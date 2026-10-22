# Planches d'animations : le barbare, 4 directions

Deuxième version du [concept des animations iso](../concept-animations-iso.md). La première planche donnait des sprites presque de face : retournés en miroir, ils semblaient se replacer au lieu d'avancer. Ici, chaque direction est un vrai trois-quarts sur sa diagonale.

Résultat pour le barbare homme (`iso/planches/barbare-h-deplacements.png`, `barbare-h-combat.png`) : le générateur a dessiné les rangées 1 et 2 toutes deux vers le bas à droite. On garde la rangée 1 (bas-droite) et la rangée 3 (haut-gauche), le miroir donne les deux autres : sur un vrai trois-quarts, il ne se voit pas. Demander les 4 rangées reste utile, le générateur dessine mieux une direction quand il voit les autres.

## Directions

Le plateau est en isométrie 2:1 : un personnage se déplace toujours selon une diagonale de l'écran.

| Code | Vers | Vue | Déplacement sur le plateau |
| --- | --- | --- | --- |
| `so` | bas à gauche | trois-quarts face | case + 26 |
| `se` | bas à droite | trois-quarts face | case + 1 |
| `no` | haut à gauche | trois-quarts dos | case - 1 |
| `ne` | haut à droite | trois-quarts dos | case - 26 |

En combat (gros plan), le héros est en haut à gauche et le monstre en bas à droite : le héros regarde `se`, le monstre `no`.

## Planches

Deux planches par personnage et par sexe, soit 4 générations pour le barbare. Une seule personne par planche : le générateur garde mieux le même personnage.

**Déplacements**, 1024 × 1024, 4 × 4 cases de 256 × 256 :

| Rangée | 1 | 2 | 3 | 4 |
| --- | --- | --- | --- | --- |
| 1, `so` | repos | marche 1 | marche 2 | marche 3 |
| 2, `se` | repos | marche 1 | marche 2 | marche 3 |
| 3, `no` | repos | marche 1 | marche 2 | marche 3 |
| 4, `ne` | repos | marche 1 | marche 2 | marche 3 |

**Combat**, 1536 × 1024, 4 × 2 cases de 384 × 512, tout en `se` :

| Rangée | 1 | 2 | 3 | 4 |
| --- | --- | --- | --- | --- |
| 1 | repos | attaque 1 | attaque 2 | attaque 3 |
| 2 | touché | mort 1 | mort 2 | mort 3 |

Le repos de la planche combat sert seulement d'échelle au découpage (même hauteur que le repos `se` des déplacements) ; il n'entre pas dans l'atlas.

Noms dans l'atlas : `barbare-h-so-repos`, `barbare-h-so-marche0` à `-marche2`, idem pour `se`, `no`, `ne` ; `barbare-h-attaque0` à `-attaque2`, `-touche`, `-mort0` à `-mort2`.

## Ordre de génération

1. Déplacements de l'homme, avec [reference-barbare.png](reference-barbare.png) en pièce jointe.
2. Combat de l'homme, avec en pièce jointe la planche de déplacements obtenue (cohérence du design et de l'échelle).
3. Puis 1 et 2 pour la femme.

Une rangée ratée se régénère seule : grille de 4 colonnes × 1 rangée (1024 × 256), la planche réussie en pièce jointe, même prompt réduit à cette rangée.

## Prompt : déplacements

Remplacer `[PERSONNAGE]` par le bloc du personnage (plus bas). Le prompt est en anglais : les modèles d'image le suivent mieux.

```
A sprite sheet for an isometric dungeon game, 1024x1024 canvas, arranged in a strict grid of 4 columns and 4 rows (16 equal square cells of 256x256 pixels). Cells are separated by thin straight pure black gutters. Every cell has a plain flat solid pure green (#00FF00) background: no gradient, no floor, no cast shadow, no scenery. No text, no letters, no numbers, no arrows, no labels, no watermark.

Style: detailed 16-bit era pixel art, like a polished 1990s Amiga or DOS isometric dungeon crawler sprite, crisp dark outline, warm torchlight from the upper left, muted palette. Match the attached reference exactly: same character design, proportions and colors.

Camera: classic 2:1 isometric game view, seen from about 30 degrees above the ground. The character never faces the camera straight on and never shows a pure side profile: every pose is a clear three-quarter view along one of the four screen diagonals.

[PERSONNAGE]

Strict rules: the same character at exactly the same scale in all 16 cells, about 190 pixels tall when standing. The feet always rest on the same invisible ground line, about 20 pixels above the bottom of each cell, and the character stays horizontally centered in the cell. The whole character, weapon included, stays inside its cell. Large, clear leg movements that read at very small size. Each row is a different facing direction; do not mirror one row to make another, the equipment stays on the same hands in every row.

Columns, identical in every row:
1. Idle: standing still, feet together.
2. Walk 1: left leg stepping far forward, right leg behind.
3. Walk 2: legs passing each other, body slightly raised.
4. Walk 3: right leg stepping far forward, left leg behind.

Rows:
Row 1: three-quarter FRONT view, facing and walking toward the LOWER-LEFT corner of the image. We see the face and chest, the body turned toward the left.
Row 2: three-quarter FRONT view, facing and walking toward the LOWER-RIGHT corner of the image. We see the face and chest, the body turned toward the right.
Row 3: three-quarter BACK view, walking away toward the UPPER-LEFT corner of the image. We see the back and a little of the left side of the face.
Row 4: three-quarter BACK view, walking away toward the UPPER-RIGHT corner of the image. We see the back and a little of the right side of the face.
```

## Prompt : combat

Joindre la planche de déplacements réussie.

```
A sprite sheet for an isometric dungeon game, 1536x1024 canvas, arranged in a strict grid of 4 columns and 2 rows (8 equal cells of 384x512 pixels). Cells are separated by thin straight pure black gutters. Every cell has a plain flat solid pure green (#00FF00) background: no gradient, no floor, no cast shadow, no scenery. No text, no letters, no numbers, no arrows, no labels, no watermark.

Style: detailed 16-bit era pixel art, like a polished 1990s Amiga or DOS isometric dungeon crawler sprite, crisp dark outline, warm torchlight from the upper left, muted palette. Exactly the same character as in the attached sprite sheet: same design, colors and proportions.

Camera: classic 2:1 isometric game view, seen from about 30 degrees above the ground. In every cell the character is in three-quarter FRONT view, facing an enemy toward the LOWER-RIGHT corner of the image (like row 2 of the attached sheet).

[PERSONNAGE]

Strict rules: the same character at exactly the same scale in all 8 cells, about 300 pixels tall when standing. The feet always rest on the same invisible ground line, about 40 pixels above the bottom of each cell. The whole character, weapon included, stays inside its cell, even with the weapon raised high. Large, clear movements that read at very small size.

Row 1, left to right:
1. Idle: standing ready, facing the lower right.
2. Attack 1: wind-up, weapon raised high behind the head.
3. Attack 2: mid-swing, weapon sweeping down toward the lower right, body twisted.
4. Attack 3: follow-through, weapon low near the ground toward the lower right, leaning forward.
Row 2, left to right:
1. Hit: recoiling backwards toward the upper left, head thrown back, arms open.
2. Death 1: falling to the knees, weapon slipping.
3. Death 2: collapsing sideways, one hand on the ground.
4. Death 3: lying flat on the back on the ground, weapon beside the body, the whole body inside the cell.
```

## Blocs des personnages

Barbare homme :

```
Character: male barbarian, huge muscular man, long wild dark hair and beard, bare chest crossed with leather straps, fur shoulder pads, belt with a skull buckle, leather loincloth, fur-wrapped boots, a great double-bladed battle axe held in both hands. The axe head is always on his right side: on the left of the image in the front views, on the right of the image in the back views.
```

Barbare femme :

```
Character: female barbarian, tall athletic warrior woman, long wavy auburn hair with small braids, leather and grey scale armor, fur-lined cloak, a round iron-rimmed wooden shield always on her LEFT arm, a broadsword always in her RIGHT hand. In the front views the shield is on the right of the image and the sword on the left; in the back views the shield is on the left of the image and the sword on the right.
```

## Ce qu'on juge sur le résultat

- **Directions :** chaque rangée suit bien sa diagonale ; en réduisant une case à 40 px de haut, on doit deviner la direction sans hésiter.
- **Mains :** l'arme et le bouclier ne changent pas de main d'une rangée à l'autre.
- **Cohérence :** même visage, mêmes couleurs, même taille dans toutes les cases ; pieds sur la même ligne.
- **Marche :** les cases 2 et 4 ont les jambes bien écartées et différentes l'une de l'autre.
