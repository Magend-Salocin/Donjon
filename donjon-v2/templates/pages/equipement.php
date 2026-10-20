<?php
/**
 * @var array $hero
 * @var list<string> $slots
 */

$labels = [
    'Arme' => 'Arme',
    'Bouclier' => 'Bouclier',
    'Casque' => 'Casque',
    'Plastron' => 'Plastron',
    'AvantBras' => 'Avant-bras',
    'Botte' => 'Bottes',
    'Jambiere' => 'Jambières',
];
?>
<h2>Équipement</h2>
<div class="scroll-panel">
    <img src="<?= asset('img/theme-2009/msg-menu01.jpg') ?>" alt="" class="scroll-edge">
    <table class="tabheros scroll-body">
        <?php foreach ($slots as $slot): ?>
            <tr>
                <td><strong><?= e($labels[$slot]) ?> :</strong></td>
                <td><?= $hero[$slot] === 'rien' ? '<em>rien</em>' : e($hero[$slot]) ?></td>
                <td>
                    <?php if ($hero[$slot] !== 'rien'): ?>
                        <?= action_button('unequip', 'Enlever', 'equipement', ['emplacement' => $slot]) ?>
                    <?php endif ?>
                </td>
            </tr>
        <?php endforeach ?>
    </table>
    <img src="<?= asset('img/theme-2009/msg-menu02.jpg') ?>" alt="" class="scroll-edge">
</div>
