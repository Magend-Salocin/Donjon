<?php
/**
 * @var array $village
 * @var list<array> $chat
 */
?>
<div class="tavern">
    <h2>Bienvenue à la taverne de <?= e($village['libelle']) ?></h2>
    <img src="<?= asset('img/lieux/taverne/' . e($village['code']) . '.png') ?>" alt="" class="tavern-image">

    <div class="tavern-columns">
        <div>
            <h3>Forum de la taverne</h3>
            <ul class="chat">
                <?php if ($chat === []): ?>
                    <li><em>Personne n'a encore rien clamé.</em></li>
                <?php endif ?>
                <?php foreach ($chat as $line): ?>
                    <li><strong><?= e($line['auteur']) ?></strong> a écrit : <?= e($line['message']) ?></li>
                <?php endforeach ?>
            </ul>
            <form method="post" action="<?= e(url('taverne')) ?>">
                <?= csrf_field() ?>
                <input type="hidden" name="action" value="chat">
                <input type="text" name="message" maxlength="200" required>
                <button type="submit">Clamer</button>
                <a href="<?= e(url('taverne')) ?>">Ouïr</a>
            </form>
        </div>
        <div>
            <h3>Jeux de taverne</h3>
            <p><a href="games/tetris/index.html">Tetris</a></p>
            <h3>Bientôt à la taverne</h3>
            <ul>
                <li>News sur les dernières aventures</li>
                <li>News sur les prochaines armes</li>
                <li>News sur l'évolution du village</li>
                <li>Création du tavernier</li>
            </ul>
        </div>
    </div>
</div>
