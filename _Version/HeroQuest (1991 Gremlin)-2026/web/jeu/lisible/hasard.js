// Générateur de hasard de QUEST.EXE (routine hasard, 0x3613).
//
// Un registre à décalage de 32 bits, rangé sur 4 octets en DS:38FD (octet a) à DS:3900 (octet d).
// À chaque tirage :
//   1. le bit entrant vaut bit 3 XOR bit 6 de l'octet a ;
//   2. les 4 octets glissent d'un bit vers la gauche, comme un seul nombre « a b c d » :
//      le bit entrant arrive en bas de d, le haut de d passe en bas de c, et ainsi de suite ;
//   3. le résultat est (octet a après le décalage) modulo max, plus 1.
// La graine est posée au lancement à partir de l'heure (int 21h AH=2Ch).

const GRAINE = 0x38fd;   // octet a ; b, c, d suivent

export class Hasard {
  constructor(donnees) {
    this.donnees = donnees;
  }

  // Nombre de 1 à max (max de 1 à 255).
  tirer(max) {
    this.decaler();
    return (this.donnees.octet(GRAINE) % max) + 1;
  }

  // Face d'un dé à 6 faces, de 0 à 5 (routine de6_moins_un, 0x6033).
  de6() {
    return this.tirer(6) - 1;
  }

  decaler() {
    const d = this.donnees;
    const a = d.octet(GRAINE);
    const bitEntrant = ((a >> 3) ^ (a >> 6)) & 1;
    let valeur = ((a << 24) | (d.octet(GRAINE + 1) << 16) | (d.octet(GRAINE + 2) << 8) | d.octet(GRAINE + 3)) >>> 0;
    valeur = ((valeur << 1) | bitEntrant) >>> 0;
    d.ecrireOctet(GRAINE, valeur >>> 24);
    d.ecrireOctet(GRAINE + 1, valeur >>> 16);
    d.ecrireOctet(GRAINE + 2, valeur >>> 8);
    d.ecrireOctet(GRAINE + 3, valeur);
  }
}
