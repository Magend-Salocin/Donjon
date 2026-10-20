"""Découpe une planche d'illustrations de quêtes (2 colonnes x 3 rangées, gouttières noires)
en 6 images public/assets/img/aventures/quetes/quete-NN.jpg, au ratio du bandeau de la liste des aventures.
Les planches et leur prompt sont dans Campagne01 (assets/illustrations/, 02-quetes/illustrations-prompt.md).
La quête NN correspond à l'aventure 100 + NN en base.

Dépendance : pip install pillow
Usage (depuis donjon-v2/) : python bin/decouper-planche.py <planche.png> <numéro de la première quête>
Exemple : python bin/decouper-planche.py ../Campagne01/assets/illustrations/planche-1.png 1
"""
import os
import sys
from PIL import Image

RACINE = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
SORTIE = os.path.join(RACINE, 'public', 'assets', 'img', 'aventures', 'quetes')
TAILLE = (744, 324)             # ratio 234 / 102 de .aventure-image
COLONNES, RANGEES = 2, 3
MARGE = 3                       # pixels retirés autour de chaque case (bord de gouttière)


def gouttieres(gris, axe, nombre):
    """Positions (début, fin) des `nombre` bandes noires internes, le long de l'axe 0 (x) ou 1 (y)."""
    largeur, hauteur = gris.size
    pixels = gris.load()
    longueur, travers = (largeur, hauteur) if axe == 0 else (hauteur, largeur)

    def sombre(i):
        valeurs = sorted(pixels[i, j] if axe == 0 else pixels[j, i] for j in range(travers))
        return valeurs[int(travers * 0.97)] < 25

    bandes = []
    for repere in range(1, nombre + 1):
        centre = longueur * repere // (nombre + 1)
        candidats = [i for i in range(centre - longueur // 20, centre + longueur // 20) if sombre(i)]
        if not candidats:
            sys.exit(f'Gouttière introuvable près de {centre} px (axe {"x" if axe == 0 else "y"}).')
        bandes.append((min(candidats), max(candidats) + 1))
    return bandes


def intervalles(bandes, longueur):
    bornes = [0] + [b for bande in bandes for b in bande] + [longueur]
    return [(bornes[i] + MARGE, bornes[i + 1] - MARGE) for i in range(0, len(bornes), 2)]


def recadrer(case):
    """Recadrage centré au ratio de TAILLE, puis redimensionnement."""
    largeur, hauteur = case.size
    ratio = TAILLE[0] / TAILLE[1]
    if largeur / hauteur > ratio:
        nouvelle = round(hauteur * ratio)
        case = case.crop(((largeur - nouvelle) // 2, 0, (largeur + nouvelle) // 2, hauteur))
    else:
        nouvelle = round(largeur / ratio)
        case = case.crop((0, (hauteur - nouvelle) // 2, largeur, (hauteur + nouvelle) // 2))
    return case.resize(TAILLE, Image.LANCZOS)


def main():
    if len(sys.argv) != 3:
        sys.exit(__doc__)
    planche = Image.open(sys.argv[1]).convert('RGB')
    premiere = int(sys.argv[2])
    gris = planche.convert('L')
    xs = intervalles(gouttieres(gris, 0, COLONNES - 1), planche.width)
    ys = intervalles(gouttieres(gris, 1, RANGEES - 1), planche.height)

    os.makedirs(SORTIE, exist_ok=True)
    numero = premiere
    for y0, y1 in ys:
        for x0, x1 in xs:
            chemin = os.path.join(SORTIE, f'quete-{numero:02d}.jpg')
            recadrer(planche.crop((x0, y0, x1, y1))).save(chemin, quality=88, optimize=True)
            print(f'quête {numero:2d} : case {x1 - x0}x{y1 - y0} -> {os.path.relpath(chemin, RACINE)}')
            numero += 1


if __name__ == '__main__':
    main()
