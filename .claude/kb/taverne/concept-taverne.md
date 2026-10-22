# Concept : la taverne

Statut : proposition, à valider avant développement.

## Objectif

Aujourd'hui, la taverne ([taverne.php](../../../donjon-v2/templates/pages/taverne.php)) ne contient qu'un forum de village et un lien vers Tetris. L'idée est d'en faire le lieu où la campagne (`Campagne01` du dépôt HeroQuest) entre dans le jeu :

- parler aux PNJ par des dialogues à choix fermés ;
- ouvrir des aventures : celles de la campagne, et les quêtes de 2009 ;
- apprendre des rumeurs qui donnent un bonus pour l'aventure suivante ;
- vivre après chaque aventure les choix moraux des quêtes (rendre l'or de Magnus, épargner Balur…) ;
- gagner des reliques de lore ;
- recruter des mercenaires et des compagnons tirés du lore.

Le jeu en ligne n'a pas de maître du jeu. Les dialogues remplissent ce rôle : ils lisent l'état du héros et y écrivent les conséquences.

## Documents

| Document | Contenu |
| --- | --- |
| [mecaniques.md](mecaniques.md) | Notation des dialogues, conditions, effets, déblocage des aventures, débriefings, bonus, réputation et corruption, tables |
| [pnj.md](pnj.md) | PNJ de chaque taverne, conditions de présence, ton |
| [dialogues-taverniers.md](dialogues-taverniers.md) | Taverniers (rumeurs, repos, recrutement) et habitués qui ouvrent les quêtes de 2009 |
| [dialogues-campagne.md](dialogues-campagne.md) | Mentor et les débriefings des aventures 101 à 114 |
| [compagnons.md](compagnons.md) | Mercenaires, Sir Ragnar, Balur, le Guide traître, fidélité |
| [recompenses.md](recompenses.md) | Reliques, bonus de rumeur, registre des drapeaux |

## Ce qui existe et ce qui manque

| Existe | Manque |
| --- | --- |
| 3 villages avec chacun une taverne : Valtordu (Au rat fumant), Waldorg (Au cheval bondissant), Gzor (Le gai souriseau) | PNJ, dialogues |
| Aventures 101 à 124, issues des quêtes HeroQuest. Les quêtes 1 à 14 de la campagne correspondent aux aventures 101 à 114 | Choix pendant ou après une aventure (le donjon se gagne ou se perd, sans plus) |
| Aventures de 2009 (1 à 6), affichées d'emblée | Une raison de les découvrir |
| Table `accomplir` : aventures réussies par héros | Réputation, corruption de Zargon, drapeaux de campagne |
| Or, objets, niveau, type et sexe du héros | Reliques, bonus temporaires, alliés |
| Le moteur du plateau gère déjà plusieurs héros (`LesJoueurs`), et les sprites iso « guerrier » et « magicien » existent | Une IA pour des alliés |

Les aventures 105 (Melar) et 110 (Château des mystères) ne sont pas en base. La chaîne de la campagne passe de 104 à 106, puis de 109 à 111. Melar et Ollar n'apparaissent qu'en allusions.

## Le système de dialogue

### Notions

- **PNJ** : un personnage avec un nom, un portrait, une taverne et une condition de présence.
- **Nœud** : une réplique du PNJ et 2 à 4 réponses.
- **Réponse** : un texte, éventuellement une condition, des effets, puis le nœud suivant (ou la fin du dialogue).
- **Condition** : un test sur l'état du héros (aventure réussie, drapeau, or, grade, réputation, type…).
- **Effet** : une modification de cet état (or, objet, drapeau, aventure débloquée, bonus, recrutement…).

La liste complète des conditions et des effets est dans [mecaniques.md](mecaniques.md).

### Règles d'interface

- La réplique du PNJ s'affiche en haut, sur parchemin, avec son portrait. Les réponses sont numérotées en dessous.
- Une réponse dont la condition n'est pas remplie s'affiche grisée, avec la raison (« 20 or », « Réputation : Respecté »). Le joueur voit ainsi ce qu'il pourrait débloquer.
- Une réponse qui coûte ou rapporte affiche son effet entre crochets : `[−5 or]`, `[Réputation +1]`.
- Chaque choix est une requête POST (même modèle que les autres actions, avec jeton CSRF). Le serveur vérifie de nouveau la condition et applique les effets. Le navigateur n'est jamais cru.
- Un dialogue dont l'effet est unique (récompense, recrutement) ne se rejoue pas, grâce à un drapeau.

### Format des données

Les dialogues s'écrivent en Markdown dans `.claude/kb/taverne/` (notation lisible, facile à relire), puis se convertissent en un fichier PHP par PNJ, `data/dialogues/<pnj>.php`. Ce format ne demande ni dépendance ni parseur, autorise les commentaires et suit le style de `config/config.php`.

Le premier nœud d'Hergard, tavernier de Valtordu, une fois converti :

```php
<?php
return [
    'nom' => 'Hergard, tavernier',
    'portrait' => 'img/pnj/hergard.png',
    'lieu' => '01',
    'presence' => [],
    'noeuds' => [
        'accueil' => [
            'texte' => "Encore un aventurier… Essuie tes bottes, j'ai lavé le sol au printemps. Qu'est-ce que je te sers ?",
            'reponses' => [
                ['texte' => 'Des nouvelles du pays ?', 'suite' => 'nouvelles'],
                ['texte' => 'Une chambre pour la nuit.', 'suite' => 'repos'],
                ['texte' => 'Je cherche des bras pour une expédition.', 'effets' => [['ecran' => 'recrutement']]],
                ['texte' => 'Une tournée pour toute la salle !',
                 'si' => [['or' => 10], ['sans' => 'tournee_valtordu']],
                 'effets' => [['or' => -10], ['reputation' => 1], ['drapeau' => 'tournee_valtordu']],
                 'suite' => 'tournee'],
                ['texte' => 'Rien, merci.'],
            ],
        ],
        // nouvelles, repos, tournee : voir .claude/kb/taverne/dialogues-taverniers.md
    ],
];
```

## Ce que la taverne apporte, en résumé

**Ouvrir des aventures.**

- La campagne se débloque aventure par aventure : chaque débriefing ouvre la suivante.
- Les quêtes de 2009 s'ouvrent auprès des habitués : le père Magotte et ses rats, Jos et son changeforme, Snorri et sa bière volée par un lutin, Gnorg le gobelin unijambiste.
- Après l'aventure 114, Mentor ouvre le Retour du Sorcier-Roi (115 à 124).

**Bonus.**

- Les rumeurs payantes donnent un bonus pour une aventure précise (`def+1@102`).
- Le repos rend les points de vie. La chambre de luxe et le défi à boire donnent un bonus pour l'aventure suivante.

**Reliques.**

- 17 objets de lore, de la lettre de recommandation de Mentor à la Larme de Leben.
- Leurs effets s'appliquent dans le donjon, et certaines servent de clés (l'Étoile de l'Ouest pour 113 et 114).

**Compagnons.**

- 6 mercenaires, dont le Guide, qui est le traître de l'aventure 109.
- 2 compagnons de lore : Sir Ragnar, chevalier fidèle à l'honneur, et Balur, puissant mais corrupteur. Ils sont incompatibles.
- La fidélité réagit aux choix du héros.

**Réputation et corruption.**

- Elles agissent sur les prix, les mercenaires, le repos et le nombre de monstres.
- À corruption 7, un cultiste remplace Hergard et Balur trahit.

## Découpage proposé

1. Moteur de dialogue, table `drapeau`, Hergard, Brunhilde et Snorri avec rumeurs et repos. Habitués et déblocage des aventures de 2009.
2. Débriefings 101 à 104, déblocage de la campagne, réputation et corruption affichées sur la fiche.
3. Reliques et bonus d'aventure (table `bonus`, application dans `jeu.php`).
4. Mercenaires, puis Sir Ragnar et sa fidélité.
5. Débriefings 106 à 114, Balur, le Guide, fin de campagne.
6. Allié visible sur le plateau, avec son IA.

Chaque étape est jouable seule. La 1 donne déjà une raison d'aller à la taverne.

## Décisions à prendre

- **Noms des villages.** Les villages du jeu (Valtordu, Waldorg, Gzor) viennent de l'univers Naheulbeuk de 2009. La campagne se déroule dans l'Empire (Ubersreik, Altdorf). Les documents gardent les villages du jeu, et les PNJ citent Altdorf comme la capitale lointaine. À confirmer.
- **Karlen ou Wardoz.** L'aventure 107 parle de Karlen (nom du HeroQuest PC), la campagne de Wardoz. Les dialogues utilisent Wardoz : faut-il corriger le résumé en base ?
- **Quêtes de 2009 verrouillées.** Les aventures 1 à 6 seraient cachées jusqu'à la rencontre de l'habitué. C'est un changement pour les joueurs actuels, sauf si leurs drapeaux sont posés à la migration.
- **Plafond de dés.** L'équipement ajoute 5 à 50 à l'attaque et à la défense, alors que le donjon plafonne à 8 dés. Un héros équipé est donc vite au plafond. Les bonus de la taverne s'appliquent après le plafond ([mecaniques.md](mecaniques.md)), mais l'équilibre de l'équipement mériterait d'être revu à part.
- **Réputation globale ou par village.** La campagne ne tranche pas ([regles-campagne.md](../../../../../HeroQuest/HeroQuest/Campagne01/01-regles/regles-campagne.md)). Les documents utilisent une réputation globale.
- **Seuils de réputation et de corruption.** Les documents reprennent ceux de `regles-campagne.md`, encore à arbitrer dans la campagne.
- **Mort d'un mercenaire.** Si le héros perd l'aventure, le mercenaire part avec son or. Faut-il aller plus loin, avec des blessures ou un prix qui augmente ?
