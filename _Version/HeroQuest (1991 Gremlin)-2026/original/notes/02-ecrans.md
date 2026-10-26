# Écrans et déroulement de QUEST.EXE

Comment le jeu enchaîne ses écrans, affiche, dialogue avec le joueur et fait tourner une quête. Adresses et noms : `original/asm/quest.asm` et `original/symboles.txt`.

État : boucle principale, menu titre, écran des héros, armurerie, choix de la quête, affichage et boucle des tours lus. Le tour lui-même est décrit dans [03-regles.md](03-regles.md). L'inventaire aussi. Reste : le briefing (texte de QUESTn.BIN sur le parchemin) et le menu de sauvegarde.

## Boucle principale

Dans `demarrage`, après la configuration et les chargements :

1. `menu_titre` (0x7310). Le bit 0x40 de `commandes` fait quitter le jeu : retour au mode texte, puis int 21h AX=4C00h.
2. `charge_ecran_plateau` : BOOK, MAPS, SPRITES.
3. `partie` (0x0246) : la quête.
4. Tant que `numero_quete` (DS:3F92, compté à partir de 0) est inférieur à 15, retour au menu titre. Ensuite, si DS:3FE7 est posé, écran de fin : le parchemin QUESTB et deux textes (DS:A5C4, puis DS:A7C2), affichés par `affiche_texte`.

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

Positions des écrans suivants : relevées par `outils/ecran.py ADRESSE`, qui liste les images dessinées par une routine, et dans les tables de zones (format : x1, y1, x2, y2 sur 16 bits, terminé par FFFFh ; `zone_cliquee` renvoie le numéro de la zone × 2, à partir de 2).

## Écran des héros

`ecran_heros` (0x7717), sur le fond BORDERED ; images de SHOPSP et SHOPMP :

| Élément | Image | Position |
| --- | --- | --- |
| Portrait du héros n (0-3), 48 × 64 | SHOPSP 0xB000 + 0xC00 × n s'il est sélectionné, 0x8000 + 0xC00 × n (gris) sinon | (40 + 64n, 40) |
| « IN PLAY », 48 × 12, si le héros est en jeu (DS:44A0 + n) | SHOPMP 0x7800 | (40 + 64n, 26) |
| 4 boutons, 32 × 48, si un héros est sélectionné (DS:409E) | SHOPMP 0x6000 + 0x600 × k | (72 + 48k, 116) |
| Flèche de retour, 32 × 16 | SHOPMP 0x7A40 | (144, 170) |

Zones (DS:AA22) et routines (DS:AA6C) :

| Zone | Action |
| --- | --- |
| Portrait n | sélectionne le héros et passe aux commandes de son joueur (`choisit_heros_1` et suivantes) |
| Bouton 1 (portrait encadré) | `heros_en_jeu` : met le héros en jeu ou l'en retire |
| Bouton 2 (plume) | `heros_nomme` : saisie du nom (15 caractères), puis mise en jeu |
| Bouton 3 (silhouette) | `heros_renouvele` : fiche remise à neuf (points de corps de départ DS:4394, équipement et or à zéro) |
| Bouton 4 (disquette) | `sauvegarde_menu` : charger ou enregistrer QUEST.SAV |
| Flèche | retour au menu titre |

## Armurerie

`armurerie` (0x8070) :

| Élément | Image | Position |
| --- | --- | --- |
| Portrait du héros n, 32 × 45 | ODDS&SOD 0x5A0 × n | (48 + 64n, 10) |
| 12 objets, 32 × 32, 3 rangées de 4 | SHOPSP 0x400 × i | (136 + 40c, 66 + 40r) |
| Flèche de retour | SHOPMP 0x7A40 | (72, 170) |
| Nom, type, or du héros choisi | `affiche_texte` | lignes 8 à 10 |

Les 12 objets (table DS:AC17 : masque de bit dans le mot d'équipement de la fiche, prix en pièces d'or), dans l'ordre des images :

| Objet | Bit | Prix | Objet | Bit | Prix |
| --- | --- | --- | --- | --- | --- |
| Bâton | 0001 | 100 | Lance | 0040 | 150 |
| Épée courte | 0002 | 150 | Bouclier | 0100 | 100 |
| Épée large | 0004 | 250 | Casque | 0200 | 120 |
| Hache de bataille | 0008 | 400 | Cotte de mailles | 0400 | 450 |
| Arbalète | 0010 | 350 | Armure de plates | 0800 | 850 |
| Hachette | 0020 | 150 | Trousse à outils | 0080 | 250 |

Ce sont les prix du jeu de plateau. `achete_objet` refuse si le héros possède déjà l'objet (« VOUS POSSEDEZ DEJA CELA ») ou si le prix dépasse son or (« VOUS NE POUVEZ PAS VOUS PERMETTRE CELA ») ; sinon il retire le prix de l'or (fiche +9) et pose le bit (fiche +0x0E).

## Choix de la quête

`choix_quete` (0x73ED) compte les héros en jeu encore vivants (points de corps non nuls) ; s'il n'y en a pas, message « AUCUN PERSONNAGE ACTIF N'A ETE SELECTIONNE POUR ENTRER DANS LA QUETE ». Sinon il charge EQUESTS.BIN, qui donne pour chaque langue deux menus affichés par `menu_liste` (0x8379) sur le parchemin :

- page 1 : les 14 quêtes de base, « page suivante », « menu principal » ;
- page 2 : les 10 quêtes de l'extension, « page précédente », « menu principal ».

Le choix donne `numero_quete` (0 à 23, + 14 pour la page 2). `lance_quete` (0x84F0) remet l'état de la partie à zéro, garde une copie des fiches (DS:A98F) pour les restaurer si la partie est abandonnée, et charge le QUESTn.BIN de la quête (noms en DS:A3FC).

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
| mots jusqu'à FFFFh | souvent `3673 0000` ; pour les menus, des triplets (offset du libellé dans le fichier de textes, numéro, position) ; par exemple le menu du génie pointe sur « REVELER LE CONTENU DE LA PIECE » (0x159F) et « D'ATTAQUER QUELQU'UN » (0x15C1) |
| texte | lignes `11h, ligne, colonne, texte`, puis 00h |

Quelques entrées sont de simples chaînes (par exemple « JE COMPRENDS MENTOR ») ; 5 sont vides.

`affiche_texte` (0x317C) écrit un texte pointé par BP, avec les mêmes codes de contrôle (11h ligne et colonne, 01h position en pixels, 10h et 12h à identifier).

## Une partie

`partie` (0x0246) prépare les héros (`prepare_heros`), puis répète un tour :

1. `tour_personnage` pour chacune des 5 fiches de `fiches_personnages` (DS:4663, 26 octets chacune) : les 4 héros, avec le type de commande de leur joueur (DS:3195 à 3198), puis une 5e fiche jouée avec les commandes du joueur 1. Une fiche vide (premier octet à 0) passe son tour. La 5e est Sir Ragnar, le chevalier escorté (nom par défaut RAGNAR, type 4) ; le 5e portrait d'ODDS&SOD est le sien.
2. `quete_continue` : fin de la quête ?
3. `tour_morcar` : les 32 monstres de `monstres` (DS:4D4A, 10 octets chacun, même format que dans QUESTn.BIN), joués par `tour_monstre`, avec un test de fin après chacun.
4. Le bit 0x40 de `commandes` ramène au menu titre.

Pendant un tour, les actions identifiées par leurs messages : `fouille_tresor`, `fouille_portes`, `fouille_pieges`, coffres (`coffre_potion`, `coffre_fleche`, `coffre_gargouille`...), objets de quête (`prend_lame_esprit`, `cles_agrain`), `boit_potion`, sorts (voir [03-regles.md](03-regles.md#sorts)), `attaque_heros`, `attaque_contre_heros`, et en fin de quête `fin_quete`, `mort_heros`, `tous_elimines`, primes (`prime_ulag`, `prime_balur`...).

## Inventaire

`inventaire_sorts` (0x8C20) charge WIZBACK (fond) et INVENT (images), plus SPELLIT pour les sorts. Le personnage 4 (Sir Ragnar) n'a pas d'inventaire. `mode_inventaire` (DS:AD67) choisit la page :

| Mode | Page | Objets listés (fiche) | En service (fiche) |
| --- | --- | --- | --- |
| 0 | trois cartes de catégorie, 64 × 94, en (64, 64), (136, 64), (208, 64) | | |
| 1 | armes et armures | +0x0E (8 armes ; +0x0F bit 0x80 donne aussi la trousse à outils), +0x0F bits 1 à 8 (4 armures) | +0x11, +0x13 |
| 2 | potions | +0x10 (7 bits) | +0x17 |
| 3 | artefacts | +0x0D (5 bits) | +0x12 |
| 5 | sorts, ouvert par `action_sort` | +0x0B, +0x0C | +0x16 |

Une page d'objets montre jusqu'à 12 cases de 32 × 32, en deux rangées de 6 : x = 44 + 40c, y = 88 et 128 (zones DS:ADA4). Un objet en service porte le cadre INVENT 0xA280. Sous le curseur, le nom de l'objet s'affiche dans le bandeau en (32, 169). La flèche en (296, 180) ramène aux catégories (au jeu pour les sorts) ; le bouton droit ferme l'inventaire et redessine le plateau (BOOK, MAPS).

Les 36 objets (table `objets`, DS:44FE : nom et image) et ce qu'un clic fait sur chacun sont décrits dans [03-regles.md](03-regles.md#objets).

## À lire ensuite

- Le briefing : affichage du texte de QUESTn.BIN sur le parchemin, après `lance_quete`.
- `sauvegarde_menu` : le déroulé du menu (le format de QUEST.SAV est dans [FORMATS.md](../../../HeroQuest%20(1991%20Gremlin)/FORMATS.md#questsav)).
