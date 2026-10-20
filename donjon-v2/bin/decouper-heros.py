"""Découpe la planche des héros (4 colonnes x 2 rangées, gouttières noires, fond vert uni) en images détourées.
Colonnes : barbare, nain, elfe, enchanteur. Rangée du haut : héros (h), rangée du bas : héroïnes (f).
Le prompt de la planche est dans Campagne01/01-regles/heros-prompt.md.

Pour chaque case, écrit :
  public/assets/img/personnages/<type>-<sexe>.png               portrait, 480 px de haut (pages du village)
  public/assets/game/images/avatars/<type>-<sexe>-combat.png    180 px de haut (écran de combat)
  public/assets/game/images/avatars/<type>-<sexe>-pion.png      24 x 24, la tête (pion du plateau)
hero_image() (src/helpers.php) utilise ces fichiers dès qu'ils existent.

Dépendance : pip install pillow
Usage (depuis donjon-v2/) :
  python bin/decouper-heros.py <planche.png>                  toute la planche
  python bin/decouper-heros.py <image.png> <type> <h|f>       une seule case régénérée à part
"""
import importlib.util
import os
import sys
from PIL import Image, ImageChops, ImageDraw, ImageFilter

RACINE = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
PORTRAITS = os.path.join(RACINE, 'public', 'assets', 'img', 'personnages')
AVATARS = os.path.join(RACINE, 'public', 'assets', 'game', 'images', 'avatars')
TYPES = ['barbare', 'nain', 'elfe', 'enchanteur']
SEXES = ['h', 'f']
HAUTEUR_PORTRAIT, HAUTEUR_COMBAT, COTE_PION = 480, 180, 24
TETE = 0.28             # côté du pion, en part de la hauteur du personnage (debout, rien au-dessus de la tête)
TOLERANCE_FOND = 90     # écart de couleur toléré avec le vert du fond

# Repérage des gouttières : repris de la découpe des illustrations de quêtes.
_spec = importlib.util.spec_from_file_location('planche', os.path.join(RACINE, 'bin', 'decouper-planche.py'))
planche_quetes = importlib.util.module_from_spec(_spec)
_spec.loader.exec_module(planche_quetes)


def detourer(case):
    """Retire le fond vert relié aux bords de la case et le reflet vert sur le contour du personnage."""
    rgb = case.convert('RGB')
    rgb = rgb.crop(rgb.convert('L').point(lambda v: 255 if v > 25 else 0).getbbox())   # reste de gouttière noire
    repere = (255, 0, 255)
    marquee = rgb.copy()
    largeur, hauteur = rgb.size
    for x, y in [(0, 0), (largeur - 1, 0), (0, hauteur - 1), (largeur - 1, hauteur - 1),
                 (largeur // 2, 0), (largeur // 2, hauteur - 1), (0, hauteur // 2), (largeur - 1, hauteur // 2)]:
        r, g, b = rgb.getpixel((x, y))
        if g > 150 and g > r + 60 and g > b + 60:
            ImageDraw.floodfill(marquee, (x, y), repere, thresh=TOLERANCE_FOND)
    fond = ImageChops.difference(marquee, Image.new('RGB', rgb.size, repere)).convert('L').point(lambda v: 255 if v == 0 else 0)
    alpha = ImageChops.invert(fond).filter(ImageFilter.MinFilter(3)).filter(ImageFilter.GaussianBlur(0.6))

    bord = fond.filter(ImageFilter.MaxFilter(7))
    r, g, b = rgb.split()
    g = Image.composite(ImageChops.darker(g, ImageChops.lighter(r, b)), g, bord)
    personnage = Image.merge('RGBA', (r, g, b, alpha))
    return personnage.crop(alpha.point(lambda v: 255 if v > 40 else 0).getbbox())


def a_la_hauteur(image, hauteur):
    return image.resize((max(1, round(image.width * hauteur / image.height)), hauteur), Image.LANCZOS)


def tete(personnage):
    """Carré en haut du personnage, centré sur la partie opaque de ce haut."""
    cote = max(1, round(personnage.height * TETE))
    haut = personnage.crop((0, 0, personnage.width, cote))
    colonnes = [x for x in range(haut.width) if haut.getchannel('A').crop((x, 0, x + 1, cote)).getbbox()]
    centre = (colonnes[0] + colonnes[-1]) // 2 if colonnes else personnage.width // 2
    gauche = min(max(0, centre - cote // 2), max(0, personnage.width - cote))
    carre = Image.new('RGBA', (cote, cote))
    carre.paste(personnage.crop((gauche, 0, gauche + cote, cote)), (0, 0))
    return carre.resize((COTE_PION, COTE_PION), Image.LANCZOS)


def enregistrer(case, nom):
    personnage = detourer(case)
    a_la_hauteur(personnage, HAUTEUR_PORTRAIT).save(os.path.join(PORTRAITS, nom + '.png'), optimize=True)
    a_la_hauteur(personnage, HAUTEUR_COMBAT).save(os.path.join(AVATARS, nom + '-combat.png'), optimize=True)
    tete(personnage).save(os.path.join(AVATARS, nom + '-pion.png'), optimize=True)
    print(f'{nom:14s} case {case.width}x{case.height}, personnage {personnage.width}x{personnage.height}')


def main():
    os.makedirs(PORTRAITS, exist_ok=True)
    os.makedirs(AVATARS, exist_ok=True)
    if len(sys.argv) == 4 and sys.argv[2] in TYPES and sys.argv[3] in SEXES:
        enregistrer(Image.open(sys.argv[1]).convert('RGB'), f'{sys.argv[2]}-{sys.argv[3]}')
        return
    if len(sys.argv) != 2:
        sys.exit(__doc__)
    planche = Image.open(sys.argv[1]).convert('RGB')
    gris = planche.convert('L')
    xs = planche_quetes.intervalles(planche_quetes.gouttieres(gris, 0, len(TYPES) - 1), planche.width)
    ys = planche_quetes.intervalles(planche_quetes.gouttieres(gris, 1, len(SEXES) - 1), planche.height)

    for sexe, (y0, y1) in zip(SEXES, ys):
        for type_, (x0, x1) in zip(TYPES, xs):
            enregistrer(planche.crop((x0, y0, x1, y1)), f'{type_}-{sexe}')


if __name__ == '__main__':
    main()
