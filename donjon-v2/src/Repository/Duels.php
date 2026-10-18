<?php

declare(strict_types=1);

namespace Donjon\Repository;

use Donjon\Database;

/** Défis en attente entre héros (table avantcombat). */
final class Duels
{
    public function __construct(private readonly Database $db)
    {
    }

    /** Défis reçus par le héros, avec les informations du challenger. */
    public function received(int $hero): array
    {
        return $this->db->all(
            'SELECT avantcombat.num, joueur.num AS adversaire, joueur.nom, joueur.exp, joueur.nbCombat, joueur.nbVictoire
             FROM avantcombat JOIN joueur ON joueur.num = avantcombat.MoiHeros
             WHERE avantcombat.heros = ? ORDER BY avantcombat.date DESC',
            [$hero]
        );
    }

    /** Défis envoyés par le héros, avec les informations de l'adversaire. */
    public function sent(int $hero): array
    {
        return $this->db->all(
            'SELECT avantcombat.num, joueur.nom, joueur.exp, joueur.nbCombat, joueur.nbVictoire
             FROM avantcombat JOIN joueur ON joueur.num = avantcombat.heros
             WHERE avantcombat.MoiHeros = ? ORDER BY avantcombat.date DESC',
            [$hero]
        );
    }

    public function exists(int $target, int $challenger): bool
    {
        return $this->db->value('SELECT 1 FROM avantcombat WHERE heros = ? AND MoiHeros = ?', [$target, $challenger]) !== null;
    }

    public function create(int $target, int $challenger, string $village): void
    {
        $this->db->run(
            'INSERT INTO avantcombat (heros, MoiHeros, village, date) VALUES (?, ?, ?, ?)',
            [$target, $challenger, $village, time()]
        );
    }

    /** Défi reçu par $hero. */
    public function findReceived(int $num, int $hero): ?array
    {
        return $this->db->one('SELECT * FROM avantcombat WHERE num = ? AND heros = ?', [$num, $hero]);
    }

    public function delete(int $num): void
    {
        $this->db->run('DELETE FROM avantcombat WHERE num = ?', [$num]);
    }

    /** $column : heros (défis reçus) ou MoiHeros (défis envoyés). */
    public function deleteAll(int $hero, string $column): void
    {
        $column = $column === 'heros' ? 'heros' : 'MoiHeros';
        $this->db->run("DELETE FROM avantcombat WHERE $column = ?", [$hero]);
    }
}
