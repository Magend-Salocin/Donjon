"""
Fait jouer les morceaux de GAME&FX.ALB par le pilote d'origine ADLIB.DRV, dans un processeur 8086 émulé (unicorn),
et relève les écritures dans les registres de la puce AdLib (OPL2), tic par tic.

Usage (depuis ce dossier outils/) : python son.py
Sortie : ../original/donnees/son/morceauNN.json pour chaque morceau joué par le jeu (voir original/notes/01-socle.md#son).
Prérequis : unicorn (pip install unicorn).

Le jeu appelle le pilote comme ici : appel lointain de son début (installation de int 60h), int 60h AX=0Ah
(minuterie à 50 Hz), AX=2 (DX = segment des données), AX=3 (DX = CX = numéro du morceau). Ensuite, la minuterie
appelle 50 fois par seconde la routine de jeu du pilote (0x418, par son gestionnaire int 8 en 0xB59).
Format de sortie : {"hz": 50, "tics": nombre de tics joués, "ecritures": [[tic, registre, valeur], ...]}.
"""

import json
import struct
from pathlib import Path

from unicorn import UC_ARCH_X86, UC_HOOK_INSN, UC_MODE_16, Uc
from unicorn.x86_const import (UC_X86_INS_IN, UC_X86_INS_OUT, UC_X86_REG_AX, UC_X86_REG_CS, UC_X86_REG_CX,
                               UC_X86_REG_DI, UC_X86_REG_DS, UC_X86_REG_DX, UC_X86_REG_ES, UC_X86_REG_EFLAGS,
                               UC_X86_REG_IP, UC_X86_REG_SI, UC_X86_REG_SP, UC_X86_REG_SS)

ICI = Path(__file__).resolve().parent
JEU = ICI.parent.parent / 'HeroQuest (1991 Gremlin)'
SORTIE = ICI.parent / 'original' / 'donnees' / 'son'

# Le pilote doit être chargé à un segment dont l'octet bas n'est pas nul : son installation teste AL après le
# test de présence de la carte (0xBAF), mais AL vaut alors l'octet bas de CS (mov ax, cs en 0x000A).
SEG_PILOTE, SEG_DONNEES, SEG_PILE, SEG_RETOUR = 0x1101, 0x2000, 0x3000, 0x0F00
HZ = 50                             # 1 193 182 / 0x5D37
MORCEAUX = {0: 'musique', 2: 'pas', 3: 'porte', 5: 'combat', 6: 'des', 8: 'clic', 9: 'sort, piège'}
DUREE_MAX = {0: 600}                # en secondes ; les effets s'arrêtent avant
SILENCE_FIN = 2                     # secondes sans écriture : morceau fini


class Adlib:
    """Ports 0x388 (registre) et 0x389 (valeur). La lecture de 0x388 répond au test de présence du pilote."""

    def __init__(self):
        self.registre, self.minuteries, self.ecritures, self.tic = 0, 0, [], 0

    def sortie(self, port, valeur):
        if port == 0x388:
            self.registre = valeur
        elif port == 0x389:
            if self.registre == 4:
                self.minuteries = valeur
            self.ecritures.append([self.tic, self.registre, valeur])

    def entree(self, port):
        if port == 0x388:
            return 0xC0 if self.minuteries & 0x01 and not self.minuteries & 0x80 else 0x00
        return 0xFF


class Machine:
    def __init__(self):
        self.uc = Uc(UC_ARCH_X86, UC_MODE_16)
        self.uc.mem_map(0, 0x100000)
        self.adlib = Adlib()
        self.uc.hook_add(UC_HOOK_INSN, lambda uc, port, taille, valeur, _: self.adlib.sortie(port, valeur & 0xFF),
                         None, 1, 0, UC_X86_INS_OUT)
        self.uc.hook_add(UC_HOOK_INSN, lambda uc, port, taille, _: self.adlib.entree(port), None, 1, 0, UC_X86_INS_IN)
        self.uc.mem_write(SEG_RETOUR * 16, b'\xcf')                       # ancien int 8 : iret
        self.uc.mem_write(0x20, struct.pack('<HH', 0, SEG_RETOUR))
        self.uc.mem_write(SEG_PILOTE * 16, (JEU / 'ADLIB.DRV').read_bytes())
        self.uc.mem_write(SEG_DONNEES * 16, (JEU / 'GAME&FX.ALB').read_bytes())

    def executer(self, cs, ip, empile, registres=None):
        """Exécute CS:IP jusqu'au retour en SEG_RETOUR:0001 ; `empile` = mots posés sur la pile (retour)."""
        uc = self.uc
        uc.reg_write(UC_X86_REG_SS, SEG_PILE)
        sp = 0xFFF0
        for mot in empile:
            sp -= 2
            uc.mem_write(SEG_PILE * 16 + sp, struct.pack('<H', mot))
        uc.reg_write(UC_X86_REG_SP, sp)
        for nom, valeur in (registres or {}).items():
            uc.reg_write(nom, valeur)
        uc.reg_write(UC_X86_REG_CS, cs)
        uc.emu_start(cs * 16 + ip, SEG_RETOUR * 16 + 1, count=5_000_000)

    def appel_lointain(self, cs, ip, registres=None):
        self.executer(cs, ip, [SEG_RETOUR, 1], registres)

    def interruption(self, cs, ip, registres=None):
        self.executer(cs, ip, [0x0202, SEG_RETOUR, 1], registres)

    def int60(self, ax, registres=None):
        ip, cs = struct.unpack('<HH', self.uc.mem_read(0x180, 4))
        self.interruption(cs, ip, {UC_X86_REG_AX: ax, **(registres or {})})
        return self.uc.reg_read(UC_X86_REG_DI)

    def tic(self):
        """Une interruption de la minuterie (int 8), détournée par le pilote vers son gestionnaire."""
        self.adlib.tic += 1
        ip, cs = struct.unpack('<HH', self.uc.mem_read(0x20, 4))
        self.interruption(cs, ip)


def jouer(numero):
    machine = Machine()
    machine.appel_lointain(SEG_PILOTE, 0)
    machine.int60(0x0A)
    machine.int60(2, {UC_X86_REG_DX: SEG_DONNEES, UC_X86_REG_SI: 0})
    machine.adlib.ecritures.clear()
    machine.int60(3, {UC_X86_REG_DX: numero, UC_X86_REG_CX: numero})
    derniere = 0
    for tic in range(DUREE_MAX.get(numero, 30) * HZ):
        avant = len(machine.adlib.ecritures)
        machine.tic()
        if len(machine.adlib.ecritures) != avant:
            derniere = tic
        elif tic - derniere > SILENCE_FIN * HZ:
            break
    return {'hz': HZ, 'tics': derniere + 1, 'ecritures': machine.adlib.ecritures}


def main():
    SORTIE.mkdir(parents=True, exist_ok=True)
    for numero, nom in MORCEAUX.items():
        resultat = jouer(numero)
        (SORTIE / f'morceau{numero:02d}.json').write_text(json.dumps(resultat, separators=(',', ':')), encoding='utf-8')
        print(f'morceau {numero} ({nom}) : {resultat["tics"] / HZ:.1f} s, {len(resultat["ecritures"])} écritures')


if __name__ == '__main__':
    main()
