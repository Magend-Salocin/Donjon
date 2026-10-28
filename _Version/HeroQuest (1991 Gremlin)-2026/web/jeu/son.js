// Son du jeu : les morceaux du pilote AdLib, rendus une fois pour toutes en WAV (outils/sons.mjs,
// dossier ../sons/). La machine appelle jouer, arreter et silence comme le jeu appelle son pilote.
// Le morceau 0 est la musique, jouée en boucle ; les autres sont des effets.

const MUSIQUE = 0;

export class Son {
  constructor() {
    this.audio = null;
    this.tampons = new Map();         // morceau -> promesse d'AudioBuffer (null si pas de fichier)
    this.poignees = new Map();        // poignée du pilote -> { morceau, source }
  }

  // Les navigateurs n'ouvrent le son qu'après un geste de l'utilisateur. La musique demandée
  // avant (au lancement du jeu) démarre alors ; un effet en retard n'a plus de sens.
  activer() {
    if (this.audio) return;
    const Contexte = window.AudioContext || window.webkitAudioContext;
    if (!Contexte) return;
    this.audio = new Contexte();
    for (const [poignee, { morceau }] of this.poignees) {
      if (morceau === MUSIQUE) this.demarrer(poignee);
      else this.poignees.delete(poignee);
    }
  }

  charger(morceau) {
    if (!this.tampons.has(morceau)) {
      const nom = `sons/morceau${String(morceau).padStart(2, '0')}.wav`;
      this.tampons.set(morceau, fetch(nom)
        .then((r) => (r.ok ? r.arrayBuffer() : null))
        .then((octets) => (octets ? this.audio.decodeAudioData(octets) : null))
        .catch(() => null));
    }
    return this.tampons.get(morceau);
  }

  jouer(morceau, poignee) {
    this.poignees.set(poignee, { morceau, source: null });
    if (this.audio) this.demarrer(poignee);
  }

  demarrer(poignee) {
    const entree = this.poignees.get(poignee);
    this.charger(entree.morceau).then((tampon) => {
      if (!tampon || this.poignees.get(poignee) !== entree) return;   // arrêté entre-temps
      const source = this.audio.createBufferSource();
      source.buffer = tampon;
      source.loop = entree.morceau === MUSIQUE;
      source.connect(this.audio.destination);
      source.start();
      entree.source = source;
    });
  }

  arreter(poignee) {
    const entree = this.poignees.get(poignee);
    if (entree && entree.source) entree.source.stop();
    this.poignees.delete(poignee);
  }

  silence() {
    for (const poignee of [...this.poignees.keys()]) this.arreter(poignee);
  }
}
