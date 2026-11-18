# INTRO.EXE

Configuration, intro animée et choix de la langue. Les adresses sont celles de `original/asm/intro.asm` (positions dans l'image décompressée, CS:0 = 0x44B0, DS = 0) ; les noms viennent de `original/symboles-intro.txt`. Les écrans et les animations des scènes sont décrits dans [02-ecrans.md](02-ecrans.md#intro).

État : les 91 routines sont nommées et décrites, aucun saut indirect non résolu. La seule zone non atteinte (0x689F-0x69B5) est faite de données.

## Déroulé

`demarrage_intro` (0x44B0) :

1. Réduit la mémoire (int 21h AH=4Ah), passe en mode texte, lit QUEST.CFG en DS:1440 (même format que pour QUEST, voir [01-socle.md](01-socle.md#questcfg)).
2. Fichier présent : « Press S to change config ». Le clavier est sondé environ 65 535 tours ; S efface QUEST.CFG.
3. Fichier absent : questions en mode texte. Écran (1 VGA → 8, 2 EGA → 6, 3 Tandy → 4), carte son (haut-parleur, AdLib, Roland), puis commandes de chaque héros (souris, clavier, joystick).
4. Mode vidéo (`mode_video_intro`), puis son : `lit_ports_video`, `son_charge_pilote`, `son_prepare` (la musique démarre).
5. VGA : GREMLIN (fondu en 128 étapes), pause (`temporise`, CX = 2000), PIC1, crédits sur TEXT1, puis les 6 scènes. Pour chacune : écran, palette, animation (`anime_scene`, table CS:071E), texte sur TEXT1.
6. EGA et Tandy (`intro_ega`) : aucune animation. Fond BORDERED, écusson SHOPMP sur l'écran de copyright, puis crédits et les 6 textes.
7. Chaque attente rend Espace ou Échap (`attend_espace_echap`) ; Échap saute à la fin.
8. `fin_intro` relit QUEST.CFG. Présent : on quitte. Absent (première configuration) : `ecran_drapeaux`.
9. `ecran_drapeaux` passe en mode EGA, même si VGA est choisi (le choix est gardé en DS:10A2), et affiche FLAGS.EGA ; en Tandy, l'écran passe par `affiche_tandy`. Les touches E F S G I donnent la langue 0 à 4. QUEST.CFG est écrit, puis l'intro vérifie que QUEST.EXE s'ouvre (« Insert disk 2 » en boucle sinon).
10. `quitte_intro` remet int 9, arrête le son (`son_arret`), repasse en mode texte et quitte avec le code 0. INTRO ne lance pas QUEST.EXE : c'est HERO.EXE qui enchaîne (dans le portage, la page).

## Affichage

- Scènes VGA : l'écran compressé reste en segment 1A26. À chaque image, `restaure_fond` le redécompresse dans le tampon 0A86, les sprites sont dessinés par-dessus (couleur 0 transparente), puis `tampon_vers_ecran` copie en A000.
- Fondus : `pas_du_fondu` calcule 96 pas en 8.8 ; `fondu_entree` et `fondu_noir` font 128 étapes, une par trame. `fondu_noir` reprend les pas de l'écran précédent.
- Texte : `affiche_chaine` puis `affiche_caractere`, police 8 × 8 (DS:13B5), un tracé par mode (Tandy, EGA, VGA). Codes dans les chaînes : 1 segment, 10h couleurs, 11h et 12h position.
- `affiche_tandy` (6 322 octets) n'est qu'une boucle déroulée : conversion de 4 plans vers 4 bits par pixel en B800h, 4 banques de 2000h.

## Saisie et son

Mêmes routines que QUEST, dans une version plus ancienne : `clavier_interruption` (128 touches en DS:1BB4), `lit_commandes` (bits de DS:1C34, Échap + Ctrl = 40h), `lit_joystick`, `lit_souris`. F10 coupe la musique (`son_musique`, appelée par `lit_commandes`). Le pilote de son est appelé par int 60h comme dans [01-socle.md](01-socle.md#son).

## Code mort

INTRO contient la bibliothèque commune avec QUEST, liée telle quelle. Ne sont jamais appelés : `lit_configuration` et `etalonne_joystick`, `ligne_ecran`, `mode_tandy`, `hasard`, `efface_ecran`, `pause_longue`, `souris_position`, `attend_commande`, `attend_clic`, `attend_relache_boutons`, `saisie_nombre`, `copie_image`, `efface_rectangle`, `numero_bit`, `installe_erreur_disque`, `erreur_disque`, `quitte`, et les outils de mise au point (`affiche_registres` et l'affichage hexadécimal, `longueur_texte`).

`etalonne_joystick` garde le masque C0h du joystick B, avec le même bogue que dans QUEST (voir [01-socle.md](01-socle.md#commandes)).

Zone non atteinte 0x689F-0x69B5 : compteur de rangées d'`affiche_tandy` (CS:23EF), un motif de cadre de 16 octets par rangée sans lecture repérée, et les compteurs d'`affiche_sprite` (CS:2500-2504).

## Points non vérifiés

- `efface_ecran` (morte) : les branches Tandy (remplit A000h avec `mode_video`) et EGA (200 mots seulement) semblent fausses.
- `affiche_caractere`, code 11h : AH n'est pas remis à zéro avant d'écrire la ligne. Sans effet si AH vaut 0 à l'entrée.
- `son_arret` lit une poignée en DS:144E que rien n'écrit dans INTRO.
- Le motif de cadre de 0x68B0-0x69B5 : usage inconnu.
