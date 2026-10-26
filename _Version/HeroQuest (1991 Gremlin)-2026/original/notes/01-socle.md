# Socle de QUEST.EXE

Configuration, commandes, fichiers, son et mémoire. Les adresses sont celles de `original/asm/quest.asm` (positions dans l'image décompressée) ; les noms viennent de `original/symboles.txt`.

État : commandes et fichiers lus en détail ; son et vidéo seulement repérés.

## Démarrage

`demarrage` (0x00ED) pose DS = 0x097C, réduit la mémoire du programme (int 21h AH=4Ah), puis appelle `lit_configuration` et `initialise_jeu`. En cas d'échec, il affiche un message et quitte.

## QUEST.CFG

Fichier de 9 octets écrit par l'intro (INTRO.EXE) au premier lancement. `lit_configuration` (0x30F6) le charge tel quel en DS:3190. S'il manque, le jeu affiche « Configuration file missing, Type 'hero' to set configuration » et quitte.

| Octet | Variable | Valeurs |
| --- | --- | --- |
| 0-1 | `mode_video` (DS:3190) | index des tables de saut d'affichage : 8 = VGA, 4 = Tandy ; 0, 2, 6 : autres modes (CGA, EGA ?) |
| 2 | `son_pilote` (DS:3192) | pilote de son, index des tables DS:31F0 (taille) et DS:31D0 (nom) ; à relever |
| 3 | `commande_type` (DS:3193) | 0 souris, 1 clavier, 2 joystick |
| 4 | `langue` (DS:3194) | fichier de textes chargé par `charge_donnees` ; l'ordre des noms en DS est anglais, français, espagnol, allemand, italien |
| 5-8 | `commandes_joueurs` (DS:3195) | commande de chacun des 4 joueurs, mêmes valeurs que l'octet 3 |

Au démarrage, si un joueur est en souris (0) et que `int 33h` AX=0 ne trouve pas de pilote, le jeu affiche « No mouse installed » et quitte. Si un joueur est en joystick (2), il lance `etalonne_joystick`.

Exemple relevé sous DOSBox-X après une première intro : `08 00 01 01 01 01 01 01 01`, c'est-à-dire VGA, clavier pour tous, langue 1. Avec `08 00 01 00 01 00 00 00 00`, le jeu utilise la souris.

## Commandes

Tout passe par un octet, `commandes` (DS:3992), remis à zéro et recalculé à chaque appel de `lit_commandes` (0x3752) :

| Bit | Sens |
| --- | --- |
| 0x01, 0x02 | haut, bas |
| 0x04, 0x08 | gauche, droite |
| 0x10 | bouton gauche (clic) |
| 0x20 | bouton droit |
| 0x40 | rôle à trouver (posé quand l'octet de la touche DS:392F est actif) |

`lit_commandes` enchaîne :

1. **Clavier** : pour chacune des 6 touches de `touches_commandes` (DS:390B), l'état lu dans `etat_touches` (DS:3912) entre dans un bit de `commandes`. Les touches sont des codes physiques (positions QWERTY) :

   | Code | Touche QWERTY | Touche AZERTY | Bit |
   | --- | --- | --- | --- |
   | 1Ch | Entrée | Entrée | 0x20 bouton droit |
   | 39h | Espace | Espace | 0x10 clic |
   | 19h | P | P | 0x08 droite |
   | 18h | O | O | 0x04 gauche |
   | 1Eh | A | Q | 0x02 bas |
   | 10h | Q | A | 0x01 haut |

2. **Joystick** (`lit_joystick`, si `commande_type` = 2) : position comparée au centre étalonné (DS:320B, DS:320D), à 32 unités près ; boutons 1 et 3 = clic, 2 et 4 = bouton droit.
3. **Curseur au clavier** (`curseur_clavier`) : chaque bit de direction déplace le curseur de 4 pixels, dans les limites de l'écran.
4. **Souris** (`lit_souris`, si `commande_type` = 0) : int 33h AX=3 ; boutons vers les bits 0x10 et 0x20, déplacement vers les bits de direction, position dans `curseur_x` et `curseur_y` (DS:3993, DS:3995 ; X divisé par 2).
5. Le curseur est ramené à 303 en X au plus, puis `son_musique` (0x4850) est appelée : la musique est relancée depuis la lecture des commandes (rôle exact à confirmer).

Le clavier est lu par un gestionnaire d'interruption propre au jeu : `clavier_installe` détourne int 9 vers `clavier_interruption` (0x3709), qui lit le port 60h et met à 1 (appui) ou 0 (relâchement) l'octet de la touche dans `etat_touches`. `clavier_retire` remet le gestionnaire du BIOS ; le jeu l'appelle avant chaque accès disque, puis réinstalle le sien.

Attentes : `attend_commande` (une commande quelconque), `attend_relache` (plus aucune), `attend_bouton_droit` (le bouton droit seul, puis son relâchement).

## Fichiers

Paramètres en DS : segment DS:3901, offset DS:3903, taille DS:3905, pointeur vers le nom DS:3907, handle DS:3909, erreur DS:37E9 (code DOS, 2 = fichier absent).

| Routine | Effet |
| --- | --- |
| `charge_fichier` (0x3981) | ouvrir, lire 0xFFFF octets au plus, fermer ; taille lue dans DS:3905 |
| `sauve_fichier` (0x39A0) | créer, écrire DS:3905 octets, fermer |
| `fichier_ouvre`, `fichier_lit`, `fichier_cree`, `fichier_ecrit`, `fichier_ferme` | int 21h AH = 3Dh, 3Fh, 3Ch, 40h, 3Eh |

Les fichiers graphiques sont chargés dans un tampon (segment 0x1463) puis décompressés par `lz_decompresse` dans leur segment (voir FORMATS.md).

`installe_erreur_disque` détourne int 24h vers `erreur_disque`, qui répond « ignorer » (AL = 0) : une disquette absente ne fait pas apparaître le message « Abort, Retry, Fail » de DOS.

## Son

Le pilote choisi par `son_pilote` (ADLIB.DRV, TANDY.DRV, MT32.DRV, BEEPER.DRV) est chargé en mémoire par `son_charge_pilote` (0x47A6), puis appelé par int 60h, fonction dans AX : 2, 3 et 4 au lancement d'une musique, 0Bh à l'arrêt. Une dizaine de routines d'effets sonores (`son_effet_1`, `son_effet_2` et voisines, de 0x2827 à 0x2B06) suivent le même schéma : rien si DS:3199 ne vaut pas 1, puis un traitement différent selon que `son_pilote` vaut 0 ou non.

À faire : la liste des fonctions de int 60h (lire le début de ADLIB.DRV), le contenu de GAME&FX.ALB et .RLD.

## Mémoire et vidéo

`alloue_memoire` (0x4E10) réserve, selon le mode vidéo, les segments rangés en DS:5E23 à 5E35 (écran, SHOPSP, MAPS, MONSTERS, GRAPHICS, ODDS&SOD, FURN). En cas d'échec, le jeu affiche un message qui se termine par « AND TRY AGAIN ».

`mode_vga` (0x5FE3) passe en mode 13h et charge la palette ; `mode_tandy` (0x359E) passe en mode 8. Les routines d'affichage existent en plusieurs versions, choisies par `mode_video` à travers des tables de saut (par exemple `saut_copie_image`, DS:3726) ; seule la version VGA (index 8) est utile au portage.
