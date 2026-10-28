// Essai de la page dans un vrai Chrome (sans fenêtre), par le protocole DevTools.
//   node navigateur.mjs <url> <capture.png> [actions]
// actions : "attendre:5,clic:160:100,touche:Space,capture:a.png,etat" (souris en coordonnées
// de l'écran du jeu 320 x 200 ; touche = KeyboardEvent.code ; etat = texte sous l'écran).
// Lancer d'abord le serveur : php -S 127.0.0.1:8765 -t web

import { spawn } from 'node:child_process';
import fs from 'node:fs';
import os from 'node:os';
import path from 'node:path';

const CHROME = 'C:/Program Files/Google/Chrome/Application/chrome.exe';
const PORT = 9333;
const attendre = (ms) => new Promise((r) => setTimeout(r, ms));

async function ouvrir() {
  const profil = fs.mkdtempSync(path.join(os.tmpdir(), 'chrome-'));
  const chrome = spawn(CHROME, ['--headless=new', '--disable-gpu', `--remote-debugging-port=${PORT}`,
    `--user-data-dir=${profil}`, '--window-size=1000,800', '--autoplay-policy=no-user-gesture-required', 'about:blank'],
  { stdio: 'ignore' });
  let cibles;
  for (let k = 0; k < 50 && !cibles; k++) {
    await attendre(200);
    try { cibles = await (await fetch(`http://127.0.0.1:${PORT}/json`)).json(); } catch { /* pas encore prêt */ }
  }
  const page = cibles.find((c) => c.type === 'page');
  const ws = new WebSocket(page.webSocketDebuggerUrl);
  await new Promise((r) => ws.addEventListener('open', r, { once: true }));
  let id = 0;
  const attente = new Map();
  ws.addEventListener('message', (e) => {
    const msg = JSON.parse(e.data);
    if (msg.id && attente.has(msg.id)) { attente.get(msg.id)(msg); attente.delete(msg.id); }
    if (msg.method === 'Runtime.consoleAPICalled') console.log('[console]', msg.params.args.map((a) => a.value ?? a.description).join(' '));
    if (msg.method === 'Runtime.exceptionThrown') console.log('[exception]', msg.params.exceptionDetails.exception?.description);
  });
  const envoyer = (method, params = {}) => new Promise((r) => {
    attente.set(++id, r);
    ws.send(JSON.stringify({ id, method, params }));
  });
  await envoyer('Runtime.enable');
  await envoyer('Page.enable');
  return { envoyer, fermer: () => { ws.close(); chrome.kill(); } };
}

async function principal() {
  const [url, capture = 'navigateur.png', actions = ''] = process.argv.slice(2);
  const { envoyer, fermer } = await ouvrir();
  await envoyer('Page.navigate', { url });
  await attendre(3000);
  const evaluer = async (expr) => (await envoyer('Runtime.evaluate', { expression: expr, returnByValue: true })).result?.result?.value;
  const capturer = async (fichier) => {
    const r = await envoyer('Page.captureScreenshot', { format: 'png' });
    fs.writeFileSync(fichier, Buffer.from(r.result.data, 'base64'));
  };
  const point = async (x, y) => {
    const r = await evaluer(`(() => { const b = document.querySelector('#ecran').getBoundingClientRect(); return [b.left, b.top, b.width, b.height]; })()`);
    return [r[0] + ((x + 0.5) / 320) * r[2], r[1] + ((y + 0.5) / 200) * r[3]];
  };
  for (const action of actions.split(',').filter(Boolean)) {
    const [nom, ...reste] = action.split(':');
    if (nom === 'attendre') await attendre(Number(reste[0]) * 1000);
    else if (nom === 'capture') await capturer(reste.join(':'));
    else if (nom === 'etat') console.log(await evaluer(`document.querySelector('#etat').textContent`));
    else if (nom === 'clic') {
      const [x, y] = await point(Number(reste[0]), Number(reste[1]));
      await envoyer('Input.dispatchMouseEvent', { type: 'mouseMoved', x, y });
      await attendre(150);
      await envoyer('Input.dispatchMouseEvent', { type: 'mousePressed', x, y, button: 'left', clickCount: 1 });
      await attendre(150);
      await envoyer('Input.dispatchMouseEvent', { type: 'mouseReleased', x, y, button: 'left', clickCount: 1 });
      await attendre(300);
    } else if (nom === 'touche') {
      const code = reste[0];
      const key = code === 'Space' ? ' ' : code.replace(/^(Key|Digit)/, '').toLowerCase();
      await envoyer('Input.dispatchKeyEvent', { type: 'keyDown', code, key, text: key.length === 1 ? key : undefined });
      await attendre(100);
      await envoyer('Input.dispatchKeyEvent', { type: 'keyUp', code, key });
      await attendre(300);
    }
  }
  await capturer(capture);
  console.log(await evaluer(`document.querySelector('#etat').textContent`));
  fermer();
}

principal().catch((e) => { console.error(e); process.exit(1); });
