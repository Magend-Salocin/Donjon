# Concept : animations de la vue isométrique

Statut : en cours. Le barbare (homme et femme) a sa planche d'animations ; le découpage et les animations du moteur sont en place. Les autres personnages gardent leur image de repos en attendant leur planche.

## Objectif

Donner plus de vie à la vue iso ([ModuleIso.js](../public/assets/game/ModuleIso.js)) : des personnages qui marchent d'une case à l'autre, des coups de hache visibles, une réaction quand ils sont touchés, une chute à leur mort. Et rendre les graphismes faciles à refaire, famille par famille, sans reprendre tout l'atlas.

## Ce qui existe

- Un seul atlas, construit par `bin/construire-atlas-iso.py` à partir d'une planche redessinée unique. La zone de chaque sprite (155) est relevée à la main dans `bin/atlas-iso.json`. Une planche régénérée oblige à tout relever à nouveau.
- Héros : 4 images par héros et par sexe (repos, 2 poses d'attaque, de dos). Monstres : 4 poses.
- L'attaque est animée dans le gros plan de combat : 3 images, 150 ms chacune, pendant 1,2 s.
- Les déplacements ne sont pas animés : le personnage saute d'une case à l'autre.

## Proposition

### Des planches séparées, un seul atlas

| Planche | Contenu | Découpage |
| --- | --- | --- |
| Décor | sols, murs, portes, meubles | zones relevées à la main dans `atlas-iso.json` (rarement refait, géométrie précise) |
| Interface | portraits h/f, icônes | grille simple |
| Héros | une planche par type (barbare, nain, elfe, enchanteur), homme et femme | grille stricte, découpage automatique |
| Monstres | 1 ou 2 planches | grille stricte, découpage automatique |

Le script de construction assemble toutes les planches dans un seul `atlas.png` / `atlas.js`. Le jeu continue de charger une seule image, et `ModuleIso.js` ne change pas pour ça. Refaire une famille ne touche pas aux autres.

Pourquoi pas 4 atlas chargés séparément : le seul gain serait un cache par famille. Le coût serait de modifier tout le code de dessin pour savoir dans quel atlas lire chaque image. Même avec toutes les animations, l'ensemble tient dans un atlas de 2048 px.

### Grille stricte pour les personnages

Chaque planche de personnages est une grille fixe : une case par image, des gouttières noires, un fond vert uni (`#00FF00`) et les pieds sur la même ligne dans toutes les cases. C'est la méthode qui a bien marché pour les portraits ([heros-prompt.md](../../Campagne01/01-regles/heros-prompt.md)) :

- le script repère les gouttières, retire le vert et pose chaque image sur la même ligne de pieds ;
- aucune zone à relever à la main ;
- une case ou une rangée ratée se régénère seule.

### Animations

Deux directions sont dessinées : de face (le personnage descend vers le bas à gauche de l'écran) et de dos (il monte vers le haut à gauche). Le miroir donne les deux autres, comme aujourd'hui.

| Animation | Images | Face | Dos | Utilisation |
| --- | --- | --- | --- | --- |
| Repos | 1 | oui | oui | sur le plateau |
| Marche | 3 | oui | oui | déplacement d'une case à l'autre |
| Attaque | 3 | oui | | gros plan du combat |
| Touché | 1 | oui | | gros plan, défenseur qui perd des points de vie |
| Mort | 2 | oui | | gros plan, puis le corps reste un instant sur le plateau |

Héros : 14 images par sexe. Monstres : les mêmes de face (10) ; la marche de dos est un bonus.

Noms dans l'atlas : `<type>-<sexe>-repos`, `-marche0` à `-marche2`, `-attaque0` à `-attaque2`, `-touche`, `-mort0`, `-mort1`, `-dos-repos`, `-dos-marche0` à `-dos-marche2`. Pour les monstres, même schéma sans le sexe (`orc-marche1`…).

### Ce qu'il faut ajouter au moteur

- **Marche animée.** Quand un personnage change de case, le faire glisser de l'ancienne à la nouvelle en environ 250 ms, en enchaînant les 3 images de marche. Les déplacements de plusieurs cases s'enchaînent case par case.
- **Touché et mort.** Les brancher sur le résultat du combat, déjà calculé dans `Iso.Combat` : perte de points de vie ou mort du défenseur.
- **Noms.** `IsoImage` choisit l'image d'une animation et revient à `-dos-repos` ou `-repos` si elle manque, pour pouvoir livrer planche par planche.

## Limites

- **Cohérence d'une image à l'autre.** Un générateur d'images ne garde pas parfaitement un personnage identique d'une case à l'autre (taille, couleurs, arme). À 24 × 40 px, un cycle de 3 images le tolère. Une rangée ratée se régénère seule.
- **Lisibilité.** Une pose doit se lire à petite taille : mouvements amples, silhouette nette, arme bien visible.
- **Prompt et sortie.** Le générateur respecte mal une grille exacte. Le script doit donc repérer les gouttières réelles plutôt que supposer des cases de taille fixe (comme `decouper-heros.py`).

## Étapes

1. Fait : planche test du barbare ([animations-iso/prompt-barbare.md](animations-iso/prompt-barbare.md)), rangée dans `public/assets/game/iso/planches/barbare.png`. À reprendre : la marche de face de la barbare (2e et 3e images presque identiques).
2. Fait : découpage des planches en grille dans `construire-atlas-iso.py` (section `grilles` de `bin/atlas-iso.json`, procédure dans le skill `atlas-iso`).
3. Fait : marche animée, touché et mort dans `ModuleIso.js`. Reste à tester en jeu.
4. Planches du nain, de l'elfe et de l'enchanteur, puis des monstres.
5. Séparer la planche actuelle en planches décor et interface, quand il faudra les refaire.
