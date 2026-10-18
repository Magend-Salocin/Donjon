<?php

return [
    // Fichier SQLite, créé et rempli automatiquement au premier lancement.
    'database' => __DIR__ . '/../data/donjon.sqlite',

    // Affiche les erreurs PHP dans la page. À désactiver hors développement.
    'debug' => true,

    // Délai (secondes) pendant lequel un joueur est considéré « en ligne » après sa dernière page.
    'online_window' => 300,

    // Nombre maximum de duels par jour et par héros.
    'duels_per_day' => 60,
];
