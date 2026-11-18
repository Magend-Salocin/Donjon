// Combat de QUEST.EXE : dés de chaque camp, attaque d'un héros, attaque d'un monstre.
// Règles : original/notes/03-regles.md, « Attaque du héros » et « Monstres ».
//
// Déroulé d'une attaque, dans les deux sens :
//   1. chaque camp lance ses dés ; l'attaquant compte les crânes, le défenseur ses boucliers ;
//   2. les dés s'affichent : côté héros à gauche, côté monstre à droite ;
//   3. plus de crânes que de boucliers : le monstre meurt (il n'a pas de points de corps),
//      ou le héros perd la différence en points de corps ;
//   4. gros plan du combat, puis message.

import { Module, QUEST, MESSAGE } from './module.js';
import { BOUTON } from './messages.js';
import { TABLES, ARTEFACT, OBJET_QUETE, POTION, ARMURE, EFFET_SORT, IMAGE_MONSTRE, OCTET, definirVariables } from './donnees.js';

definirVariables({
  attaqueADistance: [0x3fb7, OCTET],      // 1 : arme lancée ou tirée
  desAttaqueHeros: [0x3fb8, OCTET],
  desDefenseHeros: [0x3fb9, OCTET],
  desAttaqueMonstre: [0x3fba, OCTET],
  desDefenseMonstre: [0x3fbb, OCTET],
  cranes: [0x3fd2, OCTET],                // crânes du dernier combat
  boucliers: [0x3fd3, OCTET],             // boucliers du dernier combat
  personnageAttaque: [0x3fbc, OCTET],     // numéro du personnage que le monstre attaque
  combatMonstreEnCours: [0x3fb6, OCTET],
  attaqueRepetee: [0x3fb3, OCTET],        // bit 1 : seconde attaque du poison d'orc déjà faite
  secondeAttaqueFaite: [0x0e0e, OCTET],   // 1 après la seconde attaque du poison d'orc (remis à 0 à chaque tour)
});

export const FACE = { crane: 0, bouclierBlanc: 1, bouclierNoir: 2 };

// Affichage des dés (affiche_des) : image du dé, et colonne de chaque camp (position à l'écran
// y × 320 + x de la première icône, puis décalage horizontal entre deux icônes).
const ICONE_DE = { crane: 0x6120, bouclier: 0x6220 };
const COLONNE = {
  heros: { position: 90 * 320 + 96, pas: -16 },
  monstre: { position: 90 * 320 + 200, pas: 16 },
};

// Type du Sorcier-Roi dans types_monstres : 11 ou 12 jusqu'à la quête 14 du code, 26 ensuite.
const QUETE_SORCIER_ROI_26 = 15;

export class Combat extends Module {
  // ---- Dés

  // Face d'un dé de combat (de_combat, 0x21B7) : 3 crânes, 2 boucliers blancs, 1 bouclier noir.
  lancerDe() {
    return this.donnees.octet(TABLES.facesDe + this.jeu.hasard.de6());
  }

  // Lance des dés et compte les crânes (compte_cranes, 0x5D8C).
  // Le compteur de dés est un octet décrémenté avant le test : 0 dé en lance 256.
  compterCranes(des) {
    let cranes = 0;
    for (let n = 0; n < (des || 256); n++) if (this.lancerDe() === FACE.crane) cranes++;
    return cranes & 0xff;
  }

  // Dés du monstre visé (calcule_des_monstre, 0x0B28), lus dans types_monstres.
  calculerDesMonstre() {
    const d = this.donnees;
    const type = TABLES.typesMonstres + ((5 * d.cible.type) & 0xff);   // calcul sur un octet, comme l'original
    d.desAttaqueMonstre = d.octet(type + 1);
    d.desDefenseMonstre = d.octet(type + 2);
  }

  // Dés d'attaque du héros courant (calcule_attaque_heros, 0x214D).
  calculerAttaqueHeros() {
    const d = this.donnees;
    const fiche = d.ficheCourante;
    d.desAttaqueHeros = fiche.desAttaque;

    // Une arme en main : la table des armes donne ses dés, ou 0 pour garder ceux de la fiche.
    // Les artefacts ne sont alors pas regardés.
    const arme = numeroBit(fiche.armeEnMain);
    if (arme !== null) {
      const des = d.octet(TABLES.desArmes + 6 - arme) & 3;
      if (des !== 0) d.desAttaqueHeros = des + 1;
      return;
    }
    if (fiche.porte('artefactsEnService', ARTEFACT.poisonOrc)) {
      d.attaqueADistance = 0;
      d.desAttaqueHeros = 2;
      return;
    }
    if (fiche.porte('artefactsEnService', ARTEFACT.lameEsprit)) {
      d.attaqueADistance = 0;
      const image = d.cible.image;
      const mortVivant = image === IMAGE_MONSTRE.squelette || image === IMAGE_MONSTRE.zombi || image === IMAGE_MONSTRE.momie;
      d.desAttaqueHeros = mortVivant ? 4 : 3;
    }
  }

  // Bonus du héros juste avant l'attaque (bonus_attaque_heros, 0x0B44).
  appliquerBonusAttaque() {
    const d = this.donnees;
    const fiche = d.ficheCourante;
    if (this.cibleEstSorcierRoi() && !fiche.porte('artefactsEnService', ARTEFACT.lameEsprit)) {
      d.desAttaqueHeros = 0;
      return;
    }
    let des = d.desAttaqueHeros;
    if (fiche.porte('potionsActives', POTION.force)) {
      des += 2;
      fiche.retire('potionsActives', POTION.force);
    }
    if (fiche.porte('effetsSorts', EFFET_SORT.courage)) {
      fiche.retire('effetsSorts', EFFET_SORT.courage);
      des += 2;
    }
    d.desAttaqueHeros = des;
  }

  // Dés de défense du héros attaqué (calcule_defense_heros, 0x0B8B).
  calculerDefenseHeros() {
    const d = this.donnees;
    const fiche = d.ficheCourante;
    if (fiche.porte('objetsQuete', OBJET_QUETE.orDeLaMine)) {
      d.desDefenseHeros = 0;
      return;
    }
    let des = fiche.desDefense;
    if (fiche.porte('artefactsEnService', ARTEFACT.armureBorin)) des = 4;
    else if (fiche.porte('armures', ARMURE.armureDePlates)) des = 4;
    else if (fiche.porte('armures', ARMURE.cotteDeMailles)) des = 3;
    if (fiche.porte('armures', ARMURE.bouclier)) des += 1;
    if (fiche.porte('armures', ARMURE.casque)) des += 1;
    if (fiche.porte('potionsActives', POTION.tenacite)) {
      des += 2;
      fiche.retire('potionsActives', POTION.tenacite);
      fiche.retire('potions', POTION.tenacite);
    }
    if (fiche.porte('effetsSorts', EFFET_SORT.peauDePierre)) {
      fiche.retire('effetsSorts', EFFET_SORT.peauDePierre);
      des += 2;
    }
    d.desDefenseHeros = des;
  }

  cibleEstSorcierRoi() {
    const type = this.donnees.cible.type;
    if (this.donnees.numeroQuete >= QUETE_SORCIER_ROI_26) return type === 26;
    return type === 11 || type === 12;
  }

  // ---- Attaque d'un héros (attaque_heros, 0x0936)
  // Atteinte par un saut depuis mode_attaque, quand le joueur a choisi un monstre à portée.
  // Se termine par un saut vers fin_action.

  *attaqueHeros() {
    const d = this.donnees;
    yield* this.appeler(QUEST.fin_deplacement);
    d.adresseAttaquant = d.adresseFicheCourante;

    for (;;) {
      yield* this.appeler(QUEST.charge_men);
      this.appliquerBonusAttaque();
      this.calculerDesMonstre();

      d.cranes = d.desAttaqueHeros ? this.compterCranes(d.desAttaqueHeros) : 0;
      d.boucliers = this.compterBoucliersMonstre(d.desDefenseMonstre);
      yield* this.afficherDes(d.boucliers, ICONE_DE.bouclier, COLONNE.monstre);
      yield* this.afficherDes(d.cranes, ICONE_DE.crane, COLONNE.heros);
      yield* this.appeler(QUEST.sauve_tampon);

      if (d.cranes > d.boucliers) d.cible.vivant = 0;
      yield* this.appeler(QUEST.animation_combat);
      yield* this.appeler(QUEST.sauve_tampon);
      if (d.cible.vivant === 0) yield* this.appeler(QUEST.retire_monstre, { si: d.adresseCible });

      this.calculerDesMonstre();
      yield* this.afficherMessage(d.cranes > d.boucliers ? MESSAGE.ennemiMort : MESSAGE.ennemiSurvecu);

      if (!this.secondeAttaquePossible()) break;
      yield* this.afficherMessage(MESSAGE.attaquerANouveau);
      if (d.choixMenu === BOUTON.non || d.choixMenu === BOUTON.boutonDroit) break;
      d.attaqueRepetee |= 1;
      d.secondeAttaqueFaite = 1;
    }

    d.ficheCourante.retire('potionsActives', POTION.heroique);
    yield* this.appeler(QUEST.pause_150);
    yield* this.appeler(QUEST.charge_maps);
    return this.sauter(QUEST.fin_action);
  }

  // Boucliers noirs du monstre. Le compteur de dés est un mot décrémenté avant le test (loop) :
  // 0 dé en lance 65 536.
  compterBoucliersMonstre(des) {
    let boucliers = 0;
    for (let n = 0; n < (des || 0x10000); n++) if (this.lancerDe() === FACE.bouclierNoir) boucliers++;
    return boucliers & 0xff;
  }

  // Poison d'orc : un orc qui survit peut être attaqué une seconde fois, une fois par tour.
  secondeAttaquePossible() {
    const d = this.donnees;
    return d.cible.image === IMAGE_MONSTRE.orc
      && d.cible.vivant !== 0
      && d.secondeAttaqueFaite === 0
      && d.ficheCourante.porte('artefactsEnService', ARTEFACT.poisonOrc)
      && (d.attaqueRepetee & 1) === 0;
  }

  // ---- Attaque d'un monstre (combat_monstre, 0x1D8F)
  // Le monstre visé (cible) frappe le héros adresseAttaquant, numéro personnageAttaque.

  *combatMonstre() {
    const d = this.donnees;
    d.combatMonstreEnCours = 1;
    const ficheCourante = d.adresseFicheCourante;
    const personnageCourant = d.mot(0x3fa7);       // le mot entier, comme le push d'origine
    d.personnageCourant = d.personnageAttaque;
    d.adresseFicheCourante = d.adresseAttaquant;

    yield* this.appeler(QUEST.charge_men);
    this.calculerDefenseHeros();
    this.calculerDesMonstre();
    yield* this.attaqueContreHeros();

    d.combatMonstreEnCours = 0;
    d.ecrireMot(0x3fa7, personnageCourant);
    d.adresseFicheCourante = ficheCourante;
    yield* this.appeler(QUEST.charge_maps);       // même code que la fin d'origine, recopié en ligne
  }

  // attaque_contre_heros (0x1E90). Le héros compte comme boucliers toutes les faces sauf le
  // bouclier blanc (4 faces sur 6, au lieu des boucliers blancs du jeu de plateau).
  *attaqueContreHeros() {
    const d = this.donnees;
    let boucliers = 0;
    for (let n = 0; n < d.desDefenseHeros; n++) if (this.lancerDe() !== FACE.bouclierBlanc) boucliers++;
    d.boucliers = boucliers & 0xff;
    d.cranes = this.compterCranes(d.desAttaqueMonstre);
    yield* this.afficherDes(d.cranes, ICONE_DE.crane, COLONNE.monstre);
    yield* this.afficherDes(d.boucliers, ICONE_DE.bouclier, COLONNE.heros);
    yield* this.appeler(QUEST.sauve_tampon);

    const heros = d.attaquant;
    d.herosCourant = heros.type;
    if (d.cranes > d.boucliers) {
      const blessures = d.cranes - d.boucliers;
      heros.pointsCorps = blessures >= heros.pointsCorps ? 0 : heros.pointsCorps - blessures;
    }
    yield* this.appeler(QUEST.animation_attaque_monstre);

    if (d.attaquant.pointsCorps === 0) {
      // Saut d'origine vers mort_heros, qui revient ensuite à combat_monstre : c'est un appel.
      yield* this.appeler(QUEST.mort_heros, { si: d.adresseAttaquant });
      return;
    }
    yield* this.afficherMessage(MESSAGE.vousAvezSurvecu);
  }

  // Affiche un résultat de dés (affiche_des, 0x0BE6) : au plus 7 icônes.
  *afficherDes(valeur, icone, colonne) {
    yield* this.appeler(QUEST.affiche_des, { al: valeur, bx: icone, bp: colonne.position, dx: colonne.pas });
  }
}

// Numéro du premier bit posé (0 à 6), ou null : la fiche n'a qu'une arme en main.
function numeroBit(octet) {
  for (let bit = 0; bit < 7; bit++) if (octet & (1 << bit)) return bit;
  return null;
}
