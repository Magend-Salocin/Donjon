# PNJ des tavernes

Qui se trouve dans quelle taverne, et à quel moment. Les dialogues sont dans [dialogues-taverniers.md](dialogues-taverniers.md) et [dialogues-campagne.md](dialogues-campagne.md).

## Règles de présence

- Une taverne affiche 2 à 4 PNJ à la fois : son tavernier, toujours présent, et les PNJ dont la condition est vraie.
- Le débriefing d'une aventure a lieu dans la taverne du village où elle se joue (colonne `aventure.village`).
- Un PNJ de débriefing passe avant tous les autres. Tant qu'il attend, les autres ont une réplique courte du type « Va d'abord voir celui qui t'attend dans le coin ».
- Un PNJ dont le dialogue est épuisé (drapeau `fini_<pnj>`) ne s'affiche plus, sauf s'il a une réplique d'ambiance.
- Chaque PNJ a un portrait (`img/pnj/<pnj>.png`), à générer comme les héros ([heros-prompt.md](../../../Campagne01/01-regles/heros-prompt.md)).

## Valtordu, Au rat fumant (village 01)

Une taverne de village, enfumée, où l'on parle de récoltes et de bière.

| PNJ | Rôle | Présence |
| --- | --- | --- |
| Hergard, tavernier | Rumeurs, repos, mercenaires | toujours |
| Père Magotte, fermier | Ouvre l'aventure 1 (rats) | tant que l'aventure 1 n'est pas réussie |
| Mentor | Épreuve (101), débriefings 101 et 112 | `debrief_101_*`, `debrief_112_*`, ou au départ (`sans drapeau mentor_rencontre`) |
| Émissaire du Prince Magnus | Débriefing 104 (l'or) | `debrief_104_*` |
| Balur | Débriefing 108, puis compagnon possible | `debrief_108_*`, puis `drapeau balur_epargne` |
| Garde impérial | Mercenaire (défense) | réputation ≥ 3 |
| Sœur Ilsa, prêtresse de Sigmar | Mercenaire (soins) | corruption ≤ 3 |
| Le Guide | Faux mercenaire, piège de l'aventure 109 | `aventure 108` et `sans drapeau guide_traitre` |

## Waldorg, Au cheval bondissant (village 02)

Une auberge de route, où passent voyageurs, soldats et marchands.

| PNJ | Rôle | Présence |
| --- | --- | --- |
| Brunhilde, aubergiste | Rumeurs, repos, mercenaires | toujours |
| Jos, éleveur de poulets | Ouvre l'aventure 2 (changeforme) | tant que l'aventure 2 n'est pas réussie |
| Sir Ragnar | Débriefing 102, compagnon | `debrief_102_*`, puis `drapeau ragnar_libre` |
| Prisonnier évadé | Débriefing 106 | `debrief_106_*` |
| Voix du labyrinthe (vision) | Débriefing 109 | `debrief_109_*` |
| Prêtre fantôme (vision) | Débriefing 113 | `debrief_113_*` |
| Kurt, arbalétrier | Mercenaire | toujours |

## Gzor, Le gai souriseau (village 03)

Une taverne naine près des mines, bruyante et mal famée.

| PNJ | Rôle | Présence |
| --- | --- | --- |
| Snorri, tavernier nain | Rumeurs, repos, mercenaires. Ouvre l'aventure 3 (le lutin et la bière) | toujours |
| Gnorg, gobelin unijambiste repenti | Ouvre l'aventure 6 | tant que l'aventure 6 n'est pas réussie |
| Esprit de Wardoz (vision) | Débriefing 107 | `debrief_107_*` |
| Éclaireur impérial | Débriefings 103 et 111 | `debrief_103_*` ou `debrief_111_*` |
| Grak (ou ses émissaires) | Allié orc ou ennemi qui menace | `drapeau grak_allie` ou `drapeau grak_vengeance` |
| Dorn, tueur de trolls | Mercenaire | grade Ecuyer ou plus |
| Mentor | Débriefing 114 : fin de campagne, ouvre les aventures 115 à 124 | `debrief_114_*` |

## Récurrents

| PNJ | Où | Comment |
| --- | --- | --- |
| Sir Ragnar | Waldorg, puis l'équipe | compagnon après 102 ; il reste à Waldorg s'il n'est pas recruté |
| Balur | Valtordu, puis l'équipe | compagnon si épargné en 108 |
| Mentor | Valtordu, et Gzor pour la fin | guide de la campagne |
| Cultiste de Zargon | remplace le tavernier de Gzor | corruption ≥ 7 : il propose des pactes (or et puissance contre corruption) |
| Spectre du Guide | toutes les tavernes, en vision | après un échec à 109 : réplique d'ambiance menaçante |

## Ton

| PNJ | Voix |
| --- | --- |
| Taverniers | Familiers, bourrus, un peu d'humour (l'héritage Naheulbeuk des villages). Ils tutoient. |
| Mentor | Grave, phrases courtes, vouvoiement |
| Sir Ragnar | Chevaleresque, « Par Sigmar », tient à l'honneur |
| Balur | Théâtral, ironique, menaçant sous la politesse |
| Grak | Orc : phrases cassées, « Grak pas oublier » |
| Visions et esprits | Murmures, phrases inachevées, points de suspension |
