// Dés de combat de QUEST.EXE : combien de dés lance chaque camp, et la face d'un dé.
// Règles : original/notes/03-regles.md, « Attaque du héros » et « Monstres ».

import { TABLES, ARTEFACT, OBJET_QUETE, POTION, ARMURE, EFFET_SORT, IMAGE_MONSTRE } from './donnees.js';

export const FACE = { crane: 0, bouclierBlanc: 1, bouclierNoir: 2 };

// Type du Sorcier-Roi dans types_monstres : 11 ou 12 jusqu'à la quête 14 du code, 26 ensuite.
const QUETE_SORCIER_ROI_26 = 15;

export class Combat {
  constructor(donnees, hasard) {
    this.donnees = donnees;
    this.hasard = hasard;
  }

  // Face d'un dé de combat (de_combat, 0x21B7) : 3 crânes, 2 boucliers blancs, 1 bouclier noir.
  lancerDe() {
    return this.donnees.octet(TABLES.facesDe + this.hasard.de6());
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
}

// Numéro du premier bit posé (0 à 6), ou null : la fiche n'a qu'une arme en main.
function numeroBit(octet) {
  for (let bit = 0; bit < 7; bit++) if (octet & (1 << bit)) return bit;
  return null;
}
