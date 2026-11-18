// Déplacement des héros dans QUEST.EXE : dés de déplacement, pas d'une case, chemin automatique.
// Règles : original/notes/03-regles.md, « Déplacement » et « Tour d'un personnage ».
//
// Le plateau : trois grilles de 26 × 19 cases, rangées l'une après l'autre (case = y × 26 + x) :
//   - grilleZones : la zone (pièce ou couloir) de chaque case, bits 0-5 ; 0 = hors du plateau de jeu ;
//   - grilleMurs : murs et portes, sur le bord gauche et le bord haut de chaque case (voir MUR, PORTE) ;
//     le mur de droite d'une case est le mur gauche de sa voisine, et ainsi de suite ;
//   - grilleOccupants : ce qui occupe la case (OCCUPANT).
// Chaque fiche garde l'adresse de sa case dans la grille des murs (fiche.caseMurs).
//
// Un tour : le joueur lance les dés (tirageDeplacement), puis avance case par case avec les
// flèches (pas) ou en cliquant une case (clicPlateau, puis un pas automatique à chaque passage
// de la boucle du tour). Une action (attaque, fouille, sort) après avoir bougé arrête le
// déplacement (finDeplacement), sauf avec la potion héroïque.

import { Module, QUEST } from './module.js';
import { TABLES, Fiche, EFFET_SORT, ARMURE, OBJET_QUETE, POTION, OCTET, MOT, definirVariables } from './donnees.js';

definirVariables({
  finDuTour: [0x3f9a, OCTET],
  etatAction: [0x3f9b, OCTET],           // ETAT_ACTION
  deplacementRestant: [0x3f9c, OCTET],
  desDeplacement: [0x3fc4, OCTET],
  clignotement: [0x3f90, OCTET],         // compteur du clignotement du héros pendant le lancer
  imageDesCourante: [0x4b6f, OCTET],     // image de l'animation des dés (0 à 3)
  commandes: [0x3992, OCTET],            // bits de lit_commandes : 0x10 bouton gauche
  adresseSpriteCourant: [0x4639, MOT],
  sansFinDeDeplacement: [0x409f, OCTET], // non nul : fin_deplacement ne fait rien
  directionPas: [0x40cc, OCTET],         // 0 gauche, 1 droite, 2 haut, 3 bas ; FFh aucun
  orientationHeros: [0x409b, OCTET],     // image du héros après le pas
  porteFranchie: [0x3eb4, OCTET],
  caseApresPorte: [0x0e0f, MOT],
  caseAvantPorte: [0x0e11, MOT],
  dernierePorte: [0x3fce, MOT],          // case (grille des murs) de la dernière porte passée
  pasEnFile: [0x3fc8, OCTET],
  prochainPas: [0x3fcc, MOT],            // pointeur dans cheminTrouve
  pasEnCours: [0x3f98, OCTET],
  pasAnime: [0x0e57, OCTET],
  messageEnAttente: [0x3fea, MOT],
  piegeEnCours: [0x3fc2, OCTET],
  casePiege: [0x3fec, MOT],
  resultatVise: [0x3fa8, OCTET],
  coinZone: [0x3fe4, MOT],               // adresse (grille des zones) du coin de la fenêtre de vue
  sourisX: [0x47e9, MOT],
  sourisY: [0x47e7, MOT],
  distanceChemin: [0x37e9, OCTET],       // |dx| + |dy| vers la case cliquée (écrit seulement ; partage erreur_fichier)
  cheminDepartX: [0x3fee, OCTET],
  cheminDepartY: [0x3fef, OCTET],
  cheminCibleX: [0x3ff0, OCTET],
  cheminCibleY: [0x3ff1, OCTET],
  cheminDirection: [0x3ff2, OCTET],      // DIRECTION_CHEMIN
  cheminProfondeur: [0x3ff3, MOT],
  cheminCaseX: [0x3ff5, OCTET],
  cheminCaseY: [0x3ff6, OCTET],
  cheminLongueurMax: [0x3ff9, MOT],
});

// État de l'action du tour (etatAction).
export const ETAT_ACTION = { aBouge: 0x01, aAgi: 0x02, nePeutPlusBouger: 0x04, actionFaite: 0x08 };

const LARGEUR = 26;
const DE_LA_GRILLE_DES_MURS = { zones: -0x200, occupants: 0x200 };

// Octet de la grille des murs : bord gauche et bord haut de la case.
export const MUR = { gauche: 0x40, haut: 0x80 };
export const PORTE = { gauche: 0x10, haut: 0x20, ouverte: 0x04, secrete: 0x08 };

// Grille des occupants : 0 vide, 1 à 32 un monstre, 0x30-0x31 éboulis, 0x32-0x36 pièges cachés,
// jusqu'à 0x3F pièges connus et escaliers (traversables), 0x40 et plus des meubles.
export const OCCUPANT = { vide: 0, premierTraversable: 0x32, premierPiegeConnu: 0x37, premierMeuble: 0x40 };

// Les 4 pas. bordAvant n'est testé que pour un pas joué à la flèche (le pas automatique saute ce
// test et celui des personnages). Le mur et la porte sont sur la case du héros (gauche, haut) ou
// sur la case d'arrivée (droite, bas). orientation : image du héros après le pas.
const PAS = {
  gauche: { dx: -1, dy: 0, bordAvant: (f) => f.x === 0, bord: (f) => f.x === 0, mur: MUR.gauche, porte: PORTE.gauche, surArrivee: false, directionPas: 0, orientation: 2 },
  droite: { dx: 1, dy: 0, bordAvant: (f) => f.x === 25, bord: (f) => f.x === 25, mur: MUR.gauche, porte: PORTE.gauche, surArrivee: true, directionPas: 1, orientation: 1 },
  haut: { dx: 0, dy: -1, bordAvant: (f) => f.y === 0, bord: (f) => f.y === 0, mur: MUR.haut, porte: PORTE.haut, surArrivee: false, directionPas: 2, orientation: 3 },
  // Bas : le premier test regarde la rangée 19 (hors du plateau), le second la rangée 18.
  bas: { dx: 0, dy: 1, bordAvant: (f) => f.y === 19, bord: (f) => f.y === 18, mur: MUR.haut, porte: PORTE.haut, surArrivee: true, directionPas: 3, orientation: 0 },
};

// Directions du chemin automatique (cheminDirection, table deplacements).
export const DIRECTION_CHEMIN = ['haut', 'droite', 'bas', 'gauche'];

const QUETE_SANS_SON_DE_PORTE = 15;   // à partir de la quête 16 du jeu
const QUETE_CHATEAU = 9;              // 10e quête, CHATEAU DES MYSTERES
const QUETE_SALLES_FROIDES = 15;      // 16e quête, LES SALLES FROIDES
const ZONE_PIECE_TOURNANTE = 0x1f;
const TABLE_TELEPORTS_CHATEAU = 0x43b2;       // 4 octets : zone, x, y, porte
const TABLE_TELEPORTS_SALLES_FROIDES = 0x43de; // 5 octets : zone, x, y, porte (2 octets)
const TABLE_PIEGES = 0x45a6;                  // codes 0x32 à 0x36 : nouveau code de la case, piège
const TABLE_IMAGES_PAS = 0x3c20;              // image du sprite : 4 par personnage, une par orientation
const CHEMIN_PILE = 0x3ffb;
const CHEMIN_TROUVE = 0x4013;
const GRILLE_PROFONDEURS = 0x0a0e;            // 26 × 19 octets, sur le texte du briefing
const DISTANCES_CASES = 0x402d;               // 52 mots : distance du curseur à chaque case visible
const POSITION_CASES = 0x4119;                // 52 positions à l'écran (x, y), 4 octets
const ORDRE_CASES_VUE = 0x49d6;               // 45 décalages d'octet, puis 7 mots
const ORDRE_CASES_VUE_MOTS = 0x4a03;
const MONSTRE_1_DRAPEAUX = 0x4d5a;            // octet +6 du monstre 1

export class Deplacement extends Module {
  get ficheCourante() { return this.donnees.ficheCourante; }
  fiche(adresse) { return new Fiche(this.donnees, adresse); }

  // ---- Grilles du plateau

  case(x, y) { return y * LARGEUR + x; }
  murs(caseMurs) { return this.donnees.octet(caseMurs); }
  zoneDe(caseMurs) { return this.donnees.octet(caseMurs + DE_LA_GRILLE_DES_MURS.zones) & 0x3f; }
  occupantDe(caseMurs) { return this.donnees.octet(caseMurs + DE_LA_GRILLE_DES_MURS.occupants); }

  // Un personnage (une des 5 fiches présentes) est-il en (x, y) ? (personnage_en_dx, 0x1287)
  personnageEn(x, y) {
    for (let n = 0; n < 5; n++) {
      const f = this.fiche(TABLES.fichesPersonnages + 26 * n);
      if (f.present !== 0 && f.x === x && f.y === y) return true;
    }
    return false;
  }

  // ---- Dés de déplacement

  // Nombre de dés du tour (des_deplacement_tour, 0x68AE) ; remet aussi à zéro l'état du tour.
  // 2 dés ; 1 avec l'armure de plates ou un objet de quête porté, sauf pour Sir Ragnar ;
  // doublé par la potion de rapidité, puis par le vent rapide (effets consommés).
  // Le plafond de 6 n'est appliqué qu'après le vent rapide.
  calculerDesDeplacement() {
    const d = this.donnees;
    const fiche = this.ficheCourante;
    d.finDuTour = 0;
    d.etatAction = 0;
    d.desDeplacement = 2;
    const charge = fiche.porte('armures', ARMURE.armureDePlates) || fiche.porte('objetsQuete', OBJET_QUETE.objetPorte);
    if (charge && d.personnageCourant !== 4) d.desDeplacement -= 1;
    if (fiche.porte('potionsActives', POTION.rapidite)) {
      fiche.retire('potionsActives', POTION.rapidite);
      fiche.retire('potions', POTION.rapidite);
      d.desDeplacement <<= 1;
    }
    if (!fiche.porte('effetsSorts', EFFET_SORT.ventRapide)) return;
    fiche.retire('effetsSorts', EFFET_SORT.ventRapide);
    d.desDeplacement <<= 1;
    if (d.desDeplacement > 6) d.desDeplacement = 6;
  }

  // Somme des dés (lancer_deplacement, 0x672A), sur un octet. Le compteur est décrémenté avant
  // d'être testé : 0 dé en lance 65 536.
  // Renvoie le dernier dé tiré (AL de la routine hasard).
  lancerDes() {
    const d = this.donnees;
    d.deplacementRestant = 0;
    let de = 0;
    for (let n = 0; n < (d.desDeplacement || 0x10000); n++) {
      de = this.jeu.hasard.tirer(6);
      d.deplacementRestant += de;
    }
    return de;
  }

  // Lancer à l'écran (tirage_deplacement, 0x66F9) : le héros clignote et les dés tournent (un
  // nouveau tirage à chaque image) jusqu'à un clic ; puis l'animation des dés s'arrête sur
  // l'image 1. Au-delà de 24, le résultat est ramené à 5. Se termine par un saut vers restaure_tampon.
  *tirageDeplacement() {
    const d = this.donnees;
    const m = this.machine;
    d.clignotement = 0;
    d.imageDesCourante = 0;
    yield* this.appeler(QUEST.anime_sprites);
    yield* this.appeler(QUEST.attend_relache_boutons);
    yield* this.appeler(QUEST.ordre_trace_heros);
    yield* this.appeler(QUEST.ordonne_sprites);
    do {
      d.clignotement = (d.clignotement + 1) & 7;
      d.ecrireOctet(d.adresseSpriteCourant, d.clignotement >> 2);   // 0 visible, 1 éteint
      yield* this.appeler(QUEST.dessine_sprites, { bx: d.adresseSpriteCourant, al: d.clignotement >> 2 });
      const de = this.lancerDes();
      // Registres laissés par la boucle d'origine (dernier appel de hasard, compteur à 0).
      this.poserRegistres({ ax: ((de - 1) << 8) | de, cx: 0, bx: (m.bx & 0xff00) | 6 });
      yield* this.appeler(QUEST.image_des);
      yield* this.appeler(QUEST.restaure_tampon);
      yield* this.appeler(QUEST.lit_commandes);
    } while ((d.commandes & 0x10) === 0);
    d.ecrireOctet(d.adresseSpriteCourant, 1);
    yield* this.appeler(QUEST.dessine_sprites, { bx: d.adresseSpriteCourant });
    do yield* this.appeler(QUEST.image_des);
    while (d.imageDesCourante !== 1);
    yield* this.appeler(QUEST.attend_relache_boutons);
    if (d.deplacementRestant > 24) d.deplacementRestant = 5;
    for (let n = 0; n < 4; n++) yield* this.appeler(QUEST.attend_retour_vertical, { cx: 4 - n });
    return this.sauter(QUEST.restaure_tampon, { cx: 0 });
  }

  // ---- Fin du déplacement

  // Une action après avoir bougé arrête le déplacement (fin_deplacement, 0x6049), sauf avec la
  // potion héroïque, qui empêche aussi de marquer l'action comme faite.
  // Bogue de l'original : si le héros n'a pas bougé, la potion est lue dans la fiche pointée par
  // le registre DI de l'appelant, pas dans celle du héros courant. adresseFiche est ce DI.
  terminerDeplacement(adresseFiche) {
    const d = this.donnees;
    if (d.sansFinDeDeplacement !== 0) return adresseFiche;
    if (d.etatAction & ETAT_ACTION.aBouge) {
      adresseFiche = d.adresseFicheCourante;
      if (!this.fiche(adresseFiche).porte('potionsActives', POTION.heroique)) {
        d.etatAction |= ETAT_ACTION.nePeutPlusBouger;
        d.deplacementRestant = 0;
      }
    }
    d.etatAction |= ETAT_ACTION.aAgi;
    if (!this.fiche(adresseFiche).porte('potionsActives', POTION.heroique)) d.etatAction |= ETAT_ACTION.actionFaite;
    return adresseFiche;
  }

  // Un piège arrête le déplacement (arrete_deplacement, 0x26D7).
  arreterDeplacement() {
    this.donnees.etatAction |= ETAT_ACTION.aAgi;
    this.donnees.deplacementRestant = 0;
  }

  // ---- Flèches

  // État des 4 flèches du panneau (fleches_deplacement, 0x58F4) : allumée (0Bh) si le pas est
  // possible, grisée (1) sinon. Les tests sont ceux d'un pas, sans les autres héros, sans
  // case_apres_porte, et une porte fermée n'éteint pas la flèche (seule une porte secrète cachée).
  calculerFleches() {
    const d = this.donnees;
    const fiche = this.ficheCourante;
    let possibles = 0;
    if (d.deplacementRestant !== 0 && !(d.etatAction & ETAT_ACTION.nePeutPlusBouger)) {
      for (const [nom, bit] of [['haut', 2], ['droite', 8], ['gauche', 1], ['bas', 4]]) {
        if (this.flechePossible(fiche, PAS[nom])) possibles |= bit;
      }
    }
    // Icônes DS:42BF, 12 octets chacune : gauche, haut, bas, droite.
    for (let n = 0; n < 4; n++) {
      const icone = 0x42bf + 12 * n;
      d.ecrireOctet(icone + 7, 1);
      d.ecrireOctet(icone + 6, possibles & (1 << n) ? 0x0b : 1);
    }
  }

  flechePossible(fiche, sens) {
    if (sens.bord(fiche)) return false;
    const caseHeros = fiche.caseMurs;
    const arrivee = caseHeros + sens.dy * LARGEUR + sens.dx;
    const casePorte = sens.surArrivee ? arrivee : caseHeros;
    const murs = this.murs(casePorte);
    if (murs & sens.mur) {
      if (!fiche.porte('effetsSorts', EFFET_SORT.traverseeRoche)) return false;
      if (this.zoneDe(arrivee) === 0) return false;
    }
    if ((murs & sens.porte) && !(murs & PORTE.ouverte) && (murs & PORTE.secrete)) return false;
    const occupant = this.occupantDe(arrivee);
    return occupant === OCCUPANT.vide || (occupant >= OCCUPANT.premierTraversable && occupant < OCCUPANT.premierMeuble);
  }

  // ---- Un pas

  // Pas d'une case (pas_gauche 0x48A0, pas_droite 0x4968, pas_haut 0x4A2F, pas_bas 0x4AF7, puis
  // pas_fait 0x4BBF). adresseFiche (registre DI) : le héros ; adresseSprite (SI) : son sprite.
  // Renvoie l'adresse du saut final (vue_alignee, redessin_plateau) ou rien (refus).
  *pas(nomSens, adresseFiche, adresseSprite, automatique = false) {
    const d = this.donnees;
    const sens = PAS[nomSens];
    const fiche = this.fiche(adresseFiche);

    // Le pas automatique saute le premier test de bord et le test des personnages : il peut
    // traverser un autre héros.
    if (!automatique) {
      if (sens.bordAvant(fiche)) return this.refuserPas();
      if (this.personnageEn((fiche.x + sens.dx) & 0xff, (fiche.y + sens.dy) & 0xff)) return this.refuserPas();
    }
    if (d.etatAction & ETAT_ACTION.nePeutPlusBouger) return this.refuserPas();
    if (d.deplacementRestant === 0) return this.refuserPas();
    if (sens.bord(fiche)) return this.refuserPas();

    const caseHeros = fiche.caseMurs;
    const arrivee = (caseHeros + sens.dy * LARGEUR + sens.dx) & 0xffff;
    const casePorte = sens.surArrivee ? arrivee : caseHeros;
    if (this.murs(casePorte) & sens.mur) {
      // Traversée de la roche : on passe le mur, si la case d'arrivée est dans une zone.
      if (!fiche.porte('effetsSorts', EFFET_SORT.traverseeRoche)) return this.refuserPas();
      if (this.zoneDe(arrivee) === 0) return this.refuserPas();
    }

    let ouverture = 0;
    d.directionPas = sens.directionPas;
    if (this.murs(casePorte) & sens.porte) {
      // Après avoir franchi une porte, on ne repasse pas une porte depuis la case d'entrée.
      if (caseHeros === d.caseApresPorte) return this.refuserPas();
      d.porteFranchie = 1;                     // reste posé même si le pas est refusé ensuite
      if (!(this.murs(casePorte) & PORTE.ouverte)) {
        if (this.murs(casePorte) & PORTE.secrete) return this.refuserPas();
        if (d.numeroQuete < QUETE_SANS_SON_DE_PORTE) {
          this.porteReveilleMonstre();
          yield* this.appeler(QUEST.son_porte);
        }
        ouverture = PORTE.ouverte;
      }
      d.dernierePorte = casePorte;
    }

    const occupant = this.occupantDe(arrivee);
    if (occupant !== OCCUPANT.vide) {
      if (occupant < OCCUPANT.premierTraversable || occupant >= OCCUPANT.premierMeuble) return this.refuserPas();
      this.entrerPiege(occupant, arrivee + DE_LA_GRILLE_DES_MURS.occupants, (fiche.x + sens.dx) & 0xff, (fiche.y + sens.dy) & 0xff, fiche);
    }

    d.ecrireOctet(casePorte, this.murs(casePorte) | ouverture);
    fiche.x += sens.dx;
    fiche.y += sens.dy;
    return yield* this.pasFait(fiche, arrivee, sens.orientation, adresseSprite);
  }

  refuserPas() {
    this.donnees.pasEnFile = 0;
    this.donnees.directionPas = 0xff;
  }

  // Quêtes 5 et 16 (porte_reveille, 0x0790) : la porte en (5, 3-4) devait réveiller le monstre 1.
  // Bogue de l'original : x et y sont comparés d'un coup (mot = 5, donc y = 0), puis y doit valoir
  // 3 ou 4 : la condition n'est jamais vraie. Le test est fait avant le pas, sur la fiche courante.
  porteReveilleMonstre() {
    const d = this.donnees;
    if (d.numeroQuete !== 4 && d.numeroQuete !== 15) return;
    const fiche = this.ficheCourante;
    if (d.mot(fiche.adresse + 1) !== 5 || fiche.y < 3 || fiche.y >= 5) return;
    d.ecrireOctet(MONSTRE_1_DRAPEAUX, d.octet(MONSTRE_1_DRAPEAUX) | 1);
  }

  // Le héros entre sur une case de piège caché (entre_piege, 0x4DC7) : la case change de code et
  // le piège est mis en attente (piegeEnCours). Le déplacement automatique s'arrête.
  // case_piege reçoit la case que le héros quitte, pas celle du piège.
  entrerPiege(code, adresseOccupant, x, y, fiche) {
    const d = this.donnees;
    if (code >= OCCUPANT.premierPiegeConnu) return;
    if (!this.personnageEn(x, y)) {
      const piege = TABLE_PIEGES + 2 * ((code - 0x32) & 0xff);
      d.ecrireOctet(adresseOccupant, d.octet(piege));
      d.piegeEnCours = d.octet(piege + 1);
      d.casePiege = fiche.y * LARGEUR + fiche.x;
    }
    d.pasEnFile = 0;
    d.prochainPas = 0;
  }

  // Fin commune des 4 pas (pas_fait, 0x4BBF).
  *pasFait(fiche, arrivee, orientation, adresseSprite) {
    const d = this.donnees;
    if (d.porteFranchie === 1) {
      d.caseAvantPorte = fiche.caseMurs;
      d.caseApresPorte = arrivee;
      d.porteFranchie = 0;
    }
    fiche.caseMurs = arrivee;
    d.orientationHeros = orientation;
    d.etatAction |= ETAT_ACTION.aBouge;
    d.deplacementRestant -= 1;

    const zone = this.zoneDe(this.caseDeGrille(fiche.x, fiche.y) + TABLES.grilleMurs);
    if (zone === fiche.zone) {
      // Même zone : le sprite marche, la vue suit (vue_alignee).
      const rang = (d.personnageCourant * 4 + orientation) & 0xff;
      d.ecrireMot(adresseSprite + 0x0a, d.mot(TABLE_IMAGES_PAS + ((2 * rang) & 0xff)));
      d.ecrireOctet(adresseSprite, 2);
      d.pasEnCours = 2;
      d.pasAnime = 1;
      return this.sauter(QUEST.vue_alignee);
    }

    // Changement de zone : le plateau sera redessiné. fiche.zone est encore l'ancienne zone.
    if (d.numeroQuete >= QUETE_SALLES_FROIDES) {
      if (fiche.zone === ZONE_PIECE_TOURNANTE && d.numeroQuete === QUETE_SALLES_FROIDES) this.pieceTournante(fiche);
      return this.sauter(QUEST.redessin_plateau);
    }
    if (zone !== 0 || d.numeroQuete !== QUETE_CHATEAU) return this.sauter(QUEST.redessin_plateau);
    return yield* this.teleportChateau(fiche);
  }

  caseDeGrille(x, y) {
    return (this.donnees.mot(0x5ac5 + 2 * y) + x) & 0xffff;   // lignes_grille : y × 26
  }

  // Salles froides, en quittant la zone 31 : le héros est posé sur une des 6 positions de la
  // table, tirée au dé, sans personnage dessus.
  pieceTournante(fiche) {
    const d = this.donnees;
    d.ecrireMot(fiche.adresse + 1, 0);
    let position;
    do position = TABLE_TELEPORTS_SALLES_FROIDES + ((5 * this.jeu.hasard.de6()) & 0xff);
    while (this.personnageEn(d.octet(position + 1), d.octet(position + 2)));
    fiche.zone = d.octet(position);
    d.ecrireMot(fiche.adresse + 1, d.mot(position + 1));
    const caseMurs = (this.caseDeGrille(fiche.x, fiche.y) + TABLES.grilleMurs) & 0xffff;
    fiche.caseMurs = caseMurs;
    d.caseApresPorte = caseMurs;
    d.dernierePorte = d.mot(position + 3);
  }

  // Château des mystères (tire_teleport, 0x4DAA) : téléport tiré par deux dés (0-5 + 0-5), dans
  // une autre zone que celle du héros. Les 11 destinations ne sont pas équiprobables.
  tirerTeleport(fiche) {
    for (;;) {
      const de1 = this.jeu.hasard.de6();
      const de2 = this.jeu.hasard.de6();
      const teleport = TABLE_TELEPORTS_CHATEAU + ((4 * (de1 + de2)) & 0xff);
      if (this.donnees.octet(teleport) !== fiche.zone) return teleport;
    }
  }

  // Château : un pas hors du plateau téléporte le héros. Un monstre à l'arrivée est tué ; un
  // héros à l'arrivée perd un point de corps et est téléporté à son tour (avec un seul point, c'est
  // le héros qui arrive qui repart).
  *teleportChateau(fiche) {
    const d = this.donnees;
    for (;;) {
      const teleport = this.tirerTeleport(fiche);
      fiche.retire('objetsQuete', OBJET_QUETE.retireParTeleport);
      this.poserSurTeleport(fiche, teleport);
      d.dernierePorte = (fiche.caseMurs + d.octet(teleport + 3)) & 0xffff;
      d.messageEnAttente = 0;

      const monstre = this.monstreEn(fiche.x, fiche.y);
      if (monstre !== null) {
        d.messageEnAttente = 0xd4;   // VOUS AVEZ TUE UN ENNEMI EN VOUS TELEPORTANT SUR LUI
        yield* this.appeler(QUEST.retire_monstre, this.registresRecherche(monstre, fiche));
        return this.sauter(QUEST.redessin_plateau);
      }
      const autre = this.autreHerosEn(fiche);
      if (autre === null) return this.sauter(QUEST.redessin_plateau);
      if (autre.pointsCorps < 2) continue;

      d.messageEnAttente = 0xd6;
      autre.pointsCorps -= 1;
      let destination;
      do destination = this.tirerTeleport(autre);
      while (this.zoneDUnHeros(d.octet(destination)));
      this.poserSurTeleport(autre, destination);
      const monstreSousAutre = this.monstreEn(autre.x, autre.y);
      let zoneRevelee = autre.adresse;
      if (monstreSousAutre !== null) {
        yield* this.appeler(QUEST.retire_monstre, this.registresRecherche(monstreSousAutre, autre));
        zoneRevelee = this.machine.di;           // l'original relit la zone dans la fiche DI
      }
      this.revelerZone(d.octet(zoneRevelee + 3));
      return this.sauter(QUEST.redessin_plateau, { di: zoneRevelee });
    }
  }

  // Pose le héros sur un téléport (zone, x, y), ouvre la porte d'arrivée.
  poserSurTeleport(fiche, teleport) {
    const d = this.donnees;
    fiche.zone = d.octet(teleport);
    fiche.x = d.octet(teleport + 1);
    fiche.y = d.octet(teleport + 2);
    const caseMurs = (this.caseDeGrille(fiche.x, fiche.y) + TABLES.grilleMurs) & 0xffff;
    fiche.caseMurs = caseMurs;
    d.caseApresPorte = caseMurs;
    const porte = (caseMurs + d.octet(teleport + 3)) & 0xffff;
    d.ecrireOctet(porte, d.octet(porte) | PORTE.ouverte);
  }

  // Registres de la boucle d'origine quand elle trouve le monstre : SI le monstre, DI la fiche,
  // AL x et AH y, CX le compteur de la boucle.
  registresRecherche(monstre, fiche) {
    return { si: monstre, di: fiche.adresse, ax: (fiche.y << 8) | fiche.x, cx: 32 - (monstre - TABLES.monstres) / 10 };
  }

  monstreEn(x, y) {
    for (let n = 0; n < 32; n++) {
      const monstre = TABLES.monstres + 10 * n;
      if (this.donnees.octet(monstre) !== 0 && this.donnees.octet(monstre + 1) === x && this.donnees.octet(monstre + 2) === y) return monstre;
    }
    return null;
  }

  // Un des 4 héros (présent ou non) sur la case de fiche, autre que lui.
  autreHerosEn(fiche) {
    for (let n = 0; n < 4; n++) {
      const autre = this.fiche(TABLES.fichesPersonnages + 26 * n);
      if (autre.adresse !== fiche.adresse && autre.x === fiche.x && autre.y === fiche.y) return autre;
    }
    return null;
  }

  zoneDUnHeros(zone) {
    for (let n = 0; n < 4; n++) if (this.fiche(TABLES.fichesPersonnages + 26 * n).zone === zone) return true;
    return false;
  }

  // Toutes les cases de la zone deviennent vues, avec leurs bords.
  // La dernière case touche aussi le premier octet de la grille des murs.
  revelerZone(zone) {
    const d = this.donnees;
    for (let n = 0; n < 0x200; n++) {
      const a = TABLES.grilleZones + n;
      if ((d.octet(a) & 0x3f) === zone) {
        d.ecrireOctet(a, d.octet(a) | 0xc0);
        d.ecrireOctet(a + 1, d.octet(a + 1) | 0x40);
      }
    }
  }

  // ---- Chemin automatique

  // Pas suivant de la file (pas_automatique, 0x6784), quand le sprite a fini son pas précédent.
  *pasAutomatique() {
    const d = this.donnees;
    if (d.octet(d.adresseSpriteCourant) === 2) return undefined;
    if (d.pasEnFile === 0) return undefined;
    d.pasEnFile -= 1;
    const direction = d.octet(d.prochainPas);
    d.prochainPas += 1;
    const adresseFiche = d.adresseFicheCourante;
    const adresseSprite = d.adresseSpriteCourant;
    this.poserRegistres({ di: adresseFiche, si: adresseSprite });
    return yield* this.pas(DIRECTION_CHEMIN[direction], adresseFiche, adresseSprite, true);
  }

  // Clic sur le plateau (clic_plateau, 0x67B6) : la case visible la plus proche du curseur (à
  // moins de 8), si elle est libre, devient la cible du chemin.
  clicPlateau() {
    const d = this.donnees;
    // Distance du curseur à chacune des 52 cases visibles : (|dy| / 2 + |dx|) / 2.
    let meilleure = 0xffff;
    let compteur = 0;
    for (let n = 0; n < 52; n++) {
      const position = POSITION_CASES + 4 * n;
      const dy = Math.abs(((d.mot(position + 2) + 0x18) & 0xffff) - d.sourisY);
      const dx = Math.abs(((d.mot(position) + 8) & 0xffff) - d.sourisX);
      const distance = (((dy >> 1) + dx) & 0xffff) >> 1;
      d.ecrireMot(DISTANCES_CASES + 2 * n, distance);
      if (meilleure >= distance) { meilleure = distance; compteur = 52 - n; }   // à égalité, la dernière
    }
    if (meilleure >= 8) return;

    const rang = 52 - compteur;
    const decalage = rang >= 45 ? d.mot(ORDRE_CASES_VUE_MOTS + 2 * (rang - 45)) : d.octet(ORDRE_CASES_VUE + rang);
    const index = (d.coinZone + decalage - TABLES.grilleZones) & 0xffff;
    if (((index + TABLES.grilleMurs) & 0xffff) === d.caseAvantPorte) return;
    const x = index % LARGEUR;
    const y = Math.floor(index / LARGEUR) & 0xff;
    if ((d.octet(TABLES.grilleZones + index) & 0x3f) === 0) return;
    const occupant = d.octet(TABLES.grilleOccupants + index);
    if (occupant === OCCUPANT.premierTraversable || occupant >= OCCUPANT.premierMeuble) return;
    if (this.personnageEn(x & 0xff, y & 0xff)) return;

    const fiche = this.ficheCourante;
    d.cheminCibleX = x;
    d.cheminCibleY = y;
    d.cheminDepartX = d.cheminCaseX = fiche.x;
    d.cheminDepartY = d.cheminCaseY = fiche.y;
    this.chercherChemin();
    if (d.pasEnFile !== 0) d.prochainPas = CHEMIN_TROUVE;
  }

  // Plus court chemin (chemin_heros, 0x2DAC) de cheminDepart vers cheminCible en
  // deplacementRestant pas au plus. Recherche en profondeur dans les 4 directions (haut, droite,
  // bas, gauche), avec une grille des meilleures profondeurs atteintes (sur le texte du briefing).
  // Résultat : pasEnFile pas, directions dans DS:4013.
  chercherChemin() {
    const d = this.donnees;
    d.distanceChemin = absOctet(d.cheminDepartX - d.cheminCibleX) + absOctet(d.cheminDepartY - d.cheminCibleY);
    d.cheminLongueurMax = d.deplacementRestant;
    d.resultatVise = 0;
    d.pasEnFile = 0;
    d.cheminProfondeur = 0;
    d.prochainPas = 0;
    for (let n = 0; n < 0x200; n++) d.ecrireOctet(GRILLE_PROFONDEURS + n, 0x1a);
    this.adresseFicheChemin = d.adresseFicheCourante;
    this.essayerLesQuatreDirections();
    d.cheminProfondeur -= 1;
  }

  essayerLesQuatreDirections() {
    const d = this.donnees;
    d.cheminDirection = 0; d.cheminCaseY -= 1; this.essayerCase(); d.cheminCaseY += 1;
    d.cheminDirection = 1; d.cheminCaseX += 1; this.essayerCase(); d.cheminCaseX -= 1;
    d.cheminDirection = 2; d.cheminCaseY += 1; this.essayerCase(); d.cheminCaseY -= 1;
    d.cheminDirection = 3; d.cheminCaseX -= 1; this.essayerCase(); d.cheminCaseX += 1;
  }

  // Une case du chemin (chemin_essaie, 0x2DFF).
  essayerCase() {
    const d = this.donnees;
    const profondeur = d.cheminProfondeur;
    d.ecrireOctet(CHEMIN_PILE + profondeur, d.cheminDirection);
    const suivante = (profondeur + 1) & 0xffff;
    if (suivante > d.cheminLongueurMax) return;      // sans revenir d'un cran : voir chercherChemin
    d.cheminProfondeur = suivante;
    // Coupe : la cible doit rester à portée sur chaque axe (|dx| et |dy| testés séparément).
    const reste = (d.cheminLongueurMax - suivante) & 0xff;
    const permis = absOctet(d.cheminCibleX - d.cheminCaseX) <= reste
      && absOctet(d.cheminCibleY - d.cheminCaseY) <= reste
      && this.casePermise();
    if (permis !== false) {
      d.ecrireOctet(permis, suivante);
      if (d.cheminCaseX === d.cheminCibleX && d.cheminCaseY === d.cheminCibleY) {
        // Chemin trouvé : on le garde, et les suivants devront être plus courts.
        d.pasEnFile = suivante;
        for (let n = 0; n < (suivante & 0xff); n++) d.ecrireOctet(CHEMIN_TROUVE + n, d.octet(CHEMIN_PILE + n));
        d.cheminLongueurMax = suivante & 0xff;
      } else {
        this.essayerLesQuatreDirections();
      }
    }
    d.cheminProfondeur -= 1;
  }

  // La case cheminCase est-elle permise (pas_permis, 0x2EB7) ? Renvoie l'adresse de sa
  // profondeur dans la grille, ou false. Permise : dans le plateau, atteinte plus tôt que toute
  // fois précédente, différente de caseAvantPorte, dans une zone, vide ou de code 0x32 à 0x40,
  // sans mur (sauf traversée de la roche) ni porte secrète cachée du côté d'où l'on vient.
  casePermise() {
    const d = this.donnees;
    const x = d.cheminCaseX;
    const y = d.cheminCaseY;
    if (y >= 19 || x >= LARGEUR) return false;
    const index = y * LARGEUR + x;
    const adresseProfondeur = GRILLE_PROFONDEURS + index;
    if ((d.cheminProfondeur & 0xff) >= d.octet(adresseProfondeur)) return false;
    const caseMurs = TABLES.grilleMurs + index;
    if (caseMurs === d.caseAvantPorte) return false;
    if (this.zoneDe(caseMurs) === 0) return false;
    const occupant = this.occupantDe(caseMurs);
    if (occupant !== OCCUPANT.vide && (occupant < OCCUPANT.premierTraversable || occupant > OCCUPANT.premierMeuble)) return false;

    // Mur et porte entre la case d'où l'on vient et celle-ci (table murs_pas).
    const traversee = this.fiche(this.adresseFicheChemin).porte('effetsSorts', EFFET_SORT.traverseeRoche);
    const [murs, mur, porte] = [
      [this.murs(caseMurs + LARGEUR), MUR.haut, PORTE.haut],   // vers le haut : bord haut de la case quittée
      [this.murs(caseMurs), MUR.gauche, PORTE.gauche],         // vers la droite : bord gauche de celle-ci
      [this.murs(caseMurs), MUR.haut, PORTE.haut],             // vers le bas : bord haut de celle-ci
      [this.murs(caseMurs + 1), MUR.gauche, PORTE.gauche],     // vers la gauche : bord gauche de la case quittée
    ][d.cheminDirection];
    if ((murs & mur) && !traversee) return false;
    if ((murs & porte) && (murs & PORTE.secrete) && !(murs & PORTE.ouverte)) return false;
    return adresseProfondeur;
  }
}

// Valeur absolue d'une différence sur un octet signé, comme sub puis neg.
function absOctet(difference) {
  const v = difference & 0xff;
  return v & 0x80 ? (-v) & 0xff : v;
}
