# Donjon

Jeu de rôle par navigateur. Le jeu jouable est dans `donjon-v2/` (voir son `README.md`), l'historique du projet dans `README.md`.

## Conventions

- Rédaction en français, phrases courtes, comme le reste du dépôt.
- Une information à un seul endroit : modifier le fichier concerné et y renvoyer par un lien plutôt que de la recopier.
- Les commandes du jeu se lancent depuis `donjon-v2/`.

## Organisation de `.claude/`

Ces fichiers ne sont pas chargés automatiquement (sauf l'agent) : lire celui qui correspond à la tâche.

| Chemin (dans `.claude/`) | Contenu |
| --- | --- |
| `kb/roadmap.md` | état du jeu, dette, jalons, décisions à prendre, skills et agents à créer |
| `skills/atlas-iso/SKILL.md` | skill de construction de l'atlas iso (`donjon-v2/public/assets/game/iso/atlas.png` et `atlas.js`) : déroulé et fichiers à lire |
| `skills/atlas-iso/outils.py` | repérage des sprites, planche nommée de 1991, scène de test |
| `agents/juge-planche.md` | agent qui juge une planche d'animations avant intégration |
| `kb/contrat-atlas.md` | noms et tailles attendus par `ModuleIso.js` |
| `kb/planche-animations.md` | procédure pour une planche en grille (fond vert) |
| `kb/planche-decor.md` | procédure pour la planche du décor (fond noir, zones) |
| `kb/pieges.md` | erreurs déjà rencontrées sur l'atlas et leurs parades |
| `kb/animations-iso/` | concept des animations iso (statut, étapes) et prompt modèle d'une planche (barbare) |
| `kb/taverne/` | conception de la taverne, non développée : `concept-taverne.md` (vue d'ensemble, découpage, décisions à prendre), mécaniques, PNJ, dialogues, compagnons, récompenses |
| `rules/regles.md` | règles à respecter à chaque modification de l'atlas |
| `rules/verification.md` | construction de l'atlas et contrôles avant livraison |

## Campagnes JDR (dépôt séparé)

Les campagnes HeroQuest qui alimentent le jeu (quêtes, PNJ, conséquences, règles de réputation et de corruption) sont dans un autre dépôt : `D:\VisualCode_Perso\HeroQuest\HeroQuest`.

| Chemin | Contenu |
| --- | --- |
| `Campagne01/` | La Tempête gronde : campagne de base, quêtes 1 à 14 = aventures 101 à 114 du jeu |
| `Campagne02/` à `Campagne06/` | Karak Varn, Kalos, Campagne 04, Le Mage du Miroir, La Reine des Esprits |
| `_ressource/` | livres de quêtes (PDF), fiches de héros, fanzines |
| `.claude/FORMAT.md` | format des cartes `questN.js` « avec murs » |
| `.claude/skills/` | `structurer-campagne`, `decoupe-journal-quetes`, `importer-livre-quetes`, `plateau-quete-js` |

Chaque campagne suit la même structure : `01-regles/`, `02-quetes/` (une fiche par quête, `index.md`, `consequences.md`), `03-suivi/`, et un `README.md` qui donne l'état des sources.

Règles de ce dépôt (son `CLAUDE.md`) : ne pas inventer de règle, récompense ou lien narratif absent des sources ; signaler les contradictions dans « Points à arbitrer » sans trancher ; ne pas toucher aux TXT historiques sans demande explicite.

`Campagne01` était auparavant dans ce dépôt. Les mentions de `Campagne01/` dans `donjon-v2/bin/` et `donjon-v2/README.md` désignent désormais `D:\VisualCode_Perso\HeroQuest\HeroQuest\Campagne01`.
