// Rend en WAV les morceaux du pilote AdLib relevés par son.py (original/donnees/son/morceauNN.json),
// avec l'émulateur opl2.mjs. Sortie : ../web/sons/morceauNN.wav, mono 16 bits à 22 050 Hz.
//   node sons.mjs
// Les morceaux muets (le n° 3, la porte, ne fait qu'arrêter une note) ne produisent pas de fichier.

import fs from 'node:fs';
import path from 'node:path';
import { fileURLToPath } from 'node:url';
import { Opl2, FREQUENCE } from './opl2.mjs';

const ici = path.dirname(fileURLToPath(import.meta.url));
const SOURCE = path.join(ici, '..', 'original', 'donnees', 'son');
const SORTIE = path.join(ici, '..', 'web', 'sons');
const FREQUENCE_WAV = 22050;
const TRAINE_MAX = 3;                 // secondes rendues après la dernière écriture, au plus
const VOLUME = 0.9;
const SEUIL_SILENCE = 16;            // sur 4 084, la sortie maximale d'un opérateur

function rendre({ hz, tics, ecritures }) {
  const opl = new Opl2();
  const parTic = FREQUENCE / hz;
  const total = Math.ceil((tics / hz + TRAINE_MAX) * FREQUENCE);
  const brut = new Float32Array(total);
  let k = 0;
  let n = 0;
  let fin = 0;
  for (let tic = 0; n < total; tic++) {
    for (; k < ecritures.length && ecritures[k][0] === tic; k++) opl.ecrire(ecritures[k][1], ecritures[k][2]);
    const limite = Math.min(total, Math.round((tic + 1) * parTic));
    for (; n < limite; n++) brut[n] = opl.echantillon();
    if (tic >= tics && opl.silencieuse()) break;
    fin = n;
  }
  // Fin : dernier échantillon audible (les effets laissent souvent la note enfoncée).
  while (fin > 0 && Math.abs(brut[fin - 1]) < SEUIL_SILENCE) fin--;
  return brut.subarray(0, fin);
}

// Rééchantillonnage par sinus cardinal fenêtré (passe-bas sous la nouvelle moitié de fréquence).
function reechantillonner(entree, de, vers) {
  const sortie = new Float32Array(Math.floor((entree.length * vers) / de));
  const coupure = (0.45 * vers) / de;
  const DEMI = 24;
  for (let j = 0; j < sortie.length; j++) {
    const centre = (j * de) / vers;
    const premier = Math.ceil(centre - DEMI / coupure / 2);
    let s = 0;
    for (let i = premier; i <= centre + DEMI / coupure / 2; i++) {
      if (i < 0 || i >= entree.length) continue;
      const x = i - centre;
      const fenetre = 0.5 + 0.5 * Math.cos((Math.PI * x * coupure * 2) / DEMI);
      const sinc = x === 0 ? 1 : Math.sin(2 * Math.PI * coupure * x) / (Math.PI * x);
      s += entree[i] * (x === 0 ? 2 * coupure : sinc) * fenetre;
    }
    sortie[j] = s;
  }
  return sortie;
}

function wav(echantillons, frequence) {
  const octets = Buffer.alloc(44 + echantillons.length * 2);
  octets.write('RIFF', 0); octets.writeUInt32LE(36 + echantillons.length * 2, 4); octets.write('WAVE', 8);
  octets.write('fmt ', 12); octets.writeUInt32LE(16, 16); octets.writeUInt16LE(1, 20); octets.writeUInt16LE(1, 22);
  octets.writeUInt32LE(frequence, 24); octets.writeUInt32LE(frequence * 2, 28); octets.writeUInt16LE(2, 32);
  octets.writeUInt16LE(16, 34); octets.write('data', 36); octets.writeUInt32LE(echantillons.length * 2, 40);
  for (let k = 0; k < echantillons.length; k++) {
    octets.writeInt16LE(Math.max(-32768, Math.min(32767, Math.round(echantillons[k] * VOLUME))), 44 + k * 2);
  }
  return octets;
}

fs.mkdirSync(SORTIE, { recursive: true });
for (const nom of fs.readdirSync(SOURCE).filter((f) => /^morceau\d+\.json$/.test(f)).sort()) {
  const brut = rendre(JSON.parse(fs.readFileSync(path.join(SOURCE, nom), 'utf8')));
  const crete = brut.reduce((m, v) => Math.max(m, Math.abs(v)), 0);
  if (crete === 0) { console.log(`${nom} : muet, pas de fichier`); continue; }
  const echantillons = reechantillonner(brut, FREQUENCE, FREQUENCE_WAV);
  const fichier = path.join(SORTIE, nom.replace('.json', '.wav'));
  fs.writeFileSync(fichier, wav(echantillons, FREQUENCE_WAV));
  console.log(`${nom} : ${(echantillons.length / FREQUENCE_WAV).toFixed(2)} s, crête ${crete}`);
}
