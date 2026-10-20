<?php
/** @var list<array> $questItems objets utilisables dans le donjon (catégories item et quete) */
?>
<?php if ($questItems === []): ?>
    <p>Vous ne possédez aucun objet utilisable.</p>
<?php endif ?>
<?php foreach ($questItems as $index => $item): ?>
    <div class="quest-item">
        <img src="<?= asset('img/objets/' . e($item['image'])) ?>" alt="">
        <div>
            <strong><?= e($item['libelle']) ?></strong>
            <p><?= e($item['resumer']) ?></p>
            Vous possédez <span id="_item<?= (int) $item['num'] ?>"><?= (int) $item['nb'] ?></span>
            <button type="button" class="link" onclick="UtiliserObjet(<?= (int) $index ?>)">utiliser</button>
        </div>
    </div>
<?php endforeach ?>
