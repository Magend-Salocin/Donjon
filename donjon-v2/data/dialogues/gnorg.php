<?php

// Source : .claude/kb/taverne/dialogues-taverniers.md.
return [
    'nom' => 'Gnorg, gobelin repenti',
    'lieu' => '03',
    'presence' => [['sans-aventure' => 6]],
    'noeuds' => [
        'accueil' => [
            'texte' => 'Pas taper ! Gnorg gentil maintenant ! Mais copains à Gnorg, pas gentils. Eux boire, eux piller champ du fermier, eux casser tout.',
            'reponses' => [
                ['texte' => 'Où sont-ils ?', 'effets' => [['debloquer' => 6]], 'suite' => 'accepte'],
                ['texte' => 'Pourquoi tu les trahis ?', 'suite' => 'pourquoi'],
                ['texte' => 'Dégage.'],
            ],
        ],
        'pourquoi' => [
            'texte' => 'Eux prendre jambe de Gnorg. Pour rire. Gnorg pas rire.',
            'reponses' => [
                ['texte' => 'Je comprends. Où sont-ils ?', 'effets' => [['debloquer' => 6]], 'suite' => 'accepte'],
            ],
        ],
        'accepte' => [
            'texte' => 'Champ derrière colline. Eux dormir le jour, boire la nuit. Toi venir le jour !',
            'reponses' => [['texte' => 'Merci, Gnorg.']],
        ],
    ],
];
