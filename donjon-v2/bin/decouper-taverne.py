"""Découpe les maquettes de la taverne (Visuel_art/Taverne/, 1588 x 991) en images de la page taverne :
une salle par village (la scène au-dessus du dialogue incrusté), le portrait du tenancier et les icônes des réponses.

Dépendance : pip install pillow
Usage (depuis donjon-v2/) : python bin/decouper-taverne.py
Toutes les coordonnées sont en pixels de la maquette.
"""
import os
from PIL import Image

RACINE = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
MAQUETTES = os.path.join(RACINE, '..', 'Visuel_art', 'Taverne')
SORTIE = os.path.join(RACINE, 'public', 'assets', 'img', 'taverne')

# Village : (maquette, cadre de la scène). La scène s'arrête au-dessus du cadre du portrait.
SALLES = {
    '01': ('00464392-8ca5-49be-a405-b437d8d56858.png', (0, 66, 1588, 548)),
    '02': ('6d18ddf9-1989-4bc5-a479-21d3bc9b020c.png', (0, 66, 1585, 594)),
    '03': ('6f05844f-12a8-4aa9-9e5e-a62dcd18c2d4.png', (0, 66, 1588, 488)),
}
PORTRAIT = ('00464392-8ca5-49be-a405-b437d8d56858.png', (55, 565, 352, 832))
# Icônes des réponses, centrées en x = 1080, une par ligne de la maquette.
ICONES = {'chope': 612, 'rumeur': 685, 'epee': 757, 'or': 828, 'porte': 900}
DEMI_ICONE = 22


def ouvrir(nom):
    return Image.open(os.path.join(MAQUETTES, nom)).convert('RGB')


def main():
    os.makedirs(SORTIE, exist_ok=True)
    for village, (nom, cadre) in SALLES.items():
        ouvrir(nom).crop(cadre).save(os.path.join(SORTIE, f'salle-{village}.jpg'), quality=88)

    nom, cadre = PORTRAIT
    ouvrir(nom).crop(cadre).save(os.path.join(SORTIE, 'portrait-tenancier.jpg'), quality=90)

    maquette = ouvrir(PORTRAIT[0])
    for icone, y in ICONES.items():
        cadre = (1080 - DEMI_ICONE, y - DEMI_ICONE, 1080 + DEMI_ICONE, y + DEMI_ICONE)
        maquette.crop(cadre).save(os.path.join(SORTIE, f'icone-{icone}.png'))
    print('Images écrites dans', SORTIE)


if __name__ == '__main__':
    main()
