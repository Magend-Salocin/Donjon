// Branche les routines réécrites à la place du code généré (quest.gen.js).
//
// La machine appelle une routine par son adresse d'origine. Une routine lisible fait tout son
// travail d'un coup, rend les registres que ses appelants lisent (son « contrat »), puis revient
// à l'appelant comme le ret d'origine. Les drapeaux du processeur ne sont pas rendus : aucun
// appelant de ces routines ne les lit.
//
// Chaque remplacement est vérifié contre la version générée par outils/lisible.mjs.
// Dans la page, ?genere garde le code généré seul (pour comparer).

import { Donnees } from './donnees.js';
import { Hasard } from './hasard.js';
import { Combat } from './combat.js';

const octetBas = (registre, valeur) => (registre & 0xff00) | (valeur & 0xff);

// adresse -> { nom, cout, sortie, executer(jeu, m) }
//   cout   : instructions comptées pour le temps du jeu (moyenne de la version générée)
//   sortie : registres rendus aux appelants, comparés par outils/lisible.mjs ('al' = octet bas seul)
export const ROUTINES_QUEST = {
  0x3613: {
    nom: 'hasard', cout: 17, sortie: ['ax'],
    // Entrée BL = max. Sortie AL = 1 à max, AH = AL - 1.
    executer({ hasard }, m) {
      const resultat = hasard.tirer(m.bx & 0xff);
      m.ax = ((resultat - 1) << 8) | resultat;
    },
  },
  0x6033: {
    nom: 'de6_moins_un', cout: 34, sortie: ['ax', 'bx', 'cx', 'dx', 'si', 'di', 'bp'],
    // Sortie BL = 0 à 5 ; les autres registres sont conservés.
    executer({ hasard }, m) { m.bx = octetBas(m.bx, hasard.de6()); },
  },
  0x21b7: {
    nom: 'de_combat', cout: 38, sortie: ['bx'],
    // Sortie BX = face (FACE dans combat.js).
    executer({ combat }, m) { m.bx = combat.lancerDe(); },
  },
  0x0b28: {
    nom: 'calcule_des_monstre', cout: 10, sortie: ['si', 'bx', 'ax'],
    // Sortie SI = cible, BX = 5 × type, AX = dés (attaque, défense).
    executer({ combat, donnees }, m) {
      combat.calculerDesMonstre();
      m.si = donnees.adresseCible;
      m.bx = (5 * donnees.cible.type) & 0xff;
      m.ax = (donnees.desDefenseMonstre << 8) | donnees.desAttaqueMonstre;
    },
  },
  0x0b44: {
    nom: 'bonus_attaque_heros', cout: 18, sortie: ['di', 'si'],
    // Sortie DI = fiche courante, SI = cible.
    executer({ combat, donnees }, m) {
      combat.appliquerBonusAttaque();
      m.di = donnees.adresseFicheCourante;
      m.si = donnees.adresseCible;
    },
  },
  0x0b8b: {
    nom: 'calcule_defense_heros', cout: 15, sortie: ['di', 'al'],
    // Sortie DI = fiche courante, AL = dés de défense.
    executer({ combat, donnees }, m) {
      combat.calculerDefenseHeros();
      m.di = donnees.adresseFicheCourante;
      m.ax = octetBas(m.ax, donnees.desDefenseHeros);
    },
  },
  0x214d: {
    nom: 'calcule_attaque_heros', cout: 20, sortie: ['di'],
    // Sortie DI = fiche courante, lue par portee_attaque qui suit.
    executer({ combat, donnees }, m) {
      combat.calculerAttaqueHeros();
      m.di = donnees.adresseFicheCourante;
    },
  },
};

// Remplace, dans la table des routines générées, l'entrée de chaque routine réécrite.
// Les adresses intérieures gardent le code généré : on n'y arrive jamais, la routine
// lisible s'exécutant d'un seul tenant.
export function brancherRoutines(table, routines = ROUTINES_QUEST) {
  let jeu = null;
  for (const [adresse, routine] of Object.entries(routines)) {
    table[Number(adresse)] = (m) => {
      if (!jeu || jeu.machine !== m) jeu = creerJeu(m);
      routine.executer(jeu, m);
      m.t += routine.cout;
      m.pas -= routine.cout;
      return m.pop();
    };
  }
  return table;
}

export function creerJeu(machine) {
  const donnees = new Donnees(machine);
  const hasard = new Hasard(donnees);
  return { machine, donnees, hasard, combat: new Combat(donnees, hasard) };
}
