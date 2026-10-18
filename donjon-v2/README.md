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

- mootools est remplacé par `compat.js` (fonction `$`) ;
- chaque aventure `N` charge la carte `quests/questN.js` et son image `quests/questN.jpg` (cartes 1 à 8 disponibles, aventures 1 à 6 en base) ;
- la sauvegarde passe par `api.php` : vie et or du héros, objets trouvés ou utilisés, fin de partie.

Commandes : lancer les dés puis se déplacer avec les flèches du clavier, attaquer un monstre voisin, tirer une carte trésor par pièce, finir le tour pour laisser jouer les monstres.

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
