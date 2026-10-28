// Émulateur de la puce AdLib (Yamaha YM3812, OPL2), sans dépendance, pour rendre en WAV les
// morceaux relevés par son.py. Il suit le fonctionnement décrit par le projet Nuked-OPL3
// (tables de log-sinus et d'exponentielle, générateur d'enveloppe au rythme du compteur de la
// puce, vibrato, trémolo, rétroaction, mode rythmique) ; c'est une réécriture, pas une copie.
// Un échantillon par cycle de la puce : 49 716 Hz (horloge 3,58 MHz / 72).

export const FREQUENCE = 49716;

const LOGSIN = Uint16Array.from({ length: 256 }, (_, i) => Math.round(-Math.log2(Math.sin(((i + 0.5) * Math.PI) / 512)) * 256));
const EXP = Uint16Array.from({ length: 256 }, (_, i) => Math.round(1024 * 2 ** ((255 - i) / 256)));
const MULT = [1, 2, 4, 6, 8, 10, 12, 14, 16, 16, 20, 20, 24, 24, 30, 30];        // x2 (0 = 1/2)
const KSL = [0x00, 0x20, 0x28, 0x2d, 0x30, 0x33, 0x35, 0x37, 0x38, 0x3a, 0x3b, 0x3c, 0x3d, 0x3e, 0x3f, 0x40];
const DECALAGE_KSL = [8, 1, 2, 0];
const PAS_ENVELOPPE = [[0, 0, 0, 0], [1, 0, 0, 0], [1, 0, 1, 0], [1, 1, 1, 0]];
// Position d'un opérateur dans les registres 20h-35h... -> numéro d'opérateur (0-17)
const OPERATEUR = [0, 1, 2, 3, 4, 5, -1, -1, 6, 7, 8, 9, 10, 11, -1, -1, 12, 13, 14, 15, 16, 17];
const CANAL_DE = [0, 1, 2, 0, 1, 2, 3, 4, 5, 3, 4, 5, 6, 7, 8, 6, 7, 8];
const MODULATEUR = [0, 1, 2, 6, 7, 8, 12, 13, 14];                                    // porteuse = +3
const ATTAQUE = 0, DECROISSANCE = 1, MAINTIEN = 2, RELACHEMENT = 3;

function exponentielle(niveau) {
  if (niveau > 0x1fff) niveau = 0x1fff;
  return (EXP[niveau & 0xff] << 1) >> (niveau >> 8);
}

// Onde 0 (sinus) ; les ondes 1-3 ne servent que si le bit WSE (registre 01h) est posé.
function sinus(phase, enveloppe, onde) {
  phase &= 0x3ff;
  let negatif = (phase & 0x200) !== 0;
  if (onde === 1 && negatif) return 0;
  if (onde === 2) negatif = false;
  if (onde === 3) { if (phase & 0x100) return 0; negatif = false; }
  const quart = phase & 0x100 ? LOGSIN[(phase & 0xff) ^ 0xff] : LOGSIN[phase & 0xff];
  const v = exponentielle(quart + (enveloppe << 3));
  return negatif ? -v - 1 : v;
}

class Operateur {
  constructor(numero) {
    this.numero = numero;
    this.am = 0; this.vib = 0; this.maintenu = 0; this.ksr = 0; this.mult = 0;
    this.ksl = 0; this.tl = 0; this.ar = 0; this.dr = 0; this.sl = 0; this.rr = 0; this.onde = 0;
    this.etat = RELACHEMENT; this.attenuation = 0x1ff; this.sortieEnveloppe = 0x1ff;
    this.cle = 0; this.phase = 0; this.phaseSortie = 0; this.remise = false;
    this.sortie = 0; this.precedente = 0; this.retroaction = 0; this.modulation = () => 0;
  }
}

export class Opl2 {
  constructor() {
    this.ops = Array.from({ length: 18 }, (_, k) => new Operateur(k));
    this.canaux = Array.from({ length: 9 }, (_, c) => ({
      numero: c, fnum: 0, bloc: 0, cle: 0, ksv: 0, retro: 0, additif: 0,
      mod: this.ops[MODULATEUR[c]], por: this.ops[MODULATEUR[c] + 3],
    }));
    this.wse = 0; this.nts = 0; this.rythme = 0; this.amProfond = 0; this.vibProfond = 0;
    this.compteur = 0; this.etatEnveloppe = 0; this.minuterieEnveloppe = 0; this.minuterieBas = 0; this.ajoutEnveloppe = 0;
    this.positionTremolo = 0; this.tremolo = 0; this.positionVibrato = 0;
    this.bruit = 1;
    this.hh2 = 0; this.hh3 = 0; this.hh7 = 0; this.hh8 = 0; this.tc3 = 0; this.tc5 = 0;
    for (const c of this.canaux) this.relier(c);
  }

  relier(c) {
    const mod = c.mod, por = c.por;
    mod.modulation = () => mod.retroaction;
    if (this.rythme && (c.numero === 7 || c.numero === 8)) {
      mod.modulation = () => 0;
      por.modulation = () => 0;
    } else if (c.additif || (this.rythme && c.numero === 6 && c.additif)) {
      por.modulation = () => 0;
    } else {
      por.modulation = () => mod.sortie;
    }
  }

  ecrire(registre, valeur) {
    registre &= 0xff;
    valeur &= 0xff;
    if (registre === 0x01) { this.wse = (valeur >> 5) & 1; return; }
    if (registre === 0x08) { this.nts = (valeur >> 6) & 1; return; }
    if (registre === 0xbd) {
      this.amProfond = valeur >> 7;
      this.vibProfond = (valeur >> 6) & 1;
      this.rythme = (valeur >> 5) & 1;
      // Touches de percussion : grosse caisse (canal 6), caisse claire 16, tom 14, cymbale 17, charleston 13
      const touche = (op, bit) => this.cleOperateur(this.ops[op], 2, this.rythme && (valeur >> bit) & 1);
      touche(12, 4); touche(15, 4); touche(16, 3); touche(14, 2); touche(17, 1); touche(13, 0);
      for (const c of this.canaux) this.relier(c);
      return;
    }
    const groupe = registre & 0xe0;
    if (groupe >= 0x20 && groupe !== 0xa0 && groupe !== 0xc0) {
      const k = OPERATEUR[registre & 0x1f];
      if (k === undefined || k < 0) return;
      const op = this.ops[k];
      if (groupe === 0x20) {
        op.am = valeur >> 7; op.vib = (valeur >> 6) & 1; op.maintenu = (valeur >> 5) & 1;
        op.ksr = (valeur >> 4) & 1; op.mult = valeur & 15;
      } else if (groupe === 0x40) { op.ksl = valeur >> 6; op.tl = valeur & 0x3f; }
      else if (groupe === 0x60) { op.ar = valeur >> 4; op.dr = valeur & 15; }
      else if (groupe === 0x80) { op.sl = (valeur >> 4) === 15 ? 0x1f : valeur >> 4; op.rr = valeur & 15; }
      else if (groupe === 0xe0) { op.onde = valeur & 3; }
      return;
    }
    const c = this.canaux[registre & 0x0f];
    if (!c) return;
    if (groupe === 0xa0 && (registre & 0xf0) === 0xa0) { c.fnum = (c.fnum & 0x300) | valeur; this.ksv(c); }
    else if ((registre & 0xf0) === 0xb0) {
      c.fnum = (c.fnum & 0xff) | ((valeur & 3) << 8);
      c.bloc = (valeur >> 2) & 7;
      this.ksv(c);
      const cle = (valeur >> 5) & 1;
      this.cleOperateur(c.mod, 1, cle);
      this.cleOperateur(c.por, 1, cle);
    } else if ((registre & 0xf0) === 0xc0) {
      c.retro = (valeur >> 1) & 7;
      c.additif = valeur & 1;
      this.relier(c);
    }
  }

  ksv(c) {
    c.ksv = (c.bloc << 1) | ((c.fnum >> (9 - this.nts)) & 1);
  }

  // Une touche (1 = registre B0h, 2 = percussion) ; l'opérateur sonne si l'une est enfoncée.
  cleOperateur(op, type, enfoncee) {
    op.cle = enfoncee ? op.cle | type : op.cle & ~type;
  }

  enveloppe(op, c) {
    op.sortieEnveloppe = Math.min(0x1ff, op.attenuation + (op.tl << 2) +
      (Math.max(0, (KSL[c.fnum >> 6] << 2) - ((8 - c.bloc) << 5)) >> DECALAGE_KSL[op.ksl]) +
      (op.am ? this.tremolo : 0));
    let remise = false;
    let vitesse;
    if (op.cle && op.etat === RELACHEMENT) { remise = true; vitesse = op.ar; }
    else vitesse = [op.ar, op.dr, op.maintenu ? 0 : op.rr, op.rr][op.etat];
    op.remise = remise;
    const ks = c.ksv >> ((op.ksr ^ 1) << 1);
    const taux = ks + (vitesse << 2);
    let haut = taux >> 2;
    const bas = taux & 3;
    if (haut & 0x10) haut = 0x0f;
    const decalageEnveloppe = haut + this.ajoutEnveloppe;
    let decalage = 0;
    if (vitesse) {
      if (haut < 12) {
        if (this.etatEnveloppe) {
          if (decalageEnveloppe === 12) decalage = 1;
          else if (decalageEnveloppe === 13) decalage = (bas >> 1) & 1;
          else if (decalageEnveloppe === 14) decalage = bas & 1;
        }
      } else {
        decalage = (haut & 3) + PAS_ENVELOPPE[bas][this.minuterieBas];
        if (decalage & 4) decalage = 3;
        if (!decalage) decalage = this.etatEnveloppe;
      }
    }
    let att = op.attenuation;
    let increment = 0;
    if (remise && haut === 0x0f) att = 0;
    const eteinte = (op.attenuation & 0x1f8) === 0x1f8;
    if (op.etat !== ATTAQUE && !remise && eteinte) att = 0x1ff;
    if (op.etat === ATTAQUE) {
      if (op.attenuation === 0) op.etat = DECROISSANCE;
      else if (op.cle && decalage > 0 && haut !== 0x0f) increment = (~op.attenuation) >> (4 - decalage);
    } else if (op.etat === DECROISSANCE) {
      if ((op.attenuation >> 4) === op.sl) op.etat = MAINTIEN;
      else if (!eteinte && !remise && decalage > 0) increment = 1 << (decalage - 1);
    } else if (!eteinte && !remise && decalage > 0) {
      increment = 1 << (decalage - 1);
    }
    op.attenuation = (att + increment) & 0x1ff;
    if (remise) op.etat = ATTAQUE;
    if (!op.cle) op.etat = RELACHEMENT;
  }

  phaseOperateur(op, c) {
    let fnum = c.fnum;
    if (op.vib) {
      let ecart = (fnum >> 7) & 7;
      const p = this.positionVibrato;
      if (!(p & 3)) ecart = 0;
      else if (p & 1) ecart >>= 1;
      ecart >>= this.vibProfond ? 0 : 1;
      if (p & 4) ecart = -ecart;
      fnum += ecart;
    }
    const base = (fnum << c.bloc) >> 1;
    let phase = (op.phase >>> 9) & 0x3ff;
    if (op.remise) op.phase = 0;
    op.phase = (op.phase + ((base * MULT[op.mult]) >> 1)) >>> 0;
    if (this.rythme) {
      if (op.numero === 13) {
        this.hh2 = (phase >> 2) & 1; this.hh3 = (phase >> 3) & 1; this.hh7 = (phase >> 7) & 1; this.hh8 = (phase >> 8) & 1;
      }
      if (op.numero === 17) { this.tc3 = (phase >> 3) & 1; this.tc5 = (phase >> 5) & 1; }
      const ou = (this.hh2 ^ this.hh7) | (this.hh3 ^ this.tc5) | (this.tc3 ^ this.tc5);
      if (op.numero === 13) phase = (ou << 9) | ((ou ^ (this.bruit & 1)) ? 0xd0 : 0x34);
      else if (op.numero === 16) phase = (this.hh8 << 9) | ((this.hh8 ^ (this.bruit & 1)) << 8);
      else if (op.numero === 17) phase = (ou << 9) | 0x80;
    }
    op.phaseSortie = phase;
  }

  // Un échantillon (entier signé, non borné).
  echantillon() {
    for (const c of this.canaux) {
      for (const op of [c.mod, c.por]) {
        if (op === c.mod) {
          op.retroaction = c.retro ? ((op.precedente + op.sortie) >> (9 - c.retro)) : 0;
          op.precedente = op.sortie;
        }
      }
    }
    for (let k = 0; k < 18; k++) {
      const op = this.ops[k];
      const c = this.canaux[CANAL_DE[k]];
      this.enveloppe(op, c);
      this.phaseOperateur(op, c);
      op.sortie = sinus(op.phaseSortie + op.modulation(), op.sortieEnveloppe, this.wse ? op.onde : 0);
    }
    let somme = 0;
    for (const c of this.canaux) {
      if (this.rythme && c.numero >= 6) {
        if (c.numero === 6) somme += 2 * c.por.sortie;
        else somme += 2 * (c.mod.sortie + c.por.sortie);
      } else {
        somme += c.additif ? c.mod.sortie + c.por.sortie : c.por.sortie;
      }
    }
    this.avancer();
    return somme;
  }

  // Compteurs de la puce : trémolo (3,7 Hz), vibrato (6,1 Hz), enveloppes, bruit.
  avancer() {
    if ((this.compteur & 0x3f) === 0x3f) this.positionTremolo = (this.positionTremolo + 1) % 210;
    const decalageTremolo = this.amProfond ? 2 : 4;
    this.tremolo = (this.positionTremolo < 105 ? this.positionTremolo : 210 - this.positionTremolo) >> decalageTremolo;
    if ((this.compteur & 0x3ff) === 0x3ff) this.positionVibrato = (this.positionVibrato + 1) & 7;
    this.compteur = (this.compteur + 1) & 0xffff;
    if (this.etatEnveloppe) {
      let n = 0;
      while (n < 13 && ((this.minuterieEnveloppe >> n) & 1) === 0) n++;
      this.ajoutEnveloppe = n > 12 ? 0 : n + 1;
      this.minuterieBas = this.minuterieEnveloppe & 3;
      this.minuterieEnveloppe = (this.minuterieEnveloppe + 1) % 0x1000000000;
    }
    this.etatEnveloppe ^= 1;
    const bit = ((this.bruit >> 14) ^ this.bruit) & 1;
    this.bruit = (this.bruit >> 1) | (bit << 22);
  }

  silencieuse() {
    return this.ops.every((op) => (op.attenuation & 0x1f8) === 0x1f8 && !op.cle);
  }
}
