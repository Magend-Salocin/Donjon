<?php

// Source : .claude/kb/taverne/dialogues-taverniers.md. POC : sans bonus ni recrutement.
return [
    'nom' => 'Brunhilde, aubergiste',
    'lieu' => '02',
    'tavernier' => true,
    'noeuds' => [
        'accueil' => [
            'texte' => "Bienvenue au Cheval bondissant ! Lit, repas, écurie, et pas de bagarre avant minuit. Qu'est-ce que ce sera ?",
            'reponses' => [
                ['texte' => 'Des nouvelles de la route ?', 'suite' => 'nouvelles', 'icone' => 'rumeur'],
                ['texte' => 'Un lit.', 'suite' => 'repos', 'icone' => 'chope'],
                ['texte' => 'Des gens à embaucher ?', 'suite' => 'recrutement', 'icone' => 'epee'],
                ['texte' => 'Au revoir.'],
            ],
        ],
        'nouvelles' => [
            'variantes' => [
                [
                    'si' => [['aventure' => 101], ['sans-aventure' => 102], ['sans' => 'rumeur_ragnar']],
                    'texte' => "Sir Ragnar, le chevalier de l'Empereur, est aux mains d'Ulag. Ses gardes frappent toujours de face, les brutes. Ils n'ont jamais appris à feinter.",
                    'reponses' => [
                        ['texte' => 'Bon à savoir.', 'effets' => [['drapeau' => 'rumeur_ragnar']], 'suite' => 'accueil'],
                    ],
                ],
            ],
            'texte' => 'La route de l\'Est est calme. Trop calme, si tu veux mon avis.',
            'reponses' => [['texte' => 'On verra.', 'suite' => 'accueil']],
        ],
        'repos' => [
            'texte' => 'Huit pièces, repas compris. La soupe est bonne aujourd\'hui, pour une fois.',
            'reponses' => [
                ['texte' => 'Va pour un lit.', 'si' => [['or' => 8]], 'effets' => [['or' => -8], ['pv' => 'plein']]],
                ['texte' => 'Une autre fois.', 'suite' => 'accueil'],
            ],
        ],
        'recrutement' => [
            'texte' => "Kurt, l'arbalétrier, cuve sa bière à l'étage. Reviens quand il sera dessoûlé.",
            'reponses' => [['texte' => "D'accord.", 'suite' => 'accueil']],
        ],
    ],
];
