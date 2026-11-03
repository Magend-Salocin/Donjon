<?php

declare(strict_types=1);

namespace Donjon\Repository;

use Donjon\Database;

/** Drapeaux d'un héros, posés par les dialogues de la taverne. */
final class Flags
{
    public function __construct(private readonly Database $db)
    {
    }

    /** @return list<string> */
    public function all(int $hero): array
    {
        return array_column($this->db->all('SELECT nom FROM drapeau WHERE jou_num = ?', [$hero]), 'nom');
    }

    public function set(int $hero, string $name): void
    {
        $this->db->run('INSERT OR IGNORE INTO drapeau (jou_num, nom) VALUES (?, ?)', [$hero, $name]);
    }

    public function clear(int $hero, string $name): void
    {
        $this->db->run('DELETE FROM drapeau WHERE jou_num = ? AND nom = ?', [$hero, $name]);
    }
}
