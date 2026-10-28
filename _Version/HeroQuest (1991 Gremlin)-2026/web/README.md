# Portage web

HeroQuest PC (Gremlin, 1991) dans un navigateur, à partir du code original traduit en JavaScript. Les fichiers du jeu ne sont pas copiés ici : `fichiers.php` les lit dans `../../HeroQuest (1991 Gremlin)`.

## Lancer

```bash
php -S 127.0.0.1:8765 -t web       # depuis HeroQuest (1991 Gremlin)-2026/
```

Puis ouvrir `http://127.0.0.1:8765/`. La page enchaîne les programmes comme `HERO.EXE` : `INTRO.EXE` (questions de configuration en mode texte, intro, choix de la langue sur l'écran des drapeaux), puis `QUEST.EXE`.

| Adresse | Effet |
| --- | --- |
| `index.html?sans-intro` | lance directement le jeu (configuration par défaut si `QUEST.CFG` manque : VGA, AdLib, souris, français) |
| `index.html?debug` | affiche sous l'écran le programme, le temps de jeu et l'IP ; expose `window.jeu` (son, machine) |

Le jeu dessine son propre curseur. Clavier : positions physiques du PC (voir `jeu/clavier.js`) ; Ctrl quitte.

Son : un seul type, l'AdLib (le choix de carte son de l'intro est ignoré). Comme dans l'original, la musique joue au départ et les effets sont muets ; F10 coupe la musique et active les effets. Le navigateur n'ouvre le son qu'au premier clic ou à la première touche. L'intro est muette : elle ne donne pas de morceaux à son pilote.

## Fichiers

| Chemin | Rôle |
| --- | --- |
| `jeu/quest.gen.js`, `jeu/intro.gen.js` | code traduit, généré par `outils/recompiler.py` : une fonction par routine, au nom de `original/symboles.txt` (ou `symboles-intro.txt`), chaque instruction d'origine en commentaire. Ne pas modifier à la main |
| `jeu/machine.js` | ce que le code attend autour de lui : registres et drapeaux du 8086, mémoire de 1 Mo, pile, DOS (fichiers, mémoire, vecteurs), BIOS (vidéo, clavier, zone de données), VGA 13h, EGA 0Dh, mode texte, souris, ports, IRQ clavier, temps |
| `jeu/exepack.js` | décompression EXEPACK et relocations, comme DOS au chargement |
| `jeu/principal.js` | la page : chargement des fichiers, boucle au rythme du temps réel, affichage, entrées |
| `jeu/clavier.js` | codes clavier du PC |
| `jeu/son.js` | joue les WAV de `sons/` quand le jeu appelle son pilote (int 60h : jouer, arrêter, silence) ; la musique en boucle |
| `sons/` | les morceaux du pilote AdLib en WAV (mono, 16 bits, 22 050 Hz), générés (voir « Son »), ignorés par git |
| `fichiers.php` | les fichiers d'origine en une archive ; écrit `QUEST.SAV` et `QUEST.CFG` dans `sauvegardes/` (ignoré par git), jamais dans le jeu d'origine |

## Comment le code est traduit

`recompiler.py` part du désassemblage suivant le flot (`desassembler.py`) et traduit chaque instruction atteinte. Une routine devient une fonction `nom_adresse(m, ip)` : elle exécute ses instructions tant que IP reste chez elle, puis rend IP à `machine.executer`. Appels, retours et sauts passent par la vraie pile du programme, comme sur le processeur d'origine : les astuces de pile et les sauts entre routines du code d'origine marchent sans traitement particulier.

- Les segments relogés par DOS (table EXEPACK) deviennent `valeur + m.L`.
- Les octets de code que le programme réécrit (code automodifié, par exemple 0x26C9) sont relus en mémoire à chaque passage ; une écriture dans un autre octet du code traduit est signalée dans la console.
- Le temps est compté en instructions, 3000 par milliseconde, comme `cycles = fixed 3000` dans `outils/dosbox-x.conf` : attentes, animations et retour de trame (70 Hz) durent comme sous DOSBox-X.

Le résultat est identique à l'original par construction : même mémoire, mêmes adresses, même générateur de hasard. On peut ensuite réécrire une routine à la main en gardant la version générée comme référence.

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
PROGRAMME=INTRO node essai.mjs 1 intro.png "car:1,car:1"                    # l'intro
node navigateur.mjs "http://127.0.0.1:8765/?sans-intro&debug" page.png "attendre:5,clic:163:130"  # dans Chrome
```

`difference.py` compare registres, drapeaux définis, octets écrits et instruction suivante ; il exclut les interruptions, les ports et l'appel du pilote de son, qui dépendent de l'environnement. Résultat au 28 octobre 2026 : QUEST 146 660 cas, INTRO 66 500 cas, 0 écart.

## Limites

- Son : morceaux préenregistrés ; un effet se mêle à la musique au lieu de lui prendre le canal 0 comme sur la vraie puce.
- Joystick non émulé (le port 201h répond « rien de branché »).
- Les écrans n'ont pas encore été comparés pixel à pixel avec des captures de DOSBox-X.
