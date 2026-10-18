<?php

declare(strict_types=1);

namespace Donjon\Game;

use Donjon\Database;
use Donjon\Repository\Players;
use Donjon\Repository\World;

/** Niveaux, points de compétence, aventures et grades. */
final class Progression
{
    /** Points de compétence à répartir à chaque niveau. */
    private const POINTS_PER_LEVEL = 5;

    /** Caractéristiques que l'on peut augmenter en passant un niveau. */
    public const TRAINABLE_STATS = [
        'forc' => 'Force',
        'dext' => 'Dextérité',
        'inti' => 'Intelligence',
        'cha' => 'Charisme',
        'vit' => 'Vitesse',
        'end' => 'Endurance',
    ];

    /** Grade actuel => [aventures de ce grade à dépasser, grade suivant]. */
    private const RANK_UP = [
        'Novice' => [30, 'Ecuyer'],
        'Ecuyer' => [40, 'Aventurier'],
        'Aventurier' => [50, 'Legende'],
    ];

    /** Or maximum qu'une aventure peut rapporter via les cartes trésor (garde-fou contre un client modifié). */
    private const MAX_TREASURE_GOLD = 1000;

    public function __construct(
        private readonly Database $db,
        private readonly Players $players,
        private readonly World $world,
    ) {
    }

    /** Débloque le passage de niveau quand l'expérience atteint le seuil. Renvoie le héros à jour. */
    public function refreshLevel(array $hero): array
    {
        if ((int) $hero['exp'] >= (int) $hero['nivsuv'] && (int) $hero['cexp'] === 0) {
            $this->players->update((int) $hero['num'], ['cexp' => 1, 'nbexp' => self::POINTS_PER_LEVEL]);
            flash('ok', 'Vous pouvez passer au niveau supérieur !');

            return $this->players->find((int) $hero['num']);
        }

        return $hero;
    }

    public function spendPoint(array $hero, string $stat): string
    {
        if ((int) $hero['cexp'] !== 1 || (int) $hero['nbexp'] < 1) {
            throw new GameError("Vous n'avez pas de point de compétence à répartir.");
        }
        $label = self::TRAINABLE_STATS[$stat] ?? throw new GameError('Caractéristique inconnue.');

        $remaining = (int) $hero['nbexp'] - 1;
        $fields = [$stat => (int) $hero[$stat] + 1, 'nbexp' => $remaining];
        if ($remaining === 0) {
            $fields += ['codeexp' => (int) $hero['codeexp'] + 1, 'nivsuv' => (int) $hero['nivsuv'] * 3, 'cexp' => 0];
        }
        $this->players->update((int) $hero['num'], $fields);

        return $remaining === 0
            ? 'Vous passez au niveau ' . ((int) $hero['codeexp'] + 1) . ' !'
            : "$label +1. Il vous reste $remaining point(s).";
    }

    public function startAdventure(array $hero, int $code): array
    {
        $gradeCode = $this->world->gradeCode($hero['libellerang']);
        foreach ($this->world->adventures($gradeCode, $hero['village']) as $adventure) {
            if ((int) $adventure['code'] === $code) {
                $this->world->startAction((int) $hero['num'], 'A', (string) $code);

                return $adventure;
            }
        }

        throw new GameError("Cette aventure n'est pas disponible pour vous dans ce village.");
    }

    /** Aventure en cours du héros, ou null. */
    public function currentAdventure(array $hero): ?array
    {
        $action = $this->world->currentAction((int) $hero['num']);

        return $action !== null && $action['libelle'] === 'A' ? $this->world->adventure((int) $action['aven_num']) : null;
    }

    /** Enregistre la vie et l'or du héros pendant une partie de donjon. */
    public function saveQuestState(array $hero, int $life, int $gold): void
    {
        $this->players->update((int) $hero['num'], [
            'pv2' => max(0, min((int) $hero['pv'], $life)),
            'ors' => max((int) $hero['ors'], min((int) $hero['ors'] + self::MAX_TREASURE_GOLD, $gold)),
        ]);
    }

    /** Termine l'aventure en cours. En cas de victoire, verse la récompense et compte la mission. */
    public function finishAdventure(array $hero, bool $victory): string
    {
        $adventure = $this->currentAdventure($hero) ?? throw new GameError("Vous n'avez pas d'aventure en cours.");
        $heroId = (int) $hero['num'];

        return $this->db->transaction(function () use ($hero, $heroId, $adventure, $victory): string {
            $this->world->clearAction($heroId);

            if (!$victory) {
                // Un héros vaincu rentre au village avec 1 point de vie.
                $this->players->update($heroId, ['pv2' => max(1, (int) $hero['pv2'])]);

                return "Vous avez échoué : {$adventure['libelle']}.";
            }

            $this->players->update($heroId, [
                'exp' => (int) $hero['exp'] + (int) $adventure['nbexp'],
                'ors' => (int) $hero['ors'] + (int) $adventure['nbor'],
                'pv2' => max(1, (int) $hero['pv2']),
            ]);
            $this->world->incrementMission($heroId, (int) $adventure['code']);
            $this->checkRankUp($heroId, $hero['libellerang']);

            return "Aventure réussie : {$adventure['libelle']}. Vous gagnez {$adventure['nbor']} pièces d'or et {$adventure['nbexp']} points d'expérience.";
        });
    }

    private function checkRankUp(int $heroId, string $rank): void
    {
        if (!isset(self::RANK_UP[$rank])) {
            return;
        }

        [$threshold, $nextRank] = self::RANK_UP[$rank];
        $done = (int) ($this->world->missionCountsByGrade($heroId)[$rank] ?? 0);
        if ($done > $threshold) {
            $this->players->update($heroId, ['libellerang' => $nextRank]);
            flash('ok', "Vous êtes promu au grade $nextRank !");
        }
    }
}
