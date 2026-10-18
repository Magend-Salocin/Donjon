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

/** Portrait du héros affiché dans les pages du village. */
function race_portrait(string $race): string
{
    return asset('img/personnage/' . match ($race) {
        'Nain' => 'NLB_nain.png',
        'Elfe' => 'NLB_elfe.png',
        'Ogre' => 'NLB_ogre.png',
        default => 'NLB_aventurier.png',
    });
}

/** Pion du héros sur le plateau du donjon. */
function race_token(string $race): string
{
    return asset('game/images/avatars/' . match ($race) {
        'Nain' => '02.jpg',
        'Elfe' => '03.jpg',
        'Ogre' => '09.bmp',
        default => '00.jpg',
    });
}

/** Grande image du héros affichée pendant les combats du donjon. */
function race_fighter(string $race): string
{
    return asset('game/images/avatars/' . match ($race) {
        'Nain' => 'W02.png',
        'Elfe' => 'W03.png',
        'Ogre' => 'W09.png',
        default => 'W00.png',
    });
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
 */
function action_button(string $action, string $label, string $page, array $fields = []): string
{
    $html = '<form method="post" action="' . e(url($page)) . '" class="inline">' . csrf_field()
        . '<input type="hidden" name="action" value="' . e($action) . '">'
        . '<input type="hidden" name="retour" value="' . e($page) . '">';
    foreach ($fields as $name => $value) {
        $html .= '<input type="hidden" name="' . e($name) . '" value="' . e($value) . '">';
    }

    return $html . '<button type="submit" class="link">' . e($label) . '</button></form>';
}

/** Onglet du menu « épée » en haut de page. */
function menu_tab(string $page, string $label): string
{
    $label = e($label);

    return '<li><a href="' . e(url($page)) . '" class="sword_menu"><span class="shadow">&nbsp;' . $label
        . '&nbsp;</span><span class="text">&nbsp;' . $label . '&nbsp;</span><span class="tab-l"></span><span class="tab-r"></span></a></li>';
}
