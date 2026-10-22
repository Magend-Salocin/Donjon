# Pièges connus

- **Le fond de la planche du décor n'est pas noir pur.** Les planches générées ont un halo sombre (valeurs 30 à 45) autour des sprites. `FOND` (34) et `SEUIL` (45) en tiennent compte. Un pixel enfermé reste opaque, sauf s'il est presque noir (`NOIR_ENFERME`).
- **Les morceaux de voisins.** Une pointe de dalle ou d'arme qui entre dans une zone est retirée si elle est détachée et petite (`MORCEAU`). Sinon, resserrer la zone, ou mettre `"marge": 0` si deux sprites se touchent.
- **Les murs.** Leur pente sur la planche n'est jamais exactement 1/2, et l'étirement laisse des coutures noires entre les pans. Relever les 4 coins sur une vue agrandie avec une grille, sous les créneaux, pas sur les pierres qui dépassent.
- **L'orientation.** Une paire de 1991 (`meuble4f` / `meuble50`…) est un miroir. Vérifier quel dessin de la planche correspond à chaque nom ; s'il n'y en a qu'un, `"miroir": true` donne l'autre.
- **Les icônes grisées absentes.** `"gris": true` les fabrique à partir de l'icône en couleur.
- **Le vert vif sur un personnage** (elfe, orc) est effacé avec le fond. Dans le prompt, demander des verts olive ou vert-de-gris.
- **`bin/extract-heroquest-graphics.py` n'écrit que dans `iso/1991/`.** `iso/livre.jpg` (fond de la vue classique, 1280 × 800) est recadré de `iso/t/livre.png` (zone 88, 32, 1400 × 875).
- **Nouveau personnage dans le code.** Ajouter ses images, puis l'utiliser dans `ModuleIso.js` (`ISO_MONSTRES`, `IsoNomHeros`). `IsoNomHeros` retombe sur `barbare-h` si un héros n'a pas d'image de repos.
