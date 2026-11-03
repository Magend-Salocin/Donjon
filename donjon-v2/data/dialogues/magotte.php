<?php

// Source : .claude/kb/taverne/dialogues-taverniers.md.
return [
    'nom' => 'Père Magotte, fermier',
    'lieu' => '01',
    'presence' => [['sans' => 'fini_magotte']],
    'noeuds' => [
        'accueil' => [
            'variantes' => [
                [
                    'si' => [['aventure' => 1]],
                    'texte' => 'Mon poulet, comme promis !',
                    'reponses' => [
                        ['texte' => 'Merci, père Magotte.', 'effets' => [['objet' => 19], ['drapeau' => 'fini_magotte']]],
                    ],
                ],
                [
                    'si' => [['drapeau' => 'aventure_1']],
                    'texte' => "Alors, ces rats ? La grange est derrière le moulin. Prenez une torche, ils n'aiment pas le feu.",
                    'reponses' => [['texte' => "J'y vais."]],
                ],
            ],
            'texte' => 'Vous êtes aventurier, vous ? Alors aidez un pauvre vieux. Les rats ont pris ma grange. Des gros, gros comme des chiens.',
            'reponses' => [
                ['texte' => "Je m'en occupe.", 'effets' => [['debloquer' => 1]], 'suite' => 'accepte'],
                ['texte' => 'Combien vous payez ?', 'suite' => 'paie', 'icone' => 'or'],
                ['texte' => 'Pas le temps.'],
            ],
        ],
        'paie' => [
            'texte' => 'Dix pièces, et toute la reconnaissance du village. Et un poulet, si vous revenez vivant.',
            'reponses' => [
                ['texte' => 'Marché conclu.', 'effets' => [['debloquer' => 1]], 'suite' => 'accepte'],
                ['texte' => 'Trop peu.'],
            ],
        ],
        'accepte' => [
            'texte' => "Merci ! La grange est derrière le moulin. Prenez une torche, ils n'aiment pas le feu.",
            'reponses' => [['texte' => "J'y vais."]],
        ],
    ],
];
