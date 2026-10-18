<?php
/**
 * @var array $hero
 * @var list<array> $adventures
 * @var array<string, int> $missions aventures terminées par grade
 * @var array|null $current
 */
?>
<?php if ($current !== null): ?>
    <div class="flash flash-info">
        En cours : <strong><?= e($current['libelle']) ?></strong>.
        <a href="<?= e(url('jeu')) ?>">Reprendre</a> ou
        <?= action_button('abandon-adventure', 'abandonner', 'aventures') ?>
    </div>
<?php endif ?>

<section class="parchemin aventures">
    <h2 class="titre-orne">La liste des aventures</h2>
    <p class="aventures-grade">Votre grade : <strong><?= e($hero['libellerang']) ?></strong>
        <?php foreach ($missions as $grade => $count): ?>
            · <?= e($grade) ?> : <?= (int) $count ?>
        <?php endforeach ?>
    </p>

    <?php if ($adventures === []): ?>
        <p class="center">Aucune aventure n'est proposée à votre grade dans ce village. Essayez de voyager.</p>
    <?php endif ?>

    <ul class="aventures-liste">
        <?php foreach ($adventures as $adventure): ?>
            <li class="aventure">
                <img src="<?= e(adventure_illustration((int) $adventure['code'])) ?>" alt="" class="aventure-image">
                <div>
                    <h3><?= e($adventure['libelle']) ?></h3>
                    <p><?= e($adventure['resumer']) ?></p>
                    <ul class="aventure-infos">
                        <li class="info-difficulte">Difficulté : <?= e(adventure_difficulty((int) $adventure['rang'])) ?></li>
                        <li class="info-experience"><?= (int) $adventure['nbexp'] ?> points d'expérience</li>
                        <li class="info-or"><?= (int) $adventure['nbor'] ?> or</li>
                    </ul>
                </div>
                <?= action_button('start-adventure', 'Partir à l\'aventure ›', 'aventures', ['aventure' => $adventure['code']], '') ?>
            </li>
        <?php endforeach ?>
    </ul>
</section>
