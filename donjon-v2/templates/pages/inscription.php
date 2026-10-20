<?php
/**
 * @var list<array> $races
 * @var array{nom: string, email: string} $form
 */
?>
<div id="body-fullside" class="loginBlock">
    <div class="register">
        <form method="post" action="<?= e(url('inscription')) ?>">
            <?= csrf_field() ?>
            <input type="hidden" name="action" value="register">
            <table>
                <tr>
                    <td><label for="email">Votre e-mail :</label></td>
                    <td><input type="email" id="email" name="email" maxlength="60" required value="<?= e($form['email']) ?>"></td>
                </tr>
                <tr>
                    <td><label for="nom">Votre nom de héros :</label></td>
                    <td><input type="text" id="nom" name="nom" maxlength="20" required value="<?= e($form['nom']) ?>"></td>
                </tr>
                <tr>
                    <td><label for="mdp">Votre mot de passe :</label></td>
                    <td><input type="password" id="mdp" name="mdp" minlength="6" required autocomplete="new-password"></td>
                </tr>
                <tr>
                    <td><label for="mdp2">Confirmer le mot de passe :</label></td>
                    <td><input type="password" id="mdp2" name="mdp2" minlength="6" required autocomplete="new-password"></td>
                </tr>
                <tr>
                    <td colspan="2" class="center">
                        <label><input type="radio" name="sexe" value="H" required> Héros</label>
                        <label><input type="radio" name="sexe" value="F"> Héroïne</label>
                        <select name="race" required>
                            <option value="">Sélectionnez votre héros :</option>
                            <?php foreach ($races as $race): ?>
                                <option value="<?= e($race['code']) ?>"><?= e($race['libelle']) ?></option>
                            <?php endforeach ?>
                        </select>
                    </td>
                </tr>
                <tr>
                    <td colspan="2" class="center"><button type="submit">Enregistrer</button></td>
                </tr>
            </table>
        </form>
    </div>
</div>
