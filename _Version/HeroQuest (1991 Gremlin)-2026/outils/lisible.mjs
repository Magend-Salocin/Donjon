// Compare chaque routine réécrite (web/jeu/lisible/) à sa version générée (quest.gen.js).
//   node lisible.mjs [cas par routine, 300 par défaut] [nom de routine...]
// Le jeu est d'abord mené jusqu'au plateau de la 1re quête (images chargées, segments réservés).
// Puis, pour chaque cas : registres et variables du jeu tirés au hasard (fiches, monstres,
// graine...), et la routine générée et la routine lisible partent du même état. On compare toute
// la mémoire (données, écran, images), sauf la pile, et les registres de sortie déclarés (champ
// sortie de routines.js). Les boîtes de message sont fermées par des clics simulés.
// Affiche aussi le nombre moyen d'instructions de la version générée.

import { machine, avancer } from './essai.mjs';
import { ROUTINES_QUEST, brancherRoutines } from '../web/jeu/lisible/routines.js';

const [casDemandes = '300', ...noms] = process.argv.slice(2);
const CAS = Number(casDemandes);
const RETOUR = 0xfffe;                       // adresse de retour fictive : fin de la routine
const DS = 0x1000 + 0x97c;                   // segment de données relogé
const PILE = 0x9000;                         // pile hors des données : ses restes ne comptent pas
const REGISTRES = ['ax', 'bx', 'cx', 'dx', 'si', 'di', 'bp'];
const LIMITE = 300e6;                        // instructions au plus par cas (100 s de jeu)
const CLIC_DROIT = 300000;
// TEMOIN=e0e : compte les cas où cet octet de DS change (pour vérifier qu'un chemin rare est couvert).
const TEMOIN = process.env.TEMOIN ? parseInt(process.env.TEMOIN, 16) : null;                   // le bouton droit change d'état toutes les 100 ms de jeu

process.env.GENERE = '1';                    // la machine garde le code généré ; la version lisible est branchée ici
const m = await machine('QUEST');
m.journal = () => {};
const clic = (x, y) => {
  m.souris.x = x * 2; m.souris.y = y;
  avancer(m, 0.2); m.souris.boutons = 1; avancer(m, 0.2); m.souris.boutons = 0; avancer(m, 0.3);
};
avancer(m, 5); clic(68, 128); avancer(m, 3); clic(160, 44); avancer(m, 4); clic(160, 180); avancer(m, 4);
const memoireDeDepart = m.mem.slice();
const machineDeDepart = { prochainHandle: m.prochainHandle, handles: new Map(m.handles), dac: m.dac.slice() };
const generee = m.table;
const lisible = brancherRoutines(generee.slice());

let graine = 12345;
const alea = (n) => { graine = (Math.imul(graine, 1103515245) + 12345) >>> 0; return (graine >>> 8) % n; };

function preparerCas() {
  const memoire = memoireDeDepart.slice();
  const base = DS * 16;
  const hasard = (debut, fin) => { for (let off = debut; off < fin; off++) memoire[base + off] = alea(256); };
  hasard(0x38fd, 0x3901);                            // graine
  hasard(0x3fb3, 0x3fbd);                            // dés, attaque répétée, personnage attaqué...
  for (let off = 0x3fb8; off < 0x3fbc; off++) memoire[base + off] = alea(5);   // dés : de 0 à 4, comme en jeu
  for (let n = 0; n < 5; n++) {
    hasard(0x4663 + 26 * n + 0x0d, 0x4663 + 26 * n + 0x19);   // objets, effets
    memoire[base + 0x4663 + 26 * n + 0x14] = 1 + alea(3);   // dés d'attaque et de défense de la fiche
    memoire[base + 0x4663 + 26 * n + 0x15] = 1 + alea(3);
  }
  const mot = (off, v) => { memoire[base + off] = v & 0xff; memoire[base + off + 1] = v >> 8; };
  const herosPresents = [0, 1, 2, 3].filter((n) => memoire[base + 0x4663 + 26 * n] !== 0);
  const heros = () => 0x4663 + 26 * herosPresents[alea(herosPresents.length)];
  mot(0x4637, heros());                              // fiche du héros courant
  mot(0x3fd6, heros());                              // héros attaquant ou attaqué
  memoire[base + 0x3fbc] = alea(4);                  // personnage attaqué
  const monstres = [];
  for (let n = 0; n < 32; n++) if (memoire[base + 0x4d4a + 10 * n] !== 0) monstres.push(0x4d4a + 10 * n);
  const cible = monstres.length ? monstres[alea(monstres.length)] : 0x4d4a;
  mot(0x3fd4, cible);                                // monstre visé
  memoire[base + 0x0e0e] = alea(2);
  memoire[base + cible + 7] = 1 + alea(255);         // vivant
  if (alea(2)) {                                     // orc, et poison d'orc en service : seconde attaque possible
    memoire[base + cible + 8] = 1;
    memoire[base + memoire[base + 0x4637] + (memoire[base + 0x4638] << 8) + 0x12] |= 8;
    memoire[base + 0x3fb3] &= 0xfe;
    memoire[base + 0x0e0e] = 0;
  }
  for (let n = 0; n < 5; n++) memoire[base + 0x4663 + 26 * n + 6] = 1 + alea(8);   // points de corps
  const etat = { sp: 0xf000 };
  for (const r of REGISTRES) etat[r] = alea(0x10000);
  etat.bx = (etat.bx & 0xff00) | (1 + alea(255));    // max de hasard : jamais 0
  etat.dx = (etat.dx & 0x00ff) | ((1 + alea(12)) << 8);  // dés de compte_cranes
  return { etat, memoire, clicGauche: alea(2) === 1 };
}

function executer(table, adresse, fin, { etat, memoire, clicGauche }) {
  m.mem.set(memoire);
  m.prochainHandle = machineDeDepart.prochainHandle;     // fichiers ouverts : même numéro dans les deux versions
  m.handles = new Map(machineDeDepart.handles);
  m.dac.set(machineDeDepart.dac);
  for (const [r, v] of Object.entries(etat)) m[r] = v;
  m.ds = m.es = DS;
  m.ss = PILE;
  m.lisibles = [];
  m.souris.boutons = 0;
  m.souris.x = 124 * 2;                               // bouton OUI de « VOULEZ-VOUS ATTAQUER A NOUVEAU? »
  m.souris.y = 100;
  m.push(RETOUR);
  const t = m.t;
  m.pas = 1e12;
  let ip = adresse;
  let erreur = null;
  try {
    // Cas pairs : clics droits seulement (OK, ou NON aux questions). Cas impairs : le curseur est
    // sur le bouton OUI des questions, et clics gauche et droit alternent.
    const boutons = clicGauche ? [1, 0, 2, 0] : [2, 0];
    let prochainClic = t + CLIC_DROIT;
    let phase = 0;
    while (ip !== RETOUR && ip !== fin) {
      if (m.t > t + LIMITE) { erreur = 'trop long'; break; }
      if (m.t > prochainClic) { m.souris.boutons = boutons[phase++ % boutons.length]; prochainClic += CLIC_DROIT; }
      const f = table[ip];
      if (!f) throw new Error(`IP ${ip.toString(16)} hors du code`);
      ip = f(m, ip);
    }
  } catch (e) {
    erreur = e.message;
  }
  const resultat = { duree: m.t - t, sp: m.sp, ip, erreur, memoire: m.mem.slice() };
  for (const r of REGISTRES) resultat[r] = m[r];
  return resultat;
}

const lire = (resultat, registre) => (registre === 'al' ? resultat.ax & 0xff : resultat[registre]);
const hex = (v) => v.toString(16);

let echecs = 0;
for (const [adresse, routine] of Object.entries(ROUTINES_QUEST)) {
  if (noms.length && !noms.includes(routine.nom)) continue;
  let duree = 0;
  let ecarts = 0;
  let erreurs = 0;
  let temoins = 0;
  let exemple = '';
  for (let k = 0; k < CAS; k++) {
    const cas = preparerCas();
    const a = executer(generee, Number(adresse), routine.fin, cas);
    const b = executer(lisible, Number(adresse), routine.fin, cas);
    if (a.erreur) erreurs++;
    if (TEMOIN !== null && a.memoire[DS * 16 + TEMOIN] !== cas.memoire[DS * 16 + TEMOIN]) temoins++;
    duree += a.duree;
    const differences = [];
    if (a.erreur !== b.erreur) differences.push(`erreur ${a.erreur} au lieu de ${b.erreur}`);
    if (a.ip !== b.ip) differences.push(`fin en ${hex(a.ip)} au lieu de ${hex(b.ip)}`);
    for (const r of [...routine.sortie, 'sp']) if (lire(a, r) !== lire(b, r)) differences.push(`${r} ${hex(lire(a, r))} au lieu de ${hex(lire(b, r))}`);
    for (let x = 0; x < a.memoire.length; x++) {
      if (x >= PILE * 16 && x < PILE * 16 + 0x10000) continue;
      if (a.memoire[x] !== b.memoire[x]) {
        const lieu = x >= DS * 16 && x < DS * 16 + 0x10000 ? `DS:${hex(x - DS * 16)}` : hex(x);
        differences.push(`${lieu} ${a.memoire[x]} au lieu de ${b.memoire[x]}`);
        break;
      }
    }
    if (differences.length) { ecarts++; exemple ||= `cas ${k} : ${differences.join(', ')}`; }
  }
  echecs += ecarts;
  const moyenne = Math.round(duree / CAS);
  const bilan = ecarts ? `${ecarts} écarts sur ${CAS} (attendu : ${exemple})` : `identique sur ${CAS} cas`;
  console.log(`${routine.nom.padEnd(24)} ${bilan}${erreurs ? `, dont ${erreurs} arrêts dans la version générée` : ''}${TEMOIN !== null ? `, témoin changé ${temoins} fois` : ''} ; durée générée ${moyenne}`);
}
process.exit(echecs ? 1 : 0);
