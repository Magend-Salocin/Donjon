# Planche du décor (zones)

Sols, murs, portes, meubles, portraits, icônes, et personnages sans planche d'animations. Fond noir, une zone relevée à la main par sprite.

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
   Une planche redessinée ne reprend ni le nombre ni l'ordre des images de 1991. Pour chaque nom du [contrat](contrat-atlas.md), choisir le sprite le plus proche (silhouette, couleurs, orientation). Les extras restent inutilisés. Si un sprite manque, réutiliser un voisin (miroir, autre pose) plutôt que de laisser un trou.

4. **Remplir `groupes`.** Un groupe par famille, avec son `cadrage` et sa `taille` ; une entrée par sprite : `[x, y, largeur, hauteur]`, ou un objet `{"zone": …, "miroir": true, "gris": true, "taille": …, "decalage": …, "marge": …}`.

   | Cadrage | Pour | Effet |
   | --- | --- | --- |
   | `losange` | sols | garde le dessus de la dalle (hauteur = largeur / 2), sans son épaisseur |
   | `mur` | murs | `coins` (haut gauche, bas gauche, bas droit, haut droit) de la face sur la planche, `pente` `monte` (/) ou `descend` (\) : face redressée puis posée sur le parallélogramme de 1991 |
   | `etire` | portes | étirée à la taille exacte |
   | `contenir` | meubles, portraits, icônes | réduite dans la taille, posée en bas et centrée |
   | `reduction` | héros, monstres sans planche d'animations | taille de la planche ÷ `reduction` : garde les tailles relatives |

   Choisir `reduction` pour que les héros fassent environ 40 px de haut (1,875 pour une planche à environ 75 px par héros).

5. **Construire et vérifier** : [verification.md](../rules/verification.md).
