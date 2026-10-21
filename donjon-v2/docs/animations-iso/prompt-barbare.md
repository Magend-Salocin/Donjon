# Planche d'animations : le barbare

Planche test du [concept des animations iso](../concept-animations-iso.md). Elle doit montrer si le générateur d'images garde le même personnage d'une case à l'autre et si les poses se lisent à la taille du plateau (24 × 40 px).

## Disposition

Une planche de 1536 × 1024, 7 colonnes × 4 rangées, soit 28 cases d'environ 219 × 256. Gouttières noires, fond vert uni (`#00FF00`) que le script de découpe retire.

| Rangée | 1 | 2 | 3 | 4 | 5 | 6 | 7 |
| --- | --- | --- | --- | --- | --- | --- | --- |
| 1, barbare | repos | marche 1 | marche 2 | marche 3 | attaque 1 | attaque 2 | attaque 3 |
| 2, barbare | touché | mort 1 | mort 2 | dos repos | dos marche 1 | dos marche 2 | dos marche 3 |
| 3, barbare femme | repos | marche 1 | marche 2 | marche 3 | attaque 1 | attaque 2 | attaque 3 |
| 4, barbare femme | touché | mort 1 | mort 2 | dos repos | dos marche 1 | dos marche 2 | dos marche 3 |

Direction, imposée par `ModuleIso.js` (le jeu fait le miroir pour les deux autres) :

- de face : le personnage regarde et avance vers le bas à gauche de l'image ;
- de dos : il tourne le dos et avance vers le haut à gauche.

Contraintes pour que la découpe et l'animation marchent :

- **Même échelle et même ligne de pieds dans toutes les cases.** Sinon le personnage grandit ou saute pendant la marche.
- **Le personnage entier dans sa case, arme comprise**, hache levée incluse. Rien ne déborde sur la gouttière.
- **Pas d'ombre au sol, pas de décor**, pas de vert vif sur le personnage.
- **Poses amples.** À 24 × 40 px, seuls les grands mouvements se lisent : jambes bien écartées en marche, hache très haute puis très basse.

## Images de référence

Joindre [reference-barbare.png](reference-barbare.png) : à gauche, les sprites iso actuels (barbare au repos, en attaque, de dos ; barbare femme), à droite les portraits du site. Le design doit rester le même : la planche remplace des sprites déjà en jeu.

## Prompt

Le prompt est en anglais : les modèles d'image le suivent mieux.

```
A sprite sheet for an isometric dungeon game, 1536x1024 canvas, arranged in a strict grid of 7 columns and 4 rows (28 equal cells, each about 219x256 pixels). Cells are separated by thin straight pure black gutters. Every cell has a plain flat solid pure green (#00FF00) background: no gradient, no floor, no cast shadow, no scenery. No text, no letters, no numbers, no frame labels, no watermark.

Style: detailed 16-bit era pixel art, like a polished 1990s Amiga or DOS isometric dungeon crawler sprite, crisp dark outline, warm torchlight from the upper left, muted palette of leather brown, tanned skin, iron grey and ember orange. Isometric three-quarter top-down view, camera about 30 degrees above the ground. Match the attached reference sprites and portraits exactly: same character design, proportions and colors.

Strict animation rules: the same character at exactly the same scale in every cell of a row pair. The feet always rest on the same invisible ground line, about 12 percent above the bottom of each cell. The whole character, weapon included, stays inside its cell. Large, clear movements that read at very small size.

"Front" means the character faces and moves toward the lower-left corner of the image. "Back" means the character is seen from behind, moving toward the upper-left corner.

Rows 1 and 2, male barbarian: huge muscular man, long wild dark hair and beard, bare chest crossed with leather straps, fur shoulder pads, belt with a skull buckle, leather loincloth, fur-wrapped boots, a great double-bladed battle axe held in both hands.
Row 1, left to right:
1. Idle, front: standing, axe held low in front of him.
2. Walk 1, front: left leg forward, right arm swinging forward.
3. Walk 2, front: legs passing, body slightly raised.
4. Walk 3, front: right leg forward, left arm swinging forward.
5. Attack 1, front: wind-up, axe raised high behind his head with both hands.
6. Attack 2, front: mid-swing, axe sweeping down at shoulder height, body twisted.
7. Attack 3, front: follow-through, axe low in front near the ground, leaning forward.
Row 2, left to right:
1. Hit, front: recoiling backwards, head thrown back, arms open, axe held loosely.
2. Death 1, front: falling to his knees, axe slipping from his hands.
3. Death 2: lying flat on his back on the ground, axe beside him.
4. Idle, back: standing seen from behind, axe on his shoulder.
5. Walk 1, back: left leg forward.
6. Walk 2, back: legs passing.
7. Walk 3, back: right leg forward.

Rows 3 and 4, female barbarian: tall athletic warrior woman, long wavy auburn hair with small braids, leather and grey scale armor, fur-lined cloak, a round iron-rimmed wooden shield on her left arm, a broadsword in her right hand.
Row 3, left to right:
1. Idle, front: standing, shield in front, sword held low.
2. Walk 1, front: left leg forward.
3. Walk 2, front: legs passing, body slightly raised.
4. Walk 3, front: right leg forward.
5. Attack 1, front: wind-up, sword raised high above her shoulder, shield forward.
6. Attack 2, front: mid-slash, sword sweeping across at chest height.
7. Attack 3, front: follow-through, sword low on the opposite side, leaning forward behind the shield.
Row 4, left to right:
1. Hit, front: recoiling behind her shield, staggering backwards.
2. Death 1, front: falling to her knees, sword dropping.
3. Death 2: lying flat on her back on the ground, shield and sword beside her.
4. Idle, back: standing seen from behind, shield on her back, sword at her side.
5. Walk 1, back: left leg forward.
6. Walk 2, back: legs passing.
7. Walk 3, back: right leg forward.
```

## Ce qu'on juge sur le résultat

- **Cohérence :** même visage, mêmes couleurs, même arme, même taille dans les 14 cases de chaque personnage.
- **Lisibilité :** réduire une case à 24 × 40 px (ou regarder la planche de loin). Marche, attaque et chute doivent se reconnaître.
- **Grille :** gouttières bien droites, aucun personnage qui déborde, pieds alignés.
- **Direction :** les cases de face vont bien vers le bas à gauche, celles de dos vers le haut à gauche.

Si une rangée est ratée, la régénérer seule : remplacer le premier paragraphe par une grille de 7 colonnes × 1 rangée (1536 × 256 environ), garder le style et les règles, et ne donner que la description de cette rangée.
