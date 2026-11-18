// Base des modules lisibles.
//
// Une méthode qui doit attendre (le joueur, l'écran, une animation) est une fonction génératrice
// (function*). Pour appeler une routine du code d'origine, elle écrit :
//   yield* this.appeler(QUEST.affiche_message, { bx: MESSAGE.ennemiMort });
// La machine exécute alors cette routine, au rythme du temps réel, puis reprend la méthode
// juste après. Voir routines.js pour le mécanisme.

import { QUEST } from './adresses.gen.js';
import { MESSAGE } from './messages.js';

export class Module {
  constructor(jeu) {
    this.jeu = jeu;
    this.donnees = jeu.donnees;
    this.machine = jeu.machine;
  }

  // Appelle une routine d'origine. registres : valeurs à poser avant l'appel
  // (ax, bx, cx, dx, si, di, bp, ou al pour l'octet bas de AX seul).
  *appeler(adresse, registres = {}) {
    this.poserRegistres(registres);
    yield adresse;
  }

  // Fin d'une routine d'origine qui se termine par un saut (jmp) vers une autre routine :
  // la méthode renvoie l'adresse, la machine continue là-bas.
  sauter(adresse, registres = {}) {
    this.poserRegistres(registres);
    return adresse;
  }

  poserRegistres(registres) {
    for (const [nom, valeur] of Object.entries(registres)) {
      if (nom === 'al') this.machine.ax = (this.machine.ax & 0xff00) | (valeur & 0xff);
      else this.machine[nom] = valeur & 0xffff;
    }
  }

  // Boîte de message (affiche_message) ; le bouton choisi est ensuite dans donnees.choixMenu.
  *afficherMessage(numero) {
    yield* this.appeler(QUEST.affiche_message, { bx: numero });
  }
}

export { QUEST, MESSAGE };
