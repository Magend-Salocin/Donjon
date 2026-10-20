<?php
/** @var array $hero */
?>
<div id="CarteJoueur">
    <table class="hero-stats">
        <tr>
            <td>
                Nom du héros : <?= e($hero['nom']) ?><br>
                Héros : <?= e($hero['libellerace']) ?><br>
                Niveau : <?= (int) $hero['codeexp'] ?><br>
                E-mail : <?= e($hero['email']) ?>
            </td>
            <td><img src="<?= e(hero_portrait($hero)) ?>" alt=""></td>
        </tr>
    </table>

    <h3>Changer mon mot de passe</h3>
    <form method="post" action="<?= e(url('compte')) ?>" class="account-form">
        <?= csrf_field() ?>
        <input type="hidden" name="action" value="change-password">
        <input type="hidden" name="retour" value="compte">
        <p><label for="oldMdp">Ancien mot de passe</label><input type="password" id="oldMdp" name="oldMdp" required autocomplete="current-password"></p>
        <p><label for="newMDP">Nouveau mot de passe</label><input type="password" id="newMDP" name="newMDP" minlength="6" required autocomplete="new-password"></p>
        <p><label for="confMDP">Confirmation</label><input type="password" id="confMDP" name="confMDP" minlength="6" required autocomplete="new-password"></p>
        <p><button type="submit">Valider</button></p>
    </form>
</div>
