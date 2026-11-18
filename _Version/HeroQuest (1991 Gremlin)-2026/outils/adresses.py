"""
Écrit web/jeu/lisible/adresses.gen.js : l'adresse de chaque routine et étiquette nommée de QUEST.EXE,
pour que le code lisible appelle le code d'origine par son nom (celui du listing).

Usage (depuis ce dossier outils/) : python adresses.py
À relancer après une modification de ../original/symboles.txt.
"""

from pathlib import Path

RACINE = Path(__file__).resolve().parent.parent
SYMBOLES = RACINE / 'original' / 'symboles.txt'
SORTIE = RACINE / 'web' / 'jeu' / 'lisible' / 'adresses.gen.js'


def main():
    lignes = []
    for ligne in SYMBOLES.read_text(encoding='utf-8').splitlines():
        if not ligne.strip() or ligne.startswith('#'):
            continue
        parties = ligne.split(None, 3)
        if parties[1] in ('code', 'etiq'):
            lignes.append(f'  {parties[2]}: 0x{int(parties[0], 16):04x},')
    texte = ('// Généré par outils/adresses.py depuis original/symboles.txt : ne pas modifier.\n'
             '// Adresse (IP) de chaque routine et étiquette nommée de QUEST.EXE.\n\n'
             'export const QUEST = {\n' + '\n'.join(lignes) + '\n};\n')
    SORTIE.write_text(texte, encoding='utf-8')
    print(f'{SORTIE.name} : {len(lignes)} adresses')


if __name__ == '__main__':
    main()
