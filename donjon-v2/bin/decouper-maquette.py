"""Découpe les maquettes (bin/maquette/) en images pour le thème du site (public/assets/img/donjon/),
sur le modèle de l'ancien design. Page de connexion (maquette-connexion.png, 1989 x 791) : en-tête,
épée en morceaux (onglets en HTML par-dessus), torches des côtés, cadre de parchemin, bouton, blason.
Bas de page (maquette-pied.png, 1839 x 278) : mobilier à gauche et à droite, mur et sol répétés entre les deux.
Mur (maquette-mur.png, 1584 x 81) : tranche répétée en hauteur derrière la page, comme main_bg.png en 2009.
Aventures (maquette-aventures.png, 1029 x 610) : illustrations, ornements du titre, icônes difficulté / expérience / or.
La texture de parchemin est générée (raccordable).

Dépendances : pip install pillow numpy opencv-python-headless fonttools brotli
Usage (depuis donjon-v2/) : python bin/decouper-maquette.py
Toutes les coordonnées sont en pixels de la maquette.
"""
import io
import os
import sys
import cv2
import numpy as np
from PIL import Image, ImageDraw, ImageFilter, ImageFont

from fontTools.ttLib import TTFont

RACINE = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
maquette = os.path.join(RACINE, 'bin', 'maquette', 'maquette-connexion.png')
maquette_pied = os.path.join(RACINE, 'bin', 'maquette', 'maquette-pied.png')
maquette_mur = os.path.join(RACINE, 'bin', 'maquette', 'maquette-mur.png')
maquette_aventures = os.path.join(RACINE, 'bin', 'maquette', 'maquette-aventures.png')
sortie = os.path.join(RACINE, 'public', 'assets', 'img', 'donjon')


def police_titre(taille):
    """Cinzel Decorative du site (woff2), convertie en mémoire pour Pillow."""
    police = TTFont(os.path.join(RACINE, 'public', 'assets', 'fonts', 'CinzelDecorative-Bold.woff2'))
    police.flavor = None
    tampon = io.BytesIO()
    police.save(tampon)
    tampon.seek(0)
    return ImageFont.truetype(tampon, taille)
BANDE = (255, 300)              # rangée de l'épée (haut, bas)


def corriger_carte(img):
    """Remplace « Terres du Flanc » par « Terre de Fangh »."""
    x0, y0, x1, y1 = 745, 145, 945, 192
    gris = cv2.cvtColor(img[y0:y1, x0:x1], cv2.COLOR_BGR2GRAY)
    encre = cv2.dilate((gris < 95).astype(np.uint8) * 255, np.ones((5, 5), np.uint8))
    masque = np.zeros(img.shape[:2], np.uint8)
    masque[y0:y1, x0:x1] = encre
    img = cv2.inpaint(img, masque, 6, cv2.INPAINT_TELEA)
    # grain du parchemin sur la zone lissée par l'effacement
    bruit = np.random.default_rng(1).normal(0, 7, img.shape).astype(np.int16)
    zone = masque > 0
    img[zone] = np.clip(img[zone].astype(np.int16) + bruit[zone], 0, 255).astype(np.uint8)
    im = Image.fromarray(cv2.cvtColor(img, cv2.COLOR_BGR2RGB))
    calque = Image.new('RGBA', im.size)
    ImageDraw.Draw(calque).text((760, 157), 'Terre de Fangh', font=police_titre(21), fill=(52, 32, 12, 235))
    calque = calque.filter(ImageFilter.GaussianBlur(0.4))
    return Image.alpha_composite(im.convert('RGBA'), calque).convert('RGB')


def masque_polygone(taille, points, origine):
    """Masque alpha anti-crénelé : polygone dessiné à 4x puis réduit."""
    grand = Image.new('L', (taille[0] * 4, taille[1] * 4))
    ImageDraw.Draw(grand).polygon([((x - origine[0]) * 4, (y - origine[1]) * 4) for x, y in points], fill=255)
    return grand.resize(taille, Image.LANCZOS)


def trois_morceaux(im, gauche, milieu, droite, haut, bas):
    """Assemble gauche + colonne du milieu (étirable) + droite, pour border-image."""
    morceaux = [im.crop((a, haut, b, bas)) for a, b in (gauche, milieu, droite)]
    total = Image.new('RGB', (sum(m.width for m in morceaux), bas - haut))
    x = 0
    for m in morceaux:
        total.paste(m, (x, 0))
        x += m.width
    return total, morceaux[0].width, morceaux[2].width


def bruit_raccordable(largeur, hauteur, octaves, graine):
    """Bruit à plusieurs échelles, raccordable sur les quatre bords, normalisé entre 0 et 1."""
    rng = np.random.default_rng(graine)
    champ = np.zeros((hauteur, largeur))
    for cellules, poids in octaves:
        petit = rng.random((max(1, cellules * hauteur // largeur), cellules))
        grand = cv2.resize(np.tile(petit, (3, 3)), (largeur * 3, hauteur * 3), interpolation=cv2.INTER_CUBIC)
        champ += poids * grand[hauteur:2 * hauteur, largeur:2 * largeur]
    return (champ - champ.min()) / (champ.max() - champ.min())


def detourer(im, seuil=38, fondu=40):
    """Rend transparent le parchemin autour d'un élément (couleur prise aux quatre coins)."""
    rgb = np.array(im.convert('RGB')).astype(np.float32)
    fond = np.mean([rgb[1, 1], rgb[1, -2], rgb[-2, 1], rgb[-2, -2]], axis=0)
    ecart = np.linalg.norm(rgb - fond, axis=2)
    alpha = np.clip((ecart - seuil) / fondu, 0, 1)
    # seules les zones reliées aux bords sont du fond : l'intérieur du bouton reste opaque
    _, etiquettes = cv2.connectedComponents((alpha < 1).astype(np.uint8))
    bords = set(etiquettes[0]) | set(etiquettes[-1]) | set(etiquettes[:, 0]) | set(etiquettes[:, -1])
    fond_relie = np.isin(etiquettes, [e for e in bords if e != 0])
    alpha = np.where(fond_relie, alpha, 1)
    sortie = Image.fromarray(rgb.astype(np.uint8)).convert('RGBA')
    sortie.putalpha(Image.fromarray((alpha * 255).astype(np.uint8)))
    return sortie


def raccord_horizontal(im, fondu):
    """Rend une image raccordable en largeur : sa fin se fond dans son début."""
    rgb = np.array(im).astype(np.float32)
    poids = np.linspace(0, 1, fondu)[None, :, None]
    debut = rgb[:, :fondu] * poids + rgb[:, -fondu:] * (1 - poids)
    return Image.fromarray(np.concatenate([debut, rgb[:, fondu:-fondu]], axis=1).astype(np.uint8))


def tranche_mur(im):
    """Tranche de mur répétable en hauteur : une rangée de pierres coupée au milieu de deux joints,
    puis la même rangée en miroir, pour décaler les joints verticaux d'une rangée à l'autre."""
    rgb = np.array(im).astype(np.float32)
    colonnes = rgb.mean(axis=(0, 2))
    gauche = int(np.argmax(colonnes > 10))
    droite = len(colonnes) - int(np.argmax(colonnes[::-1] > 10))   # sans la bordure noire
    lignes = cv2.GaussianBlur(rgb.mean(axis=(1, 2)).reshape(-1, 1), (1, 5), 0).ravel()
    milieu = len(lignes) // 2
    haut = int(np.argmin(lignes[:milieu]))                           # joints horizontaux : lignes les plus sombres
    bas = milieu + int(np.argmin(lignes[milieu:]))
    rangee = rgb[haut:bas, gauche:droite]
    return Image.fromarray(np.concatenate([rangee, rangee[:, ::-1]], axis=0).astype(np.uint8)), (gauche, droite, haut, bas)


def texture_parchemin(taille=512):
    """Parchemin raccordable."""
    champ = bruit_raccordable(taille, taille, ((4, 0.5), (16, 0.3), (64, 0.15), (256, 0.05)), 7)
    clair, sombre = np.array([226, 196, 146]), np.array([188, 150, 98])
    return Image.fromarray((sombre + (clair - sombre) * champ[..., None]).astype(np.uint8))


def cadre_parchemin(im, echelle=0.6):
    """Cadre bois et fer du panneau : intérieur transparent (le parchemin de fond se voit au travers),
    bords brûlés du parchemin conservés par un fondu. Réduit à l'échelle d'affichage."""
    x0, y0, x1, y1 = 600, 337, 1386, 739
    cadre = im.crop((x0, y0, x1, y1)).convert('RGBA')
    interieur = Image.new('L', cadre.size)
    ImageDraw.Draw(interieur).rectangle((662 - x0, 374 - y0, 1328 - x0, 700 - y0), fill=255)
    interieur = interieur.filter(ImageFilter.GaussianBlur(9))
    cadre.putalpha(Image.eval(interieur, lambda v: 255 - v))
    return cadre.resize((round(cadre.width * echelle), round(cadre.height * echelle)), Image.LANCZOS)


os.makedirs(sortie, exist_ok=True)
im = corriger_carte(cv2.imread(maquette))
haut, bas = BANDE

im.crop((0, 0, 1989, bas)).save(f'{sortie}/entete.jpg', quality=88)

# Épée : pointe, onglets (3 morceaux), fin de la bande dorée, lame (2 px répétés), garde
im.crop((188, haut, 329, bas)).save(f'{sortie}/epee-pointe.png')
onglet, g, d = trois_morceaux(im, (517, 563), (563, 566), (671, 717), haut, bas)
onglet.save(f'{sortie}/onglet.png')
im.crop((1016, haut, 1075, bas)).save(f'{sortie}/epee-bande-fin.png')   # bout du dernier onglet + chevron
im.crop((1090, haut, 1490, bas)).save(f'{sortie}/epee-lame.png')        # tronçon répété : garde le grain du métal
im.crop((1515, haut, 1800, bas)).save(f'{sortie}/epee-garde.png')
pointe_basse = [(1595, 300), (1618, 300), (1612, 330), (1606, 345), (1600, 330)]
bas_garde = im.crop((1592, 300, 1622, 350)).convert('RGBA')
bas_garde.putalpha(masque_polygone(bas_garde.size, pointe_basse, (1592, 300)))
bas_garde.save(f'{sortie}/epee-garde-bas.png')

# Torches et bannières des côtés, sous l'épée (le mobilier du bas est dans le pied de page)
im.crop((0, bas, 255, 540)).save(f'{sortie}/decor-gauche.jpg', quality=85)
im.crop((1735, bas, 1989, 540)).save(f'{sortie}/decor-droite.jpg', quality=85)

# Pied de page : mobilier à gauche et à droite, mur et sol répétés au milieu
pied = Image.open(maquette_pied).convert('RGB')
pied.crop((35, 0, 420, 265)).save(f'{sortie}/pied-gauche.jpg', quality=85)
pied.crop((1470, 0, 1810, 265)).save(f'{sortie}/pied-droite.jpg', quality=85)
raccord_horizontal(pied.crop((1290, 0, 1470, 265)), 40).save(f'{sortie}/pied-milieu.jpg', quality=85)

# Mur de la page : tranche répétée en hauteur
mur, cadrage = tranche_mur(Image.open(maquette_mur).convert('RGB'))
mur.save(f'{sortie}/mur.jpg', quality=88)
print('mur : cadrage (gauche, droite, haut, bas) =', cadrage, 'taille', mur.size)

# Aventures : illustrations (sans leur bord déchiré), ornements du titre, icônes détourées
aventures = Image.open(maquette_aventures).convert('RGB')
illustrations = {'labyrinthe': 82, 'feu': 215, 'glace': 342, 'marais': 469}
for nom, y in illustrations.items():
    aventures.crop((52, y + 2, 286, y + 104)).save(f'{sortie}/aventure-{nom}.jpg', quality=88)
detourer(aventures.crop((203, 28, 316, 54))).save(f'{sortie}/ornement-gauche.png')
detourer(aventures.crop((670, 28, 773, 54))).save(f'{sortie}/ornement-droite.png')
for nom, x in (('difficulte', 318), ('experience', 471), ('or', 650)):
    detourer(aventures.crop((x, 170, x + 24, 195))).save(f'{sortie}/icone-{nom}.png')

# Parchemin : texture, cadre (9 morceaux), bouton rouge (3 morceaux), blason
texture_parchemin().save(f'{sortie}/parchemin.jpg', quality=85)
cadre_parchemin(im).save(f'{sortie}/cadre-parchemin.png')
bouton, g, d = trois_morceaux(im, (797, 845), (845, 848), (1137, 1187), 563, 633)
detourer(bouton).save(f'{sortie}/bouton.png')
contour_blason = [(660, 383), (714, 383), (714, 425), (706, 445), (687, 459), (668, 445), (660, 425)]
blason = im.crop((657, 380, 717, 461)).convert('RGBA')
blason.putalpha(masque_polygone(blason.size, contour_blason, (657, 380)))
blason.save(f'{sortie}/blason.png')
