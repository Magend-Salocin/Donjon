// Compare chaque routine réécrite (web/jeu/lisible/) à sa version générée (quest.gen.js).
//   node lisible.mjs [cas par routine, 2000 par défaut]
// Pour chaque cas : registres et variables du jeu tirés au hasard (fiches, monstres, graine...),
// puis la routine générée et la routine lisible partent du même état. On compare tout le segment
// de données, la pile et les registres de sortie déclarés (champ sortie de routines.js).
// Affiche aussi le nombre moyen d'instructions de la version générée (champ cout).

import { machine } from './essai.mjs';
import { ROUTINES_QUEST, brancherRoutines } from '../web/jeu/lisible/routines.js';

const CAS = Number(process.argv[2] || 2000);
const RETOUR = 0xfffe;                       // adresse de retour fictive : fin de la routine
const DS = 0x1000 + 0x97c;                   // segment de données relogé
const REGISTRES = ['ax', 'bx', 'cx', 'dx', 'si', 'di', 'bp'];

process.env.GENERE = '1';                    // la machine garde le code généré ; la version lisible est branchée ici
const m = await machine('QUEST');
const generee = m.table;
const lisible = brancherRoutines(generee.slice());
m.ds = m.es = DS;
m.ss = 0x8000;                               // pile hors du segment de données : ses restes ne comptent pas
m.journal = () => {};

let graine = 12345;
const alea = (n) => { graine = (Math.imul(graine, 1103515245) + 12345) >>> 0; return (graine >>> 8) % n; };

function preparerCas() {
  const base = DS * 16;
  for (let off = 0x3f80; off < 0x3fe0; off++) m.mem[base + off] = alea(256);
  for (let off = 0x4663; off < 0x4663 + 5 * 26; off++) m.mem[base + off] = alea(256);
  for (let off = 0x4d4a; off < 0x4d4a + 32 * 10; off++) m.mem[base + off] = alea(256);
  for (let off = 0x38fd; off < 0x3901; off++) m.mem[base + off] = alea(256);
  m.ww(DS, 0x4637, 0x4663 + 26 * alea(5));          // fiche du héros courant
  m.ww(DS, 0x3fd4, 0x4d4a + 10 * alea(32));         // monstre visé
  const cible = m.rw(DS, 0x3fd4);
  m.wb(DS, cible + 9, alea(28));                     // type de monstre connu
  m.wb(DS, 0x3f92, alea(24));                        // numéro de quête
  const etat = { sp: 0xf000 };
  for (const r of REGISTRES) etat[r] = alea(0x10000);
  etat.bx = (etat.bx & 0xff00) | (1 + alea(255));    // max de hasard : jamais 0
  return etat;
}

function executer(table, adresse, etat, memoire) {
  m.mem.set(memoire, DS * 16);
  for (const [r, v] of Object.entries(etat)) m[r] = v;
  m.push(RETOUR);
  const t = m.t;
  m.pas = 1e9;
  let ip = adresse;
  while (ip !== RETOUR) ip = table[ip](m, ip);
  const resultat = { duree: m.t - t, memoire: m.mem.slice(DS * 16, DS * 16 + 0x10000), sp: m.sp };
  for (const r of REGISTRES) resultat[r] = m[r];
  return resultat;
}

function lire(resultat, registre) {
  return registre === 'al' ? resultat.ax & 0xff : resultat[registre];
}

let echecs = 0;
for (const [adresse, routine] of Object.entries(ROUTINES_QUEST)) {
  let duree = 0;
  let ecarts = 0;
  let exemple = '';
  for (let k = 0; k < CAS; k++) {
    const etat = preparerCas();
    const memoire = m.mem.slice(DS * 16, DS * 16 + 0x10000);
    const a = executer(generee, Number(adresse), etat, memoire);
    const b = executer(lisible, Number(adresse), etat, memoire);
    duree += a.duree;
    const differences = [];
    for (const r of [...routine.sortie, 'sp']) if (lire(a, r) !== lire(b, r)) differences.push(`${r} ${lire(a, r).toString(16)} au lieu de ${lire(b, r).toString(16)}`);
    for (let off = 0; off < 0x10000; off++) {
      if (a.memoire[off] !== b.memoire[off]) { differences.push(`DS:${off.toString(16)} ${a.memoire[off]} au lieu de ${b.memoire[off]}`); break; }
    }
    if (differences.length) { ecarts++; exemple ||= differences.join(', '); }
  }
  echecs += ecarts;
  const moyenne = Math.round(duree / CAS);
  console.log(`${routine.nom.padEnd(24)} ${ecarts ? `${ecarts} écarts sur ${CAS} (attendu : ${exemple})` : `identique sur ${CAS} cas`} ; durée générée ${moyenne}${moyenne !== routine.cout ? ` (cout déclaré ${routine.cout})` : ''}`);
}
process.exit(echecs ? 1 : 0);
