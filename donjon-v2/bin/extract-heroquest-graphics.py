"""
Extrait les graphismes du HeroQuest PC de Gremlin (1991) pour la vue isométrique du plateau de donjon.

Écrit public/assets/game/iso/atlas.png (toutes les images sur une planche) et atlas.js (position de
chaque image sur la planche, IsoAtlas, et sol de chaque zone, IsoSols).

Usage : python bin/extract-heroquest-graphics.py "../_Version/HeroQuest (1991 Gremlin)"
Prérequis : Python 3.10+ et Pillow.

Formats (retrouvés en désassemblant QUEST.EXE) :
  - QUEST.EXE est compressé avec Microsoft EXEPACK ; une fois décompressé, son segment de données
    commence à 0x97c0 et contient la palette VGA (DS:0x5b23) et les tables des sprites.
  - Les fichiers .VGA sont compressés par une variante de LZ77 (routine 0x4548 de QUEST.EXE)
    et contiennent des images 8 bits les unes à la suite des autres, sans en-tête ; l'indice 0 est transparent.
"""

import json
import struct
import sys
from pathlib import Path

from PIL import Image

ROOT = Path(__file__).resolve().parent.parent
OUTPUT = ROOT / 'public' / 'assets' / 'game' / 'iso'
DATA_SEGMENT = 0x97c0

PALETTE = 0x5b23
FURNITURE_TABLE = 0x43fc       # 6 octets par meuble (codes 0x4b à 0x5f) : largeur, hauteur, dx, dy, position
SPRITE_TABLE = 0x4f80          # 4 octets par image de personnage : largeur, hauteur, position
ZONE_FLOORS = 0xa543           # position du sol de chaque zone (0 à 42) dans GRAPHICS.VGA
SPECIAL_FLOORS = 0x50d0        # position du sol des codes 0x30 à 0x3b (éboulis, escalier), 0xffff si aucun

FLOOR, WALL, DOOR = (48, 24), (24, 52), (24, 44)
WALLS = [0x7e00, 0x82e0, 0x87c0, 0x8ca0]
DOORS = [0x9180 + i * DOOR[0] * DOOR[1] for i in range(12)]

HEROES = {'barbare': 0x4fa8, 'nain': 0x4fd8, 'elfe': 0x5008, 'magicien': 0x5038, 'guerrier': 0x5068}
MONSTERS = {'gobelin': 0x5098, 'orc': 0x50a8, 'fimir': 0x50b8, 'chaos': 0x50c8, 'squelette': 0x50d8,
            'zombie': 0x50e8, 'momie': 0x50f8, 'gargouille': 0x5108}


def exepack_unpack(path):
    """Image mémoire d'un exécutable EXEPACK (sans en-tête MZ)."""
    data = path.read_bytes()
    header = struct.unpack('<14H', data[:28])
    image = data[header[4] * 16:]
    code_segment = header[11]
    fields = struct.unpack('<9H', image[code_segment * 16:code_segment * 16 + 18])
    dest_paragraphs, signature = fields[6], fields[8]
    if signature != 0x4252:
        raise ValueError(f'{path.name} : signature EXEPACK absente')
    packed = image[:code_segment * 16]
    out = bytearray(max(dest_paragraphs * 16, len(packed)))
    out[:len(packed)] = packed
    src = len(packed) - 1
    for _ in range(16):              # remplissage 0xff en fin de données
        if out[src] != 0xff:
            break
        src -= 1
    dst = dest_paragraphs * 16
    while True:                      # commandes lues de la fin vers le début
        command = out[src]
        length = out[src - 2] | out[src - 1] << 8
        src -= 3
        if command & 0xfe == 0xb0:
            fill = out[src]
            src -= 1
            out[dst - length:dst] = bytes([fill]) * length
            dst -= length
        elif command & 0xfe == 0xb2:
            for _ in range(length):
                dst -= 1
                out[dst] = out[src]
                src -= 1
        else:
            raise ValueError(f'commande EXEPACK inconnue 0x{command:02x}')
        if command & 1:
            return bytes(out[:dest_paragraphs * 16])


def vga_unpack(data):
    """Décompression des fichiers .VGA (routine 0x4548 de QUEST.EXE)."""
    out, i = bytearray(), 0
    while i < len(data):
        token = data[i]
        i += 1
        if token == 0:
            break
        if token < 0x40:                                  # octets recopiés tels quels
            count = token
            if token & 0x20:
                count = ((token & 0x1f) << 8 | data[i]) + 0x20
                i += 1
            out += data[i:i + count]
            i += count
        elif token < 0x80:                                # répétition d'un octet
            value = token & 0x3f
            if value & 0x20:
                count = ((value & 0x1f) << 8 | data[i]) + 0x24
                i += 1
            else:
                count = value + 3
            out += bytes([data[i]]) * count
            i += 1
        else:                                             # copie de données déjà écrites
            if token < 0xc0:
                extra = 2 if token & 0x20 else 1
                distance = token & 0x1f
            else:
                extra = ((token & 0x3f) >> 2) + 3
                distance = (token & 3) << 8 | data[i]
                i += 1
            start = len(out) - 1 - distance - extra
            for k in range(extra + 1):
                out.append(out[start + k])
    return bytes(out)


class Extractor:
    def __init__(self, source):
        self.source = source
        self.program = exepack_unpack(source / 'QUEST.EXE')
        palette = self.data(PALETTE, 768)
        self.palette = [v * 255 // 63 for v in palette]
        self.files = {}
        self.frames = []             # (nom, image, infos supplémentaires)

    def data(self, offset, length):
        return self.program[DATA_SEGMENT + offset:DATA_SEGMENT + offset + length]

    def word(self, offset):
        return struct.unpack('<H', self.data(offset, 2))[0]

    def vga(self, name):
        if name not in self.files:
            self.files[name] = vga_unpack((self.source / f'{name}.VGA').read_bytes())
        return self.files[name]

    def image(self, name, offset, size):
        width, height = size
        pixels = self.vga(name)[offset:offset + width * height]
        image = Image.frombytes('P', size, pixels)
        image.putpalette(self.palette)
        image.info['transparency'] = 0
        return image.convert('RGBA')

    def add(self, key, image, **extra):
        self.frames.append((key, image, extra))

    def extract(self):
        floors = {self.word(ZONE_FLOORS + 2 * zone) for zone in range(43)}
        specials = {}
        for code in range(0x30, 0x3c):
            offset = self.word(SPECIAL_FLOORS + 2 * code)
            if offset != 0xffff:
                specials[code] = offset
                floors.add(offset)
        for offset in sorted(floors):
            self.add(f'sol{offset:04x}', self.image('GRAPHICS', offset, FLOOR))
        for index, offset in enumerate(WALLS):
            self.add(f'mur{index}', self.image('GRAPHICS', offset, WALL))
        for index, offset in enumerate(DOORS):
            self.add(f'porte{index}', self.image('GRAPHICS', offset, DOOR))
        for code in range(0x4b, 0x60):
            if code in (0x51, 0x52):                       # entrées vides de la table
                continue
            width, height, dx, dy, offset = struct.unpack('<BBbbH', self.data(FURNITURE_TABLE + (code - 0x4b) * 6, 6))
            self.add(f'meuble{code:02x}', self.image('FURN', offset, (width, height)), dx=dx, dy=dy)
        for name, table in HEROES.items():
            for frame in range(12):
                self.add(f'{name}{frame}', self.sprite('SPRITES', table + 4 * frame))
        for name, table in MONSTERS.items():
            for frame in range(4):
                self.add(f'{name}{frame}', self.sprite('MONSTERS', table + 4 * frame))

        zone_floors = [f'sol{self.word(ZONE_FLOORS + 2 * zone):04x}' for zone in range(43)]
        special_floors = {f'{code}': f'sol{offset:04x}' for code, offset in specials.items()}
        return zone_floors, special_floors

    def sprite(self, file, record):
        width, height, offset = struct.unpack('<BBH', self.data(record, 4))
        return self.image(file, offset, (width, height))

    def write(self, zone_floors, special_floors):
        """Range les images en lignes sur une planche de 512 pixels de large."""
        sheet_width, x, y, row = 512, 0, 0, 0
        placed = {}
        for key, image, extra in self.frames:
            if x + image.width > sheet_width:
                x, y, row = 0, y + row + 1, 0
            placed[key] = [x, y, image.width, image.height] + ([extra['dx'], extra['dy']] if extra else [])
            x += image.width + 1
            row = max(row, image.height)
        sheet = Image.new('RGBA', (sheet_width, y + row), (0, 0, 0, 0))
        for key, image, _ in self.frames:
            sheet.paste(image, tuple(placed[key][:2]))
        OUTPUT.mkdir(parents=True, exist_ok=True)
        sheet.save(OUTPUT / 'atlas.png', optimize=True)
        script = [
            '// Graphismes du HeroQuest PC de Gremlin (1991), extraits par bin/extract-heroquest-graphics.py.',
            '// IsoAtlas : nom -> [x, y, largeur, hauteur(, dx, dy pour les meubles)] sur atlas.png.',
            f'var IsoAtlas = {json.dumps(placed, separators=(",", ":"))};',
            '// Sol de chaque zone des quêtes (MesZones) et des codes 0x30 à 0x3b (éboulis, escalier).',
            f'var IsoSols = {json.dumps(zone_floors, separators=(",", ":"))};',
            f'var IsoSolsSpeciaux = {json.dumps(special_floors, separators=(",", ":"))};',
        ]
        (OUTPUT / 'atlas.js').write_text('\n'.join(script) + '\n', encoding='utf-8')
        print(f'{len(self.frames)} images, planche {sheet.width} x {sheet.height}')


def main():
    if len(sys.argv) != 2:
        sys.exit(__doc__)
    extractor = Extractor(Path(sys.argv[1]))
    extractor.write(*extractor.extract())


if __name__ == '__main__':
    main()
