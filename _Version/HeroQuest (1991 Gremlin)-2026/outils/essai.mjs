// Fait tourner le portage sans navigateur et enregistre des captures d'écran.
//   node essai.mjs <secondes> <capture.png> [actions]
// actions : liste séparée par des virgules, exécutée dans l'ordre, par exemple
//   "attendre:3,clic:160:100,touche:39,attendre:2,capture:a.png"
// (souris en coordonnées d'écran 320 x 200 ; touche = code clavier en hexadécimal).

import fs from 'node:fs';
import path from 'node:path';
import zlib from 'node:zlib';
import { fileURLToPath } from 'node:url';
import { Machine, INSTRUCTIONS_PAR_MS } from '../web/jeu/machine.js';

const ici = path.dirname(fileURLToPath(import.meta.url));
const JEU = path.join(ici, '..', '..', 'HeroQuest (1991 Gremlin)');
// VGA, AdLib, souris, français, souris pour les 4 joueurs (comme la page)
export const CONFIGURATION = Uint8Array.from([8, 0, 1, 0, 1, 0, 0, 0, 0]);

export function fichiersDuJeu() {
  const fichiers = new Map();
  for (const nom of fs.readdirSync(JEU)) {
    if (/\.(md)$/i.test(nom)) continue;
    fichiers.set(nom.toUpperCase(), new Uint8Array(fs.readFileSync(path.join(JEU, nom))));
  }
  if (!fichiers.has('QUEST.CFG')) fichiers.set('QUEST.CFG', CONFIGURATION);
  return fichiers;
}

function png(rgba, largeur, hauteur) {
  const brut = Buffer.alloc((largeur * 4 + 1) * hauteur);
  for (let y = 0; y < hauteur; y++) {
    brut[y * (largeur * 4 + 1)] = 0;
    Buffer.from(rgba.buffer, rgba.byteOffset + y * largeur * 4, largeur * 4).copy(brut, y * (largeur * 4 + 1) + 1);
  }
  const morceau = (type, donnees) => {
    const t = Buffer.from(type);
    const longueur = Buffer.alloc(4);
    longueur.writeUInt32BE(donnees.length);
    const crc = Buffer.alloc(4);
    crc.writeUInt32BE(zlib.crc32(Buffer.concat([t, donnees])) >>> 0);
    return Buffer.concat([longueur, t, donnees, crc]);
  };
  const ihdr = Buffer.alloc(13);
  ihdr.writeUInt32BE(largeur, 0);
  ihdr.writeUInt32BE(hauteur, 4);
  ihdr[8] = 8; ihdr[9] = 6;
  return Buffer.concat([Buffer.from([0x89, 0x50, 0x4e, 0x47, 0x0d, 0x0a, 0x1a, 0x0a]),
    morceau('IHDR', ihdr), morceau('IDAT', zlib.deflateSync(brut)), morceau('IEND', Buffer.alloc(0))]);
}

export function capturer(m, fichier) {
  const rgba = new Uint8Array(320 * 200 * 4);
  m.peindre(rgba);
  fs.writeFileSync(fichier, png(rgba, 320, 200));
}

// PROGRAMME=INTRO pour l'intro (avec QUEST.CFG, comme dans la page : pas de questions).
export async function machine(programme = process.env.PROGRAMME || 'QUEST') {
  const { routines, CODE_REECRIT } = await import(`../web/jeu/${programme.toLowerCase()}.gen.js`);
  const fichiers = fichiersDuJeu();
  const m = new Machine({ fichiers, routines, codeReecrit: CODE_REECRIT });
  m.horloge = () => new Date(2026, 9, 27, 12, 0, 0, 0);    // même graine à chaque essai
  m.charger(`${programme}.EXE`);
  return m;
}

export function avancer(m, secondes) {
  const fin = m.t + secondes * 1000 * INSTRUCTIONS_PAR_MS;
  let immobile = 0;
  while (m.t < fin && m.arret === null) {
    const avant = m.t;
    m.executer(50000);
    if (m.t === avant && ++immobile > 50) break;           // bloqué (attente d'une touche BIOS)
  }
}

async function principal() {
  const [secondes = '5', capture = 'capture.png', actions = ''] = process.argv.slice(2);
  const m = await machine();
  avancer(m, Number(secondes));
  for (const action of actions.split(',').filter(Boolean)) {
    const [nom, ...reste] = action.split(':');
    const [a, b] = nom === 'capture' ? [reste.join(':')] : reste;
    if (nom === 'attendre') avancer(m, Number(a));
    else if (nom === 'clic') {
      m.souris.x = Number(a) * 2; m.souris.y = Number(b);
      avancer(m, 0.2); m.souris.boutons = 1; avancer(m, 0.2); m.souris.boutons = 0; avancer(m, 0.3);
    } else if (nom === 'souris') { m.souris.x = Number(a) * 2; m.souris.y = Number(b); avancer(m, 0.2); }
    else if (nom === 'touche') { const c = parseInt(a, 16); m.appuyer(c); avancer(m, 0.1); m.relacher(c); avancer(m, 0.3); }
    else if (nom === 'capture') capturer(m, a);
    else if (nom === 'car') { m.toucheBios(a.charCodeAt(0), parseInt(b || '0', 16)); avancer(m, 0.5); }   // car:X[:code] lu par int 16h
    else if (nom === 'espace') { m.toucheBios(0x20, 0x39); m.appuyer(0x39); avancer(m, 0.1); m.relacher(0x39); avancer(m, 0.5); }
  }
  if (m.fichiers.has('QUEST.CFG')) console.log('QUEST.CFG', Array.from(m.fichiers.get('QUEST.CFG')).join(' '));
  if (m.mode === 0x13 || m.planaire) capturer(m, capture);
  else console.log(m.texte());
  console.log(`t = ${(m.t / INSTRUCTIONS_PAR_MS / 1000).toFixed(1)} s, IP ${m.ip.toString(16)}, mode ${m.mode.toString(16)}, arrêt ${m.arret}`);
}

if (process.argv[1] && fileURLToPath(import.meta.url) === path.resolve(process.argv[1])) {
  principal().catch((e) => { console.error(e); process.exit(1); });
}
