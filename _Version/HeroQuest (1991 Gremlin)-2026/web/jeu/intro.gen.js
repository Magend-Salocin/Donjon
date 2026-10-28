// Généré par outils/recompiler.py depuis INTRO.EXE : ne pas modifier.
// Une fonction par routine (nom de original/symboles.txt, adresse d'origine) ;
// elle rend l'IP suivante à la machine dès que l'exécution quitte la routine.
/* eslint-disable */

// 0x0000 sub_44b0
function sub_0000_0000(m, ip) {
  for (;;) {
    if (m.pas <= 0) return ip;
    switch (ip) {
      case 0x0000: m.t += 10; m.pas -= 10; m.push(m.ax);  // push ax
      case 0x0001: m.ax = ((0x0 + m.L) & 0xffff);  // mov ax, 0
      case 0x0004: m.ds = m.ax;  // mov ds, ax
      case 0x0006: { const t = m.pop(); m.ax = t; }  // pop ax
      case 0x0007: m.ax = m.es;  // mov ax, es
      case 0x0009: m.bx = m.ss;  // mov bx, ss
      case 0x000b: m.bx = m.sub16(m.bx, m.ax);  // sub bx, ax
      case 0x000d: m.bx = m.add16(m.bx, 0x68);  // add bx, 0x68
      case 0x0010: m.ax = (m.ax & 0xff) | (0x4a << 8);  // mov ah, 0x4a
      case 0x0012: if (!m.interruption(0x21)) { m.pas = 0; ip = 0x0012; continue; }  // int 0x21
      case 0x0014: m.t += 1; m.pas -= 1; if (!m.cf) { ip = 0x0019; continue; }  // jae 0x19
      case 0x0016: m.t += 1; m.pas -= 1; ip = 0x03cc; continue;  // jmp 0x3cc
      case 0x0019: m.t += 4; m.pas -= 4; m.ww(m.ds, 0x1440, 0x8);  // mov word ptr [0x1440], 8
      case 0x001f: m.xor8(0, 0); m.ax = (m.ax & 0xff) | (0 << 8);  // xor ah, ah
      case 0x0021: m.ax = (m.ax & 0xff00) | 0x3;  // mov al, 3
      case 0x0023: if (!m.interruption(0x10)) { m.pas = 0; ip = 0x0023; continue; }  // int 0x10
      case 0x0025: m.t += 5; m.pas -= 5; m.ww(m.ds, 0x1ba9, 0x2);  // mov word ptr [0x1ba9], 2
      case 0x002b: m.ww(m.ds, 0x1ba5, 0x1440);  // mov word ptr [0x1ba5], 0x1440
      case 0x0031: m.ax = ((0x0 + m.L) & 0xffff);  // mov ax, 0
      case 0x0034: m.ww(m.ds, 0x1ba3, m.ax);  // mov word ptr [0x1ba3], ax
      case 0x0037: m.push(0x003a); ip = 0x2d91; continue;  // call 0x2d91
      case 0x003a: m.t += 1; m.pas -= 1; m.push(0x003d); ip = 0x2b01; continue;  // call 0x2b01
      case 0x003d: m.t += 2; m.pas -= 2; m.sub16(m.rw(m.ds, 0x1a8b), 0x2);  // cmp word ptr [0x1a8b], 2
      case 0x0042: if (!m.zf) { ip = 0x0047; continue; }  // jne 0x47
      case 0x0044: m.t += 1; m.pas -= 1; ip = 0x006b; continue;  // jmp 0x6b
      case 0x0047: m.t += 3; m.pas -= 3; m.dx = 0x34;  // mov dx, 0x34
      case 0x004a: m.ax = (m.ax & 0xff) | (0x9 << 8);  // mov ah, 9
      case 0x004c: if (!m.interruption(0x21)) { m.pas = 0; ip = 0x004c; continue; }  // int 0x21
      case 0x004e: m.t += 1; m.pas -= 1; m.cx = 0xffff;  // mov cx, 0xffff
      case 0x0051: m.t += 2; m.pas -= 2; m.ax = (m.ax & 0xff) | (0x1 << 8);  // mov ah, 1
      case 0x0053: if (!m.interruption(0x16)) { m.pas = 0; ip = 0x0053; continue; }  // int 0x16
      case 0x0055: m.t += 1; m.pas -= 1; if (m.zf) { ip = 0x005f; continue; }  // je 0x5f
      case 0x0057: m.t += 2; m.pas -= 2; m.sub8((m.ax & 0xff), 0x73);  // cmp al, 0x73
      case 0x0059: if (m.zf) { ip = 0x0064; continue; }  // je 0x64
      case 0x005b: m.t += 2; m.pas -= 2; m.sub8((m.ax & 0xff), 0x53);  // cmp al, 0x53
      case 0x005d: if (m.zf) { ip = 0x0064; continue; }  // je 0x64
      case 0x005f: m.t += 1; m.pas -= 1; m.cx = (m.cx - 1) & 0xffff; if (m.cx !== 0) { ip = 0x0051; continue; }  // loop 0x51
      case 0x0061: m.t += 1; m.pas -= 1; ip = 0x01a1; continue;  // jmp 0x1a1
      case 0x0064: m.t += 3; m.pas -= 3; m.dx = 0x2;  // mov dx, 2
      case 0x0067: m.ax = (m.ax & 0xff) | (0x41 << 8);  // mov ah, 0x41
      case 0x0069: if (!m.interruption(0x21)) { m.pas = 0; ip = 0x0069; continue; }  // int 0x21
      case 0x006b: m.t += 3; m.pas -= 3; m.dx = 0xc;  // mov dx, 0xc
      case 0x006e: m.ax = (m.ax & 0xff) | (0x9 << 8);  // mov ah, 9
      case 0x0070: if (!m.interruption(0x21)) { m.pas = 0; ip = 0x0070; continue; }  // int 0x21
      case 0x0072: m.t += 3; m.pas -= 3; m.dx = 0x180f;  // mov dx, 0x180f
      case 0x0075: m.ax = (m.ax & 0xff) | (0x9 << 8);  // mov ah, 9
      case 0x0077: if (!m.interruption(0x21)) { m.pas = 0; ip = 0x0077; continue; }  // int 0x21
      case 0x0079: m.t += 1; m.pas -= 1; m.ww(m.ds, 0x1440, 0x0);  // mov word ptr [0x1440], 0
      case 0x007f: m.t += 2; m.pas -= 2; m.xor8(0, 0); m.ax = (m.ax & 0xff) | (0 << 8);  // xor ah, ah
      case 0x0081: if (!m.interruption(0x16)) { m.pas = 0; ip = 0x0081; continue; }  // int 0x16
      case 0x0083: m.t += 2; m.pas -= 2; m.sub8((m.ax & 0xff), 0x61);  // cmp al, 0x61
      case 0x0085: if (m.cf) { ip = 0x008d; continue; }  // jb 0x8d
      case 0x0087: m.t += 2; m.pas -= 2; m.sub8((m.ax & 0xff), 0x7a);  // cmp al, 0x7a
      case 0x0089: if ((!m.cf && !m.zf)) { ip = 0x008d; continue; }  // ja 0x8d
      case 0x008b: m.t += 1; m.pas -= 1; m.ax = (m.ax & 0xff00) | m.or8((m.ax & 0xff), 0x20);  // or al, 0x20
      case 0x008d: m.t += 2; m.pas -= 2; m.sub8((m.ax & 0xff), 0x31);  // cmp al, 0x31
      case 0x008f: if (!m.zf) { ip = 0x0097; continue; }  // jne 0x97
      case 0x0091: m.t += 1; m.pas -= 1; m.ww(m.ds, 0x1440, 0x8);  // mov word ptr [0x1440], 8
      case 0x0097: m.t += 2; m.pas -= 2; m.sub8((m.ax & 0xff), 0x32);  // cmp al, 0x32
      case 0x0099: if (!m.zf) { ip = 0x00a1; continue; }  // jne 0xa1
      case 0x009b: m.t += 1; m.pas -= 1; m.ww(m.ds, 0x1440, 0x6);  // mov word ptr [0x1440], 6
      case 0x00a1: m.t += 2; m.pas -= 2; m.sub8((m.ax & 0xff), 0x33);  // cmp al, 0x33
      case 0x00a3: if (!m.zf) { ip = 0x00ab; continue; }  // jne 0xab
      case 0x00a5: m.t += 1; m.pas -= 1; m.ww(m.ds, 0x1440, 0x4);  // mov word ptr [0x1440], 4
      case 0x00ab: m.t += 2; m.pas -= 2; m.sub16(m.rw(m.ds, 0x1440), 0x4);  // cmp word ptr [0x1440], 4
      case 0x00b0: if (m.cf) { ip = 0x007f; continue; }  // jb 0x7f
      case 0x00b2: m.t += 3; m.pas -= 3; m.dx = 0x1855;  // mov dx, 0x1855
      case 0x00b5: m.ax = (m.ax & 0xff) | (0x9 << 8);  // mov ah, 9
      case 0x00b7: if (!m.interruption(0x21)) { m.pas = 0; ip = 0x00b7; continue; }  // int 0x21
      case 0x00b9: m.t += 1; m.pas -= 1; m.wb(m.ds, 0x1442, 0xff);  // mov byte ptr [0x1442], 0xff
      case 0x00be: m.t += 2; m.pas -= 2; m.xor8(0, 0); m.ax = (m.ax & 0xff) | (0 << 8);  // xor ah, ah
      case 0x00c0: if (!m.interruption(0x16)) { m.pas = 0; ip = 0x00c0; continue; }  // int 0x16
      case 0x00c2: m.t += 2; m.pas -= 2; m.sub8((m.ax & 0xff), 0x61);  // cmp al, 0x61
      case 0x00c4: if (m.cf) { ip = 0x00cc; continue; }  // jb 0xcc
      case 0x00c6: m.t += 2; m.pas -= 2; m.sub8((m.ax & 0xff), 0x7a);  // cmp al, 0x7a
      case 0x00c8: if ((!m.cf && !m.zf)) { ip = 0x00cc; continue; }  // ja 0xcc
      case 0x00ca: m.t += 1; m.pas -= 1; m.ax = (m.ax & 0xff00) | m.or8((m.ax & 0xff), 0x20);  // or al, 0x20
      case 0x00cc: m.t += 2; m.pas -= 2; m.sub8((m.ax & 0xff), 0x31);  // cmp al, 0x31
      case 0x00ce: if (!m.zf) { ip = 0x00d5; continue; }  // jne 0xd5
      case 0x00d0: m.t += 1; m.pas -= 1; m.wb(m.ds, 0x1442, 0x0);  // mov byte ptr [0x1442], 0
      case 0x00d5: m.t += 2; m.pas -= 2; m.sub8((m.ax & 0xff), 0x32);  // cmp al, 0x32
      case 0x00d7: if (!m.zf) { ip = 0x00de; continue; }  // jne 0xde
      case 0x00d9: m.t += 1; m.pas -= 1; m.wb(m.ds, 0x1442, 0x1);  // mov byte ptr [0x1442], 1
      case 0x00de: m.t += 2; m.pas -= 2; m.sub8((m.ax & 0xff), 0x33);  // cmp al, 0x33
      case 0x00e0: if (!m.zf) { ip = 0x00e7; continue; }  // jne 0xe7
      case 0x00e2: m.t += 1; m.pas -= 1; m.wb(m.ds, 0x1442, 0x2);  // mov byte ptr [0x1442], 2
      case 0x00e7: m.t += 2; m.pas -= 2; m.sub8(m.rb(m.ds, 0x1442), 0xff);  // cmp byte ptr [0x1442], 0xff
      case 0x00ec: if (m.zf) { ip = 0x00be; continue; }  // je 0xbe
      case 0x00ee: m.t += 2; m.pas -= 2; m.sub8(m.rb(m.ds, 0x1442), 0x0);  // cmp byte ptr [0x1442], 0
      case 0x00f3: if (!m.zf) { ip = 0x0101; continue; }  // jne 0x101
      case 0x00f5: m.t += 2; m.pas -= 2; m.sub16(m.rw(m.ds, 0x1440), 0x4);  // cmp word ptr [0x1440], 4
      case 0x00fa: if (!m.zf) { ip = 0x0101; continue; }  // jne 0x101
      case 0x00fc: m.t += 1; m.pas -= 1; m.wb(m.ds, 0x1442, 0x3);  // mov byte ptr [0x1442], 3
      case 0x0101: m.t += 3; m.pas -= 3; m.dx = 0x1292;  // mov dx, 0x1292
      case 0x0104: m.ax = (m.ax & 0xff) | (0x9 << 8);  // mov ah, 9
      case 0x0106: if (!m.interruption(0x21)) { m.pas = 0; ip = 0x0106; continue; }  // int 0x21
      case 0x0108: m.t += 1; m.pas -= 1; m.wb(m.ds, 0x1443, 0xff);  // mov byte ptr [0x1443], 0xff
      case 0x010d: m.t += 2; m.pas -= 2; m.xor8(0, 0); m.ax = (m.ax & 0xff) | (0 << 8);  // xor ah, ah
      case 0x010f: if (!m.interruption(0x16)) { m.pas = 0; ip = 0x010f; continue; }  // int 0x16
      case 0x0111: m.t += 2; m.pas -= 2; m.sub8((m.ax & 0xff), 0x61);  // cmp al, 0x61
      case 0x0113: if (m.cf) { ip = 0x011b; continue; }  // jb 0x11b
      case 0x0115: m.t += 2; m.pas -= 2; m.sub8((m.ax & 0xff), 0x7a);  // cmp al, 0x7a
      case 0x0117: if ((!m.cf && !m.zf)) { ip = 0x011b; continue; }  // ja 0x11b
      case 0x0119: m.t += 1; m.pas -= 1; m.ax = (m.ax & 0xff00) | m.or8((m.ax & 0xff), 0x20);  // or al, 0x20
      case 0x011b: m.t += 2; m.pas -= 2; m.sub8((m.ax & 0xff), 0x31);  // cmp al, 0x31
      case 0x011d: if (m.zf) { ip = 0x0127; continue; }  // je 0x127
      case 0x011f: m.t += 2; m.pas -= 2; m.sub8((m.ax & 0xff), 0x32);  // cmp al, 0x32
      case 0x0121: if (m.zf) { ip = 0x0127; continue; }  // je 0x127
      case 0x0123: m.t += 2; m.pas -= 2; m.sub8((m.ax & 0xff), 0x33);  // cmp al, 0x33
      case 0x0125: if (!m.zf) { ip = 0x010d; continue; }  // jne 0x10d
      case 0x0127: m.t += 6; m.pas -= 6; m.ax = (m.ax & 0xff00) | m.sub8((m.ax & 0xff), 0x31);  // sub al, 0x31
      case 0x0129: m.wb(m.ds, 0x1443, (m.ax & 0xff));  // mov byte ptr [0x1443], al
      case 0x012c: m.wb(m.ds, 0x1445, (m.ax & 0xff));  // mov byte ptr [0x1445], al
      case 0x012f: m.dx = 0x12da;  // mov dx, 0x12da
      case 0x0132: m.ax = (m.ax & 0xff) | (0x9 << 8);  // mov ah, 9
      case 0x0134: if (!m.interruption(0x21)) { m.pas = 0; ip = 0x0134; continue; }  // int 0x21
      case 0x0136: m.t += 2; m.pas -= 2; m.xor8(0, 0); m.ax = (m.ax & 0xff) | (0 << 8);  // xor ah, ah
      case 0x0138: if (!m.interruption(0x16)) { m.pas = 0; ip = 0x0138; continue; }  // int 0x16
      case 0x013a: m.t += 2; m.pas -= 2; m.sub8((m.ax & 0xff), 0x61);  // cmp al, 0x61
      case 0x013c: if (m.cf) { ip = 0x0144; continue; }  // jb 0x144
      case 0x013e: m.t += 2; m.pas -= 2; m.sub8((m.ax & 0xff), 0x7a);  // cmp al, 0x7a
      case 0x0140: if ((!m.cf && !m.zf)) { ip = 0x0144; continue; }  // ja 0x144
      case 0x0142: m.t += 1; m.pas -= 1; m.ax = (m.ax & 0xff00) | m.or8((m.ax & 0xff), 0x20);  // or al, 0x20
      case 0x0144: m.t += 2; m.pas -= 2; m.sub8((m.ax & 0xff), 0x31);  // cmp al, 0x31
      case 0x0146: if (m.zf) { ip = 0x0150; continue; }  // je 0x150
      case 0x0148: m.t += 2; m.pas -= 2; m.sub8((m.ax & 0xff), 0x32);  // cmp al, 0x32
      case 0x014a: if (m.zf) { ip = 0x0150; continue; }  // je 0x150
      case 0x014c: m.t += 2; m.pas -= 2; m.sub8((m.ax & 0xff), 0x33);  // cmp al, 0x33
      case 0x014e: if (!m.zf) { ip = 0x0136; continue; }  // jne 0x136
      case 0x0150: m.t += 5; m.pas -= 5; m.ax = (m.ax & 0xff00) | m.sub8((m.ax & 0xff), 0x31);  // sub al, 0x31
      case 0x0152: m.wb(m.ds, 0x1446, (m.ax & 0xff));  // mov byte ptr [0x1446], al
      case 0x0155: m.dx = 0x131e;  // mov dx, 0x131e
      case 0x0158: m.ax = (m.ax & 0xff) | (0x9 << 8);  // mov ah, 9
      case 0x015a: if (!m.interruption(0x21)) { m.pas = 0; ip = 0x015a; continue; }  // int 0x21
      case 0x015c: m.t += 2; m.pas -= 2; m.xor8(0, 0); m.ax = (m.ax & 0xff) | (0 << 8);  // xor ah, ah
      case 0x015e: if (!m.interruption(0x16)) { m.pas = 0; ip = 0x015e; continue; }  // int 0x16
      case 0x0160: m.t += 2; m.pas -= 2; m.sub8((m.ax & 0xff), 0x61);  // cmp al, 0x61
      case 0x0162: if (m.cf) { ip = 0x016a; continue; }  // jb 0x16a
      case 0x0164: m.t += 2; m.pas -= 2; m.sub8((m.ax & 0xff), 0x7a);  // cmp al, 0x7a
      case 0x0166: if ((!m.cf && !m.zf)) { ip = 0x016a; continue; }  // ja 0x16a
      case 0x0168: m.t += 1; m.pas -= 1; m.ax = (m.ax & 0xff00) | m.or8((m.ax & 0xff), 0x20);  // or al, 0x20
      case 0x016a: m.t += 2; m.pas -= 2; m.sub8((m.ax & 0xff), 0x31);  // cmp al, 0x31
      case 0x016c: if (m.zf) { ip = 0x0176; continue; }  // je 0x176
      case 0x016e: m.t += 2; m.pas -= 2; m.sub8((m.ax & 0xff), 0x32);  // cmp al, 0x32
      case 0x0170: if (m.zf) { ip = 0x0176; continue; }  // je 0x176
      case 0x0172: m.t += 2; m.pas -= 2; m.sub8((m.ax & 0xff), 0x33);  // cmp al, 0x33
      case 0x0174: if (!m.zf) { ip = 0x015c; continue; }  // jne 0x15c
      case 0x0176: m.t += 5; m.pas -= 5; m.ax = (m.ax & 0xff00) | m.sub8((m.ax & 0xff), 0x31);  // sub al, 0x31
      case 0x0178: m.wb(m.ds, 0x1447, (m.ax & 0xff));  // mov byte ptr [0x1447], al
      case 0x017b: m.dx = 0x135c;  // mov dx, 0x135c
      case 0x017e: m.ax = (m.ax & 0xff) | (0x9 << 8);  // mov ah, 9
      case 0x0180: if (!m.interruption(0x21)) { m.pas = 0; ip = 0x0180; continue; }  // int 0x21
      case 0x0182: m.t += 2; m.pas -= 2; m.xor8(0, 0); m.ax = (m.ax & 0xff) | (0 << 8);  // xor ah, ah
      case 0x0184: if (!m.interruption(0x16)) { m.pas = 0; ip = 0x0184; continue; }  // int 0x16
      case 0x0186: m.t += 2; m.pas -= 2; m.sub8((m.ax & 0xff), 0x61);  // cmp al, 0x61
      case 0x0188: if (m.cf) { ip = 0x0190; continue; }  // jb 0x190
      case 0x018a: m.t += 2; m.pas -= 2; m.sub8((m.ax & 0xff), 0x7a);  // cmp al, 0x7a
      case 0x018c: if ((!m.cf && !m.zf)) { ip = 0x0190; continue; }  // ja 0x190
      case 0x018e: m.t += 1; m.pas -= 1; m.ax = (m.ax & 0xff00) | m.or8((m.ax & 0xff), 0x20);  // or al, 0x20
      case 0x0190: m.t += 2; m.pas -= 2; m.sub8((m.ax & 0xff), 0x31);  // cmp al, 0x31
      case 0x0192: if (m.zf) { ip = 0x019c; continue; }  // je 0x19c
      case 0x0194: m.t += 2; m.pas -= 2; m.sub8((m.ax & 0xff), 0x32);  // cmp al, 0x32
      case 0x0196: if (m.zf) { ip = 0x019c; continue; }  // je 0x19c
      case 0x0198: m.t += 2; m.pas -= 2; m.sub8((m.ax & 0xff), 0x33);  // cmp al, 0x33
      case 0x019a: if (!m.zf) { ip = 0x0182; continue; }  // jne 0x182
      case 0x019c: m.t += 2; m.pas -= 2; m.ax = (m.ax & 0xff00) | m.sub8((m.ax & 0xff), 0x31);  // sub al, 0x31
      case 0x019e: m.wb(m.ds, 0x1448, (m.ax & 0xff));  // mov byte ptr [0x1448], al
      case 0x01a1: m.t += 1; m.pas -= 1; m.push(0x01a4); ip = 0x0975; continue;  // call 0x975
      case 0x01a4: m.t += 5; m.pas -= 5; m.wb(m.ds, 0x19fb, 0x1);  // mov byte ptr [0x19fb], 1
      case 0x01a9: m.wb(m.ds, 0x19f2, 0x6);  // mov byte ptr [0x19f2], 6
      case 0x01ae: m.ax = ((0xa86 + m.L) & 0xffff);  // mov ax, 0xa86
      case 0x01b1: m.ww(m.ds, 0x19f8, m.ax);  // mov word ptr [0x19f8], ax
      case 0x01b4: m.push(0x01b7); ip = 0x3ab7; continue;  // call 0x3ab7
      case 0x01b7: m.t += 1; m.pas -= 1; m.push(0x01ba); ip = 0x3bb2; continue;  // call 0x3bb2
      case 0x01ba: m.t += 1; m.pas -= 1; m.push(0x01bd); ip = 0x3c1a; continue;  // call 0x3c1a
      case 0x01bd: m.t += 2; m.pas -= 2; m.sub16(m.rw(m.ds, 0x1440), 0x8);  // cmp word ptr [0x1440], 8
      case 0x01c2: if (m.zf) { ip = 0x01c7; continue; }  // je 0x1c7
      case 0x01c4: m.t += 1; m.pas -= 1; ip = 0x03d7; continue;  // jmp 0x3d7
      case 0x01c7: m.t += 5; m.pas -= 5; m.ww(m.ds, 0x1ba9, 0xb2);  // mov word ptr [0x1ba9], 0xb2
      case 0x01cd: m.ww(m.ds, 0x1ba5, 0x0);  // mov word ptr [0x1ba5], 0
      case 0x01d3: m.ax = ((0x1a26 + m.L) & 0xffff);  // mov ax, 0x1a26
      case 0x01d6: m.ww(m.ds, 0x1ba3, m.ax);  // mov word ptr [0x1ba3], ax
      case 0x01d9: m.push(0x01dc); ip = 0x2d91; continue;  // call 0x2d91
      case 0x01dc: m.t += 5; m.pas -= 5; m.ww(m.ds, 0x1ba9, 0xbe);  // mov word ptr [0x1ba9], 0xbe
      case 0x01e2: m.ww(m.ds, 0x1ba5, 0x0);  // mov word ptr [0x1ba5], 0
      case 0x01e8: m.ax = ((0x2523 + m.L) & 0xffff);  // mov ax, 0x2523
      case 0x01eb: m.ww(m.ds, 0x1ba3, m.ax);  // mov word ptr [0x1ba3], ax
      case 0x01ee: m.push(0x01f1); ip = 0x2d91; continue;  // call 0x2d91
      case 0x01f1: m.t += 2; m.pas -= 2; m.dx = 0xc5e;  // mov dx, 0xc5e
      case 0x01f4: m.push(0x01f7); ip = 0x0993; continue;  // call 0x993
      case 0x01f7: m.t += 2; m.pas -= 2; m.di = 0xcbe;  // mov di, 0xcbe
      case 0x01fa: m.push(0x01fd); ip = 0x0a1d; continue;  // call 0xa1d
      case 0x01fd: m.t += 2; m.pas -= 2; m.cx = 0x7d0;  // mov cx, 0x7d0
      case 0x0200: m.push(0x0203); ip = 0x3a93; continue;  // call 0x3a93
      case 0x0203: m.t += 5; m.pas -= 5; m.ww(m.ds, 0x1ba9, 0xc8);  // mov word ptr [0x1ba9], 0xc8
      case 0x0209: m.ww(m.ds, 0x1ba5, 0x0);  // mov word ptr [0x1ba5], 0
      case 0x020f: m.ax = ((0x1a26 + m.L) & 0xffff);  // mov ax, 0x1a26
      case 0x0212: m.ww(m.ds, 0x1ba3, m.ax);  // mov word ptr [0x1ba3], ax
      case 0x0215: m.push(0x0218); ip = 0x2d91; continue;  // call 0x2d91
      case 0x0218: m.t += 2; m.pas -= 2; m.di = 0xd1e;  // mov di, 0xd1e
      case 0x021b: m.push(0x021e); ip = 0x0a1d; continue;  // call 0xa1d
      case 0x021e: m.t += 1; m.pas -= 1; m.push(0x0221); ip = 0x0a6b; continue;  // call 0xa6b
      case 0x0221: m.t += 2; m.pas -= 2; m.sub8((m.ax & 0xff), 0x1);  // cmp al, 1
      case 0x0223: if (!m.zf) { ip = 0x0228; continue; }  // jne 0x228
      case 0x0225: m.t += 1; m.pas -= 1; ip = 0x0289; continue;  // jmp 0x289
      case 0x0228: m.t += 2; m.pas -= 2; m.bp = 0xfd;  // mov bp, 0xfd
      case 0x022b: m.push(0x022e); ip = 0x09ab; continue;  // call 0x9ab
      case 0x022e: m.t += 2; m.pas -= 2; m.sub8((m.ax & 0xff), 0x1);  // cmp al, 1
      case 0x0230: if (!m.zf) { ip = 0x0235; continue; }  // jne 0x235
      case 0x0232: m.t += 1; m.pas -= 1; ip = 0x0289; continue;  // jmp 0x289
      case 0x0235: m.t += 2; m.pas -= 2; m.cx = 0x6;  // mov cx, 6
      case 0x0238: m.ww(m.ds, 0x0, 0x0);  // mov word ptr [0], 0
      case 0x023e: m.t += 8; m.pas -= 8; m.push(m.cx);  // push cx
      case 0x023f: m.bx = m.rw(m.ds, 0x0);  // mov bx, word ptr [0]
      case 0x0243: m.dx = m.rw(m.ds, ((m.bx + 0x6a) & 0xffff));  // mov dx, word ptr [bx + 0x6a]
      case 0x0247: m.ww(m.ds, 0x1ba9, m.dx);  // mov word ptr [0x1ba9], dx
      case 0x024b: m.ww(m.ds, 0x1ba5, 0x0);  // mov word ptr [0x1ba5], 0
      case 0x0251: m.ax = ((0x1a26 + m.L) & 0xffff);  // mov ax, 0x1a26
      case 0x0254: m.ww(m.ds, 0x1ba3, m.ax);  // mov word ptr [0x1ba3], ax
      case 0x0257: m.push(0x025a); ip = 0x2d91; continue;  // call 0x2d91
      case 0x025a: m.t += 3; m.pas -= 3; m.bx = m.rw(m.ds, 0x0);  // mov bx, word ptr [0]
      case 0x025e: m.di = m.rw(m.ds, ((m.bx + 0x5e) & 0xffff));  // mov di, word ptr [bx + 0x5e]
      case 0x0262: m.push(0x0265); ip = 0x0a1d; continue;  // call 0xa1d
      case 0x0265: m.t += 2; m.pas -= 2; m.bx = m.rw(m.ds, 0x0);  // mov bx, word ptr [0]
      case 0x0269: m.push(0x026c); ip = 0x055c; continue;  // call 0x55c
      case 0x026c: m.t += 3; m.pas -= 3; m.bx = m.rw(m.ds, 0x0);  // mov bx, word ptr [0]
      case 0x0270: m.bp = m.rw(m.ds, ((m.bx + 0x52) & 0xffff));  // mov bp, word ptr [bx + 0x52]
      case 0x0274: m.push(0x0277); ip = 0x09ab; continue;  // call 0x9ab
      case 0x0277: m.t += 3; m.pas -= 3; { const t = m.pop(); m.cx = t; }  // pop cx
      case 0x0278: m.sub8((m.ax & 0xff), 0x1);  // cmp al, 1
      case 0x027a: if (!m.zf) { ip = 0x027f; continue; }  // jne 0x27f
      case 0x027c: m.t += 1; m.pas -= 1; ip = 0x0289; continue;  // jmp 0x289
      case 0x027f: m.t += 2; m.pas -= 2; m.ww(m.ds, 0x0, m.add16(m.rw(m.ds, 0x0), 0x2));  // add word ptr [0], 2
      case 0x0284: m.cx = (m.cx - 1) & 0xffff; if (m.cx !== 0) { ip = 0x023e; continue; }  // loop 0x23e
      case 0x0286: m.t += 1; m.pas -= 1; m.push(0x0289); ip = 0x0b0f; continue;  // call 0xb0f
      case 0x0289: m.t += 5; m.pas -= 5; m.ww(m.ds, 0x1ba9, 0x2);  // mov word ptr [0x1ba9], 2
      case 0x028f: m.ww(m.ds, 0x1ba5, 0x1440);  // mov word ptr [0x1ba5], 0x1440
      case 0x0295: m.ax = ((0x0 + m.L) & 0xffff);  // mov ax, 0
      case 0x0298: m.ww(m.ds, 0x1ba3, m.ax);  // mov word ptr [0x1ba3], ax
      case 0x029b: m.push(0x029e); ip = 0x2d91; continue;  // call 0x2d91
      case 0x029e: m.t += 2; m.pas -= 2; m.sub16(m.rw(m.ds, 0x1a8b), 0x2);  // cmp word ptr [0x1a8b], 2
      case 0x02a3: if (m.zf) { ip = 0x02a8; continue; }  // je 0x2a8
      case 0x02a5: m.t += 1; m.pas -= 1; ip = 0x03c6; continue;  // jmp 0x3c6
      case 0x02a8: m.t += 4; m.pas -= 4; m.ax = m.rw(m.ds, 0x1440);  // mov ax, word ptr [0x1440]
      case 0x02ab: m.ww(m.ds, 0x10a2, m.ax);  // mov word ptr [0x10a2], ax
      case 0x02ae: m.sub16(m.ax, 0x8);  // cmp ax, 8
      case 0x02b1: if (!m.zf) { ip = 0x02b9; continue; }  // jne 0x2b9
      case 0x02b3: m.t += 1; m.pas -= 1; m.ww(m.ds, 0x1440, 0x6);  // mov word ptr [0x1440], 6
      case 0x02b9: m.t += 1; m.pas -= 1; m.push(0x02bc); ip = 0x054c; continue;  // call 0x54c
      case 0x02bc: m.t += 1; m.pas -= 1; m.push(0x02bf); ip = 0x0975; continue;  // call 0x975
      case 0x02bf: m.t += 5; m.pas -= 5; m.ww(m.ds, 0x1ba9, 0xe6);  // mov word ptr [0x1ba9], 0xe6
      case 0x02c5: m.ww(m.ds, 0x1ba5, 0x0);  // mov word ptr [0x1ba5], 0
      case 0x02cb: m.ax = ((0x1a26 + m.L) & 0xffff);  // mov ax, 0x1a26
      case 0x02ce: m.ww(m.ds, 0x1ba3, m.ax);  // mov word ptr [0x1ba3], ax
      case 0x02d1: m.push(0x02d4); ip = 0x2d91; continue;  // call 0x2d91
      case 0x02d4: m.t += 1; m.pas -= 1; m.push(0x02d7); ip = 0x2b01; continue;  // call 0x2b01
      case 0x02d7: m.t += 12; m.pas -= 12; m.push(m.ax);  // push ax
      case 0x02d8: m.ax = ((0xa86 + m.L) & 0xffff);  // mov ax, 0xa86
      case 0x02db: m.es = m.ax;  // mov es, ax
      case 0x02dd: { const t = m.pop(); m.ax = t; }  // pop ax
      case 0x02de: m.push(m.ax);  // push ax
      case 0x02df: m.ax = ((0x1a26 + m.L) & 0xffff);  // mov ax, 0x1a26
      case 0x02e2: m.ds = m.ax;  // mov ds, ax
      case 0x02e4: { const t = m.pop(); m.ax = t; }  // pop ax
      case 0x02e5: m.xor16(0, 0); m.di = 0;  // xor di, di
      case 0x02e7: m.si = m.di;  // mov si, di
      case 0x02e9: m.cx = 0x7d00;  // mov cx, 0x7d00
      case 0x02ec: m.push(0x02ef); ip = 0x39dd; continue;  // call 0x39dd
      case 0x02ef: m.t += 6; m.pas -= 6; m.push(m.ax);  // push ax
      case 0x02f0: m.ax = ((0x0 + m.L) & 0xffff);  // mov ax, 0
      case 0x02f3: m.ds = m.ax;  // mov ds, ax
      case 0x02f5: { const t = m.pop(); m.ax = t; }  // pop ax
      case 0x02f6: m.sub16(m.rw(m.ds, 0x1440), 0x4);  // cmp word ptr [0x1440], 4
      case 0x02fb: if (m.zf) { ip = 0x0306; continue; }  // je 0x306
      case 0x02fd: m.t += 1; m.pas -= 1; m.push(0x0300); ip = 0x04d0; continue;  // call 0x4d0
      case 0x0300: m.t += 2; m.pas -= 2; m.dx = 0x1080;  // mov dx, 0x1080
      case 0x0303: ip = 0x030c; continue;  // jmp 0x30c
      case 0x0306: m.t += 1; m.pas -= 1; m.push(0x0309); ip = 0x0b3d; continue;  // call 0xb3d
      case 0x0309: m.t += 1; m.pas -= 1; m.dx = 0x1091;  // mov dx, 0x1091
      case 0x030c: m.t += 6; m.pas -= 6; m.ax = 0x1002;  // mov ax, 0x1002
      case 0x030f: m.push(m.ax);  // push ax
      case 0x0310: m.ax = ((0x0 + m.L) & 0xffff);  // mov ax, 0
      case 0x0313: m.es = m.ax;  // mov es, ax
      case 0x0315: { const t = m.pop(); m.ax = t; }  // pop ax
      case 0x0316: if (!m.interruption(0x10)) { m.pas = 0; ip = 0x0316; continue; }  // int 0x10
      case 0x0318: m.t += 2; m.pas -= 2; m.ax = (m.ax & 0xff) | (0x0 << 8);  // mov ah, 0
      case 0x031a: if (!m.interruption(0x16)) { m.pas = 0; ip = 0x031a; continue; }  // int 0x16
      case 0x031c: m.t += 3; m.pas -= 3; m.wb(m.ds, 0x1444, 0x0);  // mov byte ptr [0x1444], 0
      case 0x0321: m.sub8((m.ax >> 8), 0x12);  // cmp ah, 0x12
      case 0x0324: if (m.zf) { ip = 0x034e; continue; }  // je 0x34e
      case 0x0326: m.t += 3; m.pas -= 3; m.wb(m.ds, 0x1444, 0x1);  // mov byte ptr [0x1444], 1
      case 0x032b: m.sub8((m.ax >> 8), 0x21);  // cmp ah, 0x21
      case 0x032e: if (m.zf) { ip = 0x034e; continue; }  // je 0x34e
      case 0x0330: m.t += 3; m.pas -= 3; m.wb(m.ds, 0x1444, 0x2);  // mov byte ptr [0x1444], 2
      case 0x0335: m.sub8((m.ax >> 8), 0x1f);  // cmp ah, 0x1f
      case 0x0338: if (m.zf) { ip = 0x034e; continue; }  // je 0x34e
      case 0x033a: m.t += 3; m.pas -= 3; m.wb(m.ds, 0x1444, 0x3);  // mov byte ptr [0x1444], 3
      case 0x033f: m.sub8((m.ax >> 8), 0x22);  // cmp ah, 0x22
      case 0x0342: if (m.zf) { ip = 0x034e; continue; }  // je 0x34e
      case 0x0344: m.t += 3; m.pas -= 3; m.wb(m.ds, 0x1444, 0x4);  // mov byte ptr [0x1444], 4
      case 0x0349: m.sub8((m.ax >> 8), 0x17);  // cmp ah, 0x17
      case 0x034c: if (!m.zf) { ip = 0x0318; continue; }  // jne 0x318
      case 0x034e: m.t += 5; m.pas -= 5; m.ax = m.rw(m.ds, 0x10a2);  // mov ax, word ptr [0x10a2]
      case 0x0351: m.ww(m.ds, 0x1440, m.ax);  // mov word ptr [0x1440], ax
      case 0x0354: m.xor8(0, 0); m.ax = (m.ax & 0xff) | (0 << 8);  // xor ah, ah
      case 0x0356: m.ax = (m.ax & 0xff00) | 0x3;  // mov al, 3
      case 0x0358: if (!m.interruption(0x10)) { m.pas = 0; ip = 0x0358; continue; }  // int 0x10
      case 0x035a: m.t += 6; m.pas -= 6; m.ww(m.ds, 0x1ba9, 0x2);  // mov word ptr [0x1ba9], 2
      case 0x0360: m.ww(m.ds, 0x1ba5, 0x1440);  // mov word ptr [0x1ba5], 0x1440
      case 0x0366: m.ww(m.ds, 0x1ba7, 0x9);  // mov word ptr [0x1ba7], 9
      case 0x036c: m.ax = ((0x0 + m.L) & 0xffff);  // mov ax, 0
      case 0x036f: m.ww(m.ds, 0x1ba3, m.ax);  // mov word ptr [0x1ba3], ax
      case 0x0372: m.push(0x0375); ip = 0x2db0; continue;  // call 0x2db0
      case 0x0375: m.t += 1; m.pas -= 1; m.push(0x0378); ip = 0x2b01; continue;  // call 0x2b01
      case 0x0378: m.t += 4; m.pas -= 4; m.dx = 0x142b;  // mov dx, 0x142b
      case 0x037b: m.xor8(0, 0); m.ax = (m.ax & 0xff00) | 0;  // xor al, al
      case 0x037d: m.ax = (m.ax & 0xff) | (0x3d << 8);  // mov ah, 0x3d
      case 0x037f: if (!m.interruption(0x21)) { m.pas = 0; ip = 0x037f; continue; }  // int 0x21
      case 0x0381: m.t += 1; m.pas -= 1; if (m.cf) { ip = 0x038c; continue; }  // jb 0x38c
      case 0x0383: m.t += 3; m.pas -= 3; m.bx = m.ax;  // mov bx, ax
      case 0x0385: m.ax = (m.ax & 0xff) | (0x3e << 8);  // mov ah, 0x3e
      case 0x0387: if (!m.interruption(0x21)) { m.pas = 0; ip = 0x0387; continue; }  // int 0x21
      case 0x0389: m.t += 1; m.pas -= 1; ip = 0x03c6; continue;  // jmp 0x3c6
      case 0x038c: m.t += 3; m.pas -= 3; m.dx = 0x139d;  // mov dx, 0x139d
      case 0x038f: m.ax = (m.ax & 0xff) | (0x9 << 8);  // mov ah, 9
      case 0x0391: if (!m.interruption(0x21)) { m.pas = 0; ip = 0x0391; continue; }  // int 0x21
      case 0x0393: m.t += 2; m.pas -= 2; m.ax = (m.ax & 0xff) | (0x0 << 8);  // mov ah, 0
      case 0x0395: if (!m.interruption(0x16)) { m.pas = 0; ip = 0x0395; continue; }  // int 0x16
      case 0x0397: m.t += 4; m.pas -= 4; m.dx = 0x142b;  // mov dx, 0x142b
      case 0x039a: m.xor8(0, 0); m.ax = (m.ax & 0xff00) | 0;  // xor al, al
      case 0x039c: m.ax = (m.ax & 0xff) | (0x3d << 8);  // mov ah, 0x3d
      case 0x039e: if (!m.interruption(0x21)) { m.pas = 0; ip = 0x039e; continue; }  // int 0x21
      case 0x03a0: m.t += 1; m.pas -= 1; if (m.cf) { ip = 0x038c; continue; }  // jb 0x38c
      case 0x03a2: m.t += 3; m.pas -= 3; m.bx = m.ax;  // mov bx, ax
      case 0x03a4: m.ax = (m.ax & 0xff) | (0x3e << 8);  // mov ah, 0x3e
      case 0x03a6: if (!m.interruption(0x21)) { m.pas = 0; ip = 0x03a6; continue; }  // int 0x21
      case 0x03a8: m.t += 6; m.pas -= 6; m.ww(m.ds, 0x1ba9, 0x2);  // mov word ptr [0x1ba9], 2
      case 0x03ae: m.ww(m.ds, 0x1ba5, 0x1440);  // mov word ptr [0x1ba5], 0x1440
      case 0x03b4: m.ww(m.ds, 0x1ba7, 0x9);  // mov word ptr [0x1ba7], 9
      case 0x03ba: m.ax = ((0x0 + m.L) & 0xffff);  // mov ax, 0
      case 0x03bd: m.ww(m.ds, 0x1ba3, m.ax);  // mov word ptr [0x1ba3], ax
      case 0x03c0: m.push(0x03c3); ip = 0x2db0; continue;  // call 0x2db0
      case 0x03c3: m.t += 1; m.pas -= 1; m.push(0x03c6); ip = 0x2b01; continue;  // call 0x2b01
      case 0x03c6: m.t += 1; m.pas -= 1; m.push(0x03c9); ip = 0x2b01; continue;  // call 0x2b01
      case 0x03c9: m.t += 1; m.pas -= 1; m.push(0x03cc); ip = 0x3b7a; continue;  // call 0x3b7a
      case 0x03cc: m.t += 3; m.pas -= 3; m.xor8(0, 0); m.ax = (m.ax & 0xff) | (0 << 8);  // xor ah, ah
      case 0x03ce: m.ax = (m.ax & 0xff00) | 0x3;  // mov al, 3
      case 0x03d0: if (!m.interruption(0x10)) { m.pas = 0; ip = 0x03d0; continue; }  // int 0x10
      case 0x03d2: m.t += 2; m.pas -= 2; m.ax = 0x4c00;  // mov ax, 0x4c00
      case 0x03d5: if (!m.interruption(0x21)) { m.pas = 0; ip = 0x03d5; continue; }  // int 0x21
      case 0x03d7: m.t += 2; m.pas -= 2; m.wb(m.ds, 0x19f2, 0x7);  // mov byte ptr [0x19f2], 7
      case 0x03dc: m.push(0x03df); ip = 0x054c; continue;  // call 0x54c
      case 0x03df: m.t += 5; m.pas -= 5; m.ww(m.ds, 0x1ba9, 0xdb);  // mov word ptr [0x1ba9], 0xdb
      case 0x03e5: m.ww(m.ds, 0x1ba5, 0x0);  // mov word ptr [0x1ba5], 0
      case 0x03eb: m.ax = ((0x1a26 + m.L) & 0xffff);  // mov ax, 0x1a26
      case 0x03ee: m.ww(m.ds, 0x1ba3, m.ax);  // mov word ptr [0x1ba3], ax
      case 0x03f1: m.push(0x03f4); ip = 0x2d91; continue;  // call 0x2d91
      case 0x03f4: m.t += 8; m.pas -= 8; m.ax = ((0x2e23 + m.L) & 0xffff);  // mov ax, 0x2e23
      case 0x03f7: m.es = m.ax;  // mov es, ax
      case 0x03f9: m.xor16(0, 0); m.si = 0;  // xor si, si
      case 0x03fb: m.di = 0x0;  // mov di, 0
      case 0x03fe: m.ax = ((0x1a26 + m.L) & 0xffff);  // mov ax, 0x1a26
      case 0x0401: m.ds = m.ax;  // mov ds, ax
      case 0x0403: m.cx = 0xffff;  // mov cx, 0xffff
      case 0x0406: m.push(0x0409); ip = 0x39dd; continue;  // call 0x39dd
      case 0x0409: m.t += 9; m.pas -= 9; m.push(m.ax);  // push ax
      case 0x040a: m.ax = ((0x0 + m.L) & 0xffff);  // mov ax, 0
      case 0x040d: m.ds = m.ax;  // mov ds, ax
      case 0x040f: { const t = m.pop(); m.ax = t; }  // pop ax
      case 0x0410: m.ww(m.ds, 0x1ba9, 0xf0);  // mov word ptr [0x1ba9], 0xf0
      case 0x0416: m.ww(m.ds, 0x1ba5, 0x0);  // mov word ptr [0x1ba5], 0
      case 0x041c: m.ax = ((0x1a26 + m.L) & 0xffff);  // mov ax, 0x1a26
      case 0x041f: m.ww(m.ds, 0x1ba3, m.ax);  // mov word ptr [0x1ba3], ax
      case 0x0422: m.push(0x0425); ip = 0x2d91; continue;  // call 0x2d91
      case 0x0425: m.t += 1; m.pas -= 1; m.push(0x0428); ip = 0x2b01; continue;  // call 0x2b01
      case 0x0428: m.t += 2; m.pas -= 2; m.bp = 0x251;  // mov bp, 0x251
      case 0x042b: m.push(0x042e); ip = 0x0462; continue;  // call 0x462
      case 0x042e: m.t += 2; m.pas -= 2; m.bp = 0xfd;  // mov bp, 0xfd
      case 0x0431: m.push(0x0434); ip = 0x0462; continue;  // call 0x462
      case 0x0434: m.t += 2; m.pas -= 2; m.sub8((m.ax & 0xff), 0x1);  // cmp al, 1
      case 0x0436: if (!m.zf) { ip = 0x043b; continue; }  // jne 0x43b
      case 0x0438: m.t += 1; m.pas -= 1; ip = 0x0289; continue;  // jmp 0x289
      case 0x043b: m.t += 2; m.pas -= 2; m.cx = 0x6;  // mov cx, 6
      case 0x043e: m.ww(m.ds, 0x0, 0x0);  // mov word ptr [0], 0
      case 0x0444: m.t += 4; m.pas -= 4; m.push(m.cx);  // push cx
      case 0x0445: m.bx = m.rw(m.ds, 0x0);  // mov bx, word ptr [0]
      case 0x0449: m.bp = m.rw(m.ds, ((m.bx + 0x52) & 0xffff));  // mov bp, word ptr [bx + 0x52]
      case 0x044d: m.push(0x0450); ip = 0x0462; continue;  // call 0x462
      case 0x0450: m.t += 3; m.pas -= 3; { const t = m.pop(); m.cx = t; }  // pop cx
      case 0x0451: m.sub8((m.ax & 0xff), 0x1);  // cmp al, 1
      case 0x0453: if (!m.zf) { ip = 0x0458; continue; }  // jne 0x458
      case 0x0455: m.t += 1; m.pas -= 1; ip = 0x0289; continue;  // jmp 0x289
      case 0x0458: m.t += 2; m.pas -= 2; m.ww(m.ds, 0x0, m.add16(m.rw(m.ds, 0x0), 0x2));  // add word ptr [0], 2
      case 0x045d: m.cx = (m.cx - 1) & 0xffff; if (m.cx !== 0) { ip = 0x0444; continue; }  // loop 0x444
      case 0x045f: m.t += 1; m.pas -= 1; ip = 0x0289; continue;  // jmp 0x289
      default: return ip;
    }
  }
}

// 0x0462 sub_4912
function sub_0462_0462(m, ip) {
  for (;;) {
    if (m.pas <= 0) return ip;
    switch (ip) {
      case 0x0462: m.t += 2; m.pas -= 2; m.sub16(m.rw(m.ds, 0x1440), 0x4);  // cmp word ptr [0x1440], 4
      case 0x0467: if (m.zf) { ip = 0x048d; continue; }  // je 0x48d
      case 0x0469: m.t += 13; m.pas -= 13; m.push(m.bp);  // push bp
      case 0x046a: m.push(m.ax);  // push ax
      case 0x046b: m.ax = ((0xa86 + m.L) & 0xffff);  // mov ax, 0xa86
      case 0x046e: m.es = m.ax;  // mov es, ax
      case 0x0470: { const t = m.pop(); m.ax = t; }  // pop ax
      case 0x0471: m.push(m.ax);  // push ax
      case 0x0472: m.ax = ((0x1a26 + m.L) & 0xffff);  // mov ax, 0x1a26
      case 0x0475: m.ds = m.ax;  // mov ds, ax
      case 0x0477: { const t = m.pop(); m.ax = t; }  // pop ax
      case 0x0478: m.xor16(0, 0); m.di = 0;  // xor di, di
      case 0x047a: m.si = m.di;  // mov si, di
      case 0x047c: m.cx = 0x7d00;  // mov cx, 0x7d00
      case 0x047f: m.push(0x0482); ip = 0x39dd; continue;  // call 0x39dd
      case 0x0482: m.t += 6; m.pas -= 6; m.push(m.ax);  // push ax
      case 0x0483: m.ax = ((0x0 + m.L) & 0xffff);  // mov ax, 0
      case 0x0486: m.ds = m.ax;  // mov ds, ax
      case 0x0488: { const t = m.pop(); m.ax = t; }  // pop ax
      case 0x0489: { const t = m.pop(); m.bp = t; }  // pop bp
      case 0x048a: ip = 0x049e; continue;  // jmp 0x49e
      case 0x048d: m.t += 8; m.pas -= 8; m.push(m.ax);  // push ax
      case 0x048e: m.ax = ((0xa86 + m.L) & 0xffff);  // mov ax, 0xa86
      case 0x0491: m.es = m.ax;  // mov es, ax
      case 0x0493: { const t = m.pop(); m.ax = t; }  // pop ax
      case 0x0494: m.xor16(0, 0); m.di = 0;  // xor di, di
      case 0x0496: m.ax = 0xcccc;  // mov ax, 0xcccc
      case 0x0499: m.cx = 0x4000;  // mov cx, 0x4000
      case 0x049c: m.stosw(m.ds, 1);  // rep stosw word ptr es:[di], ax
      case 0x049e: m.t += 2; m.pas -= 2; m.sub16(m.bp, 0x251);  // cmp bp, 0x251
      case 0x04a2: if (!m.zf) { ip = 0x04c4; continue; }  // jne 0x4c4
      case 0x04a4: m.t += 13; m.pas -= 13; m.push(m.bp);  // push bp
      case 0x04a5: m.si = 0x7c40;  // mov si, 0x7c40
      case 0x04a8: m.di = 0x142c;  // mov di, 0x142c
      case 0x04ab: m.ax = ((0x2e23 + m.L) & 0xffff);  // mov ax, 0x2e23
      case 0x04ae: m.ww(m.ds, 0x19f0, m.ax);  // mov word ptr [0x19f0], ax
      case 0x04b1: m.push(m.ax);  // push ax
      case 0x04b2: m.ax = ((0xa86 + m.L) & 0xffff);  // mov ax, 0xa86
      case 0x04b5: m.es = m.ax;  // mov es, ax
      case 0x04b7: { const t = m.pop(); m.ax = t; }  // pop ax
      case 0x04b8: m.bp = 0xe0;  // mov bp, 0xe0
      case 0x04bb: m.cx = 0x44;  // mov cx, 0x44
      case 0x04be: m.push(m.ds);  // push ds
      case 0x04bf: m.push(0x04c2); ip = 0x2f60; continue;  // call 0x2f60
      case 0x04c2: m.t += 2; m.pas -= 2; { const t = m.pop(); m.ds = t; }  // pop ds
      case 0x04c3: { const t = m.pop(); m.bp = t; }  // pop bp
      case 0x04c4: m.t += 1; m.pas -= 1; m.push(0x04c7); ip = 0x258c; continue;  // call 0x258c
      case 0x04c7: m.t += 1; m.pas -= 1; m.push(0x04ca); ip = 0x04d0; continue;  // call 0x4d0
      case 0x04ca: m.t += 1; m.pas -= 1; m.push(0x04cd); ip = 0x0532; continue;  // call 0x532
      case 0x04cd: m.t += 1; m.pas -= 1; ip = 0x0a6b; continue;  // jmp 0xa6b
      default: return ip;
    }
  }
}

// 0x04d0 sub_4980
function sub_04d0_04d0(m, ip) {
  for (;;) {
    if (m.pas <= 0) return ip;
    switch (ip) {
      case 0x04d0: m.t += 2; m.pas -= 2; m.sub16(m.rw(m.ds, 0x1440), 0x4);  // cmp word ptr [0x1440], 4
      case 0x04d5: if (m.zf) { ip = 0x0511; continue; }  // je 0x511
      case 0x04d7: m.t += 13; m.pas -= 13; m.push(m.ax);  // push ax
      case 0x04d8: m.ax = 0xa000;  // mov ax, 0xa000
      case 0x04db: m.es = m.ax;  // mov es, ax
      case 0x04dd: { const t = m.pop(); m.ax = t; }  // pop ax
      case 0x04de: m.push(m.ax);  // push ax
      case 0x04df: m.ax = ((0xa86 + m.L) & 0xffff);  // mov ax, 0xa86
      case 0x04e2: m.ds = m.ax;  // mov ds, ax
      case 0x04e4: { const t = m.pop(); m.ax = t; }  // pop ax
      case 0x04e5: m.xor16(0, 0); m.si = 0;  // xor si, si
      case 0x04e7: m.di = m.si;  // mov di, si
      case 0x04e9: m.dx = 0x3c4;  // mov dx, 0x3c4
      case 0x04ec: m.ax = 0x802;  // mov ax, 0x802
      case 0x04ef: m.bx = 0xc8;  // mov bx, 0xc8
      case 0x04f2: m.t += 9; m.pas -= 9; m.push(m.ax);  // push ax
      case 0x04f3: m.sortie(m.dx, m.ax, 2);  // out dx, ax
      case 0x04f4: m.cx = 0x14;  // mov cx, 0x14
      case 0x04f7: m.push(m.di);  // push di
      case 0x04f8: m.movsw(m.ds, 1);  // rep movsw word ptr es:[di], word ptr [si]
      case 0x04fa: { const t = m.pop(); m.di = t; }  // pop di
      case 0x04fb: { const t = m.pop(); m.ax = t; }  // pop ax
      case 0x04fc: m.ax = (m.ax & 0xff) | (m.shr8((m.ax >> 8), 0x1) << 8);  // shr ah, 1
      case 0x04fe: if (!m.zf) { ip = 0x04f2; continue; }  // jne 0x4f2
      case 0x0500: m.t += 4; m.pas -= 4; m.di = m.add16(m.di, 0x28);  // add di, 0x28
      case 0x0503: m.ax = 0x802;  // mov ax, 0x802
      case 0x0506: m.bx = m.dec16(m.bx);  // dec bx
      case 0x0507: if (!m.zf) { ip = 0x04f2; continue; }  // jne 0x4f2
      case 0x0509: m.t += 5; m.pas -= 5; m.push(m.ax);  // push ax
      case 0x050a: m.ax = ((0x0 + m.L) & 0xffff);  // mov ax, 0
      case 0x050d: m.ds = m.ax;  // mov ds, ax
      case 0x050f: { const t = m.pop(); m.ax = t; }  // pop ax
      case 0x0510: ip = m.pop(); continue;  // ret
      case 0x0511: m.t += 17; m.pas -= 17; m.push(m.ax);  // push ax
      case 0x0512: m.ax = 0xb800;  // mov ax, 0xb800
      case 0x0515: m.es = m.ax;  // mov es, ax
      case 0x0517: { const t = m.pop(); m.ax = t; }  // pop ax
      case 0x0518: m.push(m.ax);  // push ax
      case 0x0519: m.ax = ((0xa86 + m.L) & 0xffff);  // mov ax, 0xa86
      case 0x051c: m.ds = m.ax;  // mov ds, ax
      case 0x051e: { const t = m.pop(); m.ax = t; }  // pop ax
      case 0x051f: m.si = 0x0;  // mov si, 0
      case 0x0522: m.di = 0x0;  // mov di, 0
      case 0x0525: m.cx = 0x4000;  // mov cx, 0x4000
      case 0x0528: m.movsw(m.ds, 1);  // rep movsw word ptr es:[di], word ptr [si]
      case 0x052a: m.push(m.ax);  // push ax
      case 0x052b: m.ax = ((0x0 + m.L) & 0xffff);  // mov ax, 0
      case 0x052e: m.ds = m.ax;  // mov ds, ax
      case 0x0530: { const t = m.pop(); m.ax = t; }  // pop ax
      case 0x0531: ip = m.pop(); continue;  // ret
      default: return ip;
    }
  }
}

// 0x0532 sub_49e2
function sub_0532_0532(m, ip) {
  for (;;) {
    if (m.pas <= 0) return ip;
    switch (ip) {
      case 0x0532: m.t += 3; m.pas -= 3; m.dx = 0x105e;  // mov dx, 0x105e
      case 0x0535: m.sub16(m.rw(m.ds, 0x1440), 0x4);  // cmp word ptr [0x1440], 4
      case 0x053a: if (!m.zf) { ip = 0x053f; continue; }  // jne 0x53f
      case 0x053c: m.t += 1; m.pas -= 1; m.dx = 0x106f;  // mov dx, 0x106f
      case 0x053f: m.t += 6; m.pas -= 6; m.ax = 0x1002;  // mov ax, 0x1002
      case 0x0542: m.push(m.ax);  // push ax
      case 0x0543: m.ax = ((0x0 + m.L) & 0xffff);  // mov ax, 0
      case 0x0546: m.es = m.ax;  // mov es, ax
      case 0x0548: { const t = m.pop(); m.ax = t; }  // pop ax
      case 0x0549: if (!m.interruption(0x10)) { m.pas = 0; ip = 0x0549; continue; }  // int 0x10
      case 0x054b: m.t += 1; m.pas -= 1; ip = m.pop(); continue;  // ret
      default: return ip;
    }
  }
}

// 0x054c sub_49fc
function sub_054c_054c(m, ip) {
  for (;;) {
    if (m.pas <= 0) return ip;
    switch (ip) {
      case 0x054c: m.t += 7; m.pas -= 7; m.ax = 0x1002;  // mov ax, 0x1002
      case 0x054f: m.push(m.ax);  // push ax
      case 0x0550: m.ax = ((0x0 + m.L) & 0xffff);  // mov ax, 0
      case 0x0553: m.es = m.ax;  // mov es, ax
      case 0x0555: { const t = m.pop(); m.ax = t; }  // pop ax
      case 0x0556: m.dx = 0xc5e;  // mov dx, 0xc5e
      case 0x0559: if (!m.interruption(0x10)) { m.pas = 0; ip = 0x0559; continue; }  // int 0x10
      case 0x055b: m.t += 1; m.pas -= 1; ip = m.pop(); continue;  // ret
      default: return ip;
    }
  }
}

// 0x055c sub_4a0c
function sub_055c_055c(m, ip) {
  for (;;) {
    if (m.pas <= 0) return ip;
    switch (ip) {
      case 0x055c: m.t += 1; m.pas -= 1; ip = m.rw(m.cs, ((m.bx + 0x71e) & 0xffff)); continue;  // jmp word ptr cs:[bx + 0x71e]
      default: return ip;
    }
  }
}

// 0x0561 sub_4a11
function sub_0561_0561(m, ip) {
  for (;;) {
    if (m.pas <= 0) return ip;
    switch (ip) {
      case 0x0561: m.t += 4; m.pas -= 4; m.si = 0x0;  // mov si, 0
      case 0x0564: m.di = 0x0;  // mov di, 0
      case 0x0567: m.cx = 0x4;  // mov cx, 4
      case 0x056a: m.push(0x056d); ip = 0x08a0; continue;  // call 0x8a0
      case 0x056d: m.t += 2; m.pas -= 2; m.cx = 0x18;  // mov cx, 0x18
      case 0x0570: m.ww(m.ds, 0x128e, 0x0);  // mov word ptr [0x128e], 0
      case 0x0576: m.t += 2; m.pas -= 2; m.push(m.cx);  // push cx
      case 0x0577: m.push(0x057a); ip = 0x0731; continue;  // call 0x731
      case 0x057a: m.t += 5; m.pas -= 5; m.ax = m.rw(m.ds, 0x128e);  // mov ax, word ptr [0x128e]
      case 0x057d: { const t = (m.ax & 0xff); m.ax = (m.ax & 0xff00) | (m.ax >> 8); m.ax = (m.ax & 0xff) | (t << 8); }  // xchg al, ah
      case 0x057f: m.si = m.ax;  // mov si, ax
      case 0x0581: m.di = 0x8304;  // mov di, 0x8304
      case 0x0584: m.push(0x0587); ip = 0x076f; continue;  // call 0x76f
      case 0x0587: m.t += 1; m.pas -= 1; m.push(0x058a); ip = 0x074d; continue;  // call 0x74d
      case 0x058a: m.t += 2; m.pas -= 2; m.dx = 0x6;  // mov dx, 6
      case 0x058d: m.push(0x0590); ip = 0x072a; continue;  // call 0x72a
      case 0x0590: m.t += 4; m.pas -= 4; m.ww(m.ds, 0x128e, m.inc16(m.rw(m.ds, 0x128e)));  // inc word ptr [0x128e]
      case 0x0594: m.ww(m.ds, 0x128e, m.and16(m.rw(m.ds, 0x128e), 0x3));  // and word ptr [0x128e], 3
      case 0x0599: { const t = m.pop(); m.cx = t; }  // pop cx
      case 0x059a: m.cx = (m.cx - 1) & 0xffff; if (m.cx !== 0) { ip = 0x0576; continue; }  // loop 0x576
      case 0x059c: m.t += 1; m.pas -= 1; ip = m.pop(); continue;  // ret
      default: return ip;
    }
  }
}

// 0x059d sub_4a4d
function sub_059d_059d(m, ip) {
  for (;;) {
    if (m.pas <= 0) return ip;
    switch (ip) {
      case 0x059d: m.t += 3; m.pas -= 3; m.si = 0x280;  // mov si, 0x280
      case 0x05a0: m.cx = 0x3;  // mov cx, 3
      case 0x05a3: m.push(0x05a6); ip = 0x08e3; continue;  // call 0x8e3
      case 0x05a6: m.t += 1; m.pas -= 1; m.cx = 0xa;  // mov cx, 0xa
      case 0x05a9: m.t += 5; m.pas -= 5; m.push(m.cx);  // push cx
      case 0x05aa: m.cx = 0x3;  // mov cx, 3
      case 0x05ad: m.dx = 0x2;  // mov dx, 2
      case 0x05b0: m.di = 0x6e86;  // mov di, 0x6e86
      case 0x05b3: m.push(0x05b6); ip = 0x07a6; continue;  // call 0x7a6
      case 0x05b6: m.t += 2; m.pas -= 2; { const t = m.pop(); m.cx = t; }  // pop cx
      case 0x05b7: m.cx = (m.cx - 1) & 0xffff; if (m.cx !== 0) { ip = 0x05a9; continue; }  // loop 0x5a9
      case 0x05b9: m.t += 1; m.pas -= 1; ip = m.pop(); continue;  // ret
      default: return ip;
    }
  }
}

// 0x05ba sub_4a6a
function sub_05ba_05ba(m, ip) {
  for (;;) {
    if (m.pas <= 0) return ip;
    switch (ip) {
      case 0x05ba: m.t += 3; m.pas -= 3; m.si = 0x1180;  // mov si, 0x1180
      case 0x05bd: m.cx = 0x4;  // mov cx, 4
      case 0x05c0: m.push(0x05c3); ip = 0x092c; continue;  // call 0x92c
      case 0x05c3: m.t += 1; m.pas -= 1; m.dx = 0x3c;  // mov dx, 0x3c
      case 0x05c6: m.t += 1; m.pas -= 1; m.push(0x05c9); ip = 0x3a9b; continue;  // call 0x3a9b
      case 0x05c9: m.t += 2; m.pas -= 2; m.dx = m.dec16(m.dx);  // dec dx
      case 0x05ca: if (!m.zf) { ip = 0x05c6; continue; }  // jne 0x5c6
      case 0x05cc: m.t += 4; m.pas -= 4; m.cx = 0x4;  // mov cx, 4
      case 0x05cf: m.dx = 0x4;  // mov dx, 4
      case 0x05d2: m.di = 0x2880;  // mov di, 0x2880
      case 0x05d5: m.push(0x05d8); ip = 0x0823; continue;  // call 0x823
      case 0x05d8: m.t += 1; m.pas -= 1; m.dx = 0xf0;  // mov dx, 0xf0
      case 0x05db: m.t += 1; m.pas -= 1; m.push(0x05de); ip = 0x3a9b; continue;  // call 0x3a9b
      case 0x05de: m.t += 2; m.pas -= 2; m.dx = m.dec16(m.dx);  // dec dx
      case 0x05df: if (!m.zf) { ip = 0x05db; continue; }  // jne 0x5db
      case 0x05e1: m.t += 1; m.pas -= 1; ip = m.pop(); continue;  // ret
      default: return ip;
    }
  }
}

// 0x05e2 sub_4a92
function sub_05e2_05e2(m, ip) {
  for (;;) {
    if (m.pas <= 0) return ip;
    switch (ip) {
      case 0x05e2: m.t += 4; m.pas -= 4; m.si = 0x3980;  // mov si, 0x3980
      case 0x05e5: m.di = 0x0;  // mov di, 0
      case 0x05e8: m.cx = 0x10;  // mov cx, 0x10
      case 0x05eb: m.push(0x05ee); ip = 0x08a0; continue;  // call 0x8a0
      case 0x05ee: m.t += 3; m.pas -= 3; m.cx = 0x1e;  // mov cx, 0x1e
      case 0x05f1: m.ww(m.ds, 0x128e, 0x0);  // mov word ptr [0x128e], 0
      case 0x05f7: m.ww(m.ds, 0x1290, 0x0);  // mov word ptr [0x1290], 0
      case 0x05fd: m.t += 2; m.pas -= 2; m.push(m.cx);  // push cx
      case 0x05fe: m.push(0x0601); ip = 0x0731; continue;  // call 0x731
      case 0x0601: m.t += 5; m.pas -= 5; m.ax = m.rw(m.ds, 0x128e);  // mov ax, word ptr [0x128e]
      case 0x0604: { const t = (m.ax & 0xff); m.ax = (m.ax & 0xff00) | (m.ax >> 8); m.ax = (m.ax & 0xff) | (t << 8); }  // xchg al, ah
      case 0x0606: m.si = m.ax;  // mov si, ax
      case 0x0608: m.di = 0x8280;  // mov di, 0x8280
      case 0x060b: m.push(0x060e); ip = 0x076f; continue;  // call 0x76f
      case 0x060e: m.t += 6; m.pas -= 6; m.ax = m.rw(m.ds, 0x128e);  // mov ax, word ptr [0x128e]
      case 0x0611: { const t = (m.ax & 0xff); m.ax = (m.ax & 0xff00) | (m.ax >> 8); m.ax = (m.ax & 0xff) | (t << 8); }  // xchg al, ah
      case 0x0613: m.si = 0x800;  // mov si, 0x800
      case 0x0616: m.si = m.add16(m.si, m.ax);  // add si, ax
      case 0x0618: m.di = 0x8c62;  // mov di, 0x8c62
      case 0x061b: m.push(0x061e); ip = 0x076f; continue;  // call 0x76f
      case 0x061e: m.t += 6; m.pas -= 6; m.ax = m.rw(m.ds, 0x1290);  // mov ax, word ptr [0x1290]
      case 0x0621: { const t = (m.ax & 0xff); m.ax = (m.ax & 0xff00) | (m.ax >> 8); m.ax = (m.ax & 0xff) | (t << 8); }  // xchg al, ah
      case 0x0623: m.si = 0x500;  // mov si, 0x500
      case 0x0626: m.si = m.add16(m.si, m.ax);  // add si, ax
      case 0x0628: m.di = 0x7878;  // mov di, 0x7878
      case 0x062b: m.push(0x062e); ip = 0x076f; continue;  // call 0x76f
      case 0x062e: m.t += 6; m.pas -= 6; m.ax = m.rw(m.ds, 0x1290);  // mov ax, word ptr [0x1290]
      case 0x0631: { const t = (m.ax & 0xff); m.ax = (m.ax & 0xff00) | (m.ax >> 8); m.ax = (m.ax & 0xff) | (t << 8); }  // xchg al, ah
      case 0x0633: m.si = 0xd00;  // mov si, 0xd00
      case 0x0636: m.si = m.add16(m.si, m.ax);  // add si, ax
      case 0x0638: m.di = 0x9678;  // mov di, 0x9678
      case 0x063b: m.push(0x063e); ip = 0x076f; continue;  // call 0x76f
      case 0x063e: m.t += 1; m.pas -= 1; m.push(0x0641); ip = 0x074d; continue;  // call 0x74d
      case 0x0641: m.t += 2; m.pas -= 2; m.dx = 0xc;  // mov dx, 0xc
      case 0x0644: m.push(0x0647); ip = 0x072a; continue;  // call 0x72a
      case 0x0647: m.t += 4; m.pas -= 4; m.ax = m.rw(m.ds, 0x128e);  // mov ax, word ptr [0x128e]
      case 0x064a: m.ax = m.inc16(m.ax);  // inc ax
      case 0x064b: m.sub16(m.ax, 0x4);  // cmp ax, 4
      case 0x064e: if ((m.zf || m.sf !== m.of)) { ip = 0x0653; continue; }  // jle 0x653
      case 0x0650: m.t += 1; m.pas -= 1; m.ax = 0x0;  // mov ax, 0
      case 0x0653: m.t += 5; m.pas -= 5; m.ww(m.ds, 0x128e, m.ax);  // mov word ptr [0x128e], ax
      case 0x0656: m.ax = m.rw(m.ds, 0x1290);  // mov ax, word ptr [0x1290]
      case 0x0659: m.ax = m.inc16(m.ax);  // inc ax
      case 0x065a: m.sub16(m.ax, 0x2);  // cmp ax, 2
      case 0x065d: if ((m.zf || m.sf !== m.of)) { ip = 0x0662; continue; }  // jle 0x662
      case 0x065f: m.t += 1; m.pas -= 1; m.ax = 0x0;  // mov ax, 0
      case 0x0662: m.t += 3; m.pas -= 3; m.ww(m.ds, 0x1290, m.ax);  // mov word ptr [0x1290], ax
      case 0x0665: { const t = m.pop(); m.cx = t; }  // pop cx
      case 0x0666: m.cx = (m.cx - 1) & 0xffff; if (m.cx !== 0) { ip = 0x05fd; continue; }  // loop 0x5fd
      case 0x0668: m.t += 1; m.pas -= 1; ip = m.pop(); continue;  // ret
      default: return ip;
    }
  }
}

// 0x0669 sub_4b19
function sub_0669_0669(m, ip) {
  for (;;) {
    if (m.pas <= 0) return ip;
    switch (ip) {
      case 0x0669: m.t += 4; m.pas -= 4; m.si = 0x4380;  // mov si, 0x4380
      case 0x066c: m.di = 0x0;  // mov di, 0
      case 0x066f: m.cx = 0xc;  // mov cx, 0xc
      case 0x0672: m.push(0x0675); ip = 0x08a0; continue;  // call 0x8a0
      case 0x0675: m.t += 3; m.pas -= 3; m.cx = 0x1e;  // mov cx, 0x1e
      case 0x0678: m.ww(m.ds, 0x128e, 0x0);  // mov word ptr [0x128e], 0
      case 0x067e: m.ww(m.ds, 0x1290, 0x0);  // mov word ptr [0x1290], 0
      case 0x0684: m.t += 2; m.pas -= 2; m.push(m.cx);  // push cx
      case 0x0685: m.push(0x0688); ip = 0x0731; continue;  // call 0x731
      case 0x0688: m.t += 5; m.pas -= 5; m.ax = m.rw(m.ds, 0x128e);  // mov ax, word ptr [0x128e]
      case 0x068b: { const t = (m.ax & 0xff); m.ax = (m.ax & 0xff00) | (m.ax >> 8); m.ax = (m.ax & 0xff) | (t << 8); }  // xchg al, ah
      case 0x068d: m.si = m.ax;  // mov si, ax
      case 0x068f: m.di = 0x96e0;  // mov di, 0x96e0
      case 0x0692: m.push(0x0695); ip = 0x076f; continue;  // call 0x76f
      case 0x0695: m.t += 6; m.pas -= 6; m.ax = m.rw(m.ds, 0x1290);  // mov ax, word ptr [0x1290]
      case 0x0698: { const t = (m.ax & 0xff); m.ax = (m.ax & 0xff00) | (m.ax >> 8); m.ax = (m.ax & 0xff) | (t << 8); }  // xchg al, ah
      case 0x069a: m.si = 0x500;  // mov si, 0x500
      case 0x069d: m.si = m.add16(m.si, m.ax);  // add si, ax
      case 0x069f: m.di = 0x8c68;  // mov di, 0x8c68
      case 0x06a2: m.push(0x06a5); ip = 0x076f; continue;  // call 0x76f
      case 0x06a5: m.t += 1; m.pas -= 1; m.push(0x06a8); ip = 0x074d; continue;  // call 0x74d
      case 0x06a8: m.t += 2; m.pas -= 2; m.dx = 0x8;  // mov dx, 8
      case 0x06ab: m.push(0x06ae); ip = 0x072a; continue;  // call 0x72a
      case 0x06ae: m.t += 4; m.pas -= 4; m.ax = m.rw(m.ds, 0x128e);  // mov ax, word ptr [0x128e]
      case 0x06b1: m.ax = m.inc16(m.ax);  // inc ax
      case 0x06b2: m.sub16(m.ax, 0x4);  // cmp ax, 4
      case 0x06b5: if ((m.zf || m.sf !== m.of)) { ip = 0x06ba; continue; }  // jle 0x6ba
      case 0x06b7: m.t += 1; m.pas -= 1; m.ax = 0x0;  // mov ax, 0
      case 0x06ba: m.t += 5; m.pas -= 5; m.ww(m.ds, 0x128e, m.ax);  // mov word ptr [0x128e], ax
      case 0x06bd: m.ax = m.rw(m.ds, 0x1290);  // mov ax, word ptr [0x1290]
      case 0x06c0: m.ax = m.inc16(m.ax);  // inc ax
      case 0x06c1: m.sub16(m.ax, 0x6);  // cmp ax, 6
      case 0x06c4: if ((m.zf || m.sf !== m.of)) { ip = 0x06c9; continue; }  // jle 0x6c9
      case 0x06c6: m.t += 1; m.pas -= 1; m.ax = 0x0;  // mov ax, 0
      case 0x06c9: m.t += 3; m.pas -= 3; m.ww(m.ds, 0x1290, m.ax);  // mov word ptr [0x1290], ax
      case 0x06cc: { const t = m.pop(); m.cx = t; }  // pop cx
      case 0x06cd: m.cx = (m.cx - 1) & 0xffff; if (m.cx !== 0) { ip = 0x0684; continue; }  // loop 0x684
      case 0x06cf: m.t += 1; m.pas -= 1; ip = m.pop(); continue;  // ret
      default: return ip;
    }
  }
}

// 0x06d0 sub_4b80
function sub_06d0_06d0(m, ip) {
  for (;;) {
    if (m.pas <= 0) return ip;
    switch (ip) {
      case 0x06d0: m.t += 4; m.pas -= 4; m.si = 0x4b00;  // mov si, 0x4b00
      case 0x06d3: m.di = 0x0;  // mov di, 0
      case 0x06d6: m.cx = 0x8;  // mov cx, 8
      case 0x06d9: m.push(0x06dc); ip = 0x08a0; continue;  // call 0x8a0
      case 0x06dc: m.t += 2; m.pas -= 2; m.dx = 0x3c;  // mov dx, 0x3c
      case 0x06df: m.push(0x06e2); ip = 0x072a; continue;  // call 0x72a
      case 0x06e2: m.t += 2; m.pas -= 2; m.cx = 0xa;  // mov cx, 0xa
      case 0x06e5: m.ww(m.ds, 0x128e, 0x0);  // mov word ptr [0x128e], 0
      case 0x06eb: m.t += 2; m.pas -= 2; m.push(m.cx);  // push cx
      case 0x06ec: m.push(0x06ef); ip = 0x0731; continue;  // call 0x731
      case 0x06ef: m.t += 5; m.pas -= 5; m.ax = m.rw(m.ds, 0x128e);  // mov ax, word ptr [0x128e]
      case 0x06f2: { const t = (m.ax & 0xff); m.ax = (m.ax & 0xff00) | (m.ax >> 8); m.ax = (m.ax & 0xff) | (t << 8); }  // xchg al, ah
      case 0x06f4: m.si = m.ax;  // mov si, ax
      case 0x06f6: m.di = 0x9641;  // mov di, 0x9641
      case 0x06f9: m.push(0x06fc); ip = 0x076f; continue;  // call 0x76f
      case 0x06fc: m.t += 1; m.pas -= 1; m.push(0x06ff); ip = 0x074d; continue;  // call 0x74d
      case 0x06ff: m.t += 2; m.pas -= 2; m.dx = 0x8;  // mov dx, 8
      case 0x0702: m.push(0x0705); ip = 0x072a; continue;  // call 0x72a
      case 0x0705: m.t += 4; m.pas -= 4; m.ax = m.rw(m.ds, 0x128e);  // mov ax, word ptr [0x128e]
      case 0x0708: m.ax = m.inc16(m.ax);  // inc ax
      case 0x0709: m.sub16(m.ax, 0x7);  // cmp ax, 7
      case 0x070c: if ((m.zf || m.sf !== m.of)) { ip = 0x0711; continue; }  // jle 0x711
      case 0x070e: m.t += 1; m.pas -= 1; m.ax = 0x6;  // mov ax, 6
      case 0x0711: m.t += 3; m.pas -= 3; m.ww(m.ds, 0x128e, m.ax);  // mov word ptr [0x128e], ax
      case 0x0714: { const t = m.pop(); m.cx = t; }  // pop cx
      case 0x0715: m.cx = (m.cx - 1) & 0xffff; if (m.cx !== 0) { ip = 0x06eb; continue; }  // loop 0x6eb
      case 0x0717: m.t += 2; m.pas -= 2; m.dx = 0x3c;  // mov dx, 0x3c
      case 0x071a: m.push(0x071d); ip = 0x072a; continue;  // call 0x72a
      case 0x071d: m.t += 1; m.pas -= 1; ip = m.pop(); continue;  // ret
      default: return ip;
    }
  }
}

// 0x072a sub_4bda
function sub_072a_072a(m, ip) {
  for (;;) {
    if (m.pas <= 0) return ip;
    switch (ip) {
      case 0x072a: m.t += 1; m.pas -= 1; m.push(0x072d); ip = 0x3a9b; continue;  // call 0x3a9b
      case 0x072d: m.t += 2; m.pas -= 2; m.dx = m.dec16(m.dx);  // dec dx
      case 0x072e: if (!m.zf) { ip = 0x072a; continue; }  // jne 0x72a
      case 0x0730: m.t += 1; m.pas -= 1; ip = m.pop(); continue;  // ret
      default: return ip;
    }
  }
}

// 0x0731 sub_4be1
function sub_0731_0731(m, ip) {
  for (;;) {
    if (m.pas <= 0) return ip;
    switch (ip) {
      case 0x0731: m.t += 8; m.pas -= 8; m.ax = ((0xa86 + m.L) & 0xffff);  // mov ax, 0xa86
      case 0x0734: m.es = m.ax;  // mov es, ax
      case 0x0736: m.ax = ((0x1a26 + m.L) & 0xffff);  // mov ax, 0x1a26
      case 0x0739: m.ds = m.ax;  // mov ds, ax
      case 0x073b: m.di = 0x0;  // mov di, 0
      case 0x073e: m.si = 0x0;  // mov si, 0
      case 0x0741: m.cx = 0xffff;  // mov cx, 0xffff
      case 0x0744: m.push(0x0747); ip = 0x39dd; continue;  // call 0x39dd
      case 0x0747: m.t += 3; m.pas -= 3; m.ax = ((0x0 + m.L) & 0xffff);  // mov ax, 0
      case 0x074a: m.ds = m.ax;  // mov ds, ax
      case 0x074c: ip = m.pop(); continue;  // ret
      default: return ip;
    }
  }
}

// 0x074d sub_4bfd
function sub_074d_074d(m, ip) {
  for (;;) {
    if (m.pas <= 0) return ip;
    switch (ip) {
      case 0x074d: m.t += 15; m.pas -= 15; m.ax = 0xa000;  // mov ax, 0xa000
      case 0x0750: m.es = m.ax;  // mov es, ax
      case 0x0752: m.ax = ((0xa86 + m.L) & 0xffff);  // mov ax, 0xa86
      case 0x0755: m.ds = m.ax;  // mov ds, ax
      case 0x0757: m.di = 0x0;  // mov di, 0
      case 0x075a: m.si = 0x0;  // mov si, 0
      case 0x075d: m.cx = 0x7d00;  // mov cx, 0x7d00
      case 0x0760: m.movsw(m.ds, 1);  // rep movsw word ptr es:[di], word ptr [si]
      case 0x0762: m.push(m.ax);  // push ax
      case 0x0763: m.ax = ((0x0 + m.L) & 0xffff);  // mov ax, 0
      case 0x0766: m.ds = m.ax;  // mov ds, ax
      case 0x0768: { const t = m.pop(); m.ax = t; }  // pop ax
      case 0x0769: m.ax = ((0x0 + m.L) & 0xffff);  // mov ax, 0
      case 0x076c: m.ds = m.ax;  // mov ds, ax
      case 0x076e: ip = m.pop(); continue;  // ret
      default: return ip;
    }
  }
}

// 0x076f sub_4c1f
function sub_076f_076f(m, ip) {
  for (;;) {
    if (m.pas <= 0) return ip;
    switch (ip) {
      case 0x076f: m.t += 5; m.pas -= 5; m.ax = ((0xa86 + m.L) & 0xffff);  // mov ax, 0xa86
      case 0x0772: m.es = m.ax;  // mov es, ax
      case 0x0774: m.ax = ((0x2a23 + m.L) & 0xffff);  // mov ax, 0x2a23
      case 0x0777: m.ds = m.ax;  // mov ds, ax
      case 0x0779: m.bp = 0x10;  // mov bp, 0x10
      case 0x077c: m.t += 1; m.pas -= 1; m.cx = 0x8;  // mov cx, 8
      case 0x077f: m.t += 3; m.pas -= 3; m.ax = m.rw(m.ds, m.si);  // mov ax, word ptr [si]
      case 0x0781: m.sub8((m.ax & 0xff), 0x0);  // cmp al, 0
      case 0x0783: if (m.zf) { ip = 0x0788; continue; }  // je 0x788
      case 0x0785: m.t += 1; m.pas -= 1; m.wb(m.es, m.di, (m.ax & 0xff));  // mov byte ptr es:[di], al
      case 0x0788: m.t += 2; m.pas -= 2; m.sub8((m.ax >> 8), 0x0);  // cmp ah, 0
      case 0x078b: if (m.zf) { ip = 0x0791; continue; }  // je 0x791
      case 0x078d: m.t += 1; m.pas -= 1; m.wb(m.es, ((m.di + 0x1) & 0xffff), (m.ax >> 8));  // mov byte ptr es:[di + 1], ah
      case 0x0791: m.t += 3; m.pas -= 3; m.si = m.add16(m.si, 0x2);  // add si, 2
      case 0x0794: m.di = m.add16(m.di, 0x2);  // add di, 2
      case 0x0797: m.cx = (m.cx - 1) & 0xffff; if (m.cx !== 0) { ip = 0x077f; continue; }  // loop 0x77f
      case 0x0799: m.t += 3; m.pas -= 3; m.di = m.add16(m.di, 0x130);  // add di, 0x130
      case 0x079d: m.bp = m.dec16(m.bp);  // dec bp
      case 0x079e: if (!m.zf) { ip = 0x077c; continue; }  // jne 0x77c
      case 0x07a0: m.t += 3; m.pas -= 3; m.ax = ((0x0 + m.L) & 0xffff);  // mov ax, 0
      case 0x07a3: m.ds = m.ax;  // mov ds, ax
      case 0x07a5: ip = m.pop(); continue;  // ret
      default: return ip;
    }
  }
}

// 0x07a6 sub_4c56
function sub_07a6_07a6(m, ip) {
  for (;;) {
    if (m.pas <= 0) return ip;
    switch (ip) {
      case 0x07a6: m.t += 1; m.pas -= 1; m.si = 0x0;  // mov si, 0
      case 0x07a9: m.t += 12; m.pas -= 12; m.push(m.cx);  // push cx
      case 0x07aa: m.push(m.di);  // push di
      case 0x07ab: m.push(m.dx);  // push dx
      case 0x07ac: m.push(m.si);  // push si
      case 0x07ad: m.ax = ((0xa86 + m.L) & 0xffff);  // mov ax, 0xa86
      case 0x07b0: m.es = m.ax;  // mov es, ax
      case 0x07b2: m.ax = ((0x1a26 + m.L) & 0xffff);  // mov ax, 0x1a26
      case 0x07b5: m.ds = m.ax;  // mov ds, ax
      case 0x07b7: m.di = 0x0;  // mov di, 0
      case 0x07ba: m.si = 0x0;  // mov si, 0
      case 0x07bd: m.cx = 0xffff;  // mov cx, 0xffff
      case 0x07c0: m.push(0x07c3); ip = 0x39dd; continue;  // call 0x39dd
      case 0x07c3: m.t += 7; m.pas -= 7; { const t = m.pop(); m.si = t; }  // pop si
      case 0x07c4: { const t = m.pop(); m.dx = t; }  // pop dx
      case 0x07c5: { const t = m.pop(); m.di = t; }  // pop di
      case 0x07c6: m.push(m.di);  // push di
      case 0x07c7: m.push(m.dx);  // push dx
      case 0x07c8: m.ax = ((0x2a23 + m.L) & 0xffff);  // mov ax, 0x2a23
      case 0x07cb: m.ds = m.ax;  // mov ds, ax
      case 0x07cd: m.t += 1; m.pas -= 1; m.push(0x07d0); ip = 0x3a9b; continue;  // call 0x3a9b
      case 0x07d0: m.t += 2; m.pas -= 2; m.dx = m.dec16(m.dx);  // dec dx
      case 0x07d1: if (!m.zf) { ip = 0x07cd; continue; }  // jne 0x7cd
      case 0x07d3: m.t += 1; m.pas -= 1; m.bp = 0x40;  // mov bp, 0x40
      case 0x07d6: m.t += 1; m.pas -= 1; m.cx = 0x10;  // mov cx, 0x10
      case 0x07d9: m.t += 3; m.pas -= 3; m.ax = m.rw(m.ds, m.si);  // mov ax, word ptr [si]
      case 0x07db: m.sub8((m.ax & 0xff), 0x0);  // cmp al, 0
      case 0x07dd: if (m.zf) { ip = 0x07e2; continue; }  // je 0x7e2
      case 0x07df: m.t += 1; m.pas -= 1; m.wb(m.es, m.di, (m.ax & 0xff));  // mov byte ptr es:[di], al
      case 0x07e2: m.t += 2; m.pas -= 2; m.sub8((m.ax >> 8), 0x0);  // cmp ah, 0
      case 0x07e5: if (m.zf) { ip = 0x07eb; continue; }  // je 0x7eb
      case 0x07e7: m.t += 1; m.pas -= 1; m.wb(m.es, ((m.di + 0x1) & 0xffff), (m.ax >> 8));  // mov byte ptr es:[di + 1], ah
      case 0x07eb: m.t += 3; m.pas -= 3; m.si = m.add16(m.si, 0x2);  // add si, 2
      case 0x07ee: m.di = m.add16(m.di, 0x2);  // add di, 2
      case 0x07f1: m.cx = (m.cx - 1) & 0xffff; if (m.cx !== 0) { ip = 0x07d9; continue; }  // loop 0x7d9
      case 0x07f3: m.t += 3; m.pas -= 3; m.di = m.add16(m.di, 0x120);  // add di, 0x120
      case 0x07f7: m.bp = m.dec16(m.bp);  // dec bp
      case 0x07f8: if (!m.zf) { ip = 0x07d6; continue; }  // jne 0x7d6
      case 0x07fa: m.t += 18; m.pas -= 18; m.push(m.si);  // push si
      case 0x07fb: m.ax = 0xa000;  // mov ax, 0xa000
      case 0x07fe: m.es = m.ax;  // mov es, ax
      case 0x0800: m.ax = ((0xa86 + m.L) & 0xffff);  // mov ax, 0xa86
      case 0x0803: m.ds = m.ax;  // mov ds, ax
      case 0x0805: m.di = 0x0;  // mov di, 0
      case 0x0808: m.si = 0x0;  // mov si, 0
      case 0x080b: m.cx = 0x7d00;  // mov cx, 0x7d00
      case 0x080e: m.movsw(m.ds, 1);  // rep movsw word ptr es:[di], word ptr [si]
      case 0x0810: m.push(m.ax);  // push ax
      case 0x0811: m.ax = ((0x0 + m.L) & 0xffff);  // mov ax, 0
      case 0x0814: m.ds = m.ax;  // mov ds, ax
      case 0x0816: { const t = m.pop(); m.ax = t; }  // pop ax
      case 0x0817: { const t = m.pop(); m.si = t; }  // pop si
      case 0x0818: { const t = m.pop(); m.dx = t; }  // pop dx
      case 0x0819: { const t = m.pop(); m.di = t; }  // pop di
      case 0x081a: { const t = m.pop(); m.cx = t; }  // pop cx
      case 0x081b: m.cx = (m.cx - 1) & 0xffff; if (m.cx !== 0) { ip = 0x07a9; continue; }  // loop 0x7a9
      case 0x081d: m.t += 3; m.pas -= 3; m.ax = ((0x0 + m.L) & 0xffff);  // mov ax, 0
      case 0x0820: m.ds = m.ax;  // mov ds, ax
      case 0x0822: ip = m.pop(); continue;  // ret
      default: return ip;
    }
  }
}

// 0x0823 sub_4cd3
function sub_0823_0823(m, ip) {
  for (;;) {
    if (m.pas <= 0) return ip;
    switch (ip) {
      case 0x0823: m.t += 1; m.pas -= 1; m.si = 0x0;  // mov si, 0
      case 0x0826: m.t += 12; m.pas -= 12; m.push(m.cx);  // push cx
      case 0x0827: m.push(m.di);  // push di
      case 0x0828: m.push(m.dx);  // push dx
      case 0x0829: m.push(m.si);  // push si
      case 0x082a: m.ax = ((0xa86 + m.L) & 0xffff);  // mov ax, 0xa86
      case 0x082d: m.es = m.ax;  // mov es, ax
      case 0x082f: m.ax = ((0x1a26 + m.L) & 0xffff);  // mov ax, 0x1a26
      case 0x0832: m.ds = m.ax;  // mov ds, ax
      case 0x0834: m.di = 0x0;  // mov di, 0
      case 0x0837: m.si = 0x0;  // mov si, 0
      case 0x083a: m.cx = 0xffff;  // mov cx, 0xffff
      case 0x083d: m.push(0x0840); ip = 0x39dd; continue;  // call 0x39dd
      case 0x0840: m.t += 7; m.pas -= 7; { const t = m.pop(); m.si = t; }  // pop si
      case 0x0841: { const t = m.pop(); m.dx = t; }  // pop dx
      case 0x0842: { const t = m.pop(); m.di = t; }  // pop di
      case 0x0843: m.push(m.di);  // push di
      case 0x0844: m.push(m.dx);  // push dx
      case 0x0845: m.ax = ((0x2a23 + m.L) & 0xffff);  // mov ax, 0x2a23
      case 0x0848: m.ds = m.ax;  // mov ds, ax
      case 0x084a: m.t += 1; m.pas -= 1; m.push(0x084d); ip = 0x3a9b; continue;  // call 0x3a9b
      case 0x084d: m.t += 2; m.pas -= 2; m.dx = m.dec16(m.dx);  // dec dx
      case 0x084e: if (!m.zf) { ip = 0x084a; continue; }  // jne 0x84a
      case 0x0850: m.t += 1; m.pas -= 1; m.bp = 0x40;  // mov bp, 0x40
      case 0x0853: m.t += 1; m.pas -= 1; m.cx = 0x20;  // mov cx, 0x20
      case 0x0856: m.t += 3; m.pas -= 3; m.ax = m.rw(m.ds, m.si);  // mov ax, word ptr [si]
      case 0x0858: m.sub8((m.ax & 0xff), 0x0);  // cmp al, 0
      case 0x085a: if (m.zf) { ip = 0x085f; continue; }  // je 0x85f
      case 0x085c: m.t += 1; m.pas -= 1; m.wb(m.es, m.di, (m.ax & 0xff));  // mov byte ptr es:[di], al
      case 0x085f: m.t += 2; m.pas -= 2; m.sub8((m.ax >> 8), 0x0);  // cmp ah, 0
      case 0x0862: if (m.zf) { ip = 0x0868; continue; }  // je 0x868
      case 0x0864: m.t += 1; m.pas -= 1; m.wb(m.es, ((m.di + 0x1) & 0xffff), (m.ax >> 8));  // mov byte ptr es:[di + 1], ah
      case 0x0868: m.t += 3; m.pas -= 3; m.si = m.add16(m.si, 0x2);  // add si, 2
      case 0x086b: m.di = m.add16(m.di, 0x2);  // add di, 2
      case 0x086e: m.cx = (m.cx - 1) & 0xffff; if (m.cx !== 0) { ip = 0x0856; continue; }  // loop 0x856
      case 0x0870: m.t += 3; m.pas -= 3; m.di = m.add16(m.di, 0x100);  // add di, 0x100
      case 0x0874: m.bp = m.dec16(m.bp);  // dec bp
      case 0x0875: if (!m.zf) { ip = 0x0853; continue; }  // jne 0x853
      case 0x0877: m.t += 18; m.pas -= 18; m.push(m.si);  // push si
      case 0x0878: m.ax = 0xa000;  // mov ax, 0xa000
      case 0x087b: m.es = m.ax;  // mov es, ax
      case 0x087d: m.ax = ((0xa86 + m.L) & 0xffff);  // mov ax, 0xa86
      case 0x0880: m.ds = m.ax;  // mov ds, ax
      case 0x0882: m.di = 0x0;  // mov di, 0
      case 0x0885: m.si = 0x0;  // mov si, 0
      case 0x0888: m.cx = 0x7d00;  // mov cx, 0x7d00
      case 0x088b: m.movsw(m.ds, 1);  // rep movsw word ptr es:[di], word ptr [si]
      case 0x088d: m.push(m.ax);  // push ax
      case 0x088e: m.ax = ((0x0 + m.L) & 0xffff);  // mov ax, 0
      case 0x0891: m.ds = m.ax;  // mov ds, ax
      case 0x0893: { const t = m.pop(); m.ax = t; }  // pop ax
      case 0x0894: { const t = m.pop(); m.si = t; }  // pop si
      case 0x0895: { const t = m.pop(); m.dx = t; }  // pop dx
      case 0x0896: { const t = m.pop(); m.di = t; }  // pop di
      case 0x0897: { const t = m.pop(); m.cx = t; }  // pop cx
      case 0x0898: m.cx = (m.cx - 1) & 0xffff; if (m.cx !== 0) { ip = 0x0826; continue; }  // loop 0x826
      case 0x089a: m.t += 3; m.pas -= 3; m.ax = ((0x0 + m.L) & 0xffff);  // mov ax, 0
      case 0x089d: m.ds = m.ax;  // mov ds, ax
      case 0x089f: ip = m.pop(); continue;  // ret
      default: return ip;
    }
  }
}

// 0x08a0 sub_4d50
function sub_08a0_08a0(m, ip) {
  for (;;) {
    if (m.pas <= 0) return ip;
    switch (ip) {
      case 0x08a0: m.t += 4; m.pas -= 4; m.ax = ((0x2a23 + m.L) & 0xffff);  // mov ax, 0x2a23
      case 0x08a3: m.es = m.ax;  // mov es, ax
      case 0x08a5: m.ax = ((0x2523 + m.L) & 0xffff);  // mov ax, 0x2523
      case 0x08a8: m.ds = m.ax;  // mov ds, ax
      case 0x08aa: m.t += 2; m.pas -= 2; m.push(m.cx);  // push cx
      case 0x08ab: m.dx = 0x20;  // mov dx, 0x20
      case 0x08ae: m.t += 1; m.pas -= 1; m.cx = 0x8;  // mov cx, 8
      case 0x08b1: m.t += 14; m.pas -= 14; m.xor16(0, 0); m.ax = 0;  // xor ax, ax
      case 0x08b3: m.wb(m.ds, ((m.si + 0x80) & 0xffff), m.shl8(m.rb(m.ds, ((m.si + 0x80) & 0xffff)), 0x1));  // shl byte ptr [si + 0x80], 1
      case 0x08b7: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x08b9: m.wb(m.ds, ((m.si + 0x60) & 0xffff), m.shl8(m.rb(m.ds, ((m.si + 0x60) & 0xffff)), 0x1));  // shl byte ptr [si + 0x60], 1
      case 0x08bc: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x08be: m.wb(m.ds, ((m.si + 0x40) & 0xffff), m.shl8(m.rb(m.ds, ((m.si + 0x40) & 0xffff)), 0x1));  // shl byte ptr [si + 0x40], 1
      case 0x08c1: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x08c3: m.wb(m.ds, ((m.si + 0x20) & 0xffff), m.shl8(m.rb(m.ds, ((m.si + 0x20) & 0xffff)), 0x1));  // shl byte ptr [si + 0x20], 1
      case 0x08c6: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x08c8: m.wb(m.ds, m.si, m.shl8(m.rb(m.ds, m.si), 0x1));  // shl byte ptr [si], 1
      case 0x08ca: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x08cc: m.wb(m.es, m.di, (m.ax & 0xff));  // mov byte ptr es:[di], al
      case 0x08cf: m.di = m.inc16(m.di);  // inc di
      case 0x08d0: m.cx = (m.cx - 1) & 0xffff; if (m.cx !== 0) { ip = 0x08b1; continue; }  // loop 0x8b1
      case 0x08d2: m.t += 3; m.pas -= 3; m.si = m.inc16(m.si);  // inc si
      case 0x08d3: m.dx = m.dec16(m.dx);  // dec dx
      case 0x08d4: if (!m.zf) { ip = 0x08ae; continue; }  // jne 0x8ae
      case 0x08d6: m.t += 3; m.pas -= 3; m.si = m.add16(m.si, 0x80);  // add si, 0x80
      case 0x08da: { const t = m.pop(); m.cx = t; }  // pop cx
      case 0x08db: m.cx = (m.cx - 1) & 0xffff; if (m.cx !== 0) { ip = 0x08aa; continue; }  // loop 0x8aa
      case 0x08dd: m.t += 3; m.pas -= 3; m.ax = ((0x0 + m.L) & 0xffff);  // mov ax, 0
      case 0x08e0: m.ds = m.ax;  // mov ds, ax
      case 0x08e2: ip = m.pop(); continue;  // ret
      default: return ip;
    }
  }
}

// 0x08e3 sub_4d93
function sub_08e3_08e3(m, ip) {
  for (;;) {
    if (m.pas <= 0) return ip;
    switch (ip) {
      case 0x08e3: m.t += 5; m.pas -= 5; m.ax = ((0x2a23 + m.L) & 0xffff);  // mov ax, 0x2a23
      case 0x08e6: m.es = m.ax;  // mov es, ax
      case 0x08e8: m.di = 0x0;  // mov di, 0
      case 0x08eb: m.ax = ((0x2523 + m.L) & 0xffff);  // mov ax, 0x2523
      case 0x08ee: m.ds = m.ax;  // mov ds, ax
      case 0x08f0: m.t += 2; m.pas -= 2; m.push(m.cx);  // push cx
      case 0x08f1: m.dx = 0x100;  // mov dx, 0x100
      case 0x08f4: m.t += 1; m.pas -= 1; m.cx = 0x8;  // mov cx, 8
      case 0x08f7: m.t += 14; m.pas -= 14; m.xor16(0, 0); m.ax = 0;  // xor ax, ax
      case 0x08f9: m.wb(m.ds, ((m.si + 0x400) & 0xffff), m.shl8(m.rb(m.ds, ((m.si + 0x400) & 0xffff)), 0x1));  // shl byte ptr [si + 0x400], 1
      case 0x08fd: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x08ff: m.wb(m.ds, ((m.si + 0x300) & 0xffff), m.shl8(m.rb(m.ds, ((m.si + 0x300) & 0xffff)), 0x1));  // shl byte ptr [si + 0x300], 1
      case 0x0903: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x0905: m.wb(m.ds, ((m.si + 0x200) & 0xffff), m.shl8(m.rb(m.ds, ((m.si + 0x200) & 0xffff)), 0x1));  // shl byte ptr [si + 0x200], 1
      case 0x0909: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x090b: m.wb(m.ds, ((m.si + 0x100) & 0xffff), m.shl8(m.rb(m.ds, ((m.si + 0x100) & 0xffff)), 0x1));  // shl byte ptr [si + 0x100], 1
      case 0x090f: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x0911: m.wb(m.ds, m.si, m.shl8(m.rb(m.ds, m.si), 0x1));  // shl byte ptr [si], 1
      case 0x0913: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x0915: m.wb(m.es, m.di, (m.ax & 0xff));  // mov byte ptr es:[di], al
      case 0x0918: m.di = m.inc16(m.di);  // inc di
      case 0x0919: m.cx = (m.cx - 1) & 0xffff; if (m.cx !== 0) { ip = 0x08f7; continue; }  // loop 0x8f7
      case 0x091b: m.t += 3; m.pas -= 3; m.si = m.inc16(m.si);  // inc si
      case 0x091c: m.dx = m.dec16(m.dx);  // dec dx
      case 0x091d: if (!m.zf) { ip = 0x08f4; continue; }  // jne 0x8f4
      case 0x091f: m.t += 3; m.pas -= 3; m.si = m.add16(m.si, 0x400);  // add si, 0x400
      case 0x0923: { const t = m.pop(); m.cx = t; }  // pop cx
      case 0x0924: m.cx = (m.cx - 1) & 0xffff; if (m.cx !== 0) { ip = 0x08f0; continue; }  // loop 0x8f0
      case 0x0926: m.t += 3; m.pas -= 3; m.ax = ((0x0 + m.L) & 0xffff);  // mov ax, 0
      case 0x0929: m.ds = m.ax;  // mov ds, ax
      case 0x092b: ip = m.pop(); continue;  // ret
      default: return ip;
    }
  }
}

// 0x092c sub_4ddc
function sub_092c_092c(m, ip) {
  for (;;) {
    if (m.pas <= 0) return ip;
    switch (ip) {
      case 0x092c: m.t += 5; m.pas -= 5; m.ax = ((0x2a23 + m.L) & 0xffff);  // mov ax, 0x2a23
      case 0x092f: m.es = m.ax;  // mov es, ax
      case 0x0931: m.di = 0x0;  // mov di, 0
      case 0x0934: m.ax = ((0x2523 + m.L) & 0xffff);  // mov ax, 0x2523
      case 0x0937: m.ds = m.ax;  // mov ds, ax
      case 0x0939: m.t += 2; m.pas -= 2; m.push(m.cx);  // push cx
      case 0x093a: m.dx = 0x200;  // mov dx, 0x200
      case 0x093d: m.t += 1; m.pas -= 1; m.cx = 0x8;  // mov cx, 8
      case 0x0940: m.t += 14; m.pas -= 14; m.xor16(0, 0); m.ax = 0;  // xor ax, ax
      case 0x0942: m.wb(m.ds, ((m.si + 0x800) & 0xffff), m.shl8(m.rb(m.ds, ((m.si + 0x800) & 0xffff)), 0x1));  // shl byte ptr [si + 0x800], 1
      case 0x0946: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x0948: m.wb(m.ds, ((m.si + 0x600) & 0xffff), m.shl8(m.rb(m.ds, ((m.si + 0x600) & 0xffff)), 0x1));  // shl byte ptr [si + 0x600], 1
      case 0x094c: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x094e: m.wb(m.ds, ((m.si + 0x400) & 0xffff), m.shl8(m.rb(m.ds, ((m.si + 0x400) & 0xffff)), 0x1));  // shl byte ptr [si + 0x400], 1
      case 0x0952: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x0954: m.wb(m.ds, ((m.si + 0x200) & 0xffff), m.shl8(m.rb(m.ds, ((m.si + 0x200) & 0xffff)), 0x1));  // shl byte ptr [si + 0x200], 1
      case 0x0958: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x095a: m.wb(m.ds, m.si, m.shl8(m.rb(m.ds, m.si), 0x1));  // shl byte ptr [si], 1
      case 0x095c: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x095e: m.wb(m.es, m.di, (m.ax & 0xff));  // mov byte ptr es:[di], al
      case 0x0961: m.di = m.inc16(m.di);  // inc di
      case 0x0962: m.cx = (m.cx - 1) & 0xffff; if (m.cx !== 0) { ip = 0x0940; continue; }  // loop 0x940
      case 0x0964: m.t += 3; m.pas -= 3; m.si = m.inc16(m.si);  // inc si
      case 0x0965: m.dx = m.dec16(m.dx);  // dec dx
      case 0x0966: if (!m.zf) { ip = 0x093d; continue; }  // jne 0x93d
      case 0x0968: m.t += 3; m.pas -= 3; m.si = m.add16(m.si, 0x800);  // add si, 0x800
      case 0x096c: { const t = m.pop(); m.cx = t; }  // pop cx
      case 0x096d: m.cx = (m.cx - 1) & 0xffff; if (m.cx !== 0) { ip = 0x0939; continue; }  // loop 0x939
      case 0x096f: m.t += 3; m.pas -= 3; m.ax = ((0x0 + m.L) & 0xffff);  // mov ax, 0
      case 0x0972: m.ds = m.ax;  // mov ds, ax
      case 0x0974: ip = m.pop(); continue;  // ret
      default: return ip;
    }
  }
}

// 0x0975 sub_4e25
function sub_0975_0975(m, ip) {
  for (;;) {
    if (m.pas <= 0) return ip;
    switch (ip) {
      case 0x0975: m.t += 3; m.pas -= 3; m.bx = 0x1284;  // mov bx, 0x1284
      case 0x0978: m.bx = m.add16(m.bx, m.rw(m.ds, 0x1440));  // add bx, word ptr [0x1440]
      case 0x097c: ip = m.rw(m.ds, m.bx); continue;  // jmp word ptr [bx]
      case 0x097e: m.t += 3; m.pas -= 3; m.xor8(0, 0); m.ax = (m.ax & 0xff) | (0 << 8);  // xor ah, ah
      case 0x0980: m.ax = (m.ax & 0xff00) | 0x13;  // mov al, 0x13
      case 0x0982: if (!m.interruption(0x10)) { m.pas = 0; ip = 0x0982; continue; }  // int 0x10
      case 0x0984: m.t += 1; m.pas -= 1; ip = m.pop(); continue;  // ret
      case 0x0985: m.t += 3; m.pas -= 3; m.xor8(0, 0); m.ax = (m.ax & 0xff) | (0 << 8);  // xor ah, ah
      case 0x0987: m.ax = (m.ax & 0xff00) | 0xd;  // mov al, 0xd
      case 0x0989: if (!m.interruption(0x10)) { m.pas = 0; ip = 0x0989; continue; }  // int 0x10
      case 0x098b: m.t += 1; m.pas -= 1; ip = m.pop(); continue;  // ret
      case 0x098c: m.t += 3; m.pas -= 3; m.xor8(0, 0); m.ax = (m.ax & 0xff) | (0 << 8);  // xor ah, ah
      case 0x098e: m.ax = (m.ax & 0xff00) | 0x9;  // mov al, 9
      case 0x0990: if (!m.interruption(0x10)) { m.pas = 0; ip = 0x0990; continue; }  // int 0x10
      case 0x0992: m.t += 1; m.pas -= 1; ip = m.pop(); continue;  // ret
      default: return ip;
    }
  }
}

// 0x0993 sub_4e43
function sub_0993_0993(m, ip) {
  for (;;) {
    if (m.pas <= 0) return ip;
    switch (ip) {
      case 0x0993: m.t += 1; m.pas -= 1; m.push(0x0996); ip = 0x3a9b; continue;  // call 0x3a9b
      case 0x0996: m.t += 6; m.pas -= 6; m.si = m.dx;  // mov si, dx
      case 0x0998: m.dx = 0x3c8;  // mov dx, 0x3c8
      case 0x099b: m.xor8(0, 0); m.ax = (m.ax & 0xff00) | 0;  // xor al, al
      case 0x099d: m.sortie(m.dx, (m.ax & 0xff), 1);  // out dx, al
      case 0x099e: m.dx = m.inc16(m.dx);  // inc dx
      case 0x099f: m.cx = 0x20;  // mov cx, 0x20
      case 0x09a2: m.t += 7; m.pas -= 7; m.lodsb(m.ds, 0);  // lodsb al, byte ptr [si]
      case 0x09a3: m.sortie(m.dx, (m.ax & 0xff), 1);  // out dx, al
      case 0x09a4: m.lodsb(m.ds, 0);  // lodsb al, byte ptr [si]
      case 0x09a5: m.sortie(m.dx, (m.ax & 0xff), 1);  // out dx, al
      case 0x09a6: m.lodsb(m.ds, 0);  // lodsb al, byte ptr [si]
      case 0x09a7: m.sortie(m.dx, (m.ax & 0xff), 1);  // out dx, al
      case 0x09a8: m.cx = (m.cx - 1) & 0xffff; if (m.cx !== 0) { ip = 0x09a2; continue; }  // loop 0x9a2
      case 0x09aa: m.t += 1; m.pas -= 1; ip = m.pop(); continue;  // ret
      default: return ip;
    }
  }
}

// 0x09ab sub_4e5b
function sub_09ab_09ab(m, ip) {
  for (;;) {
    if (m.pas <= 0) return ip;
    switch (ip) {
      case 0x09ab: m.t += 2; m.pas -= 2; m.push(m.bp);  // push bp
      case 0x09ac: m.push(0x09af); ip = 0x0b0f; continue;  // call 0xb0f
      case 0x09af: m.t += 5; m.pas -= 5; m.ww(m.ds, 0x1ba9, 0xd1);  // mov word ptr [0x1ba9], 0xd1
      case 0x09b5: m.ww(m.ds, 0x1ba5, 0x0);  // mov word ptr [0x1ba5], 0
      case 0x09bb: m.ax = ((0x1a26 + m.L) & 0xffff);  // mov ax, 0x1a26
      case 0x09be: m.ww(m.ds, 0x1ba3, m.ax);  // mov word ptr [0x1ba3], ax
      case 0x09c1: m.push(0x09c4); ip = 0x2d91; continue;  // call 0x2d91
      case 0x09c4: m.t += 1; m.pas -= 1; m.push(0x09c7); ip = 0x2b01; continue;  // call 0x2b01
      case 0x09c7: m.t += 2; m.pas -= 2; m.di = 0xd86;  // mov di, 0xd86
      case 0x09ca: m.push(0x09cd); ip = 0x0a83; continue;  // call 0xa83
      case 0x09cd: m.t += 12; m.pas -= 12; m.push(m.ax);  // push ax
      case 0x09ce: m.ax = ((0xa86 + m.L) & 0xffff);  // mov ax, 0xa86
      case 0x09d1: m.es = m.ax;  // mov es, ax
      case 0x09d3: { const t = m.pop(); m.ax = t; }  // pop ax
      case 0x09d4: m.push(m.ax);  // push ax
      case 0x09d5: m.ax = ((0x1a26 + m.L) & 0xffff);  // mov ax, 0x1a26
      case 0x09d8: m.ds = m.ax;  // mov ds, ax
      case 0x09da: { const t = m.pop(); m.ax = t; }  // pop ax
      case 0x09db: m.xor16(0, 0); m.di = 0;  // xor di, di
      case 0x09dd: m.si = m.di;  // mov si, di
      case 0x09df: m.cx = 0xffff;  // mov cx, 0xffff
      case 0x09e2: m.push(0x09e5); ip = 0x39dd; continue;  // call 0x39dd
      case 0x09e5: m.t += 6; m.pas -= 6; m.push(m.ax);  // push ax
      case 0x09e6: m.ax = ((0x0 + m.L) & 0xffff);  // mov ax, 0
      case 0x09e9: m.ds = m.ax;  // mov ds, ax
      case 0x09eb: { const t = m.pop(); m.ax = t; }  // pop ax
      case 0x09ec: { const t = m.pop(); m.bp = t; }  // pop bp
      case 0x09ed: m.push(0x09f0); ip = 0x258c; continue;  // call 0x258c
      case 0x09f0: m.t += 21; m.pas -= 21; m.push(m.ax);  // push ax
      case 0x09f1: m.ax = 0xa000;  // mov ax, 0xa000
      case 0x09f4: m.es = m.ax;  // mov es, ax
      case 0x09f6: { const t = m.pop(); m.ax = t; }  // pop ax
      case 0x09f7: m.push(m.ax);  // push ax
      case 0x09f8: m.ax = ((0xa86 + m.L) & 0xffff);  // mov ax, 0xa86
      case 0x09fb: m.ds = m.ax;  // mov ds, ax
      case 0x09fd: { const t = m.pop(); m.ax = t; }  // pop ax
      case 0x09fe: m.di = 0x0;  // mov di, 0
      case 0x0a01: m.si = 0x0;  // mov si, 0
      case 0x0a04: m.cx = 0x7d00;  // mov cx, 0x7d00
      case 0x0a07: m.movsw(m.ds, 1);  // rep movsw word ptr es:[di], word ptr [si]
      case 0x0a09: m.push(m.ax);  // push ax
      case 0x0a0a: m.ax = ((0x0 + m.L) & 0xffff);  // mov ax, 0
      case 0x0a0d: m.ds = m.ax;  // mov ds, ax
      case 0x0a0f: { const t = m.pop(); m.ax = t; }  // pop ax
      case 0x0a10: m.push(m.ax);  // push ax
      case 0x0a11: m.ax = ((0x0 + m.L) & 0xffff);  // mov ax, 0
      case 0x0a14: m.ds = m.ax;  // mov ds, ax
      case 0x0a16: { const t = m.pop(); m.ax = t; }  // pop ax
      case 0x0a17: m.push(0x0a1a); ip = 0x0ad2; continue;  // call 0xad2
      case 0x0a1a: m.t += 1; m.pas -= 1; ip = 0x0a6b; continue;  // jmp 0xa6b
      default: return ip;
    }
  }
}

// 0x0a1d sub_4ecd
function sub_0a1d_0a1d(m, ip) {
  for (;;) {
    if (m.pas <= 0) return ip;
    switch (ip) {
      case 0x0a1d: m.t += 2; m.pas -= 2; m.push(m.di);  // push di
      case 0x0a1e: m.push(0x0a21); ip = 0x0b0f; continue;  // call 0xb0f
      case 0x0a21: m.t += 2; m.pas -= 2; { const t = m.pop(); m.di = t; }  // pop di
      case 0x0a22: m.push(0x0a25); ip = 0x0a83; continue;  // call 0xa83
      case 0x0a25: m.t += 1; m.pas -= 1; m.push(0x0a28); ip = 0x2b01; continue;  // call 0x2b01
      case 0x0a28: m.t += 12; m.pas -= 12; m.push(m.ax);  // push ax
      case 0x0a29: m.ax = ((0xa86 + m.L) & 0xffff);  // mov ax, 0xa86
      case 0x0a2c: m.es = m.ax;  // mov es, ax
      case 0x0a2e: { const t = m.pop(); m.ax = t; }  // pop ax
      case 0x0a2f: m.push(m.ax);  // push ax
      case 0x0a30: m.ax = ((0x1a26 + m.L) & 0xffff);  // mov ax, 0x1a26
      case 0x0a33: m.ds = m.ax;  // mov ds, ax
      case 0x0a35: { const t = m.pop(); m.ax = t; }  // pop ax
      case 0x0a36: m.xor16(0, 0); m.di = 0;  // xor di, di
      case 0x0a38: m.si = m.di;  // mov si, di
      case 0x0a3a: m.cx = 0xffff;  // mov cx, 0xffff
      case 0x0a3d: m.push(0x0a40); ip = 0x39dd; continue;  // call 0x39dd
      case 0x0a40: m.t += 21; m.pas -= 21; m.push(m.ax);  // push ax
      case 0x0a41: m.ax = 0xa000;  // mov ax, 0xa000
      case 0x0a44: m.es = m.ax;  // mov es, ax
      case 0x0a46: { const t = m.pop(); m.ax = t; }  // pop ax
      case 0x0a47: m.push(m.ax);  // push ax
      case 0x0a48: m.ax = ((0xa86 + m.L) & 0xffff);  // mov ax, 0xa86
      case 0x0a4b: m.ds = m.ax;  // mov ds, ax
      case 0x0a4d: { const t = m.pop(); m.ax = t; }  // pop ax
      case 0x0a4e: m.di = 0x0;  // mov di, 0
      case 0x0a51: m.si = 0x0;  // mov si, 0
      case 0x0a54: m.cx = 0x7d00;  // mov cx, 0x7d00
      case 0x0a57: m.movsw(m.ds, 1);  // rep movsw word ptr es:[di], word ptr [si]
      case 0x0a59: m.push(m.ax);  // push ax
      case 0x0a5a: m.ax = ((0x0 + m.L) & 0xffff);  // mov ax, 0
      case 0x0a5d: m.ds = m.ax;  // mov ds, ax
      case 0x0a5f: { const t = m.pop(); m.ax = t; }  // pop ax
      case 0x0a60: m.push(m.ax);  // push ax
      case 0x0a61: m.ax = ((0x0 + m.L) & 0xffff);  // mov ax, 0
      case 0x0a64: m.ds = m.ax;  // mov ds, ax
      case 0x0a66: { const t = m.pop(); m.ax = t; }  // pop ax
      case 0x0a67: m.push(0x0a6a); ip = 0x0ad2; continue;  // call 0xad2
      case 0x0a6a: m.t += 1; m.pas -= 1; ip = m.pop(); continue;  // ret
      default: return ip;
    }
  }
}

// 0x0a6b sub_4f1b
function sub_0a6b_0a6b(m, ip) {
  for (;;) {
    if (m.pas <= 0) return ip;
    switch (ip) {
      case 0x0a6b: m.t += 2; m.pas -= 2; m.ax = (m.ax & 0xff) | (0x1 << 8);  // mov ah, 1
      case 0x0a6d: if (!m.interruption(0x16)) { m.pas = 0; ip = 0x0a6d; continue; }  // int 0x16
      case 0x0a6f: m.t += 2; m.pas -= 2; m.xor8(0, 0); m.ax = (m.ax & 0xff) | (0 << 8);  // xor ah, ah
      case 0x0a71: if (!m.interruption(0x16)) { m.pas = 0; ip = 0x0a71; continue; }  // int 0x16
      case 0x0a73: m.t += 2; m.pas -= 2; m.sub8((m.ax >> 8), 0x1);  // cmp ah, 1
      case 0x0a76: if (!m.zf) { ip = 0x0a7b; continue; }  // jne 0xa7b
      case 0x0a78: m.t += 2; m.pas -= 2; m.ax = (m.ax & 0xff00) | 0x1;  // mov al, 1
      case 0x0a7a: ip = m.pop(); continue;  // ret
      case 0x0a7b: m.t += 2; m.pas -= 2; m.sub8((m.ax >> 8), 0x39);  // cmp ah, 0x39
      case 0x0a7e: if (!m.zf) { ip = 0x0a6f; continue; }  // jne 0xa6f
      case 0x0a80: m.t += 2; m.pas -= 2; m.xor8(0, 0); m.ax = (m.ax & 0xff00) | 0;  // xor al, al
      case 0x0a82: ip = m.pop(); continue;  // ret
      default: return ip;
    }
  }
}

// 0x0a83 sub_4f33
function sub_0a83_0a83(m, ip) {
  for (;;) {
    if (m.pas <= 0) return ip;
    switch (ip) {
      case 0x0a83: m.t += 2; m.pas -= 2; m.si = 0x10a4;  // mov si, 0x10a4
      case 0x0a86: m.cx = 0x20;  // mov cx, 0x20
      case 0x0a89: m.t += 33; m.pas -= 33; m.ax = (m.ax & 0xff) | (m.rb(m.ds, m.di) << 8);  // mov ah, byte ptr [di]
      case 0x0a8b: m.ax = (m.ax & 0xff00) | 0x0;  // mov al, 0
      case 0x0a8d: m.ax = m.shr16(m.ax, 0x1);  // shr ax, 1
      case 0x0a8f: m.ax = m.shr16(m.ax, 0x1);  // shr ax, 1
      case 0x0a91: m.ax = m.shr16(m.ax, 0x1);  // shr ax, 1
      case 0x0a93: m.ax = m.shr16(m.ax, 0x1);  // shr ax, 1
      case 0x0a95: m.ax = m.shr16(m.ax, 0x1);  // shr ax, 1
      case 0x0a97: m.ax = m.shr16(m.ax, 0x1);  // shr ax, 1
      case 0x0a99: m.ax = m.shr16(m.ax, 0x1);  // shr ax, 1
      case 0x0a9b: m.ww(m.ds, m.si, m.ax);  // mov word ptr [si], ax
      case 0x0a9d: m.ax = (m.ax & 0xff) | (m.rb(m.ds, ((m.di + 0x1) & 0xffff)) << 8);  // mov ah, byte ptr [di + 1]
      case 0x0aa0: m.ax = (m.ax & 0xff00) | 0x0;  // mov al, 0
      case 0x0aa2: m.ax = m.shr16(m.ax, 0x1);  // shr ax, 1
      case 0x0aa4: m.ax = m.shr16(m.ax, 0x1);  // shr ax, 1
      case 0x0aa6: m.ax = m.shr16(m.ax, 0x1);  // shr ax, 1
      case 0x0aa8: m.ax = m.shr16(m.ax, 0x1);  // shr ax, 1
      case 0x0aaa: m.ax = m.shr16(m.ax, 0x1);  // shr ax, 1
      case 0x0aac: m.ax = m.shr16(m.ax, 0x1);  // shr ax, 1
      case 0x0aae: m.ax = m.shr16(m.ax, 0x1);  // shr ax, 1
      case 0x0ab0: m.ww(m.ds, ((m.si + 0x2) & 0xffff), m.ax);  // mov word ptr [si + 2], ax
      case 0x0ab3: m.ax = (m.ax & 0xff) | (m.rb(m.ds, ((m.di + 0x2) & 0xffff)) << 8);  // mov ah, byte ptr [di + 2]
      case 0x0ab6: m.ax = (m.ax & 0xff00) | 0x0;  // mov al, 0
      case 0x0ab8: m.ax = m.shr16(m.ax, 0x1);  // shr ax, 1
      case 0x0aba: m.ax = m.shr16(m.ax, 0x1);  // shr ax, 1
      case 0x0abc: m.ax = m.shr16(m.ax, 0x1);  // shr ax, 1
      case 0x0abe: m.ax = m.shr16(m.ax, 0x1);  // shr ax, 1
      case 0x0ac0: m.ax = m.shr16(m.ax, 0x1);  // shr ax, 1
      case 0x0ac2: m.ax = m.shr16(m.ax, 0x1);  // shr ax, 1
      case 0x0ac4: m.ax = m.shr16(m.ax, 0x1);  // shr ax, 1
      case 0x0ac6: m.ww(m.ds, ((m.si + 0x4) & 0xffff), m.ax);  // mov word ptr [si + 4], ax
      case 0x0ac9: m.di = m.add16(m.di, 0x3);  // add di, 3
      case 0x0acc: m.si = m.add16(m.si, 0x6);  // add si, 6
      case 0x0acf: m.cx = (m.cx - 1) & 0xffff; if (m.cx !== 0) { ip = 0x0a89; continue; }  // loop 0xa89
      case 0x0ad1: m.t += 1; m.pas -= 1; ip = m.pop(); continue;  // ret
      default: return ip;
    }
  }
}

// 0x0ad2 sub_4f82
function sub_0ad2_0ad2(m, ip) {
  for (;;) {
    if (m.pas <= 0) return ip;
    switch (ip) {
      case 0x0ad2: m.t += 7; m.pas -= 7; m.di = 0x1164;  // mov di, 0x1164
      case 0x0ad5: m.ax = m.ds;  // mov ax, ds
      case 0x0ad7: m.es = m.ax;  // mov es, ax
      case 0x0ad9: m.ax = 0x0;  // mov ax, 0
      case 0x0adc: m.cx = 0x60;  // mov cx, 0x60
      case 0x0adf: m.stosw(m.ds, 1);  // rep stosw word ptr es:[di], ax
      case 0x0ae1: m.cx = 0x80;  // mov cx, 0x80
      case 0x0ae4: m.t += 5; m.pas -= 5; m.push(m.cx);  // push cx
      case 0x0ae5: m.cx = 0x60;  // mov cx, 0x60
      case 0x0ae8: m.si = 0x1164;  // mov si, 0x1164
      case 0x0aeb: m.di = 0x1224;  // mov di, 0x1224
      case 0x0aee: m.bx = 0x10a4;  // mov bx, 0x10a4
      case 0x0af1: m.t += 8; m.pas -= 8; m.ax = m.rw(m.ds, m.si);  // mov ax, word ptr [si]
      case 0x0af3: m.ax = m.add16(m.ax, m.rw(m.ds, m.bx));  // add ax, word ptr [bx]
      case 0x0af5: m.ww(m.ds, m.si, m.ax);  // mov word ptr [si], ax
      case 0x0af7: m.wb(m.ds, m.di, (m.ax >> 8));  // mov byte ptr [di], ah
      case 0x0af9: m.si = m.add16(m.si, 0x2);  // add si, 2
      case 0x0afc: m.bx = m.add16(m.bx, 0x2);  // add bx, 2
      case 0x0aff: m.di = m.inc16(m.di);  // inc di
      case 0x0b00: m.cx = (m.cx - 1) & 0xffff; if (m.cx !== 0) { ip = 0x0af1; continue; }  // loop 0xaf1
      case 0x0b02: m.t += 1; m.pas -= 1; m.push(0x0b05); ip = 0x3a9b; continue;  // call 0x3a9b
      case 0x0b05: m.t += 2; m.pas -= 2; m.dx = 0x1224;  // mov dx, 0x1224
      case 0x0b08: m.push(0x0b0b); ip = 0x0993; continue;  // call 0x993
      case 0x0b0b: m.t += 2; m.pas -= 2; { const t = m.pop(); m.cx = t; }  // pop cx
      case 0x0b0c: m.cx = (m.cx - 1) & 0xffff; if (m.cx !== 0) { ip = 0x0ae4; continue; }  // loop 0xae4
      case 0x0b0e: m.t += 1; m.pas -= 1; ip = m.pop(); continue;  // ret
      default: return ip;
    }
  }
}

// 0x0b0f sub_4fbf
function sub_0b0f_0b0f(m, ip) {
  for (;;) {
    if (m.pas <= 0) return ip;
    switch (ip) {
      case 0x0b0f: m.t += 1; m.pas -= 1; m.cx = 0x80;  // mov cx, 0x80
      case 0x0b12: m.t += 5; m.pas -= 5; m.push(m.cx);  // push cx
      case 0x0b13: m.cx = 0x60;  // mov cx, 0x60
      case 0x0b16: m.si = 0x1164;  // mov si, 0x1164
      case 0x0b19: m.di = 0x1224;  // mov di, 0x1224
      case 0x0b1c: m.bx = 0x10a4;  // mov bx, 0x10a4
      case 0x0b1f: m.t += 8; m.pas -= 8; m.ax = m.rw(m.ds, m.si);  // mov ax, word ptr [si]
      case 0x0b21: m.ax = m.sub16(m.ax, m.rw(m.ds, m.bx));  // sub ax, word ptr [bx]
      case 0x0b23: m.ww(m.ds, m.si, m.ax);  // mov word ptr [si], ax
      case 0x0b25: m.wb(m.ds, m.di, (m.ax >> 8));  // mov byte ptr [di], ah
      case 0x0b27: m.si = m.add16(m.si, 0x2);  // add si, 2
      case 0x0b2a: m.bx = m.add16(m.bx, 0x2);  // add bx, 2
      case 0x0b2d: m.di = m.inc16(m.di);  // inc di
      case 0x0b2e: m.cx = (m.cx - 1) & 0xffff; if (m.cx !== 0) { ip = 0x0b1f; continue; }  // loop 0xb1f
      case 0x0b30: m.t += 1; m.pas -= 1; m.push(0x0b33); ip = 0x3a9b; continue;  // call 0x3a9b
      case 0x0b33: m.t += 2; m.pas -= 2; m.dx = 0x1224;  // mov dx, 0x1224
      case 0x0b36: m.push(0x0b39); ip = 0x0993; continue;  // call 0x993
      case 0x0b39: m.t += 2; m.pas -= 2; { const t = m.pop(); m.cx = t; }  // pop cx
      case 0x0b3a: m.cx = (m.cx - 1) & 0xffff; if (m.cx !== 0) { ip = 0x0b12; continue; }  // loop 0xb12
      case 0x0b3c: m.t += 1; m.pas -= 1; ip = m.pop(); continue;  // ret
      default: return ip;
    }
  }
}

// 0x0b3d sub_4fed
function sub_0b3d_0b3d(m, ip) {
  for (;;) {
    if (m.pas <= 0) return ip;
    switch (ip) {
      case 0x0b3d: m.t += 11; m.pas -= 11; m.push(m.ax);  // push ax
      case 0x0b3e: m.ax = 0xb800;  // mov ax, 0xb800
      case 0x0b41: m.es = m.ax;  // mov es, ax
      case 0x0b43: { const t = m.pop(); m.ax = t; }  // pop ax
      case 0x0b44: m.push(m.ax);  // push ax
      case 0x0b45: m.ax = ((0xa86 + m.L) & 0xffff);  // mov ax, 0xa86
      case 0x0b48: m.ds = m.ax;  // mov ds, ax
      case 0x0b4a: { const t = m.pop(); m.ax = t; }  // pop ax
      case 0x0b4b: m.si = 0x0;  // mov si, 0
      case 0x0b4e: m.di = 0x0;  // mov di, 0
      case 0x0b51: m.ww(m.cs, 0x23ef, 0xc8);  // mov word ptr cs:[0x23ef], 0xc8
      case 0x0b58: m.t += 2963; m.pas -= 2963; m.ax = (m.ax & 0xff) | (m.rb(m.ds, ((m.si + 0x78) & 0xffff)) << 8);  // mov ah, byte ptr [si + 0x78]
      case 0x0b5b: m.ax = (m.ax & 0xff00) | m.rb(m.ds, ((m.si + 0x79) & 0xffff));  // mov al, byte ptr [si + 0x79]
      case 0x0b5e: m.bp = m.ax;  // mov bp, ax
      case 0x0b60: m.bx = (m.bx & 0xff) | (m.rb(m.ds, ((m.si + 0x50) & 0xffff)) << 8);  // mov bh, byte ptr [si + 0x50]
      case 0x0b63: m.bx = (m.bx & 0xff00) | m.rb(m.ds, ((m.si + 0x51) & 0xffff));  // mov bl, byte ptr [si + 0x51]
      case 0x0b66: m.cx = (m.cx & 0xff) | (m.rb(m.ds, ((m.si + 0x28) & 0xffff)) << 8);  // mov ch, byte ptr [si + 0x28]
      case 0x0b69: m.cx = (m.cx & 0xff00) | m.rb(m.ds, ((m.si + 0x29) & 0xffff));  // mov cl, byte ptr [si + 0x29]
      case 0x0b6c: m.dx = (m.dx & 0xff) | (m.rb(m.ds, m.si) << 8);  // mov dh, byte ptr [si]
      case 0x0b6e: m.dx = (m.dx & 0xff00) | m.rb(m.ds, ((m.si + 0x1) & 0xffff));  // mov dl, byte ptr [si + 1]
      case 0x0b71: m.ax = 0x0;  // mov ax, 0
      case 0x0b74: m.dx = m.shl16(m.dx, 0x1);  // shl dx, 1
      case 0x0b76: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x0b78: m.cx = m.shl16(m.cx, 0x1);  // shl cx, 1
      case 0x0b7a: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x0b7c: m.bx = m.shl16(m.bx, 0x1);  // shl bx, 1
      case 0x0b7e: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x0b80: m.bp = m.shl16(m.bp, 0x1);  // shl bp, 1
      case 0x0b82: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x0b84: m.dx = m.shl16(m.dx, 0x1);  // shl dx, 1
      case 0x0b86: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x0b88: m.cx = m.shl16(m.cx, 0x1);  // shl cx, 1
      case 0x0b8a: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x0b8c: m.bx = m.shl16(m.bx, 0x1);  // shl bx, 1
      case 0x0b8e: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x0b90: m.bp = m.shl16(m.bp, 0x1);  // shl bp, 1
      case 0x0b92: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x0b94: m.dx = m.shl16(m.dx, 0x1);  // shl dx, 1
      case 0x0b96: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x0b98: m.cx = m.shl16(m.cx, 0x1);  // shl cx, 1
      case 0x0b9a: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x0b9c: m.bx = m.shl16(m.bx, 0x1);  // shl bx, 1
      case 0x0b9e: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x0ba0: m.bp = m.shl16(m.bp, 0x1);  // shl bp, 1
      case 0x0ba2: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x0ba4: m.dx = m.shl16(m.dx, 0x1);  // shl dx, 1
      case 0x0ba6: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x0ba8: m.cx = m.shl16(m.cx, 0x1);  // shl cx, 1
      case 0x0baa: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x0bac: m.bx = m.shl16(m.bx, 0x1);  // shl bx, 1
      case 0x0bae: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x0bb0: m.bp = m.shl16(m.bp, 0x1);  // shl bp, 1
      case 0x0bb2: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x0bb4: { const t = (m.ax & 0xff); m.ax = (m.ax & 0xff00) | (m.ax >> 8); m.ax = (m.ax & 0xff) | (t << 8); }  // xchg al, ah
      case 0x0bb6: m.ww(m.es, m.di, m.ax);  // mov word ptr es:[di], ax
      case 0x0bb9: m.dx = m.shl16(m.dx, 0x1);  // shl dx, 1
      case 0x0bbb: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x0bbd: m.cx = m.shl16(m.cx, 0x1);  // shl cx, 1
      case 0x0bbf: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x0bc1: m.bx = m.shl16(m.bx, 0x1);  // shl bx, 1
      case 0x0bc3: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x0bc5: m.bp = m.shl16(m.bp, 0x1);  // shl bp, 1
      case 0x0bc7: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x0bc9: m.dx = m.shl16(m.dx, 0x1);  // shl dx, 1
      case 0x0bcb: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x0bcd: m.cx = m.shl16(m.cx, 0x1);  // shl cx, 1
      case 0x0bcf: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x0bd1: m.bx = m.shl16(m.bx, 0x1);  // shl bx, 1
      case 0x0bd3: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x0bd5: m.bp = m.shl16(m.bp, 0x1);  // shl bp, 1
      case 0x0bd7: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x0bd9: m.dx = m.shl16(m.dx, 0x1);  // shl dx, 1
      case 0x0bdb: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x0bdd: m.cx = m.shl16(m.cx, 0x1);  // shl cx, 1
      case 0x0bdf: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x0be1: m.bx = m.shl16(m.bx, 0x1);  // shl bx, 1
      case 0x0be3: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x0be5: m.bp = m.shl16(m.bp, 0x1);  // shl bp, 1
      case 0x0be7: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x0be9: m.dx = m.shl16(m.dx, 0x1);  // shl dx, 1
      case 0x0beb: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x0bed: m.cx = m.shl16(m.cx, 0x1);  // shl cx, 1
      case 0x0bef: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x0bf1: m.bx = m.shl16(m.bx, 0x1);  // shl bx, 1
      case 0x0bf3: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x0bf5: m.bp = m.shl16(m.bp, 0x1);  // shl bp, 1
      case 0x0bf7: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x0bf9: { const t = (m.ax & 0xff); m.ax = (m.ax & 0xff00) | (m.ax >> 8); m.ax = (m.ax & 0xff) | (t << 8); }  // xchg al, ah
      case 0x0bfb: m.ww(m.es, ((m.di + 0x2) & 0xffff), m.ax);  // mov word ptr es:[di + 2], ax
      case 0x0bff: m.dx = m.shl16(m.dx, 0x1);  // shl dx, 1
      case 0x0c01: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x0c03: m.cx = m.shl16(m.cx, 0x1);  // shl cx, 1
      case 0x0c05: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x0c07: m.bx = m.shl16(m.bx, 0x1);  // shl bx, 1
      case 0x0c09: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x0c0b: m.bp = m.shl16(m.bp, 0x1);  // shl bp, 1
      case 0x0c0d: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x0c0f: m.dx = m.shl16(m.dx, 0x1);  // shl dx, 1
      case 0x0c11: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x0c13: m.cx = m.shl16(m.cx, 0x1);  // shl cx, 1
      case 0x0c15: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x0c17: m.bx = m.shl16(m.bx, 0x1);  // shl bx, 1
      case 0x0c19: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x0c1b: m.bp = m.shl16(m.bp, 0x1);  // shl bp, 1
      case 0x0c1d: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x0c1f: m.dx = m.shl16(m.dx, 0x1);  // shl dx, 1
      case 0x0c21: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x0c23: m.cx = m.shl16(m.cx, 0x1);  // shl cx, 1
      case 0x0c25: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x0c27: m.bx = m.shl16(m.bx, 0x1);  // shl bx, 1
      case 0x0c29: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x0c2b: m.bp = m.shl16(m.bp, 0x1);  // shl bp, 1
      case 0x0c2d: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x0c2f: m.dx = m.shl16(m.dx, 0x1);  // shl dx, 1
      case 0x0c31: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x0c33: m.cx = m.shl16(m.cx, 0x1);  // shl cx, 1
      case 0x0c35: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x0c37: m.bx = m.shl16(m.bx, 0x1);  // shl bx, 1
      case 0x0c39: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x0c3b: m.bp = m.shl16(m.bp, 0x1);  // shl bp, 1
      case 0x0c3d: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x0c3f: { const t = (m.ax & 0xff); m.ax = (m.ax & 0xff00) | (m.ax >> 8); m.ax = (m.ax & 0xff) | (t << 8); }  // xchg al, ah
      case 0x0c41: m.ww(m.es, ((m.di + 0x4) & 0xffff), m.ax);  // mov word ptr es:[di + 4], ax
      case 0x0c45: m.dx = m.shl16(m.dx, 0x1);  // shl dx, 1
      case 0x0c47: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x0c49: m.cx = m.shl16(m.cx, 0x1);  // shl cx, 1
      case 0x0c4b: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x0c4d: m.bx = m.shl16(m.bx, 0x1);  // shl bx, 1
      case 0x0c4f: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x0c51: m.bp = m.shl16(m.bp, 0x1);  // shl bp, 1
      case 0x0c53: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x0c55: m.dx = m.shl16(m.dx, 0x1);  // shl dx, 1
      case 0x0c57: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x0c59: m.cx = m.shl16(m.cx, 0x1);  // shl cx, 1
      case 0x0c5b: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x0c5d: m.bx = m.shl16(m.bx, 0x1);  // shl bx, 1
      case 0x0c5f: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x0c61: m.bp = m.shl16(m.bp, 0x1);  // shl bp, 1
      case 0x0c63: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x0c65: m.dx = m.shl16(m.dx, 0x1);  // shl dx, 1
      case 0x0c67: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x0c69: m.cx = m.shl16(m.cx, 0x1);  // shl cx, 1
      case 0x0c6b: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x0c6d: m.bx = m.shl16(m.bx, 0x1);  // shl bx, 1
      case 0x0c6f: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x0c71: m.bp = m.shl16(m.bp, 0x1);  // shl bp, 1
      case 0x0c73: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x0c75: m.dx = m.shl16(m.dx, 0x1);  // shl dx, 1
      case 0x0c77: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x0c79: m.cx = m.shl16(m.cx, 0x1);  // shl cx, 1
      case 0x0c7b: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x0c7d: m.bx = m.shl16(m.bx, 0x1);  // shl bx, 1
      case 0x0c7f: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x0c81: m.bp = m.shl16(m.bp, 0x1);  // shl bp, 1
      case 0x0c83: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x0c85: { const t = (m.ax & 0xff); m.ax = (m.ax & 0xff00) | (m.ax >> 8); m.ax = (m.ax & 0xff) | (t << 8); }  // xchg al, ah
      case 0x0c87: m.ww(m.es, ((m.di + 0x6) & 0xffff), m.ax);  // mov word ptr es:[di + 6], ax
      case 0x0c8b: m.si = m.add16(m.si, 0x2);  // add si, 2
      case 0x0c8e: m.di = m.add16(m.di, 0x8);  // add di, 8
      case 0x0c91: m.ax = (m.ax & 0xff) | (m.rb(m.ds, ((m.si + 0x78) & 0xffff)) << 8);  // mov ah, byte ptr [si + 0x78]
      case 0x0c94: m.ax = (m.ax & 0xff00) | m.rb(m.ds, ((m.si + 0x79) & 0xffff));  // mov al, byte ptr [si + 0x79]
      case 0x0c97: m.bp = m.ax;  // mov bp, ax
      case 0x0c99: m.bx = (m.bx & 0xff) | (m.rb(m.ds, ((m.si + 0x50) & 0xffff)) << 8);  // mov bh, byte ptr [si + 0x50]
      case 0x0c9c: m.bx = (m.bx & 0xff00) | m.rb(m.ds, ((m.si + 0x51) & 0xffff));  // mov bl, byte ptr [si + 0x51]
      case 0x0c9f: m.cx = (m.cx & 0xff) | (m.rb(m.ds, ((m.si + 0x28) & 0xffff)) << 8);  // mov ch, byte ptr [si + 0x28]
      case 0x0ca2: m.cx = (m.cx & 0xff00) | m.rb(m.ds, ((m.si + 0x29) & 0xffff));  // mov cl, byte ptr [si + 0x29]
      case 0x0ca5: m.dx = (m.dx & 0xff) | (m.rb(m.ds, m.si) << 8);  // mov dh, byte ptr [si]
      case 0x0ca7: m.dx = (m.dx & 0xff00) | m.rb(m.ds, ((m.si + 0x1) & 0xffff));  // mov dl, byte ptr [si + 1]
      case 0x0caa: m.ax = 0x0;  // mov ax, 0
      case 0x0cad: m.dx = m.shl16(m.dx, 0x1);  // shl dx, 1
      case 0x0caf: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x0cb1: m.cx = m.shl16(m.cx, 0x1);  // shl cx, 1
      case 0x0cb3: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x0cb5: m.bx = m.shl16(m.bx, 0x1);  // shl bx, 1
      case 0x0cb7: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x0cb9: m.bp = m.shl16(m.bp, 0x1);  // shl bp, 1
      case 0x0cbb: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x0cbd: m.dx = m.shl16(m.dx, 0x1);  // shl dx, 1
      case 0x0cbf: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x0cc1: m.cx = m.shl16(m.cx, 0x1);  // shl cx, 1
      case 0x0cc3: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x0cc5: m.bx = m.shl16(m.bx, 0x1);  // shl bx, 1
      case 0x0cc7: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x0cc9: m.bp = m.shl16(m.bp, 0x1);  // shl bp, 1
      case 0x0ccb: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x0ccd: m.dx = m.shl16(m.dx, 0x1);  // shl dx, 1
      case 0x0ccf: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x0cd1: m.cx = m.shl16(m.cx, 0x1);  // shl cx, 1
      case 0x0cd3: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x0cd5: m.bx = m.shl16(m.bx, 0x1);  // shl bx, 1
      case 0x0cd7: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x0cd9: m.bp = m.shl16(m.bp, 0x1);  // shl bp, 1
      case 0x0cdb: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x0cdd: m.dx = m.shl16(m.dx, 0x1);  // shl dx, 1
      case 0x0cdf: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x0ce1: m.cx = m.shl16(m.cx, 0x1);  // shl cx, 1
      case 0x0ce3: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x0ce5: m.bx = m.shl16(m.bx, 0x1);  // shl bx, 1
      case 0x0ce7: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x0ce9: m.bp = m.shl16(m.bp, 0x1);  // shl bp, 1
      case 0x0ceb: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x0ced: { const t = (m.ax & 0xff); m.ax = (m.ax & 0xff00) | (m.ax >> 8); m.ax = (m.ax & 0xff) | (t << 8); }  // xchg al, ah
      case 0x0cef: m.ww(m.es, m.di, m.ax);  // mov word ptr es:[di], ax
      case 0x0cf2: m.dx = m.shl16(m.dx, 0x1);  // shl dx, 1
      case 0x0cf4: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x0cf6: m.cx = m.shl16(m.cx, 0x1);  // shl cx, 1
      case 0x0cf8: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x0cfa: m.bx = m.shl16(m.bx, 0x1);  // shl bx, 1
      case 0x0cfc: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x0cfe: m.bp = m.shl16(m.bp, 0x1);  // shl bp, 1
      case 0x0d00: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x0d02: m.dx = m.shl16(m.dx, 0x1);  // shl dx, 1
      case 0x0d04: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x0d06: m.cx = m.shl16(m.cx, 0x1);  // shl cx, 1
      case 0x0d08: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x0d0a: m.bx = m.shl16(m.bx, 0x1);  // shl bx, 1
      case 0x0d0c: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x0d0e: m.bp = m.shl16(m.bp, 0x1);  // shl bp, 1
      case 0x0d10: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x0d12: m.dx = m.shl16(m.dx, 0x1);  // shl dx, 1
      case 0x0d14: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x0d16: m.cx = m.shl16(m.cx, 0x1);  // shl cx, 1
      case 0x0d18: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x0d1a: m.bx = m.shl16(m.bx, 0x1);  // shl bx, 1
      case 0x0d1c: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x0d1e: m.bp = m.shl16(m.bp, 0x1);  // shl bp, 1
      case 0x0d20: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x0d22: m.dx = m.shl16(m.dx, 0x1);  // shl dx, 1
      case 0x0d24: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x0d26: m.cx = m.shl16(m.cx, 0x1);  // shl cx, 1
      case 0x0d28: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x0d2a: m.bx = m.shl16(m.bx, 0x1);  // shl bx, 1
      case 0x0d2c: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x0d2e: m.bp = m.shl16(m.bp, 0x1);  // shl bp, 1
      case 0x0d30: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x0d32: { const t = (m.ax & 0xff); m.ax = (m.ax & 0xff00) | (m.ax >> 8); m.ax = (m.ax & 0xff) | (t << 8); }  // xchg al, ah
      case 0x0d34: m.ww(m.es, ((m.di + 0x2) & 0xffff), m.ax);  // mov word ptr es:[di + 2], ax
      case 0x0d38: m.dx = m.shl16(m.dx, 0x1);  // shl dx, 1
      case 0x0d3a: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x0d3c: m.cx = m.shl16(m.cx, 0x1);  // shl cx, 1
      case 0x0d3e: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x0d40: m.bx = m.shl16(m.bx, 0x1);  // shl bx, 1
      case 0x0d42: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x0d44: m.bp = m.shl16(m.bp, 0x1);  // shl bp, 1
      case 0x0d46: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x0d48: m.dx = m.shl16(m.dx, 0x1);  // shl dx, 1
      case 0x0d4a: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x0d4c: m.cx = m.shl16(m.cx, 0x1);  // shl cx, 1
      case 0x0d4e: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x0d50: m.bx = m.shl16(m.bx, 0x1);  // shl bx, 1
      case 0x0d52: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x0d54: m.bp = m.shl16(m.bp, 0x1);  // shl bp, 1
      case 0x0d56: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x0d58: m.dx = m.shl16(m.dx, 0x1);  // shl dx, 1
      case 0x0d5a: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x0d5c: m.cx = m.shl16(m.cx, 0x1);  // shl cx, 1
      case 0x0d5e: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x0d60: m.bx = m.shl16(m.bx, 0x1);  // shl bx, 1
      case 0x0d62: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x0d64: m.bp = m.shl16(m.bp, 0x1);  // shl bp, 1
      case 0x0d66: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x0d68: m.dx = m.shl16(m.dx, 0x1);  // shl dx, 1
      case 0x0d6a: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x0d6c: m.cx = m.shl16(m.cx, 0x1);  // shl cx, 1
      case 0x0d6e: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x0d70: m.bx = m.shl16(m.bx, 0x1);  // shl bx, 1
      case 0x0d72: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x0d74: m.bp = m.shl16(m.bp, 0x1);  // shl bp, 1
      case 0x0d76: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x0d78: { const t = (m.ax & 0xff); m.ax = (m.ax & 0xff00) | (m.ax >> 8); m.ax = (m.ax & 0xff) | (t << 8); }  // xchg al, ah
      case 0x0d7a: m.ww(m.es, ((m.di + 0x4) & 0xffff), m.ax);  // mov word ptr es:[di + 4], ax
      case 0x0d7e: m.dx = m.shl16(m.dx, 0x1);  // shl dx, 1
      case 0x0d80: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x0d82: m.cx = m.shl16(m.cx, 0x1);  // shl cx, 1
      case 0x0d84: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x0d86: m.bx = m.shl16(m.bx, 0x1);  // shl bx, 1
      case 0x0d88: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x0d8a: m.bp = m.shl16(m.bp, 0x1);  // shl bp, 1
      case 0x0d8c: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x0d8e: m.dx = m.shl16(m.dx, 0x1);  // shl dx, 1
      case 0x0d90: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x0d92: m.cx = m.shl16(m.cx, 0x1);  // shl cx, 1
      case 0x0d94: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x0d96: m.bx = m.shl16(m.bx, 0x1);  // shl bx, 1
      case 0x0d98: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x0d9a: m.bp = m.shl16(m.bp, 0x1);  // shl bp, 1
      case 0x0d9c: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x0d9e: m.dx = m.shl16(m.dx, 0x1);  // shl dx, 1
      case 0x0da0: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x0da2: m.cx = m.shl16(m.cx, 0x1);  // shl cx, 1
      case 0x0da4: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x0da6: m.bx = m.shl16(m.bx, 0x1);  // shl bx, 1
      case 0x0da8: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x0daa: m.bp = m.shl16(m.bp, 0x1);  // shl bp, 1
      case 0x0dac: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x0dae: m.dx = m.shl16(m.dx, 0x1);  // shl dx, 1
      case 0x0db0: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x0db2: m.cx = m.shl16(m.cx, 0x1);  // shl cx, 1
      case 0x0db4: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x0db6: m.bx = m.shl16(m.bx, 0x1);  // shl bx, 1
      case 0x0db8: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x0dba: m.bp = m.shl16(m.bp, 0x1);  // shl bp, 1
      case 0x0dbc: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x0dbe: { const t = (m.ax & 0xff); m.ax = (m.ax & 0xff00) | (m.ax >> 8); m.ax = (m.ax & 0xff) | (t << 8); }  // xchg al, ah
      case 0x0dc0: m.ww(m.es, ((m.di + 0x6) & 0xffff), m.ax);  // mov word ptr es:[di + 6], ax
      case 0x0dc4: m.si = m.add16(m.si, 0x2);  // add si, 2
      case 0x0dc7: m.di = m.add16(m.di, 0x8);  // add di, 8
      case 0x0dca: m.ax = (m.ax & 0xff) | (m.rb(m.ds, ((m.si + 0x78) & 0xffff)) << 8);  // mov ah, byte ptr [si + 0x78]
      case 0x0dcd: m.ax = (m.ax & 0xff00) | m.rb(m.ds, ((m.si + 0x79) & 0xffff));  // mov al, byte ptr [si + 0x79]
      case 0x0dd0: m.bp = m.ax;  // mov bp, ax
      case 0x0dd2: m.bx = (m.bx & 0xff) | (m.rb(m.ds, ((m.si + 0x50) & 0xffff)) << 8);  // mov bh, byte ptr [si + 0x50]
      case 0x0dd5: m.bx = (m.bx & 0xff00) | m.rb(m.ds, ((m.si + 0x51) & 0xffff));  // mov bl, byte ptr [si + 0x51]
      case 0x0dd8: m.cx = (m.cx & 0xff) | (m.rb(m.ds, ((m.si + 0x28) & 0xffff)) << 8);  // mov ch, byte ptr [si + 0x28]
      case 0x0ddb: m.cx = (m.cx & 0xff00) | m.rb(m.ds, ((m.si + 0x29) & 0xffff));  // mov cl, byte ptr [si + 0x29]
      case 0x0dde: m.dx = (m.dx & 0xff) | (m.rb(m.ds, m.si) << 8);  // mov dh, byte ptr [si]
      case 0x0de0: m.dx = (m.dx & 0xff00) | m.rb(m.ds, ((m.si + 0x1) & 0xffff));  // mov dl, byte ptr [si + 1]
      case 0x0de3: m.ax = 0x0;  // mov ax, 0
      case 0x0de6: m.dx = m.shl16(m.dx, 0x1);  // shl dx, 1
      case 0x0de8: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x0dea: m.cx = m.shl16(m.cx, 0x1);  // shl cx, 1
      case 0x0dec: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x0dee: m.bx = m.shl16(m.bx, 0x1);  // shl bx, 1
      case 0x0df0: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x0df2: m.bp = m.shl16(m.bp, 0x1);  // shl bp, 1
      case 0x0df4: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x0df6: m.dx = m.shl16(m.dx, 0x1);  // shl dx, 1
      case 0x0df8: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x0dfa: m.cx = m.shl16(m.cx, 0x1);  // shl cx, 1
      case 0x0dfc: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x0dfe: m.bx = m.shl16(m.bx, 0x1);  // shl bx, 1
      case 0x0e00: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x0e02: m.bp = m.shl16(m.bp, 0x1);  // shl bp, 1
      case 0x0e04: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x0e06: m.dx = m.shl16(m.dx, 0x1);  // shl dx, 1
      case 0x0e08: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x0e0a: m.cx = m.shl16(m.cx, 0x1);  // shl cx, 1
      case 0x0e0c: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x0e0e: m.bx = m.shl16(m.bx, 0x1);  // shl bx, 1
      case 0x0e10: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x0e12: m.bp = m.shl16(m.bp, 0x1);  // shl bp, 1
      case 0x0e14: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x0e16: m.dx = m.shl16(m.dx, 0x1);  // shl dx, 1
      case 0x0e18: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x0e1a: m.cx = m.shl16(m.cx, 0x1);  // shl cx, 1
      case 0x0e1c: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x0e1e: m.bx = m.shl16(m.bx, 0x1);  // shl bx, 1
      case 0x0e20: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x0e22: m.bp = m.shl16(m.bp, 0x1);  // shl bp, 1
      case 0x0e24: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x0e26: { const t = (m.ax & 0xff); m.ax = (m.ax & 0xff00) | (m.ax >> 8); m.ax = (m.ax & 0xff) | (t << 8); }  // xchg al, ah
      case 0x0e28: m.ww(m.es, m.di, m.ax);  // mov word ptr es:[di], ax
      case 0x0e2b: m.dx = m.shl16(m.dx, 0x1);  // shl dx, 1
      case 0x0e2d: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x0e2f: m.cx = m.shl16(m.cx, 0x1);  // shl cx, 1
      case 0x0e31: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x0e33: m.bx = m.shl16(m.bx, 0x1);  // shl bx, 1
      case 0x0e35: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x0e37: m.bp = m.shl16(m.bp, 0x1);  // shl bp, 1
      case 0x0e39: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x0e3b: m.dx = m.shl16(m.dx, 0x1);  // shl dx, 1
      case 0x0e3d: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x0e3f: m.cx = m.shl16(m.cx, 0x1);  // shl cx, 1
      case 0x0e41: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x0e43: m.bx = m.shl16(m.bx, 0x1);  // shl bx, 1
      case 0x0e45: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x0e47: m.bp = m.shl16(m.bp, 0x1);  // shl bp, 1
      case 0x0e49: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x0e4b: m.dx = m.shl16(m.dx, 0x1);  // shl dx, 1
      case 0x0e4d: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x0e4f: m.cx = m.shl16(m.cx, 0x1);  // shl cx, 1
      case 0x0e51: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x0e53: m.bx = m.shl16(m.bx, 0x1);  // shl bx, 1
      case 0x0e55: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x0e57: m.bp = m.shl16(m.bp, 0x1);  // shl bp, 1
      case 0x0e59: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x0e5b: m.dx = m.shl16(m.dx, 0x1);  // shl dx, 1
      case 0x0e5d: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x0e5f: m.cx = m.shl16(m.cx, 0x1);  // shl cx, 1
      case 0x0e61: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x0e63: m.bx = m.shl16(m.bx, 0x1);  // shl bx, 1
      case 0x0e65: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x0e67: m.bp = m.shl16(m.bp, 0x1);  // shl bp, 1
      case 0x0e69: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x0e6b: { const t = (m.ax & 0xff); m.ax = (m.ax & 0xff00) | (m.ax >> 8); m.ax = (m.ax & 0xff) | (t << 8); }  // xchg al, ah
      case 0x0e6d: m.ww(m.es, ((m.di + 0x2) & 0xffff), m.ax);  // mov word ptr es:[di + 2], ax
      case 0x0e71: m.dx = m.shl16(m.dx, 0x1);  // shl dx, 1
      case 0x0e73: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x0e75: m.cx = m.shl16(m.cx, 0x1);  // shl cx, 1
      case 0x0e77: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x0e79: m.bx = m.shl16(m.bx, 0x1);  // shl bx, 1
      case 0x0e7b: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x0e7d: m.bp = m.shl16(m.bp, 0x1);  // shl bp, 1
      case 0x0e7f: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x0e81: m.dx = m.shl16(m.dx, 0x1);  // shl dx, 1
      case 0x0e83: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x0e85: m.cx = m.shl16(m.cx, 0x1);  // shl cx, 1
      case 0x0e87: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x0e89: m.bx = m.shl16(m.bx, 0x1);  // shl bx, 1
      case 0x0e8b: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x0e8d: m.bp = m.shl16(m.bp, 0x1);  // shl bp, 1
      case 0x0e8f: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x0e91: m.dx = m.shl16(m.dx, 0x1);  // shl dx, 1
      case 0x0e93: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x0e95: m.cx = m.shl16(m.cx, 0x1);  // shl cx, 1
      case 0x0e97: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x0e99: m.bx = m.shl16(m.bx, 0x1);  // shl bx, 1
      case 0x0e9b: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x0e9d: m.bp = m.shl16(m.bp, 0x1);  // shl bp, 1
      case 0x0e9f: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x0ea1: m.dx = m.shl16(m.dx, 0x1);  // shl dx, 1
      case 0x0ea3: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x0ea5: m.cx = m.shl16(m.cx, 0x1);  // shl cx, 1
      case 0x0ea7: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x0ea9: m.bx = m.shl16(m.bx, 0x1);  // shl bx, 1
      case 0x0eab: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x0ead: m.bp = m.shl16(m.bp, 0x1);  // shl bp, 1
      case 0x0eaf: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x0eb1: { const t = (m.ax & 0xff); m.ax = (m.ax & 0xff00) | (m.ax >> 8); m.ax = (m.ax & 0xff) | (t << 8); }  // xchg al, ah
      case 0x0eb3: m.ww(m.es, ((m.di + 0x4) & 0xffff), m.ax);  // mov word ptr es:[di + 4], ax
      case 0x0eb7: m.dx = m.shl16(m.dx, 0x1);  // shl dx, 1
      case 0x0eb9: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x0ebb: m.cx = m.shl16(m.cx, 0x1);  // shl cx, 1
      case 0x0ebd: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x0ebf: m.bx = m.shl16(m.bx, 0x1);  // shl bx, 1
      case 0x0ec1: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x0ec3: m.bp = m.shl16(m.bp, 0x1);  // shl bp, 1
      case 0x0ec5: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x0ec7: m.dx = m.shl16(m.dx, 0x1);  // shl dx, 1
      case 0x0ec9: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x0ecb: m.cx = m.shl16(m.cx, 0x1);  // shl cx, 1
      case 0x0ecd: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x0ecf: m.bx = m.shl16(m.bx, 0x1);  // shl bx, 1
      case 0x0ed1: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x0ed3: m.bp = m.shl16(m.bp, 0x1);  // shl bp, 1
      case 0x0ed5: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x0ed7: m.dx = m.shl16(m.dx, 0x1);  // shl dx, 1
      case 0x0ed9: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x0edb: m.cx = m.shl16(m.cx, 0x1);  // shl cx, 1
      case 0x0edd: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x0edf: m.bx = m.shl16(m.bx, 0x1);  // shl bx, 1
      case 0x0ee1: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x0ee3: m.bp = m.shl16(m.bp, 0x1);  // shl bp, 1
      case 0x0ee5: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x0ee7: m.dx = m.shl16(m.dx, 0x1);  // shl dx, 1
      case 0x0ee9: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x0eeb: m.cx = m.shl16(m.cx, 0x1);  // shl cx, 1
      case 0x0eed: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x0eef: m.bx = m.shl16(m.bx, 0x1);  // shl bx, 1
      case 0x0ef1: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x0ef3: m.bp = m.shl16(m.bp, 0x1);  // shl bp, 1
      case 0x0ef5: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x0ef7: { const t = (m.ax & 0xff); m.ax = (m.ax & 0xff00) | (m.ax >> 8); m.ax = (m.ax & 0xff) | (t << 8); }  // xchg al, ah
      case 0x0ef9: m.ww(m.es, ((m.di + 0x6) & 0xffff), m.ax);  // mov word ptr es:[di + 6], ax
      case 0x0efd: m.si = m.add16(m.si, 0x2);  // add si, 2
      case 0x0f00: m.di = m.add16(m.di, 0x8);  // add di, 8
      case 0x0f03: m.ax = (m.ax & 0xff) | (m.rb(m.ds, ((m.si + 0x78) & 0xffff)) << 8);  // mov ah, byte ptr [si + 0x78]
      case 0x0f06: m.ax = (m.ax & 0xff00) | m.rb(m.ds, ((m.si + 0x79) & 0xffff));  // mov al, byte ptr [si + 0x79]
      case 0x0f09: m.bp = m.ax;  // mov bp, ax
      case 0x0f0b: m.bx = (m.bx & 0xff) | (m.rb(m.ds, ((m.si + 0x50) & 0xffff)) << 8);  // mov bh, byte ptr [si + 0x50]
      case 0x0f0e: m.bx = (m.bx & 0xff00) | m.rb(m.ds, ((m.si + 0x51) & 0xffff));  // mov bl, byte ptr [si + 0x51]
      case 0x0f11: m.cx = (m.cx & 0xff) | (m.rb(m.ds, ((m.si + 0x28) & 0xffff)) << 8);  // mov ch, byte ptr [si + 0x28]
      case 0x0f14: m.cx = (m.cx & 0xff00) | m.rb(m.ds, ((m.si + 0x29) & 0xffff));  // mov cl, byte ptr [si + 0x29]
      case 0x0f17: m.dx = (m.dx & 0xff) | (m.rb(m.ds, m.si) << 8);  // mov dh, byte ptr [si]
      case 0x0f19: m.dx = (m.dx & 0xff00) | m.rb(m.ds, ((m.si + 0x1) & 0xffff));  // mov dl, byte ptr [si + 1]
      case 0x0f1c: m.ax = 0x0;  // mov ax, 0
      case 0x0f1f: m.dx = m.shl16(m.dx, 0x1);  // shl dx, 1
      case 0x0f21: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x0f23: m.cx = m.shl16(m.cx, 0x1);  // shl cx, 1
      case 0x0f25: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x0f27: m.bx = m.shl16(m.bx, 0x1);  // shl bx, 1
      case 0x0f29: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x0f2b: m.bp = m.shl16(m.bp, 0x1);  // shl bp, 1
      case 0x0f2d: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x0f2f: m.dx = m.shl16(m.dx, 0x1);  // shl dx, 1
      case 0x0f31: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x0f33: m.cx = m.shl16(m.cx, 0x1);  // shl cx, 1
      case 0x0f35: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x0f37: m.bx = m.shl16(m.bx, 0x1);  // shl bx, 1
      case 0x0f39: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x0f3b: m.bp = m.shl16(m.bp, 0x1);  // shl bp, 1
      case 0x0f3d: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x0f3f: m.dx = m.shl16(m.dx, 0x1);  // shl dx, 1
      case 0x0f41: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x0f43: m.cx = m.shl16(m.cx, 0x1);  // shl cx, 1
      case 0x0f45: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x0f47: m.bx = m.shl16(m.bx, 0x1);  // shl bx, 1
      case 0x0f49: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x0f4b: m.bp = m.shl16(m.bp, 0x1);  // shl bp, 1
      case 0x0f4d: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x0f4f: m.dx = m.shl16(m.dx, 0x1);  // shl dx, 1
      case 0x0f51: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x0f53: m.cx = m.shl16(m.cx, 0x1);  // shl cx, 1
      case 0x0f55: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x0f57: m.bx = m.shl16(m.bx, 0x1);  // shl bx, 1
      case 0x0f59: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x0f5b: m.bp = m.shl16(m.bp, 0x1);  // shl bp, 1
      case 0x0f5d: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x0f5f: { const t = (m.ax & 0xff); m.ax = (m.ax & 0xff00) | (m.ax >> 8); m.ax = (m.ax & 0xff) | (t << 8); }  // xchg al, ah
      case 0x0f61: m.ww(m.es, m.di, m.ax);  // mov word ptr es:[di], ax
      case 0x0f64: m.dx = m.shl16(m.dx, 0x1);  // shl dx, 1
      case 0x0f66: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x0f68: m.cx = m.shl16(m.cx, 0x1);  // shl cx, 1
      case 0x0f6a: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x0f6c: m.bx = m.shl16(m.bx, 0x1);  // shl bx, 1
      case 0x0f6e: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x0f70: m.bp = m.shl16(m.bp, 0x1);  // shl bp, 1
      case 0x0f72: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x0f74: m.dx = m.shl16(m.dx, 0x1);  // shl dx, 1
      case 0x0f76: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x0f78: m.cx = m.shl16(m.cx, 0x1);  // shl cx, 1
      case 0x0f7a: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x0f7c: m.bx = m.shl16(m.bx, 0x1);  // shl bx, 1
      case 0x0f7e: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x0f80: m.bp = m.shl16(m.bp, 0x1);  // shl bp, 1
      case 0x0f82: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x0f84: m.dx = m.shl16(m.dx, 0x1);  // shl dx, 1
      case 0x0f86: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x0f88: m.cx = m.shl16(m.cx, 0x1);  // shl cx, 1
      case 0x0f8a: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x0f8c: m.bx = m.shl16(m.bx, 0x1);  // shl bx, 1
      case 0x0f8e: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x0f90: m.bp = m.shl16(m.bp, 0x1);  // shl bp, 1
      case 0x0f92: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x0f94: m.dx = m.shl16(m.dx, 0x1);  // shl dx, 1
      case 0x0f96: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x0f98: m.cx = m.shl16(m.cx, 0x1);  // shl cx, 1
      case 0x0f9a: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x0f9c: m.bx = m.shl16(m.bx, 0x1);  // shl bx, 1
      case 0x0f9e: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x0fa0: m.bp = m.shl16(m.bp, 0x1);  // shl bp, 1
      case 0x0fa2: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x0fa4: { const t = (m.ax & 0xff); m.ax = (m.ax & 0xff00) | (m.ax >> 8); m.ax = (m.ax & 0xff) | (t << 8); }  // xchg al, ah
      case 0x0fa6: m.ww(m.es, ((m.di + 0x2) & 0xffff), m.ax);  // mov word ptr es:[di + 2], ax
      case 0x0faa: m.dx = m.shl16(m.dx, 0x1);  // shl dx, 1
      case 0x0fac: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x0fae: m.cx = m.shl16(m.cx, 0x1);  // shl cx, 1
      case 0x0fb0: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x0fb2: m.bx = m.shl16(m.bx, 0x1);  // shl bx, 1
      case 0x0fb4: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x0fb6: m.bp = m.shl16(m.bp, 0x1);  // shl bp, 1
      case 0x0fb8: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x0fba: m.dx = m.shl16(m.dx, 0x1);  // shl dx, 1
      case 0x0fbc: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x0fbe: m.cx = m.shl16(m.cx, 0x1);  // shl cx, 1
      case 0x0fc0: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x0fc2: m.bx = m.shl16(m.bx, 0x1);  // shl bx, 1
      case 0x0fc4: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x0fc6: m.bp = m.shl16(m.bp, 0x1);  // shl bp, 1
      case 0x0fc8: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x0fca: m.dx = m.shl16(m.dx, 0x1);  // shl dx, 1
      case 0x0fcc: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x0fce: m.cx = m.shl16(m.cx, 0x1);  // shl cx, 1
      case 0x0fd0: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x0fd2: m.bx = m.shl16(m.bx, 0x1);  // shl bx, 1
      case 0x0fd4: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x0fd6: m.bp = m.shl16(m.bp, 0x1);  // shl bp, 1
      case 0x0fd8: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x0fda: m.dx = m.shl16(m.dx, 0x1);  // shl dx, 1
      case 0x0fdc: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x0fde: m.cx = m.shl16(m.cx, 0x1);  // shl cx, 1
      case 0x0fe0: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x0fe2: m.bx = m.shl16(m.bx, 0x1);  // shl bx, 1
      case 0x0fe4: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x0fe6: m.bp = m.shl16(m.bp, 0x1);  // shl bp, 1
      case 0x0fe8: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x0fea: { const t = (m.ax & 0xff); m.ax = (m.ax & 0xff00) | (m.ax >> 8); m.ax = (m.ax & 0xff) | (t << 8); }  // xchg al, ah
      case 0x0fec: m.ww(m.es, ((m.di + 0x4) & 0xffff), m.ax);  // mov word ptr es:[di + 4], ax
      case 0x0ff0: m.dx = m.shl16(m.dx, 0x1);  // shl dx, 1
      case 0x0ff2: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x0ff4: m.cx = m.shl16(m.cx, 0x1);  // shl cx, 1
      case 0x0ff6: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x0ff8: m.bx = m.shl16(m.bx, 0x1);  // shl bx, 1
      case 0x0ffa: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x0ffc: m.bp = m.shl16(m.bp, 0x1);  // shl bp, 1
      case 0x0ffe: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1000: m.dx = m.shl16(m.dx, 0x1);  // shl dx, 1
      case 0x1002: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1004: m.cx = m.shl16(m.cx, 0x1);  // shl cx, 1
      case 0x1006: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1008: m.bx = m.shl16(m.bx, 0x1);  // shl bx, 1
      case 0x100a: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x100c: m.bp = m.shl16(m.bp, 0x1);  // shl bp, 1
      case 0x100e: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1010: m.dx = m.shl16(m.dx, 0x1);  // shl dx, 1
      case 0x1012: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1014: m.cx = m.shl16(m.cx, 0x1);  // shl cx, 1
      case 0x1016: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1018: m.bx = m.shl16(m.bx, 0x1);  // shl bx, 1
      case 0x101a: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x101c: m.bp = m.shl16(m.bp, 0x1);  // shl bp, 1
      case 0x101e: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1020: m.dx = m.shl16(m.dx, 0x1);  // shl dx, 1
      case 0x1022: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1024: m.cx = m.shl16(m.cx, 0x1);  // shl cx, 1
      case 0x1026: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1028: m.bx = m.shl16(m.bx, 0x1);  // shl bx, 1
      case 0x102a: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x102c: m.bp = m.shl16(m.bp, 0x1);  // shl bp, 1
      case 0x102e: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1030: { const t = (m.ax & 0xff); m.ax = (m.ax & 0xff00) | (m.ax >> 8); m.ax = (m.ax & 0xff) | (t << 8); }  // xchg al, ah
      case 0x1032: m.ww(m.es, ((m.di + 0x6) & 0xffff), m.ax);  // mov word ptr es:[di + 6], ax
      case 0x1036: m.si = m.add16(m.si, 0x2);  // add si, 2
      case 0x1039: m.di = m.add16(m.di, 0x8);  // add di, 8
      case 0x103c: m.ax = (m.ax & 0xff) | (m.rb(m.ds, ((m.si + 0x78) & 0xffff)) << 8);  // mov ah, byte ptr [si + 0x78]
      case 0x103f: m.ax = (m.ax & 0xff00) | m.rb(m.ds, ((m.si + 0x79) & 0xffff));  // mov al, byte ptr [si + 0x79]
      case 0x1042: m.bp = m.ax;  // mov bp, ax
      case 0x1044: m.bx = (m.bx & 0xff) | (m.rb(m.ds, ((m.si + 0x50) & 0xffff)) << 8);  // mov bh, byte ptr [si + 0x50]
      case 0x1047: m.bx = (m.bx & 0xff00) | m.rb(m.ds, ((m.si + 0x51) & 0xffff));  // mov bl, byte ptr [si + 0x51]
      case 0x104a: m.cx = (m.cx & 0xff) | (m.rb(m.ds, ((m.si + 0x28) & 0xffff)) << 8);  // mov ch, byte ptr [si + 0x28]
      case 0x104d: m.cx = (m.cx & 0xff00) | m.rb(m.ds, ((m.si + 0x29) & 0xffff));  // mov cl, byte ptr [si + 0x29]
      case 0x1050: m.dx = (m.dx & 0xff) | (m.rb(m.ds, m.si) << 8);  // mov dh, byte ptr [si]
      case 0x1052: m.dx = (m.dx & 0xff00) | m.rb(m.ds, ((m.si + 0x1) & 0xffff));  // mov dl, byte ptr [si + 1]
      case 0x1055: m.ax = 0x0;  // mov ax, 0
      case 0x1058: m.dx = m.shl16(m.dx, 0x1);  // shl dx, 1
      case 0x105a: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x105c: m.cx = m.shl16(m.cx, 0x1);  // shl cx, 1
      case 0x105e: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1060: m.bx = m.shl16(m.bx, 0x1);  // shl bx, 1
      case 0x1062: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1064: m.bp = m.shl16(m.bp, 0x1);  // shl bp, 1
      case 0x1066: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1068: m.dx = m.shl16(m.dx, 0x1);  // shl dx, 1
      case 0x106a: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x106c: m.cx = m.shl16(m.cx, 0x1);  // shl cx, 1
      case 0x106e: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1070: m.bx = m.shl16(m.bx, 0x1);  // shl bx, 1
      case 0x1072: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1074: m.bp = m.shl16(m.bp, 0x1);  // shl bp, 1
      case 0x1076: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1078: m.dx = m.shl16(m.dx, 0x1);  // shl dx, 1
      case 0x107a: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x107c: m.cx = m.shl16(m.cx, 0x1);  // shl cx, 1
      case 0x107e: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1080: m.bx = m.shl16(m.bx, 0x1);  // shl bx, 1
      case 0x1082: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1084: m.bp = m.shl16(m.bp, 0x1);  // shl bp, 1
      case 0x1086: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1088: m.dx = m.shl16(m.dx, 0x1);  // shl dx, 1
      case 0x108a: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x108c: m.cx = m.shl16(m.cx, 0x1);  // shl cx, 1
      case 0x108e: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1090: m.bx = m.shl16(m.bx, 0x1);  // shl bx, 1
      case 0x1092: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1094: m.bp = m.shl16(m.bp, 0x1);  // shl bp, 1
      case 0x1096: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1098: { const t = (m.ax & 0xff); m.ax = (m.ax & 0xff00) | (m.ax >> 8); m.ax = (m.ax & 0xff) | (t << 8); }  // xchg al, ah
      case 0x109a: m.ww(m.es, m.di, m.ax);  // mov word ptr es:[di], ax
      case 0x109d: m.dx = m.shl16(m.dx, 0x1);  // shl dx, 1
      case 0x109f: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x10a1: m.cx = m.shl16(m.cx, 0x1);  // shl cx, 1
      case 0x10a3: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x10a5: m.bx = m.shl16(m.bx, 0x1);  // shl bx, 1
      case 0x10a7: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x10a9: m.bp = m.shl16(m.bp, 0x1);  // shl bp, 1
      case 0x10ab: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x10ad: m.dx = m.shl16(m.dx, 0x1);  // shl dx, 1
      case 0x10af: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x10b1: m.cx = m.shl16(m.cx, 0x1);  // shl cx, 1
      case 0x10b3: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x10b5: m.bx = m.shl16(m.bx, 0x1);  // shl bx, 1
      case 0x10b7: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x10b9: m.bp = m.shl16(m.bp, 0x1);  // shl bp, 1
      case 0x10bb: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x10bd: m.dx = m.shl16(m.dx, 0x1);  // shl dx, 1
      case 0x10bf: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x10c1: m.cx = m.shl16(m.cx, 0x1);  // shl cx, 1
      case 0x10c3: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x10c5: m.bx = m.shl16(m.bx, 0x1);  // shl bx, 1
      case 0x10c7: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x10c9: m.bp = m.shl16(m.bp, 0x1);  // shl bp, 1
      case 0x10cb: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x10cd: m.dx = m.shl16(m.dx, 0x1);  // shl dx, 1
      case 0x10cf: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x10d1: m.cx = m.shl16(m.cx, 0x1);  // shl cx, 1
      case 0x10d3: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x10d5: m.bx = m.shl16(m.bx, 0x1);  // shl bx, 1
      case 0x10d7: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x10d9: m.bp = m.shl16(m.bp, 0x1);  // shl bp, 1
      case 0x10db: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x10dd: { const t = (m.ax & 0xff); m.ax = (m.ax & 0xff00) | (m.ax >> 8); m.ax = (m.ax & 0xff) | (t << 8); }  // xchg al, ah
      case 0x10df: m.ww(m.es, ((m.di + 0x2) & 0xffff), m.ax);  // mov word ptr es:[di + 2], ax
      case 0x10e3: m.dx = m.shl16(m.dx, 0x1);  // shl dx, 1
      case 0x10e5: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x10e7: m.cx = m.shl16(m.cx, 0x1);  // shl cx, 1
      case 0x10e9: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x10eb: m.bx = m.shl16(m.bx, 0x1);  // shl bx, 1
      case 0x10ed: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x10ef: m.bp = m.shl16(m.bp, 0x1);  // shl bp, 1
      case 0x10f1: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x10f3: m.dx = m.shl16(m.dx, 0x1);  // shl dx, 1
      case 0x10f5: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x10f7: m.cx = m.shl16(m.cx, 0x1);  // shl cx, 1
      case 0x10f9: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x10fb: m.bx = m.shl16(m.bx, 0x1);  // shl bx, 1
      case 0x10fd: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x10ff: m.bp = m.shl16(m.bp, 0x1);  // shl bp, 1
      case 0x1101: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1103: m.dx = m.shl16(m.dx, 0x1);  // shl dx, 1
      case 0x1105: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1107: m.cx = m.shl16(m.cx, 0x1);  // shl cx, 1
      case 0x1109: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x110b: m.bx = m.shl16(m.bx, 0x1);  // shl bx, 1
      case 0x110d: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x110f: m.bp = m.shl16(m.bp, 0x1);  // shl bp, 1
      case 0x1111: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1113: m.dx = m.shl16(m.dx, 0x1);  // shl dx, 1
      case 0x1115: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1117: m.cx = m.shl16(m.cx, 0x1);  // shl cx, 1
      case 0x1119: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x111b: m.bx = m.shl16(m.bx, 0x1);  // shl bx, 1
      case 0x111d: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x111f: m.bp = m.shl16(m.bp, 0x1);  // shl bp, 1
      case 0x1121: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1123: { const t = (m.ax & 0xff); m.ax = (m.ax & 0xff00) | (m.ax >> 8); m.ax = (m.ax & 0xff) | (t << 8); }  // xchg al, ah
      case 0x1125: m.ww(m.es, ((m.di + 0x4) & 0xffff), m.ax);  // mov word ptr es:[di + 4], ax
      case 0x1129: m.dx = m.shl16(m.dx, 0x1);  // shl dx, 1
      case 0x112b: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x112d: m.cx = m.shl16(m.cx, 0x1);  // shl cx, 1
      case 0x112f: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1131: m.bx = m.shl16(m.bx, 0x1);  // shl bx, 1
      case 0x1133: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1135: m.bp = m.shl16(m.bp, 0x1);  // shl bp, 1
      case 0x1137: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1139: m.dx = m.shl16(m.dx, 0x1);  // shl dx, 1
      case 0x113b: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x113d: m.cx = m.shl16(m.cx, 0x1);  // shl cx, 1
      case 0x113f: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1141: m.bx = m.shl16(m.bx, 0x1);  // shl bx, 1
      case 0x1143: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1145: m.bp = m.shl16(m.bp, 0x1);  // shl bp, 1
      case 0x1147: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1149: m.dx = m.shl16(m.dx, 0x1);  // shl dx, 1
      case 0x114b: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x114d: m.cx = m.shl16(m.cx, 0x1);  // shl cx, 1
      case 0x114f: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1151: m.bx = m.shl16(m.bx, 0x1);  // shl bx, 1
      case 0x1153: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1155: m.bp = m.shl16(m.bp, 0x1);  // shl bp, 1
      case 0x1157: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1159: m.dx = m.shl16(m.dx, 0x1);  // shl dx, 1
      case 0x115b: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x115d: m.cx = m.shl16(m.cx, 0x1);  // shl cx, 1
      case 0x115f: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1161: m.bx = m.shl16(m.bx, 0x1);  // shl bx, 1
      case 0x1163: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1165: m.bp = m.shl16(m.bp, 0x1);  // shl bp, 1
      case 0x1167: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1169: { const t = (m.ax & 0xff); m.ax = (m.ax & 0xff00) | (m.ax >> 8); m.ax = (m.ax & 0xff) | (t << 8); }  // xchg al, ah
      case 0x116b: m.ww(m.es, ((m.di + 0x6) & 0xffff), m.ax);  // mov word ptr es:[di + 6], ax
      case 0x116f: m.si = m.add16(m.si, 0x2);  // add si, 2
      case 0x1172: m.di = m.add16(m.di, 0x8);  // add di, 8
      case 0x1175: m.ax = (m.ax & 0xff) | (m.rb(m.ds, ((m.si + 0x78) & 0xffff)) << 8);  // mov ah, byte ptr [si + 0x78]
      case 0x1178: m.ax = (m.ax & 0xff00) | m.rb(m.ds, ((m.si + 0x79) & 0xffff));  // mov al, byte ptr [si + 0x79]
      case 0x117b: m.bp = m.ax;  // mov bp, ax
      case 0x117d: m.bx = (m.bx & 0xff) | (m.rb(m.ds, ((m.si + 0x50) & 0xffff)) << 8);  // mov bh, byte ptr [si + 0x50]
      case 0x1180: m.bx = (m.bx & 0xff00) | m.rb(m.ds, ((m.si + 0x51) & 0xffff));  // mov bl, byte ptr [si + 0x51]
      case 0x1183: m.cx = (m.cx & 0xff) | (m.rb(m.ds, ((m.si + 0x28) & 0xffff)) << 8);  // mov ch, byte ptr [si + 0x28]
      case 0x1186: m.cx = (m.cx & 0xff00) | m.rb(m.ds, ((m.si + 0x29) & 0xffff));  // mov cl, byte ptr [si + 0x29]
      case 0x1189: m.dx = (m.dx & 0xff) | (m.rb(m.ds, m.si) << 8);  // mov dh, byte ptr [si]
      case 0x118b: m.dx = (m.dx & 0xff00) | m.rb(m.ds, ((m.si + 0x1) & 0xffff));  // mov dl, byte ptr [si + 1]
      case 0x118e: m.ax = 0x0;  // mov ax, 0
      case 0x1191: m.dx = m.shl16(m.dx, 0x1);  // shl dx, 1
      case 0x1193: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1195: m.cx = m.shl16(m.cx, 0x1);  // shl cx, 1
      case 0x1197: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1199: m.bx = m.shl16(m.bx, 0x1);  // shl bx, 1
      case 0x119b: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x119d: m.bp = m.shl16(m.bp, 0x1);  // shl bp, 1
      case 0x119f: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x11a1: m.dx = m.shl16(m.dx, 0x1);  // shl dx, 1
      case 0x11a3: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x11a5: m.cx = m.shl16(m.cx, 0x1);  // shl cx, 1
      case 0x11a7: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x11a9: m.bx = m.shl16(m.bx, 0x1);  // shl bx, 1
      case 0x11ab: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x11ad: m.bp = m.shl16(m.bp, 0x1);  // shl bp, 1
      case 0x11af: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x11b1: m.dx = m.shl16(m.dx, 0x1);  // shl dx, 1
      case 0x11b3: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x11b5: m.cx = m.shl16(m.cx, 0x1);  // shl cx, 1
      case 0x11b7: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x11b9: m.bx = m.shl16(m.bx, 0x1);  // shl bx, 1
      case 0x11bb: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x11bd: m.bp = m.shl16(m.bp, 0x1);  // shl bp, 1
      case 0x11bf: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x11c1: m.dx = m.shl16(m.dx, 0x1);  // shl dx, 1
      case 0x11c3: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x11c5: m.cx = m.shl16(m.cx, 0x1);  // shl cx, 1
      case 0x11c7: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x11c9: m.bx = m.shl16(m.bx, 0x1);  // shl bx, 1
      case 0x11cb: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x11cd: m.bp = m.shl16(m.bp, 0x1);  // shl bp, 1
      case 0x11cf: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x11d1: { const t = (m.ax & 0xff); m.ax = (m.ax & 0xff00) | (m.ax >> 8); m.ax = (m.ax & 0xff) | (t << 8); }  // xchg al, ah
      case 0x11d3: m.ww(m.es, m.di, m.ax);  // mov word ptr es:[di], ax
      case 0x11d6: m.dx = m.shl16(m.dx, 0x1);  // shl dx, 1
      case 0x11d8: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x11da: m.cx = m.shl16(m.cx, 0x1);  // shl cx, 1
      case 0x11dc: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x11de: m.bx = m.shl16(m.bx, 0x1);  // shl bx, 1
      case 0x11e0: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x11e2: m.bp = m.shl16(m.bp, 0x1);  // shl bp, 1
      case 0x11e4: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x11e6: m.dx = m.shl16(m.dx, 0x1);  // shl dx, 1
      case 0x11e8: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x11ea: m.cx = m.shl16(m.cx, 0x1);  // shl cx, 1
      case 0x11ec: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x11ee: m.bx = m.shl16(m.bx, 0x1);  // shl bx, 1
      case 0x11f0: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x11f2: m.bp = m.shl16(m.bp, 0x1);  // shl bp, 1
      case 0x11f4: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x11f6: m.dx = m.shl16(m.dx, 0x1);  // shl dx, 1
      case 0x11f8: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x11fa: m.cx = m.shl16(m.cx, 0x1);  // shl cx, 1
      case 0x11fc: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x11fe: m.bx = m.shl16(m.bx, 0x1);  // shl bx, 1
      case 0x1200: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1202: m.bp = m.shl16(m.bp, 0x1);  // shl bp, 1
      case 0x1204: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1206: m.dx = m.shl16(m.dx, 0x1);  // shl dx, 1
      case 0x1208: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x120a: m.cx = m.shl16(m.cx, 0x1);  // shl cx, 1
      case 0x120c: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x120e: m.bx = m.shl16(m.bx, 0x1);  // shl bx, 1
      case 0x1210: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1212: m.bp = m.shl16(m.bp, 0x1);  // shl bp, 1
      case 0x1214: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1216: { const t = (m.ax & 0xff); m.ax = (m.ax & 0xff00) | (m.ax >> 8); m.ax = (m.ax & 0xff) | (t << 8); }  // xchg al, ah
      case 0x1218: m.ww(m.es, ((m.di + 0x2) & 0xffff), m.ax);  // mov word ptr es:[di + 2], ax
      case 0x121c: m.dx = m.shl16(m.dx, 0x1);  // shl dx, 1
      case 0x121e: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1220: m.cx = m.shl16(m.cx, 0x1);  // shl cx, 1
      case 0x1222: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1224: m.bx = m.shl16(m.bx, 0x1);  // shl bx, 1
      case 0x1226: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1228: m.bp = m.shl16(m.bp, 0x1);  // shl bp, 1
      case 0x122a: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x122c: m.dx = m.shl16(m.dx, 0x1);  // shl dx, 1
      case 0x122e: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1230: m.cx = m.shl16(m.cx, 0x1);  // shl cx, 1
      case 0x1232: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1234: m.bx = m.shl16(m.bx, 0x1);  // shl bx, 1
      case 0x1236: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1238: m.bp = m.shl16(m.bp, 0x1);  // shl bp, 1
      case 0x123a: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x123c: m.dx = m.shl16(m.dx, 0x1);  // shl dx, 1
      case 0x123e: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1240: m.cx = m.shl16(m.cx, 0x1);  // shl cx, 1
      case 0x1242: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1244: m.bx = m.shl16(m.bx, 0x1);  // shl bx, 1
      case 0x1246: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1248: m.bp = m.shl16(m.bp, 0x1);  // shl bp, 1
      case 0x124a: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x124c: m.dx = m.shl16(m.dx, 0x1);  // shl dx, 1
      case 0x124e: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1250: m.cx = m.shl16(m.cx, 0x1);  // shl cx, 1
      case 0x1252: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1254: m.bx = m.shl16(m.bx, 0x1);  // shl bx, 1
      case 0x1256: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1258: m.bp = m.shl16(m.bp, 0x1);  // shl bp, 1
      case 0x125a: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x125c: { const t = (m.ax & 0xff); m.ax = (m.ax & 0xff00) | (m.ax >> 8); m.ax = (m.ax & 0xff) | (t << 8); }  // xchg al, ah
      case 0x125e: m.ww(m.es, ((m.di + 0x4) & 0xffff), m.ax);  // mov word ptr es:[di + 4], ax
      case 0x1262: m.dx = m.shl16(m.dx, 0x1);  // shl dx, 1
      case 0x1264: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1266: m.cx = m.shl16(m.cx, 0x1);  // shl cx, 1
      case 0x1268: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x126a: m.bx = m.shl16(m.bx, 0x1);  // shl bx, 1
      case 0x126c: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x126e: m.bp = m.shl16(m.bp, 0x1);  // shl bp, 1
      case 0x1270: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1272: m.dx = m.shl16(m.dx, 0x1);  // shl dx, 1
      case 0x1274: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1276: m.cx = m.shl16(m.cx, 0x1);  // shl cx, 1
      case 0x1278: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x127a: m.bx = m.shl16(m.bx, 0x1);  // shl bx, 1
      case 0x127c: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x127e: m.bp = m.shl16(m.bp, 0x1);  // shl bp, 1
      case 0x1280: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1282: m.dx = m.shl16(m.dx, 0x1);  // shl dx, 1
      case 0x1284: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1286: m.cx = m.shl16(m.cx, 0x1);  // shl cx, 1
      case 0x1288: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x128a: m.bx = m.shl16(m.bx, 0x1);  // shl bx, 1
      case 0x128c: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x128e: m.bp = m.shl16(m.bp, 0x1);  // shl bp, 1
      case 0x1290: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1292: m.dx = m.shl16(m.dx, 0x1);  // shl dx, 1
      case 0x1294: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1296: m.cx = m.shl16(m.cx, 0x1);  // shl cx, 1
      case 0x1298: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x129a: m.bx = m.shl16(m.bx, 0x1);  // shl bx, 1
      case 0x129c: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x129e: m.bp = m.shl16(m.bp, 0x1);  // shl bp, 1
      case 0x12a0: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x12a2: { const t = (m.ax & 0xff); m.ax = (m.ax & 0xff00) | (m.ax >> 8); m.ax = (m.ax & 0xff) | (t << 8); }  // xchg al, ah
      case 0x12a4: m.ww(m.es, ((m.di + 0x6) & 0xffff), m.ax);  // mov word ptr es:[di + 6], ax
      case 0x12a8: m.si = m.add16(m.si, 0x2);  // add si, 2
      case 0x12ab: m.di = m.add16(m.di, 0x8);  // add di, 8
      case 0x12ae: m.ax = (m.ax & 0xff) | (m.rb(m.ds, ((m.si + 0x78) & 0xffff)) << 8);  // mov ah, byte ptr [si + 0x78]
      case 0x12b1: m.ax = (m.ax & 0xff00) | m.rb(m.ds, ((m.si + 0x79) & 0xffff));  // mov al, byte ptr [si + 0x79]
      case 0x12b4: m.bp = m.ax;  // mov bp, ax
      case 0x12b6: m.bx = (m.bx & 0xff) | (m.rb(m.ds, ((m.si + 0x50) & 0xffff)) << 8);  // mov bh, byte ptr [si + 0x50]
      case 0x12b9: m.bx = (m.bx & 0xff00) | m.rb(m.ds, ((m.si + 0x51) & 0xffff));  // mov bl, byte ptr [si + 0x51]
      case 0x12bc: m.cx = (m.cx & 0xff) | (m.rb(m.ds, ((m.si + 0x28) & 0xffff)) << 8);  // mov ch, byte ptr [si + 0x28]
      case 0x12bf: m.cx = (m.cx & 0xff00) | m.rb(m.ds, ((m.si + 0x29) & 0xffff));  // mov cl, byte ptr [si + 0x29]
      case 0x12c2: m.dx = (m.dx & 0xff) | (m.rb(m.ds, m.si) << 8);  // mov dh, byte ptr [si]
      case 0x12c4: m.dx = (m.dx & 0xff00) | m.rb(m.ds, ((m.si + 0x1) & 0xffff));  // mov dl, byte ptr [si + 1]
      case 0x12c7: m.ax = 0x0;  // mov ax, 0
      case 0x12ca: m.dx = m.shl16(m.dx, 0x1);  // shl dx, 1
      case 0x12cc: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x12ce: m.cx = m.shl16(m.cx, 0x1);  // shl cx, 1
      case 0x12d0: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x12d2: m.bx = m.shl16(m.bx, 0x1);  // shl bx, 1
      case 0x12d4: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x12d6: m.bp = m.shl16(m.bp, 0x1);  // shl bp, 1
      case 0x12d8: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x12da: m.dx = m.shl16(m.dx, 0x1);  // shl dx, 1
      case 0x12dc: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x12de: m.cx = m.shl16(m.cx, 0x1);  // shl cx, 1
      case 0x12e0: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x12e2: m.bx = m.shl16(m.bx, 0x1);  // shl bx, 1
      case 0x12e4: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x12e6: m.bp = m.shl16(m.bp, 0x1);  // shl bp, 1
      case 0x12e8: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x12ea: m.dx = m.shl16(m.dx, 0x1);  // shl dx, 1
      case 0x12ec: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x12ee: m.cx = m.shl16(m.cx, 0x1);  // shl cx, 1
      case 0x12f0: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x12f2: m.bx = m.shl16(m.bx, 0x1);  // shl bx, 1
      case 0x12f4: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x12f6: m.bp = m.shl16(m.bp, 0x1);  // shl bp, 1
      case 0x12f8: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x12fa: m.dx = m.shl16(m.dx, 0x1);  // shl dx, 1
      case 0x12fc: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x12fe: m.cx = m.shl16(m.cx, 0x1);  // shl cx, 1
      case 0x1300: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1302: m.bx = m.shl16(m.bx, 0x1);  // shl bx, 1
      case 0x1304: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1306: m.bp = m.shl16(m.bp, 0x1);  // shl bp, 1
      case 0x1308: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x130a: { const t = (m.ax & 0xff); m.ax = (m.ax & 0xff00) | (m.ax >> 8); m.ax = (m.ax & 0xff) | (t << 8); }  // xchg al, ah
      case 0x130c: m.ww(m.es, m.di, m.ax);  // mov word ptr es:[di], ax
      case 0x130f: m.dx = m.shl16(m.dx, 0x1);  // shl dx, 1
      case 0x1311: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1313: m.cx = m.shl16(m.cx, 0x1);  // shl cx, 1
      case 0x1315: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1317: m.bx = m.shl16(m.bx, 0x1);  // shl bx, 1
      case 0x1319: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x131b: m.bp = m.shl16(m.bp, 0x1);  // shl bp, 1
      case 0x131d: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x131f: m.dx = m.shl16(m.dx, 0x1);  // shl dx, 1
      case 0x1321: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1323: m.cx = m.shl16(m.cx, 0x1);  // shl cx, 1
      case 0x1325: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1327: m.bx = m.shl16(m.bx, 0x1);  // shl bx, 1
      case 0x1329: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x132b: m.bp = m.shl16(m.bp, 0x1);  // shl bp, 1
      case 0x132d: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x132f: m.dx = m.shl16(m.dx, 0x1);  // shl dx, 1
      case 0x1331: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1333: m.cx = m.shl16(m.cx, 0x1);  // shl cx, 1
      case 0x1335: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1337: m.bx = m.shl16(m.bx, 0x1);  // shl bx, 1
      case 0x1339: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x133b: m.bp = m.shl16(m.bp, 0x1);  // shl bp, 1
      case 0x133d: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x133f: m.dx = m.shl16(m.dx, 0x1);  // shl dx, 1
      case 0x1341: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1343: m.cx = m.shl16(m.cx, 0x1);  // shl cx, 1
      case 0x1345: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1347: m.bx = m.shl16(m.bx, 0x1);  // shl bx, 1
      case 0x1349: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x134b: m.bp = m.shl16(m.bp, 0x1);  // shl bp, 1
      case 0x134d: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x134f: { const t = (m.ax & 0xff); m.ax = (m.ax & 0xff00) | (m.ax >> 8); m.ax = (m.ax & 0xff) | (t << 8); }  // xchg al, ah
      case 0x1351: m.ww(m.es, ((m.di + 0x2) & 0xffff), m.ax);  // mov word ptr es:[di + 2], ax
      case 0x1355: m.dx = m.shl16(m.dx, 0x1);  // shl dx, 1
      case 0x1357: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1359: m.cx = m.shl16(m.cx, 0x1);  // shl cx, 1
      case 0x135b: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x135d: m.bx = m.shl16(m.bx, 0x1);  // shl bx, 1
      case 0x135f: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1361: m.bp = m.shl16(m.bp, 0x1);  // shl bp, 1
      case 0x1363: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1365: m.dx = m.shl16(m.dx, 0x1);  // shl dx, 1
      case 0x1367: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1369: m.cx = m.shl16(m.cx, 0x1);  // shl cx, 1
      case 0x136b: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x136d: m.bx = m.shl16(m.bx, 0x1);  // shl bx, 1
      case 0x136f: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1371: m.bp = m.shl16(m.bp, 0x1);  // shl bp, 1
      case 0x1373: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1375: m.dx = m.shl16(m.dx, 0x1);  // shl dx, 1
      case 0x1377: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1379: m.cx = m.shl16(m.cx, 0x1);  // shl cx, 1
      case 0x137b: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x137d: m.bx = m.shl16(m.bx, 0x1);  // shl bx, 1
      case 0x137f: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1381: m.bp = m.shl16(m.bp, 0x1);  // shl bp, 1
      case 0x1383: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1385: m.dx = m.shl16(m.dx, 0x1);  // shl dx, 1
      case 0x1387: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1389: m.cx = m.shl16(m.cx, 0x1);  // shl cx, 1
      case 0x138b: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x138d: m.bx = m.shl16(m.bx, 0x1);  // shl bx, 1
      case 0x138f: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1391: m.bp = m.shl16(m.bp, 0x1);  // shl bp, 1
      case 0x1393: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1395: { const t = (m.ax & 0xff); m.ax = (m.ax & 0xff00) | (m.ax >> 8); m.ax = (m.ax & 0xff) | (t << 8); }  // xchg al, ah
      case 0x1397: m.ww(m.es, ((m.di + 0x4) & 0xffff), m.ax);  // mov word ptr es:[di + 4], ax
      case 0x139b: m.dx = m.shl16(m.dx, 0x1);  // shl dx, 1
      case 0x139d: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x139f: m.cx = m.shl16(m.cx, 0x1);  // shl cx, 1
      case 0x13a1: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x13a3: m.bx = m.shl16(m.bx, 0x1);  // shl bx, 1
      case 0x13a5: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x13a7: m.bp = m.shl16(m.bp, 0x1);  // shl bp, 1
      case 0x13a9: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x13ab: m.dx = m.shl16(m.dx, 0x1);  // shl dx, 1
      case 0x13ad: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x13af: m.cx = m.shl16(m.cx, 0x1);  // shl cx, 1
      case 0x13b1: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x13b3: m.bx = m.shl16(m.bx, 0x1);  // shl bx, 1
      case 0x13b5: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x13b7: m.bp = m.shl16(m.bp, 0x1);  // shl bp, 1
      case 0x13b9: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x13bb: m.dx = m.shl16(m.dx, 0x1);  // shl dx, 1
      case 0x13bd: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x13bf: m.cx = m.shl16(m.cx, 0x1);  // shl cx, 1
      case 0x13c1: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x13c3: m.bx = m.shl16(m.bx, 0x1);  // shl bx, 1
      case 0x13c5: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x13c7: m.bp = m.shl16(m.bp, 0x1);  // shl bp, 1
      case 0x13c9: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x13cb: m.dx = m.shl16(m.dx, 0x1);  // shl dx, 1
      case 0x13cd: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x13cf: m.cx = m.shl16(m.cx, 0x1);  // shl cx, 1
      case 0x13d1: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x13d3: m.bx = m.shl16(m.bx, 0x1);  // shl bx, 1
      case 0x13d5: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x13d7: m.bp = m.shl16(m.bp, 0x1);  // shl bp, 1
      case 0x13d9: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x13db: { const t = (m.ax & 0xff); m.ax = (m.ax & 0xff00) | (m.ax >> 8); m.ax = (m.ax & 0xff) | (t << 8); }  // xchg al, ah
      case 0x13dd: m.ww(m.es, ((m.di + 0x6) & 0xffff), m.ax);  // mov word ptr es:[di + 6], ax
      case 0x13e1: m.si = m.add16(m.si, 0x2);  // add si, 2
      case 0x13e4: m.di = m.add16(m.di, 0x8);  // add di, 8
      case 0x13e7: m.ax = (m.ax & 0xff) | (m.rb(m.ds, ((m.si + 0x78) & 0xffff)) << 8);  // mov ah, byte ptr [si + 0x78]
      case 0x13ea: m.ax = (m.ax & 0xff00) | m.rb(m.ds, ((m.si + 0x79) & 0xffff));  // mov al, byte ptr [si + 0x79]
      case 0x13ed: m.bp = m.ax;  // mov bp, ax
      case 0x13ef: m.bx = (m.bx & 0xff) | (m.rb(m.ds, ((m.si + 0x50) & 0xffff)) << 8);  // mov bh, byte ptr [si + 0x50]
      case 0x13f2: m.bx = (m.bx & 0xff00) | m.rb(m.ds, ((m.si + 0x51) & 0xffff));  // mov bl, byte ptr [si + 0x51]
      case 0x13f5: m.cx = (m.cx & 0xff) | (m.rb(m.ds, ((m.si + 0x28) & 0xffff)) << 8);  // mov ch, byte ptr [si + 0x28]
      case 0x13f8: m.cx = (m.cx & 0xff00) | m.rb(m.ds, ((m.si + 0x29) & 0xffff));  // mov cl, byte ptr [si + 0x29]
      case 0x13fb: m.dx = (m.dx & 0xff) | (m.rb(m.ds, m.si) << 8);  // mov dh, byte ptr [si]
      case 0x13fd: m.dx = (m.dx & 0xff00) | m.rb(m.ds, ((m.si + 0x1) & 0xffff));  // mov dl, byte ptr [si + 1]
      case 0x1400: m.ax = 0x0;  // mov ax, 0
      case 0x1403: m.dx = m.shl16(m.dx, 0x1);  // shl dx, 1
      case 0x1405: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1407: m.cx = m.shl16(m.cx, 0x1);  // shl cx, 1
      case 0x1409: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x140b: m.bx = m.shl16(m.bx, 0x1);  // shl bx, 1
      case 0x140d: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x140f: m.bp = m.shl16(m.bp, 0x1);  // shl bp, 1
      case 0x1411: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1413: m.dx = m.shl16(m.dx, 0x1);  // shl dx, 1
      case 0x1415: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1417: m.cx = m.shl16(m.cx, 0x1);  // shl cx, 1
      case 0x1419: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x141b: m.bx = m.shl16(m.bx, 0x1);  // shl bx, 1
      case 0x141d: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x141f: m.bp = m.shl16(m.bp, 0x1);  // shl bp, 1
      case 0x1421: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1423: m.dx = m.shl16(m.dx, 0x1);  // shl dx, 1
      case 0x1425: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1427: m.cx = m.shl16(m.cx, 0x1);  // shl cx, 1
      case 0x1429: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x142b: m.bx = m.shl16(m.bx, 0x1);  // shl bx, 1
      case 0x142d: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x142f: m.bp = m.shl16(m.bp, 0x1);  // shl bp, 1
      case 0x1431: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1433: m.dx = m.shl16(m.dx, 0x1);  // shl dx, 1
      case 0x1435: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1437: m.cx = m.shl16(m.cx, 0x1);  // shl cx, 1
      case 0x1439: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x143b: m.bx = m.shl16(m.bx, 0x1);  // shl bx, 1
      case 0x143d: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x143f: m.bp = m.shl16(m.bp, 0x1);  // shl bp, 1
      case 0x1441: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1443: { const t = (m.ax & 0xff); m.ax = (m.ax & 0xff00) | (m.ax >> 8); m.ax = (m.ax & 0xff) | (t << 8); }  // xchg al, ah
      case 0x1445: m.ww(m.es, m.di, m.ax);  // mov word ptr es:[di], ax
      case 0x1448: m.dx = m.shl16(m.dx, 0x1);  // shl dx, 1
      case 0x144a: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x144c: m.cx = m.shl16(m.cx, 0x1);  // shl cx, 1
      case 0x144e: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1450: m.bx = m.shl16(m.bx, 0x1);  // shl bx, 1
      case 0x1452: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1454: m.bp = m.shl16(m.bp, 0x1);  // shl bp, 1
      case 0x1456: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1458: m.dx = m.shl16(m.dx, 0x1);  // shl dx, 1
      case 0x145a: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x145c: m.cx = m.shl16(m.cx, 0x1);  // shl cx, 1
      case 0x145e: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1460: m.bx = m.shl16(m.bx, 0x1);  // shl bx, 1
      case 0x1462: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1464: m.bp = m.shl16(m.bp, 0x1);  // shl bp, 1
      case 0x1466: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1468: m.dx = m.shl16(m.dx, 0x1);  // shl dx, 1
      case 0x146a: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x146c: m.cx = m.shl16(m.cx, 0x1);  // shl cx, 1
      case 0x146e: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1470: m.bx = m.shl16(m.bx, 0x1);  // shl bx, 1
      case 0x1472: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1474: m.bp = m.shl16(m.bp, 0x1);  // shl bp, 1
      case 0x1476: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1478: m.dx = m.shl16(m.dx, 0x1);  // shl dx, 1
      case 0x147a: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x147c: m.cx = m.shl16(m.cx, 0x1);  // shl cx, 1
      case 0x147e: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1480: m.bx = m.shl16(m.bx, 0x1);  // shl bx, 1
      case 0x1482: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1484: m.bp = m.shl16(m.bp, 0x1);  // shl bp, 1
      case 0x1486: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1488: { const t = (m.ax & 0xff); m.ax = (m.ax & 0xff00) | (m.ax >> 8); m.ax = (m.ax & 0xff) | (t << 8); }  // xchg al, ah
      case 0x148a: m.ww(m.es, ((m.di + 0x2) & 0xffff), m.ax);  // mov word ptr es:[di + 2], ax
      case 0x148e: m.dx = m.shl16(m.dx, 0x1);  // shl dx, 1
      case 0x1490: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1492: m.cx = m.shl16(m.cx, 0x1);  // shl cx, 1
      case 0x1494: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1496: m.bx = m.shl16(m.bx, 0x1);  // shl bx, 1
      case 0x1498: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x149a: m.bp = m.shl16(m.bp, 0x1);  // shl bp, 1
      case 0x149c: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x149e: m.dx = m.shl16(m.dx, 0x1);  // shl dx, 1
      case 0x14a0: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x14a2: m.cx = m.shl16(m.cx, 0x1);  // shl cx, 1
      case 0x14a4: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x14a6: m.bx = m.shl16(m.bx, 0x1);  // shl bx, 1
      case 0x14a8: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x14aa: m.bp = m.shl16(m.bp, 0x1);  // shl bp, 1
      case 0x14ac: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x14ae: m.dx = m.shl16(m.dx, 0x1);  // shl dx, 1
      case 0x14b0: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x14b2: m.cx = m.shl16(m.cx, 0x1);  // shl cx, 1
      case 0x14b4: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x14b6: m.bx = m.shl16(m.bx, 0x1);  // shl bx, 1
      case 0x14b8: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x14ba: m.bp = m.shl16(m.bp, 0x1);  // shl bp, 1
      case 0x14bc: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x14be: m.dx = m.shl16(m.dx, 0x1);  // shl dx, 1
      case 0x14c0: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x14c2: m.cx = m.shl16(m.cx, 0x1);  // shl cx, 1
      case 0x14c4: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x14c6: m.bx = m.shl16(m.bx, 0x1);  // shl bx, 1
      case 0x14c8: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x14ca: m.bp = m.shl16(m.bp, 0x1);  // shl bp, 1
      case 0x14cc: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x14ce: { const t = (m.ax & 0xff); m.ax = (m.ax & 0xff00) | (m.ax >> 8); m.ax = (m.ax & 0xff) | (t << 8); }  // xchg al, ah
      case 0x14d0: m.ww(m.es, ((m.di + 0x4) & 0xffff), m.ax);  // mov word ptr es:[di + 4], ax
      case 0x14d4: m.dx = m.shl16(m.dx, 0x1);  // shl dx, 1
      case 0x14d6: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x14d8: m.cx = m.shl16(m.cx, 0x1);  // shl cx, 1
      case 0x14da: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x14dc: m.bx = m.shl16(m.bx, 0x1);  // shl bx, 1
      case 0x14de: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x14e0: m.bp = m.shl16(m.bp, 0x1);  // shl bp, 1
      case 0x14e2: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x14e4: m.dx = m.shl16(m.dx, 0x1);  // shl dx, 1
      case 0x14e6: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x14e8: m.cx = m.shl16(m.cx, 0x1);  // shl cx, 1
      case 0x14ea: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x14ec: m.bx = m.shl16(m.bx, 0x1);  // shl bx, 1
      case 0x14ee: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x14f0: m.bp = m.shl16(m.bp, 0x1);  // shl bp, 1
      case 0x14f2: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x14f4: m.dx = m.shl16(m.dx, 0x1);  // shl dx, 1
      case 0x14f6: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x14f8: m.cx = m.shl16(m.cx, 0x1);  // shl cx, 1
      case 0x14fa: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x14fc: m.bx = m.shl16(m.bx, 0x1);  // shl bx, 1
      case 0x14fe: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1500: m.bp = m.shl16(m.bp, 0x1);  // shl bp, 1
      case 0x1502: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1504: m.dx = m.shl16(m.dx, 0x1);  // shl dx, 1
      case 0x1506: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1508: m.cx = m.shl16(m.cx, 0x1);  // shl cx, 1
      case 0x150a: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x150c: m.bx = m.shl16(m.bx, 0x1);  // shl bx, 1
      case 0x150e: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1510: m.bp = m.shl16(m.bp, 0x1);  // shl bp, 1
      case 0x1512: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1514: { const t = (m.ax & 0xff); m.ax = (m.ax & 0xff00) | (m.ax >> 8); m.ax = (m.ax & 0xff) | (t << 8); }  // xchg al, ah
      case 0x1516: m.ww(m.es, ((m.di + 0x6) & 0xffff), m.ax);  // mov word ptr es:[di + 6], ax
      case 0x151a: m.si = m.add16(m.si, 0x2);  // add si, 2
      case 0x151d: m.di = m.add16(m.di, 0x8);  // add di, 8
      case 0x1520: m.ax = (m.ax & 0xff) | (m.rb(m.ds, ((m.si + 0x78) & 0xffff)) << 8);  // mov ah, byte ptr [si + 0x78]
      case 0x1523: m.ax = (m.ax & 0xff00) | m.rb(m.ds, ((m.si + 0x79) & 0xffff));  // mov al, byte ptr [si + 0x79]
      case 0x1526: m.bp = m.ax;  // mov bp, ax
      case 0x1528: m.bx = (m.bx & 0xff) | (m.rb(m.ds, ((m.si + 0x50) & 0xffff)) << 8);  // mov bh, byte ptr [si + 0x50]
      case 0x152b: m.bx = (m.bx & 0xff00) | m.rb(m.ds, ((m.si + 0x51) & 0xffff));  // mov bl, byte ptr [si + 0x51]
      case 0x152e: m.cx = (m.cx & 0xff) | (m.rb(m.ds, ((m.si + 0x28) & 0xffff)) << 8);  // mov ch, byte ptr [si + 0x28]
      case 0x1531: m.cx = (m.cx & 0xff00) | m.rb(m.ds, ((m.si + 0x29) & 0xffff));  // mov cl, byte ptr [si + 0x29]
      case 0x1534: m.dx = (m.dx & 0xff) | (m.rb(m.ds, m.si) << 8);  // mov dh, byte ptr [si]
      case 0x1536: m.dx = (m.dx & 0xff00) | m.rb(m.ds, ((m.si + 0x1) & 0xffff));  // mov dl, byte ptr [si + 1]
      case 0x1539: m.ax = 0x0;  // mov ax, 0
      case 0x153c: m.dx = m.shl16(m.dx, 0x1);  // shl dx, 1
      case 0x153e: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1540: m.cx = m.shl16(m.cx, 0x1);  // shl cx, 1
      case 0x1542: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1544: m.bx = m.shl16(m.bx, 0x1);  // shl bx, 1
      case 0x1546: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1548: m.bp = m.shl16(m.bp, 0x1);  // shl bp, 1
      case 0x154a: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x154c: m.dx = m.shl16(m.dx, 0x1);  // shl dx, 1
      case 0x154e: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1550: m.cx = m.shl16(m.cx, 0x1);  // shl cx, 1
      case 0x1552: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1554: m.bx = m.shl16(m.bx, 0x1);  // shl bx, 1
      case 0x1556: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1558: m.bp = m.shl16(m.bp, 0x1);  // shl bp, 1
      case 0x155a: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x155c: m.dx = m.shl16(m.dx, 0x1);  // shl dx, 1
      case 0x155e: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1560: m.cx = m.shl16(m.cx, 0x1);  // shl cx, 1
      case 0x1562: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1564: m.bx = m.shl16(m.bx, 0x1);  // shl bx, 1
      case 0x1566: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1568: m.bp = m.shl16(m.bp, 0x1);  // shl bp, 1
      case 0x156a: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x156c: m.dx = m.shl16(m.dx, 0x1);  // shl dx, 1
      case 0x156e: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1570: m.cx = m.shl16(m.cx, 0x1);  // shl cx, 1
      case 0x1572: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1574: m.bx = m.shl16(m.bx, 0x1);  // shl bx, 1
      case 0x1576: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1578: m.bp = m.shl16(m.bp, 0x1);  // shl bp, 1
      case 0x157a: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x157c: { const t = (m.ax & 0xff); m.ax = (m.ax & 0xff00) | (m.ax >> 8); m.ax = (m.ax & 0xff) | (t << 8); }  // xchg al, ah
      case 0x157e: m.ww(m.es, m.di, m.ax);  // mov word ptr es:[di], ax
      case 0x1581: m.dx = m.shl16(m.dx, 0x1);  // shl dx, 1
      case 0x1583: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1585: m.cx = m.shl16(m.cx, 0x1);  // shl cx, 1
      case 0x1587: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1589: m.bx = m.shl16(m.bx, 0x1);  // shl bx, 1
      case 0x158b: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x158d: m.bp = m.shl16(m.bp, 0x1);  // shl bp, 1
      case 0x158f: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1591: m.dx = m.shl16(m.dx, 0x1);  // shl dx, 1
      case 0x1593: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1595: m.cx = m.shl16(m.cx, 0x1);  // shl cx, 1
      case 0x1597: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1599: m.bx = m.shl16(m.bx, 0x1);  // shl bx, 1
      case 0x159b: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x159d: m.bp = m.shl16(m.bp, 0x1);  // shl bp, 1
      case 0x159f: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x15a1: m.dx = m.shl16(m.dx, 0x1);  // shl dx, 1
      case 0x15a3: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x15a5: m.cx = m.shl16(m.cx, 0x1);  // shl cx, 1
      case 0x15a7: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x15a9: m.bx = m.shl16(m.bx, 0x1);  // shl bx, 1
      case 0x15ab: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x15ad: m.bp = m.shl16(m.bp, 0x1);  // shl bp, 1
      case 0x15af: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x15b1: m.dx = m.shl16(m.dx, 0x1);  // shl dx, 1
      case 0x15b3: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x15b5: m.cx = m.shl16(m.cx, 0x1);  // shl cx, 1
      case 0x15b7: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x15b9: m.bx = m.shl16(m.bx, 0x1);  // shl bx, 1
      case 0x15bb: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x15bd: m.bp = m.shl16(m.bp, 0x1);  // shl bp, 1
      case 0x15bf: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x15c1: { const t = (m.ax & 0xff); m.ax = (m.ax & 0xff00) | (m.ax >> 8); m.ax = (m.ax & 0xff) | (t << 8); }  // xchg al, ah
      case 0x15c3: m.ww(m.es, ((m.di + 0x2) & 0xffff), m.ax);  // mov word ptr es:[di + 2], ax
      case 0x15c7: m.dx = m.shl16(m.dx, 0x1);  // shl dx, 1
      case 0x15c9: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x15cb: m.cx = m.shl16(m.cx, 0x1);  // shl cx, 1
      case 0x15cd: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x15cf: m.bx = m.shl16(m.bx, 0x1);  // shl bx, 1
      case 0x15d1: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x15d3: m.bp = m.shl16(m.bp, 0x1);  // shl bp, 1
      case 0x15d5: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x15d7: m.dx = m.shl16(m.dx, 0x1);  // shl dx, 1
      case 0x15d9: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x15db: m.cx = m.shl16(m.cx, 0x1);  // shl cx, 1
      case 0x15dd: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x15df: m.bx = m.shl16(m.bx, 0x1);  // shl bx, 1
      case 0x15e1: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x15e3: m.bp = m.shl16(m.bp, 0x1);  // shl bp, 1
      case 0x15e5: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x15e7: m.dx = m.shl16(m.dx, 0x1);  // shl dx, 1
      case 0x15e9: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x15eb: m.cx = m.shl16(m.cx, 0x1);  // shl cx, 1
      case 0x15ed: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x15ef: m.bx = m.shl16(m.bx, 0x1);  // shl bx, 1
      case 0x15f1: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x15f3: m.bp = m.shl16(m.bp, 0x1);  // shl bp, 1
      case 0x15f5: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x15f7: m.dx = m.shl16(m.dx, 0x1);  // shl dx, 1
      case 0x15f9: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x15fb: m.cx = m.shl16(m.cx, 0x1);  // shl cx, 1
      case 0x15fd: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x15ff: m.bx = m.shl16(m.bx, 0x1);  // shl bx, 1
      case 0x1601: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1603: m.bp = m.shl16(m.bp, 0x1);  // shl bp, 1
      case 0x1605: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1607: { const t = (m.ax & 0xff); m.ax = (m.ax & 0xff00) | (m.ax >> 8); m.ax = (m.ax & 0xff) | (t << 8); }  // xchg al, ah
      case 0x1609: m.ww(m.es, ((m.di + 0x4) & 0xffff), m.ax);  // mov word ptr es:[di + 4], ax
      case 0x160d: m.dx = m.shl16(m.dx, 0x1);  // shl dx, 1
      case 0x160f: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1611: m.cx = m.shl16(m.cx, 0x1);  // shl cx, 1
      case 0x1613: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1615: m.bx = m.shl16(m.bx, 0x1);  // shl bx, 1
      case 0x1617: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1619: m.bp = m.shl16(m.bp, 0x1);  // shl bp, 1
      case 0x161b: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x161d: m.dx = m.shl16(m.dx, 0x1);  // shl dx, 1
      case 0x161f: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1621: m.cx = m.shl16(m.cx, 0x1);  // shl cx, 1
      case 0x1623: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1625: m.bx = m.shl16(m.bx, 0x1);  // shl bx, 1
      case 0x1627: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1629: m.bp = m.shl16(m.bp, 0x1);  // shl bp, 1
      case 0x162b: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x162d: m.dx = m.shl16(m.dx, 0x1);  // shl dx, 1
      case 0x162f: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1631: m.cx = m.shl16(m.cx, 0x1);  // shl cx, 1
      case 0x1633: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1635: m.bx = m.shl16(m.bx, 0x1);  // shl bx, 1
      case 0x1637: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1639: m.bp = m.shl16(m.bp, 0x1);  // shl bp, 1
      case 0x163b: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x163d: m.dx = m.shl16(m.dx, 0x1);  // shl dx, 1
      case 0x163f: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1641: m.cx = m.shl16(m.cx, 0x1);  // shl cx, 1
      case 0x1643: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1645: m.bx = m.shl16(m.bx, 0x1);  // shl bx, 1
      case 0x1647: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1649: m.bp = m.shl16(m.bp, 0x1);  // shl bp, 1
      case 0x164b: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x164d: { const t = (m.ax & 0xff); m.ax = (m.ax & 0xff00) | (m.ax >> 8); m.ax = (m.ax & 0xff) | (t << 8); }  // xchg al, ah
      case 0x164f: m.ww(m.es, ((m.di + 0x6) & 0xffff), m.ax);  // mov word ptr es:[di + 6], ax
      case 0x1653: m.si = m.add16(m.si, 0x2);  // add si, 2
      case 0x1656: m.di = m.add16(m.di, 0x8);  // add di, 8
      case 0x1659: m.ax = (m.ax & 0xff) | (m.rb(m.ds, ((m.si + 0x78) & 0xffff)) << 8);  // mov ah, byte ptr [si + 0x78]
      case 0x165c: m.ax = (m.ax & 0xff00) | m.rb(m.ds, ((m.si + 0x79) & 0xffff));  // mov al, byte ptr [si + 0x79]
      case 0x165f: m.bp = m.ax;  // mov bp, ax
      case 0x1661: m.bx = (m.bx & 0xff) | (m.rb(m.ds, ((m.si + 0x50) & 0xffff)) << 8);  // mov bh, byte ptr [si + 0x50]
      case 0x1664: m.bx = (m.bx & 0xff00) | m.rb(m.ds, ((m.si + 0x51) & 0xffff));  // mov bl, byte ptr [si + 0x51]
      case 0x1667: m.cx = (m.cx & 0xff) | (m.rb(m.ds, ((m.si + 0x28) & 0xffff)) << 8);  // mov ch, byte ptr [si + 0x28]
      case 0x166a: m.cx = (m.cx & 0xff00) | m.rb(m.ds, ((m.si + 0x29) & 0xffff));  // mov cl, byte ptr [si + 0x29]
      case 0x166d: m.dx = (m.dx & 0xff) | (m.rb(m.ds, m.si) << 8);  // mov dh, byte ptr [si]
      case 0x166f: m.dx = (m.dx & 0xff00) | m.rb(m.ds, ((m.si + 0x1) & 0xffff));  // mov dl, byte ptr [si + 1]
      case 0x1672: m.ax = 0x0;  // mov ax, 0
      case 0x1675: m.dx = m.shl16(m.dx, 0x1);  // shl dx, 1
      case 0x1677: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1679: m.cx = m.shl16(m.cx, 0x1);  // shl cx, 1
      case 0x167b: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x167d: m.bx = m.shl16(m.bx, 0x1);  // shl bx, 1
      case 0x167f: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1681: m.bp = m.shl16(m.bp, 0x1);  // shl bp, 1
      case 0x1683: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1685: m.dx = m.shl16(m.dx, 0x1);  // shl dx, 1
      case 0x1687: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1689: m.cx = m.shl16(m.cx, 0x1);  // shl cx, 1
      case 0x168b: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x168d: m.bx = m.shl16(m.bx, 0x1);  // shl bx, 1
      case 0x168f: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1691: m.bp = m.shl16(m.bp, 0x1);  // shl bp, 1
      case 0x1693: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1695: m.dx = m.shl16(m.dx, 0x1);  // shl dx, 1
      case 0x1697: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1699: m.cx = m.shl16(m.cx, 0x1);  // shl cx, 1
      case 0x169b: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x169d: m.bx = m.shl16(m.bx, 0x1);  // shl bx, 1
      case 0x169f: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x16a1: m.bp = m.shl16(m.bp, 0x1);  // shl bp, 1
      case 0x16a3: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x16a5: m.dx = m.shl16(m.dx, 0x1);  // shl dx, 1
      case 0x16a7: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x16a9: m.cx = m.shl16(m.cx, 0x1);  // shl cx, 1
      case 0x16ab: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x16ad: m.bx = m.shl16(m.bx, 0x1);  // shl bx, 1
      case 0x16af: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x16b1: m.bp = m.shl16(m.bp, 0x1);  // shl bp, 1
      case 0x16b3: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x16b5: { const t = (m.ax & 0xff); m.ax = (m.ax & 0xff00) | (m.ax >> 8); m.ax = (m.ax & 0xff) | (t << 8); }  // xchg al, ah
      case 0x16b7: m.ww(m.es, m.di, m.ax);  // mov word ptr es:[di], ax
      case 0x16ba: m.dx = m.shl16(m.dx, 0x1);  // shl dx, 1
      case 0x16bc: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x16be: m.cx = m.shl16(m.cx, 0x1);  // shl cx, 1
      case 0x16c0: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x16c2: m.bx = m.shl16(m.bx, 0x1);  // shl bx, 1
      case 0x16c4: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x16c6: m.bp = m.shl16(m.bp, 0x1);  // shl bp, 1
      case 0x16c8: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x16ca: m.dx = m.shl16(m.dx, 0x1);  // shl dx, 1
      case 0x16cc: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x16ce: m.cx = m.shl16(m.cx, 0x1);  // shl cx, 1
      case 0x16d0: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x16d2: m.bx = m.shl16(m.bx, 0x1);  // shl bx, 1
      case 0x16d4: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x16d6: m.bp = m.shl16(m.bp, 0x1);  // shl bp, 1
      case 0x16d8: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x16da: m.dx = m.shl16(m.dx, 0x1);  // shl dx, 1
      case 0x16dc: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x16de: m.cx = m.shl16(m.cx, 0x1);  // shl cx, 1
      case 0x16e0: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x16e2: m.bx = m.shl16(m.bx, 0x1);  // shl bx, 1
      case 0x16e4: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x16e6: m.bp = m.shl16(m.bp, 0x1);  // shl bp, 1
      case 0x16e8: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x16ea: m.dx = m.shl16(m.dx, 0x1);  // shl dx, 1
      case 0x16ec: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x16ee: m.cx = m.shl16(m.cx, 0x1);  // shl cx, 1
      case 0x16f0: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x16f2: m.bx = m.shl16(m.bx, 0x1);  // shl bx, 1
      case 0x16f4: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x16f6: m.bp = m.shl16(m.bp, 0x1);  // shl bp, 1
      case 0x16f8: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x16fa: { const t = (m.ax & 0xff); m.ax = (m.ax & 0xff00) | (m.ax >> 8); m.ax = (m.ax & 0xff) | (t << 8); }  // xchg al, ah
      case 0x16fc: m.ww(m.es, ((m.di + 0x2) & 0xffff), m.ax);  // mov word ptr es:[di + 2], ax
      case 0x1700: m.dx = m.shl16(m.dx, 0x1);  // shl dx, 1
      case 0x1702: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1704: m.cx = m.shl16(m.cx, 0x1);  // shl cx, 1
      case 0x1706: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1708: m.bx = m.shl16(m.bx, 0x1);  // shl bx, 1
      case 0x170a: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x170c: m.bp = m.shl16(m.bp, 0x1);  // shl bp, 1
      case 0x170e: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1710: m.dx = m.shl16(m.dx, 0x1);  // shl dx, 1
      case 0x1712: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1714: m.cx = m.shl16(m.cx, 0x1);  // shl cx, 1
      case 0x1716: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1718: m.bx = m.shl16(m.bx, 0x1);  // shl bx, 1
      case 0x171a: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x171c: m.bp = m.shl16(m.bp, 0x1);  // shl bp, 1
      case 0x171e: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1720: m.dx = m.shl16(m.dx, 0x1);  // shl dx, 1
      case 0x1722: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1724: m.cx = m.shl16(m.cx, 0x1);  // shl cx, 1
      case 0x1726: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1728: m.bx = m.shl16(m.bx, 0x1);  // shl bx, 1
      case 0x172a: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x172c: m.bp = m.shl16(m.bp, 0x1);  // shl bp, 1
      case 0x172e: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1730: m.dx = m.shl16(m.dx, 0x1);  // shl dx, 1
      case 0x1732: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1734: m.cx = m.shl16(m.cx, 0x1);  // shl cx, 1
      case 0x1736: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1738: m.bx = m.shl16(m.bx, 0x1);  // shl bx, 1
      case 0x173a: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x173c: m.bp = m.shl16(m.bp, 0x1);  // shl bp, 1
      case 0x173e: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1740: { const t = (m.ax & 0xff); m.ax = (m.ax & 0xff00) | (m.ax >> 8); m.ax = (m.ax & 0xff) | (t << 8); }  // xchg al, ah
      case 0x1742: m.ww(m.es, ((m.di + 0x4) & 0xffff), m.ax);  // mov word ptr es:[di + 4], ax
      case 0x1746: m.dx = m.shl16(m.dx, 0x1);  // shl dx, 1
      case 0x1748: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x174a: m.cx = m.shl16(m.cx, 0x1);  // shl cx, 1
      case 0x174c: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x174e: m.bx = m.shl16(m.bx, 0x1);  // shl bx, 1
      case 0x1750: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1752: m.bp = m.shl16(m.bp, 0x1);  // shl bp, 1
      case 0x1754: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1756: m.dx = m.shl16(m.dx, 0x1);  // shl dx, 1
      case 0x1758: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x175a: m.cx = m.shl16(m.cx, 0x1);  // shl cx, 1
      case 0x175c: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x175e: m.bx = m.shl16(m.bx, 0x1);  // shl bx, 1
      case 0x1760: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1762: m.bp = m.shl16(m.bp, 0x1);  // shl bp, 1
      case 0x1764: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1766: m.dx = m.shl16(m.dx, 0x1);  // shl dx, 1
      case 0x1768: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x176a: m.cx = m.shl16(m.cx, 0x1);  // shl cx, 1
      case 0x176c: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x176e: m.bx = m.shl16(m.bx, 0x1);  // shl bx, 1
      case 0x1770: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1772: m.bp = m.shl16(m.bp, 0x1);  // shl bp, 1
      case 0x1774: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1776: m.dx = m.shl16(m.dx, 0x1);  // shl dx, 1
      case 0x1778: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x177a: m.cx = m.shl16(m.cx, 0x1);  // shl cx, 1
      case 0x177c: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x177e: m.bx = m.shl16(m.bx, 0x1);  // shl bx, 1
      case 0x1780: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1782: m.bp = m.shl16(m.bp, 0x1);  // shl bp, 1
      case 0x1784: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1786: { const t = (m.ax & 0xff); m.ax = (m.ax & 0xff00) | (m.ax >> 8); m.ax = (m.ax & 0xff) | (t << 8); }  // xchg al, ah
      case 0x1788: m.ww(m.es, ((m.di + 0x6) & 0xffff), m.ax);  // mov word ptr es:[di + 6], ax
      case 0x178c: m.si = m.add16(m.si, 0x2);  // add si, 2
      case 0x178f: m.di = m.add16(m.di, 0x8);  // add di, 8
      case 0x1792: m.ax = (m.ax & 0xff) | (m.rb(m.ds, ((m.si + 0x78) & 0xffff)) << 8);  // mov ah, byte ptr [si + 0x78]
      case 0x1795: m.ax = (m.ax & 0xff00) | m.rb(m.ds, ((m.si + 0x79) & 0xffff));  // mov al, byte ptr [si + 0x79]
      case 0x1798: m.bp = m.ax;  // mov bp, ax
      case 0x179a: m.bx = (m.bx & 0xff) | (m.rb(m.ds, ((m.si + 0x50) & 0xffff)) << 8);  // mov bh, byte ptr [si + 0x50]
      case 0x179d: m.bx = (m.bx & 0xff00) | m.rb(m.ds, ((m.si + 0x51) & 0xffff));  // mov bl, byte ptr [si + 0x51]
      case 0x17a0: m.cx = (m.cx & 0xff) | (m.rb(m.ds, ((m.si + 0x28) & 0xffff)) << 8);  // mov ch, byte ptr [si + 0x28]
      case 0x17a3: m.cx = (m.cx & 0xff00) | m.rb(m.ds, ((m.si + 0x29) & 0xffff));  // mov cl, byte ptr [si + 0x29]
      case 0x17a6: m.dx = (m.dx & 0xff) | (m.rb(m.ds, m.si) << 8);  // mov dh, byte ptr [si]
      case 0x17a8: m.dx = (m.dx & 0xff00) | m.rb(m.ds, ((m.si + 0x1) & 0xffff));  // mov dl, byte ptr [si + 1]
      case 0x17ab: m.ax = 0x0;  // mov ax, 0
      case 0x17ae: m.dx = m.shl16(m.dx, 0x1);  // shl dx, 1
      case 0x17b0: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x17b2: m.cx = m.shl16(m.cx, 0x1);  // shl cx, 1
      case 0x17b4: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x17b6: m.bx = m.shl16(m.bx, 0x1);  // shl bx, 1
      case 0x17b8: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x17ba: m.bp = m.shl16(m.bp, 0x1);  // shl bp, 1
      case 0x17bc: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x17be: m.dx = m.shl16(m.dx, 0x1);  // shl dx, 1
      case 0x17c0: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x17c2: m.cx = m.shl16(m.cx, 0x1);  // shl cx, 1
      case 0x17c4: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x17c6: m.bx = m.shl16(m.bx, 0x1);  // shl bx, 1
      case 0x17c8: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x17ca: m.bp = m.shl16(m.bp, 0x1);  // shl bp, 1
      case 0x17cc: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x17ce: m.dx = m.shl16(m.dx, 0x1);  // shl dx, 1
      case 0x17d0: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x17d2: m.cx = m.shl16(m.cx, 0x1);  // shl cx, 1
      case 0x17d4: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x17d6: m.bx = m.shl16(m.bx, 0x1);  // shl bx, 1
      case 0x17d8: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x17da: m.bp = m.shl16(m.bp, 0x1);  // shl bp, 1
      case 0x17dc: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x17de: m.dx = m.shl16(m.dx, 0x1);  // shl dx, 1
      case 0x17e0: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x17e2: m.cx = m.shl16(m.cx, 0x1);  // shl cx, 1
      case 0x17e4: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x17e6: m.bx = m.shl16(m.bx, 0x1);  // shl bx, 1
      case 0x17e8: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x17ea: m.bp = m.shl16(m.bp, 0x1);  // shl bp, 1
      case 0x17ec: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x17ee: { const t = (m.ax & 0xff); m.ax = (m.ax & 0xff00) | (m.ax >> 8); m.ax = (m.ax & 0xff) | (t << 8); }  // xchg al, ah
      case 0x17f0: m.ww(m.es, m.di, m.ax);  // mov word ptr es:[di], ax
      case 0x17f3: m.dx = m.shl16(m.dx, 0x1);  // shl dx, 1
      case 0x17f5: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x17f7: m.cx = m.shl16(m.cx, 0x1);  // shl cx, 1
      case 0x17f9: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x17fb: m.bx = m.shl16(m.bx, 0x1);  // shl bx, 1
      case 0x17fd: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x17ff: m.bp = m.shl16(m.bp, 0x1);  // shl bp, 1
      case 0x1801: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1803: m.dx = m.shl16(m.dx, 0x1);  // shl dx, 1
      case 0x1805: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1807: m.cx = m.shl16(m.cx, 0x1);  // shl cx, 1
      case 0x1809: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x180b: m.bx = m.shl16(m.bx, 0x1);  // shl bx, 1
      case 0x180d: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x180f: m.bp = m.shl16(m.bp, 0x1);  // shl bp, 1
      case 0x1811: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1813: m.dx = m.shl16(m.dx, 0x1);  // shl dx, 1
      case 0x1815: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1817: m.cx = m.shl16(m.cx, 0x1);  // shl cx, 1
      case 0x1819: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x181b: m.bx = m.shl16(m.bx, 0x1);  // shl bx, 1
      case 0x181d: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x181f: m.bp = m.shl16(m.bp, 0x1);  // shl bp, 1
      case 0x1821: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1823: m.dx = m.shl16(m.dx, 0x1);  // shl dx, 1
      case 0x1825: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1827: m.cx = m.shl16(m.cx, 0x1);  // shl cx, 1
      case 0x1829: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x182b: m.bx = m.shl16(m.bx, 0x1);  // shl bx, 1
      case 0x182d: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x182f: m.bp = m.shl16(m.bp, 0x1);  // shl bp, 1
      case 0x1831: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1833: { const t = (m.ax & 0xff); m.ax = (m.ax & 0xff00) | (m.ax >> 8); m.ax = (m.ax & 0xff) | (t << 8); }  // xchg al, ah
      case 0x1835: m.ww(m.es, ((m.di + 0x2) & 0xffff), m.ax);  // mov word ptr es:[di + 2], ax
      case 0x1839: m.dx = m.shl16(m.dx, 0x1);  // shl dx, 1
      case 0x183b: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x183d: m.cx = m.shl16(m.cx, 0x1);  // shl cx, 1
      case 0x183f: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1841: m.bx = m.shl16(m.bx, 0x1);  // shl bx, 1
      case 0x1843: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1845: m.bp = m.shl16(m.bp, 0x1);  // shl bp, 1
      case 0x1847: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1849: m.dx = m.shl16(m.dx, 0x1);  // shl dx, 1
      case 0x184b: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x184d: m.cx = m.shl16(m.cx, 0x1);  // shl cx, 1
      case 0x184f: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1851: m.bx = m.shl16(m.bx, 0x1);  // shl bx, 1
      case 0x1853: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1855: m.bp = m.shl16(m.bp, 0x1);  // shl bp, 1
      case 0x1857: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1859: m.dx = m.shl16(m.dx, 0x1);  // shl dx, 1
      case 0x185b: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x185d: m.cx = m.shl16(m.cx, 0x1);  // shl cx, 1
      case 0x185f: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1861: m.bx = m.shl16(m.bx, 0x1);  // shl bx, 1
      case 0x1863: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1865: m.bp = m.shl16(m.bp, 0x1);  // shl bp, 1
      case 0x1867: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1869: m.dx = m.shl16(m.dx, 0x1);  // shl dx, 1
      case 0x186b: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x186d: m.cx = m.shl16(m.cx, 0x1);  // shl cx, 1
      case 0x186f: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1871: m.bx = m.shl16(m.bx, 0x1);  // shl bx, 1
      case 0x1873: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1875: m.bp = m.shl16(m.bp, 0x1);  // shl bp, 1
      case 0x1877: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1879: { const t = (m.ax & 0xff); m.ax = (m.ax & 0xff00) | (m.ax >> 8); m.ax = (m.ax & 0xff) | (t << 8); }  // xchg al, ah
      case 0x187b: m.ww(m.es, ((m.di + 0x4) & 0xffff), m.ax);  // mov word ptr es:[di + 4], ax
      case 0x187f: m.dx = m.shl16(m.dx, 0x1);  // shl dx, 1
      case 0x1881: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1883: m.cx = m.shl16(m.cx, 0x1);  // shl cx, 1
      case 0x1885: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1887: m.bx = m.shl16(m.bx, 0x1);  // shl bx, 1
      case 0x1889: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x188b: m.bp = m.shl16(m.bp, 0x1);  // shl bp, 1
      case 0x188d: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x188f: m.dx = m.shl16(m.dx, 0x1);  // shl dx, 1
      case 0x1891: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1893: m.cx = m.shl16(m.cx, 0x1);  // shl cx, 1
      case 0x1895: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1897: m.bx = m.shl16(m.bx, 0x1);  // shl bx, 1
      case 0x1899: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x189b: m.bp = m.shl16(m.bp, 0x1);  // shl bp, 1
      case 0x189d: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x189f: m.dx = m.shl16(m.dx, 0x1);  // shl dx, 1
      case 0x18a1: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x18a3: m.cx = m.shl16(m.cx, 0x1);  // shl cx, 1
      case 0x18a5: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x18a7: m.bx = m.shl16(m.bx, 0x1);  // shl bx, 1
      case 0x18a9: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x18ab: m.bp = m.shl16(m.bp, 0x1);  // shl bp, 1
      case 0x18ad: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x18af: m.dx = m.shl16(m.dx, 0x1);  // shl dx, 1
      case 0x18b1: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x18b3: m.cx = m.shl16(m.cx, 0x1);  // shl cx, 1
      case 0x18b5: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x18b7: m.bx = m.shl16(m.bx, 0x1);  // shl bx, 1
      case 0x18b9: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x18bb: m.bp = m.shl16(m.bp, 0x1);  // shl bp, 1
      case 0x18bd: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x18bf: { const t = (m.ax & 0xff); m.ax = (m.ax & 0xff00) | (m.ax >> 8); m.ax = (m.ax & 0xff) | (t << 8); }  // xchg al, ah
      case 0x18c1: m.ww(m.es, ((m.di + 0x6) & 0xffff), m.ax);  // mov word ptr es:[di + 6], ax
      case 0x18c5: m.si = m.add16(m.si, 0x2);  // add si, 2
      case 0x18c8: m.di = m.add16(m.di, 0x8);  // add di, 8
      case 0x18cb: m.ax = (m.ax & 0xff) | (m.rb(m.ds, ((m.si + 0x78) & 0xffff)) << 8);  // mov ah, byte ptr [si + 0x78]
      case 0x18ce: m.ax = (m.ax & 0xff00) | m.rb(m.ds, ((m.si + 0x79) & 0xffff));  // mov al, byte ptr [si + 0x79]
      case 0x18d1: m.bp = m.ax;  // mov bp, ax
      case 0x18d3: m.bx = (m.bx & 0xff) | (m.rb(m.ds, ((m.si + 0x50) & 0xffff)) << 8);  // mov bh, byte ptr [si + 0x50]
      case 0x18d6: m.bx = (m.bx & 0xff00) | m.rb(m.ds, ((m.si + 0x51) & 0xffff));  // mov bl, byte ptr [si + 0x51]
      case 0x18d9: m.cx = (m.cx & 0xff) | (m.rb(m.ds, ((m.si + 0x28) & 0xffff)) << 8);  // mov ch, byte ptr [si + 0x28]
      case 0x18dc: m.cx = (m.cx & 0xff00) | m.rb(m.ds, ((m.si + 0x29) & 0xffff));  // mov cl, byte ptr [si + 0x29]
      case 0x18df: m.dx = (m.dx & 0xff) | (m.rb(m.ds, m.si) << 8);  // mov dh, byte ptr [si]
      case 0x18e1: m.dx = (m.dx & 0xff00) | m.rb(m.ds, ((m.si + 0x1) & 0xffff));  // mov dl, byte ptr [si + 1]
      case 0x18e4: m.ax = 0x0;  // mov ax, 0
      case 0x18e7: m.dx = m.shl16(m.dx, 0x1);  // shl dx, 1
      case 0x18e9: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x18eb: m.cx = m.shl16(m.cx, 0x1);  // shl cx, 1
      case 0x18ed: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x18ef: m.bx = m.shl16(m.bx, 0x1);  // shl bx, 1
      case 0x18f1: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x18f3: m.bp = m.shl16(m.bp, 0x1);  // shl bp, 1
      case 0x18f5: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x18f7: m.dx = m.shl16(m.dx, 0x1);  // shl dx, 1
      case 0x18f9: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x18fb: m.cx = m.shl16(m.cx, 0x1);  // shl cx, 1
      case 0x18fd: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x18ff: m.bx = m.shl16(m.bx, 0x1);  // shl bx, 1
      case 0x1901: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1903: m.bp = m.shl16(m.bp, 0x1);  // shl bp, 1
      case 0x1905: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1907: m.dx = m.shl16(m.dx, 0x1);  // shl dx, 1
      case 0x1909: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x190b: m.cx = m.shl16(m.cx, 0x1);  // shl cx, 1
      case 0x190d: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x190f: m.bx = m.shl16(m.bx, 0x1);  // shl bx, 1
      case 0x1911: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1913: m.bp = m.shl16(m.bp, 0x1);  // shl bp, 1
      case 0x1915: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1917: m.dx = m.shl16(m.dx, 0x1);  // shl dx, 1
      case 0x1919: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x191b: m.cx = m.shl16(m.cx, 0x1);  // shl cx, 1
      case 0x191d: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x191f: m.bx = m.shl16(m.bx, 0x1);  // shl bx, 1
      case 0x1921: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1923: m.bp = m.shl16(m.bp, 0x1);  // shl bp, 1
      case 0x1925: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1927: { const t = (m.ax & 0xff); m.ax = (m.ax & 0xff00) | (m.ax >> 8); m.ax = (m.ax & 0xff) | (t << 8); }  // xchg al, ah
      case 0x1929: m.ww(m.es, m.di, m.ax);  // mov word ptr es:[di], ax
      case 0x192c: m.dx = m.shl16(m.dx, 0x1);  // shl dx, 1
      case 0x192e: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1930: m.cx = m.shl16(m.cx, 0x1);  // shl cx, 1
      case 0x1932: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1934: m.bx = m.shl16(m.bx, 0x1);  // shl bx, 1
      case 0x1936: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1938: m.bp = m.shl16(m.bp, 0x1);  // shl bp, 1
      case 0x193a: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x193c: m.dx = m.shl16(m.dx, 0x1);  // shl dx, 1
      case 0x193e: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1940: m.cx = m.shl16(m.cx, 0x1);  // shl cx, 1
      case 0x1942: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1944: m.bx = m.shl16(m.bx, 0x1);  // shl bx, 1
      case 0x1946: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1948: m.bp = m.shl16(m.bp, 0x1);  // shl bp, 1
      case 0x194a: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x194c: m.dx = m.shl16(m.dx, 0x1);  // shl dx, 1
      case 0x194e: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1950: m.cx = m.shl16(m.cx, 0x1);  // shl cx, 1
      case 0x1952: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1954: m.bx = m.shl16(m.bx, 0x1);  // shl bx, 1
      case 0x1956: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1958: m.bp = m.shl16(m.bp, 0x1);  // shl bp, 1
      case 0x195a: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x195c: m.dx = m.shl16(m.dx, 0x1);  // shl dx, 1
      case 0x195e: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1960: m.cx = m.shl16(m.cx, 0x1);  // shl cx, 1
      case 0x1962: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1964: m.bx = m.shl16(m.bx, 0x1);  // shl bx, 1
      case 0x1966: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1968: m.bp = m.shl16(m.bp, 0x1);  // shl bp, 1
      case 0x196a: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x196c: { const t = (m.ax & 0xff); m.ax = (m.ax & 0xff00) | (m.ax >> 8); m.ax = (m.ax & 0xff) | (t << 8); }  // xchg al, ah
      case 0x196e: m.ww(m.es, ((m.di + 0x2) & 0xffff), m.ax);  // mov word ptr es:[di + 2], ax
      case 0x1972: m.dx = m.shl16(m.dx, 0x1);  // shl dx, 1
      case 0x1974: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1976: m.cx = m.shl16(m.cx, 0x1);  // shl cx, 1
      case 0x1978: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x197a: m.bx = m.shl16(m.bx, 0x1);  // shl bx, 1
      case 0x197c: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x197e: m.bp = m.shl16(m.bp, 0x1);  // shl bp, 1
      case 0x1980: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1982: m.dx = m.shl16(m.dx, 0x1);  // shl dx, 1
      case 0x1984: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1986: m.cx = m.shl16(m.cx, 0x1);  // shl cx, 1
      case 0x1988: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x198a: m.bx = m.shl16(m.bx, 0x1);  // shl bx, 1
      case 0x198c: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x198e: m.bp = m.shl16(m.bp, 0x1);  // shl bp, 1
      case 0x1990: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1992: m.dx = m.shl16(m.dx, 0x1);  // shl dx, 1
      case 0x1994: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1996: m.cx = m.shl16(m.cx, 0x1);  // shl cx, 1
      case 0x1998: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x199a: m.bx = m.shl16(m.bx, 0x1);  // shl bx, 1
      case 0x199c: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x199e: m.bp = m.shl16(m.bp, 0x1);  // shl bp, 1
      case 0x19a0: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x19a2: m.dx = m.shl16(m.dx, 0x1);  // shl dx, 1
      case 0x19a4: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x19a6: m.cx = m.shl16(m.cx, 0x1);  // shl cx, 1
      case 0x19a8: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x19aa: m.bx = m.shl16(m.bx, 0x1);  // shl bx, 1
      case 0x19ac: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x19ae: m.bp = m.shl16(m.bp, 0x1);  // shl bp, 1
      case 0x19b0: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x19b2: { const t = (m.ax & 0xff); m.ax = (m.ax & 0xff00) | (m.ax >> 8); m.ax = (m.ax & 0xff) | (t << 8); }  // xchg al, ah
      case 0x19b4: m.ww(m.es, ((m.di + 0x4) & 0xffff), m.ax);  // mov word ptr es:[di + 4], ax
      case 0x19b8: m.dx = m.shl16(m.dx, 0x1);  // shl dx, 1
      case 0x19ba: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x19bc: m.cx = m.shl16(m.cx, 0x1);  // shl cx, 1
      case 0x19be: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x19c0: m.bx = m.shl16(m.bx, 0x1);  // shl bx, 1
      case 0x19c2: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x19c4: m.bp = m.shl16(m.bp, 0x1);  // shl bp, 1
      case 0x19c6: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x19c8: m.dx = m.shl16(m.dx, 0x1);  // shl dx, 1
      case 0x19ca: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x19cc: m.cx = m.shl16(m.cx, 0x1);  // shl cx, 1
      case 0x19ce: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x19d0: m.bx = m.shl16(m.bx, 0x1);  // shl bx, 1
      case 0x19d2: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x19d4: m.bp = m.shl16(m.bp, 0x1);  // shl bp, 1
      case 0x19d6: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x19d8: m.dx = m.shl16(m.dx, 0x1);  // shl dx, 1
      case 0x19da: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x19dc: m.cx = m.shl16(m.cx, 0x1);  // shl cx, 1
      case 0x19de: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x19e0: m.bx = m.shl16(m.bx, 0x1);  // shl bx, 1
      case 0x19e2: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x19e4: m.bp = m.shl16(m.bp, 0x1);  // shl bp, 1
      case 0x19e6: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x19e8: m.dx = m.shl16(m.dx, 0x1);  // shl dx, 1
      case 0x19ea: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x19ec: m.cx = m.shl16(m.cx, 0x1);  // shl cx, 1
      case 0x19ee: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x19f0: m.bx = m.shl16(m.bx, 0x1);  // shl bx, 1
      case 0x19f2: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x19f4: m.bp = m.shl16(m.bp, 0x1);  // shl bp, 1
      case 0x19f6: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x19f8: { const t = (m.ax & 0xff); m.ax = (m.ax & 0xff00) | (m.ax >> 8); m.ax = (m.ax & 0xff) | (t << 8); }  // xchg al, ah
      case 0x19fa: m.ww(m.es, ((m.di + 0x6) & 0xffff), m.ax);  // mov word ptr es:[di + 6], ax
      case 0x19fe: m.si = m.add16(m.si, 0x2);  // add si, 2
      case 0x1a01: m.di = m.add16(m.di, 0x8);  // add di, 8
      case 0x1a04: m.ax = (m.ax & 0xff) | (m.rb(m.ds, ((m.si + 0x78) & 0xffff)) << 8);  // mov ah, byte ptr [si + 0x78]
      case 0x1a07: m.ax = (m.ax & 0xff00) | m.rb(m.ds, ((m.si + 0x79) & 0xffff));  // mov al, byte ptr [si + 0x79]
      case 0x1a0a: m.bp = m.ax;  // mov bp, ax
      case 0x1a0c: m.bx = (m.bx & 0xff) | (m.rb(m.ds, ((m.si + 0x50) & 0xffff)) << 8);  // mov bh, byte ptr [si + 0x50]
      case 0x1a0f: m.bx = (m.bx & 0xff00) | m.rb(m.ds, ((m.si + 0x51) & 0xffff));  // mov bl, byte ptr [si + 0x51]
      case 0x1a12: m.cx = (m.cx & 0xff) | (m.rb(m.ds, ((m.si + 0x28) & 0xffff)) << 8);  // mov ch, byte ptr [si + 0x28]
      case 0x1a15: m.cx = (m.cx & 0xff00) | m.rb(m.ds, ((m.si + 0x29) & 0xffff));  // mov cl, byte ptr [si + 0x29]
      case 0x1a18: m.dx = (m.dx & 0xff) | (m.rb(m.ds, m.si) << 8);  // mov dh, byte ptr [si]
      case 0x1a1a: m.dx = (m.dx & 0xff00) | m.rb(m.ds, ((m.si + 0x1) & 0xffff));  // mov dl, byte ptr [si + 1]
      case 0x1a1d: m.ax = 0x0;  // mov ax, 0
      case 0x1a20: m.dx = m.shl16(m.dx, 0x1);  // shl dx, 1
      case 0x1a22: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1a24: m.cx = m.shl16(m.cx, 0x1);  // shl cx, 1
      case 0x1a26: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1a28: m.bx = m.shl16(m.bx, 0x1);  // shl bx, 1
      case 0x1a2a: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1a2c: m.bp = m.shl16(m.bp, 0x1);  // shl bp, 1
      case 0x1a2e: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1a30: m.dx = m.shl16(m.dx, 0x1);  // shl dx, 1
      case 0x1a32: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1a34: m.cx = m.shl16(m.cx, 0x1);  // shl cx, 1
      case 0x1a36: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1a38: m.bx = m.shl16(m.bx, 0x1);  // shl bx, 1
      case 0x1a3a: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1a3c: m.bp = m.shl16(m.bp, 0x1);  // shl bp, 1
      case 0x1a3e: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1a40: m.dx = m.shl16(m.dx, 0x1);  // shl dx, 1
      case 0x1a42: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1a44: m.cx = m.shl16(m.cx, 0x1);  // shl cx, 1
      case 0x1a46: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1a48: m.bx = m.shl16(m.bx, 0x1);  // shl bx, 1
      case 0x1a4a: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1a4c: m.bp = m.shl16(m.bp, 0x1);  // shl bp, 1
      case 0x1a4e: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1a50: m.dx = m.shl16(m.dx, 0x1);  // shl dx, 1
      case 0x1a52: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1a54: m.cx = m.shl16(m.cx, 0x1);  // shl cx, 1
      case 0x1a56: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1a58: m.bx = m.shl16(m.bx, 0x1);  // shl bx, 1
      case 0x1a5a: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1a5c: m.bp = m.shl16(m.bp, 0x1);  // shl bp, 1
      case 0x1a5e: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1a60: { const t = (m.ax & 0xff); m.ax = (m.ax & 0xff00) | (m.ax >> 8); m.ax = (m.ax & 0xff) | (t << 8); }  // xchg al, ah
      case 0x1a62: m.ww(m.es, m.di, m.ax);  // mov word ptr es:[di], ax
      case 0x1a65: m.dx = m.shl16(m.dx, 0x1);  // shl dx, 1
      case 0x1a67: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1a69: m.cx = m.shl16(m.cx, 0x1);  // shl cx, 1
      case 0x1a6b: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1a6d: m.bx = m.shl16(m.bx, 0x1);  // shl bx, 1
      case 0x1a6f: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1a71: m.bp = m.shl16(m.bp, 0x1);  // shl bp, 1
      case 0x1a73: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1a75: m.dx = m.shl16(m.dx, 0x1);  // shl dx, 1
      case 0x1a77: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1a79: m.cx = m.shl16(m.cx, 0x1);  // shl cx, 1
      case 0x1a7b: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1a7d: m.bx = m.shl16(m.bx, 0x1);  // shl bx, 1
      case 0x1a7f: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1a81: m.bp = m.shl16(m.bp, 0x1);  // shl bp, 1
      case 0x1a83: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1a85: m.dx = m.shl16(m.dx, 0x1);  // shl dx, 1
      case 0x1a87: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1a89: m.cx = m.shl16(m.cx, 0x1);  // shl cx, 1
      case 0x1a8b: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1a8d: m.bx = m.shl16(m.bx, 0x1);  // shl bx, 1
      case 0x1a8f: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1a91: m.bp = m.shl16(m.bp, 0x1);  // shl bp, 1
      case 0x1a93: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1a95: m.dx = m.shl16(m.dx, 0x1);  // shl dx, 1
      case 0x1a97: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1a99: m.cx = m.shl16(m.cx, 0x1);  // shl cx, 1
      case 0x1a9b: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1a9d: m.bx = m.shl16(m.bx, 0x1);  // shl bx, 1
      case 0x1a9f: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1aa1: m.bp = m.shl16(m.bp, 0x1);  // shl bp, 1
      case 0x1aa3: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1aa5: { const t = (m.ax & 0xff); m.ax = (m.ax & 0xff00) | (m.ax >> 8); m.ax = (m.ax & 0xff) | (t << 8); }  // xchg al, ah
      case 0x1aa7: m.ww(m.es, ((m.di + 0x2) & 0xffff), m.ax);  // mov word ptr es:[di + 2], ax
      case 0x1aab: m.dx = m.shl16(m.dx, 0x1);  // shl dx, 1
      case 0x1aad: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1aaf: m.cx = m.shl16(m.cx, 0x1);  // shl cx, 1
      case 0x1ab1: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1ab3: m.bx = m.shl16(m.bx, 0x1);  // shl bx, 1
      case 0x1ab5: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1ab7: m.bp = m.shl16(m.bp, 0x1);  // shl bp, 1
      case 0x1ab9: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1abb: m.dx = m.shl16(m.dx, 0x1);  // shl dx, 1
      case 0x1abd: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1abf: m.cx = m.shl16(m.cx, 0x1);  // shl cx, 1
      case 0x1ac1: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1ac3: m.bx = m.shl16(m.bx, 0x1);  // shl bx, 1
      case 0x1ac5: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1ac7: m.bp = m.shl16(m.bp, 0x1);  // shl bp, 1
      case 0x1ac9: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1acb: m.dx = m.shl16(m.dx, 0x1);  // shl dx, 1
      case 0x1acd: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1acf: m.cx = m.shl16(m.cx, 0x1);  // shl cx, 1
      case 0x1ad1: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1ad3: m.bx = m.shl16(m.bx, 0x1);  // shl bx, 1
      case 0x1ad5: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1ad7: m.bp = m.shl16(m.bp, 0x1);  // shl bp, 1
      case 0x1ad9: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1adb: m.dx = m.shl16(m.dx, 0x1);  // shl dx, 1
      case 0x1add: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1adf: m.cx = m.shl16(m.cx, 0x1);  // shl cx, 1
      case 0x1ae1: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1ae3: m.bx = m.shl16(m.bx, 0x1);  // shl bx, 1
      case 0x1ae5: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1ae7: m.bp = m.shl16(m.bp, 0x1);  // shl bp, 1
      case 0x1ae9: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1aeb: { const t = (m.ax & 0xff); m.ax = (m.ax & 0xff00) | (m.ax >> 8); m.ax = (m.ax & 0xff) | (t << 8); }  // xchg al, ah
      case 0x1aed: m.ww(m.es, ((m.di + 0x4) & 0xffff), m.ax);  // mov word ptr es:[di + 4], ax
      case 0x1af1: m.dx = m.shl16(m.dx, 0x1);  // shl dx, 1
      case 0x1af3: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1af5: m.cx = m.shl16(m.cx, 0x1);  // shl cx, 1
      case 0x1af7: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1af9: m.bx = m.shl16(m.bx, 0x1);  // shl bx, 1
      case 0x1afb: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1afd: m.bp = m.shl16(m.bp, 0x1);  // shl bp, 1
      case 0x1aff: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1b01: m.dx = m.shl16(m.dx, 0x1);  // shl dx, 1
      case 0x1b03: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1b05: m.cx = m.shl16(m.cx, 0x1);  // shl cx, 1
      case 0x1b07: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1b09: m.bx = m.shl16(m.bx, 0x1);  // shl bx, 1
      case 0x1b0b: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1b0d: m.bp = m.shl16(m.bp, 0x1);  // shl bp, 1
      case 0x1b0f: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1b11: m.dx = m.shl16(m.dx, 0x1);  // shl dx, 1
      case 0x1b13: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1b15: m.cx = m.shl16(m.cx, 0x1);  // shl cx, 1
      case 0x1b17: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1b19: m.bx = m.shl16(m.bx, 0x1);  // shl bx, 1
      case 0x1b1b: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1b1d: m.bp = m.shl16(m.bp, 0x1);  // shl bp, 1
      case 0x1b1f: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1b21: m.dx = m.shl16(m.dx, 0x1);  // shl dx, 1
      case 0x1b23: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1b25: m.cx = m.shl16(m.cx, 0x1);  // shl cx, 1
      case 0x1b27: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1b29: m.bx = m.shl16(m.bx, 0x1);  // shl bx, 1
      case 0x1b2b: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1b2d: m.bp = m.shl16(m.bp, 0x1);  // shl bp, 1
      case 0x1b2f: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1b31: { const t = (m.ax & 0xff); m.ax = (m.ax & 0xff00) | (m.ax >> 8); m.ax = (m.ax & 0xff) | (t << 8); }  // xchg al, ah
      case 0x1b33: m.ww(m.es, ((m.di + 0x6) & 0xffff), m.ax);  // mov word ptr es:[di + 6], ax
      case 0x1b37: m.si = m.add16(m.si, 0x2);  // add si, 2
      case 0x1b3a: m.di = m.add16(m.di, 0x8);  // add di, 8
      case 0x1b3d: m.ax = (m.ax & 0xff) | (m.rb(m.ds, ((m.si + 0x78) & 0xffff)) << 8);  // mov ah, byte ptr [si + 0x78]
      case 0x1b40: m.ax = (m.ax & 0xff00) | m.rb(m.ds, ((m.si + 0x79) & 0xffff));  // mov al, byte ptr [si + 0x79]
      case 0x1b43: m.bp = m.ax;  // mov bp, ax
      case 0x1b45: m.bx = (m.bx & 0xff) | (m.rb(m.ds, ((m.si + 0x50) & 0xffff)) << 8);  // mov bh, byte ptr [si + 0x50]
      case 0x1b48: m.bx = (m.bx & 0xff00) | m.rb(m.ds, ((m.si + 0x51) & 0xffff));  // mov bl, byte ptr [si + 0x51]
      case 0x1b4b: m.cx = (m.cx & 0xff) | (m.rb(m.ds, ((m.si + 0x28) & 0xffff)) << 8);  // mov ch, byte ptr [si + 0x28]
      case 0x1b4e: m.cx = (m.cx & 0xff00) | m.rb(m.ds, ((m.si + 0x29) & 0xffff));  // mov cl, byte ptr [si + 0x29]
      case 0x1b51: m.dx = (m.dx & 0xff) | (m.rb(m.ds, m.si) << 8);  // mov dh, byte ptr [si]
      case 0x1b53: m.dx = (m.dx & 0xff00) | m.rb(m.ds, ((m.si + 0x1) & 0xffff));  // mov dl, byte ptr [si + 1]
      case 0x1b56: m.ax = 0x0;  // mov ax, 0
      case 0x1b59: m.dx = m.shl16(m.dx, 0x1);  // shl dx, 1
      case 0x1b5b: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1b5d: m.cx = m.shl16(m.cx, 0x1);  // shl cx, 1
      case 0x1b5f: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1b61: m.bx = m.shl16(m.bx, 0x1);  // shl bx, 1
      case 0x1b63: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1b65: m.bp = m.shl16(m.bp, 0x1);  // shl bp, 1
      case 0x1b67: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1b69: m.dx = m.shl16(m.dx, 0x1);  // shl dx, 1
      case 0x1b6b: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1b6d: m.cx = m.shl16(m.cx, 0x1);  // shl cx, 1
      case 0x1b6f: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1b71: m.bx = m.shl16(m.bx, 0x1);  // shl bx, 1
      case 0x1b73: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1b75: m.bp = m.shl16(m.bp, 0x1);  // shl bp, 1
      case 0x1b77: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1b79: m.dx = m.shl16(m.dx, 0x1);  // shl dx, 1
      case 0x1b7b: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1b7d: m.cx = m.shl16(m.cx, 0x1);  // shl cx, 1
      case 0x1b7f: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1b81: m.bx = m.shl16(m.bx, 0x1);  // shl bx, 1
      case 0x1b83: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1b85: m.bp = m.shl16(m.bp, 0x1);  // shl bp, 1
      case 0x1b87: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1b89: m.dx = m.shl16(m.dx, 0x1);  // shl dx, 1
      case 0x1b8b: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1b8d: m.cx = m.shl16(m.cx, 0x1);  // shl cx, 1
      case 0x1b8f: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1b91: m.bx = m.shl16(m.bx, 0x1);  // shl bx, 1
      case 0x1b93: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1b95: m.bp = m.shl16(m.bp, 0x1);  // shl bp, 1
      case 0x1b97: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1b99: { const t = (m.ax & 0xff); m.ax = (m.ax & 0xff00) | (m.ax >> 8); m.ax = (m.ax & 0xff) | (t << 8); }  // xchg al, ah
      case 0x1b9b: m.ww(m.es, m.di, m.ax);  // mov word ptr es:[di], ax
      case 0x1b9e: m.dx = m.shl16(m.dx, 0x1);  // shl dx, 1
      case 0x1ba0: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1ba2: m.cx = m.shl16(m.cx, 0x1);  // shl cx, 1
      case 0x1ba4: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1ba6: m.bx = m.shl16(m.bx, 0x1);  // shl bx, 1
      case 0x1ba8: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1baa: m.bp = m.shl16(m.bp, 0x1);  // shl bp, 1
      case 0x1bac: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1bae: m.dx = m.shl16(m.dx, 0x1);  // shl dx, 1
      case 0x1bb0: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1bb2: m.cx = m.shl16(m.cx, 0x1);  // shl cx, 1
      case 0x1bb4: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1bb6: m.bx = m.shl16(m.bx, 0x1);  // shl bx, 1
      case 0x1bb8: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1bba: m.bp = m.shl16(m.bp, 0x1);  // shl bp, 1
      case 0x1bbc: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1bbe: m.dx = m.shl16(m.dx, 0x1);  // shl dx, 1
      case 0x1bc0: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1bc2: m.cx = m.shl16(m.cx, 0x1);  // shl cx, 1
      case 0x1bc4: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1bc6: m.bx = m.shl16(m.bx, 0x1);  // shl bx, 1
      case 0x1bc8: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1bca: m.bp = m.shl16(m.bp, 0x1);  // shl bp, 1
      case 0x1bcc: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1bce: m.dx = m.shl16(m.dx, 0x1);  // shl dx, 1
      case 0x1bd0: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1bd2: m.cx = m.shl16(m.cx, 0x1);  // shl cx, 1
      case 0x1bd4: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1bd6: m.bx = m.shl16(m.bx, 0x1);  // shl bx, 1
      case 0x1bd8: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1bda: m.bp = m.shl16(m.bp, 0x1);  // shl bp, 1
      case 0x1bdc: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1bde: { const t = (m.ax & 0xff); m.ax = (m.ax & 0xff00) | (m.ax >> 8); m.ax = (m.ax & 0xff) | (t << 8); }  // xchg al, ah
      case 0x1be0: m.ww(m.es, ((m.di + 0x2) & 0xffff), m.ax);  // mov word ptr es:[di + 2], ax
      case 0x1be4: m.dx = m.shl16(m.dx, 0x1);  // shl dx, 1
      case 0x1be6: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1be8: m.cx = m.shl16(m.cx, 0x1);  // shl cx, 1
      case 0x1bea: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1bec: m.bx = m.shl16(m.bx, 0x1);  // shl bx, 1
      case 0x1bee: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1bf0: m.bp = m.shl16(m.bp, 0x1);  // shl bp, 1
      case 0x1bf2: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1bf4: m.dx = m.shl16(m.dx, 0x1);  // shl dx, 1
      case 0x1bf6: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1bf8: m.cx = m.shl16(m.cx, 0x1);  // shl cx, 1
      case 0x1bfa: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1bfc: m.bx = m.shl16(m.bx, 0x1);  // shl bx, 1
      case 0x1bfe: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1c00: m.bp = m.shl16(m.bp, 0x1);  // shl bp, 1
      case 0x1c02: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1c04: m.dx = m.shl16(m.dx, 0x1);  // shl dx, 1
      case 0x1c06: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1c08: m.cx = m.shl16(m.cx, 0x1);  // shl cx, 1
      case 0x1c0a: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1c0c: m.bx = m.shl16(m.bx, 0x1);  // shl bx, 1
      case 0x1c0e: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1c10: m.bp = m.shl16(m.bp, 0x1);  // shl bp, 1
      case 0x1c12: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1c14: m.dx = m.shl16(m.dx, 0x1);  // shl dx, 1
      case 0x1c16: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1c18: m.cx = m.shl16(m.cx, 0x1);  // shl cx, 1
      case 0x1c1a: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1c1c: m.bx = m.shl16(m.bx, 0x1);  // shl bx, 1
      case 0x1c1e: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1c20: m.bp = m.shl16(m.bp, 0x1);  // shl bp, 1
      case 0x1c22: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1c24: { const t = (m.ax & 0xff); m.ax = (m.ax & 0xff00) | (m.ax >> 8); m.ax = (m.ax & 0xff) | (t << 8); }  // xchg al, ah
      case 0x1c26: m.ww(m.es, ((m.di + 0x4) & 0xffff), m.ax);  // mov word ptr es:[di + 4], ax
      case 0x1c2a: m.dx = m.shl16(m.dx, 0x1);  // shl dx, 1
      case 0x1c2c: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1c2e: m.cx = m.shl16(m.cx, 0x1);  // shl cx, 1
      case 0x1c30: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1c32: m.bx = m.shl16(m.bx, 0x1);  // shl bx, 1
      case 0x1c34: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1c36: m.bp = m.shl16(m.bp, 0x1);  // shl bp, 1
      case 0x1c38: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1c3a: m.dx = m.shl16(m.dx, 0x1);  // shl dx, 1
      case 0x1c3c: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1c3e: m.cx = m.shl16(m.cx, 0x1);  // shl cx, 1
      case 0x1c40: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1c42: m.bx = m.shl16(m.bx, 0x1);  // shl bx, 1
      case 0x1c44: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1c46: m.bp = m.shl16(m.bp, 0x1);  // shl bp, 1
      case 0x1c48: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1c4a: m.dx = m.shl16(m.dx, 0x1);  // shl dx, 1
      case 0x1c4c: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1c4e: m.cx = m.shl16(m.cx, 0x1);  // shl cx, 1
      case 0x1c50: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1c52: m.bx = m.shl16(m.bx, 0x1);  // shl bx, 1
      case 0x1c54: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1c56: m.bp = m.shl16(m.bp, 0x1);  // shl bp, 1
      case 0x1c58: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1c5a: m.dx = m.shl16(m.dx, 0x1);  // shl dx, 1
      case 0x1c5c: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1c5e: m.cx = m.shl16(m.cx, 0x1);  // shl cx, 1
      case 0x1c60: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1c62: m.bx = m.shl16(m.bx, 0x1);  // shl bx, 1
      case 0x1c64: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1c66: m.bp = m.shl16(m.bp, 0x1);  // shl bp, 1
      case 0x1c68: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1c6a: { const t = (m.ax & 0xff); m.ax = (m.ax & 0xff00) | (m.ax >> 8); m.ax = (m.ax & 0xff) | (t << 8); }  // xchg al, ah
      case 0x1c6c: m.ww(m.es, ((m.di + 0x6) & 0xffff), m.ax);  // mov word ptr es:[di + 6], ax
      case 0x1c70: m.si = m.add16(m.si, 0x2);  // add si, 2
      case 0x1c73: m.di = m.add16(m.di, 0x8);  // add di, 8
      case 0x1c76: m.ax = (m.ax & 0xff) | (m.rb(m.ds, ((m.si + 0x78) & 0xffff)) << 8);  // mov ah, byte ptr [si + 0x78]
      case 0x1c79: m.ax = (m.ax & 0xff00) | m.rb(m.ds, ((m.si + 0x79) & 0xffff));  // mov al, byte ptr [si + 0x79]
      case 0x1c7c: m.bp = m.ax;  // mov bp, ax
      case 0x1c7e: m.bx = (m.bx & 0xff) | (m.rb(m.ds, ((m.si + 0x50) & 0xffff)) << 8);  // mov bh, byte ptr [si + 0x50]
      case 0x1c81: m.bx = (m.bx & 0xff00) | m.rb(m.ds, ((m.si + 0x51) & 0xffff));  // mov bl, byte ptr [si + 0x51]
      case 0x1c84: m.cx = (m.cx & 0xff) | (m.rb(m.ds, ((m.si + 0x28) & 0xffff)) << 8);  // mov ch, byte ptr [si + 0x28]
      case 0x1c87: m.cx = (m.cx & 0xff00) | m.rb(m.ds, ((m.si + 0x29) & 0xffff));  // mov cl, byte ptr [si + 0x29]
      case 0x1c8a: m.dx = (m.dx & 0xff) | (m.rb(m.ds, m.si) << 8);  // mov dh, byte ptr [si]
      case 0x1c8c: m.dx = (m.dx & 0xff00) | m.rb(m.ds, ((m.si + 0x1) & 0xffff));  // mov dl, byte ptr [si + 1]
      case 0x1c8f: m.ax = 0x0;  // mov ax, 0
      case 0x1c92: m.dx = m.shl16(m.dx, 0x1);  // shl dx, 1
      case 0x1c94: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1c96: m.cx = m.shl16(m.cx, 0x1);  // shl cx, 1
      case 0x1c98: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1c9a: m.bx = m.shl16(m.bx, 0x1);  // shl bx, 1
      case 0x1c9c: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1c9e: m.bp = m.shl16(m.bp, 0x1);  // shl bp, 1
      case 0x1ca0: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1ca2: m.dx = m.shl16(m.dx, 0x1);  // shl dx, 1
      case 0x1ca4: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1ca6: m.cx = m.shl16(m.cx, 0x1);  // shl cx, 1
      case 0x1ca8: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1caa: m.bx = m.shl16(m.bx, 0x1);  // shl bx, 1
      case 0x1cac: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1cae: m.bp = m.shl16(m.bp, 0x1);  // shl bp, 1
      case 0x1cb0: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1cb2: m.dx = m.shl16(m.dx, 0x1);  // shl dx, 1
      case 0x1cb4: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1cb6: m.cx = m.shl16(m.cx, 0x1);  // shl cx, 1
      case 0x1cb8: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1cba: m.bx = m.shl16(m.bx, 0x1);  // shl bx, 1
      case 0x1cbc: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1cbe: m.bp = m.shl16(m.bp, 0x1);  // shl bp, 1
      case 0x1cc0: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1cc2: m.dx = m.shl16(m.dx, 0x1);  // shl dx, 1
      case 0x1cc4: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1cc6: m.cx = m.shl16(m.cx, 0x1);  // shl cx, 1
      case 0x1cc8: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1cca: m.bx = m.shl16(m.bx, 0x1);  // shl bx, 1
      case 0x1ccc: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1cce: m.bp = m.shl16(m.bp, 0x1);  // shl bp, 1
      case 0x1cd0: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1cd2: { const t = (m.ax & 0xff); m.ax = (m.ax & 0xff00) | (m.ax >> 8); m.ax = (m.ax & 0xff) | (t << 8); }  // xchg al, ah
      case 0x1cd4: m.ww(m.es, m.di, m.ax);  // mov word ptr es:[di], ax
      case 0x1cd7: m.dx = m.shl16(m.dx, 0x1);  // shl dx, 1
      case 0x1cd9: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1cdb: m.cx = m.shl16(m.cx, 0x1);  // shl cx, 1
      case 0x1cdd: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1cdf: m.bx = m.shl16(m.bx, 0x1);  // shl bx, 1
      case 0x1ce1: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1ce3: m.bp = m.shl16(m.bp, 0x1);  // shl bp, 1
      case 0x1ce5: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1ce7: m.dx = m.shl16(m.dx, 0x1);  // shl dx, 1
      case 0x1ce9: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1ceb: m.cx = m.shl16(m.cx, 0x1);  // shl cx, 1
      case 0x1ced: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1cef: m.bx = m.shl16(m.bx, 0x1);  // shl bx, 1
      case 0x1cf1: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1cf3: m.bp = m.shl16(m.bp, 0x1);  // shl bp, 1
      case 0x1cf5: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1cf7: m.dx = m.shl16(m.dx, 0x1);  // shl dx, 1
      case 0x1cf9: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1cfb: m.cx = m.shl16(m.cx, 0x1);  // shl cx, 1
      case 0x1cfd: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1cff: m.bx = m.shl16(m.bx, 0x1);  // shl bx, 1
      case 0x1d01: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1d03: m.bp = m.shl16(m.bp, 0x1);  // shl bp, 1
      case 0x1d05: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1d07: m.dx = m.shl16(m.dx, 0x1);  // shl dx, 1
      case 0x1d09: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1d0b: m.cx = m.shl16(m.cx, 0x1);  // shl cx, 1
      case 0x1d0d: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1d0f: m.bx = m.shl16(m.bx, 0x1);  // shl bx, 1
      case 0x1d11: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1d13: m.bp = m.shl16(m.bp, 0x1);  // shl bp, 1
      case 0x1d15: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1d17: { const t = (m.ax & 0xff); m.ax = (m.ax & 0xff00) | (m.ax >> 8); m.ax = (m.ax & 0xff) | (t << 8); }  // xchg al, ah
      case 0x1d19: m.ww(m.es, ((m.di + 0x2) & 0xffff), m.ax);  // mov word ptr es:[di + 2], ax
      case 0x1d1d: m.dx = m.shl16(m.dx, 0x1);  // shl dx, 1
      case 0x1d1f: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1d21: m.cx = m.shl16(m.cx, 0x1);  // shl cx, 1
      case 0x1d23: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1d25: m.bx = m.shl16(m.bx, 0x1);  // shl bx, 1
      case 0x1d27: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1d29: m.bp = m.shl16(m.bp, 0x1);  // shl bp, 1
      case 0x1d2b: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1d2d: m.dx = m.shl16(m.dx, 0x1);  // shl dx, 1
      case 0x1d2f: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1d31: m.cx = m.shl16(m.cx, 0x1);  // shl cx, 1
      case 0x1d33: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1d35: m.bx = m.shl16(m.bx, 0x1);  // shl bx, 1
      case 0x1d37: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1d39: m.bp = m.shl16(m.bp, 0x1);  // shl bp, 1
      case 0x1d3b: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1d3d: m.dx = m.shl16(m.dx, 0x1);  // shl dx, 1
      case 0x1d3f: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1d41: m.cx = m.shl16(m.cx, 0x1);  // shl cx, 1
      case 0x1d43: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1d45: m.bx = m.shl16(m.bx, 0x1);  // shl bx, 1
      case 0x1d47: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1d49: m.bp = m.shl16(m.bp, 0x1);  // shl bp, 1
      case 0x1d4b: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1d4d: m.dx = m.shl16(m.dx, 0x1);  // shl dx, 1
      case 0x1d4f: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1d51: m.cx = m.shl16(m.cx, 0x1);  // shl cx, 1
      case 0x1d53: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1d55: m.bx = m.shl16(m.bx, 0x1);  // shl bx, 1
      case 0x1d57: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1d59: m.bp = m.shl16(m.bp, 0x1);  // shl bp, 1
      case 0x1d5b: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1d5d: { const t = (m.ax & 0xff); m.ax = (m.ax & 0xff00) | (m.ax >> 8); m.ax = (m.ax & 0xff) | (t << 8); }  // xchg al, ah
      case 0x1d5f: m.ww(m.es, ((m.di + 0x4) & 0xffff), m.ax);  // mov word ptr es:[di + 4], ax
      case 0x1d63: m.dx = m.shl16(m.dx, 0x1);  // shl dx, 1
      case 0x1d65: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1d67: m.cx = m.shl16(m.cx, 0x1);  // shl cx, 1
      case 0x1d69: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1d6b: m.bx = m.shl16(m.bx, 0x1);  // shl bx, 1
      case 0x1d6d: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1d6f: m.bp = m.shl16(m.bp, 0x1);  // shl bp, 1
      case 0x1d71: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1d73: m.dx = m.shl16(m.dx, 0x1);  // shl dx, 1
      case 0x1d75: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1d77: m.cx = m.shl16(m.cx, 0x1);  // shl cx, 1
      case 0x1d79: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1d7b: m.bx = m.shl16(m.bx, 0x1);  // shl bx, 1
      case 0x1d7d: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1d7f: m.bp = m.shl16(m.bp, 0x1);  // shl bp, 1
      case 0x1d81: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1d83: m.dx = m.shl16(m.dx, 0x1);  // shl dx, 1
      case 0x1d85: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1d87: m.cx = m.shl16(m.cx, 0x1);  // shl cx, 1
      case 0x1d89: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1d8b: m.bx = m.shl16(m.bx, 0x1);  // shl bx, 1
      case 0x1d8d: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1d8f: m.bp = m.shl16(m.bp, 0x1);  // shl bp, 1
      case 0x1d91: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1d93: m.dx = m.shl16(m.dx, 0x1);  // shl dx, 1
      case 0x1d95: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1d97: m.cx = m.shl16(m.cx, 0x1);  // shl cx, 1
      case 0x1d99: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1d9b: m.bx = m.shl16(m.bx, 0x1);  // shl bx, 1
      case 0x1d9d: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1d9f: m.bp = m.shl16(m.bp, 0x1);  // shl bp, 1
      case 0x1da1: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1da3: { const t = (m.ax & 0xff); m.ax = (m.ax & 0xff00) | (m.ax >> 8); m.ax = (m.ax & 0xff) | (t << 8); }  // xchg al, ah
      case 0x1da5: m.ww(m.es, ((m.di + 0x6) & 0xffff), m.ax);  // mov word ptr es:[di + 6], ax
      case 0x1da9: m.si = m.add16(m.si, 0x2);  // add si, 2
      case 0x1dac: m.di = m.add16(m.di, 0x8);  // add di, 8
      case 0x1daf: m.ax = (m.ax & 0xff) | (m.rb(m.ds, ((m.si + 0x78) & 0xffff)) << 8);  // mov ah, byte ptr [si + 0x78]
      case 0x1db2: m.ax = (m.ax & 0xff00) | m.rb(m.ds, ((m.si + 0x79) & 0xffff));  // mov al, byte ptr [si + 0x79]
      case 0x1db5: m.bp = m.ax;  // mov bp, ax
      case 0x1db7: m.bx = (m.bx & 0xff) | (m.rb(m.ds, ((m.si + 0x50) & 0xffff)) << 8);  // mov bh, byte ptr [si + 0x50]
      case 0x1dba: m.bx = (m.bx & 0xff00) | m.rb(m.ds, ((m.si + 0x51) & 0xffff));  // mov bl, byte ptr [si + 0x51]
      case 0x1dbd: m.cx = (m.cx & 0xff) | (m.rb(m.ds, ((m.si + 0x28) & 0xffff)) << 8);  // mov ch, byte ptr [si + 0x28]
      case 0x1dc0: m.cx = (m.cx & 0xff00) | m.rb(m.ds, ((m.si + 0x29) & 0xffff));  // mov cl, byte ptr [si + 0x29]
      case 0x1dc3: m.dx = (m.dx & 0xff) | (m.rb(m.ds, m.si) << 8);  // mov dh, byte ptr [si]
      case 0x1dc5: m.dx = (m.dx & 0xff00) | m.rb(m.ds, ((m.si + 0x1) & 0xffff));  // mov dl, byte ptr [si + 1]
      case 0x1dc8: m.ax = 0x0;  // mov ax, 0
      case 0x1dcb: m.dx = m.shl16(m.dx, 0x1);  // shl dx, 1
      case 0x1dcd: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1dcf: m.cx = m.shl16(m.cx, 0x1);  // shl cx, 1
      case 0x1dd1: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1dd3: m.bx = m.shl16(m.bx, 0x1);  // shl bx, 1
      case 0x1dd5: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1dd7: m.bp = m.shl16(m.bp, 0x1);  // shl bp, 1
      case 0x1dd9: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1ddb: m.dx = m.shl16(m.dx, 0x1);  // shl dx, 1
      case 0x1ddd: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1ddf: m.cx = m.shl16(m.cx, 0x1);  // shl cx, 1
      case 0x1de1: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1de3: m.bx = m.shl16(m.bx, 0x1);  // shl bx, 1
      case 0x1de5: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1de7: m.bp = m.shl16(m.bp, 0x1);  // shl bp, 1
      case 0x1de9: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1deb: m.dx = m.shl16(m.dx, 0x1);  // shl dx, 1
      case 0x1ded: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1def: m.cx = m.shl16(m.cx, 0x1);  // shl cx, 1
      case 0x1df1: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1df3: m.bx = m.shl16(m.bx, 0x1);  // shl bx, 1
      case 0x1df5: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1df7: m.bp = m.shl16(m.bp, 0x1);  // shl bp, 1
      case 0x1df9: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1dfb: m.dx = m.shl16(m.dx, 0x1);  // shl dx, 1
      case 0x1dfd: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1dff: m.cx = m.shl16(m.cx, 0x1);  // shl cx, 1
      case 0x1e01: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1e03: m.bx = m.shl16(m.bx, 0x1);  // shl bx, 1
      case 0x1e05: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1e07: m.bp = m.shl16(m.bp, 0x1);  // shl bp, 1
      case 0x1e09: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1e0b: { const t = (m.ax & 0xff); m.ax = (m.ax & 0xff00) | (m.ax >> 8); m.ax = (m.ax & 0xff) | (t << 8); }  // xchg al, ah
      case 0x1e0d: m.ww(m.es, m.di, m.ax);  // mov word ptr es:[di], ax
      case 0x1e10: m.dx = m.shl16(m.dx, 0x1);  // shl dx, 1
      case 0x1e12: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1e14: m.cx = m.shl16(m.cx, 0x1);  // shl cx, 1
      case 0x1e16: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1e18: m.bx = m.shl16(m.bx, 0x1);  // shl bx, 1
      case 0x1e1a: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1e1c: m.bp = m.shl16(m.bp, 0x1);  // shl bp, 1
      case 0x1e1e: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1e20: m.dx = m.shl16(m.dx, 0x1);  // shl dx, 1
      case 0x1e22: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1e24: m.cx = m.shl16(m.cx, 0x1);  // shl cx, 1
      case 0x1e26: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1e28: m.bx = m.shl16(m.bx, 0x1);  // shl bx, 1
      case 0x1e2a: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1e2c: m.bp = m.shl16(m.bp, 0x1);  // shl bp, 1
      case 0x1e2e: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1e30: m.dx = m.shl16(m.dx, 0x1);  // shl dx, 1
      case 0x1e32: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1e34: m.cx = m.shl16(m.cx, 0x1);  // shl cx, 1
      case 0x1e36: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1e38: m.bx = m.shl16(m.bx, 0x1);  // shl bx, 1
      case 0x1e3a: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1e3c: m.bp = m.shl16(m.bp, 0x1);  // shl bp, 1
      case 0x1e3e: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1e40: m.dx = m.shl16(m.dx, 0x1);  // shl dx, 1
      case 0x1e42: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1e44: m.cx = m.shl16(m.cx, 0x1);  // shl cx, 1
      case 0x1e46: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1e48: m.bx = m.shl16(m.bx, 0x1);  // shl bx, 1
      case 0x1e4a: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1e4c: m.bp = m.shl16(m.bp, 0x1);  // shl bp, 1
      case 0x1e4e: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1e50: { const t = (m.ax & 0xff); m.ax = (m.ax & 0xff00) | (m.ax >> 8); m.ax = (m.ax & 0xff) | (t << 8); }  // xchg al, ah
      case 0x1e52: m.ww(m.es, ((m.di + 0x2) & 0xffff), m.ax);  // mov word ptr es:[di + 2], ax
      case 0x1e56: m.dx = m.shl16(m.dx, 0x1);  // shl dx, 1
      case 0x1e58: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1e5a: m.cx = m.shl16(m.cx, 0x1);  // shl cx, 1
      case 0x1e5c: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1e5e: m.bx = m.shl16(m.bx, 0x1);  // shl bx, 1
      case 0x1e60: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1e62: m.bp = m.shl16(m.bp, 0x1);  // shl bp, 1
      case 0x1e64: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1e66: m.dx = m.shl16(m.dx, 0x1);  // shl dx, 1
      case 0x1e68: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1e6a: m.cx = m.shl16(m.cx, 0x1);  // shl cx, 1
      case 0x1e6c: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1e6e: m.bx = m.shl16(m.bx, 0x1);  // shl bx, 1
      case 0x1e70: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1e72: m.bp = m.shl16(m.bp, 0x1);  // shl bp, 1
      case 0x1e74: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1e76: m.dx = m.shl16(m.dx, 0x1);  // shl dx, 1
      case 0x1e78: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1e7a: m.cx = m.shl16(m.cx, 0x1);  // shl cx, 1
      case 0x1e7c: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1e7e: m.bx = m.shl16(m.bx, 0x1);  // shl bx, 1
      case 0x1e80: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1e82: m.bp = m.shl16(m.bp, 0x1);  // shl bp, 1
      case 0x1e84: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1e86: m.dx = m.shl16(m.dx, 0x1);  // shl dx, 1
      case 0x1e88: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1e8a: m.cx = m.shl16(m.cx, 0x1);  // shl cx, 1
      case 0x1e8c: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1e8e: m.bx = m.shl16(m.bx, 0x1);  // shl bx, 1
      case 0x1e90: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1e92: m.bp = m.shl16(m.bp, 0x1);  // shl bp, 1
      case 0x1e94: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1e96: { const t = (m.ax & 0xff); m.ax = (m.ax & 0xff00) | (m.ax >> 8); m.ax = (m.ax & 0xff) | (t << 8); }  // xchg al, ah
      case 0x1e98: m.ww(m.es, ((m.di + 0x4) & 0xffff), m.ax);  // mov word ptr es:[di + 4], ax
      case 0x1e9c: m.dx = m.shl16(m.dx, 0x1);  // shl dx, 1
      case 0x1e9e: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1ea0: m.cx = m.shl16(m.cx, 0x1);  // shl cx, 1
      case 0x1ea2: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1ea4: m.bx = m.shl16(m.bx, 0x1);  // shl bx, 1
      case 0x1ea6: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1ea8: m.bp = m.shl16(m.bp, 0x1);  // shl bp, 1
      case 0x1eaa: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1eac: m.dx = m.shl16(m.dx, 0x1);  // shl dx, 1
      case 0x1eae: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1eb0: m.cx = m.shl16(m.cx, 0x1);  // shl cx, 1
      case 0x1eb2: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1eb4: m.bx = m.shl16(m.bx, 0x1);  // shl bx, 1
      case 0x1eb6: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1eb8: m.bp = m.shl16(m.bp, 0x1);  // shl bp, 1
      case 0x1eba: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1ebc: m.dx = m.shl16(m.dx, 0x1);  // shl dx, 1
      case 0x1ebe: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1ec0: m.cx = m.shl16(m.cx, 0x1);  // shl cx, 1
      case 0x1ec2: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1ec4: m.bx = m.shl16(m.bx, 0x1);  // shl bx, 1
      case 0x1ec6: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1ec8: m.bp = m.shl16(m.bp, 0x1);  // shl bp, 1
      case 0x1eca: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1ecc: m.dx = m.shl16(m.dx, 0x1);  // shl dx, 1
      case 0x1ece: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1ed0: m.cx = m.shl16(m.cx, 0x1);  // shl cx, 1
      case 0x1ed2: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1ed4: m.bx = m.shl16(m.bx, 0x1);  // shl bx, 1
      case 0x1ed6: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1ed8: m.bp = m.shl16(m.bp, 0x1);  // shl bp, 1
      case 0x1eda: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1edc: { const t = (m.ax & 0xff); m.ax = (m.ax & 0xff00) | (m.ax >> 8); m.ax = (m.ax & 0xff) | (t << 8); }  // xchg al, ah
      case 0x1ede: m.ww(m.es, ((m.di + 0x6) & 0xffff), m.ax);  // mov word ptr es:[di + 6], ax
      case 0x1ee2: m.si = m.add16(m.si, 0x2);  // add si, 2
      case 0x1ee5: m.di = m.add16(m.di, 0x8);  // add di, 8
      case 0x1ee8: m.ax = (m.ax & 0xff) | (m.rb(m.ds, ((m.si + 0x78) & 0xffff)) << 8);  // mov ah, byte ptr [si + 0x78]
      case 0x1eeb: m.ax = (m.ax & 0xff00) | m.rb(m.ds, ((m.si + 0x79) & 0xffff));  // mov al, byte ptr [si + 0x79]
      case 0x1eee: m.bp = m.ax;  // mov bp, ax
      case 0x1ef0: m.bx = (m.bx & 0xff) | (m.rb(m.ds, ((m.si + 0x50) & 0xffff)) << 8);  // mov bh, byte ptr [si + 0x50]
      case 0x1ef3: m.bx = (m.bx & 0xff00) | m.rb(m.ds, ((m.si + 0x51) & 0xffff));  // mov bl, byte ptr [si + 0x51]
      case 0x1ef6: m.cx = (m.cx & 0xff) | (m.rb(m.ds, ((m.si + 0x28) & 0xffff)) << 8);  // mov ch, byte ptr [si + 0x28]
      case 0x1ef9: m.cx = (m.cx & 0xff00) | m.rb(m.ds, ((m.si + 0x29) & 0xffff));  // mov cl, byte ptr [si + 0x29]
      case 0x1efc: m.dx = (m.dx & 0xff) | (m.rb(m.ds, m.si) << 8);  // mov dh, byte ptr [si]
      case 0x1efe: m.dx = (m.dx & 0xff00) | m.rb(m.ds, ((m.si + 0x1) & 0xffff));  // mov dl, byte ptr [si + 1]
      case 0x1f01: m.ax = 0x0;  // mov ax, 0
      case 0x1f04: m.dx = m.shl16(m.dx, 0x1);  // shl dx, 1
      case 0x1f06: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1f08: m.cx = m.shl16(m.cx, 0x1);  // shl cx, 1
      case 0x1f0a: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1f0c: m.bx = m.shl16(m.bx, 0x1);  // shl bx, 1
      case 0x1f0e: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1f10: m.bp = m.shl16(m.bp, 0x1);  // shl bp, 1
      case 0x1f12: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1f14: m.dx = m.shl16(m.dx, 0x1);  // shl dx, 1
      case 0x1f16: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1f18: m.cx = m.shl16(m.cx, 0x1);  // shl cx, 1
      case 0x1f1a: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1f1c: m.bx = m.shl16(m.bx, 0x1);  // shl bx, 1
      case 0x1f1e: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1f20: m.bp = m.shl16(m.bp, 0x1);  // shl bp, 1
      case 0x1f22: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1f24: m.dx = m.shl16(m.dx, 0x1);  // shl dx, 1
      case 0x1f26: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1f28: m.cx = m.shl16(m.cx, 0x1);  // shl cx, 1
      case 0x1f2a: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1f2c: m.bx = m.shl16(m.bx, 0x1);  // shl bx, 1
      case 0x1f2e: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1f30: m.bp = m.shl16(m.bp, 0x1);  // shl bp, 1
      case 0x1f32: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1f34: m.dx = m.shl16(m.dx, 0x1);  // shl dx, 1
      case 0x1f36: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1f38: m.cx = m.shl16(m.cx, 0x1);  // shl cx, 1
      case 0x1f3a: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1f3c: m.bx = m.shl16(m.bx, 0x1);  // shl bx, 1
      case 0x1f3e: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1f40: m.bp = m.shl16(m.bp, 0x1);  // shl bp, 1
      case 0x1f42: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1f44: { const t = (m.ax & 0xff); m.ax = (m.ax & 0xff00) | (m.ax >> 8); m.ax = (m.ax & 0xff) | (t << 8); }  // xchg al, ah
      case 0x1f46: m.ww(m.es, m.di, m.ax);  // mov word ptr es:[di], ax
      case 0x1f49: m.dx = m.shl16(m.dx, 0x1);  // shl dx, 1
      case 0x1f4b: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1f4d: m.cx = m.shl16(m.cx, 0x1);  // shl cx, 1
      case 0x1f4f: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1f51: m.bx = m.shl16(m.bx, 0x1);  // shl bx, 1
      case 0x1f53: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1f55: m.bp = m.shl16(m.bp, 0x1);  // shl bp, 1
      case 0x1f57: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1f59: m.dx = m.shl16(m.dx, 0x1);  // shl dx, 1
      case 0x1f5b: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1f5d: m.cx = m.shl16(m.cx, 0x1);  // shl cx, 1
      case 0x1f5f: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1f61: m.bx = m.shl16(m.bx, 0x1);  // shl bx, 1
      case 0x1f63: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1f65: m.bp = m.shl16(m.bp, 0x1);  // shl bp, 1
      case 0x1f67: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1f69: m.dx = m.shl16(m.dx, 0x1);  // shl dx, 1
      case 0x1f6b: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1f6d: m.cx = m.shl16(m.cx, 0x1);  // shl cx, 1
      case 0x1f6f: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1f71: m.bx = m.shl16(m.bx, 0x1);  // shl bx, 1
      case 0x1f73: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1f75: m.bp = m.shl16(m.bp, 0x1);  // shl bp, 1
      case 0x1f77: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1f79: m.dx = m.shl16(m.dx, 0x1);  // shl dx, 1
      case 0x1f7b: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1f7d: m.cx = m.shl16(m.cx, 0x1);  // shl cx, 1
      case 0x1f7f: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1f81: m.bx = m.shl16(m.bx, 0x1);  // shl bx, 1
      case 0x1f83: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1f85: m.bp = m.shl16(m.bp, 0x1);  // shl bp, 1
      case 0x1f87: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1f89: { const t = (m.ax & 0xff); m.ax = (m.ax & 0xff00) | (m.ax >> 8); m.ax = (m.ax & 0xff) | (t << 8); }  // xchg al, ah
      case 0x1f8b: m.ww(m.es, ((m.di + 0x2) & 0xffff), m.ax);  // mov word ptr es:[di + 2], ax
      case 0x1f8f: m.dx = m.shl16(m.dx, 0x1);  // shl dx, 1
      case 0x1f91: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1f93: m.cx = m.shl16(m.cx, 0x1);  // shl cx, 1
      case 0x1f95: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1f97: m.bx = m.shl16(m.bx, 0x1);  // shl bx, 1
      case 0x1f99: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1f9b: m.bp = m.shl16(m.bp, 0x1);  // shl bp, 1
      case 0x1f9d: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1f9f: m.dx = m.shl16(m.dx, 0x1);  // shl dx, 1
      case 0x1fa1: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1fa3: m.cx = m.shl16(m.cx, 0x1);  // shl cx, 1
      case 0x1fa5: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1fa7: m.bx = m.shl16(m.bx, 0x1);  // shl bx, 1
      case 0x1fa9: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1fab: m.bp = m.shl16(m.bp, 0x1);  // shl bp, 1
      case 0x1fad: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1faf: m.dx = m.shl16(m.dx, 0x1);  // shl dx, 1
      case 0x1fb1: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1fb3: m.cx = m.shl16(m.cx, 0x1);  // shl cx, 1
      case 0x1fb5: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1fb7: m.bx = m.shl16(m.bx, 0x1);  // shl bx, 1
      case 0x1fb9: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1fbb: m.bp = m.shl16(m.bp, 0x1);  // shl bp, 1
      case 0x1fbd: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1fbf: m.dx = m.shl16(m.dx, 0x1);  // shl dx, 1
      case 0x1fc1: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1fc3: m.cx = m.shl16(m.cx, 0x1);  // shl cx, 1
      case 0x1fc5: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1fc7: m.bx = m.shl16(m.bx, 0x1);  // shl bx, 1
      case 0x1fc9: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1fcb: m.bp = m.shl16(m.bp, 0x1);  // shl bp, 1
      case 0x1fcd: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1fcf: { const t = (m.ax & 0xff); m.ax = (m.ax & 0xff00) | (m.ax >> 8); m.ax = (m.ax & 0xff) | (t << 8); }  // xchg al, ah
      case 0x1fd1: m.ww(m.es, ((m.di + 0x4) & 0xffff), m.ax);  // mov word ptr es:[di + 4], ax
      case 0x1fd5: m.dx = m.shl16(m.dx, 0x1);  // shl dx, 1
      case 0x1fd7: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1fd9: m.cx = m.shl16(m.cx, 0x1);  // shl cx, 1
      case 0x1fdb: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1fdd: m.bx = m.shl16(m.bx, 0x1);  // shl bx, 1
      case 0x1fdf: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1fe1: m.bp = m.shl16(m.bp, 0x1);  // shl bp, 1
      case 0x1fe3: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1fe5: m.dx = m.shl16(m.dx, 0x1);  // shl dx, 1
      case 0x1fe7: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1fe9: m.cx = m.shl16(m.cx, 0x1);  // shl cx, 1
      case 0x1feb: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1fed: m.bx = m.shl16(m.bx, 0x1);  // shl bx, 1
      case 0x1fef: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1ff1: m.bp = m.shl16(m.bp, 0x1);  // shl bp, 1
      case 0x1ff3: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1ff5: m.dx = m.shl16(m.dx, 0x1);  // shl dx, 1
      case 0x1ff7: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1ff9: m.cx = m.shl16(m.cx, 0x1);  // shl cx, 1
      case 0x1ffb: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x1ffd: m.bx = m.shl16(m.bx, 0x1);  // shl bx, 1
      case 0x1fff: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x2001: m.bp = m.shl16(m.bp, 0x1);  // shl bp, 1
      case 0x2003: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x2005: m.dx = m.shl16(m.dx, 0x1);  // shl dx, 1
      case 0x2007: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x2009: m.cx = m.shl16(m.cx, 0x1);  // shl cx, 1
      case 0x200b: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x200d: m.bx = m.shl16(m.bx, 0x1);  // shl bx, 1
      case 0x200f: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x2011: m.bp = m.shl16(m.bp, 0x1);  // shl bp, 1
      case 0x2013: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x2015: { const t = (m.ax & 0xff); m.ax = (m.ax & 0xff00) | (m.ax >> 8); m.ax = (m.ax & 0xff) | (t << 8); }  // xchg al, ah
      case 0x2017: m.ww(m.es, ((m.di + 0x6) & 0xffff), m.ax);  // mov word ptr es:[di + 6], ax
      case 0x201b: m.si = m.add16(m.si, 0x2);  // add si, 2
      case 0x201e: m.di = m.add16(m.di, 0x8);  // add di, 8
      case 0x2021: m.ax = (m.ax & 0xff) | (m.rb(m.ds, ((m.si + 0x78) & 0xffff)) << 8);  // mov ah, byte ptr [si + 0x78]
      case 0x2024: m.ax = (m.ax & 0xff00) | m.rb(m.ds, ((m.si + 0x79) & 0xffff));  // mov al, byte ptr [si + 0x79]
      case 0x2027: m.bp = m.ax;  // mov bp, ax
      case 0x2029: m.bx = (m.bx & 0xff) | (m.rb(m.ds, ((m.si + 0x50) & 0xffff)) << 8);  // mov bh, byte ptr [si + 0x50]
      case 0x202c: m.bx = (m.bx & 0xff00) | m.rb(m.ds, ((m.si + 0x51) & 0xffff));  // mov bl, byte ptr [si + 0x51]
      case 0x202f: m.cx = (m.cx & 0xff) | (m.rb(m.ds, ((m.si + 0x28) & 0xffff)) << 8);  // mov ch, byte ptr [si + 0x28]
      case 0x2032: m.cx = (m.cx & 0xff00) | m.rb(m.ds, ((m.si + 0x29) & 0xffff));  // mov cl, byte ptr [si + 0x29]
      case 0x2035: m.dx = (m.dx & 0xff) | (m.rb(m.ds, m.si) << 8);  // mov dh, byte ptr [si]
      case 0x2037: m.dx = (m.dx & 0xff00) | m.rb(m.ds, ((m.si + 0x1) & 0xffff));  // mov dl, byte ptr [si + 1]
      case 0x203a: m.ax = 0x0;  // mov ax, 0
      case 0x203d: m.dx = m.shl16(m.dx, 0x1);  // shl dx, 1
      case 0x203f: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x2041: m.cx = m.shl16(m.cx, 0x1);  // shl cx, 1
      case 0x2043: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x2045: m.bx = m.shl16(m.bx, 0x1);  // shl bx, 1
      case 0x2047: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x2049: m.bp = m.shl16(m.bp, 0x1);  // shl bp, 1
      case 0x204b: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x204d: m.dx = m.shl16(m.dx, 0x1);  // shl dx, 1
      case 0x204f: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x2051: m.cx = m.shl16(m.cx, 0x1);  // shl cx, 1
      case 0x2053: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x2055: m.bx = m.shl16(m.bx, 0x1);  // shl bx, 1
      case 0x2057: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x2059: m.bp = m.shl16(m.bp, 0x1);  // shl bp, 1
      case 0x205b: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x205d: m.dx = m.shl16(m.dx, 0x1);  // shl dx, 1
      case 0x205f: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x2061: m.cx = m.shl16(m.cx, 0x1);  // shl cx, 1
      case 0x2063: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x2065: m.bx = m.shl16(m.bx, 0x1);  // shl bx, 1
      case 0x2067: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x2069: m.bp = m.shl16(m.bp, 0x1);  // shl bp, 1
      case 0x206b: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x206d: m.dx = m.shl16(m.dx, 0x1);  // shl dx, 1
      case 0x206f: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x2071: m.cx = m.shl16(m.cx, 0x1);  // shl cx, 1
      case 0x2073: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x2075: m.bx = m.shl16(m.bx, 0x1);  // shl bx, 1
      case 0x2077: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x2079: m.bp = m.shl16(m.bp, 0x1);  // shl bp, 1
      case 0x207b: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x207d: { const t = (m.ax & 0xff); m.ax = (m.ax & 0xff00) | (m.ax >> 8); m.ax = (m.ax & 0xff) | (t << 8); }  // xchg al, ah
      case 0x207f: m.ww(m.es, m.di, m.ax);  // mov word ptr es:[di], ax
      case 0x2082: m.dx = m.shl16(m.dx, 0x1);  // shl dx, 1
      case 0x2084: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x2086: m.cx = m.shl16(m.cx, 0x1);  // shl cx, 1
      case 0x2088: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x208a: m.bx = m.shl16(m.bx, 0x1);  // shl bx, 1
      case 0x208c: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x208e: m.bp = m.shl16(m.bp, 0x1);  // shl bp, 1
      case 0x2090: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x2092: m.dx = m.shl16(m.dx, 0x1);  // shl dx, 1
      case 0x2094: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x2096: m.cx = m.shl16(m.cx, 0x1);  // shl cx, 1
      case 0x2098: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x209a: m.bx = m.shl16(m.bx, 0x1);  // shl bx, 1
      case 0x209c: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x209e: m.bp = m.shl16(m.bp, 0x1);  // shl bp, 1
      case 0x20a0: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x20a2: m.dx = m.shl16(m.dx, 0x1);  // shl dx, 1
      case 0x20a4: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x20a6: m.cx = m.shl16(m.cx, 0x1);  // shl cx, 1
      case 0x20a8: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x20aa: m.bx = m.shl16(m.bx, 0x1);  // shl bx, 1
      case 0x20ac: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x20ae: m.bp = m.shl16(m.bp, 0x1);  // shl bp, 1
      case 0x20b0: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x20b2: m.dx = m.shl16(m.dx, 0x1);  // shl dx, 1
      case 0x20b4: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x20b6: m.cx = m.shl16(m.cx, 0x1);  // shl cx, 1
      case 0x20b8: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x20ba: m.bx = m.shl16(m.bx, 0x1);  // shl bx, 1
      case 0x20bc: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x20be: m.bp = m.shl16(m.bp, 0x1);  // shl bp, 1
      case 0x20c0: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x20c2: { const t = (m.ax & 0xff); m.ax = (m.ax & 0xff00) | (m.ax >> 8); m.ax = (m.ax & 0xff) | (t << 8); }  // xchg al, ah
      case 0x20c4: m.ww(m.es, ((m.di + 0x2) & 0xffff), m.ax);  // mov word ptr es:[di + 2], ax
      case 0x20c8: m.dx = m.shl16(m.dx, 0x1);  // shl dx, 1
      case 0x20ca: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x20cc: m.cx = m.shl16(m.cx, 0x1);  // shl cx, 1
      case 0x20ce: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x20d0: m.bx = m.shl16(m.bx, 0x1);  // shl bx, 1
      case 0x20d2: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x20d4: m.bp = m.shl16(m.bp, 0x1);  // shl bp, 1
      case 0x20d6: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x20d8: m.dx = m.shl16(m.dx, 0x1);  // shl dx, 1
      case 0x20da: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x20dc: m.cx = m.shl16(m.cx, 0x1);  // shl cx, 1
      case 0x20de: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x20e0: m.bx = m.shl16(m.bx, 0x1);  // shl bx, 1
      case 0x20e2: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x20e4: m.bp = m.shl16(m.bp, 0x1);  // shl bp, 1
      case 0x20e6: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x20e8: m.dx = m.shl16(m.dx, 0x1);  // shl dx, 1
      case 0x20ea: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x20ec: m.cx = m.shl16(m.cx, 0x1);  // shl cx, 1
      case 0x20ee: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x20f0: m.bx = m.shl16(m.bx, 0x1);  // shl bx, 1
      case 0x20f2: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x20f4: m.bp = m.shl16(m.bp, 0x1);  // shl bp, 1
      case 0x20f6: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x20f8: m.dx = m.shl16(m.dx, 0x1);  // shl dx, 1
      case 0x20fa: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x20fc: m.cx = m.shl16(m.cx, 0x1);  // shl cx, 1
      case 0x20fe: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x2100: m.bx = m.shl16(m.bx, 0x1);  // shl bx, 1
      case 0x2102: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x2104: m.bp = m.shl16(m.bp, 0x1);  // shl bp, 1
      case 0x2106: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x2108: { const t = (m.ax & 0xff); m.ax = (m.ax & 0xff00) | (m.ax >> 8); m.ax = (m.ax & 0xff) | (t << 8); }  // xchg al, ah
      case 0x210a: m.ww(m.es, ((m.di + 0x4) & 0xffff), m.ax);  // mov word ptr es:[di + 4], ax
      case 0x210e: m.dx = m.shl16(m.dx, 0x1);  // shl dx, 1
      case 0x2110: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x2112: m.cx = m.shl16(m.cx, 0x1);  // shl cx, 1
      case 0x2114: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x2116: m.bx = m.shl16(m.bx, 0x1);  // shl bx, 1
      case 0x2118: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x211a: m.bp = m.shl16(m.bp, 0x1);  // shl bp, 1
      case 0x211c: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x211e: m.dx = m.shl16(m.dx, 0x1);  // shl dx, 1
      case 0x2120: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x2122: m.cx = m.shl16(m.cx, 0x1);  // shl cx, 1
      case 0x2124: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x2126: m.bx = m.shl16(m.bx, 0x1);  // shl bx, 1
      case 0x2128: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x212a: m.bp = m.shl16(m.bp, 0x1);  // shl bp, 1
      case 0x212c: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x212e: m.dx = m.shl16(m.dx, 0x1);  // shl dx, 1
      case 0x2130: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x2132: m.cx = m.shl16(m.cx, 0x1);  // shl cx, 1
      case 0x2134: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x2136: m.bx = m.shl16(m.bx, 0x1);  // shl bx, 1
      case 0x2138: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x213a: m.bp = m.shl16(m.bp, 0x1);  // shl bp, 1
      case 0x213c: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x213e: m.dx = m.shl16(m.dx, 0x1);  // shl dx, 1
      case 0x2140: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x2142: m.cx = m.shl16(m.cx, 0x1);  // shl cx, 1
      case 0x2144: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x2146: m.bx = m.shl16(m.bx, 0x1);  // shl bx, 1
      case 0x2148: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x214a: m.bp = m.shl16(m.bp, 0x1);  // shl bp, 1
      case 0x214c: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x214e: { const t = (m.ax & 0xff); m.ax = (m.ax & 0xff00) | (m.ax >> 8); m.ax = (m.ax & 0xff) | (t << 8); }  // xchg al, ah
      case 0x2150: m.ww(m.es, ((m.di + 0x6) & 0xffff), m.ax);  // mov word ptr es:[di + 6], ax
      case 0x2154: m.si = m.add16(m.si, 0x2);  // add si, 2
      case 0x2157: m.di = m.add16(m.di, 0x8);  // add di, 8
      case 0x215a: m.ax = (m.ax & 0xff) | (m.rb(m.ds, ((m.si + 0x78) & 0xffff)) << 8);  // mov ah, byte ptr [si + 0x78]
      case 0x215d: m.ax = (m.ax & 0xff00) | m.rb(m.ds, ((m.si + 0x79) & 0xffff));  // mov al, byte ptr [si + 0x79]
      case 0x2160: m.bp = m.ax;  // mov bp, ax
      case 0x2162: m.bx = (m.bx & 0xff) | (m.rb(m.ds, ((m.si + 0x50) & 0xffff)) << 8);  // mov bh, byte ptr [si + 0x50]
      case 0x2165: m.bx = (m.bx & 0xff00) | m.rb(m.ds, ((m.si + 0x51) & 0xffff));  // mov bl, byte ptr [si + 0x51]
      case 0x2168: m.cx = (m.cx & 0xff) | (m.rb(m.ds, ((m.si + 0x28) & 0xffff)) << 8);  // mov ch, byte ptr [si + 0x28]
      case 0x216b: m.cx = (m.cx & 0xff00) | m.rb(m.ds, ((m.si + 0x29) & 0xffff));  // mov cl, byte ptr [si + 0x29]
      case 0x216e: m.dx = (m.dx & 0xff) | (m.rb(m.ds, m.si) << 8);  // mov dh, byte ptr [si]
      case 0x2170: m.dx = (m.dx & 0xff00) | m.rb(m.ds, ((m.si + 0x1) & 0xffff));  // mov dl, byte ptr [si + 1]
      case 0x2173: m.ax = 0x0;  // mov ax, 0
      case 0x2176: m.dx = m.shl16(m.dx, 0x1);  // shl dx, 1
      case 0x2178: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x217a: m.cx = m.shl16(m.cx, 0x1);  // shl cx, 1
      case 0x217c: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x217e: m.bx = m.shl16(m.bx, 0x1);  // shl bx, 1
      case 0x2180: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x2182: m.bp = m.shl16(m.bp, 0x1);  // shl bp, 1
      case 0x2184: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x2186: m.dx = m.shl16(m.dx, 0x1);  // shl dx, 1
      case 0x2188: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x218a: m.cx = m.shl16(m.cx, 0x1);  // shl cx, 1
      case 0x218c: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x218e: m.bx = m.shl16(m.bx, 0x1);  // shl bx, 1
      case 0x2190: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x2192: m.bp = m.shl16(m.bp, 0x1);  // shl bp, 1
      case 0x2194: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x2196: m.dx = m.shl16(m.dx, 0x1);  // shl dx, 1
      case 0x2198: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x219a: m.cx = m.shl16(m.cx, 0x1);  // shl cx, 1
      case 0x219c: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x219e: m.bx = m.shl16(m.bx, 0x1);  // shl bx, 1
      case 0x21a0: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x21a2: m.bp = m.shl16(m.bp, 0x1);  // shl bp, 1
      case 0x21a4: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x21a6: m.dx = m.shl16(m.dx, 0x1);  // shl dx, 1
      case 0x21a8: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x21aa: m.cx = m.shl16(m.cx, 0x1);  // shl cx, 1
      case 0x21ac: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x21ae: m.bx = m.shl16(m.bx, 0x1);  // shl bx, 1
      case 0x21b0: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x21b2: m.bp = m.shl16(m.bp, 0x1);  // shl bp, 1
      case 0x21b4: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x21b6: { const t = (m.ax & 0xff); m.ax = (m.ax & 0xff00) | (m.ax >> 8); m.ax = (m.ax & 0xff) | (t << 8); }  // xchg al, ah
      case 0x21b8: m.ww(m.es, m.di, m.ax);  // mov word ptr es:[di], ax
      case 0x21bb: m.dx = m.shl16(m.dx, 0x1);  // shl dx, 1
      case 0x21bd: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x21bf: m.cx = m.shl16(m.cx, 0x1);  // shl cx, 1
      case 0x21c1: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x21c3: m.bx = m.shl16(m.bx, 0x1);  // shl bx, 1
      case 0x21c5: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x21c7: m.bp = m.shl16(m.bp, 0x1);  // shl bp, 1
      case 0x21c9: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x21cb: m.dx = m.shl16(m.dx, 0x1);  // shl dx, 1
      case 0x21cd: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x21cf: m.cx = m.shl16(m.cx, 0x1);  // shl cx, 1
      case 0x21d1: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x21d3: m.bx = m.shl16(m.bx, 0x1);  // shl bx, 1
      case 0x21d5: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x21d7: m.bp = m.shl16(m.bp, 0x1);  // shl bp, 1
      case 0x21d9: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x21db: m.dx = m.shl16(m.dx, 0x1);  // shl dx, 1
      case 0x21dd: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x21df: m.cx = m.shl16(m.cx, 0x1);  // shl cx, 1
      case 0x21e1: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x21e3: m.bx = m.shl16(m.bx, 0x1);  // shl bx, 1
      case 0x21e5: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x21e7: m.bp = m.shl16(m.bp, 0x1);  // shl bp, 1
      case 0x21e9: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x21eb: m.dx = m.shl16(m.dx, 0x1);  // shl dx, 1
      case 0x21ed: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x21ef: m.cx = m.shl16(m.cx, 0x1);  // shl cx, 1
      case 0x21f1: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x21f3: m.bx = m.shl16(m.bx, 0x1);  // shl bx, 1
      case 0x21f5: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x21f7: m.bp = m.shl16(m.bp, 0x1);  // shl bp, 1
      case 0x21f9: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x21fb: { const t = (m.ax & 0xff); m.ax = (m.ax & 0xff00) | (m.ax >> 8); m.ax = (m.ax & 0xff) | (t << 8); }  // xchg al, ah
      case 0x21fd: m.ww(m.es, ((m.di + 0x2) & 0xffff), m.ax);  // mov word ptr es:[di + 2], ax
      case 0x2201: m.dx = m.shl16(m.dx, 0x1);  // shl dx, 1
      case 0x2203: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x2205: m.cx = m.shl16(m.cx, 0x1);  // shl cx, 1
      case 0x2207: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x2209: m.bx = m.shl16(m.bx, 0x1);  // shl bx, 1
      case 0x220b: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x220d: m.bp = m.shl16(m.bp, 0x1);  // shl bp, 1
      case 0x220f: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x2211: m.dx = m.shl16(m.dx, 0x1);  // shl dx, 1
      case 0x2213: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x2215: m.cx = m.shl16(m.cx, 0x1);  // shl cx, 1
      case 0x2217: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x2219: m.bx = m.shl16(m.bx, 0x1);  // shl bx, 1
      case 0x221b: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x221d: m.bp = m.shl16(m.bp, 0x1);  // shl bp, 1
      case 0x221f: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x2221: m.dx = m.shl16(m.dx, 0x1);  // shl dx, 1
      case 0x2223: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x2225: m.cx = m.shl16(m.cx, 0x1);  // shl cx, 1
      case 0x2227: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x2229: m.bx = m.shl16(m.bx, 0x1);  // shl bx, 1
      case 0x222b: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x222d: m.bp = m.shl16(m.bp, 0x1);  // shl bp, 1
      case 0x222f: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x2231: m.dx = m.shl16(m.dx, 0x1);  // shl dx, 1
      case 0x2233: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x2235: m.cx = m.shl16(m.cx, 0x1);  // shl cx, 1
      case 0x2237: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x2239: m.bx = m.shl16(m.bx, 0x1);  // shl bx, 1
      case 0x223b: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x223d: m.bp = m.shl16(m.bp, 0x1);  // shl bp, 1
      case 0x223f: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x2241: { const t = (m.ax & 0xff); m.ax = (m.ax & 0xff00) | (m.ax >> 8); m.ax = (m.ax & 0xff) | (t << 8); }  // xchg al, ah
      case 0x2243: m.ww(m.es, ((m.di + 0x4) & 0xffff), m.ax);  // mov word ptr es:[di + 4], ax
      case 0x2247: m.dx = m.shl16(m.dx, 0x1);  // shl dx, 1
      case 0x2249: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x224b: m.cx = m.shl16(m.cx, 0x1);  // shl cx, 1
      case 0x224d: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x224f: m.bx = m.shl16(m.bx, 0x1);  // shl bx, 1
      case 0x2251: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x2253: m.bp = m.shl16(m.bp, 0x1);  // shl bp, 1
      case 0x2255: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x2257: m.dx = m.shl16(m.dx, 0x1);  // shl dx, 1
      case 0x2259: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x225b: m.cx = m.shl16(m.cx, 0x1);  // shl cx, 1
      case 0x225d: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x225f: m.bx = m.shl16(m.bx, 0x1);  // shl bx, 1
      case 0x2261: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x2263: m.bp = m.shl16(m.bp, 0x1);  // shl bp, 1
      case 0x2265: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x2267: m.dx = m.shl16(m.dx, 0x1);  // shl dx, 1
      case 0x2269: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x226b: m.cx = m.shl16(m.cx, 0x1);  // shl cx, 1
      case 0x226d: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x226f: m.bx = m.shl16(m.bx, 0x1);  // shl bx, 1
      case 0x2271: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x2273: m.bp = m.shl16(m.bp, 0x1);  // shl bp, 1
      case 0x2275: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x2277: m.dx = m.shl16(m.dx, 0x1);  // shl dx, 1
      case 0x2279: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x227b: m.cx = m.shl16(m.cx, 0x1);  // shl cx, 1
      case 0x227d: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x227f: m.bx = m.shl16(m.bx, 0x1);  // shl bx, 1
      case 0x2281: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x2283: m.bp = m.shl16(m.bp, 0x1);  // shl bp, 1
      case 0x2285: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x2287: { const t = (m.ax & 0xff); m.ax = (m.ax & 0xff00) | (m.ax >> 8); m.ax = (m.ax & 0xff) | (t << 8); }  // xchg al, ah
      case 0x2289: m.ww(m.es, ((m.di + 0x6) & 0xffff), m.ax);  // mov word ptr es:[di + 6], ax
      case 0x228d: m.si = m.add16(m.si, 0x2);  // add si, 2
      case 0x2290: m.di = m.add16(m.di, 0x8);  // add di, 8
      case 0x2293: m.ax = (m.ax & 0xff) | (m.rb(m.ds, ((m.si + 0x78) & 0xffff)) << 8);  // mov ah, byte ptr [si + 0x78]
      case 0x2296: m.ax = (m.ax & 0xff00) | m.rb(m.ds, ((m.si + 0x79) & 0xffff));  // mov al, byte ptr [si + 0x79]
      case 0x2299: m.bp = m.ax;  // mov bp, ax
      case 0x229b: m.bx = (m.bx & 0xff) | (m.rb(m.ds, ((m.si + 0x50) & 0xffff)) << 8);  // mov bh, byte ptr [si + 0x50]
      case 0x229e: m.bx = (m.bx & 0xff00) | m.rb(m.ds, ((m.si + 0x51) & 0xffff));  // mov bl, byte ptr [si + 0x51]
      case 0x22a1: m.cx = (m.cx & 0xff) | (m.rb(m.ds, ((m.si + 0x28) & 0xffff)) << 8);  // mov ch, byte ptr [si + 0x28]
      case 0x22a4: m.cx = (m.cx & 0xff00) | m.rb(m.ds, ((m.si + 0x29) & 0xffff));  // mov cl, byte ptr [si + 0x29]
      case 0x22a7: m.dx = (m.dx & 0xff) | (m.rb(m.ds, m.si) << 8);  // mov dh, byte ptr [si]
      case 0x22a9: m.dx = (m.dx & 0xff00) | m.rb(m.ds, ((m.si + 0x1) & 0xffff));  // mov dl, byte ptr [si + 1]
      case 0x22ac: m.ax = 0x0;  // mov ax, 0
      case 0x22af: m.dx = m.shl16(m.dx, 0x1);  // shl dx, 1
      case 0x22b1: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x22b3: m.cx = m.shl16(m.cx, 0x1);  // shl cx, 1
      case 0x22b5: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x22b7: m.bx = m.shl16(m.bx, 0x1);  // shl bx, 1
      case 0x22b9: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x22bb: m.bp = m.shl16(m.bp, 0x1);  // shl bp, 1
      case 0x22bd: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x22bf: m.dx = m.shl16(m.dx, 0x1);  // shl dx, 1
      case 0x22c1: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x22c3: m.cx = m.shl16(m.cx, 0x1);  // shl cx, 1
      case 0x22c5: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x22c7: m.bx = m.shl16(m.bx, 0x1);  // shl bx, 1
      case 0x22c9: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x22cb: m.bp = m.shl16(m.bp, 0x1);  // shl bp, 1
      case 0x22cd: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x22cf: m.dx = m.shl16(m.dx, 0x1);  // shl dx, 1
      case 0x22d1: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x22d3: m.cx = m.shl16(m.cx, 0x1);  // shl cx, 1
      case 0x22d5: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x22d7: m.bx = m.shl16(m.bx, 0x1);  // shl bx, 1
      case 0x22d9: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x22db: m.bp = m.shl16(m.bp, 0x1);  // shl bp, 1
      case 0x22dd: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x22df: m.dx = m.shl16(m.dx, 0x1);  // shl dx, 1
      case 0x22e1: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x22e3: m.cx = m.shl16(m.cx, 0x1);  // shl cx, 1
      case 0x22e5: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x22e7: m.bx = m.shl16(m.bx, 0x1);  // shl bx, 1
      case 0x22e9: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x22eb: m.bp = m.shl16(m.bp, 0x1);  // shl bp, 1
      case 0x22ed: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x22ef: { const t = (m.ax & 0xff); m.ax = (m.ax & 0xff00) | (m.ax >> 8); m.ax = (m.ax & 0xff) | (t << 8); }  // xchg al, ah
      case 0x22f1: m.ww(m.es, m.di, m.ax);  // mov word ptr es:[di], ax
      case 0x22f4: m.dx = m.shl16(m.dx, 0x1);  // shl dx, 1
      case 0x22f6: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x22f8: m.cx = m.shl16(m.cx, 0x1);  // shl cx, 1
      case 0x22fa: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x22fc: m.bx = m.shl16(m.bx, 0x1);  // shl bx, 1
      case 0x22fe: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x2300: m.bp = m.shl16(m.bp, 0x1);  // shl bp, 1
      case 0x2302: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x2304: m.dx = m.shl16(m.dx, 0x1);  // shl dx, 1
      case 0x2306: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x2308: m.cx = m.shl16(m.cx, 0x1);  // shl cx, 1
      case 0x230a: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x230c: m.bx = m.shl16(m.bx, 0x1);  // shl bx, 1
      case 0x230e: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x2310: m.bp = m.shl16(m.bp, 0x1);  // shl bp, 1
      case 0x2312: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x2314: m.dx = m.shl16(m.dx, 0x1);  // shl dx, 1
      case 0x2316: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x2318: m.cx = m.shl16(m.cx, 0x1);  // shl cx, 1
      case 0x231a: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x231c: m.bx = m.shl16(m.bx, 0x1);  // shl bx, 1
      case 0x231e: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x2320: m.bp = m.shl16(m.bp, 0x1);  // shl bp, 1
      case 0x2322: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x2324: m.dx = m.shl16(m.dx, 0x1);  // shl dx, 1
      case 0x2326: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x2328: m.cx = m.shl16(m.cx, 0x1);  // shl cx, 1
      case 0x232a: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x232c: m.bx = m.shl16(m.bx, 0x1);  // shl bx, 1
      case 0x232e: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x2330: m.bp = m.shl16(m.bp, 0x1);  // shl bp, 1
      case 0x2332: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x2334: { const t = (m.ax & 0xff); m.ax = (m.ax & 0xff00) | (m.ax >> 8); m.ax = (m.ax & 0xff) | (t << 8); }  // xchg al, ah
      case 0x2336: m.ww(m.es, ((m.di + 0x2) & 0xffff), m.ax);  // mov word ptr es:[di + 2], ax
      case 0x233a: m.dx = m.shl16(m.dx, 0x1);  // shl dx, 1
      case 0x233c: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x233e: m.cx = m.shl16(m.cx, 0x1);  // shl cx, 1
      case 0x2340: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x2342: m.bx = m.shl16(m.bx, 0x1);  // shl bx, 1
      case 0x2344: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x2346: m.bp = m.shl16(m.bp, 0x1);  // shl bp, 1
      case 0x2348: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x234a: m.dx = m.shl16(m.dx, 0x1);  // shl dx, 1
      case 0x234c: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x234e: m.cx = m.shl16(m.cx, 0x1);  // shl cx, 1
      case 0x2350: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x2352: m.bx = m.shl16(m.bx, 0x1);  // shl bx, 1
      case 0x2354: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x2356: m.bp = m.shl16(m.bp, 0x1);  // shl bp, 1
      case 0x2358: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x235a: m.dx = m.shl16(m.dx, 0x1);  // shl dx, 1
      case 0x235c: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x235e: m.cx = m.shl16(m.cx, 0x1);  // shl cx, 1
      case 0x2360: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x2362: m.bx = m.shl16(m.bx, 0x1);  // shl bx, 1
      case 0x2364: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x2366: m.bp = m.shl16(m.bp, 0x1);  // shl bp, 1
      case 0x2368: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x236a: m.dx = m.shl16(m.dx, 0x1);  // shl dx, 1
      case 0x236c: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x236e: m.cx = m.shl16(m.cx, 0x1);  // shl cx, 1
      case 0x2370: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x2372: m.bx = m.shl16(m.bx, 0x1);  // shl bx, 1
      case 0x2374: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x2376: m.bp = m.shl16(m.bp, 0x1);  // shl bp, 1
      case 0x2378: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x237a: { const t = (m.ax & 0xff); m.ax = (m.ax & 0xff00) | (m.ax >> 8); m.ax = (m.ax & 0xff) | (t << 8); }  // xchg al, ah
      case 0x237c: m.ww(m.es, ((m.di + 0x4) & 0xffff), m.ax);  // mov word ptr es:[di + 4], ax
      case 0x2380: m.dx = m.shl16(m.dx, 0x1);  // shl dx, 1
      case 0x2382: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x2384: m.cx = m.shl16(m.cx, 0x1);  // shl cx, 1
      case 0x2386: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x2388: m.bx = m.shl16(m.bx, 0x1);  // shl bx, 1
      case 0x238a: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x238c: m.bp = m.shl16(m.bp, 0x1);  // shl bp, 1
      case 0x238e: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x2390: m.dx = m.shl16(m.dx, 0x1);  // shl dx, 1
      case 0x2392: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x2394: m.cx = m.shl16(m.cx, 0x1);  // shl cx, 1
      case 0x2396: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x2398: m.bx = m.shl16(m.bx, 0x1);  // shl bx, 1
      case 0x239a: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x239c: m.bp = m.shl16(m.bp, 0x1);  // shl bp, 1
      case 0x239e: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x23a0: m.dx = m.shl16(m.dx, 0x1);  // shl dx, 1
      case 0x23a2: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x23a4: m.cx = m.shl16(m.cx, 0x1);  // shl cx, 1
      case 0x23a6: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x23a8: m.bx = m.shl16(m.bx, 0x1);  // shl bx, 1
      case 0x23aa: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x23ac: m.bp = m.shl16(m.bp, 0x1);  // shl bp, 1
      case 0x23ae: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x23b0: m.dx = m.shl16(m.dx, 0x1);  // shl dx, 1
      case 0x23b2: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x23b4: m.cx = m.shl16(m.cx, 0x1);  // shl cx, 1
      case 0x23b6: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x23b8: m.bx = m.shl16(m.bx, 0x1);  // shl bx, 1
      case 0x23ba: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x23bc: m.bp = m.shl16(m.bp, 0x1);  // shl bp, 1
      case 0x23be: m.ax = m.rcl16(m.ax, 0x1);  // rcl ax, 1
      case 0x23c0: { const t = (m.ax & 0xff); m.ax = (m.ax & 0xff00) | (m.ax >> 8); m.ax = (m.ax & 0xff) | (t << 8); }  // xchg al, ah
      case 0x23c2: m.ww(m.es, ((m.di + 0x6) & 0xffff), m.ax);  // mov word ptr es:[di + 6], ax
      case 0x23c6: m.si = m.add16(m.si, 0x2);  // add si, 2
      case 0x23c9: m.di = m.add16(m.di, 0x8);  // add di, 8
      case 0x23cc: m.di = m.add16(m.di, 0x1f60);  // add di, 0x1f60
      case 0x23d0: m.and16(m.di, 0x8000);  // test di, 0x8000
      case 0x23d4: if (m.zf) { ip = 0x23da; continue; }  // je 0x23da
      case 0x23d6: m.t += 1; m.pas -= 1; m.di = m.sub16(m.di, 0x7f60);  // sub di, 0x7f60
      case 0x23da: m.t += 3; m.pas -= 3; m.si = m.add16(m.si, 0x78);  // add si, 0x78
      case 0x23dd: m.ww(m.cs, 0x23ef, m.dec16(m.rw(m.cs, 0x23ef)));  // dec word ptr cs:[0x23ef]
      case 0x23e2: if (m.zf) { ip = 0x23e7; continue; }  // je 0x23e7
      case 0x23e4: m.t += 1; m.pas -= 1; ip = 0x0b58; continue;  // jmp 0xb58
      case 0x23e7: m.t += 5; m.pas -= 5; m.push(m.ax);  // push ax
      case 0x23e8: m.ax = ((0x0 + m.L) & 0xffff);  // mov ax, 0
      case 0x23eb: m.ds = m.ax;  // mov ds, ax
      case 0x23ed: { const t = m.pop(); m.ax = t; }  // pop ax
      case 0x23ee: ip = m.pop(); continue;  // ret
      default: return ip;
    }
  }
}

// 0x258c sub_6a3c
function sub_258c_258c(m, ip) {
  for (;;) {
    if (m.pas <= 0) return ip;
    switch (ip) {
      case 0x258c: m.t += 3; m.pas -= 3; m.ax = (m.ax & 0xff00) | m.rb(m.ds, m.bp);  // mov al, byte ptr ds:[bp]
      case 0x2590: m.ax = (m.ax & 0xff00) | m.and8((m.ax & 0xff), (m.ax & 0xff));  // and al, al
      case 0x2592: if (!m.zf) { ip = 0x2595; continue; }  // jne 0x2595
      case 0x2594: m.t += 1; m.pas -= 1; ip = m.pop(); continue;  // ret
      case 0x2595: m.t += 1; m.pas -= 1; m.push(0x2598); ip = 0x259b; continue;  // call 0x259b
      case 0x2598: m.t += 2; m.pas -= 2; m.bp = m.inc16(m.bp);  // inc bp
      case 0x2599: ip = 0x258c; continue;  // jmp 0x258c
      default: return ip;
    }
  }
}

// 0x259b sub_6a4b
function sub_259b_259b(m, ip) {
  for (;;) {
    if (m.pas <= 0) return ip;
    switch (ip) {
      case 0x259b: m.t += 2; m.pas -= 2; m.sub8((m.ax & 0xff), 0x1);  // cmp al, 1
      case 0x259d: if (m.zf) { ip = 0x25a8; continue; }  // je 0x25a8
      case 0x259f: m.t += 3; m.pas -= 3; m.bx = 0x19dc;  // mov bx, 0x19dc
      case 0x25a2: m.bx = m.add16(m.bx, m.rw(m.ds, 0x1440));  // add bx, word ptr [0x1440]
      case 0x25a6: ip = m.rw(m.ds, m.bx); continue;  // jmp word ptr [bx]
      case 0x25a8: m.t += 4; m.pas -= 4; m.ax = m.rw(m.ds, ((m.bp + 0x1) & 0xffff));  // mov ax, word ptr ds:[bp + 1]
      case 0x25ac: m.ww(m.ds, 0x19f8, m.ax);  // mov word ptr [0x19f8], ax
      case 0x25af: m.bp = m.add16(m.bp, 0x2);  // add bp, 2
      case 0x25b2: ip = m.pop(); continue;  // ret
      case 0x25b3: m.t += 2; m.pas -= 2; m.sub8((m.ax & 0xff), 0x10);  // cmp al, 0x10
      case 0x25b5: if (!m.zf) { ip = 0x25ba; continue; }  // jne 0x25ba
      case 0x25b7: m.t += 1; m.pas -= 1; ip = 0x26d8; continue;  // jmp 0x26d8
      case 0x25ba: m.t += 2; m.pas -= 2; m.sub8((m.ax & 0xff), 0x11);  // cmp al, 0x11
      case 0x25bc: if (!m.zf) { ip = 0x25c1; continue; }  // jne 0x25c1
      case 0x25be: m.t += 1; m.pas -= 1; ip = 0x2972; continue;  // jmp 0x2972
      case 0x25c1: m.t += 2; m.pas -= 2; m.sub8((m.ax & 0xff), 0x12);  // cmp al, 0x12
      case 0x25c3: if (!m.zf) { ip = 0x25c8; continue; }  // jne 0x25c8
      case 0x25c5: m.t += 1; m.pas -= 1; ip = 0x2986; continue;  // jmp 0x2986
      case 0x25c8: m.t += 10; m.pas -= 10; m.push(m.ax);  // push ax
      case 0x25c9: m.bx = 0x1a21;  // mov bx, 0x1a21
      case 0x25cc: m.ax = (m.ax & 0xff00) | m.rb(m.ds, 0x19f2);  // mov al, byte ptr [0x19f2]
      case 0x25cf: m.ax = (m.ax & 0xff00) | m.rb(m.ds, (m.bx + (m.ax & 0xff)) & 0xffff);  // xlatb
      case 0x25d0: m.dx = (m.dx & 0xff00) | (m.ax & 0xff);  // mov dl, al
      case 0x25d2: m.ax = (m.ax & 0xff00) | m.rb(m.ds, 0x19f3);  // mov al, byte ptr [0x19f3]
      case 0x25d5: m.ax = (m.ax & 0xff00) | m.rb(m.ds, (m.bx + (m.ax & 0xff)) & 0xffff);  // xlatb
      case 0x25d6: m.dx = (m.dx & 0xff) | ((m.ax & 0xff) << 8);  // mov dh, al
      case 0x25d8: m.sub8(m.rb(m.ds, 0x19fb), 0x1);  // cmp byte ptr [0x19fb], 1
      case 0x25dd: if (!m.zf) { ip = 0x25e1; continue; }  // jne 0x25e1
      case 0x25df: m.t += 1; m.pas -= 1; m.dx = (m.dx & 0xff) | (0x0 << 8);  // mov dh, 0
      case 0x25e1: m.t += 10; m.pas -= 10; { const t = m.pop(); m.ax = t; }  // pop ax
      case 0x25e2: m.push(m.bp);  // push bp
      case 0x25e3: m.xor8(0, 0); m.ax = (m.ax & 0xff) | (0 << 8);  // xor ah, ah
      case 0x25e5: m.ax = m.shl16(m.ax, 0x1);  // shl ax, 1
      case 0x25e7: m.ax = m.shl16(m.ax, 0x1);  // shl ax, 1
      case 0x25e9: m.ax = m.shl16(m.ax, 0x1);  // shl ax, 1
      case 0x25eb: m.ax = m.add16(m.ax, 0x13b5);  // add ax, 0x13b5
      case 0x25ee: m.si = m.ax;  // mov si, ax
      case 0x25f0: m.di = 0x19ff;  // mov di, 0x19ff
      case 0x25f3: m.cx = 0x8;  // mov cx, 8
      case 0x25f6: m.t += 3; m.pas -= 3; m.push(m.cx);  // push cx
      case 0x25f7: m.lodsb(m.ds, 0);  // lodsb al, byte ptr [si]
      case 0x25f8: m.cx = 0x4;  // mov cx, 4
      case 0x25fb: m.t += 3; m.pas -= 3; m.ax = (m.ax & 0xff) | ((m.dx >> 8) << 8);  // mov ah, dh
      case 0x25fd: m.ax = (m.ax & 0xff00) | m.shl8((m.ax & 0xff), 0x1);  // shl al, 1
      case 0x25ff: if (!m.cf) { ip = 0x260b; continue; }  // jae 0x260b
      case 0x2601: m.t += 4; m.pas -= 4; m.ax = (m.ax & 0xff) | (m.and8((m.ax >> 8), 0xf) << 8);  // and ah, 0xf
      case 0x2604: m.bx = (m.bx & 0xff00) | (m.dx & 0xff);  // mov bl, dl
      case 0x2606: m.bx = (m.bx & 0xff00) | m.and8((m.bx & 0xff), 0xf0);  // and bl, 0xf0
      case 0x2609: m.ax = (m.ax & 0xff) | (m.or8((m.ax >> 8), (m.bx & 0xff)) << 8);  // or ah, bl
      case 0x260b: m.t += 2; m.pas -= 2; m.ax = (m.ax & 0xff00) | m.shl8((m.ax & 0xff), 0x1);  // shl al, 1
      case 0x260d: if (!m.cf) { ip = 0x2619; continue; }  // jae 0x2619
      case 0x260f: m.t += 4; m.pas -= 4; m.ax = (m.ax & 0xff) | (m.and8((m.ax >> 8), 0xf0) << 8);  // and ah, 0xf0
      case 0x2612: m.bx = (m.bx & 0xff00) | (m.dx & 0xff);  // mov bl, dl
      case 0x2614: m.bx = (m.bx & 0xff00) | m.and8((m.bx & 0xff), 0xf);  // and bl, 0xf
      case 0x2617: m.ax = (m.ax & 0xff) | (m.or8((m.ax >> 8), (m.bx & 0xff)) << 8);  // or ah, bl
      case 0x2619: m.t += 3; m.pas -= 3; m.wb(m.ds, m.di, (m.ax >> 8));  // mov byte ptr [di], ah
      case 0x261b: m.di = m.inc16(m.di);  // inc di
      case 0x261c: m.cx = (m.cx - 1) & 0xffff; if (m.cx !== 0) { ip = 0x25fb; continue; }  // loop 0x25fb
      case 0x261e: m.t += 2; m.pas -= 2; { const t = m.pop(); m.cx = t; }  // pop cx
      case 0x261f: m.cx = (m.cx - 1) & 0xffff; if (m.cx !== 0) { ip = 0x25f6; continue; }  // loop 0x25f6
      case 0x2621: m.t += 13; m.pas -= 13; m.ax = m.rw(m.ds, 0x19f6);  // mov ax, word ptr [0x19f6]
      case 0x2624: m.xor8(0, 0); m.ax = (m.ax & 0xff) | (0 << 8);  // xor ah, ah
      case 0x2626: m.dx = 0x140;  // mov dx, 0x140
      case 0x2629: m.mul16(m.dx);  // mul dx
      case 0x262b: m.di = m.rw(m.ds, 0x19f4);  // mov di, word ptr [0x19f4]
      case 0x262f: m.di = m.shl16(m.di, 0x1);  // shl di, 1
      case 0x2631: m.di = m.shl16(m.di, 0x1);  // shl di, 1
      case 0x2633: m.di = m.add16(m.di, m.ax);  // add di, ax
      case 0x2635: m.ax = m.rw(m.ds, 0x19f8);  // mov ax, word ptr [0x19f8]
      case 0x2638: m.es = m.ax;  // mov es, ax
      case 0x263a: m.bx = 0x2400;  // mov bx, 0x2400
      case 0x263d: m.si = 0x19ff;  // mov si, 0x19ff
      case 0x2640: m.cx = 0x8;  // mov cx, 8
      case 0x2643: m.t += 3; m.pas -= 3; m.lodsb(m.ds, 0);  // lodsb al, byte ptr [si]
      case 0x2644: m.sub8(m.rb(m.ds, 0x19fb), 0x1);  // cmp byte ptr [0x19fb], 1
      case 0x2649: if (m.zf) { ip = 0x2651; continue; }  // je 0x2651
      case 0x264b: m.t += 2; m.pas -= 2; m.wb(m.es, m.di, (m.ax & 0xff));  // mov byte ptr es:[di], al
      case 0x264e: ip = 0x265b; continue;  // jmp 0x265b
      case 0x2651: m.t += 4; m.pas -= 4; m.ax = (m.ax & 0xff) | ((m.ax & 0xff) << 8);  // mov ah, al
      case 0x2653: m.ax = (m.ax & 0xff00) | m.rb(m.cs, (m.bx + (m.ax & 0xff)) & 0xffff);  // xlatb
      case 0x2655: m.wb(m.es, m.di, m.and8(m.rb(m.es, m.di), (m.ax & 0xff)));  // and byte ptr es:[di], al
      case 0x2658: m.wb(m.es, m.di, m.or8(m.rb(m.es, m.di), (m.ax >> 8)));  // or byte ptr es:[di], ah
      case 0x265b: m.t += 4; m.pas -= 4; m.di = m.inc16(m.di);  // inc di
      case 0x265c: m.lodsb(m.ds, 0);  // lodsb al, byte ptr [si]
      case 0x265d: m.sub8(m.rb(m.ds, 0x19fb), 0x1);  // cmp byte ptr [0x19fb], 1
      case 0x2662: if (m.zf) { ip = 0x266a; continue; }  // je 0x266a
      case 0x2664: m.t += 2; m.pas -= 2; m.wb(m.es, m.di, (m.ax & 0xff));  // mov byte ptr es:[di], al
      case 0x2667: ip = 0x2674; continue;  // jmp 0x2674
      case 0x266a: m.t += 4; m.pas -= 4; m.ax = (m.ax & 0xff) | ((m.ax & 0xff) << 8);  // mov ah, al
      case 0x266c: m.ax = (m.ax & 0xff00) | m.rb(m.cs, (m.bx + (m.ax & 0xff)) & 0xffff);  // xlatb
      case 0x266e: m.wb(m.es, m.di, m.and8(m.rb(m.es, m.di), (m.ax & 0xff)));  // and byte ptr es:[di], al
      case 0x2671: m.wb(m.es, m.di, m.or8(m.rb(m.es, m.di), (m.ax >> 8)));  // or byte ptr es:[di], ah
      case 0x2674: m.t += 4; m.pas -= 4; m.di = m.inc16(m.di);  // inc di
      case 0x2675: m.lodsb(m.ds, 0);  // lodsb al, byte ptr [si]
      case 0x2676: m.sub8(m.rb(m.ds, 0x19fb), 0x1);  // cmp byte ptr [0x19fb], 1
      case 0x267b: if (m.zf) { ip = 0x2683; continue; }  // je 0x2683
      case 0x267d: m.t += 2; m.pas -= 2; m.wb(m.es, m.di, (m.ax & 0xff));  // mov byte ptr es:[di], al
      case 0x2680: ip = 0x268d; continue;  // jmp 0x268d
      case 0x2683: m.t += 4; m.pas -= 4; m.ax = (m.ax & 0xff) | ((m.ax & 0xff) << 8);  // mov ah, al
      case 0x2685: m.ax = (m.ax & 0xff00) | m.rb(m.cs, (m.bx + (m.ax & 0xff)) & 0xffff);  // xlatb
      case 0x2687: m.wb(m.es, m.di, m.and8(m.rb(m.es, m.di), (m.ax & 0xff)));  // and byte ptr es:[di], al
      case 0x268a: m.wb(m.es, m.di, m.or8(m.rb(m.es, m.di), (m.ax >> 8)));  // or byte ptr es:[di], ah
      case 0x268d: m.t += 4; m.pas -= 4; m.di = m.inc16(m.di);  // inc di
      case 0x268e: m.lodsb(m.ds, 0);  // lodsb al, byte ptr [si]
      case 0x268f: m.sub8(m.rb(m.ds, 0x19fb), 0x1);  // cmp byte ptr [0x19fb], 1
      case 0x2694: if (m.zf) { ip = 0x269c; continue; }  // je 0x269c
      case 0x2696: m.t += 2; m.pas -= 2; m.wb(m.es, m.di, (m.ax & 0xff));  // mov byte ptr es:[di], al
      case 0x2699: ip = 0x26a6; continue;  // jmp 0x26a6
      case 0x269c: m.t += 4; m.pas -= 4; m.ax = (m.ax & 0xff) | ((m.ax & 0xff) << 8);  // mov ah, al
      case 0x269e: m.ax = (m.ax & 0xff00) | m.rb(m.cs, (m.bx + (m.ax & 0xff)) & 0xffff);  // xlatb
      case 0x26a0: m.wb(m.es, m.di, m.and8(m.rb(m.es, m.di), (m.ax & 0xff)));  // and byte ptr es:[di], al
      case 0x26a3: m.wb(m.es, m.di, m.or8(m.rb(m.es, m.di), (m.ax >> 8)));  // or byte ptr es:[di], ah
      case 0x26a6: m.t += 4; m.pas -= 4; m.di = m.inc16(m.di);  // inc di
      case 0x26a7: m.di = m.add16(m.di, 0x2000);  // add di, 0x2000
      case 0x26ab: m.and16(m.di, 0x8000);  // test di, 0x8000
      case 0x26af: if (m.zf) { ip = 0x26b5; continue; }  // je 0x26b5
      case 0x26b1: m.t += 1; m.pas -= 1; m.di = m.sub16(m.di, 0x7f60);  // sub di, 0x7f60
      case 0x26b5: m.t += 2; m.pas -= 2; m.di = m.sub16(m.di, 0x4);  // sub di, 4
      case 0x26b8: m.cx = (m.cx - 1) & 0xffff; if (m.cx !== 0) { ip = 0x2643; continue; }  // loop 0x2643
      case 0x26ba: m.t += 7; m.pas -= 7; m.push(m.ax);  // push ax
      case 0x26bb: m.ax = ((0x0 + m.L) & 0xffff);  // mov ax, 0
      case 0x26be: m.ds = m.ax;  // mov ds, ax
      case 0x26c0: { const t = m.pop(); m.ax = t; }  // pop ax
      case 0x26c1: m.ww(m.ds, 0x19f4, m.inc16(m.rw(m.ds, 0x19f4)));  // inc word ptr [0x19f4]
      case 0x26c5: m.sub16(m.rw(m.ds, 0x19f4), 0x28);  // cmp word ptr [0x19f4], 0x28
      case 0x26ca: if (m.cf) { ip = 0x26d6; continue; }  // jb 0x26d6
      case 0x26cc: m.t += 2; m.pas -= 2; m.ww(m.ds, 0x19f4, 0x0);  // mov word ptr [0x19f4], 0
      case 0x26d2: m.ww(m.ds, 0x19f6, m.inc16(m.rw(m.ds, 0x19f6)));  // inc word ptr [0x19f6]
      case 0x26d6: m.t += 2; m.pas -= 2; { const t = m.pop(); m.bp = t; }  // pop bp
      case 0x26d7: ip = m.pop(); continue;  // ret
      case 0x26d8: m.t += 3; m.pas -= 3; m.ax = (m.ax & 0xff00) | m.rb(m.ds, ((m.bp + 0x1) & 0xffff));  // mov al, byte ptr ds:[bp + 1]
      case 0x26dc: m.sub8((m.ax & 0xff), 0x38);  // cmp al, 0x38
      case 0x26de: if (!m.zf) { ip = 0x26e2; continue; }  // jne 0x26e2
      case 0x26e0: m.t += 1; m.pas -= 1; m.ax = (m.ax & 0xff00) | 0x5;  // mov al, 5
      case 0x26e2: m.t += 5; m.pas -= 5; m.wb(m.ds, 0x19f2, (m.ax & 0xff));  // mov byte ptr [0x19f2], al
      case 0x26e5: m.ax = (m.ax & 0xff00) | m.rb(m.ds, ((m.bp + 0x2) & 0xffff));  // mov al, byte ptr ds:[bp + 2]
      case 0x26e9: m.wb(m.ds, 0x19f3, (m.ax & 0xff));  // mov byte ptr [0x19f3], al
      case 0x26ec: m.bp = m.add16(m.bp, 0x2);  // add bp, 2
      case 0x26ef: ip = m.pop(); continue;  // ret
      case 0x26f0: m.t += 2; m.pas -= 2; m.sub8((m.ax & 0xff), 0x10);  // cmp al, 0x10
      case 0x26f2: if (!m.zf) { ip = 0x26f7; continue; }  // jne 0x26f7
      case 0x26f4: m.t += 1; m.pas -= 1; ip = 0x28ba; continue;  // jmp 0x28ba
      case 0x26f7: m.t += 2; m.pas -= 2; m.sub8((m.ax & 0xff), 0x11);  // cmp al, 0x11
      case 0x26f9: if (!m.zf) { ip = 0x26fe; continue; }  // jne 0x26fe
      case 0x26fb: m.t += 1; m.pas -= 1; ip = 0x2890; continue;  // jmp 0x2890
      case 0x26fe: m.t += 2; m.pas -= 2; m.sub8((m.ax & 0xff), 0x12);  // cmp al, 0x12
      case 0x2700: if (!m.zf) { ip = 0x2705; continue; }  // jne 0x2705
      case 0x2702: m.t += 1; m.pas -= 1; ip = 0x28a4; continue;  // jmp 0x28a4
      case 0x2705: m.t += 11; m.pas -= 11; m.push(m.bp);  // push bp
      case 0x2706: m.xor8(0, 0); m.ax = (m.ax & 0xff) | (0 << 8);  // xor ah, ah
      case 0x2708: m.ax = m.shl16(m.ax, 0x1);  // shl ax, 1
      case 0x270a: m.ax = m.shl16(m.ax, 0x1);  // shl ax, 1
      case 0x270c: m.ax = m.shl16(m.ax, 0x1);  // shl ax, 1
      case 0x270e: m.ax = m.add16(m.ax, 0x13b5);  // add ax, 0x13b5
      case 0x2711: m.si = m.ax;  // mov si, ax
      case 0x2713: m.di = 0x19ff;  // mov di, 0x19ff
      case 0x2716: m.bx = (m.bx & 0xff00) | m.rb(m.ds, 0x19f2);  // mov bl, byte ptr [0x19f2]
      case 0x271a: m.bx = (m.bx & 0xff) | (m.rb(m.ds, 0x19f3) << 8);  // mov bh, byte ptr [0x19f3]
      case 0x271e: m.cx = 0x8;  // mov cx, 8
      case 0x2721: m.t += 5; m.pas -= 5; m.push(m.bx);  // push bx
      case 0x2722: m.lodsb(m.ds, 0);  // lodsb al, byte ptr [si]
      case 0x2723: m.xor8(0, 0); m.ax = (m.ax & 0xff) | (0 << 8);  // xor ah, ah
      case 0x2725: m.bx = (m.bx & 0xff00) | m.shr8((m.bx & 0xff), 0x1);  // shr bl, 1
      case 0x2727: if (m.cf) { ip = 0x272b; continue; }  // jb 0x272b
      case 0x2729: m.t += 1; m.pas -= 1; m.wb(m.ds, m.di, (m.ax >> 8));  // mov byte ptr [di], ah
      case 0x272b: m.t += 1; m.pas -= 1; if (!m.cf) { ip = 0x272f; continue; }  // jae 0x272f
      case 0x272d: m.t += 1; m.pas -= 1; m.wb(m.ds, m.di, (m.ax & 0xff));  // mov byte ptr [di], al
      case 0x272f: m.t += 2; m.pas -= 2; m.bx = (m.bx & 0xff00) | m.shr8((m.bx & 0xff), 0x1);  // shr bl, 1
      case 0x2731: if (m.cf) { ip = 0x2736; continue; }  // jb 0x2736
      case 0x2733: m.t += 1; m.pas -= 1; m.wb(m.ds, ((m.di + 0x8) & 0xffff), (m.ax >> 8));  // mov byte ptr [di + 8], ah
      case 0x2736: m.t += 1; m.pas -= 1; if (!m.cf) { ip = 0x273b; continue; }  // jae 0x273b
      case 0x2738: m.t += 1; m.pas -= 1; m.wb(m.ds, ((m.di + 0x8) & 0xffff), (m.ax & 0xff));  // mov byte ptr [di + 8], al
      case 0x273b: m.t += 2; m.pas -= 2; m.bx = (m.bx & 0xff00) | m.shr8((m.bx & 0xff), 0x1);  // shr bl, 1
      case 0x273d: if (m.cf) { ip = 0x2742; continue; }  // jb 0x2742
      case 0x273f: m.t += 1; m.pas -= 1; m.wb(m.ds, ((m.di + 0x10) & 0xffff), (m.ax >> 8));  // mov byte ptr [di + 0x10], ah
      case 0x2742: m.t += 1; m.pas -= 1; if (!m.cf) { ip = 0x2747; continue; }  // jae 0x2747
      case 0x2744: m.t += 1; m.pas -= 1; m.wb(m.ds, ((m.di + 0x10) & 0xffff), (m.ax & 0xff));  // mov byte ptr [di + 0x10], al
      case 0x2747: m.t += 2; m.pas -= 2; m.bx = (m.bx & 0xff00) | m.shr8((m.bx & 0xff), 0x1);  // shr bl, 1
      case 0x2749: if (m.cf) { ip = 0x274e; continue; }  // jb 0x274e
      case 0x274b: m.t += 1; m.pas -= 1; m.wb(m.ds, ((m.di + 0x18) & 0xffff), (m.ax >> 8));  // mov byte ptr [di + 0x18], ah
      case 0x274e: m.t += 1; m.pas -= 1; if (!m.cf) { ip = 0x2753; continue; }  // jae 0x2753
      case 0x2750: m.t += 1; m.pas -= 1; m.wb(m.ds, ((m.di + 0x18) & 0xffff), (m.ax & 0xff));  // mov byte ptr [di + 0x18], al
      case 0x2753: m.t += 3; m.pas -= 3; m.ax = (m.ax & 0xff00) | (~(m.ax & 0xff) & 0xff);  // not al
      case 0x2755: m.sub8(m.rb(m.ds, 0x19fb), 0x0);  // cmp byte ptr [0x19fb], 0
      case 0x275a: if (!m.zf) { ip = 0x2777; continue; }  // jne 0x2777
      case 0x275c: m.t += 2; m.pas -= 2; m.bx = (m.bx & 0xff) | (m.shr8((m.bx >> 8), 0x1) << 8);  // shr bh, 1
      case 0x275e: if (!m.cf) { ip = 0x2762; continue; }  // jae 0x2762
      case 0x2760: m.t += 1; m.pas -= 1; m.wb(m.ds, m.di, m.or8(m.rb(m.ds, m.di), (m.ax & 0xff)));  // or byte ptr [di], al
      case 0x2762: m.t += 2; m.pas -= 2; m.bx = (m.bx & 0xff) | (m.shr8((m.bx >> 8), 0x1) << 8);  // shr bh, 1
      case 0x2764: if (!m.cf) { ip = 0x2769; continue; }  // jae 0x2769
      case 0x2766: m.t += 1; m.pas -= 1; m.wb(m.ds, ((m.di + 0x8) & 0xffff), m.or8(m.rb(m.ds, ((m.di + 0x8) & 0xffff)), (m.ax & 0xff)));  // or byte ptr [di + 8], al
      case 0x2769: m.t += 2; m.pas -= 2; m.bx = (m.bx & 0xff) | (m.shr8((m.bx >> 8), 0x1) << 8);  // shr bh, 1
      case 0x276b: if (!m.cf) { ip = 0x2770; continue; }  // jae 0x2770
      case 0x276d: m.t += 1; m.pas -= 1; m.wb(m.ds, ((m.di + 0x10) & 0xffff), m.or8(m.rb(m.ds, ((m.di + 0x10) & 0xffff)), (m.ax & 0xff)));  // or byte ptr [di + 0x10], al
      case 0x2770: m.t += 2; m.pas -= 2; m.bx = (m.bx & 0xff) | (m.shr8((m.bx >> 8), 0x1) << 8);  // shr bh, 1
      case 0x2772: if (!m.cf) { ip = 0x2777; continue; }  // jae 0x2777
      case 0x2774: m.t += 1; m.pas -= 1; m.wb(m.ds, ((m.di + 0x18) & 0xffff), m.or8(m.rb(m.ds, ((m.di + 0x18) & 0xffff)), (m.ax & 0xff)));  // or byte ptr [di + 0x18], al
      case 0x2777: m.t += 3; m.pas -= 3; { const t = m.pop(); m.bx = t; }  // pop bx
      case 0x2778: m.di = m.inc16(m.di);  // inc di
      case 0x2779: m.cx = (m.cx - 1) & 0xffff; if (m.cx !== 0) { ip = 0x2721; continue; }  // loop 0x2721
      case 0x277b: m.t += 5; m.pas -= 5; m.si = 0x19ff;  // mov si, 0x19ff
      case 0x277e: m.ax = m.rw(m.ds, 0x19f8);  // mov ax, word ptr [0x19f8]
      case 0x2781: m.es = m.ax;  // mov es, ax
      case 0x2783: m.sub16(m.ax, 0xa000);  // cmp ax, 0xa000
      case 0x2786: if (!m.zf) { ip = 0x2802; continue; }  // jne 0x2802
      case 0x2788: m.t += 18; m.pas -= 18; m.ax = m.rw(m.ds, 0x19f6);  // mov ax, word ptr [0x19f6]
      case 0x278b: m.dx = 0x140;  // mov dx, 0x140
      case 0x278e: m.mul16(m.dx);  // mul dx
      case 0x2790: m.ax = m.add16(m.ax, m.rw(m.ds, 0x19f4));  // add ax, word ptr [0x19f4]
      case 0x2794: m.di = m.ax;  // mov di, ax
      case 0x2796: m.dx = 0x3ce;  // mov dx, 0x3ce
      case 0x2799: m.ax = (m.ax & 0xff) | (0x18 << 8);  // mov ah, 0x18
      case 0x279b: m.ax = (m.ax & 0xff00) | 0x3;  // mov al, 3
      case 0x279d: m.sortie(m.dx, m.ax, 2);  // out dx, ax
      case 0x279e: m.ax = 0x805;  // mov ax, 0x805
      case 0x27a1: m.sortie(m.dx, m.ax, 2);  // out dx, ax
      case 0x27a2: m.ax = 0x7;  // mov ax, 7
      case 0x27a5: m.sortie(m.dx, m.ax, 2);  // out dx, ax
      case 0x27a6: m.ax = 0xff08;  // mov ax, 0xff08
      case 0x27a9: m.sortie(m.dx, m.ax, 2);  // out dx, ax
      case 0x27aa: m.dx = (m.dx & 0xff00) | 0xc4;  // mov dl, 0xc4
      case 0x27ac: m.ax = 0x802;  // mov ax, 0x802
      case 0x27af: m.cx = 0x8;  // mov cx, 8
      case 0x27b2: m.t += 21; m.pas -= 21; m.sortie(m.dx, m.ax, 2);  // out dx, ax
      case 0x27b3: m.push(m.ax);  // push ax
      case 0x27b4: m.lodsb(m.ds, 0);  // lodsb al, byte ptr [si]
      case 0x27b5: m.wb(m.es, m.di, (m.ax & 0xff));  // mov byte ptr es:[di], al
      case 0x27b8: m.lodsb(m.ds, 0);  // lodsb al, byte ptr [si]
      case 0x27b9: m.wb(m.es, ((m.di + 0x28) & 0xffff), (m.ax & 0xff));  // mov byte ptr es:[di + 0x28], al
      case 0x27bd: m.lodsb(m.ds, 0);  // lodsb al, byte ptr [si]
      case 0x27be: m.wb(m.es, ((m.di + 0x50) & 0xffff), (m.ax & 0xff));  // mov byte ptr es:[di + 0x50], al
      case 0x27c2: m.lodsb(m.ds, 0);  // lodsb al, byte ptr [si]
      case 0x27c3: m.wb(m.es, ((m.di + 0x78) & 0xffff), (m.ax & 0xff));  // mov byte ptr es:[di + 0x78], al
      case 0x27c7: m.lodsb(m.ds, 0);  // lodsb al, byte ptr [si]
      case 0x27c8: m.wb(m.es, ((m.di + 0xa0) & 0xffff), (m.ax & 0xff));  // mov byte ptr es:[di + 0xa0], al
      case 0x27cd: m.lodsb(m.ds, 0);  // lodsb al, byte ptr [si]
      case 0x27ce: m.wb(m.es, ((m.di + 0xc8) & 0xffff), (m.ax & 0xff));  // mov byte ptr es:[di + 0xc8], al
      case 0x27d3: m.lodsb(m.ds, 0);  // lodsb al, byte ptr [si]
      case 0x27d4: m.wb(m.es, ((m.di + 0xf0) & 0xffff), (m.ax & 0xff));  // mov byte ptr es:[di + 0xf0], al
      case 0x27d9: m.lodsb(m.ds, 0);  // lodsb al, byte ptr [si]
      case 0x27da: m.wb(m.es, ((m.di + 0x118) & 0xffff), (m.ax & 0xff));  // mov byte ptr es:[di + 0x118], al
      case 0x27df: { const t = m.pop(); m.ax = t; }  // pop ax
      case 0x27e0: m.ax = (m.ax & 0xff) | (m.shr8((m.ax >> 8), 0x1) << 8);  // shr ah, 1
      case 0x27e2: m.cx = (m.cx - 1) & 0xffff; if (m.cx !== 0) { ip = 0x27b2; continue; }  // loop 0x27b2
      case 0x27e4: m.t += 7; m.pas -= 7; m.push(m.ax);  // push ax
      case 0x27e5: m.ax = ((0x0 + m.L) & 0xffff);  // mov ax, 0
      case 0x27e8: m.ds = m.ax;  // mov ds, ax
      case 0x27ea: { const t = m.pop(); m.ax = t; }  // pop ax
      case 0x27eb: m.ww(m.ds, 0x19f4, m.inc16(m.rw(m.ds, 0x19f4)));  // inc word ptr [0x19f4]
      case 0x27ef: m.sub16(m.rw(m.ds, 0x19f4), 0x28);  // cmp word ptr [0x19f4], 0x28
      case 0x27f4: if (m.cf) { ip = 0x2800; continue; }  // jb 0x2800
      case 0x27f6: m.t += 2; m.pas -= 2; m.ww(m.ds, 0x19f4, 0x0);  // mov word ptr [0x19f4], 0
      case 0x27fc: m.ww(m.ds, 0x19f6, m.inc16(m.rw(m.ds, 0x19f6)));  // inc word ptr [0x19f6]
      case 0x2800: m.t += 2; m.pas -= 2; { const t = m.pop(); m.bp = t; }  // pop bp
      case 0x2801: ip = m.pop(); continue;  // ret
      case 0x2802: m.t += 10; m.pas -= 10; m.ax = m.rw(m.ds, 0x19f6);  // mov ax, word ptr [0x19f6]
      case 0x2805: m.dx = 0x140;  // mov dx, 0x140
      case 0x2808: m.mul16(m.dx);  // mul dx
      case 0x280a: m.ax = m.shl16(m.ax, 0x1);  // shl ax, 1
      case 0x280c: m.ax = m.shl16(m.ax, 0x1);  // shl ax, 1
      case 0x280e: m.ax = m.add16(m.ax, m.rw(m.ds, 0x19f4));  // add ax, word ptr [0x19f4]
      case 0x2812: m.di = m.ax;  // mov di, ax
      case 0x2814: m.cx = 0x8;  // mov cx, 8
      case 0x2817: m.sub8(m.rb(m.ds, 0x19fb), 0x0);  // cmp byte ptr [0x19fb], 0
      case 0x281c: if (!m.zf) { ip = 0x2847; continue; }  // jne 0x2847
      case 0x281e: m.t += 19; m.pas -= 19; m.push(m.di);  // push di
      case 0x281f: m.push(m.si);  // push si
      case 0x2820: m.movsb(m.ds, 0);  // movsb byte ptr es:[di], byte ptr [si]
      case 0x2821: m.si = m.add16(m.si, 0x7);  // add si, 7
      case 0x2824: m.di = m.add16(m.di, 0x27);  // add di, 0x27
      case 0x2827: m.movsb(m.ds, 0);  // movsb byte ptr es:[di], byte ptr [si]
      case 0x2828: m.si = m.add16(m.si, 0x7);  // add si, 7
      case 0x282b: m.di = m.add16(m.di, 0x27);  // add di, 0x27
      case 0x282e: m.movsb(m.ds, 0);  // movsb byte ptr es:[di], byte ptr [si]
      case 0x282f: m.si = m.add16(m.si, 0x7);  // add si, 7
      case 0x2832: m.di = m.add16(m.di, 0x27);  // add di, 0x27
      case 0x2835: m.movsb(m.ds, 0);  // movsb byte ptr es:[di], byte ptr [si]
      case 0x2836: m.si = m.add16(m.si, 0x7);  // add si, 7
      case 0x2839: m.di = m.add16(m.di, 0x27);  // add di, 0x27
      case 0x283c: { const t = m.pop(); m.si = t; }  // pop si
      case 0x283d: { const t = m.pop(); m.di = t; }  // pop di
      case 0x283e: m.si = m.inc16(m.si);  // inc si
      case 0x283f: m.di = m.add16(m.di, 0xa0);  // add di, 0xa0
      case 0x2843: m.cx = (m.cx - 1) & 0xffff; if (m.cx !== 0) { ip = 0x281e; continue; }  // loop 0x281e
      case 0x2845: m.t += 1; m.pas -= 1; ip = 0x27e4; continue;  // jmp 0x27e4
      case 0x2847: m.t += 27; m.pas -= 27; m.ax = (m.ax & 0xff) | (m.rb(m.ds, m.si) << 8);  // mov ah, byte ptr [si]
      case 0x2849: m.ax = (m.ax & 0xff) | (m.or8((m.ax >> 8), m.rb(m.ds, ((m.si + 0x8) & 0xffff))) << 8);  // or ah, byte ptr [si + 8]
      case 0x284c: m.ax = (m.ax & 0xff) | (m.or8((m.ax >> 8), m.rb(m.ds, ((m.si + 0x10) & 0xffff))) << 8);  // or ah, byte ptr [si + 0x10]
      case 0x284f: m.ax = (m.ax & 0xff) | (m.or8((m.ax >> 8), m.rb(m.ds, ((m.si + 0x18) & 0xffff))) << 8);  // or ah, byte ptr [si + 0x18]
      case 0x2852: m.ax = (m.ax & 0xff) | ((~(m.ax >> 8) & 0xff) << 8);  // not ah
      case 0x2854: m.lodsb(m.ds, 0);  // lodsb al, byte ptr [si]
      case 0x2855: m.wb(m.es, m.di, m.and8(m.rb(m.es, m.di), (m.ax >> 8)));  // and byte ptr es:[di], ah
      case 0x2858: m.wb(m.es, m.di, m.or8(m.rb(m.es, m.di), (m.ax & 0xff)));  // or byte ptr es:[di], al
      case 0x285b: m.si = m.add16(m.si, 0x7);  // add si, 7
      case 0x285e: m.di = m.add16(m.di, 0x28);  // add di, 0x28
      case 0x2861: m.lodsb(m.ds, 0);  // lodsb al, byte ptr [si]
      case 0x2862: m.wb(m.es, m.di, m.and8(m.rb(m.es, m.di), (m.ax >> 8)));  // and byte ptr es:[di], ah
      case 0x2865: m.wb(m.es, m.di, m.or8(m.rb(m.es, m.di), (m.ax & 0xff)));  // or byte ptr es:[di], al
      case 0x2868: m.si = m.add16(m.si, 0x7);  // add si, 7
      case 0x286b: m.di = m.add16(m.di, 0x28);  // add di, 0x28
      case 0x286e: m.lodsb(m.ds, 0);  // lodsb al, byte ptr [si]
      case 0x286f: m.wb(m.es, m.di, m.and8(m.rb(m.es, m.di), (m.ax >> 8)));  // and byte ptr es:[di], ah
      case 0x2872: m.wb(m.es, m.di, m.or8(m.rb(m.es, m.di), (m.ax & 0xff)));  // or byte ptr es:[di], al
      case 0x2875: m.si = m.add16(m.si, 0x7);  // add si, 7
      case 0x2878: m.di = m.add16(m.di, 0x28);  // add di, 0x28
      case 0x287b: m.lodsb(m.ds, 0);  // lodsb al, byte ptr [si]
      case 0x287c: m.wb(m.es, m.di, m.and8(m.rb(m.es, m.di), (m.ax >> 8)));  // and byte ptr es:[di], ah
      case 0x287f: m.wb(m.es, m.di, m.or8(m.rb(m.es, m.di), (m.ax & 0xff)));  // or byte ptr es:[di], al
      case 0x2882: m.si = m.add16(m.si, 0x7);  // add si, 7
      case 0x2885: m.di = m.add16(m.di, 0x28);  // add di, 0x28
      case 0x2888: m.si = m.sub16(m.si, 0x1f);  // sub si, 0x1f
      case 0x288b: m.cx = (m.cx - 1) & 0xffff; if (m.cx !== 0) { ip = 0x2847; continue; }  // loop 0x2847
      case 0x288d: m.t += 1; m.pas -= 1; ip = 0x27e4; continue;  // jmp 0x27e4
      case 0x2890: m.t += 7; m.pas -= 7; m.ax = (m.ax & 0xff00) | m.rb(m.ds, ((m.bp + 0x1) & 0xffff));  // mov al, byte ptr ds:[bp + 1]
      case 0x2894: m.xor8(0, 0); m.ax = (m.ax & 0xff) | (0 << 8);  // xor ah, ah
      case 0x2896: m.ww(m.ds, 0x19f6, m.ax);  // mov word ptr [0x19f6], ax
      case 0x2899: m.ax = (m.ax & 0xff00) | m.rb(m.ds, ((m.bp + 0x2) & 0xffff));  // mov al, byte ptr ds:[bp + 2]
      case 0x289d: m.ww(m.ds, 0x19f4, m.ax);  // mov word ptr [0x19f4], ax
      case 0x28a0: m.bp = m.add16(m.bp, 0x2);  // add bp, 2
      case 0x28a3: ip = m.pop(); continue;  // ret
      case 0x28a4: m.t += 8; m.pas -= 8; m.ax = (m.ax & 0xff00) | m.rb(m.ds, ((m.bp + 0x2) & 0xffff));  // mov al, byte ptr ds:[bp + 2]
      case 0x28a8: m.ax = (m.ax & 0xff00) | m.add8((m.ax & 0xff), 0x4);  // add al, 4
      case 0x28aa: m.xor8(0, 0); m.ax = (m.ax & 0xff) | (0 << 8);  // xor ah, ah
      case 0x28ac: m.ww(m.ds, 0x19f6, m.ax);  // mov word ptr [0x19f6], ax
      case 0x28af: m.ax = (m.ax & 0xff00) | m.rb(m.ds, ((m.bp + 0x1) & 0xffff));  // mov al, byte ptr ds:[bp + 1]
      case 0x28b3: m.ww(m.ds, 0x19f4, m.ax);  // mov word ptr [0x19f4], ax
      case 0x28b6: m.bp = m.add16(m.bp, 0x2);  // add bp, 2
      case 0x28b9: ip = m.pop(); continue;  // ret
      case 0x28ba: m.t += 6; m.pas -= 6; m.ax = (m.ax & 0xff00) | m.rb(m.ds, ((m.bp + 0x1) & 0xffff));  // mov al, byte ptr ds:[bp + 1]
      case 0x28be: m.wb(m.ds, 0x19f2, (m.ax & 0xff));  // mov byte ptr [0x19f2], al
      case 0x28c1: m.ax = (m.ax & 0xff00) | m.rb(m.ds, ((m.bp + 0x2) & 0xffff));  // mov al, byte ptr ds:[bp + 2]
      case 0x28c5: m.wb(m.ds, 0x19f3, (m.ax & 0xff));  // mov byte ptr [0x19f3], al
      case 0x28c8: m.bp = m.add16(m.bp, 0x2);  // add bp, 2
      case 0x28cb: ip = m.pop(); continue;  // ret
      case 0x28cc: m.t += 2; m.pas -= 2; m.sub8((m.ax & 0xff), 0x10);  // cmp al, 0x10
      case 0x28ce: if (!m.zf) { ip = 0x28d3; continue; }  // jne 0x28d3
      case 0x28d0: m.t += 1; m.pas -= 1; ip = 0x299c; continue;  // jmp 0x299c
      case 0x28d3: m.t += 2; m.pas -= 2; m.sub8((m.ax & 0xff), 0x11);  // cmp al, 0x11
      case 0x28d5: if (!m.zf) { ip = 0x28da; continue; }  // jne 0x28da
      case 0x28d7: m.t += 1; m.pas -= 1; ip = 0x2972; continue;  // jmp 0x2972
      case 0x28da: m.t += 2; m.pas -= 2; m.sub8((m.ax & 0xff), 0x12);  // cmp al, 0x12
      case 0x28dc: if (!m.zf) { ip = 0x28e1; continue; }  // jne 0x28e1
      case 0x28de: m.t += 1; m.pas -= 1; ip = 0x2986; continue;  // jmp 0x2986
      case 0x28e1: m.t += 30; m.pas -= 30; m.push(m.drapeaux());  // pushf
      case 0x28e2: m.push(m.ax);  // push ax
      case 0x28e3: m.push(m.bx);  // push bx
      case 0x28e4: m.push(m.cx);  // push cx
      case 0x28e5: m.push(m.dx);  // push dx
      case 0x28e6: m.push(m.di);  // push di
      case 0x28e7: m.push(m.si);  // push si
      case 0x28e8: m.push(m.bp);  // push bp
      case 0x28e9: m.push(m.es);  // push es
      case 0x28ea: m.push(m.ds);  // push ds
      case 0x28eb: m.xor8(0, 0); m.ax = (m.ax & 0xff) | (0 << 8);  // xor ah, ah
      case 0x28ed: m.ax = m.shl16(m.ax, 0x1);  // shl ax, 1
      case 0x28ef: m.ax = m.shl16(m.ax, 0x1);  // shl ax, 1
      case 0x28f1: m.ax = m.shl16(m.ax, 0x1);  // shl ax, 1
      case 0x28f3: m.ax = m.add16(m.ax, 0x13b5);  // add ax, 0x13b5
      case 0x28f6: m.si = m.ax;  // mov si, ax
      case 0x28f8: m.ax = m.rw(m.ds, 0x19f6);  // mov ax, word ptr [0x19f6]
      case 0x28fb: m.dx = 0xa00;  // mov dx, 0xa00
      case 0x28fe: m.mul16(m.dx);  // mul dx
      case 0x2900: m.dx = m.rw(m.ds, 0x19f4);  // mov dx, word ptr [0x19f4]
      case 0x2904: m.dx = m.shl16(m.dx, 0x1);  // shl dx, 1
      case 0x2906: m.dx = m.shl16(m.dx, 0x1);  // shl dx, 1
      case 0x2908: m.dx = m.shl16(m.dx, 0x1);  // shl dx, 1
      case 0x290a: m.ax = m.add16(m.ax, m.dx);  // add ax, dx
      case 0x290c: m.di = m.ax;  // mov di, ax
      case 0x290e: m.ax = m.rw(m.ds, 0x19f8);  // mov ax, word ptr [0x19f8]
      case 0x2911: m.es = m.ax;  // mov es, ax
      case 0x2913: m.bx = (m.bx & 0xff00) | m.rb(m.ds, 0x19f2);  // mov bl, byte ptr [0x19f2]
      case 0x2917: m.bx = (m.bx & 0xff) | (m.rb(m.ds, 0x19f3) << 8);  // mov bh, byte ptr [0x19f3]
      case 0x291b: m.cx = 0x8;  // mov cx, 8
      case 0x291e: m.t += 4; m.pas -= 4; m.push(m.cx);  // push cx
      case 0x291f: m.lodsb(m.ds, 0);  // lodsb al, byte ptr [si]
      case 0x2920: m.and8(m.rb(m.ds, 0x19fa), 0x1);  // test byte ptr [0x19fa], 1
      case 0x2925: if (m.zf) { ip = 0x2929; continue; }  // je 0x2929
      case 0x2927: m.t += 1; m.pas -= 1; m.ax = (m.ax & 0xff00) | (~(m.ax & 0xff) & 0xff);  // not al
      case 0x2929: m.t += 2; m.pas -= 2; m.ax = (m.ax & 0xff) | ((m.ax & 0xff) << 8);  // mov ah, al
      case 0x292b: m.cx = 0x8;  // mov cx, 8
      case 0x292e: m.t += 3; m.pas -= 3; m.ax = (m.ax & 0xff00) | (m.bx & 0xff);  // mov al, bl
      case 0x2930: m.ax = (m.ax & 0xff) | (m.shl8((m.ax >> 8), 0x1) << 8);  // shl ah, 1
      case 0x2932: if (m.cf) { ip = 0x2941; continue; }  // jb 0x2941
      case 0x2934: m.t += 3; m.pas -= 3; m.ax = (m.ax & 0xff00) | (m.bx >> 8);  // mov al, bh
      case 0x2936: m.sub8(m.rb(m.ds, 0x19fb), 0x0);  // cmp byte ptr [0x19fb], 0
      case 0x293b: if (m.zf) { ip = 0x2941; continue; }  // je 0x2941
      case 0x293d: m.t += 2; m.pas -= 2; m.di = m.inc16(m.di);  // inc di
      case 0x293e: ip = 0x2942; continue;  // jmp 0x2942
      case 0x2941: m.t += 1; m.pas -= 1; m.stosb(m.ds, 0);  // stosb byte ptr es:[di], al
      case 0x2942: m.t += 1; m.pas -= 1; m.cx = (m.cx - 1) & 0xffff; if (m.cx !== 0) { ip = 0x292e; continue; }  // loop 0x292e
      case 0x2944: m.t += 3; m.pas -= 3; { const t = m.pop(); m.cx = t; }  // pop cx
      case 0x2945: m.di = m.add16(m.di, 0x138);  // add di, 0x138
      case 0x2949: m.cx = (m.cx - 1) & 0xffff; if (m.cx !== 0) { ip = 0x291e; continue; }  // loop 0x291e
      case 0x294b: m.t += 7; m.pas -= 7; m.push(m.ax);  // push ax
      case 0x294c: m.ax = ((0x0 + m.L) & 0xffff);  // mov ax, 0
      case 0x294f: m.ds = m.ax;  // mov ds, ax
      case 0x2951: { const t = m.pop(); m.ax = t; }  // pop ax
      case 0x2952: m.ww(m.ds, 0x19f4, m.inc16(m.rw(m.ds, 0x19f4)));  // inc word ptr [0x19f4]
      case 0x2956: m.sub16(m.rw(m.ds, 0x19f4), 0x28);  // cmp word ptr [0x19f4], 0x28
      case 0x295b: if (m.cf) { ip = 0x2967; continue; }  // jb 0x2967
      case 0x295d: m.t += 2; m.pas -= 2; m.ww(m.ds, 0x19f4, 0x0);  // mov word ptr [0x19f4], 0
      case 0x2963: m.ww(m.ds, 0x19f6, m.inc16(m.rw(m.ds, 0x19f6)));  // inc word ptr [0x19f6]
      case 0x2967: m.t += 11; m.pas -= 11; { const t = m.pop(); m.ds = t; }  // pop ds
      case 0x2968: { const t = m.pop(); m.es = t; }  // pop es
      case 0x2969: { const t = m.pop(); m.bp = t; }  // pop bp
      case 0x296a: { const t = m.pop(); m.si = t; }  // pop si
      case 0x296b: { const t = m.pop(); m.di = t; }  // pop di
      case 0x296c: { const t = m.pop(); m.dx = t; }  // pop dx
      case 0x296d: { const t = m.pop(); m.cx = t; }  // pop cx
      case 0x296e: { const t = m.pop(); m.bx = t; }  // pop bx
      case 0x296f: { const t = m.pop(); m.ax = t; }  // pop ax
      case 0x2970: m.poserDrapeaux(m.pop());  // popf
      case 0x2971: ip = m.pop(); continue;  // ret
      case 0x2972: m.t += 7; m.pas -= 7; m.ax = (m.ax & 0xff00) | m.rb(m.ds, ((m.bp + 0x1) & 0xffff));  // mov al, byte ptr ds:[bp + 1]
      case 0x2976: m.ww(m.ds, 0x19f6, m.ax);  // mov word ptr [0x19f6], ax
      case 0x2979: m.xor8(0, 0); m.ax = (m.ax & 0xff) | (0 << 8);  // xor ah, ah
      case 0x297b: m.ax = (m.ax & 0xff00) | m.rb(m.ds, ((m.bp + 0x2) & 0xffff));  // mov al, byte ptr ds:[bp + 2]
      case 0x297f: m.ww(m.ds, 0x19f4, m.ax);  // mov word ptr [0x19f4], ax
      case 0x2982: m.bp = m.add16(m.bp, 0x2);  // add bp, 2
      case 0x2985: ip = m.pop(); continue;  // ret
      case 0x2986: m.t += 8; m.pas -= 8; m.ax = (m.ax & 0xff00) | m.rb(m.ds, ((m.bp + 0x2) & 0xffff));  // mov al, byte ptr ds:[bp + 2]
      case 0x298a: m.xor8(0, 0); m.ax = (m.ax & 0xff) | (0 << 8);  // xor ah, ah
      case 0x298c: m.ax = (m.ax & 0xff00) | m.add8((m.ax & 0xff), 0x4);  // add al, 4
      case 0x298e: m.ww(m.ds, 0x19f6, m.ax);  // mov word ptr [0x19f6], ax
      case 0x2991: m.ax = (m.ax & 0xff00) | m.rb(m.ds, ((m.bp + 0x1) & 0xffff));  // mov al, byte ptr ds:[bp + 1]
      case 0x2995: m.ww(m.ds, 0x19f4, m.ax);  // mov word ptr [0x19f4], ax
      case 0x2998: m.bp = m.add16(m.bp, 0x2);  // add bp, 2
      case 0x299b: ip = m.pop(); continue;  // ret
      case 0x299c: m.t += 6; m.pas -= 6; m.ax = (m.ax & 0xff00) | m.rb(m.ds, ((m.bp + 0x1) & 0xffff));  // mov al, byte ptr ds:[bp + 1]
      case 0x29a0: m.wb(m.ds, 0x19f2, (m.ax & 0xff));  // mov byte ptr [0x19f2], al
      case 0x29a3: m.ax = (m.ax & 0xff00) | m.rb(m.ds, ((m.bp + 0x2) & 0xffff));  // mov al, byte ptr ds:[bp + 2]
      case 0x29a7: m.wb(m.ds, 0x19f3, (m.ax & 0xff));  // mov byte ptr [0x19f3], al
      case 0x29aa: m.bp = m.add16(m.bp, 0x2);  // add bp, 2
      case 0x29ad: ip = m.pop(); continue;  // ret
      default: return ip;
    }
  }
}

// 0x29ae sub_6e5e
function sub_29ae_29ae(m, ip) {
  for (;;) {
    if (m.pas <= 0) return ip;
    switch (ip) {
      case 0x29ae: m.t += 4; m.pas -= 4; m.ww(m.ds, 0x1440, 0x4);  // mov word ptr [0x1440], 4
      case 0x29b4: m.ax = (m.ax & 0xff) | (0x0 << 8);  // mov ah, 0
      case 0x29b6: m.ax = (m.ax & 0xff00) | 0x8;  // mov al, 8
      case 0x29b8: if (!m.interruption(0x10)) { m.pas = 0; ip = 0x29b8; continue; }  // int 0x10
      case 0x29ba: m.t += 1; m.pas -= 1; ip = m.pop(); continue;  // ret
      default: return ip;
    }
  }
}

// 0x29bb sub_6e6b
function sub_29bb_29bb(m, ip) {
  for (;;) {
    if (m.pas <= 0) return ip;
    switch (ip) {
      case 0x29bb: m.t += 11; m.pas -= 11; m.push(m.drapeaux());  // pushf
      case 0x29bc: m.push(m.ax);  // push ax
      case 0x29bd: m.push(m.bx);  // push bx
      case 0x29be: m.push(m.cx);  // push cx
      case 0x29bf: m.push(m.dx);  // push dx
      case 0x29c0: m.push(m.di);  // push di
      case 0x29c1: m.push(m.si);  // push si
      case 0x29c2: m.push(m.bp);  // push bp
      case 0x29c3: m.push(m.es);  // push es
      case 0x29c4: m.push(m.ds);  // push ds
      case 0x29c5: m.cx = 0x3e8;  // mov cx, 0x3e8
      case 0x29c8: m.t += 2; m.pas -= 2;  // nop
      case 0x29c9: m.cx = (m.cx - 1) & 0xffff; if (m.cx !== 0) { ip = 0x29c8; continue; }  // loop 0x29c8
      case 0x29cb: m.t += 11; m.pas -= 11; { const t = m.pop(); m.ds = t; }  // pop ds
      case 0x29cc: { const t = m.pop(); m.es = t; }  // pop es
      case 0x29cd: { const t = m.pop(); m.bp = t; }  // pop bp
      case 0x29ce: { const t = m.pop(); m.si = t; }  // pop si
      case 0x29cf: { const t = m.pop(); m.di = t; }  // pop di
      case 0x29d0: { const t = m.pop(); m.dx = t; }  // pop dx
      case 0x29d1: { const t = m.pop(); m.cx = t; }  // pop cx
      case 0x29d2: { const t = m.pop(); m.bx = t; }  // pop bx
      case 0x29d3: { const t = m.pop(); m.ax = t; }  // pop ax
      case 0x29d4: m.poserDrapeaux(m.pop());  // popf
      case 0x29d5: ip = m.pop(); continue;  // ret
      default: return ip;
    }
  }
}

// 0x29d6 sub_6e86
function sub_29d6_29d6(m, ip) {
  for (;;) {
    if (m.pas <= 0) return ip;
    switch (ip) {
      case 0x29d6: m.t += 12; m.pas -= 12; m.push(m.drapeaux());  // pushf
      case 0x29d7: m.push(m.ax);  // push ax
      case 0x29d8: m.push(m.bx);  // push bx
      case 0x29d9: m.push(m.cx);  // push cx
      case 0x29da: m.push(m.dx);  // push dx
      case 0x29db: m.push(m.di);  // push di
      case 0x29dc: m.push(m.si);  // push si
      case 0x29dd: m.push(m.bp);  // push bp
      case 0x29de: m.push(m.es);  // push es
      case 0x29df: m.push(m.ds);  // push ds
      case 0x29e0: m.cx = 0xffff;  // mov cx, 0xffff
      case 0x29e3: ip = 0x29c8; continue;  // jmp 0x29c8
      default: return ip;
    }
  }
}

// 0x29e5 sub_6e95
function sub_29e5_29e5(m, ip) {
  for (;;) {
    if (m.pas <= 0) return ip;
    switch (ip) {
      case 0x29e5: m.t += 1; m.pas -= 1; m.push(0x29e8); ip = 0x29f2; continue;  // call 0x29f2
      case 0x29e8: m.t += 2; m.pas -= 2; m.ax = (m.ax & 0xff00) | m.or8((m.ax & 0xff), (m.ax & 0xff));  // or al, al
      case 0x29ea: if (m.zf) { ip = 0x29e5; continue; }  // je 0x29e5
      case 0x29ec: m.t += 2; m.pas -= 2; m.push(m.ax);  // push ax
      case 0x29ed: m.push(0x29f0); ip = 0x2a1b; continue;  // call 0x2a1b
      case 0x29f0: m.t += 2; m.pas -= 2; { const t = m.pop(); m.ax = t; }  // pop ax
      case 0x29f1: ip = m.pop(); continue;  // ret
      default: return ip;
    }
  }
}

// 0x29f2 sub_6ea2
function sub_29f2_29f2(m, ip) {
  for (;;) {
    if (m.pas <= 0) return ip;
    switch (ip) {
      case 0x29f2: m.t += 9; m.pas -= 9; m.push(m.es);  // push es
      case 0x29f3: m.push(m.ax);  // push ax
      case 0x29f4: m.ax = ((0x0 + m.L) & 0xffff);  // mov ax, 0
      case 0x29f7: m.es = m.ax;  // mov es, ax
      case 0x29f9: { const t = m.pop(); m.ax = t; }  // pop ax
      case 0x29fa: m.df = 0;  // cld
      case 0x29fb: m.cx = 0x80;  // mov cx, 0x80
      case 0x29fe: m.ax = (m.ax & 0xff00) | 0x1;  // mov al, 1
      case 0x2a00: m.di = 0x1bb4;  // mov di, 0x1bb4
      case 0x2a03: m.t += 2; m.pas -= 2; m.sub8(m.rb(m.es, m.di), (m.ax & 0xff));  // cmp byte ptr es:[di], al
      case 0x2a06: if (m.zf) { ip = 0x2a0f; continue; }  // je 0x2a0f
      case 0x2a08: m.t += 2; m.pas -= 2; m.di = m.inc16(m.di);  // inc di
      case 0x2a09: m.cx = (m.cx - 1) & 0xffff; if (m.cx !== 0) { ip = 0x2a03; continue; }  // loop 0x2a03
      case 0x2a0b: m.t += 3; m.pas -= 3; m.xor16(0, 0); m.ax = 0;  // xor ax, ax
      case 0x2a0d: { const t = m.pop(); m.es = t; }  // pop es
      case 0x2a0e: ip = m.pop(); continue;  // ret
      case 0x2a0f: m.t += 7; m.pas -= 7; m.ax = (m.ax & 0xff00) | 0x80;  // mov al, 0x80
      case 0x2a11: m.ax = (m.ax & 0xff00) | m.sub8((m.ax & 0xff), (m.cx & 0xff));  // sub al, cl
      case 0x2a13: m.ax = (m.ax & 0xff) | ((m.ax & 0xff) << 8);  // mov ah, al
      case 0x2a15: m.bx = 0x1c3f;  // mov bx, 0x1c3f
      case 0x2a18: m.ax = (m.ax & 0xff00) | m.rb(m.ds, (m.bx + (m.ax & 0xff)) & 0xffff);  // xlatb
      case 0x2a19: { const t = m.pop(); m.es = t; }  // pop es
      case 0x2a1a: ip = m.pop(); continue;  // ret
      default: return ip;
    }
  }
}

// 0x2a1b sub_6ecb
function sub_2a1b_2a1b(m, ip) {
  for (;;) {
    if (m.pas <= 0) return ip;
    switch (ip) {
      case 0x2a1b: m.t += 1; m.pas -= 1; m.push(0x2a1e); ip = 0x29f2; continue;  // call 0x29f2
      case 0x2a1e: m.t += 2; m.pas -= 2; m.ax = (m.ax & 0xff00) | m.or8((m.ax & 0xff), (m.ax & 0xff));  // or al, al
      case 0x2a20: if (!m.zf) { ip = 0x2a1b; continue; }  // jne 0x2a1b
      case 0x2a22: m.t += 1; m.pas -= 1; ip = m.pop(); continue;  // ret
      default: return ip;
    }
  }
}

// 0x2a23 sub_6ed3
function sub_2a23_2a23(m, ip) {
  for (;;) {
    if (m.pas <= 0) return ip;
    switch (ip) {
      case 0x2a23: m.t += 16; m.pas -= 16; m.ax = m.rw(m.ds, 0x1b9f);  // mov ax, word ptr [0x1b9f]
      case 0x2a26: m.ax = (m.ax & 0xff00) | m.and8((m.ax & 0xff), 0x48);  // and al, 0x48
      case 0x2a28: m.ax = (m.ax & 0xff00) | m.add8((m.ax & 0xff), 0x38);  // add al, 0x38
      case 0x2a2a: m.ax = (m.ax & 0xff00) | m.rcl8((m.ax & 0xff), 0x1);  // rcl al, 1
      case 0x2a2c: m.ax = (m.ax & 0xff00) | m.rcl8((m.ax & 0xff), 0x1);  // rcl al, 1
      case 0x2a2e: m.wb(m.ds, 0x1ba2, m.rcl8(m.rb(m.ds, 0x1ba2), 0x1));  // rcl byte ptr [0x1ba2]
      case 0x2a32: m.wb(m.ds, 0x1ba1, m.rcl8(m.rb(m.ds, 0x1ba1), 0x1));  // rcl byte ptr [0x1ba1]
      case 0x2a36: m.wb(m.ds, 0x1ba0, m.rcl8(m.rb(m.ds, 0x1ba0), 0x1));  // rcl byte ptr [0x1ba0]
      case 0x2a3a: m.wb(m.ds, 0x1b9f, m.rcl8(m.rb(m.ds, 0x1b9f), 0x1));  // rcl byte ptr [0x1b9f]
      case 0x2a3e: m.ax = m.rw(m.ds, 0x1b9f);  // mov ax, word ptr [0x1b9f]
      case 0x2a41: m.xor8(0, 0); m.ax = (m.ax & 0xff) | (0 << 8);  // xor ah, ah
      case 0x2a43: m.div8((m.bx & 0xff));  // div bl
      case 0x2a45: m.ax = (m.ax & 0xff00) | (m.ax >> 8);  // mov al, ah
      case 0x2a47: m.ax = (m.ax & 0xff00) | m.inc8((m.ax & 0xff));  // inc al
      case 0x2a49: m.ax = (m.ax & 0xff00) | m.or8((m.ax & 0xff), (m.ax & 0xff));  // or al, al
      case 0x2a4b: if (!m.zf) { ip = 0x2a4f; continue; }  // jne 0x2a4f
      case 0x2a4d: m.t += 1; m.pas -= 1; m.ax = (m.ax & 0xff00) | m.inc8((m.ax & 0xff));  // inc al
      case 0x2a4f: m.t += 1; m.pas -= 1; ip = m.pop(); continue;  // ret
      default: return ip;
    }
  }
}

// 0x2a50 sub_6f00
function sub_2a50_2a50(m, ip) {
  for (;;) {
    if (m.pas <= 0) return ip;
    switch (ip) {
      case 0x2a50: m.t += 10; m.pas -= 10; m.ww(m.ds, 0x19f4, 0x0);  // mov word ptr [0x19f4], 0
      case 0x2a56: m.ww(m.ds, 0x19f6, 0x0);  // mov word ptr [0x19f6], 0
      case 0x2a5c: m.df = 0;  // cld
      case 0x2a5d: m.xor16(0, 0); m.ax = 0;  // xor ax, ax
      case 0x2a5f: m.di = m.ax;  // mov di, ax
      case 0x2a61: m.cx = ((0x0 + m.L) & 0xffff);  // mov cx, 0
      case 0x2a64: m.ax = m.rw(m.ds, 0x1440);  // mov ax, word ptr [0x1440]
      case 0x2a67: m.bx = 0x19e6;  // mov bx, 0x19e6
      case 0x2a6a: m.bx = m.add16(m.bx, m.rw(m.ds, 0x1440));  // add bx, word ptr [0x1440]
      case 0x2a6e: ip = m.rw(m.ds, m.bx); continue;  // jmp word ptr [bx]
      case 0x2a70: m.t += 8; m.pas -= 8; m.push(m.ax);  // push ax
      case 0x2a71: m.ax = 0xa000;  // mov ax, 0xa000
      case 0x2a74: m.es = m.ax;  // mov es, ax
      case 0x2a76: { const t = m.pop(); m.ax = t; }  // pop ax
      case 0x2a77: m.xor16(0, 0); m.di = 0;  // xor di, di
      case 0x2a79: m.cx = 0x4000;  // mov cx, 0x4000
      case 0x2a7c: m.stosw(m.ds, 1);  // rep stosw word ptr es:[di], ax
      case 0x2a7e: ip = m.pop(); continue;  // ret
      case 0x2a7f: m.t += 15; m.pas -= 15; m.push(m.ax);  // push ax
      case 0x2a80: m.ax = 0xa000;  // mov ax, 0xa000
      case 0x2a83: m.es = m.ax;  // mov es, ax
      case 0x2a85: { const t = m.pop(); m.ax = t; }  // pop ax
      case 0x2a86: m.dx = 0x3ce;  // mov dx, 0x3ce
      case 0x2a89: m.ax = (m.ax & 0xff) | (m.rb(m.ds, 0x19f3) << 8);  // mov ah, byte ptr [0x19f3]
      case 0x2a8d: m.ax = (m.ax & 0xff00) | 0x0;  // mov al, 0
      case 0x2a8f: m.sortie(m.dx, m.ax, 2);  // out dx, ax
      case 0x2a90: m.ax = 0xf01;  // mov ax, 0xf01
      case 0x2a93: m.sortie(m.dx, m.ax, 2);  // out dx, ax
      case 0x2a94: m.cx = 0xc8;  // mov cx, 0xc8
      case 0x2a97: m.stosw(m.ds, 1);  // rep stosw word ptr es:[di], ax
      case 0x2a99: m.ax = 0x1;  // mov ax, 1
      case 0x2a9c: m.sortie(m.dx, m.ax, 2);  // out dx, ax
      case 0x2a9d: ip = m.pop(); continue;  // ret
      case 0x2a9e: m.t += 9; m.pas -= 9; m.push(m.ax);  // push ax
      case 0x2a9f: m.ax = 0xa000;  // mov ax, 0xa000
      case 0x2aa2: m.es = m.ax;  // mov es, ax
      case 0x2aa4: { const t = m.pop(); m.ax = t; }  // pop ax
      case 0x2aa5: m.ax = (m.ax & 0xff00) | m.rb(m.ds, 0x19f3);  // mov al, byte ptr [0x19f3]
      case 0x2aa8: m.ax = (m.ax & 0xff) | ((m.ax & 0xff) << 8);  // mov ah, al
      case 0x2aaa: m.cx = 0x7d00;  // mov cx, 0x7d00
      case 0x2aad: m.stosw(m.ds, 1);  // rep stosw word ptr es:[di], ax
      case 0x2aaf: ip = m.pop(); continue;  // ret
      default: return ip;
    }
  }
}

// 0x2ab0 sub_6f60
function sub_2ab0_2ab0(m, ip) {
  for (;;) {
    if (m.pas <= 0) return ip;
    switch (ip) {
      case 0x2ab0: m.t += 3; m.pas -= 3; m.push(m.dx);  // push dx
      case 0x2ab1: m.push(m.ax);  // push ax
      case 0x2ab2: m.dx = 0x3da;  // mov dx, 0x3da
      case 0x2ab5: m.t += 3; m.pas -= 3; m.ax = (m.ax & 0xff00) | m.entree(m.dx, 1);  // in al, dx
      case 0x2ab6: m.ax = (m.ax & 0xff00) | m.and8((m.ax & 0xff), 0x8);  // and al, 8
      case 0x2ab8: if (m.zf) { ip = 0x2ab5; continue; }  // je 0x2ab5
      case 0x2aba: m.t += 3; m.pas -= 3; { const t = m.pop(); m.ax = t; }  // pop ax
      case 0x2abb: { const t = m.pop(); m.dx = t; }  // pop dx
      case 0x2abc: ip = m.pop(); continue;  // ret
      default: return ip;
    }
  }
}

// 0x2aca sub_6f7a
function sub_2aca_2aca(m, ip) {
  for (;;) {
    if (m.pas <= 0) return ip;
    switch (ip) {
      case 0x2aca: m.t += 3; m.pas -= 3; m.bx = 0x2b19;  // mov bx, 0x2b19
      case 0x2acd: m.sub16(m.rw(m.ds, 0x1c3d), m.bx);  // cmp word ptr [0x1c3d], bx
      case 0x2ad1: if (!m.zf) { ip = 0x2ad4; continue; }  // jne 0x2ad4
      case 0x2ad3: m.t += 1; m.pas -= 1; ip = m.pop(); continue;  // ret
      case 0x2ad4: m.t += 4; m.pas -= 4; m.push(m.es);  // push es
      case 0x2ad5: m.ax = (m.ax & 0xff) | (0x35 << 8);  // mov ah, 0x35
      case 0x2ad7: m.ax = (m.ax & 0xff00) | 0x9;  // mov al, 9
      case 0x2ad9: if (!m.interruption(0x21)) { m.pas = 0; ip = 0x2ad9; continue; }  // int 0x21
      case 0x2adb: m.t += 11; m.pas -= 11; m.di = 0x1c3b;  // mov di, 0x1c3b
      case 0x2ade: m.ww(m.ds, m.di, m.es);  // mov word ptr [di], es
      case 0x2ae0: m.ww(m.ds, ((m.di + 0x2) & 0xffff), m.bx);  // mov word ptr [di + 2], bx
      case 0x2ae3: { const t = m.pop(); m.es = t; }  // pop es
      case 0x2ae4: m.push(m.ds);  // push ds
      case 0x2ae5: m.push(m.cs);  // push cs
      case 0x2ae6: { const t = m.pop(); m.ds = t; }  // pop ds
      case 0x2ae7: m.dx = 0x2b19;  // mov dx, 0x2b19
      case 0x2aea: m.ax = (m.ax & 0xff) | (0x25 << 8);  // mov ah, 0x25
      case 0x2aec: m.ax = (m.ax & 0xff00) | 0x9;  // mov al, 9
      case 0x2aee: if (!m.interruption(0x21)) { m.pas = 0; ip = 0x2aee; continue; }  // int 0x21
      case 0x2af0: m.t += 8; m.pas -= 8; { const t = m.pop(); m.ds = t; }  // pop ds
      case 0x2af1: m.di = 0x1bb4;  // mov di, 0x1bb4
      case 0x2af4: m.ax = ((0x0 + m.L) & 0xffff);  // mov ax, 0
      case 0x2af7: m.es = m.ax;  // mov es, ax
      case 0x2af9: m.xor16(0, 0); m.ax = 0;  // xor ax, ax
      case 0x2afb: m.cx = 0x40;  // mov cx, 0x40
      case 0x2afe: m.stosw(m.ds, 1);  // rep stosw word ptr es:[di], ax
      case 0x2b00: ip = m.pop(); continue;  // ret
      default: return ip;
    }
  }
}

// 0x2b01 sub_6fb1
function sub_2b01_2b01(m, ip) {
  for (;;) {
    if (m.pas <= 0) return ip;
    switch (ip) {
      case 0x2b01: m.t += 5; m.pas -= 5; m.push(m.ds);  // push ds
      case 0x2b02: m.di = 0x1c3b;  // mov di, 0x1c3b
      case 0x2b05: m.dx = m.rw(m.ds, ((m.di + 0x2) & 0xffff));  // mov dx, word ptr [di + 2]
      case 0x2b08: m.sub16(m.dx, 0x0);  // cmp dx, 0
      case 0x2b0b: if (m.zf) { ip = 0x2b17; continue; }  // je 0x2b17
      case 0x2b0d: m.t += 5; m.pas -= 5; m.ax = m.rw(m.ds, m.di);  // mov ax, word ptr [di]
      case 0x2b0f: m.ds = m.ax;  // mov ds, ax
      case 0x2b11: m.ax = (m.ax & 0xff) | (0x25 << 8);  // mov ah, 0x25
      case 0x2b13: m.ax = (m.ax & 0xff00) | 0x9;  // mov al, 9
      case 0x2b15: if (!m.interruption(0x21)) { m.pas = 0; ip = 0x2b15; continue; }  // int 0x21
      case 0x2b17: m.t += 2; m.pas -= 2; { const t = m.pop(); m.ds = t; }  // pop ds
      case 0x2b18: ip = m.pop(); continue;  // ret
      default: return ip;
    }
  }
}

// 0x2b19 clavier_interruption : int 9 installé par sub_6f7a (CS:2B19) : lit le port 60h, met à 1 ou 0 l'octet de la touche dans DS:1BB4 (64 touches)
function clavier_interruption_2b19(m, ip) {
  for (;;) {
    if (m.pas <= 0) return ip;
    switch (ip) {
      case 0x2b19: m.t += 27; m.pas -= 27; m.push(m.drapeaux());  // pushf
      case 0x2b1a: m.push(m.ax);  // push ax
      case 0x2b1b: m.push(m.bx);  // push bx
      case 0x2b1c: m.push(m.cx);  // push cx
      case 0x2b1d: m.push(m.dx);  // push dx
      case 0x2b1e: m.push(m.di);  // push di
      case 0x2b1f: m.push(m.si);  // push si
      case 0x2b20: m.push(m.bp);  // push bp
      case 0x2b21: m.push(m.es);  // push es
      case 0x2b22: m.push(m.ds);  // push ds
      case 0x2b23: m.push(m.ax);  // push ax
      case 0x2b24: m.ax = ((0x0 + m.L) & 0xffff);  // mov ax, 0
      case 0x2b27: m.ds = m.ax;  // mov ds, ax
      case 0x2b29: { const t = m.pop(); m.ax = t; }  // pop ax
      case 0x2b2a: m.ax = (m.ax & 0xff00) | m.entree(0x60, 1);  // in al, 0x60
      case 0x2b2c: m.bx = (m.bx & 0xff00) | (m.ax & 0xff);  // mov bl, al
      case 0x2b2e: m.ax = (m.ax & 0xff00) | m.entree(0x61, 1);  // in al, 0x61
      case 0x2b30: m.ax = (m.ax & 0xff) | ((m.ax & 0xff) << 8);  // mov ah, al
      case 0x2b32: m.ax = (m.ax & 0xff00) | m.or8((m.ax & 0xff), 0x80);  // or al, 0x80
      case 0x2b34: m.sortie(0x61, (m.ax & 0xff), 1);  // out 0x61, al
      case 0x2b36: { const t = (m.ax & 0xff); m.ax = (m.ax & 0xff00) | (m.ax >> 8); m.ax = (m.ax & 0xff) | (t << 8); }  // xchg al, ah
      case 0x2b38: m.sortie(0x61, (m.ax & 0xff), 1);  // out 0x61, al
      case 0x2b3a: m.ax = (m.ax & 0xff00) | (m.bx & 0xff);  // mov al, bl
      case 0x2b3c: m.xor8(0, 0); m.ax = (m.ax & 0xff) | (0 << 8);  // xor ah, ah
      case 0x2b3e: m.bx = 0x1bb4;  // mov bx, 0x1bb4
      case 0x2b41: m.and8((m.ax & 0xff), 0x80);  // test al, 0x80
      case 0x2b43: if (!m.zf) { ip = 0x2b4c; continue; }  // jne 0x2b4c
      case 0x2b45: m.t += 3; m.pas -= 3; m.bx = m.add16(m.bx, m.ax);  // add bx, ax
      case 0x2b47: m.wb(m.ds, m.bx, 0x1);  // mov byte ptr [bx], 1
      case 0x2b4a: ip = 0x2b53; continue;  // jmp 0x2b53
      case 0x2b4c: m.t += 3; m.pas -= 3; m.ax = (m.ax & 0xff00) | m.and8((m.ax & 0xff), 0x7f);  // and al, 0x7f
      case 0x2b4e: m.bx = m.add16(m.bx, m.ax);  // add bx, ax
      case 0x2b50: m.wb(m.ds, m.bx, 0x0);  // mov byte ptr [bx], 0
      case 0x2b53: m.t += 13; m.pas -= 13; m.ax = (m.ax & 0xff00) | 0x61;  // mov al, 0x61
      case 0x2b55: m.sortie(0x20, (m.ax & 0xff), 1);  // out 0x20, al
      case 0x2b57: { const t = m.pop(); m.ds = t; }  // pop ds
      case 0x2b58: { const t = m.pop(); m.es = t; }  // pop es
      case 0x2b59: { const t = m.pop(); m.bp = t; }  // pop bp
      case 0x2b5a: { const t = m.pop(); m.si = t; }  // pop si
      case 0x2b5b: { const t = m.pop(); m.di = t; }  // pop di
      case 0x2b5c: { const t = m.pop(); m.dx = t; }  // pop dx
      case 0x2b5d: { const t = m.pop(); m.cx = t; }  // pop cx
      case 0x2b5e: { const t = m.pop(); m.bx = t; }  // pop bx
      case 0x2b5f: { const t = m.pop(); m.ax = t; }  // pop ax
      case 0x2b60: m.poserDrapeaux(m.pop());  // popf
      case 0x2b61: ip = m.pop(); m.cs = m.pop(); m.poserDrapeaux(m.pop()); continue;  // iret
      default: return ip;
    }
  }
}

// 0x2b62 sub_7012
function sub_2b62_2b62(m, ip) {
  for (;;) {
    if (m.pas <= 0) return ip;
    switch (ip) {
      case 0x2b62: m.t += 5; m.pas -= 5; m.wb(m.ds, 0x1c34, 0x0);  // mov byte ptr [0x1c34], 0
      case 0x2b67: m.cx = 0x6;  // mov cx, 6
      case 0x2b6a: m.xor16(0, 0); m.bx = 0;  // xor bx, bx
      case 0x2b6c: m.si = 0x1bad;  // mov si, 0x1bad
      case 0x2b6f: m.di = 0x1bb4;  // mov di, 0x1bb4
      case 0x2b72: m.t += 6; m.pas -= 6; m.bx = (m.bx & 0xff00) | m.rb(m.ds, m.si);  // mov bl, byte ptr [si]
      case 0x2b74: m.ax = (m.ax & 0xff00) | m.rb(m.ds, ((m.bx + m.di) & 0xffff));  // mov al, byte ptr [bx + di]
      case 0x2b76: m.ax = (m.ax & 0xff00) | m.shr8((m.ax & 0xff), 0x1);  // shr al, 1
      case 0x2b78: m.wb(m.ds, 0x1c34, m.rcl8(m.rb(m.ds, 0x1c34), 0x1));  // rcl byte ptr [0x1c34]
      case 0x2b7c: m.si = m.inc16(m.si);  // inc si
      case 0x2b7d: m.cx = (m.cx - 1) & 0xffff; if (m.cx !== 0) { ip = 0x2b72; continue; }  // loop 0x2b72
      case 0x2b7f: m.t += 3; m.pas -= 3; m.wb(m.ds, 0x1c34, m.and8(m.rb(m.ds, 0x1c34), 0x7f));  // and byte ptr [0x1c34], 0x7f
      case 0x2b84: m.and8(m.rb(m.ds, 0x1bb5), 0x1);  // test byte ptr [0x1bb5], 1
      case 0x2b89: if (m.zf) { ip = 0x2b9e; continue; }  // je 0x2b9e
      case 0x2b8b: m.t += 2; m.pas -= 2; m.and8(m.rb(m.ds, 0x1bd1), 0x1);  // test byte ptr [0x1bd1], 1
      case 0x2b90: if (m.zf) { ip = 0x2b97; continue; }  // je 0x2b97
      case 0x2b92: m.t += 1; m.pas -= 1; m.wb(m.ds, 0x1c34, m.or8(m.rb(m.ds, 0x1c34), 0x40));  // or byte ptr [0x1c34], 0x40
      case 0x2b97: m.t += 2; m.pas -= 2; m.ax = (m.ax & 0xff00) | m.rb(m.ds, 0x1bd1);  // mov al, byte ptr [0x1bd1]
      case 0x2b9a: m.ax = (m.ax & 0xff) | (m.rb(m.ds, 0x1bb5) << 8);  // mov ah, byte ptr [0x1bb5]
      case 0x2b9e: m.t += 1; m.pas -= 1; m.push(0x2ba1); ip = 0x2bb9; continue;  // call 0x2bb9
      case 0x2ba1: m.t += 1; m.pas -= 1; m.push(0x2ba4); ip = 0x2c45; continue;  // call 0x2c45
      case 0x2ba4: m.t += 1; m.pas -= 1; m.push(0x2ba7); ip = 0x2c96; continue;  // call 0x2c96
      case 0x2ba7: m.t += 2; m.pas -= 2; m.sub16(m.rw(m.ds, 0x1c35), 0x12f);  // cmp word ptr [0x1c35], 0x12f
      case 0x2bad: if ((m.cf || m.zf)) { ip = 0x2bb5; continue; }  // jbe 0x2bb5
      case 0x2baf: m.t += 1; m.pas -= 1; m.ww(m.ds, 0x1c35, 0x12f);  // mov word ptr [0x1c35], 0x12f
      case 0x2bb5: m.t += 1; m.pas -= 1; m.push(0x2bb8); ip = 0x3c45; continue;  // call 0x3c45
      case 0x2bb8: m.t += 1; m.pas -= 1; ip = m.pop(); continue;  // ret
      default: return ip;
    }
  }
}

// 0x2bb9 sub_7069
function sub_2bb9_2bb9(m, ip) {
  for (;;) {
    if (m.pas <= 0) return ip;
    switch (ip) {
      case 0x2bb9: m.t += 2; m.pas -= 2; m.sub8(m.rb(m.ds, 0x1443), 0x2);  // cmp byte ptr [0x1443], 2
      case 0x2bbe: if (m.zf) { ip = 0x2bc1; continue; }  // je 0x2bc1
      case 0x2bc0: m.t += 1; m.pas -= 1; ip = m.pop(); continue;  // ret
      case 0x2bc1: m.t += 1; m.pas -= 1; m.push(0x2bc4); ip = 0x3b1a; continue;  // call 0x3b1a
      case 0x2bc4: m.t += 2; m.pas -= 2; m.sub8(m.rb(m.ds, 0x14ac), 0x3);  // cmp byte ptr [0x14ac], 3
      case 0x2bc9: if (m.zf) { ip = 0x2bcf; continue; }  // je 0x2bcf
      case 0x2bcb: m.t += 2; m.pas -= 2; m.bx = m.di;  // mov bx, di
      case 0x2bcd: m.cx = m.si;  // mov cx, si
      case 0x2bcf: m.t += 2; m.pas -= 2; m.sub16(m.cx, m.rw(m.ds, 0x14ad));  // cmp cx, word ptr [0x14ad]
      case 0x2bd3: if (m.cf) { ip = 0x2be6; continue; }  // jb 0x2be6
      case 0x2bd5: m.t += 3; m.pas -= 3; m.cx = m.sub16(m.cx, m.rw(m.ds, 0x14ad));  // sub cx, word ptr [0x14ad]
      case 0x2bd9: m.sub16(m.cx, 0x10);  // cmp cx, 0x10
      case 0x2bdc: if (m.cf) { ip = 0x2bf4; continue; }  // jb 0x2bf4
      case 0x2bde: m.t += 2; m.pas -= 2; m.wb(m.ds, 0x1c34, m.or8(m.rb(m.ds, 0x1c34), 0x2));  // or byte ptr [0x1c34], 2
      case 0x2be3: ip = 0x2bf4; continue;  // jmp 0x2bf4
      case 0x2be6: m.t += 3; m.pas -= 3; m.cx = m.sub16(m.cx, m.rw(m.ds, 0x14ad));  // sub cx, word ptr [0x14ad]
      case 0x2bea: m.sub16(m.cx, 0xfff0);  // cmp cx, -0x10
      case 0x2bed: if ((!m.cf && !m.zf)) { ip = 0x2bf4; continue; }  // ja 0x2bf4
      case 0x2bef: m.t += 1; m.pas -= 1; m.wb(m.ds, 0x1c34, m.or8(m.rb(m.ds, 0x1c34), 0x1));  // or byte ptr [0x1c34], 1
      case 0x2bf4: m.t += 2; m.pas -= 2; m.sub16(m.bx, m.rw(m.ds, 0x14af));  // cmp bx, word ptr [0x14af]
      case 0x2bf8: if (m.cf) { ip = 0x2c0b; continue; }  // jb 0x2c0b
      case 0x2bfa: m.t += 3; m.pas -= 3; m.bx = m.sub16(m.bx, m.rw(m.ds, 0x14af));  // sub bx, word ptr [0x14af]
      case 0x2bfe: m.sub16(m.bx, 0x10);  // cmp bx, 0x10
      case 0x2c01: if (m.cf) { ip = 0x2c19; continue; }  // jb 0x2c19
      case 0x2c03: m.t += 2; m.pas -= 2; m.wb(m.ds, 0x1c34, m.or8(m.rb(m.ds, 0x1c34), 0x8));  // or byte ptr [0x1c34], 8
      case 0x2c08: ip = 0x2c19; continue;  // jmp 0x2c19
      case 0x2c0b: m.t += 3; m.pas -= 3; m.bx = m.sub16(m.bx, m.rw(m.ds, 0x14af));  // sub bx, word ptr [0x14af]
      case 0x2c0f: m.sub16(m.bx, 0xfff0);  // cmp bx, -0x10
      case 0x2c12: if ((!m.cf && !m.zf)) { ip = 0x2c19; continue; }  // ja 0x2c19
      case 0x2c14: m.t += 1; m.pas -= 1; m.wb(m.ds, 0x1c34, m.or8(m.rb(m.ds, 0x1c34), 0x4));  // or byte ptr [0x1c34], 4
      case 0x2c19: m.t += 1; m.pas -= 1; m.push(0x2c1c); ip = 0x3b61; continue;  // call 0x3b61
      case 0x2c1c: m.t += 2; m.pas -= 2; m.and16(m.ax, 0x1);  // test ax, 1
      case 0x2c1f: if (m.zf) { ip = 0x2c26; continue; }  // je 0x2c26
      case 0x2c21: m.t += 1; m.pas -= 1; m.wb(m.ds, 0x1c34, m.or8(m.rb(m.ds, 0x1c34), 0x10));  // or byte ptr [0x1c34], 0x10
      case 0x2c26: m.t += 2; m.pas -= 2; m.and16(m.ax, 0x2);  // test ax, 2
      case 0x2c29: if (m.zf) { ip = 0x2c30; continue; }  // je 0x2c30
      case 0x2c2b: m.t += 1; m.pas -= 1; m.wb(m.ds, 0x1c34, m.or8(m.rb(m.ds, 0x1c34), 0x20));  // or byte ptr [0x1c34], 0x20
      case 0x2c30: m.t += 2; m.pas -= 2; m.and16(m.ax, 0x4);  // test ax, 4
      case 0x2c33: if (m.zf) { ip = 0x2c3a; continue; }  // je 0x2c3a
      case 0x2c35: m.t += 1; m.pas -= 1; m.wb(m.ds, 0x1c34, m.or8(m.rb(m.ds, 0x1c34), 0x10));  // or byte ptr [0x1c34], 0x10
      case 0x2c3a: m.t += 2; m.pas -= 2; m.and16(m.ax, 0x8);  // test ax, 8
      case 0x2c3d: if (m.zf) { ip = 0x2c44; continue; }  // je 0x2c44
      case 0x2c3f: m.t += 1; m.pas -= 1; m.wb(m.ds, 0x1c34, m.or8(m.rb(m.ds, 0x1c34), 0x20));  // or byte ptr [0x1c34], 0x20
      case 0x2c44: m.t += 1; m.pas -= 1; ip = m.pop(); continue;  // ret
      default: return ip;
    }
  }
}

// 0x2c45 sub_70f5
function sub_2c45_2c45(m, ip) {
  for (;;) {
    if (m.pas <= 0) return ip;
    switch (ip) {
      case 0x2c45: m.t += 2; m.pas -= 2; m.and8(m.rb(m.ds, 0x1c34), 0x1);  // test byte ptr [0x1c34], 1
      case 0x2c4a: if (m.zf) { ip = 0x2c58; continue; }  // je 0x2c58
      case 0x2c4c: m.t += 2; m.pas -= 2; m.sub16(m.rw(m.ds, 0x1c37), 0x4);  // cmp word ptr [0x1c37], 4
      case 0x2c51: if (m.cf) { ip = 0x2c58; continue; }  // jb 0x2c58
      case 0x2c53: m.t += 1; m.pas -= 1; m.ww(m.ds, 0x1c37, m.sub16(m.rw(m.ds, 0x1c37), 0x4));  // sub word ptr [0x1c37], 4
      case 0x2c58: m.t += 2; m.pas -= 2; m.and8(m.rb(m.ds, 0x1c34), 0x2);  // test byte ptr [0x1c34], 2
      case 0x2c5d: if (m.zf) { ip = 0x2c6c; continue; }  // je 0x2c6c
      case 0x2c5f: m.t += 2; m.pas -= 2; m.sub16(m.rw(m.ds, 0x1c37), 0xc2);  // cmp word ptr [0x1c37], 0xc2
      case 0x2c65: if ((!m.cf && !m.zf)) { ip = 0x2c6c; continue; }  // ja 0x2c6c
      case 0x2c67: m.t += 1; m.pas -= 1; m.ww(m.ds, 0x1c37, m.add16(m.rw(m.ds, 0x1c37), 0x4));  // add word ptr [0x1c37], 4
      case 0x2c6c: m.t += 2; m.pas -= 2; m.and8(m.rb(m.ds, 0x1c34), 0x4);  // test byte ptr [0x1c34], 4
      case 0x2c71: if (m.zf) { ip = 0x2c7f; continue; }  // je 0x2c7f
      case 0x2c73: m.t += 2; m.pas -= 2; m.sub16(m.rw(m.ds, 0x1c35), 0x4);  // cmp word ptr [0x1c35], 4
      case 0x2c78: if (m.cf) { ip = 0x2c7f; continue; }  // jb 0x2c7f
      case 0x2c7a: m.t += 1; m.pas -= 1; m.ww(m.ds, 0x1c35, m.sub16(m.rw(m.ds, 0x1c35), 0x4));  // sub word ptr [0x1c35], 4
      case 0x2c7f: m.t += 2; m.pas -= 2; m.and8(m.rb(m.ds, 0x1c34), 0x8);  // test byte ptr [0x1c34], 8
      case 0x2c84: if (!m.zf) { ip = 0x2c87; continue; }  // jne 0x2c87
      case 0x2c86: m.t += 1; m.pas -= 1; ip = m.pop(); continue;  // ret
      case 0x2c87: m.t += 2; m.pas -= 2; m.sub16(m.rw(m.ds, 0x1c35), 0x13b);  // cmp word ptr [0x1c35], 0x13b
      case 0x2c8d: if ((m.cf || m.zf)) { ip = 0x2c90; continue; }  // jbe 0x2c90
      case 0x2c8f: m.t += 1; m.pas -= 1; ip = m.pop(); continue;  // ret
      case 0x2c90: m.t += 2; m.pas -= 2; m.ww(m.ds, 0x1c35, m.add16(m.rw(m.ds, 0x1c35), 0x4));  // add word ptr [0x1c35], 4
      case 0x2c95: ip = m.pop(); continue;  // ret
      default: return ip;
    }
  }
}

// 0x2c96 sub_7146
function sub_2c96_2c96(m, ip) {
  for (;;) {
    if (m.pas <= 0) return ip;
    switch (ip) {
      case 0x2c96: m.t += 2; m.pas -= 2; m.sub8(m.rb(m.ds, 0x1443), 0x0);  // cmp byte ptr [0x1443], 0
      case 0x2c9b: if (m.zf) { ip = 0x2c9e; continue; }  // je 0x2c9e
      case 0x2c9d: m.t += 1; m.pas -= 1; ip = m.pop(); continue;  // ret
      case 0x2c9e: m.t += 2; m.pas -= 2; m.ax = 0x3;  // mov ax, 3
      case 0x2ca1: if (!m.interruption(0x33)) { m.pas = 0; ip = 0x2ca1; continue; }  // int 0x33
      case 0x2ca3: m.t += 2; m.pas -= 2; m.and16(m.bx, 0x1);  // test bx, 1
      case 0x2ca7: if (m.zf) { ip = 0x2cae; continue; }  // je 0x2cae
      case 0x2ca9: m.t += 1; m.pas -= 1; m.wb(m.ds, 0x1c34, m.or8(m.rb(m.ds, 0x1c34), 0x10));  // or byte ptr [0x1c34], 0x10
      case 0x2cae: m.t += 2; m.pas -= 2; m.and16(m.bx, 0x2);  // test bx, 2
      case 0x2cb2: if (m.zf) { ip = 0x2cb9; continue; }  // je 0x2cb9
      case 0x2cb4: m.t += 1; m.pas -= 1; m.wb(m.ds, 0x1c34, m.or8(m.rb(m.ds, 0x1c34), 0x20));  // or byte ptr [0x1c34], 0x20
      case 0x2cb9: m.t += 3; m.pas -= 3; m.cx = m.shr16(m.cx, 0x1);  // shr cx, 1
      case 0x2cbb: m.sub16(m.cx, m.rw(m.ds, 0x1c35));  // cmp cx, word ptr [0x1c35]
      case 0x2cbf: if (m.zf) { ip = 0x2ccf; continue; }  // je 0x2ccf
      case 0x2cc1: m.t += 1; m.pas -= 1; if (m.cf) { ip = 0x2cca; continue; }  // jb 0x2cca
      case 0x2cc3: m.t += 2; m.pas -= 2; m.wb(m.ds, 0x1c34, m.or8(m.rb(m.ds, 0x1c34), 0x8));  // or byte ptr [0x1c34], 8
      case 0x2cc8: ip = 0x2ccf; continue;  // jmp 0x2ccf
      case 0x2cca: m.t += 1; m.pas -= 1; m.wb(m.ds, 0x1c34, m.or8(m.rb(m.ds, 0x1c34), 0x4));  // or byte ptr [0x1c34], 4
      case 0x2ccf: m.t += 2; m.pas -= 2; m.sub16(m.dx, m.rw(m.ds, 0x1c37));  // cmp dx, word ptr [0x1c37]
      case 0x2cd3: if (m.zf) { ip = 0x2ce4; continue; }  // je 0x2ce4
      case 0x2cd5: m.t += 1; m.pas -= 1; if (m.cf) { ip = 0x2cdf; continue; }  // jb 0x2cdf
      case 0x2cd7: m.t += 2; m.pas -= 2; m.wb(m.ds, 0x1c34, m.or8(m.rb(m.ds, 0x1c34), 0x2));  // or byte ptr [0x1c34], 2
      case 0x2cdc: ip = 0x2ce4; continue;  // jmp 0x2ce4
      case 0x2cdf: m.t += 1; m.pas -= 1; m.wb(m.ds, 0x1c34, m.or8(m.rb(m.ds, 0x1c34), 0x1));  // or byte ptr [0x1c34], 1
      case 0x2ce4: m.t += 3; m.pas -= 3; m.ww(m.ds, 0x1c35, m.cx);  // mov word ptr [0x1c35], cx
      case 0x2ce8: m.ww(m.ds, 0x1c37, m.dx);  // mov word ptr [0x1c37], dx
      case 0x2cec: ip = m.pop(); continue;  // ret
      default: return ip;
    }
  }
}

// 0x2ced sub_719d
function sub_2ced_2ced(m, ip) {
  for (;;) {
    if (m.pas <= 0) return ip;
    switch (ip) {
      case 0x2ced: m.t += 2; m.pas -= 2; m.sub8(m.rb(m.ds, 0x1443), 0x0);  // cmp byte ptr [0x1443], 0
      case 0x2cf2: if (m.zf) { ip = 0x2cf5; continue; }  // je 0x2cf5
      case 0x2cf4: m.t += 1; m.pas -= 1; ip = m.pop(); continue;  // ret
      case 0x2cf5: m.t += 4; m.pas -= 4; m.xor16(0, 0); m.cx = 0;  // xor cx, cx
      case 0x2cf7: m.dx = m.dx;  // mov dx, dx
      case 0x2cf9: m.ax = 0x4;  // mov ax, 4
      case 0x2cfc: if (!m.interruption(0x33)) { m.pas = 0; ip = 0x2cfc; continue; }  // int 0x33
      case 0x2cfe: m.t += 1; m.pas -= 1; ip = m.pop(); continue;  // ret
      default: return ip;
    }
  }
}

// 0x2cff sub_71af
function sub_2cff_2cff(m, ip) {
  for (;;) {
    if (m.pas <= 0) return ip;
    switch (ip) {
      case 0x2cff: m.t += 1; m.pas -= 1; m.push(0x2d02); ip = 0x2b62; continue;  // call 0x2b62
      case 0x2d02: m.t += 2; m.pas -= 2; m.sub8(m.rb(m.ds, 0x1c34), 0x0);  // cmp byte ptr [0x1c34], 0
      case 0x2d07: if (m.zf) { ip = 0x2cff; continue; }  // je 0x2cff
      case 0x2d09: m.t += 1; m.pas -= 1; ip = m.pop(); continue;  // ret
      default: return ip;
    }
  }
}

// 0x2d0a sub_71ba
function sub_2d0a_2d0a(m, ip) {
  for (;;) {
    if (m.pas <= 0) return ip;
    switch (ip) {
      case 0x2d0a: m.t += 1; m.pas -= 1; m.push(0x2d0d); ip = 0x2b62; continue;  // call 0x2b62
      case 0x2d0d: m.t += 2; m.pas -= 2; m.sub8(m.rb(m.ds, 0x1c34), 0x0);  // cmp byte ptr [0x1c34], 0
      case 0x2d12: if (!m.zf) { ip = 0x2d0a; continue; }  // jne 0x2d0a
      case 0x2d14: m.t += 1; m.pas -= 1; ip = m.pop(); continue;  // ret
      case 0x2d15: m.t += 14; m.pas -= 14; m.push(m.drapeaux());  // pushf
      case 0x2d16: m.push(m.ax);  // push ax
      case 0x2d17: m.push(m.bx);  // push bx
      case 0x2d18: m.push(m.cx);  // push cx
      case 0x2d19: m.push(m.dx);  // push dx
      case 0x2d1a: m.push(m.di);  // push di
      case 0x2d1b: m.push(m.si);  // push si
      case 0x2d1c: m.push(m.bp);  // push bp
      case 0x2d1d: m.push(m.es);  // push es
      case 0x2d1e: m.push(m.ds);  // push ds
      case 0x2d1f: m.push(m.ax);  // push ax
      case 0x2d20: m.ax = ((0x0 + m.L) & 0xffff);  // mov ax, 0
      case 0x2d23: m.ds = m.ax;  // mov ds, ax
      case 0x2d25: { const t = m.pop(); m.ax = t; }  // pop ax
      case 0x2d26: m.t += 1; m.pas -= 1; m.push(0x2d29); ip = 0x2b62; continue;  // call 0x2b62
      case 0x2d29: m.t += 2; m.pas -= 2; m.sub8(m.rb(m.ds, 0x1c34), 0x20);  // cmp byte ptr [0x1c34], 0x20
      case 0x2d2e: if (!m.zf) { ip = 0x2d26; continue; }  // jne 0x2d26
      case 0x2d30: m.t += 1; m.pas -= 1; m.push(0x2d33); ip = 0x2d0a; continue;  // call 0x2d0a
      case 0x2d33: m.t += 11; m.pas -= 11; { const t = m.pop(); m.ds = t; }  // pop ds
      case 0x2d34: { const t = m.pop(); m.es = t; }  // pop es
      case 0x2d35: { const t = m.pop(); m.bp = t; }  // pop bp
      case 0x2d36: { const t = m.pop(); m.si = t; }  // pop si
      case 0x2d37: { const t = m.pop(); m.di = t; }  // pop di
      case 0x2d38: { const t = m.pop(); m.dx = t; }  // pop dx
      case 0x2d39: { const t = m.pop(); m.cx = t; }  // pop cx
      case 0x2d3a: { const t = m.pop(); m.bx = t; }  // pop bx
      case 0x2d3b: { const t = m.pop(); m.ax = t; }  // pop ax
      case 0x2d3c: m.poserDrapeaux(m.pop());  // popf
      case 0x2d3d: ip = m.pop(); continue;  // ret
      default: return ip;
    }
  }
}

// 0x2d3e sub_71ee
function sub_2d3e_2d3e(m, ip) {
  for (;;) {
    if (m.pas <= 0) return ip;
    switch (ip) {
      case 0x2d3e: m.t += 14; m.pas -= 14; m.push(m.drapeaux());  // pushf
      case 0x2d3f: m.push(m.ax);  // push ax
      case 0x2d40: m.push(m.bx);  // push bx
      case 0x2d41: m.push(m.cx);  // push cx
      case 0x2d42: m.push(m.dx);  // push dx
      case 0x2d43: m.push(m.di);  // push di
      case 0x2d44: m.push(m.si);  // push si
      case 0x2d45: m.push(m.bp);  // push bp
      case 0x2d46: m.push(m.es);  // push es
      case 0x2d47: m.push(m.ds);  // push ds
      case 0x2d48: m.push(m.ax);  // push ax
      case 0x2d49: m.ax = ((0x0 + m.L) & 0xffff);  // mov ax, 0
      case 0x2d4c: m.ds = m.ax;  // mov ds, ax
      case 0x2d4e: { const t = m.pop(); m.ax = t; }  // pop ax
      case 0x2d4f: m.t += 1; m.pas -= 1; m.push(0x2d52); ip = 0x2b62; continue;  // call 0x2b62
      case 0x2d52: m.t += 2; m.pas -= 2; m.and8(m.rb(m.ds, 0x1c34), 0x10);  // test byte ptr [0x1c34], 0x10
      case 0x2d57: if (m.zf) { ip = 0x2d4f; continue; }  // je 0x2d4f
      case 0x2d59: m.t += 11; m.pas -= 11; { const t = m.pop(); m.ds = t; }  // pop ds
      case 0x2d5a: { const t = m.pop(); m.es = t; }  // pop es
      case 0x2d5b: { const t = m.pop(); m.bp = t; }  // pop bp
      case 0x2d5c: { const t = m.pop(); m.si = t; }  // pop si
      case 0x2d5d: { const t = m.pop(); m.di = t; }  // pop di
      case 0x2d5e: { const t = m.pop(); m.dx = t; }  // pop dx
      case 0x2d5f: { const t = m.pop(); m.cx = t; }  // pop cx
      case 0x2d60: { const t = m.pop(); m.bx = t; }  // pop bx
      case 0x2d61: { const t = m.pop(); m.ax = t; }  // pop ax
      case 0x2d62: m.poserDrapeaux(m.pop());  // popf
      case 0x2d63: ip = m.pop(); continue;  // ret
      default: return ip;
    }
  }
}

// 0x2d64 sub_7214
function sub_2d64_2d64(m, ip) {
  for (;;) {
    if (m.pas <= 0) return ip;
    switch (ip) {
      case 0x2d64: m.t += 14; m.pas -= 14; m.push(m.drapeaux());  // pushf
      case 0x2d65: m.push(m.ax);  // push ax
      case 0x2d66: m.push(m.bx);  // push bx
      case 0x2d67: m.push(m.cx);  // push cx
      case 0x2d68: m.push(m.dx);  // push dx
      case 0x2d69: m.push(m.di);  // push di
      case 0x2d6a: m.push(m.si);  // push si
      case 0x2d6b: m.push(m.bp);  // push bp
      case 0x2d6c: m.push(m.es);  // push es
      case 0x2d6d: m.push(m.ds);  // push ds
      case 0x2d6e: m.push(m.ax);  // push ax
      case 0x2d6f: m.ax = ((0x0 + m.L) & 0xffff);  // mov ax, 0
      case 0x2d72: m.ds = m.ax;  // mov ds, ax
      case 0x2d74: { const t = m.pop(); m.ax = t; }  // pop ax
      case 0x2d75: m.t += 1; m.pas -= 1; m.push(0x2d78); ip = 0x2b62; continue;  // call 0x2b62
      case 0x2d78: m.t += 2; m.pas -= 2; m.and8(m.rb(m.ds, 0x1c34), 0x10);  // test byte ptr [0x1c34], 0x10
      case 0x2d7d: if (!m.zf) { ip = 0x2d75; continue; }  // jne 0x2d75
      case 0x2d7f: m.t += 2; m.pas -= 2; m.and8(m.rb(m.ds, 0x1c34), 0x20);  // test byte ptr [0x1c34], 0x20
      case 0x2d84: if (!m.zf) { ip = 0x2d75; continue; }  // jne 0x2d75
      case 0x2d86: m.t += 11; m.pas -= 11; { const t = m.pop(); m.ds = t; }  // pop ds
      case 0x2d87: { const t = m.pop(); m.es = t; }  // pop es
      case 0x2d88: { const t = m.pop(); m.bp = t; }  // pop bp
      case 0x2d89: { const t = m.pop(); m.si = t; }  // pop si
      case 0x2d8a: { const t = m.pop(); m.di = t; }  // pop di
      case 0x2d8b: { const t = m.pop(); m.dx = t; }  // pop dx
      case 0x2d8c: { const t = m.pop(); m.cx = t; }  // pop cx
      case 0x2d8d: { const t = m.pop(); m.bx = t; }  // pop bx
      case 0x2d8e: { const t = m.pop(); m.ax = t; }  // pop ax
      case 0x2d8f: m.poserDrapeaux(m.pop());  // popf
      case 0x2d90: ip = m.pop(); continue;  // ret
      default: return ip;
    }
  }
}

// 0x2d91 sub_7241
function sub_2d91_2d91(m, ip) {
  for (;;) {
    if (m.pas <= 0) return ip;
    switch (ip) {
      case 0x2d91: m.t += 2; m.pas -= 2; m.ww(m.ds, 0x1a8b, 0x0);  // mov word ptr [0x1a8b], 0
      case 0x2d97: m.push(0x2d9a); ip = 0x2b01; continue;  // call 0x2b01
      case 0x2d9a: m.t += 1; m.pas -= 1; m.push(0x2d9d); ip = 0x2dd8; continue;  // call 0x2dd8
      case 0x2d9d: m.t += 2; m.pas -= 2; m.sub16(m.rw(m.ds, 0x1a8b), 0x0);  // cmp word ptr [0x1a8b], 0
      case 0x2da2: if (m.zf) { ip = 0x2da7; continue; }  // je 0x2da7
      case 0x2da4: m.t += 1; m.pas -= 1; ip = 0x2dc2; continue;  // jmp 0x2dc2
      case 0x2da7: m.t += 1; m.pas -= 1; m.push(0x2daa); ip = 0x2e0c; continue;  // call 0x2e0c
      case 0x2daa: m.t += 2; m.pas -= 2; m.ww(m.ds, 0x1ba7, m.ax);  // mov word ptr [0x1ba7], ax
      case 0x2dad: ip = 0x2dbf; continue;  // jmp 0x2dbf
      default: return ip;
    }
  }
}

// 0x2db0 sub_7260
function sub_2db0_2db0(m, ip) {
  for (;;) {
    if (m.pas <= 0) return ip;
    switch (ip) {
      case 0x2db0: m.t += 2; m.pas -= 2; m.ww(m.ds, 0x1a8b, 0x0);  // mov word ptr [0x1a8b], 0
      case 0x2db6: m.push(0x2db9); ip = 0x2b01; continue;  // call 0x2b01
      case 0x2db9: m.t += 1; m.pas -= 1; m.push(0x2dbc); ip = 0x2dc6; continue;  // call 0x2dc6
      case 0x2dbc: m.t += 1; m.pas -= 1; m.push(0x2dbf); ip = 0x2df2; continue;  // call 0x2df2
      case 0x2dbf: m.t += 1; m.pas -= 1; m.push(0x2dc2); ip = 0x2e24; continue;  // call 0x2e24
      case 0x2dc2: m.t += 1; m.pas -= 1; m.push(0x2dc5); ip = 0x2aca; continue;  // call 0x2aca
      case 0x2dc5: m.t += 1; m.pas -= 1; ip = m.pop(); continue;  // ret
      default: return ip;
    }
  }
}

// 0x2dc6 sub_7276
function sub_2dc6_2dc6(m, ip) {
  for (;;) {
    if (m.pas <= 0) return ip;
    switch (ip) {
      case 0x2dc6: m.t += 5; m.pas -= 5; m.dx = m.rw(m.ds, 0x1ba9);  // mov dx, word ptr [0x1ba9]
      case 0x2dca: m.xor16(0, 0); m.cx = 0;  // xor cx, cx
      case 0x2dcc: m.ax = (m.ax & 0xff00) | 0x2;  // mov al, 2
      case 0x2dce: m.ax = (m.ax & 0xff) | (0x3c << 8);  // mov ah, 0x3c
      case 0x2dd0: if (!m.interruption(0x21)) { m.pas = 0; ip = 0x2dd0; continue; }  // int 0x21
      case 0x2dd2: m.t += 1; m.pas -= 1; if (m.cf) { ip = 0x2dee; continue; }  // jb 0x2dee
      case 0x2dd4: m.t += 2; m.pas -= 2; m.ww(m.ds, 0x1bab, m.ax);  // mov word ptr [0x1bab], ax
      case 0x2dd7: ip = m.pop(); continue;  // ret
      default: return ip;
    }
  }
}

// 0x2dd8 sub_7288
function sub_2dd8_2dd8(m, ip) {
  for (;;) {
    if (m.pas <= 0) return ip;
    switch (ip) {
      case 0x2dd8: m.t += 4; m.pas -= 4; m.dx = m.rw(m.ds, 0x1ba9);  // mov dx, word ptr [0x1ba9]
      case 0x2ddc: m.xor8(0, 0); m.ax = (m.ax & 0xff00) | 0;  // xor al, al
      case 0x2dde: m.ax = (m.ax & 0xff) | (0x3d << 8);  // mov ah, 0x3d
      case 0x2de0: if (!m.interruption(0x21)) { m.pas = 0; ip = 0x2de0; continue; }  // int 0x21
      case 0x2de2: m.t += 1; m.pas -= 1; if (m.cf) { ip = 0x2dee; continue; }  // jb 0x2dee
      case 0x2de4: m.t += 3; m.pas -= 3; m.ww(m.ds, 0x1a8b, 0x0);  // mov word ptr [0x1a8b], 0
      case 0x2dea: m.ww(m.ds, 0x1bab, m.ax);  // mov word ptr [0x1bab], ax
      case 0x2ded: ip = m.pop(); continue;  // ret
      case 0x2dee: m.t += 2; m.pas -= 2; m.ww(m.ds, 0x1a8b, m.ax);  // mov word ptr [0x1a8b], ax
      case 0x2df1: ip = m.pop(); continue;  // ret
      default: return ip;
    }
  }
}

// 0x2df2 sub_72a2
function sub_2df2_2df2(m, ip) {
  for (;;) {
    if (m.pas <= 0) return ip;
    switch (ip) {
      case 0x2df2: m.t += 8; m.pas -= 8; m.ax = m.rw(m.ds, 0x1ba3);  // mov ax, word ptr [0x1ba3]
      case 0x2df5: m.bx = m.rw(m.ds, 0x1bab);  // mov bx, word ptr [0x1bab]
      case 0x2df9: m.cx = m.rw(m.ds, 0x1ba7);  // mov cx, word ptr [0x1ba7]
      case 0x2dfd: m.dx = m.rw(m.ds, 0x1ba5);  // mov dx, word ptr [0x1ba5]
      case 0x2e01: m.push(m.ds);  // push ds
      case 0x2e02: m.ds = m.ax;  // mov ds, ax
      case 0x2e04: m.ax = (m.ax & 0xff) | (0x40 << 8);  // mov ah, 0x40
      case 0x2e06: if (!m.interruption(0x21)) { m.pas = 0; ip = 0x2e06; continue; }  // int 0x21
      case 0x2e08: m.t += 2; m.pas -= 2; { const t = m.pop(); m.ds = t; }  // pop ds
      case 0x2e09: if (m.cf) { ip = 0x2dee; continue; }  // jb 0x2dee
      case 0x2e0b: m.t += 1; m.pas -= 1; ip = m.pop(); continue;  // ret
      default: return ip;
    }
  }
}

// 0x2e0c sub_72bc
function sub_2e0c_2e0c(m, ip) {
  for (;;) {
    if (m.pas <= 0) return ip;
    switch (ip) {
      case 0x2e0c: m.t += 8; m.pas -= 8; m.ax = m.rw(m.ds, 0x1ba3);  // mov ax, word ptr [0x1ba3]
      case 0x2e0f: m.bx = m.rw(m.ds, 0x1bab);  // mov bx, word ptr [0x1bab]
      case 0x2e13: m.cx = 0xffff;  // mov cx, 0xffff
      case 0x2e16: m.dx = m.rw(m.ds, 0x1ba5);  // mov dx, word ptr [0x1ba5]
      case 0x2e1a: m.push(m.ds);  // push ds
      case 0x2e1b: m.ds = m.ax;  // mov ds, ax
      case 0x2e1d: m.ax = (m.ax & 0xff) | (0x3f << 8);  // mov ah, 0x3f
      case 0x2e1f: if (!m.interruption(0x21)) { m.pas = 0; ip = 0x2e1f; continue; }  // int 0x21
      case 0x2e21: m.t += 2; m.pas -= 2; { const t = m.pop(); m.ds = t; }  // pop ds
      case 0x2e22: if (m.cf) { ip = 0x2dee; continue; }  // jb 0x2dee
        ip = 0x2e24; continue;
      default: return ip;
    }
  }
}

// 0x2e24 sub_72d4
function sub_2e24_2e24(m, ip) {
  for (;;) {
    if (m.pas <= 0) return ip;
    switch (ip) {
      case 0x2e24: m.t += 3; m.pas -= 3; m.bx = m.rw(m.ds, 0x1bab);  // mov bx, word ptr [0x1bab]
      case 0x2e28: m.ax = (m.ax & 0xff) | (0x3e << 8);  // mov ah, 0x3e
      case 0x2e2a: if (!m.interruption(0x21)) { m.pas = 0; ip = 0x2e2a; continue; }  // int 0x21
      case 0x2e2c: m.t += 1; m.pas -= 1; if (m.cf) { ip = 0x2dee; continue; }  // jb 0x2dee
      case 0x2e2e: m.t += 1; m.pas -= 1; ip = m.pop(); continue;  // ret
      default: return ip;
    }
  }
}

// 0x2e2f sub_72df
function sub_2e2f_2e2f(m, ip) {
  for (;;) {
    if (m.pas <= 0) return ip;
    switch (ip) {
      case 0x2e2f: m.t += 9; m.pas -= 9; m.ww(m.ds, 0x1d26, m.cx);  // mov word ptr [0x1d26], cx
      case 0x2e33: m.ww(m.ds, 0x1d28, m.di);  // mov word ptr [0x1d28], di
      case 0x2e37: m.push(m.ax);  // push ax
      case 0x2e38: m.ax = ((0x0 + m.L) & 0xffff);  // mov ax, 0
      case 0x2e3b: m.es = m.ax;  // mov es, ax
      case 0x2e3d: { const t = m.pop(); m.ax = t; }  // pop ax
      case 0x2e3e: m.ax = 0x20;  // mov ax, 0x20
      case 0x2e41: m.stosb(m.ds, 1);  // rep stosb byte ptr es:[di], al
      case 0x2e43: m.ww(m.ds, 0x1d2a, 0x0);  // mov word ptr [0x1d2a], 0
      case 0x2e49: m.t += 1; m.pas -= 1; m.push(0x2e4c); ip = 0x29e5; continue;  // call 0x29e5
      case 0x2e4c: m.t += 2; m.pas -= 2; m.sub8((m.ax & 0xff), 0xd);  // cmp al, 0xd
      case 0x2e4e: if (!m.zf) { ip = 0x2e51; continue; }  // jne 0x2e51
      case 0x2e50: m.t += 1; m.pas -= 1; ip = m.pop(); continue;  // ret
      case 0x2e51: m.t += 2; m.pas -= 2; m.sub8((m.ax >> 8), 0xe);  // cmp ah, 0xe
      case 0x2e54: if (m.zf) { ip = 0x2e90; continue; }  // je 0x2e90
      case 0x2e56: m.t += 2; m.pas -= 2; m.sub8((m.ax & 0xff), 0x20);  // cmp al, 0x20
      case 0x2e58: if (m.cf) { ip = 0x2e49; continue; }  // jb 0x2e49
      case 0x2e5a: m.t += 2; m.pas -= 2; m.sub8((m.ax & 0xff), 0x7a);  // cmp al, 0x7a
      case 0x2e5c: if ((!m.cf && !m.zf)) { ip = 0x2e49; continue; }  // ja 0x2e49
      case 0x2e5e: m.t += 2; m.pas -= 2; m.sub8(m.rb(m.ds, 0x1d2c), 0x1);  // cmp byte ptr [0x1d2c], 1
      case 0x2e63: if (!m.zf) { ip = 0x2e6d; continue; }  // jne 0x2e6d
      case 0x2e65: m.t += 2; m.pas -= 2; m.sub8((m.ax & 0xff), 0x30);  // cmp al, 0x30
      case 0x2e67: if (m.cf) { ip = 0x2e49; continue; }  // jb 0x2e49
      case 0x2e69: m.t += 2; m.pas -= 2; m.sub8((m.ax & 0xff), 0x39);  // cmp al, 0x39
      case 0x2e6b: if ((!m.cf && !m.zf)) { ip = 0x2e49; continue; }  // ja 0x2e49
      case 0x2e6d: m.t += 3; m.pas -= 3; m.bx = m.rw(m.ds, 0x1d2a);  // mov bx, word ptr [0x1d2a]
      case 0x2e71: m.sub16(m.bx, m.rw(m.ds, 0x1d26));  // cmp bx, word ptr [0x1d26]
      case 0x2e75: if (!m.cf) { ip = 0x2e49; continue; }  // jae 0x2e49
      case 0x2e77: m.t += 8; m.pas -= 8; m.push(m.ax);  // push ax
      case 0x2e78: m.ax = ((0x0 + m.L) & 0xffff);  // mov ax, 0
      case 0x2e7b: m.es = m.ax;  // mov es, ax
      case 0x2e7d: { const t = m.pop(); m.ax = t; }  // pop ax
      case 0x2e7e: m.di = m.rw(m.ds, 0x1d28);  // mov di, word ptr [0x1d28]
      case 0x2e82: m.stosb(m.ds, 0);  // stosb byte ptr es:[di], al
      case 0x2e83: m.ww(m.ds, 0x1d28, m.di);  // mov word ptr [0x1d28], di
      case 0x2e87: m.push(0x2e8a); ip = 0x259b; continue;  // call 0x259b
      case 0x2e8a: m.t += 2; m.pas -= 2; m.ww(m.ds, 0x1d2a, m.inc16(m.rw(m.ds, 0x1d2a)));  // inc word ptr [0x1d2a]
      case 0x2e8e: ip = 0x2e49; continue;  // jmp 0x2e49
      case 0x2e90: m.t += 2; m.pas -= 2; m.sub16(m.rw(m.ds, 0x1d2a), 0x0);  // cmp word ptr [0x1d2a], 0
      case 0x2e95: if (m.zf) { ip = 0x2e49; continue; }  // je 0x2e49
      case 0x2e97: m.t += 7; m.pas -= 7; m.ww(m.ds, 0x19f4, m.dec16(m.rw(m.ds, 0x19f4)));  // dec word ptr [0x19f4]
      case 0x2e9b: m.ax = (m.ax & 0xff00) | 0x20;  // mov al, 0x20
      case 0x2e9d: m.di = m.rw(m.ds, 0x1d28);  // mov di, word ptr [0x1d28]
      case 0x2ea1: m.di = m.dec16(m.di);  // dec di
      case 0x2ea2: m.wb(m.ds, m.di, (m.ax & 0xff));  // mov byte ptr [di], al
      case 0x2ea4: m.ww(m.ds, 0x1d28, m.di);  // mov word ptr [0x1d28], di
      case 0x2ea8: m.push(0x2eab); ip = 0x259b; continue;  // call 0x259b
      case 0x2eab: m.t += 3; m.pas -= 3; m.ww(m.ds, 0x19f4, m.dec16(m.rw(m.ds, 0x19f4)));  // dec word ptr [0x19f4]
      case 0x2eaf: m.ww(m.ds, 0x1d2a, m.dec16(m.rw(m.ds, 0x1d2a)));  // dec word ptr [0x1d2a]
      case 0x2eb3: ip = 0x2e49; continue;  // jmp 0x2e49
      default: return ip;
    }
  }
}

// 0x2eb5 sub_7365
function sub_2eb5_2eb5(m, ip) {
  for (;;) {
    if (m.pas <= 0) return ip;
    switch (ip) {
      case 0x2eb5: m.t += 4; m.pas -= 4; m.wb(m.ds, 0x1d2c, 0x1);  // mov byte ptr [0x1d2c], 1
      case 0x2eba: m.di = 0x1a95;  // mov di, 0x1a95
      case 0x2ebd: m.cx = 0x2;  // mov cx, 2
      case 0x2ec0: m.push(0x2ec3); ip = 0x2e2f; continue;  // call 0x2e2f
      case 0x2ec3: m.t += 2; m.pas -= 2; m.sub16(m.rw(m.ds, 0x1d2a), 0x0);  // cmp word ptr [0x1d2a], 0
      case 0x2ec8: if (m.zf) { ip = 0x2eb5; continue; }  // je 0x2eb5
      case 0x2eca: m.t += 5; m.pas -= 5; m.wb(m.ds, 0x1d2c, 0x0);  // mov byte ptr [0x1d2c], 0
      case 0x2ecf: m.cx = m.rw(m.ds, 0x1d2a);  // mov cx, word ptr [0x1d2a]
      case 0x2ed3: m.di = 0x1a95;  // mov di, 0x1a95
      case 0x2ed6: m.xor16(0, 0); m.ax = 0;  // xor ax, ax
      case 0x2ed8: m.dx = (m.dx & 0xff00) | 0xa;  // mov dl, 0xa
      case 0x2eda: m.t += 6; m.pas -= 6; m.bx = (m.bx & 0xff00) | m.rb(m.ds, m.di);  // mov bl, byte ptr [di]
      case 0x2edc: m.di = m.inc16(m.di);  // inc di
      case 0x2edd: m.bx = (m.bx & 0xff00) | m.sub8((m.bx & 0xff), 0x30);  // sub bl, 0x30
      case 0x2ee0: m.mul8((m.dx & 0xff));  // mul dl
      case 0x2ee2: m.ax = (m.ax & 0xff00) | m.add8((m.ax & 0xff), (m.bx & 0xff));  // add al, bl
      case 0x2ee4: m.cx = (m.cx - 1) & 0xffff; if (m.cx !== 0) { ip = 0x2eda; continue; }  // loop 0x2eda
      case 0x2ee6: m.t += 2; m.pas -= 2; m.xor8(0, 0); m.ax = (m.ax & 0xff) | (0 << 8);  // xor ah, ah
      case 0x2ee8: ip = m.pop(); continue;  // ret
      default: return ip;
    }
  }
}

// 0x2ee9 sub_7399
function sub_2ee9_2ee9(m, ip) {
  for (;;) {
    if (m.pas <= 0) return ip;
    switch (ip) {
      case 0x2ee9: m.t += 38; m.pas -= 38; m.push(m.drapeaux());  // pushf
      case 0x2eea: m.push(m.ax);  // push ax
      case 0x2eeb: m.push(m.bx);  // push bx
      case 0x2eec: m.push(m.cx);  // push cx
      case 0x2eed: m.push(m.dx);  // push dx
      case 0x2eee: m.push(m.di);  // push di
      case 0x2eef: m.push(m.si);  // push si
      case 0x2ef0: m.push(m.bp);  // push bp
      case 0x2ef1: m.push(m.es);  // push es
      case 0x2ef2: m.push(m.ds);  // push ds
      case 0x2ef3: m.ax = m.di;  // mov ax, di
      case 0x2ef5: m.xor16(0, 0); m.dx = 0;  // xor dx, dx
      case 0x2ef7: m.cx = 0x140;  // mov cx, 0x140
      case 0x2efa: m.div16(m.cx);  // div cx
      case 0x2efc: m.push(m.dx);  // push dx
      case 0x2efd: m.cx = 0xa0;  // mov cx, 0xa0
      case 0x2f00: m.mul16(m.cx);  // mul cx
      case 0x2f02: m.dx = m.ax;  // mov dx, ax
      case 0x2f04: { const t = m.pop(); m.ax = t; }  // pop ax
      case 0x2f05: m.cx = m.ax;  // mov cx, ax
      case 0x2f07: m.cx = (m.cx & 0xff00) | m.and8((m.cx & 0xff), 0x7);  // and cl, 7
      case 0x2f0a: m.ww(m.ds, 0x1a9b, m.cx);  // mov word ptr [0x1a9b], cx
      case 0x2f0e: m.ax = m.shr16(m.ax, 0x1);  // shr ax, 1
      case 0x2f10: m.ax = m.shr16(m.ax, 0x1);  // shr ax, 1
      case 0x2f12: m.ax = m.shr16(m.ax, 0x1);  // shr ax, 1
      case 0x2f14: m.ax = m.add16(m.ax, m.dx);  // add ax, dx
      case 0x2f16: m.ww(m.ds, 0x1a9d, m.ax);  // mov word ptr [0x1a9d], ax
      case 0x2f19: { const t = m.pop(); m.ds = t; }  // pop ds
      case 0x2f1a: { const t = m.pop(); m.es = t; }  // pop es
      case 0x2f1b: { const t = m.pop(); m.bp = t; }  // pop bp
      case 0x2f1c: { const t = m.pop(); m.si = t; }  // pop si
      case 0x2f1d: { const t = m.pop(); m.di = t; }  // pop di
      case 0x2f1e: { const t = m.pop(); m.dx = t; }  // pop dx
      case 0x2f1f: { const t = m.pop(); m.cx = t; }  // pop cx
      case 0x2f20: { const t = m.pop(); m.bx = t; }  // pop bx
      case 0x2f21: { const t = m.pop(); m.ax = t; }  // pop ax
      case 0x2f22: m.poserDrapeaux(m.pop());  // popf
      case 0x2f23: ip = m.pop(); continue;  // ret
      default: return ip;
    }
  }
}

// 0x2f24 sub_73d4
function sub_2f24_2f24(m, ip) {
  for (;;) {
    if (m.pas <= 0) return ip;
    switch (ip) {
      case 0x2f24: m.t += 13; m.pas -= 13; m.push(m.drapeaux());  // pushf
      case 0x2f25: m.push(m.ax);  // push ax
      case 0x2f26: m.push(m.bx);  // push bx
      case 0x2f27: m.push(m.cx);  // push cx
      case 0x2f28: m.push(m.dx);  // push dx
      case 0x2f29: m.push(m.di);  // push di
      case 0x2f2a: m.push(m.si);  // push si
      case 0x2f2b: m.push(m.bp);  // push bp
      case 0x2f2c: m.push(m.es);  // push es
      case 0x2f2d: m.push(m.ds);  // push ds
      case 0x2f2e: m.ww(m.ds, 0x1a9b, 0x0);  // mov word ptr [0x1a9b], 0
      case 0x2f34: m.di = m.shr16(m.di, 0x1);  // shr di, 1
      case 0x2f36: if (!m.cf) { ip = 0x2f3e; continue; }  // jae 0x2f3e
      case 0x2f38: m.t += 1; m.pas -= 1; m.ww(m.ds, 0x1a9b, 0x1);  // mov word ptr [0x1a9b], 1
      case 0x2f3e: m.t += 20; m.pas -= 20; m.ax = m.di;  // mov ax, di
      case 0x2f40: m.xor16(0, 0); m.dx = 0;  // xor dx, dx
      case 0x2f42: m.cx = 0xa0;  // mov cx, 0xa0
      case 0x2f45: m.div16(m.cx);  // div cx
      case 0x2f47: m.bx = m.ax;  // mov bx, ax
      case 0x2f49: m.bx = m.shl16(m.bx, 0x1);  // shl bx, 1
      case 0x2f4b: m.di = m.rw(m.ds, ((m.bx + 0x1d2d) & 0xffff));  // mov di, word ptr [bx + 0x1d2d]
      case 0x2f4f: m.di = m.add16(m.di, m.dx);  // add di, dx
      case 0x2f51: m.ww(m.ds, 0x1a9d, m.di);  // mov word ptr [0x1a9d], di
      case 0x2f55: { const t = m.pop(); m.ds = t; }  // pop ds
      case 0x2f56: { const t = m.pop(); m.es = t; }  // pop es
      case 0x2f57: { const t = m.pop(); m.bp = t; }  // pop bp
      case 0x2f58: { const t = m.pop(); m.si = t; }  // pop si
      case 0x2f59: { const t = m.pop(); m.di = t; }  // pop di
      case 0x2f5a: { const t = m.pop(); m.dx = t; }  // pop dx
      case 0x2f5b: { const t = m.pop(); m.cx = t; }  // pop cx
      case 0x2f5c: { const t = m.pop(); m.bx = t; }  // pop bx
      case 0x2f5d: { const t = m.pop(); m.ax = t; }  // pop ax
      case 0x2f5e: m.poserDrapeaux(m.pop());  // popf
      case 0x2f5f: ip = m.pop(); continue;  // ret
      default: return ip;
    }
  }
}

// 0x2f60 sub_7410
function sub_2f60_2f60(m, ip) {
  for (;;) {
    if (m.pas <= 0) return ip;
    switch (ip) {
      case 0x2f60: m.t += 3; m.pas -= 3; m.bx = 0x19c8;  // mov bx, 0x19c8
      case 0x2f63: m.bx = m.add16(m.bx, m.rw(m.ds, 0x1440));  // add bx, word ptr [0x1440]
      case 0x2f67: ip = m.rw(m.ds, m.bx); continue;  // jmp word ptr [bx]
      case 0x2f69: m.t += 1; m.pas -= 1; m.push(0x2f6c); ip = 0x2ee9; continue;  // call 0x2ee9
      case 0x2f6c: m.t += 14; m.pas -= 14; m.ax = m.rw(m.ds, 0x1a9b);  // mov ax, word ptr [0x1a9b]
      case 0x2f6f: m.di = m.rw(m.ds, 0x1a9d);  // mov di, word ptr [0x1a9d]
      case 0x2f73: m.push(m.ax);  // push ax
      case 0x2f74: m.ax = m.rw(m.ds, 0x19f0);  // mov ax, word ptr [0x19f0]
      case 0x2f77: m.ds = m.ax;  // mov ds, ax
      case 0x2f79: m.bp = m.shr16(m.bp, 0x1);  // shr bp, 1
      case 0x2f7b: m.bp = m.shr16(m.bp, 0x1);  // shr bp, 1
      case 0x2f7d: m.bp = m.shr16(m.bp, 0x1);  // shr bp, 1
      case 0x2f7f: m.si = m.shr16(m.si, 0x1);  // shr si, 1
      case 0x2f81: m.bx = 0x28;  // mov bx, 0x28
      case 0x2f84: m.bx = m.sub16(m.bx, m.bp);  // sub bx, bp
      case 0x2f86: { const t = m.pop(); m.ax = t; }  // pop ax
      case 0x2f87: m.ax = m.or16(m.ax, m.ax);  // or ax, ax
      case 0x2f89: if (!m.zf) { ip = 0x2ff4; continue; }  // jne 0x2ff4
      case 0x2f8b: m.t += 2; m.pas -= 2; m.dx = m.cx;  // mov dx, cx
      case 0x2f8d: m.cx = m.bp;  // mov cx, bp
      case 0x2f8f: m.t += 37; m.pas -= 37; m.ax = (m.ax & 0xff) | (m.rb(m.ds, m.si) << 8);  // mov ah, byte ptr [si]
      case 0x2f91: m.push(m.si);  // push si
      case 0x2f92: m.si = m.add16(m.si, m.bp);  // add si, bp
      case 0x2f94: m.ax = (m.ax & 0xff) | (m.or8((m.ax >> 8), m.rb(m.ds, m.si)) << 8);  // or ah, byte ptr [si]
      case 0x2f96: m.si = m.add16(m.si, m.bp);  // add si, bp
      case 0x2f98: m.ax = (m.ax & 0xff) | (m.or8((m.ax >> 8), m.rb(m.ds, m.si)) << 8);  // or ah, byte ptr [si]
      case 0x2f9a: m.si = m.add16(m.si, m.bp);  // add si, bp
      case 0x2f9c: m.ax = (m.ax & 0xff) | (m.or8((m.ax >> 8), m.rb(m.ds, m.si)) << 8);  // or ah, byte ptr [si]
      case 0x2f9e: { const t = m.pop(); m.si = t; }  // pop si
      case 0x2f9f: m.ax = (m.ax & 0xff) | ((~(m.ax >> 8) & 0xff) << 8);  // not ah
      case 0x2fa1: m.push(m.si);  // push si
      case 0x2fa2: m.push(m.di);  // push di
      case 0x2fa3: m.ax = (m.ax & 0xff00) | m.rb(m.ds, m.si);  // mov al, byte ptr [si]
      case 0x2fa5: m.wb(m.es, m.di, m.and8(m.rb(m.es, m.di), (m.ax >> 8)));  // and byte ptr es:[di], ah
      case 0x2fa8: m.wb(m.es, m.di, m.or8(m.rb(m.es, m.di), (m.ax & 0xff)));  // or byte ptr es:[di], al
      case 0x2fab: m.si = m.add16(m.si, m.bp);  // add si, bp
      case 0x2fad: m.di = m.add16(m.di, 0x28);  // add di, 0x28
      case 0x2fb0: m.ax = (m.ax & 0xff00) | m.rb(m.ds, m.si);  // mov al, byte ptr [si]
      case 0x2fb2: m.wb(m.es, m.di, m.and8(m.rb(m.es, m.di), (m.ax >> 8)));  // and byte ptr es:[di], ah
      case 0x2fb5: m.wb(m.es, m.di, m.or8(m.rb(m.es, m.di), (m.ax & 0xff)));  // or byte ptr es:[di], al
      case 0x2fb8: m.si = m.add16(m.si, m.bp);  // add si, bp
      case 0x2fba: m.di = m.add16(m.di, 0x28);  // add di, 0x28
      case 0x2fbd: m.ax = (m.ax & 0xff00) | m.rb(m.ds, m.si);  // mov al, byte ptr [si]
      case 0x2fbf: m.wb(m.es, m.di, m.and8(m.rb(m.es, m.di), (m.ax >> 8)));  // and byte ptr es:[di], ah
      case 0x2fc2: m.wb(m.es, m.di, m.or8(m.rb(m.es, m.di), (m.ax & 0xff)));  // or byte ptr es:[di], al
      case 0x2fc5: m.si = m.add16(m.si, m.bp);  // add si, bp
      case 0x2fc7: m.di = m.add16(m.di, 0x28);  // add di, 0x28
      case 0x2fca: m.ax = (m.ax & 0xff00) | m.rb(m.ds, m.si);  // mov al, byte ptr [si]
      case 0x2fcc: m.wb(m.es, m.di, m.and8(m.rb(m.es, m.di), (m.ax >> 8)));  // and byte ptr es:[di], ah
      case 0x2fcf: m.wb(m.es, m.di, m.or8(m.rb(m.es, m.di), (m.ax & 0xff)));  // or byte ptr es:[di], al
      case 0x2fd2: m.si = m.add16(m.si, m.bp);  // add si, bp
      case 0x2fd4: m.di = m.add16(m.di, 0x28);  // add di, 0x28
      case 0x2fd7: { const t = m.pop(); m.di = t; }  // pop di
      case 0x2fd8: { const t = m.pop(); m.si = t; }  // pop si
      case 0x2fd9: m.si = m.inc16(m.si);  // inc si
      case 0x2fda: m.di = m.inc16(m.di);  // inc di
      case 0x2fdb: m.cx = (m.cx - 1) & 0xffff; if (m.cx !== 0) { ip = 0x2f8f; continue; }  // loop 0x2f8f
      case 0x2fdd: m.t += 7; m.pas -= 7; m.si = m.add16(m.si, m.bp);  // add si, bp
      case 0x2fdf: m.si = m.add16(m.si, m.bp);  // add si, bp
      case 0x2fe1: m.si = m.add16(m.si, m.bp);  // add si, bp
      case 0x2fe3: m.di = m.add16(m.di, m.bx);  // add di, bx
      case 0x2fe5: m.di = m.add16(m.di, 0x78);  // add di, 0x78
      case 0x2fe8: m.cx = m.dx;  // mov cx, dx
      case 0x2fea: m.cx = (m.cx - 1) & 0xffff; if (m.cx !== 0) { ip = 0x2f8b; continue; }  // loop 0x2f8b
      case 0x2fec: m.t += 5; m.pas -= 5; m.push(m.ax);  // push ax
      case 0x2fed: m.ax = ((0x0 + m.L) & 0xffff);  // mov ax, 0
      case 0x2ff0: m.ds = m.ax;  // mov ds, ax
      case 0x2ff2: { const t = m.pop(); m.ax = t; }  // pop ax
      case 0x2ff3: ip = m.pop(); continue;  // ret
      case 0x2ff4: m.t += 2; m.pas -= 2; m.ww(m.cs, 0x2502, m.cx);  // mov word ptr cs:[0x2502], cx
      case 0x2ff9: m.cx = m.ax;  // mov cx, ax
      case 0x2ffb: m.t += 50; m.pas -= 50; m.push(m.di);  // push di
      case 0x2ffc: m.push(m.si);  // push si
      case 0x2ffd: m.ax = (m.ax & 0xff) | (m.rb(m.ds, m.si) << 8);  // mov ah, byte ptr [si]
      case 0x2fff: m.push(m.si);  // push si
      case 0x3000: m.si = m.add16(m.si, m.bp);  // add si, bp
      case 0x3002: m.ax = (m.ax & 0xff) | (m.or8((m.ax >> 8), m.rb(m.ds, m.si)) << 8);  // or ah, byte ptr [si]
      case 0x3004: m.si = m.add16(m.si, m.bp);  // add si, bp
      case 0x3006: m.ax = (m.ax & 0xff) | (m.or8((m.ax >> 8), m.rb(m.ds, m.si)) << 8);  // or ah, byte ptr [si]
      case 0x3008: m.si = m.add16(m.si, m.bp);  // add si, bp
      case 0x300a: m.ax = (m.ax & 0xff) | (m.or8((m.ax >> 8), m.rb(m.ds, m.si)) << 8);  // or ah, byte ptr [si]
      case 0x300c: { const t = m.pop(); m.si = t; }  // pop si
      case 0x300d: m.ax = (m.ax & 0xff) | ((~(m.ax >> 8) & 0xff) << 8);  // not ah
      case 0x300f: m.ax = (m.ax & 0xff00) | (m.ax >> 8);  // mov al, ah
      case 0x3011: m.ax = (m.ax & 0xff) | (0xff << 8);  // mov ah, 0xff
      case 0x3013: m.ax = m.shr16(m.ax, (m.cx & 0xff));  // shr ax, cl
      case 0x3015: m.push(m.si);  // push si
      case 0x3016: m.push(m.di);  // push di
      case 0x3017: m.bx = (m.bx & 0xff00) | m.rb(m.ds, m.si);  // mov bl, byte ptr [si]
      case 0x3019: m.xor8(0, 0); m.bx = (m.bx & 0xff) | (0 << 8);  // xor bh, bh
      case 0x301b: m.bx = m.shr16(m.bx, (m.cx & 0xff));  // shr bx, cl
      case 0x301d: m.wb(m.es, m.di, m.and8(m.rb(m.es, m.di), (m.ax & 0xff)));  // and byte ptr es:[di], al
      case 0x3020: m.wb(m.es, m.di, m.or8(m.rb(m.es, m.di), (m.bx & 0xff)));  // or byte ptr es:[di], bl
      case 0x3023: m.si = m.add16(m.si, m.bp);  // add si, bp
      case 0x3025: m.di = m.add16(m.di, 0x28);  // add di, 0x28
      case 0x3028: m.bx = (m.bx & 0xff00) | m.rb(m.ds, m.si);  // mov bl, byte ptr [si]
      case 0x302a: m.xor8(0, 0); m.bx = (m.bx & 0xff) | (0 << 8);  // xor bh, bh
      case 0x302c: m.bx = m.shr16(m.bx, (m.cx & 0xff));  // shr bx, cl
      case 0x302e: m.wb(m.es, m.di, m.and8(m.rb(m.es, m.di), (m.ax & 0xff)));  // and byte ptr es:[di], al
      case 0x3031: m.wb(m.es, m.di, m.or8(m.rb(m.es, m.di), (m.bx & 0xff)));  // or byte ptr es:[di], bl
      case 0x3034: m.si = m.add16(m.si, m.bp);  // add si, bp
      case 0x3036: m.di = m.add16(m.di, 0x28);  // add di, 0x28
      case 0x3039: m.bx = (m.bx & 0xff00) | m.rb(m.ds, m.si);  // mov bl, byte ptr [si]
      case 0x303b: m.xor8(0, 0); m.bx = (m.bx & 0xff) | (0 << 8);  // xor bh, bh
      case 0x303d: m.bx = m.shr16(m.bx, (m.cx & 0xff));  // shr bx, cl
      case 0x303f: m.wb(m.es, m.di, m.and8(m.rb(m.es, m.di), (m.ax & 0xff)));  // and byte ptr es:[di], al
      case 0x3042: m.wb(m.es, m.di, m.or8(m.rb(m.es, m.di), (m.bx & 0xff)));  // or byte ptr es:[di], bl
      case 0x3045: m.si = m.add16(m.si, m.bp);  // add si, bp
      case 0x3047: m.di = m.add16(m.di, 0x28);  // add di, 0x28
      case 0x304a: m.bx = (m.bx & 0xff00) | m.rb(m.ds, m.si);  // mov bl, byte ptr [si]
      case 0x304c: m.xor8(0, 0); m.bx = (m.bx & 0xff) | (0 << 8);  // xor bh, bh
      case 0x304e: m.bx = m.shr16(m.bx, (m.cx & 0xff));  // shr bx, cl
      case 0x3050: m.wb(m.es, m.di, m.and8(m.rb(m.es, m.di), (m.ax & 0xff)));  // and byte ptr es:[di], al
      case 0x3053: m.wb(m.es, m.di, m.or8(m.rb(m.es, m.di), (m.bx & 0xff)));  // or byte ptr es:[di], bl
      case 0x3056: m.si = m.add16(m.si, m.bp);  // add si, bp
      case 0x3058: m.di = m.add16(m.di, 0x28);  // add di, 0x28
      case 0x305b: { const t = m.pop(); m.di = t; }  // pop di
      case 0x305c: { const t = m.pop(); m.si = t; }  // pop si
      case 0x305d: m.di = m.inc16(m.di);  // inc di
      case 0x305e: m.sub16(m.bp, 0x1);  // cmp bp, 1
      case 0x3061: if (m.zf) { ip = 0x30d4; continue; }  // je 0x30d4
      case 0x3063: m.t += 2; m.pas -= 2; m.ww(m.cs, 0x2500, m.bp);  // mov word ptr cs:[0x2500], bp
      case 0x3068: m.ww(m.cs, 0x2500, m.dec16(m.rw(m.cs, 0x2500)));  // dec word ptr cs:[0x2500]
      case 0x306d: m.t += 48; m.pas -= 48; m.ax = m.rw(m.ds, m.si);  // mov ax, word ptr [si]
      case 0x306f: m.push(m.si);  // push si
      case 0x3070: m.si = m.add16(m.si, m.bp);  // add si, bp
      case 0x3072: m.ax = m.or16(m.ax, m.rw(m.ds, m.si));  // or ax, word ptr [si]
      case 0x3074: m.si = m.add16(m.si, m.bp);  // add si, bp
      case 0x3076: m.ax = m.or16(m.ax, m.rw(m.ds, m.si));  // or ax, word ptr [si]
      case 0x3078: m.si = m.add16(m.si, m.bp);  // add si, bp
      case 0x307a: m.ax = m.or16(m.ax, m.rw(m.ds, m.si));  // or ax, word ptr [si]
      case 0x307c: { const t = m.pop(); m.si = t; }  // pop si
      case 0x307d: m.ax = (~m.ax & 0xffff);  // not ax
      case 0x307f: { const t = (m.ax & 0xff); m.ax = (m.ax & 0xff00) | (m.ax >> 8); m.ax = (m.ax & 0xff) | (t << 8); }  // xchg al, ah
      case 0x3081: m.ax = m.shr16(m.ax, (m.cx & 0xff));  // shr ax, cl
      case 0x3083: m.push(m.si);  // push si
      case 0x3084: m.push(m.di);  // push di
      case 0x3085: m.bx = m.rw(m.ds, m.si);  // mov bx, word ptr [si]
      case 0x3087: { const t = (m.bx & 0xff); m.bx = (m.bx & 0xff00) | (m.bx >> 8); m.bx = (m.bx & 0xff) | (t << 8); }  // xchg bl, bh
      case 0x3089: m.bx = m.shr16(m.bx, (m.cx & 0xff));  // shr bx, cl
      case 0x308b: m.wb(m.es, m.di, m.and8(m.rb(m.es, m.di), (m.ax & 0xff)));  // and byte ptr es:[di], al
      case 0x308e: m.wb(m.es, m.di, m.or8(m.rb(m.es, m.di), (m.bx & 0xff)));  // or byte ptr es:[di], bl
      case 0x3091: m.si = m.add16(m.si, m.bp);  // add si, bp
      case 0x3093: m.di = m.add16(m.di, 0x28);  // add di, 0x28
      case 0x3096: m.bx = m.rw(m.ds, m.si);  // mov bx, word ptr [si]
      case 0x3098: { const t = (m.bx & 0xff); m.bx = (m.bx & 0xff00) | (m.bx >> 8); m.bx = (m.bx & 0xff) | (t << 8); }  // xchg bl, bh
      case 0x309a: m.bx = m.shr16(m.bx, (m.cx & 0xff));  // shr bx, cl
      case 0x309c: m.wb(m.es, m.di, m.and8(m.rb(m.es, m.di), (m.ax & 0xff)));  // and byte ptr es:[di], al
      case 0x309f: m.wb(m.es, m.di, m.or8(m.rb(m.es, m.di), (m.bx & 0xff)));  // or byte ptr es:[di], bl
      case 0x30a2: m.si = m.add16(m.si, m.bp);  // add si, bp
      case 0x30a4: m.di = m.add16(m.di, 0x28);  // add di, 0x28
      case 0x30a7: m.bx = m.rw(m.ds, m.si);  // mov bx, word ptr [si]
      case 0x30a9: { const t = (m.bx & 0xff); m.bx = (m.bx & 0xff00) | (m.bx >> 8); m.bx = (m.bx & 0xff) | (t << 8); }  // xchg bl, bh
      case 0x30ab: m.bx = m.shr16(m.bx, (m.cx & 0xff));  // shr bx, cl
      case 0x30ad: m.wb(m.es, m.di, m.and8(m.rb(m.es, m.di), (m.ax & 0xff)));  // and byte ptr es:[di], al
      case 0x30b0: m.wb(m.es, m.di, m.or8(m.rb(m.es, m.di), (m.bx & 0xff)));  // or byte ptr es:[di], bl
      case 0x30b3: m.si = m.add16(m.si, m.bp);  // add si, bp
      case 0x30b5: m.di = m.add16(m.di, 0x28);  // add di, 0x28
      case 0x30b8: m.bx = m.rw(m.ds, m.si);  // mov bx, word ptr [si]
      case 0x30ba: { const t = (m.bx & 0xff); m.bx = (m.bx & 0xff00) | (m.bx >> 8); m.bx = (m.bx & 0xff) | (t << 8); }  // xchg bl, bh
      case 0x30bc: m.bx = m.shr16(m.bx, (m.cx & 0xff));  // shr bx, cl
      case 0x30be: m.wb(m.es, m.di, m.and8(m.rb(m.es, m.di), (m.ax & 0xff)));  // and byte ptr es:[di], al
      case 0x30c1: m.wb(m.es, m.di, m.or8(m.rb(m.es, m.di), (m.bx & 0xff)));  // or byte ptr es:[di], bl
      case 0x30c4: m.si = m.add16(m.si, m.bp);  // add si, bp
      case 0x30c6: m.di = m.add16(m.di, 0x28);  // add di, 0x28
      case 0x30c9: { const t = m.pop(); m.di = t; }  // pop di
      case 0x30ca: { const t = m.pop(); m.si = t; }  // pop si
      case 0x30cb: m.di = m.inc16(m.di);  // inc di
      case 0x30cc: m.si = m.inc16(m.si);  // inc si
      case 0x30cd: m.ww(m.cs, 0x2500, m.dec16(m.rw(m.cs, 0x2500)));  // dec word ptr cs:[0x2500]
      case 0x30d2: if (!m.zf) { ip = 0x306d; continue; }  // jne 0x306d
      case 0x30d4: m.t += 49; m.pas -= 49; m.ax = (m.ax & 0xff) | (m.rb(m.ds, m.si) << 8);  // mov ah, byte ptr [si]
      case 0x30d6: m.push(m.si);  // push si
      case 0x30d7: m.si = m.add16(m.si, m.bp);  // add si, bp
      case 0x30d9: m.ax = (m.ax & 0xff) | (m.or8((m.ax >> 8), m.rb(m.ds, m.si)) << 8);  // or ah, byte ptr [si]
      case 0x30db: m.si = m.add16(m.si, m.bp);  // add si, bp
      case 0x30dd: m.ax = (m.ax & 0xff) | (m.or8((m.ax >> 8), m.rb(m.ds, m.si)) << 8);  // or ah, byte ptr [si]
      case 0x30df: m.si = m.add16(m.si, m.bp);  // add si, bp
      case 0x30e1: m.ax = (m.ax & 0xff) | (m.or8((m.ax >> 8), m.rb(m.ds, m.si)) << 8);  // or ah, byte ptr [si]
      case 0x30e3: { const t = m.pop(); m.si = t; }  // pop si
      case 0x30e4: m.ax = (m.ax & 0xff) | ((~(m.ax >> 8) & 0xff) << 8);  // not ah
      case 0x30e6: m.ax = (m.ax & 0xff00) | 0xff;  // mov al, 0xff
      case 0x30e8: m.ax = m.shr16(m.ax, (m.cx & 0xff));  // shr ax, cl
      case 0x30ea: m.bx = (m.bx & 0xff) | (m.rb(m.ds, m.si) << 8);  // mov bh, byte ptr [si]
      case 0x30ec: m.xor8(0, 0); m.bx = (m.bx & 0xff00) | 0;  // xor bl, bl
      case 0x30ee: m.bx = m.shr16(m.bx, (m.cx & 0xff));  // shr bx, cl
      case 0x30f0: m.wb(m.es, m.di, m.and8(m.rb(m.es, m.di), (m.ax & 0xff)));  // and byte ptr es:[di], al
      case 0x30f3: m.wb(m.es, m.di, m.or8(m.rb(m.es, m.di), (m.bx & 0xff)));  // or byte ptr es:[di], bl
      case 0x30f6: m.si = m.add16(m.si, m.bp);  // add si, bp
      case 0x30f8: m.di = m.add16(m.di, 0x28);  // add di, 0x28
      case 0x30fb: m.bx = (m.bx & 0xff) | (m.rb(m.ds, m.si) << 8);  // mov bh, byte ptr [si]
      case 0x30fd: m.xor8(0, 0); m.bx = (m.bx & 0xff00) | 0;  // xor bl, bl
      case 0x30ff: m.bx = m.shr16(m.bx, (m.cx & 0xff));  // shr bx, cl
      case 0x3101: m.wb(m.es, m.di, m.and8(m.rb(m.es, m.di), (m.ax & 0xff)));  // and byte ptr es:[di], al
      case 0x3104: m.wb(m.es, m.di, m.or8(m.rb(m.es, m.di), (m.bx & 0xff)));  // or byte ptr es:[di], bl
      case 0x3107: m.si = m.add16(m.si, m.bp);  // add si, bp
      case 0x3109: m.di = m.add16(m.di, 0x28);  // add di, 0x28
      case 0x310c: m.bx = (m.bx & 0xff) | (m.rb(m.ds, m.si) << 8);  // mov bh, byte ptr [si]
      case 0x310e: m.xor8(0, 0); m.bx = (m.bx & 0xff00) | 0;  // xor bl, bl
      case 0x3110: m.bx = m.shr16(m.bx, (m.cx & 0xff));  // shr bx, cl
      case 0x3112: m.wb(m.es, m.di, m.and8(m.rb(m.es, m.di), (m.ax & 0xff)));  // and byte ptr es:[di], al
      case 0x3115: m.wb(m.es, m.di, m.or8(m.rb(m.es, m.di), (m.bx & 0xff)));  // or byte ptr es:[di], bl
      case 0x3118: m.si = m.add16(m.si, m.bp);  // add si, bp
      case 0x311a: m.di = m.add16(m.di, 0x28);  // add di, 0x28
      case 0x311d: m.bx = (m.bx & 0xff) | (m.rb(m.ds, m.si) << 8);  // mov bh, byte ptr [si]
      case 0x311f: m.xor8(0, 0); m.bx = (m.bx & 0xff00) | 0;  // xor bl, bl
      case 0x3121: m.bx = m.shr16(m.bx, (m.cx & 0xff));  // shr bx, cl
      case 0x3123: m.wb(m.es, m.di, m.and8(m.rb(m.es, m.di), (m.ax & 0xff)));  // and byte ptr es:[di], al
      case 0x3126: m.wb(m.es, m.di, m.or8(m.rb(m.es, m.di), (m.bx & 0xff)));  // or byte ptr es:[di], bl
      case 0x3129: m.si = m.add16(m.si, m.bp);  // add si, bp
      case 0x312b: m.di = m.add16(m.di, 0x28);  // add di, 0x28
      case 0x312e: { const t = m.pop(); m.si = t; }  // pop si
      case 0x312f: m.si = m.add16(m.si, m.bp);  // add si, bp
      case 0x3131: m.si = m.add16(m.si, m.bp);  // add si, bp
      case 0x3133: m.si = m.add16(m.si, m.bp);  // add si, bp
      case 0x3135: m.si = m.add16(m.si, m.bp);  // add si, bp
      case 0x3137: { const t = m.pop(); m.di = t; }  // pop di
      case 0x3138: m.di = m.add16(m.di, 0xa0);  // add di, 0xa0
      case 0x313c: m.ww(m.cs, 0x2502, m.dec16(m.rw(m.cs, 0x2502)));  // dec word ptr cs:[0x2502]
      case 0x3141: if (m.zf) { ip = 0x3146; continue; }  // je 0x3146
      case 0x3143: m.t += 1; m.pas -= 1; ip = 0x2ffb; continue;  // jmp 0x2ffb
      case 0x3146: m.t += 1; m.pas -= 1; ip = m.pop(); continue;  // ret
      case 0x3147: m.t += 1; m.pas -= 1; m.push(0x314a); ip = 0x2f24; continue;  // call 0x2f24
      case 0x314a: m.t += 13; m.pas -= 13; m.di = m.rw(m.ds, 0x1a9d);  // mov di, word ptr [0x1a9d]
      case 0x314e: m.bx = m.rw(m.ds, 0x1a9b);  // mov bx, word ptr [0x1a9b]
      case 0x3152: m.si = m.shr16(m.si, 0x1);  // shr si, 1
      case 0x3154: m.ax = m.rw(m.ds, 0x19f0);  // mov ax, word ptr [0x19f0]
      case 0x3157: m.ds = m.ax;  // mov ds, ax
      case 0x3159: m.ww(m.cs, 0x2502, m.cx);  // mov word ptr cs:[0x2502], cx
      case 0x315e: m.bp = m.shr16(m.bp, 0x1);  // shr bp, 1
      case 0x3160: m.ww(m.cs, 0x2504, m.bp);  // mov word ptr cs:[0x2504], bp
      case 0x3165: m.bp = m.shr16(m.bp, 0x1);  // shr bp, 1
      case 0x3167: m.bp = m.shr16(m.bp, 0x1);  // shr bp, 1
      case 0x3169: m.ww(m.cs, 0x2500, m.bp);  // mov word ptr cs:[0x2500], bp
      case 0x316e: m.sub16(m.bx, 0x1);  // cmp bx, 1
      case 0x3171: if (!m.zf) { ip = 0x3176; continue; }  // jne 0x3176
      case 0x3173: m.t += 1; m.pas -= 1; ip = 0x328f; continue;  // jmp 0x328f
      case 0x3176: m.t += 3; m.pas -= 3; m.cx = m.rw(m.cs, 0x2500);  // mov cx, word ptr cs:[0x2500]
      case 0x317b: m.push(m.di);  // push di
      case 0x317c: m.push(m.si);  // push si
      case 0x317d: m.t += 115; m.pas -= 115; m.bx = m.rw(m.cs, 0x2504);  // mov bx, word ptr cs:[0x2504]
      case 0x3182: m.bx = m.sub16(m.bx, m.rw(m.cs, 0x2500));  // sub bx, word ptr cs:[0x2500]
      case 0x3187: m.ax = (m.ax & 0xff00) | m.rb(m.ds, ((m.bx + m.si) & 0xffff));  // mov al, byte ptr [bx + si]
      case 0x3189: m.bx = m.sub16(m.bx, m.rw(m.cs, 0x2500));  // sub bx, word ptr cs:[0x2500]
      case 0x318e: m.dx = (m.dx & 0xff) | (m.rb(m.ds, ((m.bx + m.si) & 0xffff)) << 8);  // mov dh, byte ptr [bx + si]
      case 0x3190: m.bx = m.sub16(m.bx, m.rw(m.cs, 0x2500));  // sub bx, word ptr cs:[0x2500]
      case 0x3195: m.dx = (m.dx & 0xff00) | m.rb(m.ds, ((m.bx + m.si) & 0xffff));  // mov dl, byte ptr [bx + si]
      case 0x3197: m.bx = (m.bx & 0xff00) | m.rb(m.ds, m.si);  // mov bl, byte ptr [si]
      case 0x3199: m.bx = (m.bx & 0xff00) | m.shl8((m.bx & 0xff), 0x1);  // shl bl, 1
      case 0x319b: m.ax = (m.ax & 0xff) | (m.rcl8((m.ax >> 8), 0x1) << 8);  // rcl ah, 1
      case 0x319d: m.dx = (m.dx & 0xff00) | m.shl8((m.dx & 0xff), 0x1);  // shl dl, 1
      case 0x319f: m.ax = (m.ax & 0xff) | (m.rcl8((m.ax >> 8), 0x1) << 8);  // rcl ah, 1
      case 0x31a1: m.dx = (m.dx & 0xff) | (m.shl8((m.dx >> 8), 0x1) << 8);  // shl dh, 1
      case 0x31a3: m.ax = (m.ax & 0xff) | (m.rcl8((m.ax >> 8), 0x1) << 8);  // rcl ah, 1
      case 0x31a5: m.ax = (m.ax & 0xff00) | m.shl8((m.ax & 0xff), 0x1);  // shl al, 1
      case 0x31a7: m.ax = (m.ax & 0xff) | (m.rcl8((m.ax >> 8), 0x1) << 8);  // rcl ah, 1
      case 0x31a9: m.bx = (m.bx & 0xff00) | m.shl8((m.bx & 0xff), 0x1);  // shl bl, 1
      case 0x31ab: m.ax = (m.ax & 0xff) | (m.rcl8((m.ax >> 8), 0x1) << 8);  // rcl ah, 1
      case 0x31ad: m.dx = (m.dx & 0xff00) | m.shl8((m.dx & 0xff), 0x1);  // shl dl, 1
      case 0x31af: m.ax = (m.ax & 0xff) | (m.rcl8((m.ax >> 8), 0x1) << 8);  // rcl ah, 1
      case 0x31b1: m.dx = (m.dx & 0xff) | (m.shl8((m.dx >> 8), 0x1) << 8);  // shl dh, 1
      case 0x31b3: m.ax = (m.ax & 0xff) | (m.rcl8((m.ax >> 8), 0x1) << 8);  // rcl ah, 1
      case 0x31b5: m.ax = (m.ax & 0xff00) | m.shl8((m.ax & 0xff), 0x1);  // shl al, 1
      case 0x31b7: m.ax = (m.ax & 0xff) | (m.rcl8((m.ax >> 8), 0x1) << 8);  // rcl ah, 1
      case 0x31b9: m.push(m.ax);  // push ax
      case 0x31ba: m.push(m.bx);  // push bx
      case 0x31bb: m.ax = (m.ax & 0xff00) | (m.ax >> 8);  // mov al, ah
      case 0x31bd: m.bx = 0x2400;  // mov bx, 0x2400
      case 0x31c0: m.ax = (m.ax & 0xff00) | m.rb(m.cs, (m.bx + (m.ax & 0xff)) & 0xffff);  // xlatb
      case 0x31c2: { const t = m.pop(); m.bx = t; }  // pop bx
      case 0x31c3: m.wb(m.es, m.di, m.and8(m.rb(m.es, m.di), (m.ax & 0xff)));  // and byte ptr es:[di], al
      case 0x31c6: m.wb(m.es, m.di, m.or8(m.rb(m.es, m.di), (m.ax >> 8)));  // or byte ptr es:[di], ah
      case 0x31c9: { const t = m.pop(); m.ax = t; }  // pop ax
      case 0x31ca: m.di = m.inc16(m.di);  // inc di
      case 0x31cb: m.bx = (m.bx & 0xff00) | m.shl8((m.bx & 0xff), 0x1);  // shl bl, 1
      case 0x31cd: m.ax = (m.ax & 0xff) | (m.rcl8((m.ax >> 8), 0x1) << 8);  // rcl ah, 1
      case 0x31cf: m.dx = (m.dx & 0xff00) | m.shl8((m.dx & 0xff), 0x1);  // shl dl, 1
      case 0x31d1: m.ax = (m.ax & 0xff) | (m.rcl8((m.ax >> 8), 0x1) << 8);  // rcl ah, 1
      case 0x31d3: m.dx = (m.dx & 0xff) | (m.shl8((m.dx >> 8), 0x1) << 8);  // shl dh, 1
      case 0x31d5: m.ax = (m.ax & 0xff) | (m.rcl8((m.ax >> 8), 0x1) << 8);  // rcl ah, 1
      case 0x31d7: m.ax = (m.ax & 0xff00) | m.shl8((m.ax & 0xff), 0x1);  // shl al, 1
      case 0x31d9: m.ax = (m.ax & 0xff) | (m.rcl8((m.ax >> 8), 0x1) << 8);  // rcl ah, 1
      case 0x31db: m.bx = (m.bx & 0xff00) | m.shl8((m.bx & 0xff), 0x1);  // shl bl, 1
      case 0x31dd: m.ax = (m.ax & 0xff) | (m.rcl8((m.ax >> 8), 0x1) << 8);  // rcl ah, 1
      case 0x31df: m.dx = (m.dx & 0xff00) | m.shl8((m.dx & 0xff), 0x1);  // shl dl, 1
      case 0x31e1: m.ax = (m.ax & 0xff) | (m.rcl8((m.ax >> 8), 0x1) << 8);  // rcl ah, 1
      case 0x31e3: m.dx = (m.dx & 0xff) | (m.shl8((m.dx >> 8), 0x1) << 8);  // shl dh, 1
      case 0x31e5: m.ax = (m.ax & 0xff) | (m.rcl8((m.ax >> 8), 0x1) << 8);  // rcl ah, 1
      case 0x31e7: m.ax = (m.ax & 0xff00) | m.shl8((m.ax & 0xff), 0x1);  // shl al, 1
      case 0x31e9: m.ax = (m.ax & 0xff) | (m.rcl8((m.ax >> 8), 0x1) << 8);  // rcl ah, 1
      case 0x31eb: m.push(m.ax);  // push ax
      case 0x31ec: m.push(m.bx);  // push bx
      case 0x31ed: m.ax = (m.ax & 0xff00) | (m.ax >> 8);  // mov al, ah
      case 0x31ef: m.bx = 0x2400;  // mov bx, 0x2400
      case 0x31f2: m.ax = (m.ax & 0xff00) | m.rb(m.cs, (m.bx + (m.ax & 0xff)) & 0xffff);  // xlatb
      case 0x31f4: { const t = m.pop(); m.bx = t; }  // pop bx
      case 0x31f5: m.wb(m.es, m.di, m.and8(m.rb(m.es, m.di), (m.ax & 0xff)));  // and byte ptr es:[di], al
      case 0x31f8: m.wb(m.es, m.di, m.or8(m.rb(m.es, m.di), (m.ax >> 8)));  // or byte ptr es:[di], ah
      case 0x31fb: { const t = m.pop(); m.ax = t; }  // pop ax
      case 0x31fc: m.di = m.inc16(m.di);  // inc di
      case 0x31fd: m.bx = (m.bx & 0xff00) | m.shl8((m.bx & 0xff), 0x1);  // shl bl, 1
      case 0x31ff: m.ax = (m.ax & 0xff) | (m.rcl8((m.ax >> 8), 0x1) << 8);  // rcl ah, 1
      case 0x3201: m.dx = (m.dx & 0xff00) | m.shl8((m.dx & 0xff), 0x1);  // shl dl, 1
      case 0x3203: m.ax = (m.ax & 0xff) | (m.rcl8((m.ax >> 8), 0x1) << 8);  // rcl ah, 1
      case 0x3205: m.dx = (m.dx & 0xff) | (m.shl8((m.dx >> 8), 0x1) << 8);  // shl dh, 1
      case 0x3207: m.ax = (m.ax & 0xff) | (m.rcl8((m.ax >> 8), 0x1) << 8);  // rcl ah, 1
      case 0x3209: m.ax = (m.ax & 0xff00) | m.shl8((m.ax & 0xff), 0x1);  // shl al, 1
      case 0x320b: m.ax = (m.ax & 0xff) | (m.rcl8((m.ax >> 8), 0x1) << 8);  // rcl ah, 1
      case 0x320d: m.bx = (m.bx & 0xff00) | m.shl8((m.bx & 0xff), 0x1);  // shl bl, 1
      case 0x320f: m.ax = (m.ax & 0xff) | (m.rcl8((m.ax >> 8), 0x1) << 8);  // rcl ah, 1
      case 0x3211: m.dx = (m.dx & 0xff00) | m.shl8((m.dx & 0xff), 0x1);  // shl dl, 1
      case 0x3213: m.ax = (m.ax & 0xff) | (m.rcl8((m.ax >> 8), 0x1) << 8);  // rcl ah, 1
      case 0x3215: m.dx = (m.dx & 0xff) | (m.shl8((m.dx >> 8), 0x1) << 8);  // shl dh, 1
      case 0x3217: m.ax = (m.ax & 0xff) | (m.rcl8((m.ax >> 8), 0x1) << 8);  // rcl ah, 1
      case 0x3219: m.ax = (m.ax & 0xff00) | m.shl8((m.ax & 0xff), 0x1);  // shl al, 1
      case 0x321b: m.ax = (m.ax & 0xff) | (m.rcl8((m.ax >> 8), 0x1) << 8);  // rcl ah, 1
      case 0x321d: m.push(m.ax);  // push ax
      case 0x321e: m.push(m.bx);  // push bx
      case 0x321f: m.ax = (m.ax & 0xff00) | (m.ax >> 8);  // mov al, ah
      case 0x3221: m.bx = 0x2400;  // mov bx, 0x2400
      case 0x3224: m.ax = (m.ax & 0xff00) | m.rb(m.cs, (m.bx + (m.ax & 0xff)) & 0xffff);  // xlatb
      case 0x3226: { const t = m.pop(); m.bx = t; }  // pop bx
      case 0x3227: m.wb(m.es, m.di, m.and8(m.rb(m.es, m.di), (m.ax & 0xff)));  // and byte ptr es:[di], al
      case 0x322a: m.wb(m.es, m.di, m.or8(m.rb(m.es, m.di), (m.ax >> 8)));  // or byte ptr es:[di], ah
      case 0x322d: { const t = m.pop(); m.ax = t; }  // pop ax
      case 0x322e: m.di = m.inc16(m.di);  // inc di
      case 0x322f: m.bx = (m.bx & 0xff00) | m.shl8((m.bx & 0xff), 0x1);  // shl bl, 1
      case 0x3231: m.ax = (m.ax & 0xff) | (m.rcl8((m.ax >> 8), 0x1) << 8);  // rcl ah, 1
      case 0x3233: m.dx = (m.dx & 0xff00) | m.shl8((m.dx & 0xff), 0x1);  // shl dl, 1
      case 0x3235: m.ax = (m.ax & 0xff) | (m.rcl8((m.ax >> 8), 0x1) << 8);  // rcl ah, 1
      case 0x3237: m.dx = (m.dx & 0xff) | (m.shl8((m.dx >> 8), 0x1) << 8);  // shl dh, 1
      case 0x3239: m.ax = (m.ax & 0xff) | (m.rcl8((m.ax >> 8), 0x1) << 8);  // rcl ah, 1
      case 0x323b: m.ax = (m.ax & 0xff00) | m.shl8((m.ax & 0xff), 0x1);  // shl al, 1
      case 0x323d: m.ax = (m.ax & 0xff) | (m.rcl8((m.ax >> 8), 0x1) << 8);  // rcl ah, 1
      case 0x323f: m.bx = (m.bx & 0xff00) | m.shl8((m.bx & 0xff), 0x1);  // shl bl, 1
      case 0x3241: m.ax = (m.ax & 0xff) | (m.rcl8((m.ax >> 8), 0x1) << 8);  // rcl ah, 1
      case 0x3243: m.dx = (m.dx & 0xff00) | m.shl8((m.dx & 0xff), 0x1);  // shl dl, 1
      case 0x3245: m.ax = (m.ax & 0xff) | (m.rcl8((m.ax >> 8), 0x1) << 8);  // rcl ah, 1
      case 0x3247: m.dx = (m.dx & 0xff) | (m.shl8((m.dx >> 8), 0x1) << 8);  // shl dh, 1
      case 0x3249: m.ax = (m.ax & 0xff) | (m.rcl8((m.ax >> 8), 0x1) << 8);  // rcl ah, 1
      case 0x324b: m.ax = (m.ax & 0xff00) | m.shl8((m.ax & 0xff), 0x1);  // shl al, 1
      case 0x324d: m.ax = (m.ax & 0xff) | (m.rcl8((m.ax >> 8), 0x1) << 8);  // rcl ah, 1
      case 0x324f: m.push(m.ax);  // push ax
      case 0x3250: m.push(m.bx);  // push bx
      case 0x3251: m.ax = (m.ax & 0xff00) | (m.ax >> 8);  // mov al, ah
      case 0x3253: m.bx = 0x2400;  // mov bx, 0x2400
      case 0x3256: m.ax = (m.ax & 0xff00) | m.rb(m.cs, (m.bx + (m.ax & 0xff)) & 0xffff);  // xlatb
      case 0x3258: { const t = m.pop(); m.bx = t; }  // pop bx
      case 0x3259: m.wb(m.es, m.di, m.and8(m.rb(m.es, m.di), (m.ax & 0xff)));  // and byte ptr es:[di], al
      case 0x325c: m.wb(m.es, m.di, m.or8(m.rb(m.es, m.di), (m.ax >> 8)));  // or byte ptr es:[di], ah
      case 0x325f: { const t = m.pop(); m.ax = t; }  // pop ax
      case 0x3260: m.di = m.inc16(m.di);  // inc di
      case 0x3261: m.si = m.inc16(m.si);  // inc si
      case 0x3262: m.cx = m.dec16(m.cx);  // dec cx
      case 0x3263: if (m.zf) { ip = 0x3268; continue; }  // je 0x3268
      case 0x3265: m.t += 1; m.pas -= 1; ip = 0x317d; continue;  // jmp 0x317d
      case 0x3268: m.t += 6; m.pas -= 6; { const t = m.pop(); m.si = t; }  // pop si
      case 0x3269: { const t = m.pop(); m.di = t; }  // pop di
      case 0x326a: m.si = m.add16(m.si, m.rw(m.cs, 0x2504));  // add si, word ptr cs:[0x2504]
      case 0x326f: m.di = m.add16(m.di, 0x2000);  // add di, 0x2000
      case 0x3273: m.and16(m.di, 0x8000);  // test di, 0x8000
      case 0x3277: if (m.zf) { ip = 0x327d; continue; }  // je 0x327d
      case 0x3279: m.t += 1; m.pas -= 1; m.di = m.sub16(m.di, 0x7f60);  // sub di, 0x7f60
      case 0x327d: m.t += 2; m.pas -= 2; m.ww(m.cs, 0x2502, m.dec16(m.rw(m.cs, 0x2502)));  // dec word ptr cs:[0x2502]
      case 0x3282: if (m.zf) { ip = 0x3287; continue; }  // je 0x3287
      case 0x3284: m.t += 1; m.pas -= 1; ip = 0x3176; continue;  // jmp 0x3176
      case 0x3287: m.t += 5; m.pas -= 5; m.push(m.ax);  // push ax
      case 0x3288: m.ax = ((0x0 + m.L) & 0xffff);  // mov ax, 0
      case 0x328b: m.ds = m.ax;  // mov ds, ax
      case 0x328d: { const t = m.pop(); m.ax = t; }  // pop ax
      case 0x328e: ip = m.pop(); continue;  // ret
      case 0x328f: m.t += 1; m.pas -= 1; m.ww(m.cs, 0x2502, m.cx);  // mov word ptr cs:[0x2502], cx
      case 0x3294: m.t += 32; m.pas -= 32; m.cx = m.rw(m.cs, 0x2500);  // mov cx, word ptr cs:[0x2500]
      case 0x3299: m.push(m.di);  // push di
      case 0x329a: m.push(m.si);  // push si
      case 0x329b: m.xor8(0, 0); m.ax = (m.ax & 0xff) | (0 << 8);  // xor ah, ah
      case 0x329d: m.bx = m.rw(m.cs, 0x2504);  // mov bx, word ptr cs:[0x2504]
      case 0x32a2: m.bx = m.sub16(m.bx, m.rw(m.cs, 0x2500));  // sub bx, word ptr cs:[0x2500]
      case 0x32a7: m.ax = (m.ax & 0xff00) | m.rb(m.ds, ((m.bx + m.si) & 0xffff));  // mov al, byte ptr [bx + si]
      case 0x32a9: m.bx = m.sub16(m.bx, m.rw(m.cs, 0x2500));  // sub bx, word ptr cs:[0x2500]
      case 0x32ae: m.dx = (m.dx & 0xff) | (m.rb(m.ds, ((m.bx + m.si) & 0xffff)) << 8);  // mov dh, byte ptr [bx + si]
      case 0x32b0: m.bx = m.sub16(m.bx, m.rw(m.cs, 0x2500));  // sub bx, word ptr cs:[0x2500]
      case 0x32b5: m.dx = (m.dx & 0xff00) | m.rb(m.ds, ((m.bx + m.si) & 0xffff));  // mov dl, byte ptr [bx + si]
      case 0x32b7: m.bx = (m.bx & 0xff00) | m.rb(m.ds, m.si);  // mov bl, byte ptr [si]
      case 0x32b9: m.bx = (m.bx & 0xff00) | m.shl8((m.bx & 0xff), 0x1);  // shl bl, 1
      case 0x32bb: m.ax = (m.ax & 0xff) | (m.rcl8((m.ax >> 8), 0x1) << 8);  // rcl ah, 1
      case 0x32bd: m.dx = (m.dx & 0xff00) | m.shl8((m.dx & 0xff), 0x1);  // shl dl, 1
      case 0x32bf: m.ax = (m.ax & 0xff) | (m.rcl8((m.ax >> 8), 0x1) << 8);  // rcl ah, 1
      case 0x32c1: m.dx = (m.dx & 0xff) | (m.shl8((m.dx >> 8), 0x1) << 8);  // shl dh, 1
      case 0x32c3: m.ax = (m.ax & 0xff) | (m.rcl8((m.ax >> 8), 0x1) << 8);  // rcl ah, 1
      case 0x32c5: m.ax = (m.ax & 0xff00) | m.shl8((m.ax & 0xff), 0x1);  // shl al, 1
      case 0x32c7: m.ax = (m.ax & 0xff) | (m.rcl8((m.ax >> 8), 0x1) << 8);  // rcl ah, 1
      case 0x32c9: m.push(m.ax);  // push ax
      case 0x32ca: m.push(m.bx);  // push bx
      case 0x32cb: m.ax = (m.ax & 0xff00) | (m.ax >> 8);  // mov al, ah
      case 0x32cd: m.bx = 0x2400;  // mov bx, 0x2400
      case 0x32d0: m.ax = (m.ax & 0xff00) | m.rb(m.cs, (m.bx + (m.ax & 0xff)) & 0xffff);  // xlatb
      case 0x32d2: { const t = m.pop(); m.bx = t; }  // pop bx
      case 0x32d3: m.wb(m.es, m.di, m.and8(m.rb(m.es, m.di), (m.ax & 0xff)));  // and byte ptr es:[di], al
      case 0x32d6: m.wb(m.es, m.di, m.or8(m.rb(m.es, m.di), (m.ax >> 8)));  // or byte ptr es:[di], ah
      case 0x32d9: { const t = m.pop(); m.ax = t; }  // pop ax
      case 0x32da: m.di = m.inc16(m.di);  // inc di
      case 0x32db: m.sub16(m.cx, 0x1);  // cmp cx, 1
      case 0x32de: if (!m.zf) { ip = 0x32e3; continue; }  // jne 0x32e3
      case 0x32e0: m.t += 1; m.pas -= 1; ip = 0x33cf; continue;  // jmp 0x33cf
      case 0x32e3: m.t += 1; m.pas -= 1; m.cx = m.dec16(m.cx);  // dec cx
      case 0x32e4: m.t += 115; m.pas -= 115; m.bx = (m.bx & 0xff00) | m.shl8((m.bx & 0xff), 0x1);  // shl bl, 1
      case 0x32e6: m.ax = (m.ax & 0xff) | (m.rcl8((m.ax >> 8), 0x1) << 8);  // rcl ah, 1
      case 0x32e8: m.dx = (m.dx & 0xff00) | m.shl8((m.dx & 0xff), 0x1);  // shl dl, 1
      case 0x32ea: m.ax = (m.ax & 0xff) | (m.rcl8((m.ax >> 8), 0x1) << 8);  // rcl ah, 1
      case 0x32ec: m.dx = (m.dx & 0xff) | (m.shl8((m.dx >> 8), 0x1) << 8);  // shl dh, 1
      case 0x32ee: m.ax = (m.ax & 0xff) | (m.rcl8((m.ax >> 8), 0x1) << 8);  // rcl ah, 1
      case 0x32f0: m.ax = (m.ax & 0xff00) | m.shl8((m.ax & 0xff), 0x1);  // shl al, 1
      case 0x32f2: m.ax = (m.ax & 0xff) | (m.rcl8((m.ax >> 8), 0x1) << 8);  // rcl ah, 1
      case 0x32f4: m.bx = (m.bx & 0xff00) | m.shl8((m.bx & 0xff), 0x1);  // shl bl, 1
      case 0x32f6: m.ax = (m.ax & 0xff) | (m.rcl8((m.ax >> 8), 0x1) << 8);  // rcl ah, 1
      case 0x32f8: m.dx = (m.dx & 0xff00) | m.shl8((m.dx & 0xff), 0x1);  // shl dl, 1
      case 0x32fa: m.ax = (m.ax & 0xff) | (m.rcl8((m.ax >> 8), 0x1) << 8);  // rcl ah, 1
      case 0x32fc: m.dx = (m.dx & 0xff) | (m.shl8((m.dx >> 8), 0x1) << 8);  // shl dh, 1
      case 0x32fe: m.ax = (m.ax & 0xff) | (m.rcl8((m.ax >> 8), 0x1) << 8);  // rcl ah, 1
      case 0x3300: m.ax = (m.ax & 0xff00) | m.shl8((m.ax & 0xff), 0x1);  // shl al, 1
      case 0x3302: m.ax = (m.ax & 0xff) | (m.rcl8((m.ax >> 8), 0x1) << 8);  // rcl ah, 1
      case 0x3304: m.push(m.ax);  // push ax
      case 0x3305: m.push(m.bx);  // push bx
      case 0x3306: m.ax = (m.ax & 0xff00) | (m.ax >> 8);  // mov al, ah
      case 0x3308: m.bx = 0x2400;  // mov bx, 0x2400
      case 0x330b: m.ax = (m.ax & 0xff00) | m.rb(m.cs, (m.bx + (m.ax & 0xff)) & 0xffff);  // xlatb
      case 0x330d: { const t = m.pop(); m.bx = t; }  // pop bx
      case 0x330e: m.wb(m.es, m.di, m.and8(m.rb(m.es, m.di), (m.ax & 0xff)));  // and byte ptr es:[di], al
      case 0x3311: m.wb(m.es, m.di, m.or8(m.rb(m.es, m.di), (m.ax >> 8)));  // or byte ptr es:[di], ah
      case 0x3314: { const t = m.pop(); m.ax = t; }  // pop ax
      case 0x3315: m.di = m.inc16(m.di);  // inc di
      case 0x3316: m.bx = (m.bx & 0xff00) | m.shl8((m.bx & 0xff), 0x1);  // shl bl, 1
      case 0x3318: m.ax = (m.ax & 0xff) | (m.rcl8((m.ax >> 8), 0x1) << 8);  // rcl ah, 1
      case 0x331a: m.dx = (m.dx & 0xff00) | m.shl8((m.dx & 0xff), 0x1);  // shl dl, 1
      case 0x331c: m.ax = (m.ax & 0xff) | (m.rcl8((m.ax >> 8), 0x1) << 8);  // rcl ah, 1
      case 0x331e: m.dx = (m.dx & 0xff) | (m.shl8((m.dx >> 8), 0x1) << 8);  // shl dh, 1
      case 0x3320: m.ax = (m.ax & 0xff) | (m.rcl8((m.ax >> 8), 0x1) << 8);  // rcl ah, 1
      case 0x3322: m.ax = (m.ax & 0xff00) | m.shl8((m.ax & 0xff), 0x1);  // shl al, 1
      case 0x3324: m.ax = (m.ax & 0xff) | (m.rcl8((m.ax >> 8), 0x1) << 8);  // rcl ah, 1
      case 0x3326: m.bx = (m.bx & 0xff00) | m.shl8((m.bx & 0xff), 0x1);  // shl bl, 1
      case 0x3328: m.ax = (m.ax & 0xff) | (m.rcl8((m.ax >> 8), 0x1) << 8);  // rcl ah, 1
      case 0x332a: m.dx = (m.dx & 0xff00) | m.shl8((m.dx & 0xff), 0x1);  // shl dl, 1
      case 0x332c: m.ax = (m.ax & 0xff) | (m.rcl8((m.ax >> 8), 0x1) << 8);  // rcl ah, 1
      case 0x332e: m.dx = (m.dx & 0xff) | (m.shl8((m.dx >> 8), 0x1) << 8);  // shl dh, 1
      case 0x3330: m.ax = (m.ax & 0xff) | (m.rcl8((m.ax >> 8), 0x1) << 8);  // rcl ah, 1
      case 0x3332: m.ax = (m.ax & 0xff00) | m.shl8((m.ax & 0xff), 0x1);  // shl al, 1
      case 0x3334: m.ax = (m.ax & 0xff) | (m.rcl8((m.ax >> 8), 0x1) << 8);  // rcl ah, 1
      case 0x3336: m.push(m.ax);  // push ax
      case 0x3337: m.push(m.bx);  // push bx
      case 0x3338: m.ax = (m.ax & 0xff00) | (m.ax >> 8);  // mov al, ah
      case 0x333a: m.bx = 0x2400;  // mov bx, 0x2400
      case 0x333d: m.ax = (m.ax & 0xff00) | m.rb(m.cs, (m.bx + (m.ax & 0xff)) & 0xffff);  // xlatb
      case 0x333f: { const t = m.pop(); m.bx = t; }  // pop bx
      case 0x3340: m.wb(m.es, m.di, m.and8(m.rb(m.es, m.di), (m.ax & 0xff)));  // and byte ptr es:[di], al
      case 0x3343: m.wb(m.es, m.di, m.or8(m.rb(m.es, m.di), (m.ax >> 8)));  // or byte ptr es:[di], ah
      case 0x3346: { const t = m.pop(); m.ax = t; }  // pop ax
      case 0x3347: m.di = m.inc16(m.di);  // inc di
      case 0x3348: m.bx = (m.bx & 0xff00) | m.shl8((m.bx & 0xff), 0x1);  // shl bl, 1
      case 0x334a: m.ax = (m.ax & 0xff) | (m.rcl8((m.ax >> 8), 0x1) << 8);  // rcl ah, 1
      case 0x334c: m.dx = (m.dx & 0xff00) | m.shl8((m.dx & 0xff), 0x1);  // shl dl, 1
      case 0x334e: m.ax = (m.ax & 0xff) | (m.rcl8((m.ax >> 8), 0x1) << 8);  // rcl ah, 1
      case 0x3350: m.dx = (m.dx & 0xff) | (m.shl8((m.dx >> 8), 0x1) << 8);  // shl dh, 1
      case 0x3352: m.ax = (m.ax & 0xff) | (m.rcl8((m.ax >> 8), 0x1) << 8);  // rcl ah, 1
      case 0x3354: m.ax = (m.ax & 0xff00) | m.shl8((m.ax & 0xff), 0x1);  // shl al, 1
      case 0x3356: m.ax = (m.ax & 0xff) | (m.rcl8((m.ax >> 8), 0x1) << 8);  // rcl ah, 1
      case 0x3358: m.bx = (m.bx & 0xff00) | m.shl8((m.bx & 0xff), 0x1);  // shl bl, 1
      case 0x335a: m.ax = (m.ax & 0xff) | (m.rcl8((m.ax >> 8), 0x1) << 8);  // rcl ah, 1
      case 0x335c: m.dx = (m.dx & 0xff00) | m.shl8((m.dx & 0xff), 0x1);  // shl dl, 1
      case 0x335e: m.ax = (m.ax & 0xff) | (m.rcl8((m.ax >> 8), 0x1) << 8);  // rcl ah, 1
      case 0x3360: m.dx = (m.dx & 0xff) | (m.shl8((m.dx >> 8), 0x1) << 8);  // shl dh, 1
      case 0x3362: m.ax = (m.ax & 0xff) | (m.rcl8((m.ax >> 8), 0x1) << 8);  // rcl ah, 1
      case 0x3364: m.ax = (m.ax & 0xff00) | m.shl8((m.ax & 0xff), 0x1);  // shl al, 1
      case 0x3366: m.ax = (m.ax & 0xff) | (m.rcl8((m.ax >> 8), 0x1) << 8);  // rcl ah, 1
      case 0x3368: m.push(m.ax);  // push ax
      case 0x3369: m.push(m.bx);  // push bx
      case 0x336a: m.ax = (m.ax & 0xff00) | (m.ax >> 8);  // mov al, ah
      case 0x336c: m.bx = 0x2400;  // mov bx, 0x2400
      case 0x336f: m.ax = (m.ax & 0xff00) | m.rb(m.cs, (m.bx + (m.ax & 0xff)) & 0xffff);  // xlatb
      case 0x3371: { const t = m.pop(); m.bx = t; }  // pop bx
      case 0x3372: m.wb(m.es, m.di, m.and8(m.rb(m.es, m.di), (m.ax & 0xff)));  // and byte ptr es:[di], al
      case 0x3375: m.wb(m.es, m.di, m.or8(m.rb(m.es, m.di), (m.ax >> 8)));  // or byte ptr es:[di], ah
      case 0x3378: { const t = m.pop(); m.ax = t; }  // pop ax
      case 0x3379: m.di = m.inc16(m.di);  // inc di
      case 0x337a: m.bx = (m.bx & 0xff00) | m.shl8((m.bx & 0xff), 0x1);  // shl bl, 1
      case 0x337c: m.ax = (m.ax & 0xff) | (m.rcl8((m.ax >> 8), 0x1) << 8);  // rcl ah, 1
      case 0x337e: m.dx = (m.dx & 0xff00) | m.shl8((m.dx & 0xff), 0x1);  // shl dl, 1
      case 0x3380: m.ax = (m.ax & 0xff) | (m.rcl8((m.ax >> 8), 0x1) << 8);  // rcl ah, 1
      case 0x3382: m.dx = (m.dx & 0xff) | (m.shl8((m.dx >> 8), 0x1) << 8);  // shl dh, 1
      case 0x3384: m.ax = (m.ax & 0xff) | (m.rcl8((m.ax >> 8), 0x1) << 8);  // rcl ah, 1
      case 0x3386: m.ax = (m.ax & 0xff00) | m.shl8((m.ax & 0xff), 0x1);  // shl al, 1
      case 0x3388: m.ax = (m.ax & 0xff) | (m.rcl8((m.ax >> 8), 0x1) << 8);  // rcl ah, 1
      case 0x338a: m.si = m.inc16(m.si);  // inc si
      case 0x338b: m.bx = m.rw(m.cs, 0x2504);  // mov bx, word ptr cs:[0x2504]
      case 0x3390: m.bx = m.sub16(m.bx, m.rw(m.cs, 0x2500));  // sub bx, word ptr cs:[0x2500]
      case 0x3395: m.ax = (m.ax & 0xff00) | m.rb(m.ds, ((m.bx + m.si) & 0xffff));  // mov al, byte ptr [bx + si]
      case 0x3397: m.bx = m.sub16(m.bx, m.rw(m.cs, 0x2500));  // sub bx, word ptr cs:[0x2500]
      case 0x339c: m.dx = (m.dx & 0xff) | (m.rb(m.ds, ((m.bx + m.si) & 0xffff)) << 8);  // mov dh, byte ptr [bx + si]
      case 0x339e: m.bx = m.sub16(m.bx, m.rw(m.cs, 0x2500));  // sub bx, word ptr cs:[0x2500]
      case 0x33a3: m.dx = (m.dx & 0xff00) | m.rb(m.ds, ((m.bx + m.si) & 0xffff));  // mov dl, byte ptr [bx + si]
      case 0x33a5: m.bx = (m.bx & 0xff00) | m.rb(m.ds, m.si);  // mov bl, byte ptr [si]
      case 0x33a7: m.bx = (m.bx & 0xff00) | m.shl8((m.bx & 0xff), 0x1);  // shl bl, 1
      case 0x33a9: m.ax = (m.ax & 0xff) | (m.rcl8((m.ax >> 8), 0x1) << 8);  // rcl ah, 1
      case 0x33ab: m.dx = (m.dx & 0xff00) | m.shl8((m.dx & 0xff), 0x1);  // shl dl, 1
      case 0x33ad: m.ax = (m.ax & 0xff) | (m.rcl8((m.ax >> 8), 0x1) << 8);  // rcl ah, 1
      case 0x33af: m.dx = (m.dx & 0xff) | (m.shl8((m.dx >> 8), 0x1) << 8);  // shl dh, 1
      case 0x33b1: m.ax = (m.ax & 0xff) | (m.rcl8((m.ax >> 8), 0x1) << 8);  // rcl ah, 1
      case 0x33b3: m.ax = (m.ax & 0xff00) | m.shl8((m.ax & 0xff), 0x1);  // shl al, 1
      case 0x33b5: m.ax = (m.ax & 0xff) | (m.rcl8((m.ax >> 8), 0x1) << 8);  // rcl ah, 1
      case 0x33b7: m.push(m.ax);  // push ax
      case 0x33b8: m.push(m.bx);  // push bx
      case 0x33b9: m.ax = (m.ax & 0xff00) | (m.ax >> 8);  // mov al, ah
      case 0x33bb: m.bx = 0x2400;  // mov bx, 0x2400
      case 0x33be: m.ax = (m.ax & 0xff00) | m.rb(m.cs, (m.bx + (m.ax & 0xff)) & 0xffff);  // xlatb
      case 0x33c0: { const t = m.pop(); m.bx = t; }  // pop bx
      case 0x33c1: m.wb(m.es, m.di, m.and8(m.rb(m.es, m.di), (m.ax & 0xff)));  // and byte ptr es:[di], al
      case 0x33c4: m.wb(m.es, m.di, m.or8(m.rb(m.es, m.di), (m.ax >> 8)));  // or byte ptr es:[di], ah
      case 0x33c7: { const t = m.pop(); m.ax = t; }  // pop ax
      case 0x33c8: m.di = m.inc16(m.di);  // inc di
      case 0x33c9: m.cx = m.dec16(m.cx);  // dec cx
      case 0x33ca: if (m.zf) { ip = 0x33cf; continue; }  // je 0x33cf
      case 0x33cc: m.t += 1; m.pas -= 1; ip = 0x32e4; continue;  // jmp 0x32e4
      case 0x33cf: m.t += 107; m.pas -= 107; m.bx = (m.bx & 0xff00) | m.shl8((m.bx & 0xff), 0x1);  // shl bl, 1
      case 0x33d1: m.ax = (m.ax & 0xff) | (m.rcl8((m.ax >> 8), 0x1) << 8);  // rcl ah, 1
      case 0x33d3: m.dx = (m.dx & 0xff00) | m.shl8((m.dx & 0xff), 0x1);  // shl dl, 1
      case 0x33d5: m.ax = (m.ax & 0xff) | (m.rcl8((m.ax >> 8), 0x1) << 8);  // rcl ah, 1
      case 0x33d7: m.dx = (m.dx & 0xff) | (m.shl8((m.dx >> 8), 0x1) << 8);  // shl dh, 1
      case 0x33d9: m.ax = (m.ax & 0xff) | (m.rcl8((m.ax >> 8), 0x1) << 8);  // rcl ah, 1
      case 0x33db: m.ax = (m.ax & 0xff00) | m.shl8((m.ax & 0xff), 0x1);  // shl al, 1
      case 0x33dd: m.ax = (m.ax & 0xff) | (m.rcl8((m.ax >> 8), 0x1) << 8);  // rcl ah, 1
      case 0x33df: m.bx = (m.bx & 0xff00) | m.shl8((m.bx & 0xff), 0x1);  // shl bl, 1
      case 0x33e1: m.ax = (m.ax & 0xff) | (m.rcl8((m.ax >> 8), 0x1) << 8);  // rcl ah, 1
      case 0x33e3: m.dx = (m.dx & 0xff00) | m.shl8((m.dx & 0xff), 0x1);  // shl dl, 1
      case 0x33e5: m.ax = (m.ax & 0xff) | (m.rcl8((m.ax >> 8), 0x1) << 8);  // rcl ah, 1
      case 0x33e7: m.dx = (m.dx & 0xff) | (m.shl8((m.dx >> 8), 0x1) << 8);  // shl dh, 1
      case 0x33e9: m.ax = (m.ax & 0xff) | (m.rcl8((m.ax >> 8), 0x1) << 8);  // rcl ah, 1
      case 0x33eb: m.ax = (m.ax & 0xff00) | m.shl8((m.ax & 0xff), 0x1);  // shl al, 1
      case 0x33ed: m.ax = (m.ax & 0xff) | (m.rcl8((m.ax >> 8), 0x1) << 8);  // rcl ah, 1
      case 0x33ef: m.push(m.ax);  // push ax
      case 0x33f0: m.push(m.bx);  // push bx
      case 0x33f1: m.ax = (m.ax & 0xff00) | (m.ax >> 8);  // mov al, ah
      case 0x33f3: m.bx = 0x2400;  // mov bx, 0x2400
      case 0x33f6: m.ax = (m.ax & 0xff00) | m.rb(m.cs, (m.bx + (m.ax & 0xff)) & 0xffff);  // xlatb
      case 0x33f8: { const t = m.pop(); m.bx = t; }  // pop bx
      case 0x33f9: m.wb(m.es, m.di, m.and8(m.rb(m.es, m.di), (m.ax & 0xff)));  // and byte ptr es:[di], al
      case 0x33fc: m.wb(m.es, m.di, m.or8(m.rb(m.es, m.di), (m.ax >> 8)));  // or byte ptr es:[di], ah
      case 0x33ff: { const t = m.pop(); m.ax = t; }  // pop ax
      case 0x3400: m.di = m.inc16(m.di);  // inc di
      case 0x3401: m.bx = (m.bx & 0xff00) | m.shl8((m.bx & 0xff), 0x1);  // shl bl, 1
      case 0x3403: m.ax = (m.ax & 0xff) | (m.rcl8((m.ax >> 8), 0x1) << 8);  // rcl ah, 1
      case 0x3405: m.dx = (m.dx & 0xff00) | m.shl8((m.dx & 0xff), 0x1);  // shl dl, 1
      case 0x3407: m.ax = (m.ax & 0xff) | (m.rcl8((m.ax >> 8), 0x1) << 8);  // rcl ah, 1
      case 0x3409: m.dx = (m.dx & 0xff) | (m.shl8((m.dx >> 8), 0x1) << 8);  // shl dh, 1
      case 0x340b: m.ax = (m.ax & 0xff) | (m.rcl8((m.ax >> 8), 0x1) << 8);  // rcl ah, 1
      case 0x340d: m.ax = (m.ax & 0xff00) | m.shl8((m.ax & 0xff), 0x1);  // shl al, 1
      case 0x340f: m.ax = (m.ax & 0xff) | (m.rcl8((m.ax >> 8), 0x1) << 8);  // rcl ah, 1
      case 0x3411: m.bx = (m.bx & 0xff00) | m.shl8((m.bx & 0xff), 0x1);  // shl bl, 1
      case 0x3413: m.ax = (m.ax & 0xff) | (m.rcl8((m.ax >> 8), 0x1) << 8);  // rcl ah, 1
      case 0x3415: m.dx = (m.dx & 0xff00) | m.shl8((m.dx & 0xff), 0x1);  // shl dl, 1
      case 0x3417: m.ax = (m.ax & 0xff) | (m.rcl8((m.ax >> 8), 0x1) << 8);  // rcl ah, 1
      case 0x3419: m.dx = (m.dx & 0xff) | (m.shl8((m.dx >> 8), 0x1) << 8);  // shl dh, 1
      case 0x341b: m.ax = (m.ax & 0xff) | (m.rcl8((m.ax >> 8), 0x1) << 8);  // rcl ah, 1
      case 0x341d: m.ax = (m.ax & 0xff00) | m.shl8((m.ax & 0xff), 0x1);  // shl al, 1
      case 0x341f: m.ax = (m.ax & 0xff) | (m.rcl8((m.ax >> 8), 0x1) << 8);  // rcl ah, 1
      case 0x3421: m.push(m.ax);  // push ax
      case 0x3422: m.push(m.bx);  // push bx
      case 0x3423: m.ax = (m.ax & 0xff00) | (m.ax >> 8);  // mov al, ah
      case 0x3425: m.bx = 0x2400;  // mov bx, 0x2400
      case 0x3428: m.ax = (m.ax & 0xff00) | m.rb(m.cs, (m.bx + (m.ax & 0xff)) & 0xffff);  // xlatb
      case 0x342a: { const t = m.pop(); m.bx = t; }  // pop bx
      case 0x342b: m.wb(m.es, m.di, m.and8(m.rb(m.es, m.di), (m.ax & 0xff)));  // and byte ptr es:[di], al
      case 0x342e: m.wb(m.es, m.di, m.or8(m.rb(m.es, m.di), (m.ax >> 8)));  // or byte ptr es:[di], ah
      case 0x3431: { const t = m.pop(); m.ax = t; }  // pop ax
      case 0x3432: m.di = m.inc16(m.di);  // inc di
      case 0x3433: m.bx = (m.bx & 0xff00) | m.shl8((m.bx & 0xff), 0x1);  // shl bl, 1
      case 0x3435: m.ax = (m.ax & 0xff) | (m.rcl8((m.ax >> 8), 0x1) << 8);  // rcl ah, 1
      case 0x3437: m.dx = (m.dx & 0xff00) | m.shl8((m.dx & 0xff), 0x1);  // shl dl, 1
      case 0x3439: m.ax = (m.ax & 0xff) | (m.rcl8((m.ax >> 8), 0x1) << 8);  // rcl ah, 1
      case 0x343b: m.dx = (m.dx & 0xff) | (m.shl8((m.dx >> 8), 0x1) << 8);  // shl dh, 1
      case 0x343d: m.ax = (m.ax & 0xff) | (m.rcl8((m.ax >> 8), 0x1) << 8);  // rcl ah, 1
      case 0x343f: m.ax = (m.ax & 0xff00) | m.shl8((m.ax & 0xff), 0x1);  // shl al, 1
      case 0x3441: m.ax = (m.ax & 0xff) | (m.rcl8((m.ax >> 8), 0x1) << 8);  // rcl ah, 1
      case 0x3443: m.bx = (m.bx & 0xff00) | m.shl8((m.bx & 0xff), 0x1);  // shl bl, 1
      case 0x3445: m.ax = (m.ax & 0xff) | (m.rcl8((m.ax >> 8), 0x1) << 8);  // rcl ah, 1
      case 0x3447: m.dx = (m.dx & 0xff00) | m.shl8((m.dx & 0xff), 0x1);  // shl dl, 1
      case 0x3449: m.ax = (m.ax & 0xff) | (m.rcl8((m.ax >> 8), 0x1) << 8);  // rcl ah, 1
      case 0x344b: m.dx = (m.dx & 0xff) | (m.shl8((m.dx >> 8), 0x1) << 8);  // shl dh, 1
      case 0x344d: m.ax = (m.ax & 0xff) | (m.rcl8((m.ax >> 8), 0x1) << 8);  // rcl ah, 1
      case 0x344f: m.ax = (m.ax & 0xff00) | m.shl8((m.ax & 0xff), 0x1);  // shl al, 1
      case 0x3451: m.ax = (m.ax & 0xff) | (m.rcl8((m.ax >> 8), 0x1) << 8);  // rcl ah, 1
      case 0x3453: m.push(m.ax);  // push ax
      case 0x3454: m.push(m.bx);  // push bx
      case 0x3455: m.ax = (m.ax & 0xff00) | (m.ax >> 8);  // mov al, ah
      case 0x3457: m.bx = 0x2400;  // mov bx, 0x2400
      case 0x345a: m.ax = (m.ax & 0xff00) | m.rb(m.cs, (m.bx + (m.ax & 0xff)) & 0xffff);  // xlatb
      case 0x345c: { const t = m.pop(); m.bx = t; }  // pop bx
      case 0x345d: m.wb(m.es, m.di, m.and8(m.rb(m.es, m.di), (m.ax & 0xff)));  // and byte ptr es:[di], al
      case 0x3460: m.wb(m.es, m.di, m.or8(m.rb(m.es, m.di), (m.ax >> 8)));  // or byte ptr es:[di], ah
      case 0x3463: { const t = m.pop(); m.ax = t; }  // pop ax
      case 0x3464: m.di = m.inc16(m.di);  // inc di
      case 0x3465: m.bx = (m.bx & 0xff00) | m.shl8((m.bx & 0xff), 0x1);  // shl bl, 1
      case 0x3467: m.ax = (m.ax & 0xff) | (m.rcl8((m.ax >> 8), 0x1) << 8);  // rcl ah, 1
      case 0x3469: m.dx = (m.dx & 0xff00) | m.shl8((m.dx & 0xff), 0x1);  // shl dl, 1
      case 0x346b: m.ax = (m.ax & 0xff) | (m.rcl8((m.ax >> 8), 0x1) << 8);  // rcl ah, 1
      case 0x346d: m.dx = (m.dx & 0xff) | (m.shl8((m.dx >> 8), 0x1) << 8);  // shl dh, 1
      case 0x346f: m.ax = (m.ax & 0xff) | (m.rcl8((m.ax >> 8), 0x1) << 8);  // rcl ah, 1
      case 0x3471: m.ax = (m.ax & 0xff00) | m.shl8((m.ax & 0xff), 0x1);  // shl al, 1
      case 0x3473: m.ax = (m.ax & 0xff) | (m.rcl8((m.ax >> 8), 0x1) << 8);  // rcl ah, 1
      case 0x3475: m.ax = (m.ax & 0xff) | (m.shl8((m.ax >> 8), 0x1) << 8);  // shl ah, 1
      case 0x3477: m.ax = (m.ax & 0xff) | (m.shl8((m.ax >> 8), 0x1) << 8);  // shl ah, 1
      case 0x3479: m.ax = (m.ax & 0xff) | (m.shl8((m.ax >> 8), 0x1) << 8);  // shl ah, 1
      case 0x347b: m.ax = (m.ax & 0xff) | (m.shl8((m.ax >> 8), 0x1) << 8);  // shl ah, 1
      case 0x347d: m.ax = (m.ax & 0xff) | (m.and8((m.ax >> 8), 0xf0) << 8);  // and ah, 0xf0
      case 0x3480: m.push(m.ax);  // push ax
      case 0x3481: m.push(m.bx);  // push bx
      case 0x3482: m.ax = (m.ax & 0xff00) | (m.ax >> 8);  // mov al, ah
      case 0x3484: m.bx = 0x2400;  // mov bx, 0x2400
      case 0x3487: m.ax = (m.ax & 0xff00) | m.rb(m.cs, (m.bx + (m.ax & 0xff)) & 0xffff);  // xlatb
      case 0x3489: { const t = m.pop(); m.bx = t; }  // pop bx
      case 0x348a: m.wb(m.es, m.di, m.and8(m.rb(m.es, m.di), (m.ax & 0xff)));  // and byte ptr es:[di], al
      case 0x348d: m.wb(m.es, m.di, m.or8(m.rb(m.es, m.di), (m.ax >> 8)));  // or byte ptr es:[di], ah
      case 0x3490: { const t = m.pop(); m.ax = t; }  // pop ax
      case 0x3491: m.di = m.inc16(m.di);  // inc di
      case 0x3492: { const t = m.pop(); m.si = t; }  // pop si
      case 0x3493: { const t = m.pop(); m.di = t; }  // pop di
      case 0x3494: m.si = m.add16(m.si, m.rw(m.cs, 0x2504));  // add si, word ptr cs:[0x2504]
      case 0x3499: m.di = m.add16(m.di, 0x2000);  // add di, 0x2000
      case 0x349d: m.and16(m.di, 0x8000);  // test di, 0x8000
      case 0x34a1: if (m.zf) { ip = 0x34a7; continue; }  // je 0x34a7
      case 0x34a3: m.t += 1; m.pas -= 1; m.di = m.sub16(m.di, 0x7f60);  // sub di, 0x7f60
      case 0x34a7: m.t += 2; m.pas -= 2; m.ww(m.cs, 0x2502, m.dec16(m.rw(m.cs, 0x2502)));  // dec word ptr cs:[0x2502]
      case 0x34ac: if (m.zf) { ip = 0x34b1; continue; }  // je 0x34b1
      case 0x34ae: m.t += 1; m.pas -= 1; ip = 0x3294; continue;  // jmp 0x3294
      case 0x34b1: m.t += 5; m.pas -= 5; m.push(m.ax);  // push ax
      case 0x34b2: m.ax = ((0x0 + m.L) & 0xffff);  // mov ax, 0
      case 0x34b5: m.ds = m.ax;  // mov ds, ax
      case 0x34b7: { const t = m.pop(); m.ax = t; }  // pop ax
      case 0x34b8: ip = m.pop(); continue;  // ret
      case 0x34b9: m.t += 2; m.pas -= 2; m.ax = m.rw(m.ds, 0x19f0);  // mov ax, word ptr [0x19f0]
      case 0x34bc: m.ds = m.ax;  // mov ds, ax
      case 0x34be: m.t += 3; m.pas -= 3; m.dx = m.cx;  // mov dx, cx
      case 0x34c0: m.cx = m.bp;  // mov cx, bp
      case 0x34c2: m.push(m.di);  // push di
      case 0x34c3: m.t += 3; m.pas -= 3; m.lodsb(m.ds, 0);  // lodsb al, byte ptr [si]
      case 0x34c4: m.ax = (m.ax & 0xff00) | m.or8((m.ax & 0xff), (m.ax & 0xff));  // or al, al
      case 0x34c6: if (m.zf) { ip = 0x34cb; continue; }  // je 0x34cb
      case 0x34c8: m.t += 1; m.pas -= 1; m.wb(m.es, m.di, (m.ax & 0xff));  // mov byte ptr es:[di], al
      case 0x34cb: m.t += 2; m.pas -= 2; m.di = m.inc16(m.di);  // inc di
      case 0x34cc: m.cx = (m.cx - 1) & 0xffff; if (m.cx !== 0) { ip = 0x34c3; continue; }  // loop 0x34c3
      case 0x34ce: m.t += 4; m.pas -= 4; { const t = m.pop(); m.di = t; }  // pop di
      case 0x34cf: m.di = m.add16(m.di, 0x140);  // add di, 0x140
      case 0x34d3: m.sub16(m.di, 0xfa00);  // cmp di, 0xfa00
      case 0x34d7: if (m.zf) { ip = 0x34dd; continue; }  // je 0x34dd
      case 0x34d9: m.t += 2; m.pas -= 2; m.cx = m.dx;  // mov cx, dx
      case 0x34db: m.cx = (m.cx - 1) & 0xffff; if (m.cx !== 0) { ip = 0x34be; continue; }  // loop 0x34be
      case 0x34dd: m.t += 5; m.pas -= 5; m.push(m.ax);  // push ax
      case 0x34de: m.ax = ((0x0 + m.L) & 0xffff);  // mov ax, 0
      case 0x34e1: m.ds = m.ax;  // mov ds, ax
      case 0x34e3: { const t = m.pop(); m.ax = t; }  // pop ax
      case 0x34e4: ip = m.pop(); continue;  // ret
      default: return ip;
    }
  }
}

// 0x34e5 sub_7995
function sub_34e5_34e5(m, ip) {
  for (;;) {
    if (m.pas <= 0) return ip;
    switch (ip) {
      case 0x34e5: m.t += 3; m.pas -= 3; m.bx = 0x19d2;  // mov bx, 0x19d2
      case 0x34e8: m.bx = m.add16(m.bx, m.rw(m.ds, 0x1440));  // add bx, word ptr [0x1440]
      case 0x34ec: ip = m.rw(m.ds, m.bx); continue;  // jmp word ptr [bx]
      case 0x34ee: m.t += 1; m.pas -= 1; m.push(0x34f1); ip = 0x2f24; continue;  // call 0x2f24
      case 0x34f1: m.t += 13; m.pas -= 13; m.di = m.rw(m.ds, 0x1a9d);  // mov di, word ptr [0x1a9d]
      case 0x34f5: m.bx = m.rw(m.ds, 0x1a9b);  // mov bx, word ptr [0x1a9b]
      case 0x34f9: m.si = m.shr16(m.si, 0x1);  // shr si, 1
      case 0x34fb: m.ax = m.rw(m.ds, 0x19f0);  // mov ax, word ptr [0x19f0]
      case 0x34fe: m.ds = m.ax;  // mov ds, ax
      case 0x3500: m.ww(m.cs, 0x2502, m.cx);  // mov word ptr cs:[0x2502], cx
      case 0x3505: m.bp = m.shr16(m.bp, 0x1);  // shr bp, 1
      case 0x3507: m.ww(m.cs, 0x2504, m.bp);  // mov word ptr cs:[0x2504], bp
      case 0x350c: m.bp = m.shr16(m.bp, 0x1);  // shr bp, 1
      case 0x350e: m.bp = m.shr16(m.bp, 0x1);  // shr bp, 1
      case 0x3510: m.ww(m.cs, 0x2500, m.bp);  // mov word ptr cs:[0x2500], bp
      case 0x3515: m.sub16(m.bx, 0x1);  // cmp bx, 1
      case 0x3518: if (!m.zf) { ip = 0x351d; continue; }  // jne 0x351d
      case 0x351a: m.t += 1; m.pas -= 1; ip = 0x35fe; continue;  // jmp 0x35fe
      case 0x351d: m.t += 3; m.pas -= 3; m.cx = m.rw(m.cs, 0x2500);  // mov cx, word ptr cs:[0x2500]
      case 0x3522: m.push(m.di);  // push di
      case 0x3523: m.push(m.si);  // push si
      case 0x3524: m.t += 83; m.pas -= 83; m.bx = m.rw(m.cs, 0x2504);  // mov bx, word ptr cs:[0x2504]
      case 0x3529: m.bx = m.sub16(m.bx, m.rw(m.cs, 0x2500));  // sub bx, word ptr cs:[0x2500]
      case 0x352e: m.ax = (m.ax & 0xff00) | m.rb(m.ds, ((m.bx + m.si) & 0xffff));  // mov al, byte ptr [bx + si]
      case 0x3530: m.bx = m.sub16(m.bx, m.rw(m.cs, 0x2500));  // sub bx, word ptr cs:[0x2500]
      case 0x3535: m.dx = (m.dx & 0xff) | (m.rb(m.ds, ((m.bx + m.si) & 0xffff)) << 8);  // mov dh, byte ptr [bx + si]
      case 0x3537: m.bx = m.sub16(m.bx, m.rw(m.cs, 0x2500));  // sub bx, word ptr cs:[0x2500]
      case 0x353c: m.dx = (m.dx & 0xff00) | m.rb(m.ds, ((m.bx + m.si) & 0xffff));  // mov dl, byte ptr [bx + si]
      case 0x353e: m.bx = (m.bx & 0xff00) | m.rb(m.ds, m.si);  // mov bl, byte ptr [si]
      case 0x3540: m.bx = (m.bx & 0xff00) | m.shl8((m.bx & 0xff), 0x1);  // shl bl, 1
      case 0x3542: m.ax = (m.ax & 0xff) | (m.rcl8((m.ax >> 8), 0x1) << 8);  // rcl ah, 1
      case 0x3544: m.dx = (m.dx & 0xff00) | m.shl8((m.dx & 0xff), 0x1);  // shl dl, 1
      case 0x3546: m.ax = (m.ax & 0xff) | (m.rcl8((m.ax >> 8), 0x1) << 8);  // rcl ah, 1
      case 0x3548: m.dx = (m.dx & 0xff) | (m.shl8((m.dx >> 8), 0x1) << 8);  // shl dh, 1
      case 0x354a: m.ax = (m.ax & 0xff) | (m.rcl8((m.ax >> 8), 0x1) << 8);  // rcl ah, 1
      case 0x354c: m.ax = (m.ax & 0xff00) | m.shl8((m.ax & 0xff), 0x1);  // shl al, 1
      case 0x354e: m.ax = (m.ax & 0xff) | (m.rcl8((m.ax >> 8), 0x1) << 8);  // rcl ah, 1
      case 0x3550: m.bx = (m.bx & 0xff00) | m.shl8((m.bx & 0xff), 0x1);  // shl bl, 1
      case 0x3552: m.ax = (m.ax & 0xff) | (m.rcl8((m.ax >> 8), 0x1) << 8);  // rcl ah, 1
      case 0x3554: m.dx = (m.dx & 0xff00) | m.shl8((m.dx & 0xff), 0x1);  // shl dl, 1
      case 0x3556: m.ax = (m.ax & 0xff) | (m.rcl8((m.ax >> 8), 0x1) << 8);  // rcl ah, 1
      case 0x3558: m.dx = (m.dx & 0xff) | (m.shl8((m.dx >> 8), 0x1) << 8);  // shl dh, 1
      case 0x355a: m.ax = (m.ax & 0xff) | (m.rcl8((m.ax >> 8), 0x1) << 8);  // rcl ah, 1
      case 0x355c: m.ax = (m.ax & 0xff00) | m.shl8((m.ax & 0xff), 0x1);  // shl al, 1
      case 0x355e: m.ax = (m.ax & 0xff) | (m.rcl8((m.ax >> 8), 0x1) << 8);  // rcl ah, 1
      case 0x3560: m.wb(m.es, m.di, (m.ax >> 8));  // mov byte ptr es:[di], ah
      case 0x3563: m.di = m.inc16(m.di);  // inc di
      case 0x3564: m.bx = (m.bx & 0xff00) | m.shl8((m.bx & 0xff), 0x1);  // shl bl, 1
      case 0x3566: m.ax = (m.ax & 0xff) | (m.rcl8((m.ax >> 8), 0x1) << 8);  // rcl ah, 1
      case 0x3568: m.dx = (m.dx & 0xff00) | m.shl8((m.dx & 0xff), 0x1);  // shl dl, 1
      case 0x356a: m.ax = (m.ax & 0xff) | (m.rcl8((m.ax >> 8), 0x1) << 8);  // rcl ah, 1
      case 0x356c: m.dx = (m.dx & 0xff) | (m.shl8((m.dx >> 8), 0x1) << 8);  // shl dh, 1
      case 0x356e: m.ax = (m.ax & 0xff) | (m.rcl8((m.ax >> 8), 0x1) << 8);  // rcl ah, 1
      case 0x3570: m.ax = (m.ax & 0xff00) | m.shl8((m.ax & 0xff), 0x1);  // shl al, 1
      case 0x3572: m.ax = (m.ax & 0xff) | (m.rcl8((m.ax >> 8), 0x1) << 8);  // rcl ah, 1
      case 0x3574: m.bx = (m.bx & 0xff00) | m.shl8((m.bx & 0xff), 0x1);  // shl bl, 1
      case 0x3576: m.ax = (m.ax & 0xff) | (m.rcl8((m.ax >> 8), 0x1) << 8);  // rcl ah, 1
      case 0x3578: m.dx = (m.dx & 0xff00) | m.shl8((m.dx & 0xff), 0x1);  // shl dl, 1
      case 0x357a: m.ax = (m.ax & 0xff) | (m.rcl8((m.ax >> 8), 0x1) << 8);  // rcl ah, 1
      case 0x357c: m.dx = (m.dx & 0xff) | (m.shl8((m.dx >> 8), 0x1) << 8);  // shl dh, 1
      case 0x357e: m.ax = (m.ax & 0xff) | (m.rcl8((m.ax >> 8), 0x1) << 8);  // rcl ah, 1
      case 0x3580: m.ax = (m.ax & 0xff00) | m.shl8((m.ax & 0xff), 0x1);  // shl al, 1
      case 0x3582: m.ax = (m.ax & 0xff) | (m.rcl8((m.ax >> 8), 0x1) << 8);  // rcl ah, 1
      case 0x3584: m.wb(m.es, m.di, (m.ax >> 8));  // mov byte ptr es:[di], ah
      case 0x3587: m.di = m.inc16(m.di);  // inc di
      case 0x3588: m.bx = (m.bx & 0xff00) | m.shl8((m.bx & 0xff), 0x1);  // shl bl, 1
      case 0x358a: m.ax = (m.ax & 0xff) | (m.rcl8((m.ax >> 8), 0x1) << 8);  // rcl ah, 1
      case 0x358c: m.dx = (m.dx & 0xff00) | m.shl8((m.dx & 0xff), 0x1);  // shl dl, 1
      case 0x358e: m.ax = (m.ax & 0xff) | (m.rcl8((m.ax >> 8), 0x1) << 8);  // rcl ah, 1
      case 0x3590: m.dx = (m.dx & 0xff) | (m.shl8((m.dx >> 8), 0x1) << 8);  // shl dh, 1
      case 0x3592: m.ax = (m.ax & 0xff) | (m.rcl8((m.ax >> 8), 0x1) << 8);  // rcl ah, 1
      case 0x3594: m.ax = (m.ax & 0xff00) | m.shl8((m.ax & 0xff), 0x1);  // shl al, 1
      case 0x3596: m.ax = (m.ax & 0xff) | (m.rcl8((m.ax >> 8), 0x1) << 8);  // rcl ah, 1
      case 0x3598: m.bx = (m.bx & 0xff00) | m.shl8((m.bx & 0xff), 0x1);  // shl bl, 1
      case 0x359a: m.ax = (m.ax & 0xff) | (m.rcl8((m.ax >> 8), 0x1) << 8);  // rcl ah, 1
      case 0x359c: m.dx = (m.dx & 0xff00) | m.shl8((m.dx & 0xff), 0x1);  // shl dl, 1
      case 0x359e: m.ax = (m.ax & 0xff) | (m.rcl8((m.ax >> 8), 0x1) << 8);  // rcl ah, 1
      case 0x35a0: m.dx = (m.dx & 0xff) | (m.shl8((m.dx >> 8), 0x1) << 8);  // shl dh, 1
      case 0x35a2: m.ax = (m.ax & 0xff) | (m.rcl8((m.ax >> 8), 0x1) << 8);  // rcl ah, 1
      case 0x35a4: m.ax = (m.ax & 0xff00) | m.shl8((m.ax & 0xff), 0x1);  // shl al, 1
      case 0x35a6: m.ax = (m.ax & 0xff) | (m.rcl8((m.ax >> 8), 0x1) << 8);  // rcl ah, 1
      case 0x35a8: m.wb(m.es, m.di, (m.ax >> 8));  // mov byte ptr es:[di], ah
      case 0x35ab: m.di = m.inc16(m.di);  // inc di
      case 0x35ac: m.bx = (m.bx & 0xff00) | m.shl8((m.bx & 0xff), 0x1);  // shl bl, 1
      case 0x35ae: m.ax = (m.ax & 0xff) | (m.rcl8((m.ax >> 8), 0x1) << 8);  // rcl ah, 1
      case 0x35b0: m.dx = (m.dx & 0xff00) | m.shl8((m.dx & 0xff), 0x1);  // shl dl, 1
      case 0x35b2: m.ax = (m.ax & 0xff) | (m.rcl8((m.ax >> 8), 0x1) << 8);  // rcl ah, 1
      case 0x35b4: m.dx = (m.dx & 0xff) | (m.shl8((m.dx >> 8), 0x1) << 8);  // shl dh, 1
      case 0x35b6: m.ax = (m.ax & 0xff) | (m.rcl8((m.ax >> 8), 0x1) << 8);  // rcl ah, 1
      case 0x35b8: m.ax = (m.ax & 0xff00) | m.shl8((m.ax & 0xff), 0x1);  // shl al, 1
      case 0x35ba: m.ax = (m.ax & 0xff) | (m.rcl8((m.ax >> 8), 0x1) << 8);  // rcl ah, 1
      case 0x35bc: m.bx = (m.bx & 0xff00) | m.shl8((m.bx & 0xff), 0x1);  // shl bl, 1
      case 0x35be: m.ax = (m.ax & 0xff) | (m.rcl8((m.ax >> 8), 0x1) << 8);  // rcl ah, 1
      case 0x35c0: m.dx = (m.dx & 0xff00) | m.shl8((m.dx & 0xff), 0x1);  // shl dl, 1
      case 0x35c2: m.ax = (m.ax & 0xff) | (m.rcl8((m.ax >> 8), 0x1) << 8);  // rcl ah, 1
      case 0x35c4: m.dx = (m.dx & 0xff) | (m.shl8((m.dx >> 8), 0x1) << 8);  // shl dh, 1
      case 0x35c6: m.ax = (m.ax & 0xff) | (m.rcl8((m.ax >> 8), 0x1) << 8);  // rcl ah, 1
      case 0x35c8: m.ax = (m.ax & 0xff00) | m.shl8((m.ax & 0xff), 0x1);  // shl al, 1
      case 0x35ca: m.ax = (m.ax & 0xff) | (m.rcl8((m.ax >> 8), 0x1) << 8);  // rcl ah, 1
      case 0x35cc: m.wb(m.es, m.di, (m.ax >> 8));  // mov byte ptr es:[di], ah
      case 0x35cf: m.di = m.inc16(m.di);  // inc di
      case 0x35d0: m.si = m.inc16(m.si);  // inc si
      case 0x35d1: m.cx = m.dec16(m.cx);  // dec cx
      case 0x35d2: if (m.zf) { ip = 0x35d7; continue; }  // je 0x35d7
      case 0x35d4: m.t += 1; m.pas -= 1; ip = 0x3524; continue;  // jmp 0x3524
      case 0x35d7: m.t += 6; m.pas -= 6; { const t = m.pop(); m.si = t; }  // pop si
      case 0x35d8: { const t = m.pop(); m.di = t; }  // pop di
      case 0x35d9: m.si = m.add16(m.si, m.rw(m.cs, 0x2504));  // add si, word ptr cs:[0x2504]
      case 0x35de: m.di = m.add16(m.di, 0x2000);  // add di, 0x2000
      case 0x35e2: m.and16(m.di, 0x8000);  // test di, 0x8000
      case 0x35e6: if (m.zf) { ip = 0x35ec; continue; }  // je 0x35ec
      case 0x35e8: m.t += 1; m.pas -= 1; m.di = m.sub16(m.di, 0x7f60);  // sub di, 0x7f60
      case 0x35ec: m.t += 2; m.pas -= 2; m.ww(m.cs, 0x2502, m.dec16(m.rw(m.cs, 0x2502)));  // dec word ptr cs:[0x2502]
      case 0x35f1: if (m.zf) { ip = 0x35f6; continue; }  // je 0x35f6
      case 0x35f3: m.t += 1; m.pas -= 1; ip = 0x351d; continue;  // jmp 0x351d
      case 0x35f6: m.t += 5; m.pas -= 5; m.push(m.ax);  // push ax
      case 0x35f7: m.ax = ((0x0 + m.L) & 0xffff);  // mov ax, 0
      case 0x35fa: m.ds = m.ax;  // mov ds, ax
      case 0x35fc: { const t = m.pop(); m.ax = t; }  // pop ax
      case 0x35fd: ip = m.pop(); continue;  // ret
      case 0x35fe: m.t += 1; m.pas -= 1; m.ww(m.cs, 0x2502, m.cx);  // mov word ptr cs:[0x2502], cx
      case 0x3603: m.t += 32; m.pas -= 32; m.cx = m.rw(m.cs, 0x2500);  // mov cx, word ptr cs:[0x2500]
      case 0x3608: m.push(m.di);  // push di
      case 0x3609: m.push(m.si);  // push si
      case 0x360a: m.xor8(0, 0); m.ax = (m.ax & 0xff) | (0 << 8);  // xor ah, ah
      case 0x360c: m.bx = m.rw(m.cs, 0x2504);  // mov bx, word ptr cs:[0x2504]
      case 0x3611: m.bx = m.sub16(m.bx, m.rw(m.cs, 0x2500));  // sub bx, word ptr cs:[0x2500]
      case 0x3616: m.ax = (m.ax & 0xff00) | m.rb(m.ds, ((m.bx + m.si) & 0xffff));  // mov al, byte ptr [bx + si]
      case 0x3618: m.bx = m.sub16(m.bx, m.rw(m.cs, 0x2500));  // sub bx, word ptr cs:[0x2500]
      case 0x361d: m.dx = (m.dx & 0xff) | (m.rb(m.ds, ((m.bx + m.si) & 0xffff)) << 8);  // mov dh, byte ptr [bx + si]
      case 0x361f: m.bx = m.sub16(m.bx, m.rw(m.cs, 0x2500));  // sub bx, word ptr cs:[0x2500]
      case 0x3624: m.dx = (m.dx & 0xff00) | m.rb(m.ds, ((m.bx + m.si) & 0xffff));  // mov dl, byte ptr [bx + si]
      case 0x3626: m.bx = (m.bx & 0xff00) | m.rb(m.ds, m.si);  // mov bl, byte ptr [si]
      case 0x3628: m.bx = (m.bx & 0xff00) | m.shl8((m.bx & 0xff), 0x1);  // shl bl, 1
      case 0x362a: m.ax = (m.ax & 0xff) | (m.rcl8((m.ax >> 8), 0x1) << 8);  // rcl ah, 1
      case 0x362c: m.dx = (m.dx & 0xff00) | m.shl8((m.dx & 0xff), 0x1);  // shl dl, 1
      case 0x362e: m.ax = (m.ax & 0xff) | (m.rcl8((m.ax >> 8), 0x1) << 8);  // rcl ah, 1
      case 0x3630: m.dx = (m.dx & 0xff) | (m.shl8((m.dx >> 8), 0x1) << 8);  // shl dh, 1
      case 0x3632: m.ax = (m.ax & 0xff) | (m.rcl8((m.ax >> 8), 0x1) << 8);  // rcl ah, 1
      case 0x3634: m.ax = (m.ax & 0xff00) | m.shl8((m.ax & 0xff), 0x1);  // shl al, 1
      case 0x3636: m.ax = (m.ax & 0xff) | (m.rcl8((m.ax >> 8), 0x1) << 8);  // rcl ah, 1
      case 0x3638: m.push(m.ax);  // push ax
      case 0x3639: m.push(m.bx);  // push bx
      case 0x363a: m.ax = (m.ax & 0xff00) | (m.ax >> 8);  // mov al, ah
      case 0x363c: m.bx = 0x2400;  // mov bx, 0x2400
      case 0x363f: m.ax = (m.ax & 0xff00) | m.rb(m.cs, (m.bx + (m.ax & 0xff)) & 0xffff);  // xlatb
      case 0x3641: { const t = m.pop(); m.bx = t; }  // pop bx
      case 0x3642: m.wb(m.es, m.di, m.and8(m.rb(m.es, m.di), (m.ax & 0xff)));  // and byte ptr es:[di], al
      case 0x3645: m.wb(m.es, m.di, m.or8(m.rb(m.es, m.di), (m.ax >> 8)));  // or byte ptr es:[di], ah
      case 0x3648: { const t = m.pop(); m.ax = t; }  // pop ax
      case 0x3649: m.di = m.inc16(m.di);  // inc di
      case 0x364a: m.sub16(m.cx, 0x1);  // cmp cx, 1
      case 0x364d: if (!m.zf) { ip = 0x3652; continue; }  // jne 0x3652
      case 0x364f: m.t += 1; m.pas -= 1; ip = 0x3702; continue;  // jmp 0x3702
      case 0x3652: m.t += 1; m.pas -= 1; m.cx = m.dec16(m.cx);  // dec cx
      case 0x3653: m.t += 79; m.pas -= 79; m.bx = (m.bx & 0xff00) | m.shl8((m.bx & 0xff), 0x1);  // shl bl, 1
      case 0x3655: m.ax = (m.ax & 0xff) | (m.rcl8((m.ax >> 8), 0x1) << 8);  // rcl ah, 1
      case 0x3657: m.dx = (m.dx & 0xff00) | m.shl8((m.dx & 0xff), 0x1);  // shl dl, 1
      case 0x3659: m.ax = (m.ax & 0xff) | (m.rcl8((m.ax >> 8), 0x1) << 8);  // rcl ah, 1
      case 0x365b: m.dx = (m.dx & 0xff) | (m.shl8((m.dx >> 8), 0x1) << 8);  // shl dh, 1
      case 0x365d: m.ax = (m.ax & 0xff) | (m.rcl8((m.ax >> 8), 0x1) << 8);  // rcl ah, 1
      case 0x365f: m.ax = (m.ax & 0xff00) | m.shl8((m.ax & 0xff), 0x1);  // shl al, 1
      case 0x3661: m.ax = (m.ax & 0xff) | (m.rcl8((m.ax >> 8), 0x1) << 8);  // rcl ah, 1
      case 0x3663: m.bx = (m.bx & 0xff00) | m.shl8((m.bx & 0xff), 0x1);  // shl bl, 1
      case 0x3665: m.ax = (m.ax & 0xff) | (m.rcl8((m.ax >> 8), 0x1) << 8);  // rcl ah, 1
      case 0x3667: m.dx = (m.dx & 0xff00) | m.shl8((m.dx & 0xff), 0x1);  // shl dl, 1
      case 0x3669: m.ax = (m.ax & 0xff) | (m.rcl8((m.ax >> 8), 0x1) << 8);  // rcl ah, 1
      case 0x366b: m.dx = (m.dx & 0xff) | (m.shl8((m.dx >> 8), 0x1) << 8);  // shl dh, 1
      case 0x366d: m.ax = (m.ax & 0xff) | (m.rcl8((m.ax >> 8), 0x1) << 8);  // rcl ah, 1
      case 0x366f: m.ax = (m.ax & 0xff00) | m.shl8((m.ax & 0xff), 0x1);  // shl al, 1
      case 0x3671: m.ax = (m.ax & 0xff) | (m.rcl8((m.ax >> 8), 0x1) << 8);  // rcl ah, 1
      case 0x3673: m.wb(m.es, m.di, (m.ax >> 8));  // mov byte ptr es:[di], ah
      case 0x3676: m.bx = (m.bx & 0xff00) | m.shl8((m.bx & 0xff), 0x1);  // shl bl, 1
      case 0x3678: m.ax = (m.ax & 0xff) | (m.rcl8((m.ax >> 8), 0x1) << 8);  // rcl ah, 1
      case 0x367a: m.dx = (m.dx & 0xff00) | m.shl8((m.dx & 0xff), 0x1);  // shl dl, 1
      case 0x367c: m.ax = (m.ax & 0xff) | (m.rcl8((m.ax >> 8), 0x1) << 8);  // rcl ah, 1
      case 0x367e: m.dx = (m.dx & 0xff) | (m.shl8((m.dx >> 8), 0x1) << 8);  // shl dh, 1
      case 0x3680: m.ax = (m.ax & 0xff) | (m.rcl8((m.ax >> 8), 0x1) << 8);  // rcl ah, 1
      case 0x3682: m.ax = (m.ax & 0xff00) | m.shl8((m.ax & 0xff), 0x1);  // shl al, 1
      case 0x3684: m.ax = (m.ax & 0xff) | (m.rcl8((m.ax >> 8), 0x1) << 8);  // rcl ah, 1
      case 0x3686: m.bx = (m.bx & 0xff00) | m.shl8((m.bx & 0xff), 0x1);  // shl bl, 1
      case 0x3688: m.ax = (m.ax & 0xff) | (m.rcl8((m.ax >> 8), 0x1) << 8);  // rcl ah, 1
      case 0x368a: m.dx = (m.dx & 0xff00) | m.shl8((m.dx & 0xff), 0x1);  // shl dl, 1
      case 0x368c: m.ax = (m.ax & 0xff) | (m.rcl8((m.ax >> 8), 0x1) << 8);  // rcl ah, 1
      case 0x368e: m.dx = (m.dx & 0xff) | (m.shl8((m.dx >> 8), 0x1) << 8);  // shl dh, 1
      case 0x3690: m.ax = (m.ax & 0xff) | (m.rcl8((m.ax >> 8), 0x1) << 8);  // rcl ah, 1
      case 0x3692: m.ax = (m.ax & 0xff00) | m.shl8((m.ax & 0xff), 0x1);  // shl al, 1
      case 0x3694: m.ax = (m.ax & 0xff) | (m.rcl8((m.ax >> 8), 0x1) << 8);  // rcl ah, 1
      case 0x3696: m.wb(m.es, m.di, (m.ax >> 8));  // mov byte ptr es:[di], ah
      case 0x3699: m.bx = (m.bx & 0xff00) | m.shl8((m.bx & 0xff), 0x1);  // shl bl, 1
      case 0x369b: m.ax = (m.ax & 0xff) | (m.rcl8((m.ax >> 8), 0x1) << 8);  // rcl ah, 1
      case 0x369d: m.dx = (m.dx & 0xff00) | m.shl8((m.dx & 0xff), 0x1);  // shl dl, 1
      case 0x369f: m.ax = (m.ax & 0xff) | (m.rcl8((m.ax >> 8), 0x1) << 8);  // rcl ah, 1
      case 0x36a1: m.dx = (m.dx & 0xff) | (m.shl8((m.dx >> 8), 0x1) << 8);  // shl dh, 1
      case 0x36a3: m.ax = (m.ax & 0xff) | (m.rcl8((m.ax >> 8), 0x1) << 8);  // rcl ah, 1
      case 0x36a5: m.ax = (m.ax & 0xff00) | m.shl8((m.ax & 0xff), 0x1);  // shl al, 1
      case 0x36a7: m.ax = (m.ax & 0xff) | (m.rcl8((m.ax >> 8), 0x1) << 8);  // rcl ah, 1
      case 0x36a9: m.bx = (m.bx & 0xff00) | m.shl8((m.bx & 0xff), 0x1);  // shl bl, 1
      case 0x36ab: m.ax = (m.ax & 0xff) | (m.rcl8((m.ax >> 8), 0x1) << 8);  // rcl ah, 1
      case 0x36ad: m.dx = (m.dx & 0xff00) | m.shl8((m.dx & 0xff), 0x1);  // shl dl, 1
      case 0x36af: m.ax = (m.ax & 0xff) | (m.rcl8((m.ax >> 8), 0x1) << 8);  // rcl ah, 1
      case 0x36b1: m.dx = (m.dx & 0xff) | (m.shl8((m.dx >> 8), 0x1) << 8);  // shl dh, 1
      case 0x36b3: m.ax = (m.ax & 0xff) | (m.rcl8((m.ax >> 8), 0x1) << 8);  // rcl ah, 1
      case 0x36b5: m.ax = (m.ax & 0xff00) | m.shl8((m.ax & 0xff), 0x1);  // shl al, 1
      case 0x36b7: m.ax = (m.ax & 0xff) | (m.rcl8((m.ax >> 8), 0x1) << 8);  // rcl ah, 1
      case 0x36b9: m.wb(m.es, m.di, (m.ax >> 8));  // mov byte ptr es:[di], ah
      case 0x36bc: m.bx = (m.bx & 0xff00) | m.shl8((m.bx & 0xff), 0x1);  // shl bl, 1
      case 0x36be: m.ax = (m.ax & 0xff) | (m.rcl8((m.ax >> 8), 0x1) << 8);  // rcl ah, 1
      case 0x36c0: m.dx = (m.dx & 0xff00) | m.shl8((m.dx & 0xff), 0x1);  // shl dl, 1
      case 0x36c2: m.ax = (m.ax & 0xff) | (m.rcl8((m.ax >> 8), 0x1) << 8);  // rcl ah, 1
      case 0x36c4: m.dx = (m.dx & 0xff) | (m.shl8((m.dx >> 8), 0x1) << 8);  // shl dh, 1
      case 0x36c6: m.ax = (m.ax & 0xff) | (m.rcl8((m.ax >> 8), 0x1) << 8);  // rcl ah, 1
      case 0x36c8: m.ax = (m.ax & 0xff00) | m.shl8((m.ax & 0xff), 0x1);  // shl al, 1
      case 0x36ca: m.ax = (m.ax & 0xff) | (m.rcl8((m.ax >> 8), 0x1) << 8);  // rcl ah, 1
      case 0x36cc: m.si = m.inc16(m.si);  // inc si
      case 0x36cd: m.bx = m.rw(m.cs, 0x2504);  // mov bx, word ptr cs:[0x2504]
      case 0x36d2: m.bx = m.sub16(m.bx, m.rw(m.cs, 0x2500));  // sub bx, word ptr cs:[0x2500]
      case 0x36d7: m.ax = (m.ax & 0xff00) | m.rb(m.ds, ((m.bx + m.si) & 0xffff));  // mov al, byte ptr [bx + si]
      case 0x36d9: m.bx = m.sub16(m.bx, m.rw(m.cs, 0x2500));  // sub bx, word ptr cs:[0x2500]
      case 0x36de: m.dx = (m.dx & 0xff) | (m.rb(m.ds, ((m.bx + m.si) & 0xffff)) << 8);  // mov dh, byte ptr [bx + si]
      case 0x36e0: m.bx = m.sub16(m.bx, m.rw(m.cs, 0x2500));  // sub bx, word ptr cs:[0x2500]
      case 0x36e5: m.dx = (m.dx & 0xff00) | m.rb(m.ds, ((m.bx + m.si) & 0xffff));  // mov dl, byte ptr [bx + si]
      case 0x36e7: m.bx = (m.bx & 0xff00) | m.rb(m.ds, m.si);  // mov bl, byte ptr [si]
      case 0x36e9: m.bx = (m.bx & 0xff00) | m.shl8((m.bx & 0xff), 0x1);  // shl bl, 1
      case 0x36eb: m.ax = (m.ax & 0xff) | (m.rcl8((m.ax >> 8), 0x1) << 8);  // rcl ah, 1
      case 0x36ed: m.dx = (m.dx & 0xff00) | m.shl8((m.dx & 0xff), 0x1);  // shl dl, 1
      case 0x36ef: m.ax = (m.ax & 0xff) | (m.rcl8((m.ax >> 8), 0x1) << 8);  // rcl ah, 1
      case 0x36f1: m.dx = (m.dx & 0xff) | (m.shl8((m.dx >> 8), 0x1) << 8);  // shl dh, 1
      case 0x36f3: m.ax = (m.ax & 0xff) | (m.rcl8((m.ax >> 8), 0x1) << 8);  // rcl ah, 1
      case 0x36f5: m.ax = (m.ax & 0xff00) | m.shl8((m.ax & 0xff), 0x1);  // shl al, 1
      case 0x36f7: m.ax = (m.ax & 0xff) | (m.rcl8((m.ax >> 8), 0x1) << 8);  // rcl ah, 1
      case 0x36f9: m.wb(m.es, m.di, (m.ax >> 8));  // mov byte ptr es:[di], ah
      case 0x36fc: m.cx = m.dec16(m.cx);  // dec cx
      case 0x36fd: if (m.zf) { ip = 0x3702; continue; }  // je 0x3702
      case 0x36ff: m.t += 1; m.pas -= 1; ip = 0x3653; continue;  // jmp 0x3653
      case 0x3702: m.t += 80; m.pas -= 80; m.bx = (m.bx & 0xff00) | m.shl8((m.bx & 0xff), 0x1);  // shl bl, 1
      case 0x3704: m.ax = (m.ax & 0xff) | (m.rcl8((m.ax >> 8), 0x1) << 8);  // rcl ah, 1
      case 0x3706: m.dx = (m.dx & 0xff00) | m.shl8((m.dx & 0xff), 0x1);  // shl dl, 1
      case 0x3708: m.ax = (m.ax & 0xff) | (m.rcl8((m.ax >> 8), 0x1) << 8);  // rcl ah, 1
      case 0x370a: m.dx = (m.dx & 0xff) | (m.shl8((m.dx >> 8), 0x1) << 8);  // shl dh, 1
      case 0x370c: m.ax = (m.ax & 0xff) | (m.rcl8((m.ax >> 8), 0x1) << 8);  // rcl ah, 1
      case 0x370e: m.ax = (m.ax & 0xff00) | m.shl8((m.ax & 0xff), 0x1);  // shl al, 1
      case 0x3710: m.ax = (m.ax & 0xff) | (m.rcl8((m.ax >> 8), 0x1) << 8);  // rcl ah, 1
      case 0x3712: m.bx = (m.bx & 0xff00) | m.shl8((m.bx & 0xff), 0x1);  // shl bl, 1
      case 0x3714: m.ax = (m.ax & 0xff) | (m.rcl8((m.ax >> 8), 0x1) << 8);  // rcl ah, 1
      case 0x3716: m.dx = (m.dx & 0xff00) | m.shl8((m.dx & 0xff), 0x1);  // shl dl, 1
      case 0x3718: m.ax = (m.ax & 0xff) | (m.rcl8((m.ax >> 8), 0x1) << 8);  // rcl ah, 1
      case 0x371a: m.dx = (m.dx & 0xff) | (m.shl8((m.dx >> 8), 0x1) << 8);  // shl dh, 1
      case 0x371c: m.ax = (m.ax & 0xff) | (m.rcl8((m.ax >> 8), 0x1) << 8);  // rcl ah, 1
      case 0x371e: m.ax = (m.ax & 0xff00) | m.shl8((m.ax & 0xff), 0x1);  // shl al, 1
      case 0x3720: m.ax = (m.ax & 0xff) | (m.rcl8((m.ax >> 8), 0x1) << 8);  // rcl ah, 1
      case 0x3722: m.wb(m.es, m.di, (m.ax >> 8));  // mov byte ptr es:[di], ah
      case 0x3725: m.bx = (m.bx & 0xff00) | m.shl8((m.bx & 0xff), 0x1);  // shl bl, 1
      case 0x3727: m.ax = (m.ax & 0xff) | (m.rcl8((m.ax >> 8), 0x1) << 8);  // rcl ah, 1
      case 0x3729: m.dx = (m.dx & 0xff00) | m.shl8((m.dx & 0xff), 0x1);  // shl dl, 1
      case 0x372b: m.ax = (m.ax & 0xff) | (m.rcl8((m.ax >> 8), 0x1) << 8);  // rcl ah, 1
      case 0x372d: m.dx = (m.dx & 0xff) | (m.shl8((m.dx >> 8), 0x1) << 8);  // shl dh, 1
      case 0x372f: m.ax = (m.ax & 0xff) | (m.rcl8((m.ax >> 8), 0x1) << 8);  // rcl ah, 1
      case 0x3731: m.ax = (m.ax & 0xff00) | m.shl8((m.ax & 0xff), 0x1);  // shl al, 1
      case 0x3733: m.ax = (m.ax & 0xff) | (m.rcl8((m.ax >> 8), 0x1) << 8);  // rcl ah, 1
      case 0x3735: m.bx = (m.bx & 0xff00) | m.shl8((m.bx & 0xff), 0x1);  // shl bl, 1
      case 0x3737: m.ax = (m.ax & 0xff) | (m.rcl8((m.ax >> 8), 0x1) << 8);  // rcl ah, 1
      case 0x3739: m.dx = (m.dx & 0xff00) | m.shl8((m.dx & 0xff), 0x1);  // shl dl, 1
      case 0x373b: m.ax = (m.ax & 0xff) | (m.rcl8((m.ax >> 8), 0x1) << 8);  // rcl ah, 1
      case 0x373d: m.dx = (m.dx & 0xff) | (m.shl8((m.dx >> 8), 0x1) << 8);  // shl dh, 1
      case 0x373f: m.ax = (m.ax & 0xff) | (m.rcl8((m.ax >> 8), 0x1) << 8);  // rcl ah, 1
      case 0x3741: m.ax = (m.ax & 0xff00) | m.shl8((m.ax & 0xff), 0x1);  // shl al, 1
      case 0x3743: m.ax = (m.ax & 0xff) | (m.rcl8((m.ax >> 8), 0x1) << 8);  // rcl ah, 1
      case 0x3745: m.wb(m.es, m.di, (m.ax >> 8));  // mov byte ptr es:[di], ah
      case 0x3748: m.bx = (m.bx & 0xff00) | m.shl8((m.bx & 0xff), 0x1);  // shl bl, 1
      case 0x374a: m.ax = (m.ax & 0xff) | (m.rcl8((m.ax >> 8), 0x1) << 8);  // rcl ah, 1
      case 0x374c: m.dx = (m.dx & 0xff00) | m.shl8((m.dx & 0xff), 0x1);  // shl dl, 1
      case 0x374e: m.ax = (m.ax & 0xff) | (m.rcl8((m.ax >> 8), 0x1) << 8);  // rcl ah, 1
      case 0x3750: m.dx = (m.dx & 0xff) | (m.shl8((m.dx >> 8), 0x1) << 8);  // shl dh, 1
      case 0x3752: m.ax = (m.ax & 0xff) | (m.rcl8((m.ax >> 8), 0x1) << 8);  // rcl ah, 1
      case 0x3754: m.ax = (m.ax & 0xff00) | m.shl8((m.ax & 0xff), 0x1);  // shl al, 1
      case 0x3756: m.ax = (m.ax & 0xff) | (m.rcl8((m.ax >> 8), 0x1) << 8);  // rcl ah, 1
      case 0x3758: m.bx = (m.bx & 0xff00) | m.shl8((m.bx & 0xff), 0x1);  // shl bl, 1
      case 0x375a: m.ax = (m.ax & 0xff) | (m.rcl8((m.ax >> 8), 0x1) << 8);  // rcl ah, 1
      case 0x375c: m.dx = (m.dx & 0xff00) | m.shl8((m.dx & 0xff), 0x1);  // shl dl, 1
      case 0x375e: m.ax = (m.ax & 0xff) | (m.rcl8((m.ax >> 8), 0x1) << 8);  // rcl ah, 1
      case 0x3760: m.dx = (m.dx & 0xff) | (m.shl8((m.dx >> 8), 0x1) << 8);  // shl dh, 1
      case 0x3762: m.ax = (m.ax & 0xff) | (m.rcl8((m.ax >> 8), 0x1) << 8);  // rcl ah, 1
      case 0x3764: m.ax = (m.ax & 0xff00) | m.shl8((m.ax & 0xff), 0x1);  // shl al, 1
      case 0x3766: m.ax = (m.ax & 0xff) | (m.rcl8((m.ax >> 8), 0x1) << 8);  // rcl ah, 1
      case 0x3768: m.wb(m.es, m.di, (m.ax >> 8));  // mov byte ptr es:[di], ah
      case 0x376b: m.bx = (m.bx & 0xff00) | m.shl8((m.bx & 0xff), 0x1);  // shl bl, 1
      case 0x376d: m.ax = (m.ax & 0xff) | (m.rcl8((m.ax >> 8), 0x1) << 8);  // rcl ah, 1
      case 0x376f: m.dx = (m.dx & 0xff00) | m.shl8((m.dx & 0xff), 0x1);  // shl dl, 1
      case 0x3771: m.ax = (m.ax & 0xff) | (m.rcl8((m.ax >> 8), 0x1) << 8);  // rcl ah, 1
      case 0x3773: m.dx = (m.dx & 0xff) | (m.shl8((m.dx >> 8), 0x1) << 8);  // shl dh, 1
      case 0x3775: m.ax = (m.ax & 0xff) | (m.rcl8((m.ax >> 8), 0x1) << 8);  // rcl ah, 1
      case 0x3777: m.ax = (m.ax & 0xff00) | m.shl8((m.ax & 0xff), 0x1);  // shl al, 1
      case 0x3779: m.ax = (m.ax & 0xff) | (m.rcl8((m.ax >> 8), 0x1) << 8);  // rcl ah, 1
      case 0x377b: m.ax = (m.ax & 0xff) | (m.shl8((m.ax >> 8), 0x1) << 8);  // shl ah, 1
      case 0x377d: m.ax = (m.ax & 0xff) | (m.shl8((m.ax >> 8), 0x1) << 8);  // shl ah, 1
      case 0x377f: m.ax = (m.ax & 0xff) | (m.shl8((m.ax >> 8), 0x1) << 8);  // shl ah, 1
      case 0x3781: m.ax = (m.ax & 0xff) | (m.shl8((m.ax >> 8), 0x1) << 8);  // shl ah, 1
      case 0x3783: m.ax = (m.ax & 0xff) | (m.and8((m.ax >> 8), 0xf0) << 8);  // and ah, 0xf0
      case 0x3786: m.push(m.ax);  // push ax
      case 0x3787: m.push(m.bx);  // push bx
      case 0x3788: m.ax = (m.ax & 0xff00) | (m.ax >> 8);  // mov al, ah
      case 0x378a: m.bx = 0x2400;  // mov bx, 0x2400
      case 0x378d: m.ax = (m.ax & 0xff00) | m.rb(m.cs, (m.bx + (m.ax & 0xff)) & 0xffff);  // xlatb
      case 0x378f: { const t = m.pop(); m.bx = t; }  // pop bx
      case 0x3790: m.wb(m.es, m.di, m.and8(m.rb(m.es, m.di), (m.ax & 0xff)));  // and byte ptr es:[di], al
      case 0x3793: m.wb(m.es, m.di, m.or8(m.rb(m.es, m.di), (m.ax >> 8)));  // or byte ptr es:[di], ah
      case 0x3796: { const t = m.pop(); m.ax = t; }  // pop ax
      case 0x3797: m.di = m.inc16(m.di);  // inc di
      case 0x3798: { const t = m.pop(); m.si = t; }  // pop si
      case 0x3799: { const t = m.pop(); m.di = t; }  // pop di
      case 0x379a: m.si = m.add16(m.si, m.rw(m.cs, 0x2504));  // add si, word ptr cs:[0x2504]
      case 0x379f: m.di = m.add16(m.di, 0x2000);  // add di, 0x2000
      case 0x37a3: m.and16(m.di, 0x8000);  // test di, 0x8000
      case 0x37a7: if (m.zf) { ip = 0x37ad; continue; }  // je 0x37ad
      case 0x37a9: m.t += 1; m.pas -= 1; m.di = m.sub16(m.di, 0x7f60);  // sub di, 0x7f60
      case 0x37ad: m.t += 2; m.pas -= 2; m.ww(m.cs, 0x2502, m.dec16(m.rw(m.cs, 0x2502)));  // dec word ptr cs:[0x2502]
      case 0x37b2: if (m.zf) { ip = 0x37b7; continue; }  // je 0x37b7
      case 0x37b4: m.t += 1; m.pas -= 1; ip = 0x3603; continue;  // jmp 0x3603
      case 0x37b7: m.t += 5; m.pas -= 5; m.push(m.ax);  // push ax
      case 0x37b8: m.ax = ((0x0 + m.L) & 0xffff);  // mov ax, 0
      case 0x37bb: m.ds = m.ax;  // mov ds, ax
      case 0x37bd: { const t = m.pop(); m.ax = t; }  // pop ax
      case 0x37be: ip = m.pop(); continue;  // ret
      case 0x37bf: m.t += 8; m.pas -= 8; m.ax = m.rw(m.ds, 0x19f0);  // mov ax, word ptr [0x19f0]
      case 0x37c2: m.ds = m.ax;  // mov ds, ax
      case 0x37c4: m.bp = m.shr16(m.bp, 0x1);  // shr bp, 1
      case 0x37c6: m.bp = m.shr16(m.bp, 0x1);  // shr bp, 1
      case 0x37c8: m.bp = m.shr16(m.bp, 0x1);  // shr bp, 1
      case 0x37ca: m.si = m.shr16(m.si, 0x1);  // shr si, 1
      case 0x37cc: m.bx = 0x28;  // mov bx, 0x28
      case 0x37cf: m.bx = m.sub16(m.bx, m.bp);  // sub bx, bp
      case 0x37d1: m.t += 15; m.pas -= 15; m.dx = m.cx;  // mov dx, cx
      case 0x37d3: m.cx = m.bp;  // mov cx, bp
      case 0x37d5: m.movsb(m.ds, 1);  // rep movsb byte ptr es:[di], byte ptr [si]
      case 0x37d7: m.di = m.add16(m.di, m.bx);  // add di, bx
      case 0x37d9: m.cx = m.bp;  // mov cx, bp
      case 0x37db: m.movsb(m.ds, 1);  // rep movsb byte ptr es:[di], byte ptr [si]
      case 0x37dd: m.di = m.add16(m.di, m.bx);  // add di, bx
      case 0x37df: m.cx = m.bp;  // mov cx, bp
      case 0x37e1: m.movsb(m.ds, 1);  // rep movsb byte ptr es:[di], byte ptr [si]
      case 0x37e3: m.di = m.add16(m.di, m.bx);  // add di, bx
      case 0x37e5: m.cx = m.bp;  // mov cx, bp
      case 0x37e7: m.movsb(m.ds, 1);  // rep movsb byte ptr es:[di], byte ptr [si]
      case 0x37e9: m.di = m.add16(m.di, m.bx);  // add di, bx
      case 0x37eb: m.cx = m.dx;  // mov cx, dx
      case 0x37ed: m.cx = (m.cx - 1) & 0xffff; if (m.cx !== 0) { ip = 0x37d1; continue; }  // loop 0x37d1
      case 0x37ef: m.t += 5; m.pas -= 5; m.push(m.ax);  // push ax
      case 0x37f0: m.ax = ((0x0 + m.L) & 0xffff);  // mov ax, 0
      case 0x37f3: m.ds = m.ax;  // mov ds, ax
      case 0x37f5: { const t = m.pop(); m.ax = t; }  // pop ax
      case 0x37f6: ip = m.pop(); continue;  // ret
      case 0x37f7: m.t += 2; m.pas -= 2; m.ax = m.rw(m.ds, 0x19f0);  // mov ax, word ptr [0x19f0]
      case 0x37fa: m.ds = m.ax;  // mov ds, ax
      case 0x37fc: m.t += 8; m.pas -= 8; m.dx = m.cx;  // mov dx, cx
      case 0x37fe: m.cx = m.bp;  // mov cx, bp
      case 0x3800: m.push(m.di);  // push di
      case 0x3801: m.movsb(m.ds, 1);  // rep movsb byte ptr es:[di], byte ptr [si]
      case 0x3803: { const t = m.pop(); m.di = t; }  // pop di
      case 0x3804: m.di = m.add16(m.di, 0x140);  // add di, 0x140
      case 0x3808: m.cx = m.dx;  // mov cx, dx
      case 0x380a: m.cx = (m.cx - 1) & 0xffff; if (m.cx !== 0) { ip = 0x37fc; continue; }  // loop 0x37fc
      case 0x380c: m.t += 5; m.pas -= 5; m.push(m.ax);  // push ax
      case 0x380d: m.ax = ((0x0 + m.L) & 0xffff);  // mov ax, 0
      case 0x3810: m.ds = m.ax;  // mov ds, ax
      case 0x3812: { const t = m.pop(); m.ax = t; }  // pop ax
      case 0x3813: ip = m.pop(); continue;  // ret
      default: return ip;
    }
  }
}

// 0x3814 sub_7cc4
function sub_3814_3814(m, ip) {
  for (;;) {
    if (m.pas <= 0) return ip;
    switch (ip) {
      case 0x3814: m.t += 36; m.pas -= 36; m.push(m.drapeaux());  // pushf
      case 0x3815: m.push(m.ax);  // push ax
      case 0x3816: m.push(m.bx);  // push bx
      case 0x3817: m.push(m.cx);  // push cx
      case 0x3818: m.push(m.dx);  // push dx
      case 0x3819: m.push(m.di);  // push di
      case 0x381a: m.push(m.si);  // push si
      case 0x381b: m.push(m.bp);  // push bp
      case 0x381c: m.push(m.es);  // push es
      case 0x381d: m.push(m.ds);  // push ds
      case 0x381e: m.push(m.ax);  // push ax
      case 0x381f: m.ax = ((0x0 + m.L) & 0xffff);  // mov ax, 0
      case 0x3822: m.es = m.ax;  // mov es, ax
      case 0x3824: { const t = m.pop(); m.ax = t; }  // pop ax
      case 0x3825: m.ax = m.rw(m.ds, m.si);  // mov ax, word ptr [si]
      case 0x3827: m.di = 0x1a33;  // mov di, 0x1a33
      case 0x382a: m.ww(m.ds, ((m.di + 0x1) & 0xffff), m.ax);  // mov word ptr [di + 1], ax
      case 0x382d: m.ax = m.rw(m.ds, ((m.si + 0x2) & 0xffff));  // mov ax, word ptr [si + 2]
      case 0x3830: m.ww(m.ds, 0x1a87, m.ax);  // mov word ptr [0x1a87], ax
      case 0x3833: m.ax = m.rw(m.ds, ((m.si + 0x4) & 0xffff));  // mov ax, word ptr [si + 4]
      case 0x3836: m.ww(m.ds, 0x1a89, m.ax);  // mov word ptr [0x1a89], ax
      case 0x3839: m.cx = m.ax;  // mov cx, ax
      case 0x383b: m.ax = m.rw(m.ds, ((m.si + 0x6) & 0xffff));  // mov ax, word ptr [si + 6]
      case 0x383e: m.ww(m.ds, 0x19f2, m.ax);  // mov word ptr [0x19f2], ax
      case 0x3841: m.ax = (m.ax & 0xff00) | 0x20;  // mov al, 0x20
      case 0x3843: m.wb(m.ds, ((m.di + 0x3) & 0xffff), (m.ax & 0xff));  // mov byte ptr [di + 3], al
      case 0x3846: m.ax = (m.ax & 0xff00) | 0x20;  // mov al, 0x20
      case 0x3848: m.di = m.add16(m.di, 0x4);  // add di, 4
      case 0x384b: m.stosb(m.ds, 1);  // rep stosb byte ptr es:[di], al
      case 0x384d: m.ax = (m.ax & 0xff00) | 0x20;  // mov al, 0x20
      case 0x384f: m.stosb(m.ds, 0);  // stosb byte ptr es:[di], al
      case 0x3850: m.xor8(0, 0); m.ax = (m.ax & 0xff00) | 0;  // xor al, al
      case 0x3852: m.stosb(m.ds, 0);  // stosb byte ptr es:[di], al
      case 0x3853: m.bp = 0x1a33;  // mov bp, 0x1a33
      case 0x3856: m.push(m.es);  // push es
      case 0x3857: m.push(0x385a); ip = 0x258c; continue;  // call 0x258c
      case 0x385a: m.t += 13; m.pas -= 13; { const t = m.pop(); m.es = t; }  // pop es
      case 0x385b: m.di = 0x1a36;  // mov di, 0x1a36
      case 0x385e: m.ax = (m.ax & 0xff00) | 0x20;  // mov al, 0x20
      case 0x3860: m.stosb(m.ds, 0);  // stosb byte ptr es:[di], al
      case 0x3861: m.ax = (m.ax & 0xff00) | 0x20;  // mov al, 0x20
      case 0x3863: m.cx = m.rw(m.ds, 0x1a89);  // mov cx, word ptr [0x1a89]
      case 0x3867: m.stosb(m.ds, 1);  // rep stosb byte ptr es:[di], al
      case 0x3869: m.ax = (m.ax & 0xff00) | 0x20;  // mov al, 0x20
      case 0x386b: m.stosb(m.ds, 0);  // stosb byte ptr es:[di], al
      case 0x386c: m.cx = m.rw(m.ds, 0x1a87);  // mov cx, word ptr [0x1a87]
      case 0x3870: m.bp = 0x1a33;  // mov bp, 0x1a33
      case 0x3873: m.push(m.bp);  // push bp
      case 0x3874: m.push(m.es);  // push es
      case 0x3875: m.t += 4; m.pas -= 4; m.push(m.bp);  // push bp
      case 0x3876: m.push(m.cx);  // push cx
      case 0x3877: m.wb(m.ds, ((m.bp + 0x1) & 0xffff), m.inc8(m.rb(m.ds, ((m.bp + 0x1) & 0xffff))));  // inc byte ptr ds:[bp + 1]
      case 0x387b: m.push(0x387e); ip = 0x258c; continue;  // call 0x258c
      case 0x387e: m.t += 3; m.pas -= 3; { const t = m.pop(); m.cx = t; }  // pop cx
      case 0x387f: { const t = m.pop(); m.bp = t; }  // pop bp
      case 0x3880: m.cx = (m.cx - 1) & 0xffff; if (m.cx !== 0) { ip = 0x3875; continue; }  // loop 0x3875
      case 0x3882: m.t += 12; m.pas -= 12; { const t = m.pop(); m.es = t; }  // pop es
      case 0x3883: { const t = m.pop(); m.bp = t; }  // pop bp
      case 0x3884: m.di = 0x1a36;  // mov di, 0x1a36
      case 0x3887: m.ax = (m.ax & 0xff00) | 0x20;  // mov al, 0x20
      case 0x3889: m.stosb(m.ds, 0);  // stosb byte ptr es:[di], al
      case 0x388a: m.cx = m.rw(m.ds, 0x1a89);  // mov cx, word ptr [0x1a89]
      case 0x388e: m.ax = (m.ax & 0xff00) | 0x20;  // mov al, 0x20
      case 0x3890: m.stosb(m.ds, 1);  // rep stosb byte ptr es:[di], al
      case 0x3892: m.ax = (m.ax & 0xff00) | 0x20;  // mov al, 0x20
      case 0x3894: m.stosb(m.ds, 0);  // stosb byte ptr es:[di], al
      case 0x3895: m.wb(m.ds, ((m.bp + 0x1) & 0xffff), m.inc8(m.rb(m.ds, ((m.bp + 0x1) & 0xffff))));  // inc byte ptr ds:[bp + 1]
      case 0x3899: m.push(0x389c); ip = 0x258c; continue;  // call 0x258c
      case 0x389c: m.t += 11; m.pas -= 11; { const t = m.pop(); m.ds = t; }  // pop ds
      case 0x389d: { const t = m.pop(); m.es = t; }  // pop es
      case 0x389e: { const t = m.pop(); m.bp = t; }  // pop bp
      case 0x389f: { const t = m.pop(); m.si = t; }  // pop si
      case 0x38a0: { const t = m.pop(); m.di = t; }  // pop di
      case 0x38a1: { const t = m.pop(); m.dx = t; }  // pop dx
      case 0x38a2: { const t = m.pop(); m.cx = t; }  // pop cx
      case 0x38a3: { const t = m.pop(); m.bx = t; }  // pop bx
      case 0x38a4: { const t = m.pop(); m.ax = t; }  // pop ax
      case 0x38a5: m.poserDrapeaux(m.pop());  // popf
      case 0x38a6: ip = m.pop(); continue;  // ret
      default: return ip;
    }
  }
}

// 0x38a7 sub_7d57
function sub_38a7_38a7(m, ip) {
  for (;;) {
    if (m.pas <= 0) return ip;
    switch (ip) {
      case 0x38a7: m.t += 1; m.pas -= 1; m.si = 0x1;  // mov si, 1
      case 0x38aa: m.t += 2; m.pas -= 2; m.sub8(m.rb(m.ds, ((m.bp + m.si) & 0xffff)), 0x0);  // cmp byte ptr ds:[bp + si], 0
      case 0x38ae: if (!m.zf) { ip = 0x38b1; continue; }  // jne 0x38b1
      case 0x38b0: m.t += 1; m.pas -= 1; ip = m.pop(); continue;  // ret
      case 0x38b1: m.t += 2; m.pas -= 2; m.si = m.inc16(m.si);  // inc si
      case 0x38b2: ip = 0x38aa; continue;  // jmp 0x38aa
      default: return ip;
    }
  }
}

// 0x38b4 sub_7d64
function sub_38b4_38b4(m, ip) {
  for (;;) {
    if (m.pas <= 0) return ip;
    switch (ip) {
      case 0x38b4: m.t += 1; m.pas -= 1; m.push(0x38b7); ip = 0x38ba; continue;  // call 0x38ba
      case 0x38b7: m.t += 1; m.pas -= 1; ip = 0x2d15; continue;  // jmp 0x2d15
      default: return ip;
    }
  }
}

// 0x38ba sub_7d6a
function sub_38ba_38ba(m, ip) {
  for (;;) {
    if (m.pas <= 0) return ip;
    switch (ip) {
      case 0x38ba: m.t += 21; m.pas -= 21; m.push(m.rw(m.ds, 0x19f2));  // push word ptr [0x19f2]
      case 0x38be: m.push(m.rw(m.ds, 0x19f4));  // push word ptr [0x19f4]
      case 0x38c2: m.push(m.rw(m.ds, 0x19f6));  // push word ptr [0x19f6]
      case 0x38c6: m.push(m.rw(m.ds, 0x19fb));  // push word ptr [0x19fb]
      case 0x38ca: m.push(m.drapeaux());  // pushf
      case 0x38cb: m.push(m.drapeaux());  // pushf
      case 0x38cc: m.push(m.ax);  // push ax
      case 0x38cd: m.push(m.bx);  // push bx
      case 0x38ce: m.push(m.cx);  // push cx
      case 0x38cf: m.push(m.dx);  // push dx
      case 0x38d0: m.push(m.di);  // push di
      case 0x38d1: m.push(m.si);  // push si
      case 0x38d2: m.push(m.bp);  // push bp
      case 0x38d3: m.push(m.es);  // push es
      case 0x38d4: m.push(m.ds);  // push ds
      case 0x38d5: m.push(m.ax);  // push ax
      case 0x38d6: m.ax = ((0x0 + m.L) & 0xffff);  // mov ax, 0
      case 0x38d9: m.ds = m.ax;  // mov ds, ax
      case 0x38db: { const t = m.pop(); m.ax = t; }  // pop ax
      case 0x38dc: m.wb(m.ds, 0x19fb, 0x0);  // mov byte ptr [0x19fb], 0
      case 0x38e1: m.push(0x38e4); ip = 0x2ab0; continue;  // call 0x2ab0
      case 0x38e4: m.t += 2; m.pas -= 2; m.bp = 0x17b5;  // mov bp, 0x17b5
      case 0x38e7: m.push(0x38ea); ip = 0x258c; continue;  // call 0x258c
      case 0x38ea: m.t += 3; m.pas -= 3; m.bp = m.sp;  // mov bp, sp
      case 0x38ec: m.dx = m.rw(m.ss, ((m.bp + 0x10) & 0xffff));  // mov dx, word ptr [bp + 0x10]
      case 0x38ef: m.push(0x38f2); ip = 0x397e; continue;  // call 0x397e
      case 0x38f2: m.t += 2; m.pas -= 2; m.bp = 0x17bf;  // mov bp, 0x17bf
      case 0x38f5: m.push(0x38f8); ip = 0x258c; continue;  // call 0x258c
      case 0x38f8: m.t += 3; m.pas -= 3; m.bp = m.sp;  // mov bp, sp
      case 0x38fa: m.dx = m.rw(m.ss, ((m.bp + 0xe) & 0xffff));  // mov dx, word ptr [bp + 0xe]
      case 0x38fd: m.push(0x3900); ip = 0x397e; continue;  // call 0x397e
      case 0x3900: m.t += 2; m.pas -= 2; m.bp = 0x17c9;  // mov bp, 0x17c9
      case 0x3903: m.push(0x3906); ip = 0x258c; continue;  // call 0x258c
      case 0x3906: m.t += 3; m.pas -= 3; m.bp = m.sp;  // mov bp, sp
      case 0x3908: m.dx = m.rw(m.ss, ((m.bp + 0xc) & 0xffff));  // mov dx, word ptr [bp + 0xc]
      case 0x390b: m.push(0x390e); ip = 0x397e; continue;  // call 0x397e
      case 0x390e: m.t += 2; m.pas -= 2; m.bp = 0x17d3;  // mov bp, 0x17d3
      case 0x3911: m.push(0x3914); ip = 0x258c; continue;  // call 0x258c
      case 0x3914: m.t += 3; m.pas -= 3; m.bp = m.sp;  // mov bp, sp
      case 0x3916: m.dx = m.rw(m.ss, ((m.bp + 0xa) & 0xffff));  // mov dx, word ptr [bp + 0xa]
      case 0x3919: m.push(0x391c); ip = 0x397e; continue;  // call 0x397e
      case 0x391c: m.t += 2; m.pas -= 2; m.bp = 0x1805;  // mov bp, 0x1805
      case 0x391f: m.push(0x3922); ip = 0x258c; continue;  // call 0x258c
      case 0x3922: m.t += 3; m.pas -= 3; m.bp = m.sp;  // mov bp, sp
      case 0x3924: m.dx = m.rw(m.ss, ((m.bp + 0x4) & 0xffff));  // mov dx, word ptr [bp + 4]
      case 0x3927: m.push(0x392a); ip = 0x397e; continue;  // call 0x397e
      case 0x392a: m.t += 2; m.pas -= 2; m.bp = 0x17dd;  // mov bp, 0x17dd
      case 0x392d: m.push(0x3930); ip = 0x258c; continue;  // call 0x258c
      case 0x3930: m.t += 3; m.pas -= 3; m.bp = m.sp;  // mov bp, sp
      case 0x3932: m.dx = m.rw(m.ss, ((m.bp + 0x8) & 0xffff));  // mov dx, word ptr [bp + 8]
      case 0x3935: m.push(0x3938); ip = 0x397e; continue;  // call 0x397e
      case 0x3938: m.t += 2; m.pas -= 2; m.bp = 0x17e7;  // mov bp, 0x17e7
      case 0x393b: m.push(0x393e); ip = 0x258c; continue;  // call 0x258c
      case 0x393e: m.t += 3; m.pas -= 3; m.bp = m.sp;  // mov bp, sp
      case 0x3940: m.dx = m.rw(m.ss, ((m.bp + 0x6) & 0xffff));  // mov dx, word ptr [bp + 6]
      case 0x3943: m.push(0x3946); ip = 0x397e; continue;  // call 0x397e
      case 0x3946: m.t += 2; m.pas -= 2; m.bp = 0x17f1;  // mov bp, 0x17f1
      case 0x3949: m.push(0x394c); ip = 0x258c; continue;  // call 0x258c
      case 0x394c: m.t += 3; m.pas -= 3; m.bp = m.sp;  // mov bp, sp
      case 0x394e: m.dx = m.rw(m.ss, ((m.bp + 0x2) & 0xffff));  // mov dx, word ptr [bp + 2]
      case 0x3951: m.push(0x3954); ip = 0x397e; continue;  // call 0x397e
      case 0x3954: m.t += 2; m.pas -= 2; m.bp = 0x17fb;  // mov bp, 0x17fb
      case 0x3957: m.push(0x395a); ip = 0x258c; continue;  // call 0x258c
      case 0x395a: m.t += 3; m.pas -= 3; m.bp = m.sp;  // mov bp, sp
      case 0x395c: m.dx = m.rw(m.ss, m.bp);  // mov dx, word ptr [bp]
      case 0x395f: m.push(0x3962); ip = 0x397e; continue;  // call 0x397e
      case 0x3962: m.t += 16; m.pas -= 16; { const t = m.pop(); m.ds = t; }  // pop ds
      case 0x3963: { const t = m.pop(); m.es = t; }  // pop es
      case 0x3964: { const t = m.pop(); m.bp = t; }  // pop bp
      case 0x3965: { const t = m.pop(); m.si = t; }  // pop si
      case 0x3966: { const t = m.pop(); m.di = t; }  // pop di
      case 0x3967: { const t = m.pop(); m.dx = t; }  // pop dx
      case 0x3968: { const t = m.pop(); m.cx = t; }  // pop cx
      case 0x3969: { const t = m.pop(); m.bx = t; }  // pop bx
      case 0x396a: { const t = m.pop(); m.ax = t; }  // pop ax
      case 0x396b: m.poserDrapeaux(m.pop());  // popf
      case 0x396c: m.poserDrapeaux(m.pop());  // popf
      case 0x396d: { const t = m.pop(); m.ww(m.ds, 0x19fb, t); }  // pop word ptr [0x19fb]
      case 0x3971: { const t = m.pop(); m.ww(m.ds, 0x19f6, t); }  // pop word ptr [0x19f6]
      case 0x3975: { const t = m.pop(); m.ww(m.ds, 0x19f4, t); }  // pop word ptr [0x19f4]
      case 0x3979: { const t = m.pop(); m.ww(m.ds, 0x19f2, t); }  // pop word ptr [0x19f2]
      case 0x397d: ip = m.pop(); continue;  // ret
      default: return ip;
    }
  }
}

// 0x397e sub_7e2e
function sub_397e_397e(m, ip) {
  for (;;) {
    if (m.pas <= 0) return ip;
    switch (ip) {
      case 0x397e: m.t += 3; m.pas -= 3; m.ww(m.ds, 0x1a95, m.dx);  // mov word ptr [0x1a95], dx
      case 0x3982: m.ax = (m.ax & 0xff00) | (m.dx >> 8);  // mov al, dh
      case 0x3984: m.push(0x3987); ip = 0x39a2; continue;  // call 0x39a2
      case 0x3987: m.t += 3; m.pas -= 3; m.ax = m.rw(m.ds, 0x1a95);  // mov ax, word ptr [0x1a95]
      case 0x398a: m.ax = (m.ax & 0xff00) | (m.ax >> 8);  // mov al, ah
      case 0x398c: m.push(0x398f); ip = 0x399c; continue;  // call 0x399c
      case 0x398f: m.t += 2; m.pas -= 2; m.ax = m.rw(m.ds, 0x1a95);  // mov ax, word ptr [0x1a95]
      case 0x3992: m.push(0x3995); ip = 0x39a2; continue;  // call 0x39a2
      case 0x3995: m.t += 2; m.pas -= 2; m.ax = m.rw(m.ds, 0x1a95);  // mov ax, word ptr [0x1a95]
      case 0x3998: m.push(0x399b); ip = 0x399c; continue;  // call 0x399c
      case 0x399b: m.t += 1; m.pas -= 1; ip = m.pop(); continue;  // ret
      default: return ip;
    }
  }
}

// 0x399c sub_7e4c
function sub_399c_399c(m, ip) {
  for (;;) {
    if (m.pas <= 0) return ip;
    switch (ip) {
      case 0x399c: m.t += 2; m.pas -= 2; m.ax = (m.ax & 0xff00) | m.and8((m.ax & 0xff), 0xf);  // and al, 0xf
      case 0x399e: m.push(0x39a1); ip = 0x39b0; continue;  // call 0x39b0
      case 0x39a1: m.t += 1; m.pas -= 1; ip = m.pop(); continue;  // ret
      default: return ip;
    }
  }
}

// 0x39a2 sub_7e52
function sub_39a2_39a2(m, ip) {
  for (;;) {
    if (m.pas <= 0) return ip;
    switch (ip) {
      case 0x39a2: m.t += 6; m.pas -= 6; m.ax = (m.ax & 0xff00) | m.and8((m.ax & 0xff), 0xf0);  // and al, 0xf0
      case 0x39a4: m.ax = (m.ax & 0xff00) | m.shr8((m.ax & 0xff), 0x1);  // shr al, 1
      case 0x39a6: m.ax = (m.ax & 0xff00) | m.shr8((m.ax & 0xff), 0x1);  // shr al, 1
      case 0x39a8: m.ax = (m.ax & 0xff00) | m.shr8((m.ax & 0xff), 0x1);  // shr al, 1
      case 0x39aa: m.ax = (m.ax & 0xff00) | m.shr8((m.ax & 0xff), 0x1);  // shr al, 1
      case 0x39ac: m.push(0x39af); ip = 0x39b0; continue;  // call 0x39b0
      case 0x39af: m.t += 1; m.pas -= 1; ip = m.pop(); continue;  // ret
      default: return ip;
    }
  }
}

// 0x39b0 sub_7e60
function sub_39b0_39b0(m, ip) {
  for (;;) {
    if (m.pas <= 0) return ip;
    switch (ip) {
      case 0x39b0: m.t += 3; m.pas -= 3; m.bx = 0x1d12;  // mov bx, 0x1d12
      case 0x39b3: m.ax = (m.ax & 0xff00) | m.rb(m.ds, (m.bx + (m.ax & 0xff)) & 0xffff);  // xlatb
      case 0x39b4: m.push(0x39b7); ip = 0x259b; continue;  // call 0x259b
      case 0x39b7: m.t += 1; m.pas -= 1; ip = m.pop(); continue;  // ret
      default: return ip;
    }
  }
}

// 0x39b8 sub_7e68
function sub_39b8_39b8(m, ip) {
  for (;;) {
    if (m.pas <= 0) return ip;
    switch (ip) {
      case 0x39b8: m.t += 3; m.pas -= 3; m.push(m.cx);  // push cx
      case 0x39b9: m.ax = (m.ax & 0xff) | (0x0 << 8);  // mov ah, 0
      case 0x39bb: m.cx = 0x8;  // mov cx, 8
      case 0x39be: m.t += 2; m.pas -= 2; m.ax = (m.ax & 0xff00) | m.shr8((m.ax & 0xff), 0x1);  // shr al, 1
      case 0x39c0: if (m.cf) { ip = 0x39c8; continue; }  // jb 0x39c8
      case 0x39c2: m.t += 2; m.pas -= 2; m.ax = (m.ax & 0xff) | (m.inc8((m.ax >> 8)) << 8);  // inc ah
      case 0x39c4: m.cx = (m.cx - 1) & 0xffff; if (m.cx !== 0) { ip = 0x39be; continue; }  // loop 0x39be
      case 0x39c6: m.t += 1; m.pas -= 1; m.xor8(0, 0); m.ax = (m.ax & 0xff) | (0 << 8);  // xor ah, ah
      case 0x39c8: m.t += 3; m.pas -= 3; m.ax = (m.ax & 0xff00) | (m.ax >> 8);  // mov al, ah
      case 0x39ca: { const t = m.pop(); m.cx = t; }  // pop cx
      case 0x39cb: ip = m.pop(); continue;  // ret
      default: return ip;
    }
  }
}

// 0x39cc sub_7e7c
function sub_39cc_39cc(m, ip) {
  for (;;) {
    if (m.pas <= 0) return ip;
    switch (ip) {
      case 0x39cc: m.t += 7; m.pas -= 7; m.ax = (m.ax & 0xff) | (0x25 << 8);  // mov ah, 0x25
      case 0x39ce: m.ax = (m.ax & 0xff00) | 0x24;  // mov al, 0x24
      case 0x39d0: m.dx = 0x39da;  // mov dx, 0x39da
      case 0x39d3: m.push(m.ds);  // push ds
      case 0x39d4: m.push(m.cs);  // push cs
      case 0x39d5: { const t = m.pop(); m.ds = t; }  // pop ds
      case 0x39d6: if (!m.interruption(0x21)) { m.pas = 0; ip = 0x39d6; continue; }  // int 0x21
      case 0x39d8: m.t += 2; m.pas -= 2; { const t = m.pop(); m.ds = t; }  // pop ds
      case 0x39d9: ip = m.pop(); continue;  // ret
      default: return ip;
    }
  }
}

// 0x39dd sub_7e8d
function sub_39dd_39dd(m, ip) {
  for (;;) {
    if (m.pas <= 0) return ip;
    switch (ip) {
      case 0x39dd: m.t += 2; m.pas -= 2; m.df = 0;  // cld
      case 0x39de: m.dx = 0x0;  // mov dx, 0
      case 0x39e1: m.t += 4; m.pas -= 4; m.ax = 0x0;  // mov ax, 0
      case 0x39e4: m.lodsb(m.ds, 0);  // lodsb al, byte ptr [si]
      case 0x39e5: m.sub8((m.ax & 0xff), 0x0);  // cmp al, 0
      case 0x39e7: if (!m.zf) { ip = 0x39ec; continue; }  // jne 0x39ec
      case 0x39e9: m.t += 1; m.pas -= 1; ip = 0x3a92; continue;  // jmp 0x3a92
      case 0x39ec: m.t += 2; m.pas -= 2; m.and8((m.ax & 0xff), 0x80);  // test al, 0x80
      case 0x39ee: if (!m.zf) { ip = 0x3a35; continue; }  // jne 0x3a35
      case 0x39f0: m.t += 2; m.pas -= 2; m.and8((m.ax & 0xff), 0x40);  // test al, 0x40
      case 0x39f2: if (!m.zf) { ip = 0x3a11; continue; }  // jne 0x3a11
      case 0x39f4: m.t += 2; m.pas -= 2; m.and8((m.ax & 0xff), 0x20);  // test al, 0x20
      case 0x39f6: if (m.zf) { ip = 0x3a00; continue; }  // je 0x3a00
      case 0x39f8: m.t += 4; m.pas -= 4; m.ax = (m.ax & 0xff00) | m.and8((m.ax & 0xff), 0xdf);  // and al, 0xdf
      case 0x39fa: { const t = (m.ax & 0xff); m.ax = (m.ax & 0xff00) | (m.ax >> 8); m.ax = (m.ax & 0xff) | (t << 8); }  // xchg al, ah
      case 0x39fc: m.lodsb(m.ds, 0);  // lodsb al, byte ptr [si]
      case 0x39fd: m.ax = m.add16(m.ax, 0x20);  // add ax, 0x20
      case 0x3a00: m.t += 1; m.pas -= 1; m.ax = m.dec16(m.ax);  // dec ax
      case 0x3a01: m.t += 4; m.pas -= 4; m.movsb(m.ds, 0);  // movsb byte ptr es:[di], byte ptr [si]
      case 0x3a02: m.dx = m.inc16(m.dx);  // inc dx
      case 0x3a03: m.cx = m.dec16(m.cx);  // dec cx
      case 0x3a04: if (!m.zf) { ip = 0x3a09; continue; }  // jne 0x3a09
      case 0x3a06: m.t += 1; m.pas -= 1; ip = 0x3a92; continue;  // jmp 0x3a92
      case 0x3a09: m.t += 3; m.pas -= 3; m.ax = m.dec16(m.ax);  // dec ax
      case 0x3a0a: m.and8((m.ax >> 8), 0x80);  // test ah, 0x80
      case 0x3a0d: if (m.zf) { ip = 0x3a01; continue; }  // je 0x3a01
      case 0x3a0f: m.t += 1; m.pas -= 1; ip = 0x39e1; continue;  // jmp 0x39e1
      case 0x3a11: m.t += 3; m.pas -= 3; m.ax = (m.ax & 0xff00) | m.and8((m.ax & 0xff), 0xbf);  // and al, 0xbf
      case 0x3a13: m.and8((m.ax & 0xff), 0x20);  // test al, 0x20
      case 0x3a15: if (m.zf) { ip = 0x3a1f; continue; }  // je 0x3a1f
      case 0x3a17: m.t += 4; m.pas -= 4; m.ax = (m.ax & 0xff00) | m.and8((m.ax & 0xff), 0xdf);  // and al, 0xdf
      case 0x3a19: { const t = (m.ax & 0xff); m.ax = (m.ax & 0xff00) | (m.ax >> 8); m.ax = (m.ax & 0xff) | (t << 8); }  // xchg al, ah
      case 0x3a1b: m.lodsb(m.ds, 0);  // lodsb al, byte ptr [si]
      case 0x3a1c: m.ax = m.add16(m.ax, 0x21);  // add ax, 0x21
      case 0x3a1f: m.t += 3; m.pas -= 3; m.ax = m.add16(m.ax, 0x2);  // add ax, 2
      case 0x3a22: m.bx = (m.bx & 0xff00) | m.rb(m.ds, m.si);  // mov bl, byte ptr [si]
      case 0x3a24: m.si = m.inc16(m.si);  // inc si
      case 0x3a25: m.t += 5; m.pas -= 5; m.wb(m.es, m.di, (m.bx & 0xff));  // mov byte ptr es:[di], bl
      case 0x3a28: m.di = m.inc16(m.di);  // inc di
      case 0x3a29: m.dx = m.inc16(m.dx);  // inc dx
      case 0x3a2a: m.cx = m.dec16(m.cx);  // dec cx
      case 0x3a2b: if (m.zf) { ip = 0x3a92; continue; }  // je 0x3a92
      case 0x3a2d: m.t += 3; m.pas -= 3; m.ax = m.dec16(m.ax);  // dec ax
      case 0x3a2e: m.and8((m.ax >> 8), 0x80);  // test ah, 0x80
      case 0x3a31: if (m.zf) { ip = 0x3a25; continue; }  // je 0x3a25
      case 0x3a33: m.t += 1; m.pas -= 1; ip = 0x39e1; continue;  // jmp 0x39e1
      case 0x3a35: m.t += 3; m.pas -= 3; m.ax = (m.ax & 0xff00) | m.and8((m.ax & 0xff), 0x7f);  // and al, 0x7f
      case 0x3a37: m.and8((m.ax & 0xff), 0x40);  // test al, 0x40
      case 0x3a39: if (!m.zf) { ip = 0x3a64; continue; }  // jne 0x3a64
      case 0x3a3b: m.t += 3; m.pas -= 3; m.bp = 0x2;  // mov bp, 2
      case 0x3a3e: m.and8((m.ax & 0xff), 0x20);  // test al, 0x20
      case 0x3a40: if (!m.zf) { ip = 0x3a45; continue; }  // jne 0x3a45
      case 0x3a42: m.t += 1; m.pas -= 1; m.bp = 0x1;  // mov bp, 1
      case 0x3a45: m.t += 5; m.pas -= 5; m.ax = (m.ax & 0xff00) | m.and8((m.ax & 0xff), 0xdf);  // and al, 0xdf
      case 0x3a47: m.bx = m.di;  // mov bx, di
      case 0x3a49: m.bx = m.dec16(m.bx);  // dec bx
      case 0x3a4a: m.bx = m.sub16(m.bx, m.ax);  // sub bx, ax
      case 0x3a4c: m.bx = m.sub16(m.bx, m.bp);  // sub bx, bp
      case 0x3a4e: m.t += 7; m.pas -= 7; m.ax = (m.ax & 0xff00) | m.rb(m.es, m.bx);  // mov al, byte ptr es:[bx]
      case 0x3a51: m.wb(m.es, m.di, (m.ax & 0xff));  // mov byte ptr es:[di], al
      case 0x3a54: m.bx = m.inc16(m.bx);  // inc bx
      case 0x3a55: m.di = m.inc16(m.di);  // inc di
      case 0x3a56: m.dx = m.inc16(m.dx);  // inc dx
      case 0x3a57: m.cx = m.dec16(m.cx);  // dec cx
      case 0x3a58: if (m.zf) { ip = 0x3a92; continue; }  // je 0x3a92
      case 0x3a5a: m.t += 3; m.pas -= 3; m.bp = m.dec16(m.bp);  // dec bp
      case 0x3a5b: m.and16(m.bp, 0x8000);  // test bp, 0x8000
      case 0x3a5f: if (m.zf) { ip = 0x3a4e; continue; }  // je 0x3a4e
      case 0x3a61: m.t += 1; m.pas -= 1; ip = 0x39e1; continue;  // jmp 0x39e1
      case 0x3a64: m.t += 12; m.pas -= 12; m.ax = (m.ax & 0xff00) | m.and8((m.ax & 0xff), 0xbf);  // and al, 0xbf
      case 0x3a66: m.bp = m.ax;  // mov bp, ax
      case 0x3a68: { const t = (m.ax >> 8); m.ax = (m.ax & 0xff) | ((m.ax & 0xff) << 8); m.ax = (m.ax & 0xff00) | t; }  // xchg ah, al
      case 0x3a6a: m.lodsb(m.ds, 0);  // lodsb al, byte ptr [si]
      case 0x3a6b: m.ax = m.and16(m.ax, 0x3ff);  // and ax, 0x3ff
      case 0x3a6e: m.bp = m.shr16(m.bp, 0x1);  // shr bp, 1
      case 0x3a70: m.bp = m.shr16(m.bp, 0x1);  // shr bp, 1
      case 0x3a72: m.bp = m.add16(m.bp, 0x3);  // add bp, 3
      case 0x3a75: m.bx = m.di;  // mov bx, di
      case 0x3a77: m.bx = m.dec16(m.bx);  // dec bx
      case 0x3a78: m.bx = m.sub16(m.bx, m.ax);  // sub bx, ax
      case 0x3a7a: m.bx = m.sub16(m.bx, m.bp);  // sub bx, bp
      case 0x3a7c: m.t += 7; m.pas -= 7; m.ax = (m.ax & 0xff00) | m.rb(m.es, m.bx);  // mov al, byte ptr es:[bx]
      case 0x3a7f: m.wb(m.es, m.di, (m.ax & 0xff));  // mov byte ptr es:[di], al
      case 0x3a82: m.bx = m.inc16(m.bx);  // inc bx
      case 0x3a83: m.di = m.inc16(m.di);  // inc di
      case 0x3a84: m.dx = m.inc16(m.dx);  // inc dx
      case 0x3a85: m.cx = m.dec16(m.cx);  // dec cx
      case 0x3a86: if (m.zf) { ip = 0x3a92; continue; }  // je 0x3a92
      case 0x3a88: m.t += 3; m.pas -= 3; m.bp = m.dec16(m.bp);  // dec bp
      case 0x3a89: m.and16(m.bp, 0x8000);  // test bp, 0x8000
      case 0x3a8d: if (m.zf) { ip = 0x3a7c; continue; }  // je 0x3a7c
      case 0x3a8f: m.t += 1; m.pas -= 1; ip = 0x39e1; continue;  // jmp 0x39e1
      case 0x3a92: m.t += 1; m.pas -= 1; ip = m.pop(); continue;  // ret
      default: return ip;
    }
  }
}

// 0x3a93 sub_7f43
function sub_3a93_3a93(m, ip) {
  for (;;) {
    if (m.pas <= 0) return ip;
    switch (ip) {
      case 0x3a93: m.t += 2; m.pas -= 2; m.push(m.cx);  // push cx
      case 0x3a94: m.push(0x3a97); ip = 0x29bb; continue;  // call 0x29bb
      case 0x3a97: m.t += 2; m.pas -= 2; { const t = m.pop(); m.cx = t; }  // pop cx
      case 0x3a98: m.cx = (m.cx - 1) & 0xffff; if (m.cx !== 0) { ip = 0x3a93; continue; }  // loop 0x3a93
      case 0x3a9a: m.t += 1; m.pas -= 1; ip = m.pop(); continue;  // ret
      default: return ip;
    }
  }
}

// 0x3a9b sub_7f4b
function sub_3a9b_3a9b(m, ip) {
  for (;;) {
    if (m.pas <= 0) return ip;
    switch (ip) {
      case 0x3a9b: m.t += 8; m.pas -= 8; m.push(m.ax);  // push ax
      case 0x3a9c: m.push(m.dx);  // push dx
      case 0x3a9d: m.push(m.ds);  // push ds
      case 0x3a9e: m.push(m.ax);  // push ax
      case 0x3a9f: m.ax = ((0x0 + m.L) & 0xffff);  // mov ax, 0
      case 0x3aa2: m.ds = m.ax;  // mov ds, ax
      case 0x3aa4: { const t = m.pop(); m.ax = t; }  // pop ax
      case 0x3aa5: m.dx = m.rw(m.ds, 0x1d24);  // mov dx, word ptr [0x1d24]
      case 0x3aa9: m.t += 3; m.pas -= 3; m.ax = (m.ax & 0xff00) | m.entree(m.dx, 1);  // in al, dx
      case 0x3aaa: m.and8((m.ax & 0xff), 0x8);  // test al, 8
      case 0x3aac: if (m.zf) { ip = 0x3aa9; continue; }  // je 0x3aa9
      case 0x3aae: m.t += 3; m.pas -= 3; m.ax = (m.ax & 0xff00) | m.entree(m.dx, 1);  // in al, dx
      case 0x3aaf: m.and8((m.ax & 0xff), 0x8);  // test al, 8
      case 0x3ab1: if (!m.zf) { ip = 0x3aae; continue; }  // jne 0x3aae
      case 0x3ab3: m.t += 4; m.pas -= 4; { const t = m.pop(); m.ds = t; }  // pop ds
      case 0x3ab4: { const t = m.pop(); m.dx = t; }  // pop dx
      case 0x3ab5: { const t = m.pop(); m.ax = t; }  // pop ax
      case 0x3ab6: ip = m.pop(); continue;  // ret
      default: return ip;
    }
  }
}

// 0x3ab7 sub_7f67
function sub_3ab7_3ab7(m, ip) {
  for (;;) {
    if (m.pas <= 0) return ip;
    switch (ip) {
      case 0x3ab7: m.t += 7; m.pas -= 7; m.ax = 0x40;  // mov ax, 0x40
      case 0x3aba: m.es = m.ax;  // mov es, ax
      case 0x3abc: m.ax = m.rw(m.es, 0x63);  // mov ax, word ptr es:[0x63]
      case 0x3ac0: m.ww(m.ds, 0x1d22, m.ax);  // mov word ptr [0x1d22], ax
      case 0x3ac3: m.ax = m.add16(m.ax, 0x6);  // add ax, 6
      case 0x3ac6: m.ww(m.ds, 0x1d24, m.ax);  // mov word ptr [0x1d24], ax
      case 0x3ac9: ip = m.pop(); continue;  // ret
      default: return ip;
    }
  }
}

// 0x3b1a sub_7fca
function sub_3b1a_3b1a(m, ip) {
  for (;;) {
    if (m.pas <= 0) return ip;
    switch (ip) {
      case 0x3b1a: m.t += 8; m.pas -= 8; m.if = 0;  // cli
      case 0x3b1b: m.xor16(0, 0); m.bx = 0;  // xor bx, bx
      case 0x3b1d: m.xor16(0, 0); m.cx = 0;  // xor cx, cx
      case 0x3b1f: m.xor16(0, 0); m.di = 0;  // xor di, di
      case 0x3b21: m.xor16(0, 0); m.si = 0;  // xor si, si
      case 0x3b23: m.dx = 0x201;  // mov dx, 0x201
      case 0x3b26: m.sortie(m.dx, (m.ax & 0xff), 1);  // out dx, al
      case 0x3b27: ip = 0x3b2a; continue;  // jmp 0x3b2a
      case 0x3b2a: m.t += 1; m.pas -= 1; ip = 0x3b2d; continue;  // jmp 0x3b2d
      case 0x3b2d: m.t += 1; m.pas -= 1; ip = 0x3b30; continue;  // jmp 0x3b30
      case 0x3b30: m.t += 21; m.pas -= 21; m.ax = (m.ax & 0xff00) | m.entree(m.dx, 1);  // in al, dx
      case 0x3b31: m.ax = (m.ax & 0xff00) | m.and8((m.ax & 0xff), m.rb(m.ds, 0x14ac));  // and al, byte ptr [0x14ac]
      case 0x3b35: m.xor8(0, 0); m.ax = (m.ax & 0xff) | (0 << 8);  // xor ah, ah
      case 0x3b37: m.bp = m.ax;  // mov bp, ax
      case 0x3b39: m.ax = m.and16(m.ax, 0x1);  // and ax, 1
      case 0x3b3c: m.bx = m.add16(m.bx, m.ax);  // add bx, ax
      case 0x3b3e: m.ax = m.bp;  // mov ax, bp
      case 0x3b40: m.ax = m.and16(m.ax, 0x2);  // and ax, 2
      case 0x3b43: m.cx = m.add16(m.cx, m.ax);  // add cx, ax
      case 0x3b45: m.ax = m.bp;  // mov ax, bp
      case 0x3b47: m.ax = m.and16(m.ax, 0x4);  // and ax, 4
      case 0x3b4a: m.ax = m.shr16(m.ax, 0x1);  // shr ax, 1
      case 0x3b4c: m.ax = m.shr16(m.ax, 0x1);  // shr ax, 1
      case 0x3b4e: m.di = m.add16(m.di, m.ax);  // add di, ax
      case 0x3b50: m.ax = m.bp;  // mov ax, bp
      case 0x3b52: m.ax = m.and16(m.ax, 0x8);  // and ax, 8
      case 0x3b55: m.ax = m.shr16(m.ax, 0x1);  // shr ax, 1
      case 0x3b57: m.ax = m.shr16(m.ax, 0x1);  // shr ax, 1
      case 0x3b59: m.si = m.add16(m.si, m.ax);  // add si, ax
      case 0x3b5b: m.bp = m.or16(m.bp, m.bp);  // or bp, bp
      case 0x3b5d: if (!m.zf) { ip = 0x3b30; continue; }  // jne 0x3b30
      case 0x3b5f: m.t += 2; m.pas -= 2; m.if = 1;  // sti
      case 0x3b60: ip = m.pop(); continue;  // ret
      default: return ip;
    }
  }
}

// 0x3b61 sub_8011
function sub_3b61_3b61(m, ip) {
  for (;;) {
    if (m.pas <= 0) return ip;
    switch (ip) {
      case 0x3b61: m.t += 14; m.pas -= 14; m.if = 0;  // cli
      case 0x3b62: m.dx = 0x201;  // mov dx, 0x201
      case 0x3b65: m.ax = (m.ax & 0xff00) | m.entree(m.dx, 1);  // in al, dx
      case 0x3b66: m.ax = (m.ax & 0xff00) | (~(m.ax & 0xff) & 0xff);  // not al
      case 0x3b68: m.ax = (m.ax & 0xff) | ((m.ax & 0xff) << 8);  // mov ah, al
      case 0x3b6a: m.ax = (m.ax & 0xff00) | m.shr8((m.ax & 0xff), 0x1);  // shr al, 1
      case 0x3b6c: m.ax = (m.ax & 0xff00) | m.shr8((m.ax & 0xff), 0x1);  // shr al, 1
      case 0x3b6e: m.ax = (m.ax & 0xff00) | m.or8((m.ax & 0xff), (m.ax >> 8));  // or al, ah
      case 0x3b70: m.ax = (m.ax & 0xff00) | m.shr8((m.ax & 0xff), 0x1);  // shr al, 1
      case 0x3b72: m.ax = (m.ax & 0xff00) | m.shr8((m.ax & 0xff), 0x1);  // shr al, 1
      case 0x3b74: m.ax = (m.ax & 0xff00) | m.shr8((m.ax & 0xff), 0x1);  // shr al, 1
      case 0x3b76: m.ax = (m.ax & 0xff00) | m.shr8((m.ax & 0xff), 0x1);  // shr al, 1
      case 0x3b78: m.if = 1;  // sti
      case 0x3b79: ip = m.pop(); continue;  // ret
      default: return ip;
    }
  }
}

// 0x3b7a sub_802a
function sub_3b7a_3b7a(m, ip) {
  for (;;) {
    if (m.pas <= 0) return ip;
    switch (ip) {
      case 0x3b7a: m.t += 2; m.pas -= 2; m.sub8(m.rb(m.ds, 0x1442), 0x0);  // cmp byte ptr [0x1442], 0
      case 0x3b7f: if (!m.zf) { ip = 0x3b8c; continue; }  // jne 0x3b8c
      case 0x3b81: m.t += 2; m.pas -= 2; m.ax = 0xb;  // mov ax, 0xb
      case 0x3b84: if (!m.interruption(0x60)) { m.pas = 0; ip = 0x3b84; continue; }  // int 0x60
      case 0x3b86: m.t += 3; m.pas -= 3; m.ax = (m.ax & 0xff00) | m.entree(0x61, 1);  // in al, 0x61
      case 0x3b88: m.ax = (m.ax & 0xff00) | m.and8((m.ax & 0xff), 0xfc);  // and al, 0xfc
      case 0x3b8a: m.sortie(0x61, (m.ax & 0xff), 1);  // out 0x61, al
      case 0x3b8c: m.t += 2; m.pas -= 2; m.sub8(m.rb(m.ds, 0x1442), 0x0);  // cmp byte ptr [0x1442], 0
      case 0x3b91: if (m.zf) { ip = 0x3ba7; continue; }  // je 0x3ba7
      case 0x3b93: m.t += 3; m.pas -= 3; m.di = m.rw(m.ds, 0x144e);  // mov di, word ptr [0x144e]
      case 0x3b97: m.sub8(m.rb(m.ds, 0x1449), 0x1);  // cmp byte ptr [0x1449], 1
      case 0x3b9c: if (m.zf) { ip = 0x3ba2; continue; }  // je 0x3ba2
      case 0x3b9e: m.t += 1; m.pas -= 1; m.di = m.rw(m.ds, 0x144c);  // mov di, word ptr [0x144c]
      case 0x3ba2: m.t += 2; m.pas -= 2; m.ax = 0x4;  // mov ax, 4
      case 0x3ba5: if (!m.interruption(0x60)) { m.pas = 0; ip = 0x3ba5; continue; }  // int 0x60
      case 0x3ba7: m.t += 2; m.pas -= 2; m.ax = 0xb;  // mov ax, 0xb
      case 0x3baa: if (!m.interruption(0x60)) { m.pas = 0; ip = 0x3baa; continue; }  // int 0x60
      case 0x3bac: m.t += 2; m.pas -= 2; m.ax = 0x0;  // mov ax, 0
      case 0x3baf: if (!m.interruption(0x60)) { m.pas = 0; ip = 0x3baf; continue; }  // int 0x60
      case 0x3bb1: m.t += 1; m.pas -= 1; ip = m.pop(); continue;  // ret
      default: return ip;
    }
  }
}

// 0x3bb2 sub_8062
function sub_3bb2_3bb2(m, ip) {
  for (;;) {
    if (m.pas <= 0) return ip;
    switch (ip) {
      case 0x3bb2: m.t += 7; m.pas -= 7; m.wb(m.ds, 0x1449, 0x0);  // mov byte ptr [0x1449], 0
      case 0x3bb7: m.bx = (m.bx & 0xff00) | m.rb(m.ds, 0x1442);  // mov bl, byte ptr [0x1442]
      case 0x3bbb: m.bx = (m.bx & 0xff00) | m.shl8((m.bx & 0xff), 0x1);  // shl bl, 1
      case 0x3bbd: m.xor8(0, 0); m.bx = (m.bx & 0xff) | (0 << 8);  // xor bh, bh
      case 0x3bbf: m.bx = m.rw(m.ds, ((m.bx + 0x1480) & 0xffff));  // mov bx, word ptr [bx + 0x1480]
      case 0x3bc3: m.sub16(m.bx, 0x0);  // cmp bx, 0
      case 0x3bc6: if (m.zf) { ip = 0x3bf0; continue; }  // je 0x3bf0
      case 0x3bc8: m.t += 4; m.pas -= 4; m.ww(m.ds, 0x1a8b, m.bx);  // mov word ptr [0x1a8b], bx
      case 0x3bcc: m.bx = 0x697;  // mov bx, 0x697
      case 0x3bcf: m.ax = (m.ax & 0xff) | (0x48 << 8);  // mov ah, 0x48
      case 0x3bd1: if (!m.interruption(0x21)) { m.pas = 0; ip = 0x3bd1; continue; }  // int 0x21
      case 0x3bd3: m.t += 1; m.pas -= 1; if (!m.cf) { ip = 0x3bd6; continue; }  // jae 0x3bd6
      case 0x3bd5: m.t += 1; m.pas -= 1; ip = m.pop(); continue;  // ret
      case 0x3bd6: m.t += 7; m.pas -= 7; m.ww(m.ds, 0x144a, m.ax);  // mov word ptr [0x144a], ax
      case 0x3bd9: m.bx = m.rw(m.ds, 0x1a8b);  // mov bx, word ptr [0x1a8b]
      case 0x3bdd: m.ww(m.ds, 0x1ba9, m.bx);  // mov word ptr [0x1ba9], bx
      case 0x3be1: m.ww(m.ds, 0x1ba5, 0x0);  // mov word ptr [0x1ba5], 0
      case 0x3be7: m.ax = m.rw(m.ds, 0x144a);  // mov ax, word ptr [0x144a]
      case 0x3bea: m.ww(m.ds, 0x1ba3, m.ax);  // mov word ptr [0x1ba3], ax
      case 0x3bed: m.push(0x3bf0); ip = 0x2d91; continue;  // call 0x2d91
      case 0x3bf0: m.t += 9; m.pas -= 9; m.bx = (m.bx & 0xff00) | m.rb(m.ds, 0x1442);  // mov bl, byte ptr [0x1442]
      case 0x3bf4: m.bx = (m.bx & 0xff00) | m.shl8((m.bx & 0xff), 0x1);  // shl bl, 1
      case 0x3bf6: m.xor8(0, 0); m.bx = (m.bx & 0xff) | (0 << 8);  // xor bh, bh
      case 0x3bf8: m.bx = m.rw(m.ds, ((m.bx + 0x1450) & 0xffff));  // mov bx, word ptr [bx + 0x1450]
      case 0x3bfc: m.ww(m.ds, 0x1ba9, m.bx);  // mov word ptr [0x1ba9], bx
      case 0x3c00: m.ww(m.ds, 0x1ba5, 0x0);  // mov word ptr [0x1ba5], 0
      case 0x3c06: m.ax = ((0x1ec + m.L) & 0xffff);  // mov ax, 0x1ec
      case 0x3c09: m.ww(m.ds, 0x1ba3, m.ax);  // mov word ptr [0x1ba3], ax
      case 0x3c0c: m.push(0x3c0f); ip = 0x2d91; continue;  // call 0x2d91
      case 0x3c0f: m.t += 3; m.pas -= 3; m.appelLointain(m.rw(m.ds, (0x14a8 + 2) & 0xffff), m.rw(m.ds, 0x14a8));  // lcall [0x14a8]
      case 0x3c13: m.ax = 0xa;  // mov ax, 0xa
      case 0x3c16: if (!m.interruption(0x60)) { m.pas = 0; ip = 0x3c16; continue; }  // int 0x60
      case 0x3c18: m.t += 2; m.pas -= 2; m.cf = 0;  // clc
      case 0x3c19: ip = m.pop(); continue;  // ret
      default: return ip;
    }
  }
}

// 0x3c1a sub_80ca
function sub_3c1a_3c1a(m, ip) {
  for (;;) {
    if (m.pas <= 0) return ip;
    switch (ip) {
      case 0x3c1a: m.t += 2; m.pas -= 2; m.sub8(m.rb(m.ds, 0x1442), 0x0);  // cmp byte ptr [0x1442], 0
      case 0x3c1f: if (m.zf) { ip = 0x3c2d; continue; }  // je 0x3c2d
      case 0x3c21: m.t += 4; m.pas -= 4; m.dx = m.rw(m.ds, 0x144a);  // mov dx, word ptr [0x144a]
      case 0x3c25: m.si = 0x0;  // mov si, 0
      case 0x3c28: m.ax = 0x2;  // mov ax, 2
      case 0x3c2b: if (!m.interruption(0x60)) { m.pas = 0; ip = 0x3c2b; continue; }  // int 0x60
      case 0x3c2d: m.t += 7; m.pas -= 7; m.bx = (m.bx & 0xff00) | m.rb(m.ds, 0x1442);  // mov bl, byte ptr [0x1442]
      case 0x3c31: m.xor8(0, 0); m.bx = (m.bx & 0xff) | (0 << 8);  // xor bh, bh
      case 0x3c33: m.bx = m.shl16(m.bx, 0x1);  // shl bx, 1
      case 0x3c35: m.dx = m.rw(m.ds, ((m.bx + 0x14a0) & 0xffff));  // mov dx, word ptr [bx + 0x14a0]
      case 0x3c39: m.cx = m.dx;  // mov cx, dx
      case 0x3c3b: m.ax = 0x3;  // mov ax, 3
      case 0x3c3e: if (!m.interruption(0x60)) { m.pas = 0; ip = 0x3c3e; continue; }  // int 0x60
      case 0x3c40: m.t += 2; m.pas -= 2; m.ww(m.ds, 0x144c, m.di);  // mov word ptr [0x144c], di
      case 0x3c44: ip = m.pop(); continue;  // ret
      default: return ip;
    }
  }
}

// 0x3c45 sub_80f5
function sub_3c45_3c45(m, ip) {
  for (;;) {
    if (m.pas <= 0) return ip;
    switch (ip) {
      case 0x3c45: m.t += 2; m.pas -= 2; m.sub8(m.rb(m.ds, 0x1449), 0x1);  // cmp byte ptr [0x1449], 1
      case 0x3c4a: if (!m.zf) { ip = 0x3c4d; continue; }  // jne 0x3c4d
      case 0x3c4c: m.t += 1; m.pas -= 1; ip = m.pop(); continue;  // ret
      case 0x3c4d: m.t += 2; m.pas -= 2; m.sub8(m.rb(m.ds, 0x1bf8), 0x1);  // cmp byte ptr [0x1bf8], 1
      case 0x3c52: if (m.zf) { ip = 0x3c55; continue; }  // je 0x3c55
      case 0x3c54: m.t += 1; m.pas -= 1; ip = m.pop(); continue;  // ret
      case 0x3c55: m.t += 3; m.pas -= 3; m.wb(m.ds, 0x1449, 0x1);  // mov byte ptr [0x1449], 1
      case 0x3c5a: m.sub8(m.rb(m.ds, 0x1442), 0x3);  // cmp byte ptr [0x1442], 3
      case 0x3c5f: if (!m.zf) { ip = 0x3c6a; continue; }  // jne 0x3c6a
      case 0x3c61: m.t += 3; m.pas -= 3; m.dx = 0x0;  // mov dx, 0
      case 0x3c64: m.ax = 0x3;  // mov ax, 3
      case 0x3c67: if (!m.interruption(0x60)) { m.pas = 0; ip = 0x3c67; continue; }  // int 0x60
      case 0x3c69: m.t += 1; m.pas -= 1; ip = m.pop(); continue;  // ret
      case 0x3c6a: m.t += 3; m.pas -= 3; m.di = m.rw(m.ds, 0x144c);  // mov di, word ptr [0x144c]
      case 0x3c6e: m.ax = 0x4;  // mov ax, 4
      case 0x3c71: if (!m.interruption(0x60)) { m.pas = 0; ip = 0x3c71; continue; }  // int 0x60
      case 0x3c73: m.t += 2; m.pas -= 2; m.sub8(m.rb(m.ds, 0x1442), 0x0);  // cmp byte ptr [0x1442], 0
      case 0x3c78: if (!m.zf) { ip = 0x3c85; continue; }  // jne 0x3c85
      case 0x3c7a: m.t += 2; m.pas -= 2; m.ax = 0xb;  // mov ax, 0xb
      case 0x3c7d: if (!m.interruption(0x60)) { m.pas = 0; ip = 0x3c7d; continue; }  // int 0x60
      case 0x3c7f: m.t += 3; m.pas -= 3; m.ax = (m.ax & 0xff00) | m.entree(0x61, 1);  // in al, 0x61
      case 0x3c81: m.ax = (m.ax & 0xff00) | m.and8((m.ax & 0xff), 0xfc);  // and al, 0xfc
      case 0x3c83: m.sortie(0x61, (m.ax & 0xff), 1);  // out 0x61, al
      case 0x3c85: m.t += 1; m.pas -= 1; ip = m.pop(); continue;  // ret
      default: return ip;
    }
  }
}

// Adresse de chaque instruction -> fonction qui la contient.
export function routines() {
  const table = new Array(0x10000).fill(null);
  remplir(table, sub_0000_0000, [0x0000, 0x0046, 0x0047, 0x0227, 0x0228, 0x0234, 0x0235, 0x027e, 0x027f, 0x0305, 0x0306, 0x038b, 0x038c, 0x0462]);
  remplir(table, sub_0462_0462, [0x0462, 0x048c, 0x048d, 0x04d0]);
  remplir(table, sub_04d0_04d0, [0x04d0, 0x0532]);
  remplir(table, sub_0532_0532, [0x0532, 0x054c]);
  remplir(table, sub_054c_054c, [0x054c, 0x055c]);
  remplir(table, sub_055c_055c, [0x055c, 0x0561]);
  remplir(table, sub_0561_0561, [0x0561, 0x059d]);
  remplir(table, sub_059d_059d, [0x059d, 0x05ba]);
  remplir(table, sub_05ba_05ba, [0x05ba, 0x05e2]);
  remplir(table, sub_05e2_05e2, [0x05e2, 0x0669]);
  remplir(table, sub_0669_0669, [0x0669, 0x06d0]);
  remplir(table, sub_06d0_06d0, [0x06d0, 0x071e]);
  remplir(table, sub_072a_072a, [0x072a, 0x0731]);
  remplir(table, sub_0731_0731, [0x0731, 0x074d]);
  remplir(table, sub_074d_074d, [0x074d, 0x076f]);
  remplir(table, sub_076f_076f, [0x076f, 0x07a6]);
  remplir(table, sub_07a6_07a6, [0x07a6, 0x0823]);
  remplir(table, sub_0823_0823, [0x0823, 0x08a0]);
  remplir(table, sub_08a0_08a0, [0x08a0, 0x08e3]);
  remplir(table, sub_08e3_08e3, [0x08e3, 0x092c]);
  remplir(table, sub_092c_092c, [0x092c, 0x0975]);
  remplir(table, sub_0975_0975, [0x0975, 0x0993]);
  remplir(table, sub_0993_0993, [0x0993, 0x09ab]);
  remplir(table, sub_09ab_09ab, [0x09ab, 0x0a1c]);
  remplir(table, sub_0a1d_0a1d, [0x0a1d, 0x0a6b]);
  remplir(table, sub_0a6b_0a6b, [0x0a6b, 0x0a83]);
  remplir(table, sub_0a83_0a83, [0x0a83, 0x0ad2]);
  remplir(table, sub_0ad2_0ad2, [0x0ad2, 0x0b0f]);
  remplir(table, sub_0b0f_0b0f, [0x0b0f, 0x0b3d]);
  remplir(table, sub_0b3d_0b3d, [0x0b3d, 0x23ef]);
  remplir(table, sub_258c_258c, [0x258c, 0x259b]);
  remplir(table, sub_259b_259b, [0x259b, 0x2650, 0x2651, 0x2669, 0x266a, 0x2682, 0x2683, 0x269b, 0x269c, 0x2940, 0x2941, 0x29ae]);
  remplir(table, sub_29ae_29ae, [0x29ae, 0x29bb]);
  remplir(table, sub_29bb_29bb, [0x29bb, 0x29d6]);
  remplir(table, sub_29d6_29d6, [0x29d6, 0x29e5]);
  remplir(table, sub_29e5_29e5, [0x29e5, 0x29f2]);
  remplir(table, sub_29f2_29f2, [0x29f2, 0x2a1b]);
  remplir(table, sub_2a1b_2a1b, [0x2a1b, 0x2a23]);
  remplir(table, sub_2a23_2a23, [0x2a23, 0x2a50]);
  remplir(table, sub_2a50_2a50, [0x2a50, 0x2ab0]);
  remplir(table, sub_2ab0_2ab0, [0x2ab0, 0x2abd]);
  remplir(table, sub_2aca_2aca, [0x2aca, 0x2b01]);
  remplir(table, sub_2b01_2b01, [0x2b01, 0x2b19]);
  remplir(table, clavier_interruption_2b19, [0x2b19, 0x2b62]);
  remplir(table, sub_2b62_2b62, [0x2b62, 0x2bb9]);
  remplir(table, sub_2bb9_2bb9, [0x2bb9, 0x2be5, 0x2be6, 0x2c0a, 0x2c0b, 0x2c45]);
  remplir(table, sub_2c45_2c45, [0x2c45, 0x2c96]);
  remplir(table, sub_2c96_2c96, [0x2c96, 0x2cde, 0x2cdf, 0x2ced]);
  remplir(table, sub_2ced_2ced, [0x2ced, 0x2cff]);
  remplir(table, sub_2cff_2cff, [0x2cff, 0x2d0a]);
  remplir(table, sub_2d0a_2d0a, [0x2d0a, 0x2d3e]);
  remplir(table, sub_2d3e_2d3e, [0x2d3e, 0x2d64]);
  remplir(table, sub_2d64_2d64, [0x2d64, 0x2d91]);
  remplir(table, sub_2d91_2d91, [0x2d91, 0x2da6, 0x2da7, 0x2daf]);
  remplir(table, sub_2db0_2db0, [0x2db0, 0x2dc6]);
  remplir(table, sub_2dc6_2dc6, [0x2dc6, 0x2dd8]);
  remplir(table, sub_2dd8_2dd8, [0x2dd8, 0x2df2]);
  remplir(table, sub_2df2_2df2, [0x2df2, 0x2e0c]);
  remplir(table, sub_2e0c_2e0c, [0x2e0c, 0x2e24]);
  remplir(table, sub_2e24_2e24, [0x2e24, 0x2e2f]);
  remplir(table, sub_2e2f_2e2f, [0x2e2f, 0x2eb5]);
  remplir(table, sub_2eb5_2eb5, [0x2eb5, 0x2ee9]);
  remplir(table, sub_2ee9_2ee9, [0x2ee9, 0x2f24]);
  remplir(table, sub_2f24_2f24, [0x2f24, 0x2f60]);
  remplir(table, sub_2f60_2f60, [0x2f60, 0x34e5]);
  remplir(table, sub_34e5_34e5, [0x34e5, 0x3814]);
  remplir(table, sub_3814_3814, [0x3814, 0x38a7]);
  remplir(table, sub_38a7_38a7, [0x38a7, 0x38b4]);
  remplir(table, sub_38b4_38b4, [0x38b4, 0x38ba]);
  remplir(table, sub_38ba_38ba, [0x38ba, 0x397e]);
  remplir(table, sub_397e_397e, [0x397e, 0x399c]);
  remplir(table, sub_399c_399c, [0x399c, 0x39a2]);
  remplir(table, sub_39a2_39a2, [0x39a2, 0x39b0]);
  remplir(table, sub_39b0_39b0, [0x39b0, 0x39b8]);
  remplir(table, sub_39b8_39b8, [0x39b8, 0x39cc]);
  remplir(table, sub_39cc_39cc, [0x39cc, 0x39da]);
  remplir(table, sub_39dd_39dd, [0x39dd, 0x3a93]);
  remplir(table, sub_3a93_3a93, [0x3a93, 0x3a9b]);
  remplir(table, sub_3a9b_3a9b, [0x3a9b, 0x3ab7]);
  remplir(table, sub_3ab7_3ab7, [0x3ab7, 0x3aca]);
  remplir(table, sub_3b1a_3b1a, [0x3b1a, 0x3b29, 0x3b2a, 0x3b2c, 0x3b2d, 0x3b2f, 0x3b30, 0x3b61]);
  remplir(table, sub_3b61_3b61, [0x3b61, 0x3b7a]);
  remplir(table, sub_3b7a_3b7a, [0x3b7a, 0x3bb2]);
  remplir(table, sub_3bb2_3bb2, [0x3bb2, 0x3c1a]);
  remplir(table, sub_3c1a_3c1a, [0x3c1a, 0x3c45]);
  remplir(table, sub_3c45_3c45, [0x3c45, 0x3c86]);
  return table;
}

function remplir(table, f, plages) {
  for (let k = 0; k < plages.length; k += 2) table.fill(f, plages[k], plages[k + 1]);
}

export const CODE_REECRIT = [0x23ef, 0x23f0, 0x2500, 0x2501, 0x2502, 0x2503, 0x2504, 0x2505];
export const ENTREE = 0x0000;
