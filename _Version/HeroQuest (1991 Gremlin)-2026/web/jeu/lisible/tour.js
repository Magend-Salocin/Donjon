// Tour d'un personnage dans QUEST.EXE : préparation, réveil, lancer de déplacement, puis la
// boucle qui lit les commandes et redessine le plateau jusqu'à la fin du tour.
// Règles : original/notes/03-regles.md, « Tour d'un personnage » et « Panneau d'icônes ».
//
// La partie (routine partie, 0x0246) appelle tourPersonnage pour les 5 fiches, dans l'ordre, puis
// fait jouer Morcar. Une fiche vide (+0 = 0) ne joue pas.
//
// Le tour :
//   1. remise à zéro : portes passées, dés de déplacement, attaque répétée, pas en file ;
//   2. tempête (+0x18 bit 4) : le personnage passe ce tour, sauf s'il est aussi endormi ;
//   3. endormi (+0x18 bit 2) : un dé ; sur un 6 il se réveille et joue, sinon son tour s'arrête ;
//   4. lancer des dés de déplacement (tirage_deplacement), puis la boucle : une image par passage.
//
// Un passage de la boucle : lire un clic (commandesTour), le bouton droit termine le tour, jouer
// un pas automatique, les événements et les pièges, animer et dessiner les sprites et les
// icônes, afficher l'image, les événements de quête, la fin de quête. Le tour s'arrête quand
// finDuTour est posé (icône fin du tour, mort, piège...).

import { Module, QUEST, MESSAGE } from './module.js';
import { ARTEFACT, EFFET_SORT, OCTET, MOT, definirVariables } from './donnees.js';

definirVariables({
  commandeType: [0x3193, OCTET],          // 0 souris, 1 clavier, 2 joystick : celle du joueur qui joue
  baguetteDeRappel: [0x402c, OCTET],      // 1 si le héros a la baguette de rappel (lue au début du tour)
  vueARefaire: [0x3f97, OCTET],           // posé quand le plateau change : la vue est redessinée
  adresseZonesActives: [0x4635, MOT],     // table des zones cliquables en cours (zones_panneau pendant un tour)
});

// Bits de commandes (lit_commandes).
const COMMANDE = { boutonGauche: 0x10, boutonDroit: 0x20, quitter: 0x40 };

// Une zone cliquable : x1, x2, y1, y2 (mots), puis la routine appelée ; 10 octets, fin = FFFFh.
const TAILLE_ZONE = 10;
const FIN_DES_ZONES = 0xffff;
const SPRITE_EN_MOUVEMENT = 2;            // premier octet d'un sprite pendant l'animation d'un pas

// Retour au menu (étiquette dans partie, 0x02CD) quand le joueur quitte la quête.
const QUITTE_LA_QUETE = 0x02cd;

export class Tour extends Module {
  // ---- tour_personnage (0x0349)
  // Entrée : AH type de commande, AL numéro du personnage (0 à 4), BX sa fiche, DX son sprite.

  *tourPersonnage(numero, adresseFiche, adresseSprite, commandeType) {
    const d = this.donnees;
    d.commandeType = commandeType;
    d.adresseSpriteCourant = adresseSprite;
    d.adresseFicheCourante = adresseFiche;
    d.caseApresPorte = 0xffff;
    d.caseAvantPorte = 0xffff;
    d.baguetteDeRappel = d.ficheCourante.porte('artefacts', ARTEFACT.baguetteRappel) ? 1 : 0;
    d.personnageCourant = numero;
    if (d.ficheCourante.present === 0) return;

    d.directionPas = 0xff;
    d.attaqueRepetee = 0;
    d.pasEnFile = 0;
    d.dernierePorte = 0;
    d.desDeplacement = 0;
    d.secondeAttaqueFaite = 0;
    yield* this.appeler(QUEST.icones_init);
    yield* this.appeler(QUEST.fond_vers_tampon);
    yield* this.appeler(QUEST.affiche_nom_portrait);
    yield* this.appeler(QUEST.redessine_vue);
    yield* this.appeler(QUEST.des_deplacement_tour);
    yield* this.appeler(QUEST.icones_actives);
    yield* this.appeler(QUEST.dessine_icones);

    const fiche = d.ficheCourante;
    if (fiche.porte('effetsSorts', EFFET_SORT.tempete)) {
      fiche.retire('effetsSorts', EFFET_SORT.tempete);
      if (!fiche.porte('effetsSorts', EFFET_SORT.endormi)) return;   // la tempête fait passer ce tour
    }
    if (fiche.porte('effetsSorts', EFFET_SORT.endormi)) {
      const reveille = yield* this.tenterReveil();
      if (!reveille) return;
    }

    yield* this.appeler(QUEST.icones_actives);
    yield* this.appeler(QUEST.dessine_icones);
    yield* this.appeler(QUEST.sauve_tampon);
    yield* this.appeler(QUEST.tirage_deplacement);
    yield* this.appeler(QUEST.icones_init);
    yield* this.appeler(QUEST.fleches_deplacement);
    yield* this.appeler(QUEST.dessine_icones_fiche);
    yield* this.appeler(QUEST.dessine_icones);
    yield* this.appeler(QUEST.sauve_tampon);

    for (;;) {
      yield* this.passageDeLaBoucle();
      if (d.finDuTour !== 0) return;
      // Le test d'origine compare l'octet entier à 0x40 (cmp), pas le seul bit 0x40 :
      // quitter n'est vu que si aucun autre bit de commande n'est posé.
      if (d.commandes === COMMANDE.quitter) return this.sauter(QUITTE_LA_QUETE);
    }
  }

  // Un héros endormi lance un dé comme pour son déplacement (tirage_deplacement avec 1 dé) :
  // sur un 6 il se réveille. Le nombre de dés du tour est gardé pendant ce lancer (le mot entier,
  // comme le push d'origine).
  *tenterReveil() {
    const d = this.donnees;
    yield* this.appeler(QUEST.sauve_tampon);
    const desDuTour = d.mot(0x3fc4);
    d.desDeplacement = 1;
    yield* this.appeler(QUEST.tirage_deplacement);
    d.ecrireMot(0x3fc4, desDuTour);
    if (d.deplacementRestant !== 6) return false;

    d.ficheCourante.retire('effetsSorts', EFFET_SORT.endormi);
    yield* this.afficherMessage(MESSAGE.reveilSommeilProfond);
    yield* this.appeler(QUEST.redessine_plateau);
    return true;
  }

  *passageDeLaBoucle() {
    const d = this.donnees;
    yield* this.appeler(QUEST.curseur_memorise);
    yield* this.appeler(QUEST.commandes_tour);
    d.directionPas = 0xff;
    if (d.commandes & COMMANDE.boutonDroit) yield* this.appeler(QUEST.fin_tour);
    yield* this.appeler(QUEST.pas_automatique);
    yield* this.appeler(QUEST.evenements_et_piege);
    yield* this.appeler(QUEST.ordre_trace_heros);
    yield* this.appeler(QUEST.ordonne_sprites);
    yield* this.appeler(QUEST.anime_sprites);
    yield* this.appeler(QUEST.dessine_icones);
    yield* this.appeler(QUEST.dessine_sprites);
    yield* this.appeler(QUEST.fleches_deplacement);
    yield* this.appeler(QUEST.icones_selon_situation);
    yield* this.appeler(QUEST.survol_icones);
    yield* this.appeler(QUEST.affiche_valeurs_fiche);
    yield* this.appeler(QUEST.curseur_dessine);
    if (d.finDuTour === 0) yield* this.appeler(QUEST.affiche_tampon);
    yield* this.appeler(QUEST.curseur_efface);
    yield* this.appeler(QUEST.restaure_tampon);
    yield* this.appeler(QUEST.evenements_quete);
    yield* this.appeler(QUEST.fin_quete);
    if (d.vueARefaire !== 0) yield* this.appeler(QUEST.redessine_vue);
  }

  // ---- commandes_tour (0x6413) et clic_tour (0x6441)
  // Rien pendant un piège ou des pas en file. Pendant un pas lancé à la flèche, on attend la fin
  // de son animation. Sinon, un clic gauche lance la routine de la zone cliquée.

  *commandesTour() {
    const d = this.donnees;
    if (d.piegeEnCours !== 0 || d.pasEnFile !== 0) return;
    this.machine.ax = (this.machine.ax & 0xff00) | d.pasEnCours;   // AL, comme l'original
    if (d.pasEnCours !== 0) {
      if (d.octet(d.adresseSpriteCourant) === SPRITE_EN_MOUVEMENT) return;
      if (d.directionPas !== 0xff) return;
      d.pasEnCours = 0;
    }
    return yield* this.clicTour();
  }

  // Clic gauche : attend le relâchement, puis la routine de la zone sous le curseur, par un saut,
  // avec DI = fiche courante et SI = sprite courant. Hors des zones : clic sur le plateau.
  *clicTour() {
    const d = this.donnees;
    if ((d.commandes & COMMANDE.boutonGauche) === 0) return;
    yield* this.appeler(QUEST.attend_clic);
    const zone = this.zoneSousLeCurseur();
    this.rendreZone(zone);
    if (zone.adresse === null) return this.sauter(QUEST.clic_plateau);
    const routine = d.mot(zone.adresse + 8);
    return this.sauter(routine, { bx: zone.adresse + 8, di: d.adresseFicheCourante, si: d.adresseSpriteCourant });
  }

  // ---- zone_panneau (0x64A7)
  // Cherche, dans la table des zones actives, la première zone qui contient le curseur.
  // Rend son adresse (null si aucune : l'adresse est alors celle de la fin de table) et son rang.

  zoneSousLeCurseur() {
    const d = this.donnees;
    const x = d.sourisX;
    const y = d.sourisY;
    let adresse = d.adresseZonesActives;
    let rang = 0;
    while (d.mot(adresse) !== FIN_DES_ZONES) {
      const dedans = x >= d.mot(adresse) && x <= d.mot(adresse + 2) && y >= d.mot(adresse + 4) && y <= d.mot(adresse + 6);
      if (dedans) return { adresse, fin: adresse, rang, trouvee: true };
      adresse += TAILLE_ZONE;
      rang++;
    }
    return { adresse: null, fin: adresse, rang, trouvee: false };
  }

  // Registres rendus par zone_panneau : SI la zone (ou la fin de table), AX son rang,
  // DX et BP la position du curseur, CF posé si une zone est trouvée.
  rendreZone(zone) {
    const m = this.machine;
    m.si = zone.fin;
    m.ax = zone.rang & 0xffff;
    m.dx = this.donnees.sourisX;
    m.bp = this.donnees.sourisY;
    m.cf = zone.trouvee ? 1 : 0;
  }

  // ---- fin_tour (0x0756)
  // Icône fin du tour, ou bouton droit. Sans effet pendant des pas en file ou un piège.
  // Une traversée de la roche lancée ce tour (+0x18 bit 0x80) devient active (bit 0x20).

  *finTour() {
    const d = this.donnees;
    if (d.pasEnFile !== 0 || d.piegeEnCours !== 0) return;
    const fiche = d.ficheCourante;
    fiche.retire('effetsSorts', EFFET_SORT.traverseeRoche);
    if (fiche.porte('effetsSorts', EFFET_SORT.traverseeRocheLancee)) {
      fiche.effetsSorts |= EFFET_SORT.traverseeRoche;
      fiche.retire('effetsSorts', EFFET_SORT.traverseeRocheLancee);
    }
    yield* this.appeler(QUEST.son_clic);
    d.finDuTour = 1;
  }
}
