<?php
/**
 * @var array $hero
 * @var array $shop
 * @var list<array> $offers
 */

use Donjon\View;
?>
<div class="shopkeeper">
    <img src="<?= asset('img/theme-2009/A.png') ?>" alt="">
    <p><strong><?= e($shop['libelle']) ?></strong><br>Bienvenue dans mon échoppe, aventurier ! Vous avez <?= (int) $hero['ors'] ?> pièces d'or.</p>
</div>

<div class="parchment-list">
    <h3>Les objets du magasin</h3>
    <?php if ($offers === []): ?>
        <p>Le magasin est vide.</p>
    <?php endif ?>
    <?php foreach ($offers as $offer): ?>
        <?= View::render('partials/item-card', [
            'item' => $offer,
            'footer' => 'Prix : <strong>' . (int) $offer['prix'] . '</strong> pièces d\'or - Stock : ' . (int) $offer['stock'] . ' '
                . action_button('buy', 'Acheter', 'magasin', ['magasin' => $shop['code'], 'objet' => $offer['num']]),
        ]) ?>
    <?php endforeach ?>
    <p class="center"><a href="<?= e(url('village')) ?>">Retour au village</a></p>
</div>
