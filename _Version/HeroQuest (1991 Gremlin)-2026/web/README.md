# Portage web

HeroQuest PC (Gremlin, 1991) dans un navigateur, à partir du code original traduit en JavaScript. Les fichiers du jeu ne sont pas copiés ici : `fichiers.php` les lit dans `../../HeroQuest (1991 Gremlin)`.

## Lancer

```bash
php -S 127.0.0.1:8765 -t web       # depuis HeroQuest (1991 Gremlin)-2026/
```

Puis ouvrir `http://127.0.0.1:8765/`. La page enchaîne les programmes comme `HERO.EXE` : `INTRO.EXE` (questions de configuration en mode texte, intro, choix de la langue sur l'écran des drapeaux), puis `QUEST.EXE`.

| Adresse | Effet |
| --- | --- |
| `index.html?sans-intro` | lance directement le jeu (configuration par défaut si `QUEST.CFG` manque : VGA, haut-parleur, souris, français) |
| `index.html?debug` | affiche sous l'écran le programme, le temps de jeu et l'IP |

Le jeu dessine son propre curseur. Clavier : positions physiques du PC (voir `jeu/clavier.js`) ; F10 coupe la musique, Ctrl quitte.

## Fichiers

| Chemin | Rôle |
| --- | --- |
| `jeu/quest.gen.js`, `jeu/intro.gen.js` | code traduit, généré par `outils/recompiler.py` : une fonction par routine, au nom de `original/symboles.txt` (ou `symboles-intro.txt`), chaque instruction d'origine en commentaire. Ne pas modifier à la main |
| `jeu/machine.js` | ce que le code attend autour de lui : registres et drapeaux du 8086, mémoire de 1 Mo, pile, DOS (fichiers, mémoire, vecteurs), BIOS (vidéo, clavier, zone de données), VGA 13h, EGA 0Dh, mode texte, souris, ports, IRQ clavier, temps |
| `jeu/exepack.js` | décompression EXEPACK et relocations, comme DOS au chargement |
| `jeu/principal.js` | la page : chargement des fichiers, boucle au rythme du temps réel, affichage, entrées |
| `jeu/clavier.js`, `jeu/haut-parleur.js` | codes clavier du PC ; haut-parleur (ports 42h et 61h) en WebAudio |
| `fichiers.php` | les fichiers d'origine en une archive ; écrit `QUEST.SAV` et `QUEST.CFG` dans `sauvegardes/` (ignoré par git), jamais dans le jeu d'origine |

## Comment le code est traduit

`recompiler.py` part du désassemblage suivant le flot (`desassembler.py`) et traduit chaque instruction atteinte. Une routine devient une fonction `nom_adresse(m, ip)` : elle exécute ses instructions tant que IP reste chez elle, puis rend IP à `machine.executer`. Appels, retours et sauts passent par la vraie pile du programme, comme sur le processeur d'origine : les astuces de pile et les sauts entre routines du code d'origine marchent sans traitement particulier.

- Les segments relogés par DOS (table EXEPACK) deviennent `valeur + m.L`.
- Les octets de code que le programme réécrit (code automodifié, par exemple 0x26C9) sont relus en mémoire à chaque passage ; une écriture dans un autre octet du code traduit est signalée dans la console.
- Le temps est compté en instructions, 3000 par milliseconde, comme `cycles = fixed 3000` dans `outils/dosbox-x.conf` : attentes, animations et retour de trame (70 Hz) durent comme sous DOSBox-X.

Le résultat est identique à l'original par construction : même mémoire, mêmes adresses, même générateur de hasard. On peut ensuite réécrire une routine à la main en gardant la version générée comme référence.

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

- Son : le pilote (`ADLIB.DRV`, `int 60h`) est muet ; seuls les effets du haut-parleur (pilote 0, « Internal ») sont joués. Décision D3 de la roadmap.
- Joystick non émulé (le port 201h répond « rien de branché »).
- Les écrans n'ont pas encore été comparés pixel à pixel avec des captures de DOSBox-X.
