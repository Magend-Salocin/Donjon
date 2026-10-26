# Déboguer le jeu original

Sert à vérifier sur le jeu qui tourne ce que l'on lit dans `original/asm/quest.asm` : qu'une routine est bien appelée à tel moment, ce que contient une variable.

DOSBox-X est installé dans `C:\DOSBox-X` (winget, `joncampbell123.DOSBox-X`). Le lanceur travaille sur une copie du jeu dans `travail/`, ignorée par git :

```powershell
.\lancer-dosbox.ps1          # jouer (HERO.EXE : intro puis jeu)
.\lancer-dosbox.ps1 -Debug   # QUEST.EXE arrêté sur sa première instruction
.\lancer-dosbox.ps1 -Neuf    # repartir d'une copie propre du jeu
```

Le lanceur exécute `LOADFIX` avant le jeu : sans lui, le jeu s'arrête sur « Packed file is corrupt » (défaut connu d'EXEPACK).

## Commandes du jeu

Le choix clavier, souris ou joystick est rangé dans `travail/jeu/QUEST.CFG`, que l'intro écrit au premier lancement ([format](../original/notes/01-socle.md#questcfg)). La copie de travail est réglée sur la souris (`08 00 01 00 01 00 00 00 00`), et la configuration au clavier est gardée dans `QUEST.CFG.clavier`. La fenêtre prend la souris au premier clic ; Ctrl+F10 la relâche.

Au clavier, sur un clavier AZERTY : A haut, Q bas, O gauche, P droite, Espace clic, Entrée bouton droit.

## Passer des adresses du listing aux adresses en mémoire

Le listing donne des positions dans l'image décompressée. En mémoire, DOS charge le programme à un segment L qui change selon la configuration :

| Dans le listing | En mémoire |
| --- | --- |
| code à la position X | `L:X` (QUEST.EXE tourne avec CS = L) |
| variable `DS:V` | `(L + 097C):V` |

Pour trouver L : poser `BPINT 21 4A`, puis lancer (F5). Le premier arrêt dans le programme est l'instruction `int 21h` de `demarrage`, en 0x00FE : CS vaut alors L et IP vaut 00FE. Si IP n'est pas 00FE, c'est un autre appel (par exemple celui du décompresseur EXEPACK) : relancer avec F5.

Autre moyen, dès l'ouverture du débogueur par `-Debug` : le programme est arrêté sur le décompresseur EXEPACK, en IP = 0012 ; L = CS − 0C2B.

Exemple, pour vérifier l'attaque du héros (`attaque_heros`, position 0x0936) et lire les crânes obtenus (`cranes`, DS:3FD2), avec L = 0820 :

```text
BP 0820:0936
D 0B9C:3FD2
```

## Commandes utiles du débogueur

Le débogueur s'ouvre avec `-Debug`, ou en cours de jeu avec Alt+Pause.

| Commande | Effet |
| --- | --- |
| F5 | reprendre l'exécution |
| F10, F11 | instruction suivante, en passant par-dessus un appel ou en y entrant |
| `BP seg:off` | point d'arrêt sur une instruction |
| `BPINT nn [ah]` | point d'arrêt sur une interruption, par exemple `BPINT 21 3D` à chaque ouverture de fichier |
| `BPLIST`, `BPDEL n` | lister, supprimer les points d'arrêt |
| `C seg:off` | afficher le code à partir de cette adresse |
| `D seg:off` | afficher la mémoire à partir de cette adresse |
| `SR reg valeur` | modifier un registre |
| `MEMDUMPBIN seg:off taille` | écrire une zone mémoire dans un fichier (dans le dossier de DOSBox-X) |
| `HELP` | toutes les commandes |

Pour suivre les chargements de fichiers : `BPINT 21 3D`, puis à chaque arrêt, lire le nom en `DS:DX` avec `D`.

Si QUEST.EXE lancé seul refuse de démarrer (il attend peut-être quelque chose de HERO.EXE), lancer le jeu normalement, puis poser `BPINT 21 4B` (lancement d'un programme) avant la fin de l'intro.

## Ce qui reste à vérifier sur cette méthode

- Que QUEST.EXE démarre seul sous `DEBUGBOX`.
- La valeur de L dans cette configuration, à noter ici une fois relevée.
