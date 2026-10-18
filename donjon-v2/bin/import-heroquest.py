"""
Convertit les 24 quêtes du HeroQuest PC de Gremlin (1991) en cartes du plateau de donjon.

Pour chaque fichier QUESTn.BIN, écrit public/assets/game/quests/quest{100+n}.js (pièces, portes,
murs, pièges, monstres) et quest{100+n}.jpg (image du plateau, dessinée avec bin/heroquest-tiles).

Usage : python bin/import-heroquest.py "../_Version/HeroQuest (1991 Gremlin)"
Prérequis : Python 3.10+ et Pillow (pip install pillow).

Format de QUESTn.BIN (octets, cases numérotées y * 26 + x sur 26 x 19) :
  0     494 octets : numéro de zone de chaque case (0 = hors quête, 1-20 couloirs, 21-42 pièces)
  512   494 octets : murs et portes de chaque case (0x80 mur en haut, 0x40 mur à gauche,
                     0x20 porte en haut, 0x10 porte à gauche ; les autres bits sont ignorés)
  1024  4 x 3 octets : départ des quatre héros (x, y, ?)
  1122  6 mots little-endian : position du texte, sa longueur, position des monstres,
                     taille des monstres, position du mobilier, nombre d'objets (positions depuis 1122)
  monstres : 10 octets par monstre (actif, x, y, 0, 0, 0, ?, classe, type, ?) ;
             le premier, inactif, est le monstre errant de la quête (ignoré)
  mobilier : 3 octets par objet (x, y, code), les cases supplémentaires d'un meuble suivent son code
  texte    : lignes de briefing en anglais, chacune précédée de 0x11, ligne, colonne
"""

import struct
import sys
from collections import deque
from pathlib import Path

from PIL import Image, ImageChops, ImageDraw

COLUMNS, ROWS = 26, 19
CELLS = COLUMNS * ROWS
QUEST_OFFSET = 100            # quête Gremlin n -> carte quest{100+n}
CELL = 28                     # pas d'une case sur l'image du plateau (voir #board dans game.css)
BOARD_SIZE = (731, 534)

ROOT = Path(__file__).resolve().parent.parent
TILES = Path(__file__).resolve().parent / 'heroquest-tiles'
OUTPUT = ROOT / 'public' / 'assets' / 'game' / 'quests'

# Monstres Gremlin (octet "type") -> numéro de TabMonstre dans MesItem.js.
MONSTERS = {
    0: 1,    # gobelin -> Lutin
    1: 2,    # orc
    2: 3,    # fimir
    3: 5,    # guerrier du chaos
    4: 15,   # squelette
    5: 16,   # zombie
    6: 17,   # momie
    7: 4,    # gargouille
    8: 6,    # Ulag, seigneur orc -> ChamanOrc
    9: 6,    # Grak, fils d'Ulag -> ChamanOrc
    10: 19,  # Balur, mage du feu -> Sorcier
    11: 18,  # le Sorcier-Roi -> MageSquellette
    12: 18,
    20: 18,  # cavaliers spectraux
    21: 18,
    22: 4,   # Bellthor, gardien de la porte -> Gargouille
    23: 18,  # Skulmar
    24: 5,   # garde du destin -> GuerrierChaos
    25: 19,
    26: 18,  # le Sorcier-Roi
}

# Codes du mobilier. Les pièges ont été identifiés en comparant leur nombre par quête avec les
# quêtes du remake HeroQuest en C# ; les meubles d'après leurs sprites dans FURN.VGA
# (voir bin/extract-heroquest-graphics.py), chaque meuble ayant un code par orientation.
BLOCKED = 0x30                       # case bloquée (éboulis)
TRAPS = {0x32, 0x34, 0x36}           # fosse, chute de pierre, lance (invisibles sur la carte)
MAGIC_DOOR = 0x37                    # portail magique de la quête 10 : non géré
STAIRS = {0x38, 0x39, 0x3a, 0x3b}    # escalier 2 x 2 (départ ou sortie)
FILLERS = set(range(0x42, 0x4b))     # cases supplémentaires du meuble qui précède
FURNITURE = {
    0x4b: 'table', 0x4c: 'table', 0x4d: 'chevalet', 0x4e: 'chevalet',
    0x4f: 'etabli-alchimiste', 0x50: 'etabli-alchimiste', 0x53: 'tombeau',
    0x54: 'armoire', 0x5a: 'armoire', 0x55: 'ratelier-armes', 0x5b: 'ratelier-armes',
    0x56: 'armoire', 0x58: 'armoire', 0x57: 'cheminee', 0x59: 'cheminee',          # 0x56 : bibliothèque
    0x5c: 'coffre', 0x5d: 'coffre2', 0x5e: 'trone', 0x5f: 'trone',
}

# Quêtes à gagner en atteignant l'escalier ; les autres se gagnent en tuant tous les monstres.
ESCAPE_QUESTS = {1, 6, 9}

# Quêtes non converties : leurs passages dépendent de scripts du jeu absents de QUESTn.BIN.
SKIPPED_QUESTS = {
    5: 'la salle de départ ne s\'ouvre que par un passage secret scripté',
    10: 'les pièces ne sont reliées que par des portails magiques',
}

CORRIDOR_FLOOR = 'FLR08'
ROOM_FLOORS = ['FLR11', 'FLR15', 'FLR03', 'FLR20', 'FLR12', 'FLR23', 'FLR17', 'FLR10', 'FLR14', 'FLR22',
               'FLR13', 'FLR24', 'FLR21', 'FLR18', 'FLR04', 'FLR19']

# Murs du plateau JavaScript (MesMurs) : un bit par côté fermé, 16 pour une case occupée par un meuble.
UP, RIGHT, DOWN, LEFT, OCCUPIED = 1, 2, 4, 8, 16
DIRECTIONS = {UP: -COLUMNS, RIGHT: 1, DOWN: COLUMNS, LEFT: -1}
OPPOSITE = {UP: DOWN, DOWN: UP, LEFT: RIGHT, RIGHT: LEFT}

OPEN, WALL, DOOR = 'open', 'wall', 'door'


def neighbour(cell, direction):
    x, y = cell % COLUMNS, cell // COLUMNS
    if (direction == LEFT and x == 0) or (direction == RIGHT and x == COLUMNS - 1) \
            or (direction == UP and y == 0) or (direction == DOWN and y == ROWS - 1):
        return None
    return cell + DIRECTIONS[direction]


class Quest:
    def __init__(self, number, data):
        self.number = number
        self.zones = data[:CELLS]
        self.walls = data[512:512 + CELLS]
        self.starts = [data[1024 + 3 * i] + COLUMNS * data[1025 + 3 * i] for i in range(4)]
        text_at, text_length, monsters_at, monsters_size, furniture_at, furniture_count = \
            struct.unpack('<6H', data[1122:1134])
        self.title = self._briefing(data[1122 + text_at:1122 + text_at + text_length + 1])[0]
        self.monsters = []
        for i in range(monsters_at, monsters_at + monsters_size, 10):
            record = data[1122 + i:1122 + i + 10]
            if record[0]:
                self.monsters.append((record[1] + COLUMNS * record[2], record[8]))
        self.furniture = []
        for i in range(furniture_at, furniture_at + 3 * furniture_count, 3):
            x, y, code = data[1122 + i:1122 + i + 3]
            self.furniture.append((x + COLUMNS * y, code))

    @staticmethod
    def _briefing(text):
        return [line[2:].decode('latin-1').replace('_', ' ').strip() for line in text.split(b'\x11')[1:]]

    def used(self, cell):
        return cell is not None and self.zones[cell] != 0

    def edge(self, cell, direction):
        """État du côté `direction` de la case : ouvert, mur ou porte."""
        other = neighbour(cell, direction)
        if not self.used(cell) or not self.used(other):
            return WALL
        if direction in (UP, LEFT):
            flags = self.walls[cell]
        else:
            flags, direction = self.walls[other], OPPOSITE[direction]
        door, wall = (0x20, 0x80) if direction == UP else (0x10, 0x40)
        if flags & door:
            return DOOR
        return WALL if flags & wall else OPEN


def build_board(quest):
    """Découpe le plateau en pièces (cases reliées sans mur ni porte) et place portes, murs et objets."""
    region = [None] * CELLS
    regions = []
    for start in range(CELLS):
        if not quest.used(start) or region[start] is not None:
            continue
        label = region_label(len(regions))
        cells, queue = [], deque([start])
        region[start] = label
        while queue:
            cell = queue.popleft()
            cells.append(cell)
            for direction in DIRECTIONS:
                other = neighbour(cell, direction)
                if quest.edge(cell, direction) == OPEN and region[other] is None:
                    region[other] = label
                    queue.append(other)
        corridor = any(quest.zones[c] <= 20 for c in cells)
        regions.append({'label': label, 'cells': cells, 'corridor': corridor, 'zone': quest.zones[cells[0]]})

    doors, door_to = [], ['0'] * CELLS
    walls = [0] * CELLS
    for cell in range(CELLS):
        for direction in DIRECTIONS:
            state = quest.edge(cell, direction)
            if state == WALL:
                walls[cell] |= direction
            elif state == DOOR:
                other = neighbour(cell, direction)
                if door_to[cell] == '0':
                    door_to[cell] = region[other]
                if direction in (RIGHT, DOWN):
                    doors.append((cell, direction))

    traps, stairs, pieces, objects = ['0'] * CELLS, [], [], []
    current = None
    for cell, code in quest.furniture:
        if code in FILLERS and current:
            current['cells'].append(cell)
            continue
        current = None
        if code in TRAPS:
            traps[cell] = 'X'
        elif code in STAIRS:
            stairs.append(cell)
            objects.append({'code': code, 'cells': [cell]})
        elif code == BLOCKED:
            pieces.append({'name': 'eboulis', 'code': code, 'cells': [cell]})
        elif code in FURNITURE:
            current = {'name': FURNITURE[code], 'code': code, 'cells': [cell]}
            pieces.append(current)
        elif code != MAGIC_DOOR:
            print(f'  quête {quest.number} : objet inconnu 0x{code:02x} en {cell}', file=sys.stderr)
    for piece in pieces:
        for cell in piece['cells']:
            walls[cell] |= OCCUPIED

    return {
        'region': region, 'regions': regions, 'doors': doors, 'door_to': door_to,
        'walls': walls, 'traps': traps, 'stairs': sorted(stairs), 'pieces': pieces,
        'objects': objects + [{'code': p['code'], 'cells': p['cells']} for p in pieces],
    }


def region_label(index):
    letters = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz'
    return letters[index] if index < len(letters) else f'P{index}'


def reachable_regions(quest, board, start):
    """Pièces que le héros peut atteindre depuis la case de départ (règles de ModulePersonnage.js)."""
    seen, queue = {start}, deque([start])
    while queue:
        cell = queue.popleft()
        for direction in DIRECTIONS:
            other = neighbour(cell, direction)
            if other is None or other in seen or board['walls'][cell] & direction or board['walls'][other] & OCCUPIED:
                continue
            if board['region'][other] == board['region'][cell] or board['door_to'][other] != '0':
                seen.add(other)
                queue.append(other)
    return {board['region'][c] for c in seen}


def js_array(values, quote=True):
    items = [f"'{v}'" if quote else str(v) for v in values]
    rows = [','.join(items[i:i + COLUMNS]) for i in range(0, len(items), COLUMNS)]
    return '[\n' + ',\n'.join(rows) + '\n]'


def write_script(quest, board, path):
    start = quest.starts[0]
    region = board['region']
    escape = quest.number in ESCAPE_QUESTS and bool(board['stairs']) and start not in board['stairs']
    monsters = [(MONSTERS.get(kind, 2), cell, region[cell]) for cell, kind in quest.monsters if region[cell]]
    lines = [
        f'// {quest.title.title()} : quête {quest.number} du HeroQuest PC de Gremlin (1991).',
        '// Fichier généré par bin/import-heroquest.py, ne pas modifier à la main.',
        '',
        f"var PieceDepart = '{region[start]}';",
        f'var PositionDepart = {start};',
        "var PieceFouiller = ['Null'];",
        f"var PieceActiver = ['{region[start]}'];",
        '',
        '/* Murs de chaque case : 1 haut, 2 droite, 4 bas, 8 gauche, 16 case occupée par un meuble. */',
        f'var MesMurs = {js_array(board["walls"], quote=False)};',
        '',
        f'var MesPieges = {js_array(board["traps"])};',
        '',
        f"var MesPieces = {js_array([r or '0' for r in region])};",
        '',
        '/* Case devant une porte : pièce de l\'autre côté (MesPortes) et pièce de la case (MesPortesPieceActive). */',
        f'var MesPortes = {js_array(board["door_to"])};',
        '',
        "var MesPortesPieceActive = " + js_array([region[c] if board['door_to'][c] != '0' else '0' for c in range(CELLS)]) + ';',
        '',
        '/* Vue isométrique (ModuleIso.js) : zone HeroQuest de chaque case (donne le sol),',
        '   puis objets [code HeroQuest, cases occupées...] (éboulis, escalier, meubles). */',
        f'var MesZones = {js_array(quest.zones, quote=False)};',
        'var MesObjets = [' + ','.join('[' + ','.join(str(v) for v in [o['code']] + o['cells']) + ']'
                                      for o in board['objects']) + '];',
        '',
        'var LesMonstres = [',
        ',\n'.join(f"\tTabMonstre({kind}, {cell}, '{room}')" for kind, cell, room in monsters),
        '];',
        f'var NbMonstre = {len(monsters)};',
        '',
    ]
    if escape:
        lines += [
            f"var CasesSortie = [{', '.join(str(c) for c in board['stairs'])}];",
            '',
            'function Victoire(){',
            '\treturn CasesSortie.indexOf(Number(LesJoueurs[ConstIdJoueur][5])) != -1;',
            '}',
        ]
    else:
        lines += [
            'function Victoire(){',
            '\tfor (var i=0;i<LesMonstres.length;i++){',
            '\t\tif (LesMonstres[i][8]!=-1){ return false; }',
            '\t}',
            '\treturn true;',
            '}',
        ]
    path.write_text('\n'.join(lines) + '\n', encoding='utf-8')
    return escape, monsters


def tile(name, size):
    """Tuile redimensionnée, le magenta des images du remake devenant transparent."""
    image = Image.open(TILES / f'{name}.png').convert('RGB')
    magenta = Image.new('RGB', image.size, (255, 0, 255))
    alpha = ImageChops.difference(image, magenta).convert('L').point(lambda v: 255 if v else 0)
    image.putalpha(alpha)
    return image.resize(size, Image.LANCZOS)


def cell_origin(cell):
    return 1 + CELL * (cell % COLUMNS), 1 + CELL * (cell // COLUMNS)


def draw_board(quest, board, path):
    image = Image.new('RGB', BOARD_SIZE, 'black')
    draw = ImageDraw.Draw(image)
    floors = {}
    for info in board['regions']:
        name = CORRIDOR_FLOOR if info['corridor'] else ROOM_FLOORS[(info['zone'] - 21) % len(ROOM_FLOORS)]
        floor = floors.setdefault(name, tile(name, (CELL - 2, CELL - 2)))
        for cell in info['cells']:
            x, y = cell_origin(cell)
            draw.rectangle([x, y, x + CELL - 1, y + CELL - 1], fill=(40, 36, 32))
            image.paste(floor, (x + 1, y + 1), floor)

    for cell in range(CELLS):
        if not quest.used(cell):
            continue
        x, y = cell_origin(cell)
        for direction in DIRECTIONS:
            if quest.edge(cell, direction) != WALL:
                continue
            if direction == UP:
                draw.rectangle([x - 1, y - 1, x + CELL, y], fill=(230, 226, 214))
            elif direction == DOWN:
                draw.rectangle([x - 1, y + CELL - 1, x + CELL, y + CELL], fill=(230, 226, 214))
            elif direction == LEFT:
                draw.rectangle([x - 1, y - 1, x, y + CELL], fill=(230, 226, 214))
            else:
                draw.rectangle([x + CELL - 1, y - 1, x + CELL, y + CELL], fill=(230, 226, 214))

    if board['stairs']:
        first = board['stairs'][0]
        x, y = cell_origin(first)
        stairs = tile('escalier', (2 * CELL - 2, 2 * CELL - 2))
        image.paste(stairs, (x + 1, y + 1), stairs)

    for piece in board['pieces']:
        xs = [c % COLUMNS for c in piece['cells']]
        ys = [c // COLUMNS for c in piece['cells']]
        width, height = max(xs) - min(xs) + 1, max(ys) - min(ys) + 1
        x, y = cell_origin(min(ys) * COLUMNS + min(xs))
        size = (width * CELL - 4, height * CELL - 4)
        sprite = Image.open(TILES / f"{piece['name']}.png")
        if (height > width) != (sprite.height > sprite.width):
            sprite = tile(piece['name'], (size[1], size[0])).rotate(90, expand=True)
        else:
            sprite = tile(piece['name'], size)
        image.paste(sprite, (x + 2, y + 2), sprite)

    for cell, direction in board['doors']:
        x, y = cell_origin(cell)
        if direction == RIGHT:
            draw.rectangle([x + CELL - 2, y + 5, x + CELL + 1, y + CELL - 6], fill=(205, 30, 30))
        else:
            draw.rectangle([x + 5, y + CELL - 2, x + CELL - 6, y + CELL + 1], fill=(205, 30, 30))

    image.save(path, quality=90)


def main():
    if len(sys.argv) != 2:
        sys.exit(__doc__)
    source = Path(sys.argv[1])
    for number in range(1, 25):
        if number in SKIPPED_QUESTS:
            print(f'quête {number} ignorée : {SKIPPED_QUESTS[number]}')
            continue
        quest = Quest(number, (source / f'QUEST{number}.BIN').read_bytes())
        board = build_board(quest)
        code = QUEST_OFFSET + number
        escape, monsters = write_script(quest, board, OUTPUT / f'quest{code}.js')
        draw_board(quest, board, OUTPUT / f'quest{code}.jpg')

        reachable = reachable_regions(quest, board, quest.starts[0])
        lost = [m for m in monsters if m[2] not in reachable]
        goal = 'escalier' if escape else 'monstres'
        print(f'quest{code}.js  {quest.title:<35} {len(board["regions"]):>2} pièces  {len(monsters):>2} monstres  '
              f'victoire : {goal}' + (f'  ATTENTION : {len(lost)} monstre(s) hors d\'atteinte' if lost else ''))


if __name__ == '__main__':
    main()
