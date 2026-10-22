# Règles

À respecter à chaque modification de l'atlas.

1. Ne pas changer les tailles plateau des sols, murs, portes et meubles ([contrat](../kb/contrat-atlas.md)) : les placements de `ModuleIso.js` en dépendent.
2. Ne jamais étirer un mur : cadrage `mur` avec ses 4 coins.
3. Meubles et portes existent dans leurs deux orientations dans l'atlas. Seuls les personnages sont retournés par le jeu.
4. Un nom n'est fourni qu'une fois : ce que donne une grille est retiré de `groupes`.
5. Seul `<base>-repos` est obligatoire pour un personnage. Les animations peuvent arriver planche par planche.
6. Juger une planche d'animations avant de l'intégrer ([juge-planche](../agents/juge-planche.md)).
7. Quand un choix change le rendu du jeu (quel dessin pour quel héros ou quel sexe), demander à l'utilisateur.
8. Ne pas écraser `iso/livre.jpg` ni modifier `iso/1991/` à la main.
9. Ne rien livrer sans avoir passé [la vérification](verification.md).
