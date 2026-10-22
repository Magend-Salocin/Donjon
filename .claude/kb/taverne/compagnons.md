# Mercenaires et compagnons

Notation : voir [mecaniques.md](mecaniques.md). Les codes d'effet (`att+1`, `def+1`…) s'appliquent dans le donjon, après le plafond de dés.

## Règles communes

- L'équipe compte une recrue au plus au début. Une seconde place s'ouvre au grade Aventurier.
- Une recrue ne se voit pas sur le plateau : elle donne ses effets au héros (étape 1 du concept). L'affichage comme allié viendra plus tard.
- Si le héros perd une aventure, un mercenaire part avec son or. Un compagnon perd 1 point de fidélité.
- La fiche du héros affiche l'équipe : nom, portrait, effet, aventures restantes (mercenaire) ou fidélité (compagnon).

## Mercenaires

Ils s'engagent depuis l'écran de recrutement, ouvert par le tavernier (effet `ecran recrutement`). L'écran liste les mercenaires de la taverne, grisés avec la raison quand une condition manque. À réputation Honteux (0-2), aucun ne signe.

| Mercenaire | Taverne | Prix | Contrat | Condition | Effet |
| --- | --- | ---: | --- | --- | --- |
| Garde impérial | Valtordu | 15 or (7 avec la relique 40, gratuit avec la 43) | 1 aventure | réputation ≥ 3 | `def+1` |
| Sœur Ilsa, prêtresse de Sigmar | Valtordu | 20 or | 1 aventure | `corruption ≤ 3` | `corps+2`, `potion` |
| Kurt, arbalétrier | Waldorg | 15 or | 1 aventure | aucune | `att+1` |
| Dorn, tueur de trolls | Gzor | 40 or | 3 aventures | grade Ecuyer | `att+2`. Part s'il survit à 3 aventures, en laissant une potion de force (997) |
| Le Guide | Valtordu | 5 or | 1 aventure | `aventure 108`, `sans guide_traitre` | `depl+2`, mais il trahit à l'aventure 109 (voir plus bas) |
| Guerriers de Grak | Gzor | gratuit | 1 aventure, une seule fois | `grak_allie` | `att+1`, `def+1` |

Chaque mercenaire a une réplique d'engagement, une de départ, et une réplique quand le héros les regarde dans l'équipe.

| Mercenaire | Engagement | Départ |
| --- | --- | --- |
| Garde impérial | « Pour l'Empereur. Et pour la solde. » | « Contrat rempli. Que Sigmar vous garde. » |
| Sœur Ilsa | « Je soigne les corps. Les âmes, c'est votre affaire. » | « Allez en paix. Et lavez-vous, de temps en temps. » |
| Kurt | « Je tire, tu frappes. Si je te touche, c'est que tu étais dans le chemin. » | « Rappelle-moi si t'as d'autres orcs à trouer. » |
| Dorn | « Je cherche une mort glorieuse. Si tu peux m'en trouver une, je suis à toi. » | « Pas encore mort. Décevant. Garde ça. » |
| Guerriers de Grak | « Grak dire : aider toi. Une fois. » | « Dette payée. Maintenant, nous quittes. » |

### Le Guide (piège de l'aventure 109)

Le résumé de l'aventure 109 dit que le guide abandonne les héros dans le noir. Le jeu le fait rencontrer avant, comme un mercenaire bon marché.

#### accueil

> Vous allez vers l'Est ? Je connais chaque pierre de ces montagnes. Cinq pièces, et je vous mène où vous voulez. Raccourcis compris.

1. Marché conclu. [si : or ≥ 5] [effets : or −5, recruter guide] → engage
2. Pourquoi si peu cher ? → doute
3. Non merci. → fin

#### doute

> Les temps sont durs. Et j'aime la compagnie des héros. (Il sourit. Ses dents sont très blanches.)

1. D'accord, viens. [si : or ≥ 5] [effets : or −5, recruter guide] → engage
2. Quelque chose cloche. Non. [effets : drapeau guide_refuse] → fin

#### engage

> Vous ne le regretterez pas. Enfin… pas tout de suite.

1. … → fin

Effet : le Guide reste dans l'équipe jusqu'à l'aventure 109. Au départ de cette aventure, il est retiré et le drapeau `guide_traitre` est posé. Le héros garde `depl+2` pour cette aventure : le Guide l'a quand même mené jusqu'à l'entrée. Avec `guide_refuse`, l'aventure 109 démarre normalement, et la Voix du labyrinthe le mentionne au débriefing : « Vous vous êtes méfiés du guide. Sage. »

## Compagnons

### Sir Ragnar

| | |
| --- | --- |
| Obtention | Débriefing 102, ou plus tard au Cheval bondissant (`ragnar_libre`) |
| Condition | `reputation ≥ 3`, `sans or_magnus_garde` |
| Effet | `def+1`, `bouclier` (annule la première blessure de chaque aventure : « il peut annuler un Bouclier Noir ») |
| Valeurs | Honneur, Empire, Sigmar |
| Sprite iso (étape 2) | « guerrier » |

#### Fidélité (départ 5)

| Choix | Fidélité |
| --- | ---: |
| 104 : rendre l'or | +2 |
| 104 : garder l'or | −3 |
| 104 : en garder une part | −1 |
| 106 : alliance avec Grak | −2 |
| 107 : purifier Wardoz | +1 |
| 108 : prendre le grimoire de Balur | −1 |
| 111 : prévenir Altdorf | +2 |
| 111 : vendre l'information | −2 |
| Pacte du cultiste | −5 |
| Aventure perdue | −1 |

Ces effets s'ajoutent aux réponses correspondantes dans [dialogues-campagne.md](dialogues-campagne.md) et [dialogues-taverniers.md](dialogues-taverniers.md). L'effet `fidelite` n'a aucun effet si le compagnon n'est pas dans l'équipe.

#### pnj : ragnar, à la taverne, hors équipe

Présence : `ragnar_libre`, sans `compagnon ragnar`.

#### accueil

> Héros ! L'Empire a besoin d'épées. La mienne est à vous, si votre cause est juste.

1. Rejoignez-moi, Sir Ragnar. [si : reputation ≥ 3, sans or_magnus_garde] [effets : recruter ragnar] → rejoint
2. Pas pour l'instant. → fin

Si `or_magnus_garde` : « Vous avez volé l'Empereur. Je ne marcherai pas à vos côtés. » (réponse 1 absente)

#### rejoint

> Par Sigmar, en route ! Et gardez vos mains loin de l'or des autres.

1. En route. → fin

#### pnj : ragnar, dans l'équipe

Quand le héros parle à Ragnar depuis sa fiche, la réplique change avec la fidélité.

> **Fidélité ≥ 8** : Je n'ai jamais combattu aux côtés d'un héros aussi droit. C'est un honneur.
> **Fidélité 3 à 7** : Nous tenons bon. Mais je vous observe, ami. Ne me décevez pas.
> **Fidélité 1 ou 2** : Je commence à douter de notre cause. Encore un faux pas, et je rentre à Altdorf.

1. Je ne vous décevrai pas. → fin

#### depart (fidélité 0)

> Je vous ai suivi par loyauté. Vous l'avez gaspillée. Je rentre à Altdorf. Ne m'y cherchez pas.

1. … [effets : renvoyer ragnar, effacer ragnar_libre, reputation −1] → fin

### Balur

| | |
| --- | --- |
| Obtention | `balur_epargne` (débriefing 108). Il apparaît au Rat fumant après l'aventure 109. |
| Condition | aucune : c'est lui qui choisit |
| Effet | `att+2`. Corruption +1 à la fin de chaque aventure, réussie ou non. |
| Valeurs | Puissance, feu, mépris de l'Empire |
| Fidélité | Elle monte de 1 à chaque gain de corruption et baisse de 2 à chaque gain de réputation ≥ 2. |
| Trahison | Si la corruption atteint 7, il quitte l'équipe au retour d'aventure. L'aventure suivante gagne un Sorcier (monstre 19) : c'est Balur. |
| Sprite iso (étape 2) | « magicien » |

Ragnar et Balur ne peuvent pas être dans l'équipe ensemble. Ragnar refuse : « Lui ou moi. »

#### pnj : balur, à la taverne

Présence : `balur_epargne`, `aventure 109`, sans `compagnon balur`.

#### accueil

> (Une chope s'embrase toute seule à votre table.) Vous m'avez épargné. Je déteste avoir des dettes. Je vous offre mon feu, quelque temps.

1. Ton feu, contre quoi ? → prix
2. Tu as brûlé des villages. Va-t'en. [effets : reputation +1, drapeau fini_balur] → fin

#### prix

> Contre rien. Le feu prend ce qu'il veut, quand il veut. Vous le sentirez à peine.

1. J'accepte. [si : sans-compagnon] [effets : recruter balur] → rejoint
2. Je préfère garder mon âme. → fin

#### rejoint

> Excellent. Que les orcs brûlent, et les autres aussi, s'il le faut.

1. Seulement les orcs. → fin

#### trahison (corruption ≥ 7)

> Le feu a choisi son camp, héros. Et ce n'est pas le vôtre. Nous nous reverrons, et cette fois je ne serai pas aussi clément.

1. … [effets : renvoyer balur, drapeau balur_traitre, bonus ennemi-balur] → fin

### Melar (réservé)

Melar libéré dit, dans la campagne, « trouvez-moi à Altdorf ». Il ne sera recrutable que si l'aventure 105 entre en jeu. Effet prévu : `pieges`, `corps+1`. Sprite iso : « magicien ».

Les codes propres aux compagnons (`bouclier`, `ennemi-balur`) sont décrits avec les autres bonus dans [mecaniques.md](mecaniques.md).
