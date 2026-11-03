<?php

declare(strict_types=1);

namespace Donjon\Game;

use Donjon\Database;
use Donjon\Repository\Flags;
use Donjon\Repository\Items;
use Donjon\Repository\Players;
use Donjon\Repository\World;

/**
 * Dialogues des PNJ de la taverne (data/dialogues/<pnj>.php). Notation : .claude/kb/taverne/mecaniques.md.
 *
 * Conditions, une par tableau ['clé' => valeur] :
 * - d'état, qui masquent la réponse : drapeau, sans, aventure, sans-aventure, type, sans-type ;
 * - de moyens, qui la grisent avec la raison : or, grade.
 * Effets : or, pv (plein), drapeau, effacer, debloquer (pose aventure_<code>), objet.
 */
final class Tavern
{
    private const DIALOGUE_DIR = ROOT_DIR . '/data/dialogues';
    private const STATE_CONDITIONS = ['drapeau', 'sans', 'aventure', 'sans-aventure', 'type', 'sans-type'];
    public const DEFAULT_PORTRAIT = 'img/taverne/portrait-tenancier.jpg';

    public function __construct(
        private readonly Database $db,
        private readonly Players $players,
        private readonly Items $items,
        private readonly World $world,
        private readonly Flags $flags,
    ) {
    }

    /** PNJ présents dans la taverne du héros, tavernier en premier. @return array<string, array> */
    public function npcs(array $hero): array
    {
        $state = $this->state($hero);
        $npcs = [];
        foreach (glob(self::DIALOGUE_DIR . '/*.php') as $file) {
            $npc = require $file;
            if ($npc['lieu'] === $hero['village'] && $this->isVisible($state, $npc['presence'] ?? [])) {
                $npcs[basename($file, '.php')] = $npc;
            }
        }
        uasort($npcs, static fn(array $a, array $b): int => (int) empty($a['tavernier']) <=> (int) empty($b['tavernier']));

        return $npcs;
    }

    /**
     * Nœud prêt à afficher : texte et réponses visibles, chacune avec
     * index, texte, icone, possible, raison (si grisée) et effets (libellés).
     */
    public function node(array $hero, string $npcCode, string $nodeName): ?array
    {
        $node = $this->resolve($hero, $npcCode, $nodeName);
        if ($node === null) {
            return null;
        }

        $state = $this->state($hero);
        $answers = [];
        foreach ($node['reponses'] as $index => $answer) {
            if (!$this->isVisible($state, $answer['si'] ?? [])) {
                continue;
            }
            $reasons = $this->missing($state, $answer['si'] ?? []);
            $answers[] = [
                'index' => $index,
                'texte' => $answer['texte'],
                'icone' => $answer['icone'] ?? $this->defaultIcon($answer),
                'possible' => $reasons === [],
                'raison' => implode(', ', $reasons),
                'effets' => $this->effectLabels($answer['effets'] ?? []),
            ];
        }

        return ['texte' => $node['texte'], 'reponses' => $answers];
    }

    /** Applique la réponse choisie. Renvoie le nœud suivant, ou null quand le dialogue se termine. */
    public function choose(array $hero, string $npcCode, string $nodeName, int $index): ?string
    {
        $answer = $this->resolve($hero, $npcCode, $nodeName)['reponses'][$index] ?? null;
        $state = $this->state($hero);
        if ($answer === null || !$this->isVisible($state, $answer['si'] ?? [])) {
            throw new GameError("Cette réponse n'est plus possible.");
        }
        if ($this->missing($state, $answer['si'] ?? []) !== []) {
            throw new GameError('Vous ne remplissez pas les conditions de cette réponse.');
        }

        $this->db->transaction(fn() => $this->apply($hero, $answer['effets'] ?? []));

        return $answer['suite'] ?? null;
    }

    /** Nœud d'un PNJ présent, avec la première variante dont les conditions sont remplies. */
    private function resolve(array $hero, string $npcCode, string $nodeName): ?array
    {
        $node = $this->npcs($hero)[$npcCode]['noeuds'][$nodeName] ?? null;
        if ($node === null) {
            return null;
        }

        $state = $this->state($hero);
        foreach ($node['variantes'] ?? [] as $variant) {
            if ($this->isVisible($state, $variant['si'])) {
                return $variant;
            }
        }

        return $node;
    }

    /** @return array{hero: array, flags: list<string>, adventures: list<int>, grade: int} */
    private function state(array $hero): array
    {
        $id = (int) $hero['num'];

        return [
            'hero' => $hero,
            'flags' => $this->flags->all($id),
            'adventures' => $this->world->completedAdventures($id),
            'grade' => $this->world->gradeCode((string) $hero['libellerang']),
        ];
    }

    private function isVisible(array $state, array $conditions): bool
    {
        foreach ($conditions as $condition) {
            $key = array_key_first($condition);
            $value = $condition[$key];
            $met = match ($key) {
                'drapeau' => in_array($value, $state['flags'], true),
                'sans' => !in_array($value, $state['flags'], true),
                'aventure' => in_array($value, $state['adventures'], true),
                'sans-aventure' => !in_array($value, $state['adventures'], true),
                'type' => $state['hero']['libellerace'] === $value,
                'sans-type' => $state['hero']['libellerace'] !== $value,
                default => true,
            };
            if (!$met) {
                return false;
            }
        }

        return true;
    }

    /** @return list<string> raisons affichées sous une réponse grisée */
    private function missing(array $state, array $conditions): array
    {
        $reasons = [];
        foreach ($conditions as $condition) {
            $key = array_key_first($condition);
            if (in_array($key, self::STATE_CONDITIONS, true)) {
                continue;
            }
            $value = $condition[$key];
            $reason = match ($key) {
                'or' => (int) $state['hero']['ors'] < $value ? "$value or" : null,
                'grade' => $state['grade'] < $this->world->gradeCode($value) ? "Grade : $value" : null,
            };
            if ($reason !== null) {
                $reasons[] = $reason;
            }
        }

        return $reasons;
    }

    private function apply(array $hero, array $effects): void
    {
        $id = (int) $hero['num'];
        foreach ($effects as $effect) {
            $key = array_key_first($effect);
            $value = $effect[$key];
            match ($key) {
                'or' => $this->db->run('UPDATE joueur SET ors = MAX(0, ors + ?) WHERE num = ?', [$value, $id]),
                'pv' => $this->players->update($id, ['pv2' => (int) $hero['pv']]),
                'drapeau' => $this->flags->set($id, $value),
                'effacer' => $this->flags->clear($id, $value),
                'debloquer' => $this->flags->set($id, 'aventure_' . $value),
                'objet' => $this->items->add($id, $value),
            };
        }
    }

    /** @return list<string> */
    private function effectLabels(array $effects): array
    {
        $labels = [];
        foreach ($effects as $effect) {
            $key = array_key_first($effect);
            $value = $effect[$key];
            $label = match ($key) {
                'or' => ($value > 0 ? '+' : '−') . abs($value) . ' or',
                'pv' => 'Vie au maximum',
                'debloquer' => 'Nouvelle aventure',
                'objet' => '+ ' . ($this->items->find($value)['libelle'] ?? 'objet'),
                default => null,
            };
            if ($label !== null) {
                $labels[] = $label;
            }
        }

        return $labels;
    }

    private function defaultIcon(array $answer): string
    {
        if (!isset($answer['suite'])) {
            return 'porte';
        }
        foreach ($answer['effets'] ?? [] as $effect) {
            if (isset($effect['or'])) {
                return 'or';
            }
        }

        return 'rumeur';
    }
}
