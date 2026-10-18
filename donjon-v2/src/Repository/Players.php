<?php

declare(strict_types=1);

namespace Donjon\Repository;

use Donjon\Database;
use InvalidArgumentException;

final class Players
{
    /** Colonnes de joueur modifiables par le jeu. */
    private const UPDATABLE = [
        'mdp_hash', 'pv', 'pv2', 'pm', 'pm2', 'forc', 'end', 'inti', 'dext', 'vit', 'cha', 'man', 'ppm',
        'exp', 'ors', 'codeexp', 'nivsuv', 'cexp', 'nbexp', 'libellerang', 'village', 'Enligne',
        'nbCombat', 'nbVictoire', 'NbCombatDay', 'combat_jour',
        'Arme', 'Bouclier', 'Casque', 'Plastron', 'AvantBras', 'Botte', 'Jambiere',
    ];

    public const EQUIPMENT_SLOTS = ['Arme', 'Bouclier', 'Casque', 'Plastron', 'AvantBras', 'Botte', 'Jambiere'];

    public function __construct(private readonly Database $db)
    {
    }

    public function find(int $id): ?array
    {
        return $this->db->one('SELECT * FROM joueur WHERE num = ?', [$id]);
    }

    public function findByLogin(string $login): ?array
    {
        return $this->db->one('SELECT * FROM joueur WHERE login = ?', [$login]);
    }

    public function findByName(string $name): ?array
    {
        return $this->db->one('SELECT * FROM joueur WHERE nom = ?', [$name]);
    }

    public function nameExists(string $name): bool
    {
        return $this->db->value('SELECT 1 FROM joueur WHERE nom = ? OR login = ?', [$name, $name]) !== null;
    }

    public function emailExists(string $email): bool
    {
        return $this->db->value('SELECT 1 FROM joueur WHERE email = ?', [$email]) !== null;
    }

    /** Crée un héros avec les caractéristiques de départ de sa race. Le nom sert aussi d'identifiant de connexion. */
    public function create(string $email, string $name, string $password, array $race): int
    {
        return $this->db->transaction(function () use ($email, $name, $password, $race): int {
            $this->db->run(
                'INSERT INTO joueur (email, login, mdp_hash, nom, pv, pv2, pm, pm2, forc, "end", inti, dext, vit, cha, man, ppm,
                                     libellerace, village, image)
                 VALUES (:email, :login, :hash, :nom, :pv, :pv, :pm, :pm, :forc, :end, :inti, :dext, :vit, :cha, :man, :ppm,
                         :race, :village, :image)',
                [
                    'email' => $email,
                    'login' => $name,
                    'hash' => password_hash($password, PASSWORD_DEFAULT),
                    'nom' => $name,
                    'pv' => $race['r_pv'],
                    'pm' => $race['r_pm'],
                    'forc' => $race['r_for'],
                    'end' => $race['r_end'],
                    'inti' => $race['r_int'],
                    'dext' => $race['r_dext'],
                    'vit' => $race['r_vit'],
                    'cha' => $race['r_cha'],
                    'man' => $race['r_man'],
                    'ppm' => $race['r_ppm'],
                    'race' => $race['libelle'],
                    'village' => $race['r_village'],
                    'image' => $race['r_image'],
                ]
            );
            $id = $this->db->lastId();
            $this->db->run('INSERT INTO accomplir (aven_num, jou_num, nb) SELECT code, ?, 0 FROM aventure', [$id]);

            return $id;
        });
    }

    /** @param array<string, int|string> $fields */
    public function update(int $id, array $fields): void
    {
        if ($fields === []) {
            return;
        }

        $assignments = [];
        foreach (array_keys($fields) as $column) {
            if (!in_array($column, self::UPDATABLE, true)) {
                throw new InvalidArgumentException("Colonne joueur non modifiable : $column");
            }
            $assignments[] = "\"$column\" = :$column";
        }

        $this->db->run(
            'UPDATE joueur SET ' . implode(', ', $assignments) . ' WHERE num = :num',
            $fields + ['num' => $id]
        );
    }

    public function touchOnline(int $id): void
    {
        $this->db->run('UPDATE joueur SET Enligne = ? WHERE num = ?', [time(), $id]);
    }

    public function onlineInVillage(string $village, int $exceptId, int $window): array
    {
        return $this->db->all(
            'SELECT num, nom, codeexp, libellerang, libellerace FROM joueur
             WHERE village = ? AND num <> ? AND Enligne >= ? ORDER BY nom',
            [$village, $exceptId, time() - $window]
        );
    }
}
