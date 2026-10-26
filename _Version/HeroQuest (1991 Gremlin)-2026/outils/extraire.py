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


def messages(brut):
    """Messages d'un fichier de textes, tel que le jeu le charge en DS:5FC1 (voir original/notes/02-ecrans.md).
    Numéro = valeur passée dans BX à affiche_message (offset de l'entrée dans la table du début du fichier)."""
    # La table d'offsets s'arrête là où commence le premier message : le plus petit offset lu jusque-là.
    debuts, fin_table = [], len(brut)
    while 2 * len(debuts) < fin_table:
        offset = struct.unpack('<H', brut[2 * len(debuts):2 * len(debuts) + 2])[0]
        debuts.append(offset)
        fin_table = min(fin_table, offset)
    bornes = sorted(set(debuts)) + [len(brut)]                 # des entrées partagent le même texte
    lignes = ['# numéro (BX)  boîte : colonne ligne largeur hauteur  |  mots (boutons ?)  |  lignes : (ligne, colonne) texte', '']
    for index, debut in enumerate(debuts):
        numero = 2 * index
        fin = next(b for b in bornes if b > debut) if debut < len(brut) else debut
        entree = brut[debut:fin]
        if len(entree) < 6:
            lignes.append(f'{numero:04x}  (entrée vide ou hors du fichier : offset {debut:04x})')
            continue
        x, y, largeur, hauteur, a, b = entree[:6]
        mots, i = [], 6
        while i + 1 < len(entree) and entree[i:i + 2] != b'\xff\xff':
            mots.append(struct.unpack('<H', entree[i:i + 2])[0])
            i += 2
        texte = []
        for morceau in entree[i + 2:].split(b'\x11')[1:]:
            if len(morceau) >= 2:
                contenu = morceau[2:].split(b'\x00')[0].decode('cp437')
                texte.append(f'({morceau[0]},{morceau[1]}) {contenu}')
        lignes.append(f'{numero:04x}  {x} {y} {largeur} {hauteur} ({a} {b})  |  {" ".join(f"{m:04x}" for m in mots)}  |  '
                      + ' / '.join(texte))
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
    print(f'{palettes_et_ecrans()} écrans, {images()} sprites du plateau, {textes()} langues, {quetes()} quêtes')


if __name__ == '__main__':
    main()
