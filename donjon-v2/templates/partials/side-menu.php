<?php
/**
 * @var array $hero
 * @var int $unread
 * @var string $page
 */

$links = [
    'personnage' => 'Personnage',
    'equipement' => 'Équipement',
    'inventaire' => 'Inventaire',
    'messagerie' => 'Messagerie' . ($unread > 0 ? ' (' . $unread . ')' : ''),
    'taverne' => 'Taverne',
    'compte' => 'Mon compte',
];
?>
<div class="panneau menu-lateral">
    <p class="panneau-titre">Menu</p>
    <nav aria-label="Menu du héros">
        <?php foreach ($links as $target => $label): ?>
            <a href="<?= e(url($target)) ?>"<?= $page === $target ? ' aria-current="page"' : '' ?>><?= e($label) ?></a>
        <?php endforeach ?>
        <?php if ((int) $hero['cexp'] === 1): ?>
            <a href="<?= e(url('niveau')) ?>" class="level-up"<?= $page === 'niveau' ? ' aria-current="page"' : '' ?>>Niveau supérieur !</a>
        <?php endif ?>
    </nav>
    <p class="menu-lateral-heros"><?= e($hero['nom']) ?></p>
    <p class="menu-lateral-infos"><span>Niveau <?= (int) $hero['codeexp'] ?></span><span><?= (int) $hero['ors'] ?> or</span></p>
</div>
