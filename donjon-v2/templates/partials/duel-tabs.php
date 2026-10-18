<?php
/**
 * @var array $hero
 * @var int $perDay
 */

$duelsToday = $hero['combat_jour'] === date('Y-m-d') ? (int) $hero['NbCombatDay'] : 0;
?>
<p class="center">
    <a href="<?= e(url('defis')) ?>">Mes défis</a> ||
    <a href="<?= e(url('defier')) ?>">Défier un héros du village</a>
</p>
<p class="center">
    Vous avez gagné <strong><?= (int) $hero['nbVictoire'] ?></strong> combats sur <strong><?= (int) $hero['nbCombat'] ?></strong>.<br>
    Aujourd'hui vous avez participé à <strong><?= $duelsToday ?></strong>/<?= $perDay ?> combats.
</p>
