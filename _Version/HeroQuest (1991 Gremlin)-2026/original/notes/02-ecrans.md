# Écrans et déroulement de QUEST.EXE

Comment le jeu enchaîne ses écrans, affiche, dialogue avec le joueur et fait tourner une quête. Adresses et noms : `original/asm/quest.asm` et `original/symboles.txt`.

État : boucle principale, menu titre, écran des héros, armurerie, choix de la quête, affichage et boucle des tours lus. Le tour lui-même est décrit dans [03-regles.md](03-regles.md). L'inventaire, le briefing et la sauvegarde aussi.

## Boucle principale

Dans `demarrage`, après la configuration et les chargements :

`ecran_shields` (0x0000), jamais appelée, est une protection contre la copie restée d'une version EGA : un bouclier tiré au hasard (1 à 29), un code saisi (`saisie_nombre`), et `erreur_fichier` = FFFFh si la réponse est fausse.

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

Choix des sorts (`attribue_sorts`, 0x7F74) : l'enchanteur choisit 3 éléments, ou 1 seul si l'elfe joue, puis l'elfe en choisit 1 (« ENCHANTEUR CHOISIT TES SORTS », « ELFE CHOISIT TES SORTS »). Si les deux jouent, les 2 éléments restants vont à l'enchanteur. Chaque élément donne 3 sorts (`sorts_elements`, DS:ACD9 : 07h ou 38h dans +0x0B ou +0x0C).

## Briefing

`lance_quete` (0x84F0), dans l'ordre :

1. Remet à zéro l'état de la partie (DS:3F93, 270 octets) et le texte du briefing (DS:0A0E). Copie les 5 fiches et `heros_en_jeu` en DS:A98F.
2. Charge QUESTn.BIN ([format](../../../HeroQuest%20(1991%20Gremlin)/FORMATS.md#quêtes--questnbin)) : zones et murs dans `grille_zones` (DS:546F), le reste du fichier en DS:0000.
3. Pour chacun des 4 héros : en jeu ou non (`heros_en_jeu`, remis à zéro), case de départ et image (fiche +1, +2, +8). Un héros absent pose son bit dans `etat_quete`. La fiche perd ses potions (+0x10), son sort choisi, ses effets en cours (+0x16 à +0x18) et les bits 0x10 à 0x40 de +0x0F.
4. Recopie les deux tables par zone (DS:4B70 et DS:4B9B) et le texte du briefing, qu'il affiche par `affiche_texte` (couleur 11h) sur le fond déjà chargé par `choix_quete` (le parchemin QUESTB).
5. Charge les 32 monstres (DS:4D4A) et pose le mobilier dans `grille_occupants` (DS:586F).
6. Vide la fiche de Sir Ragnar. Dans la 2e quête, la place en (6, 1), avec 2 points de corps et l'image 0x50.
7. Attend : « JE COMPRENDS MENTOR » (ligne 22, colonne 10) s'allume sous le curseur ; un clic dessus, ou le bouton droit, ferme le briefing (`attente_briefing`).
8. Range chaque monstre sur sa case : zone, index de case, et son numéro (1 à 32) dans `grille_occupants`. Le type 0x15 est sauté.
9. Règles propres à certaines quêtes (numéros du jeu) :
   - 6e, LEGS DU SEIGNEUR ORC : les héros, capturés, perdent sorts et équipement (+0x0B à +0x0F, gardés en DS:4A9F) ;
   - 8e, LE MAGE DU FEU : l'elfe et l'enchanteur perdent leurs sorts de feu (+0x0C &= 38h) ;
   - 7e et 8e : le drapeau d'événement DS:3FC0 est posé (FFh).
10. Mélange les 25 cartes trésor (`pioche_tresors`, DS:463B) et place le pointeur de pioche au début.

## Intro

INTRO.EXE enchaîne GREMLIN, PIC1, TEXT1, puis 6 scènes (tables DS:0052 texte, DS:005E palette, DS:006A écran ; routine de chaque scène dans la table CS:071E). Dans l'ordre : HERO1, HERO2, HERO4, HERO6, HERO3, HERO7. Chaque écran a sa palette de 32 couleurs ([palettes](../donnees/palettes.json)).

Les sprites animés viennent de ANIMS.VGA, chargé tel quel (pas de compression) en segment 0x2523. Une image est rangée sur 5 plans de bits consécutifs (plan 0 = bit faible, 1 bit par pixel, rangée après rangée) ; trois routines la convertissent en un octet par pixel (0x4D50 pour 16 × 16, 0x4D93 pour 32 × 64, 0x4DDC pour 64 × 64). La couleur 0 est transparente. Les 6 scènes occupent exactement les 20 480 octets du fichier :

| Scène | Écran | Début | Images | Animation |
| --- | --- | --- | --- | --- |
| 1 | HERO1 | 0x0000 | 4 de 16 × 16 | une flamme en (260, 104), 24 images |
| 2 | HERO2 | 0x0280 | 3 de 32 × 64 | feu en (134, 88), 10 tours |
| 3 | HERO4 | 0x1180 | 4 de 64 × 64 | visage qui parle en (128, 32) |
| 4 | HERO6 | 0x3980 | 16 de 16 × 16 | 4 sprites sur la table (bougies, parchemin), 30 images |
| 5 | HERO3 | 0x4380 | 12 de 16 × 16 | 2 sprites, 30 images |
| 6 | HERO7 | 0x4B00 | 8 de 16 × 16 | un sprite en (65, 120), qui finit en boucle sur ses 2 dernières images |

`extraire.py` les range dans `original/donnees/images/anims/` et `original/donnees/anims.json` (positions et boucles).

## Gros plan du combat

`animation_combat` (0x1F14) joue deux séquences en parallèle, une image toutes les 50 unités de `sub_4687` (la première attend 500) : celle du héros, dessiné de dos, et celle du monstre. Données extraites par `extraire.py` dans `original/donnees/combat.json` et `original/donnees/images/combat/men-NN.png`.

Poses du héros : 31 images de MEN.VGA, qui couvrent tout le fichier décompressé (31 832 octets). Tables DS:A0FD (position dans MEN), DS:A13B (largeur, hauteur), DS:A179 (position à l'écran).

| Poses | Taille | Contenu |
| --- | --- | --- |
| 0 à 3 | 24 × 40 | barbare |
| 4 à 7 | 24 × 40 | elfe |
| 8 | 24 × 40 | enchanteur |
| 9 à 12 | 24 × 40 | Sir Ragnar |
| 13 à 17 | 32 × 40 | nain |
| 18 à 24 | 32 × 40 | barbare, enchanteur lançant un sort, Sir Ragnar, elfe |
| 25 à 29 | 32 × 20 | héros à terre : barbare, elfe, nain, enchanteur, Sir Ragnar |
| 30 | 24 × 33 | nain |

Séquence d'attaque de chaque héros (DS:A381, 7 octets) : trois poses aller-retour, par exemple 0, 1, 2, 2, 1, 0 pour le barbare (nain 13 à 15, elfe 4 à 6, enchanteur 8, 19, 20, Sir Ragnar 9 à 11). Avec une arme lancée (DS:A3A4), le héros ne bouge pas et un projectile (ODDS&SOD 0x8EE6, 16 × 16) part de (224, 37) : chaque code FEh le déplace de 8 pixels à droite et 4 vers le haut.

Le monstre : position par classe (DS:A1B7) et 4 séquences par classe (classes 0 à 7 ; la classe 9 prend celles de la classe 1, les autres au-delà de 7 celles de la classe 7). Les numéros d'image renvoient à la table des personnages (DS:4F38, 4 octets par image). Touché sans mourir (DS:A1D9) : deux images d'attaque en balancement ; tué (DS:A1E9) : puis les images 120 à 125 (disparition) ; contre une arme lancée (DS:A1F9, DS:A209), le monstre reste immobile pendant le vol.

Codes des séquences : FFh fin, 7Dh image inchangée, FEh projectile déplacé.

## Affichage

Le jeu dessine dans un tampon hors écran (segment 0x1463), puis l'envoie à l'écran :

| Routine | Effet |
| --- | --- |
| `efface_tampon` | remplit le tampon |
| `fond_vers_tampon` | recopie l'écran de fond (segment DS:5E23 : BOOK, BORDERED...) dans le tampon |
| `copie_image` | dessine une image dans le tampon (BP largeur, CX hauteur, SI source, DI = y × 320 + x) |
| `affiche_tampon` | envoie le tampon à l'écran |
| `sauve_tampon` | garde une copie du tampon (segment DS:5E35, nommé `seg_furn` car il sert d'abord à FURN) |
| `restaure_tampon`, `restaure_rect` | recopie la copie dans le tampon, en entier ou un rectangle (BP largeur, CX lignes, DI) |
| `affiche_tampon_rideau` | envoie le tampon en 50 étapes de 4 lignes, de haut en bas |

Chacune existe en plusieurs versions selon `mode_video`, par une table de saut ; la version VGA est l'entrée d'index 8 (par exemple 0x6148 pour `affiche_tampon`).

Le curseur est un sprite de 16 × 16 décrit en DS:47E5 : `curseur_dessine` le dessine dans le tampon, `curseur_efface` remet le fond depuis la copie DS:5E35 après `affiche_tampon`. L'image est en DS:47F1 : 2C20h pour la flèche, 2D20h pour le viseur.

## Messages

`affiche_message` (0x88ED) ouvre une boîte de dialogue. BX est le numéro du message : l'offset de son entrée dans la table du début du fichier de textes, chargé (décompressé) en DS:5FC1 par `charge_donnees`. Les messages français sont listés dans `original/donnees/textes/french-messages.txt` (300 entrées, numéros tels que passés dans BX), et le listing affiche le texte à côté de chaque appel.

Format d'une entrée :

| Octets | Contenu |
| --- | --- |
| 0-3 | colonne, ligne, largeur, hauteur de la boîte, en caractères de 8 pixels |
| boutons, jusqu'à FFFFh | pour chaque bouton : colonne et ligne (2 octets), offset du libellé dans le fichier de textes (mot), numéro du bouton (mot) |
| texte | lignes `11h, ligne, colonne, texte`, puis 00h |

La plupart des messages ont un seul bouton, « OK » (libellé 0x3673, numéro 0). Un menu en a plusieurs : par exemple le génie (« REVELER LE CONTENU DE LA PIECE » en 0x159F, « D'ATTAQUER QUELQU'UN » en 0x15C1, « ANNULEZ » en 0x3679). Le choix est rendu dans `choix_menu` (DS:AB7A) : le rang du bouton dans le menu (0, 1...), ou FEh pour le bouton droit.

133 entrées sont de simples chaînes : noms des objets et du mobilier, libellés, « JE COMPRENDS MENTOR ». Une entrée peut continuer dans la suivante : le message s'arrête au 00h final, pas au début de l'entrée suivante (par exemple la carte trésor 8, dont le jeu écrit le montant au début de l'entrée 0x1B2).

La boîte s'ouvre comme un parchemin : deux barres (`rouleau_haut`, `rouleau_bas`, DS:AD20 et DS:AD22) s'écartent de 4 pixels par étape, et ce qui est hors des barres reste caché. La fermeture refait le mouvement en sens inverse. Ensuite `vue_a_refaire` (DS:3F97) vaut 1.

`affiche_texte` (0x317C) écrit un texte pointé par BP, caractère par caractère (`affiche_caractere`, police 8 × 8 en DS:3113, grille de 40 × 25). Codes de contrôle : 01h segment de destination (DS:3756), 10h encre et fond (DS:3750, DS:3751), 11h ligne puis colonne, 12h colonne puis ligne + 4. `texte_transparent` (DS:3759) à 1 ne dessine pas le fond.

## Vue de la zone

La vue isométrique montre une fenêtre de 6 × 5 cases dont l'origine est le coin de la zone du héros (`coin_zone`, DS:3FE0, tiré de `zones_revelees`). `redessine_vue` (0x0526) refait tout : fond, `affiche_zone_heros`, portrait, icônes, puis les personnages (`place_personnages`).

1. `affiche_zone_heros` parcourt les 30 cases dans l'ordre de `ordre_cases_vue` (DS:49D6), du fond vers l'avant, et ne dessine que celles de la zone (`dessine_case_vue`) : dalle (`dessine_sol_case`), murs du haut et de gauche copiés dans le fond (`murs_case_vue`), occupant en sprite (`sprite_occupant`), liseré vers les zones voisines (`bords_zone`), portes du côté droit et du bas en sprites.
2. Murs : 24 × 52, le mur gauche en (x, y − 39), le mur haut en (x + 24, y − 40) ; deux variantes par côté (`variante_mur`, DS:4482). Portes : 24 × 44. Une porte secrète non trouvée est dessinée en mur.
3. Les sprites (`sprites`, DS:4BC6, 14 de 23 octets, les 4 héros d'abord) sont triés par profondeur (`ordonne_sprites`) : 3 × rang de la case (`rang_cases_vue`, DS:4A11), + 1 pour un occupant, + 2 pour une porte. Un sprite animé suit un script (+0Ah) : FCh fige, FDh éteint, FEh saut, FFh déplacement x, y.
4. Meubles : l'image est décompressée en DS:0E5C et son code gardé en `meuble_cache` (DS:0E58). Le second cache (DS:0E5A, image en DS:1FF0) n'est jamais renseigné : tout autre meuble fait décompresser FURN à chaque dessin. Comme les sprites ne sont dessinés qu'après la préparation de toute la zone, à partir de 3 types de meubles dans une zone, les types 2 et suivants montreraient tous la dernière image décompressée. Défaut latent : aucune zone des 24 quêtes n'a plus de 2 types de meubles (0x4B et plus), 6 en ont 2.

## Carte et désignation d'une cible

`dessine_carte` (0x1A50) affiche le parchemin MAPS (256 × 197 en (32, 2)), puis la grille 26 × 19 en tuiles 8 × 8 depuis (56, 16) : sols, murs, occupants, puis les personnages. Seules les cases vues (bit 0x40 de `grille_zones`) sont montrées. La carte sert au génie, au tour de Morcar et à la désignation d'une cible.

Pour l'attaque, les sorts et le regard, `plateau_ciblage` ouvre la carte avec le viseur pour curseur, et l'icône d'annulation en (224, 180) quand `carte_cible` (DS:3F91) vaut 1. `designe_case` nomme ce qui est sous le curseur (monstre, mobilier ou héros) ; les pièges et le portail (0x32 à 0x37) s'affichent comme une case vide. Un clic pose `cible_validee` (DS:3F9D).

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

## Sauvegarde des personnages

`sauvegarde_menu` (0x7954), bouton disquette de l'écran des héros. Le menu (message 0x0C) propose :

| Choix | Effet |
| --- | --- |
| 0 SAUVEGARDEZ LE PERSONNAGE | lit QUEST.SAV (le crée par `sauve_quest_sav` s'il manque), montre les 8 emplacements du type du héros sélectionné, copie son nom (16 octets) et sa fiche (26 octets) dans l'emplacement choisi, puis réécrit le fichier (0x560 octets) |
| 1 CHARGEZ LE PERSONNAGE | lit QUEST.SAV, montre les 8 emplacements, recopie le nom et la fiche choisis dans le héros sélectionné ; « IL Y A UNE ERREUR DE DISQUETTE » si le fichier manque |
| 2 ANNULEZ, ou bouton droit | retour à l'écran des héros |

La liste des emplacements (`liste_emplacements`, message 0x12) affiche les 8 noms du groupe (17 octets chacun) et « ANNULEZ ». Le fichier est lu dans le segment de SHOPMP, que le jeu recharge ensuite. Format de QUEST.SAV : [FORMATS.md](../../../HeroQuest%20(1991%20Gremlin)/FORMATS.md#questsav).

Une erreur d'écriture répète le message d'erreur et l'écriture jusqu'à ce qu'elle réussisse.
