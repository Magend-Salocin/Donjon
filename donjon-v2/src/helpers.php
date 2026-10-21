<?php

declare(strict_types=1);

/** Échappe une valeur pour l'afficher dans du HTML. */
function e(mixed $value): string
{
    return htmlspecialchars((string) $value, ENT_QUOTES | ENT_SUBSTITUTE, 'UTF-8');
}

function url(string $page, array $params = []): string
{
    return 'index.php?' . http_build_query(['page' => $page] + $params);
}

function asset(string $path): string
{
    return 'assets/' . $path;
}

function redirect(string $page, array $params = []): never
{
    header('Location: ' . url($page, $params));
    exit;
}

function csrf_token(): string
{
    return $_SESSION['csrf'] ??= bin2hex(random_bytes(16));
}

function csrf_field(): string
{
    return '<input type="hidden" name="csrf" value="' . e(csrf_token()) . '">';
}

function csrf_is_valid(?string $token): bool
{
    return is_string($token) && hash_equals(csrf_token(), $token);
}

/** Message affiché une seule fois, à la page suivante. $type : info, ok ou erreur. */
function flash(string $type, string $message): void
{
    $_SESSION['flash'][] = ['type' => $type, 'message' => $message];
}

/** @return list<array{type: string, message: string}> */
function take_flashes(): array
{
    $flashes = $_SESSION['flash'] ?? [];
    unset($_SESSION['flash']);

    return $flashes;
}

function post_string(string $key): string
{
    return trim((string) ($_POST[$key] ?? ''));
}

function post_int(string $key): int
{
    return (int) ($_POST[$key] ?? 0);
}

/** Tronque un texte UTF-8 à $length caractères (sans dépendre de l'extension mbstring). */
function limit_text(string $text, int $length): string
{
    preg_match('/^.{0,' . $length . '}/us', $text, $match);

    return $match[0] ?? '';
}

/** Image d'un héros selon son type (colonne image : barbare, nain, elfe, enchanteur) et son sexe, découpée par bin/decouper-heros.py. */
function hero_image(array $hero, string $pattern): string
{
    return asset(sprintf($pattern, $hero['image'] . '-' . strtolower((string) $hero['sexe'])));
}

/** Portrait du héros affiché dans les pages du village. */
function hero_portrait(array $hero): string
{
    return hero_image($hero, 'img/personnages/%s.png');
}

/** Pion du héros sur le plateau du donjon. */
function hero_token(array $hero): string
{
    return hero_image($hero, 'game/images/avatars/%s-pion.png');
}

/** Grande image du héros affichée pendant les combats du donjon. */
function hero_fighter(array $hero): string
{
    return hero_image($hero, 'game/images/avatars/%s-combat.png');
}

/** Barre de progression. $kind : vie, magie ou exp. */
function progress_bar(int $value, int $max, string $kind, string $id = ''): string
{
    $percent = $max > 0 ? max(0, min(100, intdiv($value * 100, $max))) : 0;
    $idAttribute = $id !== '' ? ' id="' . e($id) . '"' : '';

    return '<span class="bar bar-' . e($kind) . '"><span' . $idAttribute . ' style="width:' . $percent . '%"></span></span>';
}

/**
 * Progression vers le niveau suivant, relative au niveau actuel.
 * Le seuil est multiplié par 3 à chaque niveau ; à partir du niveau 2 on retire le seuil précédent.
 *
 * @return array{0: int, 1: int} [points acquis dans le niveau, points nécessaires]
 */
function level_progress(array $hero): array
{
    $exp = (int) $hero['exp'];
    $next = (int) $hero['nivsuv'];
    if ((int) $hero['codeexp'] > 1) {
        $previous = intdiv($next, 3);
        $exp -= $previous;
        $next -= $previous;
    }

    return [max(0, $exp), max(1, $next)];
}

function attack_score(array $hero): int
{
    return ((int) $hero['forc'] + (int) $hero['vit']) * 2;
}

function defense_score(array $hero): int
{
    return ((int) $hero['dext'] + (int) $hero['end']) * 2;
}

function format_date(int $timestamp): string
{
    return date('d/m/Y H:i', $timestamp);
}

/**
 * Petit formulaire POST réduit à un bouton, pour les actions qui modifient la partie.
 * $page est la page affichée après l'action, y compris en cas d'erreur.
 * $class 'link' affiche le bouton comme un lien ; '' pour un bouton du thème.
 */
function action_button(string $action, string $label, string $page, array $fields = [], string $class = 'link'): string
{
    $html = '<form method="post" action="' . e(url($page)) . '" class="inline">' . csrf_field()
        . '<input type="hidden" name="action" value="' . e($action) . '">'
        . '<input type="hidden" name="retour" value="' . e($page) . '">';
    foreach ($fields as $name => $value) {
        $html .= '<input type="hidden" name="' . e($name) . '" value="' . e($value) . '">';
    }

    $classAttribute = $class !== '' ? ' class="' . e($class) . '"' : '';

    return $html . '<button type="submit"' . $classAttribute . '>' . e($label) . '</button></form>';
}

/** Difficulté affichée d'une aventure, d'après le grade requis (1 à 4). */
function adventure_difficulty(int $grade): string
{
    return [1 => 'Facile', 2 => 'Moyen', 3 => 'Difficile'][$grade] ?? 'Héroïque';
}

/**
 * Illustration d'une aventure : celle de la quête (img/aventures/quetes/quete-NN.jpg, aventure 100 + NN,
 * découpée par bin/decouper-planche.py) si elle existe, sinon une image de thème (img/aventures/aventure-*.jpg).
 * Les images de 2009 (100 px) sont trop petites pour le bandeau de la liste.
 */
function adventure_illustration(int $code): string
{
    $quest = sprintf('img/aventures/quetes/quete-%02d.jpg', $code - 100);
    if ($code > 100 && is_file(ROOT_DIR . '/public/assets/' . $quest)) {
        return asset($quest);
    }

    $themes = [
        'feu' => [4, 103, 108, 111, 119, 123],
        'glace' => [104, 112, 114, 116],
        'marais' => [2, 3, 6, 107, 113, 115, 122, 124],
        'labyrinthe' => [1, 5, 101, 109, 117, 118, 121],
    ];
    foreach ($themes as $theme => $codes) {
        if (in_array($code, $codes, true)) {
            return asset('img/aventures/aventure-' . $theme . '.jpg');
        }
    }

    return asset('img/aventures/aventure-' . array_keys($themes)[$code % count($themes)] . '.jpg');
}

/** Onglet du menu principal en haut de page ; $current : section de la page affichée. */
function menu_tab(string $page, string $label, string $current = ''): string
{
    $currentAttribute = $page === $current ? ' aria-current="page"' : '';

    return '<li><a href="' . e(url($page)) . '"' . $currentAttribute . '>' . e($label) . '</a></li>';
}
