# Roadmap

État au 22 octobre 2026. Ce document liste ce qui existe, les axes d'amélioration et l'outillage Claude Code à prévoir. Le détail de chaque chantier reste dans son concept ([animations](animations-iso/concept-animations-iso.md), [taverne](taverne/concept-taverne.md)) : ici, seulement l'état et l'ordre.

## Ce qui existe

| Domaine | En place | Où |
| --- | --- | --- |
| Socle | PHP 8, SQLite créée au premier lancement, requêtes préparées, CSRF, mots de passe hachés | `donjon-v2/src/`, [README v2](../../donjon-v2/README.md) |
| Héros | Inscription (4 types × 2 sexes), fiche, niveaux (5 points par niveau), grades Novice à Légende | `Progression.php` |
| Village | 3 villages, boutiques et stocks, inventaire, équipement sur 7 emplacements, voyages minutés | `World.php`, `Inventory.php`, `Travel.php` |
| Social | Messagerie, discussion de taverne par village, duels simulés côté serveur (60 par jour) | `Duel.php`, `Chat.php` |
| Taverne | Discussion et Tetris. Conception complète des PNJ, dialogues et compagnons, non développée | [concept-taverne](taverne/concept-taverne.md) |
| Plateau | Moteur de 2009 nettoyé : dés, déplacement, combat, trésors, pièges, IA des monstres, sauvegarde par `api.php` | `public/assets/game/` |
| Aventures | 6 aventures de 2009 (cartes 1 à 6), 22 du HeroQuest PC (101 à 124 sauf 105 et 110) | `database/seed.sql`, `quests/` |
| Vue iso | Vues 3D, classique et de dessus. Gros plan de combat. Atlas de 177 images, barbare h/f animé (marche, attaque, touché, mort) | `ModuleIso.js`, skill `atlas-iso` |
| Campagnes | 6 campagnes HeroQuest en Markdown. Seule Campagne01 est jouable (aventures 101 à 114). Les aventures 115 à 124 correspondent à Campagne03, sans que la campagne le mentionne | dépôt HeroQuest |

## Dette et défauts constatés

| Constat | Effet | Parade |
| --- | --- | --- |
| Aucun test automatisé, PHP ou navigateur | Chaque modification se vérifie à la main ([verification.md](../rules/verification.md), étape 4) | Jalon 1 |
| Pas de migration de base : une nouvelle aventure ou table demande `bin/reset-db.php` | La taverne ajoute des tables : les héros existants seraient perdus | Jalon 1 |
| `api.php` `item-add` accepte n'importe quel objet `item` ou `quete`, même hors aventure | Un client modifié se donne des objets à volonté | Tirer les trésors côté serveur (jalon 2) |
| L'or des trésors est calculé par le navigateur (plafond 1 000 par sauvegarde) | Idem pour l'or | Jalon 2 |
| Les points de magie (`pm`, `man`, `ppm`) sont stockés mais aucun sort n'existe | Elfe et enchanteur n'ont pas leur rôle de HeroQuest | Jalon 2 |
| Le [README du dépôt](../../README.md) annonce les races Humain, Elfe, Nain, Ogre ; la base a Barbare, Nain, Elfe, Enchanteur | Documentation fausse | Corriger le README |
| `FORMAT.md` existe dans `donjon-v2/public/assets/game/quests/` et dans le dépôt HeroQuest, avec un contenu différent | Deux sources pour un même format | Garder celui de donjon-v2, faire pointer l'autre dessus |
| Images `quest9.jpg` à `quest12.jpg` sans carte `.js`, cartes 7 et 8 sans aventure | Contenu dormant | Jalon 4 |
| Résumés des aventures 1 à 6 avec fautes (« confier », « envahie ») | Finition | Jalon 4 |
| `config.php` en `debug => true` | À couper avant toute mise en ligne | Décision D1 |

Corrigé le 22 octobre 2026 : le déplacement de `iso/t/` et `iso/planches/` vers `iso/remake/` cassait `bin/construire-atlas-iso.py`. Chemins mis à jour dans `bin/atlas-iso.json`, le skill et la KB ; l'atlas reconstruit est identique au précédent.

## Jalons

Chaque jalon est jouable seul. L'ordre suit les dépendances : on teste avant d'ajouter des tables, on sécurise le plateau avant d'y brancher des récompenses de campagne.

### Jalon 1 : filet de sécurité

1. Migrations : un dossier `database/migrations/` numéroté et une table `migration`, appliqués au démarrage comme le schéma aujourd'hui. Plus de `reset-db` pour ajouter une aventure.
2. Tests PHP (Pest) sur `Progression`, `Inventory`, `Duel` et `api.php`, avec une base SQLite en mémoire.
3. Tests navigateur (Playwright, ou Pest 4 qui l'embarque) : chaque page sans erreur JavaScript, une quête 101 jouée jusqu'au premier combat dans les 3 vues, captures du canvas comparées à une référence.
4. Dés à graine fixe en mode test (les 5 `Math.random` du plateau passent par une fonction), pour des captures reproductibles.
5. Valider en jeu les animations du barbare (étape 3 du [concept](animations-iso/concept-animations-iso.md#étapes), « reste à tester »).

### Jalon 2 : plateau fidèle à HeroQuest

1. Trésors tirés par le serveur : `api.php` pioche la carte et verse l'or ou l'objet. Le client n'envoie plus que « je cherche dans cette pièce ».
2. Sorts : les 3 éléments de l'elfe (1 sort) et de l'enchanteur (3 éléments), consommant les points de magie. C'est le plus gros manque de règles.
3. Portes secrètes et fouille (aujourd'hui affichées comme des portes normales), recherche de pièges qui révèle et désamorce.
4. Objectifs de quête au-delà de « tuer tout » ou « atteindre l'escalier » : personnage à délivrer, objet à trouver. Prérequis des débriefings de la taverne.
5. Boss distincts (Ulag, Balur, Sorcier-Roi) : statistiques propres dans `config/monstres.js`, sprite de remplacement en attendant leur planche.
6. Narration à l'entrée d'une pièce, comme l'application compagnon d'Avalon Hill : un texte court par pièce, tiré des fiches de quête de la campagne.
7. Quêtes 105 (Melar) et 110 (Château des mystères) : passages et portails scriptés.

### Jalon 3 : taverne et campagne

Suivre le [découpage de la taverne](taverne/concept-taverne.md#découpage-proposé), étapes 1 à 5. Préalables : jalon 1 (tables nouvelles), jalon 2 point 4 (objectifs pour les débriefings), et les [décisions de la taverne](taverne/concept-taverne.md#décisions-à-prendre).

L'étape 6 (allié visible sur le plateau, avec son IA) vient après le jalon 5.

### Jalon 4 : contenu

1. Animations du nain, de l'elfe et de l'enchanteur, puis des 9 monstres ([étape 4](animations-iso/concept-animations-iso.md#étapes)).
2. Campagne03 reliée aux aventures 115 à 124 (fiches et débriefings), comme Campagne01 l'est à 101 à 114.
3. Campagne05 : `quest501` à valider puis à intégrer (format `questLQQ` du dépôt HeroQuest), puis le reste du livre.
4. Campagnes 02, 04 et 06 : plateaux à extraire des livres PDF (skill `plateau-quete-js`), après arbitrage de leurs points ouverts.
5. Cartes de 2009 : aventures pour les cartes 7 et 8, cartes `.js` pour les images 9 à 12, relecture des résumés 1 à 6.

### Jalon 5 : confort et ouverture

1. Tactile et mobile : Pointer Events sur le plateau, `touch-action: none`, canvas à `devicePixelRatio` (plafonné à 2) avec conversion des coordonnées du clic. Aujourd'hui le déplacement ne se fait qu'aux flèches du clavier.
2. Accessibilité : zone `aria-live` qui annonce le tour, les jets et les dégâts ; liste HTML des cases visibles en parallèle du canvas.
3. Mode solo à plusieurs héros, que le moteur prévoit déjà (`LesJoueurs`) : prérequis de l'allié de la taverne.
4. Mise en ligne, si elle est décidée (D1) : debug coupé, sauvegarde de la base, limites d'inscription.

## Décisions à prendre

| N° | Question | Bloque |
| --- | --- | --- |
| D1 | Le jeu sera-t-il mis en ligne pour d'autres joueurs, ou reste-t-il local ? La priorité de la sécurité du plateau (jalon 2, points 1) et du jalon 5.4 en dépend | jalons 2 et 5 |
| D2 | Les décisions de la [taverne](taverne/concept-taverne.md#décisions-à-prendre) (noms des villages, Karlen ou Wardoz, quêtes de 2009 verrouillées, plafond de dés, réputation) | jalon 3 |
| D3 | Sorts : règles du HeroQuest de 1989 (cartes de sort à usage unique par quête) ou points de magie de la v1 ? | jalon 2.2 |
| D4 | Numérotation des aventures des campagnes 02 à 06 : `questLQQ` (livre 2023) ou par campagne ? Campagne06 vient du livre 8, Campagne05 du livre 5 | jalon 4 |
| D5 | Outil de génération des planches : continuer avec le générateur actuel et le fond vert, ou essayer un outil spécialisé (PixelLab, qui a un serveur MCP) ? | jalon 4.1 |
| D6 | Le multijoueur sur un même plateau, jamais terminé en v1 : abandonné, ou à garder au-delà du jalon 5 ? | rien pour l'instant |

## Skills, agents et outillage

### Existant

| Outil | Dépôt | Rôle |
| --- | --- | --- |
| skill `atlas-iso` | Donjon | construire l'atlas iso |
| agent `juge-planche` | Donjon | juger une planche d'animations |
| skills `structurer-campagne`, `decoupe-journal-quetes`, `importer-livre-quetes`, `plateau-quete-js` | HeroQuest | campagnes Markdown et plateaux |

Manque relevé : aucun outil ne fait passer un plateau du dépôt HeroQuest au jeu (copie de `questN.js` et `.jpg`, ligne `aventure`, test). C'est aujourd'hui « à la demande » dans `FORMAT.md`.

### À créer

| Outil | Type | Quand | Rôle |
| --- | --- | --- | --- |
| `jouer-quete` | agent (outils : Bash, navigateur Playwright) | jalon 1 | Lance le serveur, joue une quête dans les 3 vues, renvoie captures, erreurs de console et un verdict. Remplace l'étape 4 de [verification.md](../rules/verification.md). Agent plutôt que skill : les captures restent hors du contexte principal |
| `integrer-quete` | skill (Donjon) | jalon 4 | D'un plateau validé du dépôt HeroQuest à une aventure jouable : copie, migration de la ligne `aventure`, vérification d'accessibilité des monstres, appel de `jouer-quete` |
| `dialogue-taverne` | skill (Donjon) | jalon 3 | Convertit un dialogue Markdown de `kb/taverne/` en `data/dialogues/<pnj>.php` et vérifie le graphe : cibles existantes, nœuds atteignables, conditions et effets connus. La vérification est un script (`bin/verifier-dialogues.php`), le skill dit quand et comment l'utiliser |
| `gardien-lore` | agent (lecture seule) | jalon 3 et 4 | Compare un dialogue, une récompense ou un résumé d'aventure aux sources de la campagne. Signale ce qui est inventé ou contradictoire, sans trancher (règle du dépôt HeroQuest) |
| `rules/base.md` | règle | jalon 1 | Toute modification du schéma passe par une migration. Jamais de `reset-db` sur une base de joueurs |
| Hook `PostToolUse` | réglage | jalon 1 | `php -l` après chaque édition d'un `.php` |

### À ajuster

- `atlas-iso` : ajouter `paths` dans le frontmatter (`donjon-v2/public/assets/game/iso/**`, `donjon-v2/bin/atlas-iso.json`) pour qu'il se charge sur ces fichiers.
- `juge-planche` : `memory: project`, pour garder les défauts déjà vus d'une planche à l'autre.
- `plateau-quete-js` (HeroQuest) : finir par un renvoi à `integrer-quete` ; définir la numérotation après D4.
- `importer-livre-quetes` (HeroQuest) : écrire l'OCR dans le dossier temporaire de la session, pas dans `/tmp`.

## Sources

- Application compagnon HeroQuest (monstres pilotés, narration à l'exploration) : <https://apps.apple.com/app/id1586044591>, critique : <https://boardgamequest.com/heroquest-review>
- Descent, Road to Legend (carte révélée porte par porte, boucle ville et donjon) : <https://www.fantasyflightgames.com/en/news/2016/3/15/road-to-legend/>
- Tests de dialogue par parcours aléatoires : <https://github.com/wildwinter/Ink-Tester>
- Pest 4, tests navigateur : <https://pestphp.com/docs/browser-testing> ; captures Playwright : <https://playwright.dev/docs/test-snapshots>
- Playwright MCP dans Claude Code : <https://playwright.dev/mcp/clients/claude-code>
- Skills, sous-agents, hooks : <https://code.claude.com/docs/en/skills>, <https://code.claude.com/docs/en/sub-agents>, <https://code.claude.com/docs/en/hooks-guide>
- Sprites : PixelLab (isométrique, MCP) <https://pixellab.ai/> ; nettoyage du pixel art généré <https://pypi.org/project/unfake/>
- Canvas tactile et haute densité : <https://app.cinevva.com/tutorials/mobile-friendly-web-games>
