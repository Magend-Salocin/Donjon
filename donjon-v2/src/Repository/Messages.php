<?php

declare(strict_types=1);

namespace Donjon\Repository;

use Donjon\Database;

final class Messages
{
    public function __construct(private readonly Database $db)
    {
    }

    public function inbox(string $heroName): array
    {
        return $this->db->all('SELECT * FROM message WHERE a = ? ORDER BY date DESC', [$heroName]);
    }

    public function find(int $code, string $heroName): ?array
    {
        return $this->db->one('SELECT * FROM message WHERE code = ? AND a = ?', [$code, $heroName]);
    }

    public function markRead(int $code, string $heroName): void
    {
        $this->db->run('UPDATE message SET lue = 1 WHERE code = ? AND a = ?', [$code, $heroName]);
    }

    public function delete(int $code, string $heroName): void
    {
        $this->db->run('DELETE FROM message WHERE code = ? AND a = ?', [$code, $heroName]);
    }

    public function send(string $to, string $from, string $subject, string $content): void
    {
        $this->db->run(
            'INSERT INTO message (a, de, date, sujet, contenu) VALUES (?, ?, ?, ?, ?)',
            [$to, $from, time(), $subject, $content]
        );
    }

    public function unreadCount(string $heroName): int
    {
        return (int) $this->db->value('SELECT COUNT(*) FROM message WHERE a = ? AND lue = 0', [$heroName]);
    }
}
