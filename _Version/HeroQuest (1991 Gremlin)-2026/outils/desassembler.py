"""
Désassemble un exécutable du HeroQuest PC (Gremlin, 1991) en suivant le flot d'exécution.

Usage (depuis ce dossier outils/) :
  python desassembler.py QUEST     -> ../original/asm/quest.asm, quest-donnees.txt, quest-rapport.txt
  python desassembler.py INTRO

Méthode : l'exécutable est décompressé (EXEPACK), puis le code est parcouru depuis le point d'entrée
en suivant appels, sauts et tables de saut reconnues. Les zones non atteintes sont listées dans le rapport.
Les noms viennent de ../original/symboles.txt. Prérequis : capstone (pip install capstone).
"""

import importlib.util
import re
import struct
import sys
from collections import defaultdict
from pathlib import Path

from capstone import CS_ARCH_X86, CS_MODE_16, Cs

ICI = Path(__file__).resolve().parent
RACINE = ICI.parent
JEU = RACINE.parent / 'HeroQuest (1991 Gremlin)'
SORTIE = RACINE / 'original' / 'asm'

# Décompresseurs partagés avec donjon-v2 (une seule implémentation).
_spec = importlib.util.spec_from_file_location(
    'graphismes', RACINE.parent.parent / 'donjon-v2' / 'bin' / 'extract-heroquest-graphics.py')
graphismes = importlib.util.module_from_spec(_spec)
_spec.loader.exec_module(graphismes)

PROGRAMMES = {
    # entree : point d'entrée ; code : zone de code (None = jusqu'à la fin) ; base : début du segment de code
    # (adresse image = base + IP, sert à lire les tables de saut) ; ds : début du segment de données.
    # Toutes les adresses sont des positions dans l'image décompressée.
    'QUEST': {'entree': 0x00ED, 'code': (0x0000, 0x97C0), 'base': 0x0000, 'ds': 0x97C0},
    'INTRO': {'entree': 0x44B0, 'code': (0x44B0, None), 'base': 0x44B0, 'ds': 0x0000},
}

# Tables de saut de taille connue : offset DS -> (nombre d'entrées, pas). Sans cela, la lecture continue
# au-delà de la table ou suit un pas de 2, et les fausses cibles cassent le décodage.
TABLES_ESPACEES = {
    'QUEST': {
        0x4809: (27, 5),            # types_monstres + 3 : routine de mort de chaque type (lea bx, [bx + 0x4809])
        0x44a9: (15, 2),            # fins_quetes : une routine par quête du code 0 à 14
        0x4657: (6, 2),             # circuit_brume
        0xaa1a: (4, 2),             # saut_menu_titre : zones 2, 4, 6 (l'entrée 0 est vide)
    },
}

AFFICHE_MESSAGE = 0x88ED            # routine de QUEST.EXE qui affiche le message BX (voir original/notes/02-ecrans.md)
MESSAGES = RACINE / 'original' / 'donnees' / 'textes' / 'french.bin'

FINS = {'ret', 'retf', 'iret', 'jmp', 'ljmp'}


def charger_messages():
    """Texte des messages (BX -> lignes jointes), d'après le fichier de textes décompressé par extraire.py."""
    if not MESSAGES.exists():
        return {}
    spec = importlib.util.spec_from_file_location('extraire', ICI / 'extraire.py')
    extraire = importlib.util.module_from_spec(spec)
    spec.loader.exec_module(extraire)
    messages = {}
    for numero, entree in extraire.table_messages(MESSAGES.read_bytes()):
        m = extraire.decoder_message(entree)
        if m and m['lignes']:
            messages[numero] = ' / '.join(t.strip() for _, _, t in m['lignes'] if t.strip())
    return messages
SAUTS = re.compile(r'^(j\w+|loop\w*|jcxz)$')


def charger_symboles(fichier):
    symboles = {'code': {}, 'var': {}, 'table': {}, 'commentaire': {}, 'routines': set()}
    if not fichier.exists():
        return symboles
    for ligne in fichier.read_text(encoding='utf-8').splitlines():
        if not ligne.strip() or ligne.startswith('#'):
            continue
        parties = ligne.split(None, 3)
        adresse, genre, nom = int(parties[0], 16), parties[1], parties[2]
        commentaire = parties[3] if len(parties) > 3 else ''
        cle = 'code' if genre in ('code', 'etiq') else genre
        symboles[cle][adresse] = nom
        if genre == 'code':                      # début de routine, même si elle n'est jamais appelée (vecteur d'interruption)
            symboles['routines'].add(adresse)
        if commentaire:
            symboles['commentaire'][(cle, adresse)] = commentaire
    return symboles


class Desassembleur:
    def __init__(self, image, entree, ds, symboles, code, base, espacees):
        self.image, self.entree, self.ds, self.sym = image, entree, ds, symboles
        self.espacees = espacees
        self.debut_code, self.fin_code = code
        self.base = base
        self.md = Cs(CS_ARCH_X86, CS_MODE_16)
        self.instructions = {}                           # adresse -> instruction
        self.routines = {entree} | symboles['routines']
        self.etiquettes = set()
        self.appelants = defaultdict(set)
        self.indirects = []                              # sauts et appels indirects non résolus
        self.tables = {}                                 # adresse DS -> liste de cibles
        self.probables = set()                           # routines trouvées par la passe des zones non atteintes
        self.ecritures = self.ecritures_constantes()     # adresse DS -> valeurs écrites par mov word ptr [X], valeur
        self.messages = charger_messages() if base == 0 else {}

    def ecritures_constantes(self):
        """Balayage linéaire de tout le code : `mov word ptr [X], valeur` (pointeurs de routine posés à l'exécution)."""
        ecritures = defaultdict(set)
        for m in re.finditer(rb'\xc7\x06(..)(..)', self.image[self.debut_code:self.fin_code], re.S):
            cible, valeur = struct.unpack('<H', m.group(1))[0], struct.unpack('<H', m.group(2))[0]
            ecritures[cible].add(self.base + valeur)
        return ecritures

    def dans_segment(self, adresse):
        """Un saut relatif reste dans le segment de code : IP est sur 16 bits."""
        return self.base + ((adresse - self.base) & 0xFFFF)

    def mot_ds(self, offset):
        a = self.ds + offset
        return struct.unpack('<H', self.image[a:a + 2])[0] if a + 2 <= len(self.image) else None

    def plausible(self, adresse):
        """Dans la zone de code ; les 16 premiers octets ne sont acceptés que s'ils sont nommés (cibles douteuses)."""
        return max(0x10, self.debut_code) <= adresse < self.fin_code or (
            self.debut_code <= adresse < self.fin_code and adresse in self.sym['code'])

    def parcourir(self):
        a_voir = [self.entree] + sorted(a for a in self.sym['code'] if self.plausible(a))
        while a_voir:
            adresse = a_voir.pop()
            precedentes = []
            while self.debut_code <= adresse < self.fin_code and adresse not in self.instructions:
                code = self.image[adresse:adresse + 8]
                instr = next(self.md.disasm(code, adresse), None)
                if instr is None:
                    break
                self.instructions[adresse] = instr
                precedentes = (precedentes + [instr])[-4:]
                m, op = instr.mnemonic, instr.op_str
                cible = self.dans_segment(int(op, 16)) if re.fullmatch(r'0x[0-9a-f]+', op) else None
                if m == 'call' and cible is not None:
                    self.routines.add(cible)
                    self.appelants[cible].add(adresse)
                    a_voir.append(cible)
                elif (SAUTS.match(m) or m == 'jmp') and cible is not None:
                    self.etiquettes.add(cible)
                    a_voir.append(cible)
                elif m in ('jmp', 'call') and cible is None:
                    a_voir.extend(self.table_de_saut(instr, precedentes))
                if m in FINS:
                    break
                adresse += instr.size

    def table_de_saut(self, instr, precedentes):
        """Reconnaît les sauts indirects du jeu et renvoie leurs cibles."""
        op, cibles = instr.op_str, []
        avant = ' ; '.join(f'{i.mnemonic} {i.op_str}' for i in precedentes[:-1])
        m = re.search(r'mov bx, (0x[0-9a-f]+)(?: ; add bx, word ptr \[(0x[0-9a-f]+)\])?$', avant)
        if op == 'word ptr [bx]' and m:
            table = int(m.group(1), 16)
            if m.group(2):
                # mov bx, TABLE ; add bx, [0x3190] ; jmp [bx] : une routine par mode vidéo (index 0, 2, 4, 6, 8)
                cibles = self.lire_table(table, 5, 2, toutes=True)
            else:
                # mov bx, VARIABLE ; jmp [bx] : pointeur de routine posé à l'exécution
                cibles = self.lire_table(table, 1, 2) + sorted(v for v in self.ecritures[table] if self.plausible(v))
        # lea bx, [bx + TABLE] ; jmp [bx]
        m4 = re.search(r'lea bx, \[bx \+ (0x[0-9a-f]+)\]$', avant)
        if op == 'word ptr [bx]' and m4:
            cibles = self.lire_table(int(m4.group(1), 16), 64, 2)
        # jmp/call word ptr [bx + TABLE] ou [bx - X] (index déjà multiplié par 2)
        m2 = re.fullmatch(r'word ptr \[(?:bx|si|di) ([+-]) (0x[0-9a-f]+)\]', op)
        if m2:
            table = int(m2.group(2), 16) if m2.group(1) == '+' else 0x10000 - int(m2.group(2), 16)
            cibles = self.lire_table(table, 64, 2)
        m3 = re.fullmatch(r'word ptr \[(0x[0-9a-f]+)\]', op)
        if m3:
            variable = int(m3.group(1), 16)
            cibles = self.lire_table(variable, 1, 2) + sorted(v for v in self.ecritures[variable] if self.plausible(v))
        cibles = sorted(set(cibles))
        if not cibles:
            self.indirects.append(instr.address)
        for c in cibles:
            (self.routines if instr.mnemonic == 'call' else self.etiquettes).add(c)
            self.appelants[c].add(instr.address)
        return cibles

    def lire_table(self, table, nombre, pas, toutes=False):
        """Entrées plausibles d'une table ; sans `toutes`, la lecture s'arrête à la première entrée invalide."""
        if table in self.espacees:
            (nombre, pas), toutes = self.espacees[table], True
        cibles = []
        for i in range(nombre):
            v = self.mot_ds(table + i * pas)
            v = None if not v else self.base + v          # les tables contiennent des IP ; 0 = entrée vide
            if v is None or not self.plausible(v):
                if toutes:
                    continue
                break
            cibles.append(v)
        if cibles:
            self.tables[table] = cibles
        return cibles

    def zones_non_atteintes(self):
        """Seconde passe : une zone non atteinte qui suit un ret ou un jmp et se décode jusqu'à un ret
        sans retomber au milieu d'une instruction connue est ajoutée comme routine probable."""
        ajoutees = True
        while ajoutees:
            ajoutees = False
            adresses = sorted(self.instructions)
            for avant, apres in zip(adresses, adresses[1:]):
                debut = avant + self.instructions[avant].size
                if apres - debut < 4 or self.instructions[avant].mnemonic not in FINS:
                    continue
                while debut < apres and self.image[debut] in (0x90, 0x00):   # bourrage
                    debut += 1
                if self.decodable(debut, apres):
                    self.probables.add(debut)
                    self.routines.add(debut)
                    self.parcourir_depuis(debut)
                    ajoutees = True

    def decodable(self, debut, fin):
        adresse = debut
        for instr in self.md.disasm(self.image[debut:fin + 8], debut):
            if instr.address != adresse or instr.mnemonic in ('db', 'hlt', 'in', 'out', 'int3', 'into', 'bound', 'arpl'):
                return False
            if instr.mnemonic in FINS:
                return instr.address + instr.size <= fin or (instr.address + instr.size) in self.instructions
            adresse += instr.size
            if adresse >= fin:
                return adresse == fin
        return False

    def parcourir_depuis(self, adresse):
        sauvegarde = self.entree
        self.entree = adresse
        symboles = self.sym['code']
        self.sym['code'] = {}
        self.parcourir()
        self.sym['code'] = symboles
        self.entree = sauvegarde

    # ---- sortie ----

    def nom(self, adresse):
        if adresse in self.sym['code']:
            return self.sym['code'][adresse]
        if adresse in self.routines:
            return f'sub_{adresse:04x}'
        return f'loc_{adresse:04x}'

    def annoter(self, instr):
        texte = f'{instr.mnemonic} {instr.op_str}'.strip()
        op = instr.op_str
        if re.fullmatch(r'0x[0-9a-f]+', op) and (instr.mnemonic == 'call' or SAUTS.match(instr.mnemonic) or instr.mnemonic == 'jmp'):
            texte = f'{instr.mnemonic} {self.nom(self.dans_segment(int(op, 16)))}'
        notes = []
        # mov bx, MESSAGE ; call affiche_message : texte du message (version française)
        m = re.fullmatch(r'bx, (0x[0-9a-f]+|\d+)', op) if instr.mnemonic == 'mov' else None
        suivante = self.instructions.get(instr.address + instr.size)
        if m and suivante and suivante.mnemonic == 'call' and suivante.op_str == f'{AFFICHE_MESSAGE:#x}':
            message = self.messages.get(int(m.group(1), 0))
            if message:
                notes.append(f'message « {message} »')
        for valeur in re.findall(r'\[(?:[a-z]+ \+ )?(0x[0-9a-f]+)\]', op):
            v = int(valeur, 16)
            for genre in ('var', 'table'):
                if v in self.sym[genre]:
                    notes.append(self.sym[genre][v])
        for valeur in re.findall(r', (0x[0-9a-f]{3,4})$', op):
            v = int(valeur, 16)
            chaine = self.chaine_ds(v)
            if chaine:
                notes.append(f'"{chaine}"')
            elif v in self.sym['table']:
                notes.append(self.sym['table'][v])
        return texte + (f'    ; {", ".join(notes)}' if notes else '')

    def chaine_ds(self, offset):
        a = self.ds + offset
        if not (self.ds <= a < len(self.image)):
            return None
        fin = self.image.find(b'\0', a, a + 64)
        brut = self.image[a:fin] if fin > a else b''
        if len(brut) >= 4 and all(32 <= c < 127 for c in brut):
            return brut.decode('ascii')
        return None

    def ecrire(self, prefixe):
        SORTIE.mkdir(parents=True, exist_ok=True)
        lignes = [f'; {prefixe}.EXE décompressé, désassemblé par outils/desassembler.py. Ne pas modifier : '
                  f'enrichir original/symboles.txt puis relancer.', '']
        adresses = sorted(self.instructions)
        precedente_fin = None
        for adresse in adresses:
            instr = self.instructions[adresse]
            if precedente_fin is not None and adresse != precedente_fin:
                lignes.append(f'; ---- {adresse - precedente_fin} octets non atteints ({precedente_fin:04x}-{adresse - 1:04x})')
            if adresse in self.routines:
                appel = ', '.join(f'{a:04x}' for a in sorted(self.appelants[adresse])[:8])
                probable = '   (routine probable : non appelée directement)' if adresse in self.probables and not appel else ''
                lignes += ['', f'; ======== {self.nom(adresse)}' + (f'   (appelée depuis {appel})' if appel else '') + probable]
                commentaire = self.sym['commentaire'].get(('code', adresse))
                if commentaire:
                    lignes.append(f'; {commentaire}')
            elif adresse in self.etiquettes or adresse in self.sym['code']:
                commentaire = self.sym['commentaire'].get(('code', adresse))
                lignes.append(f'{self.nom(adresse)}:' + (f'    ; {commentaire}' if commentaire else ''))
            lignes.append(f'{adresse:05x}  {instr.bytes.hex(" "):<20} {self.annoter(instr)}')
            precedente_fin = adresse + instr.size
        (SORTIE / f'{prefixe.lower()}.asm').write_text('\n'.join(lignes) + '\n', encoding='utf-8')

        couvert = sum(i.size for i in self.instructions.values())
        rapport = [
            f'{prefixe}.EXE : image de {len(self.image)} octets, code de 0x{self.debut_code:04x} à 0x{self.fin_code:04x}, '
            f'segment de données à 0x{self.ds:04x}.',
            f'Instructions atteintes : {len(self.instructions)} ({couvert} octets, '
            f'{100 * couvert / (self.fin_code - self.debut_code):.1f} % de la zone de code).',
            f'Routines : {len(self.routines)} (dont {len(self.probables)} probables), étiquettes : {len(self.etiquettes)}, tables de saut lues : {len(self.tables)}.',
            f'Sauts ou appels indirects non résolus : {len(self.indirects)}',
            '  ' + ' '.join(f'{a:04x}' for a in self.indirects),
            '', 'Zones de code non atteintes (plus de 16 octets) :',
        ]
        precedente_fin = self.debut_code
        for adresse in adresses + [self.fin_code]:
            if adresse - precedente_fin > 16:
                rapport.append(f'  {precedente_fin:05x}-{adresse - 1:05x}  {adresse - precedente_fin} octets')
            if adresse in self.instructions:
                precedente_fin = max(precedente_fin, adresse + self.instructions[adresse].size)
        (SORTIE / f'{prefixe.lower()}-rapport.txt').write_text('\n'.join(rapport) + '\n', encoding='utf-8')
        print('\n'.join(rapport[:4]))

    def ecrire_routines(self, prefixe):
        """Une ligne par routine : taille, appelants, interruptions, ports, variables et chaînes. Sert à classer
        les routines par sous-système avant de les lire. Une instruction appartient à la routine qui la précède."""
        departs = sorted(self.routines & set(self.instructions))
        par_routine = defaultdict(list)
        for adresse in sorted(self.instructions):
            i = max(0, next((k for k, d in enumerate(departs) if d > adresse), len(departs)) - 1)
            if departs and departs[i] <= adresse:
                par_routine[departs[i]].append(self.instructions[adresse])
        nommees = sum(1 for d in departs if d in self.sym['code'])
        lignes = [f'; Routines de {prefixe}.EXE : {len(departs)}, dont {nommees} nommées dans symboles.txt.',
                  '; adresse  nom  taille  appelants  | int  ports  variables  chaînes', '']
        for depart in departs:
            corps = par_routine[depart]
            ints = sorted({f'{i.op_str[2:]}h' + (f'/{self.ah_avant(corps, k)}' if i.op_str in ('0x21', '0x10', '0x33') else '')
                           for k, i in enumerate(corps) if i.mnemonic == 'int'})
            ports = sorted({i.op_str.split(', ')[0 if i.mnemonic == 'out' else 1] for i in corps if i.mnemonic in ('in', 'out')})
            variables = sorted({self.sym['var'].get(v, f'{v:04x}') for i in corps
                                for v in (int(x, 16) for x in re.findall(r'\[(0x[0-9a-f]{3,4})\]', i.op_str))})
            chaines = sorted({c for i in corps for v in re.findall(r', (0x[0-9a-f]{3,4})$', i.op_str)
                              if (c := self.chaine_ds(int(v, 16)))})
            taille = sum(i.size for i in corps)
            lignes.append(f'{depart:05x}  {self.nom(depart):<24} {taille:5}  {len(self.appelants[depart]):3}  | '
                          f'{" ".join(ints)}  {" ".join(ports)}  {" ".join(variables[:12])}'
                          + (f'  "{chaines[0]}"' if chaines else ''))
        (SORTIE / f'{prefixe.lower()}-routines.txt').write_text('\n'.join(lignes) + '\n', encoding='utf-8')

    @staticmethod
    def ah_avant(corps, k):
        """Valeur de AH posée juste avant une interruption (fonction appelée), si elle est visible."""
        for i in reversed(corps[max(0, k - 6):k]):
            m = re.fullmatch(r'(ah|ax), (0x[0-9a-f]+|\d+)', i.op_str) if i.mnemonic == 'mov' else None
            if m:
                v = int(m.group(2), 0)
                return f'{(v >> 8 if m.group(1) == "ax" else v):02x}'
        return '?'

    def ecrire_donnees(self, prefixe):
        """Segment de données en hexadécimal, avec chaînes et symboles."""
        lignes = [f'; Segment de données de {prefixe}.EXE (DS:0000 = image 0x{self.ds:04x}).', '']
        noms = {**{a: n for a, n in self.sym['var'].items()}, **self.sym['table']}
        fin = self.debut_code if self.ds < self.debut_code else len(self.image)
        donnees = self.image[self.ds:fin]
        for offset in range(0, len(donnees), 16):
            bloc = donnees[offset:offset + 16]
            for a in range(offset, offset + 16):
                if a in noms:
                    lignes.append(f'; DS:{a:04x}  {noms[a]}')
            texte = ''.join(chr(c) if 32 <= c < 127 else '.' for c in bloc)
            lignes.append(f'DS:{offset:04x}  {bloc.hex(" "):<47}  {texte}')
        (SORTIE / f'{prefixe.lower()}-donnees.txt').write_text('\n'.join(lignes) + '\n', encoding='utf-8')


def main():
    if len(sys.argv) != 2 or sys.argv[1].upper() not in PROGRAMMES:
        sys.exit(__doc__)
    prefixe = sys.argv[1].upper()
    image = graphismes.exepack_unpack(JEU / f'{prefixe}.EXE')
    (RACINE / 'original' / 'binaires').mkdir(parents=True, exist_ok=True)
    (RACINE / 'original' / 'binaires' / f'{prefixe.lower()}.bin').write_bytes(image)
    reglage = PROGRAMMES[prefixe]
    code = (reglage['code'][0], reglage['code'][1] or len(image))
    symboles = charger_symboles(RACINE / 'original' / ('symboles.txt' if prefixe == 'QUEST' else f'symboles-{prefixe.lower()}.txt'))
    d = Desassembleur(image, reglage['entree'], reglage['ds'], symboles, code, reglage['base'], TABLES_ESPACEES.get(prefixe, {}))
    d.parcourir()
    d.zones_non_atteintes()
    d.ecrire(prefixe)
    d.ecrire_routines(prefixe)
    d.ecrire_donnees(prefixe)


if __name__ == '__main__':
    main()
