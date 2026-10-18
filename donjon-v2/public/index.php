<?php

declare(strict_types=1);

use Donjon\Actions;
use Donjon\Pages;
use Donjon\View;

require __DIR__ . '/../src/bootstrap.php';

/** @var Donjon\App $app */
$hero = isset($_SESSION['player_id']) ? $app->players->find((int) $_SESSION['player_id']) : null;
if ($hero === null) {
    unset($_SESSION['player_id']);
}

$page = (string) ($_GET['page'] ?? '');

if ($page === 'deconnexion') {
    $_SESSION = [];
    session_regenerate_id(true);
    redirect('connexion');
}

$journey = null;
if ($hero !== null) {
    $app->players->touchOnline((int) $hero['num']);
    $journey = $app->travel->resolve($hero);
    $hero = $app->progression->refreshLevel($app->players->find((int) $hero['num']));
}

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    (new Actions($app, $hero))->handle((string) ($_POST['action'] ?? ''));
}

$allowed = $hero === null ? Pages::PUBLIC_PAGES : array_merge(Pages::PUBLIC_PAGES, Pages::PRIVATE_PAGES);
if (!in_array($page, $allowed, true) || ($hero !== null && in_array($page, ['connexion', 'inscription'], true))) {
    $page = $hero === null ? 'connexion' : 'personnage';
}

$data = (new Pages($app, $hero, $journey))->$page();

echo View::render('layout', [
    'page' => $page,
    'title' => $data['title'],
    'side' => $data['side'] ?? false,
    'hero' => $hero,
    'unread' => $hero !== null ? $app->messages->unreadCount($hero['nom']) : 0,
    'adventureInProgress' => $hero !== null && $page !== 'jeu' && $app->progression->currentAdventure($hero) !== null,
    'flashes' => take_flashes(),
    'content' => View::render('pages/' . $page, $data + ['hero' => $hero]),
]);
