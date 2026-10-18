<?php
/** @var array{log: list<array{side: string, text: string}>, summary: string} $result */
?>
<h2 class="center"><?= e($result['summary']) ?></h2>
<ul class="fight-log">
    <?php foreach ($result['log'] as $index => $line): ?>
        <li class="fight-<?= e($line['side']) ?>" style="animation-delay: <?= $index * 200 ?>ms"><?= e($line['text']) ?></li>
    <?php endforeach ?>
</ul>
<p class="center"><a href="<?= e(url('defis')) ?>">Retour aux défis</a></p>
