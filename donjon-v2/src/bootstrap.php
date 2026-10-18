<?php

declare(strict_types=1);

const ROOT_DIR = __DIR__ . '/..';

spl_autoload_register(static function (string $class): void {
    $prefix = 'Donjon\\';
    if (str_starts_with($class, $prefix)) {
        require __DIR__ . '/' . str_replace('\\', '/', substr($class, strlen($prefix))) . '.php';
    }
});

require __DIR__ . '/helpers.php';

$config = require ROOT_DIR . '/config/config.php';

error_reporting(E_ALL);
ini_set('display_errors', $config['debug'] ? '1' : '0');

session_set_cookie_params(['httponly' => true, 'samesite' => 'Lax']);
session_start();

$app = new Donjon\App(
    Donjon\Database::open($config['database'], ROOT_DIR . '/database'),
    $config,
);
