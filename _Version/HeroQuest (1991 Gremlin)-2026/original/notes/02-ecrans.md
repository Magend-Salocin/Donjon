# Écrans et déroulement de QUEST.EXE

Comment le jeu enchaîne ses écrans, affiche, dialogue avec le joueur et fait tourner une quête. Adresses et noms : `original/asm/quest.asm` et `original/symboles.txt`.

État : la boucle principale, le menu titre, l'affichage et la boucle des tours sont lus ; le contenu de chaque écran (héros, armurerie, briefing) et de chaque tour reste à lire.

## Boucle principale

Dans `demarrage`, après la configuration et les chargements :

1. `menu_titre` (0x7310). Le bit 0x40 de `commandes` fait quitter le jeu : retour au mode texte, puis int 21h AX=4C00h.
2. `charge_ecran_plateau` : BOOK, MAPS, SPRITES.
3. `partie` (0x0246) : la quête.
4. Tant que `numero_quete` (DS:3F92) est inférieur à 15, retour au menu titre. Après la 14e quête, si DS:3FE7 est posé, écran de fin : le parchemin QUESTB et deux textes (DS:A5C4, puis DS:A7C2), affichés par `affiche_texte`.

## Menu titre

`menu_titre` charge l'écran des menus (`charge_ecran_menus` : BORDERED, SHOPSP, SHOPMP), puis dessine à partir de SHOPMP :

| Image | Source | Position (x, y) |
| --- | --- | --- |
| Logo HeroQuest, 224 × 68 | 0x7C40 | 48, 8 |
| Icône plateau, 48 × 64 | 0x3000 | 44, 94 |
| Icône héros | 0x3C00 | 136, 94 |
| Icône armurerie | 0x4800 | 228, 94 |

Il boucle ensuite : curseur, envoi du tampon à l'écran, lecture des commandes. Au clic, `zone_cliquee` cherche la zone sous le curseur dans `zones_menu_titre` (DS:AA00) et renvoie son numéro × 2 ; le jeu saute à la routine de la table `saut_menu_titre` (DS:AA1A) :

| Zone | Routine | Écran |
| --- | --- | --- |
| 2 | `choix_quete` (0x73ED) | choix de la quête et briefing ; refuse si aucun personnage n'est actif |
| 4 | `ecran_heros` (0x7717) | choix et création des personnages |
| 6 | `armurerie` (0x8070) | achats |

## Affichage

Le jeu dessine dans un tampon hors écran (segment 0x1463), puis l'envoie à l'écran :

| Routine | Effet |
| --- | --- |
| `efface_tampon` | remplit le tampon |
| `fond_vers_tampon` | recopie l'écran de fond (segment DS:5E23 : BOOK, BORDERED...) dans le tampon |
| `copie_image` | dessine une image dans le tampon (BP largeur, CX hauteur, SI source, DI = y × 320 + x) |
| `affiche_tampon` | envoie le tampon à l'écran |
| `sauve_tampon` | garde une copie du tampon |

Chacune existe en plusieurs versions selon `mode_video`, par une table de saut ; la version VGA est l'entrée d'index 8 (par exemple 0x6148 pour `affiche_tampon`).

Le curseur est un sprite de 16 × 16 décrit en DS:47E5 : `curseur_sauve_fond` garde ce qu'il recouvre, `curseur_dessine` le dessine.

## Messages

`affiche_message` (0x88ED) ouvre une boîte de dialogue. BX est le numéro du message : l'offset de son entrée dans la table du début du fichier de textes, chargé (décompressé) en DS:5FC1 par `charge_donnees`. Les messages français sont listés dans `original/donnees/textes/french-messages.txt` (300 entrées, numéros tels que passés dans BX), et le listing affiche le texte à côté de chaque appel.

Format d'une entrée :

| Octets | Contenu |
| --- | --- |
| 0-3 | colonne, ligne, largeur, hauteur de la boîte, en caractères de 8 pixels |
| 4-5 | rôle à trouver (position du bouton ?) |
| mots jusqu'à FFFFh | souvent `3673 0000` ; pour les menus, des triplets (pointeur vers un libellé en DS, numéro, position) |
| texte | lignes `11h, ligne, colonne, texte`, puis 00h |

Quelques entrées sont de simples chaînes (par exemple « JE COMPRENDS MENTOR ») ; 5 sont vides.

`affiche_texte` (0x317C) écrit un texte pointé par BP, avec les mêmes codes de contrôle (11h ligne et colonne, 01h position en pixels, 10h et 12h à identifier).

## Une partie

`partie` (0x0246) prépare les héros (`prepare_heros`), puis répète un tour :

1. `tour_personnage` pour chacune des 5 fiches de `fiches_personnages` (DS:4663, 26 octets chacune) : les 4 héros, avec le type de commande de leur joueur (DS:3195 à 3198), puis une 5e fiche jouée avec les commandes du joueur 1. Une fiche vide (premier octet à 0) passe son tour. La 5e est sans doute le personnage escorté de certaines quêtes (Sir Ragnar, Karlen) ; le 5e portrait d'ODDS&SOD irait avec.
2. `quete_continue` : fin de la quête ?
3. `tour_morcar` : les 32 monstres de `monstres` (DS:4D4A, 10 octets chacun, même format que dans QUESTn.BIN), joués par `tour_monstre`, avec un test de fin après chacun.
4. Le bit 0x40 de `commandes` ramène au menu titre.

Pendant un tour, les actions identifiées par leurs messages : `fouille_tresor`, `fouille_portes`, `fouille_pieges`, coffres (`coffre_potion`, `coffre_fleche`, `coffre_gargouille`...), objets de quête (`prend_lame_esprit`, `cles_agrain`), `boit_potion`, sorts (`sort_genie`, `sort_sans_effet`), `attaque_heros`, `attaque_contre_heros`, et en fin de quête `fin_quete`, `mort_heros`, `tous_elimines`, primes (`prime_ulag`, `prime_balur`...).

## À lire ensuite

- `tour_personnage` : choix de l'action, déplacement case par case, révélation des pièces.
- `tour_monstre` : intelligence des monstres (bits de l'octet 6 de l'enregistrement).
- `ecran_heros`, `armurerie`, `choix_quete` : contenu des écrans.
- Le format des fiches de 26 octets (DS:4663) : points de corps (+6), esprit, équipement.
