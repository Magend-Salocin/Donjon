# Règles de QUEST.EXE

Ce que fait le jeu pendant une quête : tour d'un personnage, panneau d'icônes, événements de quête, monstres. Les dés, le déplacement, l'attaque du héros et la pioche des trésors sont décrits dans [FORMATS.md](../../../HeroQuest%20(1991%20Gremlin)/FORMATS.md#code-du-jeu-règles) ; la boucle des tours dans [02-ecrans.md](02-ecrans.md#une-partie).

État : structure du tour, panneau, événements, fouilles scriptées, sorts et monstres lus ; plusieurs champs et résultats restent à confirmer au débogueur (marqués « ? »).

## Fiche d'un personnage (26 octets, DS:4663 + 26 × n)

| Octet | Contenu |
| --- | --- |
| +0 | 0 = place vide (le personnage ne joue pas) |
| +1, +2 | x, y sur le plateau |
| +3 | zone (pièce ou couloir) où il se trouve |
| +6 | points de corps (0 : mort ; remis à la valeur de DS:4394 par `heros_renouvele`) |
| +7 | points d'esprit (confirmé par QUEST.SAV : elfe neuf 6 et 4, enchanteur 4 et 6) |
| +8 | rôle à trouver |
| +9, +0x0A | or, sur 16 bits |
| +0x0B, +0x0C | sorts connus, un bit par sort : sorts 1 à 6 dans +0x0B, 7 à 12 dans +0x0C |
| +0x0D | bit 2 : rôle à trouver (lu au début du tour) |
| +0x0E, +0x0F | équipement acheté, un bit par objet (voir l'armurerie dans [02-ecrans.md](02-ecrans.md#armurerie)) ; le bit 0x2000 (+0x0F bit 0x20) empêche l'attaque (?) |
| +0x14, +0x15 | dés d'attaque et de défense (barbare 3 et 2, nain et elfe 2 et 2, enchanteur 1 et 2) |
| +0x16 | sort choisi (1 à 12, 0 = aucun) |
| +0x18 | effets de sorts : 1 voile de brume (ignoré par les monstres), 2 endormi, 4 passe son tour (tempête), 8 déplacement doublé (vent rapide), 0x10 deux dés d'attaque de plus (courage), 0x20 ou 0x80 passe à travers un mur (traversée de la roche), 0x40 deux dés de défense de plus (peau de pierre) |
| +0x19 | type de héros : 0 barbare, 1 nain, 2 elfe, 3 enchanteur (4 : Sir Ragnar, 5e fiche) |

Noms par défaut (DS:45E5, 16 octets chacun) : SIGMAR, GRUNGI, LADRIL, ZOLTAR, RAGNAR. La 5e fiche est donc bien Sir Ragnar, le chevalier escorté. Les fiches sont sauvegardées dans QUEST.SAV ([format](../../../HeroQuest%20(1991%20Gremlin)/FORMATS.md#questsav)).

## Tour d'un personnage

`tour_personnage` (0x0349) :

1. Pose le type de commande du joueur, remet à zéro les dés de déplacement et l'état du tour.
2. Endormi (+0x18 bit 2) : un dé ; sur un 6, message « VOUS VOUS REVEILLEZ D'UN SOMMEIL PROFOND » et le personnage joue ; sinon son tour s'arrête.
3. Boucle d'événements jusqu'à la fin du tour (DS:3F9A) : lecture des commandes, bouton droit, mise à jour et dessin des icônes, du plateau et du curseur, `evenements_quete`, test de fin de quête. Le bit 0x40 des commandes interrompt la partie.

## Panneau d'icônes

12 icônes, décrites en DS:4277 (12 octets chacune) : taille, état, position à l'écran, image dans ODDS&SOD. L'état choisit l'image : normale (+0x1800 dans ODDS&SOD), enfoncée (état 0x1C, +0x0C00) ou grisée ; 0xFF cache l'icône.

| Icône | Identification | Règle d'état |
| --- | --- | --- |
| 1 (DS:4283) | attaque | enfoncée : `mode_attaque` attend un clic sur une cible |
| 4 et 10 | fouilles (trésor, portes, pièges ?) | grisées si un monstre réveillé est dans la zone |
| 6 à 9 (DS:42BF) | 4 directions de déplacement | grisée si un mur ou un objet bloque ce côté |
| 11 (DS:42FB) | sorts | cachée pour le barbare, le nain et le 5e personnage |

Les positions à l'écran ne sont pas dans le fichier : la table est remplie à l'exécution. À relever au débogueur (`D` sur DS:4277 pendant un tour).

## Événements de quête

`evenements_quete` (0x0480) affiche, selon la quête, un message quand un drapeau d'événement (DS:3FBF, DS:3FC0) a été posé ailleurs (par l'entrée dans une zone, sans doute à partir des numéros d'événement par zone de QUESTn.BIN) :

| Quête | Message |
| --- | --- |
| 1 | 0x94 « VOUS AVEZ TROUVE SIR RAGNARD. UNE ALARME A AVERTI TOUS LES GARDES... » |
| 6 | 0xC4 « KARLEN EST LE ZOMBI... » |
| 9 | 0xDE « L'OR TROUVE DANS LA MINE ETAIT FAUX » ; aussi un message mis en attente (DS:3FEA) |
| 15 | 0x22C « C'EST UNE PIECE TOURNANTE. ATTENTION EN LA QUITTANT » |
| 16 | 0x234 « LA BRUME DE LA MORT HANTE CES SALLES » |

Les numéros de quête du code (`numero_quete`, DS:3F92) commencent à 0 : la quête 1 du code est la 2e du jeu (Sir Ragnar), la 6 la 7e (Le chasseur de pierres, Karlen), la 9 la 10e (Château des mystères, la mine d'or). Les trois messages le confirment. Les quêtes 15 et 16 du code sont donc les 16e et 17e du jeu (Les salles glacées, Les couloirs silencieux).

## Fouilles scriptées

Chaque zone de la quête a un numéro d'événement de fouille : les octets 1036 à 1078 de QUESTn.BIN, recopiés en DS:4B9B (`evenement_par_zone`). Quand un héros fouille la zone, le jeu appelle la routine numéro − 1 de la table `evenements_fouille` (DS:5A89, 30 routines), puis met le numéro à FFh : l'événement ne se produit qu'une fois.

Routines identifiées dans la table : `fouille_vide`, `coffre_potion`, `coffre_fleche`, `coffre_desarme`, `coffre_gargouille`, `cles_agrain`, `prend_lame_esprit`. Exemple : dans la 2e quête du jeu, la zone 0x15 a l'événement 6 et la zone 0x27 l'événement 2. C'est ce qui manquait à donjon-v2 pour les objets et passages scriptés (quêtes 5 et 10).

## Sorts

Les 12 sorts du jeu de plateau, numérotés par élément, trois par trois. Leurs messages sont les numéros 0x24 à 0x8E de `french-messages.txt`.

| N° | Élément | Sort | Routine | Effet |
| --- | --- | --- | --- | --- |
| 1 | Eau | Voile de brume | `sort_brume` | fiche +0x18 bit 1 : les monstres ignorent le héros |
| 2 | Eau | Eau de guérison | `sort_guerison` | +4 points de corps, sans dépasser le départ (DS:4394) |
| 3 | Eau | Sommeil | `sort_sommeil` | un dé ; sauf bouclier blanc, la cible s'endort (« L'ENNEMI S'EFFONDRE ET S'ENDORT SUR PLACE ») |
| 4 | Air | Tempête | `sort_tempete` | la cible passe son prochain tour |
| 5 | Air | Vent rapide | `sort_vent` | déplacement doublé au prochain tour |
| 6 | Air | Génie | `sort_genie` | menu « ORDONNEZ AU GENIE DE » : attaquer quelqu'un (5 dés de combat) ou révéler le contenu de la pièce (effet 13, `sort_genie_revele`) |
| 7 | Feu | Courage | `sort_courage` | deux dés d'attaque de plus |
| 8 | Feu | Boule de feu | `sort_boule_feu` | deux dés : 2 points de dégâts, moins un par bouclier blanc |
| 9 | Feu | Feu de colère | `sort_feu_colere` | un dé : 1 point de dégât, sauf bouclier blanc |
| 10 | Terre | Traversée de la roche | `sort_traverse_roche` | passer à travers un mur au prochain déplacement |
| 11 | Terre | Peau de pierre | `sort_peau_pierre` | deux dés de défense de plus |
| 12 | Terre | Guérison du corps | `sort_guerison` | comme l'eau de guérison |

Écart avec le jeu de plateau : la résistance au sommeil et aux sorts de feu se joue sur un ou deux dés de combat (bouclier blanc), et non sur les points d'esprit de la cible.

Les sorts sont sans effet sur le Sorcier-Roi : avant l'effet, le jeu teste le type de la cible (champ +9 du monstre : 0x0C ou 0x0D avant la quête 15 du code, 0x0E ensuite) et affiche « CE SORT N'A AUCUN EFFET SUR UN ENNEMI ».

`action_sort` (0x2C74), quand l'icône des sorts (icône 11) est enfoncée :

1. Ouvre `inventaire_sorts` en mode 5 (DS:AD67) : le joueur choisit un sort, rangé dans la fiche (+0x16).
2. Lit les propriétés du sort dans `proprietes_sorts` (DS:4387, un octet par sort : 1, 1, 3, 3, 1, 3, 1, 3, 3, 1, 1, 3) : bit 1 = peut viser un personnage, bit 2 = peut viser un ennemi (?).
3. Attend un clic sur la cible ; la zone (224, 180)-(240, 196) annule.
4. Range la routine d'effet du sort (table `effets_sorts`, DS:5A6F, 13 entrées : les 12 sorts, puis le génie qui révèle la pièce ; le menu du génie, dans l'inventaire, remplace le sort 6 par 13) dans DS:4097, puis l'appelle (`jmp [0x4097]`, en 0x0F01) ; l'effet affiche son message par `sort_message`. Sans cible valide : « CE SORT N'A AUCUN EFFET SUR UN ENNEMI. IL A ETE GASPILLE ».
5. `retire_sort` efface le bit du sort dans la fiche : chaque sort ne sert qu'une fois par quête, comme dans le jeu de plateau.

## Monstres

`tour_morcar` joue les 32 monstres de DS:4D4A (10 octets, même format que dans QUESTn.BIN : +1 x, +2 y, +3 zone, +4 case, +6 drapeaux).

`tour_monstre` (0x2217) :

1. Rien si le monstre n'existe pas ou porte le bit 0x80.
2. Octet +6 : bit 1 = réveillé (sinon il ne joue pas) ; bit 4 = endormi, il ne se réveille que sur un 6 ; bit 2 = passe ce tour.
3. Pour chacun des 5 personnages, `monstre_vise` : le personnage doit être dans la même zone et ne pas porter le bit 1 de +0x18. Le monstre calcule alors un chemin vers lui (pas dx, dy rangés en DS:40A2, leur nombre en DS:3FA9). Si le résultat (DS:3FA8) vaut 0 ou 3, le monstre agit : il avance pas à pas sur le chemin (`monstre_avance`, 0x24CE), en mettant à jour la grille des occupants (DS:586F).
4. Quête 16 : la brume de la mort se déplace de 6 cases par tour, par une table de routines (DS:4657).

À lire : le reste de `monstre_vise` (distance, attaque quand le monstre est au contact, `attaque_contre_heros`).

## Plateau en mémoire

La quête en cours semble rangée à partir de DS:546F : zone de chaque case, puis (+0x200) codes des objets (éboulis, pièges, escalier, meubles), et une grille des occupants en DS:586F. `index_case` (0x607E) donne l'index d'une case à partir de (x, y). À confirmer en comparant avec QUESTn.BIN au débogueur.
