---
name: atlas-iso
description: Refaire l'atlas de la vue isométrique du donjon (donjon-v2/public/assets/game/iso/atlas.png et atlas.js) à partir d'une planche de sprites redessinée sur fond noir. À utiliser quand l'utilisateur fournit une nouvelle planche iso, veut remplacer, ajouter ou recadrer un sprite de la vue 3D ou classique (sol, mur, porte, meuble, héros, monstre, portrait, icône), ou signale un sprite mal découpé.
---

# Atlas de la vue isométrique

La vue iso (`public/assets/game/ModuleIso.js`) dessine tout depuis une seule image, `iso/atlas.png`, décrite par `iso/atlas.js`. L'atlas est construit à partir d'une planche redessinée (fond noir, sprites rangés à la main) par `bin/construire-atlas-iso.py`, qui lit la zone de chaque sprite dans `bin/atlas-iso.json`.

Toutes les commandes se lancent depuis `donjon-v2/`.

| Fichier | Rôle |
| --- | --- |
| `bin/atlas-iso.json` | chemin de la planche (`planche`), échelle, zone de chaque sprite sur la planche, sols des zones |
| `bin/construire-atlas-iso.py` | découpe, détoure, met à l'échelle, écrit `atlas.png` et `atlas.js` |
| `public/assets/game/iso/1991/` | atlas d'origine (`bin/extract-heroquest-graphics.py`) : référence des tailles et orientations |
| `.claude/skills/atlas-iso/outils.py` | repérage des sprites, planche nommée de 1991, scène de test |

## Contrat avec ModuleIso.js

`atlas.js` définit `IsoEchelle` (2), `IsoAtlas`, `IsoSols` et `IsoSolsSpeciaux`. Dans `IsoAtlas`, `[x, y, largeur, hauteur(, dx, dy)]` : `x, y` sur `atlas.png`, largeur et hauteur en pixels du plateau. L'image occupe `largeur × IsoEchelle` sur `atlas.png`. Les placements du code reposent sur ces tailles. Ne pas les changer pour les sols, murs, portes et meubles.

| Images | Noms | Taille plateau | Notes |
| --- | --- | --- | --- |
| Sols | `sol0000` … `sol7980` (les 28 de `IsoSols` et `IsoSolsSpeciaux`) | 48 × 24 | losange exact |
| Murs | `mur0`, `mur1` (/, côté gauche) ; `mur2`, `mur3` (\, côté haut) | 24 × 52 | parallélogramme de pente 1/2, face de 40 |
| Portes | `porte0` … `porte11` | 24 × 44 | le jeu utilise `porte0` (/), `porte1` (\), `porte6` et `porte7` (ouvertes) |
| Meubles | `meuble4b` … `meuble5f` (sauf 51, 52) | celle de 1991 | `dx, dy` recopiés de 1991. Les paires sont deux orientations (miroir) |
| Héros | `<type>-<h\|f>0` repos, `1` et `2` attaque, `<type>-<h\|f>-dos` | ≈ 24 × 40 | type = colonne `image` (barbare, nain, elfe, enchanteur), sexe = `LeMagend[31]` |
| Monstres | `gobelin`, `orc`, `fimir`, `chaos`, `mage`, `squelette`, `zombie`, `momie`, `gargouille` + `0` à `3` | proportionnelle | `0` au repos, `0` à `3` animation d'attaque. Correspondance dans `ISO_MONSTRES` |
| Portraits | `portrait-<type>-<h\|f>` | 32 × 45 | panneau de la vue classique |
| Icônes | `icone-deplacement`, `attaque`, `objet`, `tresor`, `piege`, `fin` et leur `-grise` ; `bottes`, `bras`, `or`, `bouclier` | 16 × 16 | `-grise` = action déjà jouée |

Le jeu ne dessine un sprite miroir que pour les personnages (direction de marche). Les meubles et les portes doivent exister dans leurs deux orientations.

## Procédure

1. **Ranger la planche.** La garder telle quelle (PNG, fond noir) et noter son chemin dans `"planche"` de `bin/atlas-iso.json`. Les zones n'ont de sens que pour cette image : une planche régénérée, même proche, demande de refaire les zones.

2. **Repérer les sprites.**
   ```
   python ../.claude/skills/atlas-iso/outils.py reperer <planche.png> <dossier>
   ```
   Ouvrir `<dossier>/reperes.png`. Les boîtes sont un point de départ, à vérifier une par une :
   - des sprites voisins collés par une ombre ou un halo (sols empilés, deux cheminées, icônes) sont dans une seule boîte : la redécouper à la main ;
   - un morceau détaché (lame, flèche) peut manquer : élargir la boîte ;
   - un sprite peut être absorbé par la boîte d'un grand voisin (un personnage sous une cheminée).

3. **Identifier chaque sprite.** Comparer avec la référence de 1991 :
   ```
   python ../.claude/skills/atlas-iso/outils.py reference <sortie.png>
   ```
   Une planche redessinée ne reprend ni le nombre ni l'ordre des images de 1991. Pour chaque nom du contrat, choisir le sprite le plus proche (silhouette, couleurs, orientation). Les extras restent inutilisés. Si un sprite manque, réutiliser un voisin (miroir, autre pose) plutôt que de laisser un trou. Quand le choix change le rendu du jeu (quel dessin pour quel héros ou quel sexe), demander à l'utilisateur.

4. **Remplir `bin/atlas-iso.json`.** Un groupe par famille, avec son `cadrage` et sa `taille` ; une entrée par sprite : `[x, y, largeur, hauteur]`, ou un objet `{"zone": …, "miroir": true, "gris": true, "taille": …, "decalage": …, "marge": …}`.

   | Cadrage | Pour | Effet |
   | --- | --- | --- |
   | `losange` | sols | garde le dessus de la dalle (hauteur = largeur / 2), sans son épaisseur |
   | `mur` | murs | `coins` (haut gauche, bas gauche, bas droit, haut droit) de la face sur la planche, `pente` `monte` (/) ou `descend` (\) : face redressée puis posée sur le parallélogramme de 1991 |
   | `etire` | portes | étirée à la taille exacte |
   | `contenir` | meubles, portraits, icônes | réduite dans la taille, posée en bas et centrée |
   | `reduction` | héros, monstres | taille de la planche ÷ `reduction` : garde les tailles relatives (nain plus petit que le barbare) |

   Choisir `reduction` pour que les héros fassent environ 40 px de haut (1,875 pour une planche à environ 75 px par héros).

5. **Construire.**
   ```
   python bin/construire-atlas-iso.py <controle.png>
   ```
   Environ une minute. Le résultat est identique à chaque lancement.

6. **Vérifier.**
   - `<controle.png>` : chaque sprite sous son nom. Chercher les morceaux de voisins, les bords noirs, les orientations inversées.
   - Scène de test, avec les formules de placement de `ModuleIso.js` :
     ```
     python ../.claude/skills/atlas-iso/outils.py scene <sortie.png>
     ```
     Les murs doivent se raccorder sans couture noire ; les portes doivent suivre les murs ; les pieds des personnages doivent être au centre de leur dalle.
   - Tous les noms du contrat présents : voir le contrôle plus bas.
   - Dans le jeu : une quête des cartes 101 à 124, vues 3D et classique, un combat (gros plan × 3).

## Pièges

- **Le fond n'est pas noir pur.** Les planches générées ont un halo sombre (valeurs 30 à 45) autour des sprites. `FOND` (34) et `SEUIL` (45) en tiennent compte. Un pixel enfermé reste opaque, sauf s'il est presque noir (`NOIR_ENFERME`).
- **Les morceaux de voisins.** Une pointe de dalle ou d'arme qui entre dans une zone est retirée si elle est détachée et petite (`MORCEAU`). Sinon, resserrer la zone, ou mettre `"marge": 0` si deux sprites se touchent.
- **Les murs.** Ne pas les étirer : leur pente sur la planche n'est jamais exactement 1/2, et l'étirement laisse des coutures noires entre les pans. Relever les 4 coins sur une vue agrandie avec une grille, sous les créneaux, pas sur les pierres qui dépassent.
- **L'orientation.** Une paire de 1991 (`meuble4f` / `meuble50`…) est un miroir. Vérifier quel dessin de la planche correspond à chaque nom ; s'il n'y en a qu'un, `"miroir": true` donne l'autre.
- **Les icônes grisées absentes.** `"gris": true` les fabrique à partir de l'icône en couleur.
- **`bin/extract-heroquest-graphics.py` n'écrit que dans `iso/1991/`.** `iso/livre.png` (fond de la vue classique) est retouché à la main : ne pas l'écraser.
- **Nouveau nom dans le code.** Ajouter le sprite dans `atlas-iso.json`, puis l'utiliser dans `ModuleIso.js` (`ISO_MONSTRES`, `IsoNomHeros`…). `IsoNomHeros` retombe sur `barbare-h` si un type n'a pas d'image.

## Contrôle des noms

```
node -e "eval(require('fs').readFileSync('public/assets/game/iso/atlas.js','utf8')+';global.A=IsoAtlas;global.S=IsoSols.concat(Object.values(IsoSolsSpeciaux))');const m=[];const v=n=>A[n]||m.push(n);for(const t of ['barbare','nain','elfe','enchanteur'])for(const s of ['h','f']){['0','1','2','-dos'].forEach(f=>v(t+'-'+s+f));v('portrait-'+t+'-'+s)}for(const n of ['gobelin','orc','fimir','chaos','mage','squelette','zombie','momie','gargouille'])for(let i=0;i<4;i++)v(n+i);for(const i of ['deplacement','attaque','objet','tresor','piege','fin'])v('icone-'+i),v('icone-'+i+'-grise');['bottes','bras','or','bouclier'].forEach(i=>v('icone-'+i));S.forEach(v);for(let i=0;i<4;i++)v('mur'+i);for(let i=0;i<12;i++)v('porte'+i);for(let c=0x4b;c<0x60;c++)if(c!=0x51&&c!=0x52)v('meuble'+c.toString(16));console.log(m.length?'manquants : '+m:'complet')"
```
