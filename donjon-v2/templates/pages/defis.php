<?php
/**
 * @var array $hero
 * @var list<array> $received
 * @var list<array> $sent
 * @var int $perDay
 */

use Donjon\View;
?>
<?= View::render('partials/duel-tabs', ['hero' => $hero, 'perDay' => $perDay]) ?>

<h3>Défis reçus (<?= count($received) ?>)</h3>
<table class="duels">
    <tr><th>Adversaire</th><th>XP</th><th>Combats</th><th>Victoires</th><th></th></tr>
    <?php foreach ($received as $duel): ?>
        <tr>
            <td><?= e($duel['nom']) ?></td>
            <td><?= (int) $duel['exp'] ?></td>
            <td><?= (int) $duel['nbCombat'] ?></td>
            <td><?= (int) $duel['nbVictoire'] ?></td>
            <td><?= action_button('fight', 'Combattre', 'defis', ['defi' => $duel['num']]) ?></td>
        </tr>
    <?php endforeach ?>
</table>
<?php if ($received !== []): ?>
    <?= action_button('delete-challenges', 'Tout refuser', 'defis', ['liste' => 'recus']) ?>
<?php endif ?>

<h3>Défis envoyés (<?= count($sent) ?>)</h3>
<table class="duels">
    <tr><th>Adversaire</th><th>XP</th><th>Combats</th><th>Victoires</th></tr>
    <?php foreach ($sent as $duel): ?>
        <tr>
            <td><?= e($duel['nom']) ?></td>
            <td><?= (int) $duel['exp'] ?></td>
            <td><?= (int) $duel['nbCombat'] ?></td>
            <td><?= (int) $duel['nbVictoire'] ?></td>
        </tr>
    <?php endforeach ?>
</table>
<?php if ($sent !== []): ?>
    <?= action_button('delete-challenges', 'Tout annuler', 'defis', ['liste' => 'envoyes']) ?>
<?php endif ?>
