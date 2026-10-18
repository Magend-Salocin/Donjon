/* Lecteur des musiques d'origine (dossier arzhel/ de la v1). La piste choisie est mémorisée dans le navigateur. */
(function () {
    var select = document.getElementById('music-track');
    var player = document.getElementById('music-player');
    if (!select || !player) {
        return;
    }

    try {
        var saved = localStorage.getItem('donjon-music');
        if (saved && select.querySelector('option[value="' + saved + '"]')) {
            select.value = saved;
        }
    } catch (error) {
        // Stockage indisponible (navigation privée) : on garde la première piste.
    }
    player.src = select.value;

    select.addEventListener('change', function () {
        var wasPlaying = !player.paused;
        player.src = select.value;
        if (wasPlaying) {
            player.play();
        }
        try {
            localStorage.setItem('donjon-music', select.value);
        } catch (error) {
            // Sans stockage, le choix ne sera simplement pas mémorisé.
        }
    });
})();
