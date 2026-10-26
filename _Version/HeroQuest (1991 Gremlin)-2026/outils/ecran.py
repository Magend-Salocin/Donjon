"""
Résume ce qu'une routine de QUEST.EXE dessine et affiche, à partir de ../original/asm/quest.asm.

Usage : python ecran.py ADRESSE [ADRESSE...]     (hexadécimal, par exemple 7717)

Pour chaque appel à copie_image : segment source, offset, taille (BP x CX) et position à l'écran (DI = y x 320 + x),
d'après les dernières valeurs immédiates posées avant l'appel. Puis les messages affichés, les fichiers chargés
et les routines appelées. Une valeur non immédiate (registre, mémoire) est notée telle quelle.
"""

import re
import sys
from pathlib import Path

LISTING = Path(__file__).resolve().parent.parent / 'original' / 'asm' / 'quest.asm'
INSTRUCTION = re.compile(r'^([0-9a-f]{5})  (?:[0-9a-f]{2} )+\s*(\S+)\s*(.*)$')


def routine(lignes, adresse):
    """Lignes de la routine qui commence à `adresse` (jusqu'à l'en-tête de routine suivant)."""
    debut = next(i for i, l in enumerate(lignes) if l.startswith(f'{adresse:05x}  '))
    while debut > 0 and not lignes[debut - 1].startswith('; ========') and not lignes[debut].startswith('; ========'):
        if lignes[debut - 1].strip() == '':
            break
        debut -= 1
    fin = next((i for i in range(debut + 1, len(lignes)) if lignes[i].startswith('; ========')), len(lignes))
    return lignes[debut:fin]


def resumer(corps):
    registres, dessins, messages, fichiers, appels = {}, [], [], [], []
    for ligne in corps:
        m = INSTRUCTION.match(ligne)
        if not m:
            continue
        adresse, mnemonique, operandes = m.groups()
        note = operandes.split('    ; ', 1)[1] if '    ; ' in operandes else ''
        operandes = operandes.split('    ; ', 1)[0]
        if mnemonique == 'mov':
            cible, _, source = operandes.partition(', ')
            if cible in ('si', 'di', 'bp', 'cx'):
                registres[cible] = source
            if cible == 'ax' and 'seg_' in note:
                registres['seg'] = note.split(',')[0]
        if mnemonique == 'call' and operandes == 'copie_image':
            di = registres.get('di', '?')
            position = di
            if re.fullmatch(r'0x[0-9a-f]+|\d+', di):
                v = int(di, 0)
                position = f'({v % 320}, {v // 320})'
            dessins.append(f'{adresse}  {registres.get("seg", "?"):<14} source {registres.get("si", "?"):<8} '
                           f'{registres.get("bp", "?")} x {registres.get("cx", "?")}  à {position}')
        elif mnemonique == 'call':
            appels.append(operandes)
        if 'message «' in note:
            messages.append(f'{adresse}  {note}')
        for f in re.findall(r'"([a-z0-9&_]+\.(?:vga|bin|sav))"', note):
            fichiers.append(f)
    return dessins, messages, sorted(set(fichiers)), sorted(set(appels))


def main():
    if len(sys.argv) < 2:
        sys.exit(__doc__)
    lignes = LISTING.read_text(encoding='utf-8').splitlines()
    for argument in sys.argv[1:]:
        corps = routine(lignes, int(argument, 16))
        dessins, messages, fichiers, appels = resumer(corps)
        print(f'### {corps[0] if corps[0].startswith(";") else argument}')
        print('Dessins :' if dessins else 'Dessins : aucun')
        print('\n'.join(f'  {d}' for d in dessins))
        if messages:
            print('Messages :\n' + '\n'.join(f'  {m}' for m in messages))
        if fichiers:
            print('Fichiers : ' + ', '.join(fichiers))
        print('Appels : ' + ', '.join(appels))
        print()


if __name__ == '__main__':
    main()
