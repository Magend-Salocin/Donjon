"""Test différentiel du portage : chaque instruction traduite contre un vrai x86 (Unicorn).

    python difference.py [essais par instruction] [QUEST|INTRO]

Pour chaque instruction atteinte du programme, des états tirés au hasard (registres,
drapeaux) sont exécutés une fois par Unicorn et une fois par la traduction JavaScript
(mode pas à pas de recompiler.py, via difference.mjs). On compare registres, drapeaux
définis, octets écrits et instruction suivante. Les interruptions, ports et appels
lointains, qui dépendent de l'environnement, sont exclus.
Prérequis : capstone, unicorn, node.
"""

import json
import random
import subprocess
import sys
import tempfile
from pathlib import Path

from capstone import CS_ARCH_X86, CS_MODE_16, Cs
from unicorn import Uc, UC_ARCH_X86, UC_MODE_16, UC_HOOK_MEM_WRITE, UcError
from unicorn import x86_const as U

import desassembler as D
import recompiler as R

ICI = Path(__file__).resolve().parent
L = 0x1000
REGISTRES = {'ax': U.UC_X86_REG_AX, 'bx': U.UC_X86_REG_BX, 'cx': U.UC_X86_REG_CX, 'dx': U.UC_X86_REG_DX,
             'si': U.UC_X86_REG_SI, 'di': U.UC_X86_REG_DI, 'bp': U.UC_X86_REG_BP, 'sp': U.UC_X86_REG_SP,
             'ds': U.UC_X86_REG_DS, 'es': U.UC_X86_REG_ES, 'ss': U.UC_X86_REG_SS}
BITS = {'cf': 0, 'pf': 2, 'af': 4, 'zf': 6, 'sf': 7, 'df': 10, 'of': 11}
EXCLUS = {'int', 'in', 'out', 'lcall', 'iret'}
# Drapeaux que le processeur laisse indéfinis : on ne les compare pas.
INDEFINIS = {'and': {'af'}, 'or': {'af'}, 'xor': {'af'}, 'test': {'af'},
             'mul': {'pf', 'af', 'zf', 'sf'}, 'div': set(BITS),
             'shl': {'af'}, 'shr': {'af'}, 'sar': {'af'}}


def motif(a):
    return ((a * 2654435761) & 0xffffffff) >> 13 & 0xff


def image_relogee(prefixe):
    image = bytearray(D.graphismes.exepack_unpack(D.JEU / f'{prefixe}.EXE'))
    for p in R.relocations(D.JEU / f'{prefixe}.EXE'):
        v = (image[p] | image[p + 1] << 8) + L
        image[p], image[p + 1] = v & 0xff, (v >> 8) & 0xff
    return bytes(image)


def main():
    essais = int(sys.argv[1]) if len(sys.argv) > 1 else 3
    prefixe = sys.argv[2].upper() if len(sys.argv) > 2 else 'QUEST'
    tmp = Path(tempfile.mkdtemp())
    pas_a_pas = tmp / f'{prefixe.lower()}.pas.js'
    subprocess.run([sys.executable, str(ICI / 'recompiler.py'), prefixe, '--pas-a-pas', str(pas_a_pas)], check=True)
    image = image_relogee(prefixe)
    (tmp / 'image.bin').write_bytes(image)

    d, _ = R.analyser(prefixe)
    B = d.base                                       # IP = position - B ; CS = L + B / 16
    md = Cs(CS_ARCH_X86, CS_MODE_16)
    instructions = {p - B: next(md.disasm(image[p:p + 16], p - B)) for p in sorted(d.instructions)}

    memoire = bytearray(motif(a) for a in range(0x110000))
    memoire[L * 16:L * 16 + len(image)] = image
    memoire = bytes(memoire)
    uc = Uc(UC_ARCH_X86, UC_MODE_16)
    uc.mem_map(0, 0x110000 + 0x10000)
    ecritures = {}
    uc.hook_add(UC_HOOK_MEM_WRITE, lambda uc, acces, adresse, taille, valeur, _: ecritures.update(
        {adresse + k: (valeur >> (8 * k)) & 0xff for k in range(taille)}))

    uc.mem_write(0, memoire)
    hasard = random.Random(1991)
    cas, attendus = [], []
    for a, i in instructions.items():
        if i.mnemonic in EXCLUS:
            continue
        for _ in range(essais):
            etat = {r: hasard.randrange(0x10000) for r in REGISTRES}
            for s in ('ds', 'es', 'ss'):
                etat[s] = hasard.randrange(0x3000, 0x9000)        # au-dessus du code (0x10000-0x24630)
            etat['cx'] = hasard.choice([etat['cx'], hasard.randrange(1, 40), 0, 1])   # rep et décalages
            for f in BITS:
                etat[f] = hasard.randrange(2)
            etat['ip'] = a
            for r, reg in REGISTRES.items():
                uc.reg_write(reg, etat[r])
            uc.reg_write(U.UC_X86_REG_CS, L + B // 16)
            uc.reg_write(U.UC_X86_REG_EFLAGS, 0x202 | sum(etat[f] << b for f, b in BITS.items()))
            ecritures.clear()
            try:
                if i.mnemonic.startswith('rep'):         # Unicorn compte chaque tour de rep
                    uc.emu_start(L * 16 + B + a, L * 16 + B + a + i.size)
                else:
                    uc.emu_start(L * 16 + B + a, 0, count=1)
                drapeaux = uc.reg_read(U.UC_X86_REG_EFLAGS)
                attendu = {r: uc.reg_read(reg) & 0xffff for r, reg in REGISTRES.items()}
                attendu.update({f: (drapeaux >> b) & 1 for f, b in BITS.items()})
                attendu['ip'] = uc.reg_read(U.UC_X86_REG_IP)
                attendu['ecritures'] = {str(k & 0xfffff): v for k, v in ecritures.items()}
                attendu['erreur'] = None
            except UcError as e:
                attendu = {'erreur': str(e)}
            for k in ecritures:                         # remet la mémoire d'origine
                uc.mem_write(k, memoire[k:k + 1])
            cas.append(etat)
            attendus.append((i, attendu))

    sortie = subprocess.run(['node', str(ICI / 'difference.mjs'), str(pas_a_pas), str(tmp / 'image.bin'), str(B // 16)],
                            input=json.dumps(cas), capture_output=True, text=True, check=True,
                            encoding='utf8')
    obtenus = json.loads(sortie.stdout)

    ecarts = {}
    for (i, attendu), obtenu, etat in zip(attendus, obtenus, cas):
        if obtenu['erreur'] and 'division' in obtenu['erreur']:
            continue                    # Unicorn déroute vers int 0 ; le portage s'arrête : voulu
        if 'cs:[' in i.op_str and i.op_str.split(',')[0].endswith(']') and i.mnemonic == 'mov':
            continue                    # Unicorn rejoue l'instruction qui réécrit son propre bloc
        if attendu['erreur'] or obtenu['erreur']:
            if bool(attendu['erreur']) != bool(obtenu['erreur']):
                ecarts.setdefault(i.address, (i, etat, attendu, obtenu, ['erreur']))
            continue
        ignores = INDEFINIS.get(i.mnemonic.split()[-1], set())
        if i.mnemonic in ('shl', 'shr', 'rcl', 'rcr', 'sar') and not i.op_str.endswith(', 1') \
                and ',' in i.op_str:
            ignores = ignores | {'of'}
        differences = [k for k in list(REGISTRES) + ['ip'] if attendu[k] != obtenu[k]]
        differences += [f for f in BITS if f not in ignores and attendu[f] != obtenu[f]]
        if attendu['ecritures'] != obtenu['ecritures']:
            differences.append('ecritures')
        if differences:
            ecarts.setdefault(i.address, (i, etat, attendu, obtenu, differences))

    print(f'{len(cas)} cas, {len(instructions)} instructions, {len(ecarts)} instructions en écart')
    for a, (i, etat, attendu, obtenu, differences) in sorted(ecarts.items())[:40]:
        detail = ', '.join(f'{k} {attendu.get(k)} / {obtenu.get(k)}' for k in differences if k != 'ecritures')
        if 'ecritures' in differences:
            ea, eo = attendu['ecritures'], obtenu['ecritures']
            detail += f' ; écritures {len(ea)} / {len(eo)}, ' + str({k: (ea.get(k), eo.get(k)) for k in sorted(set(ea) ^ set(eo) | {k for k in ea if ea[k] != eo.get(k)})[:4]})
        print(f'  {a:05x} {i.mnemonic} {i.op_str} : {detail}')
    return 1 if ecarts else 0


if __name__ == '__main__':
    sys.exit(main())
