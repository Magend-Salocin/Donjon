// Chargement d'un exécutable compressé par Microsoft EXEPACK (HERO, INTRO, QUEST).
// Même algorithme que exepack_unpack (donjon-v2/bin/extract-heroquest-graphics.py),
// plus la table de relocation, que DOS applique au chargement.

const MESSAGE = 'Packed file is corrupt';

export function decompresser(octets) {
  const vue = new DataView(octets.buffer, octets.byteOffset, octets.byteLength);
  const mot = (p) => vue.getUint16(p, true);
  const entete = mot(8) * 16;
  const image = octets.subarray(entete);
  const segmentCode = mot(22);
  const stub = image.subarray(segmentCode * 16);
  const champ = (k) => stub[2 * k] | (stub[2 * k + 1] << 8);
  if (champ(8) !== 0x4252) throw new Error('signature EXEPACK absente');
  const paragraphes = champ(6);

  const compresse = image.subarray(0, segmentCode * 16);
  const sortie = new Uint8Array(Math.max(paragraphes * 16, compresse.length));
  sortie.set(compresse);
  let src = compresse.length - 1;
  for (let k = 0; k < 16 && sortie[src] === 0xff; k++) src--;
  let dst = paragraphes * 16;
  for (;;) {
    const commande = sortie[src];
    const longueur = sortie[src - 2] | (sortie[src - 1] << 8);
    src -= 3;
    if ((commande & 0xfe) === 0xb0) {
      sortie.fill(sortie[src--], dst - longueur, dst);
      dst -= longueur;
    } else if ((commande & 0xfe) === 0xb2) {
      for (let k = 0; k < longueur; k++) sortie[--dst] = sortie[src--];
    } else {
      throw new Error(`commande EXEPACK inconnue ${commande.toString(16)}`);
    }
    if (commande & 1) break;
  }

  // Table de relocation : 16 segments de 64 Ko, un compte puis les positions.
  const texte = String.fromCharCode(...stub);
  let p = texte.indexOf(MESSAGE) + MESSAGE.length;
  const relocations = [];
  for (let segment = 0; segment < 16; segment++) {
    const n = stub[p] | (stub[p + 1] << 8);
    p += 2;
    for (let k = 0; k < n; k++, p += 2) relocations.push(segment * 0x10000 + (stub[p] | (stub[p + 1] << 8)));
  }

  return {
    image: sortie.subarray(0, paragraphes * 16),
    ip: champ(0), cs: champ(1), sp: champ(4), ss: champ(5),
    relocations,
  };
}
