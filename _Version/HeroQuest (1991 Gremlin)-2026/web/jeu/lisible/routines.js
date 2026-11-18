// Branche les routines réécrites à la place du code généré (quest.gen.js).
//
// La machine appelle une routine par son adresse d'origine. Deux sortes de routines lisibles :
//
// - Routine d'un seul tenant : une méthode ordinaire, qui ne fait que calculer. Elle rend les
//   registres que ses appelants lisent (champ sortie), puis revient comme le ret d'origine.
//
// - Routine par étapes (etapes: true) : une méthode génératrice, qui appelle d'autres routines
//   d'origine et attend leur fin (yield). À chaque appel, on pose sur la pile du programme
//   l'adresse de retour RETOUR_LISIBLE ; quand la routine appelée y revient, la méthode reprend.
//   Une méthode qui se termine en renvoyant une adresse continue par un saut (jmp) vers elle.
//
// Les drapeaux du processeur ne sont pas rendus : les appelants de ces routines ne les lisent pas.
// Chaque remplacement est vérifié contre la version générée par outils/lisible.mjs.
// Dans la page, ?genere garde le code généré seul (pour comparer).

import { Donnees } from './donnees.js';
import { Hasard } from './hasard.js';
import { Combat } from './combat.js';

// Adresse de retour réservée : le segment de code de QUEST s'arrête à 0x97C0.
export const RETOUR_LISIBLE = 0xfff0;

const octetBas = (registre, valeur) => (registre & 0xff00) | (valeur & 0xff);

// adresse -> { nom, cout, sortie, etapes, fin, executer(jeu, m) }
//   cout   : instructions comptées pour le temps du jeu (moyenne de la version générée ;
//            pour une routine par étapes, à chaque reprise, hors routines appelées)
//   sortie : registres rendus aux appelants, comparés par outils/lisible.mjs ('al' = octet bas seul)
//   fin    : routine qui se termine par un saut : l'adresse où elle finit (pour la comparaison)
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
  0x5d8c: {
    nom: 'compte_cranes', cout: 130, sortie: ['al', 'dx'],
    // Entrée DH = nombre de dés. Sortie AL = DL = crânes, DH = 0.
    executer({ combat }, m) {
      const cranes = combat.compterCranes(m.dx >> 8);
      m.ax = octetBas(m.ax, cranes);
      m.dx = cranes;
    },
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
  0x0936: {
    nom: 'attaque_heros', cout: 10, sortie: [], etapes: true, fin: 0x12aa,
    executer: ({ combat }) => combat.attaqueHeros(),
  },
  0x1d8f: {
    nom: 'combat_monstre', cout: 10, sortie: [], etapes: true,
    executer: ({ combat }) => combat.combatMonstre(),
  },
  0x1e90: {
    nom: 'attaque_contre_heros', cout: 10, sortie: [], etapes: true,
    executer: ({ combat }) => combat.attaqueContreHeros(),
  },
};

// Remplace, dans la table des routines générées, l'entrée de chaque routine réécrite.
// Les adresses intérieures gardent le code généré : on n'y arrive jamais, la routine
// lisible remplaçant la routine entière.
export function brancherRoutines(table, routines = ROUTINES_QUEST) {
  let jeu = null;
  const jeuDe = (m) => {
    if (!jeu || jeu.machine !== m) jeu = creerJeu(m);
    return jeu;
  };
  table[RETOUR_LISIBLE] = (m) => reprendre(m);
  for (const [adresse, routine] of Object.entries(routines)) {
    table[Number(adresse)] = routine.etapes
      ? (m) => commencer(m, routine, routine.executer(jeuDe(m), m))
      : (m) => {
        routine.executer(jeuDe(m), m);
        compter(m, routine.cout);
        return m.pop();
      };
  }
  return table;
}

function compter(m, instructions) {
  m.t += instructions;
  m.pas -= instructions;
}

// m.lisibles : routines par étapes en cours, de la plus ancienne à la plus récente.
function commencer(m, routine, etapes) {
  m.lisibles ||= [];
  // Une routine dont la pile a été abandonnée (le programme est reparti plus haut sans revenir)
  // ne reprendra jamais : on l'oublie.
  while (m.lisibles.length && m.lisibles.at(-1).sp <= m.sp) m.lisibles.pop();
  m.lisibles.push({ routine, etapes, sp: m.sp });
  return reprendre(m);
}

function reprendre(m) {
  const enCours = m.lisibles.at(-1);
  compter(m, enCours.routine.cout);
  const { value: adresse, done } = enCours.etapes.next();
  if (!done) {
    m.push(RETOUR_LISIBLE);       // la routine appelée reviendra ici
    return adresse;
  }
  m.lisibles.pop();
  return adresse === undefined ? m.pop() : adresse;   // ret, ou saut final
}

export function creerJeu(machine) {
  const donnees = new Donnees(machine);
  const jeu = { machine, donnees, hasard: new Hasard(donnees) };
  jeu.combat = new Combat(jeu);
  return jeu;
}
