// Haut-parleur du PC : le jeu (pilote 0) joue ses effets en programmant le canal 2 de la
// minuterie (port 42h, fréquence 1 193 182 / diviseur) et en ouvrant le port 61h (bits 0 et 1).
// On relève cet état à chaque image : les notes plus courtes qu'une image peuvent manquer.

const FREQUENCE_MINUTERIE = 1193182;

export class HautParleur {
  constructor() {
    this.machine = null;                             // programme en cours, posé par la page
    this.audio = null;
  }

  activer() {
    if (this.audio) return;
    const Contexte = window.AudioContext || window.webkitAudioContext;
    if (!Contexte) return;
    this.audio = new Contexte();
    this.oscillateur = this.audio.createOscillator();
    this.oscillateur.type = 'square';
    this.volume = this.audio.createGain();
    this.volume.gain.value = 0;
    this.oscillateur.connect(this.volume).connect(this.audio.destination);
    this.oscillateur.start();
  }

  suivre() {
    if (!this.audio || !this.machine) return;
    const { diviseur } = this.machine.haut_parleur;
    const ouvert = (this.machine.port61 & 3) === 3 && diviseur > 0;
    const t = this.audio.currentTime;
    if (ouvert) this.oscillateur.frequency.setValueAtTime(FREQUENCE_MINUTERIE / diviseur, t);
    this.volume.gain.setTargetAtTime(ouvert ? 0.08 : 0, t, 0.005);
  }
}
