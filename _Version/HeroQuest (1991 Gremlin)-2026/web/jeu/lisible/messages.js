// Numéros des messages du jeu (BX passé à affiche_message), avec leur texte français.
// Liste complète : original/donnees/textes/french-messages.txt.

export const MESSAGE = {
  blessuresMortelles: 0x0020,   // VOUS AVEZ ESSUYE / DES BLESSURES MORTELLES.
  ennemiMort: 0x004e,           // L'ENNEMI EST MORT
  ennemiSurvecu: 0x0050,        // L'ENEMI A SURVECU
  vousAvezSurvecu: 0x0052,      // VOUS AVEZ SURVECU A L'ATTAQUE
  attaquerANouveau: 0x0122,     // VOULEZ-VOUS ATTAQUER / A NOUVEAU ?  (boutons : 0 OUI, 1 NON)
};

// Bouton choisi dans une boîte de message (donnees.choixMenu).
export const BOUTON = { oui: 0, non: 1, boutonDroit: 0xfe };
