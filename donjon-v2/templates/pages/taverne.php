<?php
/**
 * @var array $hero
 * @var array $village
 * @var array<string, array> $npcs PNJ présents, tavernier en premier
 * @var array|null $npc PNJ qui parle, null dans la salle
 * @var array{texte: string, reponses: list<array>}|null $node
 * @var list<array> $chat
 */

use Donjon\Game\Tavern;

$icon = static fn(string $name): string => asset('img/taverne/icone-' . $name . '.png');
?>
<div class="taverne">
    <div class="taverne-salle" style="background-image: url('<?= asset('img/taverne/salle-' . e($village['code']) . '.jpg') ?>')">
        <h2>Taverne de <?= e($village['libelle']) ?></h2>
    </div>

    <div class="taverne-dialogue">
        <?php if ($node !== null): ?>
            <figure class="taverne-portrait">
                <img src="<?= e(asset($npc['portrait'] ?? Tavern::DEFAULT_PORTRAIT)) ?>" alt="">
                <figcaption><?= e($npc['nom']) ?></figcaption>
            </figure>
            <div class="taverne-replique parchemin">
                <p><?= nl2br(e($node['texte'])) ?></p>
            </div>
            <ol class="taverne-choix">
                <?php foreach ($node['reponses'] as $answer): ?>
                    <li>
                        <form method="post" action="<?= e(url('taverne')) ?>">
                            <?= csrf_field() ?>
                            <input type="hidden" name="action" value="dialogue">
                            <input type="hidden" name="retour" value="taverne">
                            <input type="hidden" name="choix" value="<?= (int) $answer['index'] ?>">
                            <button type="submit"<?= $answer['possible'] ? '' : ' disabled' ?>>
                                <img src="<?= $icon($answer['icone']) ?>" alt="">
                                <span>
                                    <?= e($answer['texte']) ?>
                                    <?php if (!$answer['possible']): ?>
                                        <small class="taverne-raison">Il faut : <?= e($answer['raison']) ?></small>
                                    <?php elseif ($answer['effets'] !== []): ?>
                                        <small>[<?= e(implode(', ', $answer['effets'])) ?>]</small>
                                    <?php endif ?>
                                </span>
                            </button>
                        </form>
                    </li>
                <?php endforeach ?>
            </ol>
            <p class="taverne-quitter"><a href="<?= e(url('taverne', ['salle' => 1])) ?>">Retourner dans la salle</a></p>
        <?php else: ?>
            <figure class="taverne-portrait">
                <img src="<?= hero_portrait($hero) ?>" alt="">
                <figcaption><?= e($hero['nom']) ?></figcaption>
            </figure>
            <div class="taverne-replique parchemin">
                <p>La salle est pleine. Ça sent la bière, le feu de bois et le ragoût.<br>À qui voulez-vous parler ?</p>
            </div>
            <ul class="taverne-choix">
                <?php foreach ($npcs as $code => $person): ?>
                    <li>
                        <a href="<?= e(url('taverne', ['pnj' => $code])) ?>">
                            <img src="<?= $icon(empty($person['tavernier']) ? 'rumeur' : 'chope') ?>" alt="">
                            <span><?= e($person['nom']) ?></span>
                        </a>
                    </li>
                <?php endforeach ?>
                <li>
                    <a href="<?= e(url('village')) ?>">
                        <img src="<?= $icon('porte') ?>" alt="">
                        <span>Quitter la taverne</span>
                    </a>
                </li>
            </ul>
        <?php endif ?>
    </div>

    <details class="taverne-forum">
        <summary>Forum de la taverne</summary>
        <ul>
            <?php if ($chat === []): ?>
                <li><em>Personne n'a encore rien clamé.</em></li>
            <?php endif ?>
            <?php foreach ($chat as $line): ?>
                <li><strong><?= e($line['auteur']) ?></strong> : <?= e($line['message']) ?></li>
            <?php endforeach ?>
        </ul>
        <form method="post" action="<?= e(url('taverne')) ?>">
            <?= csrf_field() ?>
            <input type="hidden" name="action" value="chat">
            <input type="text" name="message" maxlength="200" required>
            <button type="submit">Clamer</button>
        </form>
    </details>
</div>
