"""
Extrait toutes les données du HeroQuest PC (Gremlin, 1991) vers ../original/donnees/.

Usage (depuis ce dossier outils/) : python extraire.py

Sortie :
  palettes.json          palette du jeu (QUEST.EXE) et palettes des écrans de l'intro (INTRO.EXE)
  ecrans/                écrans 320 x 200 du jeu et de l'intro
  images/                sprites (sols, murs, portes, meubles, héros, monstres) et images d'interface
  textes/                textes du jeu décompressés (.bin) et lisibles (.txt), titres des quêtes
  quetes/                QUESTn.BIN en JSON, champ par champ

Les formats sont décrits dans ../../HeroQuest (1991 Gremlin)/FORMATS.md. Prérequis : Pillow.
"""

import importlib.util
import json
import re
import struct
from pathlib import Path

from PIL import Image

ICI = Path(__file__).resolve().parent
RACINE = ICI.parent
JEU = RACINE.parent / 'HeroQuest (1991 Gremlin)'
SORTIE = RACINE / 'original' / 'donnees'
BIN = RACINE.parent.parent / 'donjon-v2' / 'bin'


def charger(nom, fichier):
    spec = importlib.util.spec_from_file_location(nom, BIN / fichier)
    module = importlib.util.module_from_spec(spec)
    spec.loader.exec_module(module)
    return module


graphismes = charger('graphismes', 'extract-heroquest-graphics.py')
outils = charger('outils', 'heroquest-outils.py')

# Écrans de l'intro et leur palette de 32 couleurs dans le segment de données de INTRO.EXE (DS = 0).
INTRO_ECRANS = {'GREMLIN': 0x0CBE, 'PIC1': 0x0D1E, 'TEXT1': 0x0D86, 'HERO1': 0x0DEE, 'HERO2': 0x0E56,
                'HERO3': 0x0EBE, 'HERO4': 0x0F26, 'HERO6': 0x0F8E, 'HERO7': 0x0FF6}
JEU_ECRANS = ['BOOK', 'BORDERED', 'WIZBACK', 'QUESTB']
LANGUES = ['ENGLISH', 'FRENCH', 'GERMAN', 'ITALIAN', 'SPANISH']


def palette_vga(octets):
    return [v * 255 // 63 for v in octets] + [0] * (768 - len(octets))


def ecrire_image(chemin, pixels, taille, palette):
    image = Image.frombytes('P', taille, pixels)
    image.putpalette(palette)
    image.save(chemin, optimize=True)


def palettes_et_ecrans():
    quest = graphismes.exepack_unpack(JEU / 'QUEST.EXE')
    intro = graphismes.exepack_unpack(JEU / 'INTRO.EXE')
    jeu = list(quest[graphismes.DATA_SEGMENT + graphismes.PALETTE:][:768])
    palettes = {'jeu': jeu, 'intro': {nom: list(intro[p:p + 96]) for nom, p in INTRO_ECRANS.items()}}
    (SORTIE / 'palettes.json').write_text(json.dumps(palettes, separators=(',', ':')), encoding='utf-8')

    dossier = SORTIE / 'ecrans'
    dossier.mkdir(parents=True, exist_ok=True)
    for nom in JEU_ECRANS:
        pixels = graphismes.vga_unpack((JEU / f'{nom}.VGA').read_bytes())
        ecrire_image(dossier / f'{nom.lower()}.png', pixels[:64000], (320, 200), palette_vga(jeu))
    for nom, offset in INTRO_ECRANS.items():
        pixels = graphismes.vga_unpack((JEU / f'{nom}.VGA').read_bytes())
        ecrire_image(dossier / f'intro-{nom.lower()}.png', pixels[:64000], (320, 200), palette_vga(intro[offset:offset + 96]))
    return len(JEU_ECRANS) + len(INTRO_ECRANS)


def images():
    """Sprites du plateau (mêmes tables que l'atlas iso) puis images d'interface (CATALOGUE)."""
    dossier = SORTIE / 'images'
    dossier.mkdir(parents=True, exist_ok=True)
    extracteur = graphismes.Extractor(JEU)
    extracteur.extract()
    for nom, image, _ in extracteur.frames:
        image.save(dossier / f'plateau-{nom}.png', optimize=True)
    outils.cmd_catalogue(JEU, dossier)
    return len(extracteur.frames)


def combat():
    """Gros plan du combat (animation_combat, 0x1F14) : les 31 poses de MEN.VGA et les séquences d'animation.
    Tables de QUEST.EXE (DS) : A0FD position dans MEN, A13B taille (largeur, hauteur), A179 position à l'écran,
    A381 séquence d'attaque de chaque type de héros (7 octets), A3A4 arme lancée, A1B7 position du monstre
    par classe, A1D9 / A1E9 / A1F9 / A209 séquences du monstre (touché sans mourir, tué, puis les mêmes
    contre une arme lancée). Codes de séquence : FFh fin, 7Dh image inchangée, FEh projectile déplacé."""
    quest = graphismes.exepack_unpack(JEU / 'QUEST.EXE')
    ds = graphismes.DATA_SEGMENT

    def mots(offset, nombre):
        return list(struct.unpack(f'<{nombre}H', quest[ds + offset:ds + offset + 2 * nombre]))

    def sequence(offset):
        fin = quest.index(b'\xff', ds + offset)
        return list(quest[ds + offset:fin])

    men = graphismes.vga_unpack((JEU / 'MEN.VGA').read_bytes())
    palette = palette_vga(list(quest[ds + graphismes.PALETTE:][:768]))
    dossier = SORTIE / 'images' / 'combat'
    dossier.mkdir(parents=True, exist_ok=True)
    poses = []
    for numero, (debut, taille, ecran) in enumerate(zip(mots(0xA0FD, 31), mots(0xA13B, 31), mots(0xA179, 31))):
        largeur, hauteur = taille & 0xFF, taille >> 8
        ecrire_image(dossier / f'men-{numero:02d}.png', men[debut:debut + largeur * hauteur], (largeur, hauteur), palette)
        poses.append({'men': debut, 'largeur': largeur, 'hauteur': hauteur, 'x': ecran % 320, 'y': ecran // 320})

    donnees = {
        'poses': poses,
        'heros': [sequence(0xA381 + 7 * t) for t in range(5)],
        'arme_lancee': sequence(0xA3A4),
        'monstre_position': [{'x': p % 320, 'y': p // 320} for p in mots(0xA1B7, 8)],
        'monstre_touche': [sequence(o) for o in mots(0xA1D9, 8)],
        'monstre_tue': [sequence(o) for o in mots(0xA1E9, 8)],
        'monstre_touche_distance': [sequence(o) for o in mots(0xA1F9, 8)],
        'monstre_tue_distance': [sequence(o) for o in mots(0xA209, 8)],
    }
    (SORTIE / 'combat.json').write_text(json.dumps(donnees, indent=1), encoding='utf-8')
    return len(poses)


def textes():
    dossier = SORTIE / 'textes'
    dossier.mkdir(parents=True, exist_ok=True)
    for langue in LANGUES:
        brut = graphismes.vga_unpack((JEU / f'{langue}.BIN').read_bytes())
        (dossier / f'{langue.lower()}.bin').write_bytes(brut)
        lignes = [f'{m.start():05x}  {m.group().decode("cp437")}' for m in re.finditer(rb'[\x20-\x7e\x80-\xa8]{3,}', brut)]
        (dossier / f'{langue.lower()}.txt').write_text('\n'.join(lignes) + '\n', encoding='utf-8')
        (dossier / f'{langue.lower()}-messages.txt').write_text(messages(brut), encoding='utf-8')
    titres = [m.group().decode('cp437') for m in re.finditer(rb'[\x20-\x7e]{4,}', (JEU / 'EQUESTS.BIN').read_bytes())]
    (dossier / 'titres-quetes.txt').write_text('\n'.join(titres) + '\n', encoding='utf-8')
    return len(LANGUES)


def table_messages(brut):
    """(numéro, octets de l'entrée) pour chaque message d'un fichier de textes décompressé.
    La table d'offsets du début s'arrête là où commence le premier message : le plus petit offset lu jusque-là.
    Numéro = valeur passée dans BX à affiche_message (voir original/notes/02-ecrans.md)."""
    debuts, fin_table = [], len(brut)
    while 2 * len(debuts) < fin_table:
        offset = struct.unpack('<H', brut[2 * len(debuts):2 * len(debuts) + 2])[0]
        debuts.append(offset)
        fin_table = min(fin_table, offset)
    for index, debut in enumerate(debuts):                     # une entrée peut déborder sur la suivante :
        yield 2 * index, brut[debut:]                           # le décodage s'arrête au 00h final


def decoder_message(entree):
    """En-tête : boîte (colonne, ligne, largeur, hauteur). Puis les boutons jusqu'à FFFFh : colonne, ligne,
    offset du libellé dans le fichier de textes (mot), numéro (mot). Puis les lignes « 11h, ligne, colonne, texte »
    jusqu'à 00h. Lecture séquentielle : la ligne d'écran 17 s'écrit 11h, comme le marqueur.
    None si l'entrée est trop courte."""
    if len(entree) < 6:
        return None
    boutons, i = [], 4
    while i + 5 < len(entree) and entree[i:i + 2] != b'\xff\xff':
        libelle, numero = struct.unpack('<HH', entree[i + 2:i + 6])
        boutons.append((entree[i], entree[i + 1], libelle, numero))
        i += 6
    i += 2
    lignes = []
    while i + 2 < len(entree) and entree[i] == 0x11:
        ligne, colonne, j = entree[i + 1], entree[i + 2], i + 3
        while j < len(entree) and entree[j] not in (0x00, 0x11):
            j += 1
        lignes.append((ligne, colonne, entree[i + 3:j].decode('cp437')))
        if j >= len(entree) or entree[j] == 0x00:
            break
        i = j
    return {'boite': list(entree[:4]), 'boutons': boutons, 'lignes': lignes}


def libelle(brut, offset):
    """Texte d'un libellé de bouton : « 11h, 0, 0, texte, 00h » à l'offset donné du fichier de textes."""
    if offset + 3 >= len(brut) or brut[offset] != 0x11:
        return f'?{offset:04x}'
    return brut[offset + 3:brut.index(b'\0', offset + 3)].decode('cp437')


def messages(brut):
    """Liste lisible des messages d'un fichier de textes."""
    lignes = ['# numéro (BX)  boîte : colonne ligne largeur hauteur  |  boutons : [numéro (colonne,ligne) libellé]  |  '
              'lignes : (ligne, colonne) texte', '']
    for numero, entree in table_messages(brut):
        m = decoder_message(entree)
        if m is None:
            lignes.append(f'{numero:04x}  (entrée vide ou hors du fichier)')
            continue
        texte = ' / '.join(f'({l},{c}) {t}' for l, c, t in m['lignes'])
        libelles = [libelle(brut, o) for _, _, o, _ in m['boutons']]
        if any(t.startswith('?') for t in libelles):               # pas une boîte : une simple chaîne
            chaine = (entree[3:] if entree[0] == 0x11 else entree).split(b'\0')[0].decode('cp437')
            chaine = ''.join(c if c >= ' ' else ' ' for c in chaine)
            lignes.append(f'{numero:04x}  chaîne : {chaine}')
            continue
        boutons = ' '.join(f'[{n} ({c},{l}) {t}]' for (c, l, _, n), t in zip(m['boutons'], libelles))
        lignes.append(f'{numero:04x}  {" ".join(map(str, m["boite"]))}  |  {boutons}  |  {texte}')
    return '\n'.join(lignes) + '\n'


def quetes():
    """Chaque QUESTn.BIN en JSON, sans interprétation (voir FORMATS.md, « Quêtes : QUESTn.BIN »)."""
    dossier = SORTIE / 'quetes'
    dossier.mkdir(parents=True, exist_ok=True)
    for numero in range(1, 25):
        d = (JEU / f'QUEST{numero}.BIN').read_bytes()
        texte, longueur, monstres, taille_monstres, mobilier, objets = struct.unpack('<6H', d[1122:1134])
        quete = {
            'numero': numero,
            'zones': [list(d[y * 26:y * 26 + 26]) for y in range(19)],
            'murs': [list(d[512 + y * 26:512 + y * 26 + 26]) for y in range(19)],
            'departs': [list(d[1024 + 3 * i:1027 + 3 * i]) for i in range(4)],
            'evenements_zone': list(d[1036:1079]),
            'drapeaux_zone': list(d[1079:1122]),
            'entete': [texte, longueur, monstres, taille_monstres, mobilier, objets],
            'monstres': [list(d[1122 + i:1132 + i]) for i in range(monstres, monstres + taille_monstres, 10)],
            'mobilier': [list(d[1122 + i:1125 + i]) for i in range(mobilier, mobilier + 3 * objets, 3)],
            'texte': [ligne[2:].decode('cp437') for ligne in d[1122 + texte:1122 + texte + longueur + 1].split(b'\x11')[1:]],
        }
        (dossier / f'quest{numero:02d}.json').write_text(json.dumps(quete, ensure_ascii=False, indent=1), encoding='utf-8')
    return 24


def main():
    SORTIE.mkdir(parents=True, exist_ok=True)
    print(f'{palettes_et_ecrans()} écrans, {images()} sprites du plateau, {combat()} poses de combat, '
          f'{textes()} langues, {quetes()} quêtes')


if __name__ == '__main__':
    main()
