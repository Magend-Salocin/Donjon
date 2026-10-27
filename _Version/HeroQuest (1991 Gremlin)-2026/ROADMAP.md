# Roadmap

État au 27 octobre 2026. Objectif : rejouer HeroQuest PC (Gremlin, 1991) dans un navigateur, à l'identique, à partir du code original. Chaque phase produit un livrable utilisable seul.

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

Bogues vérifiés dans le code le 27 octobre (ligne de vue vers le haut, mur manqué et blocage des tirs, cache des meubles, `monstre_actif_case`, joystick B, chemin des monstres) : voir les notes. Reste de la phase 1 : les 34 lignes marquées (?) de `symboles.txt`.

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

## Phase 3 : portage JavaScript

Principe : traduire routine par routine, en gardant le nom et l'adresse d'origine en commentaire, pour pouvoir comparer avec l'original à chaque étape.

1. **Moteur d'affichage** : écran virtuel 320 × 200 en 8 bits et palette VGA, agrandi sans lissage dans un canvas ; `copie_image`, décompression LZ, fondus, cadence calée sur le balayage vertical (70 Hz).
2. **État du jeu** : un tableau d'octets qui reproduit le segment de données (mêmes offsets), pour comparer l'état avec un vidage mémoire de l'original.
3. **Hasard** : le même registre à décalage (`hasard`, 0x3613) et la même graine, pour obtenir les mêmes suites de dés que l'original.
4. **Écrans dans l'ordre du jeu** : intro, menu titre, héros, armurerie, briefing, plateau statique, déplacement, combat, monstres, sorts, fin de quête.
5. **Entrées** : souris et clavier comme sous DOS.

Contrôle : pour chaque écran, une capture de l'original sous DOSBox et la même capture du portage, comparées pixel à pixel ; pour les règles, des parties rejouées avec la même graine.

## Phase 4 : PHP et finition

1. PHP sert le jeu et les fichiers de données, et garde les sauvegardes (l'équivalent de `QUEST.SAV`, par joueur).
2. Son : émulation AdLib (OPL2) en JavaScript, ou enregistrement des musiques.
3. Langues : les 5 langues d'origine sont disponibles.

## Décisions à prendre

| N° | Question | Proposition |
| --- | --- | --- |
| D1 | Jusqu'où va « à l'identique » : au pixel près et mêmes suites de dés, ou seulement même rendu et mêmes règles ? | Au pixel près et mêmes dés : c'est ce qui permet de vérifier automatiquement le portage |
| D2 | Rôle de PHP : simple service (fichiers, sauvegardes) ou aussi les règles côté serveur ? | Simple service : le jeu d'origine tourne en local, les règles restent en JavaScript |
| D3 | Son : émulation AdLib ou musiques enregistrées ? | À trancher en phase 2, selon le format trouvé |
| D4 | Langue par défaut | Français (`FRENCH.BIN`), les autres en option |
| D5 | Lien avec `donjon-v2` : projets séparés, ou le remake devient un mode de `donjon-v2` ? | Séparés tant que le portage n'est pas fini |
