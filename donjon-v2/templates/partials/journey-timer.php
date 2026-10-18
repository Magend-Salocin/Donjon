<?php
/** @var array{destination: array, remaining: int} $journey */
?>
<div class="menu_separator">
    <div class="separator_text">Voyage</div>
</div>
<div class="journey">
    <p><strong>Voyage en cours vers <?= e($journey['destination']['libelle']) ?>.</strong></p>
    <p><span id="journey-time" data-remaining="<?= (int) $journey['remaining'] ?>">Chargement...</span> restant</p>
</div>
<script>
    (function () {
        var label = document.getElementById('journey-time');
        var arrival = Date.now() + Number(label.dataset.remaining) * 1000;

        function tick() {
            var seconds = Math.max(0, Math.round((arrival - Date.now()) / 1000));
            if (seconds === 0) {
                label.textContent = 'Arrivée !';
                window.location.reload();
                return;
            }
            var h = Math.floor(seconds / 3600), m = Math.floor(seconds / 60) % 60, s = seconds % 60;
            label.textContent = h + ':' + String(m).padStart(2, '0') + ':' + String(s).padStart(2, '0');
            window.setTimeout(tick, 1000);
        }
        tick();
    })();
</script>
