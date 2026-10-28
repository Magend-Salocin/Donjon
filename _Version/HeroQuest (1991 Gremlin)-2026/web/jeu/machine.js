// Machine qui fait tourner le code traduit (quest.gen.js) : registres et drapeaux du 8086,
// mémoire de 1 Mo, pile, et l'environnement que le jeu attend (DOS, BIOS, VGA, souris,
// clavier, pilote de son). Un seul affichage : le VGA 13h, plus le mode texte de DOS.
// Le temps est compté en instructions : 3000 par milliseconde, le réglage de DOSBox-X
// (outils/dosbox-x.conf), pour que les attentes du jeu durent pareil.

import { decompresser } from './exepack.js';

export const INSTRUCTIONS_PAR_MS = 3000;
const IMAGE_PAR_SECONDE = 70;
const SEGMENT_CHARGEMENT = 0x1000;
const FIN_MEMOIRE = 0xa000;
const SEGMENT_BIOS = 0xf000;                     // vecteurs d'origine rendus par int 21h AH=35h

const PARITE = new Uint8Array(256).map((_, v) => {
  let n = 0;
  for (let b = v; b; b >>= 1) n += b & 1;
  return n % 2 === 0 ? 1 : 0;
});

export class Machine {
  constructor({ fichiers, routines, codeReecrit = [], journal = console.log }) {
    this.fichiers = fichiers;         // nom en majuscules -> Uint8Array ; sauver(nom, octets) optionnel
    this.table = routines();
    this.journal = journal;
    this.mem = new Uint8Array(0x110000);
    this.ax = this.bx = this.cx = this.dx = this.si = this.di = this.bp = this.sp = 0;
    this.cs = this.ds = this.es = this.ss = 0;
    this.cf = this.pf = this.af = this.zf = this.sf = this.tf = this.of = this.df = 0;
    this.if = 1;
    this.ip = 0;
    this.t = 0;                       // instructions exécutées depuis le lancement
    this.pas = 0;                     // instructions restant à exécuter avant de rendre la main
    this.arret = null;                // code de sortie quand le programme se termine
    this.vecteurs = new Map();        // interruptions détournées par le programme : n -> [seg, off]
    this.handles = new Map();
    this.prochainHandle = 5;
    this.horloge = () => new Date();
    // Matériel
    this.mode = 3;
    this.curseur = { x: 0, y: 0 };
    this.zoneBios();
    this.dac = new Uint8Array(768);
    this.dacEcriture = 0;
    this.dacLecture = 0;
    this.dacComposante = 0;
    this.port60 = 0;
    this.port61 = 0;
    this.touchesEnAttente = [];       // codes clavier (bit 7 = relâchement) à livrer par l'IRQ 1
    this.tamponBios = [];             // touches pour int 16h
    this.souris = { x: 320, y: 100, boutons: 0 };
    this.son = null;                  // { jouer(morceau, poignee), arreter(poignee), silence() }, posé par la page
    this.sonDonnees = false;
    this.poigneeSon = 0;
    this.signale = new Set();
    this.codeReecrit = new Set(codeReecrit);
  }

  // ---- Chargement d'un programme comme DOS (PSP, relocations, registres de départ)

  charger(nom, ligne = '') {
    const exe = decompresser(this.lireFichier(nom));
    const L = SEGMENT_CHARGEMENT;
    const psp = L - 0x10;
    this.L = L;
    this.mem.set(exe.image, L * 16);
    for (const p of exe.relocations) {
      const a = L * 16 + p;
      const v = (this.mem[a] | (this.mem[a + 1] << 8)) + L;
      this.mem[a] = v & 0xff;
      this.mem[a + 1] = (v >> 8) & 0xff;
    }
    const base = psp * 16;
    this.mem.fill(0, base, base + 256);
    this.mem[base] = 0xcd;
    this.mem[base + 1] = 0x20;
    this.mem[base + 2] = FIN_MEMOIRE & 0xff;
    this.mem[base + 3] = FIN_MEMOIRE >> 8;
    this.mem[base + 0x80] = ligne.length;
    for (let k = 0; k < ligne.length; k++) this.mem[base + 0x81 + k] = ligne.charCodeAt(k);
    this.mem[base + 0x81 + ligne.length] = 0x0d;
    this.psp = psp;
    this.memoireLibre = FIN_MEMOIRE;   // tout appartient au programme jusqu'à int 21h AH=4Ah
    this.cs = L + exe.cs;
    this.ip = exe.ip;
    this.ss = L + exe.ss;
    this.sp = exe.sp;
    this.ds = this.es = psp;
    this.ax = this.bx = this.cx = this.dx = this.si = this.di = this.bp = 0;
    if (this.mode !== 0x13) this.effacerTexte();
  }

  // Zone de données du BIOS (segment 40h), lue directement par les programmes.
  zoneBios() {
    const ecrire16 = (off, v) => { this.mem[0x400 + off] = v & 0xff; this.mem[0x401 + off] = v >> 8; };
    ecrire16(0x10, 0x0021);                          // équipement : coprocesseur absent, couleur 80 colonnes
    ecrire16(0x13, 640);                             // Ko de mémoire conventionnelle
    this.mem[0x449] = this.mode;
    ecrire16(0x4a, 80);
    ecrire16(0x63, 0x3d4);                           // port du CRTC couleur
  }

  // ---- Exécution

  // Exécute environ n instructions ; le dépassement (une copie rep peut en compter des milliers)
  // est retiré du budget suivant, pour que le temps du jeu suive le temps réel.
  executer(n) {
    this.pas = Math.min(this.pas, 0) + n;
    const tics = Math.floor(this.t / (INSTRUCTIONS_PAR_MS * 1000 / 18.2065)) >>> 0;
    this.mem[0x46c] = tics & 0xff; this.mem[0x46d] = (tics >> 8) & 0xff;
    this.mem[0x46e] = (tics >> 16) & 0xff; this.mem[0x46f] = tics >>> 24;
    let ip = this.ip;
    while (this.pas > 0 && this.arret === null) {
      if (this.if && this.touchesEnAttente.length) ip = this.irqClavier(ip);
      const f = this.table[ip];
      if (!f) {
        this.ip = ip;
        throw new Error(`IP ${ip.toString(16)} hors du code traduit`);
      }
      ip = f(this, ip);
    }
    this.ip = ip;
  }

  // IRQ 1 : le gestionnaire du programme s'il en a installé un ; sinon celui du BIOS, dont
  // le tampon est rempli directement par la page (toucheBios).
  irqClavier(ip) {
    this.port60 = this.touchesEnAttente.shift();
    const vecteur = this.vecteurs.get(9);
    if (!vecteur || vecteur[0] === SEGMENT_BIOS) return ip;
    this.push(this.drapeaux());
    this.push(this.cs);
    this.push(ip);
    this.if = 0;
    const [seg, off] = this.vecteurs.get(9);
    this.cs = seg;
    return off;
  }

  // ---- Mémoire et pile

  // Un mot à l'offset FFFFh déborde sur l'adresse linéaire suivante, comme dans DOSBox.
  rb(seg, off) { return this.mem[((seg << 4) + off) & 0xfffff]; }
  rw(seg, off) { return this.rb(seg, off) | (this.rb(seg + (off === 0xffff ? 0x1000 : 0), (off + 1) & 0xffff) << 8); }
  wb(seg, off, v) {
    const a = ((seg << 4) + off) & 0xfffff;
    if (seg === this.cs && this.L !== undefined && this.table[off] && !this.codeReecrit.has(off)) {
      this.signaler(`ecriture-code-${off}`, `écriture dans le code traduit en ${off.toString(16)}`);
    }
    this.mem[a] = v;
  }
  ww(seg, off, v) { this.wb(seg, off, v & 0xff); this.wb(seg + (off === 0xffff ? 0x1000 : 0), (off + 1) & 0xffff, v >> 8); }
  push(v) { this.sp = (this.sp - 2) & 0xffff; this.ww(this.ss, this.sp, v); }
  pop() { const v = this.rw(this.ss, this.sp); this.sp = (this.sp + 2) & 0xffff; return v; }

  // ---- Drapeaux

  drapeaux() {
    return this.cf | 2 | (this.pf << 2) | (this.af << 4) | (this.zf << 6) | (this.sf << 7) |
      (this.tf << 8) | (this.if << 9) | (this.df << 10) | (this.of << 11);   // bits 12-15 à 0, comme un 386
  }
  poserDrapeaux(v) {
    this.cf = v & 1; this.pf = (v >> 2) & 1; this.af = (v >> 4) & 1; this.zf = (v >> 6) & 1;
    this.sf = (v >> 7) & 1; this.tf = (v >> 8) & 1; this.if = (v >> 9) & 1; this.df = (v >> 10) & 1;
    this.of = (v >> 11) & 1;
  }
  szp8(r) { this.zf = r === 0 ? 1 : 0; this.sf = r >> 7; this.pf = PARITE[r]; return r; }
  szp16(r) { this.zf = r === 0 ? 1 : 0; this.sf = r >> 15; this.pf = PARITE[r & 0xff]; return r; }

  add8(a, b) { const r = a + b; this.cf = r >> 8; this.of = ((a ^ r) & (b ^ r) & 0x80) ? 1 : 0; this.af = ((a ^ b ^ r) >> 4) & 1; return this.szp8(r & 0xff); }
  add16(a, b) { const r = a + b; this.cf = r >> 16; this.of = ((a ^ r) & (b ^ r) & 0x8000) ? 1 : 0; this.af = ((a ^ b ^ r) >> 4) & 1; return this.szp16(r & 0xffff); }
  adc8(a, b) { const r = a + b + this.cf; this.cf = r >> 8; this.of = ((a ^ r) & (b ^ r) & 0x80) ? 1 : 0; this.af = ((a ^ b ^ r) >> 4) & 1; return this.szp8(r & 0xff); }
  adc16(a, b) { const r = a + b + this.cf; this.cf = r >> 16; this.of = ((a ^ r) & (b ^ r) & 0x8000) ? 1 : 0; this.af = ((a ^ b ^ r) >> 4) & 1; return this.szp16(r & 0xffff); }
  sub8(a, b) { const r = a - b; this.cf = r < 0 ? 1 : 0; this.of = ((a ^ b) & (a ^ r) & 0x80) ? 1 : 0; this.af = ((a ^ b ^ r) >> 4) & 1; return this.szp8(r & 0xff); }
  sub16(a, b) { const r = a - b; this.cf = r < 0 ? 1 : 0; this.of = ((a ^ b) & (a ^ r) & 0x8000) ? 1 : 0; this.af = ((a ^ b ^ r) >> 4) & 1; return this.szp16(r & 0xffff); }
  sbb8(a, b) { const r = a - b - this.cf; this.cf = r < 0 ? 1 : 0; this.of = ((a ^ b) & (a ^ r) & 0x80) ? 1 : 0; this.af = ((a ^ b ^ r) >> 4) & 1; return this.szp8(r & 0xff); }
  sbb16(a, b) { const r = a - b - this.cf; this.cf = r < 0 ? 1 : 0; this.of = ((a ^ b) & (a ^ r) & 0x8000) ? 1 : 0; this.af = ((a ^ b ^ r) >> 4) & 1; return this.szp16(r & 0xffff); }
  and8(a, b) { this.cf = this.of = this.af = 0; return this.szp8(a & b); }
  and16(a, b) { this.cf = this.of = this.af = 0; return this.szp16(a & b); }
  or8(a, b) { this.cf = this.of = this.af = 0; return this.szp8(a | b); }
  or16(a, b) { this.cf = this.of = this.af = 0; return this.szp16(a | b); }
  xor8(a, b) { this.cf = this.of = this.af = 0; return this.szp8(a ^ b); }
  xor16(a, b) { this.cf = this.of = this.af = 0; return this.szp16(a ^ b); }
  inc8(a) { const r = (a + 1) & 0xff; this.of = r === 0x80 ? 1 : 0; this.af = (r & 0xf) === 0 ? 1 : 0; return this.szp8(r); }
  inc16(a) { const r = (a + 1) & 0xffff; this.of = r === 0x8000 ? 1 : 0; this.af = (r & 0xf) === 0 ? 1 : 0; return this.szp16(r); }
  dec8(a) { const r = (a - 1) & 0xff; this.of = r === 0x7f ? 1 : 0; this.af = (r & 0xf) === 0xf ? 1 : 0; return this.szp8(r); }
  dec16(a) { const r = (a - 1) & 0xffff; this.of = r === 0x7fff ? 1 : 0; this.af = (r & 0xf) === 0xf ? 1 : 0; return this.szp16(r); }
  neg8(a) { const r = this.sub8(0, a); this.cf = a ? 1 : 0; return r; }
  neg16(a) { const r = this.sub16(0, a); this.cf = a ? 1 : 0; return r; }

  // Décalages : comme un 386 (nombre pris modulo 32), ce que fait DOSBox.
  shl8(a, n) { n &= 0x1f; if (!n) return a; const r = a << n; this.cf = n <= 8 ? (r >> 8) & 1 : 0; const v = r & 0xff; this.of = (v >> 7) ^ this.cf; this.af = 0; return this.szp8(v); }
  shl16(a, n) { n &= 0x1f; if (!n) return a; const r = a << n; this.cf = n <= 16 ? (r >> 16) & 1 : 0; const v = r & 0xffff; this.of = (v >> 15) ^ this.cf; this.af = 0; return this.szp16(v); }
  shr8(a, n) { n &= 0x1f; if (!n) return a; this.cf = (a >> (n - 1)) & 1; this.of = n === 1 ? a >> 7 : 0; this.af = 0; return this.szp8(a >> n); }
  shr16(a, n) { n &= 0x1f; if (!n) return a; this.cf = (a >> (n - 1)) & 1; this.of = n === 1 ? a >> 15 : 0; this.af = 0; return this.szp16(a >> n); }
  sar8(a, n) { n &= 0x1f; if (!n) return a; const s = (a << 24) >> 24; this.cf = (s >> Math.min(n - 1, 7)) & 1; this.of = 0; return this.szp8((s >> Math.min(n, 7)) & 0xff); }
  sar16(a, n) { n &= 0x1f; if (!n) return a; const s = (a << 16) >> 16; this.cf = (s >> Math.min(n - 1, 15)) & 1; this.of = 0; return this.szp16((s >> Math.min(n, 15)) & 0xffff); }
  rcl8(a, n) { n = (n & 0x1f) % 9; for (let k = 0; k < n; k++) { const c = a >> 7; a = ((a << 1) | this.cf) & 0xff; this.cf = c; } if (n) this.of = (a >> 7) ^ this.cf; return a; }
  rcl16(a, n) { n = (n & 0x1f) % 17; for (let k = 0; k < n; k++) { const c = a >> 15; a = ((a << 1) | this.cf) & 0xffff; this.cf = c; } if (n) this.of = (a >> 15) ^ this.cf; return a; }
  rcr8(a, n) { n = (n & 0x1f) % 9; if (n) this.of = (a >> 7) ^ this.cf; for (let k = 0; k < n; k++) { const c = a & 1; a = (a >> 1) | (this.cf << 7); this.cf = c; } return a; }
  rcr16(a, n) { n = (n & 0x1f) % 17; if (n) this.of = (a >> 15) ^ this.cf; for (let k = 0; k < n; k++) { const c = a & 1; a = (a >> 1) | (this.cf << 15); this.cf = c; } return a; }
  rol8(a, n) { n &= 0x1f; if (!n) return a; n &= 7; a = ((a << n) | (a >> (8 - n))) & 0xff; this.cf = a & 1; this.of = (a >> 7) ^ this.cf; return a; }
  rol16(a, n) { n &= 0x1f; if (!n) return a; n &= 15; a = ((a << n) | (a >> (16 - n))) & 0xffff; this.cf = a & 1; this.of = (a >> 15) ^ this.cf; return a; }
  ror8(a, n) { n &= 0x1f; if (!n) return a; n &= 7; a = ((a >> n) | (a << (8 - n))) & 0xff; this.cf = a >> 7; this.of = (a >> 7) ^ ((a >> 6) & 1); return a; }
  ror16(a, n) { n &= 0x1f; if (!n) return a; n &= 15; a = ((a >> n) | (a << (16 - n))) & 0xffff; this.cf = a >> 15; this.of = (a >> 15) ^ ((a >> 14) & 1); return a; }

  mul8(b) { const r = (this.ax & 0xff) * b; this.ax = r & 0xffff; this.cf = this.of = r > 0xff ? 1 : 0; }
  mul16(b) { const r = this.ax * b; this.ax = r & 0xffff; this.dx = Math.floor(r / 0x10000) & 0xffff; this.cf = this.of = this.dx ? 1 : 0; }
  div8(b) {
    if (b === 0) throw new Error('division par zéro (div 8 bits)');
    const q = Math.floor(this.ax / b);
    if (q > 0xff) throw new Error('dépassement de division (div 8 bits)');
    this.ax = ((this.ax % b) << 8) | q;
  }
  div16(b) {
    if (b === 0) throw new Error('division par zéro (div 16 bits)');
    const n = this.dx * 0x10000 + this.ax;
    const q = Math.floor(n / b);
    if (q > 0xffff) throw new Error('dépassement de division (div 16 bits)');
    this.ax = q;
    this.dx = n % b;
  }

  // ---- Instructions de chaîne (préfixe rep : CX fois)

  chaine(rep, pas, action) {
    const n = rep ? this.cx : 1;
    const d = this.df ? -pas : pas;
    for (let k = 0; k < n; k++) action(d);
    if (rep) this.cx = 0;
    this.t += n;
    this.pas -= n;
  }
  movsb(seg, rep) { this.chaine(rep, 1, (d) => { this.wb(this.es, this.di, this.rb(seg, this.si)); this.si = (this.si + d) & 0xffff; this.di = (this.di + d) & 0xffff; }); }
  movsw(seg, rep) { this.chaine(rep, 2, (d) => { this.ww(this.es, this.di, this.rw(seg, this.si)); this.si = (this.si + d) & 0xffff; this.di = (this.di + d) & 0xffff; }); }
  stosb(seg, rep) { this.chaine(rep, 1, (d) => { this.wb(this.es, this.di, this.ax & 0xff); this.di = (this.di + d) & 0xffff; }); }
  stosw(seg, rep) { this.chaine(rep, 2, (d) => { this.ww(this.es, this.di, this.ax); this.di = (this.di + d) & 0xffff; }); }
  lodsb(seg, rep) { this.chaine(rep, 1, (d) => { this.ax = (this.ax & 0xff00) | this.rb(seg, this.si); this.si = (this.si + d) & 0xffff; }); }
  lodsw(seg, rep) { this.chaine(rep, 2, (d) => { this.ax = this.rw(seg, this.si); this.si = (this.si + d) & 0xffff; }); }

  // ---- Ports

  entree(port, taille) {
    switch (port) {
      case 0x60: return this.port60;
      case 0x61: return this.port61;
      case 0x201: return 0xf0;                       // pas de joystick : axes à 0, boutons relâchés
      case 0x3da: return this.etatVideo();
      case 0x3c9: {
        const v = this.dac[this.dacLecture * 3 + this.dacComposante];
        if (++this.dacComposante === 3) { this.dacComposante = 0; this.dacLecture = (this.dacLecture + 1) & 0xff; }
        return v;
      }
      default:
        this.signaler(`in-${port}`, `lecture du port ${port.toString(16)} non émulée`);
        return taille === 1 ? 0xff : 0xffff;
    }
  }

  sortie(port, valeur, taille) {
    if (taille === 2) {                              // out dx, ax : deux octets sur deux ports
      this.sortie(port, valeur & 0xff, 1);
      this.sortie(port + 1, valeur >> 8, 1);
      return;
    }
    switch (port) {
      case 0x20: return;                             // fin d'interruption
      case 0x42: case 0x43: return;                  // haut-parleur : non joué (le son passe par l'AdLib)
      case 0x61: this.port61 = valeur; return;
      case 0x3c8: this.dacEcriture = valeur; this.dacComposante = 0; return;
      case 0x3c7: this.dacLecture = valeur; this.dacComposante = 0; return;
      case 0x3c9:
        this.dac[this.dacEcriture * 3 + this.dacComposante] = valeur & 0x3f;
        if (++this.dacComposante === 3) { this.dacComposante = 0; this.dacEcriture = (this.dacEcriture + 1) & 0xff; }
        return;
      case 0x3c4: case 0x3c5: case 0x3ce: case 0x3cf: case 0x3d4: case 0x3d5: case 0x3c0: return;   // registres EGA, CRTC
      default:
        this.signaler(`out-${port}`, `écriture du port ${port.toString(16)} non émulée`);
    }
  }

  // Bit 3 : retour de trame (70 par seconde) ; bit 0 : affichage inactif.
  etatVideo() {
    const periode = (INSTRUCTIONS_PAR_MS * 1000) / IMAGE_PAR_SECONDE;
    const phase = this.t % periode;
    const trame = phase < periode * 0.06 ? 8 : 0;
    const ligne = (this.t % 107) < 20 ? 1 : 0;
    return trame | ligne | trame >> 3;
  }

  // ---- Interruptions : true si le service est rendu, false s'il faut réessayer plus tard

  interruption(n) {
    switch (n) {
      case 0x10: return this.bios10();
      case 0x16: return this.bios16();
      case 0x21: return this.dos();
      case 0x33: return this.pilote33();
      case 0x60: return this.pilote60();
      default:
        this.signaler(`int-${n}`, `int ${n.toString(16)}h non émulée`);
        return true;
    }
  }

  get ah() { return this.ax >> 8; }
  get al() { return this.ax & 0xff; }

  bios10() {
    const ah = this.ah;
    if (ah === 0x00) {
      this.mode = this.al & 0x7f;
      if (this.mode === 0x13) this.mem.fill(0, 0xa0000, 0xa0000 + 64000);
      else if (this.mode <= 3 || this.mode === 7) this.effacerTexte();
      else this.signaler(`mode-${this.mode}`, `mode vidéo ${this.mode.toString(16)}h non émulé : seul le VGA 13h l'est`);
      this.mem[0x449] = this.mode;
    } else if (this.ax === 0x1012) {
      for (let k = 0; k < this.cx; k++) {
        for (let c = 0; c < 3; c++) this.dac[((this.bx + k) & 0xff) * 3 + c] = this.rb(this.es, (this.dx + k * 3 + c) & 0xffff) & 0x3f;
      }
    } else if (this.ax === 0x1010) {
      const i = (this.bx & 0xff) * 3;
      this.dac[i] = (this.dx >> 8) & 0x3f;
      this.dac[i + 1] = (this.cx >> 8) & 0x3f;
      this.dac[i + 2] = this.cx & 0x3f;
    } else if (this.ax === 0x1000 || this.ax === 0x1001 || this.ax === 0x1002) {
      // registres de palette EGA, bordure : sans effet en VGA 256 couleurs
    } else if (ah === 0x0f) {
      this.ax = (40 << 8) | this.mode;
      this.bx &= 0x00ff;
    } else if (ah === 0x02) {
      this.curseur = { x: this.dx & 0xff, y: this.dx >> 8 };
    } else if (ah === 0x03) {
      this.dx = (this.curseur.y << 8) | this.curseur.x;
      this.cx = 0x0607;
    } else if (ah === 0x0e) {
      this.ecrireTexte(this.al);
    } else if (ah === 0x09 || ah === 0x0a) {
      const { x, y } = this.curseur;
      for (let k = 0; k < this.cx && y * 80 + x + k < 2000; k++) {
        const a = 0xb8000 + (y * 80 + x + k) * 2;
        this.mem[a] = this.al;
        if (ah === 0x09) this.mem[a + 1] = this.bx & 0xff;
      }
    } else if (ah === 0x06 && (this.ax & 0xff) === 0) {
      this.effacerTexte();
    } else {
      this.signaler(`int10-${this.ax}`, `int 10h AX=${this.ax.toString(16)} non émulée`);
    }
    return true;
  }

  bios16() {
    const ah = this.ah;
    if (ah === 0x00 || ah === 0x10) {
      if (!this.tamponBios.length) return false;
      this.ax = this.tamponBios.shift();
    } else if (ah === 0x01 || ah === 0x11) {
      this.zf = this.tamponBios.length ? 0 : 1;
      if (this.tamponBios.length) this.ax = this.tamponBios[0];
    } else if (ah === 0x02) {
      this.ax &= 0xff00;
    }
    return true;
  }

  pilote33() {
    const s = this.souris;
    switch (this.ax) {
      case 0x0000: this.ax = 0xffff; this.bx = 2; break;
      case 0x0003: this.bx = s.boutons; this.cx = s.x; this.dx = s.y; break;
      case 0x0004: s.x = this.cx; s.y = this.dx; break;
      default: break;                                // afficher, cacher, limites : sans effet
    }
    return true;
  }

  // Pilote de son (int 60h). Le pilote d'origine n'est pas exécuté : ses morceaux, rendus en WAV
  // (outils/sons.mjs), sont joués par this.son quand le programme lui a donné ses données (AX=2).
  //   AX=2 données, AX=3 jouer le morceau DX (poignée rendue dans DI), AX=4 arrêter la poignée DI,
  //   AX=0 et AX=0Bh silence.
  pilote60() {
    switch (this.ax) {
      case 2: this.sonDonnees = true; break;
      case 3:
        this.di = ++this.poigneeSon;
        if (this.sonDonnees && this.son) this.son.jouer(this.dx, this.di);
        break;
      case 4: if (this.son) this.son.arreter(this.di); break;
      case 0: case 0x0b: if (this.son) this.son.silence(); break;
      default: break;
    }
    return true;
  }

  appelLointain(seg, off) {
    this.signaler('pilote-son', `appel du pilote de son ${seg.toString(16)}:${off.toString(16)} ignoré`);
  }

  // ---- DOS

  nomEn(seg, off) {
    let nom = '';
    for (let k = 0; k < 128; k++) {
      const c = this.rb(seg, (off + k) & 0xffff);
      if (!c) break;
      nom += String.fromCharCode(c);
    }
    return nom.toUpperCase().replace(/^.*[\\:]/, '');
  }

  lireFichier(nom) {
    const octets = this.fichiers.get(nom.toUpperCase());
    if (!octets) throw new Error(`fichier absent : ${nom}`);
    return octets;
  }

  echec(code) { this.cf = 1; this.ax = code; return true; }

  dos() {
    const ah = this.ah;
    this.cf = 0;
    switch (ah) {
      case 0x02: this.ecrireTexte(this.dx & 0xff); return true;
      case 0x09: {
        for (let k = 0; k < 4000; k++) {
          const c = this.rb(this.ds, (this.dx + k) & 0xffff);
          if (c === 0x24) break;
          this.ecrireTexte(c);
        }
        return true;
      }
      case 0x25: this.vecteurs.set(this.al, [this.ds, this.dx]); return true;
      case 0x35: {
        const [seg, off] = this.vecteurs.get(this.al) || [SEGMENT_BIOS, 0xff00 + this.al];
        this.es = seg;
        this.bx = off;
        return true;
      }
      case 0x2c: {
        const d = this.horloge();
        this.cx = (d.getHours() << 8) | d.getMinutes();
        this.dx = (d.getSeconds() << 8) | Math.floor(d.getMilliseconds() / 10);
        return true;
      }
      case 0x3c: case 0x3d: {
        const nom = this.nomEn(this.ds, this.dx);
        let octets = this.fichiers.get(nom);
        if (ah === 0x3c) octets = new Uint8Array(0);
        else if (!octets) return this.echec(2);
        const h = this.prochainHandle++;
        this.handles.set(h, { nom, octets, position: 0, modifie: ah === 0x3c });
        this.ax = h;
        return true;
      }
      case 0x3e: {
        const f = this.handles.get(this.bx);
        if (!f) return this.echec(6);
        if (f.modifie) {
          this.fichiers.set(f.nom, f.octets);
          if (this.fichiers.sauver) this.fichiers.sauver(f.nom, f.octets);
        }
        this.handles.delete(this.bx);
        return true;
      }
      case 0x3f: {
        const f = this.handles.get(this.bx);
        if (!f) return this.echec(6);
        const n = Math.max(0, Math.min(this.cx, f.octets.length - f.position));
        for (let k = 0; k < n; k++) this.wb(this.ds, (this.dx + k) & 0xffff, f.octets[f.position + k]);
        f.position += n;
        this.ax = n;
        return true;
      }
      case 0x40: {
        const f = this.handles.get(this.bx);
        if (!f) return this.echec(6);
        const fin = f.position + this.cx;
        if (fin > f.octets.length) {
          const plus = new Uint8Array(fin);
          plus.set(f.octets);
          f.octets = plus;
        }
        for (let k = 0; k < this.cx; k++) f.octets[f.position + k] = this.rb(this.ds, (this.dx + k) & 0xffff);
        f.position = fin;
        f.modifie = true;
        this.ax = this.cx;
        return true;
      }
      case 0x42: {
        const f = this.handles.get(this.bx);
        if (!f) return this.echec(6);
        const depl = (this.cx << 16) | this.dx;
        const base = [0, f.position, f.octets.length][this.al] ?? 0;
        f.position = base + depl;
        this.dx = f.position >>> 16;
        this.ax = f.position & 0xffff;
        return true;
      }
      case 0x48: {
        if (this.memoireLibre + this.bx > FIN_MEMOIRE) {
          this.bx = Math.max(0, FIN_MEMOIRE - this.memoireLibre);
          return this.echec(8);
        }
        this.ax = this.memoireLibre;
        this.memoireLibre += this.bx;
        return true;
      }
      case 0x49: return true;
      case 0x4a: {
        if (this.es === this.psp) this.memoireLibre = this.psp + this.bx;
        return true;
      }
      case 0x4c: this.arret = this.al; this.pas = 0; return false;
      default:
        this.signaler(`int21-${ah}`, `int 21h AH=${ah.toString(16)} non émulée`);
        return true;
    }
  }

  // ---- Console en mode texte (80 x 25, mémoire B800h) : messages de DOS et du BIOS

  effacerTexte() {
    for (let k = 0; k < 2000; k++) { this.mem[0xb8000 + 2 * k] = 0x20; this.mem[0xb8001 + 2 * k] = 0x07; }
    this.curseur = { x: 0, y: 0 };
  }

  ecrireTexte(c) {
    const cur = this.curseur;
    if (c === 0x0d) cur.x = 0;
    else if (c === 0x0a) cur.y++;
    else if (c === 0x08) cur.x = Math.max(0, cur.x - 1);
    else if (c === 0x07) return;
    else {
      this.mem[0xb8000 + (cur.y * 80 + cur.x) * 2] = c;
      if (++cur.x === 80) { cur.x = 0; cur.y++; }
    }
    if (cur.y === 25) {
      this.mem.copyWithin(0xb8000, 0xb8000 + 160, 0xb8000 + 4000);
      for (let k = 0; k < 80; k++) { this.mem[0xb8000 + 3840 + 2 * k] = 0x20; this.mem[0xb8001 + 3840 + 2 * k] = 0x07; }
      cur.y = 24;
    }
    if (c === 0x0a) this.journal(this.ligneTexte(cur.y - 1));
  }

  ligneTexte(y) {
    let s = '';
    for (let x = 0; x < 80; x++) s += String.fromCharCode(this.mem[0xb8000 + (y * 80 + x) * 2]);
    return s.trimEnd();
  }

  texte() {
    return Array.from({ length: 25 }, (_, y) => this.ligneTexte(y)).join('\n').trimEnd();
  }

  // ---- Entrées venant de la page

  appuyer(code) { this.touchesEnAttente.push(code); }
  relacher(code) { this.touchesEnAttente.push(code | 0x80); }
  toucheBios(ascii, code) { if (this.tamponBios.length < 15) this.tamponBios.push((code << 8) | ascii); }   // 15 touches, comme le BIOS

  // ---- Écran : image RGBA de 320 x 200 (mode 13h)

  peindre(rgba) {
    const vram = this.mem.subarray(0xa0000, 0xa0000 + 64000);
    const pal = new Uint32Array(256);
    for (let k = 0; k < 256; k++) {
      const r = (this.dac[k * 3] * 255 / 63) | 0;
      const g = (this.dac[k * 3 + 1] * 255 / 63) | 0;
      const b = (this.dac[k * 3 + 2] * 255 / 63) | 0;
      pal[k] = 0xff000000 | (b << 16) | (g << 8) | r;
    }
    const sortie = new Uint32Array(rgba.buffer, rgba.byteOffset, 64000);
    if (this.mode !== 0x13) { sortie.fill(0xff000000); return; }
    for (let k = 0; k < 64000; k++) sortie[k] = pal[vram[k]];
  }

  signaler(cle, texte) {
    if (this.signale.has(cle)) return;
    this.signale.add(cle);
    this.journal(`[machine] ${texte} (IP ${this.ip.toString(16)}, t ${this.t})`);
  }
}
