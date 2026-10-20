<?php
/**
 * @var array $hero
 * @var array<string, string> $stats colonne => libellé
 */
?>
<div id="CarteJoueur">
    <h3 class="center"><?= e($hero['nom']) ?> : <?= e($hero['libellerace']) ?> - Niveau <?= (int) $hero['codeexp'] + 1 ?></h3>
    <p class="center"><img src="<?= e(hero_portrait($hero)) ?>" alt=""></p>
    <p class="center"><strong>Vous avez <?= (int) $hero['nbexp'] ?> point(s) de compétence à distribuer.</strong></p>
    <table class="tabheros level-table">
        <?php foreach ($stats as $stat => $label): ?>
            <tr>
                <td><strong><?= e($label) ?> :</strong></td>
                <td><?= (int) $hero[$stat] ?></td>
                <td><?= action_button('level-up', '+1', 'niveau', ['stat' => $stat]) ?></td>
            </tr>
        <?php endforeach ?>
    </table>
</div>
