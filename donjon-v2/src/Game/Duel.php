<?php

declare(strict_types=1);

namespace Donjon\Game;

use Donjon\Repository\Duels;
use Donjon\Repository\Players;

/** Défis entre héros d'un même village et simulation du combat (reprise de PageDefis-ModuleCombat.php). */
final class Duel
{
    /** Garde-fou : au-delà, le combat est déclaré nul. */
    private const MAX_ROUNDS = 200;

    public function __construct(
        private readonly Players $players,
        private readonly Duels $duels,
        private readonly int $perDay,
    ) {
    }

    public function challenge(array $hero, int $targetId): string
    {
        $target = $this->players->find($targetId);
        if ($target === null || $targetId === (int) $hero['num'] || $target['village'] !== $hero['village']) {
            throw new GameError('Ce héros ne peut pas être défié.');
        }
        if ($this->duelsToday($hero) >= $this->perDay) {
            throw new GameError("Vous avez atteint la limite de {$this->perDay} combats aujourd'hui.");
        }
        if ($this->duels->exists($targetId, (int) $hero['num'])) {
            throw new GameError("Vous avez déjà défié {$target['nom']}.");
        }

        $this->duels->create($targetId, (int) $hero['num'], $hero['village']);

        return "Défi envoyé à {$target['nom']}.";
    }

    /**
     * Accepte un défi reçu et joue le combat.
     *
     * @return array{log: list<array{side: string, text: string}>, summary: string}
     */
    public function fight(array $hero, int $challengeNum): array
    {
        $challenge = $this->duels->findReceived($challengeNum, (int) $hero['num'])
            ?? throw new GameError("Ce défi n'existe plus.");
        $opponent = $this->players->find((int) $challenge['MoiHeros']);
        $this->duels->delete($challengeNum);
        if ($opponent === null) {
            throw new GameError("Votre adversaire a quitté le jeu.");
        }
        if ($this->duelsToday($hero) >= $this->perDay) {
            throw new GameError("Vous avez atteint la limite de {$this->perDay} combats aujourd'hui.");
        }

        [$log, $winner] = $this->simulate($hero, $opponent);

        if ($winner === null) {
            $this->recordResult($hero, false);
            $this->recordResult($opponent, false);
            $log[] = ['side' => 'fin', 'text' => 'Les deux héros sont épuisés : match nul.'];

            return ['log' => $log, 'summary' => 'Match nul.'];
        }

        $loser = $winner === $hero ? $opponent : $hero;
        [$gold, $exp] = $this->recordResult($winner, true);
        $this->recordResult($loser, false);
        $log[] = ['side' => 'fin', 'text' => "{$winner['nom']} remporte le combat ! ($gold pièces d'or + $exp points d'expérience)"];

        return ['log' => $log, 'summary' => $winner === $hero ? 'Victoire !' : 'Défaite...'];
    }

    /** @return array{0: list<array{side: string, text: string}>, 1: array|null} journal et vainqueur (null si nul) */
    private function simulate(array $hero, array $opponent): array
    {
        $fighters = ['hero' => $hero, 'opponent' => $opponent];
        $life = ['hero' => max(1, (int) $hero['pv2']), 'opponent' => max(1, (int) $opponent['pv2'])];
        $log = [['side' => 'fin', 'text' => "Début du combat entre {$hero['nom']} et {$opponent['nom']}."]];
        $dodgeLogged = false;

        for ($round = 0; $round < self::MAX_ROUNDS; $round++) {
            $heroStrikes = $this->speedRoll($hero) > $this->speedRoll($opponent);
            $attackerSide = $heroStrikes ? 'hero' : 'opponent';
            $defenderSide = $heroStrikes ? 'opponent' : 'hero';
            $attacker = $fighters[$attackerSide];
            $defender = $fighters[$defenderSide];

            $critical = $this->isPerfect($attacker);
            $dodged = $this->isPerfect($defender);
            $attack = (int) $attacker['forc'] * random_int(0, 12) + intdiv(attack_score($attacker), 10);
            $defense = (int) $defender['end'] * random_int(0, 12) + intdiv(defense_score($defender), 10);
            $damage = ($dodged ? 0 : ($critical ? $attack * 2 : $attack)) - $defense;

            if ($damage > 0) {
                $life[$defenderSide] -= $damage;
                $dodgeLogged = false;
                $log[] = ['side' => $attackerSide, 'text' => $critical
                    ? "{$attacker['nom']} donne un coup critique ($damage) : {$defender['nom']} tombe à {$life[$defenderSide]} PV."
                    : "{$attacker['nom']} donne un coup normal ($damage) : {$defender['nom']} tombe à {$life[$defenderSide]} PV."];
            } elseif (!$dodgeLogged) {
                $dodgeLogged = true;
                $log[] = ['side' => $defenderSide, 'text' => "{$defender['nom']} esquive l'attaque."];
            }

            if ($life[$defenderSide] <= 0) {
                return [$log, $attacker];
            }
        }

        return [$log, null];
    }

    /** Lance autant de d6 que la dextérité : coup parfait si plus d'un quart sont des 6. */
    private function isPerfect(array $fighter): bool
    {
        $dice = max(1, (int) $fighter['dext']);
        $sixes = 0;
        for ($i = 0; $i < $dice; $i++) {
            $sixes += random_int(1, 6) === 6 ? 1 : 0;
        }

        return $sixes > $dice / 4;
    }

    private function speedRoll(array $fighter): int
    {
        return (int) $fighter['vit'] * random_int(0, 6);
    }

    private function duelsToday(array $hero): int
    {
        return $hero['combat_jour'] === date('Y-m-d') ? (int) $hero['NbCombatDay'] : 0;
    }

    /** @return array{0: int, 1: int} or et expérience gagnés */
    private function recordResult(array $fighter, bool $won): array
    {
        $gold = $won ? random_int(1, 20) : 0;
        $exp = $won ? random_int(1, 20) : random_int(1, 5);
        $this->players->update((int) $fighter['num'], [
            'exp' => (int) $fighter['exp'] + $exp,
            'ors' => (int) $fighter['ors'] + $gold,
            'nbCombat' => (int) $fighter['nbCombat'] + 1,
            'nbVictoire' => (int) $fighter['nbVictoire'] + ($won ? 1 : 0),
            'NbCombatDay' => $this->duelsToday($fighter) + 1,
            'combat_jour' => date('Y-m-d'),
        ]);

        return [$gold, $exp];
    }
}
