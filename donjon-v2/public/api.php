<?php

declare(strict_types=1);

/*
 * Appels AJAX du plateau de donjon (assets/game/ModuleSave.js).
 * Requêtes POST, jeton CSRF dans l'en-tête X-CSRF-Token, réponses JSON.
 */

use Donjon\Game\GameError;
use Donjon\View;

require __DIR__ . '/../src/bootstrap.php';

/** @var Donjon\App $app */
header('Content-Type: application/json; charset=utf-8');

function respond(int $status, array $body): never
{
    http_response_code($status);
    echo json_encode($body, JSON_UNESCAPED_UNICODE);
    exit;
}

$hero = isset($_SESSION['player_id']) ? $app->players->find((int) $_SESSION['player_id']) : null;
if ($hero === null) {
    respond(401, ['error' => 'Session expirée, reconnectez-vous.']);
}
if ($_SERVER['REQUEST_METHOD'] !== 'POST' || !csrf_is_valid($_SERVER['HTTP_X_CSRF_TOKEN'] ?? null)) {
    respond(403, ['error' => 'Requête refusée.']);
}

$heroId = (int) $hero['num'];

try {
    switch ((string) ($_GET['action'] ?? '')) {
        case 'save-hero':
            $app->progression->saveQuestState($hero, post_int('pv2'), post_int('ors'));
            respond(200, ['ok' => true]);

        case 'item-add':
            $item = $app->items->find(post_int('objet'));
            if ($item === null || !in_array($item['catheg'], ['item', 'quete'], true)) {
                throw new GameError('Objet inconnu.');
            }
            $app->items->add($heroId, (int) $item['num']);
            respond(200, ['ok' => true]);

        case 'item-remove':
            if (!$app->items->remove($heroId, post_int('objet'))) {
                throw new GameError('Vous ne possédez pas cet objet.');
            }
            respond(200, ['ok' => true]);

        case 'inventory':
            $items = $app->items->inventory($heroId, ['item', 'quete']);
            respond(200, [
                'items' => $items,
                'html' => View::render('partials/quest-inventory', ['questItems' => $items]),
            ]);

        case 'finish':
            $app->progression->saveQuestState($hero, post_int('pv2'), post_int('ors'));
            $message = $app->progression->finishAdventure($app->players->find($heroId), post_string('resultat') === 'victoire');
            flash('ok', $message);
            respond(200, ['message' => $message]);

        default:
            respond(404, ['error' => 'Action inconnue.']);
    }
} catch (GameError $error) {
    respond(422, ['error' => $error->getMessage()]);
}
