// Côté JavaScript du test différentiel (lancé par difference.py) : lit des cas en JSON sur
// l'entrée standard, exécute une seule instruction traduite par cas, écrit les résultats.

import fs from 'node:fs';
import { pathToFileURL } from 'node:url';
import { Machine } from '../web/jeu/machine.js';

const [fichierPasAPas, fichierImage, segmentCode = '0'] = process.argv.slice(2);
const { routines, CODE_REECRIT } = await import(pathToFileURL(fichierPasAPas).href);
const image = fs.readFileSync(fichierImage);
const cas = JSON.parse(fs.readFileSync(0, 'utf8'));
const L = 0x1000;
const REGISTRES = ['ax', 'bx', 'cx', 'dx', 'si', 'di', 'bp', 'sp', 'ds', 'es', 'ss'];
const DRAPEAUX = ['cf', 'pf', 'af', 'zf', 'sf', 'df', 'of'];

export function motif(a) {
  return (Math.imul(a, 2654435761) >>> 13) & 0xff;
}

const memoireDeBase = new Uint8Array(0x110000);
for (let a = 0; a < memoireDeBase.length; a++) memoireDeBase[a] = motif(a);
memoireDeBase.set(image, L * 16);

const m = new Machine({ fichiers: new Map(), routines, codeReecrit: CODE_REECRIT, journal: () => {} });
m.L = L;
m.cs = L + Number(segmentCode);                  // CS du programme (INTRO : L + 44Bh)
const resultats = [];
m.mem.set(memoireDeBase);
for (const c of cas) {
  for (const r of REGISTRES) m[r] = c[r];
  for (const d of DRAPEAUX) m[d] = c[d];
  m.if = 1;
  m.tf = 0;
  const ecritures = {};
  m.wb = function (seg, off, v) {
    const a = ((seg << 4) + off) & 0xfffff;
    ecritures[a] = v & 0xff;
    this.mem[a] = v;
  };
  let suivante;
  let erreur = null;
  try {
    m.pas = 1;
    suivante = m.table[c.ip] ? m.table[c.ip](m, c.ip) : null;
  } catch (e) {
    erreur = e.message;
  }
  const r = { ip: suivante, erreur, ecritures };
  for (const k of REGISTRES) r[k] = m[k];
  for (const d of DRAPEAUX) r[d] = m[d];
  resultats.push(r);
  for (const a of Object.keys(ecritures)) m.mem[a] = memoireDeBase[a];   // mémoire d'origine
}
process.stdout.write(JSON.stringify(resultats));
