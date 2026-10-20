<?php
/**
 * @var array $village
 * @var list<array> $buildings
 */

$buildingUrl = static fn (array $building): string => match ($building['type']) {
    'taverne' => url('taverne'),
    'aventure' => url('aventures'),
    default => url('magasin', ['code' => $building['code']]),
};
?>
<div id="body-fullside" class="map-page">
    <h2><?= e($village['libelle']) ?></h2>
    <img src="<?= asset('img/lieux/village/' . e($village['code']) . '.jpg') ?>" usemap="#village-map" alt="Village de <?= e($village['libelle']) ?>">
    <map name="village-map">
        <?php foreach ($buildings as $building): ?>
            <area shape="rect"
                  coords="<?= (int) $building['coord01'] ?>,<?= (int) $building['coord02'] ?>,<?= (int) $building['coord03'] ?>,<?= (int) $building['coord04'] ?>"
                  href="<?= e($buildingUrl($building)) ?>" alt="<?= e($building['libelle']) ?>" title="<?= e($building['libelle']) ?>">
        <?php endforeach ?>
    </map>
    <p class="buildings">
        <?php foreach ($buildings as $building): ?>
            <a href="<?= e($buildingUrl($building)) ?>"><?= e($building['libelle']) ?></a>
        <?php endforeach ?>
    </p>
</div>
