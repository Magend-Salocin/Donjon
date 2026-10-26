# Règles de QUEST.EXE

Ce que fait le jeu pendant une quête : tour d'un personnage, panneau d'icônes, événements de quête, monstres. Les dés, le déplacement, l'attaque du héros et la pioche des trésors sont décrits dans [FORMATS.md](../../../HeroQuest%20(1991%20Gremlin)/FORMATS.md#code-du-jeu-règles) ; la boucle des tours dans [02-ecrans.md](02-ecrans.md#une-partie).

État : structure du tour, panneau, événements, fouilles scriptées, sorts, objets et monstres lus ; plusieurs champs et résultats restent à confirmer au débogueur (marqués « ? »).

## Fiche d'un personnage (26 octets, DS:4663 + 26 × n)

| Octet | Contenu |
| --- | --- |
| +0 | 0 = place vide (le personnage ne joue pas) |
| +1, +2 | x, y sur le plateau |
| +3 | zone (pièce ou couloir) où il se trouve |
| +6 | points de corps (0 : mort ; remis à la valeur de DS:4394 par `heros_renouvele`) |
| +7 | points d'esprit (confirmé par QUEST.SAV : elfe neuf 6 et 4, enchanteur 4 et 6) |
| +8 | image du personnage, donnée par la case de départ de QUESTn.BIN : 29 + 12n pour le héros n, plus 0, 3, 6 ou 9 selon l'orientation (?) |
| +9, +0x0A | or, sur 16 bits |
| +0x0B, +0x0C | sorts connus, un bit par sort : sorts 1 à 6 dans +0x0B, 7 à 12 dans +0x0C |
| +0x0D | artefacts possédés : 1 armure de Borin, 2 baguette de rappel (lue au début du tour), 4 talisman du savoir, 8 poison d'orc, 0x10 lame de l'esprit |
| +0x0E, +0x0F | équipement acheté, un bit par objet (voir l'armurerie dans [02-ecrans.md](02-ecrans.md#armurerie)) ; le bit 0x2000 (+0x0F bit 0x20) empêche l'attaque (?) |
| +0x10 | potions possédées : 1 force, 2 ténacité, 4 et 8 curatives, 0x10 eau bénite, 0x20 rapidité, 0x40 héroïque |
| +0x11 | arme en main (un seul bit, dans l'ordre de +0x0E) |
| +0x12 | artefacts en service (bits de +0x0D) |
| +0x13 | armures portées : 1 bouclier, 2 casque, 4 cotte de mailles, 8 armure de plates |
| +0x17 | potions bues dont l'effet dure (bits de +0x10) |
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

Chaque zone de la quête a un numéro d'événement de fouille : les octets 1036 à 1078 de QUESTn.BIN, recopiés en DS:4B70 (`evenement_par_zone`). Quand un héros cherche un trésor dans la zone, le jeu met l'octet à FFh (« CETTE PIECE A DEJA ETE FOUILLEE » la fois suivante). S'il valait 0, le héros tire une carte trésor ; sinon, le jeu appelle la routine numéro − 1 de la table `evenements_fouille` (DS:5A89, 30 routines). L'événement ne se produit donc qu'une fois.

Les octets 1079 à 1121 (DS:4B9B, `portes_fouillees`) jouent le même rôle pour la recherche des portes secrètes : FFh une fois la zone fouillée.

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
| 6 | Air | Génie | `sort_genie` | menu « ORDONNEZ AU GENIE DE » : attaquer quelqu'un (5 dés de combat) ou révéler le contenu de la pièce (effet 13, `sort_genie_revele`). Bogue : « ANNULEZ » et le bouton droit révèlent aussi la pièce, le test d'annulation (`choix_menu` = 2 et FEh à la fois) ne pouvant jamais réussir |
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

## Objets

L'inventaire ([écran](02-ecrans.md#inventaire)) liste 36 objets. Pour chacun, la table `objets_champs` (DS:AE0E) donne le champ de la fiche à modifier au clic et la valeur à y mettre :

| Objets | Champ | Règle au clic |
| --- | --- | --- |
| Potions (0 à 6) | +0x17 | voir ci-dessous ; la potion est retirée de +0x10 |
| Artefacts (7 à 11) | +0x12 | baguette de rappel et talisman : sans effet (passifs). Les autres se prennent ou se posent. L'armure de Borin retire la cotte et l'armure de plates. Le poison d'orc et la lame de l'esprit lâchent l'arme en main |
| Armes (12 à 19) | +0x11 | une seule en main ; recliquer la lâche (et remet aussi +0x12 à zéro). La hache d'armes retire le bouclier. La trousse à outils désarme un piège |
| Armures (20 à 23) | +0x13 | se portent ou s'enlèvent. Cotte et plates : une seule des deux, et elles retirent l'armure de Borin. Bouclier refusé avec la hache d'armes en main |
| Sorts (24 à 35) | +0x16 | le sort choisi ; le génie ouvre son menu ([sorts](#sorts)) |

Le personnage 4 a des restrictions dans ce code (pas d'armure, seulement le bâton et la trousse à outils, table DS:AE56), mais l'inventaire ne s'ouvre pas pour lui : elles ne servent pas. L'enchanteur n'a ici aucune restriction.

Potions :

| Potion | Effet |
| --- | --- |
| Curatives (deux emplacements) | +4 points de corps, sans dépasser le départ ; « LE FLUIDE VOUS RANIME ». Le code efface aussi les autres potions en cours (+0x17) |
| Eau bénite | tue les squelettes, zombis et momies de la pièce (types 4 à 6) ; « VOTRE EAU BENITE A TUE n », sinon « VOUS AVEZ GASPILLE VOTRE EAU BENITE » |
| Force | deux dés d'attaque de plus |
| Ténacité | deux dés de défense de plus |
| Rapidité | déplacement doublé |
| Héroïque | rallume l'icône d'attaque : le héros attaque deux fois |

Boire une potion dont l'effet dure encore : « VOUS AVEZ TOUJOURS CETTE POTION DANS LE SANG ».

Trousse à outils (`trousse_outils`) : le jeu cherche un piège (codes 0x31 à 0x36) sur la case du héros puis sur les 4 cases voisines de la même zone (table DS:4399), et l'efface. Le nain réussit toujours ; les autres lancent un dé de combat. Sur un échec, le héros perd 1 point de corps :

| Piège | Réussite | Échec |
| --- | --- | --- |
| Fosse | « VOUS POSEZ UNE TRAPPE » | « LA PIERRE ... S'EFFONDRE ... ET PERDEZ 1 POINT DE CORPS » |
| Chute de pierre (0x34, 0x35) | « VOUS DEGAGEZ LE ROCHER » | « UN ROCHER TOMBE DU TOIT SUR LA TETE DU (héros) » |
| Lance (0x36) | « ... IL VOUS A MANQUE » | « ... PIEGE A LANCES ... PERDEZ 1 POINT DE CORPS » |

Sans piège à portée : « IL N'Y A PAS DE PIEGES SUR LESQUELS VOUS POUVEZ UTILISER VOS OUTILS ». La réussite sur un dé de combat (valeur non nulle renvoyée par `de_combat`) reste à confirmer.

## Monstres

`tour_morcar` joue les 32 monstres de DS:4D4A (10 octets, même format que dans QUESTn.BIN : +1 x, +2 y, +3 zone, +4 case, +6 drapeaux).

`tour_monstre` (0x2217) :

1. Rien si le monstre n'existe pas ou porte le bit 0x80.
2. Octet +6 : bit 1 = réveillé (sinon il ne joue pas) ; bit 4 = endormi, il ne se réveille que sur un 6 ; bit 2 = passe ce tour.
3. Pour chacun des 5 personnages, dans l'ordre des fiches, `monstre_vise` cherche un chemin jusqu'à lui (ci-dessous). Le premier personnage atteignable est attaqué : le monstre avance (`monstre_avance`), puis frappe (`combat_monstre`). Sinon le monstre reste sur place.
4. Quête 16 du code (17e du jeu, Les couloirs silencieux) : la brume de la mort se déplace 6 fois par tour, par une table de routines (DS:4657).

`monstre_vise` (0x22C3) :

1. Le personnage doit exister, être dans la même zone que le monstre et ne pas porter le voile de brume (+0x18 bit 1).
2. Le chemin est en L : d'abord sur l'axe où l'écart est le plus grand, puis sur l'autre, une case à la fois vers le personnage. Chaque pas (dx, dy) est rangé en DS:40A2.
3. Chaque case testée (`case_libre`) : la case du personnage visé termine le chemin (résultat 0 : attaque) ; un autre héros, un occupant (monstre, meuble) ou une autre zone le bloque (résultat 2 : pas d'attaque). Le monstre ne contourne pas un obstacle.
4. Le déplacement du monstre (premier octet de `types_monstres`) est décompté à chaque pas, mais le test qui devrait arrêter le chemin ne peut jamais réussir (retenue d'un `add` sur un pointeur) : le chemin n'est pas limité. À confirmer au débogueur.

`combat_monstre` (0x1D8F) charge les images de combat (MEN), calcule les dés, appelle `attaque_contre_heros`, puis recharge MAPS. Les dés :

- Attaque du monstre : deuxième octet de `types_monstres` (DS:4806, 5 octets par type : déplacement, attaque, défense, routine appelée à sa mort).
- Défense du héros (`calcule_defense_heros`, 0x0B8B) : +0x15, remplacé par 4 avec l'armure de Borin ou l'armure de plates, 3 avec la cotte de mailles ; +1 avec le bouclier, +1 avec le casque ; +2 avec la potion de ténacité ou la peau de pierre, effets consommés par cette défense. Aucun dé si +0x0F bit 0x20 est posé (?).
- `attaque_contre_heros` : le héros compte comme boucliers toutes les faces sauf le bouclier blanc (4 faces sur 6, au lieu des 2 boucliers blancs du jeu de plateau) ; les crânes du monstre moins ces boucliers sont retirés des points de corps. « VOUS AVEZ SURVECU A L'ATTAQUE », ou `mort_heros`.

Types de monstres (`types_monstres`) :

| Type | Déplacement | Attaque | Défense | Type | Déplacement | Attaque | Défense |
| --- | --- | --- | --- | --- | --- | --- | --- |
| 0 gobelin | 10 | 2 | 1 | 7 gargouille | 6 | 4 | 4 |
| 1 orc | 8 | 3 | 2 | 8 Ulag | 10 | 4 | 5 |
| 2 fimir | 6 | 3 | 3 | 9 Grak | 8 | 4 | 4 |
| 3 guerrier du chaos | 6 | 3 | 4 | 10 Balur | 8 | 2 | 5 |
| 4 squelette | 6 | 2 | 2 | 11 Sorcier-Roi (sur son trône ?) | 1 | 2 | 6 |
| 5 zombi | 4 | 2 | 3 | 12 Sorcier-Roi | 10 | 5 | 6 |
| 6 momie | 4 | 3 | 4 | 13 (?) | 6 | 3 | 5 |

Les types 14 à 26 (extension) sont dans la même table. Une routine de mort est donnée pour Ulag (prime de l'empereur), Balur, et les types 14 à 19, 22 et 26 (primes, objets lâchés comme l'étoile de l'ouest) ; `retire_monstre` (0x2120) l'appelle.

## Attaque du héros

`calcule_attaque_heros` (0x214D) : +0x14 de la fiche, remplacé par le nombre de dés de l'arme en main (table DS:47FF, bits 0-1, plus 1) :

| Arme | Dés | Arme | Dés |
| --- | --- | --- | --- |
| Bâton | 2 | Arbalète | 3 |
| Épée courte | 2 | Hache à main | 2 |
| Glaive (épée large) | 3 | Lance | 2 |
| Hache d'armes | 4 | | |

Les bits hauts de la table (0x80 pour le bâton, l'épée courte, la lance et l'arbalète ; 0x40, 0x20, 0x10) sont sans doute les portées (diagonale, lancer, tir) : à lire. Le poison d'orc donne 2 dés, la lame de l'esprit 3 (4 contre squelettes, zombis et momies). Puis (0x0B44) : contre le Sorcier-Roi, aucun dé sans la lame de l'esprit ; +2 avec la potion de force ou le courage, consommés par cette attaque.

## Fin de quête

Un héros sort de la quête quand il est sur l'escalier (codes 0x38 à 0x3B de `grille_occupants`) et que le premier octet de son état de tour (DS:4639) vaut 1 (à préciser). C'est `fin_quete` (0x184E), appelée à chaque passage de la boucle du tour :

1. Son bit est posé dans `etat_quete`, il quitte `heros_en_jeu` (FFh) et sa fiche est désactivée (+0 = 0). Exception : dans la 4e quête, ces trois points sont faits par la routine de la quête.
2. « VOUS AVEZ ECHAPPE INDEMNE A LA QUETE », puis la routine de la quête (`fins_quetes`, DS:44A9, quêtes du code 0 à 14 ; les quêtes de l'extension n'en ont pas).

| Quête du jeu | Routine | Effet |
| --- | --- | --- |
| 1 Le labyrinthe | `fin_labyrinthe` | le premier sorti reçoit 100 pièces d'or |
| 2 Le sauvetage de Sir Ragnar | `fin_ragnar` | quand Sir Ragnar sort : « L'EMPEREUR OFFRE 100 PIECES D'OR AU SAUVEUR », mais le héros qui l'a trouvé (`evenement_a`) reçoit 200 pièces |
| 4 L'or du prince Magnus | `fin_or_prince` | avec le coffre (+0x0F bit 0x40) : « GARDER LE COFFRE » ou « RENDEZ-LE AU PRINCE » (récompense de 200 annoncée, 50 pièces retirées de l'or). Puis, s'il reste des coffres : « ABANDONNEZ LA QUETE » ou « ALLEZ CHERCHER PLUS D'OR » (le héros revient en (3, 11) ou sur une case voisine libre) |
| 7 Le chasseur de pierres | `fin_karlen` | 100 pièces si Karlen a été trouvé (`evenement_b` posé) |
| 8 Le mage du feu | `fin_balur` | 150 pièces au héros qui a tué Balur ; sinon « BALUR EST TOUJOURS VIVANT » |
| 9 Course contre la montre | `fin_course` | retire l'objet de quête (+0x0F bit 0x40) |
| 10 Le château des mystères | `fin_or_faux` | si le héros a l'or de la mine (+0x0F bit 0x20) : 5000 pièces retirées, « L'OR TROUVE DANS LA MINE ETAIT FAUX » |

`ajoute_or` (0x6906) n'ajoute rien si le héros a déjà 9999 pièces ou plus.

Mort d'un héros (`mort_heros`, 0x10D8) : points de corps, or, équipement (+0x0E, +0x0F), artefacts (+0x0D) et objets en service remis à zéro ; la fiche est désactivée et le bit du héros posé dans `etat_quete`. Le héros reste « en jeu » à l'écran des héros, mais `choix_quete` ne compte pas un héros sans points de corps.

La quête s'arrête (`quete_continue`) quand `etat_quete` vaut 0Fh : les 4 héros sont sortis, morts ou absents. Dans la 2e quête, elle continue tant que Sir Ragnar est sur le plateau. Le jeu affiche alors « LES JOUEURS SONT TOUS ELIMINES », même si tous sont sortis vivants, et revient au menu titre. Après la 15e quête (`numero_quete` ≥ 15) et si DS:3FE7 est posé, l'écran final s'affiche ([02-ecrans.md](02-ecrans.md#boucle-principale)).

Abandon de la partie (`commandes` = 40h pendant un tour) : les fiches et `heros_en_jeu` sont restaurés depuis la copie faite par `lance_quete`, et `numero_quete` est remis à 0.

## Plateau en mémoire

`lance_quete` recopie les 1024 premiers octets de QUESTn.BIN en DS:546F (`grille_zones`) : zone de chaque case (bits 0 à 5), puis (+0x200) murs et portes. La grille des occupants suit, en DS:586F (= `grille_zones` + 0x400) : pour chaque case, le numéro du monstre qui l'occupe (1 à 32) ou le code du mobilier et des pièges (0x30 et plus, voir [FORMATS.md](../../../HeroQuest%20(1991%20Gremlin)/FORMATS.md#quêtes--questnbin)). `index_case` (0x607E) donne l'index d'une case à partir de (x, y).
