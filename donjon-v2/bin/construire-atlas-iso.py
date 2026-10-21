r"""Construit l'atlas de la vue isométrique (public/assets/game/iso/atlas.png et atlas.js) à partir d'une planche
redessinée sur fond noir. La zone de chaque image sur la planche est dans bin/atlas-iso.json.
Procédure complète (nouvelle planche, repérage des zones, vérification) : skill atlas-iso, .claude/skills/atlas-iso/SKILL.md
à la racine du dépôt.

Les images sont rangées sur atlas.png à IsoEchelle fois leur taille sur le plateau. IsoAtlas donne leur position
sur atlas.png et leur taille sur le plateau : ModuleIso.js n'a pas à connaître l'échelle de la planche.

Cadrages (champ "cadrage" d'un groupe de bin/atlas-iso.json) :
  mur        face redressée depuis ses "coins" (haut gauche, bas gauche, bas droit, haut droit) sur la planche,
             reposée sur le parallélogramme de pente 1/2 ("pente" : monte pour /, descend pour \)
  etire      étirée à la taille exacte (portes : leur géométrie doit suivre les murs)
  losange    sol : losange du dessus (hauteur = largeur / 2), sans l'épaisseur de la dalle, puis étiré
  contenir   réduite pour tenir dans la taille, posée en bas et centrée (meubles, portraits, icônes)
  reduction  taille de la planche divisée par "reduction" : garde les tailles relatives (personnages)
Autres champs : "marge" (pixels ajoutés autour de la zone, 2 par défaut), "miroir", "gris" (icône déjà jouée),
"decalage" (dx, dy des meubles, recopiés tels quels).

Dépendance : pip install pillow numpy
Usage (depuis donjon-v2/) : python bin/construire-atlas-iso.py [controle.png]
La planche est celle de "planche" dans bin/atlas-iso.json : les zones n'ont de sens que pour elle.
controle.png (facultatif) : planche de vérification, chaque image avec son nom.
"""
import json
import os
import sys
import numpy as np
from PIL import Image, ImageDraw, ImageOps

RACINE = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
CORRESPONDANCE = os.path.join(RACINE, 'bin', 'atlas-iso.json')
SORTIE = os.path.join(RACINE, 'public', 'assets', 'game', 'iso')
LARGEUR_PLANCHE = 1024
ESPACE = 2              # pixels vides entre deux images (évite que le lissage déborde sur la voisine)
FOND = 34               # luminosité (max r, g, b) sous laquelle un pixel relié au bord est du fond
NOIR_ENFERME = 8        # sous ce seuil, un pixel est du fond même enfermé (entre un bras et le corps)
MORCEAU = 0.03          # morceau gardé s'il fait au moins cette part du plus grand (sinon : bout d'un voisin)


def morceaux_isoles(dessin):
    """Masque des petits morceaux détachés du dessin principal (pointe d'une dalle voisine, poussière)."""
    reste = dessin.copy()
    morceaux = []
    for y, x in zip(*np.nonzero(dessin)):
        if not reste[y, x]:
            continue
        marque = Image.fromarray(reste.astype(np.uint8) * 255)
        ImageDraw.floodfill(marque, (int(x), int(y)), 128)
        morceau = np.asarray(marque) == 128
        reste &= ~morceau
        morceaux.append(morceau)
    plus_grand = max(m.sum() for m in morceaux)
    petits = [m for m in morceaux if m.sum() < plus_grand * MORCEAU]
    return np.logical_or.reduce(petits) if petits else np.zeros_like(dessin)


def detourer(zone):
    """RGBA : le fond noir relié aux bords de la zone devient transparent, recadré sur le dessin."""
    rgb = np.asarray(zone.convert('RGB')).astype(int)
    sombre = rgb.max(axis=2) <= FOND
    marque = Image.fromarray(np.pad(sombre, 1, constant_values=True).astype(np.uint8) * 255)
    ImageDraw.floodfill(marque, (0, 0), 128)
    fond = (np.asarray(marque)[1:-1, 1:-1] == 128) | (rgb.max(axis=2) <= NOIR_ENFERME)
    fond |= morceaux_isoles(~fond)
    alpha = Image.fromarray(np.where(fond, 0, 255).astype(np.uint8))
    image = zone.convert('RGB').convert('RGBA')
    image.putalpha(alpha)
    return image.crop(alpha.getbbox())


def griser(image):
    """Version « déjà jouée » d'une icône : gris beige assombri, comme les icônes grisées de 1991."""
    gris = ImageOps.grayscale(image).point(lambda v: v * 0.8)
    teinte = ImageOps.colorize(gris, (20, 18, 14), (200, 190, 170)).convert('RGBA')
    teinte.putalpha(image.getchannel('A'))
    return teinte


def reduire(image, taille):
    """Redimensionnement en alpha prémultiplié, pour ne pas faire baver le noir du fond sur les bords."""
    return image.convert('RGBa').resize(taille, Image.LANCZOS).convert('RGBA')


def cadrer(image, options, echelle):
    """(image à la taille de l'atlas, taille sur le plateau)."""
    cadrage = options['cadrage']
    if cadrage == 'reduction':
        taille = [max(1, round(cote / options['reduction'])) for cote in image.size]
        return reduire(image, (taille[0] * echelle, taille[1] * echelle)), taille
    largeur, hauteur = taille = options['taille']
    if cadrage == 'losange':
        image = image.crop((0, 0, image.width, min(image.height, round(image.width / 2))))
        cadrage = 'etire'
    if cadrage == 'etire':
        return reduire(image, (largeur * echelle, hauteur * echelle)), taille
    rapport = min(largeur / image.width, hauteur / image.height)
    dessin = reduire(image, (max(1, round(image.width * rapport * echelle)), max(1, round(image.height * rapport * echelle))))
    cadre = Image.new('RGBA', (largeur * echelle, hauteur * echelle))
    cadre.paste(dessin, ((cadre.width - dessin.width) // 2, cadre.height - dessin.height))
    return cadre, taille


def mur(planche, options, echelle):
    """Face de mur redressée depuis ses 4 coins sur la planche, puis posée sur le parallélogramme des murs de 1991
    (pente 1/2) : les murs se raccordent alors exactement aux dalles et entre eux."""
    largeur, hauteur = options['taille']
    montee = largeur // 2
    coins = [valeur for coin in options['coins'] for valeur in coin]
    face = planche.convert('RGBA').transform((largeur * echelle, (hauteur - montee) * echelle), Image.QUAD, coins, Image.BICUBIC)
    # pente « monte » (/) : le bord gauche est plus bas que le bord droit ; « descend » (\) : l'inverse
    pente, depart = (0.5, -montee * echelle) if options['pente'] == 'monte' else (-0.5, 0)
    return face.transform((largeur * echelle, hauteur * echelle), Image.AFFINE, (1, 0, 0, pente, 1, depart), Image.BICUBIC)


def images(planche, correspondance):
    echelle = correspondance['echelle']
    for groupe in correspondance['groupes']:
        for nom, entree in groupe['images'].items():
            options = {**groupe, **(entree if isinstance(entree, dict) else {'zone': entree})}
            if options['cadrage'] == 'mur':
                yield nom, mur(planche, options, echelle), options['taille']
                continue
            x, y, largeur, hauteur = options['zone']
            marge = options.get('marge', 2)
            image = detourer(planche.crop((x - marge, y - marge, x + largeur + marge, y + hauteur + marge)))
            if options.get('miroir'):
                image = ImageOps.mirror(image)
            if options.get('gris'):
                image = griser(image)
            image, taille = cadrer(image, options, echelle)
            yield nom, image, list(taille) + options.get('decalage', [])


def ranger(liste):
    """Rangement en lignes sur LARGEUR_PLANCHE pixels de large."""
    x = y = ligne = 0
    positions = {}
    for nom, image, _ in liste:
        if x + image.width > LARGEUR_PLANCHE:
            x, y, ligne = 0, y + ligne + ESPACE, 0
        positions[nom] = (x, y)
        x += image.width + ESPACE
        ligne = max(ligne, image.height)
    atlas = Image.new('RGBA', (LARGEUR_PLANCHE, y + ligne))
    for nom, image, _ in liste:
        atlas.paste(image, positions[nom])
    return atlas, positions


def controler(liste, chemin):
    """Planche de vérification : chaque image à sa taille sur le plateau x 2, son nom en dessous."""
    colonnes, case = 12, 104
    lignes = (len(liste) + colonnes - 1) // colonnes
    feuille = Image.new('RGB', (colonnes * case, lignes * (case + 12)), (70, 62, 50))
    dessin = ImageDraw.Draw(feuille)
    for i, (nom, image, taille) in enumerate(liste):
        x, y = i % colonnes * case, i // colonnes * (case + 12)
        apercu = reduire(image, (taille[0] * 2, taille[1] * 2))
        apercu.thumbnail((case - 4, case - 4))
        feuille.paste(apercu, (x + (case - apercu.width) // 2, y + case - 2 - apercu.height), apercu)
        dessin.text((x + 2, y + case), nom, fill=(255, 230, 120))
    feuille.save(chemin)


def main():
    if len(sys.argv) > 2:
        sys.exit(__doc__)
    correspondance = json.load(open(CORRESPONDANCE, encoding='utf-8'))
    liste = list(images(Image.open(os.path.join(RACINE, correspondance['planche'])), correspondance))
    atlas, positions = ranger(liste)
    atlas.save(os.path.join(SORTIE, 'atlas.png'), optimize=True)
    zones = {nom: list(positions[nom]) + taille for nom, _, taille in liste}
    script = [
        f'// Vue isométrique : planche redessinée, découpée par bin/construire-atlas-iso.py (zones dans bin/atlas-iso.json).',
        f'// IsoAtlas : nom -> [x, y, largeur, hauteur(, dx, dy pour les meubles)]. x, y sur atlas.png ; largeur et hauteur',
        f'// en pixels du plateau. Sur atlas.png, chaque image fait IsoEchelle fois sa taille sur le plateau.',
        f'var IsoEchelle = {correspondance["echelle"]};',
        f'var IsoAtlas = {json.dumps(zones, separators=(",", ":"))};',
        '// Sol de chaque zone des quêtes (MesZones) et des codes 0x30 à 0x3b (éboulis, escalier).',
        f'var IsoSols = {json.dumps(correspondance["sols_des_zones"], separators=(",", ":"))};',
        f'var IsoSolsSpeciaux = {json.dumps(correspondance["sols_speciaux"], separators=(",", ":"))};',
    ]
    with open(os.path.join(SORTIE, 'atlas.js'), 'w', encoding='utf-8', newline='\n') as fichier:
        fichier.write('\n'.join(script) + '\n')
    if len(sys.argv) == 2:
        controler(liste, sys.argv[1])
    print(f'{len(liste)} images, atlas.png {atlas.width} x {atlas.height}')


if __name__ == '__main__':
    main()
