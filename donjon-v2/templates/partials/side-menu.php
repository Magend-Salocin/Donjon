<?php
/**
 * @var array $hero
 * @var int $unread
 */
?>
<div id="scroll_top"><span id="scroll_header">MENU&nbsp;</span></div>
<div id="scroll_middle">
    <a href="<?= e(url('personnage')) ?>" class="main_menu">Personnage</a>
    <a href="<?= e(url('equipement')) ?>" class="main_menu">Équipement</a>
    <a href="<?= e(url('inventaire')) ?>" class="main_menu">Inventaire</a>
    <a href="<?= e(url('messagerie')) ?>" class="main_menu">Messagerie<?= $unread > 0 ? ' (' . $unread . ')' : '' ?></a>
    <a href="<?= e(url('taverne')) ?>" class="main_menu">Taverne</a>
    <div class="menu_separator">
        <div class="separator_text"><?= e($hero['nom']) ?></div>
    </div>
    <a href="<?= e(url('compte')) ?>" class="main_menu">Mon compte</a>
    <?php if ((int) $hero['cexp'] === 1): ?>
        <a href="<?= e(url('niveau')) ?>" class="main_menu level-up">Niveau supérieur !</a>
    <?php endif ?>
    <span class="main_menu">Niveau : <?= (int) $hero['codeexp'] ?></span>
    <span class="main_menu">Or : <?= (int) $hero['ors'] ?></span>
</div>
<div id="scroll_bottom"></div>
