<?php
/**
 * @var string $page
 * @var string $title
 * @var bool $side
 * @var array|null $hero
 * @var int $unread
 * @var bool $adventureInProgress
 * @var list<array{type: string, message: string}> $flashes
 * @var string $content
 */

$tracks = [
    'IntroTheme' => "Thème d'introduction",
    'LesHeroes' => 'Les héros',
    'HeroeHarp' => 'Harpe du héros',
    'HarpTheme' => 'Thème à la harpe',
    'MonPrecieux' => 'Mon précieux',
];

// Onglet du menu principal mis en valeur : les pages du menu latéral dépendent de « Héros », le plateau d'« Aventure ».
$heroPages = ['equipement', 'inventaire', 'messagerie', 'taverne', 'compte', 'niveau'];
$section = $page === 'jeu' ? 'aventures' : (in_array($page, $heroPages, true) ? 'personnage' : $page);
?>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title><?= e($title) ?> - Donjon de Naheulbeuk</title>
    <link rel="icon" href="favicon.ico">
    <link rel="stylesheet" href="<?= asset('css/main.css') ?>">
    <link rel="stylesheet" href="<?= asset('css/old.css') ?>">
    <link rel="stylesheet" href="<?= asset('css/app.css') ?>">
    <link rel="stylesheet" href="<?= asset('css/theme.css') ?>">
</head>
<body>
<div class="scene">
    <header class="entete">
        <a href="<?= e(url($hero !== null ? 'personnage' : 'connexion')) ?>" class="entete-accueil">Donjon de Naheulbeuk</a>
        <!-- Épée découpée comme en 2009 : pointe, onglets en trois morceaux, fin de bande, lame répétée, garde -->
        <nav class="epee" aria-label="Menu principal">
            <span class="epee-pointe"></span>
            <ul>
            <?php if ($hero !== null): ?>
                <?= menu_tab('personnage', 'Héros', $section) ?>
                <?= menu_tab('village', 'Village', $section) ?>
                <?= menu_tab('aventures', 'Aventure', $section) ?>
                <?= menu_tab('voyager', 'Voyager', $section) ?>
                <?= menu_tab('defis', 'Défis', $section) ?>
                <?= menu_tab('deconnexion', 'Quitter', $section) ?>
            <?php else: ?>
                <?= menu_tab('connexion', 'Accueil', $section) ?>
                <?= menu_tab('inscription', 'Inscription', $section) ?>
                <?= menu_tab('aide', 'Aide', $section) ?>
                <?= menu_tab('version', 'Version', $section) ?>
            <?php endif ?>
            </ul>
            <span class="epee-bande-fin"></span>
            <span class="epee-lame"></span>
            <span class="epee-garde"></span>
        </nav>
    </header>
    <div class="decor decor-gauche" aria-hidden="true"></div>
    <div class="decor decor-droite" aria-hidden="true"></div>

    <main id="body" data-page="<?= e($page) ?>"<?= $side && $hero !== null ? ' class="avec-menu"' : '' ?>>
        <?php foreach ($flashes as $flash): ?>
            <p class="flash flash-<?= e($flash['type']) ?>"><?= e($flash['message']) ?></p>
        <?php endforeach ?>

        <?php if ($adventureInProgress && !in_array($page, ['jeu', 'aventures'], true)): ?>
            <p class="flash flash-info">Une aventure est en cours : <a href="<?= e(url('jeu')) ?>">retourner dans le donjon</a>.</p>
        <?php endif ?>

        <?php if ($side && $hero !== null): ?>
            <aside id="body-leftside"><?= Donjon\View::render('partials/side-menu', ['hero' => $hero, 'unread' => $unread, 'page' => $page]) ?></aside>
            <div id="body-rightside"><?= $content ?></div>
        <?php else: ?>
            <?= $content ?>
        <?php endif ?>
    </main>

    <footer class="pied">
        <a href="<?= e(url('aide')) ?>">Aide</a>
        <a href="<?= e(url('version')) ?>">Version</a>
        <span class="music">
            <label for="music-track">Musique</label>
            <select id="music-track">
                <?php foreach ($tracks as $file => $label): ?>
                    <option value="<?= asset('audio/' . $file . '.mp3') ?>"><?= e($label) ?></option>
                <?php endforeach ?>
            </select>
            <audio id="music-player" controls preload="none" loop></audio>
        </span>
        <span class="designedby">Magend 2009 - v2 2026</span>
    </footer>
</div>
<script src="<?= asset('js/music.js') ?>"></script>
</body>
</html>
