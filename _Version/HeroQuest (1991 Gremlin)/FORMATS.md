# HeroQuest PC (Gremlin, 1991) : formats des fichiers

Notes de rétro-ingénierie faites en octobre 2026 pour Donjon v2. Elles permettent de reprendre le travail sans tout redésassembler. Les scripts qui appliquent ces formats sont dans `donjon-v2/bin/` :

| Script | Rôle |
|---|---|
| `import-heroquest.py` | `QUESTn.BIN` vers les cartes `quest101` à `quest124` (JS et image vue de dessus) |
| `extract-heroquest-graphics.py` | Sprites vers `public/assets/game/iso/atlas.png` et `atlas.js` (vue isométrique) |
| `heroquest-outils.py` | Exploration : décompression, planche, textes, désassemblage, recherche, vidage du segment de données, export du catalogue des images |

Les décompresseurs EXEPACK et LZ sont écrits une seule fois, dans `extract-heroquest-graphics.py` (`exepack_unpack`, `vga_unpack`), et réutilisés par `heroquest-outils.py`.

## Démarrage rapide

Depuis `donjon-v2`, avec `J="../_Version/HeroQuest (1991 Gremlin)"` (prérequis : `pip install pillow capstone`) :

```bash
python bin/heroquest-outils.py exe "$J/QUEST.EXE" quest.bin      # image mémoire décompressée, base de tout le reste
python bin/heroquest-outils.py planche "$J/BOOK.VGA" 320 book.png # écran 320 x 200 avec la vraie palette
python bin/heroquest-outils.py textes "$J/FRENCH.BIN"             # 544 textes du jeu en français
python bin/heroquest-outils.py desasm quest.bin 45d1 40           # décompresseur LZ
python bin/heroquest-outils.py ds quest.bin 43fc 128              # table des meubles
python bin/heroquest-outils.py cherche quest.bin c70607397c5e     # où le jeu charge furn.vga
```

## Les exécutables

- `HERO.EXE` lance `INTRO.EXE` puis `QUEST.EXE`.
- Les trois sont compressés avec **Microsoft EXEPACK** : signature `RB` dans l'en-tête placé à `CS:0` (CS initial de l'en-tête MZ). Les commandes sont lues de la fin vers le début : `0xB0`/`0xB1` = remplir (longueur sur 2 octets, puis l'octet), `0xB2`/`0xB3` = copier ; le bit 0 marque la dernière commande. Le code désassemblé avant décompression est trompeur : une partie seulement est en clair.
- Code assembleur écrit à la main, sans table de relocation ni bibliothèque Borland.

### QUEST.EXE décompressé (83 504 octets)

Toutes les adresses ci-dessous sont des positions dans cette image.

| Élément | Où |
|---|---|
| Segment de code | CS = début de l'image, IP = position : point d'entrée 0x00ED ; les tables de saut (par exemple DS:0x3726) contiennent directement des positions. INTRO.EXE est organisé à l'inverse : données en tête (DS = 0), code à partir de 0x44B0 (CS = 0x044B) |
| Segment de données | DS = ES = 0x097C, donc **DS:x = position 0x97C0 + x** |
| Routine d'ouverture, lecture, écriture des fichiers | paramètres en DS:0x3901 (segment), 0x3903 (offset), 0x3905 (taille), 0x3907 (nom) |
| Chargement des graphismes (noms et segments de destination) | autour de 0x5175 (furn.vga) |
| Décompresseur LZ | 0x45D1 (source DS:SI, destination ES:DI) |
| Passage en mode 13h et palette (`int 10h`, AX = 0x1012) | 0x5FF8, palette en DS:0x5B23 |
| Choix du sprite d'un meuble | 0x1411 (code − 0x4B) × 6 + DS:0x43FC |
| Dessin des sols (48 × 24) et des murs (24 × 44 et 24 × 52) | autour de 0x17A5 et 0x1740 |

Noms des fichiers en DS (chaque nom est précédé d'un octet) : book.vga 0x5E37, monsters 0x5E40, sprites 0x5E4D, odds&sod 0x5E59, maps 0x5E66, graphics 0x5E6F, furn 0x5E7C, shopsp 0x5E85, shopmp 0x5E90, bordered 0x5E9B, wizback 0x5EA8, invent 0x5EB4, spellit 0x5EBF, men 0x5ECB ; versions .ega à partir de 0x5ED3 ; quest.sav 0x5FB3.

Segments où sont rangés les graphismes décompressés (mots en DS) : 0x5E29 monsters, 0x5E2B graphics, 0x5E2D odds&sod, 0x5E2F furn (fichier brut), 0x5E35 furn décompressé.

## Compression LZ des .VGA et des textes

Routine 0x45D1. Un octet de commande `b`, puis :

| `b` | Effet |
|---|---|
| `0x00` | fin |
| `0x01`-`0x1F` | copier `b` octets tels quels |
| `0x20`-`0x3F` | copier `(b & 0x1F) × 256 + octet suivant + 0x20` octets tels quels |
| `0x40`-`0x5F` | répéter l'octet suivant `(b & 0x1F) + 3` fois |
| `0x60`-`0x7F` | répéter `(b & 0x1F) × 256 + suivant + 0x24` fois l'octet d'après |
| `0x80`-`0xBF` | recopier `n + 1` octets déjà écrits, `n` = 2 si `b & 0x20` sinon 1, à partir de `fin − 1 − (b & 0x1F) − n` |
| `0xC0`-`0xFF` | `n = ((b & 0x3F) >> 2) + 3`, distance `d = (b & 3) × 256 + suivant`, recopier `n + 1` octets depuis `fin − 1 − d − n` |

Format confirmé sur tous les .VGA sauf `ANIMS.VGA` (non compressé : images sur 5 plans de bits, voir les notes du remake, « Intro »), et sur `ENGLISH.BIN`, `FRENCH.BIN`, `GERMAN.BIN`, `ITALIAN.BIN`, `SPANISH.BIN`.

## Palette

256 couleurs VGA sur 6 bits (0-63) en DS:0x5B23 de QUEST.EXE ; multiplier par 4 (ou × 255 / 63). Indice 0 = transparent dans les sprites. Les écrans de l'intro utilisent sans doute la palette de `INTRO.EXE` (à vérifier dans son image décompressée).

## Contenu des .VGA (après décompression)

Images 8 bits rangées les unes après les autres, sans en-tête : il faut les tables de QUEST.EXE pour les découper.

| Fichier | Taille | Contenu |
|---|---|---|
| BOOK | 64 000 | écran 320 × 200 du plateau : le livre et Morcar |
| BORDERED | 64 000 | fond aux crânes des menus et de l'armurerie, avec son cadre |
| WIZBACK | 64 000 | Morcar et le rideau rouge (messages du maître du jeu) |
| QUESTB | 64 000 | parchemin des briefings de quête |
| HERO1-7, PIC1, TEXT1, GREMLIN | 64 000 | écrans de l'intro (palette de INTRO.EXE, non vérifiée) |
| GRAPHICS | 49 920 | sols, murs, portes (voir ci-dessous) |
| FURN | 62 592 | meubles (table DS:0x43FC) |
| SPRITES | 57 024 | héros sur le plateau (table DS:0x4FA8) |
| MONSTERS | 53 152 | monstres (table DS:0x5098) |
| ODDS&SOD | 25 952 | portraits du panneau de jeu, objets, icônes des actions (voir « Écrans et interface ») |
| MAPS | 61 248 | carte de la quête : parchemin et tuiles de couleur |
| SHOPMP | 49 088 | cartes de sort, icônes du menu titre, logo |
| SHOPSP | 57 344 | objets de l'armurerie et portraits de sélection des héros |
| INVENT | 51 776 | cartes de catégorie et objets de l'armurerie |
| SPELLIT | 12 288 | 12 objets 32 × 32 (potions, sac, mortier, bougie, livre…) |
| MEN | 31 832 | 31 poses des héros en combat, de dos, et à terre (tables DS:A0FD, A13B, A179 ; voir les notes du remake, « Gros plan du combat ») |

Les offsets de « Écrans et interface » viennent des appels à la routine de copie d'image 0x3B53 (BP = largeur, CX = hauteur, SI = source, segment source en DS:0x374E). Les fichiers passent par un tampon (segment 0x1463), puis sont décompressés dans un segment rangé en DS : 0x5E23 écran courant, 0x5E25 SHOPSP, 0x5E27 MAPS, SHOPMP, MEN, INVENT ou SPELLIT selon l'écran, 0x5E29 MONSTERS, 0x5E2B GRAPHICS, 0x5E2D ODDS&SOD. `heroquest-outils.py catalogue` exporte toutes ces images en PNG (327 images).

### GRAPHICS.VGA

- 0x0000 à 0x7E00 : dalles 48 × 24 (0x480 octets chacune). 0x0000, 0x0480, 0x0900, 0x0D80 = quarts de l'escalier ; 0x1200 = éboulis ; 0x1680 = dalle du code 0x33 (fosse révélée) ; 0x1F80 = pavés des couloirs ; les autres sont les sols des pièces.
- 0x7E00, 0x82E0, 0x87C0, 0x8CA0 : murs 24 × 52 (les deux premiers pour le côté gauche « / », les deux autres pour le côté haut « \ »).
- 0x9180 à 0xC300 : 12 portes 24 × 44, par paires gauche/haut : porte fermée, porte secrète, porte fermée 2, arche ouverte, puis porte et arche violettes.
- Sol de chaque zone : 43 mots en DS:0xA543 (zone 0 à 42 ; zones 1 à 20 = couloirs, 21 à 42 = pièces, sol fixe par pièce).
- Sol des codes d'objets 0x30 à 0x3B : mots en DS:0x50D0 + 2 × code (0xFFFF = sol normal, c'est le cas des pièges cachés).

### Tables de sprites

- Meubles, DS:0x43FC, 6 octets par code 0x4B à 0x5F : largeur, hauteur, dx, dy (signés, décalage d'affichage dans une unité non identifiée), position dans FURN. Les codes 0x51 et 0x52 sont vides.
- Personnages, à partir de DS:0x4F80, 4 octets : largeur, hauteur, position. Héros (SPRITES), 12 images chacun (6 de face, 6 de dos) : barbare 0x4FA8, nain 0x4FD8, elfe 0x5008, magicien 0x5038, guerrier 0x5068. Monstres (MONSTERS), 4 images d'attaque chacun : gobelin 0x5098 (24 × 32), orc 0x50A8 (32 × 32), fimir 0x50B8 (32 × 40), guerrier du chaos 0x50C8 (32 × 48), squelette 0x50D8 (32 × 44), zombie 0x50E8, momie 0x50F8 (24 × 40), gargouille 0x5108 (32 × 50), boule de feu 0x5118 (24 × 38).

## Écrans et interface

Positions en hexadécimal dans le fichier décompressé ; les images d'une série se suivent.

| Fichier | Position | Taille | Contenu |
|---|---|---|---|
| MAPS | 0x0000 | 256 × 197 | parchemin de la carte de quête |
| MAPS | 0xC500 | 8 × 8, 169 tuiles | couleurs des sols pour dessiner la carte |
| ODDS&SOD | 0x0000 | 32 × 45, pas 0x5A0 | portraits du panneau de jeu : barbare, nain, elfe, magicien, guerrier (table DS:0x41E8) |
| ODDS&SOD | 0x1C20 | 32 × 32, 6 | bouclier, lame, épée… |
| ODDS&SOD | 0x3420 à 0x6020 | 16 × 16 | icônes des actions et des objets, avec leurs états allumé et éteint (découpage par endroits imparfait) |
| ODDS&SOD | 0x58A0 | 8 × 8 | petits symboles ; chiffres 8 × 12 dessinés en 0x4F96 |
| ODDS&SOD | 0x6320 | 24 × 24 | cadre |
| SHOPMP | 0x0000 | 48 × 64, 4 | cartes de sort Eau, Air, Feu, Terre |
| SHOPMP | 0x3000 | 48 × 64, 4 | icônes du menu titre : plateau, héros, armurerie, parchemin |
| SHOPMP | 0x7800 | 48 × 12 | « IN PLAY » |
| SHOPMP | 0x7A40 | 32 × 16 | flèche rouge |
| SHOPMP | 0x7C40 | 224 × 68 | logo HeroQuest |
| SHOPMP | 0xB7C0 | 16 × 16, 8 | bordure |
| SHOPSP | 0x0000 | 32 × 32, 23 | objets de l'armurerie |
| SHOPSP | 0x5C00 | 32 × 32 | cadre d'objet |
| SHOPSP | 0x6000 | 32 × 48 | images de l'armurerie (non découpées) |
| SHOPSP | 0x8000, 0xB000 | 48 × 64, 4 + 4 | portraits de sélection des héros, en gris puis en couleur |
| INVENT | 0x0000 | 64 × 94, 3 | cartes de catégorie : armes, potions, coffre |
| INVENT | 0x4680 | 32 × 32, 23 | armes, armures, potions |
| INVENT | 0xA280 | 32 × 32 | case vide ; 0xA680 à 0xC680 non identifié |
| INVENT | 0xC680 | 16 × 20, 3 | crochets du cadre |
| SPELLIT | 0x0000 | 32 × 32, 12 | objets |
| MEN | 0x0000 à 0x7C58 | 24 × 40, 32 × 40, 32 × 20 | 31 poses, découpage exact dans `combat.json` du remake |

Routines utiles : écran de sélection des héros autour de 0x7755 (portraits SHOPSP, pas 0xC00), menu titre autour de 0x7353 (logo et icônes SHOPMP), armurerie autour de 0x8304 et 0x8E8E (cartes INVENT), panneau de jeu autour de 0x6651 (portrait ODDS&SOD).

## Quêtes : QUESTn.BIN

Cases numérotées `y × 26 + x` sur 26 × 19.

| Position | Contenu |
|---|---|
| 0 | 494 octets : zone de chaque case (0 = hors quête, 1-20 couloirs, 21-42 pièces) |
| 512 | 494 octets : murs et portes. 0x80 mur en haut, 0x40 mur à gauche, 0x20 porte en haut, 0x10 porte à gauche ; 0x08 porte secrète, 0x04 posé par le jeu quand elle est révélée ; 0x01 est un détail de rendu du plateau standard |
| 1024 | 4 × 3 octets : départ des héros (x, y, image du personnage : 29 + 12n, plus 0, 3, 6 ou 9 selon l'orientation) |
| 1036 | 43 octets : événement de fouille de trésor par zone (0 = carte trésor, n = routine scriptée n), puis 43 octets pour la fouille des portes secrètes ; le jeu y écrit FFh quand la zone a été fouillée |
| 1122 | 6 mots : position du texte, longueur du texte, position des monstres, taille des monstres, position du mobilier, nombre d'objets (positions depuis 1122) |
| monstres | 10 octets : actif (0x81), x, y, 0, 0, 0, drapeaux, classe, type, ? Le premier enregistrement, inactif, est le monstre errant |
| mobilier | 3 octets : x, y, code ; les cases supplémentaires d'un meuble (codes 0x42 à 0x4A) suivent son code |
| texte | briefing en anglais, lignes précédées de 0x11, ligne, colonne |

Types de monstres : 0 gobelin, 1 orc, 2 fimir, 3 guerrier du chaos, 4 squelette, 5 zombie, 6 momie, 7 gargouille, 8 Ulag, 9 Grak, 10 Balur, 11 et 12 le Sorcier-Roi, 20 à 26 boss de l'extension.

Codes du mobilier : 0x30 et 0x31 éboulis, 0x32 fosse cachée, 0x33 fosse révélée, 0x34 chute de pierre, 0x35 chute de pierre sans effet, 0x36 lance (effets : notes du remake, `03-regles.md`, « Pièges »), 0x37 portail magique, 0x38-0x3B escalier ; puis par paire d'orientations 0x4B/0x4C table, 0x4D/0x4E chevalet, 0x4F/0x50 établi d'alchimiste, 0x53 tombeau, 0x54/0x5A armoire, 0x55/0x5B râtelier d'armes, 0x56/0x58 bibliothèque, 0x57/0x59 cheminée, 0x5C/0x5D coffre, 0x5E/0x5F trône. Les pièges ont été identifiés en comparant leur nombre par quête avec les quêtes du remake HeroQuest en C# (quêtes 1 à 14).

## Autres fichiers

- `EQUESTS.BIN` : titres des 24 quêtes en 5 langues, en clair (non compressé).
- `FRENCH.BIN` et les autres langues : textes du jeu compressés en LZ. On y trouve les messages des événements scriptés (« VOUS AVEZ TROUVE SIR RAGNARD », coffres piégés, récompenses…).
- `GAME&FX.ALB` et `.RLD` : musique et effets AdLib, non étudiés.
- `QUEST.CFG` : configuration écrite par l'intro (mode vidéo, son, commandes, langue) ; format dans les notes du remake (`HeroQuest (1991 Gremlin)-2026/original/notes/01-socle.md`).

### QUEST.SAV

1 376 octets (0x560), sans compression : 32 personnages sauvegardés, 8 par type de héros (groupe 0 barbare, 1 nain, 2 elfe, 3 enchanteur).

| Position | Contenu |
| --- | --- |
| 0 | 32 noms de 17 octets (16 caractères, puis 00h) : groupe × 8 + emplacement |
| 0x220 | 32 fiches de 26 octets, dans le même ordre |

Une fiche a le format de celles du jeu en mémoire (DS:4663) : +6 points de corps, +7 points d'esprit, +9 or sur 16 bits, +0x0B et +0x0C sorts connus, +0x0E équipement, +0x14 dés d'attaque, +0x15 dés de défense, +0x19 type de héros (le numéro du groupe). Un emplacement vide a une fiche à zéro, mais peut garder un ancien nom. Détail des champs : notes du remake (`original/notes/03-regles.md`).

Exemple du fichier d'origine : groupe 0, emplacement 0, « BLACKHAWK », 7 points de corps, 4 d'esprit, 3 815 pièces d'or, 3 dés d'attaque, 2 de défense.

Si le fichier manque, le jeu en crée un : `sauve_quest_sav` (0x8443) écrit les 32 noms par défaut et des fiches à zéro.

## Code du jeu (règles)

État de l'étude : le hasard, les dés, le déplacement, l'attaque du héros et la pioche des trésors sont décrits ici. Le déroulement des tours, les monstres, les sorts, les objets et les événements scriptés sont dans les notes du remake (`HeroQuest (1991 Gremlin)-2026/original/notes/`). Le plateau de Donjon v2 n'utilise pas ce code : il garde ses propres règles (modules JavaScript de 2009).

### Hasard

- Graine : heure DOS (`int 21h`, AH = 2Ch) rangée en DS:0x38FD au lancement (0x5F89).
- Générateur 0x3613 : registre à décalage de 32 bits en DS:0x38FD à 0x3900. Le bit entrant est calculé à partir des bits 3 et 6 de DS:0x38FD (`and al, 0x48 ; add al, 0x38`, puis deux `rcl`), puis les quatre octets sont décalés d'un bit vers la gauche. Résultat : `(octet DS:0x38FD mod BL) + 1`, soit un nombre de 1 à BL dans AL.

### Dés

- Dé de déplacement : `0x3613` avec BL = 6.
- Dé de combat 0x21B7 : `0x6033` tire 0 à 5, puis la face est lue dans DS:0x47F9 = `00 01 02 00 01 00`, soit 0 = crâne (3 faces sur 6), 1 = bouclier blanc (2 sur 6), 2 = bouclier noir (1 sur 6), comme le dé du jeu de plateau.
- 0x5D8C : lance DH dés de combat et renvoie le nombre de crânes dans AL.
- Les résultats s'affichent avec les icônes ODDS&SOD 0x6120 (crâne) et 0x6220 (bouclier), par la routine 0x0BE6.

### Déplacement (0x672A)

Le héros lance DS:0x3FC4 dés (2 en temps normal) et la somme va dans DS:0x3F9C, le nombre de cases restant à parcourir. Une valeur supérieure à 24 est ramenée à 5 (garde-fou).

### Attaque du héros contre un monstre (0x0936)

1. Attaquant DS:0x3FD6 = héros courant DS:0x4637, cible DS:0x3FD4.
2. Le héros lance DS:0x3FB8 dés et compte les crânes, rangés en DS:0x3FD2.
3. Le monstre lance DS:0x3FBB dés et compte les boucliers noirs (face 2), rangés en DS:0x3FD3.
4. Si crânes > boucliers, le champ +7 de l'enregistrement du monstre passe à 0 (monstre touché), puis 0x1F14 applique le résultat et 0x2120 retire le monstre s'il est mort.

### Attaque d'un monstre contre un héros (0x1E90)

Le héros lance DS:0x3FB9 dés en comptant les faces **différentes** du bouclier blanc (crânes et boucliers noirs, 4 faces sur 6), le monstre lance DS:0x3FBA dés et compte les crânes. La différence, si elle est positive, est retirée des points de corps du héros (+6). Le calcul des dés et le déplacement du monstre sont décrits dans les notes du remake (`HeroQuest (1991 Gremlin)-2026/original/notes/03-regles.md`, « Monstres »).

### Pièges et cartes

Effets des pièges, cartes trésor (0x87DD : mélange des 25 cartes) et fouilles : notes du remake (`HeroQuest (1991 Gremlin)-2026/original/notes/03-regles.md`, « Fouilles » et « Pièges »).

### Variables repérées (DS)

| Adresse | Rôle |
|---|---|
| 0x4637 | enregistrement du héros courant (champ +6 points de corps, +0x19 numéro du héros) |
| 0x3FCA | numéro du héros courant |
| 0x3F92 | numéro de la quête (comparé à 4 et 11 pour des règles propres à ces quêtes) |
| 0x3F9C | cases de déplacement restantes |
| 0x3FB8 à 0x3FBB | nombres de dés d'attaque et de défense pour le combat en cours |
| 0x3FC4 | nombre de dés de déplacement |
| 0x3FD2, 0x3FD3 | crânes et boucliers du dernier lancer |
| 0x3FD4, 0x3FD6 | enregistrements de la cible et de l'attaquant |

## Pistes pour la suite

- Tours de jeu : partir de 0x672A (lancer de déplacement) et remonter les appels pour trouver la boucle principale (héros l'un après l'autre, puis Morcar) et le tour des monstres.
- Intelligence des monstres : chercher les appels de 0x1E90 depuis le tour de Morcar.

- Événements scriptés : relier les numéros d'événement par zone (position 1036 des quêtes) aux textes de `FRENCH.BIN` et au code qui les déclenche. C'est ce qui manque pour convertir les quêtes 5 (passage secret) et 10 (portails magiques), et pour les objectifs « délivrer » ou « trouver ».
- Compléter le découpage des icônes 16 × 16 d'ODDS&SOD, de SHOPSP 0x6000 et d'INVENT 0xA680.
- Écran de fond : `BOOK.VGA` (le livre et Morcar) n'est pas encore utilisé par la vue isométrique.
