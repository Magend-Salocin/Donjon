# Donjon de Naheulbeuk

Jeu de rôle par navigateur dans l'univers du Donjon de Naheulbeuk, développé par Magend (Nicolas Berger) à partir de 2007.

Le joueur crée un héros (Humain, Elfe, Nain ou Ogre) qui vit dans l'un des trois villages de la Terre de Fangh. Au village, il fait ses achats, discute à la taverne, écrit aux autres joueurs et les défie en duel. Il voyage entre les villages et part en aventure. Une aventure se joue sur un plateau de donjon tour par tour, inspiré du jeu de société HeroQuest.

Le jeu jouable aujourd'hui est dans [donjon-v2/](donjon-v2/) : voir son [README](donjon-v2/README.md) pour le lancer. Ce document retrace l'histoire du projet de 2007 à 2026.

> Les dates viennent des dates de modification des fichiers conservés, faute d'historique de versions. Elles indiquent quand chaque version a été travaillée, pas une date de sortie.

## Chronologie

| Période | Version | Où la trouver |
|---|---|---|
| 2000 - 2007 | Sources d'inspiration HeroQuest | `_Version/HeroQuest*`, `_Version/===Image===` |
| avril - juin 2007 | Premier prototype PHP | `_Version/Donjon_v0a.zip` |
| avril 2007 - juillet 2008 | Deuxième itération | `_Version/Donjon_v0b.zip` |
| juin 2007 - janvier 2009 | Version avec taverne et modules | `_Version/Donjon_v0c.zip` |
| novembre 2007 | Export de la base MySQL | `_Version/baseNAl.txt` |
| août 2007 - mai 2009 | Plateau de donjon HeroQuest en JavaScript | `HeroQuest_V2/` |
| mars - mai 2009 | Éditeur de cartes de donjon | `AdminCarte/` |
| février - octobre 2009 | Version complète « Magend 2009 » | `_Version/Donjon_v1a.zip` |
| novembre 2010 - septembre 2013 | Corrections de la version 2009 | `_Version/Donjon_v1b.zip` |
| octobre 2026 | v2 : fusion et modernisation | `donjon-v2/` |

Les archives `Donjon_v0a` à `Donjon_v0c` correspondent aux archives d'origine `DonjonV3`, `DonjonV2` et `DonjonV1`, renommées dans l'ordre chronologique (les noms d'origine étaient inversés). Le dossier racine de chaque zip garde son nom d'origine.

## Les versions en détail

### Sources d'inspiration (2000 - 2007)

- **Jeu de référence** : le jeu PC HeroQuest de Gremlin (1991), dans deux archives et un dossier `_Version/HeroQuest (1991 Gremlin)`. Le jeu de plateau en ligne en reprend les règles : dés de déplacement, dés de combat crâne/bouclier, cartes trésor, pièces révélées à l'entrée du héros, monstres qui jouent après le joueur.
- **Remake** : un portage de HeroQuest en C# (fichiers datés de 2003 à 2007), avec ses fichiers de quêtes (`_Version/HeroQuest (C#).zip`).
- **Images** : scans et visuels HeroQuest (2000-2003) ayant servi de référence pour les cartes, les meubles et les monstres.

### Premier prototype PHP (avril - juin 2007, `Donjon_v0a.zip`)

- Interface en deux cadres HTML (`frameset`) : un menu fixe à gauche, la page de jeu à droite.
- Code organisé en `Controleurs/` (un fichier par domaine : joueur, race, village, magasin, objet, aventure, grade, combat, menu) et `Vues/`.
- Fonctionnalités :
  - inscription avec choix de la race ;
  - fiche du héros ;
  - village et magasins ;
  - inventaire et objets ;
  - aventures ;
  - défis entre joueurs en ligne avec module de combat ;
  - page de passage de niveau (`HNS.PHP`) ;
  - décors animés (`MouvDecor`).

### Deuxième itération (avril 2007 - juillet 2008, `Donjon_v0b.zip`)

- Même architecture, avec un second jeu de vues (`Vues2/`) qui teste une nouvelle page d'accueil et un nouveau menu.
- Apparition de la messagerie entre joueurs.

### Version avec taverne et modules (juin 2007 - janvier 2009, `Donjon_v0c.zip`)

- Ajout de la taverne et du tavernier.
- Dossier `Module/` :
  - discussion par village (`Chatte`), stockée dans des fichiers texte ;
  - rumeurs ;
  - mini-jeu Tetris (`Jeux/01`).
- Contrôleurs dédiés au chat et aux messages.

### Base de données (novembre 2007, `_Version/baseNAl.txt`)

- Export phpMyAdmin d'une base MySQL 4.1 (PHP 4.3).
- Tables : `joueur`, `race`, `grade`, `village`, `villagealler` (trajets), `magazin`, `objet`, `objetproposer` (stock des boutiques), `objethero` (inventaires), `aventure`, `aventureencour`, `accomplir` (missions réussies), `avantcombat` (défis), `message`.
- Contenu de référence :
  - 4 races ;
  - 4 grades (Novice, Écuyer, Aventurier, Légende) ;
  - 3 villages (Valtordu, Waldorg, Gzor) ;
  - 9 bâtiments ;
  - 30 objets ;
  - 6 aventures.
- La v2 repart encore de ces données.

### Plateau de donjon HeroQuest (août 2007 - mai 2009, `HeroQuest_V2/`)

- Moteur JavaScript écrit en modules : actions du joueur, pièces, déplacement, intelligence des monstres, combat, cartes trésor, sauvegarde, multijoueur. Il s'appuie sur mootools.
- Plateau de 26 × 19 cases posé sur une image de carte. Les pièces se dévoilent quand le héros y entre.
- Une première version utilisait un moteur unique, `EngineMagend.js` (mars 2009), avant le découpage en modules.
- Chaque quête est un fichier de données (`questN.js`) : pièces, portes, pièges, monstres et condition de victoire. Huit cartes ont été dessinées.
- Ce dossier est l'état du prototype en mai 2009, avant son intégration dans le jeu. La version intégrée et corrigée est dans `donjon-v2/public/assets/game/`.

### Éditeur de cartes (mars - mai 2009, `AdminCarte/`)

- Outil d'administration pour dessiner les quêtes sur la même grille de 26 × 19 cases.
- On y place le départ, les cases, les pièces, les pièges et les monstres, puis on enregistre la partie.
- Une page de gestion des magasins y est intégrée. Elle utilisait l'éditeur de texte FCKeditor (2008), qui n'est pas conservé : le dossier `fckeditor/` est vide.
- Contient aussi des visuels de travail (décors, personnages, villages).

### Version complète « Magend 2009 » (février - octobre 2009, `Donjon_v1a.zip`)

- Réécriture de l'ensemble :
  - abandon des cadres HTML pour une page unique au thème médiéval (menu en forme d'épée, parchemins) ;
  - code réparti en `DAO/` (accès aux données), `Class/`, `Controleur/` et `Vues/`.
- Intégration du plateau HeroQuest : on part en aventure depuis le village et la partie se joue dans la page.
- Intro animée en Flash et musiques d'ambiance (dossier `arzhel/`).
- Navigation partiellement en AJAX.

### Corrections de la version 2009 (novembre 2010 - septembre 2013, `Donjon_v1b.zip`)

- Base de code identique à `Donjon_v1a`, avec les dernières modifications :
  - routage des pages déplacé dans `index.php` ;
  - nouveau formulaire de connexion ;
  - initialisation des variables de session pour les versions récentes de PHP ;
  - fonction AJAX générique pour recharger l'inventaire pendant une quête.
- C'est la dernière version complète et jouable de la v1, et la base de la v2.

### Refonte inachevée (mars - septembre 2013, non conservée)

- Tentative de nouvelle architecture (point d'entrée unique, fichier de configuration, classes regroupant les actions du héros), arrêtée après la migration de cinq pages.
- Elle reposait sur le squelette d'un autre projet et n'a pas été gardée dans le dépôt. La v2 en reprend l'idée d'un point d'entrée et d'une configuration centralisée.

### v2 (octobre 2026, `donjon-v2/`)

Reprise de la version 2009-2013 en un seul projet moderne :

- **Socle** :
  - code de `Donjon_v1b` réorganisé et porté en PHP 8 ;
  - base SQLite créée automatiquement à partir du schéma et des données de 2007 ;
  - pas de serveur MySQL à installer.
- **Sécurité** :
  - requêtes préparées ;
  - mots de passe chiffrés ;
  - formulaires protégés par jeton ;
  - plus aucun identifiant de serveur dans le code.
- **Toutes les fonctionnalités de 2009 reprises** : village, boutiques, inventaire et équipement, niveaux et grades, voyages, messagerie, taverne, Tetris, duels et plateau de donjon.
- **Assets** : l'intro Flash d'origine est lue avec l'émulateur Ruffle, les cinq musiques sont jouables depuis le pied de page.
- **Bugs de la v1 corrigés** : bonus d'équipement, tour des monstres bloqué, soins, récompense de fin d'aventure, détection de la victoire.

Le détail des changements et les limites connues sont dans [donjon-v2/README.md](donjon-v2/README.md).

## Contenu du dépôt

| Emplacement | Contenu |
|---|---|
| `donjon-v2/` | Version actuelle, à utiliser pour jouer |
| `HeroQuest_V2/` | Prototype du plateau de donjon (2009) |
| `AdminCarte/` | Éditeur de cartes de donjon (2009) |
| `_Version/Donjon_v0a.zip` à `Donjon_v0c.zip` | Prototypes PHP 2007-2009 |
| `_Version/Donjon_v1a.zip` | Version 2009 |
| `_Version/Donjon_v1b.zip` | Dernière version complète de la v1 (2009-2013) |
| `_Version/baseNAl.txt` | Base MySQL de 2007 |
| `_Version/HeroQuest*`, `_Version/===Image===` | Sources d'inspiration HeroQuest |
| `_Version/dungeon.mp3`, `_Version/heroquest.jpg` | Musique et visuel de référence (2007) |

Les versions antérieures à la v2 sont conservées pour l'histoire du projet. Elles demandent PHP 4 ou 5 et MySQL et ne sont plus maintenues.
