<div id="body-fullside" class="loginBlock">
    <div class="login">
        <form method="post" action="<?= e(url('connexion')) ?>" class="parchment">
            <?= csrf_field() ?>
            <input type="hidden" name="action" value="login">
            <h2>Authentification</h2>
            <p>
                <label for="login">Nom de héros</label>
                <input type="text" id="login" name="login" required autofocus autocomplete="username">
            </p>
            <p>
                <label for="mdp">Mot de passe</label>
                <input type="password" id="mdp" name="mdp" required autocomplete="current-password">
            </p>
            <p><button type="submit">Se connecter</button></p>
            <p class="hint">Pas encore de héros ? <a href="<?= e(url('inscription')) ?>">Inscription</a></p>
        </form>

        <div class="intro-flash">
            <embed src="<?= asset('flash/Donjon.swf') ?>" type="application/x-shockwave-flash" width="550" height="400">
        </div>
    </div>
</div>
<!-- Ruffle émule le lecteur Flash, abandonné par les navigateurs, pour lire l'intro d'origine. -->
<script src="https://unpkg.com/@ruffle-rs/ruffle@0.6.0/ruffle.js"></script>
