<?php

/*
 * Recrée la base SQLite à partir de database/schema.sql et database/seed.sql, puis crée un compte de démonstration.
 * Toutes les parties en cours sont perdues.
 *
 * Usage : php -d extension=pdo_sqlite bin/reset-db.php
 */

declare(strict_types=1);

$config = require __DIR__ . '/../config/config.php';
$path = $config['database'];

foreach ([$path, $path . '-wal', $path . '-shm'] as $file) {
    if (is_file($file)) {
        unlink($file);
    }
}

require __DIR__ . '/../src/bootstrap.php';

/** @var Donjon\App $app */
$app->players->create('demo@donjon.local', 'Demo', 'demo123', $app->world->race('01'), 'H');

echo "Base recréée : $path\n";
echo "Compte de démonstration : Demo / demo123\n";
