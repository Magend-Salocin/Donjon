// Codes clavier du PC (jeu 1, positions physiques), comme les lit le port 60h.
// Le jeu lit des positions et non des lettres : sur un clavier AZERTY, la touche A
// donne le code de Q (voir notes/01-socle.md, « Commandes »).

const CODES = {
  Escape: 0x01, Digit1: 0x02, Digit2: 0x03, Digit3: 0x04, Digit4: 0x05, Digit5: 0x06, Digit6: 0x07,
  Digit7: 0x08, Digit8: 0x09, Digit9: 0x0a, Digit0: 0x0b, Minus: 0x0c, Equal: 0x0d, Backspace: 0x0e,
  Tab: 0x0f, KeyQ: 0x10, KeyW: 0x11, KeyE: 0x12, KeyR: 0x13, KeyT: 0x14, KeyY: 0x15, KeyU: 0x16,
  KeyI: 0x17, KeyO: 0x18, KeyP: 0x19, BracketLeft: 0x1a, BracketRight: 0x1b, Enter: 0x1c,
  ControlLeft: 0x1d, ControlRight: 0x1d, KeyA: 0x1e, KeyS: 0x1f, KeyD: 0x20, KeyF: 0x21, KeyG: 0x22,
  KeyH: 0x23, KeyJ: 0x24, KeyK: 0x25, KeyL: 0x26, Semicolon: 0x27, Quote: 0x28, Backquote: 0x29,
  ShiftLeft: 0x2a, Backslash: 0x2b, KeyZ: 0x2c, KeyX: 0x2d, KeyC: 0x2e, KeyV: 0x2f, KeyB: 0x30,
  KeyN: 0x31, KeyM: 0x32, Comma: 0x33, Period: 0x34, Slash: 0x35, ShiftRight: 0x36, AltLeft: 0x38,
  Space: 0x39, F1: 0x3b, F2: 0x3c, F3: 0x3d, F4: 0x3e, F5: 0x3f, F6: 0x40, F7: 0x41, F8: 0x42,
  F9: 0x43, F10: 0x44, ArrowUp: 0x48, ArrowLeft: 0x4b, ArrowRight: 0x4d, ArrowDown: 0x50,
};

export function codeClavier(code) {
  return CODES[code];
}

const ASCII_SPECIAUX = { Enter: 0x0d, Escape: 0x1b, Backspace: 0x08, Tab: 0x09 };

// Caractère rendu par int 16h (AL) : la lettre en majuscule, ou le code ASCII de la touche.
export function asciiDe(evenement) {
  if (evenement.key.length === 1) return evenement.key.toUpperCase().charCodeAt(0) & 0xff;
  return ASCII_SPECIAUX[evenement.key] ?? 0;
}
