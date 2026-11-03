<?php

// Source : .claude/kb/taverne/dialogues-taverniers.md. POC : sans bonus, réputation ni recrutement.
return [
    'nom' => 'Hergard, tavernier',
    'lieu' => '01',
    'tavernier' => true,
    'noeuds' => [
        'accueil' => [
            'texte' => "Encore un aventurier… Essuie tes bottes, j'ai lavé le sol au printemps. Qu'est-ce que je te sers ?",
            'reponses' => [
                ['texte' => 'Des nouvelles du pays ?', 'suite' => 'nouvelles', 'icone' => 'rumeur'],
                ['texte' => 'Une chambre pour la nuit.', 'suite' => 'repos', 'icone' => 'chope'],
                ['texte' => 'Je cherche des bras pour une expédition.', 'suite' => 'recrutement', 'icone' => 'epee'],
                ['texte' => 'Une tournée pour toute la salle !',
                 'si' => [['or' => 10], ['sans' => 'tournee_valtordu']],
                 'effets' => [['or' => -10], ['drapeau' => 'tournee_valtordu']],
                 'suite' => 'tournee'],
                ['texte' => 'Il paraît que tu connais une histoire de statuette ?',
                 'si' => [['sans-aventure' => 4], ['sans' => 'aventure_4'], ['grade' => 'Aventurier']],
                 'effets' => [['debloquer' => 4]],
                 'suite' => 'statuette'],
                ['texte' => 'Rien, merci.'],
            ],
        ],
        'nouvelles' => [
            'variantes' => [
                [
                    'si' => [['sans-aventure' => 101], ['sans' => 'rumeur_labyrinthe']],
                    'texte' => "Le vieux Mentor cherche des têtes brûlées pour son épreuve. Paraît qu'il a semé son labyrinthe de pièges, le vieux sadique.",
                    'reponses' => [
                        ['texte' => 'Où sont les pièges ?', 'si' => [['or' => 2]],
                         'effets' => [['or' => -2], ['drapeau' => 'rumeur_labyrinthe']], 'suite' => 'nouvelles-merci'],
                        ['texte' => 'Je trouverai bien.', 'suite' => 'accueil'],
                    ],
                ],
            ],
            'texte' => "Rien de neuf. Les vaches donnent moins de lait depuis que les orcs passent. C'est tout.",
            'reponses' => [
                ['texte' => 'Dommage.', 'suite' => 'accueil'],
            ],
        ],
        'nouvelles-merci' => [
            'texte' => 'Les dalles les plus propres. Personne ne marche dessus, alors personne ne les salit. Logique, non ?',
            'reponses' => [['texte' => 'Logique.', 'suite' => 'accueil']],
        ],
        'repos' => [
            'texte' => "La paillasse, c'est 5 pièces. Pour 12, t'as la chambre du haut, un vrai lit et un bain chaud.",
            'reponses' => [
                ['texte' => 'La paillasse.', 'si' => [['or' => 5]], 'effets' => [['or' => -5], ['pv' => 'plein']], 'suite' => 'repos-ok'],
                ['texte' => 'La chambre du haut.', 'si' => [['or' => 12]], 'effets' => [['or' => -12], ['pv' => 'plein']], 'suite' => 'repos-ok'],
                ['texte' => 'Trop cher.', 'suite' => 'accueil'],
            ],
        ],
        'repos-ok' => [
            'texte' => "Dors bien. Et si t'entends gratter sous le plancher, c'est les rats du père Magotte. Pas les miens.",
            'reponses' => [['texte' => 'Bonne nuit.']],
        ],
        'recrutement' => [
            'texte' => "Des bras ? Tout le monde est aux champs. Repasse quand la moisson sera rentrée.",
            'reponses' => [['texte' => 'Tant pis.', 'suite' => 'accueil']],
        ],
        'tournee' => [
            'texte' => "Holà, tout le monde ! C'est l'aventurier qui régale !\n(La salle lève ses chopes. On se souviendra de ton nom à Valtordu.)",
            'reponses' => [['texte' => 'À la vôtre !']],
        ],
        'statuette' => [
            'texte' => "Une statuette, une prophétie de Galdeulfera, et un sorcier de niveau 1 pour l'aller chercher. Ça finit toujours mal, ces histoires-là. Monte une compagnie, et bonne chance.",
            'reponses' => [['texte' => 'On verra bien.']],
        ],
    ],
];
