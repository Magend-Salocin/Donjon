# Skill atlas-iso

Construit l'atlas de la vue isométrique (`donjon-v2/public/assets/game/iso/atlas.png` et `atlas.js`) à partir de planches de sprites redessinées. Le point d'entrée est [SKILL.md](SKILL.md).

## Organisation

| Chemin | Contenu |
| --- | --- |
| `SKILL.md` | déclenchement du skill, vue d'ensemble, choix de la procédure |
| `kb/contrat-atlas.md` | noms et tailles attendus par `ModuleIso.js` |
| `kb/planche-animations.md` | procédure pour une planche en grille (fond vert) |
| `kb/planche-decor.md` | procédure pour la planche du décor (fond noir, zones) |
| `kb/pieges.md` | erreurs déjà rencontrées et leurs parades |
| `rules/regles.md` | règles à respecter à chaque modification |
| `rules/verification.md` | construction et contrôles avant livraison |
| `agents/juge-planche.md` | agent qui juge une planche d'animations avant intégration |
| `outils.py` | repérage des sprites, planche nommée de 1991, scène de test |

Ces fichiers ne sont pas chargés automatiquement : `SKILL.md` indique lesquels lire selon la tâche. Pour utiliser l'agent, passer son contenu en prompt à un sous-agent (Agent tool), avec la planche à juger.

## Conventions

- Rédaction en français, phrases courtes, comme le reste du dépôt.
- Une information à un seul endroit : modifier le fichier concerné et y renvoyer par un lien plutôt que de la recopier.
- Les commandes se lancent depuis `donjon-v2/`.
