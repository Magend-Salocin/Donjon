---
name: atlas-iso
description: Refaire l'atlas de la vue isométrique du donjon (donjon-v2/public/assets/game/iso/atlas.png et atlas.js) à partir de planches de sprites redessinées : planche du décor sur fond noir, planches d'animations des personnages en grille sur fond vert. À utiliser quand l'utilisateur fournit une nouvelle planche iso ou d'animations, veut écrire le prompt d'une planche, remplacer, ajouter ou recadrer un sprite de la vue 3D ou classique (sol, mur, porte, meuble, héros, monstre, portrait, icône, animation), ou signale un sprite mal découpé.
---

# Atlas de la vue isométrique

La vue iso (`public/assets/game/ModuleIso.js`) dessine tout depuis une seule image, `iso/atlas.png`, décrite par `iso/atlas.js`. `bin/construire-atlas-iso.py` construit l'atlas à partir de deux sortes de planches, déclarées dans `bin/atlas-iso.json` :

| Planche | Clé du JSON | Fond | Découpage | Procédure |
| --- | --- | --- | --- | --- |
| Décor et sprites fixes (sols, murs, portes, meubles, portraits, icônes, héros et monstres sans animations) | `planche`, `groupes` | noir | une zone relevée à la main par sprite | [kb/planche-decor.md](../../kb/planche-decor.md) |
| Animations d'un ou deux personnages (`iso/remake/planches/*.png`) | `grilles` | vert `#00FF00`, gouttières noires | automatique, case par case | [kb/planche-animations.md](../../kb/planche-animations.md) |

Les animations, leurs noms et les étapes sont décrits dans [kb/animations-iso/concept-animations-iso.md](../../kb/animations-iso/concept-animations-iso.md). Le prompt modèle d'une planche d'animations est [kb/animations-iso/prompt-barbare.md](../../kb/animations-iso/prompt-barbare.md).

Toutes les commandes se lancent depuis `donjon-v2/`.

| Fichier | Rôle |
| --- | --- |
| `bin/atlas-iso.json` | planche du décor et zones, planches d'animations, échelle, sols des zones |
| `bin/construire-atlas-iso.py` | découpe, détoure, met à l'échelle, écrit `atlas.png` et `atlas.js` |
| `public/assets/game/iso/remake/planches/` | planches d'animations |
| `public/assets/game/iso/1991/` | atlas d'origine (`bin/extract-heroquest-graphics.py`) : référence des tailles et orientations |
| `.claude/skills/atlas-iso/outils.py` | repérage des sprites, planche nommée de 1991, scène de test |

## Déroulé

1. Lire [rules/regles.md](../../rules/regles.md) et [kb/contrat-atlas.md](../../kb/contrat-atlas.md).
2. Suivre la procédure de la planche concernée (tableau ci-dessus). Pour une planche d'animations, la faire juger d'abord par l'agent `juge-planche` ([agents/juge-planche.md](../../agents/juge-planche.md)).
3. En cas de rendu inattendu, consulter [kb/pieges.md](../../kb/pieges.md).
4. Construire et vérifier : [rules/verification.md](../../rules/verification.md).

L'organisation des fichiers du skill est décrite dans [.claude/CLAUDE.md](../../CLAUDE.md).
