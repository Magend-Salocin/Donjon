<?php
/**
 * @var array $hero
 * @var list<array> $adventures
 * @var array<string, int> $missions aventures terminées par grade
 * @var array|null $current
 */
?>
<p class="center">Votre grade : <strong><?= e($hero['libellerang']) ?></strong>
    <?php foreach ($missions as $grade => $count): ?>
        - <?= e($grade) ?> : <?= (int) $count ?>
    <?php endforeach ?>
</p>

<?php if ($current !== null): ?>
    <div class="flash flash-info">
        En cours : <strong><?= e($current['libelle']) ?></strong>.
        <a href="<?= e(url('jeu')) ?>">Reprendre</a> ou
        <?= action_button('abandon-adventure', 'abandonner', 'aventures') ?>
    </div>
<?php endif ?>

<div class="parchment-list">
    <h3>La liste des aventures</h3>
    <?php if ($adventures === []): ?>
        <p>Aucune aventure n'est proposée à votre grade dans ce village. Essayez de voyager.</p>
    <?php endif ?>
    <?php foreach ($adventures as $adventure): ?>
        <div class="item-card">
            <?php if ($adventure['image'] !== ''): ?>
                <img src="<?= asset('img/' . e($adventure['image'])) ?>" alt="" class="item-image">
            <?php endif ?>
            <div class="item-text">
                <strong><?= e($adventure['libelle']) ?></strong>
                <hr>
                <p><?= e($adventure['resumer']) ?></p>
            </div>
            <div class="item-footer">
                Rapporte <?= (int) $adventure['nbor'] ?> pièces d'or et <?= (int) $adventure['nbexp'] ?> points d'expérience
                <?= action_button('start-adventure', 'Partir', 'aventures', ['aventure' => $adventure['code']]) ?>
            </div>
        </div>
    <?php endforeach ?>
</div>
