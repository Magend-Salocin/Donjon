"""Traduit QUEST.EXE (ou INTRO.EXE) en JavaScript, routine par routine.

    python recompiler.py QUEST     ->  ../web/jeu/quest.gen.js

Chaque routine de symboles.txt devient une fonction qui porte son nom et son adresse.
Une fonction exécute ses instructions tant que IP reste chez elle, puis rend IP à la
boucle de la machine (web/jeu/machine.js) : appels, retours et sauts entre routines
passent par la vraie pile du programme, comme sur le processeur d'origine.

Les segments relogés par DOS (table EXEPACK) deviennent « valeur + m.L ». Les octets de
code que le programme réécrit (code automodifié) sont relus en mémoire à chaque passage.
Prérequis : capstone.
"""

import struct
import sys
from bisect import bisect_right
from pathlib import Path

from capstone import CS_ARCH_X86, CS_MODE_16, Cs
from capstone import x86_const as X

import desassembler as D

RACINE = Path(__file__).resolve().parent.parent
SORTIE = RACINE / 'web' / 'jeu'

REG16 = {'ax', 'bx', 'cx', 'dx', 'si', 'di', 'bp', 'sp'}
REG8 = {'al': ('ax', 0), 'ah': ('ax', 8), 'bl': ('bx', 0), 'bh': ('bx', 8),
        'cl': ('cx', 0), 'ch': ('cx', 8), 'dl': ('dx', 0), 'dh': ('dx', 8)}
SEG = {'cs', 'ds', 'es', 'ss'}

CONDITIONS = {
    'je': 'm.zf', 'jne': '!m.zf', 'jb': 'm.cf', 'jae': '!m.cf', 'jbe': '(m.cf || m.zf)',
    'ja': '(!m.cf && !m.zf)', 'js': 'm.sf', 'jns': '!m.sf', 'jl': '(m.sf !== m.of)',
    'jge': '(m.sf === m.of)', 'jle': '(m.zf || m.sf !== m.of)', 'jg': '(!m.zf && m.sf === m.of)',
    'jo': 'm.of', 'jno': '!m.of', 'jcxz': '(m.cx === 0)',
}
SEGMENTS_PREFIXE = {0x2e: 'cs', 0x36: 'ss', 0x3e: 'ds', 0x26: 'es'}
ARITH = {'add', 'sub', 'cmp', 'and', 'or', 'xor', 'test', 'adc', 'sbb'}
TERMINAUX = {'jmp', 'ret', 'iret', 'retf', 'notrack jmp'}


def relocations(exe):
    """Positions (dans l'image) des mots que DOS augmente du segment de chargement."""
    d = exe.read_bytes()
    h = struct.unpack('<14H', d[:28])
    stub = d[h[4] * 16:][h[11] * 16:]
    p = stub.find(b'Packed file is corrupt') + len('Packed file is corrupt')
    positions = set()
    for segment in range(16):
        n = struct.unpack('<H', stub[p:p + 2])[0]
        p += 2
        for (off,) in struct.iter_unpack('<H', stub[p:p + 2 * n]):
            positions.add(segment * 0x10000 + off)
        p += 2 * n
    return positions


class Traducteur:
    def __init__(self, d, relocs, ecrits):
        self.d, self.relocs, self.ecrits = d, relocs, ecrits
        self.md = Cs(CS_ARCH_X86, CS_MODE_16)
        self.md.detail = True

    def decoder(self, ip):
        position = ip + self.d.base
        return next(self.md.disasm(self.d.image[position:position + 16], ip))

    # ---- opérandes

    def immediat(self, i, op, taille):
        """Valeur immédiate : constante, relogée, ou relue en mémoire si le code la réécrit."""
        position, codee = i.address + i.imm_offset, i.imm_size
        masque = 0xff if taille == 1 else 0xffff
        if any(a in self.ecrits for a in range(position, position + codee)):
            if codee == 2:
                return f'm.rw(m.cs, 0x{position:04x})'
            octet = f'm.rb(m.cs, 0x{position:04x})'
            return octet if taille == 1 else f'(((({octet}) ^ 0x80) - 0x80) & 0xffff)'
        valeur = op.imm & masque
        if position in self.relocs:
            assert codee == 2, hex(i.address)
            return f'((0x{valeur:x} + m.L) & 0xffff)'
        return f'0x{valeur:x}'

    def adresse(self, i, op):
        mem = op.mem
        morceaux = [i.reg_name(r) for r in (mem.base, mem.index) if r]
        for r in morceaux:
            assert r in REG16, (hex(i.address), i.op_str)
        disp = mem.disp & 0xffff
        termes = [f'm.{r}' for r in morceaux] + ([f'0x{disp:x}'] if disp or not morceaux else [])
        ea = ' + '.join(termes)
        if len(termes) > 1:
            ea = f'(({ea}) & 0xffff)'
        if mem.segment:
            seg = i.reg_name(mem.segment)
        else:
            seg = 'ss' if mem.base and i.reg_name(mem.base) in ('bp', 'sp') else 'ds'
        return f'm.{seg}', ea

    def lire(self, i, op, taille=None):
        taille = taille or op.size
        if op.type == X.X86_OP_REG:
            r = i.reg_name(op.reg)
            if r in REG8:
                base, dec = REG8[r]
                return f'(m.{base} & 0xff)' if dec == 0 else f'(m.{base} >> 8)'
            return f'm.{r}'
        if op.type == X.X86_OP_IMM:
            return self.immediat(i, op, taille)
        seg, ea = self.adresse(i, op)
        return f'm.{"rb" if taille == 1 else "rw"}({seg}, {ea})'

    def ecrire(self, i, op, valeur):
        if op.type == X.X86_OP_REG:
            r = i.reg_name(op.reg)
            if r in REG8:
                base, dec = REG8[r]
                if dec == 0:
                    return f'm.{base} = (m.{base} & 0xff00) | {valeur};'
                return f'm.{base} = (m.{base} & 0xff) | ({valeur} << 8);'
            return f'm.{r} = {valeur};'
        seg, ea = self.adresse(i, op)
        return f'm.{"wb" if op.size == 1 else "ww"}({seg}, {ea}, {valeur});'

    def cible(self, i, op):
        if op.type == X.X86_OP_IMM:
            return f'0x{op.imm & 0xffff:04x}'
        return self.lire(i, op, 2)

    # ---- instructions

    def traduire(self, i):
        """Lignes JS de l'instruction ; la dernière peut sauter (ip = ...; continue)."""
        mn = i.mnemonic
        ops = i.operands
        suivante = f'0x{i.address + i.size:04x}'
        b = lambda k: 8 if ops[k].size == 1 else 16

        if mn == 'nop':
            return []
        if mn == 'mov':
            return [self.ecrire(i, ops[0], self.lire(i, ops[1], ops[0].size))]
        if mn in ARITH:
            n = b(0)
            a, c = self.lire(i, ops[0]), self.lire(i, ops[1], ops[0].size)
            if mn in ('cmp', 'test'):
                fonction = 'sub' if mn == 'cmp' else 'and'
                return [f'm.{fonction}{n}({a}, {c});']
            if mn in ('xor', 'sub') and ops[0].type == X.X86_OP_REG and ops[1].type == X.X86_OP_REG \
                    and ops[0].reg == ops[1].reg:
                return [f'm.{mn}{n}(0, 0);', self.ecrire(i, ops[0], '0')]
            return [self.ecrire(i, ops[0], f'm.{mn}{n}({a}, {c})')]
        if mn in ('inc', 'dec', 'neg'):
            return [self.ecrire(i, ops[0], f'm.{mn}{b(0)}({self.lire(i, ops[0])})')]
        if mn == 'not':
            masque = '0xff' if ops[0].size == 1 else '0xffff'
            return [self.ecrire(i, ops[0], f'(~{self.lire(i, ops[0])} & {masque})')]
        if mn in ('shl', 'sal', 'shr', 'sar', 'rcl', 'rcr', 'rol', 'ror'):
            nombre = self.lire(i, ops[1], 1) if len(ops) > 1 else '1'
            nom = 'shl' if mn == 'sal' else mn
            return [self.ecrire(i, ops[0], f'm.{nom}{b(0)}({self.lire(i, ops[0])}, {nombre})')]
        if mn in ('mul', 'div'):
            return [f'm.{mn}{b(0)}({self.lire(i, ops[0])});']
        if mn == 'xchg':
            a, c = self.lire(i, ops[0]), self.lire(i, ops[1])
            return ['{', f'const t = {a};', self.ecrire(i, ops[0], c), self.ecrire(i, ops[1], 't'), '}']
        if mn == 'lea':
            _, ea = self.adresse(i, ops[1])
            return [self.ecrire(i, ops[0], ea)]
        if mn == 'xlatb':
            seg = SEGMENTS_PREFIXE.get(i.prefix[1], 'ds')
            return [f'm.ax = (m.ax & 0xff00) | m.rb(m.{seg}, (m.bx + (m.ax & 0xff)) & 0xffff);']
        if mn == 'cwde':                                   # CBW en mode 16 bits
            return ['m.ax = (m.ax & 0x80) ? (m.ax | 0xff00) : (m.ax & 0xff);']
        if mn == 'push':
            return [f'm.push({self.lire(i, ops[0], 2)});']
        if mn == 'pop':
            return ['{', 'const t = m.pop();', self.ecrire(i, ops[0], 't'), '}']
        if mn == 'pushf':
            return ['m.push(m.drapeaux());']
        if mn == 'popf':
            return ['m.poserDrapeaux(m.pop());']
        if mn in ('clc', 'stc', 'cld', 'std', 'cli', 'sti', 'cmc'):
            return [{'clc': 'm.cf = 0;', 'stc': 'm.cf = 1;', 'cld': 'm.df = 0;', 'std': 'm.df = 1;',
                     'cli': 'm.if = 0;', 'sti': 'm.if = 1;', 'cmc': 'm.cf ^= 1;'}[mn]]
        if mn.startswith('rep') or mn in ('movsb', 'movsw', 'stosb', 'stosw', 'lodsb', 'lodsw',
                                          'cmpsb', 'scasb'):
            rep = mn.split()[0] if ' ' in mn else ''
            op = mn.split()[-1]
            seg = 'm.ds'
            for o in ops:
                if o.type == X.X86_OP_MEM and o.mem.segment and o.mem.base and \
                        i.reg_name(o.mem.base) == 'si':
                    seg = f'm.{i.reg_name(o.mem.segment)}'
            return [f'm.{op}({seg}, {1 if rep else 0});']
        if mn == 'in':
            taille = ops[0].size
            port = self.lire(i, ops[1], 1) if ops[1].type == X.X86_OP_IMM else 'm.dx'
            return [self.ecrire(i, ops[0], f'm.entree({port}, {taille})')]
        if mn == 'out':
            port = self.lire(i, ops[0], 1) if ops[0].type == X.X86_OP_IMM else 'm.dx'
            return [f'm.sortie({port}, {self.lire(i, ops[1])}, {ops[1].size});']
        if mn == 'int':
            n = ops[0].imm
            return [f'if (!m.interruption(0x{n:02x})) {{ m.pas = 0; ip = 0x{i.address:04x}; continue; }}']
        if mn == 'lcall':
            seg, ea = self.adresse(i, ops[0])
            return [f'm.appelLointain(m.rw({seg}, ({ea} + 2) & 0xffff), m.rw({seg}, {ea}));']
        if mn == 'call':
            return [f'm.push({suivante});', f'ip = {self.cible(i, ops[0])}; continue;']
        if mn in ('jmp', 'notrack jmp'):
            return [f'ip = {self.cible(i, ops[0])}; continue;']
        if mn in CONDITIONS:
            return [f'if ({CONDITIONS[mn]}) {{ ip = {self.cible(i, ops[0])}; continue; }}']
        if mn == 'loop':
            return ['m.cx = (m.cx - 1) & 0xffff;',
                    f'if (m.cx !== 0) {{ ip = {self.cible(i, ops[0])}; continue; }}']
        if mn == 'ret':
            lignes = ['ip = m.pop();']
            if ops:
                lignes.append(f'm.sp = (m.sp + 0x{ops[0].imm:x}) & 0xffff;')
            return lignes + ['continue;']
        if mn == 'iret':
            return ['ip = m.pop();', 'm.cs = m.pop();', 'm.poserDrapeaux(m.pop());', 'continue;']
        raise ValueError(f'instruction non traduite en 0x{i.address:x} : {mn} {i.op_str}')


def ecrits_par_le_code(d, md):
    """Octets du segment de code que le programme réécrit (adresse fixe, préfixe cs:)."""
    ecrits = set()
    for position in d.instructions:
        i = next(md.disasm(d.image[position:position + 16], position - d.base))
        if not i.operands or i.mnemonic in ('cmp', 'test', 'push'):
            continue
        op = i.operands[0]
        if op.type == X.X86_OP_MEM and op.mem.segment and i.reg_name(op.mem.segment) == 'cs' \
                and not op.mem.base and not op.mem.index:
            ecrits.update(range(op.mem.disp & 0xffff, (op.mem.disp & 0xffff) + op.size))
    return ecrits


def nom_js(nom):
    return nom if nom.isidentifier() else 'r_' + ''.join(c if c.isalnum() else '_' for c in nom)


def analyser(prefixe):
    """Image décompressée et désassemblage suivant le flot, comme outils/desassembler.py."""
    image = D.graphismes.exepack_unpack(D.JEU / f'{prefixe}.EXE')
    reglage = D.PROGRAMMES[prefixe]
    code = (reglage['code'][0], reglage['code'][1] or len(image))
    fichier = 'symboles.txt' if prefixe == 'QUEST' else f'symboles-{prefixe.lower()}.txt'
    symboles = D.charger_symboles(RACINE / 'original' / fichier)
    d = D.Desassembleur(image, reglage['entree'], reglage['ds'], symboles, code, reglage['base'],
                        D.TABLES_ESPACEES.get(prefixe, {}))
    d.parcourir()
    d.zones_non_atteintes()
    return d, reglage


def main():
    prefixe = sys.argv[1].upper() if len(sys.argv) > 1 else 'QUEST'
    # --pas-a-pas FICHIER : une instruction par appel, pour outils/difference.py
    pas_a_pas = Path(sys.argv[sys.argv.index('--pas-a-pas') + 1]) if '--pas-a-pas' in sys.argv else None
    d, reglage = analyser(prefixe)

    md = Cs(CS_ARCH_X86, CS_MODE_16)
    md.detail = True
    relocs = {p - reglage['base'] for p in relocations(D.JEU / f'{prefixe}.EXE')}
    ecrits = ecrits_par_le_code(d, md)
    t = Traducteur(d, relocs, ecrits)

    # Tout est compté en IP (position dans l'image - base du segment de code).
    B = d.base
    adresses = sorted(p - B for p in d.instructions)
    instructions = {a: t.decoder(a) for a in adresses}
    for a, i in instructions.items():                  # un mot relogé n'est jamais qu'un immédiat
        for r in range(a, a + i.size):
            if r in relocs and not (i.imm_size == 2 and r == a + i.imm_offset):
                raise ValueError(f'relocation hors immédiat en 0x{a:x} : {i.mnemonic} {i.op_str}')
    debuts = sorted(p - B for p in set(d.routines) | set(d.probables) if p - B in instructions)
    # Têtes de bloc : cibles de sauts et d'appels, et instructions qui suivent un saut,
    # pour compter le temps (m.t) une fois par bloc exécuté.
    tetes = set(debuts)
    for a, i in instructions.items():
        if i.mnemonic in CONDITIONS or i.mnemonic in TERMINAUX or i.mnemonic in ('call', 'loop', 'int'):
            tetes.add(a + i.size)
            if i.operands and i.operands[0].type == X.X86_OP_IMM and i.mnemonic != 'int':
                tetes.add(i.operands[0].imm & 0xffff)
    for cibles in d.tables.values():
        tetes.update(c - B for c in cibles)

    def proprietaire(a):
        k = bisect_right(debuts, a) - 1
        return debuts[k] if k >= 0 else adresses[0]

    par_routine = {}
    for a in adresses:
        par_routine.setdefault(proprietaire(a), []).append(a)

    noms = {}
    lignes = [f'// Généré par outils/recompiler.py depuis {prefixe}.EXE : ne pas modifier.',
              '// Une fonction par routine (nom de original/symboles.txt, adresse d\'origine) ;',
              '// elle rend l\'IP suivante à la machine dès que l\'exécution quitte la routine.',
              '/* eslint-disable */', '']
    for debut, liste in sorted(par_routine.items()):
        nom = nom_js(d.sym['code'].get(debut + B, f'sub_{debut:04x}'))
        nom = f'{nom}_{debut:04x}'
        noms[debut] = nom
        commentaire = d.sym['commentaire'].get(('code', debut + B), '')
        lignes.append(f'// 0x{debut:04x} {d.nom(debut + B)}' + (f' : {commentaire}' if commentaire else ''))
        lignes.append(f'function {nom}(m, ip) {{')
        lignes.append('  for (;;) {')
        lignes.append('    if (m.pas <= 0) return ip;')
        lignes.append('    switch (ip) {')
        for k, a in enumerate(liste):
            i = instructions[a]
            etiquette = d.sym['code'].get(a + B) if a != debut else None
            if etiquette:
                lignes.append(f'      // {etiquette}')
            entete = f'      case 0x{a:04x}: '
            corps = t.traduire(i)
            if pas_a_pas:
                corps = ['m.t += 1; m.pas -= 1;'] + corps
            elif a in tetes:
                n = 1
                for b in liste[k + 1:]:
                    if b in tetes:
                        break
                    n += 1
                corps = [f'm.t += {n}; m.pas -= {n};'] + corps
            texte = ' '.join(corps)
            lignes.append(f'{entete}{texte}  // {i.mnemonic} {i.op_str}'.rstrip())
            suivante = a + i.size
            fin = i.mnemonic in TERMINAUX
            if not fin and (pas_a_pas or k + 1 >= len(liste) or liste[k + 1] != suivante):
                lignes.append(f'        ip = 0x{suivante:04x}; continue;')
        lignes.append('      default: return ip;')
        lignes.append('    }')
        lignes.append('  }')
        lignes.append('}')
        lignes.append('')

    lignes.append('// Adresse de chaque instruction -> fonction qui la contient.')
    lignes.append('export function routines() {')
    lignes.append('  const table = new Array(0x10000).fill(null);')
    for debut, liste in sorted(par_routine.items()):
        plages = []
        for a in liste:
            if plages and plages[-1][1] == a:
                plages[-1][1] = a + instructions[a].size
            else:
                plages.append([a, a + instructions[a].size])
        texte = ', '.join(f'0x{p:04x}, 0x{q:04x}' for p, q in plages)
        lignes.append(f'  remplir(table, {noms[debut]}, [{texte}]);')
    lignes.append('  return table;')
    lignes.append('}')
    lignes.append('')
    lignes.append('function remplir(table, f, plages) {')
    lignes.append('  for (let k = 0; k < plages.length; k += 2) table.fill(f, plages[k], plages[k + 1]);')
    lignes.append('}')
    lignes.append('')
    octets = sorted(ecrits)
    lignes.append(f'export const CODE_REECRIT = [{", ".join(f"0x{a:04x}" for a in octets)}];')
    lignes.append(f'export const ENTREE = 0x{reglage["entree"] - B:04x};')

    SORTIE.mkdir(parents=True, exist_ok=True)
    sortie = pas_a_pas or SORTIE / f'{prefixe.lower()}.gen.js'
    sortie.write_text('\n'.join(lignes) + '\n', encoding='utf8')
    print(f'{sortie.name} : {len(adresses)} instructions, {len(par_routine)} routines, '
          f'{len(ecrits)} octets de code réécrits')


if __name__ == '__main__':
    main()
