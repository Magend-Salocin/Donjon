# Planche d'animations (grille)

Une planche par personnage et par usage : déplacements (4 × 4) et combat (4 × 2). Fond vert `#00FF00`, gouttières noires. Découpage automatique.

1. **Prompt.** Partir de [animations-iso/prompt-barbare.md](animations-iso/prompt-barbare.md). Décrire le personnage à partir de son portrait (`public/assets/img/personnages/<type>-<sexe>.png`) et joindre ses sprites actuels en référence.
2. **Juger la planche** avant de l'intégrer, avec l'agent [juge-planche](../agents/juge-planche.md). Une rangée ratée se régénère seule (voir la fin du prompt modèle).
3. **Déclarer** dans `grilles`, une entrée par planche (exemples du barbare dans `bin/atlas-iso.json`) :
   - `"prefixe"` : `<base>` du personnage ;
   - `"cases"` : l'animation de chaque case, rangée après rangée, `null` pour une case à ignorer (direction en double, repos de la planche de combat) ;
   - `"hauteur"` : hauteur sur le plateau de la case de repos `"reference"` (0 par défaut) : 40 pour un grand héros, 38 pour un plus petit, environ 34 pour un nain ;
   - `"face_vers_la_droite": true` si la face est dessinée vers le bas à droite : le script la retourne.

   Retirer de `groupes` les images que la grille fournit : le script refuse les noms en double.
4. **Construire et vérifier** : [verification.md](../rules/verification.md). Le script s'arrête si le nombre de cases trouvées n'est pas celui de `"cases"`.

## Ce que fait le script

- il repère les gouttières réelles (les cases d'une planche générée ne sont jamais égales) ;
- il retire le vert comme pour les portraits (`detourer` de `bin/decouper-heros.py`) ;
- il réduit toutes les images d'un personnage dans le rapport de son repos ;
- il centre chaque image sur les pieds, pour que le personnage ne glisse pas quand son arme part d'un côté.
