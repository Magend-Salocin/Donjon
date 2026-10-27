; QUEST.EXE décompressé, désassemblé par outils/desassembler.py. Ne pas modifier : enrichir original/symboles.txt puis relancer.


; ======== ecran_shields   (appelée depuis 2088)
; non appelée : protection contre la copie (écran SHIELDS, EGA) : bouclier tiré au hasard, code saisi par saisie_nombre, erreur_fichier = FFFFh si faux
00000  ff 36 90 31          push word ptr [0x3190]    ; mode_video
00004  83 3e 90 31 08       cmp word ptr [0x3190], 8    ; mode_video
00009  75 0e                jne loc_0019
0000b  c7 06 90 31 06 00    mov word ptr [0x3190], 6    ; mode_video
00011  e8 02 60             call mode_ega
00014  c6 06 59 37 00       mov byte ptr [0x3759], 0    ; texte_transparent
loc_0019:
00019  83 3e 90 31 04       cmp word ptr [0x3190], 4    ; mode_video
0001e  75 05                jne loc_0025
00020  c6 06 62 09 0c       mov byte ptr [0x962], 0xc
loc_0025:
00025  e8 da 61             call efface_tampon
00028  e8 b9 60             call affiche_tampon
0002b  c7 06 07 39 13 0e    mov word ptr [0x3907], 0xe13    ; fichier_nom, "shields.ega"
00031  c7 06 03 39 00 00    mov word ptr [0x3903], 0    ; fichier_offset
00037  b8 63 14             mov ax, 0x1463
0003a  a3 01 39             mov word ptr [0x3901], ax    ; fichier_segment
0003d  e8 41 39             call charge_fichier
00040  a1 27 5e             mov ax, word ptr [0x5e27]    ; seg_annexe
00043  8e c0                mov es, ax
00045  33 f6                xor si, si
00047  bf 00 00             mov di, 0
0004a  b8 63 14             mov ax, 0x1463
0004d  8e d8                mov ds, ax
0004f  b9 ff ff             mov cx, 0xffff
00052  e8 7c 45             call lz_decompresse
00055  50                   push ax
00056  b8 7c 09             mov ax, 0x97c
00059  8e d8                mov ds, ax
0005b  58                   pop ax
0005c  e8 a3 61             call efface_tampon
0005f  bd 60 09             mov bp, 0x960
00062  e8 17 31             call affiche_texte
loc_0065:
00065  b3 1d                mov bl, 0x1d
00067  e8 a9 35             call hasard
0006a  fe c8                dec al
0006c  32 e4                xor ah, ah
0006e  a3 ed 37             mov word ptr [0x37ed], ax    ; ligne_carte
00071  8b d8                mov bx, ax
00073  d1 e3                shl bx, 1
00075  8b 9f 1f 0e          mov bx, word ptr [bx + 0xe1f]
00079  8b f3                mov si, bx
0007b  bf 90 28             mov di, 0x2890
0007e  a1 27 5e             mov ax, word ptr [0x5e27]    ; seg_annexe
00081  a3 4e 37             mov word ptr [0x374e], ax    ; segment_source
00084  50                   push ax
00085  b8 63 14             mov ax, 0x1463
00088  8e c0                mov es, ax
0008a  58                   pop ax
0008b  bd 30 00             mov bp, 0x30
0008e  b9 30 00             mov cx, 0x30
00091  1e                   push ds
00092  e8 be 3a             call copie_image
00095  1f                   pop ds
00096  e8 4b 60             call affiche_tampon
00099  e8 46 35             call touche_enfoncee
0009c  3c 20                cmp al, 0x20
0009e  74 0e                je loc_00ae
000a0  bf 90 28             mov di, 0x2890
000a3  bd 30 00             mov bp, 0x30
000a6  b9 30 00             mov cx, 0x30
000a9  e8 88 62             call restaure_rect
000ac  eb b7                jmp loc_0065
loc_00ae:
000ae  bd 98 09             mov bp, 0x998
000b1  e8 c8 30             call affiche_texte
000b4  e8 2d 60             call affiche_tampon
000b7  e8 ee 39             call saisie_nombre
000ba  2d 02 00             sub ax, 2
000bd  3b 06 ed 37          cmp ax, word ptr [0x37ed]    ; ligne_carte
000c1  74 15                je loc_00d8
000c3  c7 06 e9 37 ff ff    mov word ptr [0x37e9], 0xffff    ; erreur_fichier
000c9  bd f6 09             mov bp, 0x9f6
000cc  e8 ad 30             call affiche_texte
000cf  e8 12 60             call affiche_tampon
000d2  e8 00 35             call attend_touche
000d5  eb 07                jmp loc_00de
; ---- 1 octets non atteints (00d7-00d7)
loc_00d8:
000d8  c7 06 e9 37 00 00    mov word ptr [0x37e9], 0    ; erreur_fichier
loc_00de:
000de  8f 06 90 31          pop word ptr [0x3190]    ; mode_video
000e2  83 3e 90 31 08       cmp word ptr [0x3190], 8    ; mode_video
000e7  75 03                jne loc_00ec
000e9  e8 f7 5e             call mode_vga
loc_00ec:
000ec  c3                   ret

; ======== demarrage
; point d'entrée : DS = 0x097C, réduit la mémoire (int 21h AH=4Ah)
000ed  50                   push ax
000ee  b8 7c 09             mov ax, 0x97c
000f1  8e d8                mov ds, ax
000f3  58                   pop ax
000f4  8c c0                mov ax, es
000f6  8c d3                mov bx, ss
000f8  2b d8                sub bx, ax
000fa  81 c3 94 01          add bx, 0x194
000fe  b4 4a                mov ah, 0x4a
00100  cd 21                int 0x21
00102  72 10                jb loc_0114
00104  e8 b3 35             call clavier_installe
00107  e8 ec 2f             call lit_configuration
0010a  73 03                jae loc_010f
0010c  e9 bd 2e             jmp quitte_erreur
loc_010f:
0010f  e8 70 5e             call initialise_jeu
00112  73 0d                jae loc_0121
loc_0114:
00114  e8 da 35             call clavier_retire
00117  ba 10 36             mov dx, 0x3610
0011a  b4 09                mov ah, 9
0011c  cd 21                int 0x21
0011e  e9 ab 2e             jmp quitte_erreur
loc_0121:
00121  90                   nop
00122  90                   nop
00123  90                   nop
00124  83 3e e9 37 00       cmp word ptr [0x37e9], 0    ; erreur_fichier
00129  eb 03                jmp loc_012e
; ---- 3 octets non atteints (012b-012d)
loc_012e:
0012e  e8 d1 60             call efface_tampon
00131  e8 b0 5f             call affiche_tampon
00134  e8 8a 64             call init_sprites_icones
00137  c6 06 a0 44 ff       mov byte ptr [0x44a0], 0xff    ; heros_en_jeu
0013c  c6 06 a1 44 00       mov byte ptr [0x44a1], 0
00141  c6 06 a2 44 00       mov byte ptr [0x44a2], 0
00146  c6 06 a3 44 00       mov byte ptr [0x44a3], 0
0014b  c6 06 8b 46 80       mov byte ptr [0x468b], 0x80
loc_0150:
00150  c6 06 e9 3f 01       mov byte ptr [0x3fe9], 1    ; sans_sprites
00155  e8 b8 71             call menu_titre
00158  f6 06 92 39 40       test byte ptr [0x3992], 0x40    ; commandes
0015d  74 03                je loc_0162
0015f  e9 5a 01             jmp loc_02bc
loc_0162:
00162  e8 4c 53             call charge_ecran_plateau
00165  c6 06 e9 3f 00       mov byte ptr [0x3fe9], 0    ; sans_sprites
0016a  e8 d9 00             call partie
0016d  f6 06 92 39 40       test byte ptr [0x3992], 0x40    ; commandes
00172  74 03                je loc_0177
00174  e9 45 01             jmp loc_02bc
loc_0177:
00177  80 3e 92 3f 0f       cmp byte ptr [0x3f92], 0xf    ; numero_quete
0017c  72 d2                jb loc_0150
0017e  80 3e e7 3f 00       cmp byte ptr [0x3fe7], 0    ; fin_du_jeu
00183  74 cb                je loc_0150
00185  83 3e 90 31 08       cmp word ptr [0x3190], 8    ; mode_video
0018a  75 49                jne loc_01d5
0018c  c7 06 07 39 e1 ac    mov word ptr [0x3907], 0xace1    ; fichier_nom, "questb.vga"
00192  c7 06 03 39 00 00    mov word ptr [0x3903], 0    ; fichier_offset
00198  a1 23 5e             mov ax, word ptr [0x5e23]    ; seg_ecran
0019b  a3 01 39             mov word ptr [0x3901], ax    ; fichier_segment
loc_019e:
0019e  c7 06 e9 37 00 00    mov word ptr [0x37e9], 0    ; erreur_fichier
001a4  e8 4a 35             call clavier_retire
001a7  e8 1e 38             call fichier_ouvre
001aa  83 3e e9 37 00       cmp word ptr [0x37e9], 0    ; erreur_fichier
001af  75 03                jne loc_01b4
001b1  eb 0f                jmp loc_01c2
; ---- 1 octets non atteints (01b3-01b3)
loc_01b4:
001b4  e8 03 35             call clavier_installe
001b7  bb 52 02             mov bx, 0x252
001ba  e8 30 87             call affiche_message
001bd  e8 31 35             call clavier_retire
001c0  eb dc                jmp loc_019e
loc_01c2:
001c2  e8 37 38             call fichier_lit
001c5  83 3e e9 37 00       cmp word ptr [0x37e9], 0    ; erreur_fichier
001ca  75 e8                jne loc_01b4
001cc  a3 05 39             mov word ptr [0x3905], ax    ; fichier_taille
001cf  e8 e8 34             call clavier_installe
001d2  eb 47                jmp loc_021b
; ---- 1 octets non atteints (01d4-01d4)
loc_01d5:
001d5  c7 06 07 39 ec ac    mov word ptr [0x3907], 0xacec    ; fichier_nom, "questb.ega"
001db  c7 06 03 39 00 00    mov word ptr [0x3903], 0    ; fichier_offset
001e1  a1 23 5e             mov ax, word ptr [0x5e23]    ; seg_ecran
001e4  a3 01 39             mov word ptr [0x3901], ax    ; fichier_segment
loc_01e7:
001e7  c7 06 e9 37 00 00    mov word ptr [0x37e9], 0    ; erreur_fichier
001ed  e8 01 35             call clavier_retire
001f0  e8 d5 37             call fichier_ouvre
001f3  83 3e e9 37 00       cmp word ptr [0x37e9], 0    ; erreur_fichier
001f8  75 03                jne loc_01fd
001fa  eb 0f                jmp loc_020b
; ---- 1 octets non atteints (01fc-01fc)
loc_01fd:
001fd  e8 ba 34             call clavier_installe
00200  bb 52 02             mov bx, 0x252
00203  e8 e7 86             call affiche_message
00206  e8 e8 34             call clavier_retire
00209  eb dc                jmp loc_01e7
loc_020b:
0020b  e8 ee 37             call fichier_lit
0020e  83 3e e9 37 00       cmp word ptr [0x37e9], 0    ; erreur_fichier
00213  75 e8                jne loc_01fd
00215  a3 05 39             mov word ptr [0x3905], ax    ; fichier_taille
00218  e8 9f 34             call clavier_installe
loc_021b:
0021b  e8 05 68             call fond_vers_tampon
0021e  c6 06 50 37 11       mov byte ptr [0x3750], 0x11    ; couleur_texte
00223  c6 06 59 37 01       mov byte ptr [0x3759], 1    ; texte_transparent
00228  bd c4 a5             mov bp, 0xa5c4
0022b  e8 4e 2f             call affiche_texte
0022e  e8 b3 5e             call affiche_tampon
00231  e8 fa 36             call attend_clic
00234  e8 ec 67             call fond_vers_tampon
00237  bd c2 a7             mov bp, 0xa7c2
0023a  e8 3f 2f             call affiche_texte
0023d  e8 a4 5e             call affiche_tampon
00240  e8 eb 36             call attend_clic
00243  e9 0a ff             jmp loc_0150

; ======== partie   (appelée depuis 016a)
; une quête : préparation des 4 joueurs (DS:3195-3198), puis le jeu
00246  c7 06 35 46 a4 48    mov word ptr [0x4635], 0x48a4    ; zones_actives, zones_panneau
0024c  c6 06 e9 3f 00       mov byte ptr [0x3fe9], 0    ; sans_sprites
00251  e8 cf 67             call fond_vers_tampon
00254  e8 6a 63             call init_sprites_icones
00257  e8 99 00             call prepare_heros
loc_025a:
0025a  ba c6 4b             mov dx, 0x4bc6    ; sprites
0025d  bb 63 46             mov bx, 0x4663    ; fiches_personnages
00260  8a 26 95 31          mov ah, byte ptr [0x3195]    ; commandes_joueurs
00264  32 c0                xor al, al
00266  e8 e0 00             call tour_personnage
00269  ba dd 4b             mov dx, 0x4bdd
0026c  bb 7d 46             mov bx, 0x467d
0026f  8a 26 96 31          mov ah, byte ptr [0x3196]
00273  b0 01                mov al, 1
00275  e8 d1 00             call tour_personnage
00278  ba f4 4b             mov dx, 0x4bf4
0027b  bb 97 46             mov bx, 0x4697
0027e  8a 26 97 31          mov ah, byte ptr [0x3197]
00282  b0 02                mov al, 2
00284  e8 c2 00             call tour_personnage
00287  ba 0b 4c             mov dx, 0x4c0b
0028a  bb b1 46             mov bx, 0x46b1
0028d  8a 26 98 31          mov ah, byte ptr [0x3198]
00291  b0 03                mov al, 3
00293  e8 b3 00             call tour_personnage
00296  ba f1 4c             mov dx, 0x4cf1
00299  bb cb 46             mov bx, 0x46cb
0029c  8a 26 95 31          mov ah, byte ptr [0x3195]    ; commandes_joueurs
002a0  b0 04                mov al, 4
002a2  e8 a4 00             call tour_personnage
002a5  e8 0c 04             call quete_continue
002a8  0a c0                or al, al
002aa  75 01                jne loc_02ad
002ac  c3                   ret
loc_02ad:
002ad  e8 11 1f             call tour_morcar
002b0  f6 06 92 39 40       test byte ptr [0x3992], 0x40    ; commandes
002b5  74 03                je loc_02ba
002b7  e9 96 fe             jmp loc_0150
loc_02ba:
002ba  eb 9e                jmp loc_025a
loc_02bc:
002bc  e8 af 44             call son_arret
002bf  e8 2f 34             call clavier_retire
002c2  32 e4                xor ah, ah
002c4  b0 03                mov al, 3
002c6  cd 10                int 0x10
002c8  b8 00 4c             mov ax, 0x4c00
002cb  cd 21                int 0x21
loc_02cd:
002cd  bf 63 46             mov di, 0x4663    ; fiches_personnages
002d0  be 8f a9             mov si, 0xa98f    ; fiches_avant_quete
002d3  50                   push ax
002d4  b8 7c 09             mov ax, 0x97c
002d7  8e c0                mov es, ax
002d9  58                   pop ax
002da  b9 34 00             mov cx, 0x34
002dd  f3 a5                rep movsw word ptr es:[di], word ptr [si]
002df  bf a0 44             mov di, 0x44a0    ; heros_en_jeu
002e2  b9 02 00             mov cx, 2
002e5  f3 a5                rep movsw word ptr es:[di], word ptr [si]
002e7  c6 06 92 3f 00       mov byte ptr [0x3f92], 0    ; numero_quete
002ec  c6 06 92 39 00       mov byte ptr [0x3992], 0    ; commandes
002f1  58                   pop ax
002f2  c3                   ret

; ======== prepare_heros   (appelée depuis 0257)
; prépare les fiches des héros avant la quête
002f3  bf 63 46             mov di, 0x4663    ; fiches_personnages
002f6  89 3e 37 46          mov word ptr [0x4637], di    ; fiche_heros_courant
002fa  80 3d 00             cmp byte ptr [di], 0
002fd  74 09                je loc_0308
002ff  e8 19 13             call adresse_case_perso
00302  e8 c6 02             call marque_zone_vue
00305  e8 fa 23             call vue_alignee
loc_0308:
00308  bf 7d 46             mov di, 0x467d
0030b  89 3e 37 46          mov word ptr [0x4637], di    ; fiche_heros_courant
0030f  80 3d 00             cmp byte ptr [di], 0
00312  74 09                je loc_031d
00314  e8 04 13             call adresse_case_perso
00317  e8 b1 02             call marque_zone_vue
0031a  e8 e5 23             call vue_alignee
loc_031d:
0031d  bf 97 46             mov di, 0x4697
00320  89 3e 37 46          mov word ptr [0x4637], di    ; fiche_heros_courant
00324  80 3d 00             cmp byte ptr [di], 0
00327  74 09                je loc_0332
00329  e8 ef 12             call adresse_case_perso
0032c  e8 9c 02             call marque_zone_vue
0032f  e8 d0 23             call vue_alignee
loc_0332:
00332  bf b1 46             mov di, 0x46b1
00335  89 3e 37 46          mov word ptr [0x4637], di    ; fiche_heros_courant
00339  80 3d 00             cmp byte ptr [di], 0
0033c  75 01                jne loc_033f
0033e  c3                   ret
loc_033f:
0033f  e8 d9 12             call adresse_case_perso
00342  e8 86 02             call marque_zone_vue
00345  e8 ba 23             call vue_alignee
00348  c3                   ret

; ======== tour_personnage   (appelée depuis 0266, 0275, 0284, 0293, 02a2)
; tour d'un personnage : AH type de commande, BX fiche, DX ?, AL numéro (0-4)
00349  88 26 93 31          mov byte ptr [0x3193], ah    ; commande_type
0034d  89 16 39 46          mov word ptr [0x4639], dx    ; sprite_courant
00351  89 1e 37 46          mov word ptr [0x4637], bx    ; fiche_heros_courant
00355  c7 06 0f 0e ff ff    mov word ptr [0xe0f], 0xffff    ; case_apres_porte
0035b  c7 06 11 0e ff ff    mov word ptr [0xe11], 0xffff    ; case_avant_porte
00361  c6 06 2c 40 00       mov byte ptr [0x402c], 0
00366  f6 47 0d 02          test byte ptr [bx + 0xd], 2
0036a  74 05                je loc_0371
0036c  c6 06 2c 40 01       mov byte ptr [0x402c], 1
loc_0371:
00371  a2 a7 3f             mov byte ptr [0x3fa7], al    ; personnage_courant
00374  80 3f 00             cmp byte ptr [bx], 0
00377  75 01                jne loc_037a
00379  c3                   ret
loc_037a:
0037a  c6 06 cc 40 ff       mov byte ptr [0x40cc], 0xff    ; direction_pas
0037f  c6 06 b3 3f 00       mov byte ptr [0x3fb3], 0    ; attaque_repetee
00384  c6 06 c8 3f 00       mov byte ptr [0x3fc8], 0    ; pas_en_file
00389  c7 06 ce 3f 00 00    mov word ptr [0x3fce], 0
0038f  c6 06 c4 3f 00       mov byte ptr [0x3fc4], 0    ; des_deplacement
00394  c6 06 0e 0e 00       mov byte ptr [0xe0e], 0
00399  e8 22 57             call icones_init
0039c  e8 84 66             call fond_vers_tampon
0039f  e8 7a 62             call affiche_nom_portrait
003a2  e8 81 01             call redessine_vue
003a5  e8 06 65             call des_deplacement_tour
003a8  e8 d2 56             call icones_actives
003ab  e8 86 4e             call dessine_icones
003ae  8b 3e 37 46          mov di, word ptr [0x4637]    ; fiche_heros_courant
003b2  8a 45 18             mov al, byte ptr [di + 0x18]
003b5  f6 45 18 04          test byte ptr [di + 0x18], 4
003b9  74 0b                je loc_03c6
003bb  80 75 18 04          xor byte ptr [di + 0x18], 4
003bf  f6 45 18 02          test byte ptr [di + 0x18], 2
003c3  75 01                jne loc_03c6
003c5  c3                   ret
loc_03c6:
003c6  f6 45 18 02          test byte ptr [di + 0x18], 2
003ca  74 2c                je loc_03f8
003cc  e8 a0 61             call sauve_tampon
003cf  ff 36 c4 3f          push word ptr [0x3fc4]    ; des_deplacement
003d3  c6 06 c4 3f 01       mov byte ptr [0x3fc4], 1    ; des_deplacement
003d8  e8 1e 63             call tirage_deplacement
003db  8f 06 c4 3f          pop word ptr [0x3fc4]    ; des_deplacement
003df  80 3e 9c 3f 06       cmp byte ptr [0x3f9c], 6    ; deplacement_restant
003e4  74 01                je loc_03e7
003e6  c3                   ret
loc_03e7:
003e7  8b 3e 37 46          mov di, word ptr [0x4637]    ; fiche_heros_courant
003eb  80 65 18 fd          and byte ptr [di + 0x18], 0xfd
003ef  bb 66 00             mov bx, 0x66
003f2  e8 f8 84             call affiche_message
003f5  e8 2d 14             call redessine_plateau
loc_03f8:
003f8  e8 82 56             call icones_actives
003fb  e8 36 4e             call dessine_icones
003fe  e8 6e 61             call sauve_tampon
00401  e8 f5 62             call tirage_deplacement
00404  e8 b7 56             call icones_init
00407  e8 ea 54             call fleches_deplacement
0040a  e8 73 62             call dessine_icones_fiche
0040d  e8 24 4e             call dessine_icones
00410  e8 5c 61             call sauve_tampon
loc_0413:
00413  e8 e6 5f             call curseur_memorise
00416  e8 fa 5f             call commandes_tour
00419  c6 06 cc 40 ff       mov byte ptr [0x40cc], 0xff    ; direction_pas
0041e  f6 06 92 39 20       test byte ptr [0x3992], 0x20    ; commandes
00423  74 03                je loc_0428
00425  e8 2e 03             call fin_tour
loc_0428:
00428  e8 59 63             call pas_automatique
0042b  e8 a2 02             call evenements_et_piege
0042e  e8 e5 64             call ordre_trace_heros
00431  e8 45 53             call ordonne_sprites
00434  e8 dd 53             call anime_sprites
00437  e8 fa 4d             call dessine_icones
0043a  e8 7b 53             call dessine_sprites
0043d  e8 b4 54             call fleches_deplacement
00440  e8 a1 56             call icones_selon_situation
00443  e8 1e 60             call survol_icones
00446  e8 cf 60             call affiche_valeurs_fiche
00449  e8 c8 59             call curseur_dessine
0044c  80 3e 9a 3f 00       cmp byte ptr [0x3f9a], 0    ; fin_du_tour
00451  75 03                jne loc_0456
00453  e8 8e 5c             call affiche_tampon
loc_0456:
00456  e8 7e 59             call curseur_efface
00459  e8 59 54             call restaure_tampon
0045c  e8 21 00             call evenements_quete
0045f  e8 ec 13             call fin_quete
00462  80 3e 97 3f 00       cmp byte ptr [0x3f97], 0    ; vue_a_refaire
00467  74 03                je loc_046c
00469  e8 ba 00             call redessine_vue
loc_046c:
0046c  80 3e 9a 3f 00       cmp byte ptr [0x3f9a], 0    ; fin_du_tour
00471  74 01                je loc_0474
00473  c3                   ret
loc_0474:
00474  80 3e 92 39 40       cmp byte ptr [0x3992], 0x40    ; commandes
00479  75 03                jne loc_047e
0047b  e9 4f fe             jmp loc_02cd
loc_047e:
0047e  eb 93                jmp loc_0413

; ======== evenements_quete   (appelée depuis 045c)
; messages scriptés des quêtes 1, 6, 9, 15, 16 selon les drapeaux DS:3FBF et DS:3FC0
00480  80 3e 92 3f 01       cmp byte ptr [0x3f92], 1    ; numero_quete
00485  75 1c                jne loc_04a3
00487  80 3e bf 3f 80       cmp byte ptr [0x3fbf], 0x80    ; evenement_a
0048c  73 01                jae loc_048f
0048e  c3                   ret
loc_048f:
0048f  be 94 00             mov si, 0x94
00492  80 36 bf 3f 80       xor byte ptr [0x3fbf], 0x80    ; evenement_a
loc_0497:
00497  b9 2c 01             mov cx, 0x12c
0049a  e8 ea 41             call temporise
0049d  8b de                mov bx, si
0049f  e8 4b 84             call affiche_message
004a2  c3                   ret
loc_04a3:
004a3  80 3e 92 3f 06       cmp byte ptr [0x3f92], 6    ; numero_quete
004a8  75 1a                jne loc_04c4
004aa  80 3e c0 3f 80       cmp byte ptr [0x3fc0], 0x80    ; evenement_b
004af  73 01                jae loc_04b2
004b1  c3                   ret
loc_04b2:
004b2  80 3e c0 3f ff       cmp byte ptr [0x3fc0], 0xff    ; evenement_b
004b7  75 01                jne loc_04ba
004b9  c3                   ret
loc_04ba:
004ba  80 36 c0 3f 80       xor byte ptr [0x3fc0], 0x80    ; evenement_b
004bf  be c4 00             mov si, 0xc4
004c2  eb d3                jmp loc_0497
loc_04c4:
004c4  80 3e 92 3f 09       cmp byte ptr [0x3f92], 9    ; numero_quete
004c9  75 28                jne loc_04f3
004cb  83 3e ea 3f 00       cmp word ptr [0x3fea], 0    ; message_en_attente
004d0  74 0f                je loc_04e1
004d2  8b 36 ea 3f          mov si, word ptr [0x3fea]    ; message_en_attente
004d6  c7 06 ea 3f 00 00    mov word ptr [0x3fea], 0    ; message_en_attente
004dc  8b de                mov bx, si
004de  e8 0c 84             call affiche_message
loc_04e1:
004e1  80 3e c0 3f 02       cmp byte ptr [0x3fc0], 2    ; evenement_b
004e6  74 01                je loc_04e9
004e8  c3                   ret
loc_04e9:
004e9  c6 06 c0 3f 01       mov byte ptr [0x3fc0], 1    ; evenement_b
004ee  be de 00             mov si, 0xde
004f1  eb a4                jmp loc_0497
loc_04f3:
004f3  80 3e 92 3f 0f       cmp byte ptr [0x3f92], 0xf    ; numero_quete
004f8  75 12                jne loc_050c
004fa  80 3e bf 3f 81       cmp byte ptr [0x3fbf], 0x81    ; evenement_a
004ff  74 01                je loc_0502
00501  c3                   ret
loc_0502:
00502  c6 06 bf 3f 01       mov byte ptr [0x3fbf], 1    ; evenement_a
00507  be 2c 02             mov si, 0x22c
0050a  eb 8b                jmp loc_0497
loc_050c:
0050c  80 3e 92 3f 10       cmp byte ptr [0x3f92], 0x10    ; numero_quete
00511  75 12                jne loc_0525
00513  80 3e bf 3f 00       cmp byte ptr [0x3fbf], 0    ; evenement_a
00518  75 0b                jne loc_0525
0051a  c6 06 bf 3f 01       mov byte ptr [0x3fbf], 1    ; evenement_a
0051f  be 34 02             mov si, 0x234
00522  e9 72 ff             jmp loc_0497
loc_0525:
00525  c3                   ret

; ======== redessine_vue   (appelée depuis 03a2, 0469)
; fond, vide sprites_vue et le cache de meubles (DS:0E58, DS:0E5A), affiche_zone_heros, portrait, icônes, sauve_tampon, place_personnages ; DS:3F97 et DS:3F99 remis à 0
00526  e8 fa 64             call fond_vers_tampon
00529  c7 06 58 0e 00 00    mov word ptr [0xe58], 0    ; meuble_cache
0052f  c7 06 5a 0e 00 00    mov word ptr [0xe5a], 0    ; meuble_cache_2
00535  e8 89 60             call init_sprites_icones
00538  c6 06 99 3f 00       mov byte ptr [0x3f99], 0    ; sprites_figes
0053d  c6 06 97 3f 00       mov byte ptr [0x3f97], 0    ; vue_a_refaire
00542  e8 10 00             call affiche_zone_heros
00545  e8 d4 60             call affiche_nom_portrait
00548  e8 35 61             call dessine_icones_fiche
0054b  e8 e6 4c             call dessine_icones
0054e  e8 1e 60             call sauve_tampon
00551  e8 ed 0d             call place_personnages
00554  c3                   ret

; ======== affiche_zone_heros   (appelée depuis 0542, 12cb, 1830)
; zone du héros courant (zone_heros, fiche +3), revele_zone avec événements (BP = 0), dessine_case_vue pour chaque case de la fenêtre 6 × 5 (ordre DS:49D6) qui est dans la zone, vue_alignee, puis les monstres de la zone sont révélés (+0 bit 0x80 effacé, 0x6664)
00555  8b 3e 37 46          mov di, word ptr [0x4637]    ; fiche_heros_courant
00559  e8 bf 10             call adresse_case_perso
0055c  a2 94 3f             mov byte ptr [0x3f94], al    ; zone_heros
0055f  88 45 03             mov byte ptr [di + 3], al
00562  bd 00 00             mov bp, 0
00565  e8 ac 0f             call revele_zone
00568  89 1e e4 3f          mov word ptr [0x3fe4], bx    ; case_coin_zone
0056c  c6 06 93 3f 00       mov byte ptr [0x3f93], 0    ; index_case_courante
00571  bf d6 49             mov di, 0x49d6    ; ordre_cases_vue
00574  b9 1e 00             mov cx, 0x1e
00577  c7 06 f5 37 00 00    mov word ptr [0x37f5], 0
0057d  c7 06 f7 37 00 00    mov word ptr [0x37f7], 0
loc_0583:
00583  51                   push cx
00584  53                   push bx
00585  57                   push di
00586  8a 15                mov dl, byte ptr [di]
00588  32 f6                xor dh, dh
0058a  03 da                add bx, dx
0058c  8a 07                mov al, byte ptr [bx]
0058e  24 3f                and al, 0x3f
00590  3a 06 94 3f          cmp al, byte ptr [0x3f94]    ; zone_heros
00594  75 03                jne loc_0599
00596  e8 5a 00             call dessine_case_vue
loc_0599:
00599  5f                   pop di
0059a  5b                   pop bx
0059b  59                   pop cx
0059c  47                   inc di
0059d  fe 06 93 3f          inc byte ptr [0x3f93]    ; index_case_courante
005a1  ff 06 f5 37          inc word ptr [0x37f5]
005a5  83 3e f5 37 1a       cmp word ptr [0x37f5], 0x1a
005aa  75 0a                jne loc_05b6
005ac  c7 06 f7 37 00 00    mov word ptr [0x37f7], 0
005b2  ff 06 f5 37          inc word ptr [0x37f5]
loc_05b6:
005b6  e2 cb                loop loc_0583
005b8  e8 47 21             call vue_alignee
005bb  a0 9e 3f             mov al, byte ptr [0x3f9e]    ; zone_nouvelle
005be  0a c0                or al, al
005c0  75 01                jne loc_05c3
005c2  c3                   ret
loc_05c3:
005c3  f6 d0                not al
005c5  a2 9e 3f             mov byte ptr [0x3f9e], al    ; zone_nouvelle
005c8  e9 99 60             jmp loc_6664

; ======== marque_zone_vue   (appelée depuis 0302, 0317, 032c, 0342, 7270, 72ce, 72ef)
; AL = zone : revele_zone sans événement (BP = 1), puis marque_case_vue sur chaque case de la fenêtre qui est dans la zone (bits 0xC0 de grille_zones)
005cb  a2 94 3f             mov byte ptr [0x3f94], al    ; zone_heros
005ce  bd 01 00             mov bp, 1
005d1  e8 40 0f             call revele_zone
005d4  bf d6 49             mov di, 0x49d6    ; ordre_cases_vue
005d7  b9 1e 00             mov cx, 0x1e
005da  32 f6                xor dh, dh
loc_05dc:
005dc  53                   push bx
005dd  8a 15                mov dl, byte ptr [di]
005df  03 da                add bx, dx
005e1  8a 07                mov al, byte ptr [bx]
005e3  24 3f                and al, 0x3f
005e5  3a 06 94 3f          cmp al, byte ptr [0x3f94]    ; zone_heros
005e9  75 03                jne loc_05ee
005eb  e8 77 17             call marque_case_vue
loc_05ee:
005ee  47                   inc di
005ef  5b                   pop bx
005f0  e2 ea                loop loc_05dc
005f2  c3                   ret

; ======== dessine_case_vue   (appelée depuis 0596)
; une case de la fenêtre (BX ; DS:3FDE = BX + 0x200) : marquée vue, sol, murs_case_vue, sprite_occupant, bords_zone, portes des côtés droit et bas (0x16A5)
005f3  81 c3 00 02          add bx, 0x200
005f7  89 1e de 3f          mov word ptr [0x3fde], bx    ; case_dessinee
005fb  e8 5f 17             call marque_case_courante
005fe  e8 b8 11             call dessine_sol_case
00601  e8 09 00             call murs_case_vue
00604  e8 ba 0d             call sprite_occupant
00607  e8 83 55             call bords_zone
0060a  e9 98 10             jmp portes_avant_case

; ======== murs_case_vue   (appelée depuis 0601)
; octet de murs DS:3FDE : bit 0x01 posé, sprite de la porte non secrète (table DS:4A6F) ; sinon murs et portes du haut et de gauche copiés dans le fond (0x16F2)
0060d  8b 1e de 3f          mov bx, word ptr [0x3fde]    ; case_dessinee
00611  f6 07 01             test byte ptr [bx], 1
00614  75 03                jne loc_0619
00616  e9 d9 10             jmp murs_case
loc_0619:
00619  8a 07                mov al, byte ptr [bx]
0061b  24 30                and al, 0x30
0061d  75 01                jne loc_0620
0061f  c3                   ret
loc_0620:
00620  8a 07                mov al, byte ptr [bx]
00622  24 0c                and al, 0xc
00624  3c 08                cmp al, 8
00626  75 01                jne loc_0629
00628  c3                   ret
loc_0629:
00629  8a 07                mov al, byte ptr [bx]
0062b  24 1c                and al, 0x1c
0062d  bd 6f 4a             mov bp, 0x4a6f
00630  32 e4                xor ah, ah
00632  03 e8                add bp, ax
00634  e8 a8 52             call sprite_libre
00637  c6 04 01             mov byte ptr [si], 1
0063a  8a 1e 93 3f          mov bl, byte ptr [0x3f93]    ; index_case_courante
0063e  02 db                add bl, bl
00640  02 db                add bl, bl
00642  b7 00                mov bh, 0
00644  81 c3 19 41          add bx, 0x4119    ; position_cases
00648  8b 07                mov ax, word ptr [bx]
0064a  3e 2a 46 00          sub al, byte ptr ds:[bp]
0064e  88 44 04             mov byte ptr [si + 4], al
00651  8b 47 02             mov ax, word ptr [bx + 2]
00654  3e 02 46 01          add al, byte ptr ds:[bp + 1]
00658  89 44 02             mov word ptr [si + 2], ax
0065b  eb 35                jmp loc_0692

; ======== sprite_porte   (appelée depuis 16c0, 16ea)
; sprite d'une porte 24 × 44 de GRAPHICS : AL = décalage dans DS:4A2F (dx, dy, image) ; profondeur +1 = 3 × index_case_courante
0065d  bd 2f 4a             mov bp, 0x4a2f    ; portes_vue
00660  32 e4                xor ah, ah
00662  03 e8                add bp, ax
00664  8a 1e 93 3f          mov bl, byte ptr [0x3f93]    ; index_case_courante
00668  e8 74 52             call sprite_libre
0066b  c6 04 01             mov byte ptr [si], 1
0066e  8a 1e 93 3f          mov bl, byte ptr [0x3f93]    ; index_case_courante
00672  02 db                add bl, bl
00674  02 db                add bl, bl
00676  b7 00                mov bh, 0
00678  81 c3 19 41          add bx, 0x4119    ; position_cases
0067c  8b 07                mov ax, word ptr [bx]
0067e  3e 2a 46 00          sub al, byte ptr ds:[bp]
00682  88 44 04             mov byte ptr [si + 4], al
00685  8b 4f 02             mov cx, word ptr [bx + 2]
00688  3e 8a 46 01          mov al, byte ptr ds:[bp + 1]
0068c  98                   cwde
0068d  03 c1                add ax, cx
0068f  89 44 02             mov word ptr [si + 2], ax
loc_0692:
00692  c6 44 06 18          mov byte ptr [si + 6], 0x18
00696  c6 44 07 2c          mov byte ptr [si + 7], 0x2c
0069a  3e 8b 46 02          mov ax, word ptr ds:[bp + 2]
0069e  89 44 0c             mov word ptr [si + 0xc], ax
006a1  a1 2b 5e             mov ax, word ptr [0x5e2b]    ; seg_graphics
006a4  89 44 08             mov word ptr [si + 8], ax
006a7  a0 93 3f             mov al, byte ptr [0x3f93]    ; index_case_courante
006aa  02 c0                add al, al
006ac  02 06 93 3f          add al, byte ptr [0x3f93]    ; index_case_courante
006b0  88 44 01             mov byte ptr [si + 1], al
006b3  c3                   ret

; ======== quete_continue   (appelée depuis 02a5, 1116, 1a3d, 21d2, 21e5)
; AL = 1 tant que la quête continue
006b4  32 c0                xor al, al
006b6  80 3e c6 3f 0f       cmp byte ptr [0x3fc6], 0xf    ; etat_quete
006bb  75 10                jne loc_06cd
006bd  80 3e 92 3f 01       cmp byte ptr [0x3f92], 1    ; numero_quete
006c2  74 01                je loc_06c5
006c4  c3                   ret
loc_06c5:
006c5  80 3e cb 46 00       cmp byte ptr [0x46cb], 0
006ca  75 01                jne loc_06cd
006cc  c3                   ret
loc_06cd:
006cd  b0 01                mov al, 1
006cf  c3                   ret

; ======== evenements_et_piege   (appelée depuis 042b)
; evenements_tour, puis declenche_piege
006d0  e8 03 00             call evenements_tour
006d3  e9 9f 1e             jmp declenche_piege

; ======== evenements_tour   (appelée depuis 06d0)
; quête 6 : équipement repris ; quête 12 : le Sorcier se réveille
006d6  a0 92 3f             mov al, byte ptr [0x3f92]    ; numero_quete
006d9  3c 05                cmp al, 5
006db  75 03                jne loc_06e0
006dd  eb 23                jmp loc_0702
; ---- 1 octets non atteints (06df-06df)
loc_06e0:
006e0  3c 0b                cmp al, 0xb
006e2  74 01                je loc_06e5
006e4  c3                   ret
loc_06e5:
006e5  80 3e c0 3f 00       cmp byte ptr [0x3fc0], 0    ; evenement_b
006ea  75 01                jne loc_06ed
006ec  c3                   ret
loc_06ed:
006ed  80 3e c3 3f 00       cmp byte ptr [0x3fc3], 0
006f2  74 01                je loc_06f5
006f4  c3                   ret
loc_06f5:
006f5  fe 06 c3 3f          inc byte ptr [0x3fc3]
006f9  e8 29 11             call redessine_plateau
006fc  be ee 00             mov si, 0xee
006ff  e9 33 13             jmp message_puis_sortie
loc_0702:
00702  80 3e c0 3f 00       cmp byte ptr [0x3fc0], 0    ; evenement_b
00707  75 01                jne loc_070a
00709  c3                   ret
loc_070a:
0070a  c6 06 c0 3f 00       mov byte ptr [0x3fc0], 0    ; evenement_b
0070f  b2 01                mov dl, 1
00711  a0 a7 3f             mov al, byte ptr [0x3fa7]    ; personnage_courant
loc_0714:
00714  0a c0                or al, al
00716  74 06                je loc_071e
00718  d0 e2                shl dl, 1
0071a  fe c8                dec al
0071c  eb f6                jmp loc_0714
loc_071e:
0071e  a0 c1 3f             mov al, byte ptr [0x3fc1]    ; equipement_repris
00721  22 c2                and al, dl
00723  74 01                je loc_0726
00725  c3                   ret
loc_0726:
00726  08 16 c1 3f          or byte ptr [0x3fc1], dl    ; equipement_repris
0072a  8a 1e a7 3f          mov bl, byte ptr [0x3fa7]    ; personnage_courant
0072e  32 ff                xor bh, bh
00730  d1 e3                shl bx, 1
00732  8b bf 8f 4a          mov di, word ptr [bx + 0x4a8f]    ; equipement_fiches
00736  8b b7 97 4a          mov si, word ptr [bx + 0x4a97]
0073a  50                   push ax
0073b  b8 7c 09             mov ax, 0x97c
0073e  8e c0                mov es, ax
00740  58                   pop ax
00741  b9 05 00             mov cx, 5
00744  f3 a4                rep movsb byte ptr es:[di], byte ptr [si]
00746  e8 dc 10             call redessine_plateau
00749  bb bc 00             mov bx, 0xbc
0074c  e8 9e 81             call affiche_message
0074f  e8 5e 67             call redessin_plateau
00752  e9 f5 12             jmp loc_1a4a
; ---- 1 octets non atteints (0755-0755)

; ======== fin_tour   (appelée depuis 0425)
; icône fin du tour : DS:3F9A = 1 ; traversée de la roche activée
00756  80 3e c8 3f 00       cmp byte ptr [0x3fc8], 0    ; pas_en_file
0075b  74 01                je loc_075e
0075d  c3                   ret
loc_075e:
0075e  80 3e c2 3f 00       cmp byte ptr [0x3fc2], 0    ; piege_en_cours
00763  74 01                je loc_0766
00765  c3                   ret
loc_0766:
00766  8b 3e 37 46          mov di, word ptr [0x4637]    ; fiche_heros_courant
0076a  80 65 18 df          and byte ptr [di + 0x18], 0xdf
0076e  f6 45 18 80          test byte ptr [di + 0x18], 0x80
00772  74 08                je loc_077c
00774  80 4d 18 20          or byte ptr [di + 0x18], 0x20
00778  80 65 18 7f          and byte ptr [di + 0x18], 0x7f
loc_077c:
0077c  e8 c9 22             call son_clic
0077f  c6 06 9a 3f 01       mov byte ptr [0x3f9a], 1    ; fin_du_tour
00784  c3                   ret
ouvre_portes:    ; icône : ouvre les portes de la case du héros (sub_07c0)
00785  e8 38 00             call ouvre_portes_case

; ======== teste_porte_reveille   (appelée depuis 4927, 49ee, 4ab4, 4b7f)
; porte_reveille en gardant AX et DI (appelée par les 4 pas)
00788  50                   push ax
00789  57                   push di
0078a  e8 03 00             call porte_reveille
0078d  5f                   pop di
0078e  58                   pop ax
0078f  c3                   ret

; ======== porte_reveille   (appelée depuis 078a)
; quêtes 5 et 16 : la porte en (5, 3-4) réveille le monstre 1
00790  80 3e 92 3f 04       cmp byte ptr [0x3f92], 4    ; numero_quete
00795  74 07                je loc_079e
00797  80 3e 92 3f 0f       cmp byte ptr [0x3f92], 0xf    ; numero_quete
0079c  75 1f                jne loc_07bd
loc_079e:
0079e  8b 3e 37 46          mov di, word ptr [0x4637]    ; fiche_heros_courant
007a2  83 7d 01 05          cmp word ptr [di + 1], 5
007a6  75 15                jne loc_07bd
007a8  80 7d 02 03          cmp byte ptr [di + 2], 3
007ac  72 0f                jb loc_07bd
007ae  80 7d 02 05          cmp byte ptr [di + 2], 5
007b2  73 09                jae loc_07bd
007b4  bf 5a 4d             mov di, 0x4d5a
007b7  80 0d 01             or byte ptr [di], 1
007ba  b0 01                mov al, 1
007bc  c3                   ret
loc_07bd:
007bd  32 c0                xor al, al
007bf  c3                   ret

; ======== ouvre_portes_case   (appelée depuis 0785)
; pose le bit 0x04 des portes non secrètes autour de la case et révèle l'autre côté
007c0  c6 06 97 3f 01       mov byte ptr [0x3f97], 1    ; vue_a_refaire
007c5  e8 53 0e             call adresse_case_perso
007c8  80 c7 02             add bh, 2
007cb  8a 07                mov al, byte ptr [bx]
007cd  24 30                and al, 0x30
007cf  74 22                je loc_07f3
007d1  f6 07 fb             test byte ptr [bx], 0xfb
007d4  74 1d                je loc_07f3
007d6  f6 07 f7             test byte ptr [bx], 0xf7
007d9  74 18                je loc_07f3
007db  80 0f 04             or byte ptr [bx], 4
007de  e8 46 20             call son_porte
007e1  53                   push bx
007e2  bd 01 00             mov bp, 1
007e5  f6 07 10             test byte ptr [bx], 0x10
007e8  75 03                jne loc_07ed
007ea  bd 1a 00             mov bp, 0x1a
loc_07ed:
007ed  2b dd                sub bx, bp
007ef  e8 0d 0b             call revele_derriere_porte
007f2  5b                   pop bx
loc_07f3:
007f3  43                   inc bx
007f4  f6 07 04             test byte ptr [bx], 4
007f7  75 15                jne loc_080e
007f9  f6 07 08             test byte ptr [bx], 8
007fc  75 10                jne loc_080e
007fe  f6 07 10             test byte ptr [bx], 0x10
00801  74 0b                je loc_080e
00803  80 0f 04             or byte ptr [bx], 4
00806  53                   push bx
00807  e8 1d 20             call son_porte
0080a  e8 f2 0a             call revele_derriere_porte
0080d  5b                   pop bx
loc_080e:
0080e  83 c3 19             add bx, 0x19
00811  81 fb 6f 58          cmp bx, 0x586f    ; grille_occupants
00815  72 01                jb loc_0818
00817  c3                   ret
loc_0818:
00818  f6 07 04             test byte ptr [bx], 4
0081b  74 01                je loc_081e
0081d  c3                   ret
loc_081e:
0081e  f6 07 08             test byte ptr [bx], 8
00821  74 01                je loc_0824
00823  c3                   ret
loc_0824:
00824  f6 07 20             test byte ptr [bx], 0x20
00827  75 01                jne loc_082a
00829  c3                   ret
loc_082a:
0082a  80 0f 04             or byte ptr [bx], 4
0082d  e8 f7 1f             call son_porte
00830  e9 cc 0a             jmp revele_derriere_porte

; ======== mode_attaque
; actif quand l'icône attaque est enfoncée (état 0x1C) ; clic sur une cible, zone DS:4337 pour annuler
00833  80 3e a7 3f 04       cmp byte ptr [0x3fa7], 4    ; personnage_courant
00838  75 01                jne loc_083b
0083a  c3                   ret
loc_083b:
0083b  80 3e 89 42 1c       cmp byte ptr [0x4289], 0x1c
00840  74 01                je loc_0843
00842  c3                   ret
loc_0843:
00843  8b 3e 37 46          mov di, word ptr [0x4637]    ; fiche_heros_courant
00847  f6 45 0f 20          test byte ptr [di + 0xf], 0x20
0084b  74 01                je loc_084e
0084d  c3                   ret
loc_084e:
0084e  e8 f7 21             call son_clic
00851  c6 06 b1 3f 00       mov byte ptr [0x3fb1], 0
00856  c6 06 ac 3f 00       mov byte ptr [0x3fac], 0    ; monstre_designe
0085b  c6 06 91 3f 01       mov byte ptr [0x3f91], 1    ; carte_cible
00860  e8 6d 4e             call plateau_ciblage
loc_0863:
00863  e8 29 3e             call attend_trame
00866  e8 93 5b             call curseur_memorise
00869  e8 2c 04             call clic_attaque
0086c  e8 a5 55             call curseur_dessine
0086f  e8 72 58             call affiche_tampon
00872  e8 62 55             call curseur_efface
00875  f6 06 92 39 20       test byte ptr [0x3992], 0x20    ; commandes
0087a  74 03                je loc_087f
0087c  e9 2b 0a             jmp fin_action
loc_087f:
0087f  be 37 43             mov si, 0x4337    ; zone_annuler_attaque
00882  f6 06 92 39 10       test byte ptr [0x3992], 0x10    ; commandes
00887  74 03                je loc_088c
00889  e8 8e 46             call zone_sous_curseur
loc_088c:
0088c  83 fb 02             cmp bx, 2
0088f  75 03                jne loc_0894
00891  e9 16 0a             jmp fin_action
loc_0894:
00894  a0 9d 3f             mov al, byte ptr [0x3f9d]    ; cible_validee
00897  0a c0                or al, al
00899  74 c8                je loc_0863
0089b  3c ff                cmp al, 0xff
0089d  75 03                jne loc_08a2
0089f  e9 08 0a             jmp fin_action
loc_08a2:
008a2  e8 a8 18             call calcule_attaque_heros
008a5  e8 96 01             call portee_attaque
008a8  a2 a8 3f             mov byte ptr [0x3fa8], al    ; resultat_vise
008ab  8b 36 d4 3f          mov si, word ptr [0x3fd4]    ; cible
008af  80 3e b1 3f 00       cmp byte ptr [0x3fb1], 0
008b4  74 07                je loc_08bd
008b6  c6 06 9d 3f 00       mov byte ptr [0x3f9d], 0    ; cible_validee
008bb  eb a6                jmp loc_0863
loc_08bd:
008bd  f6 44 06 01          test byte ptr [si + 6], 1
008c1  74 25                je loc_08e8
008c3  a0 a8 3f             mov al, byte ptr [0x3fa8]    ; resultat_vise
008c6  0a c0                or al, al
008c8  74 6c                je attaque_heros
008ca  3c 01                cmp al, 1
008cc  75 03                jne loc_08d1
008ce  e9 d9 09             jmp fin_action
loc_08d1:
008d1  3c fd                cmp al, 0xfd
008d3  74 0e                je loc_08e3
008d5  3c fe                cmp al, 0xfe
008d7  75 05                jne loc_08de
008d9  be 28 00             mov si, 0x28
008dc  eb 46                jmp loc_0924
loc_08de:
008de  be 22 00             mov si, 0x22
008e1  eb 41                jmp loc_0924
loc_08e3:
008e3  be 28 00             mov si, 0x28
008e6  eb 3c                jmp loc_0924
loc_08e8:
008e8  80 3e 92 3f 0f       cmp byte ptr [0x3f92], 0xf    ; numero_quete
008ed  72 32                jb loc_0921
008ef  f6 44 06 bf          test byte ptr [si + 6], 0xbf
008f3  74 2c                je loc_0921
008f5  32 db                xor bl, bl
008f7  8b 3e 37 46          mov di, word ptr [0x4637]    ; fiche_heros_courant
008fb  8a 45 11             mov al, byte ptr [di + 0x11]
008fe  0a c0                or al, al
00900  74 09                je loc_090b
00902  30 45 0e             xor byte ptr [di + 0xe], al
00905  c6 45 11 00          mov byte ptr [di + 0x11], 0
00909  fe c3                inc bl
loc_090b:
0090b  8a 45 12             mov al, byte ptr [di + 0x12]
0090e  24 18                and al, 0x18
00910  74 0d                je loc_091f
00912  30 45 0d             xor byte ptr [di + 0xd], al
00915  80 75 12 f7          xor byte ptr [di + 0x12], 0xf7
00919  80 75 12 ef          xor byte ptr [di + 0x12], 0xef
0091d  fe c3                inc bl
loc_091f:
0091f  0a db                or bl, bl
loc_0921:
00921  be 22 00             mov si, 0x22
loc_0924:
00924  c6 06 e9 3f 01       mov byte ptr [0x3fe9], 1    ; sans_sprites
00929  8b de                mov bx, si
0092b  e8 bf 7f             call affiche_message
0092e  c6 06 e9 3f 00       mov byte ptr [0x3fe9], 0    ; sans_sprites
00933  e9 74 09             jmp fin_action

; ======== attaque_heros
; le héros attaque : crânes (DS:3FB8 dés) contre boucliers noirs du monstre (DS:3FBB dés)
00936  e8 10 57             call fin_deplacement
00939  8b 36 37 46          mov si, word ptr [0x4637]    ; fiche_heros_courant
0093d  89 36 d6 3f          mov word ptr [0x3fd6], si    ; attaquant
loc_0941:
00941  e8 3c 53             call charge_men
00944  e8 fd 01             call bonus_attaque_heros
00947  e8 de 01             call calcule_des_monstre
0094a  8b 3e 37 46          mov di, word ptr [0x4637]    ; fiche_heros_courant
0094e  32 c0                xor al, al
00950  8a 36 b8 3f          mov dh, byte ptr [0x3fb8]    ; des_attaque_heros
00954  0a f6                or dh, dh
00956  74 03                je loc_095b
00958  e8 31 54             call compte_cranes
loc_095b:
0095b  a2 d2 3f             mov byte ptr [0x3fd2], al    ; cranes
0095e  8a 0e bb 3f          mov cl, byte ptr [0x3fbb]    ; des_defense_monstre
00962  32 ed                xor ch, ch
00964  8a d5                mov dl, ch
loc_0966:
00966  51                   push cx
00967  e8 4d 18             call de_combat
0096a  80 fb 02             cmp bl, 2
0096d  75 02                jne loc_0971
0096f  fe c2                inc dl
loc_0971:
00971  59                   pop cx
00972  e2 f2                loop loc_0966
00974  88 16 d3 3f          mov byte ptr [0x3fd3], dl    ; boucliers
00978  a0 d3 3f             mov al, byte ptr [0x3fd3]    ; boucliers
0097b  bd 48 71             mov bp, 0x7148
0097e  ba 10 00             mov dx, 0x10
00981  bb 20 62             mov bx, 0x6220
00984  e8 5f 02             call affiche_des
00987  a0 d2 3f             mov al, byte ptr [0x3fd2]    ; cranes
0098a  bd e0 70             mov bp, 0x70e0
0098d  ba f0 ff             mov dx, 0xfff0
00990  bb 20 61             mov bx, 0x6120
00993  e8 50 02             call affiche_des
00996  e8 d6 5b             call sauve_tampon
00999  8b 16 d2 3f          mov dx, word ptr [0x3fd2]    ; cranes
0099d  8b 36 d4 3f          mov si, word ptr [0x3fd4]    ; cible
009a1  3a d6                cmp dl, dh
009a3  76 04                jbe loc_09a9
009a5  c6 44 07 00          mov byte ptr [si + 7], 0
loc_09a9:
009a9  e8 68 15             call animation_combat
009ac  e8 c0 5b             call sauve_tampon
009af  8b 36 d4 3f          mov si, word ptr [0x3fd4]    ; cible
009b3  80 7c 07 00          cmp byte ptr [si + 7], 0
009b7  75 03                jne loc_09bc
009b9  e8 64 17             call retire_monstre
loc_09bc:
009bc  e8 69 01             call calcule_des_monstre
009bf  be 50 00             mov si, 0x50
009c2  8b 16 d2 3f          mov dx, word ptr [0x3fd2]    ; cranes
009c6  3a d6                cmp dl, dh
009c8  76 03                jbe loc_09cd
009ca  be 4e 00             mov si, 0x4e
loc_09cd:
009cd  8b de                mov bx, si
009cf  e8 1b 7f             call affiche_message
009d2  8b 36 d4 3f          mov si, word ptr [0x3fd4]    ; cible
009d6  80 7c 08 01          cmp byte ptr [si + 8], 1
009da  75 4b                jne loc_0a27
009dc  80 7c 07 00          cmp byte ptr [si + 7], 0
009e0  74 45                je loc_0a27
009e2  80 3e 0e 0e 00       cmp byte ptr [0xe0e], 0
009e7  75 3e                jne loc_0a27
009e9  8b 3e 37 46          mov di, word ptr [0x4637]    ; fiche_heros_courant
009ed  f6 45 12 08          test byte ptr [di + 0x12], 8
009f1  75 03                jne loc_09f6
009f3  eb 32                jmp loc_0a27
; ---- 1 octets non atteints (09f5-09f5)
loc_09f6:
009f6  f6 06 b3 3f 01       test byte ptr [0x3fb3], 1    ; attaque_repetee
009fb  74 03                je loc_0a00
009fd  eb 28                jmp loc_0a27
; ---- 1 octets non atteints (09ff-09ff)
loc_0a00:
00a00  bb 22 01             mov bx, 0x122    ; message « VOULEZ-VOUS ATTAQUER / A NOUVEAU? »
00a03  e8 e7 7e             call affiche_message
00a06  80 3e 7a ab 01       cmp byte ptr [0xab7a], 1    ; choix_menu
00a0b  75 03                jne loc_0a10
00a0d  eb 18                jmp loc_0a27
; ---- 1 octets non atteints (0a0f-0a0f)
loc_0a10:
00a10  80 3e 7a ab fe       cmp byte ptr [0xab7a], 0xfe    ; choix_menu
00a15  75 03                jne loc_0a1a
00a17  eb 0e                jmp loc_0a27
; ---- 1 octets non atteints (0a19-0a19)
loc_0a1a:
00a1a  80 0e b3 3f 01       or byte ptr [0x3fb3], 1    ; attaque_repetee
00a1f  c6 06 0e 0e 01       mov byte ptr [0xe0e], 1
00a24  e9 1a ff             jmp loc_0941
loc_0a27:
00a27  8b 3e 37 46          mov di, word ptr [0x4637]    ; fiche_heros_courant
00a2b  f6 45 17 40          test byte ptr [di + 0x17], 0x40
00a2f  74 04                je loc_0a35
00a31  80 65 17 bf          and byte ptr [di + 0x17], 0xbf
loc_0a35:
00a35  e8 26 5c             call pause_150
00a38  e8 1b 5f             call charge_maps
00a3b  e9 6c 08             jmp fin_action

; ======== portee_attaque   (appelée depuis 08a5)
; 0 permis ; FCh hors de portée, FDh arbalète au contact, FEh mur ou ligne de vue coupée
00a3e  c6 06 b0 3f 00       mov byte ptr [0x3fb0], 0    ; carte_simplifiee
00a43  c6 06 b2 3f 00       mov byte ptr [0x3fb2], 0    ; ligne_libre
00a48  8b 36 d4 3f          mov si, word ptr [0x3fd4]    ; cible
00a4c  8b 45 01             mov ax, word ptr [di + 1]
00a4f  8b 5c 01             mov bx, word ptr [si + 1]
00a52  2a c3                sub al, bl
00a54  3c 80                cmp al, 0x80
00a56  76 02                jbe loc_0a5a
00a58  f6 d8                neg al
loc_0a5a:
00a5a  3c 01                cmp al, 1
00a5c  77 76                ja loc_0ad4
00a5e  2a e7                sub ah, bh
00a60  80 fc 80             cmp ah, 0x80
00a63  76 02                jbe loc_0a67
00a65  f6 dc                neg ah
loc_0a67:
00a67  80 fc 01             cmp ah, 1
00a6a  77 68                ja loc_0ad4
00a6c  02 e0                add ah, al
00a6e  80 fc 02             cmp ah, 2
00a71  74 4b                je loc_0abe
00a73  32 c0                xor al, al
00a75  8b 55 01             mov dx, word ptr [di + 1]
00a78  8b 4c 01             mov cx, word ptr [si + 1]
00a7b  8b 5d 04             mov bx, word ptr [di + 4]
00a7e  3a d1                cmp dl, cl
00a80  74 17                je loc_0a99
00a82  76 0a                jbe loc_0a8e
00a84  f6 07 40             test byte ptr [bx], 0x40
00a87  74 02                je loc_0a8b
00a89  b0 fe                mov al, 0xfe
loc_0a8b:
00a8b  74 27                je loc_0ab4
00a8d  c3                   ret
loc_0a8e:
00a8e  f6 47 01 40          test byte ptr [bx + 1], 0x40
00a92  74 02                je loc_0a96
00a94  b0 fe                mov al, 0xfe
loc_0a96:
00a96  74 1c                je loc_0ab4
00a98  c3                   ret
loc_0a99:
00a99  3a f5                cmp dh, ch
00a9b  76 0a                jbe loc_0aa7
00a9d  f6 07 80             test byte ptr [bx], 0x80
00aa0  74 02                je loc_0aa4
00aa2  b0 fe                mov al, 0xfe
loc_0aa4:
00aa4  74 0e                je loc_0ab4
00aa6  c3                   ret
loc_0aa7:
00aa7  f6 47 1a 80          test byte ptr [bx + 0x1a], 0x80
00aab  74 02                je loc_0aaf
00aad  b0 fe                mov al, 0xfe
loc_0aaf:
00aaf  74 03                je loc_0ab4
00ab1  c3                   ret
loc_0ab2:
00ab2  32 c0                xor al, al
loc_0ab4:
00ab4  f6 45 11 10          test byte ptr [di + 0x11], 0x10
00ab8  75 01                jne loc_0abb
00aba  c3                   ret
loc_0abb:
00abb  b0 fd                mov al, 0xfd
00abd  c3                   ret
loc_0abe:
00abe  80 7d 11 01          cmp byte ptr [di + 0x11], 1
00ac2  74 ee                je loc_0ab2
00ac4  80 7d 11 02          cmp byte ptr [di + 0x11], 2
00ac8  74 e8                je loc_0ab2
00aca  80 7d 11 40          cmp byte ptr [di + 0x11], 0x40
00ace  74 e2                je loc_0ab2
00ad0  b0 fc                mov al, 0xfc
00ad2  eb e0                jmp loc_0ab4
loc_0ad4:
00ad4  f6 45 11 10          test byte ptr [di + 0x11], 0x10
00ad8  75 0f                jne loc_0ae9
00ada  f6 45 11 20          test byte ptr [di + 0x11], 0x20
00ade  75 09                jne loc_0ae9
00ae0  f6 45 11 40          test byte ptr [di + 0x11], 0x40
00ae4  75 03                jne loc_0ae9
00ae6  b0 fc                mov al, 0xfc
00ae8  c3                   ret
loc_0ae9:
00ae9  c6 06 b7 3f 01       mov byte ptr [0x3fb7], 1    ; attaque_a_distance
00aee  e8 2b 00             call tir_ligne_libre
00af1  32 c0                xor al, al
00af3  80 3e a8 3f 01       cmp byte ptr [0x3fa8], 1    ; resultat_vise
00af8  74 01                je loc_0afb
00afa  c3                   ret
loc_0afb:
00afb  b0 fe                mov al, 0xfe
00afd  c6 06 b7 3f 00       mov byte ptr [0x3fb7], 0    ; attaque_a_distance
00b02  c3                   ret

; ======== fin_tir
; non appelée : perd_arme_lancee, puis AL = 0
00b03  e8 03 00             call perd_arme_lancee
00b06  32 c0                xor al, al
00b08  c3                   ret

; ======== perd_arme_lancee   (appelée depuis 0b03)
; code mort : retire l'arme en main de +0x0E et +0x11 si attaque_a_distance a le bit 0x20, qui ne vaut que 0 ou 1 ; seule fin_tir (morte) l'appelle
00b09  f6 06 b7 3f 20       test byte ptr [0x3fb7], 0x20    ; attaque_a_distance
00b0e  75 01                jne loc_0b11
00b10  c3                   ret
loc_0b11:
00b11  8a 45 11             mov al, byte ptr [di + 0x11]
00b14  30 45 0e             xor byte ptr [di + 0xe], al
00b17  c6 45 11 00          mov byte ptr [di + 0x11], 0
00b1b  c3                   ret

; ======== tir_ligne_libre   (appelée depuis 0aee)
; vue_cible ; DS:3FB2 = 1 si la ligne est libre (resultat_vise = 0)
00b1c  e8 1f 06             call vue_cible
00b1f  a0 a8 3f             mov al, byte ptr [0x3fa8]    ; resultat_vise
00b22  34 01                xor al, 1
00b24  a2 b2 3f             mov byte ptr [0x3fb2], al    ; ligne_libre
00b27  c3                   ret

; ======== calcule_des_monstre   (appelée depuis 0947, 09bc, 1db0)
; dés d'attaque (DS:3FBA) et de défense (DS:3FBB) du monstre DS:3FD4
00b28  8b 36 d4 3f          mov si, word ptr [0x3fd4]    ; cible
00b2c  8a 5c 09             mov bl, byte ptr [si + 9]
00b2f  02 db                add bl, bl
00b31  02 db                add bl, bl
00b33  02 5c 09             add bl, byte ptr [si + 9]
00b36  b7 00                mov bh, 0
00b38  8b 87 07 48          mov ax, word ptr [bx + 0x4807]
00b3c  a2 ba 3f             mov byte ptr [0x3fba], al    ; des_attaque_monstre
00b3f  88 26 bb 3f          mov byte ptr [0x3fbb], ah    ; des_defense_monstre
00b43  c3                   ret

; ======== bonus_attaque_heros   (appelée depuis 0944)
; Sorcier-Roi sans la lame de l'esprit : 0 dé ; +2 force, +2 courage (consommés)
00b44  8b 3e 37 46          mov di, word ptr [0x4637]    ; fiche_heros_courant
00b48  8b 36 d4 3f          mov si, word ptr [0x3fd4]    ; cible
00b4c  8a 44 09             mov al, byte ptr [si + 9]
00b4f  80 3e 92 3f 0f       cmp byte ptr [0x3f92], 0xf    ; numero_quete
00b54  72 04                jb loc_0b5a
00b56  3c 1a                cmp al, 0x1a
00b58  eb 06                jmp loc_0b60
loc_0b5a:
00b5a  fe c0                inc al
00b5c  24 fe                and al, 0xfe
00b5e  3c 0c                cmp al, 0xc
loc_0b60:
00b60  75 0a                jne loc_0b6c
00b62  f6 45 12 10          test byte ptr [di + 0x12], 0x10
00b66  75 04                jne loc_0b6c
00b68  32 c0                xor al, al
00b6a  eb 1b                jmp loc_0b87
loc_0b6c:
00b6c  a0 b8 3f             mov al, byte ptr [0x3fb8]    ; des_attaque_heros
00b6f  f6 45 17 01          test byte ptr [di + 0x17], 1
00b73  74 06                je loc_0b7b
00b75  04 02                add al, 2
00b77  80 65 17 fe          and byte ptr [di + 0x17], 0xfe
loc_0b7b:
00b7b  f6 45 18 10          test byte ptr [di + 0x18], 0x10
00b7f  74 06                je loc_0b87
00b81  80 65 18 ef          and byte ptr [di + 0x18], 0xef
00b85  04 02                add al, 2
loc_0b87:
00b87  a2 b8 3f             mov byte ptr [0x3fb8], al    ; des_attaque_heros
00b8a  c3                   ret

; ======== calcule_defense_heros   (appelée depuis 1dad)
; +0x15, armures, bouclier, casque, ténacité, peau de pierre -> DS:3FB9
00b8b  8b 3e 37 46          mov di, word ptr [0x4637]    ; fiche_heros_courant
00b8f  32 c0                xor al, al
00b91  f6 45 0f 20          test byte ptr [di + 0xf], 0x20
00b95  75 4b                jne loc_0be2
00b97  8a 45 15             mov al, byte ptr [di + 0x15]
00b9a  f6 45 12 01          test byte ptr [di + 0x12], 1
00b9e  74 04                je loc_0ba4
00ba0  b0 04                mov al, 4
00ba2  eb 12                jmp loc_0bb6
loc_0ba4:
00ba4  f6 45 13 08          test byte ptr [di + 0x13], 8
00ba8  74 04                je loc_0bae
00baa  b0 04                mov al, 4
00bac  eb 08                jmp loc_0bb6
loc_0bae:
00bae  f6 45 13 04          test byte ptr [di + 0x13], 4
00bb2  74 02                je loc_0bb6
00bb4  b0 03                mov al, 3
loc_0bb6:
00bb6  f6 45 13 01          test byte ptr [di + 0x13], 1
00bba  74 02                je loc_0bbe
00bbc  fe c0                inc al
loc_0bbe:
00bbe  f6 45 13 02          test byte ptr [di + 0x13], 2
00bc2  74 02                je loc_0bc6
00bc4  fe c0                inc al
loc_0bc6:
00bc6  f6 45 17 02          test byte ptr [di + 0x17], 2
00bca  74 0a                je loc_0bd6
00bcc  04 02                add al, 2
00bce  80 65 17 fd          and byte ptr [di + 0x17], 0xfd
00bd2  80 65 10 fd          and byte ptr [di + 0x10], 0xfd
loc_0bd6:
00bd6  f6 45 18 40          test byte ptr [di + 0x18], 0x40
00bda  74 06                je loc_0be2
00bdc  80 65 18 bf          and byte ptr [di + 0x18], 0xbf
00be0  04 02                add al, 2
loc_0be2:
00be2  a2 b9 3f             mov byte ptr [0x3fb9], al    ; des_defense_heros
00be5  c3                   ret

; ======== affiche_des   (appelée depuis 0984, 0993, 1ec5, 1ed4)
; affiche un résultat de dés (icône BX, position BP)
00be6  0a c0                or al, al
00be8  75 01                jne loc_0beb
00bea  c3                   ret
loc_0beb:
00beb  8a c8                mov cl, al
00bed  32 ed                xor ch, ch
00bef  83 f9 07             cmp cx, 7
00bf2  76 03                jbe loc_0bf7
00bf4  b9 07 00             mov cx, 7
loc_0bf7:
00bf7  51                   push cx
00bf8  55                   push bp
00bf9  52                   push dx
00bfa  53                   push bx
00bfb  8b f3                mov si, bx
00bfd  8b fd                mov di, bp
00bff  a1 2d 5e             mov ax, word ptr [0x5e2d]    ; seg_odds
00c02  a3 4e 37             mov word ptr [0x374e], ax    ; segment_source
00c05  50                   push ax
00c06  b8 63 14             mov ax, 0x1463
00c09  8e c0                mov es, ax
00c0b  58                   pop ax
00c0c  bd 10 00             mov bp, 0x10
00c0f  b9 10 00             mov cx, 0x10
00c12  1e                   push ds
00c13  e8 3d 2f             call copie_image
00c16  1f                   pop ds
00c17  5b                   pop bx
00c18  5a                   pop dx
00c19  5d                   pop bp
00c1a  59                   pop cx
00c1b  03 ea                add bp, dx
00c1d  e2 d8                loop loc_0bf7
00c1f  c3                   ret

; ======== prime_ulag   (appelée depuis 214b)
; « L'EMPEREUR OFFRE 200 PIECES D'OR A L'ASSASSIN D'ULAG », mais ajoute 100
00c20  bb a8 00             mov bx, 0xa8    ; message « L'EMPEREUR OFFRE 200 / PIECES D'OR A / L'ASSASSIN D'ULAG »
00c23  e8 c7 7c             call affiche_message
00c26  ba 64 00             mov dx, 0x64
00c29  e9 da 5c             jmp ajoute_or

; ======== mort_balur   (appelée depuis 214b)
; tous les héros reçoivent 150 pièces ; evenement_b = le tueur
00c2c  a0 a7 3f             mov al, byte ptr [0x3fa7]    ; personnage_courant
00c2f  a2 c0 3f             mov byte ptr [0x3fc0], al    ; evenement_b
00c32  32 c0                xor al, al
loc_0c34:
00c34  50                   push ax
00c35  9c                   pushf
00c36  e8 46 51             call fiche_personnage
00c39  8b fe                mov di, si
00c3b  ba 96 00             mov dx, 0x96
00c3e  e8 c9 5c             call ajoute_or_di
00c41  9d                   popf
00c42  58                   pop ax
00c43  fe c0                inc al
00c45  3c 04                cmp al, 4
00c47  75 eb                jne loc_0c34
00c49  c3                   ret

; ======== prime_10   (appelée depuis 214b)
; prime de 10 pièces (type 14)
00c4a  b0 31                mov al, 0x31
00c4c  ba 0a 00             mov dx, 0xa
00c4f  eb 06                jmp loc_0c57
; ---- 1 octets non atteints (0c51-0c51)

; ======== prime_monstre   (appelée depuis 214b)
; prime de 20 pièces (type 15) : « VOUS RECEVEZ UNE PRIME DE 20 PIECE D'OR »
00c52  b0 32                mov al, 0x32
00c54  ba 14 00             mov dx, 0x14
loc_0c57:
00c57  bb b0 01             mov bx, 0x1b0
00c5a  8b b7 c1 5f          mov si, word ptr [bx + 0x5fc1]    ; textes
00c5e  81 c6 c1 5f          add si, 0x5fc1    ; textes
00c62  88 04                mov byte ptr [si], al
00c64  52                   push dx
00c65  bb e0 00             mov bx, 0xe0    ; message « VOUS RECEVEZ UNE PRIME / DE00 PIECE D'OR »
00c68  e8 82 7c             call affiche_message
00c6b  5a                   pop dx
00c6c  e9 97 5c             jmp ajoute_or

; ======== mort_chaos_poison   (appelée depuis 214b)
; prime de 30 et poison d'orc (type 18) : « LE GUERRIER DU CHAOS LACHE LE POISON DE L'ORC »
00c6f  e8 09 00             call prime_30
00c72  80 4d 0d 08          or byte ptr [di + 0xd], 8
00c76  be ea 00             mov si, 0xea
00c79  eb 14                jmp loc_0c8f

; ======== prime_30   (appelée depuis 0c6f, 214b)
; prime de 30 pièces (types 16, 17)
00c7b  b0 33                mov al, 0x33
00c7d  ba 1e 00             mov dx, 0x1e
00c80  eb d5                jmp loc_0c57

; ======== etoile_ouest   (appelée depuis 214b)
; « LE ZOMBI LACHE L'ETOILE DE L'OUEST »
00c82  ba c8 00             mov dx, 0xc8
00c85  e8 7e 5c             call ajoute_or
00c88  bb ec 00             mov bx, 0xec    ; message « LE ZOMBI LACHE / L'ETOILE DE L'OUEST. VOUS / RECEVEZ 200 PIECES D'OR »
00c8b  e8 5f 7c             call affiche_message
00c8e  c3                   ret
loc_0c8f:
00c8f  e9 c4 59             jmp loc_6656

; ======== image_par_table
; non appelée : BX = DS:34FE, puis fin de image_personnage (image d'un personnage par xlat)
00c92  bb fe 34             mov bx, 0x34fe
00c95  e9 b4 4a             jmp loc_574c

; ======== clic_attaque   (appelée depuis 0869)
; mode_attaque : au clic sur un monstre (DS:3FAC), attend le relâchement (attend_relache_boutons) et pose DS:3F9D ; sans clic, designe_case (0x0CF9)
00c98  f6 06 92 39 10       test byte ptr [0x3992], 0x10    ; commandes
00c9d  75 03                jne loc_0ca2
00c9f  eb 58                jmp loc_0cf9
; ---- 1 octets non atteints (0ca1-0ca1)
loc_0ca2:
00ca2  80 3e ac 3f 00       cmp byte ptr [0x3fac], 0    ; monstre_designe
00ca7  75 01                jne loc_0caa
00ca9  c3                   ret
loc_0caa:
00caa  e8 a7 2c             call attend_relache_boutons
00cad  c6 06 9d 3f 01       mov byte ptr [0x3f9d], 1    ; cible_validee
00cb2  c3                   ret

; ======== mode_regarder
; carte avec viseur : nomme ce qui est sous le curseur, jusqu'au bouton droit ou à un clic sur l'icône d'annulation
00cb3  c6 06 91 3f 01       mov byte ptr [0x3f91], 1    ; carte_cible
00cb8  e8 15 4a             call plateau_ciblage
loc_0cbb:
00cbb  e8 3e 57             call curseur_memorise
00cbe  e8 28 00             call designe_case
00cc1  e8 50 51             call curseur_dessine
00cc4  e8 1d 54             call affiche_tampon
00cc7  e8 0d 51             call curseur_efface
00cca  f6 06 92 39 20       test byte ptr [0x3992], 0x20    ; commandes
00ccf  74 03                je loc_0cd4
00cd1  e9 d6 05             jmp fin_action
loc_0cd4:
00cd4  be 37 43             mov si, 0x4337    ; zone_annuler_attaque
00cd7  f6 06 92 39 10       test byte ptr [0x3992], 0x10    ; commandes
00cdc  74 03                je loc_0ce1
00cde  e8 39 42             call zone_sous_curseur
loc_0ce1:
00ce1  83 fb 02             cmp bx, 2
00ce4  75 d5                jne loc_0cbb
00ce6  e9 c1 05             jmp fin_action

; ======== designe_case   (appelée depuis 0cbe, 2cfc)
; case de la carte sous le curseur (8 × 8 depuis (56, 16)), si vue (bit 0x40) : nom du monstre, du mobilier ou du héros ; DS:3F9D = 1 au clic
00ce9  e8 f9 56             call lit_commandes_al
00cec  f6 06 92 39 10       test byte ptr [0x3992], 0x10    ; commandes
00cf1  74 06                je loc_0cf9
00cf3  c6 06 9d 3f 01       mov byte ptr [0x3f9d], 1    ; cible_validee
00cf8  c3                   ret
loc_0cf9:
00cf9  c6 06 ac 3f 00       mov byte ptr [0x3fac], 0    ; monstre_designe
00cfe  c6 06 ad 3f 00       mov byte ptr [0x3fad], 0    ; case_vide_designee
00d03  c6 06 b5 3f ff       mov byte ptr [0x3fb5], 0xff    ; heros_designe
00d08  b9 08 00             mov cx, 8
00d0b  bd 58 00             mov bp, 0x58
00d0e  bf 38 dc             mov di, 0xdc38
00d11  e8 3a 55             call restaure_rect_es
00d14  be bd 5f             mov si, 0x5fbd
00d17  e8 9a 53             call affiche_texte_sans_fond
00d1a  be 37 43             mov si, 0x4337    ; zone_annuler_attaque
00d1d  e8 fa 41             call zone_sous_curseur
00d20  83 fb 02             cmp bx, 2
00d23  75 1f                jne loc_0d44
00d25  be 20 42             mov si, 0x4220
00d28  bf e0 e1             mov di, 0xe1e0
00d2b  a1 2d 5e             mov ax, word ptr [0x5e2d]    ; seg_odds
00d2e  a3 4e 37             mov word ptr [0x374e], ax    ; segment_source
00d31  50                   push ax
00d32  b8 63 14             mov ax, 0x1463
00d35  8e c0                mov es, ax
00d37  58                   pop ax
00d38  bd 10 00             mov bp, 0x10
00d3b  b9 10 00             mov cx, 0x10
00d3e  1e                   push ds
00d3f  e8 11 2e             call copie_image
00d42  1f                   pop ds
00d43  c3                   ret
loc_0d44:
00d44  be 20 36             mov si, 0x3620
00d47  bf e0 e1             mov di, 0xe1e0
00d4a  a1 2d 5e             mov ax, word ptr [0x5e2d]    ; seg_odds
00d4d  a3 4e 37             mov word ptr [0x374e], ax    ; segment_source
00d50  50                   push ax
00d51  b8 63 14             mov ax, 0x1463
00d54  8e c0                mov es, ax
00d56  58                   pop ax
00d57  bd 10 00             mov bp, 0x10
00d5a  b9 10 00             mov cx, 0x10
00d5d  1e                   push ds
00d5e  e8 f2 2d             call copie_image
00d61  1f                   pop ds
00d62  a0 e9 47             mov al, byte ptr [0x47e9]
00d65  3c 10                cmp al, 0x10
00d67  73 01                jae loc_0d6a
00d69  c3                   ret
loc_0d6a:
00d6a  2c 10                sub al, 0x10
00d6c  3c 98                cmp al, 0x98
00d6e  72 01                jb loc_0d71
00d70  c3                   ret
loc_0d71:
00d71  d0 e8                shr al, 1
00d73  d0 e8                shr al, 1
00d75  d0 e8                shr al, 1
00d77  a2 96 40             mov byte ptr [0x4096], al    ; ligne_curseur
00d7a  bb c5 5a             mov bx, 0x5ac5    ; lignes_grille
00d7d  e8 5b 53             call mot_table
00d80  a1 93 39             mov ax, word ptr [0x3993]    ; curseur_x
00d83  3d 38 00             cmp ax, 0x38
00d86  73 01                jae loc_0d89
00d88  c3                   ret
loc_0d89:
00d89  2d 38 00             sub ax, 0x38
00d8c  d1 e8                shr ax, 1
00d8e  d1 e8                shr ax, 1
00d90  d1 e8                shr ax, 1
00d92  3c 19                cmp al, 0x19
00d94  76 01                jbe loc_0d97
00d96  c3                   ret
loc_0d97:
00d97  a2 95 40             mov byte ptr [0x4095], al    ; colonne_curseur
00d9a  8a d8                mov bl, al
00d9c  32 ff                xor bh, bh
00d9e  03 da                add bx, dx
00da0  81 c3 6f 58          add bx, 0x586f    ; grille_occupants
00da4  89 1e d0 3f          mov word ptr [0x3fd0], bx    ; case_designee
00da8  f6 87 00 fc 40       test byte ptr [bx - 0x400], 0x40
00dad  75 03                jne loc_0db2
00daf  e9 80 00             jmp loc_0e32
loc_0db2:
00db2  8a 07                mov al, byte ptr [bx]
00db4  0a c0                or al, al
00db6  74 47                je loc_0dff
00db8  3c 32                cmp al, 0x32
00dba  72 04                jb loc_0dc0
00dbc  3c 38                cmp al, 0x38
00dbe  72 3f                jb loc_0dff
loc_0dc0:
00dc0  3c 30                cmp al, 0x30
00dc2  73 1d                jae loc_0de1
00dc4  a2 ac 3f             mov byte ptr [0x3fac], al    ; monstre_designe
00dc7  e8 76 00             call adresse_monstre
00dca  89 1e d4 3f          mov word ptr [0x3fd4], bx    ; cible
00dce  8a 47 08             mov al, byte ptr [bx + 8]
00dd1  3c 15                cmp al, 0x15
00dd3  75 01                jne loc_0dd6
00dd5  c3                   ret
loc_0dd6:
00dd6  bb 1e 49             mov bx, 0x491e    ; noms_monstres
00dd9  e8 ff 52             call mot_table
00ddc  8b f2                mov si, dx
00dde  e9 c8 52             jmp affiche_chaine_sans_fond
loc_0de1:
00de1  2c 30                sub al, 0x30
00de3  8a d8                mov bl, al
00de5  32 ff                xor bh, bh
00de7  81 c3 56 49          add bx, 0x4956    ; occupants_noms
00deb  8a 1f                mov bl, byte ptr [bx]
00ded  32 ff                xor bh, bh
00def  d1 e3                shl bx, 1
00df1  81 c3 a7 49          add bx, 0x49a7
00df5  8b 37                mov si, word ptr [bx]
00df7  0b f6                or si, si
00df9  75 01                jne loc_0dfc
00dfb  c3                   ret
loc_0dfc:
00dfc  e9 aa 52             jmp affiche_chaine_sans_fond
loc_0dff:
00dff  b9 05 00             mov cx, 5
00e02  be 63 46             mov si, 0x4663    ; fiches_personnages
00e05  bb 4b 43             mov bx, 0x434b    ; "UC_CiCsC}CBARBARIAN"
loc_0e08:
00e08  80 3c 00             cmp byte ptr [si], 0
00e0b  74 1d                je loc_0e2a
00e0d  8a 44 02             mov al, byte ptr [si + 2]
00e10  3a 06 96 40          cmp al, byte ptr [0x4096]    ; ligne_curseur
00e14  75 14                jne loc_0e2a
00e16  8a 44 01             mov al, byte ptr [si + 1]
00e19  3a 06 95 40          cmp al, byte ptr [0x4095]    ; colonne_curseur
00e1d  75 0b                jne loc_0e2a
00e1f  8a 44 19             mov al, byte ptr [si + 0x19]
00e22  a2 b5 3f             mov byte ptr [0x3fb5], al    ; heros_designe
00e25  8b 37                mov si, word ptr [bx]
00e27  e9 8a 52             jmp affiche_texte_sans_fond
loc_0e2a:
00e2a  83 c3 02             add bx, 2
00e2d  83 c6 1a             add si, 0x1a
00e30  e2 d6                loop loc_0e08
loc_0e32:
00e32  80 3e ae 3f 00       cmp byte ptr [0x3fae], 0    ; sort_en_cours
00e37  75 01                jne loc_0e3a
00e39  c3                   ret
loc_0e3a:
00e3a  c6 06 ad 3f 01       mov byte ptr [0x3fad], 1    ; case_vide_designee
00e3f  c3                   ret

; ======== adresse_monstre   (appelée depuis 0dc7, 13d5, 1c7b, 281f, 6de8, 9505)
; AL = numéro du monstre (1 à 32) -> BX = son enregistrement (table DS:4D08) ; la suite (0x0E4E) lance le sort choisi
00e40  fe c8                dec al
00e42  d0 e0                shl al, 1
00e44  32 e4                xor ah, ah
00e46  bb 08 4d             mov bx, 0x4d08    ; adresses_monstres
00e49  03 d8                add bx, ax
00e4b  8b 1f                mov bx, word ptr [bx]
00e4d  c3                   ret
sort_sur_monstre:    ; cible DS:3FD4 : sans effet sur le Sorcier-Roi (type +9 = 11 ou 12 ; 14 à partir de la quête code 15)
00e4e  c6 06 ca 3f 05       mov byte ptr [0x3fca], 5    ; heros_courant
00e53  8b 36 d4 3f          mov si, word ptr [0x3fd4]    ; cible
00e57  8a 44 09             mov al, byte ptr [si + 9]
00e5a  80 3e 92 3f 0f       cmp byte ptr [0x3f92], 0xf    ; numero_quete
00e5f  72 04                jb loc_0e65
00e61  3c 0e                cmp al, 0xe
00e63  eb 06                jmp loc_0e6b
loc_0e65:
00e65  fe c0                inc al
00e67  24 fe                and al, 0xfe
00e69  3c 0c                cmp al, 0xc
loc_0e6b:
00e6b  75 12                jne lance_sort
00e6d  c6 06 ae 3f 00       mov byte ptr [0x3fae], 0    ; sort_en_cours
00e72  c6 45 16 00          mov byte ptr [di + 0x16], 0
00e76  e9 f1 00             jmp loc_0f6a
sort_sur_heros:    ; AL = type du héros visé (DS:3FB5)
00e79  a2 ca 3f             mov byte ptr [0x3fca], al    ; heros_courant
00e7c  e8 00 4f             call fiche_personnage
lance_sort:    ; effet_sort_choisi, retire_sort, son_sort ; sauf sorts 6, 9 et 13, sur soi ou dans la même pièce, il faut voir la cible (ligne_de_vue)
00e7f  c6 06 ae 3f 00       mov byte ptr [0x3fae], 0    ; sort_en_cours
00e84  8b 3e 37 46          mov di, word ptr [0x4637]    ; fiche_heros_courant
00e88  8a 45 16             mov al, byte ptr [di + 0x16]
00e8b  50                   push ax
00e8c  fe c8                dec al
00e8e  bb 6f 5a             mov bx, 0x5a6f    ; effets_sorts
00e91  e8 47 52             call mot_table
00e94  89 16 97 40          mov word ptr [0x4097], dx    ; effet_sort_choisi
00e98  58                   pop ax
00e99  50                   push ax
00e9a  e8 e7 1e             call retire_sort
00e9d  e8 c4 1a             call son_sort
00ea0  58                   pop ax
00ea1  3c 06                cmp al, 6
00ea3  74 59                je loc_0efe
00ea5  3c 0d                cmp al, 0xd
00ea7  74 55                je loc_0efe
00ea9  3c 09                cmp al, 9
00eab  74 51                je loc_0efe
00ead  a0 ca 3f             mov al, byte ptr [0x3fca]    ; heros_courant
00eb0  3a 45 19             cmp al, byte ptr [di + 0x19]
00eb3  74 49                je loc_0efe
00eb5  e8 63 07             call adresse_case_perso
00eb8  3c 15                cmp al, 0x15
00eba  72 10                jb loc_0ecc
00ebc  8a e8                mov ch, al
00ebe  8b 1e d0 3f          mov bx, word ptr [0x3fd0]    ; case_designee
00ec2  8a 87 00 fc          mov al, byte ptr [bx - 0x400]
00ec6  24 3f                and al, 0x3f
00ec8  3a c5                cmp al, ch
00eca  74 32                je loc_0efe
loc_0ecc:
00ecc  80 3e ca 3f 05       cmp byte ptr [0x3fca], 5    ; heros_courant
00ed1  72 0f                jb loc_0ee2
00ed3  e8 68 02             call vue_cible
00ed6  80 3e a8 3f 00       cmp byte ptr [0x3fa8], 0    ; resultat_vise
00edb  74 03                je loc_0ee0
00edd  e9 8a 00             jmp loc_0f6a
loc_0ee0:
00ee0  eb 1c                jmp loc_0efe
loc_0ee2:
00ee2  a0 ca 3f             mov al, byte ptr [0x3fca]    ; heros_courant
00ee5  e8 97 4e             call fiche_personnage
00ee8  8a 7c 01             mov bh, byte ptr [si + 1]
00eeb  8a 5c 02             mov bl, byte ptr [si + 2]
00eee  e8 57 02             call ligne_de_vue
00ef1  bb 24 00             mov bx, 0x24
00ef4  80 3e a8 3f 00       cmp byte ptr [0x3fa8], 0    ; resultat_vise
00ef9  74 03                je loc_0efe
00efb  eb 70                jmp sort_message
; ---- 1 octets non atteints (0efd-0efd)
loc_0efe:
00efe  a0 ca 3f             mov al, byte ptr [0x3fca]    ; heros_courant
00f01  bb 97 40             mov bx, 0x4097
00f04  ff 27                jmp word ptr [bx]

; ======== sort_guerison
; 2 eau de guérison et 12 guérison du corps : +4 points de corps, sans dépasser DS:4394
00f06  8a 44 06             mov al, byte ptr [si + 6]
00f09  8a 1e ca 3f          mov bl, byte ptr [0x3fca]    ; heros_courant
00f0d  b7 00                mov bh, 0
00f0f  8a 44 06             mov al, byte ptr [si + 6]
00f12  04 04                add al, 4
00f14  3a 87 94 43          cmp al, byte ptr [bx + 0x4394]    ; corps_depart
00f18  76 04                jbe loc_0f1e
00f1a  8a 87 94 43          mov al, byte ptr [bx + 0x4394]    ; corps_depart
loc_0f1e:
00f1e  88 44 06             mov byte ptr [si + 6], al
00f21  bb 58 00             mov bx, 0x58
00f24  eb 47                jmp sort_message
; ---- 1 octets non atteints (0f26-0f26)

; ======== sort_vent
; 5 vent rapide : +0x18 bit 8, déplacement doublé au prochain tour
00f27  80 4c 18 08          or byte ptr [si + 0x18], 8
00f2b  bb 5c 00             mov bx, 0x5c
00f2e  eb 3d                jmp sort_message
; ---- 1 octets non atteints (0f30-0f30)

; ======== sort_courage
; 7 : +0x18 bit 0x10, deux dés d'attaque de plus
00f31  80 4c 18 10          or byte ptr [si + 0x18], 0x10
00f35  bb 8c 00             mov bx, 0x8c
00f38  eb 33                jmp sort_message
; ---- 1 octets non atteints (0f3a-0f3a)

; ======== sort_peau_pierre
; 11 : +0x18 bit 0x40, deux dés de défense de plus
00f3b  80 4c 18 40          or byte ptr [si + 0x18], 0x40
00f3f  bb 8e 00             mov bx, 0x8e
00f42  eb 29                jmp sort_message
; ---- 1 octets non atteints (0f44-0f44)

; ======== sort_tempete
; 4 : la cible passe son prochain tour (héros +0x18 bit 4, monstre +6 bit 2)
00f45  3c 05                cmp al, 5
00f47  75 03                jne loc_0f4c
00f49  eb 0b                jmp loc_0f56
; ---- 1 octets non atteints (0f4b-0f4b)
loc_0f4c:
00f4c  80 4c 18 04          or byte ptr [si + 0x18], 4
00f50  bb 5e 00             mov bx, 0x5e
00f53  eb 18                jmp sort_message
; ---- 1 octets non atteints (0f55-0f55)
loc_0f56:
00f56  8b 36 d4 3f          mov si, word ptr [0x3fd4]    ; cible
00f5a  80 4c 06 02          or byte ptr [si + 6], 2
00f5e  bb 62 00             mov bx, 0x62
00f61  eb 0a                jmp sort_message
; ---- 1 octets non atteints (0f63-0f63)
loc_0f64:
00f64  bb 78 00             mov bx, 0x78
00f67  eb 04                jmp sort_message
; ---- 1 octets non atteints (0f69-0f69)
loc_0f6a:
00f6a  bb 56 00             mov bx, 0x56    ; message « CE SORT N'A AUCUN / EFFET SUR UN ENNEMI. / IL A ETE GASPILLE »
sort_message:    ; affiche le message BX du sort, puis fin de l'action
00f6d  e8 7d 79             call affiche_message
00f70  e8 b1 01             call pause_250
00f73  e9 34 03             jmp fin_action

; ======== sort_boule_feu
; 8 : deux dés, 2 points de dégâts moins un par bouclier blanc
00f76  e8 3e 12             call de_combat
00f79  b2 00                mov dl, 0
00f7b  80 fb 01             cmp bl, 1
00f7e  75 02                jne loc_0f82
00f80  fe c2                inc dl
loc_0f82:
00f82  e8 32 12             call de_combat
00f85  80 fb 01             cmp bl, 1
00f88  75 02                jne loc_0f8c
00f8a  fe c2                inc dl
loc_0f8c:
00f8c  b0 02                mov al, 2
00f8e  2a c2                sub al, dl
00f90  74 1e                je loc_0fb0
00f92  80 3e ca 3f 05       cmp byte ptr [0x3fca], 5    ; heros_courant
00f97  75 03                jne loc_0f9c
00f99  e9 0e 01             jmp loc_10aa
loc_0f9c:
00f9c  8a 54 06             mov dl, byte ptr [si + 6]
00f9f  2a d0                sub dl, al
00fa1  73 03                jae loc_0fa6
00fa3  e9 2c 01             jmp loc_10d2
loc_0fa6:
00fa6  75 03                jne loc_0fab
00fa8  e9 27 01             jmp loc_10d2
loc_0fab:
00fab  88 54 06             mov byte ptr [si + 6], dl
00fae  eb b4                jmp loc_0f64
loc_0fb0:
00fb0  80 3e ca 3f 05       cmp byte ptr [0x3fca], 5    ; heros_courant
00fb5  75 ad                jne loc_0f64
00fb7  bb 72 00             mov bx, 0x72
00fba  eb b1                jmp sort_message

; ======== sort_feu_colere
; 9 : un dé, 1 point de dégât sauf bouclier blanc
00fbc  e8 f8 11             call de_combat
00fbf  80 fb 01             cmp bl, 1
00fc2  75 02                jne loc_0fc6
00fc4  eb ea                jmp loc_0fb0
loc_0fc6:
00fc6  80 3e ca 3f 05       cmp byte ptr [0x3fca], 5    ; heros_courant
00fcb  75 03                jne loc_0fd0
00fcd  e9 da 00             jmp loc_10aa
loc_0fd0:
00fd0  80 7c 06 01          cmp byte ptr [si + 6], 1
00fd4  75 03                jne loc_0fd9
00fd6  e9 f9 00             jmp loc_10d2
loc_0fd9:
00fd9  fe 4c 06             dec byte ptr [si + 6]
00fdc  bb 74 00             mov bx, 0x74
00fdf  eb 8c                jmp sort_message

; ======== sort_sommeil
; 3 : un dé ; sauf bouclier blanc, la cible s'endort (héros +0x18 bit 2, monstre +6 bit 4)
00fe1  e8 d3 11             call de_combat
00fe4  80 3e ca 3f 05       cmp byte ptr [0x3fca], 5    ; heros_courant
00fe9  75 03                jne loc_0fee
00feb  eb 16                jmp loc_1003
; ---- 1 octets non atteints (0fed-0fed)
loc_0fee:
00fee  80 fb 01             cmp bl, 1
00ff1  74 0a                je loc_0ffd
00ff3  80 4c 18 02          or byte ptr [si + 0x18], 2
00ff7  bb 64 00             mov bx, 0x64
00ffa  e9 70 ff             jmp sort_message
loc_0ffd:
00ffd  bb 6a 00             mov bx, 0x6a
01000  e9 6a ff             jmp sort_message
loc_1003:
01003  80 fb 01             cmp bl, 1
01006  74 0e                je loc_1016
01008  8b 36 d4 3f          mov si, word ptr [0x3fd4]    ; cible
0100c  80 4c 06 04          or byte ptr [si + 6], 4
01010  bb 68 00             mov bx, 0x68
01013  e9 57 ff             jmp sort_message
loc_1016:
01016  bb 6c 00             mov bx, 0x6c
01019  e9 51 ff             jmp sort_message

; ======== sort_brume
; 1 voile de brume : fiche +0x18 bit 1 (invisible aux monstres)
0101c  80 4c 18 01          or byte ptr [si + 0x18], 1
01020  bb 80 00             mov bx, 0x80
01023  e9 47 ff             jmp sort_message

; ======== sort_genie
; 6 génie : attaque à 5 dés de combat ; si la cible vaut 6, révèle la pièce (0x102d)
01026  a0 ca 3f             mov al, byte ptr [0x3fca]    ; heros_courant
01029  3c 06                cmp al, 6
0102b  75 35                jne loc_1062
sort_genie_revele:    ; 13 : révèle le contenu de la pièce (choix 0 du menu du génie)
0102d  8b 1e d0 3f          mov bx, word ptr [0x3fd0]    ; case_designee
01031  81 eb 00 02          sub bx, 0x200
01035  e8 c7 02             call revele_derriere_porte
01038  e8 15 0a             call dessine_carte
0103b  be 20 36             mov si, 0x3620
0103e  bf e0 e1             mov di, 0xe1e0
01041  a1 2d 5e             mov ax, word ptr [0x5e2d]    ; seg_odds
01044  a3 4e 37             mov word ptr [0x374e], ax    ; segment_source
01047  50                   push ax
01048  b8 63 14             mov ax, 0x1463
0104b  8e c0                mov es, ax
0104d  58                   pop ax
0104e  bd 10 00             mov bp, 0x10
01051  b9 10 00             mov cx, 0x10
01054  1e                   push ds
01055  e8 fb 2a             call copie_image
01058  1f                   pop ds
01059  e8 13 55             call sauve_tampon
0105c  e8 85 50             call affiche_tampon
0105f  e9 59 fc             jmp loc_0cbb
loc_1062:
01062  b6 05                mov dh, 5
01064  e8 25 4d             call compte_cranes
01067  80 3e ca 3f 05       cmp byte ptr [0x3fca], 5    ; heros_courant
0106c  8a 26 ca 3f          mov ah, byte ptr [0x3fca]    ; heros_courant
01070  72 0a                jb loc_107c
01072  0a c0                or al, al
01074  75 03                jne loc_1079
01076  e9 f1 fe             jmp loc_0f6a
loc_1079:
01079  eb 2f                jmp loc_10aa
; ---- 1 octets non atteints (107b-107b)
loc_107c:
0107c  28 54 06             sub byte ptr [si + 6], dl
0107f  75 03                jne loc_1084
01081  eb 4f                jmp loc_10d2
; ---- 1 octets non atteints (1083-1083)
loc_1084:
01084  72 4c                jb loc_10d2
01086  80 c2 30             add dl, 0x30
01089  bb 88 01             mov bx, 0x188
0108c  8b b7 c1 5f          mov si, word ptr [bx + 0x5fc1]    ; textes
01090  81 c6 c1 5f          add si, 0x5fc1    ; textes
01094  88 14                mov byte ptr [si], dl
01096  bb 8a 01             mov bx, 0x18a
01099  8b b7 c1 5f          mov si, word ptr [bx + 0x5fc1]    ; textes
0109d  81 c6 c1 5f          add si, 0x5fc1    ; textes
010a1  c6 04 30             mov byte ptr [si], 0x30
010a4  bb 54 00             mov bx, 0x54
010a7  e9 c3 fe             jmp sort_message
loc_10aa:
010aa  e8 73 10             call retire_monstre
010ad  bb 4e 00             mov bx, 0x4e
010b0  e9 ba fe             jmp sort_message

; ======== sort_traverse_roche
; 10 : +0x18 bit 0x20 (ou 0x80), passer à travers un mur au prochain déplacement
010b3  bb 5a 00             mov bx, 0x5a
010b6  80 3e a7 3f 03       cmp byte ptr [0x3fa7], 3    ; personnage_courant
010bb  75 0e                jne loc_10cb
010bd  a0 9b 3f             mov al, byte ptr [0x3f9b]    ; etat_action
010c0  a8 01                test al, 1
010c2  74 07                je loc_10cb
010c4  80 4c 18 80          or byte ptr [si + 0x18], 0x80
010c8  e9 a2 fe             jmp sort_message
loc_10cb:
010cb  80 4c 18 20          or byte ptr [si + 0x18], 0x20
010cf  e9 9b fe             jmp sort_message
loc_10d2:
010d2  e8 03 00             call mort_heros
010d5  e9 d2 01             jmp fin_action

; ======== mort_heros   (appelée depuis 10d2, 2c70, 6f95, 9749)
; fiche SI : points de corps, or, équipement et artefacts à zéro, sort de la quête ; « VOUS AVEZ ESSUYE DES BLESSURES MORTELLES »
010d8  c6 44 06 00          mov byte ptr [si + 6], 0
010dc  c6 04 00             mov byte ptr [si], 0
010df  c6 44 0e 00          mov byte ptr [si + 0xe], 0
010e3  c6 44 0f 00          mov byte ptr [si + 0xf], 0
010e7  c6 44 0d 00          mov byte ptr [si + 0xd], 0
010eb  c7 44 09 00 00       mov word ptr [si + 9], 0
010f0  c6 44 11 00          mov byte ptr [si + 0x11], 0
010f4  c6 44 12 00          mov byte ptr [si + 0x12], 0
010f8  c6 44 13 00          mov byte ptr [si + 0x13], 0
010fc  e8 e3 15             call heros_hors_quete
010ff  bb 20 00             mov bx, 0x20    ; message « VOUS AVEZ ESSUYE / DES BLESSURES MORTELLES. / VOUS AVEZ ECHOUE / DANS CETTE QUETE »
01102  e8 e8 77             call affiche_message
01105  e8 1d 07             call redessine_plateau
01108  a0 a7 3f             mov al, byte ptr [0x3fa7]    ; personnage_courant
0110b  3a 06 ca 3f          cmp al, byte ptr [0x3fca]    ; heros_courant
0110f  75 05                jne loc_1116
01111  c6 06 9a 3f 01       mov byte ptr [0x3f9a], 1    ; fin_du_tour
loc_1116:
01116  e8 9b f5             call quete_continue
01119  75 09                jne pause_250
0111b  bb 1e 00             mov bx, 0x1e    ; message « LES JOUEURS SONT TOUS ELIMINES »
0111e  e8 cc 77             call affiche_message
01121  e8 01 07             call redessine_plateau

; ======== pause_250   (appelée depuis 0f70)
; attente : temporise avec CX = 250 (boucle de 1000 tours par unité)
01124  b9 fa 00             mov cx, 0xfa
01127  e9 5d 35             jmp temporise

; ======== retire_or_mine
; non appelée : avant la quête code 15, retire l'or de la mine (+0x0F bit 0x20) de la fiche DI
0112a  80 3e 92 3f 0f       cmp byte ptr [0x3f92], 0xf    ; numero_quete
0112f  72 01                jb loc_1132
01131  c3                   ret
loc_1132:
01132  f6 45 0f 20          test byte ptr [di + 0xf], 0x20
01136  75 01                jne loc_1139
01138  c3                   ret
loc_1139:
01139  80 65 0f df          and byte ptr [di + 0xf], 0xdf
0113d  c3                   ret

; ======== vue_cible   (appelée depuis 0b1c, 0ed3)
; ligne_de_vue vers la case du monstre DS:3FD4
0113e  8b 36 d4 3f          mov si, word ptr [0x3fd4]    ; cible
01142  8a 7c 01             mov bh, byte ptr [si + 1]
01145  8a 5c 02             mov bl, byte ptr [si + 2]

; ======== ligne_de_vue   (appelée depuis 0eee)
; du héros courant à la case (BH x, BL y), une case à la fois sur l'axe le plus long ; resultat_vise = 0 libre, sinon coupée
01148  8b cb                mov cx, bx
0114a  8b 3e 37 46          mov di, word ptr [0x4637]    ; fiche_heros_courant
0114e  8a 75 01             mov dh, byte ptr [di + 1]
01151  8a 55 02             mov dl, byte ptr [di + 2]
01154  88 36 a5 3f          mov byte ptr [0x3fa5], dh    ; trace_x
01158  88 16 a6 3f          mov byte ptr [0x3fa6], dl    ; trace_y
0115c  c6 06 9f 3f 00       mov byte ptr [0x3f9f], 0    ; trace_erreur
01161  c6 06 a8 3f 00       mov byte ptr [0x3fa8], 0    ; resultat_vise
01166  b7 ff                mov bh, 0xff
01168  8a c6                mov al, dh
0116a  2a c5                sub al, ch
0116c  75 04                jne loc_1172
0116e  b7 00                mov bh, 0
01170  eb 06                jmp loc_1178
loc_1172:
01172  73 04                jae loc_1178
01174  f6 d8                neg al
01176  b7 01                mov bh, 1
loc_1178:
01178  a2 a1 3f             mov byte ptr [0x3fa1], al    ; trace_dx
0117b  8a e8                mov ch, al
0117d  b3 ff                mov bl, 0xff
0117f  8a c2                mov al, dl
01181  2a c1                sub al, cl
01183  75 04                jne loc_1189
01185  b3 00                mov bl, 0
01187  eb 06                jmp loc_118f
loc_1189:
01189  73 04                jae loc_118f
0118b  f6 d8                neg al
0118d  b3 01                mov bl, 1
loc_118f:
0118f  a2 a2 3f             mov byte ptr [0x3fa2], al    ; trace_dy
01192  3a c5                cmp al, ch
01194  72 40                jb loc_11d6
01196  8a cd                mov cl, ch
01198  8a e8                mov ch, al
0119a  8a d0                mov dl, al
loc_119c:
0119c  00 0e 9f 3f          add byte ptr [0x3f9f], cl    ; trace_erreur
011a0  38 16 9f 3f          cmp byte ptr [0x3f9f], dl    ; trace_erreur
011a4  72 08                jb loc_11ae
011a6  28 16 9f 3f          sub byte ptr [0x3f9f], dl    ; trace_erreur
011aa  00 3e a5 3f          add byte ptr [0x3fa5], bh    ; trace_x
loc_11ae:
011ae  00 1e a6 3f          add byte ptr [0x3fa6], bl    ; trace_y
011b2  c7 06 e9 37 00 00    mov word ptr [0x37e9], 0    ; erreur_fichier
011b8  88 2e eb 37          mov byte ptr [0x37eb], ch    ; position_tuile_carte
011bc  80 fd 01             cmp ch, 1
011bf  75 05                jne loc_11c6
011c1  80 fb ff             cmp bl, 0xff
011c4  74 03                je loc_11c9
loc_11c6:
011c6  e8 4b 00             call case_coupe_vue
loc_11c9:
011c9  80 3e a8 3f 00       cmp byte ptr [0x3fa8], 0    ; resultat_vise
011ce  74 01                je loc_11d1
011d0  c3                   ret
loc_11d1:
011d1  fe cd                dec ch
011d3  75 c7                jne loc_119c
011d5  c3                   ret
loc_11d6:
011d6  8a d0                mov dl, al
011d8  8a cd                mov cl, ch
011da  32 ed                xor ch, ch
loc_11dc:
011dc  00 16 9f 3f          add byte ptr [0x3f9f], dl    ; trace_erreur
011e0  38 0e 9f 3f          cmp byte ptr [0x3f9f], cl    ; trace_erreur
011e4  72 08                jb loc_11ee
011e6  28 0e 9f 3f          sub byte ptr [0x3f9f], cl    ; trace_erreur
011ea  00 1e a6 3f          add byte ptr [0x3fa6], bl    ; trace_y
loc_11ee:
011ee  00 3e a5 3f          add byte ptr [0x3fa5], bh    ; trace_x
011f2  c7 06 e9 37 01 00    mov word ptr [0x37e9], 1    ; erreur_fichier
011f8  88 0e eb 37          mov byte ptr [0x37eb], cl    ; position_tuile_carte
011fc  80 f9 01             cmp cl, 1
011ff  75 05                jne loc_1206
01201  80 ff ff             cmp bh, 0xff
01204  74 03                je loc_1209
loc_1206:
01206  e8 0b 00             call case_coupe_vue
loc_1209:
01209  80 3e a8 3f 00       cmp byte ptr [0x3fa8], 0    ; resultat_vise
0120e  74 01                je loc_1211
01210  c3                   ret
loc_1211:
01211  e2 c9                loop loc_11dc
01213  c3                   ret

; ======== case_coupe_vue   (appelée depuis 11c6, 1206)
; mur ou porte fermée (resultat_vise = 1), puis occupant (table DS:4946) ou personnage ; l'occupant de la dernière case n'est pas testé
01214  53                   push bx
01215  52                   push dx
01216  8a 36 a6 3f          mov dh, byte ptr [0x3fa6]    ; trace_y
0121a  8a 16 a5 3f          mov dl, byte ptr [0x3fa5]    ; trace_x
0121e  e8 5d 4e             call index_case
01221  80 bf 6f 56 00       cmp byte ptr [bx + 0x566f], 0
01226  74 2a                je loc_1252
01228  8a 87 6f 56          mov al, byte ptr [bx + 0x566f]
0122c  83 3e e9 37 01       cmp word ptr [0x37e9], 1    ; erreur_fichier
01231  74 11                je loc_1244
01233  24 ac                and al, 0xac
01235  0a c0                or al, al
01237  74 19                je loc_1252
01239  a8 20                test al, 0x20
0123b  74 42                je loc_127f
0123d  a8 04                test al, 4
0123f  74 3e                je loc_127f
01241  eb 0f                jmp loc_1252
; ---- 1 octets non atteints (1243-1243)
loc_1244:
01244  24 5c                and al, 0x5c
01246  0a c0                or al, al
01248  74 08                je loc_1252
0124a  a8 10                test al, 0x10
0124c  74 31                je loc_127f
0124e  a8 04                test al, 4
01250  74 2d                je loc_127f
loc_1252:
01252  80 3e eb 37 01       cmp byte ptr [0x37eb], 1    ; position_tuile_carte
01257  74 2b                je loc_1284
01259  80 bf 6f 58 00       cmp byte ptr [bx + 0x586f], 0    ; grille_occupants
0125e  74 0e                je loc_126e
01260  8a 87 6f 58          mov al, byte ptr [bx + 0x586f]    ; grille_occupants
01264  bb 46 49             mov bx, 0x4946    ; occupants_vue
01267  d7                   xlatb
01268  a2 a8 3f             mov byte ptr [0x3fa8], al    ; resultat_vise
0126b  eb 17                jmp loc_1284
; ---- 1 octets non atteints (126d-126d)
loc_126e:
0126e  8a 36 a6 3f          mov dh, byte ptr [0x3fa6]    ; trace_y
01272  8a 16 a5 3f          mov dl, byte ptr [0x3fa5]    ; trace_x
01276  e8 0e 00             call personnage_en_dx
01279  a2 a8 3f             mov byte ptr [0x3fa8], al    ; resultat_vise
0127c  eb 06                jmp loc_1284
; ---- 1 octets non atteints (127e-127e)
loc_127f:
0127f  c6 06 a8 3f 01       mov byte ptr [0x3fa8], 1    ; resultat_vise
loc_1284:
01284  5a                   pop dx
01285  5b                   pop bx
01286  c3                   ret

; ======== personnage_en_dx   (appelée depuis 1276, 48b0, 4978, 4a3f, 4b07, 4c24, 4dcc, 6874)
; AL = 1 si un personnage est sur la case DX
01287  51                   push cx
01288  57                   push di
01289  b9 05 00             mov cx, 5
0128c  bf 63 46             mov di, 0x4663    ; fiches_personnages
0128f  33 c0                xor ax, ax
loc_1291:
01291  80 3d 00             cmp byte ptr [di], 0
01294  74 0c                je loc_12a2
01296  38 55 01             cmp byte ptr [di + 1], dl
01299  75 07                jne loc_12a2
0129b  38 75 02             cmp byte ptr [di + 2], dh
0129e  75 02                jne loc_12a2
012a0  b0 01                mov al, 1
loc_12a2:
012a2  83 c7 1a             add di, 0x1a
012a5  e2 ea                loop loc_1291
012a7  5f                   pop di
012a8  59                   pop cx
012a9  c3                   ret
fin_action:    ; remet DS:3F9D, DS:3FE9, DS:3F91 à 0, redessine la vue et les icônes (état 0x0B)
012aa  c6 06 9d 3f 00       mov byte ptr [0x3f9d], 0    ; cible_validee
012af  c6 06 e9 3f 00       mov byte ptr [0x3fe9], 0    ; sans_sprites
012b4  c6 06 91 3f 00       mov byte ptr [0x3f91], 0    ; carte_cible
012b9  c7 06 f1 47 20 2c    mov word ptr [0x47f1], 0x2c20
012bf  e8 86 17             call son_clic
012c2  e8 5e 57             call fond_vers_tampon
012c5  e8 54 53             call affiche_nom_portrait
012c8  e8 f6 52             call init_sprites_icones
012cb  e8 87 f2             call affiche_zone_heros
012ce  e8 70 00             call place_personnages
012d1  e8 ac 53             call dessine_icones_fiche
012d4  bf 77 42             mov di, 0x4277    ; icones_panneau
012d7  b9 0c 00             mov cx, 0xc
loc_12da:
012da  c6 45 07 01          mov byte ptr [di + 7], 1
012de  80 7d 06 ff          cmp byte ptr [di + 6], 0xff
012e2  74 04                je loc_12e8
012e4  c6 45 06 0b          mov byte ptr [di + 6], 0xb
loc_12e8:
012e8  83 c7 0c             add di, 0xc
012eb  e2 ed                loop loc_12da
012ed  e8 44 3f             call dessine_icones
012f0  e8 7c 52             call sauve_tampon
012f3  e8 1e 45             call anime_sprites
012f6  e8 bf 44             call dessine_sprites
012f9  e8 58 26             call attend_relache_boutons
012fc  e9 e5 4d             jmp affiche_tampon

; ======== revele_derriere_porte   (appelée depuis 07ef, 080a, 1035, 703d, 72f8)
; BX = octet de murs de la case de l'autre côté : si elle est dans une zone, zone_heros = cette zone, revele_zone sans événement, cases marquées vues, vue_alignee, monstres révélés (0x6664)
012ff  81 eb 00 02          sub bx, 0x200
01303  8a 07                mov al, byte ptr [bx]
01305  24 3f                and al, 0x3f
01307  0a c0                or al, al
01309  75 01                jne loc_130c
0130b  c3                   ret
loc_130c:
0130c  a2 94 3f             mov byte ptr [0x3f94], al    ; zone_heros
0130f  8b 3e 37 46          mov di, word ptr [0x4637]    ; fiche_heros_courant
01313  bd 01 00             mov bp, 1
01316  e8 fb 01             call revele_zone
01319  bf d6 49             mov di, 0x49d6    ; ordre_cases_vue
0131c  b9 1e 00             mov cx, 0x1e
loc_131f:
0131f  51                   push cx
01320  53                   push bx
01321  57                   push di
01322  8a 15                mov dl, byte ptr [di]
01324  b6 00                mov dh, 0
01326  03 da                add bx, dx
01328  8a 07                mov al, byte ptr [bx]
0132a  24 3f                and al, 0x3f
0132c  3a 06 94 3f          cmp al, byte ptr [0x3f94]    ; zone_heros
01330  75 03                jne loc_1335
01332  e8 30 0a             call marque_case_vue
loc_1335:
01335  5f                   pop di
01336  5b                   pop bx
01337  59                   pop cx
01338  47                   inc di
01339  e2 e4                loop loc_131f
0133b  e8 c4 13             call vue_alignee
0133e  e9 23 53             jmp loc_6664

; ======== place_personnages   (appelée depuis 0551, 12ce, 1833)
; place_personnage pour les 4 héros (sprites DS:4BC6 + 23 × n) ; quête 2 (code 1) : Sir Ragnar aussi (DS:4CF1, segment SHOPSP)
01341  bf 63 46             mov di, 0x4663    ; fiches_personnages
01344  be c6 4b             mov si, 0x4bc6    ; sprites
01347  e8 2f 00             call place_personnage
0134a  bf 7d 46             mov di, 0x467d
0134d  be dd 4b             mov si, 0x4bdd
01350  e8 26 00             call place_personnage
01353  bf 97 46             mov di, 0x4697
01356  be f4 4b             mov si, 0x4bf4
01359  e8 1d 00             call place_personnage
0135c  bf b1 46             mov di, 0x46b1
0135f  be 0b 4c             mov si, 0x4c0b
01362  e8 14 00             call place_personnage
01365  80 3e 92 3f 01       cmp byte ptr [0x3f92], 1    ; numero_quete
0136a  74 01                je loc_136d
0136c  c3                   ret
loc_136d:
0136d  bf cb 46             mov di, 0x46cb
01370  be f1 4c             mov si, 0x4cf1
01373  a1 25 5e             mov ax, word ptr [0x5e25]    ; seg_shopsp
01376  89 44 08             mov word ptr [si + 8], ax

; ======== place_personnage   (appelée depuis 1347, 1350, 1359, 1362)
; fiche DI, sprite SI : zone (+3) et case dans la grille des murs (+4) ; si dans zone_heros, sprite sur sa case ; le héros courant qui marche prend l'image de sa direction (DS:40CC)
01379  80 3d 00             cmp byte ptr [di], 0
0137c  75 01                jne loc_137f
0137e  c3                   ret
loc_137f:
0137f  e8 99 02             call adresse_case_perso
01382  88 45 03             mov byte ptr [di + 3], al
01385  80 c7 02             add bh, 2
01388  89 5d 04             mov word ptr [di + 4], bx
0138b  3a 06 94 3f          cmp al, byte ptr [0x3f94]    ; zone_heros
0138f  74 01                je loc_1392
01391  c3                   ret
loc_1392:
01392  3b 3e 37 46          cmp di, word ptr [0x4637]    ; fiche_heros_courant
01396  75 1f                jne loc_13b7
01398  80 3e cc 40 ff       cmp byte ptr [0x40cc], 0xff    ; direction_pas
0139d  74 18                je loc_13b7
0139f  8a 1e cc 40          mov bl, byte ptr [0x40cc]    ; direction_pas
013a3  32 ff                xor bh, bh
013a5  d1 e3                shl bx, 1
013a7  8b 9f cd 40          mov bx, word ptr [bx + 0x40cd]    ; images_direction
013ab  a0 a7 3f             mov al, byte ptr [0x3fa7]    ; personnage_courant
013ae  32 e4                xor ah, ah
013b0  03 d8                add bx, ax
013b2  8a 07                mov al, byte ptr [bx]
013b4  88 45 08             mov byte ptr [di + 8], al
loc_13b7:
013b7  e8 7a 55             call rang_case_heros
013ba  8b df                mov bx, di
013bc  83 c3 08             add bx, 8
013bf  eb 23                jmp loc_13e4

; ======== sprite_occupant   (appelée depuis 0604)
; occupant de la case DS:3FDE + 0x200 : monstre (code < 0x30, image +8 dans MONSTERS) ou meuble (0x4B et plus, prepare_meuble) ; rien pour 0x30 à 0x4A
013c1  8b 1e de 3f          mov bx, word ptr [0x3fde]    ; case_dessinee
013c5  8a 87 00 02          mov al, byte ptr [bx + 0x200]
013c9  0a c0                or al, al
013cb  75 01                jne loc_13ce
013cd  c3                   ret
loc_13ce:
013ce  3c 30                cmp al, 0x30
013d0  72 03                jb loc_13d5
013d2  eb 30                jmp loc_1404
; ---- 1 octets non atteints (13d4-13d4)
loc_13d5:
013d5  e8 68 fa             call adresse_monstre
013d8  83 c3 08             add bx, 8
013db  e8 01 45             call sprite_libre
013de  a1 29 5e             mov ax, word ptr [0x5e29]    ; seg_monsters
013e1  89 44 08             mov word ptr [si + 8], ax
loc_13e4:
013e4  89 5c 12             mov word ptr [si + 0x12], bx
013e7  8a 07                mov al, byte ptr [bx]
013e9  c6 04 01             mov byte ptr [si], 1
013ec  e8 0d 01             call image_personnage_sprite
013ef  bb 00 78             mov bx, 0x7800

; ======== place_sprite_case   (appelée depuis 14d3)
; position du sprite SI sur la case index_case_courante (position_cases, ancré en bas, position_sprite_case) ; profondeur +1 = 3 × index + 1
013f2  e8 2b 02             call position_sprite_case
013f5  a0 93 3f             mov al, byte ptr [0x3f93]    ; index_case_courante
013f8  02 c0                add al, al
013fa  02 06 93 3f          add al, byte ptr [0x3f93]    ; index_case_courante
013fe  fe c0                inc al
01400  88 44 01             mov byte ptr [si + 1], al
01403  c3                   ret
loc_1404:
01404  3c 40                cmp al, 0x40
01406  73 01                jae loc_1409
01408  c3                   ret
loc_1409:
01409  3c 4b                cmp al, 0x4b
0140b  73 01                jae loc_140e
0140d  c3                   ret
loc_140e:
0140e  32 e4                xor ah, ah
01410  50                   push ax

; ======== prepare_meuble
; sprite d'un meuble : (code - 0x4B) * 6 + DS:43FC
01411  2c 4b                sub al, 0x4b
01413  8a d8                mov bl, al
01415  b7 00                mov bh, 0
01417  03 db                add bx, bx
01419  8b d3                mov dx, bx
0141b  03 db                add bx, bx
0141d  03 da                add bx, dx
0141f  81 c3 fc 43          add bx, 0x43fc    ; meubles
01423  e8 b9 44             call sprite_libre
01426  c6 04 01             mov byte ptr [si], 1
01429  8b 07                mov ax, word ptr [bx]
0142b  88 64 07             mov byte ptr [si + 7], ah
0142e  88 44 06             mov byte ptr [si + 6], al
01431  58                   pop ax
01432  9c                   pushf
01433  50                   push ax
01434  53                   push bx
01435  51                   push cx
01436  52                   push dx
01437  57                   push di
01438  56                   push si
01439  55                   push bp
0143a  06                   push es
0143b  1e                   push ds
0143c  bf 5c 0e             mov di, 0xe5c
0143f  83 3e 58 0e 00       cmp word ptr [0xe58], 0    ; meuble_cache
01444  75 06                jne loc_144c
01446  a3 58 0e             mov word ptr [0xe58], ax    ; meuble_cache
01449  eb 18                jmp loc_1463
; ---- 1 octets non atteints (144b-144b)
loc_144c:
0144c  39 06 58 0e          cmp word ptr [0xe58], ax    ; meuble_cache
01450  75 03                jne loc_1455
01452  eb 62                jmp loc_14b6
; ---- 1 octets non atteints (1454-1454)
loc_1455:
01455  bf f0 1f             mov di, 0x1ff0
01458  39 06 5a 0e          cmp word ptr [0xe5a], ax    ; meuble_cache_2
0145c  74 58                je loc_14b6
0145e  83 3e 5a 0e 00       cmp word ptr [0xe5a], 0    ; meuble_cache_2
loc_1463:
01463  8b 47 04             mov ax, word ptr [bx + 4]
01466  50                   push ax
01467  57                   push di
01468  56                   push si
01469  1e                   push ds
0146a  50                   push ax
0146b  a1 35 5e             mov ax, word ptr [0x5e35]    ; seg_furn
0146e  8e c0                mov es, ax
01470  58                   pop ax
01471  50                   push ax
01472  a1 2f 5e             mov ax, word ptr [0x5e2f]    ; seg_furn_brut
01475  8e d8                mov ds, ax
01477  58                   pop ax
01478  33 ff                xor di, di
0147a  8b f7                mov si, di
0147c  b9 ff ff             mov cx, 0xffff
0147f  e8 4f 31             call lz_decompresse
01482  1f                   pop ds
01483  5e                   pop si
01484  5f                   pop di
01485  58                   pop ax
01486  57                   push di
01487  56                   push si
01488  50                   push ax
01489  8a 44 07             mov al, byte ptr [si + 7]
0148c  8a 4c 06             mov cl, byte ptr [si + 6]
0148f  f6 e1                mul cl
01491  8b c8                mov cx, ax
01493  5e                   pop si
01494  83 3e 90 31 08       cmp word ptr [0x3190], 8    ; mode_video
01499  74 02                je loc_149d
0149b  d1 ee                shr si, 1
loc_149d:
0149d  50                   push ax
0149e  a1 35 5e             mov ax, word ptr [0x5e35]    ; seg_furn
014a1  8e d8                mov ds, ax
014a3  58                   pop ax
014a4  50                   push ax
014a5  b8 7c 09             mov ax, 0x97c
014a8  8e c0                mov es, ax
014aa  58                   pop ax
014ab  f3 a4                rep movsb byte ptr es:[di], byte ptr [si]
014ad  50                   push ax
014ae  b8 7c 09             mov ax, 0x97c
014b1  8e d8                mov ds, ax
014b3  58                   pop ax
014b4  5e                   pop si
014b5  5f                   pop di
loc_14b6:
014b6  83 3e 90 31 08       cmp word ptr [0x3190], 8    ; mode_video
014bb  74 02                je loc_14bf
014bd  d1 e7                shl di, 1
loc_14bf:
014bf  89 7c 0c             mov word ptr [si + 0xc], di
014c2  b8 7c 09             mov ax, 0x97c
014c5  89 44 08             mov word ptr [si + 8], ax
014c8  1f                   pop ds
014c9  07                   pop es
014ca  5d                   pop bp
014cb  5e                   pop si
014cc  5f                   pop di
014cd  5a                   pop dx
014ce  59                   pop cx
014cf  5b                   pop bx
014d0  58                   pop ax
014d1  9d                   popf
014d2  53                   push bx
014d3  e8 1c ff             call place_sprite_case
014d6  5b                   pop bx
014d7  8a 44 04             mov al, byte ptr [si + 4]
014da  8a 4c 02             mov cl, byte ptr [si + 2]
014dd  02 47 02             add al, byte ptr [bx + 2]
014e0  02 4f 03             add cl, byte ptr [bx + 3]
014e3  88 44 04             mov byte ptr [si + 4], al
014e6  88 4c 02             mov byte ptr [si + 2], cl
014e9  8a d9                mov bl, cl
014eb  32 e4                xor ah, ah
014ed  8a fc                mov bh, ah
014ef  e8 82 1c             call ligne_ecran
014f2  88 44 16             mov byte ptr [si + 0x16], al
014f5  89 5c 10             mov word ptr [si + 0x10], bx
014f8  e8 3d 43             call anime_sprite
014fb  c3                   ret

; ======== image_personnage_sprite   (appelée depuis 13ec)
; sprite SI : largeur, hauteur (+6) et position (+0x0C) de l'image AL (images_personnages)
014fc  8a d8                mov bl, al
014fe  32 ff                xor bh, bh
01500  03 db                add bx, bx
01502  03 db                add bx, bx
01504  81 c3 38 4f          add bx, 0x4f38    ; images_personnages
01508  8b 07                mov ax, word ptr [bx]
0150a  89 44 06             mov word ptr [si + 6], ax
0150d  8b 47 02             mov ax, word ptr [bx + 2]
01510  89 44 0c             mov word ptr [si + 0xc], ax
01513  c3                   ret

; ======== revele_zone   (appelée depuis 0565, 05d1, 1316, 6da9, 721d)
; première révélation d'une zone (table DS:53C3) : drapeaux propres aux quêtes 2, 6, 7, 10, 12, 16
01514  8a d8                mov bl, al
01516  b7 00                mov bh, 0
01518  03 db                add bx, bx
0151a  03 db                add bx, bx
0151c  81 c3 c3 53          add bx, 0x53c3    ; zones_revelees
01520  8a d0                mov dl, al
01522  8b 0f                mov cx, word ptr [bx]
01524  89 0e e0 3f          mov word ptr [0x3fe0], cx    ; coin_zone
01528  83 fd 01             cmp bp, 1
0152b  75 03                jne loc_1530
0152d  e9 cd 00             jmp loc_15fd
loc_1530:
01530  80 7f 03 00          cmp byte ptr [bx + 3], 0
01534  74 03                je loc_1539
01536  e9 c4 00             jmp loc_15fd
loc_1539:
01539  80 3e 92 3f 01       cmp byte ptr [0x3f92], 1    ; numero_quete
0153e  75 03                jne loc_1543
01540  e9 82 00             jmp loc_15c5
loc_1543:
01543  80 3e 92 3f 05       cmp byte ptr [0x3f92], 5    ; numero_quete
01548  74 5b                je loc_15a5
0154a  80 3e 92 3f 09       cmp byte ptr [0x3f92], 9    ; numero_quete
0154f  74 28                je loc_1579
01551  80 3e 92 3f 06       cmp byte ptr [0x3f92], 6    ; numero_quete
01556  74 34                je loc_158c
01558  80 3e 92 3f 0f       cmp byte ptr [0x3f92], 0xf    ; numero_quete
0155d  74 52                je loc_15b1
0155f  80 3e 92 3f 0b       cmp byte ptr [0x3f92], 0xb    ; numero_quete
01564  74 03                je loc_1569
01566  e9 8e 00             jmp loc_15f7
loc_1569:
01569  80 fa 1f             cmp dl, 0x1f
0156c  74 03                je loc_1571
0156e  e9 86 00             jmp loc_15f7
loc_1571:
01571  c6 06 c0 3f 01       mov byte ptr [0x3fc0], 1    ; evenement_b
01576  e9 82 00             jmp loc_15fb
loc_1579:
01579  80 fa 18             cmp dl, 0x18
0157c  75 79                jne loc_15f7
0157e  80 3e c0 3f 01       cmp byte ptr [0x3fc0], 1    ; evenement_b
01583  74 72                je loc_15f7
01585  c6 06 c0 3f 02       mov byte ptr [0x3fc0], 2    ; evenement_b
0158a  eb 6f                jmp loc_15fb
loc_158c:
0158c  80 fa 19             cmp dl, 0x19
0158f  75 66                jne loc_15f7
01591  80 3e c0 3f ff       cmp byte ptr [0x3fc0], 0xff    ; evenement_b
01596  75 5f                jne loc_15f7
01598  a0 a7 3f             mov al, byte ptr [0x3fa7]    ; personnage_courant
0159b  a2 c0 3f             mov byte ptr [0x3fc0], al    ; evenement_b
0159e  80 0e c0 3f 80       or byte ptr [0x3fc0], 0x80    ; evenement_b
015a3  eb 56                jmp loc_15fb
loc_15a5:
015a5  80 fa 1d             cmp dl, 0x1d
015a8  75 4d                jne loc_15f7
015aa  c6 06 c0 3f 01       mov byte ptr [0x3fc0], 1    ; evenement_b
015af  eb 4a                jmp loc_15fb
loc_15b1:
015b1  80 fa 1f             cmp dl, 0x1f
015b4  75 41                jne loc_15f7
015b6  80 3e bf 3f 00       cmp byte ptr [0x3fbf], 0    ; evenement_a
015bb  75 05                jne loc_15c2
015bd  c6 06 bf 3f 81       mov byte ptr [0x3fbf], 0x81    ; evenement_a
loc_15c2:
015c2  eb 33                jmp loc_15f7
; ---- 1 octets non atteints (15c4-15c4)
loc_15c5:
015c5  80 fa 16             cmp dl, 0x16
015c8  75 2d                jne loc_15f7
015ca  c6 06 cb 46 01       mov byte ptr [0x46cb], 1
015cf  a0 a7 3f             mov al, byte ptr [0x3fa7]    ; personnage_courant
015d2  a2 bf 3f             mov byte ptr [0x3fbf], al    ; evenement_a
015d5  80 0e bf 3f 80       or byte ptr [0x3fbf], 0x80    ; evenement_a
015da  53                   push bx
015db  51                   push cx
015dc  bb 6f 54             mov bx, 0x546f    ; grille_zones
015df  b9 00 02             mov cx, 0x200
loc_15e2:
015e2  80 0f c0             or byte ptr [bx], 0xc0
015e5  43                   inc bx
015e6  e2 fa                loop loc_15e2
015e8  bb 4a 4d             mov bx, 0x4d4a    ; monstres
015eb  b1 20                mov cl, 0x20
loc_15ed:
015ed  80 37 80             xor byte ptr [bx], 0x80
015f0  83 c3 0a             add bx, 0xa
015f3  e2 f8                loop loc_15ed
015f5  59                   pop cx
015f6  5b                   pop bx
loc_15f7:
015f7  c6 47 03 ff          mov byte ptr [bx + 3], 0xff
loc_15fb:
015fb  32 c0                xor al, al
loc_15fd:
015fd  f6 d0                not al
015ff  a2 9e 3f             mov byte ptr [0x3f9e], al    ; zone_nouvelle

; ======== adresse_case   (appelée depuis 2744, 4c3f, 4c7c, 4d1e, 6fe3, 7098, 948f, 979b)
; BX = adresse de la case (CL = x, CH = y) dans grille_zones (lignes DS:5AC5), AL = sa zone (bits 0-5) ; revele_zone y aboutit avec le coin de la zone
01602  8a dd                mov bl, ch
01604  b7 00                mov bh, 0
01606  03 db                add bx, bx
01608  8b 87 c5 5a          mov ax, word ptr [bx + 0x5ac5]    ; lignes_grille
0160c  8b d8                mov bx, ax
0160e  b5 00                mov ch, 0
01610  03 d9                add bx, cx
01612  81 c3 6f 54          add bx, 0x546f    ; grille_zones
01616  8a 07                mov al, byte ptr [bx]
01618  24 3f                and al, 0x3f
0161a  c3                   ret

; ======== adresse_case_perso   (appelée depuis 02ff, 0314, 0329, 033f, 0559, 07c5, 0eb5, 137f)
; même chose pour la case du personnage DI (+1 x, +2 y)
0161b  8b 4d 01             mov cx, word ptr [di + 1]
0161e  eb e2                jmp adresse_case

; ======== position_sprite_case   (appelée depuis 13f2)
; sprite SI sur la case index_case_courante (position_cases) : y = y case + 18 - hauteur, x = x case + 26 - largeur ; position écran en +0x10
01620  8a 1e 93 3f          mov bl, byte ptr [0x3f93]    ; index_case_courante
01624  02 db                add bl, bl
01626  02 db                add bl, bl
01628  b7 00                mov bh, 0
0162a  81 c3 19 41          add bx, 0x4119    ; position_cases
0162e  8b 07                mov ax, word ptr [bx]
01630  04 12                add al, 0x12
01632  2a 44 07             sub al, byte ptr [si + 7]
01635  88 44 04             mov byte ptr [si + 4], al
01638  8b 5f 02             mov bx, word ptr [bx + 2]
0163b  80 c3 1a             add bl, 0x1a
0163e  2a 5c 06             sub bl, byte ptr [si + 6]
01641  88 5c 02             mov byte ptr [si + 2], bl
01644  32 ff                xor bh, bh
01646  8a e7                mov ah, bh
01648  e8 29 1b             call ligne_ecran
0164b  88 44 16             mov byte ptr [si + 0x16], al
0164e  89 5c 10             mov word ptr [si + 0x10], bx
01651  c3                   ret

; ======== sprite_porte_case
; non appelée : sprite 24 × 44 de GRAPHICS (source DX) sur la case courante, décalage (CH, CL) et ordre AL écrits dans son propre code ; doublon de sprite_porte
01652  53                   push bx
01653  2e a2 9f 16          mov byte ptr cs:[0x169f], al
01657  2e 88 2e 75 16       mov byte ptr cs:[0x1675], ch
0165c  2e 88 0e 7e 16       mov byte ptr cs:[0x167e], cl
01661  c6 04 01             mov byte ptr [si], 1
01664  8a 1e 93 3f          mov bl, byte ptr [0x3f93]    ; index_case_courante
01668  02 db                add bl, bl
0166a  02 db                add bl, bl
0166c  b7 00                mov bh, 0
0166e  81 c3 19 41          add bx, 0x4119    ; position_cases
01672  8b 07                mov ax, word ptr [bx]
01674  05 00 00             add ax, 0
01677  89 44 04             mov word ptr [si + 4], ax
0167a  8b 47 02             mov ax, word ptr [bx + 2]
0167d  05 00 00             add ax, 0
01680  89 44 02             mov word ptr [si + 2], ax
01683  c6 44 06 18          mov byte ptr [si + 6], 0x18
01687  c6 44 07 2c          mov byte ptr [si + 7], 0x2c
0168b  89 54 0c             mov word ptr [si + 0xc], dx
0168e  8b 16 2b 5e          mov dx, word ptr [0x5e2b]    ; seg_graphics
01692  89 54 08             mov word ptr [si + 8], dx
01695  a0 93 3f             mov al, byte ptr [0x3f93]    ; index_case_courante
01698  02 c0                add al, al
0169a  02 06 93 3f          add al, byte ptr [0x3f93]    ; index_case_courante
0169e  04 00                add al, 0
016a0  88 44 01             mov byte ptr [si + 1], al
016a3  5b                   pop bx
016a4  c3                   ret
portes_avant_case:    ; portes du côté droit ([+1] bit 0x10) et du bas ([+0x1A] bit 0x20) de la case, en sprites (sprite_porte), devant les personnages ; porte secrète non trouvée (bits 0x0C = 8) omise
016a5  8b 1e de 3f          mov bx, word ptr [0x3fde]    ; case_dessinee
016a9  f6 47 01 10          test byte ptr [bx + 1], 0x10
016ad  74 18                je loc_16c7
016af  8a 47 01             mov al, byte ptr [bx + 1]
016b2  24 0c                and al, 0xc
016b4  3c 08                cmp al, 8
016b6  75 01                jne loc_16b9
016b8  c3                   ret
loc_16b9:
016b9  8a 47 01             mov al, byte ptr [bx + 1]
016bc  24 1c                and al, 0x1c
016be  0c 20                or al, 0x20
016c0  e8 9a ef             call sprite_porte
016c3  80 44 01 02          add byte ptr [si + 1], 2
loc_16c7:
016c7  8b 1e de 3f          mov bx, word ptr [0x3fde]    ; case_dessinee
016cb  81 fb 55 58          cmp bx, 0x5855
016cf  72 01                jb loc_16d2
016d1  c3                   ret
loc_16d2:
016d2  f6 47 1a 20          test byte ptr [bx + 0x1a], 0x20
016d6  75 01                jne loc_16d9
016d8  c3                   ret
loc_16d9:
016d9  8a 47 1a             mov al, byte ptr [bx + 0x1a]
016dc  24 0c                and al, 0xc
016de  3c 08                cmp al, 8
016e0  75 01                jne loc_16e3
016e2  c3                   ret
loc_16e3:
016e3  8a 47 1a             mov al, byte ptr [bx + 0x1a]
016e6  24 1c                and al, 0x1c
016e8  0c 20                or al, 0x20
016ea  e8 70 ef             call sprite_porte
016ed  80 44 01 02          add byte ptr [si + 1], 2
016f1  c3                   ret
murs_case:    ; murs et portes du haut (0x80, 0x20) et de gauche (0x40, 0x10) de la case courante, copiés dans le tampon ; images de portes DS:4A31 (haut), DS:4A41 (gauche) ; porte secrète non trouvée dessinée en mur
016f2  8b 1e de 3f          mov bx, word ptr [0x3fde]    ; case_dessinee
016f6  f6 07 80             test byte ptr [bx], 0x80
016f9  75 05                jne loc_1700
016fb  f6 07 20             test byte ptr [bx], 0x20
016fe  74 09                je loc_1709
loc_1700:
01700  e8 9f 00             call source_mur_haut
01703  b9 34 00             mov cx, 0x34
01706  e8 73 00             call copie_mur_haut
loc_1709:
01709  8b 1e de 3f          mov bx, word ptr [0x3fde]    ; case_dessinee
0170d  f6 07 40             test byte ptr [bx], 0x40
01710  75 05                jne loc_1717
01712  f6 07 10             test byte ptr [bx], 0x10
01715  74 09                je loc_1720
loc_1717:
01717  e8 83 00             call source_mur_gauche
0171a  b9 34 00             mov cx, 0x34
0171d  e8 56 00             call copie_mur_gauche
loc_1720:
01720  8b 1e de 3f          mov bx, word ptr [0x3fde]    ; case_dessinee
01724  f6 07 20             test byte ptr [bx], 0x20
01727  74 28                je loc_1751
01729  8a 07                mov al, byte ptr [bx]
0172b  24 0c                and al, 0xc
0172d  3c 08                cmp al, 8
0172f  75 09                jne loc_173a
01731  e8 6e 00             call source_mur_haut
01734  b9 34 00             mov cx, 0x34
01737  eb 43                jmp copie_mur_haut
; ---- 1 octets non atteints (1739-1739)
loc_173a:
0173a  bb 31 4a             mov bx, 0x4a31    ; images_portes_haut
0173d  e8 9d 49             call mot_table_octets
01740  b9 2c 00             mov cx, 0x2c
01743  bf 98 d5             mov di, 0xd598
01746  3c 0c                cmp al, 0xc
01748  75 04                jne loc_174e
0174a  81 c7 40 01          add di, 0x140
loc_174e:
0174e  eb 2f                jmp loc_177f
; ---- 1 octets non atteints (1750-1750)
loc_1751:
01751  f6 07 10             test byte ptr [bx], 0x10
01754  75 01                jne loc_1757
01756  c3                   ret
loc_1757:
01757  8a 07                mov al, byte ptr [bx]
01759  24 0c                and al, 0xc
0175b  3c 08                cmp al, 8
0175d  75 08                jne loc_1767
0175f  e8 3b 00             call source_mur_gauche
01762  b9 34 00             mov cx, 0x34
01765  eb 0f                jmp copie_mur_gauche
loc_1767:
01767  bb 41 4a             mov bx, 0x4a41    ; images_portes_gauche
0176a  e8 70 49             call mot_table_octets
0176d  b9 2c 00             mov cx, 0x2c
01770  bf c0 d6             mov di, 0xd6c0
01773  eb 0a                jmp loc_177f
; ---- 1 octets non atteints (1775-1775)

; ======== copie_mur_gauche   (appelée depuis 171d)
; image DX (24 × CX) en (x, y - 39) de la case (DS:3FE2), dans le tampon
01776  bf 40 cf             mov di, 0xcf40
01779  eb 04                jmp loc_177f
; ---- 1 octets non atteints (177b-177b)

; ======== copie_mur_haut   (appelée depuis 1706)
; image DX (24 × CX) en (x + 24, y - 40) de la case
0177c  bf 18 ce             mov di, 0xce18
loc_177f:
0177f  03 3e e2 3f          add di, word ptr [0x3fe2]    ; ecran_case_courante
01783  56                   push si
01784  1e                   push ds
01785  8b f2                mov si, dx
01787  bd 18 00             mov bp, 0x18
0178a  a1 2b 5e             mov ax, word ptr [0x5e2b]    ; seg_graphics
0178d  a3 4e 37             mov word ptr [0x374e], ax    ; segment_source
01790  50                   push ax
01791  b8 63 14             mov ax, 0x1463
01794  8e c0                mov es, ax
01796  58                   pop ax
01797  e8 b9 23             call copie_image
0179a  1f                   pop ds
0179b  5e                   pop si
0179c  c3                   ret

; ======== source_mur_gauche   (appelée depuis 1717, 175f)
; DX = mur gauche « / » (table DS:447A : 0x7E00, 0x82E0), variante selon la case
0179d  ba 7a 44             mov dx, 0x447a    ; murs_gauches
017a0  eb 03                jmp source_mur

; ======== source_mur_haut   (appelée depuis 1700, 1731)
; DX = mur haut « \ » (table DS:447E : 0x87C0, 0x8CA0), variante selon la case
017a2  ba 7e 44             mov dx, 0x447e    ; murs_hauts

; ======== source_mur
; source d'un mur selon l'orientation
017a5  8a 1e 93 3f          mov bl, byte ptr [0x3f93]    ; index_case_courante
017a9  32 ff                xor bh, bh
017ab  8a 9f 82 44          mov bl, byte ptr [bx + 0x4482]    ; variante_mur
017af  32 ff                xor bh, bh
017b1  03 db                add bx, bx
017b3  03 da                add bx, dx
017b5  8b 17                mov dx, word ptr [bx]
017b7  43                   inc bx
017b8  c3                   ret

; ======== dessine_sol_case   (appelée depuis 05fe)
; dalle de la zone du héros (sols_zones), ou sol spécial du code 0x30 à 0x3B (sols_speciaux, sauf FFFFh), puis copie_sol
017b9  8a 1e 94 3f          mov bl, byte ptr [0x3f94]    ; zone_heros
017bd  32 ff                xor bh, bh
017bf  d1 e3                shl bx, 1
017c1  8b 97 43 a5          mov dx, word ptr [bx - 0x5abd]
017c5  8b 1e de 3f          mov bx, word ptr [0x3fde]    ; case_dessinee
017c9  8a 87 00 02          mov al, byte ptr [bx + 0x200]
017cd  3c 30                cmp al, 0x30
017cf  8a 26 6f 58          mov ah, byte ptr [0x586f]    ; grille_occupants
017d3  72 15                jb copie_sol
017d5  3c 3c                cmp al, 0x3c
017d7  73 11                jae copie_sol
017d9  8a d8                mov bl, al
017db  02 db                add bl, bl
017dd  32 ff                xor bh, bh
017df  83 bf d0 50 ff       cmp word ptr [bx + 0x50d0], -1    ; sols_speciaux
017e4  74 04                je copie_sol
017e6  8b 97 d0 50          mov dx, word ptr [bx + 0x50d0]    ; sols_speciaux

; ======== copie_sol   (appelée depuis 5d6c, 5d75)
; dalle DX (48 × 24, GRAPHICS) sur la case index_case_courante ; position écran gardée en DS:3FE2
017ea  8a 1e 93 3f          mov bl, byte ptr [0x3f93]    ; index_case_courante
017ee  02 db                add bl, bl
017f0  02 db                add bl, bl
017f2  b7 00                mov bh, 0
017f4  81 c3 19 41          add bx, 0x4119    ; position_cases
017f8  8b 07                mov ax, word ptr [bx]
017fa  8b 5f 02             mov bx, word ptr [bx + 2]
017fd  52                   push dx
017fe  e8 73 19             call ligne_ecran
01801  5a                   pop dx
01802  89 1e e2 3f          mov word ptr [0x3fe2], bx    ; ecran_case_courante
01806  57                   push di
01807  1e                   push ds
01808  8b fb                mov di, bx
0180a  8b f2                mov si, dx
0180c  bd 30 00             mov bp, 0x30
0180f  b9 18 00             mov cx, 0x18
01812  a1 2b 5e             mov ax, word ptr [0x5e2b]    ; seg_graphics
01815  a3 4e 37             mov word ptr [0x374e], ax    ; segment_source
01818  50                   push ax
01819  b8 63 14             mov ax, 0x1463
0181c  8e c0                mov es, ax
0181e  58                   pop ax
0181f  e8 31 23             call copie_image
01822  1f                   pop ds
01823  5f                   pop di
01824  c3                   ret

; ======== redessine_plateau   (appelée depuis 03f5, 06f9, 0746, 1105, 1121, 193d, 194d, 1959)
; vide les sprites, fond, zone du héros (affiche_zone_heros), personnages, portrait, icônes ; sprites_figes = 1 à la fin
01825  c6 06 99 3f 00       mov byte ptr [0x3f99], 0    ; sprites_figes
0182a  e8 94 4d             call init_sprites_icones
0182d  e8 f3 51             call fond_vers_tampon
01830  e8 22 ed             call affiche_zone_heros
01833  e8 0b fb             call place_personnages
01836  e8 e3 4d             call affiche_nom_portrait
01839  e8 44 4e             call dessine_icones_fiche
0183c  e8 3a 3f             call ordonne_sprites
0183f  e8 d2 3f             call anime_sprites
01842  e8 73 3f             call dessine_sprites
01845  e8 ec 39             call dessine_icones
01848  c6 06 99 3f 01       mov byte ptr [0x3f99], 1    ; sprites_figes
0184d  c3                   ret

; ======== fin_quete   (appelée depuis 045f)
; héros sur l'escalier (codes 0x38 à 0x3B) : il sort de la quête ; routine de fin de la quête (fins_quetes)
0184e  8b 3e 39 46          mov di, word ptr [0x4639]    ; sprite_courant
01852  80 3d 01             cmp byte ptr [di], 1
01855  74 01                je loc_1858
01857  c3                   ret
loc_1858:
01858  8b 3e 37 46          mov di, word ptr [0x4637]    ; fiche_heros_courant
0185c  8b 5d 04             mov bx, word ptr [di + 4]
0185f  80 bf 00 02 38       cmp byte ptr [bx + 0x200], 0x38
01864  73 01                jae loc_1867
01866  c3                   ret
loc_1867:
01867  80 bf 00 02 3c       cmp byte ptr [bx + 0x200], 0x3c
0186c  72 01                jb loc_186f
0186e  c3                   ret
loc_186f:
0186f  e8 65 45             call curseur_efface
01872  c6 06 c8 3f 00       mov byte ptr [0x3fc8], 0    ; pas_en_file
01877  80 3e 92 3f 03       cmp byte ptr [0x3f92], 3    ; numero_quete
0187c  74 1b                je loc_1899
0187e  a0 a7 3f             mov al, byte ptr [0x3fa7]    ; personnage_courant
01881  a2 ca 3f             mov byte ptr [0x3fca], al    ; heros_courant
01884  e8 5b 0e             call heros_hors_quete
01887  8a 1e a7 3f          mov bl, byte ptr [0x3fa7]    ; personnage_courant
0188b  32 ff                xor bh, bh
0188d  c6 87 a0 44 ff       mov byte ptr [bx + 0x44a0], 0xff    ; heros_en_jeu
01892  8b 3e 37 46          mov di, word ptr [0x4637]    ; fiche_heros_courant
01896  c6 05 00             mov byte ptr [di], 0
loc_1899:
01899  c6 06 9a 3f 01       mov byte ptr [0x3f9a], 1    ; fin_du_tour
0189e  80 3e 92 3f 0f       cmp byte ptr [0x3f92], 0xf    ; numero_quete
018a3  73 12                jae loc_18b7
018a5  bb 1c 00             mov bx, 0x1c    ; message « VOUS AVEZ ECHAPPE INDEMNE / A LA QUETE »
018a8  e8 42 70             call affiche_message
018ab  8a 1e 92 3f          mov bl, byte ptr [0x3f92]    ; numero_quete
018af  32 ff                xor bh, bh
018b1  d0 e3                shl bl, 1
018b3  ff a7 a9 44          jmp word ptr [bx + 0x44a9]    ; fins_quetes
loc_18b7:
018b7  bb 4c 02             mov bx, 0x24c    ; message « VOUS AVEZ ECHAPPE INDEMNE / A LA QUETE »
018ba  e8 30 70             call affiche_message
018bd  c3                   ret
fin_labyrinthe:    ; quête 1 : 100 pièces au premier sorti
018be  fe 06 bd 3f          inc byte ptr [0x3fbd]    ; heros_sortis
018c2  80 3e bd 3f 01       cmp byte ptr [0x3fbd], 1    ; heros_sortis
018c7  74 03                je loc_18cc
018c9  e9 6e 01             jmp apres_sortie
loc_18cc:
018cc  be 92 00             mov si, 0x92
018cf  ba 64 00             mov dx, 0x64
loc_18d2:
018d2  52                   push dx
018d3  8b de                mov bx, si
018d5  e8 15 70             call affiche_message
018d8  5a                   pop dx
018d9  e8 2a 50             call ajoute_or
018dc  e9 5b 01             jmp apres_sortie
fin_karlen:    ; quête 7 : 100 pièces si Karlen a été trouvé
018df  80 3e c0 3f ff       cmp byte ptr [0x3fc0], 0xff    ; evenement_b
018e4  75 03                jne loc_18e9
018e6  e9 51 01             jmp apres_sortie
loc_18e9:
018e9  ba 64 00             mov dx, 0x64
018ec  be c6 00             mov si, 0xc6
018ef  eb e1                jmp loc_18d2
fin_ragnar:    ; quête 2 : Sir Ragnar sorti, 200 pièces à celui qui l'a trouvé (le message dit 100)
018f1  80 3e a7 3f 04       cmp byte ptr [0x3fa7], 4    ; personnage_courant
018f6  74 03                je loc_18fb
018f8  e9 3f 01             jmp apres_sortie
loc_18fb:
018fb  bb 9c 00             mov bx, 0x9c    ; message « L'EMPEREUR OFFRE 100 / PIECES D'OR AU / SAUVEUR DE SIR RAGNARD »
018fe  e8 ec 6f             call affiche_message
01901  a0 bf 3f             mov al, byte ptr [0x3fbf]    ; evenement_a
01904  e8 78 44             call fiche_personnage
01907  8b fe                mov di, si
01909  ba c8 00             mov dx, 0xc8
0190c  e8 fb 4f             call ajoute_or_di
0190f  e9 28 01             jmp apres_sortie
fin_or_faux:    ; quête 10 : l'or de la mine était faux, 5000 pièces retirées
01912  8b 3e 37 46          mov di, word ptr [0x4637]    ; fiche_heros_courant
01916  f6 45 0f 20          test byte ptr [di + 0xf], 0x20
0191a  75 03                jne loc_191f
0191c  e9 1b 01             jmp apres_sortie
loc_191f:
0191f  81 6d 09 88 13       sub word ptr [di + 9], 0x1388
01924  be dc 00             mov si, 0xdc
01927  e9 0b 01             jmp message_puis_sortie
fin_or_prince:    ; quête 4 : garder ou rendre le coffre, retourner chercher de l'or
0192a  e8 0d 01             call apres_sortie
0192d  8b 3e 37 46          mov di, word ptr [0x4637]    ; fiche_heros_courant
01931  f6 45 0f 40          test byte ptr [di + 0xf], 0x40
01935  74 2d                je loc_1964
01937  bb b2 00             mov bx, 0xb2    ; message « VOUS DEVEZ DECIDER DE CE QUE / VOUS VOULEZ FAIRE AVEC LE / COFFRE QUE VOUS AVEZ RECUPERE »
0193a  e8 b0 6f             call affiche_message
0193d  e8 e5 fe             call redessine_plateau
01940  80 3e 7a ab 01       cmp byte ptr [0xab7a], 1    ; choix_menu
01945  74 0c                je loc_1953
01947  bb ae 00             mov bx, 0xae    ; message « VOUS DEVENEZ PLUS RICHE MAIS NE / SEREZ PEUT-ETRE JAMAIS CHAMPION »
0194a  e8 a0 6f             call affiche_message
0194d  e8 d5 fe             call redessine_plateau
01950  eb 12                jmp loc_1964
; ---- 1 octets non atteints (1952-1952)
loc_1953:
01953  bb b0 00             mov bx, 0xb0    ; message « LE PRINCE VOUS REMERCIE / D'AVOIR RAPPORTE SON OR. / SA RECOMPENSE EST DE 200 PIECES »
01956  e8 94 6f             call affiche_message
01959  e8 c9 fe             call redessine_plateau
0195c  8b 3e 37 46          mov di, word ptr [0x4637]    ; fiche_heros_courant
01960  83 6d 09 32          sub word ptr [di + 9], 0x32
loc_1964:
01964  80 3e be 3f 03       cmp byte ptr [0x3fbe], 3    ; coffres_ramasses
01969  74 76                je loc_19e1
0196b  bb b4 00             mov bx, 0xb4    ; message « IL Y A ENCORE DE L'OR A / RECUPERER. VOULEZ-VOUS / RETOURNER LE CHERCHER »
0196e  e8 7c 6f             call affiche_message
01971  e8 b1 fe             call redessine_plateau
01974  80 3e 7a ab 00       cmp byte ptr [0xab7a], 0    ; choix_menu
01979  74 66                je loc_19e1
0197b  8a 1e a7 3f          mov bl, byte ptr [0x3fa7]    ; personnage_courant
0197f  b7 00                mov bh, 0
01981  8b 3e 37 46          mov di, word ptr [0x4637]    ; fiche_heros_courant
01985  c6 87 a0 44 00       mov byte ptr [bx + 0x44a0], 0    ; heros_en_jeu
0198a  c6 05 ff             mov byte ptr [di], 0xff
0198d  b0 03                mov al, 3
0198f  b4 0b                mov ah, 0xb
01991  e8 2e 00             call case_prise_heros
01994  73 12                jae loc_19a8
01996  fe c0                inc al
01998  e8 27 00             call case_prise_heros
0199b  73 0b                jae loc_19a8
0199d  fe c8                dec al
0199f  fe c4                inc ah
019a1  e8 1e 00             call case_prise_heros
019a4  72 02                jb loc_19a8
019a6  fe c8                dec al
loc_19a8:
019a8  88 45 01             mov byte ptr [di + 1], al
019ab  88 65 02             mov byte ptr [di + 2], ah
019ae  80 65 0f bf          and byte ptr [di + 0xf], 0xbf
019b2  c6 06 9c 3f 00       mov byte ptr [0x3f9c], 0    ; deplacement_restant
019b7  c6 06 9a 3f 00       mov byte ptr [0x3f9a], 0    ; fin_du_tour
019bc  e8 f1 54             call redessin_plateau
019bf  e9 e8 54             jmp loc_6eaa

; ======== case_prise_heros   (appelée depuis 1991, 1998, 19a1)
; CF posé si un autre héros que DI est en (AL, AH)
019c2  50                   push ax
019c3  b9 04 00             mov cx, 4
019c6  be 63 46             mov si, 0x4663    ; fiches_personnages
loc_19c9:
019c9  3b fe                cmp di, si
019cb  74 0c                je loc_19d9
019cd  38 44 01             cmp byte ptr [si + 1], al
019d0  75 07                jne loc_19d9
019d2  38 64 02             cmp byte ptr [si + 2], ah
019d5  f9                   stc
019d6  eb 07                jmp loc_19df
; ---- 1 octets non atteints (19d8-19d8)
loc_19d9:
019d9  83 c6 1a             add si, 0x1a
019dc  e2 eb                loop loc_19c9
019de  f8                   clc
loc_19df:
019df  58                   pop ax
019e0  c3                   ret
loc_19e1:
019e1  a0 a7 3f             mov al, byte ptr [0x3fa7]    ; personnage_courant
019e4  a2 ca 3f             mov byte ptr [0x3fca], al    ; heros_courant
019e7  e8 f8 0c             call heros_hors_quete
019ea  8a 1e a7 3f          mov bl, byte ptr [0x3fa7]    ; personnage_courant
019ee  32 ff                xor bh, bh
019f0  c6 87 a0 44 ff       mov byte ptr [bx + 0x44a0], 0xff    ; heros_en_jeu
019f5  8b 3e 37 46          mov di, word ptr [0x4637]    ; fiche_heros_courant
019f9  c6 05 00             mov byte ptr [di], 0
019fc  c6 06 9a 3f 01       mov byte ptr [0x3f9a], 1    ; fin_du_tour
01a01  e9 a6 54             jmp loc_6eaa
fin_course:    ; quête 9 : retire l'objet de quête (+0x0F bit 0x40)
01a04  8b 3e 37 46          mov di, word ptr [0x4637]    ; fiche_heros_courant
01a08  80 65 0f bf          and byte ptr [di + 0xf], 0xbf
01a0c  eb 2c                jmp apres_sortie
; ---- 1 octets non atteints (1a0e-1a0e)
fin_balur:    ; quête 8 : 150 pièces au héros qui a tué Balur
01a0f  be ce 00             mov si, 0xce
01a12  80 3e c0 3f ff       cmp byte ptr [0x3fc0], 0xff    ; evenement_b
01a17  74 1c                je message_puis_sortie
01a19  a0 a7 3f             mov al, byte ptr [0x3fa7]    ; personnage_courant
01a1c  3a 06 c0 3f          cmp al, byte ptr [0x3fc0]    ; evenement_b
01a20  75 18                jne apres_sortie
01a22  bb cc 00             mov bx, 0xcc    ; message « L'EMPEREUR OFFRE AUX / ASSASSINS DE BALUR UNE / RECOMPENSE DE 150 PIECES D'OR »
01a25  e8 c5 6e             call affiche_message
01a28  8b 3e 37 46          mov di, word ptr [0x4637]    ; fiche_heros_courant
01a2c  ba 96 00             mov dx, 0x96
01a2f  e8 d4 4e             call ajoute_or
01a32  eb 06                jmp apres_sortie
; ---- 1 octets non atteints (1a34-1a34)

; ======== message_puis_sortie   (appelée depuis 6f1f, 6f74, 6ffd)
; affiche le message SI, puis apres_sortie
01a35  8b de                mov bx, si
01a37  e8 b3 6e             call affiche_message

; ======== apres_sortie   (appelée depuis 18b3, 192a, 7168, 71a2)
; « LES JOUEURS SONT TOUS ELIMINES » si plus aucun héros dans la quête
01a3a  e8 e8 fd             call redessine_plateau
01a3d  e8 74 ec             call quete_continue
01a40  0a c0                or al, al
01a42  75 06                jne loc_1a4a
01a44  bb 1e 00             mov bx, 0x1e    ; message « LES JOUEURS SONT TOUS ELIMINES »
01a47  e8 a3 6e             call affiche_message
loc_1a4a:
01a4a  e8 11 4c             call pause_150
01a4d  e9 5a 54             jmp loc_6eaa

; ======== dessine_carte   (appelée depuis 1038, 2232, 22a8, 22bf, 22e9, 2519, 56e0)
; parchemin MAPS 256 × 197 en (32, 2), puis grille 26 × 19 de tuiles 8 × 8 depuis (56, 16) : sols, murs, bords droit (tuile 0x22) et bas (0x21), occupants, puis les 5 personnages (icône DS:52A1 par type)
01a50  56                   push si
01a51  be 00 00             mov si, 0
01a54  bf a0 02             mov di, 0x2a0
01a57  a1 27 5e             mov ax, word ptr [0x5e27]    ; seg_annexe
01a5a  a3 4e 37             mov word ptr [0x374e], ax    ; segment_source
01a5d  50                   push ax
01a5e  b8 63 14             mov ax, 0x1463
01a61  8e c0                mov es, ax
01a63  58                   pop ax
01a64  bd 00 01             mov bp, 0x100
01a67  b9 c5 00             mov cx, 0xc5
01a6a  1e                   push ds
01a6b  e8 e5 20             call copie_image
01a6e  1f                   pop ds
01a6f  c7 06 e9 37 38 14    mov word ptr [0x37e9], 0x1438    ; erreur_fichier
01a75  c7 06 ed 37 00 00    mov word ptr [0x37ed], 0    ; ligne_carte
01a7b  c7 06 ef 37 00 00    mov word ptr [0x37ef], 0    ; colonne_carte
01a81  bb 6f 54             mov bx, 0x546f    ; grille_zones
01a84  b9 13 00             mov cx, 0x13
loc_1a87:
01a87  53                   push bx
01a88  51                   push cx
01a89  8b 0e e9 37          mov cx, word ptr [0x37e9]    ; erreur_fichier
01a8d  89 0e eb 37          mov word ptr [0x37eb], cx    ; position_tuile_carte
01a91  b9 1a 00             mov cx, 0x1a
loc_1a94:
01a94  53                   push bx
01a95  51                   push cx
01a96  e8 1c 01             call sol_carte
01a99  59                   pop cx
01a9a  5b                   pop bx
01a9b  43                   inc bx
01a9c  83 06 eb 37 08       add word ptr [0x37eb], 8    ; position_tuile_carte
01aa1  ff 06 ef 37          inc word ptr [0x37ef]    ; colonne_carte
01aa5  e2 ed                loop loc_1a94
01aa7  ff 06 ed 37          inc word ptr [0x37ed]    ; ligne_carte
01aab  c7 06 ef 37 00 00    mov word ptr [0x37ef], 0    ; colonne_carte
01ab1  81 06 e9 37 00 0a    add word ptr [0x37e9], 0xa00    ; erreur_fichier, "AND TRY AGAIN"
01ab7  59                   pop cx
01ab8  5b                   pop bx
01ab9  83 c3 1a             add bx, 0x1a
01abc  e2 c9                loop loc_1a87
01abe  c7 06 e9 37 38 14    mov word ptr [0x37e9], 0x1438    ; erreur_fichier
01ac4  c7 06 ed 37 00 00    mov word ptr [0x37ed], 0    ; ligne_carte
01aca  c7 06 ef 37 00 00    mov word ptr [0x37ef], 0    ; colonne_carte
01ad0  bb 6f 54             mov bx, 0x546f    ; grille_zones
01ad3  b9 13 00             mov cx, 0x13
loc_1ad6:
01ad6  53                   push bx
01ad7  51                   push cx
01ad8  8b 0e e9 37          mov cx, word ptr [0x37e9]    ; erreur_fichier
01adc  89 0e eb 37          mov word ptr [0x37eb], cx    ; position_tuile_carte
01ae0  b9 1a 00             mov cx, 0x1a
loc_1ae3:
01ae3  53                   push bx
01ae4  51                   push cx
01ae5  83 f9 1a             cmp cx, 0x1a
01ae8  75 08                jne loc_1af2
01aea  8a 07                mov al, byte ptr [bx]
01aec  24 3f                and al, 0x3f
01aee  0a c0                or al, al
01af0  74 03                je loc_1af5
loc_1af2:
01af2  e8 d5 00             call murs_carte
loc_1af5:
01af5  59                   pop cx
01af6  5b                   pop bx
01af7  43                   inc bx
01af8  83 06 eb 37 08       add word ptr [0x37eb], 8    ; position_tuile_carte
01afd  ff 06 ef 37          inc word ptr [0x37ef]    ; colonne_carte
01b01  e2 e0                loop loc_1ae3
01b03  8a 47 ff             mov al, byte ptr [bx - 1]
01b06  24 3f                and al, 0x3f
01b08  0a c0                or al, al
01b0a  74 0b                je loc_1b17
01b0c  b0 22                mov al, 0x22
01b0e  f6 47 ff 40          test byte ptr [bx - 1], 0x40
01b12  74 03                je loc_1b17
01b14  e8 fc 01             call tuile_carte
loc_1b17:
01b17  ff 06 ed 37          inc word ptr [0x37ed]    ; ligne_carte
01b1b  c7 06 ef 37 00 00    mov word ptr [0x37ef], 0    ; colonne_carte
01b21  81 06 e9 37 00 0a    add word ptr [0x37e9], 0xa00    ; erreur_fichier, "AND TRY AGAIN"
01b27  59                   pop cx
01b28  5b                   pop bx
01b29  83 c3 1a             add bx, 0x1a
01b2c  e2 a8                loop loc_1ad6
01b2e  8b 0e e9 37          mov cx, word ptr [0x37e9]    ; erreur_fichier
01b32  89 0e eb 37          mov word ptr [0x37eb], cx    ; position_tuile_carte
01b36  b9 1a 00             mov cx, 0x1a
01b39  bb 43 56             mov bx, 0x5643
loc_1b3c:
01b3c  8a 07                mov al, byte ptr [bx]
01b3e  24 3f                and al, 0x3f
01b40  0a c0                or al, al
01b42  74 0e                je loc_1b52
01b44  51                   push cx
01b45  53                   push bx
01b46  b0 21                mov al, 0x21
01b48  f6 07 40             test byte ptr [bx], 0x40
01b4b  74 03                je loc_1b50
01b4d  e8 c3 01             call tuile_carte
loc_1b50:
01b50  5b                   pop bx
01b51  59                   pop cx
loc_1b52:
01b52  43                   inc bx
01b53  83 06 eb 37 08       add word ptr [0x37eb], 8    ; position_tuile_carte
01b58  ff 06 ef 37          inc word ptr [0x37ef]    ; colonne_carte
01b5c  e2 de                loop loc_1b3c
01b5e  be 63 46             mov si, 0x4663    ; fiches_personnages
01b61  b9 05 00             mov cx, 5
loc_1b64:
01b64  51                   push cx
01b65  56                   push si
01b66  80 3e b0 3f 00       cmp byte ptr [0x3fb0], 0    ; carte_simplifiee
01b6b  74 08                je loc_1b75
01b6d  a0 a7 3f             mov al, byte ptr [0x3fa7]    ; personnage_courant
01b70  3a 44 19             cmp al, byte ptr [si + 0x19]
01b73  74 37                je loc_1bac
loc_1b75:
01b75  80 3c 00             cmp byte ptr [si], 0
01b78  74 32                je loc_1bac
01b7a  8a 44 02             mov al, byte ptr [si + 2]
01b7d  32 e4                xor ah, ah
01b7f  ba 00 0a             mov dx, 0xa00    ; "AND TRY AGAIN"
01b82  f7 e2                mul dx
01b84  8b d8                mov bx, ax
01b86  8a 44 01             mov al, byte ptr [si + 1]
01b89  b2 08                mov dl, 8
01b8b  f6 e2                mul dl
01b8d  03 c3                add ax, bx
01b8f  05 38 14             add ax, 0x1438
01b92  a3 eb 37             mov word ptr [0x37eb], ax    ; position_tuile_carte
01b95  8a 5c 19             mov bl, byte ptr [si + 0x19]
01b98  32 ff                xor bh, bh
01b9a  d1 e3                shl bx, 1
01b9c  81 c3 a1 52          add bx, 0x52a1    ; icones_heros_carte
01ba0  8b 2f                mov bp, word ptr [bx]
01ba2  80 3e b0 3f 00       cmp byte ptr [0x3fb0], 0    ; carte_simplifiee
01ba7  74 00                je loc_1ba9
loc_1ba9:
01ba9  e8 92 01             call copie_tuile_carte
loc_1bac:
01bac  5e                   pop si
01bad  59                   pop cx
01bae  83 c6 1a             add si, 0x1a
01bb1  e2 b1                loop loc_1b64
01bb3  5e                   pop si
01bb4  c3                   ret

; ======== sol_carte   (appelée depuis 1a96)
; case vue (bit 0x40) d'une zone : tuile de sol de la zone (table DS:A599)
01bb5  f6 07 40             test byte ptr [bx], 0x40
01bb8  75 01                jne loc_1bbb
01bba  c3                   ret
loc_1bbb:
01bbb  8a 07                mov al, byte ptr [bx]
01bbd  24 3f                and al, 0x3f
01bbf  0a c0                or al, al
01bc1  75 01                jne loc_1bc4
01bc3  c3                   ret
loc_1bc4:
01bc4  bb 99 a5             mov bx, 0xa599    ; tuiles_sols_carte
01bc7  e9 48 01             jmp loc_1d12

; ======== murs_carte   (appelée depuis 1af2)
; case vue : tuile de murs (octet de murs & 0xFE) puis occupant_carte ; case non vue mais bordée (0x80) : seuls les murs partagés avec une case vue ; hors zone : bord 0x81 / 0x41 si la case du haut / de gauche est vue
01bca  8a 27                mov ah, byte ptr [bx]
01bcc  80 e4 3f             and ah, 0x3f
01bcf  0a e4                or ah, ah
01bd1  74 42                je loc_1c15
01bd3  8a 87 00 02          mov al, byte ptr [bx + 0x200]
01bd7  24 fe                and al, 0xfe
01bd9  f6 07 40             test byte ptr [bx], 0x40
01bdc  74 08                je loc_1be6
01bde  53                   push bx
01bdf  e8 2d 01             call tuile_murs
01be2  5b                   pop bx
01be3  eb 7c                jmp occupant_carte
; ---- 1 octets non atteints (1be5-1be5)
loc_1be6:
01be6  f6 07 80             test byte ptr [bx], 0x80
01be9  75 01                jne loc_1bec
01beb  c3                   ret
loc_1bec:
01bec  8a 67 e6             mov ah, byte ptr [bx - 0x1a]
01bef  80 e4 3f             and ah, 0x3f
01bf2  0a e4                or ah, ah
01bf4  74 06                je loc_1bfc
01bf6  f6 47 e6 40          test byte ptr [bx - 0x1a], 0x40
01bfa  75 08                jne loc_1c04
loc_1bfc:
01bfc  24 5c                and al, 0x5c
01bfe  a8 10                test al, 0x10
01c00  75 02                jne loc_1c04
01c02  24 40                and al, 0x40
loc_1c04:
01c04  f6 47 ff 40          test byte ptr [bx - 1], 0x40
01c08  75 3f                jne loc_1c49
01c0a  24 ac                and al, 0xac
01c0c  a8 20                test al, 0x20
01c0e  75 39                jne loc_1c49
01c10  24 c0                and al, 0xc0
01c12  eb 35                jmp loc_1c49
; ---- 1 octets non atteints (1c14-1c14)
loc_1c15:
01c15  32 c0                xor al, al
01c17  83 3e ed 37 00       cmp word ptr [0x37ed], 0    ; ligne_carte
01c1c  74 12                je loc_1c30
01c1e  8a 67 e6             mov ah, byte ptr [bx - 0x1a]
01c21  80 e4 3f             and ah, 0x3f
01c24  0a e4                or ah, ah
01c26  74 08                je loc_1c30
01c28  f6 47 e6 40          test byte ptr [bx - 0x1a], 0x40
01c2c  74 02                je loc_1c30
01c2e  b0 81                mov al, 0x81
loc_1c30:
01c30  83 3e ef 37 00       cmp word ptr [0x37ef], 0    ; colonne_carte
01c35  74 12                je loc_1c49
01c37  8a 67 ff             mov ah, byte ptr [bx - 1]
01c3a  80 e4 3f             and ah, 0x3f
01c3d  0a e4                or ah, ah
01c3f  74 08                je loc_1c49
01c41  f6 47 ff 40          test byte ptr [bx - 1], 0x40
01c45  74 02                je loc_1c49
01c47  0c 41                or al, 0x41
loc_1c49:
01c49  0a c0                or al, al
01c4b  75 01                jne loc_1c4e
01c4d  c3                   ret
loc_1c4e:
01c4e  e9 be 00             jmp tuile_murs

; ======== porte_en_mur_carte
; non appelée : bits de porte 0x30 recopiés en bits de mur 0xC0, puis tuile_murs
01c51  8a c8                mov cl, al
01c53  80 e1 c3             and cl, 0xc3
01c56  02 c0                add al, al
01c58  02 c0                add al, al
01c5a  24 c0                and al, 0xc0
01c5c  0a c1                or al, cl
01c5e  e9 ae 00             jmp tuile_murs
occupant_carte:    ; monstre : icône DS:5265 selon son octet +8 (rien pour 0x15) ; codes 0x30 à 0x3F : DS:51ED + code × 2 ; 0x40, 0x41 : MAPS 0xC9C0, 0xC980 ; meubles : liste de tuiles DS:521F + code × 2
01c61  8a 87 00 04          mov al, byte ptr [bx + 0x400]
01c65  0a c0                or al, al
01c67  75 01                jne loc_1c6a
01c69  c3                   ret
loc_1c6a:
01c6a  3c 30                cmp al, 0x30
01c6c  73 24                jae loc_1c92
01c6e  80 3e b0 3f 00       cmp byte ptr [0x3fb0], 0    ; carte_simplifiee
01c73  74 06                je loc_1c7b
01c75  bd 9c 48             mov bp, 0x489c
01c78  e9 c3 00             jmp copie_tuile_carte
loc_1c7b:
01c7b  e8 c2 f1             call adresse_monstre
01c7e  8a 5f 08             mov bl, byte ptr [bx + 8]
01c81  80 fb 15             cmp bl, 0x15
01c84  75 01                jne loc_1c87
01c86  c3                   ret
loc_1c87:
01c87  32 ff                xor bh, bh
01c89  d1 e3                shl bx, 1
01c8b  8b af 65 52          mov bp, word ptr [bx + 0x5265]    ; icones_monstres_carte
01c8f  e9 ac 00             jmp copie_tuile_carte
loc_1c92:
01c92  3c 40                cmp al, 0x40
01c94  73 1f                jae loc_1cb5
01c96  3c 30                cmp al, 0x30
01c98  74 08                je loc_1ca2
01c9a  80 3e b0 3f 00       cmp byte ptr [0x3fb0], 0    ; carte_simplifiee
01c9f  74 01                je loc_1ca2
01ca1  c3                   ret
loc_1ca2:
01ca2  8a d8                mov bl, al
01ca4  32 ff                xor bh, bh
01ca6  d1 e3                shl bx, 1
01ca8  8b af ed 51          mov bp, word ptr [bx + 0x51ed]    ; tuiles_codes_carte
01cac  83 fd 00             cmp bp, 0
01caf  75 01                jne loc_1cb2
01cb1  c3                   ret
loc_1cb2:
01cb2  e9 89 00             jmp copie_tuile_carte
loc_1cb5:
01cb5  3c 42                cmp al, 0x42
01cb7  73 10                jae loc_1cc9
01cb9  bd 80 c9             mov bp, 0xc980
01cbc  3c 41                cmp al, 0x41
01cbe  75 03                jne loc_1cc3
01cc0  eb 7c                jmp copie_tuile_carte
; ---- 1 octets non atteints (1cc2-1cc2)
loc_1cc3:
01cc3  bd c0 c9             mov bp, 0xc9c0
01cc6  eb 76                jmp copie_tuile_carte
; ---- 1 octets non atteints (1cc8-1cc8)
loc_1cc9:
01cc9  3c 4b                cmp al, 0x4b
01ccb  73 01                jae loc_1cce
01ccd  c3                   ret
loc_1cce:
01cce  32 e4                xor ah, ah
01cd0  d1 e0                shl ax, 1
01cd2  8b d8                mov bx, ax
01cd4  8b b7 1f 52          mov si, word ptr [bx + 0x521f]    ; meubles_carte
01cd8  8b 2c                mov bp, word ptr [si]
01cda  83 c6 02             add si, 2
loc_1cdd:
01cdd  8b 04                mov ax, word ptr [si]
01cdf  03 06 eb 37          add ax, word ptr [0x37eb]    ; position_tuile_carte
01ce3  56                   push si
01ce4  55                   push bp
01ce5  8b f5                mov si, bp
01ce7  8b f8                mov di, ax
01ce9  a1 27 5e             mov ax, word ptr [0x5e27]    ; seg_annexe
01cec  a3 4e 37             mov word ptr [0x374e], ax    ; segment_source
01cef  50                   push ax
01cf0  b8 63 14             mov ax, 0x1463
01cf3  8e c0                mov es, ax
01cf5  58                   pop ax
01cf6  bd 08 00             mov bp, 8
01cf9  b9 08 00             mov cx, 8
01cfc  1e                   push ds
01cfd  e8 53 1e             call copie_image
01d00  1f                   pop ds
01d01  5d                   pop bp
01d02  5e                   pop si
01d03  83 c6 02             add si, 2
01d06  83 c5 40             add bp, 0x40
01d09  83 3c ff             cmp word ptr [si], -1
01d0c  75 cf                jne loc_1cdd
01d0e  c3                   ret

; ======== tuile_murs   (appelée depuis 1bdf)
; AL = octet de murs -> tuile (table DS:5148), puis tuile_carte
01d0f  bb 48 51             mov bx, 0x5148    ; tuiles_murs_carte
loc_1d12:
01d12  d7                   xlatb

; ======== tuile_carte   (appelée depuis 1b14, 1b4d)
; tuile AL (MAPS 0xC500 + AL × 64, 8 × 8) en DS:37EB
01d13  32 e4                xor ah, ah
01d15  33 d2                xor dx, dx
01d17  b9 40 00             mov cx, 0x40
01d1a  f7 e1                mul cx
01d1c  05 00 c5             add ax, 0xc500
01d1f  8b f0                mov si, ax
01d21  8b 3e eb 37          mov di, word ptr [0x37eb]    ; position_tuile_carte
01d25  a1 27 5e             mov ax, word ptr [0x5e27]    ; seg_annexe
01d28  a3 4e 37             mov word ptr [0x374e], ax    ; segment_source
01d2b  50                   push ax
01d2c  b8 63 14             mov ax, 0x1463
01d2f  8e c0                mov es, ax
01d31  58                   pop ax
01d32  bd 08 00             mov bp, 8
01d35  b9 08 00             mov cx, 8
01d38  1e                   push ds
01d39  e8 17 1e             call copie_image
01d3c  1f                   pop ds
01d3d  c3                   ret

; ======== copie_tuile_carte   (appelée depuis 1ba9)
; image BP de MAPS (8 × 8) en DS:37EB
01d3e  8b f5                mov si, bp
01d40  8b 3e eb 37          mov di, word ptr [0x37eb]    ; position_tuile_carte
01d44  a1 27 5e             mov ax, word ptr [0x5e27]    ; seg_annexe
01d47  a3 4e 37             mov word ptr [0x374e], ax    ; segment_source
01d4a  50                   push ax
01d4b  b8 63 14             mov ax, 0x1463
01d4e  8e c0                mov es, ax
01d50  58                   pop ax
01d51  bd 08 00             mov bp, 8
01d54  b9 08 00             mov cx, 8
01d57  1e                   push ds
01d58  e8 f8 1d             call copie_image
01d5b  1f                   pop ds
01d5c  c3                   ret

; ======== marque_case_courante   (appelée depuis 05fb)
; marque_case_vue sur la case DS:3FDE - 0x200
01d5d  8b 1e de 3f          mov bx, word ptr [0x3fde]    ; case_dessinee
01d61  81 eb 00 02          sub bx, 0x200

; ======== marque_case_vue   (appelée depuis 05eb, 1332)
; bits 0xC0 de la case BX de grille_zones, bit 0x80 de ses voisines de droite (sauf x = 25) et du dessous
01d65  80 0f c0             or byte ptr [bx], 0xc0
01d68  8b c3                mov ax, bx
01d6a  33 d2                xor dx, dx
01d6c  2d 6f 54             sub ax, 0x546f    ; grille_zones
01d6f  bd 1a 00             mov bp, 0x1a
01d72  f7 f5                div bp
01d74  83 fa 19             cmp dx, 0x19
01d77  74 04                je loc_1d7d
01d79  80 4f 01 80          or byte ptr [bx + 1], 0x80
loc_1d7d:
01d7d  81 fb 55 56          cmp bx, 0x5655
01d81  75 01                jne loc_1d84
01d83  c3                   ret
loc_1d84:
01d84  80 4f 1a 80          or byte ptr [bx + 0x1a], 0x80
01d88  c3                   ret

; ======== affiche_texte_tampon
; non appelée : texte SI (affiche_texte_si), puis affiche_tampon
01d89  e8 18 43             call affiche_texte_si
01d8c  e9 55 43             jmp affiche_tampon

; ======== combat_monstre   (appelée depuis 2539, 6f06)
; un monstre frappe le héros SI (DS:3FD6) : images MEN, dés, attaque_contre_heros, puis recharge MAPS
01d8f  c6 06 b6 3f 01       mov byte ptr [0x3fb6], 1
01d94  ff 36 37 46          push word ptr [0x4637]    ; fiche_heros_courant
01d98  ff 36 a7 3f          push word ptr [0x3fa7]    ; personnage_courant
01d9c  a0 bc 3f             mov al, byte ptr [0x3fbc]
01d9f  a2 a7 3f             mov byte ptr [0x3fa7], al    ; personnage_courant
01da2  8b 1e d6 3f          mov bx, word ptr [0x3fd6]    ; attaquant
01da6  89 1e 37 46          mov word ptr [0x4637], bx    ; fiche_heros_courant
01daa  e8 d3 3e             call charge_men
01dad  e8 db ed             call calcule_defense_heros
01db0  e8 75 ed             call calcule_des_monstre
01db3  e8 da 00             call attaque_contre_heros
01db6  c6 06 b6 3f 00       mov byte ptr [0x3fb6], 0
01dbb  8f 06 a7 3f          pop word ptr [0x3fa7]    ; personnage_courant
01dbf  8f 06 37 46          pop word ptr [0x4637]    ; fiche_heros_courant
01dc3  83 3e 90 31 08       cmp word ptr [0x3190], 8    ; mode_video
01dc8  75 63                jne loc_1e2d
01dca  c7 06 07 39 66 5e    mov word ptr [0x3907], 0x5e66    ; fichier_nom, "maps.vga"
01dd0  c7 06 03 39 00 00    mov word ptr [0x3903], 0    ; fichier_offset
01dd6  b8 63 14             mov ax, 0x1463
01dd9  a3 01 39             mov word ptr [0x3901], ax    ; fichier_segment
loc_1ddc:
01ddc  c7 06 e9 37 00 00    mov word ptr [0x37e9], 0    ; erreur_fichier
01de2  e8 0c 19             call clavier_retire
01de5  e8 e0 1b             call fichier_ouvre
01de8  83 3e e9 37 00       cmp word ptr [0x37e9], 0    ; erreur_fichier
01ded  75 03                jne loc_1df2
01def  eb 0f                jmp loc_1e00
; ---- 1 octets non atteints (1df1-1df1)
loc_1df2:
01df2  e8 c5 18             call clavier_installe
01df5  bb 52 02             mov bx, 0x252    ; message « INTRODUISEZ VOTRE / HEROQUEST DISQUETTE 3 »
01df8  e8 f2 6a             call affiche_message
01dfb  e8 f3 18             call clavier_retire
01dfe  eb dc                jmp loc_1ddc
loc_1e00:
01e00  e8 f9 1b             call fichier_lit
01e03  83 3e e9 37 00       cmp word ptr [0x37e9], 0    ; erreur_fichier
01e08  75 e8                jne loc_1df2
01e0a  a3 05 39             mov word ptr [0x3905], ax    ; fichier_taille
01e0d  e8 aa 18             call clavier_installe
01e10  a1 27 5e             mov ax, word ptr [0x5e27]    ; seg_annexe
01e13  8e c0                mov es, ax
01e15  33 f6                xor si, si
01e17  bf 00 00             mov di, 0
01e1a  b8 63 14             mov ax, 0x1463
01e1d  8e d8                mov ds, ax
01e1f  b9 ff ff             mov cx, 0xffff
01e22  e8 ac 27             call lz_decompresse
01e25  50                   push ax
01e26  b8 7c 09             mov ax, 0x97c
01e29  8e d8                mov ds, ax
01e2b  58                   pop ax
01e2c  c3                   ret
loc_1e2d:
01e2d  c7 06 07 39 02 5f    mov word ptr [0x3907], 0x5f02    ; fichier_nom, "maps.ega"
01e33  c7 06 03 39 00 00    mov word ptr [0x3903], 0    ; fichier_offset
01e39  b8 63 14             mov ax, 0x1463
01e3c  a3 01 39             mov word ptr [0x3901], ax    ; fichier_segment
loc_1e3f:
01e3f  c7 06 e9 37 00 00    mov word ptr [0x37e9], 0    ; erreur_fichier
01e45  e8 a9 18             call clavier_retire
01e48  e8 7d 1b             call fichier_ouvre
01e4b  83 3e e9 37 00       cmp word ptr [0x37e9], 0    ; erreur_fichier
01e50  75 03                jne loc_1e55
01e52  eb 0f                jmp loc_1e63
; ---- 1 octets non atteints (1e54-1e54)
loc_1e55:
01e55  e8 62 18             call clavier_installe
01e58  bb 52 02             mov bx, 0x252    ; message « INTRODUISEZ VOTRE / HEROQUEST DISQUETTE 3 »
01e5b  e8 8f 6a             call affiche_message
01e5e  e8 90 18             call clavier_retire
01e61  eb dc                jmp loc_1e3f
loc_1e63:
01e63  e8 96 1b             call fichier_lit
01e66  83 3e e9 37 00       cmp word ptr [0x37e9], 0    ; erreur_fichier
01e6b  75 e8                jne loc_1e55
01e6d  a3 05 39             mov word ptr [0x3905], ax    ; fichier_taille
01e70  e8 47 18             call clavier_installe
01e73  a1 27 5e             mov ax, word ptr [0x5e27]    ; seg_annexe
01e76  8e c0                mov es, ax
01e78  33 f6                xor si, si
01e7a  bf 00 00             mov di, 0
01e7d  b8 63 14             mov ax, 0x1463
01e80  8e d8                mov ds, ax
01e82  b9 ff ff             mov cx, 0xffff
01e85  e8 49 27             call lz_decompresse
01e88  50                   push ax
01e89  b8 7c 09             mov ax, 0x97c
01e8c  8e d8                mov ds, ax
01e8e  58                   pop ax
01e8f  c3                   ret

; ======== attaque_contre_heros   (appelée depuis 1db3)
; le héros compte comme boucliers les faces autres que le bouclier blanc (4 sur 6) ; crânes du monstre moins boucliers = blessures
01e90  8b 3e 37 46          mov di, word ptr [0x4637]    ; fiche_heros_courant
01e94  32 d2                xor dl, dl
01e96  8a 0e b9 3f          mov cl, byte ptr [0x3fb9]    ; des_defense_heros
01e9a  0a c9                or cl, cl
01e9c  74 10                je loc_1eae
01e9e  8a ea                mov ch, dl
loc_1ea0:
01ea0  51                   push cx
01ea1  e8 13 03             call de_combat
01ea4  80 fb 01             cmp bl, 1
01ea7  74 02                je loc_1eab
01ea9  fe c2                inc dl
loc_1eab:
01eab  59                   pop cx
01eac  e2 f2                loop loc_1ea0
loc_1eae:
01eae  88 16 d3 3f          mov byte ptr [0x3fd3], dl    ; boucliers
01eb2  8a 36 ba 3f          mov dh, byte ptr [0x3fba]    ; des_attaque_monstre
01eb6  e8 d3 3e             call compte_cranes
01eb9  a2 d2 3f             mov byte ptr [0x3fd2], al    ; cranes
01ebc  bd 48 71             mov bp, 0x7148
01ebf  ba 10 00             mov dx, 0x10
01ec2  bb 20 61             mov bx, 0x6120
01ec5  e8 1e ed             call affiche_des
01ec8  a0 d3 3f             mov al, byte ptr [0x3fd3]    ; boucliers
01ecb  bb 20 62             mov bx, 0x6220
01ece  bd e0 70             mov bp, 0x70e0
01ed1  ba f0 ff             mov dx, 0xfff0
01ed4  e8 0f ed             call affiche_des
01ed7  e8 95 46             call sauve_tampon
01eda  8b 36 d6 3f          mov si, word ptr [0x3fd6]    ; attaquant
01ede  8a 44 19             mov al, byte ptr [si + 0x19]
01ee1  a2 ca 3f             mov byte ptr [0x3fca], al    ; heros_courant
01ee4  8b 16 d2 3f          mov dx, word ptr [0x3fd2]    ; cranes
01ee8  3a d6                cmp dl, dh
01eea  76 11                jbe loc_1efd
01eec  2a d6                sub dl, dh
01eee  3a 54 06             cmp dl, byte ptr [si + 6]
01ef1  73 06                jae loc_1ef9
01ef3  28 54 06             sub byte ptr [si + 6], dl
01ef6  eb 05                jmp loc_1efd
; ---- 1 octets non atteints (1ef8-1ef8)
loc_1ef9:
01ef9  c6 44 06 00          mov byte ptr [si + 6], 0
loc_1efd:
01efd  e8 bb 01             call animation_attaque_monstre
01f00  8b 36 d6 3f          mov si, word ptr [0x3fd6]    ; attaquant
01f04  80 7c 06 00          cmp byte ptr [si + 6], 0
01f08  75 03                jne loc_1f0d
01f0a  e9 cb f1             jmp mort_heros
loc_1f0d:
01f0d  bb 52 00             mov bx, 0x52    ; message « VOUS AVEZ SURVECU A L'ATTAQUE »
01f10  e8 da 69             call affiche_message
01f13  c3                   ret

; ======== animation_combat   (appelée depuis 09a9)
; gros plan du combat ; retire la hache à main ou la lance lancée
01f14  8b 3e d6 3f          mov di, word ptr [0x3fd6]    ; attaquant
01f18  80 3e b7 3f 00       cmp byte ptr [0x3fb7], 0    ; attaque_a_distance
01f1d  74 22                je loc_1f41
01f1f  f6 45 11 20          test byte ptr [di + 0x11], 0x20
01f23  74 08                je loc_1f2d
01f25  80 75 11 20          xor byte ptr [di + 0x11], 0x20
01f29  80 75 0e 20          xor byte ptr [di + 0xe], 0x20
loc_1f2d:
01f2d  f6 45 11 40          test byte ptr [di + 0x11], 0x40
01f31  74 08                je loc_1f3b
01f33  80 75 11 40          xor byte ptr [di + 0x11], 0x40
01f37  80 75 0e 40          xor byte ptr [di + 0xe], 0x40
loc_1f3b:
01f3b  ba a4 a3             mov dx, 0xa3a4    ; sequence_arme_lancee
01f3e  eb 19                jmp loc_1f59
; ---- 1 octets non atteints (1f40-1f40)
loc_1f41:
01f41  8a 55 19             mov dl, byte ptr [di + 0x19]
01f44  d0 e2                shl dl, 1
01f46  32 f6                xor dh, dh
01f48  89 16 e9 37          mov word ptr [0x37e9], dx    ; erreur_fichier
01f4c  8a c2                mov al, dl
01f4e  d0 e2                shl dl, 1
01f50  02 d0                add dl, al
01f52  02 55 19             add dl, byte ptr [di + 0x19]
01f55  81 c2 81 a3          add dx, 0xa381    ; sequences_heros
loc_1f59:
01f59  8b 36 d4 3f          mov si, word ptr [0x3fd4]    ; cible
01f5d  8a 5c 08             mov bl, byte ptr [si + 8]
01f60  80 fb 07             cmp bl, 7
01f63  76 0c                jbe loc_1f71
01f65  80 fb 09             cmp bl, 9
01f68  75 05                jne loc_1f6f
01f6a  b3 01                mov bl, 1
01f6c  eb 03                jmp loc_1f71
; ---- 1 octets non atteints (1f6e-1f6e)
loc_1f6f:
01f6f  b3 07                mov bl, 7
loc_1f71:
01f71  d0 e3                shl bl, 1
01f73  32 ff                xor bh, bh
01f75  c6 06 c8 3f ff       mov byte ptr [0x3fc8], 0xff    ; pas_en_file
01f7a  80 7c 07 00          cmp byte ptr [si + 7], 0
01f7e  74 1c                je loc_1f9c
01f80  c6 06 c8 3f 03       mov byte ptr [0x3fc8], 3    ; pas_en_file
01f85  c7 06 cc 3f d0 29    mov word ptr [0x3fcc], 0x29d0    ; prochain_pas
01f8b  8b 8f d9 a1          mov cx, word ptr [bx - 0x5e27]
01f8f  80 3e b7 3f 00       cmp byte ptr [0x3fb7], 0    ; attaque_a_distance
01f94  74 20                je loc_1fb6
01f96  8b 8f f9 a1          mov cx, word ptr [bx - 0x5e07]
01f9a  eb 1a                jmp loc_1fb6
loc_1f9c:
01f9c  8b 8f e9 a1          mov cx, word ptr [bx - 0x5e17]
01fa0  c7 06 cc 3f 86 28    mov word ptr [0x3fcc], 0x2886    ; prochain_pas
01fa6  c6 06 c8 3f 06       mov byte ptr [0x3fc8], 6    ; pas_en_file
01fab  80 3e b7 3f 00       cmp byte ptr [0x3fb7], 0    ; attaque_a_distance
01fb0  74 04                je loc_1fb6
01fb2  8b 8f 09 a2          mov cx, word ptr [bx - 0x5df7]
loc_1fb6:
01fb6  8b 9f b7 a1          mov bx, word ptr [bx - 0x5e49]
01fba  c6 06 b7 3f 00       mov byte ptr [0x3fb7], 0    ; attaque_a_distance
loc_1fbf:
01fbf  c7 06 f7 37 f4 01    mov word ptr [0x37f7], 0x1f4
01fc5  89 0e ed 37          mov word ptr [0x37ed], cx    ; ligne_carte
01fc9  89 16 f1 37          mov word ptr [0x37f1], dx
01fcd  53                   push bx
01fce  e8 f0 45             call init_sprites_icones
01fd1  5b                   pop bx
01fd2  89 1e ed 4b          mov word ptr [0x4bed], bx
01fd6  a1 29 5e             mov ax, word ptr [0x5e29]    ; seg_monsters
01fd9  a3 e5 4b             mov word ptr [0x4be5], ax
01fdc  a1 27 5e             mov ax, word ptr [0x5e27]    ; seg_annexe
01fdf  81 3e f1 37 a4 a3    cmp word ptr [0x37f1], 0xa3a4    ; sequence_arme_lancee
01fe5  75 19                jne loc_2000
01fe7  c7 06 d6 4b e6 8e    mov word ptr [0x4bd6], 0x8ee6
01fed  c6 06 cc 4b 10       mov byte ptr [0x4bcc], 0x10
01ff2  c6 06 cd 4b 10       mov byte ptr [0x4bcd], 0x10
01ff7  c7 06 d2 4b 20 2f    mov word ptr [0x4bd2], 0x2f20
01ffd  a1 2d 5e             mov ax, word ptr [0x5e2d]    ; seg_odds
loc_2000:
02000  a3 ce 4b             mov word ptr [0x4bce], ax
loc_2003:
02003  e8 92 45             call restaure_tampon_combat
02006  be dd 4b             mov si, 0x4bdd
02009  8b 3e ed 37          mov di, word ptr [0x37ed]    ; ligne_carte
0200d  8a 1d                mov bl, byte ptr [di]
0200f  80 fb ff             cmp bl, 0xff
02012  74 1d                je loc_2031
02014  ff 06 ed 37          inc word ptr [0x37ed]    ; ligne_carte
02018  80 fb 7d             cmp bl, 0x7d
0201b  74 17                je loc_2034
0201d  32 ff                xor bh, bh
0201f  d1 e3                shl bx, 1
02021  d1 e3                shl bx, 1
02023  8b 87 38 4f          mov ax, word ptr [bx + 0x4f38]    ; images_personnages
02027  89 44 06             mov word ptr [si + 6], ax
0202a  8b 87 3a 4f          mov ax, word ptr [bx + 0x4f3a]
0202e  89 44 0c             mov word ptr [si + 0xc], ax
loc_2031:
02031  e8 ad 37             call dessine_sprite
loc_2034:
02034  8b 3e f1 37          mov di, word ptr [0x37f1]
02038  8a 1d                mov bl, byte ptr [di]
0203a  be c6 4b             mov si, 0x4bc6    ; sprites
0203d  80 fb ff             cmp bl, 0xff
02040  75 06                jne loc_2048
02042  8a 5d ff             mov bl, byte ptr [di - 1]
02045  eb 05                jmp loc_204c
; ---- 1 octets non atteints (2047-2047)
loc_2048:
02048  ff 06 f1 37          inc word ptr [0x37f1]
loc_204c:
0204c  80 fb 7d             cmp bl, 0x7d
0204f  74 28                je loc_2079
02051  80 fb fe             cmp bl, 0xfe
02054  75 07                jne loc_205d
02056  81 6c 10 f8 04       sub word ptr [si + 0x10], 0x4f8
0205b  eb 19                jmp loc_2076
loc_205d:
0205d  32 ff                xor bh, bh
0205f  d1 e3                shl bx, 1
02061  8b 87 3b a1          mov ax, word ptr [bx - 0x5ec5]
02065  89 44 06             mov word ptr [si + 6], ax
02068  8b 87 79 a1          mov ax, word ptr [bx - 0x5e87]
0206c  89 44 10             mov word ptr [si + 0x10], ax
0206f  8b 87 fd a0          mov ax, word ptr [bx - 0x5f03]
02073  89 44 0c             mov word ptr [si + 0xc], ax
loc_2076:
02076  e8 68 37             call dessine_sprite
loc_2079:
02079  e8 9c 44             call affiche_valeurs_fiche
0207c  e8 65 40             call affiche_tampon
0207f  fe 0e c8 3f          dec byte ptr [0x3fc8]    ; pas_en_file
02083  75 05                jne loc_208a
02085  bb cc 3f             mov bx, 0x3fcc
02088  ff 17                call word ptr [bx]
loc_208a:
0208a  8b 0e f7 37          mov cx, word ptr [0x37f7]
0208e  e8 f6 25             call temporise
02091  c7 06 f7 37 32 00    mov word ptr [0x37f7], 0x32
02097  8b 1e ed 37          mov bx, word ptr [0x37ed]    ; ligne_carte
0209b  80 3f ff             cmp byte ptr [bx], 0xff
0209e  74 03                je loc_20a3
020a0  e9 60 ff             jmp loc_2003
loc_20a3:
020a3  8b 1e f1 37          mov bx, word ptr [0x37f1]
020a7  80 3f ff             cmp byte ptr [bx], 0xff
020aa  74 03                je loc_20af
020ac  e9 54 ff             jmp loc_2003
loc_20af:
020af  c6 06 c8 3f 00       mov byte ptr [0x3fc8], 0    ; pas_en_file
020b4  c7 06 cc 3f 00 00    mov word ptr [0x3fcc], 0    ; prochain_pas
020ba  c3                   ret

; ======== animation_attaque_monstre   (appelée depuis 1efd)
; gros plan d'un monstre qui frappe : séquence du héros DS:A3AC (survit) ou DS:A3D9 (points de corps à 0), séquence du monstre DS:A1C9 par classe, puis suite d'animation_combat (0x1FBF)
020bb  8b 36 d6 3f          mov si, word ptr [0x3fd6]    ; attaquant
020bf  8a 54 19             mov dl, byte ptr [si + 0x19]
020c2  d0 e2                shl dl, 1
020c4  32 f6                xor dh, dh
020c6  89 16 e9 37          mov word ptr [0x37e9], dx    ; erreur_fichier
020ca  bb ac a3             mov bx, 0xa3ac    ; sequences_heros_touche
020cd  80 7c 06 00          cmp byte ptr [si + 6], 0
020d1  75 03                jne loc_20d6
020d3  bb d9 a3             mov bx, 0xa3d9    ; sequences_heros_mort
loc_20d6:
020d6  03 da                add bx, dx
020d8  8b 17                mov dx, word ptr [bx]
020da  8b 36 d4 3f          mov si, word ptr [0x3fd4]    ; cible
020de  8a 5c 08             mov bl, byte ptr [si + 8]
020e1  80 fb 07             cmp bl, 7
020e4  76 0c                jbe loc_20f2
020e6  80 fb 09             cmp bl, 9
020e9  75 05                jne loc_20f0
020eb  b3 01                mov bl, 1
020ed  eb 03                jmp loc_20f2
; ---- 1 octets non atteints (20ef-20ef)
loc_20f0:
020f0  b3 07                mov bl, 7
loc_20f2:
020f2  d0 e3                shl bl, 1
020f4  32 ff                xor bh, bh
020f6  8b 8f c9 a1          mov cx, word ptr [bx - 0x5e37]
020fa  bf c9 a1             mov di, 0xa1c9    ; sequences_monstre_attaque
020fd  8b 9f b7 a1          mov bx, word ptr [bx - 0x5e49]
02101  c6 06 c8 3f 04       mov byte ptr [0x3fc8], 4    ; pas_en_file
02106  c7 06 cc 3f 86 28    mov word ptr [0x3fcc], 0x2886    ; prochain_pas
0210c  80 7c 06 00          cmp byte ptr [si + 6], 0
02110  74 0b                je loc_211d
02112  c6 06 c8 3f 03       mov byte ptr [0x3fc8], 3    ; pas_en_file
02117  c7 06 cc 3f d0 29    mov word ptr [0x3fcc], 0x29d0    ; prochain_pas
loc_211d:
0211d  e9 9f fe             jmp loc_1fbf

; ======== retire_monstre   (appelée depuis 09b9, 10aa, 4cbd, 4d4f)
; efface le monstre SI et appelle sa routine de mort (types_monstres +3)
02120  80 64 07 0f          and byte ptr [si + 7], 0xf
02124  c6 04 00             mov byte ptr [si], 0
02127  c6 44 06 00          mov byte ptr [si + 6], 0
0212b  8b 5c 04             mov bx, word ptr [si + 4]
0212e  c6 87 00 04 00       mov byte ptr [bx + 0x400], 0
02133  8a 5c 09             mov bl, byte ptr [si + 9]
02136  02 db                add bl, bl
02138  02 db                add bl, bl
0213a  02 5c 09             add bl, byte ptr [si + 9]
0213d  b7 00                mov bh, 0
0213f  83 bf 09 48 00       cmp word ptr [bx + 0x4809], 0
02144  75 01                jne loc_2147
02146  c3                   ret
loc_2147:
02147  8d 9f 09 48          lea bx, [bx + 0x4809]
0214b  ff 27                jmp word ptr [bx]

; ======== calcule_attaque_heros   (appelée depuis 08a2)
; +0x14 ou l'arme en main, poison d'orc, lame de l'esprit -> DS:3FB8
0214d  8b 3e 37 46          mov di, word ptr [0x4637]    ; fiche_heros_courant
02151  8a 45 14             mov al, byte ptr [di + 0x14]
02154  a2 b8 3f             mov byte ptr [0x3fb8], al    ; des_attaque_heros
02157  b9 07 00             mov cx, 7
0215a  8a 65 11             mov ah, byte ptr [di + 0x11]
loc_215d:
0215d  f6 c4 01             test ah, 1
02160  75 41                jne loc_21a3
02162  d0 ec                shr ah, 1
02164  e2 f7                loop loc_215d
02166  8a 4d 12             mov cl, byte ptr [di + 0x12]
02169  f6 c1 08             test cl, 8
0216c  74 0b                je loc_2179
0216e  c6 06 b7 3f 00       mov byte ptr [0x3fb7], 0    ; attaque_a_distance
02173  c6 06 b8 3f 02       mov byte ptr [0x3fb8], 2    ; des_attaque_heros
02178  c3                   ret
loc_2179:
02179  f6 c1 10             test cl, 0x10
0217c  75 01                jne loc_217f
0217e  c3                   ret
loc_217f:
0217f  8b 36 d4 3f          mov si, word ptr [0x3fd4]    ; cible
02183  c6 06 b7 3f 00       mov byte ptr [0x3fb7], 0    ; attaque_a_distance
02188  8a 44 08             mov al, byte ptr [si + 8]
0218b  3c 04                cmp al, 4
0218d  74 0e                je loc_219d
0218f  3c 05                cmp al, 5
02191  74 0a                je loc_219d
02193  3c 06                cmp al, 6
02195  74 06                je loc_219d
02197  c6 06 b8 3f 03       mov byte ptr [0x3fb8], 3    ; des_attaque_heros
0219c  c3                   ret
loc_219d:
0219d  c6 06 b8 3f 04       mov byte ptr [0x3fb8], 4    ; des_attaque_heros
021a2  c3                   ret
loc_21a3:
021a3  49                   dec cx
021a4  8b d9                mov bx, cx
021a6  8a c8                mov cl, al
021a8  8a 87 ff 47          mov al, byte ptr [bx + 0x47ff]    ; des_armes
021ac  24 03                and al, 3
021ae  75 01                jne loc_21b1
021b0  c3                   ret
loc_21b1:
021b1  fe c0                inc al
021b3  a2 b8 3f             mov byte ptr [0x3fb8], al    ; des_attaque_heros
021b6  c3                   ret

; ======== de_combat   (appelée depuis 0967, 0f76, 0f82, 0fbc, 0fe1, 1ea1, 25c8, 25df)
; face d'un dé de combat dans BL : 0 crâne, 1 bouclier blanc, 2 bouclier noir
021b7  e8 79 3e             call de6_moins_un
021ba  32 ff                xor bh, bh
021bc  8a 9f f9 47          mov bl, byte ptr [bx + 0x47f9]    ; faces_de
021c0  c3                   ret

; ======== tour_morcar   (appelée depuis 02ad)
; joue les 32 monstres (DS:4D4A), en vérifiant la fin de quête après chacun
021c1  e8 0c 35             call plateau_ciblage
021c4  bf 4a 4d             mov di, 0x4d4a    ; monstres
021c7  b1 20                mov cl, 0x20
021c9  32 ed                xor ch, ch
loc_21cb:
021cb  51                   push cx
021cc  57                   push di
021cd  e8 47 00             call tour_monstre
021d0  5f                   pop di
021d1  59                   pop cx
021d2  e8 df e4             call quete_continue
021d5  0a c0                or al, al
021d7  75 01                jne loc_21da
021d9  c3                   ret
loc_21da:
021da  83 c7 0a             add di, 0xa
021dd  e2 ec                loop loc_21cb
021df  b9 2c 01             mov cx, 0x12c
021e2  e8 a2 24             call temporise
021e5  e8 cc e4             call quete_continue
021e8  0a c0                or al, al
021ea  75 01                jne loc_21ed
021ec  c3                   ret
loc_21ed:
021ed  c6 06 9d 3f 00       mov byte ptr [0x3f9d], 0    ; cible_validee
021f2  c6 06 e9 3f 00       mov byte ptr [0x3fe9], 0    ; sans_sprites
021f7  c7 06 f1 47 20 2c    mov word ptr [0x47f1], 0x2c20
021fd  80 26 7b 46 fe       and byte ptr [0x467b], 0xfe
02202  80 26 95 46 fe       and byte ptr [0x4695], 0xfe
02207  80 26 af 46 fe       and byte ptr [0x46af], 0xfe
0220c  80 26 c9 46 fe       and byte ptr [0x46c9], 0xfe
02211  80 26 e3 46 fe       and byte ptr [0x46e3], 0xfe
02216  c3                   ret

; ======== tour_monstre   (appelée depuis 21cd)
; un monstre (DI = son enregistrement de 10 octets)
02217  8a 05                mov al, byte ptr [di]
02219  0a c0                or al, al
0221b  75 01                jne loc_221e
0221d  c3                   ret
loc_221e:
0221e  a8 80                test al, 0x80
02220  74 01                je loc_2223
02222  c3                   ret
loc_2223:
02223  80 3e 92 3f 10       cmp byte ptr [0x3f92], 0x10    ; numero_quete
02228  74 60                je loc_228a
0222a  f6 45 06 01          test byte ptr [di + 6], 1
0222e  75 01                jne loc_2231
02230  c3                   ret
loc_2231:
02231  57                   push di
02232  e8 1b f8             call dessine_carte
02235  e8 ac 3e             call affiche_tampon
02238  5f                   pop di
02239  f6 45 06 04          test byte ptr [di + 6], 4
0223d  74 0d                je loc_224c
0223f  e8 f1 3d             call de6_moins_un
02242  80 fb 05             cmp bl, 5
02245  74 01                je loc_2248
02247  c3                   ret
loc_2248:
02248  80 65 06 fb          and byte ptr [di + 6], 0xfb
loc_224c:
0224c  f6 45 06 02          test byte ptr [di + 6], 2
02250  74 05                je loc_2257
02252  80 65 06 fd          and byte ptr [di + 6], 0xfd
02256  c3                   ret
loc_2257:
02257  be 63 46             mov si, 0x4663    ; fiches_personnages
0225a  b9 05 00             mov cx, 5
loc_225d:
0225d  51                   push cx
0225e  89 36 d6 3f          mov word ptr [0x3fd6], si    ; attaquant
02262  8a 44 19             mov al, byte ptr [si + 0x19]
02265  a2 bc 3f             mov byte ptr [0x3fbc], al
02268  e8 58 00             call monstre_vise
0226b  59                   pop cx
0226c  8b 36 d6 3f          mov si, word ptr [0x3fd6]    ; attaquant
02270  83 c6 1a             add si, 0x1a
02273  80 3e a8 3f 00       cmp byte ptr [0x3fa8], 0    ; resultat_vise
02278  75 03                jne loc_227d
0227a  e9 51 02             jmp monstre_avance
loc_227d:
0227d  80 3e a8 3f 03       cmp byte ptr [0x3fa8], 3    ; resultat_vise
02282  75 03                jne loc_2287
02284  e9 47 02             jmp monstre_avance
loc_2287:
02287  e2 d4                loop loc_225d
02289  c3                   ret
loc_228a:
0228a  f6 45 06 01          test byte ptr [di + 6], 1
0228e  75 a1                jne loc_2231
02290  f6 45 06 80          test byte ptr [di + 6], 0x80
02294  75 01                jne loc_2297
02296  c3                   ret
loc_2297:
02297  b9 06 00             mov cx, 6
loc_229a:
0229a  51                   push cx
0229b  8a 1e e6 3f          mov bl, byte ptr [0x3fe6]    ; pas_brume
0229f  d0 e3                shl bl, 1
022a1  32 ff                xor bh, bh
022a3  ff 97 57 46          call word ptr [bx + 0x4657]    ; circuit_brume
022a7  57                   push di
022a8  e8 a5 f7             call dessine_carte
022ab  5f                   pop di
022ac  57                   push di
022ad  e8 8f 02             call marque_case
022b0  5f                   pop di
022b1  57                   push di
022b2  e8 81 09             call brume_de_mort
022b5  b9 96 00             mov cx, 0x96
022b8  e8 cc 23             call temporise
022bb  5f                   pop di
022bc  59                   pop cx
022bd  e2 db                loop loc_229a
022bf  e8 8e f7             call dessine_carte
022c2  c3                   ret

; ======== monstre_vise   (appelée depuis 2268)
; chemin en L du monstre DI vers le personnage SI (pas en DS:40A2) ; DS:3FA8 = 0 attaque possible, 2 bloqué
022c3  c6 06 a8 3f 00       mov byte ptr [0x3fa8], 0    ; resultat_vise
022c8  80 3c 00             cmp byte ptr [si], 0
022cb  75 03                jne loc_22d0
022cd  e9 81 01             jmp loc_2451
loc_22d0:
022d0  8a 44 03             mov al, byte ptr [si + 3]
022d3  3a 45 03             cmp al, byte ptr [di + 3]
022d6  74 03                je loc_22db
022d8  e9 76 01             jmp loc_2451
loc_22db:
022db  f6 44 18 01          test byte ptr [si + 0x18], 1
022df  74 03                je loc_22e4
022e1  e9 6d 01             jmp loc_2451
loc_22e4:
022e4  8b 54 01             mov dx, word ptr [si + 1]
022e7  52                   push dx
022e8  57                   push di
022e9  e8 64 f7             call dessine_carte
022ec  5f                   pop di
022ed  57                   push di
022ee  e8 4e 02             call marque_case
022f1  e8 f0 3d             call affiche_tampon
022f4  b9 f4 01             mov cx, 0x1f4
022f7  e8 8d 23             call temporise
022fa  5f                   pop di
022fb  5a                   pop dx
022fc  88 16 a5 3f          mov byte ptr [0x3fa5], dl    ; trace_x
02300  88 36 a6 3f          mov byte ptr [0x3fa6], dh    ; trace_y
02304  bb a2 40             mov bx, 0x40a2    ; chemin_monstre
02307  89 1e ca 40          mov word ptr [0x40ca], bx
0230b  e8 70 3d             call index_case
0230e  81 c3 6f 54          add bx, 0x546f    ; grille_zones
02312  8a 07                mov al, byte ptr [bx]
02314  24 3f                and al, 0x3f
02316  3a 45 03             cmp al, byte ptr [di + 3]
02319  74 03                je loc_231e
0231b  e9 33 01             jmp loc_2451
loc_231e:
0231e  b5 01                mov ch, 1
02320  a0 a5 3f             mov al, byte ptr [0x3fa5]    ; trace_x
02323  2a 45 01             sub al, byte ptr [di + 1]
02326  75 04                jne loc_232c
02328  b5 00                mov ch, 0
0232a  eb 08                jmp loc_2334
loc_232c:
0232c  3c 80                cmp al, 0x80
0232e  72 04                jb loc_2334
02330  f6 d8                neg al
02332  b5 ff                mov ch, 0xff
loc_2334:
02334  a2 a1 3f             mov byte ptr [0x3fa1], al    ; trace_dx
02337  88 2e a3 3f          mov byte ptr [0x3fa3], ch
0233b  b5 01                mov ch, 1
0233d  a0 a6 3f             mov al, byte ptr [0x3fa6]    ; trace_y
02340  2a 45 02             sub al, byte ptr [di + 2]
02343  75 04                jne loc_2349
02345  b5 00                mov ch, 0
02347  eb 08                jmp loc_2351
loc_2349:
02349  3c 80                cmp al, 0x80
0234b  72 04                jb loc_2351
0234d  f6 d8                neg al
0234f  b5 ff                mov ch, 0xff
loc_2351:
02351  a2 a2 3f             mov byte ptr [0x3fa2], al    ; trace_dy
02354  88 2e a4 3f          mov byte ptr [0x3fa4], ch
02358  8b 55 01             mov dx, word ptr [di + 1]
0235b  89 16 9f 3f          mov word ptr [0x3f9f], dx    ; trace_erreur
0235f  c6 06 a9 3f 00       mov byte ptr [0x3fa9], 0    ; longueur_chemin
02364  8a 5d 09             mov bl, byte ptr [di + 9]
02367  02 db                add bl, bl
02369  02 db                add bl, bl
0236b  02 5d 09             add bl, byte ptr [di + 9]
0236e  32 ff                xor bh, bh
02370  8a 87 06 48          mov al, byte ptr [bx + 0x4806]    ; types_monstres
02374  a2 9c 3f             mov byte ptr [0x3f9c], al    ; deplacement_restant
02377  8a 0e a2 3f          mov cl, byte ptr [0x3fa2]    ; trace_dy
0237b  a0 a1 3f             mov al, byte ptr [0x3fa1]    ; trace_dx
0237e  3a c1                cmp al, cl
02380  72 03                jb loc_2385
02382  eb 6a                jmp loc_23ee
; ---- 1 octets non atteints (2384-2384)
loc_2385:
02385  8b 16 9f 3f          mov dx, word ptr [0x3f9f]    ; trace_erreur
02389  38 36 a6 3f          cmp byte ptr [0x3fa6], dh    ; trace_y
0238d  74 25                je loc_23b4
0238f  a0 a4 3f             mov al, byte ptr [0x3fa4]
02392  0a c0                or al, al
02394  74 1e                je loc_23b4
02396  02 f0                add dh, al
02398  e8 dd 00             call case_cible
0239b  3c ff                cmp al, 0xff
0239d  75 03                jne loc_23a2
0239f  e9 b5 00             jmp loc_2457
loc_23a2:
023a2  0a c0                or al, al
023a4  75 0e                jne loc_23b4
023a6  8a 26 a4 3f          mov ah, byte ptr [0x3fa4]
023aa  e8 b0 00             call pas_chemin
023ad  73 03                jae loc_23b2
023af  e9 99 00             jmp loc_244b
loc_23b2:
023b2  eb d1                jmp loc_2385
loc_23b4:
023b4  8b 16 9f 3f          mov dx, word ptr [0x3f9f]    ; trace_erreur
023b8  a0 a5 3f             mov al, byte ptr [0x3fa5]    ; trace_x
023bb  3a c2                cmp al, dl
023bd  75 03                jne loc_23c2
023bf  e9 8f 00             jmp loc_2451
loc_23c2:
023c2  a0 a3 3f             mov al, byte ptr [0x3fa3]
023c5  0a c0                or al, al
023c7  75 03                jne loc_23cc
023c9  e9 85 00             jmp loc_2451
loc_23cc:
023cc  02 d0                add dl, al
023ce  e8 a7 00             call case_cible
023d1  3c ff                cmp al, 0xff
023d3  75 03                jne loc_23d8
023d5  e9 7f 00             jmp loc_2457
loc_23d8:
023d8  0a c0                or al, al
023da  74 03                je loc_23df
023dc  eb 73                jmp loc_2451
; ---- 1 octets non atteints (23de-23de)
loc_23df:
023df  a0 a3 3f             mov al, byte ptr [0x3fa3]
023e2  32 e4                xor ah, ah
023e4  e8 76 00             call pas_chemin
023e7  73 03                jae loc_23ec
023e9  eb 60                jmp loc_244b
; ---- 1 octets non atteints (23eb-23eb)
loc_23ec:
023ec  eb 97                jmp loc_2385
loc_23ee:
023ee  8b 16 9f 3f          mov dx, word ptr [0x3f9f]    ; trace_erreur
023f2  a0 a5 3f             mov al, byte ptr [0x3fa5]    ; trace_x
023f5  3a c2                cmp al, dl
023f7  74 26                je loc_241f
023f9  a0 a3 3f             mov al, byte ptr [0x3fa3]
023fc  0a c0                or al, al
023fe  74 1f                je loc_241f
02400  02 d0                add dl, al
02402  e8 73 00             call case_cible
02405  3c ff                cmp al, 0xff
02407  75 03                jne loc_240c
02409  eb 4c                jmp loc_2457
; ---- 1 octets non atteints (240b-240b)
loc_240c:
0240c  0a c0                or al, al
0240e  75 0f                jne loc_241f
02410  a0 a3 3f             mov al, byte ptr [0x3fa3]
02413  32 e4                xor ah, ah
02415  e8 45 00             call pas_chemin
02418  73 03                jae loc_241d
0241a  eb 2f                jmp loc_244b
; ---- 1 octets non atteints (241c-241c)
loc_241d:
0241d  eb cf                jmp loc_23ee
loc_241f:
0241f  8b 16 9f 3f          mov dx, word ptr [0x3f9f]    ; trace_erreur
02423  38 36 a6 3f          cmp byte ptr [0x3fa6], dh    ; trace_y
02427  74 28                je loc_2451
02429  a0 a4 3f             mov al, byte ptr [0x3fa4]
0242c  0a c0                or al, al
0242e  74 21                je loc_2451
02430  02 f0                add dh, al
02432  e8 43 00             call case_cible
02435  3c ff                cmp al, 0xff
02437  74 1e                je loc_2457
02439  0a c0                or al, al
0243b  75 14                jne loc_2451
0243d  8a 26 a4 3f          mov ah, byte ptr [0x3fa4]
02441  e8 19 00             call pas_chemin
02444  73 03                jae loc_2449
02446  eb 03                jmp loc_244b
; ---- 1 octets non atteints (2448-2448)
loc_2449:
02449  eb a3                jmp loc_23ee
loc_244b:
0244b  c6 06 a8 3f 01       mov byte ptr [0x3fa8], 1    ; resultat_vise
02450  c3                   ret
loc_2451:
02451  c6 06 a8 3f 02       mov byte ptr [0x3fa8], 2    ; resultat_vise
02456  c3                   ret
loc_2457:
02457  c6 06 a8 3f 00       mov byte ptr [0x3fa8], 0    ; resultat_vise
0245c  c3                   ret

; ======== pas_chemin   (appelée depuis 23aa, 23e4, 2415, 2441)
; ajoute le pas (AL, AH) au chemin du monstre
0245d  89 16 9f 3f          mov word ptr [0x3f9f], dx    ; trace_erreur
02461  8b 1e ca 40          mov bx, word ptr [0x40ca]
02465  88 07                mov byte ptr [bx], al
02467  88 67 01             mov byte ptr [bx + 1], ah
0246a  83 06 ca 40 02       add word ptr [0x40ca], 2
0246f  fe 06 a9 3f          inc byte ptr [0x3fa9]    ; longueur_chemin
02473  fe 0e 9c 3f          dec byte ptr [0x3f9c]    ; deplacement_restant
02477  c3                   ret

; ======== case_cible   (appelée depuis 2398, 23ce, 2402, 2432)
; AL = FFh si DX est la case du personnage visé, sinon case_libre
02478  a0 bc 3f             mov al, byte ptr [0x3fbc]
0247b  e8 01 39             call fiche_personnage
0247e  80 3c 00             cmp byte ptr [si], 0
02481  74 08                je case_libre
02483  3b 54 01             cmp dx, word ptr [si + 1]
02486  75 03                jne case_libre
02488  b0 ff                mov al, 0xff
0248a  c3                   ret

; ======== case_libre   (appelée depuis 2619, 2656, 6c7f)
; AL = 0 libre, 1 un héros, 2 un occupant, 3 autre zone (case DX, zone du monstre DI)
0248b  b5 00                mov ch, 0
loc_248d:
0248d  38 2e bc 3f          cmp byte ptr [0x3fbc], ch
02491  74 12                je loc_24a5
02493  8a c5                mov al, ch
02495  e8 e7 38             call fiche_personnage
02498  80 3c 00             cmp byte ptr [si], 0
0249b  74 08                je loc_24a5
0249d  3b 54 01             cmp dx, word ptr [si + 1]
024a0  75 03                jne loc_24a5
024a2  b0 01                mov al, 1
024a4  c3                   ret
loc_24a5:
024a5  fe c5                inc ch
024a7  80 fd 04             cmp ch, 4
024aa  75 e1                jne loc_248d
024ac  52                   push dx
024ad  e8 ce 3b             call index_case
024b0  5a                   pop dx
024b1  81 c3 6f 58          add bx, 0x586f    ; grille_occupants
024b5  80 3f 00             cmp byte ptr [bx], 0
024b8  74 03                je loc_24bd
024ba  b0 02                mov al, 2
024bc  c3                   ret
loc_24bd:
024bd  8a 87 00 fc          mov al, byte ptr [bx - 0x400]
024c1  24 3f                and al, 0x3f
024c3  3a 45 03             cmp al, byte ptr [di + 3]
024c6  75 03                jne loc_24cb
024c8  32 c0                xor al, al
024ca  c3                   ret
loc_24cb:
024cb  b0 03                mov al, 3
024cd  c3                   ret
monstre_avance:    ; déplace le monstre pas à pas sur le chemin calculé
024ce  89 3e d4 3f          mov word ptr [0x3fd4], di    ; cible
024d2  8a 0e a9 3f          mov cl, byte ptr [0x3fa9]    ; longueur_chemin
024d6  0a c9                or cl, cl
024d8  74 55                je loc_252f
024da  32 ed                xor ch, ch
024dc  bb a2 40             mov bx, 0x40a2    ; chemin_monstre
024df  89 1e ca 40          mov word ptr [0x40ca], bx
loc_24e3:
024e3  51                   push cx
024e4  8b 3e d4 3f          mov di, word ptr [0x3fd4]    ; cible
024e8  8b 55 01             mov dx, word ptr [di + 1]
024eb  e8 90 3b             call index_case
024ee  8a 8f 6f 58          mov cl, byte ptr [bx + 0x586f]    ; grille_occupants
024f2  c6 87 6f 58 00       mov byte ptr [bx + 0x586f], 0    ; grille_occupants
024f7  8b 1e ca 40          mov bx, word ptr [0x40ca]
024fb  8b 55 01             mov dx, word ptr [di + 1]
024fe  02 17                add dl, byte ptr [bx]
02500  02 77 01             add dh, byte ptr [bx + 1]
02503  89 55 01             mov word ptr [di + 1], dx
02506  83 06 ca 40 02       add word ptr [0x40ca], 2
0250b  e8 70 3b             call index_case
0250e  88 8f 6f 58          mov byte ptr [bx + 0x586f], cl    ; grille_occupants
02512  81 c3 6f 54          add bx, 0x546f    ; grille_zones
02516  89 5d 04             mov word ptr [di + 4], bx
02519  e8 34 f5             call dessine_carte
0251c  8b 3e d4 3f          mov di, word ptr [0x3fd4]    ; cible
02520  e8 1c 00             call marque_case
02523  e8 be 3b             call affiche_tampon
02526  b9 f4 01             mov cx, 0x1f4
02529  e8 5b 21             call temporise
0252c  59                   pop cx
0252d  e2 b4                loop loc_24e3
loc_252f:
0252f  51                   push cx
02530  b9 32 00             mov cx, 0x32
loc_2533:
02533  e8 6a 11             call attend_retour_vertical
02536  e2 fb                loop loc_2533
02538  59                   pop cx
02539  e8 53 f8             call combat_monstre
0253c  e9 91 31             jmp plateau_ciblage

; ======== marque_case   (appelée depuis 22ad, 22ee, 2520)
; cadre ODDS&SOD 0x6320 (24 × 24) sur la case du monstre DI
0253f  8a 45 02             mov al, byte ptr [di + 2]
02542  32 e4                xor ah, ah
02544  ba 00 0a             mov dx, 0xa00    ; "AND TRY AGAIN"
02547  f7 e2                mul dx
02549  8b d8                mov bx, ax
0254b  8a 45 01             mov al, byte ptr [di + 1]
0254e  b2 08                mov dl, 8
02550  f6 e2                mul dl
02552  03 c3                add ax, bx
02554  05 30 0a             add ax, 0xa30
02557  be 20 63             mov si, 0x6320
0255a  8b f8                mov di, ax
0255c  a1 2d 5e             mov ax, word ptr [0x5e2d]    ; seg_odds
0255f  a3 4e 37             mov word ptr [0x374e], ax    ; segment_source
02562  50                   push ax
02563  b8 63 14             mov ax, 0x1463
02566  8e c0                mov es, ax
02568  58                   pop ax
02569  bd 18 00             mov bp, 0x18
0256c  b9 18 00             mov cx, 0x18
0256f  1e                   push ds
02570  e8 e0 15             call copie_image
02573  1f                   pop ds
02574  c3                   ret
declenche_piege:    ; applique le piège DS:3FC2 au héros courant ; 1 fosse cachée
02575  8b 36 39 46          mov si, word ptr [0x4639]    ; sprite_courant
02579  80 3c 02             cmp byte ptr [si], 2
0257c  75 01                jne loc_257f
0257e  c3                   ret
loc_257f:
0257f  a0 c2 3f             mov al, byte ptr [0x3fc2]    ; piege_en_cours
02582  0a c0                or al, al
02584  75 01                jne loc_2587
02586  c3                   ret
loc_2587:
02587  3c 01                cmp al, 1
02589  75 34                jne piege_des
0258b  c6 06 c2 3f 00       mov byte ptr [0x3fc2], 0    ; piege_en_cours
loc_2590:
02590  be 20 01             mov si, 0x120
loc_2593:
02593  e8 11 05             call son_piege
02596  8b 3e 37 46          mov di, word ptr [0x4637]    ; fiche_heros_courant
0259a  fe 4d 06             dec byte ptr [di + 6]
0259d  8b de                mov bx, si
0259f  e8 4b 63             call affiche_message
025a2  e8 80 f2             call redessine_plateau
025a5  e8 b6 40             call pause_150
025a8  e8 2c 01             call arrete_deplacement
025ab  a0 a7 3f             mov al, byte ptr [0x3fa7]    ; personnage_courant
025ae  a2 ca 3f             mov byte ptr [0x3fca], al    ; heros_courant
025b1  8b 36 37 46          mov si, word ptr [0x4637]    ; fiche_heros_courant
025b5  80 7c 06 00          cmp byte ptr [si + 6], 0
025b9  75 03                jne loc_25be
025bb  e9 14 eb             jmp loc_10d2
loc_25be:
025be  c3                   ret

; ======== piege_des
; effet du piège DS:3FC2 : 2 fosse connue, 3 lance, 4 chute de pierre
025bf  3c 02                cmp al, 2
025c1  75 13                jne loc_25d6
025c3  c6 06 c2 3f 00       mov byte ptr [0x3fc2], 0    ; piege_en_cours
025c8  e8 ec fb             call de_combat
025cb  0a db                or bl, bl
025cd  75 c1                jne loc_2590
025cf  bb 1e 01             mov bx, 0x11e    ; message « LE MECANISME DE LA TRAPPE / CRAQUE SOUS VOTRE POIDS / MAIS TIENT BON »
025d2  e8 18 63             call affiche_message
025d5  c3                   ret
loc_25d6:
025d6  3c 03                cmp al, 3
025d8  75 12                jne loc_25ec
025da  c6 06 c2 3f 00       mov byte ptr [0x3fc2], 0    ; piege_en_cours
025df  e8 d5 fb             call de_combat
025e2  0a db                or bl, bl
025e4  75 01                jne loc_25e7
025e6  c3                   ret
loc_25e7:
025e7  be 30 00             mov si, 0x30
025ea  eb a7                jmp loc_2593
loc_25ec:
025ec  c6 06 c2 3f 00       mov byte ptr [0x3fc2], 0    ; piege_en_cours
025f1  80 3e 92 3f 0b       cmp byte ptr [0x3f92], 0xb    ; numero_quete
025f6  74 34                je loc_262c
025f8  80 3e 92 3f 04       cmp byte ptr [0x3f92], 4    ; numero_quete
025fd  75 67                jne chute_maconnerie
025ff  bb 3e 00             mov bx, 0x3e    ; message « UN ROCHER TOMBE / DANS LE COULOIR ET / BOUCHE LE PASSAGE »
02602  e8 e8 62             call affiche_message
02605  e8 1d f2             call redessine_plateau
02608  e8 a5 48             call redessin_plateau
0260b  c6 06 24 59 00       mov byte ptr [0x5924], 0
02610  ba 19 07             mov dx, 0x719
02613  a0 a7 3f             mov al, byte ptr [0x3fa7]    ; personnage_courant
02616  a2 bc 3f             mov byte ptr [0x3fbc], al
02619  e8 6f fe             call case_libre
0261c  bb 3e 59             mov bx, 0x593e
0261f  3c 01                cmp al, 1
02621  75 03                jne loc_2626
02623  e9 89 00             jmp trois_des_un_point
loc_2626:
02626  c6 06 3e 59 31       mov byte ptr [0x593e], 0x31
0262b  c3                   ret
loc_262c:
0262c  a0 a7 3f             mov al, byte ptr [0x3fa7]    ; personnage_courant
0262f  a2 ca 3f             mov byte ptr [0x3fca], al    ; heros_courant
02632  e8 b3 00             call heros_absent
02635  3c 0f                cmp al, 0xf
02637  74 01                je loc_263a
02639  c3                   ret
loc_263a:
0263a  e8 9a 00             call arrete_deplacement
0263d  bb 3e 00             mov bx, 0x3e    ; message « UN ROCHER TOMBE / DANS LE COULOIR ET / BOUCHE LE PASSAGE »
02640  e8 aa 62             call affiche_message
02643  c6 06 97 3f 01       mov byte ptr [0x3f97], 1    ; vue_a_refaire
02648  c6 06 70 58 00       mov byte ptr [0x5870], 0
0264d  ba 00 00             mov dx, 0
02650  a0 a7 3f             mov al, byte ptr [0x3fa7]    ; personnage_courant
02653  a2 bc 3f             mov byte ptr [0x3fbc], al
02656  e8 32 fe             call case_libre
02659  bb 6f 58             mov bx, 0x586f    ; grille_occupants
0265c  3c 01                cmp al, 1
0265e  74 4f                je trois_des_un_point
02660  c6 06 6f 58 31       mov byte ptr [0x586f], 0x31    ; grille_occupants
02665  c3                   ret
chute_maconnerie:    ; un dé : sur un 6 et sans casque, 1 point de corps perdu
02666  e8 ca 39             call de6_moins_un
02669  8b 36 37 46          mov si, word ptr [0x4637]    ; fiche_heros_courant
0266d  56                   push si
0266e  80 fb 05             cmp bl, 5
02671  72 1d                jb loc_2690
02673  f6 44 13 02          test byte ptr [si + 0x13], 2
02677  75 17                jne loc_2690
02679  80 fb 04             cmp bl, 4
0267c  72 12                jb loc_2690
0267e  f6 44 13 02          test byte ptr [si + 0x13], 2
02682  75 0c                jne loc_2690
02684  fe 4c 06             dec byte ptr [si + 6]
02687  e8 1d 04             call son_piege
0268a  be 40 00             mov si, 0x40
0268d  eb 04                jmp loc_2693
; ---- 1 octets non atteints (268f-268f)
loc_2690:
02690  be 42 00             mov si, 0x42
loc_2693:
02693  8b de                mov bx, si
02695  e8 55 62             call affiche_message
02698  e8 8a f1             call redessine_plateau
0269b  e8 39 00             call arrete_deplacement
0269e  5e                   pop si
0269f  8b 1e ec 3f          mov bx, word ptr [0x3fec]    ; case_piege
026a3  c6 87 6f 58 31       mov byte ptr [bx + 0x586f], 0x31    ; grille_occupants
026a8  80 7c 06 00          cmp byte ptr [si + 6], 0
026ac  74 20                je loc_26ce
026ae  c3                   ret

; ======== trois_des_un_point
; trois dés lancés, un point de corps perdu ; code automodifié en 0x26C9
026af  2e 89 1e c9 26       mov word ptr cs:[0x26c9], bx
026b4  b6 03                mov dh, 3
026b6  e8 d3 36             call compte_cranes
026b9  b2 01                mov dl, 1
026bb  8a 44 06             mov al, byte ptr [si + 6]
026be  2a c2                sub al, dl
026c0  88 44 06             mov byte ptr [si + 6], al
026c3  74 03                je loc_26c8
026c5  72 01                jb loc_26c8
026c7  c3                   ret
loc_26c8:
026c8  bb 00 00             mov bx, 0
026cb  c6 07 31             mov byte ptr [bx], 0x31
loc_26ce:
026ce  8a 44 19             mov al, byte ptr [si + 0x19]
026d1  a2 ca 3f             mov byte ptr [0x3fca], al    ; heros_courant
026d4  e9 fb e9             jmp loc_10d2

; ======== arrete_deplacement   (appelée depuis 25a8, 263a, 269b)
; etat_action bit 2 (a agi), deplacement_restant = 0 ; appelée par les pièges
026d7  80 0e 9b 3f 02       or byte ptr [0x3f9b], 2    ; etat_action
026dc  c6 06 9c 3f 00       mov byte ptr [0x3f9c], 0    ; deplacement_restant
026e1  c3                   ret

; ======== heros_hors_quete   (appelée depuis 10fc, 1884, 19e7)
; pose le bit du héros DS:3FCA dans etat_quete et heros_absents
026e2  bb c6 3f             mov bx, 0x3fc6
026e5  e8 03 00             call pose_bit_heros

; ======== heros_absent   (appelée depuis 2632)
; pose le bit du héros DS:3FCA dans heros_absents seulement
026e8  bb c5 3f             mov bx, 0x3fc5

; ======== pose_bit_heros   (appelée depuis 26e5)
; pose le bit n du héros DS:3FCA (si < 4) dans l'octet BX
026eb  a0 ca 3f             mov al, byte ptr [0x3fca]    ; heros_courant
026ee  3c 04                cmp al, 4
026f0  72 01                jb loc_26f3
026f2  c3                   ret
loc_26f3:
026f3  b5 01                mov ch, 1
loc_26f5:
026f5  0a c0                or al, al
026f7  74 06                je loc_26ff
026f9  d0 e5                shl ch, 1
026fb  fe c8                dec al
026fd  eb f6                jmp loc_26f5
loc_26ff:
026ff  08 2f                or byte ptr [bx], ch
02701  c3                   ret

; ======== vue_alignee   (appelée depuis 0305, 031a, 032f, 0345, 05b8, 133b)
; cases vues dans les 4 directions depuis le héros courant jusqu'au premier mur ou porte fermée ; monstres croisés activés ; rien quand numero_quete = 9 (château des mystères)
02702  80 3e 92 3f 09       cmp byte ptr [0x3f92], 9    ; numero_quete
02707  75 01                jne loc_270a
02709  c3                   ret
loc_270a:
0270a  8b 3e 37 46          mov di, word ptr [0x4637]    ; fiche_heros_courant
0270e  bb 4f 27             mov bx, 0x274f
02711  e8 0f 00             call vue_direction
02714  bb 7a 27             mov bx, 0x277a
02717  e8 09 00             call vue_direction
0271a  bb a6 27             mov bx, 0x27a6
0271d  e8 03 00             call vue_direction
02720  bb cf 27             mov bx, 0x27cf

; ======== vue_direction   (appelée depuis 2711, 2717, 271d)
; lance la routine BX (DS:409C) depuis la case du héros ; en colonne 12 ou 13, aussi depuis l'autre colonne (couloirs centraux de 2 cases ?)
02723  8a 4d 01             mov cl, byte ptr [di + 1]
02726  89 1e 9c 40          mov word ptr [0x409c], bx    ; routine_vue
0272a  80 f9 0c             cmp cl, 0xc
0272d  75 07                jne loc_2736
0272f  e8 0e 00             call vue_depuis_case
02732  b1 0d                mov cl, 0xd
02734  eb 0a                jmp vue_depuis_case
loc_2736:
02736  80 f9 0d             cmp cl, 0xd
02739  75 05                jne vue_depuis_case
0273b  e8 02 00             call vue_depuis_case
0273e  b1 0c                mov cl, 0xc

; ======== vue_depuis_case   (appelée depuis 272f, 273b)
; CH = y du héros, BX = adresse_case, saute à la routine DS:409C
02740  8a 6d 02             mov ch, byte ptr [di + 2]
02743  51                   push cx
02744  e8 bb ee             call adresse_case
02747  59                   pop cx
02748  bd 9c 40             mov bp, 0x409c
0274b  3e ff 66 00          notrack jmp word ptr ds:[bp]
vue_haut:    ; vers le haut ; bogue : teste x = 0 au lieu de y = 0, rien vers le haut en colonne 0
0274f  e8 a7 00             call marque_case_ligne
02752  81 c3 00 02          add bx, 0x200
02756  0a c9                or cl, cl
02758  75 01                jne loc_275b
0275a  c3                   ret
loc_275b:
0275b  f6 07 80             test byte ptr [bx], 0x80
0275e  74 01                je loc_2761
02760  c3                   ret
loc_2761:
02761  f6 07 20             test byte ptr [bx], 0x20
02764  74 06                je loc_276c
02766  f6 07 04             test byte ptr [bx], 4
02769  75 01                jne loc_276c
0276b  c3                   ret
loc_276c:
0276c  83 eb 1a             sub bx, 0x1a
0276f  fe cd                dec ch
02771  e8 9c 00             call reveille_monstre_case
02774  81 eb 00 02          sub bx, 0x200
02778  eb d5                jmp vue_haut

; ======== vue_bas
; vers le bas jusqu'à y = 18
0277a  e8 7c 00             call marque_case_ligne
0277d  81 c3 00 02          add bx, 0x200
02781  80 fd 12             cmp ch, 0x12
02784  75 01                jne loc_2787
02786  c3                   ret
loc_2787:
02787  83 c3 1a             add bx, 0x1a
0278a  fe c5                inc ch
0278c  f6 07 80             test byte ptr [bx], 0x80
0278f  74 01                je loc_2792
02791  c3                   ret
loc_2792:
02792  f6 07 20             test byte ptr [bx], 0x20
02795  74 06                je loc_279d
02797  f6 07 04             test byte ptr [bx], 4
0279a  75 01                jne loc_279d
0279c  c3                   ret
loc_279d:
0279d  e8 70 00             call reveille_monstre_case
027a0  81 eb 00 02          sub bx, 0x200
027a4  eb d4                jmp vue_bas

; ======== vue_gauche
; vers la gauche jusqu'à x = 0
027a6  e8 50 00             call marque_case_ligne
027a9  81 c3 00 02          add bx, 0x200
027ad  0a c9                or cl, cl
027af  75 01                jne loc_27b2
027b1  c3                   ret
loc_27b2:
027b2  f6 07 40             test byte ptr [bx], 0x40
027b5  74 01                je loc_27b8
027b7  c3                   ret
loc_27b8:
027b8  f6 07 10             test byte ptr [bx], 0x10
027bb  74 06                je loc_27c3
027bd  f6 07 04             test byte ptr [bx], 4
027c0  75 01                jne loc_27c3
027c2  c3                   ret
loc_27c3:
027c3  4b                   dec bx
027c4  fe c9                dec cl
027c6  e8 47 00             call reveille_monstre_case
027c9  81 eb 00 02          sub bx, 0x200
027cd  eb d7                jmp vue_gauche

; ======== vue_droite
; vers la droite jusqu'à x = 25
027cf  e8 27 00             call marque_case_ligne
027d2  81 c3 00 02          add bx, 0x200
027d6  80 f9 19             cmp cl, 0x19
027d9  75 01                jne loc_27dc
027db  c3                   ret
loc_27dc:
027dc  43                   inc bx
027dd  fe c1                inc cl
027df  f6 07 40             test byte ptr [bx], 0x40
027e2  74 01                je loc_27e5
027e4  c3                   ret
loc_27e5:
027e5  f6 07 10             test byte ptr [bx], 0x10
027e8  74 06                je loc_27f0
027ea  f6 07 04             test byte ptr [bx], 4
027ed  75 01                jne loc_27f0
027ef  c3                   ret
loc_27f0:
027f0  e8 1d 00             call reveille_monstre_case
027f3  81 eb 00 02          sub bx, 0x200
027f7  eb d6                jmp vue_droite

; ======== marque_case_ligne   (appelée depuis 274f, 277a, 27a6, 27cf)
; bit 0x40 (vue) de la case, bit 0x80 de ses voisines de droite et du dessous
027f9  80 0f 40             or byte ptr [bx], 0x40
027fc  80 f9 19             cmp cl, 0x19
027ff  74 04                je loc_2805
02801  80 4f 01 80          or byte ptr [bx + 1], 0x80
loc_2805:
02805  80 fd 12             cmp ch, 0x12
02808  75 01                jne loc_280b
0280a  c3                   ret
loc_280b:
0280b  80 4f 1a 80          or byte ptr [bx + 0x1a], 0x80
0280f  c3                   ret

; ======== reveille_monstre_case   (appelée depuis 2771, 279d, 27c6, 27f0)
; monstre (code 1 à 0x2F) sur la case : octet +0 de sa fiche = 1 (actif)
02810  8a 87 00 02          mov al, byte ptr [bx + 0x200]
02814  0a c0                or al, al
02816  75 01                jne loc_2819
02818  c3                   ret
loc_2819:
02819  3c 30                cmp al, 0x30
0281b  72 01                jb loc_281e
0281d  c3                   ret
loc_281e:
0281e  53                   push bx
0281f  e8 1e e6             call adresse_monstre
02822  c6 07 01             mov byte ptr [bx], 1
02825  5b                   pop bx
02826  c3                   ret

; ======== son_porte   (appelée depuis 07de, 0807, 082d, 492a, 49f1, 4ab7, 4b82, 6e40)
; porte ouverte : morceau 3 (AdLib, MT-32), 8 (Tandy), bip sinon
02827  80 3e 99 31 01       cmp byte ptr [0x3199], 1    ; son_actif
0282c  74 01                je loc_282f
0282e  c3                   ret
loc_282f:
0282f  80 3e 92 31 00       cmp byte ptr [0x3192], 0    ; son_pilote
02834  75 22                jne loc_2858
02836  9c                   pushf
02837  50                   push ax
02838  53                   push bx
02839  51                   push cx
0283a  52                   push dx
0283b  57                   push di
0283c  56                   push si
0283d  55                   push bp
0283e  06                   push es
0283f  1e                   push ds
02840  bd 40 1f             mov bp, 0x1f40
02843  b9 20 00             mov cx, 0x20
02846  b4 06                mov ah, 6
02848  b7 05                mov bh, 5
0284a  e8 41 03             call son_bip
0284d  1f                   pop ds
0284e  07                   pop es
0284f  5d                   pop bp
02850  5e                   pop si
02851  5f                   pop di
02852  5a                   pop dx
02853  59                   pop cx
02854  5b                   pop bx
02855  58                   pop ax
02856  9d                   popf
02857  c3                   ret
loc_2858:
02858  80 3e 92 31 03       cmp byte ptr [0x3192], 3    ; son_pilote
0285d  75 09                jne loc_2868
0285f  ba 08 00             mov dx, 8
02862  b8 05 00             mov ax, 5
02865  cd 60                int 0x60
02867  c3                   ret
loc_2868:
02868  57                   push di
02869  51                   push cx
0286a  52                   push dx
0286b  8b 3e 9e 31          mov di, word ptr [0x319e]    ; son_effet_poignee
0286f  b8 04 00             mov ax, 4
02872  cd 60                int 0x60
02874  ba 03 00             mov dx, 3
02877  8b ca                mov cx, dx
02879  b8 03 00             mov ax, 3
0287c  cd 60                int 0x60
0287e  89 3e 9e 31          mov word ptr [0x319e], di    ; son_effet_poignee
02882  5a                   pop dx
02883  59                   pop cx
02884  5f                   pop di
02885  c3                   ret

; ======== son_monstre_tue   (appelée depuis 2088)
; morceau 5 ; Tandy 3
02886  80 3e 99 31 01       cmp byte ptr [0x3199], 1    ; son_actif
0288b  74 01                je loc_288e
0288d  c3                   ret
loc_288e:
0288e  80 3e 92 31 00       cmp byte ptr [0x3192], 0    ; son_pilote
02893  75 36                jne loc_28cb
02895  9c                   pushf
02896  50                   push ax
02897  53                   push bx
02898  51                   push cx
02899  52                   push dx
0289a  57                   push di
0289b  56                   push si
0289c  55                   push bp
0289d  06                   push es
0289e  1e                   push ds
0289f  b9 32 00             mov cx, 0x32
loc_28a2:
028a2  51                   push cx
028a3  bd 0a 00             mov bp, 0xa
028a6  b9 64 00             mov cx, 0x64
028a9  b4 01                mov ah, 1
028ab  b7 00                mov bh, 0
028ad  e8 de 02             call son_bip
028b0  bd 0a 00             mov bp, 0xa
028b3  b9 28 00             mov cx, 0x28
028b6  b4 02                mov ah, 2
028b8  b7 00                mov bh, 0
028ba  e8 d1 02             call son_bip
028bd  59                   pop cx
028be  e2 e2                loop loc_28a2
028c0  1f                   pop ds
028c1  07                   pop es
028c2  5d                   pop bp
028c3  5e                   pop si
028c4  5f                   pop di
028c5  5a                   pop dx
028c6  59                   pop cx
028c7  5b                   pop bx
028c8  58                   pop ax
028c9  9d                   popf
028ca  c3                   ret
loc_28cb:
028cb  80 3e 92 31 03       cmp byte ptr [0x3192], 3    ; son_pilote
028d0  75 09                jne loc_28db
028d2  ba 03 00             mov dx, 3
028d5  b8 05 00             mov ax, 5
028d8  cd 60                int 0x60
028da  c3                   ret
loc_28db:
028db  57                   push di
028dc  51                   push cx
028dd  52                   push dx
028de  8b 3e 9e 31          mov di, word ptr [0x319e]    ; son_effet_poignee
028e2  b8 04 00             mov ax, 4
028e5  cd 60                int 0x60
028e7  ba 05 00             mov dx, 5
028ea  8b ca                mov cx, dx
028ec  b8 03 00             mov ax, 3
028ef  cd 60                int 0x60
028f1  89 3e 9e 31          mov word ptr [0x319e], di    ; son_effet_poignee
028f5  5a                   pop dx
028f6  59                   pop cx
028f7  5f                   pop di
028f8  c3                   ret

; ======== son_pas   (appelée depuis 583f)
; un pas sur trois : morceau 2 ; Tandy 0
028f9  80 3e 99 31 01       cmp byte ptr [0x3199], 1    ; son_actif
028fe  74 01                je loc_2901
02900  c3                   ret
loc_2901:
02901  fe 0e 57 0e          dec byte ptr [0xe57]
02905  74 01                je loc_2908
02907  c3                   ret
loc_2908:
02908  c6 06 57 0e 03       mov byte ptr [0xe57], 3
0290d  80 3e 92 31 00       cmp byte ptr [0x3192], 0    ; son_pilote
02912  75 22                jne loc_2936
02914  9c                   pushf
02915  50                   push ax
02916  53                   push bx
02917  51                   push cx
02918  52                   push dx
02919  57                   push di
0291a  56                   push si
0291b  55                   push bp
0291c  06                   push es
0291d  1e                   push ds
0291e  bd f4 01             mov bp, 0x1f4
02921  b9 0a 00             mov cx, 0xa
02924  b4 01                mov ah, 1
02926  b7 18                mov bh, 0x18
02928  e8 63 02             call son_bip
0292b  1f                   pop ds
0292c  07                   pop es
0292d  5d                   pop bp
0292e  5e                   pop si
0292f  5f                   pop di
02930  5a                   pop dx
02931  59                   pop cx
02932  5b                   pop bx
02933  58                   pop ax
02934  9d                   popf
02935  c3                   ret
loc_2936:
02936  80 3e 92 31 03       cmp byte ptr [0x3192], 3    ; son_pilote
0293b  75 09                jne loc_2946
0293d  ba 00 00             mov dx, 0
02940  b8 05 00             mov ax, 5
02943  cd 60                int 0x60
02945  c3                   ret
loc_2946:
02946  57                   push di
02947  51                   push cx
02948  52                   push dx
02949  8b 3e 9e 31          mov di, word ptr [0x319e]    ; son_effet_poignee
0294d  b8 04 00             mov ax, 4
02950  cd 60                int 0x60
02952  ba 02 00             mov dx, 2
02955  8b ca                mov cx, dx
02957  b8 03 00             mov ax, 3
0295a  cd 60                int 0x60
0295c  89 3e 9e 31          mov word ptr [0x319e], di    ; son_effet_poignee
02960  5a                   pop dx
02961  59                   pop cx
02962  5f                   pop di
02963  c3                   ret

; ======== son_sort   (appelée depuis 0e9d)
; morceau 9 ; Tandy 1
02964  80 3e 99 31 01       cmp byte ptr [0x3199], 1    ; son_actif
02969  74 01                je loc_296c
0296b  c3                   ret
loc_296c:
0296c  80 3e 92 31 00       cmp byte ptr [0x3192], 0    ; son_pilote
02971  75 2f                jne loc_29a2
02973  9c                   pushf
02974  50                   push ax
02975  53                   push bx
02976  51                   push cx
02977  52                   push dx
02978  57                   push di
02979  56                   push si
0297a  55                   push bp
0297b  06                   push es
0297c  1e                   push ds
0297d  bd 64 00             mov bp, 0x64
02980  b9 e8 03             mov cx, 0x3e8
02983  b4 64                mov ah, 0x64
02985  b7 ff                mov bh, 0xff
02987  e8 04 02             call son_bip
0298a  bd 0a 00             mov bp, 0xa
0298d  b9 10 27             mov cx, 0x2710
02990  b4 02                mov ah, 2
02992  b7 01                mov bh, 1
02994  e8 f7 01             call son_bip
02997  1f                   pop ds
02998  07                   pop es
02999  5d                   pop bp
0299a  5e                   pop si
0299b  5f                   pop di
0299c  5a                   pop dx
0299d  59                   pop cx
0299e  5b                   pop bx
0299f  58                   pop ax
029a0  9d                   popf
029a1  c3                   ret
loc_29a2:
029a2  80 3e 92 31 03       cmp byte ptr [0x3192], 3    ; son_pilote
029a7  75 09                jne loc_29b2
029a9  ba 01 00             mov dx, 1
029ac  b8 05 00             mov ax, 5
029af  cd 60                int 0x60
029b1  c3                   ret
loc_29b2:
029b2  57                   push di
029b3  51                   push cx
029b4  52                   push dx
029b5  8b 3e 9e 31          mov di, word ptr [0x319e]    ; son_effet_poignee
029b9  b8 04 00             mov ax, 4
029bc  cd 60                int 0x60
029be  ba 09 00             mov dx, 9
029c1  8b ca                mov cx, dx
029c3  b8 03 00             mov ax, 3
029c6  cd 60                int 0x60
029c8  89 3e 9e 31          mov word ptr [0x319e], di    ; son_effet_poignee
029cc  5a                   pop dx
029cd  59                   pop cx
029ce  5f                   pop di
029cf  c3                   ret

; ======== son_monstre_touche   (appelée depuis 2088)
; morceau 5 ; Tandy 1
029d0  80 3e 99 31 01       cmp byte ptr [0x3199], 1    ; son_actif
029d5  74 01                je loc_29d8
029d7  c3                   ret
loc_29d8:
029d8  80 3e 92 31 00       cmp byte ptr [0x3192], 0    ; son_pilote
029dd  75 3b                jne loc_2a1a
029df  9c                   pushf
029e0  50                   push ax
029e1  53                   push bx
029e2  51                   push cx
029e3  52                   push dx
029e4  57                   push di
029e5  56                   push si
029e6  55                   push bp
029e7  06                   push es
029e8  1e                   push ds
029e9  b9 02 00             mov cx, 2
loc_29ec:
029ec  51                   push cx
029ed  bd 28 00             mov bp, 0x28
029f0  b9 64 00             mov cx, 0x64
029f3  b4 01                mov ah, 1
029f5  b7 00                mov bh, 0
029f7  e8 94 01             call son_bip
029fa  b9 2c 01             mov cx, 0x12c
loc_29fd:
029fd  e2 fe                loop loc_29fd
029ff  bd 28 00             mov bp, 0x28
02a02  b9 64 00             mov cx, 0x64
02a05  b4 14                mov ah, 0x14
02a07  b7 00                mov bh, 0
02a09  e8 82 01             call son_bip
02a0c  59                   pop cx
02a0d  e2 dd                loop loc_29ec
02a0f  1f                   pop ds
02a10  07                   pop es
02a11  5d                   pop bp
02a12  5e                   pop si
02a13  5f                   pop di
02a14  5a                   pop dx
02a15  59                   pop cx
02a16  5b                   pop bx
02a17  58                   pop ax
02a18  9d                   popf
02a19  c3                   ret
loc_2a1a:
02a1a  80 3e 92 31 03       cmp byte ptr [0x3192], 3    ; son_pilote
02a1f  75 09                jne loc_2a2a
02a21  ba 01 00             mov dx, 1
02a24  b8 05 00             mov ax, 5
02a27  cd 60                int 0x60
02a29  c3                   ret
loc_2a2a:
02a2a  57                   push di
02a2b  51                   push cx
02a2c  52                   push dx
02a2d  8b 3e 9e 31          mov di, word ptr [0x319e]    ; son_effet_poignee
02a31  b8 04 00             mov ax, 4
02a34  cd 60                int 0x60
02a36  ba 05 00             mov dx, 5
02a39  8b ca                mov cx, dx
02a3b  b8 03 00             mov ax, 3
02a3e  cd 60                int 0x60
02a40  89 3e 9e 31          mov word ptr [0x319e], di    ; son_effet_poignee
02a44  5a                   pop dx
02a45  59                   pop cx
02a46  5f                   pop di
02a47  c3                   ret

; ======== son_clic   (appelée depuis 077c, 084e, 12bf, 73e5, 787e, 7e6f, 7f5e, 806a)
; clic d'interface : morceau 8 (AdLib, MT-32), 6 (Tandy)
02a48  80 3e 99 31 01       cmp byte ptr [0x3199], 1    ; son_actif
02a4d  74 01                je loc_2a50
02a4f  c3                   ret
loc_2a50:
02a50  80 3e 92 31 00       cmp byte ptr [0x3192], 0    ; son_pilote
02a55  75 22                jne loc_2a79
02a57  9c                   pushf
02a58  50                   push ax
02a59  53                   push bx
02a5a  51                   push cx
02a5b  52                   push dx
02a5c  57                   push di
02a5d  56                   push si
02a5e  55                   push bp
02a5f  06                   push es
02a60  1e                   push ds
02a61  bd 02 00             mov bp, 2
02a64  b9 70 17             mov cx, 0x1770
02a67  b4 19                mov ah, 0x19
02a69  b7 fe                mov bh, 0xfe
02a6b  e8 20 01             call son_bip
02a6e  1f                   pop ds
02a6f  07                   pop es
02a70  5d                   pop bp
02a71  5e                   pop si
02a72  5f                   pop di
02a73  5a                   pop dx
02a74  59                   pop cx
02a75  5b                   pop bx
02a76  58                   pop ax
02a77  9d                   popf
02a78  c3                   ret
loc_2a79:
02a79  80 3e 92 31 03       cmp byte ptr [0x3192], 3    ; son_pilote
02a7e  75 09                jne loc_2a89
02a80  ba 06 00             mov dx, 6
02a83  b8 05 00             mov ax, 5
02a86  cd 60                int 0x60
02a88  c3                   ret
loc_2a89:
02a89  57                   push di
02a8a  51                   push cx
02a8b  52                   push dx
02a8c  8b 3e 9e 31          mov di, word ptr [0x319e]    ; son_effet_poignee
02a90  b8 04 00             mov ax, 4
02a93  cd 60                int 0x60
02a95  ba 08 00             mov dx, 8
02a98  8b ca                mov cx, dx
02a9a  b8 03 00             mov ax, 3
02a9d  cd 60                int 0x60
02a9f  89 3e 9e 31          mov word ptr [0x319e], di    ; son_effet_poignee
02aa3  5a                   pop dx
02aa4  59                   pop cx
02aa5  5f                   pop di
02aa6  c3                   ret

; ======== son_piege   (appelée depuis 2593, 2687, 6f19)
; morceau 9 ; Tandy 4
02aa7  80 3e 99 31 01       cmp byte ptr [0x3199], 1    ; son_actif
02aac  74 01                je loc_2aaf
02aae  c3                   ret
loc_2aaf:
02aaf  80 3e 92 31 00       cmp byte ptr [0x3192], 0    ; son_pilote
02ab4  75 22                jne loc_2ad8
02ab6  9c                   pushf
02ab7  50                   push ax
02ab8  53                   push bx
02ab9  51                   push cx
02aba  52                   push dx
02abb  57                   push di
02abc  56                   push si
02abd  55                   push bp
02abe  06                   push es
02abf  1e                   push ds
02ac0  bd 06 00             mov bp, 6
02ac3  b9 40 1f             mov cx, 0x1f40
02ac6  b4 01                mov ah, 1
02ac8  b7 10                mov bh, 0x10
02aca  e8 c1 00             call son_bip
02acd  1f                   pop ds
02ace  07                   pop es
02acf  5d                   pop bp
02ad0  5e                   pop si
02ad1  5f                   pop di
02ad2  5a                   pop dx
02ad3  59                   pop cx
02ad4  5b                   pop bx
02ad5  58                   pop ax
02ad6  9d                   popf
02ad7  c3                   ret
loc_2ad8:
02ad8  80 3e 92 31 03       cmp byte ptr [0x3192], 3    ; son_pilote
02add  75 09                jne loc_2ae8
02adf  ba 04 00             mov dx, 4
02ae2  b8 05 00             mov ax, 5
02ae5  cd 60                int 0x60
02ae7  c3                   ret
loc_2ae8:
02ae8  57                   push di
02ae9  51                   push cx
02aea  52                   push dx
02aeb  8b 3e 9e 31          mov di, word ptr [0x319e]    ; son_effet_poignee
02aef  b8 04 00             mov ax, 4
02af2  cd 60                int 0x60
02af4  ba 09 00             mov dx, 9
02af7  8b ca                mov cx, dx
02af9  b8 03 00             mov ax, 3
02afc  cd 60                int 0x60
02afe  89 3e 9e 31          mov word ptr [0x319e], di    ; son_effet_poignee
02b02  5a                   pop dx
02b03  59                   pop cx
02b04  5f                   pop di
02b05  c3                   ret

; ======== son_des   (appelée depuis 4f47)
; dés de déplacement (appelée par affiche_deplacement) : morceau 6 ; Tandy 5 ; haut-parleur : deux notes en alternance
02b06  80 3e 99 31 01       cmp byte ptr [0x3199], 1    ; son_actif
02b0b  74 01                je loc_2b0e
02b0d  c3                   ret
loc_2b0e:
02b0e  80 3e 92 31 00       cmp byte ptr [0x3192], 0    ; son_pilote
02b13  75 4b                jne loc_2b60
02b15  9c                   pushf
02b16  50                   push ax
02b17  53                   push bx
02b18  51                   push cx
02b19  52                   push dx
02b1a  57                   push di
02b1b  56                   push si
02b1c  55                   push bp
02b1d  06                   push es
02b1e  1e                   push ds
02b1f  80 3e 57 0e 01       cmp byte ptr [0xe57], 1
02b24  74 1d                je loc_2b43
02b26  c6 06 57 0e 01       mov byte ptr [0xe57], 1
02b2b  bd 01 00             mov bp, 1
02b2e  b9 70 17             mov cx, 0x1770
02b31  b4 04                mov ah, 4
02b33  b7 00                mov bh, 0
02b35  e8 56 00             call son_bip
02b38  1f                   pop ds
02b39  07                   pop es
02b3a  5d                   pop bp
02b3b  5e                   pop si
02b3c  5f                   pop di
02b3d  5a                   pop dx
02b3e  59                   pop cx
02b3f  5b                   pop bx
02b40  58                   pop ax
02b41  9d                   popf
02b42  c3                   ret
loc_2b43:
02b43  c6 06 57 0e 00       mov byte ptr [0xe57], 0
02b48  bd 01 00             mov bp, 1
02b4b  b9 70 17             mov cx, 0x1770
02b4e  b4 02                mov ah, 2
02b50  b7 00                mov bh, 0
02b52  e8 39 00             call son_bip
02b55  1f                   pop ds
02b56  07                   pop es
02b57  5d                   pop bp
02b58  5e                   pop si
02b59  5f                   pop di
02b5a  5a                   pop dx
02b5b  59                   pop cx
02b5c  5b                   pop bx
02b5d  58                   pop ax
02b5e  9d                   popf
02b5f  c3                   ret
loc_2b60:
02b60  80 3e 92 31 03       cmp byte ptr [0x3192], 3    ; son_pilote
02b65  75 09                jne loc_2b70
02b67  ba 05 00             mov dx, 5
02b6a  b8 05 00             mov ax, 5
02b6d  cd 60                int 0x60
02b6f  c3                   ret
loc_2b70:
02b70  57                   push di
02b71  51                   push cx
02b72  52                   push dx
02b73  8b 3e 9e 31          mov di, word ptr [0x319e]    ; son_effet_poignee
02b77  b8 04 00             mov ax, 4
02b7a  cd 60                int 0x60
02b7c  ba 06 00             mov dx, 6
02b7f  8b ca                mov cx, dx
02b81  b8 03 00             mov ax, 3
02b84  cd 60                int 0x60
02b86  89 3e 9e 31          mov word ptr [0x319e], di    ; son_effet_poignee
02b8a  5a                   pop dx
02b8b  59                   pop cx
02b8c  5f                   pop di
02b8d  c3                   ret

; ======== son_bip   (appelée depuis 284a, 28ad, 28ba, 2928, 2987, 2994, 29f7, 2a09)
; haut-parleur (pilote 0) : AH, BH, CX, BP règlent la note et sa durée
02b8e  50                   push ax
02b8f  53                   push bx
02b90  51                   push cx
02b91  55                   push bp
02b92  e4 61                in al, 0x61
02b94  0c 03                or al, 3
02b96  e6 61                out 0x61, al
loc_2b98:
02b98  51                   push cx
02b99  8a c4                mov al, ah
02b9b  e6 42                out 0x42, al
02b9d  e6 42                out 0x42, al
loc_2b9f:
02b9f  e4 61                in al, 0x61
02ba1  0c 03                or al, 3
02ba3  e6 61                out 0x61, al
02ba5  e2 f8                loop loc_2b9f
02ba7  59                   pop cx
02ba8  02 e7                add ah, bh
02baa  4d                   dec bp
02bab  75 eb                jne loc_2b98
02bad  e4 61                in al, 0x61
02baf  24 fc                and al, 0xfc
02bb1  e6 61                out 0x61, al
02bb3  5d                   pop bp
02bb4  59                   pop cx
02bb5  5b                   pop bx
02bb6  58                   pop ax
02bb7  c3                   ret

; ======== mort_ouvre_escalier   (appelée depuis 214b)
; type 22 : pose l'escalier (codes 0x38 à 0x3B)
02bb8  c6 06 32 59 00       mov byte ptr [0x5932], 0
02bbd  c6 06 4c 59 00       mov byte ptr [0x594c], 0
02bc2  c6 06 33 59 38       mov byte ptr [0x5933], 0x38
02bc7  c6 06 4d 59 39       mov byte ptr [0x594d], 0x39
02bcc  c6 06 34 59 3a       mov byte ptr [0x5934], 0x3a
02bd1  c6 06 4e 59 3b       mov byte ptr [0x594e], 0x3b
02bd6  c6 06 97 3f 01       mov byte ptr [0x3f97], 1    ; vue_a_refaire
02bdb  c3                   ret

; ======== mort_sorcier_final   (appelée depuis 214b)
; type 26 : fin_du_jeu = 1
02bdc  c6 06 e7 3f 01       mov byte ptr [0x3fe7], 1    ; fin_du_jeu
02be1  c3                   ret

; ======== brume_gauche   (appelée depuis 22a3)
; x - 1 ; à 0 : direction suivante
02be2  fe 4d 01             dec byte ptr [di + 1]
02be5  74 01                je loc_2be8
02be7  c3                   ret
loc_2be8:
02be8  c6 06 e6 3f 01       mov byte ptr [0x3fe6], 1    ; pas_brume
02bed  c3                   ret

; ======== brume_haut   (appelée depuis 22a3)
; y - 1
02bee  fe 4d 02             dec byte ptr [di + 2]
02bf1  74 01                je loc_2bf4
02bf3  c3                   ret
loc_2bf4:
02bf4  c6 06 e6 3f 02       mov byte ptr [0x3fe6], 2    ; pas_brume
02bf9  c3                   ret

; ======== brume_droite_haut   (appelée depuis 22a3)
; x + 1 jusqu'à (24, 0)
02bfa  fe 45 01             inc byte ptr [di + 1]
02bfd  83 7d 01 18          cmp word ptr [di + 1], 0x18
02c01  73 01                jae loc_2c04
02c03  c3                   ret
loc_2c04:
02c04  c6 06 e6 3f 03       mov byte ptr [0x3fe6], 3    ; pas_brume
02c09  c3                   ret

; ======== brume_gauche_2   (appelée depuis 22a3)
; x - 1
02c0a  fe 4d 01             dec byte ptr [di + 1]
02c0d  74 01                je loc_2c10
02c0f  c3                   ret
loc_2c10:
02c10  c6 06 e6 3f 04       mov byte ptr [0x3fe6], 4    ; pas_brume
02c15  c3                   ret

; ======== brume_bas   (appelée depuis 22a3)
; y + 1 jusqu'à 18
02c16  fe 45 02             inc byte ptr [di + 2]
02c19  80 7d 02 12          cmp byte ptr [di + 2], 0x12
02c1d  73 01                jae loc_2c20
02c1f  c3                   ret
loc_2c20:
02c20  c6 06 e6 3f 05       mov byte ptr [0x3fe6], 5    ; pas_brume
02c25  c3                   ret

; ======== brume_droite   (appelée depuis 22a3)
; x + 1 jusqu'à 24
02c26  fe 45 01             inc byte ptr [di + 1]
02c29  80 7d 01 18          cmp byte ptr [di + 1], 0x18
02c2d  74 01                je loc_2c30
02c2f  c3                   ret
loc_2c30:
02c30  c6 06 e6 3f 00       mov byte ptr [0x3fe6], 0    ; pas_brume
02c35  c3                   ret

; ======== brume_de_mort   (appelée depuis 22b2)
; un héros sur la case de la brume perd 1 point de corps, ou meurt s'il n'en a qu'un
02c36  32 c0                xor al, al
loc_2c38:
02c38  50                   push ax
02c39  e8 43 31             call fiche_personnage
02c3c  80 3c 00             cmp byte ptr [si], 0
02c3f  74 21                je loc_2c62
02c41  8a 44 01             mov al, byte ptr [si + 1]
02c44  3a 45 01             cmp al, byte ptr [di + 1]
02c47  75 19                jne loc_2c62
02c49  8a 44 02             mov al, byte ptr [si + 2]
02c4c  3a 45 02             cmp al, byte ptr [di + 2]
02c4f  75 11                jne loc_2c62
02c51  80 7c 06 01          cmp byte ptr [si + 6], 1
02c55  76 15                jbe loc_2c6c
02c57  fe 4c 06             dec byte ptr [si + 6]
02c5a  58                   pop ax
02c5b  bb 32 02             mov bx, 0x232    ; message « L'AIR GLACIAL DE LA BRUME / DE LA MORT VOUS FAIT DU MAL. / VOUS PERDEZ 1 POINT DE CORPS »
02c5e  e8 8c 5c             call affiche_message
02c61  c3                   ret
loc_2c62:
02c62  58                   pop ax
02c63  fe c0                inc al
02c65  3c 04                cmp al, 4
02c67  75 cf                jne loc_2c38
02c69  e9 78 34             jmp affiche_tampon
loc_2c6c:
02c6c  58                   pop ax
02c6d  a2 ca 3f             mov byte ptr [0x3fca], al    ; heros_courant
02c70  e8 65 e4             call mort_heros
02c73  c3                   ret

; ======== action_sort
; icône sorts enfoncée : choix du sort (inventaire_sorts, mode 5), puis de la cible
02c74  80 3e a7 3f 02       cmp byte ptr [0x3fa7], 2    ; personnage_courant
02c79  73 01                jae loc_2c7c
02c7b  c3                   ret
loc_2c7c:
02c7c  80 3e a7 3f 03       cmp byte ptr [0x3fa7], 3    ; personnage_courant
02c81  76 01                jbe loc_2c84
02c83  c3                   ret
loc_2c84:
02c84  80 3e 01 43 1c       cmp byte ptr [0x4301], 0x1c
02c89  74 01                je loc_2c8c
02c8b  c3                   ret
loc_2c8c:
02c8c  80 3e 2c 40 01       cmp byte ptr [0x402c], 1
02c91  74 16                je loc_2ca9
02c93  f6 06 9b 3f 00       test byte ptr [0x3f9b], 0    ; etat_action
02c98  74 1c                je loc_2cb6
02c9a  f6 06 b3 3f 02       test byte ptr [0x3fb3], 2    ; attaque_repetee
02c9f  74 01                je loc_2ca2
02ca1  c3                   ret
loc_2ca2:
02ca2  80 0e b3 3f 02       or byte ptr [0x3fb3], 2    ; attaque_repetee
02ca7  eb 0d                jmp loc_2cb6
loc_2ca9:
02ca9  80 3e 01 43 1c       cmp byte ptr [0x4301], 0x1c
02cae  74 01                je loc_2cb1
02cb0  c3                   ret
loc_2cb1:
02cb1  c6 06 e9 3f 01       mov byte ptr [0x3fe9], 1    ; sans_sprites
loc_2cb6:
02cb6  c6 06 67 ad 05       mov byte ptr [0xad67], 5    ; mode_inventaire
02cbb  e8 62 5f             call inventaire_sorts
02cbe  80 3e af 3f 00       cmp byte ptr [0x3faf], 0    ; objet_choisi
02cc3  75 01                jne loc_2cc6
02cc5  c3                   ret
loc_2cc6:
02cc6  8b 3e 37 46          mov di, word ptr [0x4637]    ; fiche_heros_courant
02cca  8a 5d 16             mov bl, byte ptr [di + 0x16]
02ccd  fe cb                dec bl
02ccf  32 ff                xor bh, bh
02cd1  8a 87 87 43          mov al, byte ptr [bx + 0x4387]    ; proprietes_sorts
02cd5  a2 c9 3f             mov byte ptr [0x3fc9], al    ; proprietes_sort
02cd8  c6 06 ae 3f 01       mov byte ptr [0x3fae], 1    ; sort_en_cours
02cdd  c6 06 91 3f 01       mov byte ptr [0x3f91], 1    ; carte_cible
02ce2  e8 eb 29             call plateau_ciblage
02ce5  c6 06 9d 3f 00       mov byte ptr [0x3f9d], 0    ; cible_validee
02cea  c6 06 ac 3f 00       mov byte ptr [0x3fac], 0    ; monstre_designe
02cef  c6 06 ad 3f 00       mov byte ptr [0x3fad], 0    ; case_vide_designee
02cf4  c6 06 b5 3f ff       mov byte ptr [0x3fb5], 0xff    ; heros_designe
loc_2cf9:
02cf9  e8 00 37             call curseur_memorise
02cfc  e8 ea df             call designe_case
02cff  e8 12 31             call curseur_dessine
02d02  e8 df 33             call affiche_tampon
02d05  e8 cf 30             call curseur_efface
02d08  be 37 43             mov si, 0x4337    ; zone_annuler_attaque
02d0b  e8 f7 21             call zone_cliquee
02d0e  83 fb 02             cmp bx, 2
02d11  75 03                jne loc_2d16
02d13  e9 94 e5             jmp fin_action
loc_2d16:
02d16  80 3e 9d 3f 00       cmp byte ptr [0x3f9d], 0    ; cible_validee
02d1b  74 dc                je loc_2cf9
02d1d  f6 06 9b 3f 02       test byte ptr [0x3f9b], 2    ; etat_action
02d22  74 05                je loc_2d29
02d24  c6 06 2c 40 00       mov byte ptr [0x402c], 0
loc_2d29:
02d29  e8 1d 33             call fin_deplacement
02d2c  c6 06 af 3f 00       mov byte ptr [0x3faf], 0    ; objet_choisi
02d31  8b 3e 37 46          mov di, word ptr [0x4637]    ; fiche_heros_courant
02d35  8a 0e c9 3f          mov cl, byte ptr [0x3fc9]    ; proprietes_sort
02d39  f6 06 c9 3f 01       test byte ptr [0x3fc9], 1    ; proprietes_sort
02d3e  74 0a                je loc_2d4a
02d40  a0 b5 3f             mov al, byte ptr [0x3fb5]    ; heros_designe
02d43  3c ff                cmp al, 0xff
02d45  74 03                je loc_2d4a
02d47  e9 2f e1             jmp sort_sur_heros
loc_2d4a:
02d4a  f6 06 c9 3f 02       test byte ptr [0x3fc9], 2    ; proprietes_sort
02d4f  74 23                je loc_2d74
02d51  a0 ac 3f             mov al, byte ptr [0x3fac]    ; monstre_designe
02d54  80 3e ac 3f 00       cmp byte ptr [0x3fac], 0    ; monstre_designe
02d59  74 03                je loc_2d5e
02d5b  e9 f0 e0             jmp sort_sur_monstre
loc_2d5e:
02d5e  f6 06 c9 3f 04       test byte ptr [0x3fc9], 4    ; proprietes_sort
02d63  74 0f                je loc_2d74
02d65  80 3e ad 3f 00       cmp byte ptr [0x3fad], 0    ; case_vide_designee
02d6a  74 08                je loc_2d74
02d6c  c6 06 ca 3f 06       mov byte ptr [0x3fca], 6    ; heros_courant
02d71  e9 0b e1             jmp lance_sort
loc_2d74:
02d74  bb 56 00             mov bx, 0x56    ; message « CE SORT N'A AUCUN / EFFET SUR UN ENNEMI. / IL A ETE GASPILLE »
02d77  e8 73 5b             call affiche_message
02d7a  8b 3e 37 46          mov di, word ptr [0x4637]    ; fiche_heros_courant
02d7e  e8 03 00             call retire_sort
02d81  e9 26 e5             jmp fin_action

; ======== retire_sort   (appelée depuis 0e9a, 2d7e)
; efface le bit du sort lancé (+0x0B / +0x0C de la fiche) et le sort choisi (+0x16)
02d84  bb 00 00             mov bx, 0
02d87  8a 45 16             mov al, byte ptr [di + 0x16]
02d8a  0a c0                or al, al
02d8c  74 13                je loc_2da1
02d8e  fe c3                inc bl
02d90  3c 07                cmp al, 7
02d92  72 05                jb loc_2d99
02d94  bb 00 01             mov bx, 0x100
02d97  2c 06                sub al, 6
loc_2d99:
02d99  fe c8                dec al
02d9b  74 04                je loc_2da1
02d9d  03 db                add bx, bx
02d9f  eb f8                jmp loc_2d99
loc_2da1:
02da1  30 5d 0b             xor byte ptr [di + 0xb], bl
02da4  30 7d 0c             xor byte ptr [di + 0xc], bh
02da7  c6 45 16 00          mov byte ptr [di + 0x16], 0
02dab  c3                   ret

; ======== chemin_heros   (appelée depuis 689b)
; plus court chemin de DS:3FEE vers DS:3FF0 en deplacement_restant pas au plus ; grille des profondeurs dans DS:0A0E (texte_briefing réutilisé, 26 × 19) ; résultat : DS:3FC8 pas, directions en DS:4013
02dac  a0 ee 3f             mov al, byte ptr [0x3fee]    ; chemin_depart_x
02daf  2a 06 f0 3f          sub al, byte ptr [0x3ff0]    ; chemin_cible_x
02db3  79 02                jns loc_2db7
02db5  f6 d8                neg al
loc_2db7:
02db7  8a 26 ef 3f          mov ah, byte ptr [0x3fef]
02dbb  2a 26 f1 3f          sub ah, byte ptr [0x3ff1]
02dbf  79 02                jns loc_2dc3
02dc1  f6 dc                neg ah
loc_2dc3:
02dc3  02 c4                add al, ah
02dc5  a2 e9 37             mov byte ptr [0x37e9], al    ; erreur_fichier
02dc8  a0 9c 3f             mov al, byte ptr [0x3f9c]    ; deplacement_restant
02dcb  32 e4                xor ah, ah
02dcd  a3 f9 3f             mov word ptr [0x3ff9], ax    ; chemin_longueur_max
02dd0  c6 06 a8 3f 00       mov byte ptr [0x3fa8], 0    ; resultat_vise
02dd5  c6 06 c8 3f 00       mov byte ptr [0x3fc8], 0    ; pas_en_file
02dda  c7 06 f3 3f 00 00    mov word ptr [0x3ff3], 0    ; chemin_profondeur
02de0  c7 06 cc 3f 00 00    mov word ptr [0x3fcc], 0    ; prochain_pas
02de6  bf 0e 0a             mov di, 0xa0e    ; texte_briefing
02de9  b9 00 01             mov cx, 0x100
02dec  50                   push ax
02ded  b8 7c 09             mov ax, 0x97c
02df0  8e c0                mov es, ax
02df2  58                   pop ax
02df3  b8 1a 1a             mov ax, 0x1a1a
02df6  f3 ab                rep stosw word ptr es:[di], ax
02df8  8b 3e 37 46          mov di, word ptr [0x4637]    ; fiche_heros_courant
02dfc  eb 74                jmp loc_2e72
; ---- 1 octets non atteints (2dfe-2dfe)

; ======== chemin_essaie   (appelée depuis 2e7b, 2e8b, 2e9b, 2eab)
; recherche en profondeur : empile la direction DS:3FF2, coupe si |dx| ou |dy| dépasse les pas restants, teste pas_permis, garde un chemin plus court, puis essaie les 4 directions
02dff  a0 f2 3f             mov al, byte ptr [0x3ff2]    ; chemin_direction
02e02  8b 1e f3 3f          mov bx, word ptr [0x3ff3]    ; chemin_profondeur
02e06  88 87 fb 3f          mov byte ptr [bx + 0x3ffb], al    ; chemin_pile
02e0a  43                   inc bx
02e0b  3b 1e f9 3f          cmp bx, word ptr [0x3ff9]    ; chemin_longueur_max
02e0f  76 01                jbe loc_2e12
02e11  c3                   ret
loc_2e12:
02e12  89 1e f3 3f          mov word ptr [0x3ff3], bx    ; chemin_profondeur
02e16  8a 26 f9 3f          mov ah, byte ptr [0x3ff9]    ; chemin_longueur_max
02e1a  2a e3                sub ah, bl
02e1c  a0 f0 3f             mov al, byte ptr [0x3ff0]    ; chemin_cible_x
02e1f  2a 06 f5 3f          sub al, byte ptr [0x3ff5]    ; chemin_case_x
02e23  79 02                jns loc_2e27
02e25  f6 d8                neg al
loc_2e27:
02e27  3a c4                cmp al, ah
02e29  76 03                jbe loc_2e2e
02e2b  e9 84 00             jmp loc_2eb2
loc_2e2e:
02e2e  a0 f1 3f             mov al, byte ptr [0x3ff1]
02e31  2a 06 f6 3f          sub al, byte ptr [0x3ff6]
02e35  79 02                jns loc_2e39
02e37  f6 d8                neg al
loc_2e39:
02e39  3a c4                cmp al, ah
02e3b  77 75                ja loc_2eb2
02e3d  e8 77 00             call pas_permis
02e40  72 70                jb loc_2eb2
02e42  3e 88 5e 00          mov byte ptr ds:[bp], bl
02e46  a0 f5 3f             mov al, byte ptr [0x3ff5]    ; chemin_case_x
02e49  3a 06 f0 3f          cmp al, byte ptr [0x3ff0]    ; chemin_cible_x
02e4d  75 23                jne loc_2e72
02e4f  a0 f6 3f             mov al, byte ptr [0x3ff6]
02e52  3a 06 f1 3f          cmp al, byte ptr [0x3ff1]
02e56  75 1a                jne loc_2e72
02e58  88 1e c8 3f          mov byte ptr [0x3fc8], bl    ; pas_en_file
02e5c  57                   push di
02e5d  bf 13 40             mov di, 0x4013    ; chemin_trouve
02e60  be fb 3f             mov si, 0x3ffb    ; chemin_pile
02e63  8a 0e c8 3f          mov cl, byte ptr [0x3fc8]    ; pas_en_file
02e67  32 ed                xor ch, ch
02e69  89 0e f9 3f          mov word ptr [0x3ff9], cx    ; chemin_longueur_max
02e6d  f3 a4                rep movsb byte ptr es:[di], byte ptr [si]
02e6f  5f                   pop di
02e70  eb 40                jmp loc_2eb2
loc_2e72:
02e72  c6 06 f2 3f 00       mov byte ptr [0x3ff2], 0    ; chemin_direction
02e77  fe 0e f6 3f          dec byte ptr [0x3ff6]
02e7b  e8 81 ff             call chemin_essaie
02e7e  fe 06 f6 3f          inc byte ptr [0x3ff6]
02e82  c6 06 f2 3f 01       mov byte ptr [0x3ff2], 1    ; chemin_direction
02e87  fe 06 f5 3f          inc byte ptr [0x3ff5]    ; chemin_case_x
02e8b  e8 71 ff             call chemin_essaie
02e8e  fe 0e f5 3f          dec byte ptr [0x3ff5]    ; chemin_case_x
02e92  c6 06 f2 3f 02       mov byte ptr [0x3ff2], 2    ; chemin_direction
02e97  fe 06 f6 3f          inc byte ptr [0x3ff6]
02e9b  e8 61 ff             call chemin_essaie
02e9e  fe 0e f6 3f          dec byte ptr [0x3ff6]
02ea2  c6 06 f2 3f 03       mov byte ptr [0x3ff2], 3    ; chemin_direction
02ea7  fe 0e f5 3f          dec byte ptr [0x3ff5]    ; chemin_case_x
02eab  e8 51 ff             call chemin_essaie
02eae  fe 06 f5 3f          inc byte ptr [0x3ff5]    ; chemin_case_x
loc_2eb2:
02eb2  ff 0e f3 3f          dec word ptr [0x3ff3]    ; chemin_profondeur
02eb6  c3                   ret

; ======== pas_permis   (appelée depuis 2e3d)
; CF = 0 si l'on peut entrer en (DS:3FF5, DS:3FF6) : dans le plateau, profondeur meilleure, case différente de DS:0E11, dans une zone, vide ou code 0x32 à 0x40, sans mur (sauf traversée de la roche) ni porte secrète non trouvée
02eb7  53                   push bx
02eb8  8a 1e f2 3f          mov bl, byte ptr [0x3ff2]    ; chemin_direction
02ebc  32 ff                xor bh, bh
02ebe  80 3e f6 3f 13       cmp byte ptr [0x3ff6], 0x13
02ec3  73 6c                jae loc_2f31
02ec5  80 3e f5 3f 1a       cmp byte ptr [0x3ff5], 0x1a    ; chemin_case_x
02eca  73 65                jae loc_2f31
02ecc  a0 f6 3f             mov al, byte ptr [0x3ff6]
02ecf  b2 1a                mov dl, 0x1a
02ed1  f6 e2                mul dl
02ed3  8a 16 f5 3f          mov dl, byte ptr [0x3ff5]    ; chemin_case_x
02ed7  32 f6                xor dh, dh
02ed9  03 c2                add ax, dx
02edb  8b e8                mov bp, ax
02edd  81 c5 0e 0a          add bp, 0xa0e    ; texte_briefing
02ee1  3e 8a 4e 00          mov cl, byte ptr ds:[bp]
02ee5  38 0e f3 3f          cmp byte ptr [0x3ff3], cl    ; chemin_profondeur
02ee9  73 46                jae loc_2f31
02eeb  05 6f 56             add ax, 0x566f
02eee  3b 06 11 0e          cmp ax, word ptr [0xe11]    ; case_avant_porte
02ef2  75 03                jne loc_2ef7
02ef4  eb 3b                jmp loc_2f31
; ---- 1 octets non atteints (2ef6-2ef6)
loc_2ef7:
02ef7  8b d8                mov bx, ax
02ef9  8a 87 00 fe          mov al, byte ptr [bx - 0x200]
02efd  24 3f                and al, 0x3f
02eff  75 03                jne loc_2f04
02f01  eb 2e                jmp loc_2f31
; ---- 1 octets non atteints (2f03-2f03)
loc_2f04:
02f04  80 bf 00 02 00       cmp byte ptr [bx + 0x200], 0
02f09  74 14                je loc_2f1f
02f0b  80 bf 00 02 32       cmp byte ptr [bx + 0x200], 0x32
02f10  73 03                jae loc_2f15
02f12  eb 1d                jmp loc_2f31
; ---- 1 octets non atteints (2f14-2f14)
loc_2f15:
02f15  80 bf 00 02 40       cmp byte ptr [bx + 0x200], 0x40
02f1a  76 03                jbe loc_2f1f
02f1c  eb 13                jmp loc_2f31
; ---- 1 octets non atteints (2f1e-2f1e)
loc_2f1f:
02f1f  8b c3                mov ax, bx
02f21  8a 1e f2 3f          mov bl, byte ptr [0x3ff2]    ; chemin_direction
02f25  32 ff                xor bh, bh
02f27  d1 e3                shl bx, 1
02f29  ff a7 f1 40          jmp word ptr [bx + 0x40f1]    ; murs_pas
loc_2f2d:
02f2d  f8                   clc
02f2e  eb 02                jmp loc_2f32
; ---- 1 octets non atteints (2f30-2f30)
loc_2f31:
02f31  f9                   stc
loc_2f32:
02f32  5b                   pop bx
02f33  c3                   ret
loc_2f34:
02f34  8b d8                mov bx, ax
02f36  f6 47 1a 80          test byte ptr [bx + 0x1a], 0x80
02f3a  74 08                je loc_2f44
02f3c  f6 45 18 20          test byte ptr [di + 0x18], 0x20
02f40  75 02                jne loc_2f44
02f42  eb ed                jmp loc_2f31
loc_2f44:
02f44  f6 47 1a 20          test byte ptr [bx + 0x1a], 0x20
02f48  74 e3                je loc_2f2d
02f4a  f6 47 1a 08          test byte ptr [bx + 0x1a], 8
02f4e  75 02                jne loc_2f52
02f50  eb db                jmp loc_2f2d
loc_2f52:
02f52  f6 47 1a 04          test byte ptr [bx + 0x1a], 4
02f56  74 d9                je loc_2f31
02f58  eb d3                jmp loc_2f2d
loc_2f5a:
02f5a  8b d8                mov bx, ax
02f5c  f6 07 40             test byte ptr [bx], 0x40
02f5f  74 08                je loc_2f69
02f61  f6 45 18 20          test byte ptr [di + 0x18], 0x20
02f65  75 02                jne loc_2f69
02f67  eb c8                jmp loc_2f31
loc_2f69:
02f69  f6 07 10             test byte ptr [bx], 0x10
02f6c  74 bf                je loc_2f2d
02f6e  f6 07 08             test byte ptr [bx], 8
02f71  75 02                jne loc_2f75
02f73  eb b8                jmp loc_2f2d
loc_2f75:
02f75  f6 07 04             test byte ptr [bx], 4
02f78  74 b7                je loc_2f31
02f7a  eb b1                jmp loc_2f2d
loc_2f7c:
02f7c  8b d8                mov bx, ax
02f7e  f6 07 80             test byte ptr [bx], 0x80
02f81  74 08                je loc_2f8b
02f83  f6 45 18 20          test byte ptr [di + 0x18], 0x20
02f87  75 02                jne loc_2f8b
02f89  eb a6                jmp loc_2f31
loc_2f8b:
02f8b  f6 07 20             test byte ptr [bx], 0x20
02f8e  74 9d                je loc_2f2d
02f90  f6 07 08             test byte ptr [bx], 8
02f93  75 02                jne loc_2f97
02f95  eb 96                jmp loc_2f2d
loc_2f97:
02f97  f6 07 04             test byte ptr [bx], 4
02f9a  74 95                je loc_2f31
02f9c  eb 8f                jmp loc_2f2d
loc_2f9e:
02f9e  8b d8                mov bx, ax
02fa0  f6 47 01 40          test byte ptr [bx + 1], 0x40
02fa4  74 08                je loc_2fae
02fa6  f6 45 18 20          test byte ptr [di + 0x18], 0x20
02faa  75 02                jne loc_2fae
02fac  eb 83                jmp loc_2f31
loc_2fae:
02fae  f6 47 01 10          test byte ptr [bx + 1], 0x10
02fb2  75 03                jne loc_2fb7
02fb4  e9 76 ff             jmp loc_2f2d
loc_2fb7:
02fb7  f6 47 01 08          test byte ptr [bx + 1], 8
02fbb  75 03                jne loc_2fc0
02fbd  e9 6d ff             jmp loc_2f2d
loc_2fc0:
02fc0  f6 47 01 04          test byte ptr [bx + 1], 4
02fc4  75 03                jne loc_2fc9
02fc6  e9 68 ff             jmp loc_2f31
loc_2fc9:
02fc9  e9 61 ff             jmp loc_2f2d
quitte_erreur:    ; démarrage raté : « PRESS ANY KEY TO CONTINUE » (DS:363F), une touche, retour au DOS (int 21h AX=4CFFh)
02fcc  ba 3f 36             mov dx, 0x363f
02fcf  b4 09                mov ah, 9
02fd1  cd 21                int 0x21
02fd3  32 e4                xor ah, ah
02fd5  cd 16                int 0x16
02fd7  3c 61                cmp al, 0x61
02fd9  72 06                jb loc_2fe1
02fdb  3c 7a                cmp al, 0x7a
02fdd  77 02                ja loc_2fe1
02fdf  0c 20                or al, 0x20
loc_2fe1:
02fe1  b8 ff 4c             mov ax, 0x4cff
02fe4  cd 21                int 0x21
02fe6  e8 08 07             call clavier_retire
02fe9  e9 a5 18             jmp loc_4891
; ---- 266 octets non atteints (2fec-30f5)

; ======== lit_configuration   (appelée depuis 0107)
; charge QUEST.CFG en DS:3190 (9 octets), teste la souris (int 33h), étalonne le joystick si besoin
030f6  e8 c6 14             call installe_erreur_disque
030f9  c7 06 07 39 8d 36    mov word ptr [0x3907], 0x368d    ; fichier_nom, "quest.cfg"
030ff  c7 06 03 39 90 31    mov word ptr [0x3903], 0x3190    ; fichier_offset
03105  b8 7c 09             mov ax, 0x97c
03108  a3 01 39             mov word ptr [0x3901], ax    ; fichier_segment
0310b  e8 73 08             call charge_fichier
0310e  83 3e e9 37 02       cmp word ptr [0x37e9], 2    ; erreur_fichier
03113  74 03                je loc_3118
03115  eb 13                jmp loc_312a
; ---- 1 octets non atteints (3117-3117)
loc_3118:
03118  32 e4                xor ah, ah
0311a  b0 03                mov al, 3
0311c  cd 10                int 0x10
0311e  ba bf 36             mov dx, 0x36bf
03121  b4 09                mov ah, 9
03123  cd 21                int 0x21
loc_3125:
03125  e8 c9 05             call clavier_retire
03128  f9                   stc
03129  c3                   ret
loc_312a:
0312a  b8 33 35             mov ax, 0x3533
0312d  cd 21                int 0x21
0312f  8c c0                mov ax, es
03131  0b c3                or ax, bx
03133  a3 11 32             mov word ptr [0x3211], ax    ; souris_presente
03136  74 09                je loc_3141
03138  33 c0                xor ax, ax
0313a  cd 33                int 0x33
0313c  0b c0                or ax, ax
0313e  a3 11 32             mov word ptr [0x3211], ax    ; souris_presente
loc_3141:
03141  b9 04 00             mov cx, 4
03144  bb 95 31             mov bx, 0x3195
loc_3147:
03147  80 3f 00             cmp byte ptr [bx], 0
0314a  75 07                jne loc_3153
0314c  83 3e 11 32 00       cmp word ptr [0x3211], 0    ; souris_presente
03151  74 13                je loc_3166
loc_3153:
03153  43                   inc bx
03154  e2 f1                loop loc_3147
03156  b9 04 00             mov cx, 4
03159  bb 95 31             mov bx, 0x3195
loc_315c:
0315c  80 3f 02             cmp byte ptr [bx], 2
0315f  74 0e                je loc_316f
03161  43                   inc bx
03162  e2 f8                loop loc_315c
03164  f8                   clc
03165  c3                   ret
loc_3166:
03166  ba ff 36             mov dx, 0x36ff
03169  b4 09                mov ah, 9
0316b  cd 21                int 0x21
0316d  eb b6                jmp loc_3125
loc_316f:
0316f  e8 4c 15             call etalonne_joystick
03172  f8                   clc
03173  c3                   ret

; ======== ligne_ecran   (appelée depuis 14ef, 1648, 17fe, 58ab, 5c4e, 7c15, 89b0, 89e3)
; BX += AX * 320
03174  ba 40 01             mov dx, 0x140
03177  f7 e2                mul dx
03179  03 d8                add bx, ax
0317b  c3                   ret

; ======== affiche_texte   (appelée depuis 0062, 00b1, 00cc, 022b, 023a, 444a, 446e, 448c)
; texte pointé par BP, codes de contrôle 01 (segment de destination), 10 (encre, fond), 11 (ligne, colonne), 12 (colonne, ligne + 4)
0317c  3e 8a 46 00          mov al, byte ptr ds:[bp]
03180  22 c0                and al, al
03182  75 01                jne loc_3185
03184  c3                   ret
loc_3185:
03185  e8 03 00             call affiche_caractere
03188  45                   inc bp
03189  eb f1                jmp affiche_texte

; ======== affiche_caractere   (appelée depuis 3185, 3a7a, 3a9b, 45a7)
; code AL du texte BP : 01 segment de destination (DS:3756) ; sinon routine du mode vidéo (table DS:373A) : 10 couleurs, 11 ligne puis colonne, 12 colonne puis ligne + 4, autre : caractère 8 × 8
0318b  3c 01                cmp al, 1
0318d  74 09                je loc_3198
0318f  bb 3a 37             mov bx, 0x373a    ; saut_caractere
03192  03 1e 90 31          add bx, word ptr [0x3190]    ; mode_video
03196  ff 27                jmp word ptr [bx]
loc_3198:
03198  3e 8b 46 01          mov ax, word ptr ds:[bp + 1]
0319c  a3 56 37             mov word ptr [0x3756], ax    ; texte_segment
0319f  83 c5 02             add bp, 2
031a2  c3                   ret
loc_31a3:
031a3  3c 10                cmp al, 0x10
031a5  75 03                jne loc_31aa
031a7  e9 1e 01             jmp loc_32c8
loc_31aa:
031aa  3c 11                cmp al, 0x11
031ac  75 03                jne loc_31b1
031ae  e9 b1 03             jmp loc_3562
loc_31b1:
031b1  3c 12                cmp al, 0x12
031b3  75 03                jne loc_31b8
031b5  e9 be 03             jmp loc_3576
loc_31b8:
031b8  50                   push ax
031b9  bb 7f 37             mov bx, 0x377f    ; couleurs_texte
031bc  a0 50 37             mov al, byte ptr [0x3750]    ; couleur_texte
031bf  d7                   xlatb
031c0  8a d0                mov dl, al
031c2  a0 51 37             mov al, byte ptr [0x3751]    ; couleur_fond
031c5  d7                   xlatb
031c6  8a f0                mov dh, al
031c8  80 3e 59 37 01       cmp byte ptr [0x3759], 1    ; texte_transparent
031cd  75 02                jne loc_31d1
031cf  b6 00                mov dh, 0
loc_31d1:
031d1  58                   pop ax
031d2  55                   push bp
031d3  32 e4                xor ah, ah
031d5  d1 e0                shl ax, 1
031d7  d1 e0                shl ax, 1
031d9  d1 e0                shl ax, 1
031db  05 13 31             add ax, 0x3113    ; police
031de  8b f0                mov si, ax
031e0  bf 5d 37             mov di, 0x375d
031e3  b9 08 00             mov cx, 8
loc_31e6:
031e6  51                   push cx
031e7  ac                   lodsb al, byte ptr [si]
031e8  b9 04 00             mov cx, 4
loc_31eb:
031eb  8a e6                mov ah, dh
031ed  d0 e0                shl al, 1
031ef  73 0a                jae loc_31fb
031f1  80 e4 0f             and ah, 0xf
031f4  8a da                mov bl, dl
031f6  80 e3 f0             and bl, 0xf0
031f9  0a e3                or ah, bl
loc_31fb:
031fb  d0 e0                shl al, 1
031fd  73 0a                jae loc_3209
031ff  80 e4 f0             and ah, 0xf0
03202  8a da                mov bl, dl
03204  80 e3 0f             and bl, 0xf
03207  0a e3                or ah, bl
loc_3209:
03209  88 25                mov byte ptr [di], ah
0320b  47                   inc di
0320c  e2 dd                loop loc_31eb
0320e  59                   pop cx
0320f  e2 d5                loop loc_31e6
03211  a1 54 37             mov ax, word ptr [0x3754]    ; texte_ligne
03214  32 e4                xor ah, ah
03216  ba 40 01             mov dx, 0x140
03219  f7 e2                mul dx
0321b  8b 3e 52 37          mov di, word ptr [0x3752]    ; texte_colonne
0321f  d1 e7                shl di, 1
03221  d1 e7                shl di, 1
03223  03 f8                add di, ax
03225  a1 56 37             mov ax, word ptr [0x3756]    ; texte_segment
03228  8e c0                mov es, ax
0322a  bb f0 2f             mov bx, 0x2ff0
0322d  be 5d 37             mov si, 0x375d
03230  b9 08 00             mov cx, 8
loc_3233:
03233  ac                   lodsb al, byte ptr [si]
03234  80 3e 59 37 01       cmp byte ptr [0x3759], 1    ; texte_transparent
03239  74 06                je loc_3241
0323b  26 88 05             mov byte ptr es:[di], al
0323e  eb 0b                jmp loc_324b
; ---- 1 octets non atteints (3240-3240)
loc_3241:
03241  8a e0                mov ah, al
03243  2e d7                xlatb
03245  26 20 05             and byte ptr es:[di], al
03248  26 08 25             or byte ptr es:[di], ah
loc_324b:
0324b  47                   inc di
0324c  ac                   lodsb al, byte ptr [si]
0324d  80 3e 59 37 01       cmp byte ptr [0x3759], 1    ; texte_transparent
03252  74 06                je loc_325a
03254  26 88 05             mov byte ptr es:[di], al
03257  eb 0b                jmp loc_3264
; ---- 1 octets non atteints (3259-3259)
loc_325a:
0325a  8a e0                mov ah, al
0325c  2e d7                xlatb
0325e  26 20 05             and byte ptr es:[di], al
03261  26 08 25             or byte ptr es:[di], ah
loc_3264:
03264  47                   inc di
03265  ac                   lodsb al, byte ptr [si]
03266  80 3e 59 37 01       cmp byte ptr [0x3759], 1    ; texte_transparent
0326b  74 06                je loc_3273
0326d  26 88 05             mov byte ptr es:[di], al
03270  eb 0b                jmp loc_327d
; ---- 1 octets non atteints (3272-3272)
loc_3273:
03273  8a e0                mov ah, al
03275  2e d7                xlatb
03277  26 20 05             and byte ptr es:[di], al
0327a  26 08 25             or byte ptr es:[di], ah
loc_327d:
0327d  47                   inc di
0327e  ac                   lodsb al, byte ptr [si]
0327f  80 3e 59 37 01       cmp byte ptr [0x3759], 1    ; texte_transparent
03284  74 06                je loc_328c
03286  26 88 05             mov byte ptr es:[di], al
03289  eb 0b                jmp loc_3296
; ---- 1 octets non atteints (328b-328b)
loc_328c:
0328c  8a e0                mov ah, al
0328e  2e d7                xlatb
03290  26 20 05             and byte ptr es:[di], al
03293  26 08 25             or byte ptr es:[di], ah
loc_3296:
03296  47                   inc di
03297  81 c7 00 20          add di, 0x2000
0329b  f7 c7 00 80          test di, 0x8000
0329f  74 04                je loc_32a5
032a1  81 ef 60 7f          sub di, 0x7f60
loc_32a5:
032a5  83 ef 04             sub di, 4
032a8  e2 89                loop loc_3233
032aa  50                   push ax
032ab  b8 7c 09             mov ax, 0x97c
032ae  8e d8                mov ds, ax
032b0  58                   pop ax
032b1  ff 06 52 37          inc word ptr [0x3752]    ; texte_colonne
032b5  83 3e 52 37 28       cmp word ptr [0x3752], 0x28    ; texte_colonne
032ba  72 0a                jb loc_32c6
032bc  c7 06 52 37 00 00    mov word ptr [0x3752], 0    ; texte_colonne
032c2  ff 06 54 37          inc word ptr [0x3754]    ; texte_ligne
loc_32c6:
032c6  5d                   pop bp
032c7  c3                   ret
loc_32c8:
032c8  3e 8a 46 01          mov al, byte ptr ds:[bp + 1]
032cc  3c 38                cmp al, 0x38
032ce  75 02                jne loc_32d2
032d0  b0 05                mov al, 5
loc_32d2:
032d2  a2 50 37             mov byte ptr [0x3750], al    ; couleur_texte
032d5  3e 8a 46 02          mov al, byte ptr ds:[bp + 2]
032d9  a2 51 37             mov byte ptr [0x3751], al    ; couleur_fond
032dc  83 c5 02             add bp, 2
032df  c3                   ret
loc_32e0:
032e0  3c 10                cmp al, 0x10
032e2  75 03                jne loc_32e7
032e4  e9 c3 01             jmp loc_34aa
loc_32e7:
032e7  3c 11                cmp al, 0x11
032e9  75 03                jne loc_32ee
032eb  e9 92 01             jmp loc_3480
loc_32ee:
032ee  3c 12                cmp al, 0x12
032f0  75 03                jne loc_32f5
032f2  e9 9f 01             jmp loc_3494
loc_32f5:
032f5  55                   push bp
032f6  32 e4                xor ah, ah
032f8  d1 e0                shl ax, 1
032fa  d1 e0                shl ax, 1
032fc  d1 e0                shl ax, 1
032fe  05 13 31             add ax, 0x3113    ; police
03301  8b f0                mov si, ax
03303  bf 5d 37             mov di, 0x375d
03306  8a 1e 50 37          mov bl, byte ptr [0x3750]    ; couleur_texte
0330a  8a 3e 51 37          mov bh, byte ptr [0x3751]    ; couleur_fond
0330e  b9 08 00             mov cx, 8
loc_3311:
03311  53                   push bx
03312  ac                   lodsb al, byte ptr [si]
03313  32 e4                xor ah, ah
03315  d0 eb                shr bl, 1
03317  72 02                jb loc_331b
03319  88 25                mov byte ptr [di], ah
loc_331b:
0331b  73 02                jae loc_331f
0331d  88 05                mov byte ptr [di], al
loc_331f:
0331f  d0 eb                shr bl, 1
03321  72 03                jb loc_3326
03323  88 65 08             mov byte ptr [di + 8], ah
loc_3326:
03326  73 03                jae loc_332b
03328  88 45 08             mov byte ptr [di + 8], al
loc_332b:
0332b  d0 eb                shr bl, 1
0332d  72 03                jb loc_3332
0332f  88 65 10             mov byte ptr [di + 0x10], ah
loc_3332:
03332  73 03                jae loc_3337
03334  88 45 10             mov byte ptr [di + 0x10], al
loc_3337:
03337  d0 eb                shr bl, 1
03339  72 03                jb loc_333e
0333b  88 65 18             mov byte ptr [di + 0x18], ah
loc_333e:
0333e  73 03                jae loc_3343
03340  88 45 18             mov byte ptr [di + 0x18], al
loc_3343:
03343  f6 d0                not al
03345  80 3e 59 37 00       cmp byte ptr [0x3759], 0    ; texte_transparent
0334a  75 1b                jne loc_3367
0334c  d0 ef                shr bh, 1
0334e  73 02                jae loc_3352
03350  08 05                or byte ptr [di], al
loc_3352:
03352  d0 ef                shr bh, 1
03354  73 03                jae loc_3359
03356  08 45 08             or byte ptr [di + 8], al
loc_3359:
03359  d0 ef                shr bh, 1
0335b  73 03                jae loc_3360
0335d  08 45 10             or byte ptr [di + 0x10], al
loc_3360:
03360  d0 ef                shr bh, 1
03362  73 03                jae loc_3367
03364  08 45 18             or byte ptr [di + 0x18], al
loc_3367:
03367  5b                   pop bx
03368  47                   inc di
03369  e2 a6                loop loc_3311
0336b  be 5d 37             mov si, 0x375d
0336e  a1 56 37             mov ax, word ptr [0x3756]    ; texte_segment
03371  8e c0                mov es, ax
03373  3d 00 a0             cmp ax, 0xa000
03376  75 7a                jne loc_33f2
03378  a1 54 37             mov ax, word ptr [0x3754]    ; texte_ligne
0337b  ba 40 01             mov dx, 0x140
0337e  f7 e2                mul dx
03380  03 06 52 37          add ax, word ptr [0x3752]    ; texte_colonne
03384  8b f8                mov di, ax
03386  ba ce 03             mov dx, 0x3ce
03389  b4 18                mov ah, 0x18
0338b  b0 03                mov al, 3
0338d  ef                   out dx, ax
0338e  b8 05 08             mov ax, 0x805
03391  ef                   out dx, ax
03392  b8 07 00             mov ax, 7
03395  ef                   out dx, ax
03396  b8 08 ff             mov ax, 0xff08
03399  ef                   out dx, ax
0339a  b2 c4                mov dl, 0xc4
0339c  b8 02 08             mov ax, 0x802
0339f  b9 08 00             mov cx, 8
loc_33a2:
033a2  ef                   out dx, ax
033a3  50                   push ax
033a4  ac                   lodsb al, byte ptr [si]
033a5  26 88 05             mov byte ptr es:[di], al
033a8  ac                   lodsb al, byte ptr [si]
033a9  26 88 45 28          mov byte ptr es:[di + 0x28], al
033ad  ac                   lodsb al, byte ptr [si]
033ae  26 88 45 50          mov byte ptr es:[di + 0x50], al
033b2  ac                   lodsb al, byte ptr [si]
033b3  26 88 45 78          mov byte ptr es:[di + 0x78], al
033b7  ac                   lodsb al, byte ptr [si]
033b8  26 88 85 a0 00       mov byte ptr es:[di + 0xa0], al
033bd  ac                   lodsb al, byte ptr [si]
033be  26 88 85 c8 00       mov byte ptr es:[di + 0xc8], al
033c3  ac                   lodsb al, byte ptr [si]
033c4  26 88 85 f0 00       mov byte ptr es:[di + 0xf0], al
033c9  ac                   lodsb al, byte ptr [si]
033ca  26 88 85 18 01       mov byte ptr es:[di + 0x118], al
033cf  58                   pop ax
033d0  d0 ec                shr ah, 1
033d2  e2 ce                loop loc_33a2
loc_33d4:
033d4  50                   push ax
033d5  b8 7c 09             mov ax, 0x97c
033d8  8e d8                mov ds, ax
033da  58                   pop ax
033db  ff 06 52 37          inc word ptr [0x3752]    ; texte_colonne
033df  83 3e 52 37 28       cmp word ptr [0x3752], 0x28    ; texte_colonne
033e4  72 0a                jb loc_33f0
033e6  c7 06 52 37 00 00    mov word ptr [0x3752], 0    ; texte_colonne
033ec  ff 06 54 37          inc word ptr [0x3754]    ; texte_ligne
loc_33f0:
033f0  5d                   pop bp
033f1  c3                   ret
loc_33f2:
033f2  a1 54 37             mov ax, word ptr [0x3754]    ; texte_ligne
033f5  ba 40 01             mov dx, 0x140
033f8  f7 e2                mul dx
033fa  d1 e0                shl ax, 1
033fc  d1 e0                shl ax, 1
033fe  03 06 52 37          add ax, word ptr [0x3752]    ; texte_colonne
03402  8b f8                mov di, ax
03404  b9 08 00             mov cx, 8
03407  80 3e 59 37 00       cmp byte ptr [0x3759], 0    ; texte_transparent
0340c  75 29                jne loc_3437
loc_340e:
0340e  57                   push di
0340f  56                   push si
03410  a4                   movsb byte ptr es:[di], byte ptr [si]
03411  83 c6 07             add si, 7
03414  83 c7 27             add di, 0x27
03417  a4                   movsb byte ptr es:[di], byte ptr [si]
03418  83 c6 07             add si, 7
0341b  83 c7 27             add di, 0x27
0341e  a4                   movsb byte ptr es:[di], byte ptr [si]
0341f  83 c6 07             add si, 7
03422  83 c7 27             add di, 0x27
03425  a4                   movsb byte ptr es:[di], byte ptr [si]
03426  83 c6 07             add si, 7
03429  83 c7 27             add di, 0x27
0342c  5e                   pop si
0342d  5f                   pop di
0342e  46                   inc si
0342f  81 c7 a0 00          add di, 0xa0
03433  e2 d9                loop loc_340e
03435  eb 9d                jmp loc_33d4
loc_3437:
03437  8a 24                mov ah, byte ptr [si]
03439  0a 64 08             or ah, byte ptr [si + 8]
0343c  0a 64 10             or ah, byte ptr [si + 0x10]
0343f  0a 64 18             or ah, byte ptr [si + 0x18]
03442  f6 d4                not ah
03444  ac                   lodsb al, byte ptr [si]
03445  26 20 25             and byte ptr es:[di], ah
03448  26 08 05             or byte ptr es:[di], al
0344b  83 c6 07             add si, 7
0344e  83 c7 28             add di, 0x28
03451  ac                   lodsb al, byte ptr [si]
03452  26 20 25             and byte ptr es:[di], ah
03455  26 08 05             or byte ptr es:[di], al
03458  83 c6 07             add si, 7
0345b  83 c7 28             add di, 0x28
0345e  ac                   lodsb al, byte ptr [si]
0345f  26 20 25             and byte ptr es:[di], ah
03462  26 08 05             or byte ptr es:[di], al
03465  83 c6 07             add si, 7
03468  83 c7 28             add di, 0x28
0346b  ac                   lodsb al, byte ptr [si]
0346c  26 20 25             and byte ptr es:[di], ah
0346f  26 08 05             or byte ptr es:[di], al
03472  83 c6 07             add si, 7
03475  83 c7 28             add di, 0x28
03478  83 ee 1f             sub si, 0x1f
0347b  e2 ba                loop loc_3437
0347d  e9 54 ff             jmp loc_33d4
loc_3480:
03480  3e 8a 46 01          mov al, byte ptr ds:[bp + 1]
03484  32 e4                xor ah, ah
03486  a3 54 37             mov word ptr [0x3754], ax    ; texte_ligne
03489  3e 8a 46 02          mov al, byte ptr ds:[bp + 2]
0348d  a3 52 37             mov word ptr [0x3752], ax    ; texte_colonne
03490  83 c5 02             add bp, 2
03493  c3                   ret
loc_3494:
03494  3e 8a 46 02          mov al, byte ptr ds:[bp + 2]
03498  04 04                add al, 4
0349a  32 e4                xor ah, ah
0349c  a3 54 37             mov word ptr [0x3754], ax    ; texte_ligne
0349f  3e 8a 46 01          mov al, byte ptr ds:[bp + 1]
034a3  a3 52 37             mov word ptr [0x3752], ax    ; texte_colonne
034a6  83 c5 02             add bp, 2
034a9  c3                   ret
loc_34aa:
034aa  3e 8a 46 01          mov al, byte ptr ds:[bp + 1]
034ae  a2 50 37             mov byte ptr [0x3750], al    ; couleur_texte
034b1  3e 8a 46 02          mov al, byte ptr ds:[bp + 2]
034b5  a2 51 37             mov byte ptr [0x3751], al    ; couleur_fond
034b8  83 c5 02             add bp, 2
034bb  c3                   ret
loc_34bc:
034bc  3c 10                cmp al, 0x10
034be  75 03                jne loc_34c3
034c0  e9 c9 00             jmp loc_358c
loc_34c3:
034c3  3c 11                cmp al, 0x11
034c5  75 03                jne loc_34ca
034c7  e9 98 00             jmp loc_3562
loc_34ca:
034ca  3c 12                cmp al, 0x12
034cc  75 03                jne loc_34d1
034ce  e9 a5 00             jmp loc_3576
loc_34d1:
034d1  9c                   pushf
034d2  50                   push ax
034d3  53                   push bx
034d4  51                   push cx
034d5  52                   push dx
034d6  57                   push di
034d7  56                   push si
034d8  55                   push bp
034d9  06                   push es
034da  1e                   push ds
034db  32 e4                xor ah, ah
034dd  d1 e0                shl ax, 1
034df  d1 e0                shl ax, 1
034e1  d1 e0                shl ax, 1
034e3  05 13 31             add ax, 0x3113    ; police
034e6  8b f0                mov si, ax
034e8  a1 54 37             mov ax, word ptr [0x3754]    ; texte_ligne
034eb  ba 00 0a             mov dx, 0xa00    ; "AND TRY AGAIN"
034ee  f7 e2                mul dx
034f0  8b 16 52 37          mov dx, word ptr [0x3752]    ; texte_colonne
034f4  d1 e2                shl dx, 1
034f6  d1 e2                shl dx, 1
034f8  d1 e2                shl dx, 1
034fa  03 c2                add ax, dx
034fc  8b f8                mov di, ax
034fe  a1 56 37             mov ax, word ptr [0x3756]    ; texte_segment
03501  8e c0                mov es, ax
03503  8a 1e 50 37          mov bl, byte ptr [0x3750]    ; couleur_texte
03507  8a 3e 51 37          mov bh, byte ptr [0x3751]    ; couleur_fond
0350b  b9 08 00             mov cx, 8
loc_350e:
0350e  51                   push cx
0350f  ac                   lodsb al, byte ptr [si]
03510  f6 06 58 37 01       test byte ptr [0x3758], 1    ; texte_inverse
03515  74 02                je loc_3519
03517  f6 d0                not al
loc_3519:
03519  8a e0                mov ah, al
0351b  b9 08 00             mov cx, 8
loc_351e:
0351e  8a c3                mov al, bl
03520  d0 e4                shl ah, 1
03522  72 0d                jb loc_3531
03524  8a c7                mov al, bh
03526  80 3e 59 37 00       cmp byte ptr [0x3759], 0    ; texte_transparent
0352b  74 04                je loc_3531
0352d  47                   inc di
0352e  eb 02                jmp loc_3532
; ---- 1 octets non atteints (3530-3530)
loc_3531:
03531  aa                   stosb byte ptr es:[di], al
loc_3532:
03532  e2 ea                loop loc_351e
03534  59                   pop cx
03535  81 c7 38 01          add di, 0x138
03539  e2 d3                loop loc_350e
0353b  50                   push ax
0353c  b8 7c 09             mov ax, 0x97c
0353f  8e d8                mov ds, ax
03541  58                   pop ax
03542  ff 06 52 37          inc word ptr [0x3752]    ; texte_colonne
03546  83 3e 52 37 28       cmp word ptr [0x3752], 0x28    ; texte_colonne
0354b  72 0a                jb loc_3557
0354d  c7 06 52 37 00 00    mov word ptr [0x3752], 0    ; texte_colonne
03553  ff 06 54 37          inc word ptr [0x3754]    ; texte_ligne
loc_3557:
03557  1f                   pop ds
03558  07                   pop es
03559  5d                   pop bp
0355a  5e                   pop si
0355b  5f                   pop di
0355c  5a                   pop dx
0355d  59                   pop cx
0355e  5b                   pop bx
0355f  58                   pop ax
03560  9d                   popf
03561  c3                   ret
loc_3562:
03562  3e 8a 46 01          mov al, byte ptr ds:[bp + 1]
03566  a3 54 37             mov word ptr [0x3754], ax    ; texte_ligne
03569  32 e4                xor ah, ah
0356b  3e 8a 46 02          mov al, byte ptr ds:[bp + 2]
0356f  a3 52 37             mov word ptr [0x3752], ax    ; texte_colonne
03572  83 c5 02             add bp, 2
03575  c3                   ret
loc_3576:
03576  3e 8a 46 02          mov al, byte ptr ds:[bp + 2]
0357a  32 e4                xor ah, ah
0357c  04 04                add al, 4
0357e  a3 54 37             mov word ptr [0x3754], ax    ; texte_ligne
03581  3e 8a 46 01          mov al, byte ptr ds:[bp + 1]
03585  a3 52 37             mov word ptr [0x3752], ax    ; texte_colonne
03588  83 c5 02             add bp, 2
0358b  c3                   ret
loc_358c:
0358c  3e 8a 46 01          mov al, byte ptr ds:[bp + 1]
03590  a2 50 37             mov byte ptr [0x3750], al    ; couleur_texte
03593  3e 8a 46 02          mov al, byte ptr ds:[bp + 2]
03597  a2 51 37             mov byte ptr [0x3751], al    ; couleur_fond
0359a  83 c5 02             add bp, 2
0359d  c3                   ret

; ======== mode_tandy
; mode vidéo 4 : int 10h mode 8 (Tandy / PCjr)
0359e  c7 06 90 31 04 00    mov word ptr [0x3190], 4    ; mode_video
035a4  b4 00                mov ah, 0
035a6  b0 08                mov al, 8
035a8  cd 10                int 0x10
035aa  c3                   ret

; ======== pause_courte   (appelée depuis 4688)
; boucle de 1000 nop, registres conservés ; unité de temporise
035ab  9c                   pushf
035ac  50                   push ax
035ad  53                   push bx
035ae  51                   push cx
035af  52                   push dx
035b0  57                   push di
035b1  56                   push si
035b2  55                   push bp
035b3  06                   push es
035b4  1e                   push ds
035b5  b9 e8 03             mov cx, 0x3e8
loc_35b8:
035b8  90                   nop
035b9  e2 fd                loop loc_35b8
035bb  1f                   pop ds
035bc  07                   pop es
035bd  5d                   pop bp
035be  5e                   pop si
035bf  5f                   pop di
035c0  5a                   pop dx
035c1  59                   pop cx
035c2  5b                   pop bx
035c3  58                   pop ax
035c4  9d                   popf
035c5  c3                   ret

; ======== pause_longue
; non appelée : même chose, 65535 tours
035c6  9c                   pushf
035c7  50                   push ax
035c8  53                   push bx
035c9  51                   push cx
035ca  52                   push dx
035cb  57                   push di
035cc  56                   push si
035cd  55                   push bp
035ce  06                   push es
035cf  1e                   push ds
035d0  b9 ff ff             mov cx, 0xffff
035d3  eb e3                jmp loc_35b8

; ======== attend_touche   (appelée depuis 00d2, 3a3c)
; attend une touche du clavier, puis son relâchement (attend_touches_relachees) ; AL ASCII, AH code
035d5  e8 0a 00             call touche_enfoncee
035d8  0a c0                or al, al
035da  74 f9                je attend_touche
035dc  50                   push ax
035dd  e8 2b 00             call attend_touches_relachees
035e0  58                   pop ax
035e1  c3                   ret

; ======== touche_enfoncee   (appelée depuis 0099, 35d5, 360b)
; première touche à 1 dans etat_touches : AH code clavier, AL ASCII (table DS:399D) ; AX = 0 sinon
035e2  06                   push es
035e3  50                   push ax
035e4  b8 7c 09             mov ax, 0x97c
035e7  8e c0                mov es, ax
035e9  58                   pop ax
035ea  fc                   cld
035eb  b9 80 00             mov cx, 0x80
035ee  b0 01                mov al, 1
035f0  bf 12 39             mov di, 0x3912    ; etat_touches
loc_35f3:
035f3  26 38 05             cmp byte ptr es:[di], al
035f6  74 07                je loc_35ff
035f8  47                   inc di
035f9  e2 f8                loop loc_35f3
035fb  33 c0                xor ax, ax
035fd  07                   pop es
035fe  c3                   ret
loc_35ff:
035ff  b0 80                mov al, 0x80
03601  2a c1                sub al, cl
03603  8a e0                mov ah, al
03605  bb 9d 39             mov bx, 0x399d    ; ascii_touches
03608  d7                   xlatb
03609  07                   pop es
0360a  c3                   ret

; ======== attend_touches_relachees   (appelée depuis 35dd)
; attend qu'aucune touche ne soit enfoncée (touche_enfoncee rend 0)
0360b  e8 d4 ff             call touche_enfoncee
0360e  0a c0                or al, al
03610  75 f9                jne attend_touches_relachees
03612  c3                   ret

; ======== hasard   (appelée depuis 0067, 603b, 6736, 87dd)
; nombre de 1 à BL dans AL (registre à décalage DS:38FD)
03613  a1 fd 38             mov ax, word ptr [0x38fd]    ; graine
03616  24 48                and al, 0x48
03618  04 38                add al, 0x38
0361a  d0 d0                rcl al, 1
0361c  d0 d0                rcl al, 1
0361e  d0 16 00 39          rcl byte ptr [0x3900]
03622  d0 16 ff 38          rcl byte ptr [0x38ff]
03626  d0 16 fe 38          rcl byte ptr [0x38fe]
0362a  d0 16 fd 38          rcl byte ptr [0x38fd]    ; graine
0362e  a1 fd 38             mov ax, word ptr [0x38fd]    ; graine
03631  32 e4                xor ah, ah
03633  f6 f3                div bl
03635  8a c4                mov al, ah
03637  fe c0                inc al
03639  0a c0                or al, al
0363b  75 02                jne loc_363f
0363d  fe c0                inc al
loc_363f:
0363f  c3                   ret

; ======== efface_ecran   (appelée depuis 602d)
; remet la position du texte à 0 et remplit A000 ; table DS:3744 : VGA avec couleur_fond, EGA avec couleur_fond mais 200 mots seulement, Tandy avec AX = mode_video (4)
03640  c7 06 52 37 00 00    mov word ptr [0x3752], 0    ; texte_colonne
03646  c7 06 54 37 00 00    mov word ptr [0x3754], 0    ; texte_ligne
0364c  fc                   cld
0364d  33 c0                xor ax, ax
0364f  8b f8                mov di, ax
03651  b9 7c 09             mov cx, 0x97c
03654  a1 90 31             mov ax, word ptr [0x3190]    ; mode_video
03657  bb 44 37             mov bx, 0x3744    ; saut_efface_ecran
0365a  03 1e 90 31          add bx, word ptr [0x3190]    ; mode_video
0365e  ff 27                jmp word ptr [bx]
loc_3660:
03660  50                   push ax
03661  b8 00 a0             mov ax, 0xa000
03664  8e c0                mov es, ax
03666  58                   pop ax
03667  33 ff                xor di, di
03669  b9 00 40             mov cx, 0x4000
0366c  f3 ab                rep stosw word ptr es:[di], ax
0366e  c3                   ret
loc_366f:
0366f  50                   push ax
03670  b8 00 a0             mov ax, 0xa000
03673  8e c0                mov es, ax
03675  58                   pop ax
03676  ba ce 03             mov dx, 0x3ce
03679  8a 26 51 37          mov ah, byte ptr [0x3751]    ; couleur_fond
0367d  b0 00                mov al, 0
0367f  ef                   out dx, ax
03680  b8 01 0f             mov ax, 0xf01
03683  ef                   out dx, ax
03684  b9 c8 00             mov cx, 0xc8
03687  f3 ab                rep stosw word ptr es:[di], ax
03689  b8 01 00             mov ax, 1
0368c  ef                   out dx, ax
0368d  c3                   ret
loc_368e:
0368e  50                   push ax
0368f  b8 00 a0             mov ax, 0xa000
03692  8e c0                mov es, ax
03694  58                   pop ax
03695  a0 51 37             mov al, byte ptr [0x3751]    ; couleur_fond
03698  8a e0                mov ah, al
0369a  b9 00 7d             mov cx, 0x7d00
0369d  f3 ab                rep stosw word ptr es:[di], ax
0369f  c3                   ret

; ======== attend_retour_vertical   (appelée depuis 2533, 44d4, 61f6, 677b)
; attend le début du retour de trame (port 3DAh bit 3)
036a0  52                   push dx
036a1  50                   push ax
036a2  ba da 03             mov dx, 0x3da
loc_36a5:
036a5  ec                   in al, dx
036a6  24 08                and al, 8
036a8  74 fb                je loc_36a5
036aa  58                   pop ax
036ab  5a                   pop dx
036ac  c3                   ret
; ---- 13 octets non atteints (36ad-36b9)

; ======== clavier_installe   (appelée depuis 0104, 01b4, 01cf, 01fd, 0218, 1df2, 1e0d, 1e55)
; détourne int 9 vers clavier_interruption et vide la table des touches DS:3912
036ba  bb 09 37             mov bx, 0x3709
036bd  39 1e 9b 39          cmp word ptr [0x399b], bx
036c1  75 01                jne loc_36c4
036c3  c3                   ret
loc_36c4:
036c4  06                   push es
036c5  b4 35                mov ah, 0x35
036c7  b0 09                mov al, 9
036c9  cd 21                int 0x21
036cb  bf 99 39             mov di, 0x3999
036ce  8c 05                mov word ptr [di], es
036d0  89 5d 02             mov word ptr [di + 2], bx
036d3  07                   pop es
036d4  1e                   push ds
036d5  0e                   push cs
036d6  1f                   pop ds
036d7  ba 09 37             mov dx, 0x3709
036da  b4 25                mov ah, 0x25
036dc  b0 09                mov al, 9
036de  cd 21                int 0x21
036e0  1f                   pop ds
036e1  bf 12 39             mov di, 0x3912    ; etat_touches
036e4  b8 7c 09             mov ax, 0x97c
036e7  8e c0                mov es, ax
036e9  33 c0                xor ax, ax
036eb  b9 40 00             mov cx, 0x40
036ee  f3 ab                rep stosw word ptr es:[di], ax
036f0  c3                   ret

; ======== clavier_retire   (appelée depuis 0114, 01a4, 01bd, 01ed, 0206, 02bf, 1de2, 1dfb)
; remet l'ancien vecteur int 9 (avant chaque accès disque)
036f1  1e                   push ds
036f2  bf 99 39             mov di, 0x3999
036f5  8b 55 02             mov dx, word ptr [di + 2]
036f8  83 fa 00             cmp dx, 0
036fb  74 0a                je loc_3707
036fd  8b 05                mov ax, word ptr [di]
036ff  8e d8                mov ds, ax
03701  b4 25                mov ah, 0x25
03703  b0 09                mov al, 9
03705  cd 21                int 0x21
loc_3707:
03707  1f                   pop ds
03708  c3                   ret

; ======== clavier_interruption
; int 9 : lit le port 60h, met à 1 ou 0 l'octet de la touche dans DS:3912
03709  9c                   pushf
0370a  50                   push ax
0370b  53                   push bx
0370c  51                   push cx
0370d  52                   push dx
0370e  57                   push di
0370f  56                   push si
03710  55                   push bp
03711  06                   push es
03712  1e                   push ds
03713  50                   push ax
03714  b8 7c 09             mov ax, 0x97c
03717  8e d8                mov ds, ax
03719  58                   pop ax
0371a  e4 60                in al, 0x60
0371c  8a d8                mov bl, al
0371e  e4 61                in al, 0x61
03720  8a e0                mov ah, al
03722  0c 80                or al, 0x80
03724  e6 61                out 0x61, al
03726  86 e0                xchg al, ah
03728  e6 61                out 0x61, al
0372a  8a c3                mov al, bl
0372c  32 e4                xor ah, ah
0372e  bb 12 39             mov bx, 0x3912    ; etat_touches
03731  a8 80                test al, 0x80
03733  75 07                jne loc_373c
03735  03 d8                add bx, ax
03737  c6 07 01             mov byte ptr [bx], 1
0373a  eb 07                jmp loc_3743
loc_373c:
0373c  24 7f                and al, 0x7f
0373e  03 d8                add bx, ax
03740  c6 07 00             mov byte ptr [bx], 0
loc_3743:
03743  b0 61                mov al, 0x61
03745  e6 20                out 0x20, al
03747  1f                   pop ds
03748  07                   pop es
03749  5d                   pop bp
0374a  5e                   pop si
0374b  5f                   pop di
0374c  5a                   pop dx
0374d  59                   pop cx
0374e  5b                   pop bx
0374f  58                   pop ax
03750  9d                   popf
03751  cf                   iret

; ======== lit_commandes   (appelée depuis 38ef, 38fa, 3916, 393f, 3965, 63ea, 6745, 73c5)
; fusionne clavier, joystick et souris dans DS:3992 ; déplace le curseur DS:3993/3995
03752  c6 06 92 39 00       mov byte ptr [0x3992], 0    ; commandes
03757  b9 06 00             mov cx, 6
0375a  33 db                xor bx, bx
0375c  be 0b 39             mov si, 0x390b    ; touches_commandes
0375f  bf 12 39             mov di, 0x3912    ; etat_touches
loc_3762:
03762  8a 1c                mov bl, byte ptr [si]
03764  8a 01                mov al, byte ptr [bx + di]
03766  d0 e8                shr al, 1
03768  d0 16 92 39          rcl byte ptr [0x3992]    ; commandes
0376c  46                   inc si
0376d  e2 f3                loop loc_3762
0376f  80 26 92 39 7f       and byte ptr [0x3992], 0x7f    ; commandes
03774  f6 06 13 39 01       test byte ptr [0x3913], 1
03779  74 13                je loc_378e
0377b  f6 06 2f 39 01       test byte ptr [0x392f], 1
03780  74 05                je loc_3787
03782  80 0e 92 39 40       or byte ptr [0x3992], 0x40    ; commandes
loc_3787:
03787  a0 2f 39             mov al, byte ptr [0x392f]
0378a  8a 26 13 39          mov ah, byte ptr [0x3913]
loc_378e:
0378e  e8 18 00             call lit_joystick
03791  e8 a1 00             call curseur_clavier
03794  e8 ef 00             call lit_souris
03797  81 3e 93 39 2f 01    cmp word ptr [0x3993], 0x12f    ; curseur_x
0379d  76 06                jbe loc_37a5
0379f  c7 06 93 39 2f 01    mov word ptr [0x3993], 0x12f    ; curseur_x
loc_37a5:
037a5  e8 a8 10             call son_musique
037a8  c3                   ret

; ======== lit_joystick   (appelée depuis 378e)
; si DS:3193 = 2
037a9  80 3e 93 31 02       cmp byte ptr [0x3193], 2    ; commande_type
037ae  74 01                je loc_37b1
037b0  c3                   ret
loc_37b1:
037b1  e8 5a 0f             call joystick_position
037b4  80 3e 0a 32 03       cmp byte ptr [0x320a], 3    ; masque_joystick
037b9  74 04                je loc_37bf
037bb  8b df                mov bx, di
037bd  8b ce                mov cx, si
loc_37bf:
037bf  3b 0e 0b 32          cmp cx, word ptr [0x320b]    ; joystick_centre_x
037c3  72 11                jb loc_37d6
037c5  2b 0e 0b 32          sub cx, word ptr [0x320b]    ; joystick_centre_x
037c9  83 f9 20             cmp cx, 0x20
037cc  72 16                jb loc_37e4
037ce  80 0e 92 39 02       or byte ptr [0x3992], 2    ; commandes
037d3  eb 0f                jmp loc_37e4
; ---- 1 octets non atteints (37d5-37d5)
loc_37d6:
037d6  2b 0e 0b 32          sub cx, word ptr [0x320b]    ; joystick_centre_x
037da  83 f9 e0             cmp cx, -0x20
037dd  77 05                ja loc_37e4
037df  80 0e 92 39 01       or byte ptr [0x3992], 1    ; commandes
loc_37e4:
037e4  3b 1e 0d 32          cmp bx, word ptr [0x320d]    ; joystick_centre_y
037e8  72 11                jb loc_37fb
037ea  2b 1e 0d 32          sub bx, word ptr [0x320d]    ; joystick_centre_y
037ee  83 fb 20             cmp bx, 0x20
037f1  72 16                jb loc_3809
037f3  80 0e 92 39 08       or byte ptr [0x3992], 8    ; commandes
037f8  eb 0f                jmp loc_3809
; ---- 1 octets non atteints (37fa-37fa)
loc_37fb:
037fb  2b 1e 0d 32          sub bx, word ptr [0x320d]    ; joystick_centre_y
037ff  83 fb e0             cmp bx, -0x20
03802  77 05                ja loc_3809
03804  80 0e 92 39 04       or byte ptr [0x3992], 4    ; commandes
loc_3809:
03809  e8 49 0f             call joystick_boutons
0380c  a9 01 00             test ax, 1
0380f  74 05                je loc_3816
03811  80 0e 92 39 10       or byte ptr [0x3992], 0x10    ; commandes
loc_3816:
03816  a9 02 00             test ax, 2
03819  74 05                je loc_3820
0381b  80 0e 92 39 20       or byte ptr [0x3992], 0x20    ; commandes
loc_3820:
03820  a9 04 00             test ax, 4
03823  74 05                je loc_382a
03825  80 0e 92 39 10       or byte ptr [0x3992], 0x10    ; commandes
loc_382a:
0382a  a9 08 00             test ax, 8
0382d  74 05                je loc_3834
0382f  80 0e 92 39 20       or byte ptr [0x3992], 0x20    ; commandes
loc_3834:
03834  c3                   ret

; ======== curseur_clavier   (appelée depuis 3791)
; déplace le curseur de 4 pixels selon les bits de direction
03835  f6 06 92 39 01       test byte ptr [0x3992], 1    ; commandes
0383a  74 0c                je loc_3848
0383c  83 3e 95 39 04       cmp word ptr [0x3995], 4    ; curseur_y
03841  72 05                jb loc_3848
03843  83 2e 95 39 04       sub word ptr [0x3995], 4    ; curseur_y
loc_3848:
03848  f6 06 92 39 02       test byte ptr [0x3992], 2    ; commandes
0384d  74 0d                je loc_385c
0384f  81 3e 95 39 c2 00    cmp word ptr [0x3995], 0xc2    ; curseur_y
03855  77 05                ja loc_385c
03857  83 06 95 39 04       add word ptr [0x3995], 4    ; curseur_y
loc_385c:
0385c  f6 06 92 39 04       test byte ptr [0x3992], 4    ; commandes
03861  74 0c                je loc_386f
03863  83 3e 93 39 04       cmp word ptr [0x3993], 4    ; curseur_x
03868  72 05                jb loc_386f
0386a  83 2e 93 39 04       sub word ptr [0x3993], 4    ; curseur_x
loc_386f:
0386f  f6 06 92 39 08       test byte ptr [0x3992], 8    ; commandes
03874  75 01                jne loc_3877
03876  c3                   ret
loc_3877:
03877  81 3e 93 39 3b 01    cmp word ptr [0x3993], 0x13b    ; curseur_x
0387d  76 01                jbe loc_3880
0387f  c3                   ret
loc_3880:
03880  83 06 93 39 04       add word ptr [0x3993], 4    ; curseur_x
03885  c3                   ret

; ======== lit_souris   (appelée depuis 3794)
; si DS:3193 = 0 : int 33h AX=3, boutons et position
03886  80 3e 93 31 00       cmp byte ptr [0x3193], 0    ; commande_type
0388b  74 01                je loc_388e
0388d  c3                   ret
loc_388e:
0388e  b8 03 00             mov ax, 3
03891  cd 33                int 0x33
03893  f7 c3 01 00          test bx, 1
03897  74 05                je loc_389e
03899  80 0e 92 39 10       or byte ptr [0x3992], 0x10    ; commandes
loc_389e:
0389e  f7 c3 02 00          test bx, 2
038a2  74 05                je loc_38a9
038a4  80 0e 92 39 20       or byte ptr [0x3992], 0x20    ; commandes
loc_38a9:
038a9  d1 e9                shr cx, 1
038ab  3b 0e 93 39          cmp cx, word ptr [0x3993]    ; curseur_x
038af  74 0e                je loc_38bf
038b1  72 07                jb loc_38ba
038b3  80 0e 92 39 08       or byte ptr [0x3992], 8    ; commandes
038b8  eb 05                jmp loc_38bf
loc_38ba:
038ba  80 0e 92 39 04       or byte ptr [0x3992], 4    ; commandes
loc_38bf:
038bf  3b 16 95 39          cmp dx, word ptr [0x3995]    ; curseur_y
038c3  74 0f                je loc_38d4
038c5  72 08                jb loc_38cf
038c7  80 0e 92 39 02       or byte ptr [0x3992], 2    ; commandes
038cc  eb 06                jmp loc_38d4
; ---- 1 octets non atteints (38ce-38ce)
loc_38cf:
038cf  80 0e 92 39 01       or byte ptr [0x3992], 1    ; commandes
loc_38d4:
038d4  89 0e 93 39          mov word ptr [0x3993], cx    ; curseur_x
038d8  89 16 95 39          mov word ptr [0x3995], dx    ; curseur_y
038dc  c3                   ret

; ======== souris_position   (appelée depuis 5f86)
; int 33h AX=4 (place le curseur de la souris)
038dd  80 3e 93 31 00       cmp byte ptr [0x3193], 0    ; commande_type
038e2  74 01                je loc_38e5
038e4  c3                   ret
loc_38e5:
038e5  33 c9                xor cx, cx
038e7  8b d2                mov dx, dx
038e9  b8 04 00             mov ax, 4
038ec  cd 33                int 0x33
038ee  c3                   ret

; ======== attend_commande
; attend une commande (DS:3992 non nul)
038ef  e8 60 fe             call lit_commandes
038f2  80 3e 92 39 00       cmp byte ptr [0x3992], 0    ; commandes
038f7  74 f6                je attend_commande
038f9  c3                   ret

; ======== attend_relache   (appelée depuis 3920, 7954)
; attend que DS:3992 revienne à 0
038fa  e8 55 fe             call lit_commandes
038fd  80 3e 92 39 00       cmp byte ptr [0x3992], 0    ; commandes
03902  75 f6                jne attend_relache
03904  c3                   ret
attend_bouton_droit:    ; attend le bouton droit seul (0x20), puis son relâchement
03905  9c                   pushf
03906  50                   push ax
03907  53                   push bx
03908  51                   push cx
03909  52                   push dx
0390a  57                   push di
0390b  56                   push si
0390c  55                   push bp
0390d  06                   push es
0390e  1e                   push ds
0390f  50                   push ax
03910  b8 7c 09             mov ax, 0x97c
03913  8e d8                mov ds, ax
03915  58                   pop ax
loc_3916:
03916  e8 39 fe             call lit_commandes
03919  80 3e 92 39 20       cmp byte ptr [0x3992], 0x20    ; commandes
0391e  75 f6                jne loc_3916
03920  e8 d7 ff             call attend_relache
03923  1f                   pop ds
03924  07                   pop es
03925  5d                   pop bp
03926  5e                   pop si
03927  5f                   pop di
03928  5a                   pop dx
03929  59                   pop cx
0392a  5b                   pop bx
0392b  58                   pop ax
0392c  9d                   popf
0392d  c3                   ret

; ======== attend_clic   (appelée depuis 0231, 0240, 4f17, 5f21, 6449)
; attend le bit 0x10 (clic gauche) de commandes
0392e  9c                   pushf
0392f  50                   push ax
03930  53                   push bx
03931  51                   push cx
03932  52                   push dx
03933  57                   push di
03934  56                   push si
03935  55                   push bp
03936  06                   push es
03937  1e                   push ds
03938  50                   push ax
03939  b8 7c 09             mov ax, 0x97c
0393c  8e d8                mov ds, ax
0393e  58                   pop ax
loc_393f:
0393f  e8 10 fe             call lit_commandes
03942  f6 06 92 39 10       test byte ptr [0x3992], 0x10    ; commandes
03947  74 f6                je loc_393f
03949  1f                   pop ds
0394a  07                   pop es
0394b  5d                   pop bp
0394c  5e                   pop si
0394d  5f                   pop di
0394e  5a                   pop dx
0394f  59                   pop cx
03950  5b                   pop bx
03951  58                   pop ax
03952  9d                   popf
03953  c3                   ret

; ======== attend_relache_boutons   (appelée depuis 0caa, 12f9, 6706, 6768, 73e2, 787b, 7e72, 7f5b)
; attend que les bits 0x10 et 0x20 de commandes soient à 0
03954  9c                   pushf
03955  50                   push ax
03956  53                   push bx
03957  51                   push cx
03958  52                   push dx
03959  57                   push di
0395a  56                   push si
0395b  55                   push bp
0395c  06                   push es
0395d  1e                   push ds
0395e  50                   push ax
0395f  b8 7c 09             mov ax, 0x97c
03962  8e d8                mov ds, ax
03964  58                   pop ax
loc_3965:
03965  e8 ea fd             call lit_commandes
03968  f6 06 92 39 10       test byte ptr [0x3992], 0x10    ; commandes
0396d  75 f6                jne loc_3965
0396f  f6 06 92 39 20       test byte ptr [0x3992], 0x20    ; commandes
03974  75 ef                jne loc_3965
03976  1f                   pop ds
03977  07                   pop es
03978  5d                   pop bp
03979  5e                   pop si
0397a  5f                   pop di
0397b  5a                   pop dx
0397c  59                   pop cx
0397d  5b                   pop bx
0397e  58                   pop ax
0397f  9d                   popf
03980  c3                   ret

; ======== charge_fichier   (appelée depuis 003d, 310b, 47f8, 4817, 50ba, 50f4, 5125, 5156)
; ouvre, lit et ferme DS:3907 vers DS:3901:3903 ; taille lue dans DS:3905
03981  c7 06 e9 37 00 00    mov word ptr [0x37e9], 0    ; erreur_fichier
03987  e8 67 fd             call clavier_retire
0398a  e8 3b 00             call fichier_ouvre
0398d  83 3e e9 37 00       cmp word ptr [0x37e9], 0    ; erreur_fichier
03992  74 03                je loc_3997
03994  eb 1c                jmp loc_39b2
; ---- 1 octets non atteints (3996-3996)
loc_3997:
03997  e8 62 00             call fichier_lit
0399a  a3 05 39             mov word ptr [0x3905], ax    ; fichier_taille
0399d  eb 10                jmp loc_39af
; ---- 1 octets non atteints (399f-399f)

; ======== sauve_fichier   (appelée depuis 7a03, 84dd)
; crée, écrit et ferme DS:3907 depuis DS:3901:3903, DS:3905 octets
039a0  c7 06 e9 37 00 00    mov word ptr [0x37e9], 0    ; erreur_fichier
039a6  e8 48 fd             call clavier_retire
039a9  e8 0a 00             call fichier_cree
039ac  e8 33 00             call fichier_ecrit
loc_39af:
039af  e8 62 00             call fichier_ferme
loc_39b2:
039b2  e8 05 fd             call clavier_installe
039b5  c3                   ret

; ======== fichier_cree   (appelée depuis 39a9)
; int 21h AH=3Ch
039b6  8b 16 07 39          mov dx, word ptr [0x3907]    ; fichier_nom
039ba  33 c9                xor cx, cx
039bc  b0 02                mov al, 2
039be  b4 3c                mov ah, 0x3c
039c0  cd 21                int 0x21
039c2  72 1a                jb loc_39de
039c4  a3 09 39             mov word ptr [0x3909], ax    ; fichier_handle
039c7  c3                   ret

; ======== fichier_ouvre   (appelée depuis 01a7, 01f0, 1de5, 1e48, 398a, 507f, 52b6, 52fc)
; int 21h AH=3Dh ; erreur dans DS:37E9 (2 = fichier absent)
039c8  8b 16 07 39          mov dx, word ptr [0x3907]    ; fichier_nom
039cc  32 c0                xor al, al
039ce  b4 3d                mov ah, 0x3d
039d0  cd 21                int 0x21
039d2  72 0a                jb loc_39de
039d4  c7 06 e9 37 00 00    mov word ptr [0x37e9], 0    ; erreur_fichier
039da  a3 09 39             mov word ptr [0x3909], ax    ; fichier_handle
039dd  c3                   ret
loc_39de:
039de  a3 e9 37             mov word ptr [0x37e9], ax    ; erreur_fichier
039e1  c3                   ret

; ======== fichier_ecrit   (appelée depuis 39ac)
; int 21h AH=40h
039e2  a1 01 39             mov ax, word ptr [0x3901]    ; fichier_segment
039e5  8b 1e 09 39          mov bx, word ptr [0x3909]    ; fichier_handle
039e9  8b 0e 05 39          mov cx, word ptr [0x3905]    ; fichier_taille
039ed  8b 16 03 39          mov dx, word ptr [0x3903]    ; fichier_offset
039f1  1e                   push ds
039f2  8e d8                mov ds, ax
039f4  b4 40                mov ah, 0x40
039f6  cd 21                int 0x21
039f8  1f                   pop ds
039f9  72 e3                jb loc_39de
039fb  c3                   ret

; ======== fichier_lit   (appelée depuis 01c2, 020b, 1e00, 1e63, 3997, 52d1, 5317, 5379)
; int 21h AH=3Fh
039fc  a1 01 39             mov ax, word ptr [0x3901]    ; fichier_segment
039ff  8b 1e 09 39          mov bx, word ptr [0x3909]    ; fichier_handle
03a03  b9 ff ff             mov cx, 0xffff
03a06  8b 16 03 39          mov dx, word ptr [0x3903]    ; fichier_offset
03a0a  1e                   push ds
03a0b  8e d8                mov ds, ax
03a0d  b4 3f                mov ah, 0x3f
03a0f  cd 21                int 0x21
03a11  1f                   pop ds
03a12  72 ca                jb loc_39de

; ======== fichier_ferme   (appelée depuis 39af, 5099)
; int 21h AH=3Eh
03a14  8b 1e 09 39          mov bx, word ptr [0x3909]    ; fichier_handle
03a18  b4 3e                mov ah, 0x3e
03a1a  cd 21                int 0x21
03a1c  72 c0                jb loc_39de
03a1e  c3                   ret

; ======== saisie_ligne   (appelée depuis 3ab3)
; saisie clavier : DI tampon, CX longueur max ; caractères 20h à 7Ah (chiffres seuls si DS:3A8A = 1), retour arrière (code 0Eh), fin par Entrée
03a1f  89 0e 84 3a          mov word ptr [0x3a84], cx    ; saisie_max
03a23  89 3e 86 3a          mov word ptr [0x3a86], di    ; saisie_pointeur
03a27  50                   push ax
03a28  b8 7c 09             mov ax, 0x97c
03a2b  8e c0                mov es, ax
03a2d  58                   pop ax
03a2e  b8 20 00             mov ax, 0x20
03a31  f3 aa                rep stosb byte ptr es:[di], al
03a33  c7 06 88 3a 00 00    mov word ptr [0x3a88], 0    ; saisie_longueur
loc_3a39:
03a39  e8 a8 26             call affiche_tampon
03a3c  e8 96 fb             call attend_touche
03a3f  3c 0d                cmp al, 0xd
03a41  75 01                jne loc_3a44
03a43  c3                   ret
loc_3a44:
03a44  80 fc 0e             cmp ah, 0xe
03a47  74 3a                je loc_3a83
03a49  3c 20                cmp al, 0x20
03a4b  72 ec                jb loc_3a39
03a4d  3c 7a                cmp al, 0x7a
03a4f  77 e8                ja loc_3a39
03a51  80 3e 8a 3a 01       cmp byte ptr [0x3a8a], 1    ; saisie_chiffres
03a56  75 08                jne loc_3a60
03a58  3c 30                cmp al, 0x30
03a5a  72 dd                jb loc_3a39
03a5c  3c 39                cmp al, 0x39
03a5e  77 d9                ja loc_3a39
loc_3a60:
03a60  8b 1e 88 3a          mov bx, word ptr [0x3a88]    ; saisie_longueur
03a64  3b 1e 84 3a          cmp bx, word ptr [0x3a84]    ; saisie_max
03a68  73 cf                jae loc_3a39
03a6a  50                   push ax
03a6b  b8 7c 09             mov ax, 0x97c
03a6e  8e c0                mov es, ax
03a70  58                   pop ax
03a71  8b 3e 86 3a          mov di, word ptr [0x3a86]    ; saisie_pointeur
03a75  aa                   stosb byte ptr es:[di], al
03a76  89 3e 86 3a          mov word ptr [0x3a86], di    ; saisie_pointeur
03a7a  e8 0e f7             call affiche_caractere
03a7d  ff 06 88 3a          inc word ptr [0x3a88]    ; saisie_longueur
03a81  eb b6                jmp loc_3a39
loc_3a83:
03a83  83 3e 88 3a 00       cmp word ptr [0x3a88], 0    ; saisie_longueur
03a88  74 af                je loc_3a39
03a8a  ff 0e 52 37          dec word ptr [0x3752]    ; texte_colonne
03a8e  b0 20                mov al, 0x20
03a90  8b 3e 86 3a          mov di, word ptr [0x3a86]    ; saisie_pointeur
03a94  4f                   dec di
03a95  88 05                mov byte ptr [di], al
03a97  89 3e 86 3a          mov word ptr [0x3a86], di    ; saisie_pointeur
03a9b  e8 ed f6             call affiche_caractere
03a9e  ff 0e 52 37          dec word ptr [0x3752]    ; texte_colonne
03aa2  ff 0e 88 3a          dec word ptr [0x3a88]    ; saisie_longueur
03aa6  eb 91                jmp loc_3a39

; ======== saisie_nombre   (appelée depuis 00b7)
; saisie de 1 ou 2 chiffres dans DS:37F3, valeur dans AX ; seul appelant : ecran_shields (code du bouclier)
03aa8  c6 06 8a 3a 01       mov byte ptr [0x3a8a], 1    ; saisie_chiffres
03aad  bf f3 37             mov di, 0x37f3
03ab0  b9 02 00             mov cx, 2
03ab3  e8 69 ff             call saisie_ligne
03ab6  83 3e 88 3a 00       cmp word ptr [0x3a88], 0    ; saisie_longueur
03abb  74 eb                je saisie_nombre
03abd  c6 06 8a 3a 00       mov byte ptr [0x3a8a], 0    ; saisie_chiffres
03ac2  8b 0e 88 3a          mov cx, word ptr [0x3a88]    ; saisie_longueur
03ac6  bf f3 37             mov di, 0x37f3
03ac9  33 c0                xor ax, ax
03acb  b2 0a                mov dl, 0xa
loc_3acd:
03acd  8a 1d                mov bl, byte ptr [di]
03acf  47                   inc di
03ad0  80 eb 30             sub bl, 0x30
03ad3  f6 e2                mul dl
03ad5  02 c3                add al, bl
03ad7  e2 f4                loop loc_3acd
03ad9  32 e4                xor ah, ah
03adb  c3                   ret

; ======== adresse_ega   (appelée depuis 3b5c, 62c2, 6345)
; DI (y × 320 + x) -> DS:37FB = y × 160 + x / 8, DS:37F9 = x & 7 : 160 octets par ligne, soit 4 plans de 40 octets
03adc  9c                   pushf
03add  50                   push ax
03ade  53                   push bx
03adf  51                   push cx
03ae0  52                   push dx
03ae1  57                   push di
03ae2  56                   push si
03ae3  55                   push bp
03ae4  06                   push es
03ae5  1e                   push ds
03ae6  8b c7                mov ax, di
03ae8  33 d2                xor dx, dx
03aea  b9 40 01             mov cx, 0x140
03aed  f7 f1                div cx
03aef  52                   push dx
03af0  b9 a0 00             mov cx, 0xa0
03af3  f7 e1                mul cx
03af5  8b d0                mov dx, ax
03af7  58                   pop ax
03af8  8b c8                mov cx, ax
03afa  80 e1 07             and cl, 7
03afd  89 0e f9 37          mov word ptr [0x37f9], cx    ; rang_pixel
03b01  d1 e8                shr ax, 1
03b03  d1 e8                shr ax, 1
03b05  d1 e8                shr ax, 1
03b07  03 c2                add ax, dx
03b09  a3 fb 37             mov word ptr [0x37fb], ax    ; adresse_plane
03b0c  1f                   pop ds
03b0d  07                   pop es
03b0e  5d                   pop bp
03b0f  5e                   pop si
03b10  5f                   pop di
03b11  5a                   pop dx
03b12  59                   pop cx
03b13  5b                   pop bx
03b14  58                   pop ax
03b15  9d                   popf
03b16  c3                   ret

; ======== adresse_tandy   (appelée depuis 3d3a, 40e1, 628c, 638e)
; DI (y × 320 + x) -> DS:37FB = début de ligne (table DS:3A8B) + x / 2, DS:37F9 = 1 si x impair
03b17  9c                   pushf
03b18  50                   push ax
03b19  53                   push bx
03b1a  51                   push cx
03b1b  52                   push dx
03b1c  57                   push di
03b1d  56                   push si
03b1e  55                   push bp
03b1f  06                   push es
03b20  1e                   push ds
03b21  c7 06 f9 37 00 00    mov word ptr [0x37f9], 0    ; rang_pixel
03b27  d1 ef                shr di, 1
03b29  73 06                jae loc_3b31
03b2b  c7 06 f9 37 01 00    mov word ptr [0x37f9], 1    ; rang_pixel
loc_3b31:
03b31  8b c7                mov ax, di
03b33  33 d2                xor dx, dx
03b35  b9 a0 00             mov cx, 0xa0
03b38  f7 f1                div cx
03b3a  8b d8                mov bx, ax
03b3c  d1 e3                shl bx, 1
03b3e  8b bf 8b 3a          mov di, word ptr [bx + 0x3a8b]    ; lignes_tandy
03b42  03 fa                add di, dx
03b44  89 3e fb 37          mov word ptr [0x37fb], di    ; adresse_plane
03b48  1f                   pop ds
03b49  07                   pop es
03b4a  5d                   pop bp
03b4b  5e                   pop si
03b4c  5f                   pop di
03b4d  5a                   pop dx
03b4e  59                   pop cx
03b4f  5b                   pop bx
03b50  58                   pop ax
03b51  9d                   popf
03b52  c3                   ret

; ======== copie_image   (appelée depuis 0092, 0c13, 0d3f, 0d5e, 1055, 1797, 181f, 1a6b)
; copie une image : BP largeur, CX hauteur, SI source, DI écran, segment source DS:374E
03b53  bb 26 37             mov bx, 0x3726    ; saut_copie_image
03b56  03 1e 90 31          add bx, word ptr [0x3190]    ; mode_video
03b5a  ff 27                jmp word ptr [bx]
loc_3b5c:
03b5c  e8 7d ff             call adresse_ega
03b5f  a1 f9 37             mov ax, word ptr [0x37f9]    ; rang_pixel
03b62  8b 3e fb 37          mov di, word ptr [0x37fb]    ; adresse_plane
03b66  50                   push ax
03b67  a1 4e 37             mov ax, word ptr [0x374e]    ; segment_source
03b6a  8e d8                mov ds, ax
03b6c  d1 ed                shr bp, 1
03b6e  d1 ed                shr bp, 1
03b70  d1 ed                shr bp, 1
03b72  d1 ee                shr si, 1
03b74  bb 28 00             mov bx, 0x28
03b77  2b dd                sub bx, bp
03b79  58                   pop ax
03b7a  0b c0                or ax, ax
03b7c  75 69                jne loc_3be7
loc_3b7e:
03b7e  8b d1                mov dx, cx
03b80  8b cd                mov cx, bp
loc_3b82:
03b82  8a 24                mov ah, byte ptr [si]
03b84  56                   push si
03b85  03 f5                add si, bp
03b87  0a 24                or ah, byte ptr [si]
03b89  03 f5                add si, bp
03b8b  0a 24                or ah, byte ptr [si]
03b8d  03 f5                add si, bp
03b8f  0a 24                or ah, byte ptr [si]
03b91  5e                   pop si
03b92  f6 d4                not ah
03b94  56                   push si
03b95  57                   push di
03b96  8a 04                mov al, byte ptr [si]
03b98  26 20 25             and byte ptr es:[di], ah
03b9b  26 08 05             or byte ptr es:[di], al
03b9e  03 f5                add si, bp
03ba0  83 c7 28             add di, 0x28
03ba3  8a 04                mov al, byte ptr [si]
03ba5  26 20 25             and byte ptr es:[di], ah
03ba8  26 08 05             or byte ptr es:[di], al
03bab  03 f5                add si, bp
03bad  83 c7 28             add di, 0x28
03bb0  8a 04                mov al, byte ptr [si]
03bb2  26 20 25             and byte ptr es:[di], ah
03bb5  26 08 05             or byte ptr es:[di], al
03bb8  03 f5                add si, bp
03bba  83 c7 28             add di, 0x28
03bbd  8a 04                mov al, byte ptr [si]
03bbf  26 20 25             and byte ptr es:[di], ah
03bc2  26 08 05             or byte ptr es:[di], al
03bc5  03 f5                add si, bp
03bc7  83 c7 28             add di, 0x28
03bca  5f                   pop di
03bcb  5e                   pop si
03bcc  46                   inc si
03bcd  47                   inc di
03bce  e2 b2                loop loc_3b82
03bd0  03 f5                add si, bp
03bd2  03 f5                add si, bp
03bd4  03 f5                add si, bp
03bd6  03 fb                add di, bx
03bd8  83 c7 78             add di, 0x78
03bdb  8b ca                mov cx, dx
03bdd  e2 9f                loop loc_3b7e
03bdf  50                   push ax
03be0  b8 7c 09             mov ax, 0x97c
03be3  8e d8                mov ds, ax
03be5  58                   pop ax
03be6  c3                   ret
loc_3be7:
03be7  2e 89 0e f2 30       mov word ptr cs:[0x30f2], cx
03bec  8b c8                mov cx, ax
loc_3bee:
03bee  57                   push di
03bef  56                   push si
03bf0  8a 24                mov ah, byte ptr [si]
03bf2  56                   push si
03bf3  03 f5                add si, bp
03bf5  0a 24                or ah, byte ptr [si]
03bf7  03 f5                add si, bp
03bf9  0a 24                or ah, byte ptr [si]
03bfb  03 f5                add si, bp
03bfd  0a 24                or ah, byte ptr [si]
03bff  5e                   pop si
03c00  f6 d4                not ah
03c02  8a c4                mov al, ah
03c04  b4 ff                mov ah, 0xff
03c06  d3 e8                shr ax, cl
03c08  56                   push si
03c09  57                   push di
03c0a  8a 1c                mov bl, byte ptr [si]
03c0c  32 ff                xor bh, bh
03c0e  d3 eb                shr bx, cl
03c10  26 20 05             and byte ptr es:[di], al
03c13  26 08 1d             or byte ptr es:[di], bl
03c16  03 f5                add si, bp
03c18  83 c7 28             add di, 0x28
03c1b  8a 1c                mov bl, byte ptr [si]
03c1d  32 ff                xor bh, bh
03c1f  d3 eb                shr bx, cl
03c21  26 20 05             and byte ptr es:[di], al
03c24  26 08 1d             or byte ptr es:[di], bl
03c27  03 f5                add si, bp
03c29  83 c7 28             add di, 0x28
03c2c  8a 1c                mov bl, byte ptr [si]
03c2e  32 ff                xor bh, bh
03c30  d3 eb                shr bx, cl
03c32  26 20 05             and byte ptr es:[di], al
03c35  26 08 1d             or byte ptr es:[di], bl
03c38  03 f5                add si, bp
03c3a  83 c7 28             add di, 0x28
03c3d  8a 1c                mov bl, byte ptr [si]
03c3f  32 ff                xor bh, bh
03c41  d3 eb                shr bx, cl
03c43  26 20 05             and byte ptr es:[di], al
03c46  26 08 1d             or byte ptr es:[di], bl
03c49  03 f5                add si, bp
03c4b  83 c7 28             add di, 0x28
03c4e  5f                   pop di
03c4f  5e                   pop si
03c50  47                   inc di
03c51  83 fd 01             cmp bp, 1
03c54  74 71                je loc_3cc7
03c56  2e 89 2e f0 30       mov word ptr cs:[0x30f0], bp
03c5b  2e ff 0e f0 30       dec word ptr cs:[0x30f0]
loc_3c60:
03c60  8b 04                mov ax, word ptr [si]
03c62  56                   push si
03c63  03 f5                add si, bp
03c65  0b 04                or ax, word ptr [si]
03c67  03 f5                add si, bp
03c69  0b 04                or ax, word ptr [si]
03c6b  03 f5                add si, bp
03c6d  0b 04                or ax, word ptr [si]
03c6f  5e                   pop si
03c70  f7 d0                not ax
03c72  86 e0                xchg al, ah
03c74  d3 e8                shr ax, cl
03c76  56                   push si
03c77  57                   push di
03c78  8b 1c                mov bx, word ptr [si]
03c7a  86 fb                xchg bl, bh
03c7c  d3 eb                shr bx, cl
03c7e  26 20 05             and byte ptr es:[di], al
03c81  26 08 1d             or byte ptr es:[di], bl
03c84  03 f5                add si, bp
03c86  83 c7 28             add di, 0x28
03c89  8b 1c                mov bx, word ptr [si]
03c8b  86 fb                xchg bl, bh
03c8d  d3 eb                shr bx, cl
03c8f  26 20 05             and byte ptr es:[di], al
03c92  26 08 1d             or byte ptr es:[di], bl
03c95  03 f5                add si, bp
03c97  83 c7 28             add di, 0x28
03c9a  8b 1c                mov bx, word ptr [si]
03c9c  86 fb                xchg bl, bh
03c9e  d3 eb                shr bx, cl
03ca0  26 20 05             and byte ptr es:[di], al
03ca3  26 08 1d             or byte ptr es:[di], bl
03ca6  03 f5                add si, bp
03ca8  83 c7 28             add di, 0x28
03cab  8b 1c                mov bx, word ptr [si]
03cad  86 fb                xchg bl, bh
03caf  d3 eb                shr bx, cl
03cb1  26 20 05             and byte ptr es:[di], al
03cb4  26 08 1d             or byte ptr es:[di], bl
03cb7  03 f5                add si, bp
03cb9  83 c7 28             add di, 0x28
03cbc  5f                   pop di
03cbd  5e                   pop si
03cbe  47                   inc di
03cbf  46                   inc si
03cc0  2e ff 0e f0 30       dec word ptr cs:[0x30f0]
03cc5  75 99                jne loc_3c60
loc_3cc7:
03cc7  8a 24                mov ah, byte ptr [si]
03cc9  56                   push si
03cca  03 f5                add si, bp
03ccc  0a 24                or ah, byte ptr [si]
03cce  03 f5                add si, bp
03cd0  0a 24                or ah, byte ptr [si]
03cd2  03 f5                add si, bp
03cd4  0a 24                or ah, byte ptr [si]
03cd6  5e                   pop si
03cd7  f6 d4                not ah
03cd9  b0 ff                mov al, 0xff
03cdb  d3 e8                shr ax, cl
03cdd  8a 3c                mov bh, byte ptr [si]
03cdf  32 db                xor bl, bl
03ce1  d3 eb                shr bx, cl
03ce3  26 20 05             and byte ptr es:[di], al
03ce6  26 08 1d             or byte ptr es:[di], bl
03ce9  03 f5                add si, bp
03ceb  83 c7 28             add di, 0x28
03cee  8a 3c                mov bh, byte ptr [si]
03cf0  32 db                xor bl, bl
03cf2  d3 eb                shr bx, cl
03cf4  26 20 05             and byte ptr es:[di], al
03cf7  26 08 1d             or byte ptr es:[di], bl
03cfa  03 f5                add si, bp
03cfc  83 c7 28             add di, 0x28
03cff  8a 3c                mov bh, byte ptr [si]
03d01  32 db                xor bl, bl
03d03  d3 eb                shr bx, cl
03d05  26 20 05             and byte ptr es:[di], al
03d08  26 08 1d             or byte ptr es:[di], bl
03d0b  03 f5                add si, bp
03d0d  83 c7 28             add di, 0x28
03d10  8a 3c                mov bh, byte ptr [si]
03d12  32 db                xor bl, bl
03d14  d3 eb                shr bx, cl
03d16  26 20 05             and byte ptr es:[di], al
03d19  26 08 1d             or byte ptr es:[di], bl
03d1c  03 f5                add si, bp
03d1e  83 c7 28             add di, 0x28
03d21  5e                   pop si
03d22  03 f5                add si, bp
03d24  03 f5                add si, bp
03d26  03 f5                add si, bp
03d28  03 f5                add si, bp
03d2a  5f                   pop di
03d2b  81 c7 a0 00          add di, 0xa0
03d2f  2e ff 0e f2 30       dec word ptr cs:[0x30f2]
03d34  74 03                je loc_3d39
03d36  e9 b5 fe             jmp loc_3bee
loc_3d39:
03d39  c3                   ret
loc_3d3a:
03d3a  e8 da fd             call adresse_tandy
03d3d  8b 3e fb 37          mov di, word ptr [0x37fb]    ; adresse_plane
03d41  8b 1e f9 37          mov bx, word ptr [0x37f9]    ; rang_pixel
03d45  d1 ee                shr si, 1
03d47  a1 4e 37             mov ax, word ptr [0x374e]    ; segment_source
03d4a  8e d8                mov ds, ax
03d4c  2e 89 0e f2 30       mov word ptr cs:[0x30f2], cx
03d51  d1 ed                shr bp, 1
03d53  2e 89 2e f4 30       mov word ptr cs:[0x30f4], bp
03d58  d1 ed                shr bp, 1
03d5a  d1 ed                shr bp, 1
03d5c  2e 89 2e f0 30       mov word ptr cs:[0x30f0], bp
03d61  83 fb 01             cmp bx, 1
03d64  75 03                jne loc_3d69
03d66  e9 19 01             jmp loc_3e82
loc_3d69:
03d69  2e 8b 0e f0 30       mov cx, word ptr cs:[0x30f0]
03d6e  57                   push di
03d6f  56                   push si
loc_3d70:
03d70  2e 8b 1e f4 30       mov bx, word ptr cs:[0x30f4]
03d75  2e 2b 1e f0 30       sub bx, word ptr cs:[0x30f0]
03d7a  8a 00                mov al, byte ptr [bx + si]
03d7c  2e 2b 1e f0 30       sub bx, word ptr cs:[0x30f0]
03d81  8a 30                mov dh, byte ptr [bx + si]
03d83  2e 2b 1e f0 30       sub bx, word ptr cs:[0x30f0]
03d88  8a 10                mov dl, byte ptr [bx + si]
03d8a  8a 1c                mov bl, byte ptr [si]
03d8c  d0 e3                shl bl, 1
03d8e  d0 d4                rcl ah, 1
03d90  d0 e2                shl dl, 1
03d92  d0 d4                rcl ah, 1
03d94  d0 e6                shl dh, 1
03d96  d0 d4                rcl ah, 1
03d98  d0 e0                shl al, 1
03d9a  d0 d4                rcl ah, 1
03d9c  d0 e3                shl bl, 1
03d9e  d0 d4                rcl ah, 1
03da0  d0 e2                shl dl, 1
03da2  d0 d4                rcl ah, 1
03da4  d0 e6                shl dh, 1
03da6  d0 d4                rcl ah, 1
03da8  d0 e0                shl al, 1
03daa  d0 d4                rcl ah, 1
03dac  50                   push ax
03dad  53                   push bx
03dae  8a c4                mov al, ah
03db0  bb f0 2f             mov bx, 0x2ff0
03db3  2e d7                xlatb
03db5  5b                   pop bx
03db6  26 20 05             and byte ptr es:[di], al
03db9  26 08 25             or byte ptr es:[di], ah
03dbc  58                   pop ax
03dbd  47                   inc di
03dbe  d0 e3                shl bl, 1
03dc0  d0 d4                rcl ah, 1
03dc2  d0 e2                shl dl, 1
03dc4  d0 d4                rcl ah, 1
03dc6  d0 e6                shl dh, 1
03dc8  d0 d4                rcl ah, 1
03dca  d0 e0                shl al, 1
03dcc  d0 d4                rcl ah, 1
03dce  d0 e3                shl bl, 1
03dd0  d0 d4                rcl ah, 1
03dd2  d0 e2                shl dl, 1
03dd4  d0 d4                rcl ah, 1
03dd6  d0 e6                shl dh, 1
03dd8  d0 d4                rcl ah, 1
03dda  d0 e0                shl al, 1
03ddc  d0 d4                rcl ah, 1
03dde  50                   push ax
03ddf  53                   push bx
03de0  8a c4                mov al, ah
03de2  bb f0 2f             mov bx, 0x2ff0
03de5  2e d7                xlatb
03de7  5b                   pop bx
03de8  26 20 05             and byte ptr es:[di], al
03deb  26 08 25             or byte ptr es:[di], ah
03dee  58                   pop ax
03def  47                   inc di
03df0  d0 e3                shl bl, 1
03df2  d0 d4                rcl ah, 1
03df4  d0 e2                shl dl, 1
03df6  d0 d4                rcl ah, 1
03df8  d0 e6                shl dh, 1
03dfa  d0 d4                rcl ah, 1
03dfc  d0 e0                shl al, 1
03dfe  d0 d4                rcl ah, 1
03e00  d0 e3                shl bl, 1
03e02  d0 d4                rcl ah, 1
03e04  d0 e2                shl dl, 1
03e06  d0 d4                rcl ah, 1
03e08  d0 e6                shl dh, 1
03e0a  d0 d4                rcl ah, 1
03e0c  d0 e0                shl al, 1
03e0e  d0 d4                rcl ah, 1
03e10  50                   push ax
03e11  53                   push bx
03e12  8a c4                mov al, ah
03e14  bb f0 2f             mov bx, 0x2ff0
03e17  2e d7                xlatb
03e19  5b                   pop bx
03e1a  26 20 05             and byte ptr es:[di], al
03e1d  26 08 25             or byte ptr es:[di], ah
03e20  58                   pop ax
03e21  47                   inc di
03e22  d0 e3                shl bl, 1
03e24  d0 d4                rcl ah, 1
03e26  d0 e2                shl dl, 1
03e28  d0 d4                rcl ah, 1
03e2a  d0 e6                shl dh, 1
03e2c  d0 d4                rcl ah, 1
03e2e  d0 e0                shl al, 1
03e30  d0 d4                rcl ah, 1
03e32  d0 e3                shl bl, 1
03e34  d0 d4                rcl ah, 1
03e36  d0 e2                shl dl, 1
03e38  d0 d4                rcl ah, 1
03e3a  d0 e6                shl dh, 1
03e3c  d0 d4                rcl ah, 1
03e3e  d0 e0                shl al, 1
03e40  d0 d4                rcl ah, 1
03e42  50                   push ax
03e43  53                   push bx
03e44  8a c4                mov al, ah
03e46  bb f0 2f             mov bx, 0x2ff0
03e49  2e d7                xlatb
03e4b  5b                   pop bx
03e4c  26 20 05             and byte ptr es:[di], al
03e4f  26 08 25             or byte ptr es:[di], ah
03e52  58                   pop ax
03e53  47                   inc di
03e54  46                   inc si
03e55  49                   dec cx
03e56  74 03                je loc_3e5b
03e58  e9 15 ff             jmp loc_3d70
loc_3e5b:
03e5b  5e                   pop si
03e5c  5f                   pop di
03e5d  2e 03 36 f4 30       add si, word ptr cs:[0x30f4]
03e62  81 c7 00 20          add di, 0x2000
03e66  f7 c7 00 80          test di, 0x8000
03e6a  74 04                je loc_3e70
03e6c  81 ef 60 7f          sub di, 0x7f60
loc_3e70:
03e70  2e ff 0e f2 30       dec word ptr cs:[0x30f2]
03e75  74 03                je loc_3e7a
03e77  e9 ef fe             jmp loc_3d69
loc_3e7a:
03e7a  50                   push ax
03e7b  b8 7c 09             mov ax, 0x97c
03e7e  8e d8                mov ds, ax
03e80  58                   pop ax
03e81  c3                   ret
loc_3e82:
03e82  2e 89 0e f2 30       mov word ptr cs:[0x30f2], cx
loc_3e87:
03e87  2e 8b 0e f0 30       mov cx, word ptr cs:[0x30f0]
03e8c  57                   push di
03e8d  56                   push si
03e8e  32 e4                xor ah, ah
03e90  2e 8b 1e f4 30       mov bx, word ptr cs:[0x30f4]
03e95  2e 2b 1e f0 30       sub bx, word ptr cs:[0x30f0]
03e9a  8a 00                mov al, byte ptr [bx + si]
03e9c  2e 2b 1e f0 30       sub bx, word ptr cs:[0x30f0]
03ea1  8a 30                mov dh, byte ptr [bx + si]
03ea3  2e 2b 1e f0 30       sub bx, word ptr cs:[0x30f0]
03ea8  8a 10                mov dl, byte ptr [bx + si]
03eaa  8a 1c                mov bl, byte ptr [si]
03eac  d0 e3                shl bl, 1
03eae  d0 d4                rcl ah, 1
03eb0  d0 e2                shl dl, 1
03eb2  d0 d4                rcl ah, 1
03eb4  d0 e6                shl dh, 1
03eb6  d0 d4                rcl ah, 1
03eb8  d0 e0                shl al, 1
03eba  d0 d4                rcl ah, 1
03ebc  50                   push ax
03ebd  53                   push bx
03ebe  8a c4                mov al, ah
03ec0  bb f0 2f             mov bx, 0x2ff0
03ec3  2e d7                xlatb
03ec5  5b                   pop bx
03ec6  26 20 05             and byte ptr es:[di], al
03ec9  26 08 25             or byte ptr es:[di], ah
03ecc  58                   pop ax
03ecd  47                   inc di
03ece  83 f9 01             cmp cx, 1
03ed1  75 03                jne loc_3ed6
03ed3  e9 ec 00             jmp loc_3fc2
loc_3ed6:
03ed6  49                   dec cx
loc_3ed7:
03ed7  d0 e3                shl bl, 1
03ed9  d0 d4                rcl ah, 1
03edb  d0 e2                shl dl, 1
03edd  d0 d4                rcl ah, 1
03edf  d0 e6                shl dh, 1
03ee1  d0 d4                rcl ah, 1
03ee3  d0 e0                shl al, 1
03ee5  d0 d4                rcl ah, 1
03ee7  d0 e3                shl bl, 1
03ee9  d0 d4                rcl ah, 1
03eeb  d0 e2                shl dl, 1
03eed  d0 d4                rcl ah, 1
03eef  d0 e6                shl dh, 1
03ef1  d0 d4                rcl ah, 1
03ef3  d0 e0                shl al, 1
03ef5  d0 d4                rcl ah, 1
03ef7  50                   push ax
03ef8  53                   push bx
03ef9  8a c4                mov al, ah
03efb  bb f0 2f             mov bx, 0x2ff0
03efe  2e d7                xlatb
03f00  5b                   pop bx
03f01  26 20 05             and byte ptr es:[di], al
03f04  26 08 25             or byte ptr es:[di], ah
03f07  58                   pop ax
03f08  47                   inc di
03f09  d0 e3                shl bl, 1
03f0b  d0 d4                rcl ah, 1
03f0d  d0 e2                shl dl, 1
03f0f  d0 d4                rcl ah, 1
03f11  d0 e6                shl dh, 1
03f13  d0 d4                rcl ah, 1
03f15  d0 e0                shl al, 1
03f17  d0 d4                rcl ah, 1
03f19  d0 e3                shl bl, 1
03f1b  d0 d4                rcl ah, 1
03f1d  d0 e2                shl dl, 1
03f1f  d0 d4                rcl ah, 1
03f21  d0 e6                shl dh, 1
03f23  d0 d4                rcl ah, 1
03f25  d0 e0                shl al, 1
03f27  d0 d4                rcl ah, 1
03f29  50                   push ax
03f2a  53                   push bx
03f2b  8a c4                mov al, ah
03f2d  bb f0 2f             mov bx, 0x2ff0
03f30  2e d7                xlatb
03f32  5b                   pop bx
03f33  26 20 05             and byte ptr es:[di], al
03f36  26 08 25             or byte ptr es:[di], ah
03f39  58                   pop ax
03f3a  47                   inc di
03f3b  d0 e3                shl bl, 1
03f3d  d0 d4                rcl ah, 1
03f3f  d0 e2                shl dl, 1
03f41  d0 d4                rcl ah, 1
03f43  d0 e6                shl dh, 1
03f45  d0 d4                rcl ah, 1
03f47  d0 e0                shl al, 1
03f49  d0 d4                rcl ah, 1
03f4b  d0 e3                shl bl, 1
03f4d  d0 d4                rcl ah, 1
03f4f  d0 e2                shl dl, 1
03f51  d0 d4                rcl ah, 1
03f53  d0 e6                shl dh, 1
03f55  d0 d4                rcl ah, 1
03f57  d0 e0                shl al, 1
03f59  d0 d4                rcl ah, 1
03f5b  50                   push ax
03f5c  53                   push bx
03f5d  8a c4                mov al, ah
03f5f  bb f0 2f             mov bx, 0x2ff0
03f62  2e d7                xlatb
03f64  5b                   pop bx
03f65  26 20 05             and byte ptr es:[di], al
03f68  26 08 25             or byte ptr es:[di], ah
03f6b  58                   pop ax
03f6c  47                   inc di
03f6d  d0 e3                shl bl, 1
03f6f  d0 d4                rcl ah, 1
03f71  d0 e2                shl dl, 1
03f73  d0 d4                rcl ah, 1
03f75  d0 e6                shl dh, 1
03f77  d0 d4                rcl ah, 1
03f79  d0 e0                shl al, 1
03f7b  d0 d4                rcl ah, 1
03f7d  46                   inc si
03f7e  2e 8b 1e f4 30       mov bx, word ptr cs:[0x30f4]
03f83  2e 2b 1e f0 30       sub bx, word ptr cs:[0x30f0]
03f88  8a 00                mov al, byte ptr [bx + si]
03f8a  2e 2b 1e f0 30       sub bx, word ptr cs:[0x30f0]
03f8f  8a 30                mov dh, byte ptr [bx + si]
03f91  2e 2b 1e f0 30       sub bx, word ptr cs:[0x30f0]
03f96  8a 10                mov dl, byte ptr [bx + si]
03f98  8a 1c                mov bl, byte ptr [si]
03f9a  d0 e3                shl bl, 1
03f9c  d0 d4                rcl ah, 1
03f9e  d0 e2                shl dl, 1
03fa0  d0 d4                rcl ah, 1
03fa2  d0 e6                shl dh, 1
03fa4  d0 d4                rcl ah, 1
03fa6  d0 e0                shl al, 1
03fa8  d0 d4                rcl ah, 1
03faa  50                   push ax
03fab  53                   push bx
03fac  8a c4                mov al, ah
03fae  bb f0 2f             mov bx, 0x2ff0
03fb1  2e d7                xlatb
03fb3  5b                   pop bx
03fb4  26 20 05             and byte ptr es:[di], al
03fb7  26 08 25             or byte ptr es:[di], ah
03fba  58                   pop ax
03fbb  47                   inc di
03fbc  49                   dec cx
03fbd  74 03                je loc_3fc2
03fbf  e9 15 ff             jmp loc_3ed7
loc_3fc2:
03fc2  d0 e3                shl bl, 1
03fc4  d0 d4                rcl ah, 1
03fc6  d0 e2                shl dl, 1
03fc8  d0 d4                rcl ah, 1
03fca  d0 e6                shl dh, 1
03fcc  d0 d4                rcl ah, 1
03fce  d0 e0                shl al, 1
03fd0  d0 d4                rcl ah, 1
03fd2  d0 e3                shl bl, 1
03fd4  d0 d4                rcl ah, 1
03fd6  d0 e2                shl dl, 1
03fd8  d0 d4                rcl ah, 1
03fda  d0 e6                shl dh, 1
03fdc  d0 d4                rcl ah, 1
03fde  d0 e0                shl al, 1
03fe0  d0 d4                rcl ah, 1
03fe2  50                   push ax
03fe3  53                   push bx
03fe4  8a c4                mov al, ah
03fe6  bb f0 2f             mov bx, 0x2ff0
03fe9  2e d7                xlatb
03feb  5b                   pop bx
03fec  26 20 05             and byte ptr es:[di], al
03fef  26 08 25             or byte ptr es:[di], ah
03ff2  58                   pop ax
03ff3  47                   inc di
03ff4  d0 e3                shl bl, 1
03ff6  d0 d4                rcl ah, 1
03ff8  d0 e2                shl dl, 1
03ffa  d0 d4                rcl ah, 1
03ffc  d0 e6                shl dh, 1
03ffe  d0 d4                rcl ah, 1
04000  d0 e0                shl al, 1
04002  d0 d4                rcl ah, 1
04004  d0 e3                shl bl, 1
04006  d0 d4                rcl ah, 1
04008  d0 e2                shl dl, 1
0400a  d0 d4                rcl ah, 1
0400c  d0 e6                shl dh, 1
0400e  d0 d4                rcl ah, 1
04010  d0 e0                shl al, 1
04012  d0 d4                rcl ah, 1
04014  50                   push ax
04015  53                   push bx
04016  8a c4                mov al, ah
04018  bb f0 2f             mov bx, 0x2ff0
0401b  2e d7                xlatb
0401d  5b                   pop bx
0401e  26 20 05             and byte ptr es:[di], al
04021  26 08 25             or byte ptr es:[di], ah
04024  58                   pop ax
04025  47                   inc di
04026  d0 e3                shl bl, 1
04028  d0 d4                rcl ah, 1
0402a  d0 e2                shl dl, 1
0402c  d0 d4                rcl ah, 1
0402e  d0 e6                shl dh, 1
04030  d0 d4                rcl ah, 1
04032  d0 e0                shl al, 1
04034  d0 d4                rcl ah, 1
04036  d0 e3                shl bl, 1
04038  d0 d4                rcl ah, 1
0403a  d0 e2                shl dl, 1
0403c  d0 d4                rcl ah, 1
0403e  d0 e6                shl dh, 1
04040  d0 d4                rcl ah, 1
04042  d0 e0                shl al, 1
04044  d0 d4                rcl ah, 1
04046  50                   push ax
04047  53                   push bx
04048  8a c4                mov al, ah
0404a  bb f0 2f             mov bx, 0x2ff0
0404d  2e d7                xlatb
0404f  5b                   pop bx
04050  26 20 05             and byte ptr es:[di], al
04053  26 08 25             or byte ptr es:[di], ah
04056  58                   pop ax
04057  47                   inc di
04058  d0 e3                shl bl, 1
0405a  d0 d4                rcl ah, 1
0405c  d0 e2                shl dl, 1
0405e  d0 d4                rcl ah, 1
04060  d0 e6                shl dh, 1
04062  d0 d4                rcl ah, 1
04064  d0 e0                shl al, 1
04066  d0 d4                rcl ah, 1
04068  d0 e4                shl ah, 1
0406a  d0 e4                shl ah, 1
0406c  d0 e4                shl ah, 1
0406e  d0 e4                shl ah, 1
04070  80 e4 f0             and ah, 0xf0
04073  50                   push ax
04074  53                   push bx
04075  8a c4                mov al, ah
04077  bb f0 2f             mov bx, 0x2ff0
0407a  2e d7                xlatb
0407c  5b                   pop bx
0407d  26 20 05             and byte ptr es:[di], al
04080  26 08 25             or byte ptr es:[di], ah
04083  58                   pop ax
04084  47                   inc di
04085  5e                   pop si
04086  5f                   pop di
04087  2e 03 36 f4 30       add si, word ptr cs:[0x30f4]
0408c  81 c7 00 20          add di, 0x2000
04090  f7 c7 00 80          test di, 0x8000
04094  74 04                je loc_409a
04096  81 ef 60 7f          sub di, 0x7f60
loc_409a:
0409a  2e ff 0e f2 30       dec word ptr cs:[0x30f2]
0409f  74 03                je loc_40a4
040a1  e9 e3 fd             jmp loc_3e87
loc_40a4:
040a4  50                   push ax
040a5  b8 7c 09             mov ax, 0x97c
040a8  8e d8                mov ds, ax
040aa  58                   pop ax
040ab  c3                   ret
loc_40ac:
040ac  a1 4e 37             mov ax, word ptr [0x374e]    ; segment_source
040af  8e d8                mov ds, ax
loc_40b1:
040b1  8b d1                mov dx, cx
040b3  8b cd                mov cx, bp
040b5  57                   push di
loc_40b6:
040b6  ac                   lodsb al, byte ptr [si]
040b7  0a c0                or al, al
040b9  74 03                je loc_40be
040bb  26 88 05             mov byte ptr es:[di], al
loc_40be:
040be  47                   inc di
040bf  e2 f5                loop loc_40b6
040c1  5f                   pop di
040c2  81 c7 40 01          add di, 0x140
040c6  81 ff 00 fa          cmp di, 0xfa00
040ca  74 04                je loc_40d0
040cc  8b ca                mov cx, dx
040ce  e2 e1                loop loc_40b1
loc_40d0:
040d0  50                   push ax
040d1  b8 7c 09             mov ax, 0x97c
040d4  8e d8                mov ds, ax
040d6  58                   pop ax
040d7  c3                   ret

; ======== copie_image_opaque
; comme copie_image, mais sans transparence (l'octet 0 est copié) ; 3 versions (table DS:3730 : 40E1 Tandy, 43B2 EGA, 43EA VGA) ; non appelée directement
040d8  bb 30 37             mov bx, 0x3730    ; saut_copie_opaque
040db  03 1e 90 31          add bx, word ptr [0x3190]    ; mode_video
040df  ff 27                jmp word ptr [bx]
loc_40e1:
040e1  e8 33 fa             call adresse_tandy
040e4  8b 3e fb 37          mov di, word ptr [0x37fb]    ; adresse_plane
040e8  8b 1e f9 37          mov bx, word ptr [0x37f9]    ; rang_pixel
040ec  d1 ee                shr si, 1
040ee  a1 4e 37             mov ax, word ptr [0x374e]    ; segment_source
040f1  8e d8                mov ds, ax
040f3  2e 89 0e f2 30       mov word ptr cs:[0x30f2], cx
040f8  d1 ed                shr bp, 1
040fa  2e 89 2e f4 30       mov word ptr cs:[0x30f4], bp
040ff  d1 ed                shr bp, 1
04101  d1 ed                shr bp, 1
04103  2e 89 2e f0 30       mov word ptr cs:[0x30f0], bp
04108  83 fb 01             cmp bx, 1
0410b  75 03                jne loc_4110
0410d  e9 e1 00             jmp loc_41f1
loc_4110:
04110  2e 8b 0e f0 30       mov cx, word ptr cs:[0x30f0]
04115  57                   push di
04116  56                   push si
loc_4117:
04117  2e 8b 1e f4 30       mov bx, word ptr cs:[0x30f4]
0411c  2e 2b 1e f0 30       sub bx, word ptr cs:[0x30f0]
04121  8a 00                mov al, byte ptr [bx + si]
04123  2e 2b 1e f0 30       sub bx, word ptr cs:[0x30f0]
04128  8a 30                mov dh, byte ptr [bx + si]
0412a  2e 2b 1e f0 30       sub bx, word ptr cs:[0x30f0]
0412f  8a 10                mov dl, byte ptr [bx + si]
04131  8a 1c                mov bl, byte ptr [si]
04133  d0 e3                shl bl, 1
04135  d0 d4                rcl ah, 1
04137  d0 e2                shl dl, 1
04139  d0 d4                rcl ah, 1
0413b  d0 e6                shl dh, 1
0413d  d0 d4                rcl ah, 1
0413f  d0 e0                shl al, 1
04141  d0 d4                rcl ah, 1
04143  d0 e3                shl bl, 1
04145  d0 d4                rcl ah, 1
04147  d0 e2                shl dl, 1
04149  d0 d4                rcl ah, 1
0414b  d0 e6                shl dh, 1
0414d  d0 d4                rcl ah, 1
0414f  d0 e0                shl al, 1
04151  d0 d4                rcl ah, 1
04153  26 88 25             mov byte ptr es:[di], ah
04156  47                   inc di
04157  d0 e3                shl bl, 1
04159  d0 d4                rcl ah, 1
0415b  d0 e2                shl dl, 1
0415d  d0 d4                rcl ah, 1
0415f  d0 e6                shl dh, 1
04161  d0 d4                rcl ah, 1
04163  d0 e0                shl al, 1
04165  d0 d4                rcl ah, 1
04167  d0 e3                shl bl, 1
04169  d0 d4                rcl ah, 1
0416b  d0 e2                shl dl, 1
0416d  d0 d4                rcl ah, 1
0416f  d0 e6                shl dh, 1
04171  d0 d4                rcl ah, 1
04173  d0 e0                shl al, 1
04175  d0 d4                rcl ah, 1
04177  26 88 25             mov byte ptr es:[di], ah
0417a  47                   inc di
0417b  d0 e3                shl bl, 1
0417d  d0 d4                rcl ah, 1
0417f  d0 e2                shl dl, 1
04181  d0 d4                rcl ah, 1
04183  d0 e6                shl dh, 1
04185  d0 d4                rcl ah, 1
04187  d0 e0                shl al, 1
04189  d0 d4                rcl ah, 1
0418b  d0 e3                shl bl, 1
0418d  d0 d4                rcl ah, 1
0418f  d0 e2                shl dl, 1
04191  d0 d4                rcl ah, 1
04193  d0 e6                shl dh, 1
04195  d0 d4                rcl ah, 1
04197  d0 e0                shl al, 1
04199  d0 d4                rcl ah, 1
0419b  26 88 25             mov byte ptr es:[di], ah
0419e  47                   inc di
0419f  d0 e3                shl bl, 1
041a1  d0 d4                rcl ah, 1
041a3  d0 e2                shl dl, 1
041a5  d0 d4                rcl ah, 1
041a7  d0 e6                shl dh, 1
041a9  d0 d4                rcl ah, 1
041ab  d0 e0                shl al, 1
041ad  d0 d4                rcl ah, 1
041af  d0 e3                shl bl, 1
041b1  d0 d4                rcl ah, 1
041b3  d0 e2                shl dl, 1
041b5  d0 d4                rcl ah, 1
041b7  d0 e6                shl dh, 1
041b9  d0 d4                rcl ah, 1
041bb  d0 e0                shl al, 1
041bd  d0 d4                rcl ah, 1
041bf  26 88 25             mov byte ptr es:[di], ah
041c2  47                   inc di
041c3  46                   inc si
041c4  49                   dec cx
041c5  74 03                je loc_41ca
041c7  e9 4d ff             jmp loc_4117
loc_41ca:
041ca  5e                   pop si
041cb  5f                   pop di
041cc  2e 03 36 f4 30       add si, word ptr cs:[0x30f4]
041d1  81 c7 00 20          add di, 0x2000
041d5  f7 c7 00 80          test di, 0x8000
041d9  74 04                je loc_41df
041db  81 ef 60 7f          sub di, 0x7f60
loc_41df:
041df  2e ff 0e f2 30       dec word ptr cs:[0x30f2]
041e4  74 03                je loc_41e9
041e6  e9 27 ff             jmp loc_4110
loc_41e9:
041e9  50                   push ax
041ea  b8 7c 09             mov ax, 0x97c
041ed  8e d8                mov ds, ax
041ef  58                   pop ax
041f0  c3                   ret
loc_41f1:
041f1  2e 89 0e f2 30       mov word ptr cs:[0x30f2], cx
loc_41f6:
041f6  2e 8b 0e f0 30       mov cx, word ptr cs:[0x30f0]
041fb  57                   push di
041fc  56                   push si
041fd  32 e4                xor ah, ah
041ff  2e 8b 1e f4 30       mov bx, word ptr cs:[0x30f4]
04204  2e 2b 1e f0 30       sub bx, word ptr cs:[0x30f0]
04209  8a 00                mov al, byte ptr [bx + si]
0420b  2e 2b 1e f0 30       sub bx, word ptr cs:[0x30f0]
04210  8a 30                mov dh, byte ptr [bx + si]
04212  2e 2b 1e f0 30       sub bx, word ptr cs:[0x30f0]
04217  8a 10                mov dl, byte ptr [bx + si]
04219  8a 1c                mov bl, byte ptr [si]
0421b  d0 e3                shl bl, 1
0421d  d0 d4                rcl ah, 1
0421f  d0 e2                shl dl, 1
04221  d0 d4                rcl ah, 1
04223  d0 e6                shl dh, 1
04225  d0 d4                rcl ah, 1
04227  d0 e0                shl al, 1
04229  d0 d4                rcl ah, 1
0422b  50                   push ax
0422c  53                   push bx
0422d  8a c4                mov al, ah
0422f  bb f0 2f             mov bx, 0x2ff0
04232  2e d7                xlatb
04234  5b                   pop bx
04235  26 20 05             and byte ptr es:[di], al
04238  26 08 25             or byte ptr es:[di], ah
0423b  58                   pop ax
0423c  47                   inc di
0423d  83 f9 01             cmp cx, 1
04240  75 03                jne loc_4245
04242  e9 b0 00             jmp loc_42f5
loc_4245:
04245  49                   dec cx
loc_4246:
04246  d0 e3                shl bl, 1
04248  d0 d4                rcl ah, 1
0424a  d0 e2                shl dl, 1
0424c  d0 d4                rcl ah, 1
0424e  d0 e6                shl dh, 1
04250  d0 d4                rcl ah, 1
04252  d0 e0                shl al, 1
04254  d0 d4                rcl ah, 1
04256  d0 e3                shl bl, 1
04258  d0 d4                rcl ah, 1
0425a  d0 e2                shl dl, 1
0425c  d0 d4                rcl ah, 1
0425e  d0 e6                shl dh, 1
04260  d0 d4                rcl ah, 1
04262  d0 e0                shl al, 1
04264  d0 d4                rcl ah, 1
04266  26 88 25             mov byte ptr es:[di], ah
04269  d0 e3                shl bl, 1
0426b  d0 d4                rcl ah, 1
0426d  d0 e2                shl dl, 1
0426f  d0 d4                rcl ah, 1
04271  d0 e6                shl dh, 1
04273  d0 d4                rcl ah, 1
04275  d0 e0                shl al, 1
04277  d0 d4                rcl ah, 1
04279  d0 e3                shl bl, 1
0427b  d0 d4                rcl ah, 1
0427d  d0 e2                shl dl, 1
0427f  d0 d4                rcl ah, 1
04281  d0 e6                shl dh, 1
04283  d0 d4                rcl ah, 1
04285  d0 e0                shl al, 1
04287  d0 d4                rcl ah, 1
04289  26 88 25             mov byte ptr es:[di], ah
0428c  d0 e3                shl bl, 1
0428e  d0 d4                rcl ah, 1
04290  d0 e2                shl dl, 1
04292  d0 d4                rcl ah, 1
04294  d0 e6                shl dh, 1
04296  d0 d4                rcl ah, 1
04298  d0 e0                shl al, 1
0429a  d0 d4                rcl ah, 1
0429c  d0 e3                shl bl, 1
0429e  d0 d4                rcl ah, 1
042a0  d0 e2                shl dl, 1
042a2  d0 d4                rcl ah, 1
042a4  d0 e6                shl dh, 1
042a6  d0 d4                rcl ah, 1
042a8  d0 e0                shl al, 1
042aa  d0 d4                rcl ah, 1
042ac  26 88 25             mov byte ptr es:[di], ah
042af  d0 e3                shl bl, 1
042b1  d0 d4                rcl ah, 1
042b3  d0 e2                shl dl, 1
042b5  d0 d4                rcl ah, 1
042b7  d0 e6                shl dh, 1
042b9  d0 d4                rcl ah, 1
042bb  d0 e0                shl al, 1
042bd  d0 d4                rcl ah, 1
042bf  46                   inc si
042c0  2e 8b 1e f4 30       mov bx, word ptr cs:[0x30f4]
042c5  2e 2b 1e f0 30       sub bx, word ptr cs:[0x30f0]
042ca  8a 00                mov al, byte ptr [bx + si]
042cc  2e 2b 1e f0 30       sub bx, word ptr cs:[0x30f0]
042d1  8a 30                mov dh, byte ptr [bx + si]
042d3  2e 2b 1e f0 30       sub bx, word ptr cs:[0x30f0]
042d8  8a 10                mov dl, byte ptr [bx + si]
042da  8a 1c                mov bl, byte ptr [si]
042dc  d0 e3                shl bl, 1
042de  d0 d4                rcl ah, 1
042e0  d0 e2                shl dl, 1
042e2  d0 d4                rcl ah, 1
042e4  d0 e6                shl dh, 1
042e6  d0 d4                rcl ah, 1
042e8  d0 e0                shl al, 1
042ea  d0 d4                rcl ah, 1
042ec  26 88 25             mov byte ptr es:[di], ah
042ef  49                   dec cx
042f0  74 03                je loc_42f5
042f2  e9 51 ff             jmp loc_4246
loc_42f5:
042f5  d0 e3                shl bl, 1
042f7  d0 d4                rcl ah, 1
042f9  d0 e2                shl dl, 1
042fb  d0 d4                rcl ah, 1
042fd  d0 e6                shl dh, 1
042ff  d0 d4                rcl ah, 1
04301  d0 e0                shl al, 1
04303  d0 d4                rcl ah, 1
04305  d0 e3                shl bl, 1
04307  d0 d4                rcl ah, 1
04309  d0 e2                shl dl, 1
0430b  d0 d4                rcl ah, 1
0430d  d0 e6                shl dh, 1
0430f  d0 d4                rcl ah, 1
04311  d0 e0                shl al, 1
04313  d0 d4                rcl ah, 1
04315  26 88 25             mov byte ptr es:[di], ah
04318  d0 e3                shl bl, 1
0431a  d0 d4                rcl ah, 1
0431c  d0 e2                shl dl, 1
0431e  d0 d4                rcl ah, 1
04320  d0 e6                shl dh, 1
04322  d0 d4                rcl ah, 1
04324  d0 e0                shl al, 1
04326  d0 d4                rcl ah, 1
04328  d0 e3                shl bl, 1
0432a  d0 d4                rcl ah, 1
0432c  d0 e2                shl dl, 1
0432e  d0 d4                rcl ah, 1
04330  d0 e6                shl dh, 1
04332  d0 d4                rcl ah, 1
04334  d0 e0                shl al, 1
04336  d0 d4                rcl ah, 1
04338  26 88 25             mov byte ptr es:[di], ah
0433b  d0 e3                shl bl, 1
0433d  d0 d4                rcl ah, 1
0433f  d0 e2                shl dl, 1
04341  d0 d4                rcl ah, 1
04343  d0 e6                shl dh, 1
04345  d0 d4                rcl ah, 1
04347  d0 e0                shl al, 1
04349  d0 d4                rcl ah, 1
0434b  d0 e3                shl bl, 1
0434d  d0 d4                rcl ah, 1
0434f  d0 e2                shl dl, 1
04351  d0 d4                rcl ah, 1
04353  d0 e6                shl dh, 1
04355  d0 d4                rcl ah, 1
04357  d0 e0                shl al, 1
04359  d0 d4                rcl ah, 1
0435b  26 88 25             mov byte ptr es:[di], ah
0435e  d0 e3                shl bl, 1
04360  d0 d4                rcl ah, 1
04362  d0 e2                shl dl, 1
04364  d0 d4                rcl ah, 1
04366  d0 e6                shl dh, 1
04368  d0 d4                rcl ah, 1
0436a  d0 e0                shl al, 1
0436c  d0 d4                rcl ah, 1
0436e  d0 e4                shl ah, 1
04370  d0 e4                shl ah, 1
04372  d0 e4                shl ah, 1
04374  d0 e4                shl ah, 1
04376  80 e4 f0             and ah, 0xf0
04379  50                   push ax
0437a  53                   push bx
0437b  8a c4                mov al, ah
0437d  bb f0 2f             mov bx, 0x2ff0
04380  2e d7                xlatb
04382  5b                   pop bx
04383  26 20 05             and byte ptr es:[di], al
04386  26 08 25             or byte ptr es:[di], ah
04389  58                   pop ax
0438a  47                   inc di
0438b  5e                   pop si
0438c  5f                   pop di
0438d  2e 03 36 f4 30       add si, word ptr cs:[0x30f4]
04392  81 c7 00 20          add di, 0x2000
04396  f7 c7 00 80          test di, 0x8000
0439a  74 04                je loc_43a0
0439c  81 ef 60 7f          sub di, 0x7f60
loc_43a0:
043a0  2e ff 0e f2 30       dec word ptr cs:[0x30f2]
043a5  74 03                je loc_43aa
043a7  e9 4c fe             jmp loc_41f6
loc_43aa:
043aa  50                   push ax
043ab  b8 7c 09             mov ax, 0x97c
043ae  8e d8                mov ds, ax
043b0  58                   pop ax
043b1  c3                   ret
loc_43b2:
043b2  a1 4e 37             mov ax, word ptr [0x374e]    ; segment_source
043b5  8e d8                mov ds, ax
043b7  d1 ed                shr bp, 1
043b9  d1 ed                shr bp, 1
043bb  d1 ed                shr bp, 1
043bd  d1 ee                shr si, 1
043bf  bb 28 00             mov bx, 0x28
043c2  2b dd                sub bx, bp
loc_43c4:
043c4  8b d1                mov dx, cx
043c6  8b cd                mov cx, bp
043c8  f3 a4                rep movsb byte ptr es:[di], byte ptr [si]
043ca  03 fb                add di, bx
043cc  8b cd                mov cx, bp
043ce  f3 a4                rep movsb byte ptr es:[di], byte ptr [si]
043d0  03 fb                add di, bx
043d2  8b cd                mov cx, bp
043d4  f3 a4                rep movsb byte ptr es:[di], byte ptr [si]
043d6  03 fb                add di, bx
043d8  8b cd                mov cx, bp
043da  f3 a4                rep movsb byte ptr es:[di], byte ptr [si]
043dc  03 fb                add di, bx
043de  8b ca                mov cx, dx
043e0  e2 e2                loop loc_43c4
043e2  50                   push ax
043e3  b8 7c 09             mov ax, 0x97c
043e6  8e d8                mov ds, ax
043e8  58                   pop ax
043e9  c3                   ret
loc_43ea:
043ea  a1 4e 37             mov ax, word ptr [0x374e]    ; segment_source
043ed  8e d8                mov ds, ax
loc_43ef:
043ef  8b d1                mov dx, cx
043f1  8b cd                mov cx, bp
043f3  57                   push di
043f4  f3 a4                rep movsb byte ptr es:[di], byte ptr [si]
043f6  5f                   pop di
043f7  81 c7 40 01          add di, 0x140
043fb  8b ca                mov cx, dx
043fd  e2 f0                loop loc_43ef
043ff  50                   push ax
04400  b8 7c 09             mov ax, 0x97c
04403  8e d8                mov ds, ax
04405  58                   pop ax
04406  c3                   ret

; ======== efface_boite   (appelée depuis 5013, 7dc8, 83b0)
; SI = ligne, colonne, hauteur, largeur, couleurs : affiche (hauteur + 2) lignes de (largeur + 2) espaces (fond d'une boîte de texte)
04407  9c                   pushf
04408  50                   push ax
04409  53                   push bx
0440a  51                   push cx
0440b  52                   push dx
0440c  57                   push di
0440d  56                   push si
0440e  55                   push bp
0440f  06                   push es
04410  1e                   push ds
04411  50                   push ax
04412  b8 7c 09             mov ax, 0x97c
04415  8e c0                mov es, ax
04417  58                   pop ax
04418  8b 04                mov ax, word ptr [si]
0441a  bf 91 37             mov di, 0x3791    ; ligne_boite
0441d  89 45 01             mov word ptr [di + 1], ax
04420  8b 44 02             mov ax, word ptr [si + 2]
04423  a3 e5 37             mov word ptr [0x37e5], ax    ; boite_hauteur
04426  8b 44 04             mov ax, word ptr [si + 4]
04429  a3 e7 37             mov word ptr [0x37e7], ax    ; boite_largeur
0442c  8b c8                mov cx, ax
0442e  8b 44 06             mov ax, word ptr [si + 6]
04431  a3 50 37             mov word ptr [0x3750], ax    ; couleur_texte
04434  b0 20                mov al, 0x20
04436  88 45 03             mov byte ptr [di + 3], al
04439  b0 20                mov al, 0x20
0443b  83 c7 04             add di, 4
0443e  f3 aa                rep stosb byte ptr es:[di], al
04440  b0 20                mov al, 0x20
04442  aa                   stosb byte ptr es:[di], al
04443  32 c0                xor al, al
04445  aa                   stosb byte ptr es:[di], al
04446  bd 91 37             mov bp, 0x3791    ; ligne_boite
04449  06                   push es
0444a  e8 2f ed             call affiche_texte
0444d  07                   pop es
0444e  bf 94 37             mov di, 0x3794
04451  b0 20                mov al, 0x20
04453  aa                   stosb byte ptr es:[di], al
04454  b0 20                mov al, 0x20
04456  8b 0e e7 37          mov cx, word ptr [0x37e7]    ; boite_largeur
0445a  f3 aa                rep stosb byte ptr es:[di], al
0445c  b0 20                mov al, 0x20
0445e  aa                   stosb byte ptr es:[di], al
0445f  8b 0e e5 37          mov cx, word ptr [0x37e5]    ; boite_hauteur
04463  bd 91 37             mov bp, 0x3791    ; ligne_boite
04466  55                   push bp
04467  06                   push es
loc_4468:
04468  55                   push bp
04469  51                   push cx
0446a  3e fe 46 01          inc byte ptr ds:[bp + 1]
0446e  e8 0b ed             call affiche_texte
04471  59                   pop cx
04472  5d                   pop bp
04473  e2 f3                loop loc_4468
04475  07                   pop es
04476  5d                   pop bp
04477  bf 94 37             mov di, 0x3794
0447a  b0 20                mov al, 0x20
0447c  aa                   stosb byte ptr es:[di], al
0447d  8b 0e e7 37          mov cx, word ptr [0x37e7]    ; boite_largeur
04481  b0 20                mov al, 0x20
04483  f3 aa                rep stosb byte ptr es:[di], al
04485  b0 20                mov al, 0x20
04487  aa                   stosb byte ptr es:[di], al
04488  3e fe 46 01          inc byte ptr ds:[bp + 1]
0448c  e8 ed ec             call affiche_texte
0448f  1f                   pop ds
04490  07                   pop es
04491  5d                   pop bp
04492  5e                   pop si
04493  5f                   pop di
04494  5a                   pop dx
04495  59                   pop cx
04496  5b                   pop bx
04497  58                   pop ax
04498  9d                   popf
04499  c3                   ret

; ======== longueur_texte   (appelée depuis 5d9f)
; SI = position du 0 final du texte BP (en partant de 1)
0449a  be 01 00             mov si, 1
loc_449d:
0449d  3e 80 3a 00          cmp byte ptr ds:[bp + si], 0
044a1  75 01                jne loc_44a4
044a3  c3                   ret
loc_44a4:
044a4  46                   inc si
044a5  eb f6                jmp loc_449d

; ======== affiche_registres_attend
; affiche_registres puis attend_bouton_droit ; non appelée
044a7  e8 03 00             call affiche_registres
044aa  e9 58 f4             jmp attend_bouton_droit

; ======== affiche_registres   (appelée depuis 44a7, 5f53)
; outil de mise au point : AX à DS en hexadécimal (ligne 12, colonne 33), position et couleurs du texte préservées
044ad  ff 36 50 37          push word ptr [0x3750]    ; couleur_texte
044b1  ff 36 52 37          push word ptr [0x3752]    ; texte_colonne
044b5  ff 36 54 37          push word ptr [0x3754]    ; texte_ligne
044b9  ff 36 59 37          push word ptr [0x3759]    ; texte_transparent
044bd  9c                   pushf
044be  9c                   pushf
044bf  50                   push ax
044c0  53                   push bx
044c1  51                   push cx
044c2  52                   push dx
044c3  57                   push di
044c4  56                   push si
044c5  55                   push bp
044c6  06                   push es
044c7  1e                   push ds
044c8  50                   push ax
044c9  b8 7c 09             mov ax, 0x97c
044cc  8e d8                mov ds, ax
044ce  58                   pop ax
044cf  c6 06 59 37 00       mov byte ptr [0x3759], 0    ; texte_transparent
044d4  e8 c9 f1             call attend_retour_vertical
044d7  bd 13 35             mov bp, 0x3513
044da  e8 9f ec             call affiche_texte
044dd  8b ec                mov bp, sp
044df  8b 56 10             mov dx, word ptr [bp + 0x10]
044e2  e8 8c 00             call affiche_hexa
044e5  bd 1d 35             mov bp, 0x351d
044e8  e8 91 ec             call affiche_texte
044eb  8b ec                mov bp, sp
044ed  8b 56 0e             mov dx, word ptr [bp + 0xe]
044f0  e8 7e 00             call affiche_hexa
044f3  bd 27 35             mov bp, 0x3527
044f6  e8 83 ec             call affiche_texte
044f9  8b ec                mov bp, sp
044fb  8b 56 0c             mov dx, word ptr [bp + 0xc]
044fe  e8 70 00             call affiche_hexa
04501  bd 31 35             mov bp, 0x3531
04504  e8 75 ec             call affiche_texte
04507  8b ec                mov bp, sp
04509  8b 56 0a             mov dx, word ptr [bp + 0xa]
0450c  e8 62 00             call affiche_hexa
0450f  bd 63 35             mov bp, 0x3563
04512  e8 67 ec             call affiche_texte
04515  8b ec                mov bp, sp
04517  8b 56 04             mov dx, word ptr [bp + 4]
0451a  e8 54 00             call affiche_hexa
0451d  bd 3b 35             mov bp, 0x353b
04520  e8 59 ec             call affiche_texte
04523  8b ec                mov bp, sp
04525  8b 56 08             mov dx, word ptr [bp + 8]
04528  e8 46 00             call affiche_hexa
0452b  bd 45 35             mov bp, 0x3545
0452e  e8 4b ec             call affiche_texte
04531  8b ec                mov bp, sp
04533  8b 56 06             mov dx, word ptr [bp + 6]
04536  e8 38 00             call affiche_hexa
04539  bd 4f 35             mov bp, 0x354f
0453c  e8 3d ec             call affiche_texte
0453f  8b ec                mov bp, sp
04541  8b 56 02             mov dx, word ptr [bp + 2]
04544  e8 2a 00             call affiche_hexa
04547  bd 59 35             mov bp, 0x3559
0454a  e8 2f ec             call affiche_texte
0454d  8b ec                mov bp, sp
0454f  8b 56 00             mov dx, word ptr [bp]
04552  e8 1c 00             call affiche_hexa
04555  1f                   pop ds
04556  07                   pop es
04557  5d                   pop bp
04558  5e                   pop si
04559  5f                   pop di
0455a  5a                   pop dx
0455b  59                   pop cx
0455c  5b                   pop bx
0455d  58                   pop ax
0455e  9d                   popf
0455f  9d                   popf
04560  8f 06 59 37          pop word ptr [0x3759]    ; texte_transparent
04564  8f 06 54 37          pop word ptr [0x3754]    ; texte_ligne
04568  8f 06 52 37          pop word ptr [0x3752]    ; texte_colonne
0456c  8f 06 50 37          pop word ptr [0x3750]    ; couleur_texte
04570  c3                   ret

; ======== affiche_hexa   (appelée depuis 44e2, 44f0, 44fe, 450c, 451a, 4528, 4536, 4544)
; DX en 4 chiffres hexadécimaux
04571  89 16 f3 37          mov word ptr [0x37f3], dx    ; saisie_chiffres_lus
04575  8a c6                mov al, dh
04577  e8 1b 00             call chiffre_hexa_haut
0457a  a1 f3 37             mov ax, word ptr [0x37f3]    ; saisie_chiffres_lus
0457d  8a c4                mov al, ah
0457f  e8 0d 00             call chiffre_hexa_bas
04582  a1 f3 37             mov ax, word ptr [0x37f3]    ; saisie_chiffres_lus
04585  e8 0d 00             call chiffre_hexa_haut
04588  a1 f3 37             mov ax, word ptr [0x37f3]    ; saisie_chiffres_lus
0458b  e8 01 00             call chiffre_hexa_bas
0458e  c3                   ret

; ======== chiffre_hexa_bas   (appelée depuis 457f, 458b)
; chiffre du quartet bas de AL
0458f  24 0f                and al, 0xf
04591  e8 0f 00             call chiffre_hexa
04594  c3                   ret

; ======== chiffre_hexa_haut   (appelée depuis 4577, 4585)
; chiffre du quartet haut de AL
04595  24 f0                and al, 0xf0
04597  d0 e8                shr al, 1
04599  d0 e8                shr al, 1
0459b  d0 e8                shr al, 1
0459d  d0 e8                shr al, 1
0459f  e8 01 00             call chiffre_hexa
045a2  c3                   ret

; ======== chiffre_hexa   (appelée depuis 4591, 459f)
; affiche le chiffre AL (0 à 15) avec la table DS:3A70
045a3  bb 70 3a             mov bx, 0x3a70    ; "0123456789ABCDEF"
045a6  d7                   xlatb
045a7  e8 e1 eb             call affiche_caractere
045aa  c3                   ret

; ======== numero_bit   (appelée depuis 9373, 943e)
; numéro du premier bit posé de AL (0 à 7)
045ab  51                   push cx
045ac  b4 00                mov ah, 0
045ae  b9 08 00             mov cx, 8
loc_45b1:
045b1  d0 e8                shr al, 1
045b3  72 06                jb loc_45bb
045b5  fe c4                inc ah
045b7  e2 f8                loop loc_45b1
045b9  32 e4                xor ah, ah
loc_45bb:
045bb  8a c4                mov al, ah
045bd  59                   pop cx
045be  c3                   ret

; ======== installe_erreur_disque   (appelée depuis 30f6)
; détourne int 24h (erreur critique) vers erreur_disque
045bf  b4 25                mov ah, 0x25
045c1  b0 24                mov al, 0x24
045c3  ba cd 45             mov dx, 0x45cd
045c6  1e                   push ds
045c7  0e                   push cs
045c8  1f                   pop ds
045c9  cd 21                int 0x21
045cb  1f                   pop ds
045cc  c3                   ret

; ======== erreur_disque
; gestionnaire int 24h : AL = 0, ignorer l'erreur
045cd  b0 00                mov al, 0
045cf  f9                   stc
045d0  c3                   ret

; ======== lz_decompresse   (appelée depuis 0052, 147f, 1e22, 1e85, 50cf, 5109, 513a, 516b)
; décompression LZ : DS:SI vers ES:DI
045d1  fc                   cld
045d2  ba 00 00             mov dx, 0
loc_45d5:
045d5  b8 00 00             mov ax, 0
045d8  ac                   lodsb al, byte ptr [si]
045d9  3c 00                cmp al, 0
045db  75 03                jne loc_45e0
045dd  e9 a6 00             jmp loc_4686
loc_45e0:
045e0  a8 80                test al, 0x80
045e2  75 45                jne loc_4629
045e4  a8 40                test al, 0x40
045e6  75 1d                jne loc_4605
045e8  a8 20                test al, 0x20
045ea  74 08                je loc_45f4
045ec  24 df                and al, 0xdf
045ee  86 e0                xchg al, ah
045f0  ac                   lodsb al, byte ptr [si]
045f1  05 20 00             add ax, 0x20
loc_45f4:
045f4  48                   dec ax
loc_45f5:
045f5  a4                   movsb byte ptr es:[di], byte ptr [si]
045f6  42                   inc dx
045f7  49                   dec cx
045f8  75 03                jne loc_45fd
045fa  e9 89 00             jmp loc_4686
loc_45fd:
045fd  48                   dec ax
045fe  f6 c4 80             test ah, 0x80
04601  74 f2                je loc_45f5
04603  eb d0                jmp loc_45d5
loc_4605:
04605  24 bf                and al, 0xbf
04607  a8 20                test al, 0x20
04609  74 08                je loc_4613
0460b  24 df                and al, 0xdf
0460d  86 e0                xchg al, ah
0460f  ac                   lodsb al, byte ptr [si]
04610  05 21 00             add ax, 0x21
loc_4613:
04613  05 02 00             add ax, 2
04616  8a 1c                mov bl, byte ptr [si]
04618  46                   inc si
loc_4619:
04619  26 88 1d             mov byte ptr es:[di], bl
0461c  47                   inc di
0461d  42                   inc dx
0461e  49                   dec cx
0461f  74 65                je loc_4686
04621  48                   dec ax
04622  f6 c4 80             test ah, 0x80
04625  74 f2                je loc_4619
04627  eb ac                jmp loc_45d5
loc_4629:
04629  24 7f                and al, 0x7f
0462b  a8 40                test al, 0x40
0462d  75 29                jne loc_4658
0462f  bd 02 00             mov bp, 2
04632  a8 20                test al, 0x20
04634  75 03                jne loc_4639
04636  bd 01 00             mov bp, 1
loc_4639:
04639  24 df                and al, 0xdf
0463b  8b df                mov bx, di
0463d  4b                   dec bx
0463e  2b d8                sub bx, ax
04640  2b dd                sub bx, bp
loc_4642:
04642  26 8a 07             mov al, byte ptr es:[bx]
04645  26 88 05             mov byte ptr es:[di], al
04648  43                   inc bx
04649  47                   inc di
0464a  42                   inc dx
0464b  49                   dec cx
0464c  74 38                je loc_4686
0464e  4d                   dec bp
0464f  f7 c5 00 80          test bp, 0x8000
04653  74 ed                je loc_4642
04655  e9 7d ff             jmp loc_45d5
loc_4658:
04658  24 bf                and al, 0xbf
0465a  8b e8                mov bp, ax
0465c  86 c4                xchg ah, al
0465e  ac                   lodsb al, byte ptr [si]
0465f  25 ff 03             and ax, 0x3ff
04662  d1 ed                shr bp, 1
04664  d1 ed                shr bp, 1
04666  83 c5 03             add bp, 3
04669  8b df                mov bx, di
0466b  4b                   dec bx
0466c  2b d8                sub bx, ax
0466e  2b dd                sub bx, bp
loc_4670:
04670  26 8a 07             mov al, byte ptr es:[bx]
04673  26 88 05             mov byte ptr es:[di], al
04676  43                   inc bx
04677  47                   inc di
04678  42                   inc dx
04679  49                   dec cx
0467a  74 0a                je loc_4686
0467c  4d                   dec bp
0467d  f7 c5 00 80          test bp, 0x8000
04681  74 ed                je loc_4670
04683  e9 4f ff             jmp loc_45d5
loc_4686:
04686  c3                   ret

; ======== temporise   (appelée depuis 049a, 208e, 21e2, 22b8, 22f7, 2529)
; CX fois la boucle d'attente pause_courte (1000 tours)
04687  51                   push cx
04688  e8 20 ef             call pause_courte
0468b  59                   pop cx
0468c  e2 f9                loop temporise
0468e  c3                   ret

; ======== attend_trame   (appelée depuis 0863)
; attend le début puis la fin du retour de trame, sur le port d'état DS:3A82
0468f  50                   push ax
04690  52                   push dx
04691  1e                   push ds
04692  50                   push ax
04693  b8 7c 09             mov ax, 0x97c
04696  8e d8                mov ds, ax
04698  58                   pop ax
04699  8b 16 82 3a          mov dx, word ptr [0x3a82]    ; port_etat_video
loc_469d:
0469d  ec                   in al, dx
0469e  a8 08                test al, 8
046a0  74 fb                je loc_469d
loc_46a2:
046a2  ec                   in al, dx
046a3  a8 08                test al, 8
046a5  75 fb                jne loc_46a2
046a7  1f                   pop ds
046a8  5a                   pop dx
046a9  58                   pop ax
046aa  c3                   ret

; ======== lit_ports_video   (appelée depuis 5f83)
; DS:3A80 = port du CRTC lu dans le BIOS (0040:0063), DS:3A82 = ce port + 6 (état)
046ab  b8 40 00             mov ax, 0x40
046ae  8e c0                mov es, ax
046b0  26 a1 63 00          mov ax, word ptr es:[0x63]
046b4  a3 80 3a             mov word ptr [0x3a80], ax    ; port_crtc
046b7  05 06 00             add ax, 6
046ba  a3 82 3a             mov word ptr [0x3a82], ax    ; port_etat_video
046bd  c3                   ret

; ======== etalonne_joystick   (appelée depuis 316f)
; message et étalonnage (DS:320A à 320D)
046be  32 e4                xor ah, ah
046c0  b0 03                mov al, 3
046c2  cd 10                int 0x10
046c4  ba ee 35             mov dx, 0x35ee
046c7  b4 09                mov ah, 9
046c9  cd 21                int 0x21
046cb  ba 01 02             mov dx, 0x201
loc_46ce:
046ce  ec                   in al, dx
046cf  a8 10                test al, 0x10
046d1  74 0e                je loc_46e1
046d3  a8 20                test al, 0x20
046d5  74 0a                je loc_46e1
046d7  a8 40                test al, 0x40
046d9  74 0e                je loc_46e9
046db  a8 80                test al, 0x80
046dd  74 0a                je loc_46e9
046df  eb ed                jmp loc_46ce
loc_46e1:
046e1  c6 06 0a 32 03       mov byte ptr [0x320a], 3    ; masque_joystick
046e6  eb 06                jmp loc_46ee
; ---- 1 octets non atteints (46e8-46e8)
loc_46e9:
046e9  c6 06 0a 32 c0       mov byte ptr [0x320a], 0xc0    ; masque_joystick
loc_46ee:
046ee  e8 1d 00             call joystick_position
046f1  80 3e 0a 32 03       cmp byte ptr [0x320a], 3    ; masque_joystick
046f6  75 0b                jne loc_4703
046f8  89 0e 0b 32          mov word ptr [0x320b], cx    ; joystick_centre_x
046fc  89 1e 0d 32          mov word ptr [0x320d], bx    ; joystick_centre_y
04700  eb 0b                jmp loc_470d
; ---- 1 octets non atteints (4702-4702)
loc_4703:
04703  8b c7                mov ax, di
04705  a3 0b 32             mov word ptr [0x320b], ax    ; joystick_centre_x
04708  8b c6                mov ax, si
0470a  a3 0d 32             mov word ptr [0x320d], ax    ; joystick_centre_y
loc_470d:
0470d  c3                   ret

; ======== joystick_position   (appelée depuis 37b1, 46ee)
; chronomètre le port 201h, masqué par DS:320A : BX x et CX y (×2) du joystick A ; DI x et SI y (×2) du joystick B
0470e  fa                   cli
0470f  33 db                xor bx, bx
04711  33 c9                xor cx, cx
04713  33 ff                xor di, di
04715  33 f6                xor si, si
04717  ba 01 02             mov dx, 0x201
0471a  ee                   out dx, al
0471b  eb 01                jmp loc_471e
; ---- 1 octets non atteints (471d-471d)
loc_471e:
0471e  eb 01                jmp loc_4721
; ---- 1 octets non atteints (4720-4720)
loc_4721:
04721  eb 01                jmp loc_4724
; ---- 1 octets non atteints (4723-4723)
loc_4724:
04724  ec                   in al, dx
04725  22 06 0a 32          and al, byte ptr [0x320a]    ; masque_joystick
04729  32 e4                xor ah, ah
0472b  8b e8                mov bp, ax
0472d  25 01 00             and ax, 1
04730  03 d8                add bx, ax
04732  8b c5                mov ax, bp
04734  25 02 00             and ax, 2
04737  03 c8                add cx, ax
04739  8b c5                mov ax, bp
0473b  25 04 00             and ax, 4
0473e  d1 e8                shr ax, 1
04740  d1 e8                shr ax, 1
04742  03 f8                add di, ax
04744  8b c5                mov ax, bp
04746  25 08 00             and ax, 8
04749  d1 e8                shr ax, 1
0474b  d1 e8                shr ax, 1
0474d  03 f0                add si, ax
0474f  0b ed                or bp, bp
04751  75 d1                jne loc_4724
04753  fb                   sti
04754  c3                   ret

; ======== joystick_boutons   (appelée depuis 3809)
; boutons des deux joysticks fusionnés dans les bits 0 à 3 de AL (port 201h inversé)
04755  fa                   cli
04756  ba 01 02             mov dx, 0x201
04759  ec                   in al, dx
0475a  f6 d0                not al
0475c  8a e0                mov ah, al
0475e  d0 e8                shr al, 1
04760  d0 e8                shr al, 1
04762  0a c4                or al, ah
04764  d0 e8                shr al, 1
04766  d0 e8                shr al, 1
04768  d0 e8                shr al, 1
0476a  d0 e8                shr al, 1
0476c  fb                   sti
0476d  c3                   ret

; ======== son_arret   (appelée depuis 02bc)
; int 60h AX=0Bh, coupe le haut-parleur (port 61h)
0476e  80 3e 92 31 00       cmp byte ptr [0x3192], 0    ; son_pilote
04773  75 0b                jne loc_4780
04775  b8 0b 00             mov ax, 0xb
04778  cd 60                int 0x60
0477a  e4 61                in al, 0x61
0477c  24 fc                and al, 0xfc
0477e  e6 61                out 0x61, al
loc_4780:
04780  80 3e 92 31 00       cmp byte ptr [0x3192], 0    ; son_pilote
04785  74 14                je loc_479b
04787  8b 3e 9e 31          mov di, word ptr [0x319e]    ; son_effet_poignee
0478b  80 3e 99 31 01       cmp byte ptr [0x3199], 1    ; son_actif
04790  74 04                je loc_4796
04792  8b 3e 9c 31          mov di, word ptr [0x319c]    ; son_musique_poignee
loc_4796:
04796  b8 04 00             mov ax, 4
04799  cd 60                int 0x60
loc_479b:
0479b  b8 0b 00             mov ax, 0xb
0479e  cd 60                int 0x60
047a0  b8 00 00             mov ax, 0
047a3  cd 60                int 0x60
047a5  c3                   ret

; ======== son_charge_pilote   (appelée depuis 5fd1)
; réserve la mémoire et charge le pilote choisi par DS:3192 (tables DS:31F0, DS:31D0)
047a6  c6 06 99 31 00       mov byte ptr [0x3199], 0    ; son_actif
047ab  8a 1e 92 31          mov bl, byte ptr [0x3192]    ; son_pilote
047af  d0 e3                shl bl, 1
047b1  32 ff                xor bh, bh
047b3  89 1e f9 37          mov word ptr [0x37f9], bx    ; rang_pixel
047b7  8b 9f f0 31          mov bx, word ptr [bx + 0x31f0]
047bb  b4 48                mov ah, 0x48
047bd  cd 21                int 0x21
047bf  73 01                jae loc_47c2
047c1  c3                   ret
loc_47c2:
047c2  a3 08 32             mov word ptr [0x3208], ax
047c5  8b 1e f9 37          mov bx, word ptr [0x37f9]    ; rang_pixel
047c9  8b 8f d0 31          mov cx, word ptr [bx + 0x31d0]    ; son_fichiers
047cd  83 f9 00             cmp cx, 0
047d0  74 29                je loc_47fb
047d2  89 0e e9 37          mov word ptr [0x37e9], cx    ; erreur_fichier
047d6  8b 9f f8 31          mov bx, word ptr [bx + 0x31f8]
047da  b4 48                mov ah, 0x48
047dc  cd 21                int 0x21
047de  73 01                jae loc_47e1
047e0  c3                   ret
loc_47e1:
047e1  a3 9a 31             mov word ptr [0x319a], ax    ; seg_son_donnees
047e4  8b 1e e9 37          mov bx, word ptr [0x37e9]    ; erreur_fichier
047e8  89 1e 07 39          mov word ptr [0x3907], bx    ; fichier_nom
047ec  c7 06 03 39 00 00    mov word ptr [0x3903], 0    ; fichier_offset
047f2  a1 9a 31             mov ax, word ptr [0x319a]    ; seg_son_donnees
047f5  a3 01 39             mov word ptr [0x3901], ax    ; fichier_segment
047f8  e8 86 f1             call charge_fichier
loc_47fb:
047fb  8a 1e 92 31          mov bl, byte ptr [0x3192]    ; son_pilote
047ff  d0 e3                shl bl, 1
04801  32 ff                xor bh, bh
04803  8b 9f a0 31          mov bx, word ptr [bx + 0x31a0]    ; son_pilotes
04807  89 1e 07 39          mov word ptr [0x3907], bx    ; fichier_nom
0480b  c7 06 03 39 00 00    mov word ptr [0x3903], 0    ; fichier_offset
04811  a1 08 32             mov ax, word ptr [0x3208]
04814  a3 01 39             mov word ptr [0x3901], ax    ; fichier_segment
04817  e8 67 f1             call charge_fichier
0481a  ff 1e 06 32          lcall [0x3206]
0481e  b8 0a 00             mov ax, 0xa
04821  cd 60                int 0x60
04823  f8                   clc
04824  c3                   ret

; ======== son_prepare   (appelée depuis 5fd7)
; au démarrage : int 60h AX=2 donne les données au pilote (sauf haut-parleur), puis AX=3 lance la musique (morceau DS:31FE : 0, 1 pour Tandy) ; poignée en DS:319C
04825  80 3e 92 31 00       cmp byte ptr [0x3192], 0    ; son_pilote
0482a  74 0c                je loc_4838
0482c  8b 16 9a 31          mov dx, word ptr [0x319a]    ; seg_son_donnees
04830  be 00 00             mov si, 0
04833  b8 02 00             mov ax, 2
04836  cd 60                int 0x60
loc_4838:
04838  8a 1e 92 31          mov bl, byte ptr [0x3192]    ; son_pilote
0483c  32 ff                xor bh, bh
0483e  d1 e3                shl bx, 1
04840  8b 97 fe 31          mov dx, word ptr [bx + 0x31fe]
04844  8b ca                mov cx, dx
04846  b8 03 00             mov ax, 3
04849  cd 60                int 0x60
0484b  89 3e 9c 31          mov word ptr [0x319c], di    ; son_musique_poignee
0484f  c3                   ret

; ======== son_musique   (appelée depuis 37a5)
; une fois la touche F10 enfoncée (DS:3956 = etat_touches + 44h) : coupe la musique (int 60h AX=4) et active les effets (son_actif = 1), une seule fois
04850  80 3e 99 31 01       cmp byte ptr [0x3199], 1    ; son_actif
04855  75 01                jne loc_4858
04857  c3                   ret
loc_4858:
04858  80 3e 56 39 01       cmp byte ptr [0x3956], 1
0485d  74 01                je loc_4860
0485f  c3                   ret
loc_4860:
04860  c6 06 99 31 01       mov byte ptr [0x3199], 1    ; son_actif
04865  80 3e 92 31 03       cmp byte ptr [0x3192], 3    ; son_pilote
0486a  75 09                jne loc_4875
0486c  ba 00 00             mov dx, 0
0486f  b8 03 00             mov ax, 3
04872  cd 60                int 0x60
04874  c3                   ret
loc_4875:
04875  8b 3e 9c 31          mov di, word ptr [0x319c]    ; son_musique_poignee
04879  b8 04 00             mov ax, 4
0487c  cd 60                int 0x60
0487e  80 3e 92 31 00       cmp byte ptr [0x3192], 0    ; son_pilote
04883  75 0b                jne loc_4890
04885  b8 0b 00             mov ax, 0xb
04888  cd 60                int 0x60
0488a  e4 61                in al, 0x61
0488c  24 fc                and al, 0xfc
0488e  e6 61                out 0x61, al
loc_4890:
04890  c3                   ret
loc_4891:
04891  e8 5d ee             call clavier_retire
04894  32 e4                xor ah, ah
04896  b0 03                mov al, 3
04898  cd 10                int 0x10
0489a  b8 00 4c             mov ax, 0x4c00
0489d  cd 21                int 0x21
0489f  00 8a 55 01          add byte ptr [bp + si + 0x155], cl
; ---- -3 octets non atteints (48a3-489f)
pas_gauche:
048a0  8a 55 01             mov dl, byte ptr [di + 1]
048a3  80 fa 00             cmp dl, 0
048a6  75 03                jne loc_48ab
048a8  e9 f4 04             jmp loc_4d9f
loc_48ab:
048ab  8a 75 02             mov dh, byte ptr [di + 2]
048ae  fe ca                dec dl
048b0  e8 d4 c9             call personnage_en_dx
048b3  0a c0                or al, al
048b5  74 03                je loc_48ba
048b7  e9 e5 04             jmp loc_4d9f
loc_48ba:
048ba  f6 06 9b 3f 04       test byte ptr [0x3f9b], 4    ; etat_action
048bf  74 03                je loc_48c4
048c1  e9 db 04             jmp loc_4d9f
loc_48c4:
048c4  80 3e 9c 3f 00       cmp byte ptr [0x3f9c], 0    ; deplacement_restant
048c9  75 03                jne loc_48ce
048cb  e9 d1 04             jmp loc_4d9f
loc_48ce:
048ce  80 7d 01 00          cmp byte ptr [di + 1], 0
048d2  75 03                jne loc_48d7
048d4  e9 c8 04             jmp loc_4d9f
loc_48d7:
048d7  8b 5d 04             mov bx, word ptr [di + 4]
048da  f6 07 40             test byte ptr [bx], 0x40
048dd  74 14                je loc_48f3
048df  f6 45 18 20          test byte ptr [di + 0x18], 0x20
048e3  75 03                jne loc_48e8
048e5  e9 b7 04             jmp loc_4d9f
loc_48e8:
048e8  8a 87 ff fd          mov al, byte ptr [bx - 0x201]
048ec  24 3f                and al, 0x3f
048ee  75 03                jne loc_48f3
048f0  e9 ac 04             jmp loc_4d9f
loc_48f3:
048f3  b5 00                mov ch, 0
048f5  c6 06 cc 40 00       mov byte ptr [0x40cc], 0    ; direction_pas
048fa  f6 07 10             test byte ptr [bx], 0x10
048fd  74 38                je loc_4937
048ff  8b 45 04             mov ax, word ptr [di + 4]
04902  3b 06 0f 0e          cmp ax, word ptr [0xe0f]    ; case_apres_porte
04906  75 03                jne loc_490b
04908  e9 94 04             jmp loc_4d9f
loc_490b:
0490b  c6 06 b4 3e 01       mov byte ptr [0x3eb4], 1    ; porte_franchie
04910  90                   nop
04911  f6 07 04             test byte ptr [bx], 4
04914  75 19                jne loc_492f
04916  f6 07 08             test byte ptr [bx], 8
04919  74 03                je loc_491e
0491b  e9 81 04             jmp loc_4d9f
loc_491e:
0491e  80 3e 92 3f 0f       cmp byte ptr [0x3f92], 0xf    ; numero_quete
04923  73 08                jae loc_492d
04925  8a 07                mov al, byte ptr [bx]
04927  e8 5e be             call teste_porte_reveille
0492a  e8 fa de             call son_porte
loc_492d:
0492d  b5 04                mov ch, 4
loc_492f:
0492f  3b 1e ce 3f          cmp bx, word ptr [0x3fce]
04933  89 1e ce 3f          mov word ptr [0x3fce], bx
loc_4937:
04937  81 c3 ff 01          add bx, 0x1ff
0493b  8a 07                mov al, byte ptr [bx]
0493d  0a c0                or al, al
0493f  74 19                je loc_495a
04941  3c 32                cmp al, 0x32
04943  73 03                jae loc_4948
04945  e9 57 04             jmp loc_4d9f
loc_4948:
04948  3c 40                cmp al, 0x40
0494a  72 03                jb loc_494f
0494c  e9 50 04             jmp loc_4d9f
loc_494f:
0494f  8a 55 01             mov dl, byte ptr [di + 1]
04952  8a 75 02             mov dh, byte ptr [di + 2]
04955  fe ca                dec dl
04957  e8 6d 04             call entre_piege
loc_495a:
0495a  8b 5d 04             mov bx, word ptr [di + 4]
0495d  08 2f                or byte ptr [bx], ch
0495f  4b                   dec bx
04960  fe 4d 01             dec byte ptr [di + 1]
04963  b0 02                mov al, 2
04965  e9 57 02             jmp pas_fait

; ======== pas_droite
04968  8a 55 01             mov dl, byte ptr [di + 1]
0496b  80 fa 19             cmp dl, 0x19
0496e  75 03                jne loc_4973
04970  e9 2c 04             jmp loc_4d9f
loc_4973:
04973  fe c2                inc dl
04975  8a 75 02             mov dh, byte ptr [di + 2]
04978  e8 0c c9             call personnage_en_dx
0497b  0a c0                or al, al
0497d  74 03                je loc_4982
0497f  e9 1d 04             jmp loc_4d9f
loc_4982:
04982  a0 9b 3f             mov al, byte ptr [0x3f9b]    ; etat_action
04985  a8 04                test al, 4
04987  74 03                je loc_498c
04989  e9 13 04             jmp loc_4d9f
loc_498c:
0498c  80 3e 9c 3f 00       cmp byte ptr [0x3f9c], 0    ; deplacement_restant
04991  75 03                jne loc_4996
04993  e9 09 04             jmp loc_4d9f
loc_4996:
04996  80 7d 01 19          cmp byte ptr [di + 1], 0x19
0499a  75 03                jne loc_499f
0499c  e9 00 04             jmp loc_4d9f
loc_499f:
0499f  8b 5d 04             mov bx, word ptr [di + 4]
049a2  43                   inc bx
049a3  f6 07 40             test byte ptr [bx], 0x40
049a6  74 14                je loc_49bc
049a8  f6 45 18 20          test byte ptr [di + 0x18], 0x20
049ac  75 03                jne loc_49b1
049ae  e9 ee 03             jmp loc_4d9f
loc_49b1:
049b1  8a 87 00 fe          mov al, byte ptr [bx - 0x200]
049b5  24 3f                and al, 0x3f
049b7  75 03                jne loc_49bc
049b9  e9 e3 03             jmp loc_4d9f
loc_49bc:
049bc  b5 00                mov ch, 0
049be  c6 06 cc 40 01       mov byte ptr [0x40cc], 1    ; direction_pas
049c3  f6 07 10             test byte ptr [bx], 0x10
049c6  74 36                je loc_49fe
049c8  8b 45 04             mov ax, word ptr [di + 4]
049cb  3b 06 0f 0e          cmp ax, word ptr [0xe0f]    ; case_apres_porte
049cf  75 03                jne loc_49d4
049d1  e9 cb 03             jmp loc_4d9f
loc_49d4:
049d4  c6 06 b4 3e 01       mov byte ptr [0x3eb4], 1    ; porte_franchie
049d9  90                   nop
049da  f6 07 04             test byte ptr [bx], 4
049dd  75 17                jne loc_49f6
049df  f6 07 08             test byte ptr [bx], 8
049e2  74 03                je loc_49e7
049e4  e9 b8 03             jmp loc_4d9f
loc_49e7:
049e7  80 3e 92 3f 0f       cmp byte ptr [0x3f92], 0xf    ; numero_quete
049ec  73 06                jae loc_49f4
049ee  e8 97 bd             call teste_porte_reveille
049f1  e8 33 de             call son_porte
loc_49f4:
049f4  b5 04                mov ch, 4
loc_49f6:
049f6  3b 1e ce 3f          cmp bx, word ptr [0x3fce]
049fa  89 1e ce 3f          mov word ptr [0x3fce], bx
loc_49fe:
049fe  81 c3 00 02          add bx, 0x200
04a02  8a 07                mov al, byte ptr [bx]
04a04  0a c0                or al, al
04a06  74 19                je loc_4a21
04a08  3c 32                cmp al, 0x32
04a0a  73 03                jae loc_4a0f
04a0c  e9 90 03             jmp loc_4d9f
loc_4a0f:
04a0f  3c 40                cmp al, 0x40
04a11  72 03                jb loc_4a16
04a13  e9 89 03             jmp loc_4d9f
loc_4a16:
04a16  8a 55 01             mov dl, byte ptr [di + 1]
04a19  8a 75 02             mov dh, byte ptr [di + 2]
04a1c  fe c2                inc dl
04a1e  e8 a6 03             call entre_piege
loc_4a21:
04a21  8b 5d 04             mov bx, word ptr [di + 4]
04a24  43                   inc bx
04a25  08 2f                or byte ptr [bx], ch
04a27  fe 45 01             inc byte ptr [di + 1]
04a2a  b0 01                mov al, 1
04a2c  e9 90 01             jmp pas_fait

; ======== pas_haut
04a2f  8a 55 01             mov dl, byte ptr [di + 1]
04a32  8a 75 02             mov dh, byte ptr [di + 2]
04a35  80 fe 00             cmp dh, 0
04a38  75 03                jne loc_4a3d
04a3a  e9 62 03             jmp loc_4d9f
loc_4a3d:
04a3d  fe ce                dec dh
04a3f  e8 45 c8             call personnage_en_dx
04a42  0a c0                or al, al
04a44  74 03                je loc_4a49
04a46  e9 56 03             jmp loc_4d9f
loc_4a49:
04a49  f6 06 9b 3f 04       test byte ptr [0x3f9b], 4    ; etat_action
04a4e  74 03                je loc_4a53
04a50  e9 4c 03             jmp loc_4d9f
loc_4a53:
04a53  80 3e 9c 3f 00       cmp byte ptr [0x3f9c], 0    ; deplacement_restant
04a58  75 03                jne loc_4a5d
04a5a  e9 42 03             jmp loc_4d9f
loc_4a5d:
04a5d  80 7d 02 00          cmp byte ptr [di + 2], 0
04a61  75 03                jne loc_4a66
04a63  e9 39 03             jmp loc_4d9f
loc_4a66:
04a66  8b 5d 04             mov bx, word ptr [di + 4]
04a69  f6 07 80             test byte ptr [bx], 0x80
04a6c  74 14                je loc_4a82
04a6e  f6 45 18 20          test byte ptr [di + 0x18], 0x20
04a72  75 03                jne loc_4a77
04a74  e9 28 03             jmp loc_4d9f
loc_4a77:
04a77  8a 87 e6 fd          mov al, byte ptr [bx - 0x21a]
04a7b  24 3f                and al, 0x3f
04a7d  75 03                jne loc_4a82
04a7f  e9 1d 03             jmp loc_4d9f
loc_4a82:
04a82  b5 00                mov ch, 0
04a84  c6 06 cc 40 02       mov byte ptr [0x40cc], 2    ; direction_pas
04a89  f6 07 20             test byte ptr [bx], 0x20
04a8c  74 36                je loc_4ac4
04a8e  8b 45 04             mov ax, word ptr [di + 4]
04a91  3b 06 0f 0e          cmp ax, word ptr [0xe0f]    ; case_apres_porte
04a95  75 03                jne loc_4a9a
04a97  e9 05 03             jmp loc_4d9f
loc_4a9a:
04a9a  c6 06 b4 3e 01       mov byte ptr [0x3eb4], 1    ; porte_franchie
04a9f  90                   nop
04aa0  f6 07 04             test byte ptr [bx], 4
04aa3  75 17                jne loc_4abc
04aa5  f6 07 08             test byte ptr [bx], 8
04aa8  74 03                je loc_4aad
04aaa  e9 f2 02             jmp loc_4d9f
loc_4aad:
04aad  80 3e 92 3f 0f       cmp byte ptr [0x3f92], 0xf    ; numero_quete
04ab2  73 06                jae loc_4aba
04ab4  e8 d1 bc             call teste_porte_reveille
04ab7  e8 6d dd             call son_porte
loc_4aba:
04aba  b5 04                mov ch, 4
loc_4abc:
04abc  3b 1e ce 3f          cmp bx, word ptr [0x3fce]
04ac0  89 1e ce 3f          mov word ptr [0x3fce], bx
loc_4ac4:
04ac4  81 c3 e6 01          add bx, 0x1e6
04ac8  8a 07                mov al, byte ptr [bx]
04aca  0a c0                or al, al
04acc  74 19                je loc_4ae7
04ace  3c 32                cmp al, 0x32
04ad0  73 03                jae loc_4ad5
04ad2  e9 ca 02             jmp loc_4d9f
loc_4ad5:
04ad5  3c 40                cmp al, 0x40
04ad7  72 03                jb loc_4adc
04ad9  e9 c3 02             jmp loc_4d9f
loc_4adc:
04adc  8a 55 01             mov dl, byte ptr [di + 1]
04adf  8a 75 02             mov dh, byte ptr [di + 2]
04ae2  fe ce                dec dh
04ae4  e8 e0 02             call entre_piege
loc_4ae7:
04ae7  8b 5d 04             mov bx, word ptr [di + 4]
04aea  08 2f                or byte ptr [bx], ch
04aec  83 eb 1a             sub bx, 0x1a
04aef  fe 4d 02             dec byte ptr [di + 2]
04af2  b0 03                mov al, 3
04af4  e9 c8 00             jmp pas_fait

; ======== pas_bas
04af7  8a 55 01             mov dl, byte ptr [di + 1]
04afa  8a 75 02             mov dh, byte ptr [di + 2]
04afd  80 fe 13             cmp dh, 0x13
04b00  75 03                jne loc_4b05
04b02  e9 9a 02             jmp loc_4d9f
loc_4b05:
04b05  fe c6                inc dh
04b07  e8 7d c7             call personnage_en_dx
04b0a  0a c0                or al, al
04b0c  74 03                je loc_4b11
04b0e  e9 8e 02             jmp loc_4d9f
loc_4b11:
04b11  f6 06 9b 3f 04       test byte ptr [0x3f9b], 4    ; etat_action
04b16  74 03                je loc_4b1b
04b18  e9 84 02             jmp loc_4d9f
loc_4b1b:
04b1b  80 3e 9c 3f 00       cmp byte ptr [0x3f9c], 0    ; deplacement_restant
04b20  75 03                jne loc_4b25
04b22  e9 7a 02             jmp loc_4d9f
loc_4b25:
04b25  80 7d 02 12          cmp byte ptr [di + 2], 0x12
04b29  75 03                jne loc_4b2e
04b2b  e9 71 02             jmp loc_4d9f
loc_4b2e:
04b2e  8b 5d 04             mov bx, word ptr [di + 4]
04b31  83 c3 1a             add bx, 0x1a
04b34  f6 07 80             test byte ptr [bx], 0x80
04b37  74 14                je loc_4b4d
04b39  f6 45 18 20          test byte ptr [di + 0x18], 0x20
04b3d  75 03                jne loc_4b42
04b3f  e9 5d 02             jmp loc_4d9f
loc_4b42:
04b42  8a 87 00 fe          mov al, byte ptr [bx - 0x200]
04b46  24 3f                and al, 0x3f
04b48  75 03                jne loc_4b4d
04b4a  e9 52 02             jmp loc_4d9f
loc_4b4d:
04b4d  b5 00                mov ch, 0
04b4f  c6 06 cc 40 03       mov byte ptr [0x40cc], 3    ; direction_pas
04b54  f6 07 20             test byte ptr [bx], 0x20
04b57  74 36                je loc_4b8f
04b59  8b 45 04             mov ax, word ptr [di + 4]
04b5c  3b 06 0f 0e          cmp ax, word ptr [0xe0f]    ; case_apres_porte
04b60  75 03                jne loc_4b65
04b62  e9 3a 02             jmp loc_4d9f
loc_4b65:
04b65  c6 06 b4 3e 01       mov byte ptr [0x3eb4], 1    ; porte_franchie
04b6a  90                   nop
04b6b  f6 07 04             test byte ptr [bx], 4
04b6e  75 17                jne loc_4b87
04b70  f6 07 08             test byte ptr [bx], 8
04b73  74 03                je loc_4b78
04b75  e9 27 02             jmp loc_4d9f
loc_4b78:
04b78  80 3e 92 3f 0f       cmp byte ptr [0x3f92], 0xf    ; numero_quete
04b7d  73 06                jae loc_4b85
04b7f  e8 06 bc             call teste_porte_reveille
04b82  e8 a2 dc             call son_porte
loc_4b85:
04b85  b5 04                mov ch, 4
loc_4b87:
04b87  3b 1e ce 3f          cmp bx, word ptr [0x3fce]
04b8b  89 1e ce 3f          mov word ptr [0x3fce], bx
loc_4b8f:
04b8f  81 c3 00 02          add bx, 0x200
04b93  8a 07                mov al, byte ptr [bx]
04b95  0a c0                or al, al
04b97  74 19                je loc_4bb2
04b99  3c 32                cmp al, 0x32
04b9b  73 03                jae loc_4ba0
04b9d  e9 ff 01             jmp loc_4d9f
loc_4ba0:
04ba0  3c 40                cmp al, 0x40
04ba2  72 03                jb loc_4ba7
04ba4  e9 f8 01             jmp loc_4d9f
loc_4ba7:
04ba7  8a 55 01             mov dl, byte ptr [di + 1]
04baa  8a 75 02             mov dh, byte ptr [di + 2]
04bad  fe c6                inc dh
04baf  e8 15 02             call entre_piege
loc_4bb2:
04bb2  8b 5d 04             mov bx, word ptr [di + 4]
04bb5  83 c3 1a             add bx, 0x1a
04bb8  08 2f                or byte ptr [bx], ch
04bba  fe 45 02             inc byte ptr [di + 2]
04bbd  32 c0                xor al, al
pas_fait:    ; commun aux 4 pas : déplacement - 1, zone, téléports des quêtes 10 et 16
04bbf  80 3e b4 3e 01       cmp byte ptr [0x3eb4], 1    ; porte_franchie
04bc4  75 13                jne loc_4bd9
04bc6  56                   push si
04bc7  8b 75 04             mov si, word ptr [di + 4]
04bca  89 36 11 0e          mov word ptr [0xe11], si    ; case_avant_porte
04bce  5e                   pop si
04bcf  89 1e 0f 0e          mov word ptr [0xe0f], bx    ; case_apres_porte
04bd3  c6 06 b4 3e 00       mov byte ptr [0x3eb4], 0    ; porte_franchie
04bd8  90                   nop
loc_4bd9:
04bd9  89 5d 04             mov word ptr [di + 4], bx
04bdc  a2 9b 40             mov byte ptr [0x409b], al
04bdf  80 0e 9b 3f 01       or byte ptr [0x3f9b], 1    ; etat_action
04be4  fe 0e 9c 3f          dec byte ptr [0x3f9c]    ; deplacement_restant
04be8  e8 30 ca             call adresse_case_perso
04beb  3a 45 03             cmp al, byte ptr [di + 3]
04bee  75 03                jne loc_4bf3
04bf0  e9 86 01             jmp loc_4d79
loc_4bf3:
04bf3  80 3e 92 3f 0f       cmp byte ptr [0x3f92], 0xf    ; numero_quete
04bf8  72 5a                jb loc_4c54
04bfa  80 7d 03 1f          cmp byte ptr [di + 3], 0x1f
04bfe  74 03                je loc_4c03
04c00  e9 ad 22             jmp redessin_plateau
loc_4c03:
04c03  80 3e 92 3f 0f       cmp byte ptr [0x3f92], 0xf    ; numero_quete
04c08  74 03                je loc_4c0d
04c0a  e9 a3 22             jmp redessin_plateau
loc_4c0d:
04c0d  c7 45 01 00 00       mov word ptr [di + 1], 0
loc_4c12:
04c12  e8 1e 14             call de6_moins_un
04c15  8a c3                mov al, bl
04c17  02 db                add bl, bl
04c19  02 db                add bl, bl
04c1b  02 d8                add bl, al
04c1d  32 ff                xor bh, bh
04c1f  8b 97 df 43          mov dx, word ptr [bx + 0x43df]
04c23  53                   push bx
04c24  e8 60 c6             call personnage_en_dx
04c27  5b                   pop bx
04c28  3c 01                cmp al, 1
04c2a  74 e6                je loc_4c12
04c2c  8a 87 de 43          mov al, byte ptr [bx + 0x43de]    ; teleports_salles_froides
04c30  88 45 03             mov byte ptr [di + 3], al
04c33  8b 8f df 43          mov cx, word ptr [bx + 0x43df]
04c37  89 4d 01             mov word ptr [di + 1], cx
04c3a  8b 97 e1 43          mov dx, word ptr [bx + 0x43e1]
04c3e  52                   push dx
04c3f  e8 c0 c9             call adresse_case
04c42  5a                   pop dx
04c43  80 c7 02             add bh, 2
04c46  89 5d 04             mov word ptr [di + 4], bx
04c49  89 1e 0f 0e          mov word ptr [0xe0f], bx    ; case_apres_porte
04c4d  89 16 ce 3f          mov word ptr [0x3fce], dx
04c51  e9 5c 22             jmp redessin_plateau
loc_4c54:
04c54  0a c0                or al, al
04c56  74 03                je loc_4c5b
04c58  e9 55 22             jmp redessin_plateau
loc_4c5b:
04c5b  a0 92 3f             mov al, byte ptr [0x3f92]    ; numero_quete
04c5e  3c 09                cmp al, 9
04c60  74 03                je loc_4c65
04c62  e9 4b 22             jmp redessin_plateau
loc_4c65:
04c65  e8 42 01             call tire_teleport
04c68  80 65 0f ef          and byte ptr [di + 0xf], 0xef
04c6c  88 45 03             mov byte ptr [di + 3], al
04c6f  8b 4f 01             mov cx, word ptr [bx + 1]
04c72  88 4d 01             mov byte ptr [di + 1], cl
04c75  88 6d 02             mov byte ptr [di + 2], ch
04c78  8a 57 03             mov dl, byte ptr [bx + 3]
04c7b  52                   push dx
04c7c  e8 83 c9             call adresse_case
04c7f  5a                   pop dx
04c80  81 c3 00 02          add bx, 0x200
04c84  89 5d 04             mov word ptr [di + 4], bx
04c87  89 1e 0f 0e          mov word ptr [0xe0f], bx    ; case_apres_porte
04c8b  b6 00                mov dh, 0
04c8d  03 da                add bx, dx
04c8f  80 0f 04             or byte ptr [bx], 4
04c92  89 1e ce 3f          mov word ptr [0x3fce], bx
04c96  c7 06 ea 3f 00 00    mov word ptr [0x3fea], 0    ; message_en_attente
04c9c  be 4a 4d             mov si, 0x4d4a    ; monstres
04c9f  8a 45 01             mov al, byte ptr [di + 1]
04ca2  8a 65 02             mov ah, byte ptr [di + 2]
04ca5  b9 20 00             mov cx, 0x20
loc_4ca8:
04ca8  80 3c 00             cmp byte ptr [si], 0
04cab  74 16                je loc_4cc3
04cad  3a 44 01             cmp al, byte ptr [si + 1]
04cb0  75 11                jne loc_4cc3
04cb2  3a 64 02             cmp ah, byte ptr [si + 2]
04cb5  75 0c                jne loc_4cc3
04cb7  c7 06 ea 3f d4 00    mov word ptr [0x3fea], 0xd4    ; message_en_attente
04cbd  e8 60 d4             call retire_monstre
04cc0  e9 ed 21             jmp redessin_plateau
loc_4cc3:
04cc3  83 c6 0a             add si, 0xa
04cc6  e2 e0                loop loc_4ca8
04cc8  b9 04 00             mov cx, 4
04ccb  be 63 46             mov si, 0x4663    ; fiches_personnages
loc_4cce:
04cce  3b f7                cmp si, di
04cd0  74 0d                je loc_4cdf
04cd2  3a 44 01             cmp al, byte ptr [si + 1]
04cd5  75 08                jne loc_4cdf
04cd7  3a 64 02             cmp ah, byte ptr [si + 2]
04cda  75 03                jne loc_4cdf
04cdc  eb 09                jmp loc_4ce7
; ---- 1 octets non atteints (4cde-4cde)
loc_4cdf:
04cdf  83 c6 1a             add si, 0x1a
04ce2  e2 ea                loop loc_4cce
04ce4  e9 c9 21             jmp redessin_plateau
loc_4ce7:
04ce7  80 7c 06 02          cmp byte ptr [si + 6], 2
04ceb  73 03                jae loc_4cf0
04ced  e9 75 ff             jmp loc_4c65
loc_4cf0:
04cf0  c7 06 ea 3f d6 00    mov word ptr [0x3fea], 0xd6    ; message_en_attente
04cf6  fe 4c 06             dec byte ptr [si + 6]
04cf9  8b fe                mov di, si
loc_4cfb:
04cfb  e8 ac 00             call tire_teleport
04cfe  b9 04 00             mov cx, 4
04d01  be 63 46             mov si, 0x4663    ; fiches_personnages
loc_4d04:
04d04  3a 44 03             cmp al, byte ptr [si + 3]
04d07  74 f2                je loc_4cfb
04d09  83 c6 1a             add si, 0x1a
04d0c  e2 f6                loop loc_4d04
04d0e  88 45 03             mov byte ptr [di + 3], al
04d11  8b 4f 01             mov cx, word ptr [bx + 1]
04d14  88 4d 01             mov byte ptr [di + 1], cl
04d17  88 6d 02             mov byte ptr [di + 2], ch
04d1a  8a 57 03             mov dl, byte ptr [bx + 3]
04d1d  52                   push dx
04d1e  e8 e1 c8             call adresse_case
04d21  81 c3 00 02          add bx, 0x200
04d25  89 5d 04             mov word ptr [di + 4], bx
04d28  89 1e 0f 0e          mov word ptr [0xe0f], bx    ; case_apres_porte
04d2c  5a                   pop dx
04d2d  b6 00                mov dh, 0
04d2f  03 da                add bx, dx
04d31  80 0f 04             or byte ptr [bx], 4
04d34  be 4a 4d             mov si, 0x4d4a    ; monstres
04d37  8a 45 01             mov al, byte ptr [di + 1]
04d3a  8a 65 02             mov ah, byte ptr [di + 2]
04d3d  b9 20 00             mov cx, 0x20
loc_4d40:
04d40  80 3c 00             cmp byte ptr [si], 0
04d43  74 10                je loc_4d55
04d45  3a 44 01             cmp al, byte ptr [si + 1]
04d48  75 0b                jne loc_4d55
04d4a  3a 64 02             cmp ah, byte ptr [si + 2]
04d4d  75 06                jne loc_4d55
04d4f  e8 ce d3             call retire_monstre
04d52  eb 06                jmp loc_4d5a
; ---- 1 octets non atteints (4d54-4d54)
loc_4d55:
04d55  83 c6 0a             add si, 0xa
04d58  e2 e6                loop loc_4d40
loc_4d5a:
04d5a  bb 6f 54             mov bx, 0x546f    ; grille_zones
04d5d  8a 45 03             mov al, byte ptr [di + 3]
04d60  b9 00 02             mov cx, 0x200
loc_4d63:
04d63  8a 27                mov ah, byte ptr [bx]
04d65  80 e4 3f             and ah, 0x3f
04d68  3a e0                cmp ah, al
04d6a  75 07                jne loc_4d73
04d6c  80 0f c0             or byte ptr [bx], 0xc0
04d6f  80 4f 01 40          or byte ptr [bx + 1], 0x40
loc_4d73:
04d73  43                   inc bx
04d74  e2 ed                loop loc_4d63
04d76  e9 37 21             jmp redessin_plateau
loc_4d79:
04d79  8a 2e 9b 40          mov ch, byte ptr [0x409b]
04d7d  a0 a7 3f             mov al, byte ptr [0x3fa7]    ; personnage_courant
04d80  02 c0                add al, al
04d82  02 c0                add al, al
04d84  02 c5                add al, ch
04d86  bb 20 3c             mov bx, 0x3c20
04d89  e8 4f 13             call mot_table
04d8c  89 54 0a             mov word ptr [si + 0xa], dx
04d8f  c6 04 02             mov byte ptr [si], 2
04d92  c6 06 98 3f 02       mov byte ptr [0x3f98], 2    ; pas_en_cours
04d97  c6 06 57 0e 01       mov byte ptr [0xe57], 1
04d9c  e9 63 d9             jmp vue_alignee
loc_4d9f:
04d9f  c6 06 c8 3f 00       mov byte ptr [0x3fc8], 0    ; pas_en_file
04da4  c6 06 cc 40 ff       mov byte ptr [0x40cc], 0xff    ; direction_pas
04da9  c3                   ret

; ======== tire_teleport   (appelée depuis 4c65, 4cfb)
; quête 10 : téléport tiré par deux dés (0-5 + 0-5) dans teleports_chateau, dont la zone diffère de l'octet +3 de la fiche DI
04daa  e8 86 12             call de6_moins_un
04dad  8a d3                mov dl, bl
04daf  e8 81 12             call de6_moins_un
04db2  02 d3                add dl, bl
04db4  02 d2                add dl, dl
04db6  02 d2                add dl, dl
04db8  b6 00                mov dh, 0
04dba  bb b2 43             mov bx, 0x43b2    ; teleports_chateau
04dbd  03 da                add bx, dx
04dbf  8a 07                mov al, byte ptr [bx]
04dc1  3a 45 03             cmp al, byte ptr [di + 3]
04dc4  74 e4                je tire_teleport
04dc6  c3                   ret

; ======== entre_piege   (appelée depuis 4957, 4a1e, 4ae4, 4baf)
; le héros entre sur une case de code < 0x37 : change le code, pose DS:3FC2, arrête le déplacement
04dc7  3c 37                cmp al, 0x37
04dc9  73 42                jae loc_4e0d
04dcb  50                   push ax
04dcc  e8 b8 c4             call personnage_en_dx
04dcf  3c 01                cmp al, 1
04dd1  74 2c                je loc_4dff
04dd3  58                   pop ax
04dd4  50                   push ax
04dd5  2c 32                sub al, 0x32
04dd7  32 e4                xor ah, ah
04dd9  d1 e0                shl ax, 1
04ddb  bd a6 45             mov bp, 0x45a6    ; pieges
04dde  03 e8                add bp, ax
04de0  3e 8a 46 00          mov al, byte ptr ds:[bp]
04de4  88 07                mov byte ptr [bx], al
04de6  3e 8a 46 01          mov al, byte ptr ds:[bp + 1]
04dea  a2 c2 3f             mov byte ptr [0x3fc2], al    ; piege_en_cours
04ded  8a 45 02             mov al, byte ptr [di + 2]
04df0  b2 1a                mov dl, 0x1a
04df2  f6 e2                mul dl
04df4  8a 5d 01             mov bl, byte ptr [di + 1]
04df7  32 ff                xor bh, bh
04df9  03 d8                add bx, ax
04dfb  89 1e ec 3f          mov word ptr [0x3fec], bx    ; case_piege
loc_4dff:
04dff  c6 06 c8 3f 00       mov byte ptr [0x3fc8], 0    ; pas_en_file
04e04  c7 06 cc 3f 00 00    mov word ptr [0x3fcc], 0    ; prochain_pas
04e0a  f9                   stc
04e0b  58                   pop ax
04e0c  c3                   ret
loc_4e0d:
04e0d  f8                   clc
04e0e  c3                   ret
; ---- 1 octets non atteints (4e0f-4e0f)

; ======== alloue_memoire   (appelée depuis 5f9f)
; réserve les segments graphiques (int 21h AH=48h), selon le mode vidéo
04e10  bb 48 3f             mov bx, 0x3f48
04e13  03 1e 90 31          add bx, word ptr [0x3190]    ; mode_video
04e17  ff 27                jmp word ptr [bx]
loc_4e19:
04e19  bb 9d 05             mov bx, 0x59d
04e1c  b4 48                mov ah, 0x48
04e1e  cd 21                int 0x21
04e20  73 01                jae loc_4e23
04e22  c3                   ret
loc_4e23:
04e23  a3 23 5e             mov word ptr [0x5e23], ax    ; seg_ecran
04e26  bb 00 0e             mov bx, 0xe00
04e29  b4 48                mov ah, 0x48
04e2b  cd 21                int 0x21
04e2d  73 01                jae loc_4e30
04e2f  c3                   ret
loc_4e30:
04e30  a3 25 5e             mov word ptr [0x5e25], ax    ; seg_shopsp
04e33  bb 56 06             mov bx, 0x656
04e36  b4 48                mov ah, 0x48
04e38  cd 21                int 0x21
04e3a  73 01                jae loc_4e3d
04e3c  c3                   ret
loc_4e3d:
04e3d  a3 2d 5e             mov word ptr [0x5e2d], ax    ; seg_odds
04e40  bb f4 0e             mov bx, 0xef4
04e43  b4 48                mov ah, 0x48
04e45  cd 21                int 0x21
04e47  73 01                jae loc_4e4a
04e49  c3                   ret
loc_4e4a:
04e4a  a3 27 5e             mov word ptr [0x5e27], ax    ; seg_annexe
04e4d  bb fa 0c             mov bx, 0xcfa
04e50  b4 48                mov ah, 0x48
04e52  cd 21                int 0x21
04e54  73 01                jae loc_4e57
04e56  c3                   ret
loc_4e57:
04e57  a3 29 5e             mov word ptr [0x5e29], ax    ; seg_monsters
04e5a  bb 30 0c             mov bx, 0xc30
04e5d  b4 48                mov ah, 0x48
04e5f  cd 21                int 0x21
04e61  73 01                jae loc_4e64
04e63  c3                   ret
loc_4e64:
04e64  a3 2b 5e             mov word ptr [0x5e2b], ax    ; seg_graphics
04e67  bb 65 04             mov bx, 0x465
04e6a  b4 48                mov ah, 0x48
04e6c  cd 21                int 0x21
04e6e  73 01                jae loc_4e71
04e70  c3                   ret
loc_4e71:
04e71  a3 2f 5e             mov word ptr [0x5e2f], ax    ; seg_furn_brut
04e74  bb 83 00             mov bx, 0x83
04e77  b4 48                mov ah, 0x48
04e79  cd 21                int 0x21
04e7b  73 01                jae loc_4e7e
04e7d  c3                   ret
loc_4e7e:
04e7e  a3 31 5e             mov word ptr [0x5e31], ax
04e81  bb a0 0f             mov bx, 0xfa0
04e84  b4 48                mov ah, 0x48
04e86  cd 21                int 0x21
04e88  73 01                jae loc_4e8b
04e8a  c3                   ret
loc_4e8b:
04e8b  a3 35 5e             mov word ptr [0x5e35], ax    ; seg_furn
04e8e  c3                   ret
loc_4e8f:
04e8f  bb 26 04             mov bx, 0x426
04e92  b4 48                mov ah, 0x48
04e94  cd 21                int 0x21
04e96  73 01                jae loc_4e99
04e98  c3                   ret
loc_4e99:
04e99  a3 23 5e             mov word ptr [0x5e23], ax    ; seg_ecran
04e9c  bb 00 07             mov bx, 0x700
04e9f  b4 48                mov ah, 0x48
04ea1  cd 21                int 0x21
04ea3  73 01                jae loc_4ea6
04ea5  c3                   ret
loc_4ea6:
04ea6  a3 25 5e             mov word ptr [0x5e25], ax    ; seg_shopsp
04ea9  bb 2b 03             mov bx, 0x32b
04eac  b4 48                mov ah, 0x48
04eae  cd 21                int 0x21
04eb0  73 01                jae loc_4eb3
04eb2  c3                   ret
loc_4eb3:
04eb3  a3 2d 5e             mov word ptr [0x5e2d], ax    ; seg_odds
04eb6  bb ca 08             mov bx, 0x8ca
04eb9  b4 48                mov ah, 0x48
04ebb  cd 21                int 0x21
04ebd  73 01                jae loc_4ec0
04ebf  c3                   ret
loc_4ec0:
04ec0  a3 27 5e             mov word ptr [0x5e27], ax    ; seg_annexe
04ec3  bb 7e 06             mov bx, 0x67e
04ec6  b4 48                mov ah, 0x48
04ec8  cd 21                int 0x21
04eca  73 01                jae loc_4ecd
04ecc  c3                   ret
loc_4ecd:
04ecd  a3 29 5e             mov word ptr [0x5e29], ax    ; seg_monsters
04ed0  bb 18 06             mov bx, 0x618
04ed3  b4 48                mov ah, 0x48
04ed5  cd 21                int 0x21
04ed7  73 01                jae loc_4eda
04ed9  c3                   ret
loc_4eda:
04eda  a3 2b 5e             mov word ptr [0x5e2b], ax    ; seg_graphics
04edd  bb 65 04             mov bx, 0x465
04ee0  b4 48                mov ah, 0x48
04ee2  cd 21                int 0x21
04ee4  73 01                jae loc_4ee7
04ee6  c3                   ret
loc_4ee7:
04ee7  a3 2f 5e             mov word ptr [0x5e2f], ax    ; seg_furn_brut
04eea  bb 83 00             mov bx, 0x83
04eed  b4 48                mov ah, 0x48
04eef  cd 21                int 0x21
04ef1  73 01                jae loc_4ef4
04ef3  c3                   ret
loc_4ef4:
04ef4  a3 31 5e             mov word ptr [0x5e31], ax
04ef7  bb 00 0a             mov bx, 0xa00    ; "AND TRY AGAIN"
04efa  b4 48                mov ah, 0x48
04efc  cd 21                int 0x21
04efe  73 01                jae loc_4f01
04f00  c3                   ret
loc_4f01:
04f01  a3 35 5e             mov word ptr [0x5e35], ax    ; seg_furn
04f04  c3                   ret

; ======== zone_cliquee   (appelée depuis 2d0b, 73d5, 7858, 8047, 81a4, 8f33, 92a0)
; si clic : numéro x 2 de la zone de la table SI sous le curseur, dans BX
04f05  80 3e 98 3f 02       cmp byte ptr [0x3f98], 2    ; pas_en_cours
04f0a  75 01                jne loc_4f0d
04f0c  c3                   ret
loc_4f0d:
04f0d  33 db                xor bx, bx
04f0f  f6 06 92 39 10       test byte ptr [0x3992], 0x10    ; commandes
04f14  75 01                jne loc_4f17
04f16  c3                   ret
loc_4f17:
04f17  e8 14 ea             call attend_clic

; ======== zone_sous_curseur   (appelée depuis 0889, 0cde, 0d1d, 825a, 8ed7, 91e8, 9265)
; même recherche sans attendre de clic
04f1a  bb 02 00             mov bx, 2
04f1d  8b 16 e7 47          mov dx, word ptr [0x47e7]
04f21  8b 2e e9 47          mov bp, word ptr [0x47e9]
loc_4f25:
04f25  83 3c ff             cmp word ptr [si], -1
04f28  75 01                jne loc_4f2b
04f2a  c3                   ret
loc_4f2b:
04f2b  3b 14                cmp dx, word ptr [si]
04f2d  72 10                jb loc_4f3f
04f2f  3b 6c 02             cmp bp, word ptr [si + 2]
04f32  72 0b                jb loc_4f3f
04f34  3b 54 04             cmp dx, word ptr [si + 4]
04f37  77 06                ja loc_4f3f
04f39  3b 6c 06             cmp bp, word ptr [si + 6]
04f3c  77 01                ja loc_4f3f
04f3e  c3                   ret
loc_4f3f:
04f3f  83 c6 08             add si, 8
04f42  83 c3 02             add bx, 2
04f45  eb de                jmp loc_4f25

; ======== affiche_deplacement   (appelée depuis 4fd1)
; deplacement_restant en chiffres (dizaine si supérieur à 9)
04f47  e8 bc db             call son_des
04f4a  bd 25 da             mov bp, 0xda25
04f4d  b0 01                mov al, 1
04f4f  80 3e 9c 3f 13       cmp byte ptr [0x3f9c], 0x13    ; deplacement_restant
04f54  76 02                jbe loc_4f58
04f56  fe c0                inc al
loc_4f58:
04f58  80 3e 9c 3f 09       cmp byte ptr [0x3f9c], 9    ; deplacement_restant
04f5d  76 03                jbe loc_4f62
04f5f  e8 12 00             call affiche_chiffre
loc_4f62:
04f62  a0 9c 3f             mov al, byte ptr [0x3f9c]    ; deplacement_restant
04f65  3c 0a                cmp al, 0xa
04f67  72 08                jb loc_4f71
04f69  2c 0a                sub al, 0xa
04f6b  3c 0a                cmp al, 0xa
04f6d  72 02                jb loc_4f71
04f6f  2c 0a                sub al, 0xa
loc_4f71:
04f71  bd 2d da             mov bp, 0xda2d

; ======== affiche_chiffre   (appelée depuis 4f5f)
; chiffre AL de 8 × 12 (ODDS&SOD 0x5960 + AL × 0x60) à la position BP
04f74  32 e4                xor ah, ah
04f76  ba 60 00             mov dx, 0x60
04f79  f7 e2                mul dx
04f7b  05 60 59             add ax, 0x5960
04f7e  8b f0                mov si, ax
04f80  8b fd                mov di, bp
04f82  a1 2d 5e             mov ax, word ptr [0x5e2d]    ; seg_odds
04f85  a3 4e 37             mov word ptr [0x374e], ax    ; segment_source
04f88  50                   push ax
04f89  b8 63 14             mov ax, 0x1463
04f8c  8e c0                mov es, ax
04f8e  58                   pop ax
04f8f  bd 08 00             mov bp, 8
04f92  b9 0c 00             mov cx, 0xc
04f95  1e                   push ds
04f96  e8 ba eb             call copie_image
04f99  1f                   pop ds
04f9a  c3                   ret

; ======== image_des   (appelée depuis 673f, 6759, 6763)
; image suivante (DS:4B6F, 0 à 3) de l'animation des dés, 32 × 32 en (157, 162) ; sur l'image 0, son_des et affiche_deplacement
04f9b  8a 1e 6f 4b          mov bl, byte ptr [0x4b6f]    ; image_des_courante
04f9f  32 ff                xor bh, bh
04fa1  03 db                add bx, bx
04fa3  81 c3 67 4b          add bx, 0x4b67    ; images_des
04fa7  8b 37                mov si, word ptr [bx]
04fa9  b9 20 00             mov cx, 0x20
04fac  bd 20 00             mov bp, 0x20
04faf  bf 1d cb             mov di, 0xcb1d
04fb2  1e                   push ds
04fb3  50                   push ax
04fb4  b8 63 14             mov ax, 0x1463
04fb7  8e c0                mov es, ax
04fb9  58                   pop ax
04fba  a1 2d 5e             mov ax, word ptr [0x5e2d]    ; seg_odds
04fbd  a3 4e 37             mov word ptr [0x374e], ax    ; segment_source
04fc0  c7 06 e9 37 00 00    mov word ptr [0x37e9], 0    ; erreur_fichier
04fc6  e8 8a eb             call copie_image
04fc9  1f                   pop ds
04fca  80 3e 6f 4b 00       cmp byte ptr [0x4b6f], 0    ; image_des_courante
04fcf  75 03                jne loc_4fd4
04fd1  e8 73 ff             call affiche_deplacement
loc_4fd4:
04fd4  e8 0d 11             call affiche_tampon
04fd7  e8 0a 00             call efface_des
04fda  fe 06 6f 4b          inc byte ptr [0x4b6f]    ; image_des_courante
04fde  80 26 6f 4b 03       and byte ptr [0x4b6f], 3    ; image_des_courante
04fe3  c3                   ret

; ======== efface_des   (appelée depuis 4fd7)
; restaure le fond 32 × 32 en (157, 162) (restaure_rect)
04fe4  bf 1d cb             mov di, 0xcb1d
04fe7  bd 20 00             mov bp, 0x20
04fea  b9 20 00             mov cx, 0x20
04fed  e9 44 13             jmp restaure_rect

; ======== boite_texte
; SI = ligne, colonne, largeur, nombre de lignes, puis le texte : efface_boite, puis une ligne de texte par rangée ; non appelée
04ff0  89 36 bd ab          mov word ptr [0xabbd], si
04ff4  bf c0 ab             mov di, 0xabc0
04ff7  8b 04                mov ax, word ptr [si]
04ff9  80 c4 03             add ah, 3
04ffc  89 05                mov word ptr [di], ax
04ffe  8a 44 02             mov al, byte ptr [si + 2]
05001  04 02                add al, 2
05003  32 e4                xor ah, ah
05005  89 45 04             mov word ptr [di + 4], ax
05008  8a 44 03             mov al, byte ptr [si + 3]
0500b  04 03                add al, 3
0500d  89 45 02             mov word ptr [di + 2], ax
05010  be c0 ab             mov si, 0xabc0
05013  e8 f1 f3             call efface_boite
05016  a1 c0 ab             mov ax, word ptr [0xabc0]
05019  04 02                add al, 2
0501b  80 c4 02             add ah, 2
0501e  bd c8 ab             mov bp, 0xabc8
05021  3e 89 46 01          mov word ptr ds:[bp + 1], ax
05025  8b 36 bd ab          mov si, word ptr [0xabbd]
05029  8b d6                mov dx, si
0502b  83 c2 04             add dx, 4
0502e  8a 4c 03             mov cl, byte ptr [si + 3]
05031  32 ed                xor ch, ch
loc_5033:
05033  51                   push cx
05034  8b 36 bd ab          mov si, word ptr [0xabbd]
05038  8a 4c 02             mov cl, byte ptr [si + 2]
0503b  8b f2                mov si, dx
0503d  50                   push ax
0503e  b8 7c 09             mov ax, 0x97c
05041  8e c0                mov es, ax
05043  58                   pop ax
05044  bf cb ab             mov di, 0xabcb
05047  f3 a4                rep movsb byte ptr es:[di], byte ptr [si]
05049  c6 05 00             mov byte ptr [di], 0
0504c  bd c8 ab             mov bp, 0xabc8
0504f  8b d6                mov dx, si
05051  9c                   pushf
05052  50                   push ax
05053  53                   push bx
05054  51                   push cx
05055  52                   push dx
05056  57                   push di
05057  56                   push si
05058  55                   push bp
05059  06                   push es
0505a  1e                   push ds
0505b  e8 1e e1             call affiche_texte
0505e  1f                   pop ds
0505f  07                   pop es
05060  5d                   pop bp
05061  5e                   pop si
05062  5f                   pop di
05063  5a                   pop dx
05064  59                   pop cx
05065  5b                   pop bx
05066  58                   pop ax
05067  9d                   popf
05068  3e fe 46 01          inc byte ptr ds:[bp + 1]
0506c  59                   pop cx
0506d  e2 c4                loop loc_5033
0506f  c3                   ret

; ======== charge_donnees   (appelée depuis 5fa5)
; charge le fichier de textes de la langue DS:3194, puis les graphismes
05070  c7 06 07 39 79 5f    mov word ptr [0x3907], 0x5f79    ; fichier_nom, "english.bin"
05076  e8 78 e6             call clavier_retire
loc_5079:
05079  c7 06 e9 37 00 00    mov word ptr [0x37e9], 0    ; erreur_fichier
0507f  e8 46 e9             call fichier_ouvre
05082  83 3e e9 37 00       cmp word ptr [0x37e9], 0    ; erreur_fichier
05087  75 03                jne loc_508c
05089  eb 0e                jmp loc_5099
; ---- 1 octets non atteints (508b-508b)
loc_508c:
0508c  ba c0 3e             mov dx, 0x3ec0
0508f  b4 09                mov ah, 9
05091  cd 21                int 0x21
05093  b4 00                mov ah, 0
05095  cd 16                int 0x16
05097  eb e0                jmp loc_5079
loc_5099:
05099  e8 78 e9             call fichier_ferme
0509c  8a 1e 94 31          mov bl, byte ptr [0x3194]    ; langue
050a0  32 ff                xor bh, bh
050a2  d1 e3                shl bx, 1
050a4  81 c3 6f 5f          add bx, 0x5f6f
050a8  8b 1f                mov bx, word ptr [bx]
050aa  89 1e 07 39          mov word ptr [0x3907], bx    ; fichier_nom
050ae  c7 06 03 39 00 00    mov word ptr [0x3903], 0    ; fichier_offset
050b4  b8 63 14             mov ax, 0x1463
050b7  a3 01 39             mov word ptr [0x3901], ax    ; fichier_segment
050ba  e8 c4 e8             call charge_fichier
050bd  b8 7c 09             mov ax, 0x97c
050c0  8e c0                mov es, ax
050c2  33 f6                xor si, si
050c4  bf c1 5f             mov di, 0x5fc1    ; textes
050c7  b8 63 14             mov ax, 0x1463
050ca  8e d8                mov ds, ax
050cc  b9 ff ff             mov cx, 0xffff
050cf  e8 ff f4             call lz_decompresse
050d2  50                   push ax
050d3  b8 7c 09             mov ax, 0x97c
050d6  8e d8                mov ds, ax
050d8  58                   pop ax
050d9  bb 3e 3f             mov bx, 0x3f3e
050dc  03 1e 90 31          add bx, word ptr [0x3190]    ; mode_video
050e0  ff 27                jmp word ptr [bx]
loc_50e2:
050e2  c7 06 07 39 59 5e    mov word ptr [0x3907], 0x5e59    ; fichier_nom, "odds&sod.vga"
050e8  c7 06 03 39 00 00    mov word ptr [0x3903], 0    ; fichier_offset
050ee  b8 63 14             mov ax, 0x1463
050f1  a3 01 39             mov word ptr [0x3901], ax    ; fichier_segment
050f4  e8 8a e8             call charge_fichier
050f7  a1 2d 5e             mov ax, word ptr [0x5e2d]    ; seg_odds
050fa  8e c0                mov es, ax
050fc  33 f6                xor si, si
050fe  bf 00 00             mov di, 0
05101  b8 63 14             mov ax, 0x1463
05104  8e d8                mov ds, ax
05106  b9 ff ff             mov cx, 0xffff
05109  e8 c5 f4             call lz_decompresse
0510c  50                   push ax
0510d  b8 7c 09             mov ax, 0x97c
05110  8e d8                mov ds, ax
05112  58                   pop ax
05113  c7 06 07 39 40 5e    mov word ptr [0x3907], 0x5e40    ; fichier_nom, "monsters.vga"
05119  c7 06 03 39 00 00    mov word ptr [0x3903], 0    ; fichier_offset
0511f  b8 63 14             mov ax, 0x1463
05122  a3 01 39             mov word ptr [0x3901], ax    ; fichier_segment
05125  e8 59 e8             call charge_fichier
05128  a1 29 5e             mov ax, word ptr [0x5e29]    ; seg_monsters
0512b  8e c0                mov es, ax
0512d  33 f6                xor si, si
0512f  bf 00 00             mov di, 0
05132  b8 63 14             mov ax, 0x1463
05135  8e d8                mov ds, ax
05137  b9 ff ff             mov cx, 0xffff
0513a  e8 94 f4             call lz_decompresse
0513d  50                   push ax
0513e  b8 7c 09             mov ax, 0x97c
05141  8e d8                mov ds, ax
05143  58                   pop ax
05144  c7 06 07 39 6f 5e    mov word ptr [0x3907], 0x5e6f    ; fichier_nom, "graphics.vga"
0514a  c7 06 03 39 00 00    mov word ptr [0x3903], 0    ; fichier_offset
05150  b8 63 14             mov ax, 0x1463
05153  a3 01 39             mov word ptr [0x3901], ax    ; fichier_segment
05156  e8 28 e8             call charge_fichier
05159  a1 2b 5e             mov ax, word ptr [0x5e2b]    ; seg_graphics
0515c  8e c0                mov es, ax
0515e  33 f6                xor si, si
05160  bf 00 00             mov di, 0
05163  b8 63 14             mov ax, 0x1463
05166  8e d8                mov ds, ax
05168  b9 ff ff             mov cx, 0xffff
0516b  e8 63 f4             call lz_decompresse
0516e  50                   push ax
0516f  b8 7c 09             mov ax, 0x97c
05172  8e d8                mov ds, ax
05174  58                   pop ax
05175  c7 06 07 39 7c 5e    mov word ptr [0x3907], 0x5e7c    ; fichier_nom, "furn.vga"
0517b  c7 06 03 39 00 00    mov word ptr [0x3903], 0    ; fichier_offset
05181  a1 2f 5e             mov ax, word ptr [0x5e2f]    ; seg_furn_brut
05184  a3 01 39             mov word ptr [0x3901], ax    ; fichier_segment
05187  e8 f7 e7             call charge_fichier
0518a  c3                   ret
loc_518b:
0518b  c7 06 07 39 f5 5e    mov word ptr [0x3907], 0x5ef5    ; fichier_nom, "odds&sod.ega"
05191  c7 06 03 39 00 00    mov word ptr [0x3903], 0    ; fichier_offset
05197  b8 63 14             mov ax, 0x1463
0519a  a3 01 39             mov word ptr [0x3901], ax    ; fichier_segment
0519d  e8 e1 e7             call charge_fichier
051a0  a1 2d 5e             mov ax, word ptr [0x5e2d]    ; seg_odds
051a3  8e c0                mov es, ax
051a5  33 f6                xor si, si
051a7  bf 00 00             mov di, 0
051aa  b8 63 14             mov ax, 0x1463
051ad  8e d8                mov ds, ax
051af  b9 ff ff             mov cx, 0xffff
051b2  e8 1c f4             call lz_decompresse
051b5  50                   push ax
051b6  b8 7c 09             mov ax, 0x97c
051b9  8e d8                mov ds, ax
051bb  58                   pop ax
051bc  c7 06 07 39 dc 5e    mov word ptr [0x3907], 0x5edc    ; fichier_nom, "monsters.ega"
051c2  c7 06 03 39 00 00    mov word ptr [0x3903], 0    ; fichier_offset
051c8  b8 63 14             mov ax, 0x1463
051cb  a3 01 39             mov word ptr [0x3901], ax    ; fichier_segment
051ce  e8 b0 e7             call charge_fichier
051d1  a1 29 5e             mov ax, word ptr [0x5e29]    ; seg_monsters
051d4  8e c0                mov es, ax
051d6  33 f6                xor si, si
051d8  bf 00 00             mov di, 0
051db  b8 63 14             mov ax, 0x1463
051de  8e d8                mov ds, ax
051e0  b9 ff ff             mov cx, 0xffff
051e3  e8 eb f3             call lz_decompresse
051e6  50                   push ax
051e7  b8 7c 09             mov ax, 0x97c
051ea  8e d8                mov ds, ax
051ec  58                   pop ax
051ed  c7 06 07 39 0b 5f    mov word ptr [0x3907], 0x5f0b    ; fichier_nom, "graphics.ega"
051f3  c7 06 03 39 00 00    mov word ptr [0x3903], 0    ; fichier_offset
051f9  b8 63 14             mov ax, 0x1463
051fc  a3 01 39             mov word ptr [0x3901], ax    ; fichier_segment
051ff  e8 7f e7             call charge_fichier
05202  a1 2b 5e             mov ax, word ptr [0x5e2b]    ; seg_graphics
05205  8e c0                mov es, ax
05207  33 f6                xor si, si
05209  bf 00 00             mov di, 0
0520c  b8 63 14             mov ax, 0x1463
0520f  8e d8                mov ds, ax
05211  b9 ff ff             mov cx, 0xffff
05214  e8 ba f3             call lz_decompresse
05217  50                   push ax
05218  b8 7c 09             mov ax, 0x97c
0521b  8e d8                mov ds, ax
0521d  58                   pop ax
0521e  c7 06 07 39 18 5f    mov word ptr [0x3907], 0x5f18    ; fichier_nom, "furn.ega"
05224  c7 06 03 39 00 00    mov word ptr [0x3903], 0    ; fichier_offset
0522a  a1 2f 5e             mov ax, word ptr [0x5e2f]    ; seg_furn_brut
0522d  a3 01 39             mov word ptr [0x3901], ax    ; fichier_segment
05230  e8 4e e7             call charge_fichier
05233  c3                   ret

; ======== dessine_icones   (appelée depuis 03ab, 03fb, 040d, 0437, 054b, 12ed, 1845)
; dessine les 11 ou 12 icônes du panneau selon leur état
05234  b9 0b 00             mov cx, 0xb
05237  81 3e 37 46 97 46    cmp word ptr [0x4637], 0x4697    ; fiche_heros_courant
0523d  72 01                jb loc_5240
0523f  41                   inc cx
loc_5240:
05240  be 77 42             mov si, 0x4277    ; icones_panneau
loc_5243:
05243  80 7c 06 ff          cmp byte ptr [si + 6], 0xff
05247  74 43                je loc_528c
05249  1e                   push ds
0524a  56                   push si
0524b  51                   push cx
0524c  a1 2d 5e             mov ax, word ptr [0x5e2d]    ; seg_odds
0524f  a3 4e 37             mov word ptr [0x374e], ax    ; segment_source
05252  8b 7c 08             mov di, word ptr [si + 8]
05255  32 ed                xor ch, ch
05257  8a 4c 04             mov cl, byte ptr [si + 4]
0525a  8b e9                mov bp, cx
0525c  8a 4c 05             mov cl, byte ptr [si + 5]
0525f  8b 54 0a             mov dx, word ptr [si + 0xa]
05262  8a 44 06             mov al, byte ptr [si + 6]
05265  80 7c 06 01          cmp byte ptr [si + 6], 1
05269  75 04                jne loc_526f
0526b  81 c2 00 18          add dx, 0x1800
loc_526f:
0526f  80 7c 06 1c          cmp byte ptr [si + 6], 0x1c
05273  75 04                jne loc_5279
05275  81 c2 00 0c          add dx, 0xc00
loc_5279:
05279  8b f2                mov si, dx
0527b  50                   push ax
0527c  b8 63 14             mov ax, 0x1463
0527f  8e c0                mov es, ax
05281  58                   pop ax
05282  e8 ce e8             call copie_image
05285  59                   pop cx
05286  5e                   pop si
05287  1f                   pop ds
05288  c6 44 07 00          mov byte ptr [si + 7], 0
loc_528c:
0528c  83 c6 0c             add si, 0xc
0528f  e2 b2                loop loc_5243
05291  c3                   ret

; ======== charge_ecran_menus   (appelée depuis 7327)
; BORDERED, SHOPSP, SHOPMP ; version VGA en 0x529B
05292  bb 2a 3f             mov bx, 0x3f2a
05295  03 1e 90 31          add bx, word ptr [0x3190]    ; mode_video
05299  ff 27                jmp word ptr [bx]
loc_529b:
0529b  c7 06 07 39 9b 5e    mov word ptr [0x3907], 0x5e9b    ; fichier_nom, "bordered.vga"
052a1  c7 06 03 39 00 00    mov word ptr [0x3903], 0    ; fichier_offset
052a7  a1 23 5e             mov ax, word ptr [0x5e23]    ; seg_ecran
052aa  a3 01 39             mov word ptr [0x3901], ax    ; fichier_segment
loc_52ad:
052ad  c7 06 e9 37 00 00    mov word ptr [0x37e9], 0    ; erreur_fichier
052b3  e8 3b e4             call clavier_retire
052b6  e8 0f e7             call fichier_ouvre
052b9  83 3e e9 37 00       cmp word ptr [0x37e9], 0    ; erreur_fichier
052be  75 03                jne loc_52c3
052c0  eb 0f                jmp loc_52d1
; ---- 1 octets non atteints (52c2-52c2)
loc_52c3:
052c3  e8 f4 e3             call clavier_installe
052c6  bb 50 02             mov bx, 0x250    ; message « INTRODUISEZ VOTRE / HEROQUEST DISQUETTE 2 »
052c9  e8 21 36             call affiche_message
052cc  e8 22 e4             call clavier_retire
052cf  eb dc                jmp loc_52ad
loc_52d1:
052d1  e8 28 e7             call fichier_lit
052d4  a3 05 39             mov word ptr [0x3905], ax    ; fichier_taille
052d7  83 3e e9 37 00       cmp word ptr [0x37e9], 0    ; erreur_fichier
052dc  75 e5                jne loc_52c3
052de  e8 d9 e3             call clavier_installe
052e1  c7 06 07 39 85 5e    mov word ptr [0x3907], 0x5e85    ; fichier_nom, "shopsp.vga"
052e7  c7 06 03 39 00 00    mov word ptr [0x3903], 0    ; fichier_offset
052ed  b8 63 14             mov ax, 0x1463
052f0  a3 01 39             mov word ptr [0x3901], ax    ; fichier_segment
loc_52f3:
052f3  c7 06 e9 37 00 00    mov word ptr [0x37e9], 0    ; erreur_fichier
052f9  e8 f5 e3             call clavier_retire
052fc  e8 c9 e6             call fichier_ouvre
052ff  83 3e e9 37 00       cmp word ptr [0x37e9], 0    ; erreur_fichier
05304  75 03                jne loc_5309
05306  eb 0f                jmp loc_5317
; ---- 1 octets non atteints (5308-5308)
loc_5309:
05309  e8 ae e3             call clavier_installe
0530c  bb 50 02             mov bx, 0x250    ; message « INTRODUISEZ VOTRE / HEROQUEST DISQUETTE 2 »
0530f  e8 db 35             call affiche_message
05312  e8 dc e3             call clavier_retire
05315  eb dc                jmp loc_52f3
loc_5317:
05317  e8 e2 e6             call fichier_lit
0531a  83 3e e9 37 00       cmp word ptr [0x37e9], 0    ; erreur_fichier
0531f  75 e8                jne loc_5309
05321  a3 05 39             mov word ptr [0x3905], ax    ; fichier_taille
05324  e8 93 e3             call clavier_installe
05327  a1 25 5e             mov ax, word ptr [0x5e25]    ; seg_shopsp
0532a  8e c0                mov es, ax
0532c  33 f6                xor si, si
0532e  bf 00 00             mov di, 0
05331  b8 63 14             mov ax, 0x1463
05334  8e d8                mov ds, ax
05336  b9 ff ff             mov cx, 0xffff
05339  e8 95 f2             call lz_decompresse
0533c  50                   push ax
0533d  b8 7c 09             mov ax, 0x97c
05340  8e d8                mov ds, ax
05342  58                   pop ax
05343  c7 06 07 39 90 5e    mov word ptr [0x3907], 0x5e90    ; fichier_nom, "shopmp.vga"
05349  c7 06 03 39 00 00    mov word ptr [0x3903], 0    ; fichier_offset
0534f  b8 63 14             mov ax, 0x1463
05352  a3 01 39             mov word ptr [0x3901], ax    ; fichier_segment
loc_5355:
05355  c7 06 e9 37 00 00    mov word ptr [0x37e9], 0    ; erreur_fichier
0535b  e8 93 e3             call clavier_retire
0535e  e8 67 e6             call fichier_ouvre
05361  83 3e e9 37 00       cmp word ptr [0x37e9], 0    ; erreur_fichier
05366  75 03                jne loc_536b
05368  eb 0f                jmp loc_5379
; ---- 1 octets non atteints (536a-536a)
loc_536b:
0536b  e8 4c e3             call clavier_installe
0536e  bb 50 02             mov bx, 0x250    ; message « INTRODUISEZ VOTRE / HEROQUEST DISQUETTE 2 »
05371  e8 79 35             call affiche_message
05374  e8 7a e3             call clavier_retire
05377  eb dc                jmp loc_5355
loc_5379:
05379  e8 80 e6             call fichier_lit
0537c  83 3e e9 37 00       cmp word ptr [0x37e9], 0    ; erreur_fichier
05381  75 e8                jne loc_536b
05383  a3 05 39             mov word ptr [0x3905], ax    ; fichier_taille
05386  e8 31 e3             call clavier_installe
05389  a1 27 5e             mov ax, word ptr [0x5e27]    ; seg_annexe
0538c  8e c0                mov es, ax
0538e  33 f6                xor si, si
05390  bf 00 00             mov di, 0
05393  b8 63 14             mov ax, 0x1463
05396  8e d8                mov ds, ax
05398  b9 ff ff             mov cx, 0xffff
0539b  e8 33 f2             call lz_decompresse
0539e  50                   push ax
0539f  b8 7c 09             mov ax, 0x97c
053a2  8e d8                mov ds, ax
053a4  58                   pop ax
053a5  c3                   ret
loc_53a6:
053a6  c7 06 07 39 37 5f    mov word ptr [0x3907], 0x5f37    ; fichier_nom, "bordered.ega"
053ac  c7 06 03 39 00 00    mov word ptr [0x3903], 0    ; fichier_offset
053b2  a1 23 5e             mov ax, word ptr [0x5e23]    ; seg_ecran
053b5  a3 01 39             mov word ptr [0x3901], ax    ; fichier_segment
loc_53b8:
053b8  c7 06 e9 37 00 00    mov word ptr [0x37e9], 0    ; erreur_fichier
053be  e8 30 e3             call clavier_retire
053c1  e8 04 e6             call fichier_ouvre
053c4  83 3e e9 37 00       cmp word ptr [0x37e9], 0    ; erreur_fichier
053c9  75 03                jne loc_53ce
053cb  eb 0f                jmp loc_53dc
; ---- 1 octets non atteints (53cd-53cd)
loc_53ce:
053ce  e8 e9 e2             call clavier_installe
053d1  bb 50 02             mov bx, 0x250    ; message « INTRODUISEZ VOTRE / HEROQUEST DISQUETTE 2 »
053d4  e8 16 35             call affiche_message
053d7  e8 17 e3             call clavier_retire
053da  eb dc                jmp loc_53b8
loc_53dc:
053dc  e8 1d e6             call fichier_lit
053df  a3 05 39             mov word ptr [0x3905], ax    ; fichier_taille
053e2  83 3e e9 37 00       cmp word ptr [0x37e9], 0    ; erreur_fichier
053e7  75 e5                jne loc_53ce
053e9  e8 ce e2             call clavier_installe
053ec  c7 06 07 39 21 5f    mov word ptr [0x3907], 0x5f21    ; fichier_nom, "shopsp.ega"
053f2  c7 06 03 39 00 00    mov word ptr [0x3903], 0    ; fichier_offset
053f8  b8 63 14             mov ax, 0x1463
053fb  a3 01 39             mov word ptr [0x3901], ax    ; fichier_segment
loc_53fe:
053fe  c7 06 e9 37 00 00    mov word ptr [0x37e9], 0    ; erreur_fichier
05404  e8 ea e2             call clavier_retire
05407  e8 be e5             call fichier_ouvre
0540a  83 3e e9 37 00       cmp word ptr [0x37e9], 0    ; erreur_fichier
0540f  75 03                jne loc_5414
05411  eb 0f                jmp loc_5422
; ---- 1 octets non atteints (5413-5413)
loc_5414:
05414  e8 a3 e2             call clavier_installe
05417  bb 50 02             mov bx, 0x250    ; message « INTRODUISEZ VOTRE / HEROQUEST DISQUETTE 2 »
0541a  e8 d0 34             call affiche_message
0541d  e8 d1 e2             call clavier_retire
05420  eb dc                jmp loc_53fe
loc_5422:
05422  e8 d7 e5             call fichier_lit
05425  83 3e e9 37 00       cmp word ptr [0x37e9], 0    ; erreur_fichier
0542a  75 e8                jne loc_5414
0542c  a3 05 39             mov word ptr [0x3905], ax    ; fichier_taille
0542f  e8 88 e2             call clavier_installe
05432  a1 25 5e             mov ax, word ptr [0x5e25]    ; seg_shopsp
05435  8e c0                mov es, ax
05437  33 f6                xor si, si
05439  bf 00 00             mov di, 0
0543c  b8 63 14             mov ax, 0x1463
0543f  8e d8                mov ds, ax
05441  b9 ff ff             mov cx, 0xffff
05444  e8 8a f1             call lz_decompresse
05447  50                   push ax
05448  b8 7c 09             mov ax, 0x97c
0544b  8e d8                mov ds, ax
0544d  58                   pop ax
0544e  c7 06 07 39 2c 5f    mov word ptr [0x3907], 0x5f2c    ; fichier_nom, "shopmp.ega"
05454  c7 06 03 39 00 00    mov word ptr [0x3903], 0    ; fichier_offset
0545a  b8 63 14             mov ax, 0x1463
0545d  a3 01 39             mov word ptr [0x3901], ax    ; fichier_segment
loc_5460:
05460  c7 06 e9 37 00 00    mov word ptr [0x37e9], 0    ; erreur_fichier
05466  e8 88 e2             call clavier_retire
05469  e8 5c e5             call fichier_ouvre
0546c  83 3e e9 37 00       cmp word ptr [0x37e9], 0    ; erreur_fichier
05471  75 03                jne loc_5476
05473  eb 0f                jmp loc_5484
; ---- 1 octets non atteints (5475-5475)
loc_5476:
05476  e8 41 e2             call clavier_installe
05479  bb 50 02             mov bx, 0x250    ; message « INTRODUISEZ VOTRE / HEROQUEST DISQUETTE 2 »
0547c  e8 6e 34             call affiche_message
0547f  e8 6f e2             call clavier_retire
05482  eb dc                jmp loc_5460
loc_5484:
05484  e8 75 e5             call fichier_lit
05487  83 3e e9 37 00       cmp word ptr [0x37e9], 0    ; erreur_fichier
0548c  75 e8                jne loc_5476
0548e  a3 05 39             mov word ptr [0x3905], ax    ; fichier_taille
05491  e8 26 e2             call clavier_installe
05494  a1 27 5e             mov ax, word ptr [0x5e27]    ; seg_annexe
05497  8e c0                mov es, ax
05499  33 f6                xor si, si
0549b  bf 00 00             mov di, 0
0549e  b8 63 14             mov ax, 0x1463
054a1  8e d8                mov ds, ax
054a3  b9 ff ff             mov cx, 0xffff
054a6  e8 28 f1             call lz_decompresse
054a9  50                   push ax
054aa  b8 7c 09             mov ax, 0x97c
054ad  8e d8                mov ds, ax
054af  58                   pop ax
054b0  c3                   ret

; ======== charge_ecran_plateau   (appelée depuis 0162)
; BOOK, MAPS, SPRITES ; version VGA en 0x54BA
054b1  bb 34 3f             mov bx, 0x3f34
054b4  03 1e 90 31          add bx, word ptr [0x3190]    ; mode_video
054b8  ff 27                jmp word ptr [bx]
loc_54ba:
054ba  c7 06 07 39 37 5e    mov word ptr [0x3907], 0x5e37    ; fichier_nom, "book.vga"
054c0  c7 06 03 39 00 00    mov word ptr [0x3903], 0    ; fichier_offset
054c6  a1 23 5e             mov ax, word ptr [0x5e23]    ; seg_ecran
054c9  a3 01 39             mov word ptr [0x3901], ax    ; fichier_segment
loc_54cc:
054cc  c7 06 e9 37 00 00    mov word ptr [0x37e9], 0    ; erreur_fichier
054d2  e8 1c e2             call clavier_retire
054d5  e8 f0 e4             call fichier_ouvre
054d8  83 3e e9 37 00       cmp word ptr [0x37e9], 0    ; erreur_fichier
054dd  75 03                jne loc_54e2
054df  eb 0f                jmp loc_54f0
; ---- 1 octets non atteints (54e1-54e1)
loc_54e2:
054e2  e8 d5 e1             call clavier_installe
054e5  bb 50 02             mov bx, 0x250    ; message « INTRODUISEZ VOTRE / HEROQUEST DISQUETTE 2 »
054e8  e8 02 34             call affiche_message
054eb  e8 03 e2             call clavier_retire
054ee  eb dc                jmp loc_54cc
loc_54f0:
054f0  e8 09 e5             call fichier_lit
054f3  a3 05 39             mov word ptr [0x3905], ax    ; fichier_taille
054f6  83 3e e9 37 00       cmp word ptr [0x37e9], 0    ; erreur_fichier
054fb  75 e5                jne loc_54e2
054fd  e8 ba e1             call clavier_installe
05500  c7 06 07 39 66 5e    mov word ptr [0x3907], 0x5e66    ; fichier_nom, "maps.vga"
05506  c7 06 03 39 00 00    mov word ptr [0x3903], 0    ; fichier_offset
0550c  b8 63 14             mov ax, 0x1463
0550f  a3 01 39             mov word ptr [0x3901], ax    ; fichier_segment
loc_5512:
05512  c7 06 e9 37 00 00    mov word ptr [0x37e9], 0    ; erreur_fichier
05518  e8 d6 e1             call clavier_retire
0551b  e8 aa e4             call fichier_ouvre
0551e  83 3e e9 37 00       cmp word ptr [0x37e9], 0    ; erreur_fichier
05523  75 03                jne loc_5528
05525  eb 0f                jmp loc_5536
; ---- 1 octets non atteints (5527-5527)
loc_5528:
05528  e8 8f e1             call clavier_installe
0552b  bb 52 02             mov bx, 0x252    ; message « INTRODUISEZ VOTRE / HEROQUEST DISQUETTE 3 »
0552e  e8 bc 33             call affiche_message
05531  e8 bd e1             call clavier_retire
05534  eb dc                jmp loc_5512
loc_5536:
05536  e8 c3 e4             call fichier_lit
05539  83 3e e9 37 00       cmp word ptr [0x37e9], 0    ; erreur_fichier
0553e  75 e8                jne loc_5528
05540  a3 05 39             mov word ptr [0x3905], ax    ; fichier_taille
05543  e8 74 e1             call clavier_installe
05546  a1 27 5e             mov ax, word ptr [0x5e27]    ; seg_annexe
05549  8e c0                mov es, ax
0554b  33 f6                xor si, si
0554d  bf 00 00             mov di, 0
05550  b8 63 14             mov ax, 0x1463
05553  8e d8                mov ds, ax
05555  b9 ff ff             mov cx, 0xffff
05558  e8 76 f0             call lz_decompresse
0555b  50                   push ax
0555c  b8 7c 09             mov ax, 0x97c
0555f  8e d8                mov ds, ax
05561  58                   pop ax
05562  c7 06 07 39 4d 5e    mov word ptr [0x3907], 0x5e4d    ; fichier_nom, "sprites.vga"
05568  c7 06 03 39 00 00    mov word ptr [0x3903], 0    ; fichier_offset
0556e  b8 63 14             mov ax, 0x1463
05571  a3 01 39             mov word ptr [0x3901], ax    ; fichier_segment
loc_5574:
05574  c7 06 e9 37 00 00    mov word ptr [0x37e9], 0    ; erreur_fichier
0557a  e8 74 e1             call clavier_retire
0557d  e8 48 e4             call fichier_ouvre
05580  83 3e e9 37 00       cmp word ptr [0x37e9], 0    ; erreur_fichier
05585  75 03                jne loc_558a
05587  eb 0f                jmp loc_5598
; ---- 1 octets non atteints (5589-5589)
loc_558a:
0558a  e8 2d e1             call clavier_installe
0558d  bb 52 02             mov bx, 0x252    ; message « INTRODUISEZ VOTRE / HEROQUEST DISQUETTE 3 »
05590  e8 5a 33             call affiche_message
05593  e8 5b e1             call clavier_retire
05596  eb dc                jmp loc_5574
loc_5598:
05598  e8 61 e4             call fichier_lit
0559b  83 3e e9 37 00       cmp word ptr [0x37e9], 0    ; erreur_fichier
055a0  75 e8                jne loc_558a
055a2  a3 05 39             mov word ptr [0x3905], ax    ; fichier_taille
055a5  e8 12 e1             call clavier_installe
055a8  a1 25 5e             mov ax, word ptr [0x5e25]    ; seg_shopsp
055ab  8e c0                mov es, ax
055ad  33 f6                xor si, si
055af  bf 00 00             mov di, 0
055b2  b8 63 14             mov ax, 0x1463
055b5  8e d8                mov ds, ax
055b7  b9 ff ff             mov cx, 0xffff
055ba  e8 14 f0             call lz_decompresse
055bd  50                   push ax
055be  b8 7c 09             mov ax, 0x97c
055c1  8e d8                mov ds, ax
055c3  58                   pop ax
055c4  c3                   ret
loc_55c5:
055c5  c7 06 07 39 d3 5e    mov word ptr [0x3907], 0x5ed3    ; fichier_nom, "book.ega"
055cb  c7 06 03 39 00 00    mov word ptr [0x3903], 0    ; fichier_offset
055d1  a1 23 5e             mov ax, word ptr [0x5e23]    ; seg_ecran
055d4  a3 01 39             mov word ptr [0x3901], ax    ; fichier_segment
loc_55d7:
055d7  c7 06 e9 37 00 00    mov word ptr [0x37e9], 0    ; erreur_fichier
055dd  e8 11 e1             call clavier_retire
055e0  e8 e5 e3             call fichier_ouvre
055e3  83 3e e9 37 00       cmp word ptr [0x37e9], 0    ; erreur_fichier
055e8  75 03                jne loc_55ed
055ea  eb 0f                jmp loc_55fb
; ---- 1 octets non atteints (55ec-55ec)
loc_55ed:
055ed  e8 ca e0             call clavier_installe
055f0  bb 50 02             mov bx, 0x250    ; message « INTRODUISEZ VOTRE / HEROQUEST DISQUETTE 2 »
055f3  e8 f7 32             call affiche_message
055f6  e8 f8 e0             call clavier_retire
055f9  eb dc                jmp loc_55d7
loc_55fb:
055fb  e8 fe e3             call fichier_lit
055fe  a3 05 39             mov word ptr [0x3905], ax    ; fichier_taille
05601  83 3e e9 37 00       cmp word ptr [0x37e9], 0    ; erreur_fichier
05606  75 e5                jne loc_55ed
05608  e8 af e0             call clavier_installe
0560b  c7 06 07 39 02 5f    mov word ptr [0x3907], 0x5f02    ; fichier_nom, "maps.ega"
05611  c7 06 03 39 00 00    mov word ptr [0x3903], 0    ; fichier_offset
05617  b8 63 14             mov ax, 0x1463
0561a  a3 01 39             mov word ptr [0x3901], ax    ; fichier_segment
loc_561d:
0561d  c7 06 e9 37 00 00    mov word ptr [0x37e9], 0    ; erreur_fichier
05623  e8 cb e0             call clavier_retire
05626  e8 9f e3             call fichier_ouvre
05629  83 3e e9 37 00       cmp word ptr [0x37e9], 0    ; erreur_fichier
0562e  75 03                jne loc_5633
05630  eb 0f                jmp loc_5641
; ---- 1 octets non atteints (5632-5632)
loc_5633:
05633  e8 84 e0             call clavier_installe
05636  bb 52 02             mov bx, 0x252    ; message « INTRODUISEZ VOTRE / HEROQUEST DISQUETTE 3 »
05639  e8 b1 32             call affiche_message
0563c  e8 b2 e0             call clavier_retire
0563f  eb dc                jmp loc_561d
loc_5641:
05641  e8 b8 e3             call fichier_lit
05644  83 3e e9 37 00       cmp word ptr [0x37e9], 0    ; erreur_fichier
05649  75 e8                jne loc_5633
0564b  a3 05 39             mov word ptr [0x3905], ax    ; fichier_taille
0564e  e8 69 e0             call clavier_installe
05651  a1 27 5e             mov ax, word ptr [0x5e27]    ; seg_annexe
05654  8e c0                mov es, ax
05656  33 f6                xor si, si
05658  bf 00 00             mov di, 0
0565b  b8 63 14             mov ax, 0x1463
0565e  8e d8                mov ds, ax
05660  b9 ff ff             mov cx, 0xffff
05663  e8 6b ef             call lz_decompresse
05666  50                   push ax
05667  b8 7c 09             mov ax, 0x97c
0566a  8e d8                mov ds, ax
0566c  58                   pop ax
0566d  c7 06 07 39 e9 5e    mov word ptr [0x3907], 0x5ee9    ; fichier_nom, "sprites.ega"
05673  c7 06 03 39 00 00    mov word ptr [0x3903], 0    ; fichier_offset
05679  b8 63 14             mov ax, 0x1463
0567c  a3 01 39             mov word ptr [0x3901], ax    ; fichier_segment
loc_567f:
0567f  c7 06 e9 37 00 00    mov word ptr [0x37e9], 0    ; erreur_fichier
05685  e8 69 e0             call clavier_retire
05688  e8 3d e3             call fichier_ouvre
0568b  83 3e e9 37 00       cmp word ptr [0x37e9], 0    ; erreur_fichier
05690  75 03                jne loc_5695
05692  eb 0f                jmp loc_56a3
; ---- 1 octets non atteints (5694-5694)
loc_5695:
05695  e8 22 e0             call clavier_installe
05698  bb 52 02             mov bx, 0x252    ; message « INTRODUISEZ VOTRE / HEROQUEST DISQUETTE 3 »
0569b  e8 4f 32             call affiche_message
0569e  e8 50 e0             call clavier_retire
056a1  eb dc                jmp loc_567f
loc_56a3:
056a3  e8 56 e3             call fichier_lit
056a6  83 3e e9 37 00       cmp word ptr [0x37e9], 0    ; erreur_fichier
056ab  75 e8                jne loc_5695
056ad  a3 05 39             mov word ptr [0x3905], ax    ; fichier_taille
056b0  e8 07 e0             call clavier_installe
056b3  a1 25 5e             mov ax, word ptr [0x5e25]    ; seg_shopsp
056b6  8e c0                mov es, ax
056b8  33 f6                xor si, si
056ba  bf 00 00             mov di, 0
056bd  b8 63 14             mov ax, 0x1463
056c0  8e d8                mov ds, ax
056c2  b9 ff ff             mov cx, 0xffff
056c5  e8 09 ef             call lz_decompresse
056c8  50                   push ax
056c9  b8 7c 09             mov ax, 0x97c
056cc  8e d8                mov ds, ax
056ce  58                   pop ax
056cf  c3                   ret

; ======== plateau_ciblage   (appelée depuis 0860, 0cb8, 21c1, 2ce2)
; dessine la carte (dessine_carte) ; curseur = viseur (image 0x2D20) ; si carte_cible, icône d'annulation en (224, 180) et transition affiche_tampon_rideau ; sauve et affiche le tampon
056d0  e8 2f 0b             call efface_tampon
056d3  be e5 47             mov si, 0x47e5    ; sprite_curseur
056d6  c7 44 0c 20 2d       mov word ptr [si + 0xc], 0x2d20
056db  c6 06 e9 3f 01       mov byte ptr [0x3fe9], 1    ; sans_sprites
056e0  e8 6d c3             call dessine_carte
056e3  80 3e 91 3f 00       cmp byte ptr [0x3f91], 0    ; carte_cible
056e8  74 21                je loc_570b
056ea  be 20 36             mov si, 0x3620
056ed  bf e0 e1             mov di, 0xe1e0
056f0  a1 2d 5e             mov ax, word ptr [0x5e2d]    ; seg_odds
056f3  a3 4e 37             mov word ptr [0x374e], ax    ; segment_source
056f6  50                   push ax
056f7  b8 63 14             mov ax, 0x1463
056fa  8e c0                mov es, ax
056fc  58                   pop ax
056fd  bd 10 00             mov bp, 0x10
05700  b9 10 00             mov cx, 0x10
05703  1e                   push ds
05704  e8 4c e4             call copie_image
05707  1f                   pop ds
05708  e8 60 0a             call affiche_tampon_rideau
loc_570b:
0570b  e8 61 0e             call sauve_tampon
0570e  e9 d3 09             jmp affiche_tampon

; ======== image_cible
; non appelée : image du monstre DS:3FD4 (type +8, table DS:45BA, MONSTERS)
05711  8b 1e d4 3f          mov bx, word ptr [0x3fd4]    ; cible
05715  bd fe 34             mov bp, 0x34fe
05718  8b 0e 29 5e          mov cx, word ptr [0x5e29]    ; seg_monsters
0571c  8a 47 08             mov al, byte ptr [bx + 8]
0571f  32 e4                xor ah, ah
05721  a3 eb 37             mov word ptr [0x37eb], ax    ; position_tuile_carte
05724  83 06 eb 37 05       add word ptr [0x37eb], 5    ; position_tuile_carte
05729  a3 ed 37             mov word ptr [0x37ed], ax    ; ligne_carte
0572c  83 06 ed 37 05       add word ptr [0x37ed], 5    ; ligne_carte
05731  bb ba 45             mov bx, 0x45ba
05734  eb 16                jmp loc_574c
; ---- 1 octets non atteints (5736-5736)

; ======== image_personnage
; non appelée (sa fin sert à image_par_table, morte aussi) : image du personnage courant (table DS:45B5, SHOPSP)
05737  8b 0e 25 5e          mov cx, word ptr [0x5e25]    ; seg_shopsp
0573b  a0 a7 3f             mov al, byte ptr [0x3fa7]    ; personnage_courant
0573e  32 e4                xor ah, ah
05740  a3 e9 37             mov word ptr [0x37e9], ax    ; erreur_fichier
05743  a3 ed 37             mov word ptr [0x37ed], ax    ; ligne_carte
05746  bd e6 3e             mov bp, 0x3ee6
05749  bb b5 45             mov bx, 0x45b5    ; "#/;GS"
loc_574c:
0574c  d7                   xlatb
0574d  89 0e 4e 37          mov word ptr [0x374e], cx    ; segment_source
05751  8a d8                mov bl, al
05753  b7 00                mov bh, 0
05755  03 db                add bx, bx
05757  03 db                add bx, bx
05759  8b b7 3a 4f          mov si, word ptr [bx + 0x4f3a]
0575d  8b 1e ed 37          mov bx, word ptr [0x37ed]    ; ligne_carte
05761  d1 e3                shl bx, 1
05763  8b bf fe 4e          mov di, word ptr [bx + 0x4efe]
05767  8b af c4 4e          mov bp, word ptr [bx + 0x4ec4]
0576b  8b 8f 8a 4e          mov cx, word ptr [bx + 0x4e8a]
0576f  50                   push ax
05770  b8 63 14             mov ax, 0x1463
05773  8e c0                mov es, ax
05775  58                   pop ax
05776  e9 da e3             jmp copie_image

; ======== ordonne_sprites   (appelée depuis 0431, 183c, 670c)
; remplit DS:4AB3 (90 mots, FFFFh) avec les sprites actifs, à la place 2 × octet +1 (ou la voisine si elle est prise) : ordre d'affichage
05779  bf b3 4a             mov di, 0x4ab3    ; ordre_sprites
0577c  50                   push ax
0577d  b8 7c 09             mov ax, 0x97c
05780  8e c0                mov es, ax
05782  58                   pop ax
05783  b9 5a 00             mov cx, 0x5a
05786  b8 ff ff             mov ax, 0xffff
05789  f3 ab                rep stosw word ptr es:[di], ax
0578b  be c6 4b             mov si, 0x4bc6    ; sprites
0578e  bf b3 4a             mov di, 0x4ab3    ; ordre_sprites
05791  b9 0e 00             mov cx, 0xe
loc_5794:
05794  80 3c 00             cmp byte ptr [si], 0
05797  74 19                je loc_57b2
05799  8a 5c 01             mov bl, byte ptr [si + 1]
0579c  d0 e3                shl bl, 1
0579e  32 ff                xor bh, bh
057a0  83 39 ff             cmp word ptr [bx + di], -1
057a3  74 0b                je loc_57b0
057a5  83 eb 02             sub bx, 2
057a8  83 39 ff             cmp word ptr [bx + di], -1
057ab  74 03                je loc_57b0
057ad  83 c3 04             add bx, 4
loc_57b0:
057b0  89 31                mov word ptr [bx + di], si
loc_57b2:
057b2  83 c6 17             add si, 0x17
057b5  e2 dd                loop loc_5794
057b7  c3                   ret

; ======== dessine_sprites   (appelée depuis 043a, 12f6, 1842, 6727, 6756, 89be)
; dessine les sprites dans l'ordre de DS:4AB3, sauf si sprites_figes
057b8  80 3e 99 3f 00       cmp byte ptr [0x3f99], 0    ; sprites_figes
057bd  74 01                je loc_57c0
057bf  c3                   ret
loc_57c0:
057c0  bb b3 4a             mov bx, 0x4ab3    ; ordre_sprites
057c3  b9 5a 00             mov cx, 0x5a
loc_57c6:
057c6  83 3f ff             cmp word ptr [bx], -1
057c9  75 06                jne loc_57d1
loc_57cb:
057cb  83 c3 02             add bx, 2
057ce  e2 f6                loop loc_57c6
057d0  c3                   ret
loc_57d1:
057d1  53                   push bx
057d2  51                   push cx
057d3  8b 37                mov si, word ptr [bx]
057d5  80 3c 00             cmp byte ptr [si], 0
057d8  74 03                je loc_57dd
057da  e8 04 00             call dessine_sprite
loc_57dd:
057dd  59                   pop cx
057de  5b                   pop bx
057df  eb ea                jmp loc_57cb

; ======== dessine_sprite   (appelée depuis 2031, 2076, 57da)
; copie_image du sprite SI : +6 largeur, +7 hauteur, +8 segment, +0Ch image, +10h position écran
057e1  8b 7c 10             mov di, word ptr [si + 0x10]
057e4  32 ed                xor ch, ch
057e6  8a 4c 06             mov cl, byte ptr [si + 6]
057e9  8b e9                mov bp, cx
057eb  8a 4c 07             mov cl, byte ptr [si + 7]
057ee  8b 5c 08             mov bx, word ptr [si + 8]
057f1  89 1e 4e 37          mov word ptr [0x374e], bx    ; segment_source
057f5  8a 44 16             mov al, byte ptr [si + 0x16]
057f8  a2 e9 37             mov byte ptr [0x37e9], al    ; erreur_fichier
057fb  8b 44 0c             mov ax, word ptr [si + 0xc]
057fe  56                   push si
057ff  8b f0                mov si, ax
05801  50                   push ax
05802  b8 63 14             mov ax, 0x1463
05805  8e c0                mov es, ax
05807  58                   pop ax
05808  e8 48 e3             call copie_image
0580b  50                   push ax
0580c  b8 7c 09             mov ax, 0x97c
0580f  8e d8                mov ds, ax
05811  58                   pop ax
05812  5e                   pop si
05813  c3                   ret

; ======== anime_sprites   (appelée depuis 0434, 12f3, 183f, 6703)
; anime_sprite sur les 14 sprites actifs, sauf si sprites_figes
05814  80 3e 99 3f 00       cmp byte ptr [0x3f99], 0    ; sprites_figes
05819  74 01                je loc_581c
0581b  c3                   ret
loc_581c:
0581c  be c6 4b             mov si, 0x4bc6    ; sprites
0581f  b9 0e 00             mov cx, 0xe
loc_5822:
05822  51                   push cx
05823  8a 04                mov al, byte ptr [si]
05825  0a c0                or al, al
05827  74 03                je loc_582c
05829  e8 0c 00             call anime_sprite
loc_582c:
0582c  83 c6 17             add si, 0x17
0582f  59                   pop cx
05830  e2 f0                loop loc_5822
05832  c3                   ret

; ======== anime_curseur
; anime_sprite appliqué à sprite_curseur ; non appelée
05833  be e5 47             mov si, 0x47e5    ; sprite_curseur
05836  8a 04                mov al, byte ptr [si]

; ======== anime_sprite   (appelée depuis 14f8, 5829)
; sprite SI d'état 2 : son_pas, image suivante du script +0Ah (FCh fige, FDh désactive, FEh saut, FFh dx dy), puis recalcule +10h et +16h
05838  3c 02                cmp al, 2
0583a  74 03                je loc_583f
0583c  eb 62                jmp loc_58a0
; ---- 1 octets non atteints (583e-583e)
loc_583f:
0583f  e8 b7 d0             call son_pas
05842  8b 7c 0a             mov di, word ptr [si + 0xa]
05845  8a 05                mov al, byte ptr [di]
05847  8b 5c 12             mov bx, word ptr [si + 0x12]
0584a  88 07                mov byte ptr [bx], al
0584c  8a d8                mov bl, al
0584e  b7 00                mov bh, 0
05850  03 db                add bx, bx
05852  03 db                add bx, bx
05854  81 c3 38 4f          add bx, 0x4f38    ; images_personnages
05858  8b 07                mov ax, word ptr [bx]
0585a  89 44 06             mov word ptr [si + 6], ax
0585d  8b 47 02             mov ax, word ptr [bx + 2]
05860  89 44 0c             mov word ptr [si + 0xc], ax
05863  47                   inc di
05864  8a 05                mov al, byte ptr [di]
05866  3c fc                cmp al, 0xfc
05868  72 33                jb loc_589d
0586a  75 05                jne loc_5871
0586c  c6 04 01             mov byte ptr [si], 1
0586f  eb 2f                jmp loc_58a0
loc_5871:
05871  3c fd                cmp al, 0xfd
05873  75 04                jne loc_5879
05875  c6 04 00             mov byte ptr [si], 0
05878  c3                   ret
loc_5879:
05879  3c fe                cmp al, 0xfe
0587b  75 0b                jne loc_5888
0587d  8b 45 01             mov ax, word ptr [di + 1]
05880  89 44 0a             mov word ptr [si + 0xa], ax
05883  83 c7 02             add di, 2
05886  eb 18                jmp loc_58a0
loc_5888:
05888  8b 45 01             mov ax, word ptr [di + 1]
0588b  8a cc                mov cl, ah
0588d  98                   cwde
0588e  03 44 02             add ax, word ptr [si + 2]
05891  89 44 02             mov word ptr [si + 2], ax
05894  02 4c 04             add cl, byte ptr [si + 4]
05897  88 4c 04             mov byte ptr [si + 4], cl
0589a  83 c7 03             add di, 3
loc_589d:
0589d  89 7c 0a             mov word ptr [si + 0xa], di
loc_58a0:
058a0  8a 44 04             mov al, byte ptr [si + 4]
058a3  32 e4                xor ah, ah
058a5  8b 5c 02             mov bx, word ptr [si + 2]
058a8  83 c3 0c             add bx, 0xc
058ab  e8 c6 d8             call ligne_ecran
058ae  88 44 16             mov byte ptr [si + 0x16], al
058b1  89 5c 10             mov word ptr [si + 0x10], bx
058b4  c3                   ret

; ======== restaure_tampon   (appelée depuis 0459, 6742)
; inverse de sauve_tampon : recopie le segment DS:5E35 dans le tampon (64 000 octets en VGA, 32 000 sinon)
058b5  50                   push ax
058b6  b8 63 14             mov ax, 0x1463
058b9  8e c0                mov es, ax
058bb  58                   pop ax
058bc  b9 00 7d             mov cx, 0x7d00
058bf  83 3e 90 31 08       cmp word ptr [0x3190], 8    ; mode_video
058c4  74 02                je loc_58c8
058c6  d1 e9                shr cx, 1
loc_58c8:
058c8  50                   push ax
058c9  a1 35 5e             mov ax, word ptr [0x5e35]    ; seg_furn
058cc  8e d8                mov ds, ax
058ce  58                   pop ax
058cf  bf 00 00             mov di, 0
058d2  be 00 00             mov si, 0
058d5  f3 a5                rep movsw word ptr es:[di], word ptr [si]
058d7  50                   push ax
058d8  b8 7c 09             mov ax, 0x97c
058db  8e d8                mov ds, ax
058dd  58                   pop ax
058de  c3                   ret

; ======== sprite_libre   (appelée depuis 0634, 0668, 13db, 1423)
; AX = nombre de sprites actifs consécutifs à partir du 5e (DS:4C22), c'est-à-dire le rang du premier libre
058df  33 c0                xor ax, ax
058e1  be 22 4c             mov si, 0x4c22
058e4  b9 0d 00             mov cx, 0xd
loc_58e7:
058e7  80 3c 00             cmp byte ptr [si], 0
058ea  75 01                jne loc_58ed
058ec  c3                   ret
loc_58ed:
058ed  83 c6 17             add si, 0x17
058f0  40                   inc ax
058f1  e2 f4                loop loc_58e7
058f3  c3                   ret

; ======== fleches_deplacement   (appelée depuis 0407, 043d)
; état des 4 flèches (icônes DS:42BF) : 0Bh si le pas est possible (bord, mur sauf traversée de la roche, porte fermée ou secrète, occupant 0 ou 32h-3Fh), 1 sinon
058f4  8b 3e 37 46          mov di, word ptr [0x4637]    ; fiche_heros_courant
058f8  bd 00 00             mov bp, 0
058fb  80 3e 9c 3f 00       cmp byte ptr [0x3f9c], 0    ; deplacement_restant
05900  75 03                jne loc_5905
05902  e9 51 01             jmp loc_5a56
loc_5905:
05905  f6 06 9b 3f 04       test byte ptr [0x3f9b], 4    ; etat_action
0590a  74 03                je loc_590f
0590c  e9 47 01             jmp loc_5a56
loc_590f:
0590f  80 7d 02 00          cmp byte ptr [di + 2], 0
05913  75 03                jne loc_5918
05915  eb 4b                jmp loc_5962
; ---- 1 octets non atteints (5917-5917)
loc_5918:
05918  8b 5d 04             mov bx, word ptr [di + 4]
0591b  f6 07 80             test byte ptr [bx], 0x80
0591e  74 14                je loc_5934
05920  f6 45 18 20          test byte ptr [di + 0x18], 0x20
05924  75 03                jne loc_5929
05926  eb 3a                jmp loc_5962
; ---- 1 octets non atteints (5928-5928)
loc_5929:
05929  8a 87 e6 fd          mov al, byte ptr [bx - 0x21a]
0592d  24 3f                and al, 0x3f
0592f  75 03                jne loc_5934
05931  eb 2f                jmp loc_5962
; ---- 1 octets non atteints (5933-5933)
loc_5934:
05934  f6 07 20             test byte ptr [bx], 0x20
05937  74 0d                je loc_5946
05939  f6 07 04             test byte ptr [bx], 4
0593c  75 08                jne loc_5946
0593e  f6 07 08             test byte ptr [bx], 8
05941  74 03                je loc_5946
05943  eb 1d                jmp loc_5962
; ---- 1 octets non atteints (5945-5945)
loc_5946:
05946  83 eb 1a             sub bx, 0x1a
05949  8a 87 00 02          mov al, byte ptr [bx + 0x200]
0594d  0a c0                or al, al
0594f  74 0e                je loc_595f
05951  3c 32                cmp al, 0x32
05953  73 03                jae loc_5958
05955  eb 0b                jmp loc_5962
; ---- 1 octets non atteints (5957-5957)
loc_5958:
05958  3c 40                cmp al, 0x40
0595a  72 03                jb loc_595f
0595c  eb 04                jmp loc_5962
; ---- 1 octets non atteints (595e-595e)
loc_595f:
0595f  83 cd 02             or bp, 2
loc_5962:
05962  80 7d 01 19          cmp byte ptr [di + 1], 0x19
05966  75 03                jne loc_596b
05968  eb 49                jmp loc_59b3
; ---- 1 octets non atteints (596a-596a)
loc_596b:
0596b  8b 5d 04             mov bx, word ptr [di + 4]
0596e  43                   inc bx
0596f  f6 07 40             test byte ptr [bx], 0x40
05972  74 14                je loc_5988
05974  f6 45 18 20          test byte ptr [di + 0x18], 0x20
05978  75 03                jne loc_597d
0597a  eb 37                jmp loc_59b3
; ---- 1 octets non atteints (597c-597c)
loc_597d:
0597d  8a 87 00 fe          mov al, byte ptr [bx - 0x200]
05981  24 3f                and al, 0x3f
05983  75 03                jne loc_5988
05985  eb 2c                jmp loc_59b3
; ---- 1 octets non atteints (5987-5987)
loc_5988:
05988  f6 07 10             test byte ptr [bx], 0x10
0598b  74 0d                je loc_599a
0598d  f6 07 04             test byte ptr [bx], 4
05990  75 08                jne loc_599a
05992  f6 07 08             test byte ptr [bx], 8
05995  74 03                je loc_599a
05997  eb 1a                jmp loc_59b3
; ---- 1 octets non atteints (5999-5999)
loc_599a:
0599a  8a 87 00 02          mov al, byte ptr [bx + 0x200]
0599e  0a c0                or al, al
059a0  74 0e                je loc_59b0
059a2  3c 32                cmp al, 0x32
059a4  73 03                jae loc_59a9
059a6  eb 0b                jmp loc_59b3
; ---- 1 octets non atteints (59a8-59a8)
loc_59a9:
059a9  3c 40                cmp al, 0x40
059ab  72 03                jb loc_59b0
059ad  eb 04                jmp loc_59b3
; ---- 1 octets non atteints (59af-59af)
loc_59b0:
059b0  83 cd 08             or bp, 8
loc_59b3:
059b3  80 7d 01 00          cmp byte ptr [di + 1], 0
059b7  75 03                jne loc_59bc
059b9  eb 48                jmp loc_5a03
; ---- 1 octets non atteints (59bb-59bb)
loc_59bc:
059bc  8b 5d 04             mov bx, word ptr [di + 4]
059bf  f6 07 40             test byte ptr [bx], 0x40
059c2  74 14                je loc_59d8
059c4  f6 45 18 20          test byte ptr [di + 0x18], 0x20
059c8  75 03                jne loc_59cd
059ca  eb 37                jmp loc_5a03
; ---- 1 octets non atteints (59cc-59cc)
loc_59cd:
059cd  8a 87 ff fd          mov al, byte ptr [bx - 0x201]
059d1  24 3f                and al, 0x3f
059d3  75 03                jne loc_59d8
059d5  eb 2c                jmp loc_5a03
; ---- 1 octets non atteints (59d7-59d7)
loc_59d8:
059d8  f6 07 10             test byte ptr [bx], 0x10
059db  74 0d                je loc_59ea
059dd  f6 07 04             test byte ptr [bx], 4
059e0  75 08                jne loc_59ea
059e2  f6 07 08             test byte ptr [bx], 8
059e5  74 03                je loc_59ea
059e7  eb 1a                jmp loc_5a03
; ---- 1 octets non atteints (59e9-59e9)
loc_59ea:
059ea  8a 87 ff 01          mov al, byte ptr [bx + 0x1ff]
059ee  0a c0                or al, al
059f0  74 0e                je loc_5a00
059f2  3c 32                cmp al, 0x32
059f4  73 03                jae loc_59f9
059f6  eb 0b                jmp loc_5a03
; ---- 1 octets non atteints (59f8-59f8)
loc_59f9:
059f9  3c 40                cmp al, 0x40
059fb  72 03                jb loc_5a00
059fd  eb 04                jmp loc_5a03
; ---- 1 octets non atteints (59ff-59ff)
loc_5a00:
05a00  83 cd 01             or bp, 1
loc_5a03:
05a03  80 7d 02 12          cmp byte ptr [di + 2], 0x12
05a07  75 03                jne loc_5a0c
05a09  eb 4b                jmp loc_5a56
; ---- 1 octets non atteints (5a0b-5a0b)
loc_5a0c:
05a0c  8b 5d 04             mov bx, word ptr [di + 4]
05a0f  83 c3 1a             add bx, 0x1a
05a12  f6 07 80             test byte ptr [bx], 0x80
05a15  74 14                je loc_5a2b
05a17  f6 45 18 20          test byte ptr [di + 0x18], 0x20
05a1b  75 03                jne loc_5a20
05a1d  eb 37                jmp loc_5a56
; ---- 1 octets non atteints (5a1f-5a1f)
loc_5a20:
05a20  8a 87 00 fe          mov al, byte ptr [bx - 0x200]
05a24  24 3f                and al, 0x3f
05a26  75 03                jne loc_5a2b
05a28  eb 2c                jmp loc_5a56
; ---- 1 octets non atteints (5a2a-5a2a)
loc_5a2b:
05a2b  f6 07 20             test byte ptr [bx], 0x20
05a2e  74 0d                je loc_5a3d
05a30  f6 07 04             test byte ptr [bx], 4
05a33  75 08                jne loc_5a3d
05a35  f6 07 08             test byte ptr [bx], 8
05a38  74 03                je loc_5a3d
05a3a  eb 1a                jmp loc_5a56
; ---- 1 octets non atteints (5a3c-5a3c)
loc_5a3d:
05a3d  8a 87 00 02          mov al, byte ptr [bx + 0x200]
05a41  0a c0                or al, al
05a43  74 0e                je loc_5a53
05a45  3c 32                cmp al, 0x32
05a47  73 03                jae loc_5a4c
05a49  eb 0b                jmp loc_5a56
; ---- 1 octets non atteints (5a4b-5a4b)
loc_5a4c:
05a4c  3c 40                cmp al, 0x40
05a4e  72 03                jb loc_5a53
05a50  eb 04                jmp loc_5a56
; ---- 1 octets non atteints (5a52-5a52)
loc_5a53:
05a53  83 cd 04             or bp, 4
loc_5a56:
05a56  bf bf 42             mov di, 0x42bf
05a59  b9 04 00             mov cx, 4
loc_5a5c:
05a5c  c6 45 07 01          mov byte ptr [di + 7], 1
05a60  c6 45 06 01          mov byte ptr [di + 6], 1
05a64  d1 ed                shr bp, 1
05a66  73 04                jae loc_5a6c
05a68  c6 45 06 0b          mov byte ptr [di + 6], 0xb
loc_5a6c:
05a6c  83 c7 0c             add di, 0xc
05a6f  e2 eb                loop loc_5a5c
05a71  c3                   ret

; ======== fleches_grisees
; les 4 flèches à l'état 1 ; non appelée
05a72  bf bf 42             mov di, 0x42bf
05a75  b9 04 00             mov cx, 4
05a78  b0 01                mov al, 1
05a7a  eb 35                jmp icones_etat
; ---- 1 octets non atteints (5a7c-5a7c)

; ======== icones_actives   (appelée depuis 03a8, 03f8)
; toutes les icônes à l'état 1 ; sorts cachés pour barbare, nain et 5e personnage
05a7d  bf 77 42             mov di, 0x4277    ; icones_panneau
05a80  c6 06 01 43 fe       mov byte ptr [0x4301], 0xfe
05a85  81 3e 37 46 7d 46    cmp word ptr [0x4637], 0x467d    ; fiche_heros_courant
05a8b  75 05                jne loc_5a92
05a8d  c6 06 01 43 ff       mov byte ptr [0x4301], 0xff
loc_5a92:
05a92  81 3e 37 46 63 46    cmp word ptr [0x4637], 0x4663    ; fiche_heros_courant, fiches_personnages
05a98  75 05                jne loc_5a9f
05a9a  c6 06 01 43 ff       mov byte ptr [0x4301], 0xff
loc_5a9f:
05a9f  81 3e 37 46 cb 46    cmp word ptr [0x4637], 0x46cb    ; fiche_heros_courant
05aa5  75 05                jne loc_5aac
05aa7  c6 06 01 43 ff       mov byte ptr [0x4301], 0xff
loc_5aac:
05aac  b9 0c 00             mov cx, 0xc
05aaf  b0 01                mov al, 1

; ======== icones_etat   (appelée depuis 5ae1)
; met CX icônes à partir de DI à l'état AL, à redessiner
05ab1  c6 45 07 01          mov byte ptr [di + 7], 1
05ab5  88 45 06             mov byte ptr [di + 6], al
05ab8  83 c7 0c             add di, 0xc
05abb  e2 f4                loop icones_etat
05abd  c3                   ret

; ======== icones_init   (appelée depuis 0399, 0404)
05abe  bf 77 42             mov di, 0x4277    ; icones_panneau
05ac1  b9 0c 00             mov cx, 0xc
05ac4  81 3e 37 46 7d 46    cmp word ptr [0x4637], 0x467d    ; fiche_heros_courant
05aca  75 01                jne loc_5acd
05acc  49                   dec cx
loc_5acd:
05acd  81 3e 37 46 63 46    cmp word ptr [0x4637], 0x4663    ; fiche_heros_courant, fiches_personnages
05ad3  75 01                jne loc_5ad6
05ad5  49                   dec cx
loc_5ad6:
05ad6  81 3e 37 46 cb 46    cmp word ptr [0x4637], 0x46cb    ; fiche_heros_courant
05adc  75 01                jne loc_5adf
05ade  49                   dec cx
loc_5adf:
05adf  b0 0b                mov al, 0xb
05ae1  e8 cd ff             call icones_etat

; ======== icones_selon_situation   (appelée depuis 0440)
; grise les fouilles si un monstre réveillé est dans la zone, etc.
05ae4  c6 06 ae 42 01       mov byte ptr [0x42ae], 1
05ae9  c6 06 f6 42 01       mov byte ptr [0x42f6], 1
05aee  c6 06 02 43 01       mov byte ptr [0x4302], 1
05af3  c6 06 ba 42 01       mov byte ptr [0x42ba], 1
05af8  c6 06 8a 42 01       mov byte ptr [0x428a], 1
05afd  f6 06 9b 3f 02       test byte ptr [0x3f9b], 2    ; etat_action
05b02  74 35                je loc_5b39
05b04  c6 06 ad 42 01       mov byte ptr [0x42ad], 1
05b09  c6 06 f5 42 01       mov byte ptr [0x42f5], 1
05b0e  80 3e 01 43 ff       cmp byte ptr [0x4301], 0xff
05b13  74 11                je loc_5b26
05b15  80 3e 2c 40 01       cmp byte ptr [0x402c], 1
05b1a  74 05                je loc_5b21
05b1c  c6 06 01 43 01       mov byte ptr [0x4301], 1
loc_5b21:
05b21  c6 06 89 42 01       mov byte ptr [0x4289], 1
loc_5b26:
05b26  8b 3e 37 46          mov di, word ptr [0x4637]    ; fiche_heros_courant
05b2a  f6 06 9b 3f 08       test byte ptr [0x3f9b], 8    ; etat_action
05b2f  75 05                jne loc_5b36
05b31  c6 06 89 42 0b       mov byte ptr [0x4289], 0xb
loc_5b36:
05b36  eb 2f                jmp loc_5b67
; ---- 1 octets non atteints (5b38-5b38)
loc_5b39:
05b39  c6 06 ad 42 0b       mov byte ptr [0x42ad], 0xb
05b3e  c6 06 f5 42 0b       mov byte ptr [0x42f5], 0xb
05b43  bb 4a 4d             mov bx, 0x4d4a    ; monstres
05b46  b1 20                mov cl, 0x20
05b48  32 ed                xor ch, ch
05b4a  a0 94 3f             mov al, byte ptr [0x3f94]    ; zone_heros
loc_5b4d:
05b4d  38 47 03             cmp byte ptr [bx + 3], al
05b50  75 10                jne loc_5b62
05b52  80 7f 06 00          cmp byte ptr [bx + 6], 0
05b56  74 0a                je loc_5b62
05b58  c6 06 ad 42 01       mov byte ptr [0x42ad], 1
05b5d  c6 06 f5 42 01       mov byte ptr [0x42f5], 1
loc_5b62:
05b62  83 c3 0a             add bx, 0xa
05b65  e2 e6                loop loc_5b4d
loc_5b67:
05b67  80 3e a7 3f 04       cmp byte ptr [0x3fa7], 4    ; personnage_courant
05b6c  75 1e                jne loc_5b8c
05b6e  c6 06 89 42 ff       mov byte ptr [0x4289], 0xff
05b73  c6 06 95 42 ff       mov byte ptr [0x4295], 0xff
05b78  c6 06 f5 42 ff       mov byte ptr [0x42f5], 0xff
05b7d  c6 06 ad 42 ff       mov byte ptr [0x42ad], 0xff
05b82  c6 06 b9 42 ff       mov byte ptr [0x42b9], 0xff
05b87  c6 06 01 43 ff       mov byte ptr [0x4301], 0xff
loc_5b8c:
05b8c  c3                   ret

; ======== bords_zone   (appelée depuis 0607)
; case DS:3FDE en cours de dessin : liseré 16 × 6 (ODDS&SOD, table DS:4101) sur chaque côté sans mur ni porte qui donne sur une autre zone non nulle, sauf si la voisine porte un éboulis (30h)
05b8d  33 ed                xor bp, bp
05b8f  8b 1e de 3f          mov bx, word ptr [0x3fde]    ; case_dessinee
05b93  81 fb 89 56          cmp bx, 0x5689
05b97  72 1f                jb loc_5bb8
05b99  f6 07 a0             test byte ptr [bx], 0xa0
05b9c  75 1a                jne loc_5bb8
05b9e  8a 87 e6 fd          mov al, byte ptr [bx - 0x21a]
05ba2  24 3f                and al, 0x3f
05ba4  3a 06 94 3f          cmp al, byte ptr [0x3f94]    ; zone_heros
05ba8  74 0e                je loc_5bb8
05baa  0a c0                or al, al
05bac  74 0a                je loc_5bb8
05bae  80 bf e6 01 30       cmp byte ptr [bx + 0x1e6], 0x30
05bb3  74 03                je loc_5bb8
05bb5  83 cd 02             or bp, 2
loc_5bb8:
05bb8  f6 07 50             test byte ptr [bx], 0x50
05bbb  75 1a                jne loc_5bd7
05bbd  8a 87 ff fd          mov al, byte ptr [bx - 0x201]
05bc1  24 3f                and al, 0x3f
05bc3  3a 06 94 3f          cmp al, byte ptr [0x3f94]    ; zone_heros
05bc7  74 0e                je loc_5bd7
05bc9  0a c0                or al, al
05bcb  74 0a                je loc_5bd7
05bcd  80 bf ff 01 30       cmp byte ptr [bx + 0x1ff], 0x30
05bd2  74 03                je loc_5bd7
05bd4  83 cd 01             or bp, 1
loc_5bd7:
05bd7  81 fb 5c 58          cmp bx, 0x585c
05bdb  73 21                jae loc_5bfe
05bdd  8a 47 01             mov al, byte ptr [bx + 1]
05be0  a8 50                test al, 0x50
05be2  75 1a                jne loc_5bfe
05be4  8a 87 01 fe          mov al, byte ptr [bx - 0x1ff]
05be8  24 3f                and al, 0x3f
05bea  3a 06 94 3f          cmp al, byte ptr [0x3f94]    ; zone_heros
05bee  74 0e                je loc_5bfe
05bf0  0a c0                or al, al
05bf2  74 0a                je loc_5bfe
05bf4  80 bf 01 02 30       cmp byte ptr [bx + 0x201], 0x30
05bf9  74 03                je loc_5bfe
05bfb  83 cd 08             or bp, 8
loc_5bfe:
05bfe  81 fb 42 58          cmp bx, 0x5842
05c02  73 20                jae loc_5c24
05c04  f6 47 1a a0          test byte ptr [bx + 0x1a], 0xa0
05c08  75 1a                jne loc_5c24
05c0a  8a 87 1a fe          mov al, byte ptr [bx - 0x1e6]
05c0e  24 3f                and al, 0x3f
05c10  3a 06 94 3f          cmp al, byte ptr [0x3f94]    ; zone_heros
05c14  74 0e                je loc_5c24
05c16  0a c0                or al, al
05c18  74 0a                je loc_5c24
05c1a  80 bf 1a 02 30       cmp byte ptr [bx + 0x21a], 0x30
05c1f  74 03                je loc_5c24
05c21  83 cd 04             or bp, 4
loc_5c24:
05c24  0b ed                or bp, bp
05c26  75 01                jne loc_5c29
05c28  c3                   ret
loc_5c29:
05c29  b9 04 00             mov cx, 4
05c2c  be 01 41             mov si, 0x4101    ; bords_case
loc_5c2f:
05c2f  d1 ed                shr bp, 1
05c31  73 47                jae loc_5c7a
05c33  55                   push bp
05c34  51                   push cx
05c35  56                   push si
05c36  8a 1e 93 3f          mov bl, byte ptr [0x3f93]    ; index_case_courante
05c3a  02 db                add bl, bl
05c3c  02 db                add bl, bl
05c3e  b7 00                mov bh, 0
05c40  81 c3 19 41          add bx, 0x4119    ; position_cases
05c44  8b 07                mov ax, word ptr [bx]
05c46  8b 5f 02             mov bx, word ptr [bx + 2]
05c49  03 04                add ax, word ptr [si]
05c4b  03 5c 02             add bx, word ptr [si + 2]
05c4e  e8 23 d5             call ligne_ecran
05c51  89 1e eb 37          mov word ptr [0x37eb], bx    ; position_tuile_carte
05c55  a2 e9 37             mov byte ptr [0x37e9], al    ; erreur_fichier
05c58  8b 74 04             mov si, word ptr [si + 4]
05c5b  8b 3e eb 37          mov di, word ptr [0x37eb]    ; position_tuile_carte
05c5f  a1 2d 5e             mov ax, word ptr [0x5e2d]    ; seg_odds
05c62  a3 4e 37             mov word ptr [0x374e], ax    ; segment_source
05c65  50                   push ax
05c66  b8 63 14             mov ax, 0x1463
05c69  8e c0                mov es, ax
05c6b  58                   pop ax
05c6c  bd 10 00             mov bp, 0x10
05c6f  b9 06 00             mov cx, 6
05c72  1e                   push ds
05c73  e8 dd de             call copie_image
05c76  1f                   pop ds
05c77  5e                   pop si
05c78  59                   pop cx
05c79  5d                   pop bp
loc_5c7a:
05c7a  83 c6 06             add si, 6
05c7d  e2 b0                loop loc_5c2f
05c7f  c3                   ret

; ======== charge_men   (appelée depuis 0941, 1daa)
; MEN.VGA (héros en combat)
05c80  c7 06 f1 47 20 2c    mov word ptr [0x47f1], 0x2c20
05c86  83 3e 90 31 08       cmp word ptr [0x3190], 8    ; mode_video
05c8b  74 65                je loc_5cf2
05c8d  c7 06 07 39 67 5f    mov word ptr [0x3907], 0x5f67    ; fichier_nom, "men.ega"
05c93  c7 06 03 39 00 00    mov word ptr [0x3903], 0    ; fichier_offset
05c99  b8 63 14             mov ax, 0x1463
05c9c  a3 01 39             mov word ptr [0x3901], ax    ; fichier_segment
loc_5c9f:
05c9f  c7 06 e9 37 00 00    mov word ptr [0x37e9], 0    ; erreur_fichier
05ca5  e8 49 da             call clavier_retire
05ca8  e8 1d dd             call fichier_ouvre
05cab  83 3e e9 37 00       cmp word ptr [0x37e9], 0    ; erreur_fichier
05cb0  75 03                jne loc_5cb5
05cb2  eb 0f                jmp loc_5cc3
; ---- 1 octets non atteints (5cb4-5cb4)
loc_5cb5:
05cb5  e8 02 da             call clavier_installe
05cb8  bb 52 02             mov bx, 0x252    ; message « INTRODUISEZ VOTRE / HEROQUEST DISQUETTE 3 »
05cbb  e8 2f 2c             call affiche_message
05cbe  e8 30 da             call clavier_retire
05cc1  eb dc                jmp loc_5c9f
loc_5cc3:
05cc3  e8 36 dd             call fichier_lit
05cc6  83 3e e9 37 00       cmp word ptr [0x37e9], 0    ; erreur_fichier
05ccb  75 e8                jne loc_5cb5
05ccd  a3 05 39             mov word ptr [0x3905], ax    ; fichier_taille
05cd0  e8 e7 d9             call clavier_installe
05cd3  a1 27 5e             mov ax, word ptr [0x5e27]    ; seg_annexe
05cd6  8e c0                mov es, ax
05cd8  33 f6                xor si, si
05cda  bf 00 00             mov di, 0
05cdd  b8 63 14             mov ax, 0x1463
05ce0  8e d8                mov ds, ax
05ce2  b9 ff ff             mov cx, 0xffff
05ce5  e8 e9 e8             call lz_decompresse
05ce8  50                   push ax
05ce9  b8 7c 09             mov ax, 0x97c
05cec  8e d8                mov ds, ax
05cee  58                   pop ax
05cef  eb 63                jmp loc_5d54
; ---- 1 octets non atteints (5cf1-5cf1)
loc_5cf2:
05cf2  c7 06 07 39 cb 5e    mov word ptr [0x3907], 0x5ecb    ; fichier_nom, "men.vga"
05cf8  c7 06 03 39 00 00    mov word ptr [0x3903], 0    ; fichier_offset
05cfe  b8 63 14             mov ax, 0x1463
05d01  a3 01 39             mov word ptr [0x3901], ax    ; fichier_segment
loc_5d04:
05d04  c7 06 e9 37 00 00    mov word ptr [0x37e9], 0    ; erreur_fichier
05d0a  e8 e4 d9             call clavier_retire
05d0d  e8 b8 dc             call fichier_ouvre
05d10  83 3e e9 37 00       cmp word ptr [0x37e9], 0    ; erreur_fichier
05d15  75 03                jne loc_5d1a
05d17  eb 0f                jmp loc_5d28
; ---- 1 octets non atteints (5d19-5d19)
loc_5d1a:
05d1a  e8 9d d9             call clavier_installe
05d1d  bb 52 02             mov bx, 0x252    ; message « INTRODUISEZ VOTRE / HEROQUEST DISQUETTE 3 »
05d20  e8 ca 2b             call affiche_message
05d23  e8 cb d9             call clavier_retire
05d26  eb dc                jmp loc_5d04
loc_5d28:
05d28  e8 d1 dc             call fichier_lit
05d2b  83 3e e9 37 00       cmp word ptr [0x37e9], 0    ; erreur_fichier
05d30  75 e8                jne loc_5d1a
05d32  a3 05 39             mov word ptr [0x3905], ax    ; fichier_taille
05d35  e8 82 d9             call clavier_installe
05d38  a1 27 5e             mov ax, word ptr [0x5e27]    ; seg_annexe
05d3b  8e c0                mov es, ax
05d3d  33 f6                xor si, si
05d3f  bf 00 00             mov di, 0
05d42  b8 63 14             mov ax, 0x1463
05d45  8e d8                mov ds, ax
05d47  b9 ff ff             mov cx, 0xffff
05d4a  e8 84 e8             call lz_decompresse
05d4d  50                   push ax
05d4e  b8 7c 09             mov ax, 0x97c
05d51  8e d8                mov ds, ax
05d53  58                   pop ax
loc_5d54:
05d54  e8 cc 0c             call fond_vers_tampon
05d57  8b 3e 37 46          mov di, word ptr [0x4637]    ; fiche_heros_courant
05d5b  8a 5d 03             mov bl, byte ptr [di + 3]
05d5e  32 ff                xor bh, bh
05d60  d1 e3                shl bx, 1
05d62  8b 97 43 a5          mov dx, word ptr [bx - 0x5abd]
05d66  c6 06 93 3f 08       mov byte ptr [0x3f93], 8    ; index_case_courante
05d6b  52                   push dx
05d6c  e8 7b ba             call copie_sol
05d6f  5a                   pop dx
05d70  c6 06 93 3f 0c       mov byte ptr [0x3f93], 0xc    ; index_case_courante
05d75  e8 72 ba             call copie_sol
05d78  e8 a1 08             call affiche_nom_portrait
05d7b  e8 02 09             call dessine_icones_fiche
05d7e  c3                   ret

; ======== fiche_personnage   (appelée depuis 0c36, 0e7c, 0ee5, 1904, 247b, 2495, 2c39, 78d0)
; SI = fiche du personnage AL (table DS:4341)
05d7f  53                   push bx
05d80  52                   push dx
05d81  bb 41 43             mov bx, 0x4341    ; adresses_fiches
05d84  e8 54 03             call mot_table
05d87  8b f2                mov si, dx
05d89  5a                   pop dx
05d8a  5b                   pop bx
05d8b  c3                   ret

; ======== compte_cranes   (appelée depuis 0958, 1064, 1eb6, 26b6)
; lance DH dés de combat, renvoie les crânes dans AL
05d8c  b2 00                mov dl, 0
loc_5d8e:
05d8e  e8 26 c4             call de_combat
05d91  80 fb 00             cmp bl, 0
05d94  75 02                jne loc_5d98
05d96  fe c2                inc dl
loc_5d98:
05d98  fe ce                dec dh
05d9a  75 f2                jne loc_5d8e
05d9c  8a c2                mov al, dl
05d9e  c3                   ret

; ======== texte_sous_curseur   (appelée depuis 8839, 88c7)
; ZF posé si le curseur est sur le texte BP
05d9f  e8 f8 e6             call longueur_texte
05da2  83 ee 03             sub si, 3
05da5  89 36 3c ad          mov word ptr [0xad3c], si
05da9  a1 93 39             mov ax, word ptr [0x3993]    ; curseur_x
05dac  d1 e8                shr ax, 1
05dae  d1 e8                shr ax, 1
05db0  d1 e8                shr ax, 1
05db2  3e 8a 4e 02          mov cl, byte ptr ds:[bp + 2]
05db6  3a c1                cmp al, cl
05db8  72 18                jb loc_5dd2
05dba  02 0e 3c ad          add cl, byte ptr [0xad3c]
05dbe  3a c1                cmp al, cl
05dc0  73 10                jae loc_5dd2
05dc2  a1 95 39             mov ax, word ptr [0x3995]    ; curseur_y
05dc5  d1 e8                shr ax, 1
05dc7  d1 e8                shr ax, 1
05dc9  d1 e8                shr ax, 1
05dcb  3e 3a 46 01          cmp al, byte ptr ds:[bp + 1]
05dcf  75 01                jne loc_5dd2
05dd1  c3                   ret
loc_5dd2:
05dd2  b0 01                mov al, 1
05dd4  0a c0                or al, al
05dd6  c3                   ret

; ======== curseur_efface   (appelée depuis 0456, 0872, 0cc7, 186f, 2d05, 73c2, 7845, 7f26)
; recopie le fond sous le curseur depuis la copie DS:5E35 (restaure_rect)
05dd7  be e5 47             mov si, 0x47e5    ; sprite_curseur
05dda  80 7c 07 00          cmp byte ptr [si + 7], 0
05dde  75 01                jne loc_5de1
05de0  c3                   ret
loc_5de1:
05de1  80 7c 06 00          cmp byte ptr [si + 6], 0
05de5  75 01                jne loc_5de8
05de7  c3                   ret
loc_5de8:
05de8  8b 7c 10             mov di, word ptr [si + 0x10]
05deb  32 ed                xor ch, ch
05ded  8a 4c 06             mov cl, byte ptr [si + 6]
05df0  8b e9                mov bp, cx
05df2  8a 4c 07             mov cl, byte ptr [si + 7]
05df5  e9 3c 05             jmp restaure_rect

; ======== efface_sprite
; restaure le fond sous le sprite SI (restaure_rect), sauf si son segment est DS ; non appelée
05df8  bb 7c 09             mov bx, 0x97c
05dfb  3b 5c 08             cmp bx, word ptr [si + 8]
05dfe  75 01                jne loc_5e01
05e00  c3                   ret
loc_5e01:
05e01  8b 7c 10             mov di, word ptr [si + 0x10]
05e04  32 ed                xor ch, ch
05e06  8a 4c 06             mov cl, byte ptr [si + 6]
05e09  8b e9                mov bp, cx
05e0b  8a 4c 07             mov cl, byte ptr [si + 7]
05e0e  56                   push si
05e0f  e8 22 05             call restaure_rect
05e12  5e                   pop si
05e13  c3                   ret

; ======== curseur_dessine   (appelée depuis 0449, 086c, 0cc1, 2cff, 73bc, 783f, 7f20, 8038)
; sprite du curseur (DS:47E5, 16 x 16) : détoure l'image DS:47F1 dans DS:46E5 et la dessine dans le tampon
05e14  be e5 47             mov si, 0x47e5    ; sprite_curseur
05e17  c6 44 06 10          mov byte ptr [si + 6], 0x10
05e1b  c6 44 07 10          mov byte ptr [si + 7], 0x10
05e1f  83 3e 90 31 08       cmp word ptr [0x3190], 8    ; mode_video
05e24  74 0e                je loc_5e34
05e26  81 3e 93 39 2f 01    cmp word ptr [0x3993], 0x12f    ; curseur_x
05e2c  72 06                jb loc_5e34
05e2e  c7 06 93 39 2f 01    mov word ptr [0x3993], 0x12f    ; curseur_x
loc_5e34:
05e34  b8 c8 00             mov ax, 0xc8
05e37  2b 06 95 39          sub ax, word ptr [0x3995]    ; curseur_y
05e3b  0a c0                or al, al
05e3d  75 01                jne loc_5e40
05e3f  c3                   ret
loc_5e40:
05e40  3d 10 00             cmp ax, 0x10
05e43  73 03                jae loc_5e48
05e45  88 44 07             mov byte ptr [si + 7], al
loc_5e48:
05e48  b8 40 01             mov ax, 0x140
05e4b  2b 06 93 39          sub ax, word ptr [0x3993]    ; curseur_x
05e4f  0b c0                or ax, ax
05e51  75 01                jne loc_5e54
05e53  c3                   ret
loc_5e54:
05e54  3d 10 00             cmp ax, 0x10
05e57  77 03                ja loc_5e5c
05e59  88 44 06             mov byte ptr [si + 6], al
loc_5e5c:
05e5c  a1 95 39             mov ax, word ptr [0x3995]    ; curseur_y
05e5f  33 d2                xor dx, dx
05e61  b9 40 01             mov cx, 0x140
05e64  f7 e1                mul cx
05e66  03 06 93 39          add ax, word ptr [0x3993]    ; curseur_x
05e6a  a3 97 39             mov word ptr [0x3997], ax    ; curseur_adresse
05e6d  89 44 10             mov word ptr [si + 0x10], ax
05e70  1e                   push ds
05e71  56                   push si
05e72  32 ed                xor ch, ch
05e74  8a 4c 06             mov cl, byte ptr [si + 6]
05e77  8b d1                mov dx, cx
05e79  8a 4c 07             mov cl, byte ptr [si + 7]
05e7c  50                   push ax
05e7d  b8 7c 09             mov ax, 0x97c
05e80  8e c0                mov es, ax
05e82  58                   pop ax
05e83  8b 6c 0c             mov bp, word ptr [si + 0xc]
05e86  8b f5                mov si, bp
05e88  bf e5 46             mov di, 0x46e5    ; image_curseur
05e8b  bd 10 00             mov bp, 0x10
05e8e  2b ea                sub bp, dx
05e90  bb 0c 3f             mov bx, 0x3f0c
05e93  03 1e 90 31          add bx, word ptr [0x3190]    ; mode_video
05e97  ff 27                jmp word ptr [bx]
loc_5e99:
05e99  d1 e1                shl cx, 1
05e9b  d1 e1                shl cx, 1
05e9d  d1 ee                shr si, 1
05e9f  81 3e 93 39 2f 01    cmp word ptr [0x3993], 0x12f    ; curseur_x
05ea5  72 29                jb loc_5ed0
05ea7  c7 06 93 39 2f 01    mov word ptr [0x3993], 0x12f    ; curseur_x
05ead  eb 21                jmp loc_5ed0
; ---- 1 octets non atteints (5eaf-5eaf)
curseur_code_mort:    ; fragment jamais atteint de curseur_dessine (copie un octet sur deux, x limité à 311)
05eb0  83 3e 90 31 08       cmp word ptr [0x3190], 8    ; mode_video
05eb5  74 06                je loc_5ebd
05eb7  c7 06 93 39 37 01    mov word ptr [0x3993], 0x137    ; curseur_x
loc_5ebd:
05ebd  b0 08                mov al, 8
05ebf  a2 eb 47             mov byte ptr [0x47eb], al
05ec2  50                   push ax
05ec3  a1 2d 5e             mov ax, word ptr [0x5e2d]    ; seg_odds
05ec6  8e d8                mov ds, ax
05ec8  58                   pop ax
loc_5ec9:
05ec9  a4                   movsb byte ptr es:[di], byte ptr [si]
05eca  46                   inc si
05ecb  e2 fc                loop loc_5ec9
05ecd  eb 23                jmp loc_5ef2
; ---- 1 octets non atteints (5ecf-5ecf)
loc_5ed0:
05ed0  b0 10                mov al, 0x10
05ed2  a2 eb 47             mov byte ptr [0x47eb], al
05ed5  50                   push ax
05ed6  a1 2d 5e             mov ax, word ptr [0x5e2d]    ; seg_odds
05ed9  8e d8                mov ds, ax
05edb  58                   pop ax
05edc  f3 a5                rep movsw word ptr es:[di], word ptr [si]
05ede  eb 12                jmp loc_5ef2
; ---- 1 octets non atteints (5ee0-5ee0)
loc_5ee1:
05ee1  50                   push ax
05ee2  a1 2d 5e             mov ax, word ptr [0x5e2d]    ; seg_odds
05ee5  8e d8                mov ds, ax
05ee7  58                   pop ax
loc_5ee8:
05ee8  51                   push cx
05ee9  8b ca                mov cx, dx
05eeb  f3 a4                rep movsb byte ptr es:[di], byte ptr [si]
05eed  59                   pop cx
05eee  03 f5                add si, bp
05ef0  e2 f6                loop loc_5ee8
loc_5ef2:
05ef2  5e                   pop si
05ef3  1f                   pop ds
05ef4  50                   push ax
05ef5  b8 63 14             mov ax, 0x1463
05ef8  8e c0                mov es, ax
05efa  58                   pop ax
05efb  b8 7c 09             mov ax, 0x97c
05efe  a3 4e 37             mov word ptr [0x374e], ax    ; segment_source
05f01  32 ed                xor ch, ch
05f03  8a 4c 06             mov cl, byte ptr [si + 6]
05f06  8b e9                mov bp, cx
05f08  8a 4c 07             mov cl, byte ptr [si + 7]
05f0b  8b 3e 97 39          mov di, word ptr [0x3997]    ; curseur_adresse
05f0f  be e5 46             mov si, 0x46e5    ; image_curseur
05f12  83 3e 90 31 08       cmp word ptr [0x3190], 8    ; mode_video
05f17  75 03                jne loc_5f1c
05f19  e9 37 dc             jmp copie_image
loc_5f1c:
05f1c  d1 e6                shl si, 1
05f1e  e9 32 dc             jmp copie_image

; ======== attend_clic_complet   (appelée depuis 5f59)
; attend_clic, puis attend_relache_boutons
05f21  e8 0a da             call attend_clic
05f24  e9 2d da             jmp attend_relache_boutons

; ======== point_arret
; outil de mise au point : bordure blanche (int 10h AX=1001h BH=FFh), affiche_registres, attend un clic, bordure 0 ; non appelée
05f27  9c                   pushf
05f28  50                   push ax
05f29  53                   push bx
05f2a  51                   push cx
05f2b  52                   push dx
05f2c  57                   push di
05f2d  56                   push si
05f2e  55                   push bp
05f2f  06                   push es
05f30  1e                   push ds
05f31  50                   push ax
05f32  b8 7c 09             mov ax, 0x97c
05f35  8e d8                mov ds, ax
05f37  58                   pop ax
05f38  9c                   pushf
05f39  50                   push ax
05f3a  53                   push bx
05f3b  51                   push cx
05f3c  52                   push dx
05f3d  57                   push di
05f3e  56                   push si
05f3f  55                   push bp
05f40  06                   push es
05f41  1e                   push ds
05f42  b7 ff                mov bh, 0xff
05f44  b8 01 10             mov ax, 0x1001
05f47  cd 10                int 0x10
05f49  1f                   pop ds
05f4a  07                   pop es
05f4b  5d                   pop bp
05f4c  5e                   pop si
05f4d  5f                   pop di
05f4e  5a                   pop dx
05f4f  59                   pop cx
05f50  5b                   pop bx
05f51  58                   pop ax
05f52  9d                   popf
05f53  e8 57 e5             call affiche_registres
05f56  e8 8b 01             call affiche_tampon
05f59  e8 c5 ff             call attend_clic_complet
05f5c  9c                   pushf
05f5d  50                   push ax
05f5e  53                   push bx
05f5f  51                   push cx
05f60  52                   push dx
05f61  57                   push di
05f62  56                   push si
05f63  55                   push bp
05f64  06                   push es
05f65  1e                   push ds
05f66  b7 00                mov bh, 0
05f68  b8 01 10             mov ax, 0x1001
05f6b  cd 10                int 0x10
05f6d  1f                   pop ds
05f6e  07                   pop es
05f6f  5d                   pop bp
05f70  5e                   pop si
05f71  5f                   pop di
05f72  5a                   pop dx
05f73  59                   pop cx
05f74  5b                   pop bx
05f75  58                   pop ax
05f76  9d                   popf
05f77  1f                   pop ds
05f78  07                   pop es
05f79  5d                   pop bp
05f7a  5e                   pop si
05f7b  5f                   pop di
05f7c  5a                   pop dx
05f7d  59                   pop cx
05f7e  5b                   pop bx
05f7f  58                   pop ax
05f80  9d                   popf
05f81  c3                   ret

; ======== initialise_jeu   (appelée depuis 010f)
; graine du hasard (heure DOS), puis chargements
05f82  fc                   cld
05f83  e8 25 e7             call lit_ports_video
05f86  e8 54 d9             call souris_position
05f89  b4 2c                mov ah, 0x2c
05f8b  cd 21                int 0x21
05f8d  89 16 fd 38          mov word ptr [0x38fd], dx    ; graine
05f91  b8 63 14             mov ax, 0x1463
05f94  a3 56 37             mov word ptr [0x3756], ax    ; texte_segment
05f97  be e5 47             mov si, 0x47e5    ; sprite_curseur
05f9a  c7 44 0c 20 2c       mov word ptr [si + 0xc], 0x2c20
05f9f  e8 6e ee             call alloue_memoire
05fa2  73 01                jae loc_5fa5
05fa4  c3                   ret
loc_5fa5:
05fa5  e8 c8 f0             call charge_donnees
05fa8  c7 06 07 39 a8 31    mov word ptr [0x3907], 0x31a8    ; fichier_nom, "beeper.drv"
05fae  e8 40 d7             call clavier_retire
loc_5fb1:
05fb1  c7 06 e9 37 00 00    mov word ptr [0x37e9], 0    ; erreur_fichier
05fb7  e8 0e da             call fichier_ouvre
05fba  83 3e e9 37 02       cmp word ptr [0x37e9], 2    ; erreur_fichier
05fbf  74 03                je loc_5fc4
05fc1  eb 0e                jmp loc_5fd1
; ---- 1 octets non atteints (5fc3-5fc3)
loc_5fc4:
05fc4  ba e2 3e             mov dx, 0x3ee2
05fc7  b4 09                mov ah, 9
05fc9  cd 21                int 0x21
05fcb  b4 00                mov ah, 0
05fcd  cd 16                int 0x16
05fcf  eb e0                jmp loc_5fb1
loc_5fd1:
05fd1  e8 d2 e7             call son_charge_pilote
05fd4  73 01                jae loc_5fd7
05fd6  c3                   ret
loc_5fd7:
05fd7  e8 4b e8             call son_prepare
05fda  bb 5c 3f             mov bx, 0x3f5c
05fdd  03 1e 90 31          add bx, word ptr [0x3190]    ; mode_video
05fe1  ff 27                jmp word ptr [bx]

; ======== mode_vga   (appelée depuis 00e9, 5fe1)
; mode 13h, puis palette DS:5B23
05fe3  50                   push ax
05fe4  b8 7c 09             mov ax, 0x97c
05fe7  8e c0                mov es, ax
05fe9  58                   pop ax
05fea  32 e4                xor ah, ah
05fec  b0 13                mov al, 0x13
05fee  cd 10                int 0x10
05ff0  ba 23 5b             mov dx, 0x5b23    ; palette
05ff3  33 db                xor bx, bx
05ff5  b9 ff 00             mov cx, 0xff
mode_video_palette:    ; mode 13h et palette DS:5B23 (int 10h AX=1012h)
05ff8  b8 12 10             mov ax, 0x1012
05ffb  cd 10                int 0x10
05ffd  f8                   clc
05ffe  c3                   ret
loc_5fff:
05fff  50                   push ax
06000  b8 7c 09             mov ax, 0x97c
06003  8e c0                mov es, ax
06005  58                   pop ax
06006  32 e4                xor ah, ah
06008  b0 09                mov al, 9
0600a  cd 10                int 0x10
0600c  b8 02 10             mov ax, 0x1002
0600f  ba 12 5b             mov dx, 0x5b12
06012  cd 10                int 0x10
06014  f8                   clc
06015  c3                   ret

; ======== mode_ega   (appelée depuis 0011, 5fe1)
; mode 0Dh (EGA 320 × 200, 16 couleurs), registres de palette DS:5B01 (int 10h AX=1002h) ; entrée 6 de la table DS:3F5C
06016  50                   push ax
06017  b8 7c 09             mov ax, 0x97c
0601a  8e c0                mov es, ax
0601c  58                   pop ax
0601d  32 e4                xor ah, ah
0601f  b0 0d                mov al, 0xd
06021  cd 10                int 0x10
06023  b8 02 10             mov ax, 0x1002
06026  ba 01 5b             mov dx, 0x5b01
06029  cd 10                int 0x10
0602b  f8                   clc
0602c  c3                   ret

; ======== efface_ecran_tampon   (appelée depuis 6f98)
; efface l'écran (efface_ecran, mémoire vidéo), puis efface_tampon ; après mort_heros dans evt_coffre_100
0602d  e8 10 d6             call efface_ecran
06030  e9 cf 01             jmp efface_tampon

; ======== de6_moins_un   (appelée depuis 21b7, 223f, 2666, 4c12, 4daa, 4daf, 6cdd)
; hasard(6) - 1 dans BL
06033  50                   push ax
06034  51                   push cx
06035  52                   push dx
06036  56                   push si
06037  57                   push di
06038  55                   push bp
06039  b3 06                mov bl, 6
0603b  e8 d5 d5             call hasard
0603e  8a d8                mov bl, al
06040  fe cb                dec bl
06042  5d                   pop bp
06043  5f                   pop di
06044  5e                   pop si
06045  5a                   pop dx
06046  59                   pop cx
06047  58                   pop ax
06048  c3                   ret

; ======== fin_deplacement   (appelée depuis 0936, 2d29, 6bf3, 6e0d)
; une action après un déplacement arrête le déplacement (sauf potion héroïque)
06049  80 3e 9f 40 00       cmp byte ptr [0x409f], 0
0604e  74 01                je loc_6051
06050  c3                   ret
loc_6051:
06051  f6 06 9b 3f 01       test byte ptr [0x3f9b], 1    ; etat_action
06056  74 14                je loc_606c
06058  8b 3e 37 46          mov di, word ptr [0x4637]    ; fiche_heros_courant
0605c  f6 45 17 40          test byte ptr [di + 0x17], 0x40
06060  75 0a                jne loc_606c
06062  80 0e 9b 3f 04       or byte ptr [0x3f9b], 4    ; etat_action
06067  c6 06 9c 3f 00       mov byte ptr [0x3f9c], 0    ; deplacement_restant
loc_606c:
0606c  80 0e 9b 3f 02       or byte ptr [0x3f9b], 2    ; etat_action
06071  f6 45 17 40          test byte ptr [di + 0x17], 0x40
06075  74 01                je loc_6078
06077  c3                   ret
loc_6078:
06078  80 0e 9b 3f 08       or byte ptr [0x3f9b], 8    ; etat_action
0607d  c3                   ret

; ======== index_case   (appelée depuis 121e, 230b, 24ad, 24eb, 250b, 6ec2, 6ee0, 86a4)
; index de la case (x, y) passée dans DX, dans BX
0607e  8a de                mov bl, dh
06080  b7 00                mov bh, 0
06082  03 db                add bx, bx
06084  81 c3 c5 5a          add bx, 0x5ac5    ; lignes_grille
06088  8b 07                mov ax, word ptr [bx]
0608a  b6 00                mov dh, 0
0608c  03 d0                add dx, ax
0608e  8b da                mov bx, dx
06090  c3                   ret

; ======== coord_caracteres
; non appelée : AX = [SI+4] / 8, BX = [SI+2] / 8 (pixels vers caractères ?)
06091  8b 44 04             mov ax, word ptr [si + 4]
06094  d1 e8                shr ax, 1
06096  d1 e8                shr ax, 1
06098  d1 e8                shr ax, 1
0609a  8b 5c 02             mov bx, word ptr [si + 2]
0609d  d1 eb                shr bx, 1
0609f  d1 eb                shr bx, 1
060a1  d1 eb                shr bx, 1
060a3  c3                   ret

; ======== affiche_texte_si   (appelée depuis 1d89, 60ce, 661f)
; affiche_texte avec BP = SI
060a4  8b ee                mov bp, si
060a6  e9 d3 d0             jmp affiche_texte

; ======== affiche_chaine_sans_fond   (appelée depuis 802f, 8178)
; SI = numéro de message (offset dans textes) : affiche sa chaîne par affiche_texte_sans_fond
060a9  bb c1 5f             mov bx, 0x5fc1    ; textes
060ac  8b 38                mov di, word ptr [bx + si]
060ae  81 c7 c1 5f          add di, 0x5fc1    ; textes
060b2  8b f7                mov si, di

; ======== affiche_texte_sans_fond   (appelée depuis 0d17, 662e, 814f, 815d)
; texte SI en couleur 33h (VGA) ou 0Fh, sans fond (DS:3759 = 1), puis rétablit la couleur
060b4  c6 06 59 37 01       mov byte ptr [0x3759], 1    ; texte_transparent
060b9  ff 36 50 37          push word ptr [0x3750]    ; couleur_texte
060bd  c6 06 50 37 33       mov byte ptr [0x3750], 0x33    ; couleur_texte
060c2  83 3e 90 31 08       cmp word ptr [0x3190], 8    ; mode_video
060c7  74 05                je loc_60ce
060c9  c6 06 50 37 0f       mov byte ptr [0x3750], 0xf    ; couleur_texte
loc_60ce:
060ce  e8 d3 ff             call affiche_texte_si
060d1  8f 06 50 37          pop word ptr [0x3750]    ; couleur_texte
060d5  c6 06 59 37 00       mov byte ptr [0x3759], 0    ; texte_transparent
060da  c3                   ret

; ======== mot_table   (appelée depuis 0d7d, 0dd9, 0e91, 4d89, 5d84, 6629)
; DX = mot d'indice AL de la table BX (BX avancé de 2 × AL)
060db  02 c0                add al, al

; ======== mot_table_octets   (appelée depuis 173d, 176a, 853b)
; DX = mot à l'offset AL de la table BX (BX avancé de AL)
060dd  32 e4                xor ah, ah
060df  03 d8                add bx, ax
060e1  8b 17                mov dx, word ptr [bx]
060e3  c3                   ret

; ======== affiche_tampon   (appelée depuis 0028, 0096, 00b4, 00cf, 0131, 022e, 023d, 0453)
; envoie le tampon à l'écran ; version VGA en 0x6148
060e4  bb 20 3f             mov bx, 0x3f20
060e7  03 1e 90 31          add bx, word ptr [0x3190]    ; mode_video
060eb  ff 27                jmp word ptr [bx]
loc_60ed:
060ed  50                   push ax
060ee  b8 00 b8             mov ax, 0xb800
060f1  8e c0                mov es, ax
060f3  58                   pop ax
060f4  50                   push ax
060f5  b8 63 14             mov ax, 0x1463
060f8  8e d8                mov ds, ax
060fa  58                   pop ax
060fb  be 00 00             mov si, 0
060fe  bf 00 00             mov di, 0
06101  b9 00 40             mov cx, 0x4000
06104  f3 a5                rep movsw word ptr es:[di], word ptr [si]
06106  50                   push ax
06107  b8 7c 09             mov ax, 0x97c
0610a  8e d8                mov ds, ax
0610c  58                   pop ax
0610d  c3                   ret
loc_610e:
0610e  50                   push ax
0610f  b8 00 a0             mov ax, 0xa000
06112  8e c0                mov es, ax
06114  58                   pop ax
06115  50                   push ax
06116  b8 63 14             mov ax, 0x1463
06119  8e d8                mov ds, ax
0611b  58                   pop ax
0611c  33 f6                xor si, si
0611e  8b fe                mov di, si
06120  ba c4 03             mov dx, 0x3c4
06123  b8 02 08             mov ax, 0x802
06126  bb c8 00             mov bx, 0xc8
loc_6129:
06129  50                   push ax
0612a  ef                   out dx, ax
0612b  b9 14 00             mov cx, 0x14
0612e  57                   push di
0612f  f3 a5                rep movsw word ptr es:[di], word ptr [si]
06131  5f                   pop di
06132  58                   pop ax
06133  d0 ec                shr ah, 1
06135  75 f2                jne loc_6129
06137  83 c7 28             add di, 0x28
0613a  b8 02 08             mov ax, 0x802
0613d  4b                   dec bx
0613e  75 e9                jne loc_6129
06140  50                   push ax
06141  b8 7c 09             mov ax, 0x97c
06144  8e d8                mov ds, ax
06146  58                   pop ax
06147  c3                   ret
loc_6148:
06148  1e                   push ds
06149  50                   push ax
0614a  b8 00 a0             mov ax, 0xa000
0614d  8e c0                mov es, ax
0614f  58                   pop ax
06150  50                   push ax
06151  b8 63 14             mov ax, 0x1463
06154  8e d8                mov ds, ax
06156  58                   pop ax
06157  bf 00 00             mov di, 0
0615a  be 00 00             mov si, 0
0615d  b9 00 7d             mov cx, 0x7d00
06160  f3 a5                rep movsw word ptr es:[di], word ptr [si]
06162  50                   push ax
06163  b8 7c 09             mov ax, 0x97c
06166  8e d8                mov ds, ax
06168  58                   pop ax
06169  1f                   pop ds
0616a  c3                   ret

; ======== affiche_tampon_rideau   (appelée depuis 5708)
; envoie le tampon en 50 étapes de 4 lignes, l'image descendant depuis le haut de l'écran ; VGA en 0x6174, table DS:3F52
0616b  bb 52 3f             mov bx, 0x3f52
0616e  03 1e 90 31          add bx, word ptr [0x3190]    ; mode_video
06172  ff 27                jmp word ptr [bx]
loc_6174:
06174  b9 32 00             mov cx, 0x32
06177  bd 00 f5             mov bp, 0xf500
0617a  ba 80 02             mov dx, 0x280
0617d  1e                   push ds
0617e  50                   push ax
0617f  b8 63 14             mov ax, 0x1463
06182  8e d8                mov ds, ax
06184  58                   pop ax
06185  50                   push ax
06186  b8 00 a0             mov ax, 0xa000
06189  8e c0                mov es, ax
0618b  58                   pop ax
loc_618c:
0618c  8b d9                mov bx, cx
0618e  8b f5                mov si, bp
06190  33 ff                xor di, di
06192  8b ca                mov cx, dx
06194  f3 a5                rep movsw word ptr es:[di], word ptr [si]
06196  8b cb                mov cx, bx
06198  81 c2 80 02          add dx, 0x280
0619c  81 ed 00 05          sub bp, 0x500
061a0  51                   push cx
loc_61a1:
061a1  e2 fe                loop loc_61a1
061a3  59                   pop cx
061a4  e2 e6                loop loc_618c
061a6  1f                   pop ds
061a7  c3                   ret
loc_61a8:
061a8  b9 32 00             mov cx, 0x32
061ab  bd 80 7a             mov bp, 0x7a80
061ae  ba 04 00             mov dx, 4
061b1  1e                   push ds
061b2  50                   push ax
061b3  b8 63 14             mov ax, 0x1463
061b6  8e d8                mov ds, ax
061b8  58                   pop ax
061b9  50                   push ax
061ba  b8 00 a0             mov ax, 0xa000
061bd  8e c0                mov es, ax
061bf  58                   pop ax
loc_61c0:
061c0  51                   push cx
061c1  8b f5                mov si, bp
061c3  8b da                mov bx, dx
061c5  52                   push dx
061c6  ba c4 03             mov dx, 0x3c4
061c9  b8 02 08             mov ax, 0x802
061cc  bf 00 00             mov di, 0
loc_61cf:
061cf  50                   push ax
061d0  ef                   out dx, ax
061d1  b9 14 00             mov cx, 0x14
061d4  57                   push di
061d5  f3 a5                rep movsw word ptr es:[di], word ptr [si]
061d7  5f                   pop di
061d8  58                   pop ax
061d9  d0 ec                shr ah, 1
061db  75 f2                jne loc_61cf
061dd  83 c7 28             add di, 0x28
061e0  b8 02 08             mov ax, 0x802
061e3  4b                   dec bx
061e4  75 e9                jne loc_61cf
061e6  5a                   pop dx
061e7  59                   pop cx
061e8  83 c2 04             add dx, 4
061eb  81 ed 80 02          sub bp, 0x280
061ef  51                   push cx
loc_61f0:
061f0  e2 fe                loop loc_61f0
061f2  51                   push cx
061f3  b9 0a 00             mov cx, 0xa
loc_61f6:
061f6  e8 a7 d4             call attend_retour_vertical
061f9  e2 fb                loop loc_61f6
061fb  59                   pop cx
061fc  59                   pop cx
061fd  e2 c1                loop loc_61c0
061ff  1f                   pop ds
06200  c3                   ret
; ---- 1 octets non atteints (6201-6201)

; ======== efface_tampon   (appelée depuis 0025, 005c, 012e, 56d0, 7321, 744b, 763d, 8587)
; remplit le tampon d'écran (segment 1463) ; version VGA en 0x6248
06202  33 c0                xor ax, ax
06204  8b f8                mov di, ax
06206  50                   push ax
06207  b8 63 14             mov ax, 0x1463
0620a  8e c0                mov es, ax
0620c  58                   pop ax
0620d  bb 16 3f             mov bx, 0x3f16
06210  03 1e 90 31          add bx, word ptr [0x3190]    ; mode_video
06214  ff 27                jmp word ptr [bx]
loc_6216:
06216  b8 cc cc             mov ax, 0xcccc
06219  b9 00 40             mov cx, 0x4000
0621c  f3 ab                rep stosw word ptr es:[di], ax
0621e  c3                   ret
loc_621f:
0621f  b9 04 00             mov cx, 4
06222  bb 04 3f             mov bx, 0x3f04
loc_6225:
06225  8b 07                mov ax, word ptr [bx]
06227  51                   push cx
06228  57                   push di
06229  c7 06 e9 37 c8 00    mov word ptr [0x37e9], 0xc8    ; erreur_fichier
loc_622f:
0622f  b9 14 00             mov cx, 0x14
06232  f3 ab                rep stosw word ptr es:[di], ax
06234  83 c7 78             add di, 0x78
06237  ff 0e e9 37          dec word ptr [0x37e9]    ; erreur_fichier
0623b  75 f2                jne loc_622f
0623d  5f                   pop di
0623e  59                   pop cx
0623f  83 c7 28             add di, 0x28
06242  83 c3 02             add bx, 2
06245  e2 de                loop loc_6225
06247  c3                   ret
loc_6248:
06248  b9 00 7d             mov cx, 0x7d00
0624b  f3 ab                rep stosw word ptr es:[di], ax
0624d  c3                   ret

; ======== restaure_rect_es   (appelée depuis 0d11, 824e)
; recopie le rectangle DI (BP largeur, CX lignes) depuis la copie DS:5E35 vers ES, que la routine ne pose pas (le tampon, laissé par curseur_efface ?)
0624e  bb 66 3f             mov bx, 0x3f66
06251  03 1e 90 31          add bx, word ptr [0x3190]    ; mode_video
06255  ff 27                jmp word ptr [bx]
loc_6257:
06257  8b 16 35 5e          mov dx, word ptr [0x5e35]    ; seg_furn
0625b  eb 65                jmp loc_62c2
; ---- 1 octets non atteints (625d-625d)
loc_625e:
0625e  8b 16 35 5e          mov dx, word ptr [0x5e35]    ; seg_furn
06262  eb 28                jmp loc_628c
; ---- 1 octets non atteints (6264-6264)
loc_6265:
06265  50                   push ax
06266  b8 7c 09             mov ax, 0x97c
06269  8e d8                mov ds, ax
0626b  58                   pop ax
0626c  8b 16 35 5e          mov dx, word ptr [0x5e35]    ; seg_furn
06270  e9 a0 00             jmp loc_6313
loc_6273:
06273  50                   push ax
06274  b8 63 14             mov ax, 0x1463
06277  8e c0                mov es, ax
06279  58                   pop ax
0627a  8c da                mov dx, ds
0627c  50                   push ax
0627d  b8 7c 09             mov ax, 0x97c
06280  8e d8                mov ds, ax
06282  58                   pop ax
06283  bb 70 3f             mov bx, 0x3f70
06286  03 1e 90 31          add bx, word ptr [0x3190]    ; mode_video
0628a  ff 27                jmp word ptr [bx]
loc_628c:
0628c  e8 88 d8             call adresse_tandy
0628f  8b 3e fb 37          mov di, word ptr [0x37fb]    ; adresse_plane
06293  d1 ed                shr bp, 1
06295  83 3e f9 37 01       cmp word ptr [0x37f9], 1    ; rang_pixel
0629a  75 01                jne loc_629d
0629c  45                   inc bp
loc_629d:
0629d  8e da                mov ds, dx
0629f  8b d1                mov dx, cx
loc_62a1:
062a1  57                   push di
062a2  8b f7                mov si, di
062a4  8b cd                mov cx, bp
062a6  f3 a5                rep movsw word ptr es:[di], word ptr [si]
062a8  5f                   pop di
062a9  81 c7 00 20          add di, 0x2000
062ad  f7 c7 00 80          test di, 0x8000
062b1  74 04                je loc_62b7
062b3  81 ef 60 7f          sub di, 0x7f60
loc_62b7:
062b7  4a                   dec dx
062b8  75 e7                jne loc_62a1
062ba  50                   push ax
062bb  b8 7c 09             mov ax, 0x97c
062be  8e d8                mov ds, ax
062c0  58                   pop ax
062c1  c3                   ret
loc_62c2:
062c2  e8 17 d8             call adresse_ega
062c5  8b 3e fb 37          mov di, word ptr [0x37fb]    ; adresse_plane
062c9  d1 ed                shr bp, 1
062cb  d1 ed                shr bp, 1
062cd  d1 ed                shr bp, 1
062cf  83 3e f9 37 00       cmp word ptr [0x37f9], 0    ; rang_pixel
062d4  74 01                je loc_62d7
062d6  45                   inc bp
loc_62d7:
062d7  bb 28 00             mov bx, 0x28
062da  2b dd                sub bx, bp
062dc  2b dd                sub bx, bp
062de  8e da                mov ds, dx
062e0  8b d1                mov dx, cx
loc_62e2:
062e2  57                   push di
062e3  8b f7                mov si, di
062e5  8b cd                mov cx, bp
062e7  f3 a5                rep movsw word ptr es:[di], word ptr [si]
062e9  03 fb                add di, bx
062eb  8b f7                mov si, di
062ed  8b cd                mov cx, bp
062ef  f3 a5                rep movsw word ptr es:[di], word ptr [si]
062f1  03 fb                add di, bx
062f3  8b f7                mov si, di
062f5  8b cd                mov cx, bp
062f7  f3 a5                rep movsw word ptr es:[di], word ptr [si]
062f9  03 fb                add di, bx
062fb  8b f7                mov si, di
062fd  8b cd                mov cx, bp
062ff  f3 a5                rep movsw word ptr es:[di], word ptr [si]
06301  03 fb                add di, bx
06303  5f                   pop di
06304  81 c7 a0 00          add di, 0xa0
06308  4a                   dec dx
06309  75 d7                jne loc_62e2
0630b  50                   push ax
0630c  b8 7c 09             mov ax, 0x97c
0630f  8e d8                mov ds, ax
06311  58                   pop ax
06312  c3                   ret
loc_6313:
06313  8e da                mov ds, dx
06315  bb 40 01             mov bx, 0x140
06318  2b dd                sub bx, bp
loc_631a:
0631a  8b d1                mov dx, cx
0631c  8b cd                mov cx, bp
0631e  57                   push di
0631f  8b f7                mov si, di
06321  f3 a5                rep movsw word ptr es:[di], word ptr [si]
06323  5f                   pop di
06324  81 c7 40 01          add di, 0x140
06328  8b ca                mov cx, dx
0632a  e2 ee                loop loc_631a
0632c  50                   push ax
0632d  b8 7c 09             mov ax, 0x97c
06330  8e d8                mov ds, ax
06332  58                   pop ax
06333  c3                   ret

; ======== restaure_rect   (appelée depuis 00a9, 5e0f)
; recopie dans le tampon le rectangle DI (BP largeur, CX lignes) depuis la copie DS:5E35 ; VGA en 0x63C3, table DS:3F7A
06334  50                   push ax
06335  b8 63 14             mov ax, 0x1463
06338  8e c0                mov es, ax
0633a  58                   pop ax
0633b  bb 7a 3f             mov bx, 0x3f7a
0633e  03 1e 90 31          add bx, word ptr [0x3190]    ; mode_video
06342  ff 27                jmp word ptr [bx]
loc_6344:
06344  1e                   push ds
06345  e8 94 d7             call adresse_ega
06348  8b 3e fb 37          mov di, word ptr [0x37fb]    ; adresse_plane
0634c  d1 ed                shr bp, 1
0634e  d1 ed                shr bp, 1
06350  d1 ed                shr bp, 1
06352  83 3e f9 37 00       cmp word ptr [0x37f9], 0    ; rang_pixel
06357  74 01                je loc_635a
06359  45                   inc bp
loc_635a:
0635a  50                   push ax
0635b  a1 35 5e             mov ax, word ptr [0x5e35]    ; seg_furn
0635e  8e d8                mov ds, ax
06360  58                   pop ax
06361  bb 28 00             mov bx, 0x28
06364  2b dd                sub bx, bp
06366  8b d1                mov dx, cx
loc_6368:
06368  8b f7                mov si, di
0636a  8b cd                mov cx, bp
0636c  f3 a4                rep movsb byte ptr es:[di], byte ptr [si]
0636e  03 fb                add di, bx
06370  8b f7                mov si, di
06372  8b cd                mov cx, bp
06374  f3 a4                rep movsb byte ptr es:[di], byte ptr [si]
06376  03 fb                add di, bx
06378  8b f7                mov si, di
0637a  8b cd                mov cx, bp
0637c  f3 a4                rep movsb byte ptr es:[di], byte ptr [si]
0637e  03 fb                add di, bx
06380  8b f7                mov si, di
06382  8b cd                mov cx, bp
06384  f3 a4                rep movsb byte ptr es:[di], byte ptr [si]
06386  03 fb                add di, bx
06388  4a                   dec dx
06389  75 dd                jne loc_6368
0638b  1f                   pop ds
0638c  c3                   ret
loc_638d:
0638d  1e                   push ds
0638e  e8 86 d7             call adresse_tandy
06391  8b 3e fb 37          mov di, word ptr [0x37fb]    ; adresse_plane
06395  d1 ed                shr bp, 1
06397  83 3e f9 37 01       cmp word ptr [0x37f9], 1    ; rang_pixel
0639c  75 01                jne loc_639f
0639e  45                   inc bp
loc_639f:
0639f  50                   push ax
063a0  a1 35 5e             mov ax, word ptr [0x5e35]    ; seg_furn
063a3  8e d8                mov ds, ax
063a5  58                   pop ax
063a6  8b d1                mov dx, cx
loc_63a8:
063a8  8b f7                mov si, di
063aa  8b cd                mov cx, bp
063ac  57                   push di
063ad  f3 a4                rep movsb byte ptr es:[di], byte ptr [si]
063af  5f                   pop di
063b0  81 c7 00 20          add di, 0x2000
063b4  f7 c7 00 80          test di, 0x8000
063b8  74 04                je loc_63be
063ba  81 ef 60 7f          sub di, 0x7f60
loc_63be:
063be  4a                   dec dx
063bf  75 e7                jne loc_63a8
063c1  1f                   pop ds
063c2  c3                   ret
loc_63c3:
063c3  50                   push ax
063c4  a1 35 5e             mov ax, word ptr [0x5e35]    ; seg_furn
063c7  8e d8                mov ds, ax
063c9  58                   pop ax
063ca  bb 40 01             mov bx, 0x140
063cd  2b dd                sub bx, bp
loc_63cf:
063cf  8b d1                mov dx, cx
063d1  8b cd                mov cx, bp
063d3  8b f7                mov si, di
063d5  f3 a4                rep movsb byte ptr es:[di], byte ptr [si]
063d7  03 fb                add di, bx
063d9  8b ca                mov cx, dx
063db  e2 f2                loop loc_63cf
063dd  50                   push ax
063de  b8 7c 09             mov ax, 0x97c
063e1  8e d8                mov ds, ax
063e3  58                   pop ax
063e4  c3                   ret

; ======== lit_commandes_al   (appelée depuis 0ce9, 6401)
; remet commandes à 0, appelle lit_commandes et rend commandes dans AL
063e5  c6 06 92 39 00       mov byte ptr [0x3992], 0    ; commandes
063ea  e8 65 d3             call lit_commandes
063ed  a0 92 39             mov al, byte ptr [0x3992]    ; commandes
063f0  c3                   ret

; ======== affiche_chaine   (appelée depuis 9284)
; SI = numéro de message : affiche sa chaîne par affiche_texte, sans changer la couleur
063f1  8b ac c1 5f          mov bp, word ptr [si + 0x5fc1]    ; textes
063f5  81 c5 c1 5f          add bp, 0x5fc1    ; textes
063f9  e9 80 cd             jmp affiche_texte

; ======== curseur_memorise   (appelée depuis 0413, 0866, 0cbb, 2cf9, 73b9, 783c, 7e10, 8035)
; copie curseur_x et curseur_y dans DS:47E7
063fc  80 3e c2 3f 00       cmp byte ptr [0x3fc2], 0    ; piege_en_cours
06401  e8 e1 ff             call lit_commandes_al
06404  bb e7 47             mov bx, 0x47e7
06407  a1 93 39             mov ax, word ptr [0x3993]    ; curseur_x
0640a  89 07                mov word ptr [bx], ax
0640c  a1 95 39             mov ax, word ptr [0x3995]    ; curseur_y
0640f  89 47 02             mov word ptr [bx + 2], ax
06412  c3                   ret

; ======== commandes_tour   (appelée depuis 0416)
; rien pendant un piège ou un pas en file (DS:3FC8) ; si un pas est en cours (DS:3F98), attend la fin de son animation (sprite à l'état 2, DS:40CC) ; puis clic_tour
06413  80 3e c2 3f 00       cmp byte ptr [0x3fc2], 0    ; piege_en_cours
06418  74 01                je loc_641b
0641a  c3                   ret
loc_641b:
0641b  80 3e c8 3f 00       cmp byte ptr [0x3fc8], 0    ; pas_en_file
06420  74 01                je loc_6423
06422  c3                   ret
loc_6423:
06423  a0 98 3f             mov al, byte ptr [0x3f98]    ; pas_en_cours
06426  0a c0                or al, al
06428  74 17                je clic_tour
0642a  8b 1e 39 46          mov bx, word ptr [0x4639]    ; sprite_courant
0642e  80 3f 02             cmp byte ptr [bx], 2
06431  75 01                jne loc_6434
06433  c3                   ret
loc_6434:
06434  80 3e cc 40 ff       cmp byte ptr [0x40cc], 0xff    ; direction_pas
06439  74 01                je loc_643c
0643b  c3                   ret
loc_643c:
0643c  c6 06 98 3f 00       mov byte ptr [0x3f98], 0    ; pas_en_cours

; ======== clic_tour   (appelée depuis 7ec2)
; bouton gauche : attend le relâchement, puis routine de la zone sous le curseur (zones_actives +8 ; DI fiche, SI sprite) ; hors des zones : clic_plateau
06441  f6 06 92 39 10       test byte ptr [0x3992], 0x10    ; commandes
06446  75 01                jne loc_6449
06448  c3                   ret
loc_6449:
06449  e8 e2 d4             call attend_clic
0644c  e8 58 00             call zone_panneau
0644f  83 3c ff             cmp word ptr [si], -1
06452  75 03                jne loc_6457
06454  e9 5f 03             jmp clic_plateau
loc_6457:
06457  8d 5c 08             lea bx, [si + 8]
0645a  8b 3e 37 46          mov di, word ptr [0x4637]    ; fiche_heros_courant
0645e  8b 36 39 46          mov si, word ptr [0x4639]    ; sprite_courant
06462  ff 27                jmp word ptr [bx]

; ======== survol_icones   (appelée depuis 0443)
; relâche les icônes enfoncées (relache_icones), puis l'icône de la zone sous le curseur (table DS:41F3) passe de 0Bh à 1Ch (enfoncée)
06464  e8 40 00             call zone_panneau
06467  83 3c ff             cmp word ptr [si], -1
0646a  74 20                je relache_icones
0646c  e8 1d 00             call relache_icones
0646f  bb f3 41             mov bx, 0x41f3    ; icone_de_zone
06472  d7                   xlatb
06473  be 77 42             mov si, 0x4277    ; icones_panneau
06476  b2 0c                mov dl, 0xc
06478  f6 e2                mul dl
0647a  03 f0                add si, ax
0647c  80 7c 06 0b          cmp byte ptr [si + 6], 0xb
06480  74 01                je loc_6483
06482  c3                   ret
loc_6483:
06483  c6 44 06 1c          mov byte ptr [si + 6], 0x1c
06487  c6 44 07 01          mov byte ptr [si + 7], 1
0648b  c3                   ret

; ======== relache_icones   (appelée depuis 646c)
; l'icône enfoncée (état 1Ch) revient à 0Bh, à redessiner
0648c  b9 0c 00             mov cx, 0xc
0648f  be 77 42             mov si, 0x4277    ; icones_panneau
loc_6492:
06492  80 7c 06 1c          cmp byte ptr [si + 6], 0x1c
06496  74 06                je loc_649e
06498  83 c6 0c             add si, 0xc
0649b  e2 f5                loop loc_6492
0649d  c3                   ret
loc_649e:
0649e  c6 44 06 0b          mov byte ptr [si + 6], 0xb
064a2  c6 44 07 01          mov byte ptr [si + 7], 1
064a6  c3                   ret

; ======== zone_panneau   (appelée depuis 644c, 6464)
; SI = zone sous le curseur dans la table DS:4635, CF posé si trouvée
064a7  33 c0                xor ax, ax
064a9  8b 16 e7 47          mov dx, word ptr [0x47e7]
064ad  8b 2e e9 47          mov bp, word ptr [0x47e9]
064b1  8b 36 35 46          mov si, word ptr [0x4635]    ; zones_actives
loc_64b5:
064b5  83 3c ff             cmp word ptr [si], -1
064b8  75 01                jne loc_64bb
064ba  c3                   ret
loc_64bb:
064bb  3b 14                cmp dx, word ptr [si]
064bd  72 11                jb loc_64d0
064bf  3b 54 02             cmp dx, word ptr [si + 2]
064c2  77 0c                ja loc_64d0
064c4  3b 6c 04             cmp bp, word ptr [si + 4]
064c7  72 07                jb loc_64d0
064c9  3b 6c 06             cmp bp, word ptr [si + 6]
064cc  77 02                ja loc_64d0
064ce  f9                   stc
064cf  c3                   ret
loc_64d0:
064d0  83 c6 0a             add si, 0xa
064d3  40                   inc ax
064d4  eb df                jmp loc_64b5

; ======== affiche_or   (appelée depuis 651b, 6d18)
; or du héros courant dans le texte DS:44E3
064d6  bd e3 44             mov bp, 0x44e3    ; texte_or
064d9  8b 3e 37 46          mov di, word ptr [0x4637]    ; fiche_heros_courant

; ======== affiche_or_fiche   (appelée depuis 816c)
; or de la fiche DI en 4 chiffres (+3 à +6 du texte BP), couleur 0Fh sans fond ; l'armurerie l'appelle avec BP = DS:AC87
064dd  8b 5d 09             mov bx, word ptr [di + 9]
064e0  ba e8 03             mov dx, 0x3e8
064e3  e8 23 00             call chiffre_decimal
064e6  3e 88 46 03          mov byte ptr ds:[bp + 3], al
064ea  ba 64 00             mov dx, 0x64
064ed  e8 19 00             call chiffre_decimal
064f0  3e 88 46 04          mov byte ptr ds:[bp + 4], al
064f4  ba 0a 00             mov dx, 0xa
064f7  e8 0f 00             call chiffre_decimal
064fa  3e 88 46 05          mov byte ptr ds:[bp + 5], al
064fe  b0 30                mov al, 0x30
06500  02 c3                add al, bl
06502  3e 88 46 06          mov byte ptr ds:[bp + 6], al
06506  eb 3f                jmp loc_6547
; ---- 1 octets non atteints (6508-6508)

; ======== chiffre_decimal   (appelée depuis 64e3, 64ed, 64f7)
; AL = '0' + nombre de fois que DX entre dans BX ; BX = reste
06509  32 c0                xor al, al
loc_650b:
0650b  1b da                sbb bx, dx
0650d  72 04                jb loc_6513
0650f  fe c0                inc al
06511  eb f8                jmp loc_650b
loc_6513:
06513  03 da                add bx, dx
06515  04 30                add al, 0x30
06517  c3                   ret

; ======== affiche_valeurs_fiche   (appelée depuis 0446, 2079, 89c1)
; panneau : corps et esprit, or, déplacement restant (2 chiffres, texte DS:44EB)
06518  e8 39 00             call affiche_corps_esprit
0651b  e8 b8 ff             call affiche_or
0651e  bd eb 44             mov bp, 0x44eb    ; texte_deplacement
06521  a0 9c 3f             mov al, byte ptr [0x3f9c]    ; deplacement_restant
06524  b5 00                mov ch, 0
loc_6526:
06526  3c 0a                cmp al, 0xa
06528  72 06                jb loc_6530
0652a  2c 0a                sub al, 0xa
0652c  fe c5                inc ch
0652e  eb f6                jmp loc_6526
loc_6530:
06530  8a e0                mov ah, al
06532  8a c5                mov al, ch
06534  04 30                add al, 0x30
06536  3c 30                cmp al, 0x30
06538  75 02                jne loc_653c
0653a  b0 20                mov al, 0x20
loc_653c:
0653c  3e 88 46 03          mov byte ptr ds:[bp + 3], al
06540  80 c4 30             add ah, 0x30
06543  3e 88 66 04          mov byte ptr ds:[bp + 4], ah
loc_6547:
06547  c6 06 50 37 0f       mov byte ptr [0x3750], 0xf    ; couleur_texte
0654c  c6 06 59 37 01       mov byte ptr [0x3759], 1    ; texte_transparent
06551  e9 28 cc             jmp affiche_texte

; ======== affiche_corps_esprit   (appelée depuis 6518)
; un chiffre pour +6 (corps) et +7 (esprit) de la fiche, texte DS:44F1
06554  bd f1 44             mov bp, 0x44f1    ; texte_corps_esprit
06557  8b 3e 37 46          mov di, word ptr [0x4637]    ; fiche_heros_courant
0655b  8a 45 06             mov al, byte ptr [di + 6]
0655e  04 30                add al, 0x30
06560  3e 88 46 03          mov byte ptr ds:[bp + 3], al
06564  8a 45 07             mov al, byte ptr [di + 7]
06567  04 30                add al, 0x30
06569  3e 88 46 07          mov byte ptr ds:[bp + 7], al
0656d  eb d8                jmp loc_6547

; ======== sauve_tampon   (appelée depuis 03cc, 03fe, 0410, 054e, 0996, 09ac, 1059, 12f0)
; copie le tampon (64 000 octets en VGA) vers le segment DS:5E35
0656f  50                   push ax
06570  a1 35 5e             mov ax, word ptr [0x5e35]    ; seg_furn
06573  8e c0                mov es, ax
06575  58                   pop ax
06576  33 ff                xor di, di
06578  33 f6                xor si, si
0657a  b9 00 7d             mov cx, 0x7d00
0657d  83 3e 90 31 08       cmp word ptr [0x3190], 8    ; mode_video
06582  74 03                je loc_6587
06584  b9 00 40             mov cx, 0x4000
loc_6587:
06587  50                   push ax
06588  b8 63 14             mov ax, 0x1463
0658b  8e d8                mov ds, ax
0658d  58                   pop ax
0658e  f3 a5                rep movsw word ptr es:[di], word ptr [si]
06590  50                   push ax
06591  b8 7c 09             mov ax, 0x97c
06594  8e d8                mov ds, ax
06596  58                   pop ax
06597  c3                   ret

; ======== restaure_tampon_combat   (appelée depuis 2003)
; inverse de sauve_tampon : recopie DS:5E35 dans le tampon (64 000 octets en VGA)
06598  50                   push ax
06599  b8 63 14             mov ax, 0x1463
0659c  8e c0                mov es, ax
0659e  58                   pop ax
0659f  33 ff                xor di, di
065a1  33 f6                xor si, si
065a3  b9 00 7d             mov cx, 0x7d00
065a6  83 3e 90 31 08       cmp word ptr [0x3190], 8    ; mode_video
065ab  74 03                je loc_65b0
065ad  b9 00 40             mov cx, 0x4000
loc_65b0:
065b0  50                   push ax
065b1  a1 35 5e             mov ax, word ptr [0x5e35]    ; seg_furn
065b4  8e d8                mov ds, ax
065b6  58                   pop ax
065b7  f3 a5                rep movsw word ptr es:[di], word ptr [si]
065b9  50                   push ax
065ba  b8 7c 09             mov ax, 0x97c
065bd  8e d8                mov ds, ax
065bf  58                   pop ax
065c0  c3                   ret

; ======== init_sprites_icones   (appelée depuis 0134, 0254, 0535, 12c8, 182a, 1fce)
; vide les 14 sprites (DS:4BC6), les 10 premiers en 24 × 40 avec SHOPSP ; recopie les 12 icônes de DS:41FF (10 octets) dans icones_panneau
065c1  50                   push ax
065c2  b8 7c 09             mov ax, 0x97c
065c5  8e c0                mov es, ax
065c7  58                   pop ax
065c8  bf c6 4b             mov di, 0x4bc6    ; sprites
065cb  b9 42 01             mov cx, 0x142
065ce  49                   dec cx
065cf  d1 e9                shr cx, 1
065d1  33 c0                xor ax, ax
065d3  f3 ab                rep stosw word ptr es:[di], ax
065d5  bf c6 4b             mov di, 0x4bc6    ; sprites
065d8  c7 45 0c 00 00       mov word ptr [di + 0xc], 0
065dd  b9 0a 00             mov cx, 0xa
loc_65e0:
065e0  c6 45 06 18          mov byte ptr [di + 6], 0x18
065e4  c6 45 07 28          mov byte ptr [di + 7], 0x28
065e8  a1 25 5e             mov ax, word ptr [0x5e25]    ; seg_shopsp
065eb  89 45 08             mov word ptr [di + 8], ax
065ee  83 c7 17             add di, 0x17
065f1  e2 ed                loop loc_65e0
065f3  b9 0c 00             mov cx, 0xc
065f6  bf 77 42             mov di, 0x4277    ; icones_panneau
065f9  be ff 41             mov si, 0x41ff    ; icones_depart
loc_65fc:
065fc  ad                   lodsw ax, word ptr [si]
065fd  89 05                mov word ptr [di], ax
065ff  ad                   lodsw ax, word ptr [si]
06600  89 45 02             mov word ptr [di + 2], ax
06603  ad                   lodsw ax, word ptr [si]
06604  88 45 04             mov byte ptr [di + 4], al
06607  88 65 05             mov byte ptr [di + 5], ah
0660a  ad                   lodsw ax, word ptr [si]
0660b  89 45 08             mov word ptr [di + 8], ax
0660e  ad                   lodsw ax, word ptr [si]
0660f  89 45 0a             mov word ptr [di + 0xa], ax
06612  c6 45 07 01          mov byte ptr [di + 7], 1
06616  83 c7 0c             add di, 0xc
06619  e2 e1                loop loc_65fc
0661b  c3                   ret

; ======== affiche_nom_portrait   (appelée depuis 039f, 0545, 12c5, 1836, 5d78, 6f9e)
; nom du personnage courant (noms_heros) et son portrait 32 × 45 d'ODDS&SOD (table DS:41E9) en (0, 12)
0661c  be e1 45             mov si, 0x45e1
0661f  e8 82 fa             call affiche_texte_si
06622  a0 a7 3f             mov al, byte ptr [0x3fa7]    ; personnage_courant
06625  50                   push ax
06626  bb d7 45             mov bx, 0x45d7    ; noms_heros
06629  e8 af fa             call mot_table
0662c  8b 37                mov si, word ptr [bx]
0662e  e8 83 fa             call affiche_texte_sans_fond
06631  5b                   pop bx
06632  02 db                add bl, bl
06634  32 ff                xor bh, bh
06636  8b b7 e9 41          mov si, word ptr [bx + 0x41e9]    ; portraits
0663a  bf 00 0f             mov di, 0xf00
0663d  bd 20 00             mov bp, 0x20
06640  b9 2d 00             mov cx, 0x2d
06643  1e                   push ds
06644  a1 2d 5e             mov ax, word ptr [0x5e2d]    ; seg_odds
06647  a3 4e 37             mov word ptr [0x374e], ax    ; segment_source
0664a  50                   push ax
0664b  b8 63 14             mov ax, 0x1463
0664e  8e c0                mov es, ax
06650  58                   pop ax
06651  e8 ff d4             call copie_image
06654  1f                   pop ds
06655  c3                   ret
loc_6656:
06656  8b de                mov bx, si
06658  e8 92 22             call affiche_message

; ======== affiche_et_pause   (appelée depuis 94f1)
; affiche_tampon, puis pause_150
0665b  e8 86 fa             call affiche_tampon

; ======== pause_150   (appelée depuis 0a35, 1a4a, 25a5)
; attente active : temporise avec CX = 150 (boucles de 1000 nop)
0665e  b9 96 00             mov cx, 0x96
06661  e9 23 e0             jmp temporise
loc_6664:
06664  be 4a 4d             mov si, 0x4d4a    ; monstres
06667  b9 20 00             mov cx, 0x20
loc_666a:
0666a  80 3c 00             cmp byte ptr [si], 0
0666d  74 0b                je loc_667a
0666f  a0 94 3f             mov al, byte ptr [0x3f94]    ; zone_heros
06672  3a 44 03             cmp al, byte ptr [si + 3]
06675  75 03                jne loc_667a
06677  80 24 7f             and byte ptr [si], 0x7f
loc_667a:
0667a  83 c6 0a             add si, 0xa
0667d  e2 eb                loop loc_666a
0667f  c3                   ret

; ======== dessine_icones_fiche   (appelée depuis 040a, 0548, 12d1, 1839, 5d7b)
; 4 icônes 16 × 16 d'ODDS&SOD à gauche des valeurs du panneau : 0x5F20 or (40, 11), 0x5D20 déplacement (40, 30), 0x5E20 corps (96, 11), 0x6020 esprit (96, 30)
06680  be 20 5f             mov si, 0x5f20
06683  bf e8 0d             mov di, 0xde8
06686  a1 2d 5e             mov ax, word ptr [0x5e2d]    ; seg_odds
06689  a3 4e 37             mov word ptr [0x374e], ax    ; segment_source
0668c  50                   push ax
0668d  b8 63 14             mov ax, 0x1463
06690  8e c0                mov es, ax
06692  58                   pop ax
06693  bd 10 00             mov bp, 0x10
06696  b9 10 00             mov cx, 0x10
06699  1e                   push ds
0669a  e8 b6 d4             call copie_image
0669d  1f                   pop ds
0669e  be 20 5d             mov si, 0x5d20
066a1  bf a8 25             mov di, 0x25a8
066a4  a1 2d 5e             mov ax, word ptr [0x5e2d]    ; seg_odds
066a7  a3 4e 37             mov word ptr [0x374e], ax    ; segment_source
066aa  50                   push ax
066ab  b8 63 14             mov ax, 0x1463
066ae  8e c0                mov es, ax
066b0  58                   pop ax
066b1  bd 10 00             mov bp, 0x10
066b4  b9 10 00             mov cx, 0x10
066b7  1e                   push ds
066b8  e8 98 d4             call copie_image
066bb  1f                   pop ds
066bc  be 20 5e             mov si, 0x5e20
066bf  bf 20 0e             mov di, 0xe20
066c2  a1 2d 5e             mov ax, word ptr [0x5e2d]    ; seg_odds
066c5  a3 4e 37             mov word ptr [0x374e], ax    ; segment_source
066c8  50                   push ax
066c9  b8 63 14             mov ax, 0x1463
066cc  8e c0                mov es, ax
066ce  58                   pop ax
066cf  bd 10 00             mov bp, 0x10
066d2  b9 10 00             mov cx, 0x10
066d5  1e                   push ds
066d6  e8 7a d4             call copie_image
066d9  1f                   pop ds
066da  be 20 60             mov si, 0x6020
066dd  bf e0 25             mov di, 0x25e0
066e0  a1 2d 5e             mov ax, word ptr [0x5e2d]    ; seg_odds
066e3  a3 4e 37             mov word ptr [0x374e], ax    ; segment_source
066e6  50                   push ax
066e7  b8 63 14             mov ax, 0x1463
066ea  8e c0                mov es, ax
066ec  58                   pop ax
066ed  bd 10 00             mov bp, 0x10
066f0  b9 10 00             mov cx, 0x10
066f3  1e                   push ds
066f4  e8 5c d4             call copie_image
066f7  1f                   pop ds
066f8  c3                   ret

; ======== tirage_deplacement   (appelée depuis 03d8, 0401)
; fait clignoter le sprite du héros et tourne les dés (lancer_deplacement) jusqu'à un clic, attend la fin de l'animation des dés (DS:4B6F = 1) ; au-delà de 24, 5 ; sert aussi au dé du réveil
066f9  c6 06 90 3f 00       mov byte ptr [0x3f90], 0
066fe  c6 06 6f 4b 00       mov byte ptr [0x4b6f], 0    ; image_des_courante
06703  e8 0e f1             call anime_sprites
06706  e8 4b d2             call attend_relache_boutons
06709  e8 0a 02             call ordre_trace_heros
0670c  e8 6a f0             call ordonne_sprites
loc_670f:
0670f  fe 06 90 3f          inc byte ptr [0x3f90]
06713  80 26 90 3f 07       and byte ptr [0x3f90], 7
06718  a0 90 3f             mov al, byte ptr [0x3f90]
0671b  d0 e8                shr al, 1
0671d  d0 e8                shr al, 1
0671f  0a c0                or al, al
06721  8b 1e 39 46          mov bx, word ptr [0x4639]    ; sprite_courant
06725  88 07                mov byte ptr [bx], al
06727  e8 8e f0             call dessine_sprites
lancer_deplacement:    ; somme de DS:3FC4 dés à 6 faces dans DS:3F9C
0672a  8a 0e c4 3f          mov cl, byte ptr [0x3fc4]    ; des_deplacement
0672e  32 ed                xor ch, ch
06730  88 2e 9c 3f          mov byte ptr [0x3f9c], ch    ; deplacement_restant
loc_6734:
06734  b3 06                mov bl, 6
06736  e8 da ce             call hasard
06739  00 06 9c 3f          add byte ptr [0x3f9c], al    ; deplacement_restant
0673d  e2 f5                loop loc_6734
0673f  e8 59 e8             call image_des
06742  e8 70 f1             call restaure_tampon
06745  e8 0a d0             call lit_commandes
06748  f6 06 92 39 10       test byte ptr [0x3992], 0x10    ; commandes
0674d  74 c0                je loc_670f
0674f  8b 1e 39 46          mov bx, word ptr [0x4639]    ; sprite_courant
06753  c6 07 01             mov byte ptr [bx], 1
06756  e8 5f f0             call dessine_sprites
06759  e8 3f e8             call image_des
loc_675c:
0675c  80 3e 6f 4b 01       cmp byte ptr [0x4b6f], 1    ; image_des_courante
06761  74 05                je loc_6768
06763  e8 35 e8             call image_des
06766  eb f4                jmp loc_675c
loc_6768:
06768  e8 e9 d1             call attend_relache_boutons
0676b  80 3e 9c 3f 18       cmp byte ptr [0x3f9c], 0x18    ; deplacement_restant
06770  76 05                jbe loc_6777
06772  c6 06 9c 3f 05       mov byte ptr [0x3f9c], 5    ; deplacement_restant
loc_6777:
06777  51                   push cx
06778  b9 04 00             mov cx, 4
loc_677b:
0677b  e8 22 cf             call attend_retour_vertical
0677e  e2 fb                loop loc_677b
06780  59                   pop cx
06781  e9 31 f1             jmp restaure_tampon

; ======== pas_automatique   (appelée depuis 0428)
; si le sprite n'est pas animé et qu'il reste des pas en file (DS:3FC8), joue le suivant (direction lue en DS:3FCC, table deplacements)
06784  8b 1e 39 46          mov bx, word ptr [0x4639]    ; sprite_courant
06788  8a 07                mov al, byte ptr [bx]
0678a  3c 02                cmp al, 2
0678c  75 01                jne loc_678f
0678e  c3                   ret
loc_678f:
0678f  a0 c8 3f             mov al, byte ptr [0x3fc8]    ; pas_en_file
06792  0a c0                or al, al
06794  75 01                jne loc_6797
06796  c3                   ret
loc_6797:
06797  fe c8                dec al
06799  a2 c8 3f             mov byte ptr [0x3fc8], al    ; pas_en_file
0679c  8b 1e cc 3f          mov bx, word ptr [0x3fcc]    ; prochain_pas
067a0  ff 06 cc 3f          inc word ptr [0x3fcc]    ; prochain_pas
067a4  8a 1f                mov bl, byte ptr [bx]
067a6  32 ff                xor bh, bh
067a8  d1 e3                shl bx, 1
067aa  8b 3e 37 46          mov di, word ptr [0x4637]    ; fiche_heros_courant
067ae  8b 36 39 46          mov si, word ptr [0x4639]    ; sprite_courant
067b2  ff a7 f9 40          jmp word ptr [bx + 0x40f9]    ; deplacements
clic_plateau:    ; case la plus proche du curseur (position_cases, 52 cases, écart < 8) ; si elle est libre, chemin depuis le héros (chemin_heros) et file de pas en DS:4013
067b6  8b 16 e7 47          mov dx, word ptr [0x47e7]
067ba  8b 2e e9 47          mov bp, word ptr [0x47e9]
067be  bb 2d 40             mov bx, 0x402d
067c1  be 19 41             mov si, 0x4119    ; position_cases
067c4  b9 34 00             mov cx, 0x34
loc_67c7:
067c7  51                   push cx
067c8  8b 44 02             mov ax, word ptr [si + 2]
067cb  05 18 00             add ax, 0x18
067ce  2b c2                sub ax, dx
067d0  73 02                jae loc_67d4
067d2  f7 d8                neg ax
loc_67d4:
067d4  d1 e8                shr ax, 1
067d6  8b 0c                mov cx, word ptr [si]
067d8  83 c1 08             add cx, 8
067db  2b cd                sub cx, bp
067dd  73 02                jae loc_67e1
067df  f7 d9                neg cx
loc_67e1:
067e1  03 c1                add ax, cx
067e3  d1 e8                shr ax, 1
067e5  89 07                mov word ptr [bx], ax
067e7  83 c3 02             add bx, 2
067ea  83 c6 04             add si, 4
067ed  59                   pop cx
067ee  e2 d7                loop loc_67c7
067f0  bb 2d 40             mov bx, 0x402d
067f3  b8 ff ff             mov ax, 0xffff
067f6  b9 34 00             mov cx, 0x34
loc_67f9:
067f9  3b 07                cmp ax, word ptr [bx]
067fb  72 04                jb loc_6801
067fd  8b 07                mov ax, word ptr [bx]
067ff  8b d1                mov dx, cx
loc_6801:
06801  83 c3 02             add bx, 2
06804  e2 f3                loop loc_67f9
06806  3d 08 00             cmp ax, 8
06809  72 01                jb loc_680c
0680b  c3                   ret
loc_680c:
0680c  bb 34 00             mov bx, 0x34
0680f  2b da                sub bx, dx
06811  83 fb 2d             cmp bx, 0x2d
06814  72 0b                jb loc_6821
06816  83 eb 2d             sub bx, 0x2d
06819  d1 e3                shl bx, 1
0681b  8b 8f 03 4a          mov cx, word ptr [bx + 0x4a03]
0681f  eb 06                jmp loc_6827
loc_6821:
06821  8a 8f d6 49          mov cl, byte ptr [bx + 0x49d6]    ; ordre_cases_vue
06825  32 ed                xor ch, ch
loc_6827:
06827  a1 e4 3f             mov ax, word ptr [0x3fe4]    ; case_coin_zone
0682a  03 c1                add ax, cx
0682c  2d 6f 54             sub ax, 0x546f    ; grille_zones
0682f  8b d8                mov bx, ax
06831  81 c3 6f 56          add bx, 0x566f
06835  3b 1e 11 0e          cmp bx, word ptr [0xe11]    ; case_avant_porte
06839  75 01                jne loc_683c
0683b  c3                   ret
loc_683c:
0683c  8b d8                mov bx, ax
0683e  b5 00                mov ch, 0
loc_6840:
06840  3d 1a 00             cmp ax, 0x1a
06843  72 07                jb loc_684c
06845  2d 1a 00             sub ax, 0x1a
06848  fe c5                inc ch
0684a  eb f4                jmp loc_6840
loc_684c:
0684c  8a c8                mov cl, al
0684e  8a 87 6f 54          mov al, byte ptr [bx + 0x546f]    ; grille_zones
06852  24 3f                and al, 0x3f
06854  75 01                jne loc_6857
06856  c3                   ret
loc_6857:
06857  80 bf 6f 58 00       cmp byte ptr [bx + 0x586f], 0    ; grille_occupants
0685c  75 03                jne loc_6861
0685e  eb 11                jmp loc_6871
; ---- 1 octets non atteints (6860-6860)
loc_6861:
06861  80 bf 6f 58 32       cmp byte ptr [bx + 0x586f], 0x32    ; grille_occupants
06866  75 01                jne loc_6869
06868  c3                   ret
loc_6869:
06869  80 bf 6f 58 40       cmp byte ptr [bx + 0x586f], 0x40    ; grille_occupants
0686e  72 01                jb loc_6871
06870  c3                   ret
loc_6871:
06871  8b d1                mov dx, cx
06873  51                   push cx
06874  e8 10 aa             call personnage_en_dx
06877  59                   pop cx
06878  0a c0                or al, al
0687a  74 01                je loc_687d
0687c  c3                   ret
loc_687d:
0687d  8b 3e 37 46          mov di, word ptr [0x4637]    ; fiche_heros_courant
06881  88 0e f0 3f          mov byte ptr [0x3ff0], cl    ; chemin_cible_x
06885  88 2e f1 3f          mov byte ptr [0x3ff1], ch
06889  8a 45 01             mov al, byte ptr [di + 1]
0688c  a2 ee 3f             mov byte ptr [0x3fee], al    ; chemin_depart_x
0688f  a2 f5 3f             mov byte ptr [0x3ff5], al    ; chemin_case_x
06892  8a 45 02             mov al, byte ptr [di + 2]
06895  a2 ef 3f             mov byte ptr [0x3fef], al
06898  a2 f6 3f             mov byte ptr [0x3ff6], al
0689b  e8 0e c5             call chemin_heros
0689e  80 3e c8 3f 00       cmp byte ptr [0x3fc8], 0    ; pas_en_file
068a3  75 01                jne loc_68a6
068a5  c3                   ret
loc_68a6:
068a6  bb 13 40             mov bx, 0x4013    ; chemin_trouve
068a9  89 1e cc 3f          mov word ptr [0x3fcc], bx    ; prochain_pas
068ad  c3                   ret

; ======== des_deplacement_tour   (appelée depuis 03a5)
; nombre de dés de déplacement du tour (plates, objet porté, rapidité, vent rapide)
068ae  8b 3e 37 46          mov di, word ptr [0x4637]    ; fiche_heros_courant
068b2  c6 06 9a 3f 00       mov byte ptr [0x3f9a], 0    ; fin_du_tour
068b7  c6 06 9b 3f 00       mov byte ptr [0x3f9b], 0    ; etat_action
068bc  c6 06 c4 3f 02       mov byte ptr [0x3fc4], 2    ; des_deplacement
068c1  f6 45 13 08          test byte ptr [di + 0x13], 8
068c5  75 06                jne loc_68cd
068c7  f6 45 0f 40          test byte ptr [di + 0xf], 0x40
068cb  74 0b                je loc_68d8
loc_68cd:
068cd  80 3e a7 3f 04       cmp byte ptr [0x3fa7], 4    ; personnage_courant
068d2  74 04                je loc_68d8
068d4  fe 0e c4 3f          dec byte ptr [0x3fc4]    ; des_deplacement
loc_68d8:
068d8  f6 45 17 20          test byte ptr [di + 0x17], 0x20
068dc  74 0c                je loc_68ea
068de  80 65 17 df          and byte ptr [di + 0x17], 0xdf
068e2  80 65 10 df          and byte ptr [di + 0x10], 0xdf
068e6  d0 26 c4 3f          shl byte ptr [0x3fc4], 1    ; des_deplacement
loc_68ea:
068ea  f6 45 18 08          test byte ptr [di + 0x18], 8
068ee  75 01                jne loc_68f1
068f0  c3                   ret
loc_68f1:
068f1  80 65 18 f7          and byte ptr [di + 0x18], 0xf7
068f5  d0 26 c4 3f          shl byte ptr [0x3fc4], 1    ; des_deplacement
068f9  80 3e c4 3f 06       cmp byte ptr [0x3fc4], 6    ; des_deplacement
068fe  76 05                jbe loc_6905
06900  c6 06 c4 3f 06       mov byte ptr [0x3fc4], 6    ; des_deplacement
loc_6905:
06905  c3                   ret

; ======== ajoute_or   (appelée depuis 0c85, 18d9, 1a2f, 6d15, 6f58, 6f66, 714b, 7195)
; ajoute DX pièces au héros courant (rien si l'or atteint déjà 9999)
06906  8b 3e 37 46          mov di, word ptr [0x4637]    ; fiche_heros_courant

; ======== ajoute_or_di   (appelée depuis 0c3e, 190c)
; même chose pour la fiche DI
0690a  81 7d 09 0f 27       cmp word ptr [di + 9], 0x270f
0690f  72 01                jb loc_6912
06911  c3                   ret
loc_6912:
06912  01 55 09             add word ptr [di + 9], dx
06915  c3                   ret

; ======== ordre_trace_heros   (appelée depuis 042e, 6709)
; si le sprite courant est animé (état 2) : +1 = 3 × rang de sa case + 1
06916  8b 3e 37 46          mov di, word ptr [0x4637]    ; fiche_heros_courant
0691a  8b 36 39 46          mov si, word ptr [0x4639]    ; sprite_courant
0691e  8a 04                mov al, byte ptr [si]
06920  3c 02                cmp al, 2
06922  74 01                je loc_6925
06924  c3                   ret
loc_6925:
06925  e8 0c 00             call rang_case_heros
06928  8a e8                mov ch, al
0692a  02 c0                add al, al
0692c  02 c5                add al, ch
0692e  fe c0                inc al
06930  88 44 01             mov byte ptr [si + 1], al
06933  c3                   ret

; ======== rang_case_heros   (appelée depuis 13b7, 6925)
; rang de tracé (table DS:4A11, 6 colonnes) de la case du personnage DI par rapport au coin de sa zone (DS:3FE0), dans index_case_courante
06934  8a 45 02             mov al, byte ptr [di + 2]
06937  8b 0e e0 3f          mov cx, word ptr [0x3fe0]    ; coin_zone
0693b  2a c5                sub al, ch
0693d  b2 06                mov dl, 6
0693f  f6 e2                mul dl
06941  8a d8                mov bl, al
06943  8a 45 01             mov al, byte ptr [di + 1]
06946  2a c1                sub al, cl
06948  02 d8                add bl, al
0694a  b7 00                mov bh, 0
0694c  81 c3 11 4a          add bx, 0x4a11    ; rang_cases_vue
06950  8a 07                mov al, byte ptr [bx]
06952  a2 93 3f             mov byte ptr [0x3f93], al    ; index_case_courante
06955  c3                   ret

; ======== charge_maps   (appelée depuis 0a38)
; recharge MAPS.VGA (ou MAPS.EGA) dans l'image annexe, en redemandant la disquette 3 si besoin ; après un combat
06956  83 3e 90 31 08       cmp word ptr [0x3190], 8    ; mode_video
0695b  75 63                jne loc_69c0
0695d  c7 06 07 39 66 5e    mov word ptr [0x3907], 0x5e66    ; fichier_nom, "maps.vga"
06963  c7 06 03 39 00 00    mov word ptr [0x3903], 0    ; fichier_offset
06969  b8 63 14             mov ax, 0x1463
0696c  a3 01 39             mov word ptr [0x3901], ax    ; fichier_segment
loc_696f:
0696f  c7 06 e9 37 00 00    mov word ptr [0x37e9], 0    ; erreur_fichier
06975  e8 79 cd             call clavier_retire
06978  e8 4d d0             call fichier_ouvre
0697b  83 3e e9 37 00       cmp word ptr [0x37e9], 0    ; erreur_fichier
06980  75 03                jne loc_6985
06982  eb 0f                jmp loc_6993
; ---- 1 octets non atteints (6984-6984)
loc_6985:
06985  e8 32 cd             call clavier_installe
06988  bb 52 02             mov bx, 0x252    ; message « INTRODUISEZ VOTRE / HEROQUEST DISQUETTE 3 »
0698b  e8 5f 1f             call affiche_message
0698e  e8 60 cd             call clavier_retire
06991  eb dc                jmp loc_696f
loc_6993:
06993  e8 66 d0             call fichier_lit
06996  83 3e e9 37 00       cmp word ptr [0x37e9], 0    ; erreur_fichier
0699b  75 e8                jne loc_6985
0699d  a3 05 39             mov word ptr [0x3905], ax    ; fichier_taille
069a0  e8 17 cd             call clavier_installe
069a3  a1 27 5e             mov ax, word ptr [0x5e27]    ; seg_annexe
069a6  8e c0                mov es, ax
069a8  33 f6                xor si, si
069aa  bf 00 00             mov di, 0
069ad  b8 63 14             mov ax, 0x1463
069b0  8e d8                mov ds, ax
069b2  b9 ff ff             mov cx, 0xffff
069b5  e8 19 dc             call lz_decompresse
069b8  50                   push ax
069b9  b8 7c 09             mov ax, 0x97c
069bc  8e d8                mov ds, ax
069be  58                   pop ax
069bf  c3                   ret
loc_69c0:
069c0  c7 06 07 39 02 5f    mov word ptr [0x3907], 0x5f02    ; fichier_nom, "maps.ega"
069c6  c7 06 03 39 00 00    mov word ptr [0x3903], 0    ; fichier_offset
069cc  b8 63 14             mov ax, 0x1463
069cf  a3 01 39             mov word ptr [0x3901], ax    ; fichier_segment
loc_69d2:
069d2  c7 06 e9 37 00 00    mov word ptr [0x37e9], 0    ; erreur_fichier
069d8  e8 16 cd             call clavier_retire
069db  e8 ea cf             call fichier_ouvre
069de  83 3e e9 37 00       cmp word ptr [0x37e9], 0    ; erreur_fichier
069e3  75 03                jne loc_69e8
069e5  eb 0f                jmp loc_69f6
; ---- 1 octets non atteints (69e7-69e7)
loc_69e8:
069e8  e8 cf cc             call clavier_installe
069eb  bb 52 02             mov bx, 0x252    ; message « INTRODUISEZ VOTRE / HEROQUEST DISQUETTE 3 »
069ee  e8 fc 1e             call affiche_message
069f1  e8 fd cc             call clavier_retire
069f4  eb dc                jmp loc_69d2
loc_69f6:
069f6  e8 03 d0             call fichier_lit
069f9  83 3e e9 37 00       cmp word ptr [0x37e9], 0    ; erreur_fichier
069fe  75 e8                jne loc_69e8
06a00  a3 05 39             mov word ptr [0x3905], ax    ; fichier_taille
06a03  e8 b4 cc             call clavier_installe
06a06  a1 27 5e             mov ax, word ptr [0x5e27]    ; seg_annexe
06a09  8e c0                mov es, ax
06a0b  33 f6                xor si, si
06a0d  bf 00 00             mov di, 0
06a10  b8 63 14             mov ax, 0x1463
06a13  8e d8                mov ds, ax
06a15  b9 ff ff             mov cx, 0xffff
06a18  e8 b6 db             call lz_decompresse
06a1b  50                   push ax
06a1c  b8 7c 09             mov ax, 0x97c
06a1f  8e d8                mov ds, ax
06a21  58                   pop ax
06a22  c3                   ret

; ======== fond_vers_tampon   (appelée depuis 021b, 0234, 0251, 039c, 0526, 12c2, 182d, 5d54)
; recopie l'écran de fond (DS:5E23) dans le tampon
06a23  50                   push ax
06a24  b8 63 14             mov ax, 0x1463
06a27  8e c0                mov es, ax
06a29  58                   pop ax
06a2a  83 3e 90 31 04       cmp word ptr [0x3190], 4    ; mode_video
06a2f  75 07                jne loc_6a38
06a31  50                   push ax
06a32  a1 35 5e             mov ax, word ptr [0x5e35]    ; seg_furn
06a35  8e c0                mov es, ax
06a37  58                   pop ax
loc_6a38:
06a38  50                   push ax
06a39  a1 23 5e             mov ax, word ptr [0x5e23]    ; seg_ecran
06a3c  8e d8                mov ds, ax
06a3e  58                   pop ax
06a3f  33 ff                xor di, di
06a41  8b f7                mov si, di
06a43  b9 ff ff             mov cx, 0xffff
06a46  e8 88 db             call lz_decompresse
06a49  50                   push ax
06a4a  b8 7c 09             mov ax, 0x97c
06a4d  8e d8                mov ds, ax
06a4f  58                   pop ax
06a50  83 3e 90 31 04       cmp word ptr [0x3190], 4    ; mode_video
06a55  74 03                je loc_6a5a
06a57  c3                   ret
; ---- 2 octets non atteints (6a58-6a59)
loc_6a5a:
06a5a  50                   push ax
06a5b  a1 35 5e             mov ax, word ptr [0x5e35]    ; seg_furn
06a5e  8e d8                mov ds, ax
06a60  58                   pop ax
06a61  50                   push ax
06a62  b8 63 14             mov ax, 0x1463
06a65  8e c0                mov es, ax
06a67  58                   pop ax
06a68  bf 00 00             mov di, 0
06a6b  be 00 00             mov si, 0
06a6e  2e c6 06 58 6a c8    mov byte ptr cs:[0x6a58], 0xc8
loc_6a74:
06a74  2e c6 06 59 6a 14    mov byte ptr cs:[0x6a59], 0x14
loc_6a7a:
06a7a  8a 64 78             mov ah, byte ptr [si + 0x78]
06a7d  8a 44 79             mov al, byte ptr [si + 0x79]
06a80  8b e8                mov bp, ax
06a82  8a 7c 50             mov bh, byte ptr [si + 0x50]
06a85  8a 5c 51             mov bl, byte ptr [si + 0x51]
06a88  8a 6c 28             mov ch, byte ptr [si + 0x28]
06a8b  8a 4c 29             mov cl, byte ptr [si + 0x29]
06a8e  8a 34                mov dh, byte ptr [si]
06a90  8a 54 01             mov dl, byte ptr [si + 1]
06a93  b8 00 00             mov ax, 0
06a96  d1 e2                shl dx, 1
06a98  d1 d0                rcl ax, 1
06a9a  d1 e1                shl cx, 1
06a9c  d1 d0                rcl ax, 1
06a9e  d1 e3                shl bx, 1
06aa0  d1 d0                rcl ax, 1
06aa2  d1 e5                shl bp, 1
06aa4  d1 d0                rcl ax, 1
06aa6  d1 e2                shl dx, 1
06aa8  d1 d0                rcl ax, 1
06aaa  d1 e1                shl cx, 1
06aac  d1 d0                rcl ax, 1
06aae  d1 e3                shl bx, 1
06ab0  d1 d0                rcl ax, 1
06ab2  d1 e5                shl bp, 1
06ab4  d1 d0                rcl ax, 1
06ab6  d1 e2                shl dx, 1
06ab8  d1 d0                rcl ax, 1
06aba  d1 e1                shl cx, 1
06abc  d1 d0                rcl ax, 1
06abe  d1 e3                shl bx, 1
06ac0  d1 d0                rcl ax, 1
06ac2  d1 e5                shl bp, 1
06ac4  d1 d0                rcl ax, 1
06ac6  d1 e2                shl dx, 1
06ac8  d1 d0                rcl ax, 1
06aca  d1 e1                shl cx, 1
06acc  d1 d0                rcl ax, 1
06ace  d1 e3                shl bx, 1
06ad0  d1 d0                rcl ax, 1
06ad2  d1 e5                shl bp, 1
06ad4  d1 d0                rcl ax, 1
06ad6  86 e0                xchg al, ah
06ad8  26 89 05             mov word ptr es:[di], ax
06adb  d1 e2                shl dx, 1
06add  d1 d0                rcl ax, 1
06adf  d1 e1                shl cx, 1
06ae1  d1 d0                rcl ax, 1
06ae3  d1 e3                shl bx, 1
06ae5  d1 d0                rcl ax, 1
06ae7  d1 e5                shl bp, 1
06ae9  d1 d0                rcl ax, 1
06aeb  d1 e2                shl dx, 1
06aed  d1 d0                rcl ax, 1
06aef  d1 e1                shl cx, 1
06af1  d1 d0                rcl ax, 1
06af3  d1 e3                shl bx, 1
06af5  d1 d0                rcl ax, 1
06af7  d1 e5                shl bp, 1
06af9  d1 d0                rcl ax, 1
06afb  d1 e2                shl dx, 1
06afd  d1 d0                rcl ax, 1
06aff  d1 e1                shl cx, 1
06b01  d1 d0                rcl ax, 1
06b03  d1 e3                shl bx, 1
06b05  d1 d0                rcl ax, 1
06b07  d1 e5                shl bp, 1
06b09  d1 d0                rcl ax, 1
06b0b  d1 e2                shl dx, 1
06b0d  d1 d0                rcl ax, 1
06b0f  d1 e1                shl cx, 1
06b11  d1 d0                rcl ax, 1
06b13  d1 e3                shl bx, 1
06b15  d1 d0                rcl ax, 1
06b17  d1 e5                shl bp, 1
06b19  d1 d0                rcl ax, 1
06b1b  86 e0                xchg al, ah
06b1d  26 89 45 02          mov word ptr es:[di + 2], ax
06b21  d1 e2                shl dx, 1
06b23  d1 d0                rcl ax, 1
06b25  d1 e1                shl cx, 1
06b27  d1 d0                rcl ax, 1
06b29  d1 e3                shl bx, 1
06b2b  d1 d0                rcl ax, 1
06b2d  d1 e5                shl bp, 1
06b2f  d1 d0                rcl ax, 1
06b31  d1 e2                shl dx, 1
06b33  d1 d0                rcl ax, 1
06b35  d1 e1                shl cx, 1
06b37  d1 d0                rcl ax, 1
06b39  d1 e3                shl bx, 1
06b3b  d1 d0                rcl ax, 1
06b3d  d1 e5                shl bp, 1
06b3f  d1 d0                rcl ax, 1
06b41  d1 e2                shl dx, 1
06b43  d1 d0                rcl ax, 1
06b45  d1 e1                shl cx, 1
06b47  d1 d0                rcl ax, 1
06b49  d1 e3                shl bx, 1
06b4b  d1 d0                rcl ax, 1
06b4d  d1 e5                shl bp, 1
06b4f  d1 d0                rcl ax, 1
06b51  d1 e2                shl dx, 1
06b53  d1 d0                rcl ax, 1
06b55  d1 e1                shl cx, 1
06b57  d1 d0                rcl ax, 1
06b59  d1 e3                shl bx, 1
06b5b  d1 d0                rcl ax, 1
06b5d  d1 e5                shl bp, 1
06b5f  d1 d0                rcl ax, 1
06b61  86 e0                xchg al, ah
06b63  26 89 45 04          mov word ptr es:[di + 4], ax
06b67  d1 e2                shl dx, 1
06b69  d1 d0                rcl ax, 1
06b6b  d1 e1                shl cx, 1
06b6d  d1 d0                rcl ax, 1
06b6f  d1 e3                shl bx, 1
06b71  d1 d0                rcl ax, 1
06b73  d1 e5                shl bp, 1
06b75  d1 d0                rcl ax, 1
06b77  d1 e2                shl dx, 1
06b79  d1 d0                rcl ax, 1
06b7b  d1 e1                shl cx, 1
06b7d  d1 d0                rcl ax, 1
06b7f  d1 e3                shl bx, 1
06b81  d1 d0                rcl ax, 1
06b83  d1 e5                shl bp, 1
06b85  d1 d0                rcl ax, 1
06b87  d1 e2                shl dx, 1
06b89  d1 d0                rcl ax, 1
06b8b  d1 e1                shl cx, 1
06b8d  d1 d0                rcl ax, 1
06b8f  d1 e3                shl bx, 1
06b91  d1 d0                rcl ax, 1
06b93  d1 e5                shl bp, 1
06b95  d1 d0                rcl ax, 1
06b97  d1 e2                shl dx, 1
06b99  d1 d0                rcl ax, 1
06b9b  d1 e1                shl cx, 1
06b9d  d1 d0                rcl ax, 1
06b9f  d1 e3                shl bx, 1
06ba1  d1 d0                rcl ax, 1
06ba3  d1 e5                shl bp, 1
06ba5  d1 d0                rcl ax, 1
06ba7  86 e0                xchg al, ah
06ba9  26 89 45 06          mov word ptr es:[di + 6], ax
06bad  83 c6 02             add si, 2
06bb0  83 c7 08             add di, 8
06bb3  2e fe 0e 59 6a       dec byte ptr cs:[0x6a59]
06bb8  74 03                je loc_6bbd
06bba  e9 bd fe             jmp loc_6a7a
loc_6bbd:
06bbd  81 c7 60 1f          add di, 0x1f60
06bc1  f7 c7 00 80          test di, 0x8000
06bc5  74 04                je loc_6bcb
06bc7  81 ef 60 7f          sub di, 0x7f60
loc_6bcb:
06bcb  83 c6 78             add si, 0x78
06bce  2e fe 0e 58 6a       dec byte ptr cs:[0x6a58]
06bd3  74 03                je loc_6bd8
06bd5  e9 9c fe             jmp loc_6a74
loc_6bd8:
06bd8  50                   push ax
06bd9  b8 7c 09             mov ax, 0x97c
06bdc  8e d8                mov ds, ax
06bde  58                   pop ax
06bdf  c3                   ret

; ======== fouille_tresor
; carte trésor ou événement de la zone ; « CETTE PIECE A DEJA ETE FOUILLEE »
06be0  80 3e a7 3f 04       cmp byte ptr [0x3fa7], 4    ; personnage_courant
06be5  75 01                jne loc_6be8
06be7  c3                   ret
loc_6be8:
06be8  80 3e f5 42 1c       cmp byte ptr [0x42f5], 0x1c
06bed  74 01                je loc_6bf0
06bef  c3                   ret
loc_6bf0:
06bf0  a0 9b 3f             mov al, byte ptr [0x3f9b]    ; etat_action
06bf3  e8 53 f4             call fin_deplacement
loc_6bf6:
06bf6  e8 a1 01             call monstre_dans_zone
06bf9  8b 3e 37 46          mov di, word ptr [0x4637]    ; fiche_heros_courant
06bfd  80 3e c7 3f 00       cmp byte ptr [0x3fc7], 0
06c02  74 03                je loc_6c07
06c04  e9 a3 02             jmp loc_6eaa
loc_6c07:
06c07  8a 1e 94 3f          mov bl, byte ptr [0x3f94]    ; zone_heros
06c0b  b7 00                mov bh, 0
06c0d  8a 87 70 4b          mov al, byte ptr [bx + 0x4b70]    ; evenement_par_zone
06c11  c6 87 70 4b ff       mov byte ptr [bx + 0x4b70], 0xff    ; evenement_par_zone
06c16  3c ff                cmp al, 0xff
06c18  75 03                jne loc_6c1d
06c1a  e9 42 01             jmp loc_6d5f
loc_6c1d:
06c1d  0a c0                or al, al
06c1f  74 03                je loc_6c24
06c21  e9 70 02             jmp loc_6e94
loc_6c24:
06c24  e8 3f 01             call tire_carte
06c27  3c 09                cmp al, 9
06c29  73 03                jae loc_6c2e
06c2b  e9 a7 00             jmp loc_6cd5
loc_6c2e:
06c2e  3c 0e                cmp al, 0xe
06c30  73 03                jae loc_6c35
06c32  e9 f4 00             jmp loc_6d29
loc_6c35:
06c35  3c 10                cmp al, 0x10
06c37  73 03                jae loc_6c3c
06c39  e9 0f 01             jmp loc_6d4b
loc_6c3c:
06c3c  75 03                jne loc_6c41
06c3e  eb 5f                jmp loc_6c9f
; ---- 1 octets non atteints (6c40-6c40)
loc_6c41:
06c41  3c 14                cmp al, 0x14
06c43  73 03                jae loc_6c48
06c45  eb 6f                jmp loc_6cb6
; ---- 1 octets non atteints (6c47-6c47)
loc_6c48:
06c48  e8 40 01             call remet_carte
06c4b  8b 36 37 46          mov si, word ptr [0x4637]    ; fiche_heros_courant
06c4f  a0 a7 3f             mov al, byte ptr [0x3fa7]    ; personnage_courant
06c52  a2 bc 3f             mov byte ptr [0x3fbc], al
06c55  bf 4a 4d             mov di, 0x4d4a    ; monstres
06c58  8a 44 03             mov al, byte ptr [si + 3]
06c5b  88 45 03             mov byte ptr [di + 3], al
06c5e  b9 04 00             mov cx, 4
06c61  bb 9b 43             mov bx, 0x439b    ; voisins
loc_6c64:
06c64  51                   push cx
06c65  53                   push bx
06c66  56                   push si
06c67  8a 54 01             mov dl, byte ptr [si + 1]
06c6a  02 17                add dl, byte ptr [bx]
06c6c  80 fa 1a             cmp dl, 0x1a
06c6f  73 18                jae loc_6c89
06c71  8a 74 02             mov dh, byte ptr [si + 2]
06c74  02 77 01             add dh, byte ptr [bx + 1]
06c77  80 fe 13             cmp dh, 0x13
06c7a  72 03                jb loc_6c7f
06c7c  eb 0b                jmp loc_6c89
; ---- 1 octets non atteints (6c7e-6c7e)
loc_6c7f:
06c7f  e8 09 b8             call case_libre
06c82  0a c0                or al, al
06c84  75 03                jne loc_6c89
06c86  eb 1e                jmp loc_6ca6
; ---- 1 octets non atteints (6c88-6c88)
loc_6c89:
06c89  5e                   pop si
06c8a  5b                   pop bx
06c8b  59                   pop cx
06c8c  83 c3 02             add bx, 2
06c8f  e2 d3                loop loc_6c64
06c91  8a 1e 94 3f          mov bl, byte ptr [0x3f94]    ; zone_heros
06c95  b7 00                mov bh, 0
06c97  c6 87 70 4b 00       mov byte ptr [bx + 0x4b70], 0    ; evenement_par_zone
06c9c  e9 57 ff             jmp loc_6bf6
loc_6c9f:
06c9f  bb 4c 00             mov bx, 0x4c    ; message « VOUS FOUILLEZ MAIS / NE DECOUVREZ RIEN »
06ca2  e8 48 1c             call affiche_message
06ca5  c3                   ret
loc_6ca6:
06ca6  5e                   pop si
06ca7  5b                   pop bx
06ca8  59                   pop cx
06ca9  57                   push di
06caa  52                   push dx
06cab  bb 06 01             mov bx, 0x106    ; message « PENDANT VOS RECHERCHES / UN MONSTRE VOUS TRAQUE / ET VOUS ATTAQUE »
06cae  e8 3c 1c             call affiche_message
06cb1  5a                   pop dx
06cb2  5f                   pop di
06cb3  e9 00 02             jmp loc_6eb6
loc_6cb6:
06cb6  e8 d2 00             call remet_carte
06cb9  bb 0a 01             mov bx, 0x10a    ; message « VOUS SENTEZ LA PRESSION D'UN / FIL DE DETENTE SUR VOTRE JAMBE. / AVANT DE POUVOIR REAGIR VOUS ETES / ATTEINT PAR UN COUP D'ARBALETE / ET PERDEZ 1 POINT DE CORPS »
06cbc  e8 2e 1c             call affiche_message
06cbf  e8 63 ab             call redessine_plateau
06cc2  8b 36 37 46          mov si, word ptr [0x4637]    ; fiche_heros_courant
06cc6  fe 4c 06             dec byte ptr [si + 6]
06cc9  74 01                je loc_6ccc
06ccb  c3                   ret
loc_6ccc:
06ccc  a0 a7 3f             mov al, byte ptr [0x3fa7]    ; personnage_courant
06ccf  a2 ca 3f             mov byte ptr [0x3fca], al    ; heros_courant
06cd2  e9 03 a4             jmp mort_heros
loc_6cd5:
06cd5  e8 b3 00             call remet_carte
06cd8  3c 08                cmp al, 8
06cda  75 2e                jne loc_6d0a
06cdc  50                   push ax
06cdd  e8 53 f3             call de6_moins_un
06ce0  8a c3                mov al, bl
06ce2  fe c0                inc al
06ce4  bb b2 01             mov bx, 0x1b2
06ce7  8b b7 c1 5f          mov si, word ptr [bx + 0x5fc1]    ; textes
06ceb  81 c6 c1 5f          add si, 0x5fc1    ; textes
06cef  88 04                mov byte ptr [si], al
06cf1  80 04 30             add byte ptr [si], 0x30
06cf4  02 c0                add al, al
06cf6  8a d0                mov dl, al
06cf8  02 c0                add al, al
06cfa  02 c0                add al, al
06cfc  02 d0                add dl, al
06cfe  8b 3e 37 46          mov di, word ptr [0x4637]    ; fiche_heros_courant
06d02  80 4d 18 04          or byte ptr [di + 0x18], 4
06d06  58                   pop ax
06d07  eb 09                jmp loc_6d12
; ---- 1 octets non atteints (6d09-6d09)
loc_6d0a:
06d0a  8a d8                mov bl, al
06d0c  32 ff                xor bh, bh
06d0e  8a 97 cd 49          mov dl, byte ptr [bx + 0x49cd]    ; or_cartes
loc_6d12:
06d12  50                   push ax
06d13  32 f6                xor dh, dh
06d15  e8 ee fb             call ajoute_or
06d18  e8 bb f7             call affiche_or
06d1b  58                   pop ax
06d1c  02 c0                add al, al
06d1e  32 e4                xor ah, ah
06d20  8b d8                mov bx, ax
06d22  81 c3 f4 00          add bx, 0xf4
06d26  e9 c4 1b             jmp affiche_message
loc_6d29:
06d29  2c 09                sub al, 9
06d2b  b4 00                mov ah, 0
06d2d  8a c8                mov cl, al
06d2f  bb ad 43             mov bx, 0x43ad    ; potions_cartes
06d32  03 d8                add bx, ax
06d34  8a 45 10             mov al, byte ptr [di + 0x10]
06d37  0a 07                or al, byte ptr [bx]
06d39  88 45 10             mov byte ptr [di + 0x10], al
06d3c  8a d9                mov bl, cl
06d3e  02 db                add bl, bl
06d40  b7 00                mov bh, 0
06d42  81 c3 92 48          add bx, 0x4892    ; messages_potions_cartes
06d46  8b 1f                mov bx, word ptr [bx]
06d48  e9 a2 1b             jmp affiche_message
loc_6d4b:
06d4b  b5 40                mov ch, 0x40
06d4d  bb 1c 01             mov bx, 0x11c
06d50  3c 0e                cmp al, 0xe
06d52  74 05                je loc_6d59
06d54  bb 14 01             mov bx, 0x114
06d57  b5 10                mov ch, 0x10
loc_6d59:
06d59  08 6d 10             or byte ptr [di + 0x10], ch
06d5c  e9 8e 1b             jmp affiche_message
loc_6d5f:
06d5f  bb 4a 00             mov bx, 0x4a    ; message « CETTE PIECE A DEJA / ETE FOUILLEE »
06d62  e8 88 1b             call affiche_message
06d65  c3                   ret

; ======== tire_carte   (appelée depuis 6c24)
; retire la carte du dessus de pioche_tresors
06d66  a0 3b 46             mov al, byte ptr [0x463b]    ; pioche_tresors
06d69  50                   push ax
06d6a  bd 3b 46             mov bp, 0x463b    ; pioche_tresors
06d6d  be 3c 46             mov si, 0x463c
06d70  b9 19 00             mov cx, 0x19
loc_6d73:
06d73  ac                   lodsb al, byte ptr [si]
06d74  3e 88 46 00          mov byte ptr ds:[bp], al
06d78  3c ff                cmp al, 0xff
06d7a  74 09                je loc_6d85
06d7c  45                   inc bp
06d7d  e2 f4                loop loc_6d73
06d7f  b0 ff                mov al, 0xff
06d81  3e 88 46 00          mov byte ptr ds:[bp], al
loc_6d85:
06d85  58                   pop ax
06d86  89 2e 55 46          mov word ptr [0x4655], bp    ; carte_tresor
06d8a  c3                   ret

; ======== remet_carte   (appelée depuis 6c48, 6cb6, 6cd5)
; remet la carte AL sous la pioche
06d8b  8b 1e 55 46          mov bx, word ptr [0x4655]    ; carte_tresor
06d8f  88 07                mov byte ptr [bx], al
06d91  43                   inc bx
06d92  c6 07 ff             mov byte ptr [bx], 0xff
06d95  89 1e 55 46          mov word ptr [0x4655], bx    ; carte_tresor
06d99  c3                   ret

; ======== monstre_dans_zone   (appelée depuis 6bf6)
; DS:3FC7 = 1 si un monstre actif est dans la zone du héros
06d9a  c6 06 c7 3f 00       mov byte ptr [0x3fc7], 0
06d9f  8b 3e 37 46          mov di, word ptr [0x4637]    ; fiche_heros_courant
06da3  e8 75 a8             call adresse_case_perso
06da6  a2 94 3f             mov byte ptr [0x3f94], al    ; zone_heros
06da9  e8 68 a7             call revele_zone
06dac  89 1e e4 3f          mov word ptr [0x3fe4], bx    ; case_coin_zone
06db0  8b 0e 94 3f          mov cx, word ptr [0x3f94]    ; zone_heros
06db4  bf d6 49             mov di, 0x49d6    ; ordre_cases_vue
06db7  b9 1e 00             mov cx, 0x1e
loc_6dba:
06dba  51                   push cx
06dbb  53                   push bx
06dbc  57                   push di
06dbd  8a 15                mov dl, byte ptr [di]
06dbf  b6 00                mov dh, 0
06dc1  03 da                add bx, dx
06dc3  8a 07                mov al, byte ptr [bx]
06dc5  24 3f                and al, 0x3f
06dc7  3a 06 94 3f          cmp al, byte ptr [0x3f94]    ; zone_heros
06dcb  75 03                jne loc_6dd0
06dcd  e8 07 00             call monstre_actif_case
loc_6dd0:
06dd0  5f                   pop di
06dd1  5b                   pop bx
06dd2  59                   pop cx
06dd3  47                   inc di
06dd4  e2 e4                loop loc_6dba
06dd6  c3                   ret

; ======== monstre_actif_case   (appelée depuis 6dcd)
; pour monstre_dans_zone : si la case BX porte un monstre dont +6 a un bit autre que 1, DS:3FC7 = 1 ; bogue : décrémente AL avant adresse_monstre, qui le décrémente aussi, donc teste le monstre n - 1
06dd7  80 c7 04             add bh, 4
06dda  8a 07                mov al, byte ptr [bx]
06ddc  0a c0                or al, al
06dde  75 01                jne loc_6de1
06de0  c3                   ret
loc_6de1:
06de1  3c 30                cmp al, 0x30
06de3  72 01                jb loc_6de6
06de5  c3                   ret
loc_6de6:
06de6  fe c8                dec al
06de8  e8 55 a0             call adresse_monstre
06deb  83 c3 06             add bx, 6
06dee  f6 07 fe             test byte ptr [bx], 0xfe
06df1  75 01                jne loc_6df4
06df3  c3                   ret
loc_6df4:
06df4  c6 06 c7 3f 01       mov byte ptr [0x3fc7], 1
06df9  c3                   ret

; ======== fouille_portes
; icône de fouille des portes secrètes et des pièges ; « UNE PORTE SECRETE S'OUVRE »
06dfa  80 3e a7 3f 04       cmp byte ptr [0x3fa7], 4    ; personnage_courant
06dff  75 01                jne loc_6e02
06e01  c3                   ret
loc_6e02:
06e02  80 3e ad 42 1c       cmp byte ptr [0x42ad], 0x1c
06e07  74 01                je loc_6e0a
06e09  c3                   ret
loc_6e0a:
06e0a  a0 9b 3f             mov al, byte ptr [0x3f9b]    ; etat_action
06e0d  e8 39 f2             call fin_deplacement
06e10  8a 1e 94 3f          mov bl, byte ptr [0x3f94]    ; zone_heros
06e14  b7 00                mov bh, 0
06e16  80 bf 9b 4b ff       cmp byte ptr [bx + 0x4b9b], 0xff    ; portes_fouillees
06e1b  75 03                jne loc_6e20
06e1d  e9 3f ff             jmp loc_6d5f
loc_6e20:
06e20  c7 06 ed 37 00 00    mov word ptr [0x37ed], 0    ; ligne_carte
06e26  e8 e1 03             call cherche_portes_pieges
06e29  8b 3e 37 46          mov di, word ptr [0x4637]    ; fiche_heros_courant
06e2d  e8 eb a7             call adresse_case_perso
06e30  8a d8                mov bl, al
06e32  32 ff                xor bh, bh
06e34  83 3e ed 37 00       cmp word ptr [0x37ed], 0    ; ligne_carte
06e39  74 17                je loc_6e52
06e3b  c6 87 9b 4b ff       mov byte ptr [bx + 0x4b9b], 0xff    ; portes_fouillees
06e40  e8 e4 b9             call son_porte
06e43  bb 1a 00             mov bx, 0x1a    ; message « UNE PORTE SECRETE S'OUVRE / EN GRINcANT DANS LE MUR »
06e46  e8 a4 1a             call affiche_message
06e49  c7 06 ed 37 00 00    mov word ptr [0x37ed], 0    ; ligne_carte
06e4f  eb 59                jmp loc_6eaa
; ---- 1 octets non atteints (6e51-6e51)
loc_6e52:
06e52  83 3e eb 37 01       cmp word ptr [0x37eb], 1    ; position_tuile_carte
06e57  75 03                jne loc_6e5c
06e59  eb 4f                jmp loc_6eaa
; ---- 1 octets non atteints (6e5b-6e5b)
loc_6e5c:
06e5c  80 bf 9b 4b 00       cmp byte ptr [bx + 0x4b9b], 0    ; portes_fouillees
06e61  75 1e                jne loc_6e81
06e63  c7 06 ed 37 01 00    mov word ptr [0x37ed], 1    ; ligne_carte
06e69  c6 87 9b 4b ff       mov byte ptr [bx + 0x4b9b], 0xff    ; portes_fouillees
06e6e  83 3e ed 37 00       cmp word ptr [0x37ed], 0    ; ligne_carte
06e73  75 03                jne loc_6e78
06e75  eb 33                jmp loc_6eaa
; ---- 1 octets non atteints (6e77-6e77)
loc_6e78:
06e78  bb 08 01             mov bx, 0x108    ; message « MALGRE UNE RECHERCHE MINUTIEUSE / VOUS NE DECOUVREZ RIEN »
06e7b  e8 6f 1a             call affiche_message
06e7e  eb 2a                jmp loc_6eaa
; ---- 1 octets non atteints (6e80-6e80)
loc_6e81:
06e81  80 bf 9b 4b ff       cmp byte ptr [bx + 0x4b9b], 0xff    ; portes_fouillees
06e86  75 03                jne loc_6e8b
06e88  e9 d4 fe             jmp loc_6d5f
loc_6e8b:
06e8b  8a 87 9b 4b          mov al, byte ptr [bx + 0x4b9b]    ; portes_fouillees
06e8f  c6 87 9b 4b ff       mov byte ptr [bx + 0x4b9b], 0xff    ; portes_fouillees
loc_6e94:
06e94  fe c8                dec al
06e96  32 e4                xor ah, ah
06e98  d1 e0                shl ax, 1
06e9a  8b f3                mov si, bx
06e9c  03 f0                add si, ax
06e9e  46                   inc si
06e9f  bb 89 5a             mov bx, 0x5a89    ; evenements_fouille
06ea2  03 d8                add bx, ax
06ea4  8b 3e 37 46          mov di, word ptr [0x4637]    ; fiche_heros_courant
06ea8  ff 17                call word ptr [bx]
loc_6eaa:
06eaa  c7 06 35 46 a4 48    mov word ptr [0x4635], 0x48a4    ; zones_actives, zones_panneau

; ======== redessin_plateau   (appelée depuis 074f, 19bc, 2608)
; DS:3F97 = 1 : la boucle du tour redessine tout le plateau (redessine_vue)
06eb0  c6 06 97 3f 01       mov byte ptr [0x3f97], 1    ; vue_a_refaire
06eb5  c3                   ret
loc_6eb6:
06eb6  80 3d 00             cmp byte ptr [di], 0
06eb9  74 10                je loc_6ecb
06ebb  52                   push dx
06ebc  8a 55 01             mov dl, byte ptr [di + 1]
06ebf  8a 75 02             mov dh, byte ptr [di + 2]
06ec2  e8 b9 f1             call index_case
06ec5  c6 87 6f 58 00       mov byte ptr [bx + 0x586f], 0    ; grille_occupants
06eca  5a                   pop dx
loc_6ecb:
06ecb  c6 05 01             mov byte ptr [di], 1
06ece  88 55 01             mov byte ptr [di + 1], dl
06ed1  88 75 02             mov byte ptr [di + 2], dh
06ed4  80 4d 06 01          or byte ptr [di + 6], 1
06ed8  80 65 07 0f          and byte ptr [di + 7], 0xf
06edc  80 4d 07 10          or byte ptr [di + 7], 0x10
06ee0  e8 9b f1             call index_case
06ee3  c6 87 6f 58 01       mov byte ptr [bx + 0x586f], 1    ; grille_occupants
06ee8  81 c3 6f 54          add bx, 0x546f    ; grille_zones
06eec  89 5d 04             mov word ptr [di + 4], bx
loc_6eef:
06eef  c6 06 97 3f 01       mov byte ptr [0x3f97], 1    ; vue_a_refaire
06ef4  8b 1e 37 46          mov bx, word ptr [0x4637]    ; fiche_heros_courant
06ef8  89 1e d6 3f          mov word ptr [0x3fd6], bx    ; attaquant
06efc  a0 a7 3f             mov al, byte ptr [0x3fa7]    ; personnage_courant
06eff  a2 bc 3f             mov byte ptr [0x3fbc], al
06f02  89 3e d4 3f          mov word ptr [0x3fd4], di    ; cible
06f06  e8 86 ae             call combat_monstre
06f09  e9 9e a3             jmp fin_action

; ======== evt_coffre_desarme_2
; 1 : « LE COFFRE A ETE PIEGE. VOUS LE DESARMEZ »
06f0c  be 96 00             mov si, 0x96
06f0f  e9 23 ab             jmp message_puis_sortie

; ======== fouille_vide
06f12  80 3e c2 4b ff       cmp byte ptr [0x4bc2], 0xff
06f17  74 18                je loc_6f31
06f19  e8 8b bb             call son_piege
06f1c  be 98 00             mov si, 0x98
06f1f  e8 13 ab             call message_puis_sortie
06f22  8b 3e 37 46          mov di, word ptr [0x4637]    ; fiche_heros_courant
06f26  8a 45 06             mov al, byte ptr [di + 6]
06f29  3c 01                cmp al, 1
06f2b  74 5e                je loc_6f8b
06f2d  fe 4d 06             dec byte ptr [di + 6]
06f30  c3                   ret
loc_6f31:
06f31  bb 4c 00             mov bx, 0x4c    ; message « VOUS FOUILLEZ MAIS / NE DECOUVREZ RIEN »
06f34  e8 b6 19             call affiche_message
06f37  c3                   ret

; ======== evt_coffre_potion_50
; 6 : potion curative et 50 pièces
06f38  ba 32 00             mov dx, 0x32
06f3b  be 9a 00             mov si, 0x9a
06f3e  eb 08                jmp potion_or_message

; ======== evt_armoire
; 3 : potion curative et 30 pièces
06f40  ba 1e 00             mov dx, 0x1e
06f43  be 9e 00             mov si, 0x9e
06f46  eb 00                jmp potion_or_message
potion_or_message:    ; potion curative, DX pièces, message SI
06f48  f6 45 10 04          test byte ptr [di + 0x10], 4
06f4c  75 06                jne loc_6f54
06f4e  80 4d 10 04          or byte ptr [di + 0x10], 4
06f52  eb 04                jmp loc_6f58
loc_6f54:
06f54  80 4d 10 08          or byte ptr [di + 0x10], 8
loc_6f58:
06f58  e8 ab f9             call ajoute_or
06f5b  8b de                mov bx, si
06f5d  e8 8d 19             call affiche_message
06f60  e9 d7 aa             jmp apres_sortie

; ======== evt_coffre_100
; 4 : 100 pièces, piège si non trouvé
06f63  ba 64 00             mov dx, 0x64
06f66  e8 9d f9             call ajoute_or
06f69  81 3e c0 4b ff 00    cmp word ptr [0x4bc0], 0xff
06f6f  74 14                je loc_6f85
06f71  be 98 00             mov si, 0x98
06f74  e8 be aa             call message_puis_sortie
06f77  8b 3e 37 46          mov di, word ptr [0x4637]    ; fiche_heros_courant
06f7b  8a 45 06             mov al, byte ptr [di + 6]
06f7e  3c 01                cmp al, 1
06f80  74 09                je loc_6f8b
06f82  fe 4d 06             dec byte ptr [di + 6]
loc_6f85:
06f85  be a4 00             mov si, 0xa4
06f88  e9 aa aa             jmp message_puis_sortie
loc_6f8b:
06f8b  a0 a7 3f             mov al, byte ptr [0x3fa7]    ; personnage_courant
06f8e  a2 ca 3f             mov byte ptr [0x3fca], al    ; heros_courant
06f91  8b 36 37 46          mov si, word ptr [0x4637]    ; fiche_heros_courant
06f95  e8 40 a1             call mort_heros
06f98  e8 92 f0             call efface_ecran_tampon
06f9b  e8 85 fa             call fond_vers_tampon
06f9e  e8 7b f6             call affiche_nom_portrait
06fa1  e9 1d f6             jmp init_sprites_icones

; ======== evt_lance
; 5 : une lance, sauf pour l'enchanteur
06fa4  80 3e a7 3f 03       cmp byte ptr [0x3fa7], 3    ; personnage_courant
06fa9  75 01                jne loc_6fac
06fab  c3                   ret
loc_6fac:
06fac  8b 3e 37 46          mov di, word ptr [0x4637]    ; fiche_heros_courant
06fb0  80 4d 0e 40          or byte ptr [di + 0xe], 0x40
06fb4  be a6 00             mov si, 0xa6
06fb7  e9 7b aa             jmp message_puis_sortie

; ======== evt_coffre_magnus
; 7 : coffre du prince Magnus (250 pièces, porté)
06fba  80 3e be 3f 03       cmp byte ptr [0x3fbe], 3    ; coffres_ramasses
06fbf  74 05                je loc_6fc6
06fc1  c6 06 93 4b 07       mov byte ptr [0x4b93], 7
loc_6fc6:
06fc6  8b 3e 37 46          mov di, word ptr [0x4637]    ; fiche_heros_courant
06fca  f6 45 0f 40          test byte ptr [di + 0xf], 0x40
06fce  74 03                je loc_6fd3
06fd0  e9 d7 fe             jmp loc_6eaa
loc_6fd3:
06fd3  8a 1e be 3f          mov bl, byte ptr [0x3fbe]    ; coffres_ramasses
06fd7  fe 06 be 3f          inc byte ptr [0x3fbe]    ; coffres_ramasses
06fdb  b7 00                mov bh, 0
06fdd  d0 e3                shl bl, 1
06fdf  8b 8f d9 44          mov cx, word ptr [bx + 0x44d9]
06fe3  e8 1c a6             call adresse_case
06fe6  c6 87 00 04 00       mov byte ptr [bx + 0x400], 0
06feb  be aa 00             mov si, 0xaa
06fee  80 4d 0f 40          or byte ptr [di + 0xf], 0x40
06ff2  81 45 09 fa 00       add word ptr [di + 9], 0xfa
06ff7  e9 3b aa             jmp message_puis_sortie

; ======== evt_cle_melar
; 8 : clé de Melar, le trône glisse
06ffa  be b6 00             mov si, 0xb6
06ffd  e8 35 aa             call message_puis_sortie
07000  c6 06 d1 58 00       mov byte ptr [0x58d1], 0
07005  bb eb 56             mov bx, 0x56eb
07008  b9 04 00             mov cx, 4
0700b  bf 63 46             mov di, 0x4663    ; fiches_personnages
loc_700e:
0700e  39 5d 04             cmp word ptr [di + 4], bx
07011  74 08                je loc_701b
07013  83 c7 1a             add di, 0x1a
07016  e2 f6                loop loc_700e
07018  eb 14                jmp loc_702e
; ---- 1 octets non atteints (701a-701a)
loc_701b:
0701b  bb b7 56             mov bx, 0x56b7
0701e  b9 04 00             mov cx, 4
07021  bf 63 46             mov di, 0x4663    ; fiches_personnages
loc_7024:
07024  39 5d 04             cmp word ptr [di + 4], bx
07027  74 0c                je loc_7035
07029  83 c7 1a             add di, 0x1a
0702c  e2 f6                loop loc_7024
loc_702e:
0702e  81 c3 00 02          add bx, 0x200
07032  c6 07 5e             mov byte ptr [bx], 0x5e
loc_7035:
07035  c6 06 d2 56 1c       mov byte ptr [0x56d2], 0x1c
0703a  bb d2 56             mov bx, 0x56d2
0703d  e8 bf a2             call revele_derriere_porte
07040  e9 67 fe             jmp loc_6eaa

; ======== evt_talisman
; 9 : talisman du savoir, +2 points d'esprit
07043  8b 3e 37 46          mov di, word ptr [0x4637]    ; fiche_heros_courant
07047  80 4d 0d 04          or byte ptr [di + 0xd], 4
0704b  80 45 07 02          add byte ptr [di + 7], 2
0704f  be ba 00             mov si, 0xba
07052  e9 e0 a9             jmp message_puis_sortie

; ======== evt_armure_borin
; 10
07055  8b 3e 37 46          mov di, word ptr [0x4637]    ; fiche_heros_courant
07059  80 4d 0d 01          or byte ptr [di + 0xd], 1
0705d  be c0 00             mov si, 0xc0
07060  e9 d2 a9             jmp message_puis_sortie

; ======== evt_coffre_karlen
; 11 : 200 pièces
07063  ba c8 00             mov dx, 0xc8
07066  be c2 00             mov si, 0xc2
07069  e9 ec fe             jmp loc_6f58

; ======== evt_coffre_course
; 13 : un coffre (100 pièces, porté)
0706c  80 3e be 3f 01       cmp byte ptr [0x3fbe], 1    ; coffres_ramasses
07071  74 05                je loc_7078
07073  c6 06 89 4b 0d       mov byte ptr [0x4b89], 0xd
loc_7078:
07078  8b 3e 37 46          mov di, word ptr [0x4637]    ; fiche_heros_courant
0707c  be d2 00             mov si, 0xd2
0707f  f6 45 0f 40          test byte ptr [di + 0xf], 0x40
07083  74 03                je loc_7088
07085  e9 b2 a9             jmp apres_sortie
loc_7088:
07088  8a 1e be 3f          mov bl, byte ptr [0x3fbe]    ; coffres_ramasses
0708c  fe 06 be 3f          inc byte ptr [0x3fbe]    ; coffres_ramasses
07090  b7 00                mov bh, 0
07092  d0 e3                shl bl, 1
07094  8b 8f df 44          mov cx, word ptr [bx + 0x44df]
07098  e8 67 a5             call adresse_case
0709b  c6 87 00 04 00       mov byte ptr [bx + 0x400], 0
070a0  be d0 00             mov si, 0xd0
070a3  80 4d 0f 40          or byte ptr [di + 0xf], 0x40
070a7  ba 64 00             mov dx, 0x64
070aa  e9 ab fe             jmp loc_6f58

; ======== evt_or_mine
; 30 : 5000 pièces, plus d'attaque ni de défense
070ad  c6 06 c0 3f 00       mov byte ptr [0x3fc0], 0    ; evenement_b
070b2  8b 3e 37 46          mov di, word ptr [0x4637]    ; fiche_heros_courant
070b6  81 45 09 88 13       add word ptr [di + 9], 0x1388
070bb  80 4d 0f 20          or byte ptr [di + 0xf], 0x20
070bf  80 4d 0f 10          or byte ptr [di + 0xf], 0x10
070c3  be da 00             mov si, 0xda
070c6  e9 6c a9             jmp message_puis_sortie

; ======== evt_coffre_200
; 18
070c9  ba c8 00             mov dx, 0xc8
070cc  be f2 00             mov si, 0xf2
070cf  e9 86 fe             jmp loc_6f58

; ======== prend_lame_esprit
; « VOUS PRENEZ LA LAME DE L'ESPRIT »
070d2  8b 3e 37 46          mov di, word ptr [0x4637]    ; fiche_heros_courant
070d6  80 4d 0d 10          or byte ptr [di + 0xd], 0x10
070da  bb f0 00             mov bx, 0xf0    ; message « VOUS PRENEZ LA LAME DE L'ESPRIT »
070dd  e8 0d 18             call affiche_message
070e0  c3                   ret

; ======== evt_coffre_200_b
; 19
070e1  ba c8 00             mov dx, 0xc8
070e4  be 28 02             mov si, 0x228
070e7  e9 6e fe             jmp loc_6f58

; ======== evt_coffre_250
; 27
070ea  ba fa 00             mov dx, 0xfa
070ed  be 46 02             mov si, 0x246
070f0  e9 65 fe             jmp loc_6f58

; ======== evt_coffre_300
; 20
070f3  ba 2c 01             mov dx, 0x12c
070f6  be 2a 02             mov si, 0x22a
070f9  e9 5c fe             jmp loc_6f58

; ======== evt_coffre_350
; 26
070fc  ba 5e 01             mov dx, 0x15e
070ff  be 44 02             mov si, 0x244
07102  e9 53 fe             jmp loc_6f58

; ======== evt_trone_500
; 28
07105  ba f4 01             mov dx, 0x1f4
07108  be 48 02             mov si, 0x248
0710b  eb 3e                jmp or_message
; ---- 1 octets non atteints (710d-710d)

; ======== evt_coffre_400
; 25 : 400 pièces, le message dit 200
0710e  ba 90 01             mov dx, 0x190
07111  be 3a 02             mov si, 0x23a
07114  eb 35                jmp or_message
; ---- 1 octets non atteints (7116-7116)

; ======== evt_coffre_potion_100
; 21
07117  ba 64 00             mov dx, 0x64
0711a  be 2e 02             mov si, 0x22e
0711d  eb 1b                jmp potion_or_message_b
; ---- 1 octets non atteints (711f-711f)

; ======== coffre_potion
; « VOUS TROUVEZ UNE POTION CURATIVE DANS LE COFFRE »
07120  f6 45 10 04          test byte ptr [di + 0x10], 4
07124  75 07                jne loc_712d
07126  80 4d 10 04          or byte ptr [di + 0x10], 4
0712a  eb 05                jmp loc_7131
; ---- 1 octets non atteints (712c-712c)
loc_712d:
0712d  80 4d 10 08          or byte ptr [di + 0x10], 8
loc_7131:
07131  bb 4a 02             mov bx, 0x24a    ; message « VOUS TROUVEZ UNE POTION / CURATIVE DANS LE COFFRE »
07134  e8 b6 17             call affiche_message
07137  e9 00 a9             jmp apres_sortie

; ======== potion_or_message_b
; même chose, autre exemplaire
0713a  f6 45 10 04          test byte ptr [di + 0x10], 4
0713e  75 07                jne loc_7147
07140  80 4d 10 04          or byte ptr [di + 0x10], 4
07144  eb 05                jmp or_message
; ---- 1 octets non atteints (7146-7146)
loc_7147:
07147  80 4d 10 08          or byte ptr [di + 0x10], 8
or_message:    ; DX pièces, message SI
0714b  e8 b8 f7             call ajoute_or
0714e  8b de                mov bx, si
07150  e8 9a 17             call affiche_message
07153  e9 e4 a8             jmp apres_sortie

; ======== coffre_fleche
; « LE COFFRE ETAIT PIEGE ! UNE FLECHE PART DU MUR »
07156  c6 06 bc 4b ff       mov byte ptr [0x4bbc], 0xff
0715b  8b 3e 37 46          mov di, word ptr [0x4637]    ; fiche_heros_courant
0715f  fe 4d 06             dec byte ptr [di + 6]
07162  bb 30 02             mov bx, 0x230    ; message « LE COFFRE ETAIT PIEGE ! UNE / FLECHE PART DU MUR. VOUS / PERDEZ UN POINT DE CORPS »
07165  e8 85 17             call affiche_message
07168  e8 cf a8             call apres_sortie
0716b  8b 3e 37 46          mov di, word ptr [0x4637]    ; fiche_heros_courant
0716f  80 7d 06 00          cmp byte ptr [di + 6], 0
07173  75 03                jne loc_7178
07175  e9 13 fe             jmp loc_6f8b
loc_7178:
07178  c3                   ret

; ======== coffre_desarme
07179  c6 06 91 4b ff       mov byte ptr [0x4b91], 0xff
0717e  bb 96 00             mov bx, 0x96    ; message « VOUS DECOUVREZ QUE LE / COFFRE A ETE PIEGE. VOUS / LE DESARMEZ »
07181  e8 69 17             call affiche_message
07184  e9 b3 a8             jmp apres_sortie

; ======== cles_agrain
; « LES CLES D'AGRAIN SONT SUR LA TABLE »
07187  56                   push si
07188  8b 3e 37 46          mov di, word ptr [0x4637]    ; fiche_heros_courant
0718c  f6 45 0f 40          test byte ptr [di + 0xf], 0x40
07190  75 26                jne loc_71b8
07192  ba 64 00             mov dx, 0x64
07195  e8 6e f7             call ajoute_or
07198  80 4d 0f 40          or byte ptr [di + 0xf], 0x40
0719c  bb 36 02             mov bx, 0x236    ; message « LES CLES D'AGRAIN SONT SUR / LA TABLE. PRENEZ-EN UNE D'UNE / VALEUR DE 100 PIECES D'OR »
0719f  e8 4b 17             call affiche_message
071a2  e8 95 a8             call apres_sortie
071a5  5e                   pop si
071a6  fe 06 e8 3f          inc byte ptr [0x3fe8]
071aa  80 3e e8 3f 04       cmp byte ptr [0x3fe8], 4
071af  75 01                jne loc_71b2
071b1  c3                   ret
loc_71b2:
071b2  c6 06 95 4b 18       mov byte ptr [0x4b95], 0x18
071b7  c3                   ret
loc_71b8:
071b8  bb 38 02             mov bx, 0x238    ; message « VOUS NE POUVEZ PORTER QU'UNE / CLE D'AGRAIN SANS RISQUE »
071bb  e8 2f 17             call affiche_message
071be  5e                   pop si
071bf  c3                   ret

; ======== evt_baguette
; 12 : baguette de rappel et 150 pièces
071c0  8b 3e 37 46          mov di, word ptr [0x4637]    ; fiche_heros_courant
071c4  80 4d 0d 02          or byte ptr [di + 0xd], 2
071c8  ba 96 00             mov dx, 0x96
071cb  be ca 00             mov si, 0xca
071ce  e9 87 fd             jmp loc_6f58

; ======== evt_bouclier
; 14
071d1  a0 a7 3f             mov al, byte ptr [0x3fa7]    ; personnage_courant
071d4  3c 03                cmp al, 3
071d6  75 0b                jne loc_71e3
071d8  c6 06 99 4b 0e       mov byte ptr [0x4b99], 0xe
071dd  be e4 00             mov si, 0xe4
071e0  e9 52 a8             jmp message_puis_sortie
loc_71e3:
071e3  8b 3e 37 46          mov di, word ptr [0x4637]    ; fiche_heros_courant
071e7  80 4d 0f 01          or byte ptr [di + 0xf], 1
071eb  be e4 00             mov si, 0xe4
071ee  e9 44 a8             jmp message_puis_sortie

; ======== evt_coffre_piege
; 15 : « ATTENTION, LE COFFRE EST PIEGE »
071f1  be e8 00             mov si, 0xe8
071f4  e9 3e a8             jmp message_puis_sortie

; ======== coffre_gargouille
; « LA GARGOUILLE S'ANIME SUBITEMENT »
071f7  bf 54 4d             mov di, 0x4d54
071fa  80 4d 06 01          or byte ptr [di + 6], 1
071fe  bb e6 00             mov bx, 0xe6    ; message « LE COFFRE ETAIT UN PIEGE. LA / GARGOUILLE SANIME SUBITEMENT. »
07201  e8 e9 16             call affiche_message
07204  bf 54 4d             mov di, 0x4d54
07207  e9 e5 fc             jmp loc_6eef

; ======== cherche_portes_pieges   (appelée depuis 6e26)
; fouille_case sur chaque case de la zone du héros
0720a  c7 06 e9 37 00 00    mov word ptr [0x37e9], 0    ; erreur_fichier
07210  8b 3e 37 46          mov di, word ptr [0x4637]    ; fiche_heros_courant
07214  e8 04 a4             call adresse_case_perso
07217  a2 94 3f             mov byte ptr [0x3f94], al    ; zone_heros
0721a  bd 01 00             mov bp, 1
0721d  e8 f4 a2             call revele_zone
07220  89 1e e4 3f          mov word ptr [0x3fe4], bx    ; case_coin_zone
07224  bf d6 49             mov di, 0x49d6    ; ordre_cases_vue
07227  b9 1e 00             mov cx, 0x1e
loc_722a:
0722a  51                   push cx
0722b  53                   push bx
0722c  57                   push di
0722d  8a 15                mov dl, byte ptr [di]
0722f  b6 00                mov dh, 0
07231  03 da                add bx, dx
07233  8a 07                mov al, byte ptr [bx]
07235  24 3f                and al, 0x3f
07237  3a 06 94 3f          cmp al, byte ptr [0x3f94]    ; zone_heros
0723b  75 03                jne loc_7240
0723d  e8 07 00             call fouille_case
loc_7240:
07240  5f                   pop di
07241  5b                   pop bx
07242  59                   pop cx
07243  47                   inc di
07244  e2 e4                loop loc_722a
07246  c3                   ret

; ======== fouille_case   (appelée depuis 723d)
; une case : porte secrète (murs bit 0x08), fosse 0x32, lance 0x36, chute de pierre 0x34
07247  81 c3 00 02          add bx, 0x200
0724b  53                   push bx
0724c  f6 07 08             test byte ptr [bx], 8
0724f  74 2c                je loc_727d
07251  f6 07 04             test byte ptr [bx], 4
07254  75 27                jne loc_727d
07256  80 0f 04             or byte ptr [bx], 4
07259  8a 87 ff fd          mov al, byte ptr [bx - 0x201]
0725d  b9 01 00             mov cx, 1
07260  f6 07 10             test byte ptr [bx], 0x10
07263  75 07                jne loc_726c
07265  8a 87 e6 fd          mov al, byte ptr [bx - 0x21a]
07269  b9 1a 00             mov cx, 0x1a
loc_726c:
0726c  24 3f                and al, 0x3f
0726e  53                   push bx
0726f  51                   push cx
07270  e8 58 93             call marque_zone_vue
07273  5b                   pop bx
07274  59                   pop cx
07275  2b d9                sub bx, cx
07277  c7 06 ed 37 01 00    mov word ptr [0x37ed], 1    ; ligne_carte
loc_727d:
0727d  81 c3 00 02          add bx, 0x200
07281  8a 07                mov al, byte ptr [bx]
07283  3c 32                cmp al, 0x32
07285  74 18                je loc_729f
07287  3c 36                cmp al, 0x36
07289  74 06                je loc_7291
0728b  3c 34                cmp al, 0x34
0728d  74 21                je loc_72b0
0728f  eb 24                jmp loc_72b5
loc_7291:
07291  c6 07 00             mov byte ptr [bx], 0
07294  bb 34 00             mov bx, 0x34    ; message « VOUS TROUVEZ ET DESARMEZ / UN PIEGE A LANCES CACHE »
07297  e8 53 16             call affiche_message
0729a  e8 88 a5             call redessine_plateau
0729d  eb 0b                jmp loc_72aa
loc_729f:
0729f  fe 07                inc byte ptr [bx]
072a1  bb 10 01             mov bx, 0x110    ; message « VOUS DECOUVREZ L'ENTREE / D'UNE TRAPPE »
072a4  e8 46 16             call affiche_message
072a7  e8 7b a5             call redessine_plateau
loc_72aa:
072aa  c7 06 eb 37 01 00    mov word ptr [0x37eb], 1    ; position_tuile_carte
loc_72b0:
072b0  c6 06 cb 3f 01       mov byte ptr [0x3fcb], 1
loc_72b5:
072b5  5b                   pop bx
072b6  43                   inc bx
072b7  f6 07 08             test byte ptr [bx], 8
072ba  74 16                je loc_72d2
072bc  f6 07 10             test byte ptr [bx], 0x10
072bf  74 11                je loc_72d2
072c1  f6 07 04             test byte ptr [bx], 4
072c4  75 0c                jne loc_72d2
072c6  e8 2b 00             call ouvre_porte_secrete
072c9  8a 87 00 fe          mov al, byte ptr [bx - 0x200]
072cd  53                   push bx
072ce  e8 fa 92             call marque_zone_vue
072d1  5b                   pop bx
loc_72d2:
072d2  83 c3 19             add bx, 0x19
072d5  f6 07 08             test byte ptr [bx], 8
072d8  75 01                jne loc_72db
072da  c3                   ret
loc_72db:
072db  f6 07 20             test byte ptr [bx], 0x20
072de  75 01                jne loc_72e1
072e0  c3                   ret
loc_72e1:
072e1  f6 07 04             test byte ptr [bx], 4
072e4  74 01                je loc_72e7
072e6  c3                   ret
loc_72e7:
072e7  e8 0a 00             call ouvre_porte_secrete
072ea  8a 87 00 fe          mov al, byte ptr [bx - 0x200]
072ee  53                   push bx
072ef  e8 d9 92             call marque_zone_vue
072f2  5b                   pop bx
072f3  c3                   ret

; ======== ouvre_porte_secrete   (appelée depuis 72c6, 72e7)
; porte secrète voisine trouvée : bit 0x04, zone révélée (revele_derriere_porte), DS:37ED = 1 (message « UNE PORTE SECRETE S'OUVRE »), DS:3FCB = 1
072f4  80 0f 04             or byte ptr [bx], 4
072f7  53                   push bx
072f8  e8 04 a0             call revele_derriere_porte
072fb  c7 06 ed 37 01 00    mov word ptr [0x37ed], 1    ; ligne_carte
07301  5b                   pop bx
07302  c6 06 cb 3f 01       mov byte ptr [0x3fcb], 1
07307  c3                   ret
; ---- 8 octets non atteints (7308-730f)

; ======== menu_titre   (appelée depuis 0155)
; logo et 3 icônes ; clic -> table DS:AA1A (2 plateau, 4 héros, 6 armurerie) ; bit 0x40 = quitter
07310  a0 95 31             mov al, byte ptr [0x3195]    ; commandes_joueurs
07313  a2 93 31             mov byte ptr [0x3193], al    ; commande_type
07316  c7 06 f1 47 20 2c    mov word ptr [0x47f1], 0x2c20
0731c  c6 06 98 3f 00       mov byte ptr [0x3f98], 0    ; pas_en_cours
07321  e8 de ee             call efface_tampon
07324  e8 bd ed             call affiche_tampon
07327  e8 68 df             call charge_ecran_menus
loc_732a:
0732a  e8 f6 f6             call fond_vers_tampon
0732d  a0 95 31             mov al, byte ptr [0x3195]    ; commandes_joueurs
07330  a2 93 31             mov byte ptr [0x3193], al    ; commande_type
07333  c7 06 f1 47 20 2c    mov word ptr [0x47f1], 0x2c20
07339  be 40 7c             mov si, 0x7c40
0733c  bf 30 0a             mov di, 0xa30
0733f  a1 27 5e             mov ax, word ptr [0x5e27]    ; seg_annexe
07342  a3 4e 37             mov word ptr [0x374e], ax    ; segment_source
07345  50                   push ax
07346  b8 63 14             mov ax, 0x1463
07349  8e c0                mov es, ax
0734b  58                   pop ax
0734c  bd e0 00             mov bp, 0xe0
0734f  b9 44 00             mov cx, 0x44
07352  1e                   push ds
07353  e8 fd c7             call copie_image
07356  1f                   pop ds
07357  be 00 30             mov si, 0x3000
0735a  bf ac 75             mov di, 0x75ac
0735d  a1 27 5e             mov ax, word ptr [0x5e27]    ; seg_annexe
07360  a3 4e 37             mov word ptr [0x374e], ax    ; segment_source
07363  50                   push ax
07364  b8 63 14             mov ax, 0x1463
07367  8e c0                mov es, ax
07369  58                   pop ax
0736a  bd 30 00             mov bp, 0x30
0736d  b9 40 00             mov cx, 0x40
07370  1e                   push ds
07371  e8 df c7             call copie_image
07374  1f                   pop ds
07375  be 00 3c             mov si, 0x3c00
07378  bf 08 76             mov di, 0x7608
0737b  a1 27 5e             mov ax, word ptr [0x5e27]    ; seg_annexe
0737e  a3 4e 37             mov word ptr [0x374e], ax    ; segment_source
07381  50                   push ax
07382  b8 63 14             mov ax, 0x1463
07385  8e c0                mov es, ax
07387  58                   pop ax
07388  bd 30 00             mov bp, 0x30
0738b  b9 40 00             mov cx, 0x40
0738e  1e                   push ds
0738f  e8 c1 c7             call copie_image
07392  1f                   pop ds
07393  be 00 48             mov si, 0x4800
07396  bf 64 76             mov di, 0x7664
07399  a1 27 5e             mov ax, word ptr [0x5e27]    ; seg_annexe
0739c  a3 4e 37             mov word ptr [0x374e], ax    ; segment_source
0739f  50                   push ax
073a0  b8 63 14             mov ax, 0x1463
073a3  8e c0                mov es, ax
073a5  58                   pop ax
073a6  bd 30 00             mov bp, 0x30
073a9  b9 40 00             mov cx, 0x40
073ac  1e                   push ds
073ad  e8 a3 c7             call copie_image
073b0  1f                   pop ds
073b1  c6 06 e9 3f 01       mov byte ptr [0x3fe9], 1    ; sans_sprites
073b6  e8 b6 f1             call sauve_tampon
loc_73b9:
073b9  e8 40 f0             call curseur_memorise
073bc  e8 55 ea             call curseur_dessine
073bf  e8 22 ed             call affiche_tampon
073c2  e8 12 ea             call curseur_efface
073c5  e8 8a c3             call lit_commandes
073c8  f6 06 92 39 40       test byte ptr [0x3992], 0x40    ; commandes
073cd  74 03                je loc_73d2
073cf  eb 1b                jmp loc_73ec
; ---- 1 octets non atteints (73d1-73d1)
loc_73d2:
073d2  be 00 aa             mov si, 0xaa00    ; zones_menu_titre
073d5  e8 2d db             call zone_cliquee
073d8  83 fb 06             cmp bx, 6
073db  77 dc                ja loc_73b9
073dd  83 fb 02             cmp bx, 2
073e0  72 d7                jb loc_73b9
073e2  e8 6f c5             call attend_relache_boutons
073e5  e8 60 b6             call son_clic
073e8  ff a7 1a aa          jmp word ptr [bx - 0x55e6]
loc_73ec:
073ec  c3                   ret

; ======== choix_quete   (appelée depuis 73e8)
; icône plateau : quête, briefing (QUESTB, EQUESTS.BIN) ; « AUCUN PERSONNAGE ACTIF... »
073ed  bb a0 44             mov bx, 0x44a0    ; heros_en_jeu
073f0  32 c0                xor al, al
073f2  80 3e 69 46 00       cmp byte ptr [0x4669], 0
073f7  75 03                jne loc_73fc
073f9  c6 07 00             mov byte ptr [bx], 0
loc_73fc:
073fc  74 02                je loc_7400
073fe  02 07                add al, byte ptr [bx]
loc_7400:
07400  80 3e 83 46 00       cmp byte ptr [0x4683], 0
07405  75 04                jne loc_740b
07407  c6 47 01 00          mov byte ptr [bx + 1], 0
loc_740b:
0740b  74 03                je loc_7410
0740d  02 47 01             add al, byte ptr [bx + 1]
loc_7410:
07410  80 3e 9d 46 00       cmp byte ptr [0x469d], 0
07415  75 04                jne loc_741b
07417  c6 47 02 00          mov byte ptr [bx + 2], 0
loc_741b:
0741b  74 03                je loc_7420
0741d  02 47 02             add al, byte ptr [bx + 2]
loc_7420:
07420  80 3e b7 46 00       cmp byte ptr [0x46b7], 0
07425  75 04                jne loc_742b
07427  c6 47 03 00          mov byte ptr [bx + 3], 0
loc_742b:
0742b  74 03                je loc_7430
0742d  02 47 03             add al, byte ptr [bx + 3]
loc_7430:
07430  0a c0                or al, al
07432  75 09                jne loc_743d
07434  bb 06 00             mov bx, 6    ; message « AUCUN PERSONNAGE ACTIF / N'A ETE SELECTIONNE / POUR ENTRER DANS LA QUETE »
07437  e8 b3 14             call affiche_message
0743a  e9 ed fe             jmp loc_732a
loc_743d:
0743d  e8 34 0b             call attribue_sorts
07440  a0 95 31             mov al, byte ptr [0x3195]    ; commandes_joueurs
07443  a2 93 31             mov byte ptr [0x3193], al    ; commande_type
07446  c6 06 e9 3f 01       mov byte ptr [0x3fe9], 1    ; sans_sprites
0744b  e8 b4 ed             call efface_tampon
0744e  e8 93 ec             call affiche_tampon
07451  83 3e 90 31 08       cmp word ptr [0x3190], 8    ; mode_video
07456  74 03                je loc_745b
07458  e9 ab 00             jmp loc_7506
loc_745b:
0745b  c7 06 07 39 59 5e    mov word ptr [0x3907], 0x5e59    ; fichier_nom, "odds&sod.vga"
07461  c7 06 03 39 00 00    mov word ptr [0x3903], 0    ; fichier_offset
07467  b8 63 14             mov ax, 0x1463
0746a  a3 01 39             mov word ptr [0x3901], ax    ; fichier_segment
loc_746d:
0746d  c7 06 e9 37 00 00    mov word ptr [0x37e9], 0    ; erreur_fichier
07473  e8 7b c2             call clavier_retire
07476  e8 4f c5             call fichier_ouvre
07479  83 3e e9 37 00       cmp word ptr [0x37e9], 0    ; erreur_fichier
0747e  75 03                jne loc_7483
07480  eb 0f                jmp loc_7491
; ---- 1 octets non atteints (7482-7482)
loc_7483:
07483  e8 34 c2             call clavier_installe
07486  bb 52 02             mov bx, 0x252    ; message « INTRODUISEZ VOTRE / HEROQUEST DISQUETTE 3 »
07489  e8 61 14             call affiche_message
0748c  e8 62 c2             call clavier_retire
0748f  eb dc                jmp loc_746d
loc_7491:
07491  e8 68 c5             call fichier_lit
07494  83 3e e9 37 00       cmp word ptr [0x37e9], 0    ; erreur_fichier
07499  75 e8                jne loc_7483
0749b  a3 05 39             mov word ptr [0x3905], ax    ; fichier_taille
0749e  e8 19 c2             call clavier_installe
074a1  a1 2d 5e             mov ax, word ptr [0x5e2d]    ; seg_odds
074a4  8e c0                mov es, ax
074a6  33 f6                xor si, si
074a8  bf 00 00             mov di, 0
074ab  b8 63 14             mov ax, 0x1463
074ae  8e d8                mov ds, ax
074b0  b9 ff ff             mov cx, 0xffff
074b3  e8 1b d1             call lz_decompresse
074b6  50                   push ax
074b7  b8 7c 09             mov ax, 0x97c
074ba  8e d8                mov ds, ax
074bc  58                   pop ax
074bd  c7 06 07 39 e1 ac    mov word ptr [0x3907], 0xace1    ; fichier_nom, "questb.vga"
074c3  c7 06 03 39 00 00    mov word ptr [0x3903], 0    ; fichier_offset
074c9  a1 23 5e             mov ax, word ptr [0x5e23]    ; seg_ecran
074cc  a3 01 39             mov word ptr [0x3901], ax    ; fichier_segment
loc_74cf:
074cf  c7 06 e9 37 00 00    mov word ptr [0x37e9], 0    ; erreur_fichier
074d5  e8 19 c2             call clavier_retire
074d8  e8 ed c4             call fichier_ouvre
074db  83 3e e9 37 00       cmp word ptr [0x37e9], 0    ; erreur_fichier
074e0  75 03                jne loc_74e5
074e2  eb 0f                jmp loc_74f3
; ---- 1 octets non atteints (74e4-74e4)
loc_74e5:
074e5  e8 d2 c1             call clavier_installe
074e8  bb 52 02             mov bx, 0x252    ; message « INTRODUISEZ VOTRE / HEROQUEST DISQUETTE 3 »
074eb  e8 ff 13             call affiche_message
074ee  e8 00 c2             call clavier_retire
074f1  eb dc                jmp loc_74cf
loc_74f3:
074f3  e8 06 c5             call fichier_lit
074f6  83 3e e9 37 00       cmp word ptr [0x37e9], 0    ; erreur_fichier
074fb  75 e8                jne loc_74e5
074fd  a3 05 39             mov word ptr [0x3905], ax    ; fichier_taille
07500  e8 b7 c1             call clavier_installe
07503  e9 a8 00             jmp loc_75ae
loc_7506:
07506  c7 06 07 39 f5 5e    mov word ptr [0x3907], 0x5ef5    ; fichier_nom, "odds&sod.ega"
0750c  c7 06 03 39 00 00    mov word ptr [0x3903], 0    ; fichier_offset
07512  b8 63 14             mov ax, 0x1463
07515  a3 01 39             mov word ptr [0x3901], ax    ; fichier_segment
loc_7518:
07518  c7 06 e9 37 00 00    mov word ptr [0x37e9], 0    ; erreur_fichier
0751e  e8 d0 c1             call clavier_retire
07521  e8 a4 c4             call fichier_ouvre
07524  83 3e e9 37 00       cmp word ptr [0x37e9], 0    ; erreur_fichier
07529  75 03                jne loc_752e
0752b  eb 0f                jmp loc_753c
; ---- 1 octets non atteints (752d-752d)
loc_752e:
0752e  e8 89 c1             call clavier_installe
07531  bb 52 02             mov bx, 0x252    ; message « INTRODUISEZ VOTRE / HEROQUEST DISQUETTE 3 »
07534  e8 b6 13             call affiche_message
07537  e8 b7 c1             call clavier_retire
0753a  eb dc                jmp loc_7518
loc_753c:
0753c  e8 bd c4             call fichier_lit
0753f  83 3e e9 37 00       cmp word ptr [0x37e9], 0    ; erreur_fichier
07544  75 e8                jne loc_752e
07546  a3 05 39             mov word ptr [0x3905], ax    ; fichier_taille
07549  e8 6e c1             call clavier_installe
0754c  a1 2d 5e             mov ax, word ptr [0x5e2d]    ; seg_odds
0754f  8e c0                mov es, ax
07551  33 f6                xor si, si
07553  bf 00 00             mov di, 0
07556  b8 63 14             mov ax, 0x1463
07559  8e d8                mov ds, ax
0755b  b9 ff ff             mov cx, 0xffff
0755e  e8 70 d0             call lz_decompresse
07561  50                   push ax
07562  b8 7c 09             mov ax, 0x97c
07565  8e d8                mov ds, ax
07567  58                   pop ax
07568  c7 06 07 39 ec ac    mov word ptr [0x3907], 0xacec    ; fichier_nom, "questb.ega"
0756e  c7 06 03 39 00 00    mov word ptr [0x3903], 0    ; fichier_offset
07574  a1 23 5e             mov ax, word ptr [0x5e23]    ; seg_ecran
07577  a3 01 39             mov word ptr [0x3901], ax    ; fichier_segment
loc_757a:
0757a  c7 06 e9 37 00 00    mov word ptr [0x37e9], 0    ; erreur_fichier
07580  e8 6e c1             call clavier_retire
07583  e8 42 c4             call fichier_ouvre
07586  83 3e e9 37 00       cmp word ptr [0x37e9], 0    ; erreur_fichier
0758b  75 03                jne loc_7590
0758d  eb 0f                jmp loc_759e
; ---- 1 octets non atteints (758f-758f)
loc_7590:
07590  e8 27 c1             call clavier_installe
07593  bb 52 02             mov bx, 0x252    ; message « INTRODUISEZ VOTRE / HEROQUEST DISQUETTE 3 »
07596  e8 54 13             call affiche_message
07599  e8 55 c1             call clavier_retire
0759c  eb dc                jmp loc_757a
loc_759e:
0759e  e8 5b c4             call fichier_lit
075a1  83 3e e9 37 00       cmp word ptr [0x37e9], 0    ; erreur_fichier
075a6  75 e8                jne loc_7590
075a8  a3 05 39             mov word ptr [0x3905], ax    ; fichier_taille
075ab  e8 0c c1             call clavier_installe
loc_75ae:
075ae  c7 06 37 46 00 00    mov word ptr [0x4637], 0    ; fiche_heros_courant
loc_75b4:
075b4  e8 6c f4             call fond_vers_tampon
075b7  c6 06 e9 3f 01       mov byte ptr [0x3fe9], 1    ; sans_sprites
075bc  c7 06 07 39 f7 ac    mov word ptr [0x3907], 0xacf7    ; fichier_nom, "equests.bin"
075c2  c7 06 03 39 00 00    mov word ptr [0x3903], 0    ; fichier_offset
075c8  b8 7c 09             mov ax, 0x97c
075cb  a3 01 39             mov word ptr [0x3901], ax    ; fichier_segment
loc_75ce:
075ce  c7 06 e9 37 00 00    mov word ptr [0x37e9], 0    ; erreur_fichier
075d4  e8 1a c1             call clavier_retire
075d7  e8 ee c3             call fichier_ouvre
075da  83 3e e9 37 00       cmp word ptr [0x37e9], 0    ; erreur_fichier
075df  75 03                jne loc_75e4
075e1  eb 0f                jmp loc_75f2
; ---- 1 octets non atteints (75e3-75e3)
loc_75e4:
075e4  e8 d3 c0             call clavier_installe
075e7  bb 50 02             mov bx, 0x250    ; message « INTRODUISEZ VOTRE / HEROQUEST DISQUETTE 2 »
075ea  e8 00 13             call affiche_message
075ed  e8 01 c1             call clavier_retire
075f0  eb dc                jmp loc_75ce
loc_75f2:
075f2  e8 07 c4             call fichier_lit
075f5  a3 05 39             mov word ptr [0x3905], ax    ; fichier_taille
075f8  83 3e e9 37 00       cmp word ptr [0x37e9], 0    ; erreur_fichier
075fd  75 e5                jne loc_75e4
075ff  e8 b8 c0             call clavier_installe
07602  8a 1e 94 31          mov bl, byte ptr [0x3194]    ; langue
07606  32 ff                xor bh, bh
07608  d1 e3                shl bx, 1
0760a  d1 e3                shl bx, 1
0760c  89 1e f7 37          mov word ptr [0x37f7], bx
07610  8b b7 00 00          mov si, word ptr [bx]
07614  83 3e 90 31 06       cmp word ptr [0x3190], 6    ; mode_video
07619  75 04                jne loc_761f
0761b  c6 44 07 0e          mov byte ptr [si + 7], 0xe
loc_761f:
0761f  83 3e 90 31 04       cmp word ptr [0x3190], 4    ; mode_video
07624  75 04                jne loc_762a
07626  c6 44 07 07          mov byte ptr [si + 7], 7
loc_762a:
0762a  e8 4c 0d             call menu_liste
0762d  a0 7a ab             mov al, byte ptr [0xab7a]    ; choix_menu
07630  fe c8                dec al
07632  3c 0e                cmp al, 0xe
07634  74 10                je loc_7646
07636  3c 0f                cmp al, 0xf
07638  74 44                je loc_767e
loc_763a:
0763a  a2 92 3f             mov byte ptr [0x3f92], al    ; numero_quete
0763d  e8 c2 eb             call efface_tampon
07640  e8 a1 ea             call affiche_tampon
07643  e9 aa 0e             jmp lance_quete
loc_7646:
07646  e8 da f3             call fond_vers_tampon
07649  8b 1e f7 37          mov bx, word ptr [0x37f7]
0764d  8b b7 02 00          mov si, word ptr [bx + 2]
07651  83 3e 90 31 06       cmp word ptr [0x3190], 6    ; mode_video
07656  75 04                jne loc_765c
07658  c6 44 07 0e          mov byte ptr [si + 7], 0xe
loc_765c:
0765c  83 3e 90 31 04       cmp word ptr [0x3190], 4    ; mode_video
07661  75 04                jne loc_7667
07663  c6 44 07 07          mov byte ptr [si + 7], 7
loc_7667:
07667  e8 0f 0d             call menu_liste
0766a  a0 7a ab             mov al, byte ptr [0xab7a]    ; choix_menu
0766d  fe c8                dec al
0766f  3c 0a                cmp al, 0xa
07671  75 03                jne loc_7676
07673  e9 3e ff             jmp loc_75b4
loc_7676:
07676  3c 0b                cmp al, 0xb
07678  74 04                je loc_767e
0767a  04 0e                add al, 0xe
0767c  eb bc                jmp loc_763a
loc_767e:
0767e  83 3e 90 31 08       cmp word ptr [0x3190], 8    ; mode_video
07683  75 49                jne loc_76ce
07685  c7 06 07 39 9b 5e    mov word ptr [0x3907], 0x5e9b    ; fichier_nom, "bordered.vga"
0768b  c7 06 03 39 00 00    mov word ptr [0x3903], 0    ; fichier_offset
07691  a1 23 5e             mov ax, word ptr [0x5e23]    ; seg_ecran
07694  a3 01 39             mov word ptr [0x3901], ax    ; fichier_segment
loc_7697:
07697  c7 06 e9 37 00 00    mov word ptr [0x37e9], 0    ; erreur_fichier
0769d  e8 51 c0             call clavier_retire
076a0  e8 25 c3             call fichier_ouvre
076a3  83 3e e9 37 00       cmp word ptr [0x37e9], 0    ; erreur_fichier
076a8  75 03                jne loc_76ad
076aa  eb 0f                jmp loc_76bb
; ---- 1 octets non atteints (76ac-76ac)
loc_76ad:
076ad  e8 0a c0             call clavier_installe
076b0  bb 52 02             mov bx, 0x252    ; message « INTRODUISEZ VOTRE / HEROQUEST DISQUETTE 3 »
076b3  e8 37 12             call affiche_message
076b6  e8 38 c0             call clavier_retire
076b9  eb dc                jmp loc_7697
loc_76bb:
076bb  e8 3e c3             call fichier_lit
076be  83 3e e9 37 00       cmp word ptr [0x37e9], 0    ; erreur_fichier
076c3  75 e8                jne loc_76ad
076c5  a3 05 39             mov word ptr [0x3905], ax    ; fichier_taille
076c8  e8 ef bf             call clavier_installe
076cb  e9 5c fc             jmp loc_732a
loc_76ce:
076ce  c7 06 07 39 37 5f    mov word ptr [0x3907], 0x5f37    ; fichier_nom, "bordered.ega"
076d4  c7 06 03 39 00 00    mov word ptr [0x3903], 0    ; fichier_offset
076da  a1 23 5e             mov ax, word ptr [0x5e23]    ; seg_ecran
076dd  a3 01 39             mov word ptr [0x3901], ax    ; fichier_segment
loc_76e0:
076e0  c7 06 e9 37 00 00    mov word ptr [0x37e9], 0    ; erreur_fichier
076e6  e8 08 c0             call clavier_retire
076e9  e8 dc c2             call fichier_ouvre
076ec  83 3e e9 37 00       cmp word ptr [0x37e9], 0    ; erreur_fichier
076f1  75 03                jne loc_76f6
076f3  eb 0f                jmp loc_7704
; ---- 1 octets non atteints (76f5-76f5)
loc_76f6:
076f6  e8 c1 bf             call clavier_installe
076f9  bb 52 02             mov bx, 0x252    ; message « INTRODUISEZ VOTRE / HEROQUEST DISQUETTE 3 »
076fc  e8 ee 11             call affiche_message
076ff  e8 ef bf             call clavier_retire
07702  eb dc                jmp loc_76e0
loc_7704:
07704  e8 f5 c2             call fichier_lit
07707  83 3e e9 37 00       cmp word ptr [0x37e9], 0    ; erreur_fichier
0770c  75 e8                jne loc_76f6
0770e  a3 05 39             mov word ptr [0x3905], ax    ; fichier_taille
07711  e8 a6 bf             call clavier_installe
07714  e9 13 fc             jmp loc_732a

; ======== ecran_heros   (appelée depuis 73e8)
; icône héros : choix et création des personnages
07717  c6 06 9e 40 ff       mov byte ptr [0x409e], 0xff    ; heros_selectionne
loc_771c:
0771c  e8 04 f3             call fond_vers_tampon
0771f  be 40 7a             mov si, 0x7a40
07722  bf 10 d5             mov di, 0xd510
07725  a1 27 5e             mov ax, word ptr [0x5e27]    ; seg_annexe
07728  a3 4e 37             mov word ptr [0x374e], ax    ; segment_source
0772b  50                   push ax
0772c  b8 63 14             mov ax, 0x1463
0772f  8e c0                mov es, ax
07731  58                   pop ax
07732  bd 20 00             mov bp, 0x20
07735  b9 10 00             mov cx, 0x10
07738  1e                   push ds
07739  e8 17 c4             call copie_image
0773c  1f                   pop ds
0773d  c7 06 e9 37 00 00    mov word ptr [0x37e9], 0    ; erreur_fichier
07743  c7 06 eb 37 a8 20    mov word ptr [0x37eb], 0x20a8    ; position_tuile_carte
07749  c7 06 ed 37 00 b0    mov word ptr [0x37ed], 0xb000    ; ligne_carte
0774f  c7 06 ef 37 28 32    mov word ptr [0x37ef], 0x3228    ; colonne_carte
07755  c7 06 f1 37 00 80    mov word ptr [0x37f1], 0x8000
loc_775b:
0775b  8b 1e e9 37          mov bx, word ptr [0x37e9]    ; erreur_fichier
0775f  80 bf a0 44 00       cmp byte ptr [bx + 0x44a0], 0    ; heros_en_jeu
07764  74 1f                je loc_7785
07766  be 00 78             mov si, 0x7800
07769  8b 3e eb 37          mov di, word ptr [0x37eb]    ; position_tuile_carte
0776d  a1 27 5e             mov ax, word ptr [0x5e27]    ; seg_annexe
07770  a3 4e 37             mov word ptr [0x374e], ax    ; segment_source
07773  50                   push ax
07774  b8 63 14             mov ax, 0x1463
07777  8e c0                mov es, ax
07779  58                   pop ax
0777a  bd 30 00             mov bp, 0x30
0777d  b9 0c 00             mov cx, 0xc
07780  1e                   push ds
07781  e8 cf c3             call copie_image
07784  1f                   pop ds
loc_7785:
07785  a1 e9 37             mov ax, word ptr [0x37e9]    ; erreur_fichier
07788  3a 06 9e 40          cmp al, byte ptr [0x409e]    ; heros_selectionne
0778c  74 22                je loc_77b0
0778e  8b 36 ed 37          mov si, word ptr [0x37ed]    ; ligne_carte
07792  8b 3e ef 37          mov di, word ptr [0x37ef]    ; colonne_carte
07796  a1 25 5e             mov ax, word ptr [0x5e25]    ; seg_shopsp
07799  a3 4e 37             mov word ptr [0x374e], ax    ; segment_source
0779c  50                   push ax
0779d  b8 63 14             mov ax, 0x1463
077a0  8e c0                mov es, ax
077a2  58                   pop ax
077a3  bd 30 00             mov bp, 0x30
077a6  b9 40 00             mov cx, 0x40
077a9  1e                   push ds
077aa  e8 a6 c3             call copie_image
077ad  1f                   pop ds
077ae  eb 20                jmp loc_77d0
loc_77b0:
077b0  8b 36 f1 37          mov si, word ptr [0x37f1]
077b4  8b 3e ef 37          mov di, word ptr [0x37ef]    ; colonne_carte
077b8  a1 25 5e             mov ax, word ptr [0x5e25]    ; seg_shopsp
077bb  a3 4e 37             mov word ptr [0x374e], ax    ; segment_source
077be  50                   push ax
077bf  b8 63 14             mov ax, 0x1463
077c2  8e c0                mov es, ax
077c4  58                   pop ax
077c5  bd 30 00             mov bp, 0x30
077c8  b9 40 00             mov cx, 0x40
077cb  1e                   push ds
077cc  e8 84 c3             call copie_image
077cf  1f                   pop ds
loc_77d0:
077d0  ff 06 e9 37          inc word ptr [0x37e9]    ; erreur_fichier
077d4  83 06 eb 37 40       add word ptr [0x37eb], 0x40    ; position_tuile_carte
077d9  81 06 ed 37 00 0c    add word ptr [0x37ed], 0xc00    ; ligne_carte
077df  83 06 ef 37 40       add word ptr [0x37ef], 0x40    ; colonne_carte
077e4  81 06 f1 37 00 0c    add word ptr [0x37f1], 0xc00
077ea  83 3e e9 37 04       cmp word ptr [0x37e9], 4    ; erreur_fichier
077ef  74 03                je loc_77f4
077f1  e9 67 ff             jmp loc_775b
loc_77f4:
077f4  80 3e 9e 40 03       cmp byte ptr [0x409e], 3    ; heros_selectionne
077f9  77 3e                ja loc_7839
077fb  c7 06 e9 37 00 60    mov word ptr [0x37e9], 0x6000    ; erreur_fichier
07801  c7 06 eb 37 48 91    mov word ptr [0x37eb], 0x9148    ; position_tuile_carte
07807  b9 04 00             mov cx, 4
loc_780a:
0780a  51                   push cx
0780b  8b 36 e9 37          mov si, word ptr [0x37e9]    ; erreur_fichier
0780f  8b 3e eb 37          mov di, word ptr [0x37eb]    ; position_tuile_carte
07813  a1 27 5e             mov ax, word ptr [0x5e27]    ; seg_annexe
07816  a3 4e 37             mov word ptr [0x374e], ax    ; segment_source
07819  50                   push ax
0781a  b8 63 14             mov ax, 0x1463
0781d  8e c0                mov es, ax
0781f  58                   pop ax
07820  bd 20 00             mov bp, 0x20
07823  b9 30 00             mov cx, 0x30
07826  1e                   push ds
07827  e8 29 c3             call copie_image
0782a  1f                   pop ds
0782b  81 06 e9 37 00 06    add word ptr [0x37e9], 0x600    ; erreur_fichier
07831  83 06 eb 37 30       add word ptr [0x37eb], 0x30    ; position_tuile_carte
07836  59                   pop cx
07837  e2 d1                loop loc_780a
loc_7839:
07839  e8 33 ed             call sauve_tampon
loc_783c:
0783c  e8 bd eb             call curseur_memorise
0783f  e8 d2 e5             call curseur_dessine
07842  e8 9f e8             call affiche_tampon
07845  e8 8f e5             call curseur_efface
07848  e8 07 bf             call lit_commandes
0784b  f6 06 92 39 20       test byte ptr [0x3992], 0x20    ; commandes
07850  74 03                je loc_7855
07852  eb 24                jmp loc_7878
; ---- 1 octets non atteints (7854-7854)
loc_7855:
07855  be 22 aa             mov si, 0xaa22    ; zones_heros
07858  e8 aa d6             call zone_cliquee
0785b  83 fb 12             cmp bx, 0x12
0785e  77 dc                ja loc_783c
07860  83 fb 02             cmp bx, 2
07863  72 d7                jb loc_783c
07865  80 3e 9e 40 04       cmp byte ptr [0x409e], 4    ; heros_selectionne
0786a  72 0f                jb loc_787b
0786c  83 fb 0a             cmp bx, 0xa
0786f  72 0a                jb loc_787b
07871  83 fb 12             cmp bx, 0x12
07874  74 05                je loc_787b
07876  eb c4                jmp loc_783c
loc_7878:
07878  bb 12 00             mov bx, 0x12
loc_787b:
0787b  e8 d6 c0             call attend_relache_boutons
0787e  e8 c7 b1             call son_clic
07881  81 c3 6c aa          add bx, 0xaa6c    ; saut_heros
07885  ff 27                jmp word ptr [bx]

; ======== choisit_heros_1
; sélectionne le héros 1 (DS:409E) et passe aux commandes de son joueur ; 0x7895, 0x78A3, 0x78B1 pour 2 à 4
07887  c6 06 9e 40 00       mov byte ptr [0x409e], 0    ; heros_selectionne
0788c  a0 95 31             mov al, byte ptr [0x3195]    ; commandes_joueurs
0788f  a2 93 31             mov byte ptr [0x3193], al    ; commande_type
07892  e9 87 fe             jmp loc_771c

; ======== choisit_heros_2
; heros_selectionne = 1, commandes du joueur 2 (DS:3196)
07895  c6 06 9e 40 01       mov byte ptr [0x409e], 1    ; heros_selectionne
0789a  a0 96 31             mov al, byte ptr [0x3196]
0789d  a2 93 31             mov byte ptr [0x3193], al    ; commande_type
078a0  e9 79 fe             jmp loc_771c

; ======== choisit_heros_3
; heros_selectionne = 2, commandes du joueur 3
078a3  c6 06 9e 40 02       mov byte ptr [0x409e], 2    ; heros_selectionne
078a8  a0 97 31             mov al, byte ptr [0x3197]
078ab  a2 93 31             mov byte ptr [0x3193], al    ; commande_type
078ae  e9 6b fe             jmp loc_771c

; ======== choisit_heros_4
; heros_selectionne = 3, commandes du joueur 4
078b1  c6 06 9e 40 03       mov byte ptr [0x409e], 3    ; heros_selectionne
078b6  a0 98 31             mov al, byte ptr [0x3198]
078b9  a2 93 31             mov byte ptr [0x3193], al    ; commande_type
078bc  e9 5d fe             jmp loc_771c

; ======== heros_en_jeu
; bouton portrait : met le héros en jeu ou l'en retire (DS:44A0 + n)
078bf  8a 1e 9e 40          mov bl, byte ptr [0x409e]    ; heros_selectionne
078c3  32 ff                xor bh, bh
078c5  80 b7 a0 44 ff       xor byte ptr [bx + 0x44a0], 0xff    ; heros_en_jeu
078ca  e9 4f fe             jmp loc_771c

; ======== heros_renouvele
; « LE PERSONNAGE A ETE RENOUVELE »
078cd  a0 9e 40             mov al, byte ptr [0x409e]    ; heros_selectionne
078d0  e8 ac e4             call fiche_personnage
078d3  8a 1e 9e 40          mov bl, byte ptr [0x409e]    ; heros_selectionne
078d7  b7 00                mov bh, 0
078d9  8b 87 94 43          mov ax, word ptr [bx + 0x4394]    ; corps_depart
078dd  88 44 06             mov byte ptr [si + 6], al
078e0  8a 87 1b ad          mov al, byte ptr [bx - 0x52e5]
078e4  88 44 07             mov byte ptr [si + 7], al
078e7  c6 44 0e 00          mov byte ptr [si + 0xe], 0
078eb  c6 44 0f 00          mov byte ptr [si + 0xf], 0
078ef  c6 44 0d 00          mov byte ptr [si + 0xd], 0
078f3  c7 44 09 00 00       mov word ptr [si + 9], 0
078f8  c6 44 11 00          mov byte ptr [si + 0x11], 0
078fc  c6 44 12 00          mov byte ptr [si + 0x12], 0
07900  c6 44 13 00          mov byte ptr [si + 0x13], 0
07904  88 5c 19             mov byte ptr [si + 0x19], bl
07907  80 3e 9e 40 01       cmp byte ptr [0x409e], 1    ; heros_selectionne
0790c  75 04                jne loc_7912
0790e  80 4c 0e 80          or byte ptr [si + 0xe], 0x80
loc_7912:
07912  bb 08 00             mov bx, 8    ; message « LE PERSONNAGE / A ETE RENOUVELE »
07915  e8 d5 0f             call affiche_message
07918  e9 01 fe             jmp loc_771c

; ======== heros_nomme
; bouton plume : saisie du nom (15 caractères) puis mise en jeu
0791b  ff 36 59 37          push word ptr [0x3759]    ; texte_transparent
0791f  c6 06 59 37 00       mov byte ptr [0x3759], 0    ; texte_transparent
07924  e8 5f 04             call saisie_texte
07927  8f 06 59 37          pop word ptr [0x3759]    ; texte_transparent
0792b  8a 1e 9e 40          mov bl, byte ptr [0x409e]    ; heros_selectionne
0792f  b7 00                mov bh, 0
07931  d0 e3                shl bl, 1
07933  8b bf d7 45          mov di, word ptr [bx + 0x45d7]    ; noms_heros
07937  50                   push ax
07938  b8 7c 09             mov ax, 0x97c
0793b  8e c0                mov es, ax
0793d  58                   pop ax
0793e  be fa ab             mov si, 0xabfa    ; "________________"
07941  b9 0f 00             mov cx, 0xf
07944  f3 a4                rep movsb byte ptr es:[di], byte ptr [si]
07946  8a 1e 9e 40          mov bl, byte ptr [0x409e]    ; heros_selectionne
0794a  32 ff                xor bh, bh
0794c  c6 87 a0 44 ff       mov byte ptr [bx + 0x44a0], 0xff    ; heros_en_jeu
07951  e9 c8 fd             jmp loc_771c

; ======== sauvegarde_menu
; 0 sauvegarder, 1 charger le personnage sélectionné dans QUEST.SAV, 2 annuler
07954  e8 a3 bf             call attend_relache
07957  bb 0c 00             mov bx, 0xc
0795a  e8 90 0f             call affiche_message
0795d  80 3e 7a ab fe       cmp byte ptr [0xab7a], 0xfe    ; choix_menu
07962  75 03                jne loc_7967
07964  e9 b5 fd             jmp loc_771c
loc_7967:
07967  80 3e 7a ab 02       cmp byte ptr [0xab7a], 2    ; choix_menu
0796c  75 03                jne loc_7971
0796e  e9 ab fd             jmp loc_771c
loc_7971:
07971  80 3e 7a ab 01       cmp byte ptr [0xab7a], 1    ; choix_menu
07976  75 03                jne loc_797b
07978  e9 a2 00             jmp loc_7a1d
loc_797b:
0797b  bb 0e 00             mov bx, 0xe    ; message « INTRODUISEZ VOTRE / DISQUETTE DES DONNEES »
0797e  e8 6c 0f             call affiche_message
07981  e8 6d bd             call clavier_retire
07984  ba b3 5f             mov dx, 0x5fb3    ; "quest.sav"
07987  32 c0                xor al, al
07989  b4 3d                mov ah, 0x3d
0798b  cd 21                int 0x21
0798d  73 03                jae loc_7992
0798f  e9 86 00             jmp loc_7a18
loc_7992:
07992  a3 eb 37             mov word ptr [0x37eb], ax    ; position_tuile_carte
07995  8b 1e eb 37          mov bx, word ptr [0x37eb]    ; position_tuile_carte
07999  b9 ff ff             mov cx, 0xffff
0799c  ba 00 00             mov dx, 0
0799f  1e                   push ds
079a0  50                   push ax
079a1  a1 27 5e             mov ax, word ptr [0x5e27]    ; seg_annexe
079a4  8e d8                mov ds, ax
079a6  58                   pop ax
079a7  b4 3f                mov ah, 0x3f
079a9  cd 21                int 0x21
079ab  1f                   pop ds
079ac  72 6a                jb loc_7a18
079ae  8b 1e eb 37          mov bx, word ptr [0x37eb]    ; position_tuile_carte
079b2  b4 3e                mov ah, 0x3e
079b4  cd 21                int 0x21
079b6  72 60                jb loc_7a18
loc_79b8:
079b8  e8 ff bc             call clavier_installe
079bb  e8 bc 01             call liste_emplacements
079be  80 3e 7a ab 08       cmp byte ptr [0xab7a], 8    ; choix_menu
079c3  75 03                jne loc_79c8
079c5  e9 e1 00             jmp loc_7aa9
loc_79c8:
079c8  8a 1e 9e 40          mov bl, byte ptr [0x409e]    ; heros_selectionne
079cc  32 ff                xor bh, bh
079ce  d1 e3                shl bx, 1
079d0  56                   push si
079d1  8b b7 d7 45          mov si, word ptr [bx + 0x45d7]    ; noms_heros
079d5  b9 10 00             mov cx, 0x10
079d8  50                   push ax
079d9  a1 27 5e             mov ax, word ptr [0x5e27]    ; seg_annexe
079dc  8e c0                mov es, ax
079de  58                   pop ax
079df  f3 a4                rep movsb byte ptr es:[di], byte ptr [si]
079e1  5f                   pop di
079e2  8b b7 41 43          mov si, word ptr [bx + 0x4341]    ; adresses_fiches
079e6  b9 1a 00             mov cx, 0x1a
079e9  f3 a4                rep movsb byte ptr es:[di], byte ptr [si]
loc_79eb:
079eb  c7 06 07 39 b3 5f    mov word ptr [0x3907], 0x5fb3    ; fichier_nom, "quest.sav"
079f1  c7 06 03 39 00 00    mov word ptr [0x3903], 0    ; fichier_offset
079f7  c7 06 05 39 60 05    mov word ptr [0x3905], 0x560    ; fichier_taille
079fd  a1 27 5e             mov ax, word ptr [0x5e27]    ; seg_annexe
07a00  a3 01 39             mov word ptr [0x3901], ax    ; fichier_segment
07a03  e8 9a bf             call sauve_fichier
07a06  83 3e e9 37 00       cmp word ptr [0x37e9], 0    ; erreur_fichier
07a0b  75 03                jne loc_7a10
07a0d  e9 99 00             jmp loc_7aa9
loc_7a10:
07a10  bb 18 00             mov bx, 0x18    ; message « IL Y A UNE ERREUR DE DISQUETTE »
07a13  e8 d7 0e             call affiche_message
07a16  eb d3                jmp loc_79eb
loc_7a18:
07a18  e8 28 0a             call sauve_quest_sav
07a1b  eb 9b                jmp loc_79b8
loc_7a1d:
07a1d  bb 0e 00             mov bx, 0xe    ; message « INTRODUISEZ VOTRE / DISQUETTE DES DONNEES »
07a20  e8 ca 0e             call affiche_message
07a23  e8 cb bc             call clavier_retire
07a26  ba b3 5f             mov dx, 0x5fb3    ; "quest.sav"
07a29  32 c0                xor al, al
07a2b  b4 3d                mov ah, 0x3d
07a2d  cd 21                int 0x21
07a2f  72 26                jb loc_7a57
07a31  a3 eb 37             mov word ptr [0x37eb], ax    ; position_tuile_carte
07a34  8b 1e eb 37          mov bx, word ptr [0x37eb]    ; position_tuile_carte
07a38  b9 ff ff             mov cx, 0xffff
07a3b  ba 00 00             mov dx, 0
07a3e  1e                   push ds
07a3f  50                   push ax
07a40  a1 27 5e             mov ax, word ptr [0x5e27]    ; seg_annexe
07a43  8e d8                mov ds, ax
07a45  58                   pop ax
07a46  b4 3f                mov ah, 0x3f
07a48  cd 21                int 0x21
07a4a  1f                   pop ds
07a4b  72 0a                jb loc_7a57
07a4d  8b 1e eb 37          mov bx, word ptr [0x37eb]    ; position_tuile_carte
07a51  b4 3e                mov ah, 0x3e
07a53  cd 21                int 0x21
07a55  73 0b                jae loc_7a62
loc_7a57:
07a57  e8 60 bc             call clavier_installe
07a5a  bb 18 00             mov bx, 0x18    ; message « IL Y A UNE ERREUR DE DISQUETTE »
07a5d  e8 8d 0e             call affiche_message
07a60  eb 47                jmp loc_7aa9
loc_7a62:
07a62  e8 55 bc             call clavier_installe
07a65  e8 12 01             call liste_emplacements
07a68  80 3e 7a ab 08       cmp byte ptr [0xab7a], 8    ; choix_menu
07a6d  75 03                jne loc_7a72
07a6f  eb 38                jmp loc_7aa9
; ---- 1 octets non atteints (7a71-7a71)
loc_7a72:
07a72  8a 1e 9e 40          mov bl, byte ptr [0x409e]    ; heros_selectionne
07a76  32 ff                xor bh, bh
07a78  d1 e3                shl bx, 1
07a7a  56                   push si
07a7b  8b f7                mov si, di
07a7d  8b bf d7 45          mov di, word ptr [bx + 0x45d7]    ; noms_heros
07a81  b9 10 00             mov cx, 0x10
07a84  50                   push ax
07a85  b8 7c 09             mov ax, 0x97c
07a88  8e c0                mov es, ax
07a8a  58                   pop ax
07a8b  1e                   push ds
07a8c  50                   push ax
07a8d  a1 27 5e             mov ax, word ptr [0x5e27]    ; seg_annexe
07a90  8e d8                mov ds, ax
07a92  58                   pop ax
07a93  f3 a4                rep movsb byte ptr es:[di], byte ptr [si]
07a95  1f                   pop ds
07a96  5e                   pop si
07a97  8b bf 41 43          mov di, word ptr [bx + 0x4341]    ; adresses_fiches
07a9b  1e                   push ds
07a9c  50                   push ax
07a9d  a1 27 5e             mov ax, word ptr [0x5e27]    ; seg_annexe
07aa0  8e d8                mov ds, ax
07aa2  58                   pop ax
07aa3  b9 1a 00             mov cx, 0x1a
07aa6  f3 a4                rep movsb byte ptr es:[di], byte ptr [si]
07aa8  1f                   pop ds
loc_7aa9:
07aa9  83 3e 90 31 08       cmp word ptr [0x3190], 8    ; mode_video
07aae  75 65                jne loc_7b15
07ab0  c7 06 07 39 90 5e    mov word ptr [0x3907], 0x5e90    ; fichier_nom, "shopmp.vga"
07ab6  c7 06 03 39 00 00    mov word ptr [0x3903], 0    ; fichier_offset
07abc  b8 63 14             mov ax, 0x1463
07abf  a3 01 39             mov word ptr [0x3901], ax    ; fichier_segment
loc_7ac2:
07ac2  c7 06 e9 37 00 00    mov word ptr [0x37e9], 0    ; erreur_fichier
07ac8  e8 26 bc             call clavier_retire
07acb  e8 fa be             call fichier_ouvre
07ace  83 3e e9 37 00       cmp word ptr [0x37e9], 0    ; erreur_fichier
07ad3  75 03                jne loc_7ad8
07ad5  eb 0f                jmp loc_7ae6
; ---- 1 octets non atteints (7ad7-7ad7)
loc_7ad8:
07ad8  e8 df bb             call clavier_installe
07adb  bb 50 02             mov bx, 0x250    ; message « INTRODUISEZ VOTRE / HEROQUEST DISQUETTE 2 »
07ade  e8 0c 0e             call affiche_message
07ae1  e8 0d bc             call clavier_retire
07ae4  eb dc                jmp loc_7ac2
loc_7ae6:
07ae6  e8 13 bf             call fichier_lit
07ae9  83 3e e9 37 00       cmp word ptr [0x37e9], 0    ; erreur_fichier
07aee  75 e8                jne loc_7ad8
07af0  a3 05 39             mov word ptr [0x3905], ax    ; fichier_taille
07af3  e8 c4 bb             call clavier_installe
07af6  a1 27 5e             mov ax, word ptr [0x5e27]    ; seg_annexe
07af9  8e c0                mov es, ax
07afb  33 f6                xor si, si
07afd  bf 00 00             mov di, 0
07b00  b8 63 14             mov ax, 0x1463
07b03  8e d8                mov ds, ax
07b05  b9 ff ff             mov cx, 0xffff
07b08  e8 c6 ca             call lz_decompresse
07b0b  50                   push ax
07b0c  b8 7c 09             mov ax, 0x97c
07b0f  8e d8                mov ds, ax
07b11  58                   pop ax
07b12  e9 07 fc             jmp loc_771c
loc_7b15:
07b15  c7 06 07 39 2c 5f    mov word ptr [0x3907], 0x5f2c    ; fichier_nom, "shopmp.ega"
07b1b  c7 06 03 39 00 00    mov word ptr [0x3903], 0    ; fichier_offset
07b21  b8 63 14             mov ax, 0x1463
07b24  a3 01 39             mov word ptr [0x3901], ax    ; fichier_segment
loc_7b27:
07b27  c7 06 e9 37 00 00    mov word ptr [0x37e9], 0    ; erreur_fichier
07b2d  e8 c1 bb             call clavier_retire
07b30  e8 95 be             call fichier_ouvre
07b33  83 3e e9 37 00       cmp word ptr [0x37e9], 0    ; erreur_fichier
07b38  75 03                jne loc_7b3d
07b3a  eb 0f                jmp loc_7b4b
; ---- 1 octets non atteints (7b3c-7b3c)
loc_7b3d:
07b3d  e8 7a bb             call clavier_installe
07b40  bb 50 02             mov bx, 0x250    ; message « INTRODUISEZ VOTRE / HEROQUEST DISQUETTE 2 »
07b43  e8 a7 0d             call affiche_message
07b46  e8 a8 bb             call clavier_retire
07b49  eb dc                jmp loc_7b27
loc_7b4b:
07b4b  e8 ae be             call fichier_lit
07b4e  83 3e e9 37 00       cmp word ptr [0x37e9], 0    ; erreur_fichier
07b53  75 e8                jne loc_7b3d
07b55  a3 05 39             mov word ptr [0x3905], ax    ; fichier_taille
07b58  e8 5f bb             call clavier_installe
07b5b  a1 27 5e             mov ax, word ptr [0x5e27]    ; seg_annexe
07b5e  8e c0                mov es, ax
07b60  33 f6                xor si, si
07b62  bf 00 00             mov di, 0
07b65  b8 63 14             mov ax, 0x1463
07b68  8e d8                mov ds, ax
07b6a  b9 ff ff             mov cx, 0xffff
07b6d  e8 61 ca             call lz_decompresse
07b70  50                   push ax
07b71  b8 7c 09             mov ax, 0x97c
07b74  8e d8                mov ds, ax
07b76  58                   pop ax
07b77  e9 a2 fb             jmp loc_771c

; ======== liste_emplacements   (appelée depuis 79bb, 7a65)
; les 8 emplacements de QUEST.SAV du type du héros ; DI nom, SI fiche de l'emplacement choisi
07b7a  a0 9e 40             mov al, byte ptr [0x409e]    ; heros_selectionne
07b7d  32 e4                xor ah, ah
07b7f  b9 88 00             mov cx, 0x88
07b82  f7 e1                mul cx
07b84  50                   push ax
07b85  8b f8                mov di, ax
07b87  b9 88 00             mov cx, 0x88
07b8a  bb 72 01             mov bx, 0x172
07b8d  8b b7 c1 5f          mov si, word ptr [bx + 0x5fc1]    ; textes
07b91  81 c6 c1 5f          add si, 0x5fc1    ; textes
07b95  56                   push si
07b96  8b f7                mov si, di
07b98  5f                   pop di
07b99  83 c7 03             add di, 3
07b9c  50                   push ax
07b9d  b8 7c 09             mov ax, 0x97c
07ba0  8e c0                mov es, ax
07ba2  58                   pop ax
07ba3  1e                   push ds
07ba4  50                   push ax
07ba5  a1 27 5e             mov ax, word ptr [0x5e27]    ; seg_annexe
07ba8  8e d8                mov ds, ax
07baa  58                   pop ax
07bab  b9 08 00             mov cx, 8
loc_7bae:
07bae  51                   push cx
07baf  b9 11 00             mov cx, 0x11
07bb2  f3 a4                rep movsb byte ptr es:[di], byte ptr [si]
07bb4  59                   pop cx
07bb5  83 c7 03             add di, 3
07bb8  e2 f4                loop loc_7bae
07bba  1f                   pop ds
07bbb  bb 12 00             mov bx, 0x12
07bbe  e8 2c 0d             call affiche_message
07bc1  5f                   pop di
07bc2  80 3e 7a ab 08       cmp byte ptr [0xab7a], 8    ; choix_menu
07bc7  75 01                jne loc_7bca
07bc9  c3                   ret
loc_7bca:
07bca  80 3e 7a ab fe       cmp byte ptr [0xab7a], 0xfe    ; choix_menu
07bcf  75 01                jne loc_7bd2
07bd1  c3                   ret
loc_7bd2:
07bd2  a0 7a ab             mov al, byte ptr [0xab7a]    ; choix_menu
07bd5  32 e4                xor ah, ah
07bd7  b9 11 00             mov cx, 0x11
07bda  f7 e1                mul cx
07bdc  03 f8                add di, ax
07bde  a0 9e 40             mov al, byte ptr [0x409e]    ; heros_selectionne
07be1  32 e4                xor ah, ah
07be3  b9 d0 00             mov cx, 0xd0
07be6  f7 e1                mul cx
07be8  be 20 02             mov si, 0x220
07beb  03 f0                add si, ax
07bed  a0 7a ab             mov al, byte ptr [0xab7a]    ; choix_menu
07bf0  32 e4                xor ah, ah
07bf2  b9 1a 00             mov cx, 0x1a
07bf5  f7 e1                mul cx
07bf7  03 f0                add si, ax
07bf9  c3                   ret

; ======== dessine_cadre   (appelée depuis 7dc2)
; cadre d'une boîte de texte (images SHOPMP 0xB7C0 à 0xBEC0, 16 × 16)
07bfa  8a 04                mov al, byte ptr [si]
07bfc  d0 e0                shl al, 1
07bfe  d0 e0                shl al, 1
07c00  d0 e0                shl al, 1
07c02  32 e4                xor ah, ah
07c04  2d 10 00             sub ax, 0x10
07c07  8a 5c 01             mov bl, byte ptr [si + 1]
07c0a  d0 e3                shl bl, 1
07c0c  d0 e3                shl bl, 1
07c0e  d0 e3                shl bl, 1
07c10  8a fc                mov bh, ah
07c12  83 eb 10             sub bx, 0x10
07c15  e8 5c b5             call ligne_ecran
07c18  89 1e e9 37          mov word ptr [0x37e9], bx    ; erreur_fichier
07c1c  8b 44 02             mov ax, word ptr [si + 2]
07c1f  05 02 00             add ax, 2
07c22  d1 e8                shr ax, 1
07c24  a3 eb 37             mov word ptr [0x37eb], ax    ; position_tuile_carte
07c27  8b 44 04             mov ax, word ptr [si + 4]
07c2a  05 02 00             add ax, 2
07c2d  d1 e8                shr ax, 1
07c2f  a3 ed 37             mov word ptr [0x37ed], ax    ; ligne_carte
07c32  d1 e0                shl ax, 1
07c34  d1 e0                shl ax, 1
07c36  d1 e0                shl ax, 1
07c38  d1 e0                shl ax, 1
07c3a  05 10 00             add ax, 0x10
07c3d  a3 ef 37             mov word ptr [0x37ef], ax    ; colonne_carte
07c40  be c0 b7             mov si, 0xb7c0
07c43  8b 3e e9 37          mov di, word ptr [0x37e9]    ; erreur_fichier
07c47  a1 27 5e             mov ax, word ptr [0x5e27]    ; seg_annexe
07c4a  a3 4e 37             mov word ptr [0x374e], ax    ; segment_source
07c4d  50                   push ax
07c4e  b8 63 14             mov ax, 0x1463
07c51  8e c0                mov es, ax
07c53  58                   pop ax
07c54  bd 10 00             mov bp, 0x10
07c57  b9 10 00             mov cx, 0x10
07c5a  1e                   push ds
07c5b  e8 f5 be             call copie_image
07c5e  1f                   pop ds
07c5f  8b 0e ed 37          mov cx, word ptr [0x37ed]    ; ligne_carte
07c63  ff 36 e9 37          push word ptr [0x37e9]    ; erreur_fichier
loc_7c67:
07c67  83 06 e9 37 10       add word ptr [0x37e9], 0x10    ; erreur_fichier
07c6c  51                   push cx
07c6d  be c0 bb             mov si, 0xbbc0
07c70  8b 3e e9 37          mov di, word ptr [0x37e9]    ; erreur_fichier
07c74  a1 27 5e             mov ax, word ptr [0x5e27]    ; seg_annexe
07c77  a3 4e 37             mov word ptr [0x374e], ax    ; segment_source
07c7a  50                   push ax
07c7b  b8 63 14             mov ax, 0x1463
07c7e  8e c0                mov es, ax
07c80  58                   pop ax
07c81  bd 10 00             mov bp, 0x10
07c84  b9 10 00             mov cx, 0x10
07c87  1e                   push ds
07c88  e8 c8 be             call copie_image
07c8b  1f                   pop ds
07c8c  59                   pop cx
07c8d  e2 d8                loop loc_7c67
07c8f  83 06 e9 37 10       add word ptr [0x37e9], 0x10    ; erreur_fichier
07c94  be c0 b8             mov si, 0xb8c0
07c97  8b 3e e9 37          mov di, word ptr [0x37e9]    ; erreur_fichier
07c9b  a1 27 5e             mov ax, word ptr [0x5e27]    ; seg_annexe
07c9e  a3 4e 37             mov word ptr [0x374e], ax    ; segment_source
07ca1  50                   push ax
07ca2  b8 63 14             mov ax, 0x1463
07ca5  8e c0                mov es, ax
07ca7  58                   pop ax
07ca8  bd 10 00             mov bp, 0x10
07cab  b9 10 00             mov cx, 0x10
07cae  1e                   push ds
07caf  e8 a1 be             call copie_image
07cb2  1f                   pop ds
07cb3  8f 06 e9 37          pop word ptr [0x37e9]    ; erreur_fichier
07cb7  81 06 e9 37 00 14    add word ptr [0x37e9], 0x1400    ; erreur_fichier
07cbd  8b 0e eb 37          mov cx, word ptr [0x37eb]    ; position_tuile_carte
loc_7cc1:
07cc1  51                   push cx
07cc2  ff 36 e9 37          push word ptr [0x37e9]    ; erreur_fichier
07cc6  be c0 be             mov si, 0xbec0
07cc9  8b 3e e9 37          mov di, word ptr [0x37e9]    ; erreur_fichier
07ccd  a1 27 5e             mov ax, word ptr [0x5e27]    ; seg_annexe
07cd0  a3 4e 37             mov word ptr [0x374e], ax    ; segment_source
07cd3  50                   push ax
07cd4  b8 63 14             mov ax, 0x1463
07cd7  8e c0                mov es, ax
07cd9  58                   pop ax
07cda  bd 10 00             mov bp, 0x10
07cdd  b9 10 00             mov cx, 0x10
07ce0  1e                   push ds
07ce1  e8 6f be             call copie_image
07ce4  1f                   pop ds
07ce5  a1 e9 37             mov ax, word ptr [0x37e9]    ; erreur_fichier
07ce8  03 06 ef 37          add ax, word ptr [0x37ef]    ; colonne_carte
07cec  be c0 bc             mov si, 0xbcc0
07cef  8b f8                mov di, ax
07cf1  a1 27 5e             mov ax, word ptr [0x5e27]    ; seg_annexe
07cf4  a3 4e 37             mov word ptr [0x374e], ax    ; segment_source
07cf7  50                   push ax
07cf8  b8 63 14             mov ax, 0x1463
07cfb  8e c0                mov es, ax
07cfd  58                   pop ax
07cfe  bd 10 00             mov bp, 0x10
07d01  b9 10 00             mov cx, 0x10
07d04  1e                   push ds
07d05  e8 4b be             call copie_image
07d08  1f                   pop ds
07d09  8f 06 e9 37          pop word ptr [0x37e9]    ; erreur_fichier
07d0d  59                   pop cx
07d0e  81 06 e9 37 00 14    add word ptr [0x37e9], 0x1400    ; erreur_fichier
07d14  e2 ab                loop loc_7cc1
07d16  be c0 ba             mov si, 0xbac0
07d19  8b 3e e9 37          mov di, word ptr [0x37e9]    ; erreur_fichier
07d1d  a1 27 5e             mov ax, word ptr [0x5e27]    ; seg_annexe
07d20  a3 4e 37             mov word ptr [0x374e], ax    ; segment_source
07d23  50                   push ax
07d24  b8 63 14             mov ax, 0x1463
07d27  8e c0                mov es, ax
07d29  58                   pop ax
07d2a  bd 10 00             mov bp, 0x10
07d2d  b9 10 00             mov cx, 0x10
07d30  1e                   push ds
07d31  e8 1f be             call copie_image
07d34  1f                   pop ds
07d35  8b 0e ed 37          mov cx, word ptr [0x37ed]    ; ligne_carte
loc_7d39:
07d39  83 06 e9 37 10       add word ptr [0x37e9], 0x10    ; erreur_fichier
07d3e  51                   push cx
07d3f  be c0 bd             mov si, 0xbdc0
07d42  8b 3e e9 37          mov di, word ptr [0x37e9]    ; erreur_fichier
07d46  a1 27 5e             mov ax, word ptr [0x5e27]    ; seg_annexe
07d49  a3 4e 37             mov word ptr [0x374e], ax    ; segment_source
07d4c  50                   push ax
07d4d  b8 63 14             mov ax, 0x1463
07d50  8e c0                mov es, ax
07d52  58                   pop ax
07d53  bd 10 00             mov bp, 0x10
07d56  b9 10 00             mov cx, 0x10
07d59  1e                   push ds
07d5a  e8 f6 bd             call copie_image
07d5d  1f                   pop ds
07d5e  59                   pop cx
07d5f  e2 d8                loop loc_7d39
07d61  83 06 e9 37 10       add word ptr [0x37e9], 0x10    ; erreur_fichier
07d66  be c0 b9             mov si, 0xb9c0
07d69  8b 3e e9 37          mov di, word ptr [0x37e9]    ; erreur_fichier
07d6d  a1 27 5e             mov ax, word ptr [0x5e27]    ; seg_annexe
07d70  a3 4e 37             mov word ptr [0x374e], ax    ; segment_source
07d73  50                   push ax
07d74  b8 63 14             mov ax, 0x1463
07d77  8e c0                mov es, ax
07d79  58                   pop ax
07d7a  bd 10 00             mov bp, 0x10
07d7d  b9 10 00             mov cx, 0x10
07d80  1e                   push ds
07d81  e8 cf bd             call copie_image
07d84  1f                   pop ds
07d85  c3                   ret

; ======== saisie_texte   (appelée depuis 7924)
07d86  c6 06 7a ab 00       mov byte ptr [0xab7a], 0    ; choix_menu
07d8b  c6 06 79 ab 00       mov byte ptr [0xab79], 0
07d90  90                   nop
07d91  bb 6d ab             mov bx, 0xab6d
07d94  89 1e 35 46          mov word ptr [0x4635], bx    ; zones_actives
07d98  50                   push ax
07d99  b8 7c 09             mov ax, 0x97c
07d9c  8e c0                mov es, ax
07d9e  58                   pop ax
07d9f  b0 00                mov al, 0
07da1  bf fa ab             mov di, 0xabfa    ; "________________"
07da4  b9 10 00             mov cx, 0x10
07da7  f3 aa                rep stosb byte ptr es:[di], al
07da9  be 2e ab             mov si, 0xab2e
07dac  83 3e 90 31 06       cmp word ptr [0x3190], 6    ; mode_video
07db1  75 04                jne loc_7db7
07db3  c6 44 07 0e          mov byte ptr [si + 7], 0xe
loc_7db7:
07db7  83 3e 90 31 04       cmp word ptr [0x3190], 4    ; mode_video
07dbc  75 04                jne loc_7dc2
07dbe  c6 44 07 07          mov byte ptr [si + 7], 7
loc_7dc2:
07dc2  e8 35 fe             call dessine_cadre
07dc5  be 2e ab             mov si, 0xab2e
07dc8  e8 3c c6             call efface_boite
07dcb  bd 36 ab             mov bp, 0xab36
07dce  83 3e 90 31 06       cmp word ptr [0x3190], 6    ; mode_video
07dd3  75 05                jne loc_7dda
07dd5  3e c6 46 02 0e       mov byte ptr ds:[bp + 2], 0xe
loc_7dda:
07dda  83 3e 90 31 04       cmp word ptr [0x3190], 4    ; mode_video
07ddf  75 05                jne loc_7de6
07de1  3e c6 46 02 07       mov byte ptr ds:[bp + 2], 7
loc_7de6:
07de6  e8 93 b3             call affiche_texte
07de9  bd f4 ab             mov bp, 0xabf4
07dec  83 3e 90 31 06       cmp word ptr [0x3190], 6    ; mode_video
07df1  75 05                jne loc_7df8
07df3  3e c6 46 02 0e       mov byte ptr ds:[bp + 2], 0xe
loc_7df8:
07df8  83 3e 90 31 04       cmp word ptr [0x3190], 4    ; mode_video
07dfd  75 05                jne loc_7e04
07dff  3e c6 46 02 07       mov byte ptr ds:[bp + 2], 7
loc_7e04:
07e04  e8 75 b3             call affiche_texte
07e07  e8 65 e7             call sauve_tampon
07e0a  e9 c2 00             jmp loc_7ecf
loc_7e0d:
07e0d  e8 42 b9             call lit_commandes
07e10  e8 e9 e5             call curseur_memorise
07e13  83 3e e9 47 50       cmp word ptr [0x47e9], 0x50
07e18  73 03                jae loc_7e1d
07e1a  e9 a5 00             jmp loc_7ec2
loc_7e1d:
07e1d  83 3e e9 47 59       cmp word ptr [0x47e9], 0x59
07e22  76 03                jbe loc_7e27
07e24  e9 9b 00             jmp loc_7ec2
loc_7e27:
07e27  8b 1e e7 47          mov bx, word ptr [0x47e7]
07e2b  d1 eb                shr bx, 1
07e2d  d1 eb                shr bx, 1
07e2f  d1 eb                shr bx, 1
07e31  88 1e 64 ab          mov byte ptr [0xab64], bl
07e35  80 eb 06             sub bl, 6
07e38  88 1e 7a ab          mov byte ptr [0xab7a], bl    ; choix_menu
07e3c  80 fb 1b             cmp bl, 0x1b
07e3f  76 03                jbe loc_7e44
07e41  e9 8b 00             jmp loc_7ecf
loc_7e44:
07e44  8a 87 3c ab          mov al, byte ptr [bx - 0x54c4]
07e48  a2 68 ab             mov byte ptr [0xab68], al
07e4b  f6 06 92 39 10       test byte ptr [0x3992], 0x10    ; commandes
07e50  74 38                je loc_7e8a
07e52  32 ff                xor bh, bh
07e54  8a 1e 79 ab          mov bl, byte ptr [0xab79]
07e58  80 3e 7a ab 1b       cmp byte ptr [0xab7a], 0x1b    ; choix_menu
07e5d  75 03                jne loc_7e62
07e5f  e9 00 01             jmp loc_7f62
loc_7e62:
07e62  80 fb 10             cmp bl, 0x10
07e65  73 23                jae loc_7e8a
07e67  fe 06 79 ab          inc byte ptr [0xab79]
loc_7e6b:
07e6b  88 87 fa ab          mov byte ptr [bx - 0x5406], al
07e6f  e8 d6 ab             call son_clic
07e72  e8 df ba             call attend_relache_boutons
07e75  bd f4 ab             mov bp, 0xabf4
07e78  83 3e 90 31 04       cmp word ptr [0x3190], 4    ; mode_video
07e7d  75 05                jne loc_7e84
07e7f  3e c6 46 02 07       mov byte ptr ds:[bp + 2], 7
loc_7e84:
07e84  e8 f5 b2             call affiche_texte
07e87  e8 e5 e6             call sauve_tampon
loc_7e8a:
07e8a  bd 62 ab             mov bp, 0xab62
07e8d  83 3e 90 31 08       cmp word ptr [0x3190], 8    ; mode_video
07e92  74 24                je loc_7eb8
07e94  3e c6 46 09 0e       mov byte ptr ds:[bp + 9], 0xe
07e99  3e c6 46 05 0e       mov byte ptr ds:[bp + 5], 0xe
07e9e  83 3e 90 31 04       cmp word ptr [0x3190], 4    ; mode_video
07ea3  75 05                jne loc_7eaa
07ea5  3e c6 46 09 07       mov byte ptr ds:[bp + 9], 7
loc_7eaa:
07eaa  75 05                jne loc_7eb1
07eac  3e c6 46 05 07       mov byte ptr ds:[bp + 5], 7
loc_7eb1:
07eb1  75 05                jne loc_7eb8
07eb3  3e c6 46 04 0c       mov byte ptr ds:[bp + 4], 0xc
loc_7eb8:
07eb8  e8 c1 b2             call affiche_texte
07ebb  fe 06 7a ab          inc byte ptr [0xab7a]    ; choix_menu
07ebf  eb 0e                jmp loc_7ecf
; ---- 1 octets non atteints (7ec1-7ec1)
loc_7ec2:
07ec2  e8 7c e5             call clic_tour
07ec5  80 3e 7a ab ff       cmp byte ptr [0xab7a], 0xff    ; choix_menu
07eca  75 03                jne loc_7ecf
07ecc  e9 79 ab             jmp son_clic
loc_7ecf:
07ecf  8b 16 e7 47          mov dx, word ptr [0x47e7]
07ed3  8b 2e e9 47          mov bp, word ptr [0x47e9]
07ed7  b0 11                mov al, 0x11
07ed9  be 6d ab             mov si, 0xab6d
07edc  3b 14                cmp dx, word ptr [si]
07ede  72 1e                jb loc_7efe
07ee0  3b 54 02             cmp dx, word ptr [si + 2]
07ee3  77 19                ja loc_7efe
07ee5  3b 6c 04             cmp bp, word ptr [si + 4]
07ee8  72 14                jb loc_7efe
07eea  3b 6c 06             cmp bp, word ptr [si + 6]
07eed  77 02                ja loc_7ef1
07eef  b0 26                mov al, 0x26
loc_7ef1:
07ef1  3c 26                cmp al, 0x26
07ef3  75 09                jne loc_7efe
07ef5  83 3e 90 31 04       cmp word ptr [0x3190], 4    ; mode_video
07efa  75 02                jne loc_7efe
07efc  b0 0c                mov al, 0xc
loc_7efe:
07efe  bd 58 ab             mov bp, 0xab58
07f01  83 3e 90 31 08       cmp word ptr [0x3190], 8    ; mode_video
07f06  74 05                je loc_7f0d
07f08  3e c6 46 02 0e       mov byte ptr ds:[bp + 2], 0xe
loc_7f0d:
07f0d  3e 88 46 01          mov byte ptr ds:[bp + 1], al
07f11  83 3e 90 31 04       cmp word ptr [0x3190], 4    ; mode_video
07f16  75 05                jne loc_7f1d
07f18  3e c6 46 02 07       mov byte ptr ds:[bp + 2], 7
loc_7f1d:
07f1d  e8 5c b2             call affiche_texte
07f20  e8 f1 de             call curseur_dessine
07f23  e8 be e1             call affiche_tampon
07f26  e8 ae de             call curseur_efface
07f29  80 3e 7a ab 00       cmp byte ptr [0xab7a], 0    ; choix_menu
07f2e  75 03                jne loc_7f33
07f30  e9 da fe             jmp loc_7e0d
loc_7f33:
07f33  80 3e 7a ab 1c       cmp byte ptr [0xab7a], 0x1c    ; choix_menu
07f38  76 03                jbe loc_7f3d
07f3a  e9 d0 fe             jmp loc_7e0d
loc_7f3d:
07f3d  fe 0e 7a ab          dec byte ptr [0xab7a]    ; choix_menu
07f41  bd 36 ab             mov bp, 0xab36
07f44  e8 35 b2             call affiche_texte
07f47  c6 06 7a ab 00       mov byte ptr [0xab7a], 0    ; choix_menu
07f4c  e9 be fe             jmp loc_7e0d

; ======== saisie_fin
; zone de fin de saisie_texte (pointée en DS:AB75) : termine le texte DS:ABFA par 00h, choix_menu = FFh
07f4f  be fa ab             mov si, 0xabfa    ; "________________"
07f52  43                   inc bx
07f53  c6 00 00             mov byte ptr [bx + si], 0
07f56  c6 06 7a ab ff       mov byte ptr [0xab7a], 0xff    ; choix_menu
07f5b  e8 f6 b9             call attend_relache_boutons
07f5e  e8 e7 aa             call son_clic
07f61  c3                   ret
loc_7f62:
07f62  80 fb 00             cmp bl, 0
07f65  75 03                jne loc_7f6a
07f67  e9 20 ff             jmp loc_7e8a
loc_7f6a:
07f6a  fe 0e 79 ab          dec byte ptr [0xab79]
07f6e  4b                   dec bx
07f6f  b0 5f                mov al, 0x5f
07f71  e9 f7 fe             jmp loc_7e6b

; ======== attribue_sorts   (appelée depuis 743d)
; vide les sorts de l'elfe et de l'enchanteur, fait choisir les éléments, puis pose leurs bits (DS:ACD9) en +0x0B et +0x0C ; avec les deux héros, les éléments restants vont à l'enchanteur
07f74  c6 06 a2 46 00       mov byte ptr [0x46a2], 0
07f79  c6 06 a3 46 00       mov byte ptr [0x46a3], 0
07f7e  c6 06 bc 46 00       mov byte ptr [0x46bc], 0
07f83  c6 06 bd 46 00       mov byte ptr [0x46bd], 0
07f88  e8 46 00             call choix_elements
07f8b  bf 13 ac             mov di, 0xac13    ; elements_sorts
07f8e  bb d9 ac             mov bx, 0xacd9    ; sorts_elements
07f91  b9 04 00             mov cx, 4
loc_7f94:
07f94  80 3d 00             cmp byte ptr [di], 0
07f97  74 1e                je loc_7fb7
07f99  be 97 46             mov si, 0x4697
07f9c  80 3d 01             cmp byte ptr [di], 1
07f9f  74 03                je loc_7fa4
07fa1  be b1 46             mov si, 0x46b1
loc_7fa4:
07fa4  8a 44 0b             mov al, byte ptr [si + 0xb]
07fa7  0a 07                or al, byte ptr [bx]
07fa9  88 44 0b             mov byte ptr [si + 0xb], al
07fac  43                   inc bx
07fad  8a 44 0c             mov al, byte ptr [si + 0xc]
07fb0  0a 07                or al, byte ptr [bx]
07fb2  88 44 0c             mov byte ptr [si + 0xc], al
07fb5  eb 15                jmp loc_7fcc
loc_7fb7:
07fb7  a0 a2 44             mov al, byte ptr [0x44a2]
07fba  0a c0                or al, al
07fbc  74 0d                je loc_7fcb
07fbe  a0 a3 44             mov al, byte ptr [0x44a3]
07fc1  0a c0                or al, al
07fc3  74 06                je loc_7fcb
07fc5  b0 02                mov al, 2
07fc7  88 05                mov byte ptr [di], al
07fc9  eb c9                jmp loc_7f94
loc_7fcb:
07fcb  43                   inc bx
loc_7fcc:
07fcc  43                   inc bx
07fcd  47                   inc di
07fce  e2 c4                loop loc_7f94
07fd0  c3                   ret

; ======== choix_elements   (appelée depuis 7f88)
; l'enchanteur choisit 3 éléments (1 si l'elfe joue), puis l'elfe 1, chacun avec les commandes de son joueur
07fd1  a0 a2 44             mov al, byte ptr [0x44a2]
07fd4  02 06 a3 44          add al, byte ptr [0x44a3]
07fd8  75 01                jne loc_7fdb
07fda  c3                   ret
loc_7fdb:
07fdb  c6 06 7a ab 00       mov byte ptr [0xab7a], 0    ; choix_menu
07fe0  bb 00 00             mov bx, 0
07fe3  89 1e 13 ac          mov word ptr [0xac13], bx    ; elements_sorts
07fe7  89 1e 15 ac          mov word ptr [0xac15], bx
07feb  80 3e a3 44 00       cmp byte ptr [0x44a3], 0
07ff0  74 22                je loc_8014
07ff2  c6 06 7a ab 02       mov byte ptr [0xab7a], 2    ; choix_menu
07ff7  a0 98 31             mov al, byte ptr [0x3198]
07ffa  a2 93 31             mov byte ptr [0x3193], al    ; commande_type
07ffd  b9 03 00             mov cx, 3
08000  80 3e a2 44 00       cmp byte ptr [0x44a2], 0
08005  74 03                je loc_800a
08007  b9 01 00             mov cx, 1
loc_800a:
0800a  51                   push cx
0800b  be b6 01             mov si, 0x1b6
0800e  e8 19 00             call choisit_element
08011  59                   pop cx
08012  e2 f6                loop loc_800a
loc_8014:
08014  80 3e a2 44 00       cmp byte ptr [0x44a2], 0
08019  75 01                jne loc_801c
0801b  c3                   ret
loc_801c:
0801c  be b4 01             mov si, 0x1b4
0801f  c6 06 7a ab 01       mov byte ptr [0xab7a], 1    ; choix_menu
08024  a0 97 31             mov al, byte ptr [0x3197]
08027  a2 93 31             mov byte ptr [0x3193], al    ; commande_type

; ======== choisit_element   (appelée depuis 800e)
; message SI (« ... CHOISIT TES SORTS »), attend un clic sur un élément libre (zones DS:AA82) et y inscrit choix_menu (1 elfe, 2 enchanteur)
0802a  56                   push si
0802b  e8 b2 02             call dessine_elements
0802e  5e                   pop si
0802f  e8 77 e0             call affiche_chaine_sans_fond
08032  e8 3a e5             call sauve_tampon
loc_8035:
08035  e8 c4 e3             call curseur_memorise
08038  e8 d9 dd             call curseur_dessine
0803b  e8 a6 e0             call affiche_tampon
0803e  e8 96 dd             call curseur_efface
08041  e8 0e b7             call lit_commandes
08044  be 82 aa             mov si, 0xaa82    ; zones_elements
08047  e8 bb ce             call zone_cliquee
0804a  83 fb 02             cmp bx, 2
0804d  72 e6                jb loc_8035
0804f  83 fb 08             cmp bx, 8
08052  77 e1                ja loc_8035
08054  d0 eb                shr bl, 1
08056  fe cb                dec bl
08058  b7 00                mov bh, 0
0805a  80 bf 13 ac 00       cmp byte ptr [bx - 0x53ed], 0
0805f  74 02                je loc_8063
08061  eb d2                jmp loc_8035
loc_8063:
08063  a0 7a ab             mov al, byte ptr [0xab7a]    ; choix_menu
08066  88 87 13 ac          mov byte ptr [bx - 0x53ed], al
0806a  e8 db a9             call son_clic
0806d  e9 e4 b8             jmp attend_relache_boutons

; ======== armurerie   (appelée depuis 73e8)
; icône armurerie : achats (« VOUS NE POUVEZ PAS VOUS PERMETTRE CELA »)
08070  c7 06 37 46 00 00    mov word ptr [0x4637], 0    ; fiche_heros_courant
08076  c7 06 f1 47 20 2e    mov word ptr [0x47f1], 0x2e20
loc_807c:
0807c  e8 a4 e9             call fond_vers_tampon
0807f  be 40 7a             mov si, 0x7a40
08082  bf c8 d4             mov di, 0xd4c8
08085  a1 27 5e             mov ax, word ptr [0x5e27]    ; seg_annexe
08088  a3 4e 37             mov word ptr [0x374e], ax    ; segment_source
0808b  50                   push ax
0808c  b8 63 14             mov ax, 0x1463
0808f  8e c0                mov es, ax
08091  58                   pop ax
08092  bd 20 00             mov bp, 0x20
08095  b9 10 00             mov cx, 0x10
08098  1e                   push ds
08099  e8 b7 ba             call copie_image
0809c  1f                   pop ds
0809d  c7 06 e9 37 00 00    mov word ptr [0x37e9], 0    ; erreur_fichier
080a3  c7 06 ed 37 00 00    mov word ptr [0x37ed], 0    ; ligne_carte
080a9  c7 06 ef 37 b0 0c    mov word ptr [0x37ef], 0xcb0    ; colonne_carte
loc_80af:
080af  8b 3e e9 37          mov di, word ptr [0x37e9]    ; erreur_fichier
080b3  8b 36 ed 37          mov si, word ptr [0x37ed]    ; ligne_carte
080b7  8b 3e ef 37          mov di, word ptr [0x37ef]    ; colonne_carte
080bb  a1 2d 5e             mov ax, word ptr [0x5e2d]    ; seg_odds
080be  a3 4e 37             mov word ptr [0x374e], ax    ; segment_source
080c1  50                   push ax
080c2  b8 63 14             mov ax, 0x1463
080c5  8e c0                mov es, ax
080c7  58                   pop ax
080c8  bd 20 00             mov bp, 0x20
080cb  b9 2d 00             mov cx, 0x2d
080ce  1e                   push ds
080cf  e8 81 ba             call copie_image
080d2  1f                   pop ds
080d3  ff 06 e9 37          inc word ptr [0x37e9]    ; erreur_fichier
080d7  81 06 ed 37 a0 05    add word ptr [0x37ed], 0x5a0    ; ligne_carte
080dd  83 06 ef 37 40       add word ptr [0x37ef], 0x40    ; colonne_carte
080e2  83 3e e9 37 04       cmp word ptr [0x37e9], 4    ; erreur_fichier
080e7  74 02                je loc_80eb
080e9  eb c4                jmp loc_80af
loc_80eb:
080eb  c7 06 e9 37 00 00    mov word ptr [0x37e9], 0    ; erreur_fichier
080f1  c7 06 eb 37 08 53    mov word ptr [0x37eb], 0x5308    ; position_tuile_carte
080f7  b9 03 00             mov cx, 3
loc_80fa:
080fa  51                   push cx
080fb  ff 36 eb 37          push word ptr [0x37eb]    ; position_tuile_carte
080ff  b9 04 00             mov cx, 4
loc_8102:
08102  51                   push cx
08103  8b 36 e9 37          mov si, word ptr [0x37e9]    ; erreur_fichier
08107  8b 3e eb 37          mov di, word ptr [0x37eb]    ; position_tuile_carte
0810b  a1 25 5e             mov ax, word ptr [0x5e25]    ; seg_shopsp
0810e  a3 4e 37             mov word ptr [0x374e], ax    ; segment_source
08111  50                   push ax
08112  b8 63 14             mov ax, 0x1463
08115  8e c0                mov es, ax
08117  58                   pop ax
08118  bd 20 00             mov bp, 0x20
0811b  b9 20 00             mov cx, 0x20
0811e  1e                   push ds
0811f  e8 31 ba             call copie_image
08122  1f                   pop ds
08123  81 06 e9 37 00 04    add word ptr [0x37e9], 0x400    ; erreur_fichier
08129  83 06 eb 37 28       add word ptr [0x37eb], 0x28    ; position_tuile_carte
0812e  59                   pop cx
0812f  e2 d1                loop loc_8102
08131  8f 06 eb 37          pop word ptr [0x37eb]    ; position_tuile_carte
08135  81 06 eb 37 00 32    add word ptr [0x37eb], 0x3200    ; position_tuile_carte
0813b  59                   pop cx
0813c  e2 bc                loop loc_80fa
0813e  bd 83 ac             mov bp, 0xac83
08141  e8 38 b0             call affiche_texte
08144  8b 1e 37 46          mov bx, word ptr [0x4637]    ; fiche_heros_courant
08148  d1 e3                shl bx, 1
0814a  53                   push bx
0814b  8b b7 4b 43          mov si, word ptr [bx + 0x434b]    ; noms_types
0814f  e8 62 df             call affiche_texte_sans_fond
08152  bd 93 ac             mov bp, 0xac93
08155  e8 24 b0             call affiche_texte
08158  5b                   pop bx
08159  8b b7 d7 45          mov si, word ptr [bx + 0x45d7]    ; noms_heros
0815d  e8 54 df             call affiche_texte_sans_fond
08160  a1 37 46             mov ax, word ptr [0x4637]    ; fiche_heros_courant
08163  e8 19 dc             call fiche_personnage
08166  8b fe                mov di, si
08168  57                   push di
08169  bd 87 ac             mov bp, 0xac87
0816c  e8 6e e3             call affiche_or_fiche
0816f  bd 8f ac             mov bp, 0xac8f
08172  e8 07 b0             call affiche_texte
08175  be 52 01             mov si, 0x152
08178  e8 2e df             call affiche_chaine_sans_fond
0817b  5f                   pop di
0817c  e8 f1 00             call marque_achats
0817f  e8 ed e3             call sauve_tampon
08182  e8 cf b7             call attend_relache_boutons
loc_8185:
08185  e8 74 e2             call curseur_memorise
08188  e8 89 dc             call curseur_dessine
0818b  e8 56 df             call affiche_tampon
0818e  e8 46 dc             call curseur_efface
08191  e8 be b5             call lit_commandes
08194  f6 06 92 39 20       test byte ptr [0x3992], 0x20    ; commandes
08199  74 03                je loc_819e
0819b  eb 10                jmp loc_81ad
; ---- 1 octets non atteints (819d-819d)
loc_819e:
0819e  e8 a4 00             call armurerie_survol
081a1  be a4 aa             mov si, 0xaaa4    ; zones_armurerie
081a4  e8 5e cd             call zone_cliquee
081a7  8b d3                mov dx, bx
081a9  ff a7 b3 ac          jmp word ptr [bx - 0x534d]
loc_81ad:
081ad  e8 98 a8             call son_clic
081b0  e9 77 f1             jmp loc_732a
achete_objet:    ; refuse si le bit est déjà posé ou si le prix dépasse l'or (+9) ; sinon retire le prix et pose le bit (+0x0E)
081b3  8b da                mov bx, dx
081b5  03 db                add bx, bx
081b7  8b 8f 13 ac          mov cx, word ptr [bx - 0x53ed]
081bb  8b af 15 ac          mov bp, word ptr [bx - 0x53eb]
081bf  a1 37 46             mov ax, word ptr [0x4637]    ; fiche_heros_courant
081c2  e8 ba db             call fiche_personnage
081c5  84 4c 0e             test byte ptr [si + 0xe], cl
081c8  75 27                jne loc_81f1
081ca  84 6c 0f             test byte ptr [si + 0xf], ch
081cd  75 22                jne loc_81f1
081cf  3b 6c 09             cmp bp, word ptr [si + 9]
081d2  77 11                ja loc_81e5
081d4  29 6c 09             sub word ptr [si + 9], bp
081d7  0b d1                or dx, cx
081d9  09 4c 0e             or word ptr [si + 0xe], cx
081dc  e8 69 a8             call son_clic
081df  e8 72 b7             call attend_relache_boutons
081e2  e9 97 fe             jmp loc_807c
loc_81e5:
081e5  bb 02 00             mov bx, 2    ; message « VOUS NE POUVEZ PAS / VOUS PERMETTRE CELA »
081e8  e8 02 07             call affiche_message
081eb  e8 66 b7             call attend_relache_boutons
081ee  e9 8b fe             jmp loc_807c
loc_81f1:
081f1  bb 00 00             mov bx, 0    ; message « VOUS POSSEDEZ DEJA CELA »
081f4  e8 f6 06             call affiche_message
081f7  e8 5a b7             call attend_relache_boutons
081fa  e9 7f fe             jmp loc_807c
loc_81fd:
081fd  c7 06 37 46 00 00    mov word ptr [0x4637], 0    ; fiche_heros_courant
08203  a0 95 31             mov al, byte ptr [0x3195]    ; commandes_joueurs
08206  a2 93 31             mov byte ptr [0x3193], al    ; commande_type
08209  e8 3c a8             call son_clic
0820c  e9 6d fe             jmp loc_807c
loc_820f:
0820f  c7 06 37 46 01 00    mov word ptr [0x4637], 1    ; fiche_heros_courant
08215  a0 96 31             mov al, byte ptr [0x3196]
08218  a2 93 31             mov byte ptr [0x3193], al    ; commande_type
0821b  e8 2a a8             call son_clic
0821e  e9 5b fe             jmp loc_807c
loc_8221:
08221  c7 06 37 46 02 00    mov word ptr [0x4637], 2    ; fiche_heros_courant
08227  a0 97 31             mov al, byte ptr [0x3197]
0822a  a2 93 31             mov byte ptr [0x3193], al    ; commande_type
0822d  e8 18 a8             call son_clic
08230  e9 49 fe             jmp loc_807c
loc_8233:
08233  c7 06 37 46 03 00    mov word ptr [0x4637], 3    ; fiche_heros_courant
08239  a0 98 31             mov al, byte ptr [0x3198]
0823c  a2 93 31             mov byte ptr [0x3193], al    ; commande_type
0823f  e8 06 a8             call son_clic
08242  e9 37 fe             jmp loc_807c

; ======== armurerie_survol   (appelée depuis 819e)
; efface le bandeau (144, 56) et y écrit le nom de l'objet sous le curseur (table DS:AC99)
08245  b9 08 00             mov cx, 8
08248  bf 90 46             mov di, 0x4690
0824b  bd 90 00             mov bp, 0x90
0824e  e8 fd df             call restaure_rect_es
08251  bd 97 ac             mov bp, 0xac97
08254  e8 25 af             call affiche_texte
08257  be a4 aa             mov si, 0xaaa4    ; zones_armurerie
0825a  e8 bd cc             call zone_sous_curseur
0825d  83 fb 02             cmp bx, 2
08260  73 01                jae loc_8263
08262  c3                   ret
loc_8263:
08263  83 fb 18             cmp bx, 0x18
08266  76 01                jbe loc_8269
08268  c3                   ret
loc_8269:
08269  8b b7 99 ac          mov si, word ptr [bx - 0x5367]
0826d  e9 39 de             jmp affiche_chaine_sans_fond

; ======== marque_achats   (appelée depuis 817c)
; marque (SHOPSP 0x5C00, 32 × 32) les objets achetés : +0x0E bits 0-6 et +0x0F bits 0-3 (positions DS:AD03), +0x0E bit 7 (DS:AD19)
08270  b9 07 00             mov cx, 7
08273  8a 45 0e             mov al, byte ptr [di + 0xe]
08276  57                   push di
08277  bb 03 ad             mov bx, 0xad03
0827a  e8 34 00             call marque_bits
0827d  b9 04 00             mov cx, 4
08280  5f                   pop di
08281  57                   push di
08282  8a 45 0f             mov al, byte ptr [di + 0xf]
08285  e8 29 00             call marque_bits
08288  5f                   pop di
08289  f6 45 0e 80          test byte ptr [di + 0xe], 0x80
0828d  75 01                jne loc_8290
0828f  c3                   ret
loc_8290:
08290  a1 19 ad             mov ax, word ptr [0xad19]
08293  be 00 5c             mov si, 0x5c00
08296  8b f8                mov di, ax
08298  a1 25 5e             mov ax, word ptr [0x5e25]    ; seg_shopsp
0829b  a3 4e 37             mov word ptr [0x374e], ax    ; segment_source
0829e  50                   push ax
0829f  b8 63 14             mov ax, 0x1463
082a2  8e c0                mov es, ax
082a4  58                   pop ax
082a5  bd 20 00             mov bp, 0x20
082a8  b9 20 00             mov cx, 0x20
082ab  1e                   push ds
082ac  e8 a4 b8             call copie_image
082af  1f                   pop ds
082b0  c3                   ret

; ======== marque_bits   (appelée depuis 827a, 8285)
; pour chacun des CX bits de AL, dessine la marque à la position BX (2 octets par bit)
082b1  d0 e8                shr al, 1
082b3  73 25                jae loc_82da
082b5  50                   push ax
082b6  51                   push cx
082b7  53                   push bx
082b8  8b 07                mov ax, word ptr [bx]
082ba  be 00 5c             mov si, 0x5c00
082bd  8b f8                mov di, ax
082bf  a1 25 5e             mov ax, word ptr [0x5e25]    ; seg_shopsp
082c2  a3 4e 37             mov word ptr [0x374e], ax    ; segment_source
082c5  50                   push ax
082c6  b8 63 14             mov ax, 0x1463
082c9  8e c0                mov es, ax
082cb  58                   pop ax
082cc  bd 20 00             mov bp, 0x20
082cf  b9 20 00             mov cx, 0x20
082d2  1e                   push ds
082d3  e8 7d b8             call copie_image
082d6  1f                   pop ds
082d7  5b                   pop bx
082d8  59                   pop cx
082d9  58                   pop ax
loc_82da:
082da  83 c3 02             add bx, 2
082dd  e2 d2                loop marque_bits
082df  c3                   ret

; ======== dessine_elements   (appelée depuis 802b)
; fond, puis les cartes (image annexe, 48 × 64) des éléments encore libres, en (56, 40), (200, 40), (56, 120), (200, 120)
082e0  e8 40 e7             call fond_vers_tampon
082e3  80 3e 13 ac 00       cmp byte ptr [0xac13], 0    ; elements_sorts
082e8  75 1e                jne loc_8308
082ea  be 00 00             mov si, 0
082ed  bf 38 32             mov di, 0x3238
082f0  a1 27 5e             mov ax, word ptr [0x5e27]    ; seg_annexe
082f3  a3 4e 37             mov word ptr [0x374e], ax    ; segment_source
082f6  50                   push ax
082f7  b8 63 14             mov ax, 0x1463
082fa  8e c0                mov es, ax
082fc  58                   pop ax
082fd  bd 30 00             mov bp, 0x30
08300  b9 40 00             mov cx, 0x40
08303  1e                   push ds
08304  e8 4c b8             call copie_image
08307  1f                   pop ds
loc_8308:
08308  80 3e 14 ac 00       cmp byte ptr [0xac14], 0
0830d  75 1e                jne loc_832d
0830f  be 00 0c             mov si, 0xc00
08312  bf c8 32             mov di, 0x32c8
08315  a1 27 5e             mov ax, word ptr [0x5e27]    ; seg_annexe
08318  a3 4e 37             mov word ptr [0x374e], ax    ; segment_source
0831b  50                   push ax
0831c  b8 63 14             mov ax, 0x1463
0831f  8e c0                mov es, ax
08321  58                   pop ax
08322  bd 30 00             mov bp, 0x30
08325  b9 40 00             mov cx, 0x40
08328  1e                   push ds
08329  e8 27 b8             call copie_image
0832c  1f                   pop ds
loc_832d:
0832d  80 3e 15 ac 00       cmp byte ptr [0xac15], 0
08332  75 1e                jne loc_8352
08334  be 00 18             mov si, 0x1800
08337  bf 38 96             mov di, 0x9638
0833a  a1 27 5e             mov ax, word ptr [0x5e27]    ; seg_annexe
0833d  a3 4e 37             mov word ptr [0x374e], ax    ; segment_source
08340  50                   push ax
08341  b8 63 14             mov ax, 0x1463
08344  8e c0                mov es, ax
08346  58                   pop ax
08347  bd 30 00             mov bp, 0x30
0834a  b9 40 00             mov cx, 0x40
0834d  1e                   push ds
0834e  e8 02 b8             call copie_image
08351  1f                   pop ds
loc_8352:
08352  80 3e 16 ac 00       cmp byte ptr [0xac16], 0
08357  74 01                je loc_835a
08359  c3                   ret
loc_835a:
0835a  be 00 24             mov si, 0x2400
0835d  bf c8 96             mov di, 0x96c8
08360  a1 27 5e             mov ax, word ptr [0x5e27]    ; seg_annexe
08363  a3 4e 37             mov word ptr [0x374e], ax    ; segment_source
08366  50                   push ax
08367  b8 63 14             mov ax, 0x1463
0836a  8e c0                mov es, ax
0836c  58                   pop ax
0836d  bd 30 00             mov bp, 0x30
08370  b9 40 00             mov cx, 0x40
08373  1e                   push ds
08374  e8 dc b7             call copie_image
08377  1f                   pop ds
08378  c3                   ret

; ======== menu_liste   (appelée depuis 762a, 7667)
; menu de lignes de texte ; choix (numéro + 1) dans DS:AB7A
08379  89 36 bd ab          mov word ptr [0xabbd], si
0837d  8a 44 08             mov al, byte ptr [si + 8]
08380  a2 ba ab             mov byte ptr [0xabba], al
08383  c6 06 7a ab 00       mov byte ptr [0xab7a], 0    ; choix_menu
08388  8a 44 06             mov al, byte ptr [si + 6]
0838b  a2 bb ab             mov byte ptr [0xabbb], al
0838e  8a 44 09             mov al, byte ptr [si + 9]
08391  83 3e 90 31 04       cmp word ptr [0x3190], 4    ; mode_video
08396  75 02                jne loc_839a
08398  b0 0c                mov al, 0xc
loc_839a:
0839a  a2 bc ab             mov byte ptr [0xabbc], al
0839d  50                   push ax
0839e  b8 7c 09             mov ax, 0x97c
083a1  8e c0                mov es, ax
083a3  58                   pop ax
083a4  bf 88 ab             mov di, 0xab88
083a7  b9 19 00             mov cx, 0x19
083aa  b8 ff ff             mov ax, 0xffff
083ad  f3 ab                rep stosw word ptr es:[di], ax
083af  56                   push si
083b0  e8 54 c0             call efface_boite
083b3  5e                   pop si
083b4  8a 0e ba ab          mov cl, byte ptr [0xabba]
083b8  32 ed                xor ch, ch
083ba  8b ee                mov bp, si
083bc  83 c5 0a             add bp, 0xa
083bf  bf 88 ab             mov di, 0xab88
loc_83c2:
083c2  57                   push di
083c3  51                   push cx
083c4  89 2d                mov word ptr [di], bp
083c6  e8 b3 ad             call affiche_texte
083c9  45                   inc bp
083ca  59                   pop cx
083cb  5f                   pop di
083cc  83 c7 02             add di, 2
083cf  e2 f1                loop loc_83c2
083d1  e8 9b e1             call sauve_tampon
loc_83d4:
083d4  e8 3d da             call curseur_dessine
083d7  e8 0a dd             call affiche_tampon
083da  e8 fa d9             call curseur_efface
083dd  e8 72 b3             call lit_commandes
083e0  a1 95 39             mov ax, word ptr [0x3995]    ; curseur_y
083e3  d1 e8                shr ax, 1
083e5  d1 e8                shr ax, 1
083e7  d1 e8                shr ax, 1
083e9  bf 88 ab             mov di, 0xab88
083ec  8b 36 bd ab          mov si, word ptr [0xabbd]
083f0  8a 0e ba ab          mov cl, byte ptr [0xabba]
083f4  32 ed                xor ch, ch
loc_83f6:
083f6  8b 2d                mov bp, word ptr [di]
083f8  8a 26 bb ab          mov ah, byte ptr [0xabbb]
083fc  3e 3a 46 01          cmp al, byte ptr ds:[bp + 1]
08400  75 0e                jne loc_8410
08402  8a 26 bc ab          mov ah, byte ptr [0xabbc]
08406  a0 ba ab             mov al, byte ptr [0xabba]
08409  2a c1                sub al, cl
0840b  fe c0                inc al
0840d  a2 7a ab             mov byte ptr [0xab7a], al    ; choix_menu
loc_8410:
08410  88 26 50 37          mov byte ptr [0x3750], ah    ; couleur_texte
08414  9c                   pushf
08415  50                   push ax
08416  53                   push bx
08417  51                   push cx
08418  52                   push dx
08419  57                   push di
0841a  56                   push si
0841b  55                   push bp
0841c  06                   push es
0841d  1e                   push ds
0841e  e8 5b ad             call affiche_texte
08421  1f                   pop ds
08422  07                   pop es
08423  5d                   pop bp
08424  5e                   pop si
08425  5f                   pop di
08426  5a                   pop dx
08427  59                   pop cx
08428  5b                   pop bx
08429  58                   pop ax
0842a  9d                   popf
0842b  83 c7 02             add di, 2
0842e  e2 c6                loop loc_83f6
08430  f6 06 92 39 10       test byte ptr [0x3992], 0x10    ; commandes
08435  75 02                jne loc_8439
08437  eb 9b                jmp loc_83d4
loc_8439:
08439  80 3e 7a ab 00       cmp byte ptr [0xab7a], 0    ; choix_menu
0843e  74 94                je loc_83d4
08440  e9 05 a6             jmp son_clic

; ======== sauve_quest_sav   (appelée depuis 7a18)
; écrit QUEST.SAV
08443  50                   push ax
08444  a1 27 5e             mov ax, word ptr [0x5e27]    ; seg_annexe
08447  8e c0                mov es, ax
08449  58                   pop ax
0844a  b9 04 00             mov cx, 4
0844d  bb e5 45             mov bx, 0x45e5    ; "SIGMAR"
08450  33 ff                xor di, di
loc_8452:
08452  51                   push cx
08453  b9 08 00             mov cx, 8
loc_8456:
08456  53                   push bx
08457  8b 07                mov ax, word ptr [bx]
08459  26 89 05             mov word ptr es:[di], ax
0845c  83 c3 02             add bx, 2
0845f  83 c7 02             add di, 2
08462  8b 07                mov ax, word ptr [bx]
08464  26 89 05             mov word ptr es:[di], ax
08467  83 c3 02             add bx, 2
0846a  83 c7 02             add di, 2
0846d  8b 07                mov ax, word ptr [bx]
0846f  26 89 05             mov word ptr es:[di], ax
08472  83 c3 02             add bx, 2
08475  83 c7 02             add di, 2
08478  8b 07                mov ax, word ptr [bx]
0847a  26 89 05             mov word ptr es:[di], ax
0847d  83 c3 02             add bx, 2
08480  83 c7 02             add di, 2
08483  8b 07                mov ax, word ptr [bx]
08485  26 89 05             mov word ptr es:[di], ax
08488  83 c3 02             add bx, 2
0848b  83 c7 02             add di, 2
0848e  8b 07                mov ax, word ptr [bx]
08490  26 89 05             mov word ptr es:[di], ax
08493  83 c3 02             add bx, 2
08496  83 c7 02             add di, 2
08499  8b 07                mov ax, word ptr [bx]
0849b  26 89 05             mov word ptr es:[di], ax
0849e  83 c3 02             add bx, 2
084a1  83 c7 02             add di, 2
084a4  8b 07                mov ax, word ptr [bx]
084a6  26 89 05             mov word ptr es:[di], ax
084a9  83 c3 02             add bx, 2
084ac  83 c7 02             add di, 2
084af  26 c6 05 00          mov byte ptr es:[di], 0
084b3  47                   inc di
084b4  5b                   pop bx
084b5  e2 9f                loop loc_8456
084b7  83 c3 10             add bx, 0x10
084ba  59                   pop cx
084bb  e2 95                loop loc_8452
084bd  b8 00 00             mov ax, 0
084c0  b9 a0 01             mov cx, 0x1a0
084c3  f3 ab                rep stosw word ptr es:[di], ax
loc_84c5:
084c5  c7 06 07 39 b3 5f    mov word ptr [0x3907], 0x5fb3    ; fichier_nom, "quest.sav"
084cb  c7 06 03 39 00 00    mov word ptr [0x3903], 0    ; fichier_offset
084d1  c7 06 05 39 60 05    mov word ptr [0x3905], 0x560    ; fichier_taille
084d7  a1 27 5e             mov ax, word ptr [0x5e27]    ; seg_annexe
084da  a3 01 39             mov word ptr [0x3901], ax    ; fichier_segment
084dd  e8 c0 b4             call sauve_fichier
084e0  83 3e e9 37 00       cmp word ptr [0x37e9], 0    ; erreur_fichier
084e5  75 01                jne loc_84e8
084e7  c3                   ret
loc_84e8:
084e8  bb 18 00             mov bx, 0x18    ; message « IL Y A UNE ERREUR DE DISQUETTE »
084eb  e8 ff 03             call affiche_message
084ee  eb d5                jmp loc_84c5

; ======== lance_quete
; prépare la quête (QUESTn.BIN), affiche le briefing et attend « JE COMPRENDS MENTOR » ; règles propres aux quêtes 2, 6 et 8 du jeu
084f0  50                   push ax
084f1  b8 7c 09             mov ax, 0x97c
084f4  8e c0                mov es, ax
084f6  58                   pop ax
084f7  bf 0e 0a             mov di, 0xa0e    ; texte_briefing
084fa  b9 00 02             mov cx, 0x200
084fd  33 c0                xor ax, ax
084ff  f3 ab                rep stosw word ptr es:[di], ax
08501  bf 93 3f             mov di, 0x3f93
08504  b9 0e 01             mov cx, 0x10e
08507  32 c0                xor al, al
08509  f3 aa                rep stosb byte ptr es:[di], al
0850b  bf c6 53             mov di, 0x53c6
0850e  b9 2b 00             mov cx, 0x2b
loc_8511:
08511  c6 05 00             mov byte ptr [di], 0
08514  83 c7 04             add di, 4
08517  e2 f8                loop loc_8511
08519  be 63 46             mov si, 0x4663    ; fiches_personnages
0851c  bf 8f a9             mov di, 0xa98f    ; fiches_avant_quete
0851f  50                   push ax
08520  b8 7c 09             mov ax, 0x97c
08523  8e c0                mov es, ax
08525  58                   pop ax
08526  b9 34 00             mov cx, 0x34
08529  f3 a5                rep movsw word ptr es:[di], word ptr [si]
0852b  be a0 44             mov si, 0x44a0    ; heros_en_jeu
0852e  b9 02 00             mov cx, 2
08531  f3 a5                rep movsw word ptr es:[di], word ptr [si]
08533  a0 92 3f             mov al, byte ptr [0x3f92]    ; numero_quete
08536  02 c0                add al, al
08538  bb fc a3             mov bx, 0xa3fc    ; fichiers_quetes
0853b  e8 9f db             call mot_table_octets
0853e  c6 06 e9 3f 01       mov byte ptr [0x3fe9], 1    ; sans_sprites
08543  89 16 07 39          mov word ptr [0x3907], dx    ; fichier_nom
08547  c7 06 03 39 00 00    mov word ptr [0x3903], 0    ; fichier_offset
0854d  a1 31 5e             mov ax, word ptr [0x5e31]
08550  a3 01 39             mov word ptr [0x3901], ax    ; fichier_segment
loc_8553:
08553  c7 06 e9 37 00 00    mov word ptr [0x37e9], 0    ; erreur_fichier
08559  e8 95 b1             call clavier_retire
0855c  e8 69 b4             call fichier_ouvre
0855f  83 3e e9 37 00       cmp word ptr [0x37e9], 0    ; erreur_fichier
08564  75 03                jne loc_8569
08566  eb 0f                jmp loc_8577
; ---- 1 octets non atteints (8568-8568)
loc_8569:
08569  e8 4e b1             call clavier_installe
0856c  bb 50 02             mov bx, 0x250    ; message « INTRODUISEZ VOTRE / HEROQUEST DISQUETTE 2 »
0856f  e8 7b 03             call affiche_message
08572  e8 7c b1             call clavier_retire
08575  eb dc                jmp loc_8553
loc_8577:
08577  e8 82 b4             call fichier_lit
0857a  a3 05 39             mov word ptr [0x3905], ax    ; fichier_taille
0857d  83 3e e9 37 00       cmp word ptr [0x37e9], 0    ; erreur_fichier
08582  75 e5                jne loc_8569
08584  e8 33 b1             call clavier_installe
08587  e8 78 dc             call efface_tampon
0858a  1e                   push ds
0858b  50                   push ax
0858c  a1 31 5e             mov ax, word ptr [0x5e31]
0858f  8e d8                mov ds, ax
08591  58                   pop ax
08592  50                   push ax
08593  b8 7c 09             mov ax, 0x97c
08596  8e c0                mov es, ax
08598  58                   pop ax
08599  be 00 00             mov si, 0
0859c  bf 6f 54             mov di, 0x546f    ; grille_zones
0859f  b9 00 02             mov cx, 0x200
085a2  f3 a5                rep movsw word ptr es:[di], word ptr [si]
085a4  bf 00 00             mov di, 0
085a7  b9 58 02             mov cx, 0x258
085aa  f3 a5                rep movsw word ptr es:[di], word ptr [si]
085ac  1f                   pop ds
085ad  bf 6f 58             mov di, 0x586f    ; grille_occupants
085b0  b9 00 01             mov cx, 0x100
085b3  33 c0                xor ax, ax
085b5  f3 ab                rep stosw word ptr es:[di], ax
085b7  b9 01 04             mov cx, 0x401
085ba  bb a0 44             mov bx, 0x44a0    ; heros_en_jeu
085bd  bf 00 00             mov di, 0
loc_85c0:
085c0  50                   push ax
085c1  9c                   pushf
085c2  e8 ba d7             call fiche_personnage
085c5  8b 07                mov ax, word ptr [bx]
085c7  88 04                mov byte ptr [si], al
085c9  0a c0                or al, al
085cb  75 0b                jne loc_85d8
085cd  a0 c5 3f             mov al, byte ptr [0x3fc5]    ; heros_absents
085d0  0a c1                or al, cl
085d2  a2 c5 3f             mov byte ptr [0x3fc5], al    ; heros_absents
085d5  a2 c6 3f             mov byte ptr [0x3fc6], al    ; etat_quete
loc_85d8:
085d8  d0 e1                shl cl, 1
085da  c6 07 00             mov byte ptr [bx], 0
085dd  43                   inc bx
085de  8b 05                mov ax, word ptr [di]
085e0  89 44 01             mov word ptr [si + 1], ax
085e3  8a 45 02             mov al, byte ptr [di + 2]
085e6  83 c7 03             add di, 3
085e9  88 44 08             mov byte ptr [si + 8], al
085ec  c6 44 10 00          mov byte ptr [si + 0x10], 0
085f0  c6 44 16 00          mov byte ptr [si + 0x16], 0
085f4  c6 44 17 00          mov byte ptr [si + 0x17], 0
085f8  c6 44 18 00          mov byte ptr [si + 0x18], 0
085fc  8a 44 0f             mov al, byte ptr [si + 0xf]
085ff  24 8f                and al, 0x8f
08601  88 44 0f             mov byte ptr [si + 0xf], al
08604  9d                   popf
08605  58                   pop ax
08606  fe c0                inc al
08608  fe cd                dec ch
0860a  75 b4                jne loc_85c0
0860c  50                   push ax
0860d  a1 31 5e             mov ax, word ptr [0x5e31]
08610  8e d8                mov ds, ax
08612  58                   pop ax
08613  50                   push ax
08614  b8 7c 09             mov ax, 0x97c
08617  8e c0                mov es, ax
08619  58                   pop ax
0861a  be 0c 04             mov si, 0x40c
0861d  bf 70 4b             mov di, 0x4b70    ; evenement_par_zone
08620  b9 2b 00             mov cx, 0x2b
08623  f3 a5                rep movsw word ptr es:[di], word ptr [si]
08625  bf 62 04             mov di, 0x462
08628  57                   push di
08629  8b 35                mov si, word ptr [di]
0862b  03 f7                add si, di
0862d  8b 4d 02             mov cx, word ptr [di + 2]
08630  bf 0e 0a             mov di, 0xa0e    ; texte_briefing
08633  f3 a4                rep movsb byte ptr es:[di], byte ptr [si]
08635  50                   push ax
08636  b8 7c 09             mov ax, 0x97c
08639  8e d8                mov ds, ax
0863b  58                   pop ax
0863c  9c                   pushf
0863d  50                   push ax
0863e  53                   push bx
0863f  51                   push cx
08640  52                   push dx
08641  57                   push di
08642  56                   push si
08643  55                   push bp
08644  06                   push es
08645  1e                   push ds
08646  e8 da e3             call fond_vers_tampon
08649  c6 06 59 37 01       mov byte ptr [0x3759], 1    ; texte_transparent
0864e  c6 06 50 37 11       mov byte ptr [0x3750], 0x11    ; couleur_texte
08653  bd 0e 0a             mov bp, 0xa0e    ; texte_briefing
08656  e8 23 ab             call affiche_texte
08659  e8 88 da             call affiche_tampon
0865c  e8 10 df             call sauve_tampon
0865f  1f                   pop ds
08660  07                   pop es
08661  5d                   pop bp
08662  5e                   pop si
08663  5f                   pop di
08664  5a                   pop dx
08665  59                   pop cx
08666  5b                   pop bx
08667  58                   pop ax
08668  9d                   popf
08669  50                   push ax
0866a  b8 7c 09             mov ax, 0x97c
0866d  8e c0                mov es, ax
0866f  58                   pop ax
08670  bf 4a 4d             mov di, 0x4d4a    ; monstres
08673  b9 40 01             mov cx, 0x140
08676  49                   dec cx
08677  32 c0                xor al, al
08679  f3 aa                rep stosb byte ptr es:[di], al
0867b  50                   push ax
0867c  a1 31 5e             mov ax, word ptr [0x5e31]
0867f  8e d8                mov ds, ax
08681  58                   pop ax
08682  5e                   pop si
08683  8b 54 04             mov dx, word ptr [si + 4]
08686  8b 4c 06             mov cx, word ptr [si + 6]
08689  56                   push si
0868a  03 f2                add si, dx
0868c  bf 4a 4d             mov di, 0x4d4a    ; monstres
0868f  f3 a4                rep movsb byte ptr es:[di], byte ptr [si]
08691  5e                   pop si
08692  8a 4c 0a             mov cl, byte ptr [si + 0xa]
08695  32 ed                xor ch, ch
08697  03 74 08             add si, word ptr [si + 8]
loc_869a:
0869a  8b 14                mov dx, word ptr [si]
0869c  1e                   push ds
0869d  50                   push ax
0869e  b8 7c 09             mov ax, 0x97c
086a1  8e d8                mov ds, ax
086a3  58                   pop ax
086a4  e8 d7 d9             call index_case
086a7  1f                   pop ds
086a8  8b da                mov bx, dx
086aa  81 c3 6f 58          add bx, 0x586f    ; grille_occupants
086ae  8a 44 02             mov al, byte ptr [si + 2]
086b1  26 88 07             mov byte ptr es:[bx], al
086b4  83 c6 03             add si, 3
086b7  e2 e1                loop loc_869a
086b9  50                   push ax
086ba  b8 7c 09             mov ax, 0x97c
086bd  8e d8                mov ds, ax
086bf  58                   pop ax
086c0  be cb 46             mov si, 0x46cb
086c3  c6 04 00             mov byte ptr [si], 0
086c6  80 3e 92 3f 01       cmp byte ptr [0x3f92], 1    ; numero_quete
086cb  75 11                jne loc_86de
086cd  c7 44 01 06 00       mov word ptr [si + 1], 6
086d2  c6 44 02 01          mov byte ptr [si + 2], 1
086d6  c6 44 06 02          mov byte ptr [si + 6], 2
086da  c6 44 08 50          mov byte ptr [si + 8], 0x50
loc_86de:
086de  c6 06 7a ab 00       mov byte ptr [0xab7a], 0    ; choix_menu
086e3  e8 16 dd             call curseur_memorise
086e6  e8 3e 01             call attente_briefing
086e9  e8 28 d7             call curseur_dessine
086ec  e8 f5 d9             call affiche_tampon
086ef  e8 e5 d6             call curseur_efface
086f2  e8 5d b0             call lit_commandes
086f5  80 3e 7a ab 00       cmp byte ptr [0xab7a], 0    ; choix_menu
086fa  74 e2                je loc_86de
086fc  e8 03 db             call efface_tampon
086ff  e8 e2 d9             call affiche_tampon
08702  be 4a 4d             mov si, 0x4d4a    ; monstres
08705  b5 20                mov ch, 0x20
loc_8707:
08707  80 3c 00             cmp byte ptr [si], 0
0870a  74 24                je loc_8730
0870c  80 7c 08 15          cmp byte ptr [si + 8], 0x15
08710  74 1e                je loc_8730
08712  8b 54 01             mov dx, word ptr [si + 1]
08715  e8 66 d9             call index_case
08718  81 c3 6f 54          add bx, 0x546f    ; grille_zones
0871c  8a 07                mov al, byte ptr [bx]
0871e  24 3f                and al, 0x3f
08720  88 44 03             mov byte ptr [si + 3], al
08723  89 5c 04             mov word ptr [si + 4], bx
08726  b0 20                mov al, 0x20
08728  2a c5                sub al, ch
0872a  fe c0                inc al
0872c  88 87 00 04          mov byte ptr [bx + 0x400], al
loc_8730:
08730  83 c6 0a             add si, 0xa
08733  fe cd                dec ch
08735  75 d0                jne loc_8707
08737  80 3e 92 3f 05       cmp byte ptr [0x3f92], 5    ; numero_quete
0873c  75 77                jne loc_87b5
0873e  50                   push ax
0873f  b8 7c 09             mov ax, 0x97c
08742  8e c0                mov es, ax
08744  58                   pop ax
08745  be 6e 46             mov si, 0x466e
08748  bf 9f 4a             mov di, 0x4a9f    ; equipement_confisque
0874b  b9 05 00             mov cx, 5
0874e  f3 a4                rep movsb byte ptr es:[di], byte ptr [si]
08750  c7 06 6e 46 00 00    mov word ptr [0x466e], 0
08756  c7 06 70 46 00 00    mov word ptr [0x4670], 0
0875c  c6 06 72 46 00       mov byte ptr [0x4672], 0
08761  be 88 46             mov si, 0x4688
08764  bf a4 4a             mov di, 0x4aa4
08767  b9 05 00             mov cx, 5
0876a  f3 a4                rep movsb byte ptr es:[di], byte ptr [si]
0876c  c7 06 88 46 00 00    mov word ptr [0x4688], 0
08772  c7 06 8a 46 00 00    mov word ptr [0x468a], 0
08778  c6 06 8c 46 00       mov byte ptr [0x468c], 0
0877d  be a2 46             mov si, 0x46a2
08780  bf a9 4a             mov di, 0x4aa9
08783  b9 05 00             mov cx, 5
08786  f3 a4                rep movsb byte ptr es:[di], byte ptr [si]
08788  c7 06 a2 46 00 00    mov word ptr [0x46a2], 0
0878e  c7 06 a4 46 00 00    mov word ptr [0x46a4], 0
08794  c6 06 a6 46 00       mov byte ptr [0x46a6], 0
08799  be bc 46             mov si, 0x46bc
0879c  bf ae 4a             mov di, 0x4aae
0879f  b9 05 00             mov cx, 5
087a2  f3 a4                rep movsb byte ptr es:[di], byte ptr [si]
087a4  c7 06 bc 46 00 00    mov word ptr [0x46bc], 0
087aa  c7 06 be 46 00 00    mov word ptr [0x46be], 0
087b0  c6 06 c0 46 00       mov byte ptr [0x46c0], 0
loc_87b5:
087b5  80 3e 92 3f 07       cmp byte ptr [0x3f92], 7    ; numero_quete
087ba  75 0e                jne loc_87ca
087bc  be 97 46             mov si, 0x4697
087bf  80 64 0c 38          and byte ptr [si + 0xc], 0x38
087c3  be b1 46             mov si, 0x46b1
087c6  80 64 0c 38          and byte ptr [si + 0xc], 0x38
loc_87ca:
087ca  bb 3b 46             mov bx, 0x463b    ; pioche_tresors
087cd  32 c0                xor al, al
loc_87cf:
087cf  88 07                mov byte ptr [bx], al
087d1  43                   inc bx
087d2  fe c0                inc al
087d4  3c 19                cmp al, 0x19
087d6  75 f7                jne loc_87cf
087d8  c6 07 ff             mov byte ptr [bx], 0xff
087db  b3 ff                mov bl, 0xff
melange_tresors:    ; mélange les 25 cartes trésor
087dd  e8 33 ae             call hasard
087e0  8a c8                mov cl, al
087e2  bb fc 06             mov bx, 0x6fc
087e5  b5 00                mov ch, 0
087e7  03 d9                add bx, cx
087e9  03 db                add bx, bx
loc_87eb:
087eb  be 3b 46             mov si, 0x463b    ; pioche_tresors
087ee  51                   push cx
087ef  b9 18 00             mov cx, 0x18
loc_87f2:
087f2  43                   inc bx
087f3  f6 07 f7             test byte ptr [bx], 0xf7
087f6  74 0a                je loc_8802
087f8  8a 04                mov al, byte ptr [si]
087fa  8a 54 01             mov dl, byte ptr [si + 1]
087fd  88 44 01             mov byte ptr [si + 1], al
08800  88 14                mov byte ptr [si], dl
loc_8802:
08802  46                   inc si
08803  e2 ed                loop loc_87f2
08805  59                   pop cx
08806  e2 e3                loop loc_87eb
08808  c7 06 55 46 54 46    mov word ptr [0x4655], 0x4654    ; carte_tresor
0880e  80 3e 92 3f 07       cmp byte ptr [0x3f92], 7    ; numero_quete
08813  75 05                jne loc_881a
08815  c6 06 c0 3f ff       mov byte ptr [0x3fc0], 0xff    ; evenement_b
loc_881a:
0881a  80 3e 92 3f 06       cmp byte ptr [0x3f92], 6    ; numero_quete
0881f  75 05                jne loc_8826
08821  c6 06 c0 3f ff       mov byte ptr [0x3fc0], 0xff    ; evenement_b
loc_8826:
08826  c3                   ret

; ======== attente_briefing   (appelée depuis 86e6)
; « JE COMPRENDS MENTOR » en surbrillance sous le curseur ; clic ou bouton droit
08827  bb 04 00             mov bx, 4
0882a  8b b7 c1 5f          mov si, word ptr [bx + 0x5fc1]    ; textes
0882e  81 c6 c1 5f          add si, 0x5fc1    ; textes
08832  c6 06 50 37 11       mov byte ptr [0x3750], 0x11    ; couleur_texte
08837  8b ee                mov bp, si
08839  e8 63 d5             call texte_sous_curseur
0883c  75 1c                jne loc_885a
0883e  c6 06 50 37 26       mov byte ptr [0x3750], 0x26    ; couleur_texte
08843  83 3e 90 31 04       cmp word ptr [0x3190], 4    ; mode_video
08848  75 05                jne loc_884f
0884a  c6 06 50 37 0c       mov byte ptr [0x3750], 0xc    ; couleur_texte
loc_884f:
0884f  f6 06 92 39 10       test byte ptr [0x3992], 0x10    ; commandes
08854  74 04                je loc_885a
08856  fe 06 7a ab          inc byte ptr [0xab7a]    ; choix_menu
loc_885a:
0885a  f6 06 92 39 20       test byte ptr [0x3992], 0x20    ; commandes
0885f  74 04                je loc_8865
08861  fe 06 7a ab          inc byte ptr [0xab7a]    ; choix_menu
loc_8865:
08865  e9 14 a9             jmp affiche_texte
; ---- 8 octets non atteints (8868-886f)

; ======== dessine_boutons   (appelée depuis 8a1d, 8b16)
; dessine les boutons du message (DS:AD37, 6 octets chacun, jusqu'à FFFFh) ; leur rang dans DS:37E9
08870  ff 36 37 ad          push word ptr [0xad37]    ; boutons_message
08874  c7 06 e9 37 00 00    mov word ptr [0x37e9], 0    ; erreur_fichier
0887a  8b 1e 37 ad          mov bx, word ptr [0xad37]    ; boutons_message
loc_887e:
0887e  e8 17 00             call dessine_bouton
08881  83 06 37 ad 06       add word ptr [0xad37], 6    ; boutons_message
08886  8b 1e 37 ad          mov bx, word ptr [0xad37]    ; boutons_message
0888a  ff 06 e9 37          inc word ptr [0x37e9]    ; erreur_fichier
0888e  83 3f ff             cmp word ptr [bx], -1
08891  75 eb                jne loc_887e
08893  8f 06 37 ad          pop word ptr [0xad37]    ; boutons_message
08897  c3                   ret

; ======== dessine_bouton   (appelée depuis 887e)
; bouton BX : place son libellé (colonne, ligne) ; en attente (DS:AD3B), couleur 26h (0Ch Tandy) sous le curseur, un clic donne son rang dans choix_menu, le bouton droit FEh
08898  c6 06 50 37 11       mov byte ptr [0x3750], 0x11    ; couleur_texte
0889d  8b 6f 02             mov bp, word ptr [bx + 2]
088a0  81 c5 c1 5f          add bp, 0x5fc1    ; textes
088a4  8a 07                mov al, byte ptr [bx]
088a6  3e 88 46 02          mov byte ptr ds:[bp + 2], al
088aa  8a 47 01             mov al, byte ptr [bx + 1]
088ad  3e 88 46 01          mov byte ptr ds:[bp + 1], al
088b1  80 3e 3b ad 00       cmp byte ptr [0xad3b], 0    ; message_attend_choix
088b6  74 32                je loc_88ea
088b8  f6 06 92 39 20       test byte ptr [0x3992], 0x20    ; commandes
088bd  74 08                je loc_88c7
088bf  c6 06 7a ab fe       mov byte ptr [0xab7a], 0xfe    ; choix_menu
088c4  eb 24                jmp loc_88ea
; ---- 1 octets non atteints (88c6-88c6)
loc_88c7:
088c7  e8 d5 d4             call texte_sous_curseur
088ca  75 1e                jne loc_88ea
088cc  c6 06 50 37 26       mov byte ptr [0x3750], 0x26    ; couleur_texte
088d1  83 3e 90 31 04       cmp word ptr [0x3190], 4    ; mode_video
088d6  75 05                jne loc_88dd
088d8  c6 06 50 37 0c       mov byte ptr [0x3750], 0xc    ; couleur_texte
loc_88dd:
088dd  f6 06 92 39 10       test byte ptr [0x3992], 0x10    ; commandes
088e2  74 06                je loc_88ea
088e4  a1 e9 37             mov ax, word ptr [0x37e9]    ; erreur_fichier
088e7  a2 7a ab             mov byte ptr [0xab7a], al    ; choix_menu
loc_88ea:
088ea  e9 8f a8             jmp affiche_texte

; ======== affiche_message   (appelée depuis 01ba, 0203, 03f2, 049f, 04de, 074c, 092b, 09cf)
; boîte de message BX (offset dans la table des textes chargée en DS:5FC1)
088ed  ff 36 50 37          push word ptr [0x3750]    ; couleur_texte
088f1  ff 36 35 46          push word ptr [0x4635]    ; zones_actives
088f5  c6 06 59 37 01       mov byte ptr [0x3759], 1    ; texte_transparent
088fa  c6 06 7a ab ff       mov byte ptr [0xab7a], 0xff    ; choix_menu
088ff  c6 06 3b ad 00       mov byte ptr [0xad3b], 0    ; message_attend_choix
08904  90                   nop
08905  8b b7 c1 5f          mov si, word ptr [bx + 0x5fc1]    ; textes
08909  81 c6 c1 5f          add si, 0x5fc1    ; textes
0890d  89 36 37 ad          mov word ptr [0xad37], si    ; boutons_message
08911  83 06 37 ad 04       add word ptr [0xad37], 4    ; boutons_message
08916  33 db                xor bx, bx
loc_8918:
08918  83 38 ff             cmp word ptr [bx + si], -1
0891b  74 05                je loc_8922
0891d  83 c3 02             add bx, 2
08920  eb f6                jmp loc_8918
loc_8922:
08922  03 de                add bx, si
08924  89 1e 39 ad          mov word ptr [0xad39], bx    ; texte_message
08928  83 06 39 ad 02       add word ptr [0xad39], 2    ; texte_message
0892d  8a 07                mov al, byte ptr [bx]
0892f  8a 04                mov al, byte ptr [si]
08931  a2 30 ad             mov byte ptr [0xad30], al
08934  8a 44 03             mov al, byte ptr [si + 3]
08937  2c 02                sub al, 2
08939  a2 35 ad             mov byte ptr [0xad35], al
0893c  a2 2c ad             mov byte ptr [0xad2c], al
0893f  fe 06 2c ad          inc byte ptr [0xad2c]
08943  d0 e0                shl al, 1
08945  d0 e0                shl al, 1
08947  8a 64 01             mov ah, byte ptr [si + 1]
0894a  d0 e4                shl ah, 1
0894c  d0 e4                shl ah, 1
0894e  d0 e4                shl ah, 1
08950  88 26 2f ad          mov byte ptr [0xad2f], ah
08954  02 e0                add ah, al
08956  88 26 22 ad          mov byte ptr [0xad22], ah    ; rouleau_bas
0895a  80 ec 10             sub ah, 0x10
0895d  88 26 20 ad          mov byte ptr [0xad20], ah    ; rouleau_haut
08961  8a 44 03             mov al, byte ptr [si + 3]
08964  32 e4                xor ah, ah
08966  04 04                add al, 4
08968  d1 e0                shl ax, 1
0896a  d1 e0                shl ax, 1
0896c  d1 e0                shl ax, 1
0896e  a3 2a ad             mov word ptr [0xad2a], ax
08971  8a 44 02             mov al, byte ptr [si + 2]
08974  a8 01                test al, 1
08976  74 02                je loc_897a
08978  fe c0                inc al
loc_897a:
0897a  a2 36 ad             mov byte ptr [0xad36], al
0897d  80 06 36 ad 02       add byte ptr [0xad36], 2
08982  32 e4                xor ah, ah
08984  04 07                add al, 7
08986  d1 e0                shl ax, 1
08988  d1 e0                shl ax, 1
0898a  d1 e0                shl ax, 1
0898c  a3 28 ad             mov word ptr [0xad28], ax
0898f  8a 1c                mov bl, byte ptr [si]
08991  80 eb 03             sub bl, 3
08994  32 ff                xor bh, bh
08996  d1 e3                shl bx, 1
08998  d1 e3                shl bx, 1
0899a  d1 e3                shl bx, 1
0899c  89 1e 24 ad          mov word ptr [0xad24], bx
089a0  8a 44 01             mov al, byte ptr [si + 1]
089a3  2c 02                sub al, 2
089a5  32 e4                xor ah, ah
089a7  d1 e0                shl ax, 1
089a9  d1 e0                shl ax, 1
089ab  d1 e0                shl ax, 1
089ad  a3 26 ad             mov word ptr [0xad26], ax
089b0  e8 c1 a7             call ligne_ecran
089b3  89 1e 2d ad          mov word ptr [0xad2d], bx
089b7  80 3e e9 3f 01       cmp byte ptr [0x3fe9], 1    ; sans_sprites
089bc  74 06                je loc_89c4
089be  e8 f7 cd             call dessine_sprites
089c1  e8 54 db             call affiche_valeurs_fiche
loc_89c4:
089c4  e8 a8 db             call sauve_tampon
089c7  bb 10 00             mov bx, 0x10
089ca  a1 28 ad             mov ax, word ptr [0xad28]
089cd  f7 e3                mul bx
089cf  a3 33 ad             mov word ptr [0xad33], ax
089d2  a0 2f ad             mov al, byte ptr [0xad2f]
089d5  32 e4                xor ah, ah
089d7  8a 1e 30 ad          mov bl, byte ptr [0xad30]
089db  d0 e3                shl bl, 1
089dd  d0 e3                shl bl, 1
089df  d0 e3                shl bl, 1
089e1  32 ff                xor bh, bh
089e3  e8 8e a7             call ligne_ecran
089e6  89 1e 31 ad          mov word ptr [0xad31], bx
089ea  e8 83 00             call dessine_boite_message
089ed  8a 0e 2c ad          mov cl, byte ptr [0xad2c]
089f1  32 ed                xor ch, ch
loc_89f3:
089f3  51                   push cx
089f4  e8 79 00             call dessine_boite_message
089f7  e8 83 01             call restaure_boite
089fa  83 2e 20 ad 04       sub word ptr [0xad20], 4    ; rouleau_haut
089ff  83 06 22 ad 04       add word ptr [0xad22], 4    ; rouleau_bas
08a04  59                   pop cx
08a05  e2 ec                loop loc_89f3
08a07  83 2e 22 ad 04       sub word ptr [0xad22], 4    ; rouleau_bas
08a0c  83 06 20 ad 04       add word ptr [0xad20], 4    ; rouleau_haut
08a11  c6 06 3b ad 01       mov byte ptr [0xad3b], 1    ; message_attend_choix
08a16  90                   nop
loc_8a17:
08a17  e8 e2 d9             call curseur_memorise
08a1a  e8 53 00             call dessine_boite_message
08a1d  e8 50 fe             call dessine_boutons
08a20  e8 f1 d3             call curseur_dessine
08a23  e8 be d6             call affiche_tampon
08a26  e8 ae d3             call curseur_efface
08a29  e8 26 ad             call lit_commandes
08a2c  80 3e 7a ab ff       cmp byte ptr [0xab7a], 0xff    ; choix_menu
08a31  75 02                jne loc_8a35
08a33  eb e2                jmp loc_8a17
loc_8a35:
08a35  e8 10 a0             call son_clic
08a38  e8 19 af             call attend_relache_boutons
08a3b  c6 06 3b ad 00       mov byte ptr [0xad3b], 0    ; message_attend_choix
08a40  90                   nop
08a41  8a 0e 2c ad          mov cl, byte ptr [0xad2c]
08a45  32 ed                xor ch, ch
loc_8a47:
08a47  51                   push cx
08a48  e8 25 00             call dessine_boite_message
08a4b  e8 2f 01             call restaure_boite
08a4e  83 06 20 ad 04       add word ptr [0xad20], 4    ; rouleau_haut
08a53  83 2e 22 ad 04       sub word ptr [0xad22], 4    ; rouleau_bas
08a58  59                   pop cx
08a59  e2 ec                loop loc_8a47
08a5b  8f 06 35 46          pop word ptr [0x4635]    ; zones_actives
08a5f  8f 06 50 37          pop word ptr [0x3750]    ; couleur_texte
08a63  c6 06 59 37 00       mov byte ptr [0x3759], 0    ; texte_transparent
08a68  c6 06 97 3f 01       mov byte ptr [0x3f97], 1    ; vue_a_refaire
08a6d  e9 74 d6             jmp affiche_tampon

; ======== dessine_boite_message   (appelée depuis 89ea, 89f4, 8a1a, 8a48)
; fond de la boîte (ODDS&SOD 0x58A0, 0x58E0, 0x5920, 8 × 8), texte DS:AD39, boutons, barres DS:AD20 et DS:AD22 ; hors des barres, le fond sauvé est restauré ; affiche le tampon sauf en attente (DS:AD3B)
08a70  a1 31 ad             mov ax, word ptr [0xad31]
08a73  a3 e9 37             mov word ptr [0x37e9], ax    ; erreur_fichier
08a76  83 2e e9 37 08       sub word ptr [0x37e9], 8    ; erreur_fichier
08a7b  8a 0e 35 ad          mov cl, byte ptr [0xad35]
08a7f  32 ed                xor ch, ch
loc_8a81:
08a81  51                   push cx
08a82  a1 e9 37             mov ax, word ptr [0x37e9]    ; erreur_fichier
08a85  a3 eb 37             mov word ptr [0x37eb], ax    ; position_tuile_carte
08a88  be a0 58             mov si, 0x58a0
08a8b  8b f8                mov di, ax
08a8d  a1 2d 5e             mov ax, word ptr [0x5e2d]    ; seg_odds
08a90  a3 4e 37             mov word ptr [0x374e], ax    ; segment_source
08a93  50                   push ax
08a94  b8 63 14             mov ax, 0x1463
08a97  8e c0                mov es, ax
08a99  58                   pop ax
08a9a  bd 08 00             mov bp, 8
08a9d  b9 08 00             mov cx, 8
08aa0  1e                   push ds
08aa1  e8 af b0             call copie_image
08aa4  1f                   pop ds
08aa5  83 06 eb 37 08       add word ptr [0x37eb], 8    ; position_tuile_carte
08aaa  8a 0e 36 ad          mov cl, byte ptr [0xad36]
08aae  32 ed                xor ch, ch
08ab0  83 e9 02             sub cx, 2
loc_8ab3:
08ab3  51                   push cx
08ab4  be e0 58             mov si, 0x58e0
08ab7  8b 3e eb 37          mov di, word ptr [0x37eb]    ; position_tuile_carte
08abb  a1 2d 5e             mov ax, word ptr [0x5e2d]    ; seg_odds
08abe  a3 4e 37             mov word ptr [0x374e], ax    ; segment_source
08ac1  50                   push ax
08ac2  b8 63 14             mov ax, 0x1463
08ac5  8e c0                mov es, ax
08ac7  58                   pop ax
08ac8  bd 08 00             mov bp, 8
08acb  b9 08 00             mov cx, 8
08ace  1e                   push ds
08acf  e8 81 b0             call copie_image
08ad2  1f                   pop ds
08ad3  83 06 eb 37 08       add word ptr [0x37eb], 8    ; position_tuile_carte
08ad8  59                   pop cx
08ad9  49                   dec cx
08ada  74 02                je loc_8ade
08adc  eb d5                jmp loc_8ab3
loc_8ade:
08ade  be 20 59             mov si, 0x5920
08ae1  8b 3e eb 37          mov di, word ptr [0x37eb]    ; position_tuile_carte
08ae5  a1 2d 5e             mov ax, word ptr [0x5e2d]    ; seg_odds
08ae8  a3 4e 37             mov word ptr [0x374e], ax    ; segment_source
08aeb  50                   push ax
08aec  b8 63 14             mov ax, 0x1463
08aef  8e c0                mov es, ax
08af1  58                   pop ax
08af2  bd 08 00             mov bp, 8
08af5  b9 08 00             mov cx, 8
08af8  1e                   push ds
08af9  e8 57 b0             call copie_image
08afc  1f                   pop ds
08afd  81 06 e9 37 00 0a    add word ptr [0x37e9], 0xa00    ; erreur_fichier, "AND TRY AGAIN"
08b03  59                   pop cx
08b04  49                   dec cx
08b05  74 03                je loc_8b0a
08b07  e9 77 ff             jmp loc_8a81
loc_8b0a:
08b0a  c6 06 50 37 11       mov byte ptr [0x3750], 0x11    ; couleur_texte
08b0f  8b 2e 39 ad          mov bp, word ptr [0xad39]    ; texte_message
08b13  e8 66 a6             call affiche_texte
08b16  e8 57 fd             call dessine_boutons
08b19  a1 20 ad             mov ax, word ptr [0xad20]    ; rouleau_haut
08b1c  e8 76 00             call dessine_rouleau
08b1f  a1 22 ad             mov ax, word ptr [0xad22]    ; rouleau_bas
08b22  e8 70 00             call dessine_rouleau
08b25  8a 0e 2f ad          mov cl, byte ptr [0xad2f]
08b29  32 ed                xor ch, ch
08b2b  51                   push cx
08b2c  8b 1e 20 ad          mov bx, word ptr [0xad20]    ; rouleau_haut
08b30  39 0e 20 ad          cmp word ptr [0xad20], cx    ; rouleau_haut
08b34  76 15                jbe loc_8b4b
08b36  2b 0e 20 ad          sub cx, word ptr [0xad20]    ; rouleau_haut
08b3a  8b 3e 31 ad          mov di, word ptr [0xad31]
08b3e  83 ef 10             sub di, 0x10
08b41  8b 36 33 ad          mov si, word ptr [0xad33]
08b45  f7 d1                not cx
08b47  41                   inc cx
08b48  e8 3a 00             call restaure_lignes
loc_8b4b:
08b4b  59                   pop cx
08b4c  8a 16 35 ad          mov dl, byte ptr [0xad35]
08b50  32 f6                xor dh, dh
08b52  d1 e2                shl dx, 1
08b54  d1 e2                shl dx, 1
08b56  d1 e2                shl dx, 1
08b58  03 ca                add cx, dx
08b5a  a1 22 ad             mov ax, word ptr [0xad22]    ; rouleau_bas
08b5d  05 10 00             add ax, 0x10
08b60  3b c8                cmp cx, ax
08b62  76 0e                jbe loc_8b72
08b64  2b c8                sub cx, ax
08b66  8b 1e 24 ad          mov bx, word ptr [0xad24]
08b6a  e8 07 a6             call ligne_ecran
08b6d  8b fb                mov di, bx
08b6f  e8 13 00             call restaure_lignes
loc_8b72:
08b72  80 3e 3b ad 00       cmp byte ptr [0xad3b], 0    ; message_attend_choix
08b77  74 01                je loc_8b7a
08b79  c3                   ret
loc_8b7a:
08b7a  e9 67 d5             jmp affiche_tampon

; ======== restaure_boite   (appelée depuis 89f7, 8a4b)
; restaure_lignes sur toute la boîte : DS:AD2A lignes depuis DS:AD2D
08b7d  8b 0e 2a ad          mov cx, word ptr [0xad2a]
08b81  8b 3e 2d ad          mov di, word ptr [0xad2d]

; ======== restaure_lignes   (appelée depuis 8b48, 8b6f)
; recopie CX lignes en DI, sur la largeur de la boîte (DS:AD28), depuis la copie DS:5E35 vers le tampon (0x6273)
08b85  8b 2e 28 ad          mov bp, word ptr [0xad28]
08b89  d1 ed                shr bp, 1
08b8b  50                   push ax
08b8c  a1 35 5e             mov ax, word ptr [0x5e35]    ; seg_furn
08b8f  8e d8                mov ds, ax
08b91  58                   pop ax
08b92  e9 de d6             jmp loc_6273

; ======== dessine_rouleau   (appelée depuis 8b1c, 8b22)
; barre du parchemin à la ligne AX (rouleau_haut ou rouleau_bas) : bouts ODDS&SOD 0x55A0 et 0x57A0, milieu 0x56A0 (16 × 16)
08b95  8b 1e 24 ad          mov bx, word ptr [0xad24]
08b99  e8 d8 a5             call ligne_ecran
08b9c  89 1e f3 37          mov word ptr [0x37f3], bx    ; saisie_chiffres_lus
08ba0  be a0 55             mov si, 0x55a0
08ba3  8b 3e f3 37          mov di, word ptr [0x37f3]    ; saisie_chiffres_lus
08ba7  a1 2d 5e             mov ax, word ptr [0x5e2d]    ; seg_odds
08baa  a3 4e 37             mov word ptr [0x374e], ax    ; segment_source
08bad  50                   push ax
08bae  b8 63 14             mov ax, 0x1463
08bb1  8e c0                mov es, ax
08bb3  58                   pop ax
08bb4  bd 10 00             mov bp, 0x10
08bb7  b9 10 00             mov cx, 0x10
08bba  1e                   push ds
08bbb  e8 95 af             call copie_image
08bbe  1f                   pop ds
08bbf  8a 0e 36 ad          mov cl, byte ptr [0xad36]
08bc3  32 ed                xor ch, ch
08bc5  d1 e9                shr cx, 1
loc_8bc7:
08bc7  51                   push cx
08bc8  83 06 f3 37 10       add word ptr [0x37f3], 0x10    ; saisie_chiffres_lus
08bcd  be a0 56             mov si, 0x56a0
08bd0  8b 3e f3 37          mov di, word ptr [0x37f3]    ; saisie_chiffres_lus
08bd4  a1 2d 5e             mov ax, word ptr [0x5e2d]    ; seg_odds
08bd7  a3 4e 37             mov word ptr [0x374e], ax    ; segment_source
08bda  50                   push ax
08bdb  b8 63 14             mov ax, 0x1463
08bde  8e c0                mov es, ax
08be0  58                   pop ax
08be1  bd 10 00             mov bp, 0x10
08be4  b9 10 00             mov cx, 0x10
08be7  1e                   push ds
08be8  e8 68 af             call copie_image
08beb  1f                   pop ds
08bec  59                   pop cx
08bed  e2 d8                loop loc_8bc7
08bef  83 06 f3 37 10       add word ptr [0x37f3], 0x10    ; saisie_chiffres_lus
08bf4  be a0 57             mov si, 0x57a0
08bf7  8b 3e f3 37          mov di, word ptr [0x37f3]    ; saisie_chiffres_lus
08bfb  a1 2d 5e             mov ax, word ptr [0x5e2d]    ; seg_odds
08bfe  a3 4e 37             mov word ptr [0x374e], ax    ; segment_source
08c01  50                   push ax
08c02  b8 63 14             mov ax, 0x1463
08c05  8e c0                mov es, ax
08c07  58                   pop ax
08c08  bd 10 00             mov bp, 0x10
08c0b  b9 10 00             mov cx, 0x10
08c0e  1e                   push ds
08c0f  e8 41 af             call copie_image
08c12  1f                   pop ds
08c13  c3                   ret
; ---- 12 octets non atteints (8c14-8c1f)

; ======== inventaire_sorts   (appelée depuis 2cbb)
; inventaire pendant la quête (WIZBACK, INVENT, SPELLIT) : armes et armures, potions, artefacts, sorts ; rien pour le personnage 4
08c20  a0 a7 3f             mov al, byte ptr [0x3fa7]    ; personnage_courant
08c23  3c 04                cmp al, 4
08c25  75 01                jne loc_8c28
08c27  c3                   ret
loc_8c28:
08c28  83 3e 90 31 08       cmp word ptr [0x3190], 8    ; mode_video
08c2d  74 03                je loc_8c32
08c2f  e9 ab 00             jmp loc_8cdd
loc_8c32:
08c32  c7 06 07 39 a8 5e    mov word ptr [0x3907], 0x5ea8    ; fichier_nom, "wizback.vga"
08c38  c7 06 03 39 00 00    mov word ptr [0x3903], 0    ; fichier_offset
08c3e  a1 23 5e             mov ax, word ptr [0x5e23]    ; seg_ecran
08c41  a3 01 39             mov word ptr [0x3901], ax    ; fichier_segment
loc_8c44:
08c44  c7 06 e9 37 00 00    mov word ptr [0x37e9], 0    ; erreur_fichier
08c4a  e8 a4 aa             call clavier_retire
08c4d  e8 78 ad             call fichier_ouvre
08c50  83 3e e9 37 00       cmp word ptr [0x37e9], 0    ; erreur_fichier
08c55  75 03                jne loc_8c5a
08c57  eb 0f                jmp loc_8c68
; ---- 1 octets non atteints (8c59-8c59)
loc_8c5a:
08c5a  e8 5d aa             call clavier_installe
08c5d  bb 52 02             mov bx, 0x252    ; message « INTRODUISEZ VOTRE / HEROQUEST DISQUETTE 3 »
08c60  e8 8a fc             call affiche_message
08c63  e8 8b aa             call clavier_retire
08c66  eb dc                jmp loc_8c44
loc_8c68:
08c68  e8 91 ad             call fichier_lit
08c6b  83 3e e9 37 00       cmp word ptr [0x37e9], 0    ; erreur_fichier
08c70  75 e8                jne loc_8c5a
08c72  a3 05 39             mov word ptr [0x3905], ax    ; fichier_taille
08c75  e8 42 aa             call clavier_installe
08c78  c7 06 07 39 b4 5e    mov word ptr [0x3907], 0x5eb4    ; fichier_nom, "invent.vga"
08c7e  c7 06 03 39 00 00    mov word ptr [0x3903], 0    ; fichier_offset
08c84  b8 63 14             mov ax, 0x1463
08c87  a3 01 39             mov word ptr [0x3901], ax    ; fichier_segment
loc_8c8a:
08c8a  c7 06 e9 37 00 00    mov word ptr [0x37e9], 0    ; erreur_fichier
08c90  e8 5e aa             call clavier_retire
08c93  e8 32 ad             call fichier_ouvre
08c96  83 3e e9 37 00       cmp word ptr [0x37e9], 0    ; erreur_fichier
08c9b  75 03                jne loc_8ca0
08c9d  eb 0f                jmp loc_8cae
; ---- 1 octets non atteints (8c9f-8c9f)
loc_8ca0:
08ca0  e8 17 aa             call clavier_installe
08ca3  bb 52 02             mov bx, 0x252    ; message « INTRODUISEZ VOTRE / HEROQUEST DISQUETTE 3 »
08ca6  e8 44 fc             call affiche_message
08ca9  e8 45 aa             call clavier_retire
08cac  eb dc                jmp loc_8c8a
loc_8cae:
08cae  e8 4b ad             call fichier_lit
08cb1  83 3e e9 37 00       cmp word ptr [0x37e9], 0    ; erreur_fichier
08cb6  75 e8                jne loc_8ca0
08cb8  a3 05 39             mov word ptr [0x3905], ax    ; fichier_taille
08cbb  e8 fc a9             call clavier_installe
08cbe  a1 27 5e             mov ax, word ptr [0x5e27]    ; seg_annexe
08cc1  8e c0                mov es, ax
08cc3  33 f6                xor si, si
08cc5  bf 00 00             mov di, 0
08cc8  b8 63 14             mov ax, 0x1463
08ccb  8e d8                mov ds, ax
08ccd  b9 ff ff             mov cx, 0xffff
08cd0  e8 fe b8             call lz_decompresse
08cd3  50                   push ax
08cd4  b8 7c 09             mov ax, 0x97c
08cd7  8e d8                mov ds, ax
08cd9  58                   pop ax
08cda  e9 a8 00             jmp loc_8d85
loc_8cdd:
08cdd  c7 06 07 39 44 5f    mov word ptr [0x3907], 0x5f44    ; fichier_nom, "wizback.ega"
08ce3  c7 06 03 39 00 00    mov word ptr [0x3903], 0    ; fichier_offset
08ce9  a1 23 5e             mov ax, word ptr [0x5e23]    ; seg_ecran
08cec  a3 01 39             mov word ptr [0x3901], ax    ; fichier_segment
loc_8cef:
08cef  c7 06 e9 37 00 00    mov word ptr [0x37e9], 0    ; erreur_fichier
08cf5  e8 f9 a9             call clavier_retire
08cf8  e8 cd ac             call fichier_ouvre
08cfb  83 3e e9 37 00       cmp word ptr [0x37e9], 0    ; erreur_fichier
08d00  75 03                jne loc_8d05
08d02  eb 0f                jmp loc_8d13
; ---- 1 octets non atteints (8d04-8d04)
loc_8d05:
08d05  e8 b2 a9             call clavier_installe
08d08  bb 52 02             mov bx, 0x252    ; message « INTRODUISEZ VOTRE / HEROQUEST DISQUETTE 3 »
08d0b  e8 df fb             call affiche_message
08d0e  e8 e0 a9             call clavier_retire
08d11  eb dc                jmp loc_8cef
loc_8d13:
08d13  e8 e6 ac             call fichier_lit
08d16  83 3e e9 37 00       cmp word ptr [0x37e9], 0    ; erreur_fichier
08d1b  75 e8                jne loc_8d05
08d1d  a3 05 39             mov word ptr [0x3905], ax    ; fichier_taille
08d20  e8 97 a9             call clavier_installe
08d23  c7 06 07 39 50 5f    mov word ptr [0x3907], 0x5f50    ; fichier_nom, "invent.ega"
08d29  c7 06 03 39 00 00    mov word ptr [0x3903], 0    ; fichier_offset
08d2f  b8 63 14             mov ax, 0x1463
08d32  a3 01 39             mov word ptr [0x3901], ax    ; fichier_segment
loc_8d35:
08d35  c7 06 e9 37 00 00    mov word ptr [0x37e9], 0    ; erreur_fichier
08d3b  e8 b3 a9             call clavier_retire
08d3e  e8 87 ac             call fichier_ouvre
08d41  83 3e e9 37 00       cmp word ptr [0x37e9], 0    ; erreur_fichier
08d46  75 03                jne loc_8d4b
08d48  eb 0f                jmp loc_8d59
; ---- 1 octets non atteints (8d4a-8d4a)
loc_8d4b:
08d4b  e8 6c a9             call clavier_installe
08d4e  bb 52 02             mov bx, 0x252    ; message « INTRODUISEZ VOTRE / HEROQUEST DISQUETTE 3 »
08d51  e8 99 fb             call affiche_message
08d54  e8 9a a9             call clavier_retire
08d57  eb dc                jmp loc_8d35
loc_8d59:
08d59  e8 a0 ac             call fichier_lit
08d5c  83 3e e9 37 00       cmp word ptr [0x37e9], 0    ; erreur_fichier
08d61  75 e8                jne loc_8d4b
08d63  a3 05 39             mov word ptr [0x3905], ax    ; fichier_taille
08d66  e8 51 a9             call clavier_installe
08d69  a1 27 5e             mov ax, word ptr [0x5e27]    ; seg_annexe
08d6c  8e c0                mov es, ax
08d6e  33 f6                xor si, si
08d70  bf 00 00             mov di, 0
08d73  b8 63 14             mov ax, 0x1463
08d76  8e d8                mov ds, ax
08d78  b9 ff ff             mov cx, 0xffff
08d7b  e8 53 b8             call lz_decompresse
08d7e  50                   push ax
08d7f  b8 7c 09             mov ax, 0x97c
08d82  8e d8                mov ds, ax
08d84  58                   pop ax
loc_8d85:
08d85  80 3e 67 ad 05       cmp byte ptr [0xad67], 5    ; mode_inventaire
08d8a  74 03                je loc_8d8f
08d8c  e9 ce 00             jmp loc_8e5d
loc_8d8f:
08d8f  83 3e 90 31 08       cmp word ptr [0x3190], 8    ; mode_video
08d94  75 65                jne loc_8dfb
08d96  c7 06 07 39 bf 5e    mov word ptr [0x3907], 0x5ebf    ; fichier_nom, "spellit.vga"
08d9c  c7 06 03 39 00 00    mov word ptr [0x3903], 0    ; fichier_offset
08da2  b8 63 14             mov ax, 0x1463
08da5  a3 01 39             mov word ptr [0x3901], ax    ; fichier_segment
loc_8da8:
08da8  c7 06 e9 37 00 00    mov word ptr [0x37e9], 0    ; erreur_fichier
08dae  e8 40 a9             call clavier_retire
08db1  e8 14 ac             call fichier_ouvre
08db4  83 3e e9 37 00       cmp word ptr [0x37e9], 0    ; erreur_fichier
08db9  75 03                jne loc_8dbe
08dbb  eb 0f                jmp loc_8dcc
; ---- 1 octets non atteints (8dbd-8dbd)
loc_8dbe:
08dbe  e8 f9 a8             call clavier_installe
08dc1  bb 52 02             mov bx, 0x252    ; message « INTRODUISEZ VOTRE / HEROQUEST DISQUETTE 3 »
08dc4  e8 26 fb             call affiche_message
08dc7  e8 27 a9             call clavier_retire
08dca  eb dc                jmp loc_8da8
loc_8dcc:
08dcc  e8 2d ac             call fichier_lit
08dcf  83 3e e9 37 00       cmp word ptr [0x37e9], 0    ; erreur_fichier
08dd4  75 e8                jne loc_8dbe
08dd6  a3 05 39             mov word ptr [0x3905], ax    ; fichier_taille
08dd9  e8 de a8             call clavier_installe
08ddc  a1 27 5e             mov ax, word ptr [0x5e27]    ; seg_annexe
08ddf  8e c0                mov es, ax
08de1  33 f6                xor si, si
08de3  bf 80 46             mov di, 0x4680
08de6  b8 63 14             mov ax, 0x1463
08de9  8e d8                mov ds, ax
08deb  b9 ff ff             mov cx, 0xffff
08dee  e8 e0 b7             call lz_decompresse
08df1  50                   push ax
08df2  b8 7c 09             mov ax, 0x97c
08df5  8e d8                mov ds, ax
08df7  58                   pop ax
08df8  eb 63                jmp loc_8e5d
; ---- 1 octets non atteints (8dfa-8dfa)
loc_8dfb:
08dfb  c7 06 07 39 5b 5f    mov word ptr [0x3907], 0x5f5b    ; fichier_nom, "spellit.ega"
08e01  c7 06 03 39 00 00    mov word ptr [0x3903], 0    ; fichier_offset
08e07  b8 63 14             mov ax, 0x1463
08e0a  a3 01 39             mov word ptr [0x3901], ax    ; fichier_segment
loc_8e0d:
08e0d  c7 06 e9 37 00 00    mov word ptr [0x37e9], 0    ; erreur_fichier
08e13  e8 db a8             call clavier_retire
08e16  e8 af ab             call fichier_ouvre
08e19  83 3e e9 37 00       cmp word ptr [0x37e9], 0    ; erreur_fichier
08e1e  75 03                jne loc_8e23
08e20  eb 0f                jmp loc_8e31
; ---- 1 octets non atteints (8e22-8e22)
loc_8e23:
08e23  e8 94 a8             call clavier_installe
08e26  bb 52 02             mov bx, 0x252    ; message « INTRODUISEZ VOTRE / HEROQUEST DISQUETTE 3 »
08e29  e8 c1 fa             call affiche_message
08e2c  e8 c2 a8             call clavier_retire
08e2f  eb dc                jmp loc_8e0d
loc_8e31:
08e31  e8 c8 ab             call fichier_lit
08e34  83 3e e9 37 00       cmp word ptr [0x37e9], 0    ; erreur_fichier
08e39  75 e8                jne loc_8e23
08e3b  a3 05 39             mov word ptr [0x3905], ax    ; fichier_taille
08e3e  e8 79 a8             call clavier_installe
08e41  a1 27 5e             mov ax, word ptr [0x5e27]    ; seg_annexe
08e44  8e c0                mov es, ax
08e46  33 f6                xor si, si
08e48  bf 40 23             mov di, 0x2340
08e4b  b8 63 14             mov ax, 0x1463
08e4e  8e d8                mov ds, ax
08e50  b9 ff ff             mov cx, 0xffff
08e53  e8 7b b7             call lz_decompresse
08e56  50                   push ax
08e57  b8 7c 09             mov ax, 0x97c
08e5a  8e d8                mov ds, ax
08e5c  58                   pop ax
loc_8e5d:
08e5d  c6 06 59 37 00       mov byte ptr [0x3759], 0    ; texte_transparent
08e62  c6 06 e9 3f 01       mov byte ptr [0x3fe9], 1    ; sans_sprites
loc_8e67:
08e67  e8 b9 db             call fond_vers_tampon
08e6a  80 3e 67 ad 05       cmp byte ptr [0xad67], 5    ; mode_inventaire
08e6f  75 03                jne loc_8e74
08e71  e9 36 03             jmp loc_91aa
loc_8e74:
08e74  be 80 17             mov si, 0x1780
08e77  bf 88 50             mov di, 0x5088
08e7a  a1 27 5e             mov ax, word ptr [0x5e27]    ; seg_annexe
08e7d  a3 4e 37             mov word ptr [0x374e], ax    ; segment_source
08e80  50                   push ax
08e81  b8 63 14             mov ax, 0x1463
08e84  8e c0                mov es, ax
08e86  58                   pop ax
08e87  bd 40 00             mov bp, 0x40
08e8a  b9 5e 00             mov cx, 0x5e
08e8d  1e                   push ds
08e8e  e8 c2 ac             call copie_image
08e91  1f                   pop ds
08e92  be 00 2f             mov si, 0x2f00
08e95  bf d0 50             mov di, 0x50d0    ; sols_speciaux
08e98  a1 27 5e             mov ax, word ptr [0x5e27]    ; seg_annexe
08e9b  a3 4e 37             mov word ptr [0x374e], ax    ; segment_source
08e9e  50                   push ax
08e9f  b8 63 14             mov ax, 0x1463
08ea2  8e c0                mov es, ax
08ea4  58                   pop ax
08ea5  bd 40 00             mov bp, 0x40
08ea8  b9 5e 00             mov cx, 0x5e
08eab  1e                   push ds
08eac  e8 a4 ac             call copie_image
08eaf  1f                   pop ds
08eb0  be 00 00             mov si, 0
08eb3  bf 40 50             mov di, 0x5040
08eb6  a1 27 5e             mov ax, word ptr [0x5e27]    ; seg_annexe
08eb9  a3 4e 37             mov word ptr [0x374e], ax    ; segment_source
08ebc  50                   push ax
08ebd  b8 63 14             mov ax, 0x1463
08ec0  8e c0                mov es, ax
08ec2  58                   pop ax
08ec3  bd 40 00             mov bp, 0x40
08ec6  b9 5e 00             mov cx, 0x5e
08ec9  1e                   push ds
08eca  e8 86 ac             call copie_image
08ecd  1f                   pop ds
08ece  e8 9e d6             call sauve_tampon
loc_8ed1:
08ed1  e8 28 d5             call curseur_memorise
08ed4  be 9a ad             mov si, 0xad9a    ; zones_sortie_inventaire
08ed7  e8 40 c0             call zone_sous_curseur
08eda  83 fb 02             cmp bx, 2
08edd  75 20                jne loc_8eff
08edf  be 20 40             mov si, 0x4020
08ee2  bf 28 e2             mov di, 0xe228
08ee5  a1 2d 5e             mov ax, word ptr [0x5e2d]    ; seg_odds
08ee8  a3 4e 37             mov word ptr [0x374e], ax    ; segment_source
08eeb  50                   push ax
08eec  b8 63 14             mov ax, 0x1463
08eef  8e c0                mov es, ax
08ef1  58                   pop ax
08ef2  bd 10 00             mov bp, 0x10
08ef5  b9 10 00             mov cx, 0x10
08ef8  1e                   push ds
08ef9  e8 57 ac             call copie_image
08efc  1f                   pop ds
08efd  eb 1e                jmp loc_8f1d
loc_8eff:
08eff  be 20 34             mov si, 0x3420
08f02  bf 28 e2             mov di, 0xe228
08f05  a1 2d 5e             mov ax, word ptr [0x5e2d]    ; seg_odds
08f08  a3 4e 37             mov word ptr [0x374e], ax    ; segment_source
08f0b  50                   push ax
08f0c  b8 63 14             mov ax, 0x1463
08f0f  8e c0                mov es, ax
08f11  58                   pop ax
08f12  bd 10 00             mov bp, 0x10
08f15  b9 10 00             mov cx, 0x10
08f18  1e                   push ds
08f19  e8 37 ac             call copie_image
08f1c  1f                   pop ds
loc_8f1d:
08f1d  e8 f4 ce             call curseur_dessine
08f20  e8 c1 d1             call affiche_tampon
08f23  e8 b1 ce             call curseur_efface
08f26  e8 29 a8             call lit_commandes
08f29  f6 06 92 39 20       test byte ptr [0x3992], 0x20    ; commandes
08f2e  75 2d                jne loc_8f5d
08f30  be 82 ad             mov si, 0xad82    ; zones_categories
08f33  e8 cf bf             call zone_cliquee
08f36  83 fb 08             cmp bx, 8
08f39  77 96                ja loc_8ed1
08f3b  83 fb 02             cmp bx, 2
08f3e  72 91                jb loc_8ed1
08f40  53                   push bx
08f41  e8 10 aa             call attend_relache_boutons
08f44  5b                   pop bx
08f45  83 fb 02             cmp bx, 2
08f48  75 03                jne loc_8f4d
08f4a  e9 95 01             jmp loc_90e2
loc_8f4d:
08f4d  83 fb 04             cmp bx, 4
08f50  75 03                jne loc_8f55
08f52  e9 71 06             jmp loc_95c6
loc_8f55:
08f55  83 fb 06             cmp bx, 6
08f58  75 03                jne loc_8f5d
08f5a  e9 71 06             jmp loc_95ce
loc_8f5d:
08f5d  c6 06 67 ad 00       mov byte ptr [0xad67], 0    ; mode_inventaire
08f62  c6 06 59 37 01       mov byte ptr [0x3759], 1    ; texte_transparent
08f67  e8 98 d2             call efface_tampon
08f6a  e8 77 d1             call affiche_tampon
08f6d  c6 06 e9 42 0b       mov byte ptr [0x42e9], 0xb
08f72  ff 36 e9 3f          push word ptr [0x3fe9]    ; sans_sprites
08f76  c6 06 e9 3f 01       mov byte ptr [0x3fe9], 1    ; sans_sprites
08f7b  83 3e 90 31 08       cmp word ptr [0x3190], 8    ; mode_video
08f80  74 03                je loc_8f85
08f82  e9 ab 00             jmp loc_9030
loc_8f85:
08f85  c7 06 07 39 37 5e    mov word ptr [0x3907], 0x5e37    ; fichier_nom, "book.vga"
08f8b  c7 06 03 39 00 00    mov word ptr [0x3903], 0    ; fichier_offset
08f91  a1 23 5e             mov ax, word ptr [0x5e23]    ; seg_ecran
08f94  a3 01 39             mov word ptr [0x3901], ax    ; fichier_segment
loc_8f97:
08f97  c7 06 e9 37 00 00    mov word ptr [0x37e9], 0    ; erreur_fichier
08f9d  e8 51 a7             call clavier_retire
08fa0  e8 25 aa             call fichier_ouvre
08fa3  83 3e e9 37 00       cmp word ptr [0x37e9], 0    ; erreur_fichier
08fa8  75 03                jne loc_8fad
08faa  eb 0f                jmp loc_8fbb
; ---- 1 octets non atteints (8fac-8fac)
loc_8fad:
08fad  e8 0a a7             call clavier_installe
08fb0  bb 50 02             mov bx, 0x250    ; message « INTRODUISEZ VOTRE / HEROQUEST DISQUETTE 2 »
08fb3  e8 37 f9             call affiche_message
08fb6  e8 38 a7             call clavier_retire
08fb9  eb dc                jmp loc_8f97
loc_8fbb:
08fbb  e8 3e aa             call fichier_lit
08fbe  a3 05 39             mov word ptr [0x3905], ax    ; fichier_taille
08fc1  83 3e e9 37 00       cmp word ptr [0x37e9], 0    ; erreur_fichier
08fc6  75 e5                jne loc_8fad
08fc8  e8 ef a6             call clavier_installe
08fcb  c7 06 07 39 66 5e    mov word ptr [0x3907], 0x5e66    ; fichier_nom, "maps.vga"
08fd1  c7 06 03 39 00 00    mov word ptr [0x3903], 0    ; fichier_offset
08fd7  b8 63 14             mov ax, 0x1463
08fda  a3 01 39             mov word ptr [0x3901], ax    ; fichier_segment
loc_8fdd:
08fdd  c7 06 e9 37 00 00    mov word ptr [0x37e9], 0    ; erreur_fichier
08fe3  e8 0b a7             call clavier_retire
08fe6  e8 df a9             call fichier_ouvre
08fe9  83 3e e9 37 00       cmp word ptr [0x37e9], 0    ; erreur_fichier
08fee  75 03                jne loc_8ff3
08ff0  eb 0f                jmp loc_9001
; ---- 1 octets non atteints (8ff2-8ff2)
loc_8ff3:
08ff3  e8 c4 a6             call clavier_installe
08ff6  bb 52 02             mov bx, 0x252    ; message « INTRODUISEZ VOTRE / HEROQUEST DISQUETTE 3 »
08ff9  e8 f1 f8             call affiche_message
08ffc  e8 f2 a6             call clavier_retire
08fff  eb dc                jmp loc_8fdd
loc_9001:
09001  e8 f8 a9             call fichier_lit
09004  83 3e e9 37 00       cmp word ptr [0x37e9], 0    ; erreur_fichier
09009  75 e8                jne loc_8ff3
0900b  a3 05 39             mov word ptr [0x3905], ax    ; fichier_taille
0900e  e8 a9 a6             call clavier_installe
09011  a1 27 5e             mov ax, word ptr [0x5e27]    ; seg_annexe
09014  8e c0                mov es, ax
09016  33 f6                xor si, si
09018  bf 00 00             mov di, 0
0901b  b8 63 14             mov ax, 0x1463
0901e  8e d8                mov ds, ax
09020  b9 ff ff             mov cx, 0xffff
09023  e8 ab b5             call lz_decompresse
09026  50                   push ax
09027  b8 7c 09             mov ax, 0x97c
0902a  8e d8                mov ds, ax
0902c  58                   pop ax
0902d  e9 a8 00             jmp loc_90d8
loc_9030:
09030  c7 06 07 39 d3 5e    mov word ptr [0x3907], 0x5ed3    ; fichier_nom, "book.ega"
09036  c7 06 03 39 00 00    mov word ptr [0x3903], 0    ; fichier_offset
0903c  a1 23 5e             mov ax, word ptr [0x5e23]    ; seg_ecran
0903f  a3 01 39             mov word ptr [0x3901], ax    ; fichier_segment
loc_9042:
09042  c7 06 e9 37 00 00    mov word ptr [0x37e9], 0    ; erreur_fichier
09048  e8 a6 a6             call clavier_retire
0904b  e8 7a a9             call fichier_ouvre
0904e  83 3e e9 37 00       cmp word ptr [0x37e9], 0    ; erreur_fichier
09053  75 03                jne loc_9058
09055  eb 0f                jmp loc_9066
; ---- 1 octets non atteints (9057-9057)
loc_9058:
09058  e8 5f a6             call clavier_installe
0905b  bb 50 02             mov bx, 0x250    ; message « INTRODUISEZ VOTRE / HEROQUEST DISQUETTE 2 »
0905e  e8 8c f8             call affiche_message
09061  e8 8d a6             call clavier_retire
09064  eb dc                jmp loc_9042
loc_9066:
09066  e8 93 a9             call fichier_lit
09069  a3 05 39             mov word ptr [0x3905], ax    ; fichier_taille
0906c  83 3e e9 37 00       cmp word ptr [0x37e9], 0    ; erreur_fichier
09071  75 e5                jne loc_9058
09073  e8 44 a6             call clavier_installe
09076  c7 06 07 39 02 5f    mov word ptr [0x3907], 0x5f02    ; fichier_nom, "maps.ega"
0907c  c7 06 03 39 00 00    mov word ptr [0x3903], 0    ; fichier_offset
09082  b8 63 14             mov ax, 0x1463
09085  a3 01 39             mov word ptr [0x3901], ax    ; fichier_segment
loc_9088:
09088  c7 06 e9 37 00 00    mov word ptr [0x37e9], 0    ; erreur_fichier
0908e  e8 60 a6             call clavier_retire
09091  e8 34 a9             call fichier_ouvre
09094  83 3e e9 37 00       cmp word ptr [0x37e9], 0    ; erreur_fichier
09099  75 03                jne loc_909e
0909b  eb 0f                jmp loc_90ac
; ---- 1 octets non atteints (909d-909d)
loc_909e:
0909e  e8 19 a6             call clavier_installe
090a1  bb 52 02             mov bx, 0x252    ; message « INTRODUISEZ VOTRE / HEROQUEST DISQUETTE 3 »
090a4  e8 46 f8             call affiche_message
090a7  e8 47 a6             call clavier_retire
090aa  eb dc                jmp loc_9088
loc_90ac:
090ac  e8 4d a9             call fichier_lit
090af  83 3e e9 37 00       cmp word ptr [0x37e9], 0    ; erreur_fichier
090b4  75 e8                jne loc_909e
090b6  a3 05 39             mov word ptr [0x3905], ax    ; fichier_taille
090b9  e8 fe a5             call clavier_installe
090bc  a1 27 5e             mov ax, word ptr [0x5e27]    ; seg_annexe
090bf  8e c0                mov es, ax
090c1  33 f6                xor si, si
090c3  bf 00 00             mov di, 0
090c6  b8 63 14             mov ax, 0x1463
090c9  8e d8                mov ds, ax
090cb  b9 ff ff             mov cx, 0xffff
090ce  e8 00 b5             call lz_decompresse
090d1  50                   push ax
090d2  b8 7c 09             mov ax, 0x97c
090d5  8e d8                mov ds, ax
090d7  58                   pop ax
loc_90d8:
090d8  e8 48 d9             call fond_vers_tampon
090db  8f 06 e9 3f          pop word ptr [0x3fe9]    ; sans_sprites
090df  e9 c8 81             jmp fin_action
loc_90e2:
090e2  c6 06 67 ad 01       mov byte ptr [0xad67], 1    ; mode_inventaire
loc_90e7:
090e7  50                   push ax
090e8  b8 7c 09             mov ax, 0x97c
090eb  8e c0                mov es, ax
090ed  58                   pop ax
090ee  b8 ff ff             mov ax, 0xffff
090f1  bf 6a ad             mov di, 0xad6a    ; liste_objets
090f4  b9 0c 00             mov cx, 0xc
090f7  f3 ab                rep stosw word ptr es:[di], ax
090f9  8b 3e 37 46          mov di, word ptr [0x4637]    ; fiche_heros_courant
090fd  be 6a ad             mov si, 0xad6a    ; liste_objets
09100  80 3e 67 ad 01       cmp byte ptr [0xad67], 1    ; mode_inventaire
09105  75 4f                jne loc_9156
09107  b9 08 00             mov cx, 8
0910a  8a 45 0e             mov al, byte ptr [di + 0xe]
0910d  f6 45 0f 80          test byte ptr [di + 0xf], 0x80
09111  74 02                je loc_9115
09113  0c 80                or al, 0x80
loc_9115:
09115  bb 18 00             mov bx, 0x18
09118  e8 37 05             call liste_bits
0911b  89 36 68 ad          mov word ptr [0xad68], si
0911f  be 18 00             mov si, 0x18
09122  b9 08 00             mov cx, 8
09125  8a 45 11             mov al, byte ptr [di + 0x11]
09128  0a c0                or al, al
0912a  74 03                je loc_912f
0912c  e8 32 05             call marque_en_service
loc_912f:
0912f  8b 36 68 ad          mov si, word ptr [0xad68]
09133  b9 04 00             mov cx, 4
09136  8b 3e 37 46          mov di, word ptr [0x4637]    ; fiche_heros_courant
0913a  8a 45 0f             mov al, byte ptr [di + 0xf]
0913d  bb 28 00             mov bx, 0x28
09140  e8 0f 05             call liste_bits
09143  be 28 00             mov si, 0x28
09146  b9 04 00             mov cx, 4
09149  8a 45 13             mov al, byte ptr [di + 0x13]
0914c  0a c0                or al, al
0914e  74 03                je loc_9153
09150  e8 0e 05             call marque_en_service
loc_9153:
09153  e9 86 00             jmp loc_91dc
loc_9156:
09156  80 3e 67 ad 02       cmp byte ptr [0xad67], 2    ; mode_inventaire
0915b  75 23                jne loc_9180
0915d  b9 07 00             mov cx, 7
09160  8a 45 10             mov al, byte ptr [di + 0x10]
09163  bb 00 00             mov bx, 0
09166  e8 e9 04             call liste_bits
09169  89 36 68 ad          mov word ptr [0xad68], si
0916d  be 00 00             mov si, 0
09170  b9 07 00             mov cx, 7
09173  8a 45 17             mov al, byte ptr [di + 0x17]
09176  0a c0                or al, al
09178  74 03                je loc_917d
0917a  e8 e4 04             call marque_en_service
loc_917d:
0917d  eb 5d                jmp loc_91dc
; ---- 1 octets non atteints (917f-917f)
loc_9180:
09180  80 3e 67 ad 03       cmp byte ptr [0xad67], 3    ; mode_inventaire
09185  75 55                jne loc_91dc
09187  b9 05 00             mov cx, 5
0918a  8a 45 0d             mov al, byte ptr [di + 0xd]
0918d  bb 0e 00             mov bx, 0xe
09190  e8 bf 04             call liste_bits
09193  89 36 68 ad          mov word ptr [0xad68], si
09197  be 0e 00             mov si, 0xe
0919a  b9 05 00             mov cx, 5
0919d  8a 45 12             mov al, byte ptr [di + 0x12]
091a0  0a c0                or al, al
091a2  74 03                je loc_91a7
091a4  e8 ba 04             call marque_en_service
loc_91a7:
091a7  eb 33                jmp loc_91dc
; ---- 1 octets non atteints (91a9-91a9)
loc_91aa:
091aa  50                   push ax
091ab  b8 7c 09             mov ax, 0x97c
091ae  8e c0                mov es, ax
091b0  58                   pop ax
091b1  b8 ff ff             mov ax, 0xffff
091b4  bf 6a ad             mov di, 0xad6a    ; liste_objets
091b7  b9 0c 00             mov cx, 0xc
091ba  f3 ab                rep stosw word ptr es:[di], ax
091bc  b9 06 00             mov cx, 6
091bf  8b 3e 37 46          mov di, word ptr [0x4637]    ; fiche_heros_courant
091c3  8a 45 0b             mov al, byte ptr [di + 0xb]
091c6  be 6a ad             mov si, 0xad6a    ; liste_objets
091c9  bb 30 00             mov bx, 0x30
091cc  e8 83 04             call liste_bits
091cf  b9 06 00             mov cx, 6
091d2  8b 3e 37 46          mov di, word ptr [0x4637]    ; fiche_heros_courant
091d6  8a 45 0c             mov al, byte ptr [di + 0xc]
091d9  e8 76 04             call liste_bits
loc_91dc:
091dc  e8 48 03             call dessine_objets
091df  e8 8d d3             call sauve_tampon
loc_91e2:
091e2  e8 17 d2             call curseur_memorise
091e5  be 04 ae             mov si, 0xae04
091e8  e8 2f bd             call zone_sous_curseur
091eb  83 fb 02             cmp bx, 2
091ee  75 20                jne loc_9210
091f0  be 20 40             mov si, 0x4020
091f3  bf 28 e2             mov di, 0xe228
091f6  a1 2d 5e             mov ax, word ptr [0x5e2d]    ; seg_odds
091f9  a3 4e 37             mov word ptr [0x374e], ax    ; segment_source
091fc  50                   push ax
091fd  b8 63 14             mov ax, 0x1463
09200  8e c0                mov es, ax
09202  58                   pop ax
09203  bd 10 00             mov bp, 0x10
09206  b9 10 00             mov cx, 0x10
09209  1e                   push ds
0920a  e8 46 a9             call copie_image
0920d  1f                   pop ds
0920e  eb 1e                jmp loc_922e
loc_9210:
09210  be 20 34             mov si, 0x3420
09213  bf 28 e2             mov di, 0xe228
09216  a1 2d 5e             mov ax, word ptr [0x5e2d]    ; seg_odds
09219  a3 4e 37             mov word ptr [0x374e], ax    ; segment_source
0921c  50                   push ax
0921d  b8 63 14             mov ax, 0x1463
09220  8e c0                mov es, ax
09222  58                   pop ax
09223  bd 10 00             mov bp, 0x10
09226  b9 10 00             mov cx, 0x10
09229  1e                   push ds
0922a  e8 26 a9             call copie_image
0922d  1f                   pop ds
loc_922e:
0922e  bd 40 ad             mov bp, 0xad40
09231  83 3e 90 31 06       cmp word ptr [0x3190], 6    ; mode_video
09236  75 06                jne loc_923e
09238  3e c7 46 04 0f 03    mov word ptr ds:[bp + 4], 0x30f
loc_923e:
0923e  83 3e 90 31 04       cmp word ptr [0x3190], 4    ; mode_video
09243  75 06                jne loc_924b
09245  c6 06 44 ad 0f       mov byte ptr [0xad44], 0xf
0924a  90                   nop
loc_924b:
0924b  83 3e 90 31 04       cmp word ptr [0x3190], 4    ; mode_video
09250  75 06                jne loc_9258
09252  c6 06 45 ad 0c       mov byte ptr [0xad45], 0xc
09257  90                   nop
loc_9258:
09258  e8 21 9f             call affiche_texte
0925b  83 3e 6a ad ff       cmp word ptr [0xad6a], -1    ; liste_objets
09260  74 25                je loc_9287
09262  be a4 ad             mov si, 0xada4    ; zones_objets
09265  e8 b2 bc             call zone_sous_curseur
09268  83 fb 02             cmp bx, 2
0926b  72 1a                jb loc_9287
0926d  83 fb 18             cmp bx, 0x18
09270  77 15                ja loc_9287
09272  8b b7 68 ad          mov si, word ptr [bx - 0x5298]
09276  83 fe ff             cmp si, -1
09279  74 0c                je loc_9287
0927b  83 e6 7f             and si, 0x7f
0927e  d1 e6                shl si, 1
09280  8b b4 fe 44          mov si, word ptr [si + 0x44fe]    ; objets
09284  e8 6a d1             call affiche_chaine
loc_9287:
09287  e8 8a cb             call curseur_dessine
0928a  e8 57 ce             call affiche_tampon
0928d  e8 47 cb             call curseur_efface
09290  e8 bf a4             call lit_commandes
09293  f6 06 92 39 20       test byte ptr [0x3992], 0x20    ; commandes
09298  74 03                je loc_929d
0929a  e9 c0 fc             jmp loc_8f5d
loc_929d:
0929d  be a4 ad             mov si, 0xada4    ; zones_objets
092a0  e8 62 bc             call zone_cliquee
092a3  83 fb 1a             cmp bx, 0x1a
092a6  76 03                jbe loc_92ab
092a8  e9 37 ff             jmp loc_91e2
loc_92ab:
092ab  83 fb 02             cmp bx, 2
092ae  73 03                jae loc_92b3
092b0  e9 2f ff             jmp loc_91e2
loc_92b3:
092b3  83 fb 1a             cmp bx, 0x1a
092b6  75 10                jne loc_92c8
092b8  e8 99 a6             call attend_relache_boutons
092bb  80 3e 67 ad 05       cmp byte ptr [0xad67], 5    ; mode_inventaire
092c0  75 03                jne loc_92c5
092c2  e9 98 fc             jmp loc_8f5d
loc_92c5:
092c5  e9 9f fb             jmp loc_8e67
loc_92c8:
092c8  8b 87 68 ad          mov ax, word ptr [bx - 0x5298]
092cc  3d ff ff             cmp ax, 0xffff
092cf  75 03                jne loc_92d4
092d1  e9 0e ff             jmp loc_91e2
loc_92d4:
092d4  25 7f 00             and ax, 0x7f
092d7  be 0e ae             mov si, 0xae0e    ; objets_champs
092da  03 f0                add si, ax
092dc  8a 1c                mov bl, byte ptr [si]
092de  8a 44 01             mov al, byte ptr [si + 1]
092e1  32 ff                xor bh, bh
092e3  8b 3e 37 46          mov di, word ptr [0x4637]    ; fiche_heros_courant
092e7  8a 54 01             mov dl, byte ptr [si + 1]
092ea  8a 21                mov ah, byte ptr [bx + di]
092ec  83 fb 17             cmp bx, 0x17
092ef  75 03                jne loc_92f4
092f1  e9 03 01             jmp boit_potion
loc_92f4:
092f4  83 fb 11             cmp bx, 0x11
092f7  74 71                je choix_arme
092f9  83 fb 13             cmp bx, 0x13
092fc  74 15                je choix_armure
092fe  83 fb 12             cmp bx, 0x12
09301  75 03                jne loc_9306
09303  e9 b5 00             jmp choix_artefact
loc_9306:
09306  83 fb 16             cmp bx, 0x16
09309  75 03                jne loc_930e
0930b  e9 77 03             jmp loc_9685
loc_930e:
0930e  88 11                mov byte ptr [bx + di], dl
09310  e9 d4 fd             jmp loc_90e7
choix_armure:    ; +0x13 ; bouclier refusé avec la hache d'armes
09313  0a d2                or dl, dl
09315  75 01                jne loc_9318
09317  c3                   ret
loc_9318:
09318  80 3e a7 3f 04       cmp byte ptr [0x3fa7], 4    ; personnage_courant
0931d  74 3c                je loc_935b
0931f  8a c2                mov al, dl
09321  22 45 13             and al, byte ptr [di + 0x13]
09324  75 3e                jne loc_9364
09326  f6 c2 08             test dl, 8
09329  74 0e                je loc_9339
loc_932b:
0932b  80 65 13 03          and byte ptr [di + 0x13], 3
0932f  08 55 13             or byte ptr [di + 0x13], dl
09332  80 65 12 1e          and byte ptr [di + 0x12], 0x1e
09336  e9 ae fd             jmp loc_90e7
loc_9339:
09339  f6 c2 04             test dl, 4
0933c  75 ed                jne loc_932b
0933e  f6 c2 01             test dl, 1
09341  74 12                je loc_9355
09343  f6 45 11 08          test byte ptr [di + 0x11], 8
09347  75 03                jne loc_934c
09349  eb 0a                jmp loc_9355
; ---- 1 octets non atteints (934b-934b)
loc_934c:
0934c  bb 2c 00             mov bx, 0x2c    ; message « VOUS NE POUVEZ PAS UTILISER UN / BOUCLIER AVEC LA HACHE D'ARMES »
0934f  e8 9b f5             call affiche_message
09352  e9 92 fd             jmp loc_90e7
loc_9355:
09355  08 55 13             or byte ptr [di + 0x13], dl
09358  e9 8c fd             jmp loc_90e7
loc_935b:
0935b  bb 2a 00             mov bx, 0x2a    ; message « VOTRE PERSONNAGE / NE PEUT PAS UTILISER CELA »
0935e  e8 8c f5             call affiche_message
09361  e9 83 fd             jmp loc_90e7
loc_9364:
09364  30 55 13             xor byte ptr [di + 0x13], dl
09367  e9 7d fd             jmp loc_90e7
choix_arme:    ; +0x11 : une seule arme ; la trousse à outils désarme un piège
0936a  80 3e a7 3f 04       cmp byte ptr [0x3fa7], 4    ; personnage_courant
0936f  75 0d                jne loc_937e
09371  8a c2                mov al, dl
09373  e8 35 b2             call numero_bit
09376  bb 56 ae             mov bx, 0xae56    ; armes_personnage4
09379  d7                   xlatb
0937a  0a c0                or al, al
0937c  74 dd                je loc_935b
loc_937e:
0937e  3a 55 11             cmp dl, byte ptr [di + 0x11]
09381  74 26                je loc_93a9
09383  88 55 11             mov byte ptr [di + 0x11], dl
09386  80 65 12 07          and byte ptr [di + 0x12], 7
0938a  f6 c2 80             test dl, 0x80
0938d  74 03                je loc_9392
0938f  e9 39 03             jmp trousse_outils
loc_9392:
09392  f6 c2 08             test dl, 8
09395  75 03                jne loc_939a
09397  e9 4d fd             jmp loc_90e7
loc_939a:
0939a  f6 45 13 01          test byte ptr [di + 0x13], 1
0939e  75 03                jne loc_93a3
093a0  e9 44 fd             jmp loc_90e7
loc_93a3:
093a3  80 65 13 fe          and byte ptr [di + 0x13], 0xfe
093a7  eb a3                jmp loc_934c
loc_93a9:
093a9  c7 45 11 00 00       mov word ptr [di + 0x11], 0
093ae  e9 36 fd             jmp loc_90e7

; ======== choix_arme_mort
; code mort entre choix_arme et choix_artefact : arme DL en +0x11 et +0x14 masqué à 7
093b1  88 55 11             mov byte ptr [di + 0x11], dl
093b4  80 65 14 07          and byte ptr [di + 0x14], 7
093b8  e9 2c fd             jmp loc_90e7
choix_artefact:    ; +0x12
093bb  8a c2                mov al, dl
093bd  24 06                and al, 6
093bf  74 03                je loc_93c4
093c1  e9 23 fd             jmp loc_90e7
loc_93c4:
093c4  8a c2                mov al, dl
093c6  22 45 12             and al, byte ptr [di + 0x12]
093c9  75 26                jne loc_93f1
093cb  f6 c2 01             test dl, 1
093ce  75 11                jne loc_93e1
093d0  8a 45 12             mov al, byte ptr [di + 0x12]
093d3  24 07                and al, 7
093d5  0a c2                or al, dl
093d7  88 45 12             mov byte ptr [di + 0x12], al
093da  c6 45 11 00          mov byte ptr [di + 0x11], 0
093de  e9 06 fd             jmp loc_90e7
loc_93e1:
093e1  8a 45 12             mov al, byte ptr [di + 0x12]
093e4  08 55 12             or byte ptr [di + 0x12], dl
093e7  8a 65 12             mov ah, byte ptr [di + 0x12]
093ea  80 65 13 03          and byte ptr [di + 0x13], 3
093ee  e9 f6 fc             jmp loc_90e7
loc_93f1:
093f1  30 55 12             xor byte ptr [di + 0x12], dl
093f4  e9 f0 fc             jmp loc_90e7
boit_potion:    ; +0x17 (en cours), retire la potion de +0x10
093f7  f6 c2 ef             test dl, 0xef
093fa  75 03                jne loc_93ff
093fc  e9 8c 00             jmp eau_benite
loc_93ff:
093ff  f6 c2 fb             test dl, 0xfb
09402  74 4f                je potion_curative
09404  f6 c2 f7             test dl, 0xf7
09407  74 4a                je potion_curative
09409  84 55 17             test byte ptr [di + 0x17], dl
0940c  74 09                je loc_9417
0940e  bb 90 00             mov bx, 0x90    ; message « VOUS AVEZ TOUJOURS CETTE / POTION DANS LE SANG »
09411  e8 d9 f4             call affiche_message
09414  e9 d0 fc             jmp loc_90e7
loc_9417:
09417  08 55 17             or byte ptr [di + 0x17], dl
0941a  30 55 10             xor byte ptr [di + 0x10], dl
0941d  80 fa 40             cmp dl, 0x40
09420  75 1a                jne loc_943c
09422  80 3e 89 42 0b       cmp byte ptr [0x4289], 0xb
09427  74 13                je loc_943c
09429  c6 06 89 42 0b       mov byte ptr [0x4289], 0xb
0942e  c6 06 8a 42 01       mov byte ptr [0x428a], 1
09433  80 36 9b 3f 08       xor byte ptr [0x3f9b], 8    ; etat_action
09438  80 75 17 40          xor byte ptr [di + 0x17], 0x40
loc_943c:
0943c  8a c2                mov al, dl
0943e  e8 6a b1             call numero_bit
09441  8a d8                mov bl, al
09443  32 ff                xor bh, bh
09445  d1 e3                shl bx, 1
09447  8b b7 62 ae          mov si, word ptr [bx - 0x519e]
0944b  8b de                mov bx, si
0944d  e8 9d f4             call affiche_message
09450  e9 94 fc             jmp loc_90e7
potion_curative:    ; « LE FLUIDE VOUS RANIME » : +4 points de corps, sans dépasser le départ
09453  8a 1e a7 3f          mov bl, byte ptr [0x3fa7]    ; personnage_courant
09457  b7 00                mov bh, 0
09459  8a 45 06             mov al, byte ptr [di + 6]
0945c  04 04                add al, 4
0945e  3a 87 94 43          cmp al, byte ptr [bx + 0x4394]    ; corps_depart
09462  72 04                jb loc_9468
09464  8a 87 94 43          mov al, byte ptr [bx + 0x4394]    ; corps_depart
loc_9468:
09468  88 45 06             mov byte ptr [di + 6], al
0946b  f6 c2 04             test dl, 4
0946e  75 0a                jne loc_947a
09470  80 75 10 08          xor byte ptr [di + 0x10], 8
09474  80 65 17 08          and byte ptr [di + 0x17], 8
09478  eb 08                jmp loc_9482
loc_947a:
0947a  80 75 10 04          xor byte ptr [di + 0x10], 4
0947e  80 65 17 04          and byte ptr [di + 0x17], 4
loc_9482:
09482  bb 82 00             mov bx, 0x82    ; message « LE FLUIDE VOUS RANIME »
09485  e8 65 f4             call affiche_message
09488  e9 5c fc             jmp loc_90e7
eau_benite:    ; tue les morts-vivants de la pièce (squelette, zombi, momie)
0948b  8b 0e e0 3f          mov cx, word ptr [0x3fe0]    ; coin_zone
0948f  e8 70 81             call adresse_case
09492  c6 06 7a ab 00       mov byte ptr [0xab7a], 0    ; choix_menu
09497  8b 3e 37 46          mov di, word ptr [0x4637]    ; fiche_heros_courant
0949b  8a 45 03             mov al, byte ptr [di + 3]
0949e  bf d6 49             mov di, 0x49d6    ; ordre_cases_vue
094a1  b9 1e 00             mov cx, 0x1e
loc_94a4:
094a4  50                   push ax
094a5  51                   push cx
094a6  53                   push bx
094a7  57                   push di
094a8  8a 15                mov dl, byte ptr [di]
094aa  b6 00                mov dh, 0
094ac  03 da                add bx, dx
094ae  8a 27                mov ah, byte ptr [bx]
094b0  80 e4 3f             and ah, 0x3f
094b3  3a c4                cmp al, ah
094b5  75 03                jne loc_94ba
094b7  e8 3d 00             call eau_benite_case
loc_94ba:
094ba  5f                   pop di
094bb  5b                   pop bx
094bc  59                   pop cx
094bd  58                   pop ax
094be  47                   inc di
094bf  e2 e3                loop loc_94a4
094c1  be 86 00             mov si, 0x86
094c4  80 3e 7a ab 00       cmp byte ptr [0xab7a], 0    ; choix_menu
094c9  74 15                je loc_94e0
094cb  a0 7a ab             mov al, byte ptr [0xab7a]    ; choix_menu
094ce  bb ae 01             mov bx, 0x1ae
094d1  8b b7 c1 5f          mov si, word ptr [bx + 0x5fc1]    ; textes
094d5  81 c6 c1 5f          add si, 0x5fc1    ; textes
094d9  04 30                add al, 0x30
094db  88 04                mov byte ptr [si], al
094dd  be 84 00             mov si, 0x84
loc_94e0:
094e0  8b de                mov bx, si
094e2  e8 08 f4             call affiche_message
094e5  8b 3e 37 46          mov di, word ptr [0x4637]    ; fiche_heros_courant
094e9  80 4d 17 10          or byte ptr [di + 0x17], 0x10
094ed  80 75 10 10          xor byte ptr [di + 0x10], 0x10
094f1  e8 67 d1             call affiche_et_pause
094f4  e9 f0 fb             jmp loc_90e7

; ======== eau_benite_case   (appelée depuis 94b7)
; si la case BX porte un squelette, un zombi ou une momie (type 4, 5, 6) : retire_monstre et choix_menu + 1 (compte des morts)
094f7  8a 87 00 04          mov al, byte ptr [bx + 0x400]
094fb  0a c0                or al, al
094fd  75 01                jne loc_9500
094ff  c3                   ret
loc_9500:
09500  3c 30                cmp al, 0x30
09502  72 01                jb loc_9505
09504  c3                   ret
loc_9505:
09505  e8 38 79             call adresse_monstre
09508  80 7f 08 04          cmp byte ptr [bx + 8], 4
0950c  74 10                je loc_951e
0950e  80 7f 08 05          cmp byte ptr [bx + 8], 5
09512  75 03                jne loc_9517
09514  eb 08                jmp loc_951e
; ---- 1 octets non atteints (9516-9516)
loc_9517:
09517  80 7f 08 06          cmp byte ptr [bx + 8], 6
0951b  74 01                je loc_951e
0951d  c3                   ret
loc_951e:
0951e  fe 06 7a ab          inc byte ptr [0xab7a]    ; choix_menu
09522  8b f3                mov si, bx
09524  e9 f9 8b             jmp retire_monstre

; ======== dessine_objets   (appelée depuis 91dc)
; dessine les 12 cases, et le cadre 0xA280 sur les objets en service
09527  e8 f9 d4             call fond_vers_tampon
0952a  be 20 34             mov si, 0x3420
0952d  bf 28 e2             mov di, 0xe228
09530  a1 2d 5e             mov ax, word ptr [0x5e2d]    ; seg_odds
09533  a3 4e 37             mov word ptr [0x374e], ax    ; segment_source
09536  50                   push ax
09537  b8 63 14             mov ax, 0x1463
0953a  8e c0                mov es, ax
0953c  58                   pop ax
0953d  bd 10 00             mov bp, 0x10
09540  b9 10 00             mov cx, 0x10
09543  1e                   push ds
09544  e8 0c a6             call copie_image
09547  1f                   pop ds
09548  e8 8b 00             call barre_texte
0954b  be 6a ad             mov si, 0xad6a    ; liste_objets
0954e  bf a4 ad             mov di, 0xada4    ; zones_objets
09551  b9 0c 00             mov cx, 0xc
loc_9554:
09554  ad                   lodsw ax, word ptr [si]
09555  51                   push cx
09556  56                   push si
09557  57                   push di
09558  3d ff ff             cmp ax, 0xffff
0955b  74 5d                je loc_95ba
0955d  8b 1d                mov bx, word ptr [di]
0955f  8b 45 02             mov ax, word ptr [di + 2]
09562  e8 0f 9c             call ligne_ecran
09565  8b c3                mov ax, bx
09567  8b 5c fe             mov bx, word ptr [si - 2]
0956a  89 1e e9 37          mov word ptr [0x37e9], bx    ; erreur_fichier
0956e  83 e3 7f             and bx, 0x7f
09571  d1 e3                shl bx, 1
09573  8b 8f 00 45          mov cx, word ptr [bx + 0x4500]
09577  50                   push ax
09578  8b f1                mov si, cx
0957a  8b f8                mov di, ax
0957c  a1 27 5e             mov ax, word ptr [0x5e27]    ; seg_annexe
0957f  a3 4e 37             mov word ptr [0x374e], ax    ; segment_source
09582  50                   push ax
09583  b8 63 14             mov ax, 0x1463
09586  8e c0                mov es, ax
09588  58                   pop ax
09589  bd 20 00             mov bp, 0x20
0958c  b9 20 00             mov cx, 0x20
0958f  1e                   push ds
09590  e8 c0 a5             call copie_image
09593  1f                   pop ds
09594  58                   pop ax
09595  81 3e e9 37 80 00    cmp word ptr [0x37e9], 0x80    ; erreur_fichier
0959b  72 1d                jb loc_95ba
0959d  be 80 a2             mov si, 0xa280
095a0  8b f8                mov di, ax
095a2  a1 27 5e             mov ax, word ptr [0x5e27]    ; seg_annexe
095a5  a3 4e 37             mov word ptr [0x374e], ax    ; segment_source
095a8  50                   push ax
095a9  b8 63 14             mov ax, 0x1463
095ac  8e c0                mov es, ax
095ae  58                   pop ax
095af  bd 20 00             mov bp, 0x20
095b2  b9 20 00             mov cx, 0x20
095b5  1e                   push ds
095b6  e8 9a a5             call copie_image
095b9  1f                   pop ds
loc_95ba:
095ba  5f                   pop di
095bb  5e                   pop si
095bc  59                   pop cx
095bd  83 c7 08             add di, 8
095c0  49                   dec cx
095c1  74 02                je loc_95c5
095c3  eb 8f                jmp loc_9554
loc_95c5:
095c5  c3                   ret
loc_95c6:
095c6  c6 06 67 ad 02       mov byte ptr [0xad67], 2    ; mode_inventaire
095cb  e9 19 fb             jmp loc_90e7
loc_95ce:
095ce  c6 06 67 ad 03       mov byte ptr [0xad67], 3    ; mode_inventaire
095d3  e9 11 fb             jmp loc_90e7

; ======== barre_texte   (appelée depuis 9548)
; bandeau de texte en (32, 169)
095d6  b8 a9 00             mov ax, 0xa9
095d9  bb 20 00             mov bx, 0x20
095dc  e8 95 9b             call ligne_ecran
095df  89 1e f3 37          mov word ptr [0x37f3], bx    ; saisie_chiffres_lus
095e3  be 80 c6             mov si, 0xc680
095e6  8b 3e f3 37          mov di, word ptr [0x37f3]    ; saisie_chiffres_lus
095ea  a1 27 5e             mov ax, word ptr [0x5e27]    ; seg_annexe
095ed  a3 4e 37             mov word ptr [0x374e], ax    ; segment_source
095f0  50                   push ax
095f1  b8 63 14             mov ax, 0x1463
095f4  8e c0                mov es, ax
095f6  58                   pop ax
095f7  bd 10 00             mov bp, 0x10
095fa  b9 14 00             mov cx, 0x14
095fd  1e                   push ds
095fe  e8 52 a5             call copie_image
09601  1f                   pop ds
09602  b9 0e 00             mov cx, 0xe
loc_9605:
09605  51                   push cx
09606  83 06 f3 37 10       add word ptr [0x37f3], 0x10    ; saisie_chiffres_lus
0960b  be c0 c7             mov si, 0xc7c0
0960e  8b 3e f3 37          mov di, word ptr [0x37f3]    ; saisie_chiffres_lus
09612  a1 27 5e             mov ax, word ptr [0x5e27]    ; seg_annexe
09615  a3 4e 37             mov word ptr [0x374e], ax    ; segment_source
09618  50                   push ax
09619  b8 63 14             mov ax, 0x1463
0961c  8e c0                mov es, ax
0961e  58                   pop ax
0961f  bd 10 00             mov bp, 0x10
09622  b9 14 00             mov cx, 0x14
09625  1e                   push ds
09626  e8 2a a5             call copie_image
09629  1f                   pop ds
0962a  59                   pop cx
0962b  e2 d8                loop loc_9605
0962d  83 06 f3 37 10       add word ptr [0x37f3], 0x10    ; saisie_chiffres_lus
09632  be 00 c9             mov si, 0xc900
09635  8b 3e f3 37          mov di, word ptr [0x37f3]    ; saisie_chiffres_lus
09639  a1 27 5e             mov ax, word ptr [0x5e27]    ; seg_annexe
0963c  a3 4e 37             mov word ptr [0x374e], ax    ; segment_source
0963f  50                   push ax
09640  b8 63 14             mov ax, 0x1463
09643  8e c0                mov es, ax
09645  58                   pop ax
09646  bd 10 00             mov bp, 0x10
09649  b9 14 00             mov cx, 0x14
0964c  1e                   push ds
0964d  e8 03 a5             call copie_image
09650  1f                   pop ds
09651  c3                   ret

; ======== liste_bits   (appelée depuis 9118, 9140, 9166, 9190, 91cc, 91d9)
; range dans la liste un numéro d'objet par bit posé dans AL
09652  d0 e8                shr al, 1
09654  73 05                jae loc_965b
09656  89 1c                mov word ptr [si], bx
09658  83 c6 02             add si, 2
loc_965b:
0965b  83 c3 02             add bx, 2
0965e  e2 f2                loop liste_bits
09660  c3                   ret

; ======== marque_en_service   (appelée depuis 912c, 9150, 917a, 91a4)
; pour chaque bit de AL, marque l'objet correspondant (sub_9670)
09661  d0 e8                shr al, 1
09663  50                   push ax
09664  73 03                jae loc_9669
09666  e8 07 00             call marque_objet
loc_9669:
09669  58                   pop ax
0966a  83 c6 02             add si, 2
0966d  e2 f2                loop marque_en_service
0966f  c3                   ret

; ======== marque_objet   (appelée depuis 9666)
; pose le bit 0x80 de l'entrée SI dans liste_objets
09670  bf 6a ad             mov di, 0xad6a    ; liste_objets
09673  b9 0c 00             mov cx, 0xc
loc_9676:
09676  39 35                cmp word ptr [di], si
09678  74 06                je loc_9680
0967a  83 c7 02             add di, 2
0967d  e2 f7                loop loc_9676
0967f  c3                   ret
loc_9680:
09680  81 0d 80 00          or word ptr [di], 0x80
09684  c3                   ret
loc_9685:
09685  88 45 16             mov byte ptr [di + 0x16], al
09688  c6 06 af 3f 01       mov byte ptr [0x3faf], 1    ; objet_choisi
0968d  80 7d 16 06          cmp byte ptr [di + 0x16], 6
09691  74 03                je menu_genie
09693  e9 c7 f8             jmp loc_8f5d
menu_genie:    ; « ORDONNEZ AU GENIE DE » : 0 révéler la pièce (sort 13), 1 attaquer (sort 6), 2 annuler (révèle aussi : bogue)
09696  bb 7c 00             mov bx, 0x7c    ; message « ORDONNEZ AU GENIE DE »
09699  e8 51 f2             call affiche_message
0969c  80 3e 7a ab 02       cmp byte ptr [0xab7a], 2    ; choix_menu
096a1  75 13                jne loc_96b6
096a3  80 3e 7a ab fe       cmp byte ptr [0xab7a], 0xfe    ; choix_menu
096a8  75 0c                jne loc_96b6
096aa  c6 06 af 3f 00       mov byte ptr [0x3faf], 0    ; objet_choisi
096af  c6 45 16 00          mov byte ptr [di + 0x16], 0
096b3  e9 a7 f8             jmp loc_8f5d
loc_96b6:
096b6  80 3e 7a ab 01       cmp byte ptr [0xab7a], 1    ; choix_menu
096bb  75 03                jne loc_96c0
096bd  e9 9d f8             jmp loc_8f5d
loc_96c0:
096c0  8b 3e 37 46          mov di, word ptr [0x4637]    ; fiche_heros_courant
096c4  c6 45 16 0d          mov byte ptr [di + 0x16], 0xd
096c8  e9 92 f8             jmp loc_8f5d
trousse_outils:    ; désarme un piège sur la case ou à côté ; le nain réussit toujours
096cb  e8 4d 7f             call adresse_case_perso
096ce  8a 55 03             mov dl, byte ptr [di + 3]
096d1  be 99 43             mov si, 0x4399
096d4  c7 06 f7 37 05 00    mov word ptr [0x37f7], 5
loc_96da:
096da  8a 4d 01             mov cl, byte ptr [di + 1]
096dd  02 0c                add cl, byte ptr [si]
096df  80 f9 1a             cmp cl, 0x1a
096e2  72 03                jb loc_96e7
096e4  e9 9c 00             jmp loc_9783
loc_96e7:
096e7  8a 6d 02             mov ch, byte ptr [di + 2]
096ea  02 6c 01             add ch, byte ptr [si + 1]
096ed  80 fd 13             cmp ch, 0x13
096f0  72 03                jb loc_96f5
096f2  e9 8e 00             jmp loc_9783
loc_96f5:
096f5  e8 a2 00             call piege_case
096f8  0a c0                or al, al
096fa  75 03                jne loc_96ff
096fc  e9 84 00             jmp loc_9783
loc_96ff:
096ff  8b d8                mov bx, ax
09701  80 3e a7 3f 01       cmp byte ptr [0x3fa7], 1    ; personnage_courant
09706  74 55                je loc_975d
09708  53                   push bx
09709  e8 ab 8a             call de_combat
0970c  8a c3                mov al, bl
0970e  5b                   pop bx
0970f  0a c0                or al, al
09711  75 4a                jne loc_975d
09713  be 0e 01             mov si, 0x10e
09716  80 fb 34             cmp bl, 0x34
09719  74 34                je loc_974f
0971b  80 fb 35             cmp bl, 0x35
0971e  74 2f                je loc_974f
09720  80 fb 36             cmp bl, 0x36
09723  75 03                jne loc_9728
09725  be 30 00             mov si, 0x30
loc_9728:
09728  80 fb 37             cmp bl, 0x37
0972b  75 03                jne loc_9730
0972d  be 30 00             mov si, 0x30
loc_9730:
09730  fe 4d 06             dec byte ptr [di + 6]
09733  57                   push di
09734  8b de                mov bx, si
09736  e8 b4 f1             call affiche_message
09739  5f                   pop di
0973a  80 7d 06 00          cmp byte ptr [di + 6], 0
0973e  74 03                je loc_9743
09740  e9 a4 f9             jmp loc_90e7
loc_9743:
09743  a0 a7 3f             mov al, byte ptr [0x3fa7]    ; personnage_courant
09746  a2 ca 3f             mov byte ptr [0x3fca], al    ; heros_courant
09749  e8 8c 79             call mort_heros
0974c  e9 0e f8             jmp loc_8f5d
loc_974f:
0974f  a0 a7 3f             mov al, byte ptr [0x3fa7]    ; personnage_courant
09752  32 e4                xor ah, ah
09754  d0 e0                shl al, 1
09756  be 36 00             mov si, 0x36
09759  03 f0                add si, ax
0975b  eb d3                jmp loc_9730
loc_975d:
0975d  be 44 00             mov si, 0x44
09760  80 fb 34             cmp bl, 0x34
09763  75 03                jne loc_9768
09765  be 46 00             mov si, 0x46
loc_9768:
09768  80 fb 35             cmp bl, 0x35
0976b  75 03                jne loc_9770
0976d  be 46 00             mov si, 0x46
loc_9770:
09770  80 fb 36             cmp bl, 0x36
09773  75 03                jne loc_9778
09775  be 32 00             mov si, 0x32
loc_9778:
09778  80 fb 37             cmp bl, 0x37
0977b  75 03                jne loc_9780
0977d  be 32 00             mov si, 0x32
loc_9780:
09780  eb 10                jmp loc_9792
; ---- 1 octets non atteints (9782-9782)
loc_9783:
09783  83 c6 02             add si, 2
09786  ff 0e f7 37          dec word ptr [0x37f7]
0978a  74 03                je loc_978f
0978c  e9 4b ff             jmp loc_96da
loc_978f:
0978f  be 48 00             mov si, 0x48
loc_9792:
09792  8b de                mov bx, si
09794  e8 56 f1             call affiche_message
09797  e9 4d f9             jmp loc_90e7

; ======== piege_case   (appelée depuis 96f5)
; AL = 0x31 à 0x36 si la case (CL, CH) de la zone DL porte un piège, qu'il efface
0979a  52                   push dx
0979b  e8 64 7e             call adresse_case
0979e  5a                   pop dx
0979f  53                   push bx
097a0  3a c2                cmp al, dl
097a2  75 13                jne loc_97b7
097a4  8a 87 00 04          mov al, byte ptr [bx + 0x400]
097a8  3c 31                cmp al, 0x31
097aa  72 0b                jb loc_97b7
097ac  3c 37                cmp al, 0x37
097ae  73 07                jae loc_97b7
097b0  c6 87 00 04 00       mov byte ptr [bx + 0x400], 0
097b5  5b                   pop bx
097b6  c3                   ret
loc_97b7:
097b7  32 c0                xor al, al
097b9  5b                   pop bx
097ba  c3                   ret
