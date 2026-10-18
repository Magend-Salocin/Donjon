<?php
/**
 * @var array $hero
 * @var array{destination: array, remaining: int}|null $journey
 */

[$levelExp, $levelNeeded] = level_progress($hero);
$characteristics = [
    'Force' => $hero['forc'],
    'Dextérité' => $hero['dext'],
    'Intelligence' => $hero['inti'],
    'Charisme' => $hero['cha'],
    'Vitesse' => $hero['vit'],
    'Endurance' => $hero['end'],
    'Maniement des armes' => $hero['man'],
    'Puissance magique' => $hero['ppm'],
];
?>
<article class="parchemin fiche-heros">
    <header class="fiche-titre">
        <h2 class="titre-blason"><?= e($hero['nom']) ?></h2>
        <p><?= e($hero['libellerace']) ?> · Niveau <?= (int) $hero['codeexp'] ?> · <?= e($hero['libellerang']) ?></p>
    </header>

    <div class="fiche-corps">
        <figure class="fiche-portrait">
            <img src="<?= e(race_portrait($hero['libellerace'])) ?>" alt="<?= e($hero['libellerace']) ?>">
        </figure>

        <div class="fiche-jauges">
            <div class="fiche-combat">
                <p><img src="<?= asset('game/images/dee/crane.svg') ?>" alt=""><span>Attaque</span><strong><?= attack_score($hero) ?></strong></p>
                <p><img src="<?= asset('game/images/dee/bouclier-blanc.svg') ?>" alt=""><span>Défense</span><strong><?= defense_score($hero) ?></strong></p>
            </div>
            <p class="fiche-jauge"><span>Vie</span> <?= (int) $hero['pv2'] ?> / <?= (int) $hero['pv'] ?>
                <?= progress_bar((int) $hero['pv2'], (int) $hero['pv'], 'vie') ?></p>
            <p class="fiche-jauge"><span>Magie</span> <?= (int) $hero['pm2'] ?> / <?= (int) $hero['pm'] ?>
                <?= progress_bar((int) $hero['pm2'], (int) $hero['pm'], 'magie') ?></p>
            <p class="fiche-jauge"><span>Expérience</span> <?= (int) $hero['exp'] ?> · prochain niveau
                <?= progress_bar($levelExp, $levelNeeded, 'exp') ?></p>
        </div>
    </div>

    <dl class="fiche-carac">
        <?php foreach ($characteristics as $label => $value): ?>
            <div><dt><?= e($label) ?></dt><dd><?= (int) $value ?></dd></div>
        <?php endforeach ?>
    </dl>
</article>

<?php if ($journey !== null): ?>
    <?= Donjon\View::render('partials/journey-timer', ['journey' => $journey]) ?>
<?php endif ?>
