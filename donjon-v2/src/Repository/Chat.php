<?php

declare(strict_types=1);

namespace Donjon\Repository;

use Donjon\Database;

/** Discussion de la taverne, une par village. */
final class Chat
{
    private const KEPT_MESSAGES = 10;

    public function __construct(private readonly Database $db)
    {
    }

    public function latest(string $village): array
    {
        return $this->db->all(
            'SELECT * FROM chat WHERE village = ? ORDER BY id DESC LIMIT ' . self::KEPT_MESSAGES,
            [$village]
        );
    }

    /** Ajoute un message et ne conserve que les plus récents, comme le fichier texte de la v1. */
    public function post(string $village, string $author, string $message): void
    {
        $this->db->transaction(function () use ($village, $author, $message): void {
            $this->db->run(
                'INSERT INTO chat (village, auteur, message, date) VALUES (?, ?, ?, ?)',
                [$village, $author, $message, time()]
            );
            $this->db->run(
                'DELETE FROM chat WHERE village = ? AND id NOT IN (
                     SELECT id FROM chat WHERE village = ? ORDER BY id DESC LIMIT ' . self::KEPT_MESSAGES . '
                 )',
                [$village, $village]
            );
        });
    }
}
