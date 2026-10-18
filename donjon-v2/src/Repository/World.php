<?php

declare(strict_types=1);

namespace Donjon\Repository;

use Donjon\Database;

/** Données du monde : races, grades, villages, voyages, boutiques, aventures et action en cours des héros. */
final class World
{
    public function __construct(private readonly Database $db)
    {
    }

    public function races(): array
    {
        return $this->db->all('SELECT * FROM race ORDER BY code');
    }

    public function race(string $code): ?array
    {
        return $this->db->one('SELECT * FROM race WHERE code = ?', [$code]);
    }

    public function gradeCode(string $label): int
    {
        return (int) ($this->db->value('SELECT code FROM grade WHERE libelle = ?', [$label]) ?? 1);
    }

    public function village(string $code): ?array
    {
        return $this->db->one('SELECT * FROM village WHERE code = ?', [$code]);
    }

    /** Villages accessibles depuis $village, avec la durée du trajet. */
    public function destinations(string $village): array
    {
        return $this->db->all(
            'SELECT village.*, villagealler.temps, villagealler.dure FROM villagealler
             JOIN village ON village.code = villagealler.villagearv
             WHERE villagealler.villagedep = ? ORDER BY villagealler.temps',
            [$village]
        );
    }

    public function travelTime(string $from, string $to): ?int
    {
        $seconds = $this->db->value('SELECT temps FROM villagealler WHERE villagedep = ? AND villagearv = ?', [$from, $to]);

        return $seconds === null ? null : (int) $seconds;
    }

    public function buildings(string $village): array
    {
        return $this->db->all('SELECT * FROM magazin WHERE village = ? ORDER BY code', [$village]);
    }

    public function shop(string $code, string $village): ?array
    {
        return $this->db->one("SELECT * FROM magazin WHERE code = ? AND village = ? AND type = 'magasin'", [$code, $village]);
    }

    public function offers(string $shop): array
    {
        return $this->db->all(
            'SELECT objet.*, objetproposer.nb AS stock, objetproposer.prix FROM objetproposer
             JOIN objet ON objet.num = objetproposer.objet
             WHERE objetproposer.magazin = ? ORDER BY objetproposer.prix',
            [$shop]
        );
    }

    public function offer(string $shop, int $item): ?array
    {
        return $this->db->one('SELECT * FROM objetproposer WHERE magazin = ? AND objet = ?', [$shop, $item]);
    }

    public function decrementStock(string $shop, int $item): void
    {
        $this->db->run('UPDATE objetproposer SET nb = nb - 1 WHERE magazin = ? AND objet = ?', [$shop, $item]);
        $this->db->run('DELETE FROM objetproposer WHERE magazin = ? AND objet = ? AND nb <= 0', [$shop, $item]);
    }

    /** Aventures proposées dans un village pour un grade donné (grade de l'aventure inférieur ou égal). */
    public function adventures(int $gradeCode, string $village): array
    {
        return $this->db->all('SELECT * FROM aventure WHERE rang <= ? AND village = ? ORDER BY rang, code', [$gradeCode, $village]);
    }

    public function adventure(int $code): ?array
    {
        return $this->db->one('SELECT * FROM aventure WHERE code = ?', [$code]);
    }

    /** @return array{jou_num: int, aven_num: string, sec: int, libelle: string}|null */
    public function currentAction(int $hero): ?array
    {
        return $this->db->one('SELECT * FROM aventureencour WHERE jou_num = ?', [$hero]);
    }

    /** $type : A (aventure) ou V (voyage). Remplace l'action en cours éventuelle. */
    public function startAction(int $hero, string $type, string $target): void
    {
        $this->db->run(
            'INSERT INTO aventureencour (jou_num, aven_num, sec, libelle) VALUES (?, ?, ?, ?)
             ON CONFLICT (jou_num) DO UPDATE SET aven_num = excluded.aven_num, sec = excluded.sec, libelle = excluded.libelle',
            [$hero, $target, time(), $type]
        );
    }

    public function clearAction(int $hero): void
    {
        $this->db->run('DELETE FROM aventureencour WHERE jou_num = ?', [$hero]);
    }

    public function incrementMission(int $hero, int $adventure): void
    {
        $this->db->run(
            'INSERT INTO accomplir (aven_num, jou_num, nb) VALUES (?, ?, 1)
             ON CONFLICT (aven_num, jou_num) DO UPDATE SET nb = nb + 1',
            [$adventure, $hero]
        );
    }

    /** Nombre d'aventures terminées par grade d'aventure : ['Novice' => 12, ...]. */
    public function missionCountsByGrade(int $hero): array
    {
        $rows = $this->db->all(
            'SELECT grade.libelle, SUM(accomplir.nb) AS total FROM accomplir
             JOIN aventure ON aventure.code = accomplir.aven_num
             JOIN grade ON grade.code = aventure.rang
             WHERE accomplir.jou_num = ? GROUP BY grade.code ORDER BY grade.code',
            [$hero]
        );

        return array_column($rows, 'total', 'libelle');
    }
}
