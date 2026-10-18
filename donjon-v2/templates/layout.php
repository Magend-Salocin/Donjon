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
?>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="utf-8">
    <title><?= e($title) ?> - Donjon de Naheulbeuk</title>
    <link rel="icon" href="favicon.ico">
    <link rel="stylesheet" href="<?= asset('css/main.css') ?>">
    <link rel="stylesheet" href="<?= asset('css/old.css') ?>">
    <link rel="stylesheet" href="<?= asset('css/app.css') ?>">
</head>
<body>
<div id="megabg_container">
<div id="bg_container">
<div id="container">
    <div id="header"></div>

    <div id="menu_sword">
        <div id="tabs">
            <ul>
            <?php if ($hero !== null): ?>
                <?= menu_tab('personnage', 'H') ?>
                <?= menu_tab('village', 'Village') ?>
                <?= menu_tab('aventures', 'Aventure') ?>
                <?= menu_tab('voyager', 'Voyager') ?>
                <?= menu_tab('defis', 'Défis') ?>
                <?= menu_tab('deconnexion', 'X') ?>
            <?php else: ?>
                <?= menu_tab('connexion', 'Accueil') ?>
                <?= menu_tab('inscription', 'Inscription') ?>
                <?= menu_tab('aide', 'Aide') ?>
                <?= menu_tab('version', 'Version') ?>
            <?php endif ?>
            </ul>
        </div>
    </div>
    <img src="<?= asset('img/img/menu_sword_right.jpg') ?>" alt="" class="menu-sword-right">

    <div id="body">
        <?php foreach ($flashes as $flash): ?>
            <p class="flash flash-<?= e($flash['type']) ?>"><?= e($flash['message']) ?></p>
        <?php endforeach ?>

        <?php if ($adventureInProgress): ?>
            <p class="flash flash-info">Une aventure est en cours : <a href="<?= e(url('jeu')) ?>">retourner dans le donjon</a>.</p>
        <?php endif ?>

        <?php if ($side && $hero !== null): ?>
            <div id="body-leftside"><?= Donjon\View::render('partials/side-menu', ['hero' => $hero, 'unread' => $unread]) ?></div>
            <div id="body-rightside"><?= $content ?></div>
        <?php else: ?>
            <?= $content ?>
        <?php endif ?>
    </div>

    <div id="footer">
        <div class="hr"><hr></div>
        <div class="left footer-links">
            <a href="<?= e(url('aide')) ?>" class="low_menu">Aide</a>
            <a href="<?= e(url('version')) ?>" class="low_menu">Version</a>
            <span class="music">
                <label for="music-track">Musique</label>
                <select id="music-track">
                    <?php foreach ($tracks as $file => $label): ?>
                        <option value="<?= asset('audio/' . $file . '.mp3') ?>"><?= e($label) ?></option>
                    <?php endforeach ?>
                </select>
                <audio id="music-player" controls preload="none" loop></audio>
            </span>
        </div>
        <div class="designedby">Magend 2009 - v2 2026</div>
    </div>
</div>
</div>
</div>
<script src="<?= asset('js/music.js') ?>"></script>
</body>
</html>
