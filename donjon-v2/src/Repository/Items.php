<?php

declare(strict_types=1);

namespace Donjon\Repository;

use Donjon\Database;

final class Items
{
    public function __construct(private readonly Database $db)
    {
    }

    public function find(int $num): ?array
    {
        return $this->db->one('SELECT * FROM objet WHERE num = ?', [$num]);
    }

    public function findByName(string $name): ?array
    {
        return $this->db->one('SELECT * FROM objet WHERE libelle = ?', [$name]);
    }

    /**
     * Objets possédés par un héros, avec leur quantité (colonne nb).
     *
     * @param list<string> $categories valeurs de objet.catheg
     */
    public function inventory(int $hero, array $categories): array
    {
        $placeholders = implode(', ', array_fill(0, count($categories), '?'));

        return $this->db->all(
            "SELECT objet.*, objethero.nb FROM objethero JOIN objet ON objet.num = objethero.objet
             WHERE objethero.hero = ? AND objet.catheg IN ($placeholders) ORDER BY objet.libelle",
            [$hero, ...$categories]
        );
    }

    public function quantity(int $hero, int $item): int
    {
        return (int) $this->db->value('SELECT nb FROM objethero WHERE hero = ? AND objet = ?', [$hero, $item]);
    }

    public function add(int $hero, int $item, int $quantity = 1): void
    {
        $this->db->run(
            'INSERT INTO objethero (hero, objet, nb) VALUES (?, ?, ?)
             ON CONFLICT (hero, objet) DO UPDATE SET nb = nb + excluded.nb',
            [$hero, $item, $quantity]
        );
    }

    /** Retire des exemplaires d'un objet. Renvoie false si le héros n'en possède pas assez. */
    public function remove(int $hero, int $item, int $quantity = 1): bool
    {
        return $this->db->transaction(function () use ($hero, $item, $quantity): bool {
            $owned = $this->quantity($hero, $item);
            if ($owned < $quantity) {
                return false;
            }
            if ($owned === $quantity) {
                $this->db->run('DELETE FROM objethero WHERE hero = ? AND objet = ?', [$hero, $item]);
            } else {
                $this->db->run('UPDATE objethero SET nb = nb - ? WHERE hero = ? AND objet = ?', [$quantity, $hero, $item]);
            }

            return true;
        });
    }
}
