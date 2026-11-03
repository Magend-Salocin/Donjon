<?php

// Source : .claude/kb/taverne/dialogues-taverniers.md. POC : sans bonus ni recrutement, défi sans breuvage.
return [
    'nom' => 'Snorri, tavernier nain',
    'lieu' => '03',
    'tavernier' => true,
    'noeuds' => [
        'accueil' => [
            'texte' => 'Hah ! Un client qui tient debout. Rare, à cette heure. Bière, bagarre, ou ragots ?',
            'reponses' => [
                ['texte' => 'Ragots.', 'suite' => 'nouvelles', 'icone' => 'rumeur'],
                ['texte' => 'Un coin pour dormir.', 'suite' => 'repos', 'icone' => 'chope'],
                ['texte' => 'Des épées à louer ?', 'suite' => 'recrutement', 'icone' => 'epee'],
                ['texte' => 'Un défi à boire !', 'si' => [['sans' => 'defi_snorri']], 'suite' => 'defi', 'icone' => 'chope'],
                ['texte' => 'Où est passée ta réserve de bière ?',
                 'si' => [['sans-aventure' => 3], ['sans' => 'aventure_3']], 'suite' => 'biere'],
                ['texte' => 'Bière, et je m\'en vais.', 'effets' => [['or' => -1]]],
            ],
        ],
        'nouvelles' => [
            'variantes' => [
                [
                    'si' => [['aventure' => 102], ['sans-aventure' => 103], ['sans' => 'rumeur_ulag']],
                    'texte' => "Ulag ronfle comme un dragon. Ses gardes aussi, à l'aube. Entre à ce moment-là.",
                    'reponses' => [
                        ['texte' => 'Merci, Snorri.', 'si' => [['or' => 2]],
                         'effets' => [['or' => -2], ['drapeau' => 'rumeur_ulag']], 'suite' => 'accueil'],
                        ['texte' => "Je n'ai rien à payer.", 'suite' => 'accueil'],
                    ],
                ],
            ],
            'texte' => "Les mines de Gzor ont trouvé un filon d'argent. Tout le monde boit à crédit. C'est la fin du monde.",
            'reponses' => [['texte' => 'Courage.', 'suite' => 'accueil']],
        ],
        'repos' => [
            'texte' => 'Une paillasse dans la cave, entre deux tonneaux. Trois pièces. Ne touche pas aux tonneaux.',
            'reponses' => [
                ['texte' => 'Ça ira.', 'si' => [['or' => 3]], 'effets' => [['or' => -3], ['pv' => 'plein']]],
                ['texte' => 'Non merci.', 'suite' => 'accueil'],
            ],
        ],
        'recrutement' => [
            'texte' => 'Dorn, le tueur de trolls, ne signe pas avec un blanc-bec. Gagne tes galons d\'abord.',
            'reponses' => [['texte' => 'On verra.', 'suite' => 'accueil']],
        ],
        'defi' => [
            'texte' => 'Un défi ! Trois chopes de Bière de Gromril, et le premier qui tombe paie la tournée. Mise : 10 pièces.',
            'reponses' => [
                // Le Nain gagne toujours, les autres types perdent : un clin d'œil, pas un jeu de hasard.
                ['texte' => 'Je tiens le pari.', 'si' => [['or' => 10], ['type' => 'Nain'], ['sans' => 'defi_snorri']],
                 'effets' => [['or' => 10], ['drapeau' => 'defi_snorri']], 'suite' => 'defi-gagne'],
                ['texte' => 'Je tiens le pari.', 'si' => [['or' => 10], ['sans-type' => 'Nain'], ['sans' => 'defi_snorri']],
                 'effets' => [['or' => -10], ['drapeau' => 'defi_snorri']], 'suite' => 'defi-perdu'],
                ['texte' => 'Je ne suis pas fou.', 'suite' => 'accueil'],
            ],
        ],
        'defi-gagne' => [
            'texte' => 'Par ma barbe ! Un vrai buveur ! Garde la mise, tu l\'as méritée.',
            'reponses' => [['texte' => 'À la tienne.']],
        ],
        'defi-perdu' => [
            'texte' => '(Tu te réveilles sous la table. Snorri compte tes pièces en sifflant.)',
            'reponses' => [['texte' => '…']],
        ],
        'biere' => [
            'texte' => "Un lutin. Bleu. Il est entré, il a tout pris, il est reparti dans la forêt. Toute ma réserve ! C'est une mission capitale !",
            'reponses' => [
                ['texte' => 'Je retrouve ta bière.', 'si' => [['grade' => 'Ecuyer']], 'effets' => [['debloquer' => 3]], 'suite' => 'biere-ok'],
                ['texte' => 'Je suis trop novice pour ça.', 'suite' => 'accueil'],
            ],
        ],
        'biere-ok' => [
            'texte' => 'Si tu la ramènes, tu bois gratuit chez moi pour toujours. Enfin… pour une semaine.',
            'reponses' => [['texte' => 'Marché conclu.']],
        ],
    ],
];
