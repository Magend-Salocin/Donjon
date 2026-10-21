---
name: atlas-iso
description: Refaire l'atlas de la vue isométrique du donjon (donjon-v2/public/assets/game/iso/atlas.png et atlas.js) à partir de planches de sprites redessinées : planche du décor sur fond noir, planches d'animations des personnages en grille sur fond vert. À utiliser quand l'utilisateur fournit une nouvelle planche iso ou d'animations, veut écrire le prompt d'une planche, remplacer, ajouter ou recadrer un sprite de la vue 3D ou classique (sol, mur, porte, meuble, héros, monstre, portrait, icône, animation), ou signale un sprite mal découpé.
---

# Atlas de la vue isométrique

La vue iso (`public/assets/game/ModuleIso.js`) dessine tout depuis une seule image, `iso/atlas.png`, décrite par `iso/atlas.js`. `bin/construire-atlas-iso.py` construit l'atlas à partir de deux sortes de planches, déclarées dans `bin/atlas-iso.json` :

| Planche | Clé du JSON | Fond | Découpage |
| --- | --- | --- | --- |
| Décor et sprites fixes (sols, murs, portes, meubles, portraits, icônes, héros et monstres sans animations) | `planche`, `groupes` | noir | une zone relevée à la main par sprite |
| Animations d'un ou deux personnages (`iso/planches/*.png`) | `grilles` | vert `#00FF00`, gouttières noires | automatique, case par case |

Les animations, leurs noms et les étapes sont décrits dans `docs/concept-animations-iso.md`. Le prompt modèle d'une planche d'animations est `docs/animations-iso/prompt-barbare.md`.

Toutes les commandes se lancent depuis `donjon-v2/`.

| Fichier | Rôle |
| --- | --- |
| `bin/atlas-iso.json` | planche du décor et zones, planches d'animations, échelle, sols des zones |
| `bin/construire-atlas-iso.py` | découpe, détoure, met à l'échelle, écrit `atlas.png` et `atlas.js` |
| `public/assets/game/iso/planches/` | planches d'animations |
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
| Personnages | `<base>-<animation>` | ≈ 24 × 40 au repos | voir plus bas |
| Portraits | `portrait-<type>-<h\|f>` | 32 × 45 | panneau de la vue classique |
| Icônes | `icone-deplacement`, `attaque`, `objet`, `tresor`, `piege`, `fin` et leur `-grise` ; `bottes`, `bras`, `or`, `bouclier` | 16 × 16 | `-grise` = action déjà jouée |

Personnages :

- `<base>` vaut `<type>-<h|f>` pour un héros. Le type vient de la colonne `image` (barbare, nain, elfe, enchanteur), le sexe de `LeMagend[31]`. Pour un monstre, `<base>` est `gobelin`, `orc`, `fimir`, `chaos`, `mage`, `squelette`, `zombie`, `momie` ou `gargouille` (correspondance dans `ISO_MONSTRES`).
- Animations : `repos`, `marche0` à `marche2`, `attaque0` à `attaque2`, `touche`, `mort0`, `mort1`, `dos-repos`, `dos-marche0` à `dos-marche2` (liste `ANIMATIONS` du script).
- Seul `<base>-repos` est obligatoire. `IsoImage` remplace une image absente par `-dos-repos` (pour une animation de dos), puis par `-repos`. On peut donc livrer les planches d'animations une par une.
- De face = vers le bas à gauche de l'écran ; de dos = vers le haut à gauche. Le jeu fait le miroir pour les deux autres diagonales. Il ne fait de miroir que pour les personnages : les meubles et les portes doivent exister dans leurs deux orientations.

## Planche d'animations (grille)

1. **Prompt.** Partir de `docs/animations-iso/prompt-barbare.md` : 7 colonnes × 4 rangées, 14 cases par personnage, dans l'ordre de `ANIMATIONS`, rangée après rangée. Décrire le personnage à partir de son portrait (`public/assets/img/personnages/<type>-<sexe>.png`) et joindre ses sprites actuels en référence.
2. **Juger la planche** avant de l'intégrer :
   - même personnage dans toutes ses cases ;
   - poses lisibles à 24 × 40 px : réduire chaque case à cette taille et regarder ;
   - direction de face et de dos ;
   - aucun débordement sur les gouttières.

   Une rangée ratée se régénère seule (voir la fin du prompt modèle).
3. **Déclarer** dans `grilles` : `{"planche": "public/assets/game/iso/planches/<nom>.png", "personnages": {"<base>": <hauteur au repos>, ...}}`, les personnages dans l'ordre de la planche. Les hauteurs règlent les tailles relatives : 40 pour un grand héros, 38 pour un plus petit, environ 34 pour un nain. Retirer de `groupes` les images que la grille fournit : le script refuse les noms en double.
4. **Construire et vérifier** (voir plus bas). Le script s'arrête si le nombre de cases trouvées n'est pas 14 par personnage.

Ce que fait le script :
- il repère les gouttières réelles (les cases d'une planche générée ne sont jamais égales) ;
- il retire le vert comme pour les portraits (`detourer` de `bin/decouper-heros.py`) ;
- il réduit toutes les images d'un personnage dans le rapport de son repos ;
- il centre chaque image sur les pieds, pour que le personnage ne glisse pas quand son arme part d'un côté.

## Planche du décor (zones)

1. **Ranger la planche.** La garder telle quelle (PNG, fond noir) et noter son chemin dans `"planche"`. Les zones n'ont de sens que pour cette image : une planche régénérée, même proche, demande de refaire les zones.

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

4. **Remplir `groupes`.** Un groupe par famille, avec son `cadrage` et sa `taille` ; une entrée par sprite : `[x, y, largeur, hauteur]`, ou un objet `{"zone": …, "miroir": true, "gris": true, "taille": …, "decalage": …, "marge": …}`.

   | Cadrage | Pour | Effet |
   | --- | --- | --- |
   | `losange` | sols | garde le dessus de la dalle (hauteur = largeur / 2), sans son épaisseur |
   | `mur` | murs | `coins` (haut gauche, bas gauche, bas droit, haut droit) de la face sur la planche, `pente` `monte` (/) ou `descend` (\) : face redressée puis posée sur le parallélogramme de 1991 |
   | `etire` | portes | étirée à la taille exacte |
   | `contenir` | meubles, portraits, icônes | réduite dans la taille, posée en bas et centrée |
   | `reduction` | héros, monstres sans planche d'animations | taille de la planche ÷ `reduction` : garde les tailles relatives |

   Choisir `reduction` pour que les héros fassent environ 40 px de haut (1,875 pour une planche à environ 75 px par héros).

## Construire et vérifier

```
python bin/construire-atlas-iso.py <controle.png>
```

Environ une minute. Le résultat est identique à chaque lancement.

- `<controle.png>` : chaque image sous son nom. Chercher les morceaux de voisins, les bords noirs ou verts, les orientations inversées, les tailles qui sautent d'une image à l'autre d'un même personnage.
- Scène de test, avec les formules de placement de `ModuleIso.js` :
  ```
  python ../.claude/skills/atlas-iso/outils.py scene <sortie.png>
  ```
  Les murs doivent se raccorder sans couture noire ; les portes doivent suivre les murs ; les pieds des personnages doivent être au centre de leur dalle.
- Noms obligatoires présents : voir le contrôle plus bas.
- Dans le jeu : une quête des cartes 101 à 124, vues 3D et classique. Marcher dans les 4 directions, et faire un combat (gros plan × 3 : frappe, touché, mort).

## Pièges

- **Le fond de la planche du décor n'est pas noir pur.** Les planches générées ont un halo sombre (valeurs 30 à 45) autour des sprites. `FOND` (34) et `SEUIL` (45) en tiennent compte. Un pixel enfermé reste opaque, sauf s'il est presque noir (`NOIR_ENFERME`).
- **Les morceaux de voisins.** Une pointe de dalle ou d'arme qui entre dans une zone est retirée si elle est détachée et petite (`MORCEAU`). Sinon, resserrer la zone, ou mettre `"marge": 0` si deux sprites se touchent.
- **Les murs.** Ne pas les étirer : leur pente sur la planche n'est jamais exactement 1/2, et l'étirement laisse des coutures noires entre les pans. Relever les 4 coins sur une vue agrandie avec une grille, sous les créneaux, pas sur les pierres qui dépassent.
- **L'orientation.** Une paire de 1991 (`meuble4f` / `meuble50`…) est un miroir. Vérifier quel dessin de la planche correspond à chaque nom ; s'il n'y en a qu'un, `"miroir": true` donne l'autre.
- **Les icônes grisées absentes.** `"gris": true` les fabrique à partir de l'icône en couleur.
- **Le vert vif sur un personnage** (elfe, orc) est effacé avec le fond. Dans le prompt, demander des verts olive ou vert-de-gris.
- **`bin/extract-heroquest-graphics.py` n'écrit que dans `iso/1991/`.** `iso/livre.png` (fond de la vue classique) est retouché à la main : ne pas l'écraser.
- **Nouveau personnage dans le code.** Ajouter ses images, puis l'utiliser dans `ModuleIso.js` (`ISO_MONSTRES`, `IsoNomHeros`). `IsoNomHeros` retombe sur `barbare-h` si un héros n'a pas d'image de repos.

## Contrôle des noms

Noms obligatoires : les sprites fixes et le repos de chaque personnage. Les animations sont facultatives.

```
node -e "eval(require('fs').readFileSync('public/assets/game/iso/atlas.js','utf8')+';global.A=IsoAtlas;global.S=IsoSols.concat(Object.values(IsoSolsSpeciaux))');const m=[];const v=n=>A[n]||m.push(n);for(const t of ['barbare','nain','elfe','enchanteur'])for(const s of ['h','f']){v(t+'-'+s+'-repos');v('portrait-'+t+'-'+s)}for(const n of ['gobelin','orc','fimir','chaos','mage','squelette','zombie','momie','gargouille'])v(n+'-repos');for(const i of ['deplacement','attaque','objet','tresor','piege','fin'])v('icone-'+i),v('icone-'+i+'-grise');['bottes','bras','or','bouclier'].forEach(i=>v('icone-'+i));S.forEach(v);for(let i=0;i<4;i++)v('mur'+i);for(let i=0;i<12;i++)v('porte'+i);for(let c=0x4b;c<0x60;c++)if(c!=0x51&&c!=0x52)v('meuble'+c.toString(16));console.log(m.length?'manquants : '+m:'complet')"
```
