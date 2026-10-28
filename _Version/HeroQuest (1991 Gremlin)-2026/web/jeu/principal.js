// Page du jeu : charge les fichiers d'origine (servis par fichiers.php), puis enchaîne les
// programmes comme HERO.EXE : INTRO.EXE (configuration et intro), puis QUEST.EXE.
// La machine tourne au rythme du temps réel ; souris et clavier lui sont transmis.
//   index.html?sans-intro   lance directement QUEST.EXE
//   index.html?debug        affiche le temps de jeu et l'IP sous l'écran

import { Machine, INSTRUCTIONS_PAR_MS } from './machine.js';
import { codeClavier, asciiDe } from './clavier.js';
import { HautParleur } from './haut-parleur.js';

// VGA, haut-parleur, souris, français, souris pour les 4 joueurs (format : notes/01-socle.md)
const CONFIGURATION = Uint8Array.from([8, 0, 0, 0, 1, 0, 0, 0, 0]);
const RETARD_MAX_MS = 100;
const OPTIONS = new URLSearchParams(location.search);
const PROGRAMMES = { INTRO: () => import('./intro.gen.js'), QUEST: () => import('./quest.gen.js') };

const ecran = document.querySelector('#ecran');
const console_ = document.querySelector('#texte');
const etat = document.querySelector('#etat');
const contexte = ecran.getContext('2d');
const image = contexte.createImageData(320, 200);
let machine = null;                                  // programme en cours, pour les entrées

async function chargerFichiers() {
  const archive = new Uint8Array(await (await fetch('fichiers.php')).arrayBuffer());
  const fichiers = new Map();
  for (let p = 0; p < archive.length;) {
    const nom = String.fromCharCode(...archive.subarray(p + 1, p + 1 + archive[p]));
    p += 1 + archive[p];
    const taille = archive[p] | (archive[p + 1] << 8) | (archive[p + 2] << 16) | (archive[p + 3] << 24);
    fichiers.set(nom, archive.slice(p + 4, p + 4 + taille));
    p += 4 + taille;
  }
  fichiers.sauver = (nom, octets) => {
    fetch(`fichiers.php?nom=${encodeURIComponent(nom)}`, { method: 'POST', body: octets })
      .catch((e) => console.error('sauvegarde impossible', e));
  };
  return fichiers;
}

function brancherEntrees() {
  const position = (e) => {
    const r = ecran.getBoundingClientRect();
    machine.souris.x = Math.max(0, Math.min(639, Math.floor(((e.clientX - r.left) / r.width) * 640)));
    machine.souris.y = Math.max(0, Math.min(199, Math.floor(((e.clientY - r.top) / r.height) * 200)));
  };
  const bouton = (e) => (e.button === 2 ? 2 : 1);
  ecran.addEventListener('mousemove', (e) => machine && position(e));
  ecran.addEventListener('mousedown', (e) => {
    if (!machine) return;
    position(e);
    machine.souris.boutons |= bouton(e);
    e.preventDefault();
  });
  window.addEventListener('mouseup', (e) => { if (machine) machine.souris.boutons &= ~bouton(e); });
  ecran.addEventListener('contextmenu', (e) => e.preventDefault());
  window.addEventListener('keydown', (e) => {
    const code = codeClavier(e.code);
    if (!machine || code === undefined) return;
    e.preventDefault();
    if (!e.repeat) machine.appuyer(code);
    machine.toucheBios(asciiDe(e), code);
  });
  window.addEventListener('keyup', (e) => {
    const code = codeClavier(e.code);
    if (machine && code !== undefined) machine.relacher(code);
  });
}

// Fait tourner un programme jusqu'à sa fin (int 21h AH=4Ch) ; rend son code de sortie.
async function executer(nom, fichiers, son) {
  const { routines, CODE_REECRIT } = await PROGRAMMES[nom]();
  const m = new Machine({ fichiers, routines, codeReecrit: CODE_REECRIT });
  m.charger(`${nom}.EXE`);
  machine = m;
  son.machine = m;
  return new Promise((fini, echec) => {
    let precedent = performance.now();
    const image_suivante = (maintenant) => {
      const ecoule = Math.min(RETARD_MAX_MS, maintenant - precedent);
      precedent = maintenant;
      try {
        m.executer(Math.round(ecoule * INSTRUCTIONS_PAR_MS));
      } catch (erreur) {
        echec(erreur);
        return;
      }
      son.suivre();
      afficher(m);
      if (OPTIONS.has('debug')) etat.textContent = `${nom} t = ${(m.t / INSTRUCTIONS_PAR_MS / 1000).toFixed(1)} s, IP ${m.ip.toString(16)}`;
      if (m.arret !== null) fini(m.arret);
      else requestAnimationFrame(image_suivante);
    };
    requestAnimationFrame(image_suivante);
  });
}

function afficher(m) {
  const graphique = m.mode === 0x13 || m.planaire;
  ecran.hidden = !graphique;
  console_.hidden = graphique;
  if (graphique) {
    m.peindre(image.data);
    contexte.putImageData(image, 0, 0);
  } else {
    console_.textContent = m.texte();
  }
}

async function demarrer() {
  etat.textContent = 'Chargement des fichiers du jeu…';
  const fichiers = await chargerFichiers();
  const son = new HautParleur();
  window.addEventListener('pointerdown', () => son.activer(), { once: true });
  window.addEventListener('keydown', () => son.activer(), { once: true });
  brancherEntrees();
  etat.textContent = '';

  if (!OPTIONS.has('sans-intro')) await executer('INTRO', fichiers, son);
  if (!fichiers.has('QUEST.CFG')) fichiers.set('QUEST.CFG', CONFIGURATION);
  await executer('QUEST', fichiers, son);
  etat.textContent = 'Le jeu est terminé.';
}

demarrer().catch((e) => { etat.textContent = `Arrêt : ${e.message}`; console.error(e); });
