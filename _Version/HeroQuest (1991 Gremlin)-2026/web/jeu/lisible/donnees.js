// Vue lisible du segment de données de QUEST.EXE (DS = 0x97C, relogé au chargement).
// Les routines réécrites lisent et écrivent la même mémoire que le code d'origine :
// le reste du jeu, encore généré, voit donc exactement les mêmes valeurs.
// Adresses et sens des champs : original/symboles.txt et original/notes/03-regles.md.

export const OCTET = 1;
export const MOT = 2;

// Variables communes à plusieurs modules : nom lisible -> [offset dans DS, taille].
// Chaque module déclare les siennes avec definirVariables (voir combat.js).
const VARIABLES = {
  numeroQuete: [0x3f92, OCTET],        // 0 = Le labyrinthe ; le jeu compte à partir de 0
  adresseCible: [0x3fd4, MOT],         // enregistrement du monstre visé
  adresseFicheCourante: [0x4637, MOT], // fiche du héros qui joue
  adresseAttaquant: [0x3fd6, MOT],     // fiche du héros qui attaque, ou que le monstre attaque
  herosCourant: [0x3fca, OCTET],       // type (+0x19) du héros concerné par l'action
  personnageCourant: [0x3fa7, OCTET],  // numéro du personnage qui joue (0 à 4)
  choixMenu: [0xab7a, OCTET],          // bouton choisi dans une boîte de message (0, 1...), FEh = bouton droit
};

// Tables du jeu (offset dans DS).
export const TABLES = {
  fichesPersonnages: 0x4663,  // 5 fiches de 26 octets : 4 héros, puis Sir Ragnar
  monstres: 0x4d4a,           // 32 monstres de 10 octets
  grilleZones: 0x546f,        // 26 × 19 cases : zone de chaque case (bits 0-5), 0x40 vue, 0x80 bord vu
  grilleMurs: 0x566f,         // même grille : murs et portes (voir deplacement.js)
  grilleOccupants: 0x586f,    // même grille : monstre (1 à 32), éboulis, piège, escalier, meuble (0x30 et plus)
  facesDe: 0x47f9,            // 6 faces du dé de combat
  desArmes: 0x47ff,           // 7 armes : bits 0-1 = nombre de dés - 1 (0 : dés de la fiche)
  typesMonstres: 0x4806,      // 5 octets par type : déplacement, attaque, défense, routine de mort
};

export class Donnees {
  constructor(machine) {
    this.machine = machine;
  }

  octet(offset) { return this.machine.rb(this.machine.ds, offset & 0xffff); }
  ecrireOctet(offset, valeur) { this.machine.wb(this.machine.ds, offset & 0xffff, valeur & 0xff); }
  mot(offset) { return this.machine.rw(this.machine.ds, offset & 0xffff); }
  ecrireMot(offset, valeur) { this.machine.ww(this.machine.ds, offset & 0xffff, valeur & 0xffff); }

  get ficheCourante() { return new Fiche(this, this.adresseFicheCourante); }
  get cible() { return new Monstre(this, this.adresseCible); }
  get attaquant() { return new Fiche(this, this.adresseAttaquant); }
}

// Ajoute des variables nommées à Donnees (donnees.nom en lecture et en écriture).
export function definirVariables(variables) {
  for (const [nom, [offset, taille]] of Object.entries(variables)) {
    if (nom in Donnees.prototype) throw new Error(`variable ${nom} déjà définie`);
    Object.defineProperty(Donnees.prototype, nom, {
      get() { return taille === OCTET ? this.octet(offset) : this.mot(offset); },
      set(valeur) { if (taille === OCTET) this.ecrireOctet(offset, valeur); else this.ecrireMot(offset, valeur); },
    });
  }
}
definirVariables(VARIABLES);

// Champs d'un enregistrement : nom -> [décalage, taille].
function definirChamps(classe, champs) {
  for (const [nom, [decalage, taille]] of Object.entries(champs)) {
    Object.defineProperty(classe.prototype, nom, {
      get() {
        const a = this.adresse + decalage;
        return taille === OCTET ? this.donnees.octet(a) : this.donnees.mot(a);
      },
      set(valeur) {
        const a = this.adresse + decalage;
        if (taille === OCTET) this.donnees.ecrireOctet(a, valeur); else this.donnees.ecrireMot(a, valeur);
      },
    });
  }
}

class Enregistrement {
  constructor(donnees, adresse) {
    this.donnees = donnees;
    this.adresse = adresse;
  }
}

// Fiche d'un personnage (26 octets). Les champs « bits » se lisent avec les constantes ci-dessous.
export class Fiche extends Enregistrement {
  porte(champ, bit) { return (this[champ] & bit) !== 0; }
  retire(champ, bit) { this[champ] &= ~bit; }
}
definirChamps(Fiche, {
  present: [0x00, OCTET],
  x: [0x01, OCTET],
  y: [0x02, OCTET],
  zone: [0x03, OCTET],
  caseMurs: [0x04, MOT],       // adresse de sa case dans la grille des murs (DS:566F + y × 26 + x)
  pointsCorps: [0x06, OCTET],
  pointsEsprit: [0x07, OCTET],
  image: [0x08, OCTET],
  or: [0x09, MOT],
  artefacts: [0x0d, OCTET],
  equipement: [0x0e, OCTET],
  objetsQuete: [0x0f, OCTET],
  potions: [0x10, OCTET],
  armeEnMain: [0x11, OCTET],
  artefactsEnService: [0x12, OCTET],
  armures: [0x13, OCTET],
  desAttaque: [0x14, OCTET],
  desDefense: [0x15, OCTET],
  sortChoisi: [0x16, OCTET],
  potionsActives: [0x17, OCTET],
  effetsSorts: [0x18, OCTET],
  type: [0x19, OCTET],
});

// Bits des champs de la fiche.
export const ARTEFACT = { armureBorin: 0x01, baguetteRappel: 0x02, talismanSavoir: 0x04, poisonOrc: 0x08, lameEsprit: 0x10 };
// OBJET_QUETE.retireParTeleport : bit 0x10, effacé par un téléport du château (quête 10) ; son sens reste à confirmer.
export const OBJET_QUETE = { retireParTeleport: 0x10, orDeLaMine: 0x20, objetPorte: 0x40 };
export const POTION = { force: 0x01, tenacite: 0x02, eauBenite: 0x10, rapidite: 0x20, heroique: 0x40 };
export const ARMURE = { bouclier: 0x01, casque: 0x02, cotteDeMailles: 0x04, armureDePlates: 0x08 };
export const EFFET_SORT = { voileDeBrume: 0x01, endormi: 0x02, tempete: 0x04, ventRapide: 0x08, courage: 0x10, traverseeRoche: 0x20, peauDePierre: 0x40 };

// Monstre (10 octets).
export class Monstre extends Enregistrement {}
definirChamps(Monstre, {
  etat: [0x00, OCTET],      // bit 0x80 : pas encore vu
  x: [0x01, OCTET],
  y: [0x02, OCTET],
  zone: [0x03, OCTET],
  drapeaux: [0x06, OCTET],  // bit 1 réveillé, 2 passe son tour, 4 endormi
  vivant: [0x07, OCTET],    // 0 : tué
  image: [0x08, OCTET],     // image (sprite, nom, carte) : 4 squelette, 5 zombi, 6 momie...
  type: [0x09, OCTET],      // index de types_monstres
});

export const IMAGE_MONSTRE = { gobelin: 0, orc: 1, squelette: 4, zombi: 5, momie: 6 };
