"""
Outils pour explorer les fichiers du HeroQuest PC de Gremlin (1991). Formats : _Version/HeroQuest (1991 Gremlin)/FORMATS.md.

Usage (depuis donjon-v2, JEU = "../_Version/HeroQuest (1991 Gremlin)") :
  python bin/heroquest-outils.py exe JEU/QUEST.EXE quest.bin          décompresse un .EXE (EXEPACK) en image mémoire
  python bin/heroquest-outils.py lz JEU/FRENCH.BIN french.txt         décompresse un .VGA ou un .BIN (LZ du jeu)
  python bin/heroquest-outils.py planche JEU/FURN.VGA 64 furn.png     affiche un .VGA décompressé avec une largeur donnée
  python bin/heroquest-outils.py textes JEU/FRENCH.BIN                liste les textes lisibles d'un fichier décompressé
  python bin/heroquest-outils.py desasm quest.bin 4548 60             désassemble 60 instructions (adresse = position dans l'image)
  python bin/heroquest-outils.py cherche quest.bin a12f5e             positions d'une suite d'octets (hexadécimal)
  python bin/heroquest-outils.py ds quest.bin 43fc 128                vidage hexadécimal du segment de données (DS = 0x97c0)
  python bin/heroquest-outils.py catalogue JEU images/                exporte en PNG toutes les images identifiées (CATALOGUE)

Prérequis : Pillow ; capstone pour desasm (pip install capstone).
"""

import importlib.util
import re
import sys
from pathlib import Path

HERE = Path(__file__).resolve().parent
_spec = importlib.util.spec_from_file_location('graphics', HERE / 'extract-heroquest-graphics.py')
graphics = importlib.util.module_from_spec(_spec)
_spec.loader.exec_module(graphics)

DATA_SEGMENT = graphics.DATA_SEGMENT


def palette(game_dir):
    program = graphics.exepack_unpack(Path(game_dir) / 'QUEST.EXE')
    raw = program[DATA_SEGMENT + graphics.PALETTE:DATA_SEGMENT + graphics.PALETTE + 768]
    return [v * 255 // 63 for v in raw]


def cmd_exe(source, target):
    data = graphics.exepack_unpack(Path(source))
    Path(target).write_bytes(data)
    print(f'{len(data)} octets écrits')


def cmd_lz(source, target):
    data = graphics.vga_unpack(Path(source).read_bytes())
    Path(target).write_bytes(data)
    print(f'{len(data)} octets écrits')


def cmd_planche(source, width, target):
    from PIL import Image
    source, width = Path(source), int(width)
    data = graphics.vga_unpack(source.read_bytes())
    height = len(data) // width
    image = Image.frombytes('P', (width, height), data[:width * height])
    image.putpalette(palette(source.parent))
    image.convert('RGB').save(target)
    print(f'{width} x {height} écrit dans {target}')


def cmd_textes(source):
    data = graphics.vga_unpack(Path(source).read_bytes())
    for match in re.finditer(rb'[\x20-\x7e]{6,}', data):
        print(f'{match.start():05x}  {match.group().decode("latin-1")}')


def cmd_desasm(image, start, count='40'):
    from capstone import CS_ARCH_X86, CS_MODE_16, Cs
    data = Path(image).read_bytes()
    start, count = int(start, 16), int(count)
    for instruction in Cs(CS_ARCH_X86, CS_MODE_16).disasm(data[start:start + count * 7], start):
        print(f'{instruction.address:05x}  {instruction.bytes.hex():<18} {instruction.mnemonic} {instruction.op_str}')
        count -= 1
        if count <= 0:
            break


def cmd_cherche(image, pattern):
    data, pattern = Path(image).read_bytes(), bytes.fromhex(pattern)
    position = data.find(pattern)
    while position >= 0:
        note = f'  (DS:{position - DATA_SEGMENT:04x})' if position >= DATA_SEGMENT else ''
        print(f'{position:05x}{note}')
        position = data.find(pattern, position + 1)


def cmd_ds(image, offset, length='64'):
    data = Path(image).read_bytes()
    offset, length = int(offset, 16), int(length)
    for line in range(offset, offset + length, 16):
        chunk = data[DATA_SEGMENT + line:DATA_SEGMENT + line + 16]
        print(f'DS:{line:04x}  {chunk.hex(" ")}')


# Images identifiées : (fichier, nom, position, largeur, hauteur, nombre). Les images d'une série se suivent.
# Les sprites du plateau (sols, murs, meubles, héros, monstres) sont extraits par extract-heroquest-graphics.py.
CATALOGUE = [
    ('BOOK', 'ecran-plateau', 0, 320, 200, 1),
    ('BORDERED', 'ecran-menus', 0, 320, 200, 1),
    ('WIZBACK', 'ecran-morcar', 0, 320, 200, 1),
    ('QUESTB', 'ecran-parchemin', 0, 320, 200, 1),
    ('MAPS', 'carte-parchemin', 0x0000, 256, 197, 1),
    ('MAPS', 'carte-tuile', 0xc500, 8, 8, 169),
    ('ODDS&SOD', 'portrait', 0x0000, 32, 45, 5),
    ('ODDS&SOD', 'objet32', 0x1c20, 32, 32, 6),
    ('ODDS&SOD', 'icone', 0x3420, 16, 16, 37),
    ('ODDS&SOD', 'icone-b', 0x55a0, 16, 16, 3),
    ('ODDS&SOD', 'mini', 0x58a0, 8, 8, 4),
    ('ODDS&SOD', 'icone-c', 0x5d20, 16, 16, 4),
    ('ODDS&SOD', 'cadre24', 0x6320, 24, 24, 1),
    ('SHOPMP', 'carte-element', 0x0000, 48, 64, 4),
    ('SHOPMP', 'menu', 0x3000, 48, 64, 4),
    ('SHOPMP', 'en-jeu', 0x7800, 48, 12, 1),
    ('SHOPMP', 'fleche', 0x7a40, 32, 16, 1),
    ('SHOPMP', 'logo', 0x7c40, 224, 68, 1),
    ('SHOPMP', 'bord', 0xb7c0, 16, 16, 8),
    ('SHOPSP', 'objet', 0x0000, 32, 32, 23),
    ('SHOPSP', 'cadre-objet', 0x5c00, 32, 32, 1),
    ('SHOPSP', 'portrait-gris', 0x8000, 48, 64, 4),       # héros non choisi
    ('SHOPSP', 'portrait', 0xb000, 48, 64, 4),
    ('INVENT', 'categorie', 0x0000, 64, 94, 3),
    ('INVENT', 'objet', 0x4680, 32, 32, 23),
    ('INVENT', 'case', 0xa280, 32, 32, 1),
    ('INVENT', 'crochet', 0xc680, 16, 20, 3),
    ('SPELLIT', 'objet', 0x0000, 32, 32, 12),
]


def cmd_catalogue(game_dir, target):
    from PIL import Image
    game_dir, target = Path(game_dir), Path(target)
    target.mkdir(parents=True, exist_ok=True)
    colours = palette(game_dir)
    files, count = {}, 0
    for file, name, offset, width, height, number in CATALOGUE:
        data = files.setdefault(file, graphics.vga_unpack((game_dir / f'{file}.VGA').read_bytes()))
        for index in range(number):
            start = offset + index * width * height
            image = Image.frombytes('P', (width, height), data[start:start + width * height])
            image.putpalette(colours)
            suffix = f'-{index:02d}' if number > 1 else ''
            image.save(target / f'{file.lower().replace("&", "")}-{name}{suffix}.png')
            count += 1
    print(f'{count} images écrites dans {target}')


COMMANDS = {'exe': cmd_exe, 'lz': cmd_lz, 'planche': cmd_planche, 'textes': cmd_textes,
            'desasm': cmd_desasm, 'cherche': cmd_cherche, 'ds': cmd_ds, 'catalogue': cmd_catalogue}

if __name__ == '__main__':
    if len(sys.argv) < 3 or sys.argv[1] not in COMMANDS:
        sys.exit(__doc__)
    COMMANDS[sys.argv[1]](*sys.argv[2:])
