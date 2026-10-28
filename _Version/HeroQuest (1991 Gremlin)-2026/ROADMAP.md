# Roadmap

État au 28 octobre 2026. Objectif : rejouer HeroQuest PC (Gremlin, 1991) dans un navigateur, à l'identique, à partir du code original. Chaque phase produit un livrable utilisable seul.

## Phase 0 : récupérer l'original (faite)

| Livrable | État |
| --- | --- |
| Exécutables décompressés (EXEPACK) | `original/binaires/` |
| Désassemblage suivant le flot, annoté par `symboles.txt` | QUEST 98,7 %, INTRO 95,9 % du code (le reste : des données dans le segment de code) |
| Segment de données en clair | `original/asm/*-donnees.txt` |
| Palettes du jeu et des 9 écrans de l'intro | `original/donnees/palettes.json` |
| Écrans, sprites, images d'interface | 13 écrans, 176 sprites, 327 images |
| Textes des 5 langues, titres des quêtes | décompressés ; messages découpés (`*-messages.txt`) |
| 24 quêtes | JSON champ par champ |

Déjà compris (voir [FORMATS.md](../HeroQuest%20(1991%20Gremlin)/FORMATS.md)) : compressions, palette, tables de sprites, format des quêtes, générateur de hasard, dés, déplacement, attaque du héros, mélange des trésors.

## Phase 1 : comprendre le code original

But : chaque routine nommée et décrite, chaque variable du segment de données identifiée. Livrable : `original/symboles.txt` complet et une note par sous-système dans `original/notes/`, avec le pseudo-code des règles.

Ordre proposé, du socle vers le jeu :

1. **Socle** : mémoire, fichiers, vidéo (copie d'image, palette, fondus, les 4 modes vidéo dont seul VGA est utile), souris, clavier, minuterie, son.
2. **Machine d'écrans** : intro, menu titre, choix et création des héros, armurerie, briefing (parchemin), plateau, carte, inventaire, sorts, Morcar, fin de quête, chargement et sauvegarde.
3. **Règles** : tour de jeu (héros puis Morcar), déplacement, révélation des pièces et des couloirs, combat, intelligence des monstres, pièges, fouille, portes secrètes, sorts, cartes trésor, objets, événements scriptés par zone (quêtes 5 et 10 comprises).
4. **Textes** : table d'index des messages de `FRENCH.BIN`, pour relier chaque numéro de message à son appel dans le code.

Méthode : lire le listing, poser des noms dans `symboles.txt`, régénérer. Vérifier les hypothèses sur l'original qui tourne, avec le débogueur de DOSBox-X (installé, voir [DEBOGUER.md](outils/DEBOGUER.md)) : points d'arrêt, lecture du segment de données.

Bogues vérifiés dans le code le 27 octobre (ligne de vue vers le haut, mur manqué et blocage des tirs, cache des meubles, `monstre_actif_case`, joystick B, chemin des monstres) : voir les notes. Les hypothèses (?) de `symboles.txt` ont toutes été relues le 27 octobre : il n'en reste aucune. La phase 1 est terminée pour QUEST.EXE ; seules restent les 4 sauts indirects non résolus du rapport, et INTRO.EXE (85 routines, dont 26 probables).

Avancement mesurable : la première ligne de `original/asm/quest-routines.txt` donne le nombre de routines nommées (379 sur 379 au 27 octobre : toutes ont un nom, une partie reste marquée (?) ; 0x5EB0 n'est plus comptée, c'est un fragment mort de `curseur_dessine`). Ce fichier résume aussi chaque routine (taille, appelants, interruptions, ports, variables), ce qui aide à les classer avant de les lire.

| Sous-système | État | Note |
| --- | --- | --- |
| Socle | configuration, commandes, fichiers et interface du son lus ; vidéo, saisie, joystick et outils de mise au point nommés | [01-socle.md](original/notes/01-socle.md) |
| Machine d'écrans | vue de la zone, carte et désignation d'une cible, ouverture des messages ; boucle principale, menu titre, héros, armurerie, choix de la quête, affichage, messages, boucle des tours, inventaire, briefing et préparation de la quête, sauvegarde des personnages | [02-ecrans.md](original/notes/02-ecrans.md) |
| Règles | ligne de vue (tir, sorts, cases alignées), chemin du héros vers la case cliquée, choix des sorts au départ ; dés, déplacement, attaque du héros, trésors ; tour d'un personnage, panneau d'icônes, événements et fouilles scriptés, sorts et leurs effets, objets (armes, armures, potions, artefacts, trousse à outils), monstres (chemin, attaque, types), dés d'attaque et de défense, fin de quête et récompenses, mort d'un héros, pièges, portée des armes, fouilles et cartes trésor, les 30 événements scriptés, événements de zone et morts des monstres spéciaux, panneau (positions) et déplacement | [03-regles.md](original/notes/03-regles.md) |
| Textes | index des messages décodé (`french-messages.txt`), annoté dans le listing | [02-ecrans.md](original/notes/02-ecrans.md#messages) |

## Phase 2 : compléter les données

1. Index des messages des fichiers de textes : fait (`original/donnees/textes/*-messages.txt`), boutons compris (position, libellé, numéro).
2. MEN.VGA : fait (31 poses et séquences du gros plan du combat, `original/donnees/combat.json`).
3. ANIMS.VGA : fait (non compressé, 5 plans de bits ; 47 images des 6 scènes de l'intro, `original/donnees/anims.json`).
4. Musique et effets : interface du pilote et numéros des morceaux faits ([01-socle.md](original/notes/01-socle.md#son)). Reste le contenu des morceaux (GAME&FX.ALB), selon la décision D3.
5. `QUEST.SAV` : fait (32 personnages, noms et fiches ; voir FORMATS.md). Les quêtes accomplies ne sont mémorisées nulle part : le fichier fait exactement 32 noms et 32 fiches, et le joueur choisit librement sa quête.

## Phase 3 : portage JavaScript (faite le 28 octobre 2026)

Le jeu se joue dans un navigateur : [web/README.md](web/README.md).

Méthode retenue : plutôt que de réécrire 15 000 instructions à la main, `outils/recompiler.py` les traduit toutes, routine par routine, en gardant le nom de `symboles.txt` et l'adresse d'origine (une fonction JavaScript par routine, l'instruction d'origine en commentaire de chaque ligne). Le portage reproduit donc l'original par construction : même mémoire et mêmes offsets que le segment de données, même générateur de hasard et même graine, mêmes pixels. Cela répond à la décision D1 (au pixel près et mêmes dés).

| Étape prévue | Réalisation |
| --- | --- |
| Moteur d'affichage | VGA 13h et palette (DAC, int 10h), EGA 0Dh pour l'écran des drapeaux, mode texte pour la configuration ; temps compté en instructions (3000 par ms, comme DOSBox-X), retour de trame à 70 Hz |
| État du jeu | la mémoire de 1 Mo du PC, avec le programme chargé et relogé comme par DOS |
| Hasard | le code d'origine (`hasard`, 0x3613), graine tirée de l'heure (int 21h AH=2Ch) |
| Écrans | tous : HERO.EXE est remplacé par la page, qui enchaîne INTRO.EXE puis QUEST.EXE |
| Entrées | souris (int 33h), clavier (IRQ 1 et port 60h pour le gestionnaire du jeu, int 16h) |

Contrôles faits :

- `outils/difference.py` : chaque instruction traduite contre un vrai x86 (Unicorn), 10 états au hasard par instruction : QUEST 146 660 cas, INTRO 66 500 cas, 0 écart.
- `outils/essai.mjs` : parcours sans navigateur (menu, héros, choix de quête, briefing, plateau, dés, pas) et 4 parties de clics au hasard de 13 minutes chacune, sans erreur ni service DOS ou BIOS manquant.
- `outils/navigateur.mjs` : la page dans Chrome (intro en mode texte, écrans graphiques, clics, temps du jeu égal au temps réel).

Reste :

1. Comparer des écrans pixel à pixel avec des captures de DOSBox-X (le contrôle prévu), et rejouer une partie avec la même graine sur les deux.
2. Son : fait en phase 4 (WAV de l'AdLib).
3. Réécrire à la main, si on le souhaite, les routines qui doivent devenir lisibles ou modifiables, en comparant à la version générée.

## Phase 4 : PHP et finition

1. PHP sert le jeu et les fichiers de données, et garde les sauvegardes : fait pour un seul joueur (`web/fichiers.php`, dossier `web/sauvegardes/`) ; reste une sauvegarde par joueur.
2. Son : fait. Les morceaux du pilote AdLib sont rendus en WAV (`outils/son.py` puis `outils/sons.mjs`) et joués par la page ; un seul type de son, l'AdLib. Reste à les comparer à l'oreille avec DOSBox-X, et le MP3 si un encodeur est installé.
3. Langues : fait, les 5 langues se choisissent sur l'écran des drapeaux de l'intro.

## Décisions à prendre

| N° | Question | Proposition |
| --- | --- | --- |
| D1 | Jusqu'où va « à l'identique » : au pixel près et mêmes suites de dés, ou seulement même rendu et mêmes règles ? | Tranchée par la méthode de la phase 3 : au pixel près et mêmes dés, par construction |
| D2 | Rôle de PHP : simple service (fichiers, sauvegardes) ou aussi les règles côté serveur ? | Simple service : le jeu d'origine tourne en local, les règles restent en JavaScript |
| D3 | Son : émulation AdLib ou musiques enregistrées ? | Tranchée le 28 octobre 2026 : musiques enregistrées (WAV), AdLib seulement |
| D4 | Langue par défaut | Français (`FRENCH.BIN`), les autres en option |
| D5 | Lien avec `donjon-v2` : projets séparés, ou le remake devient un mode de `donjon-v2` ? | Séparés tant que le portage n'est pas fini |
