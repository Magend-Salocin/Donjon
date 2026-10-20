<?php
/**
 * @var array $village
 * @var list<array> $destinations
 * @var array{destination: array, remaining: int}|null $journey
 */

use Donjon\View;
?>
<div id="body-fullside" class="map-page">
    <h2>Voyager depuis <?= e($village['libelle']) ?></h2>

    <?php if ($journey !== null): ?>
        <?= View::render('partials/journey-timer', ['journey' => $journey]) ?>
    <?php else: ?>
        <img src="<?= asset('img/lieux/carte/' . e($village['code']) . '.jpg') ?>" usemap="#travel-map" alt="Carte du pays de Fangh" class="travel-map">
        <map name="travel-map">
            <?php foreach ($destinations as $destination): ?>
                <area shape="rect"
                      coords="<?= (int) $destination['coord01'] ?>,<?= (int) $destination['coord02'] ?>,<?= (int) $destination['coord03'] ?>,<?= (int) $destination['coord04'] ?>"
                      href="#" data-travel="<?= e($destination['code']) ?>"
                      alt="<?= e($destination['libelle']) ?>" title="<?= e($destination['libelle']) ?> - durée du trajet : <?= e($destination['dure']) ?>">
            <?php endforeach ?>
        </map>

        <form method="post" action="<?= e(url('voyager')) ?>" id="travel-form" class="destinations">
            <?= csrf_field() ?>
            <input type="hidden" name="action" value="travel">
            <input type="hidden" name="retour" value="voyager">
            <?php foreach ($destinations as $destination): ?>
                <button type="submit" name="village" value="<?= e($destination['code']) ?>">
                    <?= e($destination['libelle']) ?> (<?= e($destination['dure']) ?>)
                </button>
            <?php endforeach ?>
        </form>
        <script>
            document.querySelectorAll('area[data-travel]').forEach(function (area) {
                area.addEventListener('click', function (event) {
                    event.preventDefault();
                    document.querySelector('#travel-form button[value="' + area.dataset.travel + '"]').click();
                });
            });
        </script>
    <?php endif ?>
</div>
