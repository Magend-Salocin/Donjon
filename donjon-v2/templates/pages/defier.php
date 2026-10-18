<?php
/**
 * @var array $hero
 * @var array $village
 * @var list<array> $online
 * @var int $perDay
 */

use Donjon\View;

$rankClass = static fn (string $rank): string => 'rank-' . strtolower($rank);
?>
<?= View::render('partials/duel-tabs', ['hero' => $hero, 'perDay' => $perDay]) ?>

<h3 class="center">Les héros en ligne présents à <?= e($village['libelle']) ?></h3>
<p class="center legend">
    <span class="rank-novice">Novice</span> - <span class="rank-ecuyer">Écuyer</span> -
    <span class="rank-aventurier">Aventurier</span> - <span class="rank-legende">Légende</span>
</p>

<table class="duels">
    <tr><th>Héros</th><th>Niveau</th><th></th><th></th></tr>
    <?php if ($online === []): ?>
        <tr><td colspan="4" class="center">Aucun autre héros connecté dans ce village.</td></tr>
    <?php endif ?>
    <?php foreach ($online as $player): ?>
        <tr>
            <td class="<?= e($rankClass($player['libellerang'])) ?>"><?= e($player['nom']) ?> (<?= e($player['libellerace']) ?>)</td>
            <td><?= (int) $player['codeexp'] ?></td>
            <td><?= action_button('challenge', 'Défier', 'defier', ['adversaire' => $player['num']]) ?></td>
            <td><a href="<?= e(url('messagerie', ['msg' => 'ecrire', 'a' => $player['nom']])) ?>">Écrire</a></td>
        </tr>
    <?php endforeach ?>
</table>
