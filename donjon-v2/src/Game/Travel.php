<?php

declare(strict_types=1);

namespace Donjon\Game;

use Donjon\Repository\Players;
use Donjon\Repository\World;

/** Voyages entre villages : le héros arrive à destination une fois la durée du trajet écoulée. */
final class Travel
{
    public function __construct(private readonly Players $players, private readonly World $world)
    {
    }

    public function start(array $hero, string $destination): string
    {
        $seconds = $this->world->travelTime($hero['village'], $destination)
            ?? throw new GameError('Cette destination est inaccessible depuis votre village.');

        $this->world->startAction((int) $hero['num'], 'V', $destination);
        $village = $this->world->village($destination);

        return "Vous partez pour {$village['libelle']}. Arrivée dans $seconds secondes.";
    }

    /**
     * Termine le voyage si sa durée est écoulée.
     *
     * @return array{destination: array, remaining: int}|null voyage encore en cours, ou null
     */
    public function resolve(array $hero): ?array
    {
        $action = $this->world->currentAction((int) $hero['num']);
        if ($action === null || $action['libelle'] !== 'V') {
            return null;
        }

        $destination = $this->world->village($action['aven_num']);
        $duration = $this->world->travelTime($hero['village'], $action['aven_num']);
        if ($destination === null || $duration === null) {
            $this->world->clearAction((int) $hero['num']);

            return null;
        }

        $remaining = (int) $action['sec'] + $duration - time();
        if ($remaining > 0) {
            return ['destination' => $destination, 'remaining' => $remaining];
        }

        $this->players->update((int) $hero['num'], ['village' => $destination['code']]);
        $this->world->clearAction((int) $hero['num']);
        flash('ok', "Vous êtes arrivé à {$destination['libelle']}.");

        return null;
    }
}
