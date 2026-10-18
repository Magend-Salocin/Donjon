<?php
/**
 * Carte d'objet sur fond de parchemin.
 *
 * @var array $item ligne objet (+ nb ou stock/prix)
 * @var string $footer HTML déjà échappé affiché sous la description
 */
?>
<div class="item-card">
    <img src="<?= asset('img/inventaire/' . e($item['image'])) ?>" alt="" class="item-image">
    <div class="item-text">
        <strong><?= e($item['libelle']) ?></strong>
        <hr>
        <p><?= nl2br(e($item['resumer'])) ?></p>
    </div>
    <div class="item-footer"><?= $footer ?></div>
</div>
