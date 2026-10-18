<?php
/**
 * @var string $mode boite, ecrire ou lire
 * @var list<array> $inbox
 * @var array|null $message
 * @var string $recipient
 */
?>
<p class="center">
    <a href="<?= e(url('messagerie')) ?>">Boîte de réception</a> ||
    <a href="<?= e(url('messagerie', ['msg' => 'ecrire'])) ?>">Envoyer un message</a>
</p>

<div class="scroll-panel">
    <img src="<?= asset('img/msg_int/menu01.jpg') ?>" alt="" class="scroll-edge">
    <div class="scroll-body">
    <?php if ($mode === 'boite'): ?>
        <table class="messages">
            <tr><th></th><th>De</th><th>Sujet</th><th>Date</th><th></th></tr>
            <?php if ($inbox === []): ?>
                <tr><td colspan="5" class="center">Aucun message.</td></tr>
            <?php endif ?>
            <?php foreach ($inbox as $row): ?>
                <tr>
                    <td><img src="<?= asset('img/msg_int/' . ((int) $row['lue']) . '.jpg') ?>" alt="<?= $row['lue'] ? 'lu' : 'non lu' ?>"></td>
                    <td><?= e($row['de']) ?></td>
                    <td><?= e($row['sujet']) ?></td>
                    <td><?= e(format_date((int) $row['date'])) ?></td>
                    <td><a href="<?= e(url('messagerie', ['msg' => 'lire', 'id' => $row['code']])) ?>">lire</a></td>
                </tr>
            <?php endforeach ?>
        </table>

    <?php elseif ($mode === 'ecrire'): ?>
        <form method="post" action="<?= e(url('messagerie')) ?>" class="message-form">
            <?= csrf_field() ?>
            <input type="hidden" name="action" value="send-message">
            <input type="hidden" name="retour" value="messagerie">
            <p><label for="pseudo_msg">À :</label> <input type="text" id="pseudo_msg" name="pseudo_msg" maxlength="20" required value="<?= e($recipient) ?>"></p>
            <p><label for="sujet_msg">Sujet :</label> <input type="text" id="sujet_msg" name="sujet_msg" maxlength="100" required></p>
            <p><textarea name="text_msg" cols="45" rows="10" required></textarea></p>
            <p class="center"><button type="submit">Envoyer</button></p>
        </form>

    <?php else: ?>
        <p><strong>De :</strong> <?= e($message['de']) ?></p>
        <p><strong>Le :</strong> <?= e(format_date((int) $message['date'])) ?></p>
        <p><strong>Sujet :</strong> <?= e($message['sujet']) ?></p>
        <div class="message-content"><?= nl2br(e($message['contenu'])) ?></div>
        <div class="center">
            <?= action_button('delete-message', 'Effacer le message', 'messagerie', ['message' => $message['code']]) ?> ||
            <a href="<?= e(url('messagerie', ['msg' => 'ecrire', 'a' => $message['de']])) ?>">Répondre</a>
        </div>
    <?php endif ?>
    </div>
    <img src="<?= asset('img/msg_int/menu02.jpg') ?>" alt="" class="scroll-edge">
</div>
