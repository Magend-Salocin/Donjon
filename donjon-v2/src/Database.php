<?php

declare(strict_types=1);

namespace Donjon;

use PDO;
use RuntimeException;

final class Database
{
    private function __construct(private readonly PDO $pdo)
    {
    }

    /** Ouvre la base SQLite et l'initialise (schéma + données) si le fichier n'existe pas encore. */
    public static function open(string $path, string $sqlDir): self
    {
        if (!in_array('sqlite', PDO::getAvailableDrivers(), true)) {
            throw new RuntimeException(
                "L'extension PHP pdo_sqlite n'est pas chargée. Lancez le jeu avec start.ps1 ou activez extension=pdo_sqlite dans php.ini."
            );
        }

        $isNew = !is_file($path);
        if ($isNew && !is_dir(dirname($path))) {
            mkdir(dirname($path), 0775, true);
        }

        $pdo = new PDO('sqlite:' . $path, options: [
            PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION,
            PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_ASSOC,
        ]);
        $pdo->exec('PRAGMA foreign_keys = ON');
        $pdo->exec('PRAGMA journal_mode = WAL');

        $db = new self($pdo);
        if ($isNew) {
            $db->install($sqlDir);
        }

        return $db;
    }

    public function install(string $sqlDir): void
    {
        $this->transaction(function () use ($sqlDir): void {
            $this->pdo->exec((string) file_get_contents($sqlDir . '/schema.sql'));
            $this->pdo->exec((string) file_get_contents($sqlDir . '/seed.sql'));
        });
    }

    /** @return list<array<string, mixed>> */
    public function all(string $sql, array $params = []): array
    {
        $statement = $this->pdo->prepare($sql);
        $statement->execute($params);

        return $statement->fetchAll();
    }

    /** @return array<string, mixed>|null */
    public function one(string $sql, array $params = []): ?array
    {
        $statement = $this->pdo->prepare($sql);
        $statement->execute($params);
        $row = $statement->fetch();

        return $row === false ? null : $row;
    }

    public function value(string $sql, array $params = []): mixed
    {
        $statement = $this->pdo->prepare($sql);
        $statement->execute($params);
        $value = $statement->fetchColumn();

        return $value === false ? null : $value;
    }

    /** Exécute une requête d'écriture et renvoie le nombre de lignes modifiées. */
    public function run(string $sql, array $params = []): int
    {
        $statement = $this->pdo->prepare($sql);
        $statement->execute($params);

        return $statement->rowCount();
    }

    public function lastId(): int
    {
        return (int) $this->pdo->lastInsertId();
    }

    /**
     * @template T
     * @param callable(): T $callback
     * @return T
     */
    public function transaction(callable $callback): mixed
    {
        if ($this->pdo->inTransaction()) {
            return $callback();
        }

        $this->pdo->beginTransaction();
        try {
            $result = $callback();
            $this->pdo->commit();

            return $result;
        } catch (\Throwable $exception) {
            $this->pdo->rollBack();
            throw $exception;
        }
    }
}
