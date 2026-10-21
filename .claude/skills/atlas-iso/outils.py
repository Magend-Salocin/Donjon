"""Outils du skill atlas-iso. À lancer depuis donjon-v2/.

  python ../.claude/skills/atlas-iso/outils.py reperer <planche.png> <dossier>
      Repère les sprites d'une planche sur fond noir : <dossier>/boites.json (liste [x, y, largeur, hauteur])
      et <dossier>/reperes.png (planche avec chaque boîte numérotée). Les boîtes servent de base aux zones
      de bin/atlas-iso.json ; vérifier chacune (sprites collés, morceaux détachés).
  python ../.claude/skills/atlas-iso/outils.py reference <sortie.png>
      Planche nommée de l'atlas de 1991 (public/assets/game/iso/1991/), x 2 : à comparer avec la nouvelle planche.
  python ../.claude/skills/atlas-iso/outils.py scene <sortie.png>
      Petite pièce dessinée avec l'atlas du jeu, avec les règles de placement de ModuleIso.js, agrandie x 3.

Dépendance : pip install pillow numpy
"""
import json
import os
import re
import sys
from collections import deque
import numpy as np
from PIL import Image, ImageDraw

ISO = os.path.join('public', 'assets', 'game', 'iso')
SEUIL = 45          # luminosité (max r, g, b) au-dessus de laquelle un pixel appartient à un sprite
FRAGMENT = 1200     # surface de boîte sous laquelle un morceau est rattaché à son voisin
PROCHE = 6          # distance max (px) pour ce rattachement


def lire_atlas(dossier):
    texte = open(os.path.join(dossier, 'atlas.js'), encoding='utf-8').read()
    atlas = json.loads(re.search(r'var IsoAtlas = (\{.*?\});', texte).group(1))
    echelle = re.search(r'var IsoEchelle = (\d+);', texte)
    return atlas, int(echelle.group(1)) if echelle else 1, Image.open(os.path.join(dossier, 'atlas.png')).convert('RGBA')


def reperer(planche, dossier):
    image = Image.open(planche).convert('RGB')
    plein = np.asarray(image).astype(int).max(axis=2) > SEUIL
    plein |= np.roll(plein, 1, 0) | np.roll(plein, 1, 1)          # comble les trous d'un pixel
    hauteur, largeur = plein.shape
    vu = np.zeros_like(plein)
    boites = []
    for y0, x0 in zip(*np.nonzero(plein)):
        if vu[y0, x0]:
            continue
        vu[y0, x0] = True
        file, boite = deque([(y0, x0)]), [x0, y0, x0, y0]
        while file:
            y, x = file.popleft()
            boite = [min(boite[0], x), min(boite[1], y), max(boite[2], x), max(boite[3], y)]
            for v, u in ((y + 1, x), (y - 1, x), (y, x + 1), (y, x - 1)):
                if 0 <= v < hauteur and 0 <= u < largeur and plein[v, u] and not vu[v, u]:
                    vu[v, u] = True
                    file.append((v, u))
        boites.append([int(boite[0]), int(boite[1]), int(boite[2]) + 1, int(boite[3]) + 1])

    surface = lambda b: (b[2] - b[0]) * (b[3] - b[1])
    distance = lambda a, b: max(a[0] - b[2], b[0] - a[2], a[1] - b[3], b[1] - a[3], 0)
    change = True
    while change:            # petits morceaux rattachés au voisin le plus proche, du plus petit au plus grand
        change = False
        boites.sort(key=surface)
        for i, b in enumerate(boites):
            if surface(b) >= FRAGMENT:
                break
            voisin = min((o for o in boites if o is not b), key=lambda o: distance(b, o))
            if distance(b, voisin) <= PROCHE:
                voisin[:] = [min(voisin[0], b[0]), min(voisin[1], b[1]), max(voisin[2], b[2]), max(voisin[3], b[3])]
                boites.pop(i)
                change = True
                break
    boites = sorted((b for b in boites if surface(b) >= FRAGMENT), key=lambda b: ((b[1] + b[3]) // 90, b[0]))

    os.makedirs(dossier, exist_ok=True)
    json.dump([[b[0], b[1], b[2] - b[0], b[3] - b[1]] for b in boites], open(os.path.join(dossier, 'boites.json'), 'w'))
    dessin = ImageDraw.Draw(image)
    for i, b in enumerate(boites):
        dessin.rectangle((b[0], b[1], b[2] - 1, b[3] - 1), outline=(255, 0, 255))
        dessin.text((b[0] + 2, b[1] + 1), str(i), fill=(255, 255, 0))
    image.save(os.path.join(dossier, 'reperes.png'))
    print(f'{len(boites)} boîtes')


def reference(sortie, zoom=2, largeur=1300):
    atlas, _, planche = lire_atlas(os.path.join(ISO, '1991'))
    x = y = ligne = 0
    positions = []
    for nom, zone in atlas.items():
        case = max(zone[2] * zoom, 64) + 6, zone[3] * zoom + 14
        if x + case[0] > largeur:
            x, y, ligne = 0, y + ligne, 0
        positions.append((nom, x, y))
        x += case[0]
        ligne = max(ligne, case[1])
    feuille = Image.new('RGBA', (largeur, y + ligne), (40, 40, 40, 255))
    dessin = ImageDraw.Draw(feuille)
    for nom, x, y in positions:
        z = atlas[nom]
        image = planche.crop((z[0], z[1], z[0] + z[2], z[1] + z[3])).resize((z[2] * zoom, z[3] * zoom), Image.NEAREST)
        feuille.alpha_composite(image, (x, y + 12))
        dessin.text((x, y), nom.replace('meuble', 'm').replace('portrait-', 'p-').replace('icone-', 'i-'), fill=(255, 255, 0))
    feuille.save(sortie)


def scene(sortie):
    """Mêmes formules que IsoDessiner, IsoCotesDuFond et IsoPersonnage (ModuleIso.js), demi-dalle 24 x 12."""
    atlas, echelle, planche = lire_atlas(ISO)
    demi_x, demi_y, decalage = 24, 12, (180, 40)
    image = Image.new('RGBA', (360, 260), (0, 0, 0, 255))

    def dessiner(nom, x, y, miroir=False):
        z = atlas[nom]
        morceau = planche.crop((z[0], z[1], z[0] + z[2] * echelle, z[1] + z[3] * echelle)).resize((z[2], z[3]), Image.BILINEAR)
        if miroir:
            morceau = morceau.transpose(Image.FLIP_LEFT_RIGHT)
        image.alpha_composite(morceau, (round(x) + decalage[0], round(y) + decalage[1]))

    point = lambda cx, cy: ((cx - cy) * demi_x, (cx + cy) * demi_y)
    for cy in range(6):
        for cx in range(6):
            x, y = point(cx, cy)
            dessiner(['sol1f80', 'sol4800', 'sol7500'][cy // 2] if cx < 4 else 'sol6c00', x - demi_x, y)
    for i in range(6):
        x, y = point(i, 0)
        dessiner('porte1', x, y - 34) if i == 2 else dessiner('mur' + str(2 + i % 2), x, y - 39)
        x, y = point(0, i)
        dessiner('porte0', x - demi_x, y + demi_y - 43) if i == 3 else dessiner('mur' + str(i % 2), x - demi_x, y + demi_y - 51)
    dessiner('meuble4b', 60, 100)
    for cx, cy, nom, miroir in [(1, 1, 'barbare-h-repos', False), (2, 1, 'nain-f-repos', False), (3, 2, 'elfe-f-repos', True),
                                (1, 3, 'enchanteur-h-repos', False), (4, 1, 'barbare-f-dos-marche0', True),
                                (4, 3, 'orc-repos', False), (3, 4, 'chaos-repos', False), (2, 4, 'barbare-f-marche1', False)]:
        x, y = point(cx, cy)
        z = atlas[nom]
        dessiner(nom, x - z[2] / 2, y + demi_y + 4 - z[3], miroir)
    image.resize((image.width * 3, image.height * 3), Image.NEAREST).save(sortie)


if __name__ == '__main__':
    commandes = {'reperer': (reperer, 4), 'reference': (reference, 3), 'scene': (scene, 3)}
    if len(sys.argv) < 2 or sys.argv[1] not in commandes or len(sys.argv) != commandes[sys.argv[1]][1]:
        sys.exit(__doc__)
    commandes[sys.argv[1]][0](*sys.argv[2:])
