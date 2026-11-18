# Portage web

HeroQuest PC (Gremlin, 1991) dans un navigateur, à partir du code original traduit en JavaScript. Les fichiers du jeu ne sont pas copiés ici : `fichiers.php` les lit dans `../../HeroQuest (1991 Gremlin)`.

## Lancer

```bash
php -S 127.0.0.1:8765 -t web       # depuis HeroQuest (1991 Gremlin)-2026/
```

Puis ouvrir `http://127.0.0.1:8765/`. La page enchaîne les programmes comme `HERO.EXE` : `INTRO.EXE`, puis `QUEST.EXE`.

Un seul affichage, le VGA, et un seul son, l'AdLib. La page fournit `QUEST.CFG` avec ces choix : l'intro ne pose donc pas ses questions de configuration, et la touche S (« Press S to change config ») est ignorée, car elle rouvrirait ces questions et l'écran des drapeaux, qui n'existe qu'en EGA. La langue se choisit dans l'adresse. Les commandes des joueurs restent celles du `QUEST.CFG` enregistré (souris par défaut).

| Adresse | Effet |
| --- | --- |
| `index.html?sans-intro` | lance directement le jeu ; pendant l'intro, Échap ou le bouton « Passer l'intro » font de même |
| `index.html?langue=en` | langue des textes : `fr` (par défaut), `en`, `es`, `de`, `it` |
| `index.html?genere` | code généré seul, sans les routines réécrites de `jeu/lisible/` (pour comparer) |
| `index.html?debug` | affiche sous l'écran le programme, le temps de jeu et l'IP ; expose `window.jeu` (son, machine) |

Le jeu dessine son propre curseur. Clavier : positions physiques du PC (voir `jeu/clavier.js`) ; Ctrl quitte.

Son : comme dans l'original, la musique joue au départ (dès l'intro) et les effets sont muets ; F10 coupe la musique et active les effets. Le navigateur n'ouvre le son qu'au premier clic ou à la première touche.

## Fichiers

| Chemin | Rôle |
| --- | --- |
| `jeu/quest.gen.js`, `jeu/intro.gen.js` | code traduit, généré par `outils/recompiler.py` : une fonction par routine, au nom de `original/symboles.txt` (ou `symboles-intro.txt`), chaque instruction d'origine en commentaire. Ne pas modifier à la main |
| `jeu/machine.js` | ce que le code attend autour de lui : registres et drapeaux du 8086, mémoire de 1 Mo, pile, DOS (fichiers, mémoire, vecteurs), BIOS (vidéo, clavier, zone de données), VGA 13h, mode texte, souris, ports, IRQ clavier, temps |
| `jeu/exepack.js` | décompression EXEPACK et relocations, comme DOS au chargement |
| `jeu/principal.js` | la page : chargement des fichiers, boucle au rythme du temps réel, affichage, entrées |
| `jeu/lisible/` | le code réécrit à la main, lisible (voir « Code lisible ») |
| `jeu/clavier.js` | codes clavier du PC |
| `jeu/son.js` | joue les WAV de `sons/` quand le jeu appelle son pilote (int 60h : jouer, arrêter, silence) ; la musique en boucle |
| `sons/` | les morceaux du pilote AdLib en WAV (mono, 16 bits, 22 050 Hz), générés (voir « Son »), ignorés par git |
| `fichiers.php` | les fichiers d'origine en une archive, sans ceux des autres versions (`.EGA`, pilotes Tandy et MT-32) ; écrit `QUEST.SAV` et `QUEST.CFG` dans `sauvegardes/` (ignoré par git), jamais dans le jeu d'origine |

## Comment le code est traduit

`recompiler.py` part du désassemblage suivant le flot (`desassembler.py`) et traduit chaque instruction atteinte. Une routine devient une fonction `nom_adresse(m, ip)` : elle exécute ses instructions tant que IP reste chez elle, puis rend IP à `machine.executer`. Appels, retours et sauts passent par la vraie pile du programme, comme sur le processeur d'origine : les astuces de pile et les sauts entre routines du code d'origine marchent sans traitement particulier.

- Les segments relogés par DOS (table EXEPACK) deviennent `valeur + m.L`.
- Les octets de code que le programme réécrit (code automodifié, par exemple 0x26C9) sont relus en mémoire à chaque passage ; une écriture dans un autre octet du code traduit est signalée dans la console.
- Le temps est compté en instructions, 3000 par milliseconde, comme `cycles = fixed 3000` dans `outils/dosbox-x.conf` : attentes, animations et retour de trame (70 Hz) durent comme sous DOSBox-X.

Le résultat est identique à l'original par construction : même mémoire, mêmes adresses, même générateur de hasard. On peut ensuite réécrire une routine à la main en gardant la version générée comme référence.

## Code lisible

`jeu/lisible/` réécrit les routines du jeu en classes et méthodes, avec des noms clairs, pour expliquer le fonctionnement du jeu de 1991. Chaque routine réécrite remplace sa version générée et travaille sur la même mémoire : le reste du jeu, encore généré, ne voit pas la différence.

| Fichier | Contenu |
| --- | --- |
| `donnees.js` | vue nommée du segment de données : variables communes (`numeroQuete`, `adresseCible`...), fiche d'un personnage (`Fiche`), monstre (`Monstre`), bits des objets et des sorts ; chaque module ajoute ses variables avec `definirVariables` |
| `module.js` | base des modules : `appeler` une routine d'origine et attendre son retour, `sauter` vers elle, `afficherMessage` |
| `hasard.js` | le générateur de hasard (registre à décalage de 32 bits) |
| `combat.js` | dés de combat, attaque d'un héros, attaque d'un monstre |
| `deplacement.js` | dés de déplacement, fin du déplacement, flèches, les 4 pas, pièges cachés, téléports des quêtes 10 et 16, clic sur le plateau, chemin automatique |
| `messages.js` | numéros des messages utilisés, avec leur texte |
| `adresses.gen.js` | adresse de chaque routine nommée, générée par `outils/adresses.py` depuis `original/symboles.txt` |
| `routines.js` | branchement : adresse d'origine -> méthode, registres rendus aux appelants, temps compté |

Réécrites à ce jour (QUEST.EXE), 25 routines :

- hasard et combat : `hasard`, `de6_moins_un`, `de_combat`, `compte_cranes`, `calcule_des_monstre`, `bonus_attaque_heros`, `calcule_defense_heros`, `calcule_attaque_heros`, `attaque_heros`, `combat_monstre`, `attaque_contre_heros` ;
- déplacement : `des_deplacement_tour`, `tirage_deplacement` (avec `lancer_deplacement`), `fin_deplacement`, `arrete_deplacement`, `fleches_deplacement`, `pas_gauche`, `pas_droite`, `pas_haut`, `pas_bas` (avec `pas_fait`, `personnage_en_dx`, `porte_reveille`), `pas_automatique`, `clic_plateau`, `chemin_heros` (avec `chemin_essaie` et `pas_permis`), `tire_teleport`, `entre_piege`.

`tour_personnage` reste générée.

Deux sortes de routines :

- d'un seul tenant : une méthode qui ne fait que calculer (`Combat.calculerDefenseHeros`). Elle rend les registres que ses appelants lisent (champ `sortie`), pas les drapeaux du processeur ;
- par étapes : une méthode génératrice (`*attaqueHeros`), pour une routine qui attend le joueur, l'écran ou une animation. `yield* this.appeler(QUEST.charge_men)` pose sur la pile du programme une adresse de retour réservée (`RETOUR_LISIBLE`, 0xFFF0), exécute la routine d'origine au rythme du temps réel, et reprend la méthode quand elle revient. Une méthode qui finit par `return this.sauter(QUEST.fin_action)` continue par un saut, comme le `jmp` d'origine.

Le temps du jeu avance du nombre moyen d'instructions de la version générée (champ `cout`), à quelques instructions près selon le chemin suivi : le rythme reste celui de l'original, pas au cycle près.

Pour réécrire une routine : lire son listing dans `original/asm/quest.asm`, écrire la méthode dans le module du sous-système, l'ajouter à `routines.js`, puis la comparer.

Vérifier, depuis `outils/` :

```bash
node lisible.mjs 100                         # chaque routine réécrite contre sa version générée, 100 états au hasard
node lisible.mjs 40 attaque_heros            # une seule routine
TEMOIN=e0e node lisible.mjs 60 attaque_heros # compte aussi les cas où DS:0E0E change (chemin rare couvert ?)
GENERE=1 node essai.mjs 5 gen.png "…"        # le même parcours avec le code généré seul, pour comparer les captures
```

`lisible.mjs` mène d'abord le jeu jusqu'au plateau de la 1re quête, puis tire au hasard la graine, les fiches, le monstre visé, l'état du tour et les alentours du héros (murs, portes, occupants, zones), avec des scénarios ciblés (voie libre, piège caché, téléport du château, pièce tournante). Il compare toute la mémoire (données, écran, images), sauf la pile. Les boîtes de message et les attentes de clic reçoivent des clics simulés (droit, ou gauche sur OUI), réglés sur le nombre de lectures de la souris et non sur le temps, qui diffère de quelques instructions entre les deux versions.

Au 18 novembre 2026 : les 25 routines sont identiques sur 100 cas chacune (seconde attaque du poison d'orc, pas réussis, portes, pièges cachés et téléport du château couverts), et un parcours avec lancer de dés, clics sur le plateau et sur les 4 flèches donne la même image qu'avec le code généré seul.

## Son

Le pilote d'origine (`ADLIB.DRV`) n'est pas exécuté dans la page. Ses morceaux sont rendus une fois en WAV, depuis `outils/` :

```bash
python son.py        # fait jouer chaque morceau par ADLIB.DRV (Unicorn) et relève les écritures dans la puce
node sons.mjs        # les rend en WAV avec opl2.mjs, émulateur de la puce OPL2 écrit pour le projet
```

| Fichier | Contenu |
| --- | --- |
| `morceau00.wav` | la musique, 603 s ; elle n'a pas de boucle globale (chaque voix boucle à sa façon) : la page la rejoue depuis le début |
| `morceau02.wav`, `06`, `08`, `05`, `09` | pas, dés, clic, gros plan du combat, sort et piège |

Le morceau 3 (porte) ne fait qu'arrêter une note : avec l'AdLib, une porte qui s'ouvre est muette, comme dans l'original. Le rendu suit le fonctionnement de la puce décrit par Nuked-OPL3 (tables, enveloppes, vibrato, trémolo, mode rythmique) ; les hauteurs ont été vérifiées par analyse de fréquence, pas encore à l'oreille contre DOSBox-X. Le MP3 demanderait un encodeur (lame ou ffmpeg), absent pour l'instant.

## Vérifier

Depuis `outils/` (prérequis : `pip install capstone unicorn`, Node 22 ou plus) :

```bash
python recompiler.py QUEST        # puis INTRO : régénère jeu/*.gen.js
python difference.py 10 QUEST     # chaque instruction traduite contre un vrai x86 (Unicorn), 10 états au hasard ; puis INTRO
node essai.mjs 5 menu.png "clic:68:128,attendre:3,clic:160:44,attendre:4"   # le jeu sans navigateur
PROGRAMME=INTRO node essai.mjs 15 intro.png "espace,attendre:8"             # l'intro
node navigateur.mjs "http://127.0.0.1:8765/?sans-intro&debug" page.png "attendre:5,clic:163:130"  # dans Chrome
```

`difference.py` compare registres, drapeaux définis, octets écrits et instruction suivante ; il exclut les interruptions, les ports et l'appel du pilote de son, qui dépendent de l'environnement. Résultat au 18 novembre 2026 : QUEST 146 660 cas, INTRO 67 400 cas, 0 écart.

## Limites

- Son : morceaux préenregistrés ; un effet se mêle à la musique au lieu de lui prendre le canal 0 comme sur la vraie puce.
- Joystick non émulé (le port 201h répond « rien de branché »).
- Les modes EGA et Tandy du jeu ne sont pas émulés : un seul affichage, le VGA.
- Les écrans n'ont pas encore été comparés pixel à pixel avec des captures de DOSBox-X.
