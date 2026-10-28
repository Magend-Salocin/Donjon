# HeroQuest (1991 Gremlin) - 2026

Reproduction à l'identique du HeroQuest PC de Gremlin (1991), d'abord en retrouvant le code original, puis en le portant en JavaScript (le jeu) et PHP (le service). La [roadmap](ROADMAP.md) donne les étapes et les décisions à prendre.

Les fichiers du jeu sont dans [`../HeroQuest (1991 Gremlin)`](../HeroQuest%20(1991%20Gremlin)), et leurs formats dans [FORMATS.md](../HeroQuest%20(1991%20Gremlin)/FORMATS.md). Ce projet est indépendant de `donjon-v2`, mais il réutilise ses décompresseurs (`donjon-v2/bin/extract-heroquest-graphics.py`) et son outil d'exploration (`donjon-v2/bin/heroquest-outils.py`).

Les données de Gremlin et Hasbro restent réservées à un usage personnel : ne pas publier les fichiers d'origine ni ce qui en est extrait (`original/`).

## Structure

| Chemin | Contenu |
| --- | --- |
| `original/symboles.txt` | noms des routines, variables et tables de QUEST.EXE, à enrichir au fil de l'étude ; `symboles-intro.txt` pour INTRO.EXE |
| `original/binaires/` | QUEST.EXE et INTRO.EXE décompressés (image mémoire) |
| `original/asm/` | désassemblage annoté (`quest.asm`, `intro.asm`), segment de données (`*-donnees.txt`), couverture (`*-rapport.txt`), résumé des routines (`*-routines.txt`) |
| `original/notes/` | ce que fait le code, par sous-système (phase 1 de la roadmap) |
| `original/donnees/` | palettes, écrans, sprites et images, textes des 5 langues, quêtes en JSON |
| `outils/` | `desassembler.py`, `extraire.py`, `ecran.py` (images dessinées et messages affichés par une routine), le lancement du jeu original sous DOSBox-X avec débogueur ([DEBOGUER.md](outils/DEBOGUER.md)), et pour le portage `recompiler.py`, `difference.py`, `essai.mjs`, `navigateur.mjs` ([web/README.md](web/README.md#vérifier)) |
| `travail/` | copie du jeu utilisée par DOSBox-X (sauvegardes, journal), ignorée par git |
| `web/` | le portage JavaScript et PHP : [web/README.md](web/README.md) |

## Régénérer

Prérequis : Python 3.10+, `pip install pillow capstone`. Depuis `outils/` :

```bash
python desassembler.py QUEST     # puis INTRO
python extraire.py
```

Les fichiers de `original/asm/` et `original/donnees/` sont générés : ne pas les modifier à la main. Pour nommer une routine ou une variable, ajouter une ligne à `original/symboles.txt` et relancer le désassembleur.

## Le désassembleur

`desassembler.py` décompresse l'exécutable (EXEPACK), puis suit le flot d'exécution depuis le point d'entrée : appels, sauts, tables de saut par mode vidéo (`mov bx, table ; add bx, [0x3190] ; jmp [bx]`), pointeurs de routine écrits en mémoire (`mov word ptr [x], routine`). Une seconde passe ajoute les zones qui suivent un `ret` et se décodent proprement jusqu'à un `ret` : ces routines sont marquées « probables » dans le listing, à confirmer. Les tables de saut de taille connue, ou dont les entrées ne sont pas des mots consécutifs, sont déclarées dans `TABLES_ESPACEES` : lues au hasard, elles produisent de fausses cibles qui décodent des données comme du code.

Couverture actuelle (voir `original/asm/*-rapport.txt`) :

| Programme | Code atteint | Routines | Sauts indirects non résolus |
| --- | --- | --- | --- |
| QUEST.EXE | 98,7 % | 380, dont 27 probables | 4 |
| INTRO.EXE | 95,9 % | 85, dont 26 probables | 1 |
