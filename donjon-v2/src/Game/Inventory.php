<?php

declare(strict_types=1);

namespace Donjon\Game;

use Donjon\Repository\Items;
use Donjon\Repository\Players;

/** Utilisation et équipement des objets en dehors du donjon. */
final class Inventory
{
    /** Caractéristique soignée => caractéristique maximale. */
    private const RESTORABLE = ['pv2' => 'pv', 'pm2' => 'pm'];

    /** Caractéristiques qu'un équipement peut augmenter. */
    private const EQUIPMENT_STATS = ['forc', 'end'];

    public function __construct(private readonly Players $players, private readonly Items $items)
    {
    }

    public function use(array $hero, int $itemNum): string
    {
        $item = $this->ownedItem($hero, $itemNum, 'item');
        $stat = $item['effet'];
        $maxStat = self::RESTORABLE[$stat] ?? throw new GameError("{$item['libelle']} ne peut pas être utilisé ici.");

        if ((int) $hero[$stat] >= (int) $hero[$maxStat]) {
            throw new GameError($stat === 'pv2'
                ? 'Vous ne pouvez utiliser cet objet : votre vie est au maximum.'
                : 'Vous ne pouvez utiliser cet objet : vos points de magie sont au maximum.');
        }

        $this->items->remove((int) $hero['num'], $itemNum);
        $this->players->update((int) $hero['num'], [
            $stat => min((int) $hero[$maxStat], (int) $hero[$stat] + (int) $item['valeur']),
        ]);

        return "Vous venez d'utiliser {$item['libelle']}.";
    }

    public function equip(array $hero, int $itemNum): string
    {
        $item = $this->ownedItem($hero, $itemNum, 'equip');
        $slot = $item['autre'];
        if (!in_array($slot, Players::EQUIPMENT_SLOTS, true) || !in_array($item['effet'], self::EQUIPMENT_STATS, true)) {
            throw new GameError("{$item['libelle']} ne peut pas être équipé.");
        }
        if ($hero[$slot] === $item['libelle']) {
            throw new GameError("Vous êtes déjà équipé de {$item['libelle']}.");
        }

        if ($hero[$slot] !== 'rien') {
            $this->unequip($hero, $slot);
            $hero = $this->players->find((int) $hero['num']);
        }

        $stat = $item['effet'];
        $this->players->update((int) $hero['num'], [
            $stat => (int) $hero[$stat] + (int) $item['valeur'],
            $slot => $item['libelle'],
        ]);

        return "Vous êtes équipé de {$item['libelle']}.";
    }

    public function unequip(array $hero, string $slot): string
    {
        if (!in_array($slot, Players::EQUIPMENT_SLOTS, true) || $hero[$slot] === 'rien') {
            throw new GameError('Rien à retirer à cet emplacement.');
        }

        $item = $this->items->findByName($hero[$slot]);
        $fields = [$slot => 'rien'];
        if ($item !== null && in_array($item['effet'], self::EQUIPMENT_STATS, true)) {
            $fields[$item['effet']] = (int) $hero[$item['effet']] - (int) $item['valeur'];
        }
        $this->players->update((int) $hero['num'], $fields);

        return "Vous avez retiré {$hero[$slot]}.";
    }

    private function ownedItem(array $hero, int $itemNum, string $category): array
    {
        $item = $this->items->find($itemNum);
        if ($item === null || $item['catheg'] !== $category || $this->items->quantity((int) $hero['num'], $itemNum) < 1) {
            throw new GameError("Vous ne possédez pas cet objet.");
        }

        return $item;
    }
}
