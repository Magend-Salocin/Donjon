<?php
/**
 * @var array $hero
 * @var array{destination: array, remaining: int}|null $journey
 */

[$levelExp, $levelNeeded] = level_progress($hero);
?>
<div id="CarteJoueur">
    <div class="center"><?= e($hero['nom']) ?> : <?= e($hero['libellerace']) ?> - Niveau <?= (int) $hero['codeexp'] ?> - <?= e($hero['libellerang']) ?></div>

    <div class="stat-block">
        Expérience : <?= (int) $hero['exp'] ?><br>
        <strong>Prochain niveau :</strong>
        <div class="bar-line"><?= progress_bar($levelExp, $levelNeeded, 'exp') ?></div>
    </div>

    <div class="stat-block">
        Maniement des armes : <?= (int) $hero['man'] ?><br>
        Puissance magique : <?= (int) $hero['ppm'] ?>
    </div>

    <table class="hero-stats">
        <tr>
            <td>
                Force : <?= (int) $hero['forc'] ?><br>
                Dextérité : <?= (int) $hero['dext'] ?><br>
                Intelligence : <?= (int) $hero['inti'] ?><br>
                Charisme : <?= (int) $hero['cha'] ?><br>
                Vitesse : <?= (int) $hero['vit'] ?><br>
                Endurance : <?= (int) $hero['end'] ?><br>
                Attaque : <?= attack_score($hero) ?><br>
                Défense : <?= defense_score($hero) ?>
            </td>
            <td><img src="<?= e(race_portrait($hero['libellerace'])) ?>" alt="<?= e($hero['libellerace']) ?>"></td>
        </tr>
    </table>

    <div class="stat-block">
        <strong>Vie :</strong> <?= (int) $hero['pv2'] ?>/<?= (int) $hero['pv'] ?>
        <div class="bar-line"><?= progress_bar((int) $hero['pv2'], (int) $hero['pv'], 'vie') ?></div>
        <strong>Magie :</strong> <?= (int) $hero['pm2'] ?>/<?= (int) $hero['pm'] ?>
        <div class="bar-line"><?= progress_bar((int) $hero['pm2'], (int) $hero['pm'], 'magie') ?></div>
    </div>
</div>

<?php if ($journey !== null): ?>
    <?= Donjon\View::render('partials/journey-timer', ['journey' => $journey]) ?>
<?php endif ?>
