# Donjon de Naheulbeuk (v2)

Jeu de rôle par navigateur, créé en 2009 par Magend : un héros vit au village (boutiques, taverne, messagerie, duels entre joueurs), voyage entre trois villages et part en aventure sur un plateau inspiré de HeroQuest.

Cette v2 reprend la dernière version de 2009-2013 (`_Version/Donjon_v1b.zip`) en un seul projet qui tourne avec PHP 8 et SQLite. L'historique complet des versions est dans le [README du dépôt](../README.md).

## Lancer le jeu

Prérequis : PHP 8.1 ou plus récent, avec l'extension `pdo_sqlite` (fournie avec PHP, pas toujours activée).

```powershell
cd donjon-v2
.\start.ps1            # ou .\start.ps1 -Port 8080
```

Ouvrir <http://localhost:8000>. Au premier lancement, la base `data/donjon.sqlite` est créée et remplie automatiquement.

Sans le script (Linux, macOS, ou PHP avec un `php.ini` qui active déjà `pdo_sqlite`) :

```bash
php -S localhost:8000 -t public
```

Pour repartir d'une base neuve avec un compte de démonstration (`Demo` / `demo123`) :

```powershell
php -d extension_dir="$(Split-Path (Get-Command php).Source)\ext" -d extension=pdo_sqlite bin/reset-db.php
```

## Structure

```text
config/config.php     Chemin de la base, mode debug, limites (duels par jour, délai « en ligne »)
database/schema.sql   Tables SQLite (noms de tables et colonnes de la base MySQL d'origine)
database/seed.sql     Races, villages, boutiques, objets, aventures (dump MySQL de 2007)
bin/reset-db.php      Recrée la base et le compte de démonstration
bin/import-heroquest.py  Convertit les quêtes du HeroQuest PC de Gremlin en cartes 101 à 124
bin/heroquest-tiles/  Sols et meubles utilisés pour dessiner ces cartes (repris du remake HeroQuest en C#)
bin/extract-heroquest-graphics.py  Extrait les graphismes du HeroQuest PC pour la vue isométrique
bin/heroquest-outils.py  Outils pour explorer les fichiers du HeroQuest PC (formats : _Version/HeroQuest (1991 Gremlin)/FORMATS.md)
bin/decouper-maquette.py  Découpe bin/maquette/maquette-connexion.png en images du thème (public/assets/img/theme/)
bin/decouper-heros.py     Découpe la planche des héros (Campagne01/01-regles/heros-prompt.md) en portraits, images de combat et pions
src/                  Code PHP
  bootstrap.php       Autoload, configuration, session, ouverture de la base
  Database.php        Accès PDO (requêtes préparées, transactions)
  Repository/         Une classe par groupe de tables (joueurs, objets, monde, messages, défis, taverne)
  Game/               Règles du jeu : inventaire, progression (niveaux, grades, aventures), voyage, duel
  Actions.php         Formulaires POST (une méthode par action, puis redirection)
  Pages.php           Données de chaque page (?page=...)
templates/            Gabarit, pages et fragments HTML
public/               Racine web
  index.php           Point d'entrée des pages
  api.php             Appels AJAX du plateau de donjon (JSON)
  assets/             CSS, images, musiques (audio/), Flash (flash/), jeu de plateau (game/)
  games/tetris/       Mini-jeu de la taverne
```

## Le plateau de donjon

Le plateau (`public/assets/game/`) est le code JavaScript de 2009, nettoyé :

- mootools est remplacé par la fonction `$` de `public/assets/game/init.js` ;
- chaque aventure `N` charge la carte `quests/questN.js` et son image `quests/questN.jpg` (cartes 1 à 8 de 2009, aventures 1 à 6 en base) ;
- la sauvegarde passe par `api.php` : vie et or du héros, objets trouvés ou utilisés, fin de partie.

Commandes : lancer les dés puis se déplacer avec les flèches du clavier, attaquer un monstre voisin, tirer une carte trésor par pièce, finir le tour pour laisser jouer les monstres.

### Quêtes du HeroQuest PC (aventures 101 à 124)

Les cartes `quest101` à `quest124` sont générées à partir des fichiers `QUESTn.BIN` du jeu de Gremlin (1991), dans `_Version/HeroQuest (1991 Gremlin)` : les 14 quêtes du jeu de base et les 10 de l'extension « Return of the Witch Lord ». Le format est décrit en tête du script.

```powershell
pip install pillow
python bin/import-heroquest.py "../_Version/HeroQuest (1991 Gremlin)"
```

Le script réécrit les fichiers `.js` et `.jpg` et affiche pour chaque quête le nombre de pièces et de monstres. Il vérifie aussi que le héros peut atteindre tous les monstres. Les aventures correspondantes sont dans `database/seed.sql` (grades 1 à 4, réparties entre les trois villages). Pour les ajouter à une base existante, lancer `bin/reset-db.php`.

Ce qui est repris : pièces, couloirs, murs, portes, éboulis, meubles (cases infranchissables), pièges (fosse, chute de pierre, lance : invisibles, un point de vie perdu), monstres, escalier et départ du héros. Ces cartes définissent `MesMurs`, que le moteur utilise pour bloquer les déplacements et les attaques à travers un mur ou un meuble. Sur ces cartes, les couloirs ne sont pas dévoilés d'un coup : le héros voit en ligne droite depuis sa case, jusqu'à un mur, une porte ou un éboulis. Un monstre ne s'active que quand le héros l'a vu (sa pièce dévoilée, ou sa case de couloir en vue) ; il poursuit ensuite le héros par le plus court chemin.

Limites :

- les quêtes 5 (Labyrinthe de Melar) et 10 (Château des mystères) ne sont pas converties : leurs passages dépendent de scripts du jeu (passage secret, portails magiques) absents des fichiers de quête ;
- les événements scriptés (personnage à délivrer, objet à trouver) ne sont pas repris : on gagne en tuant tous les monstres, ou en atteignant l'escalier pour les quêtes d'évasion 1, 6 et 9 ;
- les portes secrètes sont affichées comme des portes normales ;
- les boss (Ulag, Balur, le Sorcier-Roi, Bellthor...) utilisent les monstres existants les plus proches (ChamanOrc, Sorcier, MageSquellette, Gargouille) ;
- sur la vue de dessus, les meubles utilisent les images du remake en C#, qui n'a pas de bibliothèque (remplacée par une armoire).

### Vue isométrique

Sur les cartes 101 à 124, le plateau s'affiche par défaut en vue isométrique, avec des graphismes redessinés d'après le jeu de Gremlin : sols de chaque pièce, murs du fond, portes (fermées tant qu'un côté n'est pas dévoilé), meubles, escalier, héros et monstres. Chaque attaque s'affiche en gros plan pendant deux secondes : les deux combattants agrandis sur leurs dalles avec l'animation d'attaque du jeu, les dés lancés, les points de vie et le résultat. Le bouton au-dessus du plateau fait tourner trois vues : 3D, classique et vue de dessus. Le choix est mémorisé dans le navigateur. La vue classique reprend l'écran du jeu d'origine : seule la pièce du héros (ou les cases de couloir à moins de 4 cases) est dessinée, posée sur le livre devant Morcar ; le portrait du héros et ses caractéristiques (or, attaque, déplacement, défense) sont en haut à gauche, et les icônes d'action en bas (lancer les dés, attaquer, chercher un trésor, chercher les pièges, utiliser un objet, fin de tour), cliquables et grisées une fois jouées. Le moteur ne change pas : `ModuleIso.js` redessine en continu l'état du tableau `#board`, qui reste masqué.

Les graphismes viennent de `public/assets/game/iso/atlas.png` et `atlas.js`, construits à partir d'une planche redessinée (sols, murs, portes, meubles, héros et héroïnes, monstres, portraits, icônes) :

```powershell
python bin/construire-atlas-iso.py
```

La zone de chaque image sur la planche est dans `bin/atlas-iso.json`. L'atlas est à deux fois la taille du plateau, pour les gros plans des combats. Pour une nouvelle planche, suivre le skill `atlas-iso` (`.claude/skills/atlas-iso/SKILL.md` à la racine du dépôt).

Les graphismes d'origine servent de référence (tailles, orientations). Ils sont extraits des fichiers du jeu dans `public/assets/game/iso/1991/` :

```powershell
python bin/extract-heroquest-graphics.py "../_Version/HeroQuest (1991 Gremlin)"
```

Le script décompresse `QUEST.EXE` (compressé avec EXEPACK) pour y lire la palette et les tables des sprites, puis les fichiers `.VGA` (compression LZ77 propre au jeu, retrouvée en désassemblant l'exécutable). Les formats sont décrits en tête du script.

Toutes les notes de rétro-ingénierie (formats, adresses dans l'exécutable, tables, pistes non explorées) sont dans [FORMATS.md](../_Version/HeroQuest%20(1991%20Gremlin)/FORMATS.md).

Les flèches du clavier déplacent toujours le héros sur la grille : ↑ va vers le haut à droite de l'écran, → vers le bas à droite.

## Flash et musique

- L'intro Flash d'origine (`assets/flash/Donjon.swf`) s'affiche sur la page de connexion grâce à l'émulateur [Ruffle](https://ruffle.rs), chargé depuis unpkg (version 0.6.0). Sans connexion internet, l'intro ne s'affiche pas mais le jeu fonctionne.
- Les cinq musiques d'origine sont jouables depuis le pied de page.

## Ce qui a changé par rapport à la v1

| Sujet | v1 | v2 |
|---|---|---|
| Base de données | MySQL via `mysql_*` (supprimé en PHP 7) | SQLite via PDO, créée automatiquement |
| Requêtes | Concaténation de chaînes (injection SQL possible) | Requêtes préparées |
| Mots de passe | En clair, envoyés dans l'URL (GET) | `password_hash`, formulaire POST |
| Identifiants serveur | Codés en dur dans `Connect.php` et `Secret/connect.php` | Aucun |
| Formulaires | Actions déclenchées par des liens GET | POST avec jeton CSRF |
| État du héros | Copié en session, désynchronisé de la base | Relu en base à chaque page |
| Taverne | Fichiers texte par village | Table `chat` |

Bugs de la v1 corrigés au passage : équiper une arme n'appliquait pas son bonus (colonne `for` inexistante) ni ne retirait le bonus de l'arme remplacée ; le tour des monstres se bloquait quand le dernier monstre était actif ; les potions de soin plafonnaient la vie à sa valeur actuelle ; la fin de partie perdait l'identifiant de l'aventure avant de verser la récompense ; la victoire n'était vérifiée qu'en se déplaçant ; le monstre n°20 de la carte 5 n'existait pas.

## Limites connues

- Les aventures se jouent uniquement sur le plateau : le mode « mission chronométrée » de la v1 (colonne `aventure.temps`) n'est pas repris.
- Les cartes 7 et 8 existent mais aucune aventure ne les utilise : il suffit d'ajouter une ligne `aventure` avec `code` 7 ou 8.
- Le tour par tour à plusieurs joueurs sur le même plateau n'a jamais été terminé en v1 et n'est pas proposé.
- Les gains d'or des cartes trésor sont calculés par le navigateur ; le serveur les plafonne à 1 000 pièces par sauvegarde.
