# Donjon

Jeu de rôle par navigateur. Le jeu jouable est dans `donjon-v2/` (voir son `README.md`), l'historique du projet dans `README.md`.

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

`Campagne01` était auparavant dans ce dépôt. Les liens `../Campagne01/...` de `donjon-v2/docs/` et `donjon-v2/bin/` désignent désormais `D:\VisualCode_Perso\HeroQuest\HeroQuest\Campagne01`.
