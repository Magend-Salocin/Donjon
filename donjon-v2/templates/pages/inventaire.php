<?php
/**
 * @var array $hero
 * @var list<array> $items
 * @var list<array> $questItems
 * @var list<array> $equipment
 */

use Donjon\View;
?>
<div class="parchment-list">
    <h3>Les objets de votre inventaire</h3>
    <?php if ($items === []): ?>
        <p>Vous ne possédez aucun objet.</p>
    <?php endif ?>
    <?php foreach ($items as $item): ?>
        <?= View::render('partials/item-card', [
            'item' => $item,
            'footer' => 'Vous en possédez ' . (int) $item['nb'] . ' ' . action_button('use-item', 'Utiliser', 'inventaire', ['objet' => $item['num']]),
        ]) ?>
    <?php endforeach ?>
</div>

<div class="parchment-list">
    <h3>Les équipements de votre inventaire</h3>
    <?php if ($equipment === []): ?>
        <p>Vous ne possédez aucun équipement.</p>
    <?php endif ?>
    <?php foreach ($equipment as $item): ?>
        <?= View::render('partials/item-card', [
            'item' => $item,
            'footer' => $hero[$item['autre']] === $item['libelle']
                ? 'Équipé (' . e($item['autre']) . ')'
                : 'Vous en possédez ' . (int) $item['nb'] . ' ' . action_button('equip', 'Équiper', 'inventaire', ['objet' => $item['num']]),
        ]) ?>
    <?php endforeach ?>
</div>

<?php if ($questItems !== []): ?>
    <div class="parchment-list">
        <h3>Potions trouvées dans le donjon</h3>
        <p>Elles s'utilisent pendant une aventure, depuis le bouton « Utiliser objet ».</p>
        <?php foreach ($questItems as $item): ?>
            <?= View::render('partials/item-card', ['item' => $item, 'footer' => 'Vous en possédez ' . (int) $item['nb']]) ?>
        <?php endforeach ?>
    </div>
<?php endif ?>
