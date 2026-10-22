# Contrat entre l'atlas et ModuleIso.js

`atlas.js` définit `IsoEchelle` (2), `IsoAtlas`, `IsoSols` et `IsoSolsSpeciaux`. Dans `IsoAtlas`, `[x, y, largeur, hauteur(, dx, dy)]` : `x, y` sur `atlas.png`, largeur et hauteur en pixels du plateau. L'image occupe `largeur × IsoEchelle` sur `atlas.png`. Les placements du code reposent sur ces tailles.

| Images | Noms | Taille plateau | Notes |
| --- | --- | --- | --- |
| Sols | `sol0000` … `sol7980` (les 28 de `IsoSols` et `IsoSolsSpeciaux`) | 48 × 24 | losange exact |
| Murs | `mur0`, `mur1` (/, côté gauche) ; `mur2`, `mur3` (\, côté haut) | 24 × 52 | parallélogramme de pente 1/2, face de 40 |
| Portes | `porte0` … `porte11` | 24 × 44 | le jeu utilise `porte0` (/), `porte1` (\), `porte6` et `porte7` (ouvertes) |
| Meubles | `meuble4b` … `meuble5f` (sauf 51, 52) | celle de 1991 | `dx, dy` recopiés de 1991. Les paires sont deux orientations (miroir) |
| Personnages | `<base>-<animation>` | ≈ 24 × 40 au repos | voir plus bas |
| Portraits | `portrait-<type>-<h\|f>` | 32 × 45 | panneau de la vue classique |
| Icônes | `icone-deplacement`, `attaque`, `objet`, `tresor`, `piege`, `fin` et leur `-grise` ; `bottes`, `bras`, `or`, `bouclier` | 16 × 16 | `-grise` = action déjà jouée |

## Personnages

- `<base>` vaut `<type>-<h|f>` pour un héros. Le type vient de la colonne `image` (barbare, nain, elfe, enchanteur), le sexe de `LeMagend[31]`. Pour un monstre, `<base>` est `gobelin`, `orc`, `fimir`, `chaos`, `mage`, `squelette`, `zombie`, `momie` ou `gargouille` (correspondance dans `ISO_MONSTRES`).
- Animations : `repos`, `marche0` à `marche2`, `attaque0` à `attaque2`, `touche`, `mort0` à `mort2`, `dos-repos`, `dos-marche0` à `dos-marche2`.
- `IsoImage` remplace une image absente par la précédente de son animation (`mort2` par `mort1`), puis par `-dos-repos` (pour une animation de dos), puis par `-repos`. On peut donc livrer les planches d'animations une par une.
- De face = vers le bas à gauche de l'écran ; de dos = vers le haut à gauche. Le jeu fait le miroir pour les deux autres diagonales, pour les personnages seulement.
