<?php

// Source : .claude/kb/taverne/dialogues-taverniers.md.
return [
    'nom' => 'Jos, éleveur de poulets',
    'lieu' => '02',
    'presence' => [['sans' => 'fini_jos']],
    'noeuds' => [
        'accueil' => [
            'variantes' => [
                [
                    'si' => [['aventure' => 2]],
                    'texte' => 'Plus un poulet de perdu ! Tenez, le gâteau de ma femme.',
                    'reponses' => [
                        ['texte' => 'Merci, Jos.', 'effets' => [['objet' => 20], ['drapeau' => 'fini_jos']]],
                    ],
                ],
                [
                    'si' => [['drapeau' => 'aventure_2']],
                    'texte' => 'Quinze pièces si vous le trouvez. Et pas un mot à ma femme, elle croit que c\'est le renard.',
                    'reponses' => [['texte' => 'Promis.']],
                ],
            ],
            'texte' => "Mes poulets… Un par nuit. Et ce matin, j'ai vu un de mes poulets… marcher sur deux jambes d'homme. Un changeforme ! Personne ne me croit.",
            'reponses' => [
                ['texte' => 'Moi, je te crois.', 'effets' => [['debloquer' => 2]], 'suite' => 'accepte'],
                ['texte' => 'Tu as trop bu.'],
            ],
        ],
        'accepte' => [
            'texte' => 'Merci ! Quinze pièces si vous le trouvez. Et pas un mot à ma femme, elle croit que c\'est le renard.',
            'reponses' => [['texte' => 'Promis.']],
        ],
    ],
];
