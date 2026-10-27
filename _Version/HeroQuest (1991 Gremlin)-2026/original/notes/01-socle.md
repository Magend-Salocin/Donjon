# Socle de QUEST.EXE

Configuration, commandes, fichiers, son et mémoire. Les adresses sont celles de `original/asm/quest.asm` (positions dans l'image décompressée) ; les noms viennent de `original/symboles.txt`.

État : commandes, fichiers et interface du son lus en détail ; vidéo seulement repérée ; format des morceaux à décoder.

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
| 0x40 | touche Ctrl (code 1Dh, octet DS:392F de `etat_touches`) : quitter la partie ou le jeu |

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

Attentes : `attend_commande` (une commande quelconque), `attend_relache` (plus aucune), `attend_bouton_droit` (le bouton droit seul, puis son relâchement), `attend_clic` (bit 0x10), `attend_relache_boutons` (bits 0x10 et 0x20 à 0), `attend_touche` (une touche, puis son relâchement).

Bogue du joystick B (vérifié dans le code) : si l'on appuie sur un bouton du joystick B à l'étalonnage, `etalonne_joystick` met `masque_joystick` (DS:320A) à C0h. Ce masque garde les bits des boutons (6 et 7) au lieu de ceux des axes (2 et 3, soit 0Ch). `joystick_position` boucle, interruptions coupées, tant que les deux boutons B ne sont pas enfoncés : le jeu se fige, et le centre reste à 0.

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

`son_pilote` (QUEST.CFG) choisit le pilote : 0 BEEPER.DRV, 1 ADLIB.DRV, 2 MT32.DRV, 3 TANDY.DRV (noms en DS:31A0, tailles en paragraphes en DS:31F0). `son_charge_pilote` (0x47A6) le charge dans un segment à lui, avec son fichier de données (DS:31D0) : GAME&FX.ALB pour l'AdLib, GAME&FX.RLD pour la MT-32 (Roland), rien pour les deux autres. Il appelle ensuite le pilote à son début (appel lointain segment:0000), qui détourne int 60h. Le jeu ne parle plus au pilote que par int 60h, fonction dans AX :

| AX | Paramètres | Rôle |
| --- | --- | --- |
| 0 | | arrêt du pilote (en quittant) |
| 2 | DX segment des données, SI 0 | donne les données au pilote |
| 3 | DX = CX = numéro du morceau | joue un morceau ; rend une poignée dans DI |
| 4 | DI poignée | arrête le morceau |
| 5 | DX numéro | joue un effet (pilote Tandy) |
| 0Ah | | initialisation |
| 0Bh | | silence (avec le haut-parleur coupé par le port 61h) |

Morceaux de GAME&FX.ALB : 0 la musique (« ingame », lancée au démarrage par `son_prepare`), puis les effets :

| Morceau | Routine | Quand |
| --- | --- | --- |
| 2 | `son_pas` | un pas sur trois |
| 3 | `son_porte` | une porte s'ouvre |
| 5 | `son_monstre_touche`, `son_monstre_tue` | gros plan du combat |
| 6 | `son_des` | dés de déplacement |
| 8 | `son_clic` | clic sur un bouton |
| 9 | `son_sort`, `son_piege` | sort lancé, piège déclenché |

Avec le pilote 0, chaque effet est une suite de notes jouées directement sur le haut-parleur (`son_bip`, 0x2B8E).

GAME&FX.ALB (18 008 octets) et .RLD (26 312 octets) ont le même début : un mot (somme de contrôle ?), 1 (un seul morceau nommé ?), le nom « ingame » sur 20 octets, puis 50 (0x32) et une liste de numéros 0, 1, 2, 3, 4, 5, 6, 5, 6, 7… qui ressemble à l'ordre des motifs d'un module. Le .RLD contient aussi les noms des sons MT-32 (« 4matchip3 », « harpsi 1 »…). Le format reste à décoder ; le choix entre décodage, émulation du pilote et capture est la décision D3 de la roadmap.

`son_prepare` lance la musique au démarrage (morceau de la table DS:31FE : 0, ou 1 pour Tandy) et les effets sont muets (`son_actif` = 0). `son_musique`, appelée à chaque lecture des commandes, attend la touche F10 : DS:3956 est l'octet de la touche 44h dans `etat_touches` (DS:3912 + 44h), jamais écrit autrement. Au premier appui, elle arrête la musique et active les effets, une fois pour toutes.

## Mémoire et vidéo

`alloue_memoire` (0x4E10) réserve, selon le mode vidéo, les segments rangés en DS:5E23 à 5E35 (écran, SHOPSP, MAPS, MONSTERS, GRAPHICS, ODDS&SOD, FURN). En cas d'échec, le jeu affiche un message qui se termine par « AND TRY AGAIN ».

`mode_vga` (0x5FE3) passe en mode 13h et charge la palette ; `mode_tandy` (0x359E) passe en mode 8. Les routines d'affichage existent en plusieurs versions, choisies par `mode_video` à travers des tables de saut (par exemple `saut_copie_image`, DS:3726) ; seule la version VGA (index 8) est utile au portage. Seuls les modes 4 (Tandy), 6 (EGA, `mode_ega`) et 8 (VGA) ont des routines : les entrées 0 et 2 des tables sont à 0. En EGA, une ligne du tampon fait 4 plans de 40 octets.

Outils de mise au point restés dans l'exécutable, jamais appelés : `affiche_registres` (AX à DS en hexadécimal), `point_arret` (bordure blanche, registres, attente d'un clic), `boite_texte`, `image_cible`, `image_personnage`.
