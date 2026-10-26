; INTRO.EXE décompressé, désassemblé par outils/desassembler.py. Ne pas modifier : enrichir original/symboles.txt puis relancer.


; ======== sub_44b0   (appelée depuis 4e2c, 6a56, 6f1e, 7417, 799c)
044b0  50                   push ax
044b1  b8 00 00             mov ax, 0
044b4  8e d8                mov ds, ax
044b6  58                   pop ax
044b7  8c c0                mov ax, es
044b9  8c d3                mov bx, ss
044bb  2b d8                sub bx, ax
044bd  83 c3 68             add bx, 0x68
044c0  b4 4a                mov ah, 0x4a
044c2  cd 21                int 0x21
044c4  73 03                jae loc_44c9
044c6  e9 b3 03             jmp loc_487c
loc_44c9:
044c9  c7 06 40 14 08 00    mov word ptr [0x1440], 8
044cf  32 e4                xor ah, ah
044d1  b0 03                mov al, 3
044d3  cd 10                int 0x10
044d5  c7 06 a9 1b 02 00    mov word ptr [0x1ba9], 2
044db  c7 06 a5 1b 40 14    mov word ptr [0x1ba5], 0x1440
044e1  b8 00 00             mov ax, 0
044e4  a3 a3 1b             mov word ptr [0x1ba3], ax
044e7  e8 57 2d             call sub_7241
044ea  e8 c4 2a             call sub_6fb1
044ed  83 3e 8b 1a 02       cmp word ptr [0x1a8b], 2
044f2  75 03                jne loc_44f7
044f4  eb 25                jmp loc_451b
; ---- 1 octets non atteints (44f6-44f6)
loc_44f7:
044f7  ba 34 00             mov dx, 0x34
044fa  b4 09                mov ah, 9
044fc  cd 21                int 0x21
044fe  b9 ff ff             mov cx, 0xffff
loc_4501:
04501  b4 01                mov ah, 1
04503  cd 16                int 0x16
04505  74 08                je loc_450f
04507  3c 73                cmp al, 0x73
04509  74 09                je loc_4514
0450b  3c 53                cmp al, 0x53
0450d  74 05                je loc_4514
loc_450f:
0450f  e2 f0                loop loc_4501
04511  e9 3d 01             jmp loc_4651
loc_4514:
04514  ba 02 00             mov dx, 2
04517  b4 41                mov ah, 0x41
04519  cd 21                int 0x21
loc_451b:
0451b  ba 0c 00             mov dx, 0xc
0451e  b4 09                mov ah, 9
04520  cd 21                int 0x21
04522  ba 0f 18             mov dx, 0x180f
04525  b4 09                mov ah, 9
04527  cd 21                int 0x21
04529  c7 06 40 14 00 00    mov word ptr [0x1440], 0
loc_452f:
0452f  32 e4                xor ah, ah
04531  cd 16                int 0x16
04533  3c 61                cmp al, 0x61
04535  72 06                jb loc_453d
04537  3c 7a                cmp al, 0x7a
04539  77 02                ja loc_453d
0453b  0c 20                or al, 0x20
loc_453d:
0453d  3c 31                cmp al, 0x31
0453f  75 06                jne loc_4547
04541  c7 06 40 14 08 00    mov word ptr [0x1440], 8
loc_4547:
04547  3c 32                cmp al, 0x32
04549  75 06                jne loc_4551
0454b  c7 06 40 14 06 00    mov word ptr [0x1440], 6
loc_4551:
04551  3c 33                cmp al, 0x33
04553  75 06                jne loc_455b
04555  c7 06 40 14 04 00    mov word ptr [0x1440], 4
loc_455b:
0455b  83 3e 40 14 04       cmp word ptr [0x1440], 4
04560  72 cd                jb loc_452f
04562  ba 55 18             mov dx, 0x1855
04565  b4 09                mov ah, 9
04567  cd 21                int 0x21
04569  c6 06 42 14 ff       mov byte ptr [0x1442], 0xff
loc_456e:
0456e  32 e4                xor ah, ah
04570  cd 16                int 0x16
04572  3c 61                cmp al, 0x61
04574  72 06                jb loc_457c
04576  3c 7a                cmp al, 0x7a
04578  77 02                ja loc_457c
0457a  0c 20                or al, 0x20
loc_457c:
0457c  3c 31                cmp al, 0x31
0457e  75 05                jne loc_4585
04580  c6 06 42 14 00       mov byte ptr [0x1442], 0
loc_4585:
04585  3c 32                cmp al, 0x32
04587  75 05                jne loc_458e
04589  c6 06 42 14 01       mov byte ptr [0x1442], 1
loc_458e:
0458e  3c 33                cmp al, 0x33
04590  75 05                jne loc_4597
04592  c6 06 42 14 02       mov byte ptr [0x1442], 2
loc_4597:
04597  80 3e 42 14 ff       cmp byte ptr [0x1442], 0xff
0459c  74 d0                je loc_456e
0459e  80 3e 42 14 00       cmp byte ptr [0x1442], 0
045a3  75 0c                jne loc_45b1
045a5  83 3e 40 14 04       cmp word ptr [0x1440], 4
045aa  75 05                jne loc_45b1
045ac  c6 06 42 14 03       mov byte ptr [0x1442], 3
loc_45b1:
045b1  ba 92 12             mov dx, 0x1292
045b4  b4 09                mov ah, 9
045b6  cd 21                int 0x21
045b8  c6 06 43 14 ff       mov byte ptr [0x1443], 0xff
loc_45bd:
045bd  32 e4                xor ah, ah
045bf  cd 16                int 0x16
045c1  3c 61                cmp al, 0x61
045c3  72 06                jb loc_45cb
045c5  3c 7a                cmp al, 0x7a
045c7  77 02                ja loc_45cb
045c9  0c 20                or al, 0x20
loc_45cb:
045cb  3c 31                cmp al, 0x31
045cd  74 08                je loc_45d7
045cf  3c 32                cmp al, 0x32
045d1  74 04                je loc_45d7
045d3  3c 33                cmp al, 0x33
045d5  75 e6                jne loc_45bd
loc_45d7:
045d7  2c 31                sub al, 0x31
045d9  a2 43 14             mov byte ptr [0x1443], al
045dc  a2 45 14             mov byte ptr [0x1445], al
045df  ba da 12             mov dx, 0x12da
045e2  b4 09                mov ah, 9
045e4  cd 21                int 0x21
loc_45e6:
045e6  32 e4                xor ah, ah
045e8  cd 16                int 0x16
045ea  3c 61                cmp al, 0x61
045ec  72 06                jb loc_45f4
045ee  3c 7a                cmp al, 0x7a
045f0  77 02                ja loc_45f4
045f2  0c 20                or al, 0x20
loc_45f4:
045f4  3c 31                cmp al, 0x31
045f6  74 08                je loc_4600
045f8  3c 32                cmp al, 0x32
045fa  74 04                je loc_4600
045fc  3c 33                cmp al, 0x33
045fe  75 e6                jne loc_45e6
loc_4600:
04600  2c 31                sub al, 0x31
04602  a2 46 14             mov byte ptr [0x1446], al
04605  ba 1e 13             mov dx, 0x131e
04608  b4 09                mov ah, 9
0460a  cd 21                int 0x21
loc_460c:
0460c  32 e4                xor ah, ah
0460e  cd 16                int 0x16
04610  3c 61                cmp al, 0x61
04612  72 06                jb loc_461a
04614  3c 7a                cmp al, 0x7a
04616  77 02                ja loc_461a
04618  0c 20                or al, 0x20
loc_461a:
0461a  3c 31                cmp al, 0x31
0461c  74 08                je loc_4626
0461e  3c 32                cmp al, 0x32
04620  74 04                je loc_4626
04622  3c 33                cmp al, 0x33
04624  75 e6                jne loc_460c
loc_4626:
04626  2c 31                sub al, 0x31
04628  a2 47 14             mov byte ptr [0x1447], al
0462b  ba 5c 13             mov dx, 0x135c
0462e  b4 09                mov ah, 9
04630  cd 21                int 0x21
loc_4632:
04632  32 e4                xor ah, ah
04634  cd 16                int 0x16
04636  3c 61                cmp al, 0x61
04638  72 06                jb loc_4640
0463a  3c 7a                cmp al, 0x7a
0463c  77 02                ja loc_4640
0463e  0c 20                or al, 0x20
loc_4640:
04640  3c 31                cmp al, 0x31
04642  74 08                je loc_464c
04644  3c 32                cmp al, 0x32
04646  74 04                je loc_464c
04648  3c 33                cmp al, 0x33
0464a  75 e6                jne loc_4632
loc_464c:
0464c  2c 31                sub al, 0x31
0464e  a2 48 14             mov byte ptr [0x1448], al
loc_4651:
04651  e8 d1 07             call sub_4e25
04654  c6 06 fb 19 01       mov byte ptr [0x19fb], 1
04659  c6 06 f2 19 06       mov byte ptr [0x19f2], 6
0465e  b8 86 0a             mov ax, 0xa86
04661  a3 f8 19             mov word ptr [0x19f8], ax
04664  e8 00 39             call sub_7f67
04667  e8 f8 39             call sub_8062
0466a  e8 5d 3a             call sub_80ca
0466d  83 3e 40 14 08       cmp word ptr [0x1440], 8
04672  74 03                je loc_4677
04674  e9 10 02             jmp loc_4887
loc_4677:
04677  c7 06 a9 1b b2 00    mov word ptr [0x1ba9], 0xb2
0467d  c7 06 a5 1b 00 00    mov word ptr [0x1ba5], 0
04683  b8 26 1a             mov ax, 0x1a26
04686  a3 a3 1b             mov word ptr [0x1ba3], ax
04689  e8 b5 2b             call sub_7241
0468c  c7 06 a9 1b be 00    mov word ptr [0x1ba9], 0xbe
04692  c7 06 a5 1b 00 00    mov word ptr [0x1ba5], 0
04698  b8 23 25             mov ax, 0x2523
0469b  a3 a3 1b             mov word ptr [0x1ba3], ax
0469e  e8 a0 2b             call sub_7241
046a1  ba 5e 0c             mov dx, 0xc5e
046a4  e8 9c 07             call sub_4e43
046a7  bf be 0c             mov di, 0xcbe
046aa  e8 20 08             call sub_4ecd
046ad  b9 d0 07             mov cx, 0x7d0
046b0  e8 90 38             call sub_7f43
046b3  c7 06 a9 1b c8 00    mov word ptr [0x1ba9], 0xc8
046b9  c7 06 a5 1b 00 00    mov word ptr [0x1ba5], 0
046bf  b8 26 1a             mov ax, 0x1a26
046c2  a3 a3 1b             mov word ptr [0x1ba3], ax
046c5  e8 79 2b             call sub_7241
046c8  bf 1e 0d             mov di, 0xd1e
046cb  e8 ff 07             call sub_4ecd
046ce  e8 4a 08             call sub_4f1b
046d1  3c 01                cmp al, 1
046d3  75 03                jne loc_46d8
046d5  eb 62                jmp loc_4739
; ---- 1 octets non atteints (46d7-46d7)
loc_46d8:
046d8  bd fd 00             mov bp, 0xfd
046db  e8 7d 07             call sub_4e5b
046de  3c 01                cmp al, 1
046e0  75 03                jne loc_46e5
046e2  eb 55                jmp loc_4739
; ---- 1 octets non atteints (46e4-46e4)
loc_46e5:
046e5  b9 06 00             mov cx, 6
046e8  c7 06 00 00 00 00    mov word ptr [0], 0
loc_46ee:
046ee  51                   push cx
046ef  8b 1e 00 00          mov bx, word ptr [0]
046f3  8b 97 6a 00          mov dx, word ptr [bx + 0x6a]
046f7  89 16 a9 1b          mov word ptr [0x1ba9], dx
046fb  c7 06 a5 1b 00 00    mov word ptr [0x1ba5], 0
04701  b8 26 1a             mov ax, 0x1a26
04704  a3 a3 1b             mov word ptr [0x1ba3], ax
04707  e8 37 2b             call sub_7241
0470a  8b 1e 00 00          mov bx, word ptr [0]
0470e  8b bf 5e 00          mov di, word ptr [bx + 0x5e]
04712  e8 b8 07             call sub_4ecd
04715  8b 1e 00 00          mov bx, word ptr [0]
04719  e8 f0 02             call sub_4a0c
0471c  8b 1e 00 00          mov bx, word ptr [0]
04720  8b af 52 00          mov bp, word ptr [bx + 0x52]
04724  e8 34 07             call sub_4e5b
04727  59                   pop cx
04728  3c 01                cmp al, 1
0472a  75 03                jne loc_472f
0472c  eb 0b                jmp loc_4739
; ---- 1 octets non atteints (472e-472e)
loc_472f:
0472f  83 06 00 00 02       add word ptr [0], 2
04734  e2 b8                loop loc_46ee
04736  e8 86 08             call sub_4fbf
loc_4739:
04739  c7 06 a9 1b 02 00    mov word ptr [0x1ba9], 2
0473f  c7 06 a5 1b 40 14    mov word ptr [0x1ba5], 0x1440
04745  b8 00 00             mov ax, 0
04748  a3 a3 1b             mov word ptr [0x1ba3], ax
0474b  e8 f3 2a             call sub_7241
0474e  83 3e 8b 1a 02       cmp word ptr [0x1a8b], 2
04753  74 03                je loc_4758
04755  e9 1e 01             jmp loc_4876
loc_4758:
04758  a1 40 14             mov ax, word ptr [0x1440]
0475b  a3 a2 10             mov word ptr [0x10a2], ax
0475e  3d 08 00             cmp ax, 8
04761  75 06                jne loc_4769
04763  c7 06 40 14 06 00    mov word ptr [0x1440], 6
loc_4769:
04769  e8 90 02             call sub_49fc
0476c  e8 b6 06             call sub_4e25
0476f  c7 06 a9 1b e6 00    mov word ptr [0x1ba9], 0xe6
04775  c7 06 a5 1b 00 00    mov word ptr [0x1ba5], 0
0477b  b8 26 1a             mov ax, 0x1a26
0477e  a3 a3 1b             mov word ptr [0x1ba3], ax
04781  e8 bd 2a             call sub_7241
04784  e8 2a 28             call sub_6fb1
04787  50                   push ax
04788  b8 86 0a             mov ax, 0xa86
0478b  8e c0                mov es, ax
0478d  58                   pop ax
0478e  50                   push ax
0478f  b8 26 1a             mov ax, 0x1a26
04792  8e d8                mov ds, ax
04794  58                   pop ax
04795  33 ff                xor di, di
04797  8b f7                mov si, di
04799  b9 00 7d             mov cx, 0x7d00
0479c  e8 ee 36             call sub_7e8d
0479f  50                   push ax
047a0  b8 00 00             mov ax, 0
047a3  8e d8                mov ds, ax
047a5  58                   pop ax
047a6  83 3e 40 14 04       cmp word ptr [0x1440], 4
047ab  74 09                je loc_47b6
047ad  e8 d0 01             call sub_4980
047b0  ba 80 10             mov dx, 0x1080
047b3  eb 07                jmp loc_47bc
; ---- 1 octets non atteints (47b5-47b5)
loc_47b6:
047b6  e8 34 08             call sub_4fed
047b9  ba 91 10             mov dx, 0x1091
loc_47bc:
047bc  b8 02 10             mov ax, 0x1002
047bf  50                   push ax
047c0  b8 00 00             mov ax, 0
047c3  8e c0                mov es, ax
047c5  58                   pop ax
047c6  cd 10                int 0x10
loc_47c8:
047c8  b4 00                mov ah, 0
047ca  cd 16                int 0x16
047cc  c6 06 44 14 00       mov byte ptr [0x1444], 0
047d1  80 fc 12             cmp ah, 0x12
047d4  74 28                je loc_47fe
047d6  c6 06 44 14 01       mov byte ptr [0x1444], 1
047db  80 fc 21             cmp ah, 0x21
047de  74 1e                je loc_47fe
047e0  c6 06 44 14 02       mov byte ptr [0x1444], 2
047e5  80 fc 1f             cmp ah, 0x1f
047e8  74 14                je loc_47fe
047ea  c6 06 44 14 03       mov byte ptr [0x1444], 3
047ef  80 fc 22             cmp ah, 0x22
047f2  74 0a                je loc_47fe
047f4  c6 06 44 14 04       mov byte ptr [0x1444], 4
047f9  80 fc 17             cmp ah, 0x17
047fc  75 ca                jne loc_47c8
loc_47fe:
047fe  a1 a2 10             mov ax, word ptr [0x10a2]
04801  a3 40 14             mov word ptr [0x1440], ax
04804  32 e4                xor ah, ah
04806  b0 03                mov al, 3
04808  cd 10                int 0x10
0480a  c7 06 a9 1b 02 00    mov word ptr [0x1ba9], 2
04810  c7 06 a5 1b 40 14    mov word ptr [0x1ba5], 0x1440
04816  c7 06 a7 1b 09 00    mov word ptr [0x1ba7], 9
0481c  b8 00 00             mov ax, 0
0481f  a3 a3 1b             mov word ptr [0x1ba3], ax
04822  e8 3b 2a             call sub_7260
04825  e8 89 27             call sub_6fb1
04828  ba 2b 14             mov dx, 0x142b    ; "quest.exe"
0482b  32 c0                xor al, al
0482d  b4 3d                mov ah, 0x3d
0482f  cd 21                int 0x21
04831  72 09                jb loc_483c
04833  8b d8                mov bx, ax
04835  b4 3e                mov ah, 0x3e
04837  cd 21                int 0x21
04839  eb 3b                jmp loc_4876
; ---- 1 octets non atteints (483b-483b)
loc_483c:
0483c  ba 9d 13             mov dx, 0x139d
0483f  b4 09                mov ah, 9
04841  cd 21                int 0x21
04843  b4 00                mov ah, 0
04845  cd 16                int 0x16
04847  ba 2b 14             mov dx, 0x142b    ; "quest.exe"
0484a  32 c0                xor al, al
0484c  b4 3d                mov ah, 0x3d
0484e  cd 21                int 0x21
04850  72 ea                jb loc_483c
04852  8b d8                mov bx, ax
04854  b4 3e                mov ah, 0x3e
04856  cd 21                int 0x21
04858  c7 06 a9 1b 02 00    mov word ptr [0x1ba9], 2
0485e  c7 06 a5 1b 40 14    mov word ptr [0x1ba5], 0x1440
04864  c7 06 a7 1b 09 00    mov word ptr [0x1ba7], 9
0486a  b8 00 00             mov ax, 0
0486d  a3 a3 1b             mov word ptr [0x1ba3], ax
04870  e8 ed 29             call sub_7260
04873  e8 3b 27             call sub_6fb1
loc_4876:
04876  e8 38 27             call sub_6fb1
04879  e8 ae 37             call sub_802a
loc_487c:
0487c  32 e4                xor ah, ah
0487e  b0 03                mov al, 3
04880  cd 10                int 0x10
04882  b8 00 4c             mov ax, 0x4c00
04885  cd 21                int 0x21
loc_4887:
04887  c6 06 f2 19 07       mov byte ptr [0x19f2], 7
0488c  e8 6d 01             call sub_49fc
0488f  c7 06 a9 1b db 00    mov word ptr [0x1ba9], 0xdb
04895  c7 06 a5 1b 00 00    mov word ptr [0x1ba5], 0
0489b  b8 26 1a             mov ax, 0x1a26
0489e  a3 a3 1b             mov word ptr [0x1ba3], ax
048a1  e8 9d 29             call sub_7241
048a4  b8 23 2e             mov ax, 0x2e23
048a7  8e c0                mov es, ax
048a9  33 f6                xor si, si
048ab  bf 00 00             mov di, 0
048ae  b8 26 1a             mov ax, 0x1a26
048b1  8e d8                mov ds, ax
048b3  b9 ff ff             mov cx, 0xffff
048b6  e8 d4 35             call sub_7e8d
048b9  50                   push ax
048ba  b8 00 00             mov ax, 0
048bd  8e d8                mov ds, ax
048bf  58                   pop ax
048c0  c7 06 a9 1b f0 00    mov word ptr [0x1ba9], 0xf0
048c6  c7 06 a5 1b 00 00    mov word ptr [0x1ba5], 0
048cc  b8 26 1a             mov ax, 0x1a26
048cf  a3 a3 1b             mov word ptr [0x1ba3], ax
048d2  e8 6c 29             call sub_7241
048d5  e8 d9 26             call sub_6fb1
048d8  bd 51 02             mov bp, 0x251
048db  e8 34 00             call sub_4912
048de  bd fd 00             mov bp, 0xfd
048e1  e8 2e 00             call sub_4912
048e4  3c 01                cmp al, 1
048e6  75 03                jne loc_48eb
048e8  e9 4e fe             jmp loc_4739
loc_48eb:
048eb  b9 06 00             mov cx, 6
048ee  c7 06 00 00 00 00    mov word ptr [0], 0
loc_48f4:
048f4  51                   push cx
048f5  8b 1e 00 00          mov bx, word ptr [0]
048f9  8b af 52 00          mov bp, word ptr [bx + 0x52]
048fd  e8 12 00             call sub_4912
04900  59                   pop cx
04901  3c 01                cmp al, 1
04903  75 03                jne loc_4908
04905  e9 31 fe             jmp loc_4739
loc_4908:
04908  83 06 00 00 02       add word ptr [0], 2
0490d  e2 e5                loop loc_48f4
0490f  e9 27 fe             jmp loc_4739

; ======== sub_4912   (appelée depuis 48db, 48e1, 48fd)
04912  83 3e 40 14 04       cmp word ptr [0x1440], 4
04917  74 24                je loc_493d
04919  55                   push bp
0491a  50                   push ax
0491b  b8 86 0a             mov ax, 0xa86
0491e  8e c0                mov es, ax
04920  58                   pop ax
04921  50                   push ax
04922  b8 26 1a             mov ax, 0x1a26
04925  8e d8                mov ds, ax
04927  58                   pop ax
04928  33 ff                xor di, di
0492a  8b f7                mov si, di
0492c  b9 00 7d             mov cx, 0x7d00
0492f  e8 5b 35             call sub_7e8d
04932  50                   push ax
04933  b8 00 00             mov ax, 0
04936  8e d8                mov ds, ax
04938  58                   pop ax
04939  5d                   pop bp
0493a  eb 12                jmp loc_494e
; ---- 1 octets non atteints (493c-493c)
loc_493d:
0493d  50                   push ax
0493e  b8 86 0a             mov ax, 0xa86
04941  8e c0                mov es, ax
04943  58                   pop ax
04944  33 ff                xor di, di
04946  b8 cc cc             mov ax, 0xcccc
04949  b9 00 40             mov cx, 0x4000
0494c  f3 ab                rep stosw word ptr es:[di], ax
loc_494e:
0494e  81 fd 51 02          cmp bp, 0x251
04952  75 20                jne loc_4974
04954  55                   push bp
04955  be 40 7c             mov si, 0x7c40
04958  bf 2c 14             mov di, 0x142c    ; "uest.exe"
0495b  b8 23 2e             mov ax, 0x2e23
0495e  a3 f0 19             mov word ptr [0x19f0], ax
04961  50                   push ax
04962  b8 86 0a             mov ax, 0xa86
04965  8e c0                mov es, ax
04967  58                   pop ax
04968  bd e0 00             mov bp, 0xe0
0496b  b9 44 00             mov cx, 0x44
0496e  1e                   push ds
0496f  e8 9e 2a             call sub_7410
04972  1f                   pop ds
04973  5d                   pop bp
loc_4974:
04974  e8 c5 20             call sub_6a3c
04977  e8 06 00             call sub_4980
0497a  e8 65 00             call sub_49e2
0497d  e9 9b 05             jmp sub_4f1b

; ======== sub_4980   (appelée depuis 47ad, 4977)
04980  83 3e 40 14 04       cmp word ptr [0x1440], 4
04985  74 3a                je loc_49c1
04987  50                   push ax
04988  b8 00 a0             mov ax, 0xa000
0498b  8e c0                mov es, ax
0498d  58                   pop ax
0498e  50                   push ax
0498f  b8 86 0a             mov ax, 0xa86
04992  8e d8                mov ds, ax
04994  58                   pop ax
04995  33 f6                xor si, si
04997  8b fe                mov di, si
04999  ba c4 03             mov dx, 0x3c4
0499c  b8 02 08             mov ax, 0x802
0499f  bb c8 00             mov bx, 0xc8
loc_49a2:
049a2  50                   push ax
049a3  ef                   out dx, ax
049a4  b9 14 00             mov cx, 0x14
049a7  57                   push di
049a8  f3 a5                rep movsw word ptr es:[di], word ptr [si]
049aa  5f                   pop di
049ab  58                   pop ax
049ac  d0 ec                shr ah, 1
049ae  75 f2                jne loc_49a2
049b0  83 c7 28             add di, 0x28
049b3  b8 02 08             mov ax, 0x802
049b6  4b                   dec bx
049b7  75 e9                jne loc_49a2
049b9  50                   push ax
049ba  b8 00 00             mov ax, 0
049bd  8e d8                mov ds, ax
049bf  58                   pop ax
049c0  c3                   ret
loc_49c1:
049c1  50                   push ax
049c2  b8 00 b8             mov ax, 0xb800
049c5  8e c0                mov es, ax
049c7  58                   pop ax
049c8  50                   push ax
049c9  b8 86 0a             mov ax, 0xa86
049cc  8e d8                mov ds, ax
049ce  58                   pop ax
049cf  be 00 00             mov si, 0
049d2  bf 00 00             mov di, 0
049d5  b9 00 40             mov cx, 0x4000
049d8  f3 a5                rep movsw word ptr es:[di], word ptr [si]
049da  50                   push ax
049db  b8 00 00             mov ax, 0
049de  8e d8                mov ds, ax
049e0  58                   pop ax
049e1  c3                   ret

; ======== sub_49e2   (appelée depuis 497a)
049e2  ba 5e 10             mov dx, 0x105e
049e5  83 3e 40 14 04       cmp word ptr [0x1440], 4
049ea  75 03                jne loc_49ef
049ec  ba 6f 10             mov dx, 0x106f
loc_49ef:
049ef  b8 02 10             mov ax, 0x1002
049f2  50                   push ax
049f3  b8 00 00             mov ax, 0
049f6  8e c0                mov es, ax
049f8  58                   pop ax
049f9  cd 10                int 0x10
049fb  c3                   ret

; ======== sub_49fc   (appelée depuis 4769, 488c)
049fc  b8 02 10             mov ax, 0x1002
049ff  50                   push ax
04a00  b8 00 00             mov ax, 0
04a03  8e c0                mov es, ax
04a05  58                   pop ax
04a06  ba 5e 0c             mov dx, 0xc5e
04a09  cd 10                int 0x10
04a0b  c3                   ret

; ======== sub_4a0c   (appelée depuis 4719)
04a0c  2e ff a7 1e 07       jmp word ptr cs:[bx + 0x71e]

; ======== sub_4a11   (routine probable : non appelée directement)
04a11  be 00 00             mov si, 0
04a14  bf 00 00             mov di, 0
04a17  b9 04 00             mov cx, 4
04a1a  e8 33 03             call sub_4d50
04a1d  b9 18 00             mov cx, 0x18
04a20  c7 06 8e 12 00 00    mov word ptr [0x128e], 0
loc_4a26:
04a26  51                   push cx
04a27  e8 b7 01             call sub_4be1
04a2a  a1 8e 12             mov ax, word ptr [0x128e]
04a2d  86 e0                xchg al, ah
04a2f  8b f0                mov si, ax
04a31  bf 04 83             mov di, 0x8304
04a34  e8 e8 01             call sub_4c1f
04a37  e8 c3 01             call sub_4bfd
04a3a  ba 06 00             mov dx, 6
04a3d  e8 9a 01             call sub_4bda
04a40  ff 06 8e 12          inc word ptr [0x128e]
04a44  83 26 8e 12 03       and word ptr [0x128e], 3
04a49  59                   pop cx
04a4a  e2 da                loop loc_4a26
04a4c  c3                   ret

; ======== sub_4a4d   (routine probable : non appelée directement)
04a4d  be 80 02             mov si, 0x280
04a50  b9 03 00             mov cx, 3
04a53  e8 3d 03             call sub_4d93
04a56  b9 0a 00             mov cx, 0xa
loc_4a59:
04a59  51                   push cx
04a5a  b9 03 00             mov cx, 3
04a5d  ba 02 00             mov dx, 2
04a60  bf 86 6e             mov di, 0x6e86
04a63  e8 f0 01             call sub_4c56
04a66  59                   pop cx
04a67  e2 f0                loop loc_4a59
04a69  c3                   ret

; ======== sub_4a6a   (routine probable : non appelée directement)
04a6a  be 80 11             mov si, 0x1180
04a6d  b9 04 00             mov cx, 4
04a70  e8 69 03             call sub_4ddc
04a73  ba 3c 00             mov dx, 0x3c
loc_4a76:
04a76  e8 d2 34             call sub_7f4b
04a79  4a                   dec dx
04a7a  75 fa                jne loc_4a76
04a7c  b9 04 00             mov cx, 4
04a7f  ba 04 00             mov dx, 4
04a82  bf 80 28             mov di, 0x2880
04a85  e8 4b 02             call sub_4cd3
04a88  ba f0 00             mov dx, 0xf0
loc_4a8b:
04a8b  e8 bd 34             call sub_7f4b
04a8e  4a                   dec dx
04a8f  75 fa                jne loc_4a8b
04a91  c3                   ret

; ======== sub_4a92   (routine probable : non appelée directement)
04a92  be 80 39             mov si, 0x3980
04a95  bf 00 00             mov di, 0
04a98  b9 10 00             mov cx, 0x10
04a9b  e8 b2 02             call sub_4d50
04a9e  b9 1e 00             mov cx, 0x1e
04aa1  c7 06 8e 12 00 00    mov word ptr [0x128e], 0
04aa7  c7 06 90 12 00 00    mov word ptr [0x1290], 0
loc_4aad:
04aad  51                   push cx
04aae  e8 30 01             call sub_4be1
04ab1  a1 8e 12             mov ax, word ptr [0x128e]
04ab4  86 e0                xchg al, ah
04ab6  8b f0                mov si, ax
04ab8  bf 80 82             mov di, 0x8280
04abb  e8 61 01             call sub_4c1f
04abe  a1 8e 12             mov ax, word ptr [0x128e]
04ac1  86 e0                xchg al, ah
04ac3  be 00 08             mov si, 0x800
04ac6  03 f0                add si, ax
04ac8  bf 62 8c             mov di, 0x8c62
04acb  e8 51 01             call sub_4c1f
04ace  a1 90 12             mov ax, word ptr [0x1290]
04ad1  86 e0                xchg al, ah
04ad3  be 00 05             mov si, 0x500
04ad6  03 f0                add si, ax
04ad8  bf 78 78             mov di, 0x7878
04adb  e8 41 01             call sub_4c1f
04ade  a1 90 12             mov ax, word ptr [0x1290]
04ae1  86 e0                xchg al, ah
04ae3  be 00 0d             mov si, 0xd00
04ae6  03 f0                add si, ax
04ae8  bf 78 96             mov di, 0x9678
04aeb  e8 31 01             call sub_4c1f
04aee  e8 0c 01             call sub_4bfd
04af1  ba 0c 00             mov dx, 0xc
04af4  e8 e3 00             call sub_4bda
04af7  a1 8e 12             mov ax, word ptr [0x128e]
04afa  40                   inc ax
04afb  3d 04 00             cmp ax, 4
04afe  7e 03                jle loc_4b03
04b00  b8 00 00             mov ax, 0
loc_4b03:
04b03  a3 8e 12             mov word ptr [0x128e], ax
04b06  a1 90 12             mov ax, word ptr [0x1290]
04b09  40                   inc ax
04b0a  3d 02 00             cmp ax, 2
04b0d  7e 03                jle loc_4b12
04b0f  b8 00 00             mov ax, 0
loc_4b12:
04b12  a3 90 12             mov word ptr [0x1290], ax
04b15  59                   pop cx
04b16  e2 95                loop loc_4aad
04b18  c3                   ret

; ======== sub_4b19   (routine probable : non appelée directement)
04b19  be 80 43             mov si, 0x4380
04b1c  bf 00 00             mov di, 0
04b1f  b9 0c 00             mov cx, 0xc
04b22  e8 2b 02             call sub_4d50
04b25  b9 1e 00             mov cx, 0x1e
04b28  c7 06 8e 12 00 00    mov word ptr [0x128e], 0
04b2e  c7 06 90 12 00 00    mov word ptr [0x1290], 0
loc_4b34:
04b34  51                   push cx
04b35  e8 a9 00             call sub_4be1
04b38  a1 8e 12             mov ax, word ptr [0x128e]
04b3b  86 e0                xchg al, ah
04b3d  8b f0                mov si, ax
04b3f  bf e0 96             mov di, 0x96e0
04b42  e8 da 00             call sub_4c1f
04b45  a1 90 12             mov ax, word ptr [0x1290]
04b48  86 e0                xchg al, ah
04b4a  be 00 05             mov si, 0x500
04b4d  03 f0                add si, ax
04b4f  bf 68 8c             mov di, 0x8c68
04b52  e8 ca 00             call sub_4c1f
04b55  e8 a5 00             call sub_4bfd
04b58  ba 08 00             mov dx, 8
04b5b  e8 7c 00             call sub_4bda
04b5e  a1 8e 12             mov ax, word ptr [0x128e]
04b61  40                   inc ax
04b62  3d 04 00             cmp ax, 4
04b65  7e 03                jle loc_4b6a
04b67  b8 00 00             mov ax, 0
loc_4b6a:
04b6a  a3 8e 12             mov word ptr [0x128e], ax
04b6d  a1 90 12             mov ax, word ptr [0x1290]
04b70  40                   inc ax
04b71  3d 06 00             cmp ax, 6
04b74  7e 03                jle loc_4b79
04b76  b8 00 00             mov ax, 0
loc_4b79:
04b79  a3 90 12             mov word ptr [0x1290], ax
04b7c  59                   pop cx
04b7d  e2 b5                loop loc_4b34
04b7f  c3                   ret

; ======== sub_4b80   (routine probable : non appelée directement)
04b80  be 00 4b             mov si, 0x4b00
04b83  bf 00 00             mov di, 0
04b86  b9 08 00             mov cx, 8
04b89  e8 c4 01             call sub_4d50
04b8c  ba 3c 00             mov dx, 0x3c
04b8f  e8 48 00             call sub_4bda
04b92  b9 0a 00             mov cx, 0xa
04b95  c7 06 8e 12 00 00    mov word ptr [0x128e], 0
loc_4b9b:
04b9b  51                   push cx
04b9c  e8 42 00             call sub_4be1
04b9f  a1 8e 12             mov ax, word ptr [0x128e]
04ba2  86 e0                xchg al, ah
04ba4  8b f0                mov si, ax
04ba6  bf 41 96             mov di, 0x9641
04ba9  e8 73 00             call sub_4c1f
04bac  e8 4e 00             call sub_4bfd
04baf  ba 08 00             mov dx, 8
04bb2  e8 25 00             call sub_4bda
04bb5  a1 8e 12             mov ax, word ptr [0x128e]
04bb8  40                   inc ax
04bb9  3d 07 00             cmp ax, 7
04bbc  7e 03                jle loc_4bc1
04bbe  b8 06 00             mov ax, 6
loc_4bc1:
04bc1  a3 8e 12             mov word ptr [0x128e], ax
04bc4  59                   pop cx
04bc5  e2 d4                loop loc_4b9b
04bc7  ba 3c 00             mov dx, 0x3c
04bca  e8 0d 00             call sub_4bda
04bcd  c3                   ret
; ---- 12 octets non atteints (4bce-4bd9)

; ======== sub_4bda   (appelée depuis 4a3d, 4af4, 4b5b, 4b8f, 4bb2, 4bca)
04bda  e8 6e 33             call sub_7f4b
04bdd  4a                   dec dx
04bde  75 fa                jne sub_4bda
04be0  c3                   ret

; ======== sub_4be1   (appelée depuis 4a27, 4aae, 4b35, 4b9c)
04be1  b8 86 0a             mov ax, 0xa86
04be4  8e c0                mov es, ax
04be6  b8 26 1a             mov ax, 0x1a26
04be9  8e d8                mov ds, ax
04beb  bf 00 00             mov di, 0
04bee  be 00 00             mov si, 0
04bf1  b9 ff ff             mov cx, 0xffff
04bf4  e8 96 32             call sub_7e8d
04bf7  b8 00 00             mov ax, 0
04bfa  8e d8                mov ds, ax
04bfc  c3                   ret

; ======== sub_4bfd   (appelée depuis 4a37, 4aee, 4b55, 4bac)
04bfd  b8 00 a0             mov ax, 0xa000
04c00  8e c0                mov es, ax
04c02  b8 86 0a             mov ax, 0xa86
04c05  8e d8                mov ds, ax
04c07  bf 00 00             mov di, 0
04c0a  be 00 00             mov si, 0
04c0d  b9 00 7d             mov cx, 0x7d00
04c10  f3 a5                rep movsw word ptr es:[di], word ptr [si]
04c12  50                   push ax
04c13  b8 00 00             mov ax, 0
04c16  8e d8                mov ds, ax
04c18  58                   pop ax
04c19  b8 00 00             mov ax, 0
04c1c  8e d8                mov ds, ax
04c1e  c3                   ret

; ======== sub_4c1f   (appelée depuis 4a34, 4abb, 4acb, 4adb, 4aeb, 4b42, 4b52, 4ba9)
04c1f  b8 86 0a             mov ax, 0xa86
04c22  8e c0                mov es, ax
04c24  b8 23 2a             mov ax, 0x2a23
04c27  8e d8                mov ds, ax
04c29  bd 10 00             mov bp, 0x10
loc_4c2c:
04c2c  b9 08 00             mov cx, 8
loc_4c2f:
04c2f  8b 04                mov ax, word ptr [si]
04c31  3c 00                cmp al, 0
04c33  74 03                je loc_4c38
04c35  26 88 05             mov byte ptr es:[di], al
loc_4c38:
04c38  80 fc 00             cmp ah, 0
04c3b  74 04                je loc_4c41
04c3d  26 88 65 01          mov byte ptr es:[di + 1], ah
loc_4c41:
04c41  83 c6 02             add si, 2
04c44  83 c7 02             add di, 2
04c47  e2 e6                loop loc_4c2f
04c49  81 c7 30 01          add di, 0x130
04c4d  4d                   dec bp
04c4e  75 dc                jne loc_4c2c
04c50  b8 00 00             mov ax, 0
04c53  8e d8                mov ds, ax
04c55  c3                   ret

; ======== sub_4c56   (appelée depuis 4a63)
04c56  be 00 00             mov si, 0
loc_4c59:
04c59  51                   push cx
04c5a  57                   push di
04c5b  52                   push dx
04c5c  56                   push si
04c5d  b8 86 0a             mov ax, 0xa86
04c60  8e c0                mov es, ax
04c62  b8 26 1a             mov ax, 0x1a26
04c65  8e d8                mov ds, ax
04c67  bf 00 00             mov di, 0
04c6a  be 00 00             mov si, 0
04c6d  b9 ff ff             mov cx, 0xffff
04c70  e8 1a 32             call sub_7e8d
04c73  5e                   pop si
04c74  5a                   pop dx
04c75  5f                   pop di
04c76  57                   push di
04c77  52                   push dx
04c78  b8 23 2a             mov ax, 0x2a23
04c7b  8e d8                mov ds, ax
loc_4c7d:
04c7d  e8 cb 32             call sub_7f4b
04c80  4a                   dec dx
04c81  75 fa                jne loc_4c7d
04c83  bd 40 00             mov bp, 0x40
loc_4c86:
04c86  b9 10 00             mov cx, 0x10
loc_4c89:
04c89  8b 04                mov ax, word ptr [si]
04c8b  3c 00                cmp al, 0
04c8d  74 03                je loc_4c92
04c8f  26 88 05             mov byte ptr es:[di], al
loc_4c92:
04c92  80 fc 00             cmp ah, 0
04c95  74 04                je loc_4c9b
04c97  26 88 65 01          mov byte ptr es:[di + 1], ah
loc_4c9b:
04c9b  83 c6 02             add si, 2
04c9e  83 c7 02             add di, 2
04ca1  e2 e6                loop loc_4c89
04ca3  81 c7 20 01          add di, 0x120
04ca7  4d                   dec bp
04ca8  75 dc                jne loc_4c86
04caa  56                   push si
04cab  b8 00 a0             mov ax, 0xa000
04cae  8e c0                mov es, ax
04cb0  b8 86 0a             mov ax, 0xa86
04cb3  8e d8                mov ds, ax
04cb5  bf 00 00             mov di, 0
04cb8  be 00 00             mov si, 0
04cbb  b9 00 7d             mov cx, 0x7d00
04cbe  f3 a5                rep movsw word ptr es:[di], word ptr [si]
04cc0  50                   push ax
04cc1  b8 00 00             mov ax, 0
04cc4  8e d8                mov ds, ax
04cc6  58                   pop ax
04cc7  5e                   pop si
04cc8  5a                   pop dx
04cc9  5f                   pop di
04cca  59                   pop cx
04ccb  e2 8c                loop loc_4c59
04ccd  b8 00 00             mov ax, 0
04cd0  8e d8                mov ds, ax
04cd2  c3                   ret

; ======== sub_4cd3   (appelée depuis 4a85)
04cd3  be 00 00             mov si, 0
loc_4cd6:
04cd6  51                   push cx
04cd7  57                   push di
04cd8  52                   push dx
04cd9  56                   push si
04cda  b8 86 0a             mov ax, 0xa86
04cdd  8e c0                mov es, ax
04cdf  b8 26 1a             mov ax, 0x1a26
04ce2  8e d8                mov ds, ax
04ce4  bf 00 00             mov di, 0
04ce7  be 00 00             mov si, 0
04cea  b9 ff ff             mov cx, 0xffff
04ced  e8 9d 31             call sub_7e8d
04cf0  5e                   pop si
04cf1  5a                   pop dx
04cf2  5f                   pop di
04cf3  57                   push di
04cf4  52                   push dx
04cf5  b8 23 2a             mov ax, 0x2a23
04cf8  8e d8                mov ds, ax
loc_4cfa:
04cfa  e8 4e 32             call sub_7f4b
04cfd  4a                   dec dx
04cfe  75 fa                jne loc_4cfa
04d00  bd 40 00             mov bp, 0x40
loc_4d03:
04d03  b9 20 00             mov cx, 0x20
loc_4d06:
04d06  8b 04                mov ax, word ptr [si]
04d08  3c 00                cmp al, 0
04d0a  74 03                je loc_4d0f
04d0c  26 88 05             mov byte ptr es:[di], al
loc_4d0f:
04d0f  80 fc 00             cmp ah, 0
04d12  74 04                je loc_4d18
04d14  26 88 65 01          mov byte ptr es:[di + 1], ah
loc_4d18:
04d18  83 c6 02             add si, 2
04d1b  83 c7 02             add di, 2
04d1e  e2 e6                loop loc_4d06
04d20  81 c7 00 01          add di, 0x100
04d24  4d                   dec bp
04d25  75 dc                jne loc_4d03
04d27  56                   push si
04d28  b8 00 a0             mov ax, 0xa000
04d2b  8e c0                mov es, ax
04d2d  b8 86 0a             mov ax, 0xa86
04d30  8e d8                mov ds, ax
04d32  bf 00 00             mov di, 0
04d35  be 00 00             mov si, 0
04d38  b9 00 7d             mov cx, 0x7d00
04d3b  f3 a5                rep movsw word ptr es:[di], word ptr [si]
04d3d  50                   push ax
04d3e  b8 00 00             mov ax, 0
04d41  8e d8                mov ds, ax
04d43  58                   pop ax
04d44  5e                   pop si
04d45  5a                   pop dx
04d46  5f                   pop di
04d47  59                   pop cx
04d48  e2 8c                loop loc_4cd6
04d4a  b8 00 00             mov ax, 0
04d4d  8e d8                mov ds, ax
04d4f  c3                   ret

; ======== sub_4d50   (appelée depuis 4a1a, 4a9b, 4b22, 4b89)
04d50  b8 23 2a             mov ax, 0x2a23
04d53  8e c0                mov es, ax
04d55  b8 23 25             mov ax, 0x2523
04d58  8e d8                mov ds, ax
loc_4d5a:
04d5a  51                   push cx
04d5b  ba 20 00             mov dx, 0x20
loc_4d5e:
04d5e  b9 08 00             mov cx, 8
loc_4d61:
04d61  33 c0                xor ax, ax
04d63  d0 a4 80 00          shl byte ptr [si + 0x80], 1
04d67  d1 d0                rcl ax, 1
04d69  d0 64 60             shl byte ptr [si + 0x60], 1
04d6c  d1 d0                rcl ax, 1
04d6e  d0 64 40             shl byte ptr [si + 0x40], 1
04d71  d1 d0                rcl ax, 1
04d73  d0 64 20             shl byte ptr [si + 0x20], 1
04d76  d1 d0                rcl ax, 1
04d78  d0 24                shl byte ptr [si], 1
04d7a  d1 d0                rcl ax, 1
04d7c  26 88 05             mov byte ptr es:[di], al
04d7f  47                   inc di
04d80  e2 df                loop loc_4d61
04d82  46                   inc si
04d83  4a                   dec dx
04d84  75 d8                jne loc_4d5e
04d86  81 c6 80 00          add si, 0x80
04d8a  59                   pop cx
04d8b  e2 cd                loop loc_4d5a
04d8d  b8 00 00             mov ax, 0
04d90  8e d8                mov ds, ax
04d92  c3                   ret

; ======== sub_4d93   (appelée depuis 4a53)
04d93  b8 23 2a             mov ax, 0x2a23
04d96  8e c0                mov es, ax
04d98  bf 00 00             mov di, 0
04d9b  b8 23 25             mov ax, 0x2523
04d9e  8e d8                mov ds, ax
loc_4da0:
04da0  51                   push cx
04da1  ba 00 01             mov dx, 0x100
loc_4da4:
04da4  b9 08 00             mov cx, 8
loc_4da7:
04da7  33 c0                xor ax, ax
04da9  d0 a4 00 04          shl byte ptr [si + 0x400], 1
04dad  d1 d0                rcl ax, 1
04daf  d0 a4 00 03          shl byte ptr [si + 0x300], 1
04db3  d1 d0                rcl ax, 1
04db5  d0 a4 00 02          shl byte ptr [si + 0x200], 1
04db9  d1 d0                rcl ax, 1
04dbb  d0 a4 00 01          shl byte ptr [si + 0x100], 1
04dbf  d1 d0                rcl ax, 1
04dc1  d0 24                shl byte ptr [si], 1
04dc3  d1 d0                rcl ax, 1
04dc5  26 88 05             mov byte ptr es:[di], al
04dc8  47                   inc di
04dc9  e2 dc                loop loc_4da7
04dcb  46                   inc si
04dcc  4a                   dec dx
04dcd  75 d5                jne loc_4da4
04dcf  81 c6 00 04          add si, 0x400
04dd3  59                   pop cx
04dd4  e2 ca                loop loc_4da0
04dd6  b8 00 00             mov ax, 0
04dd9  8e d8                mov ds, ax
04ddb  c3                   ret

; ======== sub_4ddc   (appelée depuis 4a70)
04ddc  b8 23 2a             mov ax, 0x2a23
04ddf  8e c0                mov es, ax
04de1  bf 00 00             mov di, 0
04de4  b8 23 25             mov ax, 0x2523
04de7  8e d8                mov ds, ax
loc_4de9:
04de9  51                   push cx
04dea  ba 00 02             mov dx, 0x200
loc_4ded:
04ded  b9 08 00             mov cx, 8
loc_4df0:
04df0  33 c0                xor ax, ax
04df2  d0 a4 00 08          shl byte ptr [si + 0x800], 1
04df6  d1 d0                rcl ax, 1
04df8  d0 a4 00 06          shl byte ptr [si + 0x600], 1
04dfc  d1 d0                rcl ax, 1
04dfe  d0 a4 00 04          shl byte ptr [si + 0x400], 1
04e02  d1 d0                rcl ax, 1
04e04  d0 a4 00 02          shl byte ptr [si + 0x200], 1
04e08  d1 d0                rcl ax, 1
04e0a  d0 24                shl byte ptr [si], 1
04e0c  d1 d0                rcl ax, 1
04e0e  26 88 05             mov byte ptr es:[di], al
04e11  47                   inc di
04e12  e2 dc                loop loc_4df0
04e14  46                   inc si
04e15  4a                   dec dx
04e16  75 d5                jne loc_4ded
04e18  81 c6 00 08          add si, 0x800
04e1c  59                   pop cx
04e1d  e2 ca                loop loc_4de9
04e1f  b8 00 00             mov ax, 0
04e22  8e d8                mov ds, ax
04e24  c3                   ret

; ======== sub_4e25   (appelée depuis 4651, 476c)
04e25  bb 84 12             mov bx, 0x1284
04e28  03 1e 40 14          add bx, word ptr [0x1440]
04e2c  ff 27                jmp word ptr [bx]
loc_4e2e:
04e2e  32 e4                xor ah, ah
04e30  b0 13                mov al, 0x13
04e32  cd 10                int 0x10
04e34  c3                   ret
loc_4e35:
04e35  32 e4                xor ah, ah
04e37  b0 0d                mov al, 0xd
04e39  cd 10                int 0x10
04e3b  c3                   ret
loc_4e3c:
04e3c  32 e4                xor ah, ah
04e3e  b0 09                mov al, 9
04e40  cd 10                int 0x10
04e42  c3                   ret

; ======== sub_4e43   (appelée depuis 46a4, 4fb8, 4fe6)
04e43  e8 05 31             call sub_7f4b
04e46  8b f2                mov si, dx
04e48  ba c8 03             mov dx, 0x3c8
04e4b  32 c0                xor al, al
04e4d  ee                   out dx, al
04e4e  42                   inc dx
04e4f  b9 20 00             mov cx, 0x20
loc_4e52:
04e52  ac                   lodsb al, byte ptr [si]
04e53  ee                   out dx, al
04e54  ac                   lodsb al, byte ptr [si]
04e55  ee                   out dx, al
04e56  ac                   lodsb al, byte ptr [si]
04e57  ee                   out dx, al
04e58  e2 f8                loop loc_4e52
04e5a  c3                   ret

; ======== sub_4e5b   (appelée depuis 46db, 4724)
04e5b  55                   push bp
04e5c  e8 60 01             call sub_4fbf
04e5f  c7 06 a9 1b d1 00    mov word ptr [0x1ba9], 0xd1
04e65  c7 06 a5 1b 00 00    mov word ptr [0x1ba5], 0
04e6b  b8 26 1a             mov ax, 0x1a26
04e6e  a3 a3 1b             mov word ptr [0x1ba3], ax
04e71  e8 cd 23             call sub_7241
04e74  e8 3a 21             call sub_6fb1
04e77  bf 86 0d             mov di, 0xd86
04e7a  e8 b6 00             call sub_4f33
04e7d  50                   push ax
04e7e  b8 86 0a             mov ax, 0xa86
04e81  8e c0                mov es, ax
04e83  58                   pop ax
04e84  50                   push ax
04e85  b8 26 1a             mov ax, 0x1a26
04e88  8e d8                mov ds, ax
04e8a  58                   pop ax
04e8b  33 ff                xor di, di
04e8d  8b f7                mov si, di
04e8f  b9 ff ff             mov cx, 0xffff
04e92  e8 f8 2f             call sub_7e8d
04e95  50                   push ax
04e96  b8 00 00             mov ax, 0
04e99  8e d8                mov ds, ax
04e9b  58                   pop ax
04e9c  5d                   pop bp
04e9d  e8 9c 1b             call sub_6a3c
04ea0  50                   push ax
04ea1  b8 00 a0             mov ax, 0xa000
04ea4  8e c0                mov es, ax
04ea6  58                   pop ax
04ea7  50                   push ax
04ea8  b8 86 0a             mov ax, 0xa86
04eab  8e d8                mov ds, ax
04ead  58                   pop ax
04eae  bf 00 00             mov di, 0
04eb1  be 00 00             mov si, 0
04eb4  b9 00 7d             mov cx, 0x7d00
04eb7  f3 a5                rep movsw word ptr es:[di], word ptr [si]
04eb9  50                   push ax
04eba  b8 00 00             mov ax, 0
04ebd  8e d8                mov ds, ax
04ebf  58                   pop ax
04ec0  50                   push ax
04ec1  b8 00 00             mov ax, 0
04ec4  8e d8                mov ds, ax
04ec6  58                   pop ax
04ec7  e8 b8 00             call sub_4f82
04eca  eb 4f                jmp sub_4f1b
; ---- 1 octets non atteints (4ecc-4ecc)

; ======== sub_4ecd   (appelée depuis 46aa, 46cb, 4712)
04ecd  57                   push di
04ece  e8 ee 00             call sub_4fbf
04ed1  5f                   pop di
04ed2  e8 5e 00             call sub_4f33
04ed5  e8 d9 20             call sub_6fb1
04ed8  50                   push ax
04ed9  b8 86 0a             mov ax, 0xa86
04edc  8e c0                mov es, ax
04ede  58                   pop ax
04edf  50                   push ax
04ee0  b8 26 1a             mov ax, 0x1a26
04ee3  8e d8                mov ds, ax
04ee5  58                   pop ax
04ee6  33 ff                xor di, di
04ee8  8b f7                mov si, di
04eea  b9 ff ff             mov cx, 0xffff
04eed  e8 9d 2f             call sub_7e8d
04ef0  50                   push ax
04ef1  b8 00 a0             mov ax, 0xa000
04ef4  8e c0                mov es, ax
04ef6  58                   pop ax
04ef7  50                   push ax
04ef8  b8 86 0a             mov ax, 0xa86
04efb  8e d8                mov ds, ax
04efd  58                   pop ax
04efe  bf 00 00             mov di, 0
04f01  be 00 00             mov si, 0
04f04  b9 00 7d             mov cx, 0x7d00
04f07  f3 a5                rep movsw word ptr es:[di], word ptr [si]
04f09  50                   push ax
04f0a  b8 00 00             mov ax, 0
04f0d  8e d8                mov ds, ax
04f0f  58                   pop ax
04f10  50                   push ax
04f11  b8 00 00             mov ax, 0
04f14  8e d8                mov ds, ax
04f16  58                   pop ax
04f17  e8 68 00             call sub_4f82
04f1a  c3                   ret

; ======== sub_4f1b   (appelée depuis 46ce)
04f1b  b4 01                mov ah, 1
04f1d  cd 16                int 0x16
loc_4f1f:
04f1f  32 e4                xor ah, ah
04f21  cd 16                int 0x16
04f23  80 fc 01             cmp ah, 1
04f26  75 03                jne loc_4f2b
04f28  b0 01                mov al, 1
04f2a  c3                   ret
loc_4f2b:
04f2b  80 fc 39             cmp ah, 0x39
04f2e  75 ef                jne loc_4f1f
04f30  32 c0                xor al, al
04f32  c3                   ret

; ======== sub_4f33   (appelée depuis 4e7a, 4ed2)
04f33  be a4 10             mov si, 0x10a4
04f36  b9 20 00             mov cx, 0x20
loc_4f39:
04f39  8a 25                mov ah, byte ptr [di]
04f3b  b0 00                mov al, 0
04f3d  d1 e8                shr ax, 1
04f3f  d1 e8                shr ax, 1
04f41  d1 e8                shr ax, 1
04f43  d1 e8                shr ax, 1
04f45  d1 e8                shr ax, 1
04f47  d1 e8                shr ax, 1
04f49  d1 e8                shr ax, 1
04f4b  89 04                mov word ptr [si], ax
04f4d  8a 65 01             mov ah, byte ptr [di + 1]
04f50  b0 00                mov al, 0
04f52  d1 e8                shr ax, 1
04f54  d1 e8                shr ax, 1
04f56  d1 e8                shr ax, 1
04f58  d1 e8                shr ax, 1
04f5a  d1 e8                shr ax, 1
04f5c  d1 e8                shr ax, 1
04f5e  d1 e8                shr ax, 1
04f60  89 44 02             mov word ptr [si + 2], ax
04f63  8a 65 02             mov ah, byte ptr [di + 2]
04f66  b0 00                mov al, 0
04f68  d1 e8                shr ax, 1
04f6a  d1 e8                shr ax, 1
04f6c  d1 e8                shr ax, 1
04f6e  d1 e8                shr ax, 1
04f70  d1 e8                shr ax, 1
04f72  d1 e8                shr ax, 1
04f74  d1 e8                shr ax, 1
04f76  89 44 04             mov word ptr [si + 4], ax
04f79  83 c7 03             add di, 3
04f7c  83 c6 06             add si, 6
04f7f  e2 b8                loop loc_4f39
04f81  c3                   ret

; ======== sub_4f82   (appelée depuis 4ec7, 4f17)
04f82  bf 64 11             mov di, 0x1164
04f85  8c d8                mov ax, ds
04f87  8e c0                mov es, ax
04f89  b8 00 00             mov ax, 0
04f8c  b9 60 00             mov cx, 0x60
04f8f  f3 ab                rep stosw word ptr es:[di], ax
04f91  b9 80 00             mov cx, 0x80
loc_4f94:
04f94  51                   push cx
04f95  b9 60 00             mov cx, 0x60
04f98  be 64 11             mov si, 0x1164
04f9b  bf 24 12             mov di, 0x1224
04f9e  bb a4 10             mov bx, 0x10a4
loc_4fa1:
04fa1  8b 04                mov ax, word ptr [si]
04fa3  03 07                add ax, word ptr [bx]
04fa5  89 04                mov word ptr [si], ax
04fa7  88 25                mov byte ptr [di], ah
04fa9  83 c6 02             add si, 2
04fac  83 c3 02             add bx, 2
04faf  47                   inc di
04fb0  e2 ef                loop loc_4fa1
04fb2  e8 96 2f             call sub_7f4b
04fb5  ba 24 12             mov dx, 0x1224
04fb8  e8 88 fe             call sub_4e43
04fbb  59                   pop cx
04fbc  e2 d6                loop loc_4f94
04fbe  c3                   ret

; ======== sub_4fbf   (appelée depuis 4736, 4e5c, 4ece)
04fbf  b9 80 00             mov cx, 0x80
loc_4fc2:
04fc2  51                   push cx
04fc3  b9 60 00             mov cx, 0x60
04fc6  be 64 11             mov si, 0x1164
04fc9  bf 24 12             mov di, 0x1224
04fcc  bb a4 10             mov bx, 0x10a4
loc_4fcf:
04fcf  8b 04                mov ax, word ptr [si]
04fd1  2b 07                sub ax, word ptr [bx]
04fd3  89 04                mov word ptr [si], ax
04fd5  88 25                mov byte ptr [di], ah
04fd7  83 c6 02             add si, 2
04fda  83 c3 02             add bx, 2
04fdd  47                   inc di
04fde  e2 ef                loop loc_4fcf
04fe0  e8 68 2f             call sub_7f4b
04fe3  ba 24 12             mov dx, 0x1224
04fe6  e8 5a fe             call sub_4e43
04fe9  59                   pop cx
04fea  e2 d6                loop loc_4fc2
04fec  c3                   ret

; ======== sub_4fed   (appelée depuis 47b6)
04fed  50                   push ax
04fee  b8 00 b8             mov ax, 0xb800
04ff1  8e c0                mov es, ax
04ff3  58                   pop ax
04ff4  50                   push ax
04ff5  b8 86 0a             mov ax, 0xa86
04ff8  8e d8                mov ds, ax
04ffa  58                   pop ax
04ffb  be 00 00             mov si, 0
04ffe  bf 00 00             mov di, 0
05001  2e c7 06 ef 23 c8 00 mov word ptr cs:[0x23ef], 0xc8
loc_5008:
05008  8a 64 78             mov ah, byte ptr [si + 0x78]
0500b  8a 44 79             mov al, byte ptr [si + 0x79]
0500e  8b e8                mov bp, ax
05010  8a 7c 50             mov bh, byte ptr [si + 0x50]
05013  8a 5c 51             mov bl, byte ptr [si + 0x51]
05016  8a 6c 28             mov ch, byte ptr [si + 0x28]
05019  8a 4c 29             mov cl, byte ptr [si + 0x29]
0501c  8a 34                mov dh, byte ptr [si]
0501e  8a 54 01             mov dl, byte ptr [si + 1]
05021  b8 00 00             mov ax, 0
05024  d1 e2                shl dx, 1
05026  d1 d0                rcl ax, 1
05028  d1 e1                shl cx, 1
0502a  d1 d0                rcl ax, 1
0502c  d1 e3                shl bx, 1
0502e  d1 d0                rcl ax, 1
05030  d1 e5                shl bp, 1
05032  d1 d0                rcl ax, 1
05034  d1 e2                shl dx, 1
05036  d1 d0                rcl ax, 1
05038  d1 e1                shl cx, 1
0503a  d1 d0                rcl ax, 1
0503c  d1 e3                shl bx, 1
0503e  d1 d0                rcl ax, 1
05040  d1 e5                shl bp, 1
05042  d1 d0                rcl ax, 1
05044  d1 e2                shl dx, 1
05046  d1 d0                rcl ax, 1
05048  d1 e1                shl cx, 1
0504a  d1 d0                rcl ax, 1
0504c  d1 e3                shl bx, 1
0504e  d1 d0                rcl ax, 1
05050  d1 e5                shl bp, 1
05052  d1 d0                rcl ax, 1
05054  d1 e2                shl dx, 1
05056  d1 d0                rcl ax, 1
05058  d1 e1                shl cx, 1
0505a  d1 d0                rcl ax, 1
0505c  d1 e3                shl bx, 1
0505e  d1 d0                rcl ax, 1
05060  d1 e5                shl bp, 1
05062  d1 d0                rcl ax, 1
05064  86 e0                xchg al, ah
05066  26 89 05             mov word ptr es:[di], ax
05069  d1 e2                shl dx, 1
0506b  d1 d0                rcl ax, 1
0506d  d1 e1                shl cx, 1
0506f  d1 d0                rcl ax, 1
05071  d1 e3                shl bx, 1
05073  d1 d0                rcl ax, 1
05075  d1 e5                shl bp, 1
05077  d1 d0                rcl ax, 1
05079  d1 e2                shl dx, 1
0507b  d1 d0                rcl ax, 1
0507d  d1 e1                shl cx, 1
0507f  d1 d0                rcl ax, 1
05081  d1 e3                shl bx, 1
05083  d1 d0                rcl ax, 1
05085  d1 e5                shl bp, 1
05087  d1 d0                rcl ax, 1
05089  d1 e2                shl dx, 1
0508b  d1 d0                rcl ax, 1
0508d  d1 e1                shl cx, 1
0508f  d1 d0                rcl ax, 1
05091  d1 e3                shl bx, 1
05093  d1 d0                rcl ax, 1
05095  d1 e5                shl bp, 1
05097  d1 d0                rcl ax, 1
05099  d1 e2                shl dx, 1
0509b  d1 d0                rcl ax, 1
0509d  d1 e1                shl cx, 1
0509f  d1 d0                rcl ax, 1
050a1  d1 e3                shl bx, 1
050a3  d1 d0                rcl ax, 1
050a5  d1 e5                shl bp, 1
050a7  d1 d0                rcl ax, 1
050a9  86 e0                xchg al, ah
050ab  26 89 45 02          mov word ptr es:[di + 2], ax
050af  d1 e2                shl dx, 1
050b1  d1 d0                rcl ax, 1
050b3  d1 e1                shl cx, 1
050b5  d1 d0                rcl ax, 1
050b7  d1 e3                shl bx, 1
050b9  d1 d0                rcl ax, 1
050bb  d1 e5                shl bp, 1
050bd  d1 d0                rcl ax, 1
050bf  d1 e2                shl dx, 1
050c1  d1 d0                rcl ax, 1
050c3  d1 e1                shl cx, 1
050c5  d1 d0                rcl ax, 1
050c7  d1 e3                shl bx, 1
050c9  d1 d0                rcl ax, 1
050cb  d1 e5                shl bp, 1
050cd  d1 d0                rcl ax, 1
050cf  d1 e2                shl dx, 1
050d1  d1 d0                rcl ax, 1
050d3  d1 e1                shl cx, 1
050d5  d1 d0                rcl ax, 1
050d7  d1 e3                shl bx, 1
050d9  d1 d0                rcl ax, 1
050db  d1 e5                shl bp, 1
050dd  d1 d0                rcl ax, 1
050df  d1 e2                shl dx, 1
050e1  d1 d0                rcl ax, 1
050e3  d1 e1                shl cx, 1
050e5  d1 d0                rcl ax, 1
050e7  d1 e3                shl bx, 1
050e9  d1 d0                rcl ax, 1
050eb  d1 e5                shl bp, 1
050ed  d1 d0                rcl ax, 1
050ef  86 e0                xchg al, ah
050f1  26 89 45 04          mov word ptr es:[di + 4], ax
050f5  d1 e2                shl dx, 1
050f7  d1 d0                rcl ax, 1
050f9  d1 e1                shl cx, 1
050fb  d1 d0                rcl ax, 1
050fd  d1 e3                shl bx, 1
050ff  d1 d0                rcl ax, 1
05101  d1 e5                shl bp, 1
05103  d1 d0                rcl ax, 1
05105  d1 e2                shl dx, 1
05107  d1 d0                rcl ax, 1
05109  d1 e1                shl cx, 1
0510b  d1 d0                rcl ax, 1
0510d  d1 e3                shl bx, 1
0510f  d1 d0                rcl ax, 1
05111  d1 e5                shl bp, 1
05113  d1 d0                rcl ax, 1
05115  d1 e2                shl dx, 1
05117  d1 d0                rcl ax, 1
05119  d1 e1                shl cx, 1
0511b  d1 d0                rcl ax, 1
0511d  d1 e3                shl bx, 1
0511f  d1 d0                rcl ax, 1
05121  d1 e5                shl bp, 1
05123  d1 d0                rcl ax, 1
05125  d1 e2                shl dx, 1
05127  d1 d0                rcl ax, 1
05129  d1 e1                shl cx, 1
0512b  d1 d0                rcl ax, 1
0512d  d1 e3                shl bx, 1
0512f  d1 d0                rcl ax, 1
05131  d1 e5                shl bp, 1
05133  d1 d0                rcl ax, 1
05135  86 e0                xchg al, ah
05137  26 89 45 06          mov word ptr es:[di + 6], ax
0513b  83 c6 02             add si, 2
0513e  83 c7 08             add di, 8
05141  8a 64 78             mov ah, byte ptr [si + 0x78]
05144  8a 44 79             mov al, byte ptr [si + 0x79]
05147  8b e8                mov bp, ax
05149  8a 7c 50             mov bh, byte ptr [si + 0x50]
0514c  8a 5c 51             mov bl, byte ptr [si + 0x51]
0514f  8a 6c 28             mov ch, byte ptr [si + 0x28]
05152  8a 4c 29             mov cl, byte ptr [si + 0x29]
05155  8a 34                mov dh, byte ptr [si]
05157  8a 54 01             mov dl, byte ptr [si + 1]
0515a  b8 00 00             mov ax, 0
0515d  d1 e2                shl dx, 1
0515f  d1 d0                rcl ax, 1
05161  d1 e1                shl cx, 1
05163  d1 d0                rcl ax, 1
05165  d1 e3                shl bx, 1
05167  d1 d0                rcl ax, 1
05169  d1 e5                shl bp, 1
0516b  d1 d0                rcl ax, 1
0516d  d1 e2                shl dx, 1
0516f  d1 d0                rcl ax, 1
05171  d1 e1                shl cx, 1
05173  d1 d0                rcl ax, 1
05175  d1 e3                shl bx, 1
05177  d1 d0                rcl ax, 1
05179  d1 e5                shl bp, 1
0517b  d1 d0                rcl ax, 1
0517d  d1 e2                shl dx, 1
0517f  d1 d0                rcl ax, 1
05181  d1 e1                shl cx, 1
05183  d1 d0                rcl ax, 1
05185  d1 e3                shl bx, 1
05187  d1 d0                rcl ax, 1
05189  d1 e5                shl bp, 1
0518b  d1 d0                rcl ax, 1
0518d  d1 e2                shl dx, 1
0518f  d1 d0                rcl ax, 1
05191  d1 e1                shl cx, 1
05193  d1 d0                rcl ax, 1
05195  d1 e3                shl bx, 1
05197  d1 d0                rcl ax, 1
05199  d1 e5                shl bp, 1
0519b  d1 d0                rcl ax, 1
0519d  86 e0                xchg al, ah
0519f  26 89 05             mov word ptr es:[di], ax
051a2  d1 e2                shl dx, 1
051a4  d1 d0                rcl ax, 1
051a6  d1 e1                shl cx, 1
051a8  d1 d0                rcl ax, 1
051aa  d1 e3                shl bx, 1
051ac  d1 d0                rcl ax, 1
051ae  d1 e5                shl bp, 1
051b0  d1 d0                rcl ax, 1
051b2  d1 e2                shl dx, 1
051b4  d1 d0                rcl ax, 1
051b6  d1 e1                shl cx, 1
051b8  d1 d0                rcl ax, 1
051ba  d1 e3                shl bx, 1
051bc  d1 d0                rcl ax, 1
051be  d1 e5                shl bp, 1
051c0  d1 d0                rcl ax, 1
051c2  d1 e2                shl dx, 1
051c4  d1 d0                rcl ax, 1
051c6  d1 e1                shl cx, 1
051c8  d1 d0                rcl ax, 1
051ca  d1 e3                shl bx, 1
051cc  d1 d0                rcl ax, 1
051ce  d1 e5                shl bp, 1
051d0  d1 d0                rcl ax, 1
051d2  d1 e2                shl dx, 1
051d4  d1 d0                rcl ax, 1
051d6  d1 e1                shl cx, 1
051d8  d1 d0                rcl ax, 1
051da  d1 e3                shl bx, 1
051dc  d1 d0                rcl ax, 1
051de  d1 e5                shl bp, 1
051e0  d1 d0                rcl ax, 1
051e2  86 e0                xchg al, ah
051e4  26 89 45 02          mov word ptr es:[di + 2], ax
051e8  d1 e2                shl dx, 1
051ea  d1 d0                rcl ax, 1
051ec  d1 e1                shl cx, 1
051ee  d1 d0                rcl ax, 1
051f0  d1 e3                shl bx, 1
051f2  d1 d0                rcl ax, 1
051f4  d1 e5                shl bp, 1
051f6  d1 d0                rcl ax, 1
051f8  d1 e2                shl dx, 1
051fa  d1 d0                rcl ax, 1
051fc  d1 e1                shl cx, 1
051fe  d1 d0                rcl ax, 1
05200  d1 e3                shl bx, 1
05202  d1 d0                rcl ax, 1
05204  d1 e5                shl bp, 1
05206  d1 d0                rcl ax, 1
05208  d1 e2                shl dx, 1
0520a  d1 d0                rcl ax, 1
0520c  d1 e1                shl cx, 1
0520e  d1 d0                rcl ax, 1
05210  d1 e3                shl bx, 1
05212  d1 d0                rcl ax, 1
05214  d1 e5                shl bp, 1
05216  d1 d0                rcl ax, 1
05218  d1 e2                shl dx, 1
0521a  d1 d0                rcl ax, 1
0521c  d1 e1                shl cx, 1
0521e  d1 d0                rcl ax, 1
05220  d1 e3                shl bx, 1
05222  d1 d0                rcl ax, 1
05224  d1 e5                shl bp, 1
05226  d1 d0                rcl ax, 1
05228  86 e0                xchg al, ah
0522a  26 89 45 04          mov word ptr es:[di + 4], ax
0522e  d1 e2                shl dx, 1
05230  d1 d0                rcl ax, 1
05232  d1 e1                shl cx, 1
05234  d1 d0                rcl ax, 1
05236  d1 e3                shl bx, 1
05238  d1 d0                rcl ax, 1
0523a  d1 e5                shl bp, 1
0523c  d1 d0                rcl ax, 1
0523e  d1 e2                shl dx, 1
05240  d1 d0                rcl ax, 1
05242  d1 e1                shl cx, 1
05244  d1 d0                rcl ax, 1
05246  d1 e3                shl bx, 1
05248  d1 d0                rcl ax, 1
0524a  d1 e5                shl bp, 1
0524c  d1 d0                rcl ax, 1
0524e  d1 e2                shl dx, 1
05250  d1 d0                rcl ax, 1
05252  d1 e1                shl cx, 1
05254  d1 d0                rcl ax, 1
05256  d1 e3                shl bx, 1
05258  d1 d0                rcl ax, 1
0525a  d1 e5                shl bp, 1
0525c  d1 d0                rcl ax, 1
0525e  d1 e2                shl dx, 1
05260  d1 d0                rcl ax, 1
05262  d1 e1                shl cx, 1
05264  d1 d0                rcl ax, 1
05266  d1 e3                shl bx, 1
05268  d1 d0                rcl ax, 1
0526a  d1 e5                shl bp, 1
0526c  d1 d0                rcl ax, 1
0526e  86 e0                xchg al, ah
05270  26 89 45 06          mov word ptr es:[di + 6], ax
05274  83 c6 02             add si, 2
05277  83 c7 08             add di, 8
0527a  8a 64 78             mov ah, byte ptr [si + 0x78]
0527d  8a 44 79             mov al, byte ptr [si + 0x79]
05280  8b e8                mov bp, ax
05282  8a 7c 50             mov bh, byte ptr [si + 0x50]
05285  8a 5c 51             mov bl, byte ptr [si + 0x51]
05288  8a 6c 28             mov ch, byte ptr [si + 0x28]
0528b  8a 4c 29             mov cl, byte ptr [si + 0x29]
0528e  8a 34                mov dh, byte ptr [si]
05290  8a 54 01             mov dl, byte ptr [si + 1]
05293  b8 00 00             mov ax, 0
05296  d1 e2                shl dx, 1
05298  d1 d0                rcl ax, 1
0529a  d1 e1                shl cx, 1
0529c  d1 d0                rcl ax, 1
0529e  d1 e3                shl bx, 1
052a0  d1 d0                rcl ax, 1
052a2  d1 e5                shl bp, 1
052a4  d1 d0                rcl ax, 1
052a6  d1 e2                shl dx, 1
052a8  d1 d0                rcl ax, 1
052aa  d1 e1                shl cx, 1
052ac  d1 d0                rcl ax, 1
052ae  d1 e3                shl bx, 1
052b0  d1 d0                rcl ax, 1
052b2  d1 e5                shl bp, 1
052b4  d1 d0                rcl ax, 1
052b6  d1 e2                shl dx, 1
052b8  d1 d0                rcl ax, 1
052ba  d1 e1                shl cx, 1
052bc  d1 d0                rcl ax, 1
052be  d1 e3                shl bx, 1
052c0  d1 d0                rcl ax, 1
052c2  d1 e5                shl bp, 1
052c4  d1 d0                rcl ax, 1
052c6  d1 e2                shl dx, 1
052c8  d1 d0                rcl ax, 1
052ca  d1 e1                shl cx, 1
052cc  d1 d0                rcl ax, 1
052ce  d1 e3                shl bx, 1
052d0  d1 d0                rcl ax, 1
052d2  d1 e5                shl bp, 1
052d4  d1 d0                rcl ax, 1
052d6  86 e0                xchg al, ah
052d8  26 89 05             mov word ptr es:[di], ax
052db  d1 e2                shl dx, 1
052dd  d1 d0                rcl ax, 1
052df  d1 e1                shl cx, 1
052e1  d1 d0                rcl ax, 1
052e3  d1 e3                shl bx, 1
052e5  d1 d0                rcl ax, 1
052e7  d1 e5                shl bp, 1
052e9  d1 d0                rcl ax, 1
052eb  d1 e2                shl dx, 1
052ed  d1 d0                rcl ax, 1
052ef  d1 e1                shl cx, 1
052f1  d1 d0                rcl ax, 1
052f3  d1 e3                shl bx, 1
052f5  d1 d0                rcl ax, 1
052f7  d1 e5                shl bp, 1
052f9  d1 d0                rcl ax, 1
052fb  d1 e2                shl dx, 1
052fd  d1 d0                rcl ax, 1
052ff  d1 e1                shl cx, 1
05301  d1 d0                rcl ax, 1
05303  d1 e3                shl bx, 1
05305  d1 d0                rcl ax, 1
05307  d1 e5                shl bp, 1
05309  d1 d0                rcl ax, 1
0530b  d1 e2                shl dx, 1
0530d  d1 d0                rcl ax, 1
0530f  d1 e1                shl cx, 1
05311  d1 d0                rcl ax, 1
05313  d1 e3                shl bx, 1
05315  d1 d0                rcl ax, 1
05317  d1 e5                shl bp, 1
05319  d1 d0                rcl ax, 1
0531b  86 e0                xchg al, ah
0531d  26 89 45 02          mov word ptr es:[di + 2], ax
05321  d1 e2                shl dx, 1
05323  d1 d0                rcl ax, 1
05325  d1 e1                shl cx, 1
05327  d1 d0                rcl ax, 1
05329  d1 e3                shl bx, 1
0532b  d1 d0                rcl ax, 1
0532d  d1 e5                shl bp, 1
0532f  d1 d0                rcl ax, 1
05331  d1 e2                shl dx, 1
05333  d1 d0                rcl ax, 1
05335  d1 e1                shl cx, 1
05337  d1 d0                rcl ax, 1
05339  d1 e3                shl bx, 1
0533b  d1 d0                rcl ax, 1
0533d  d1 e5                shl bp, 1
0533f  d1 d0                rcl ax, 1
05341  d1 e2                shl dx, 1
05343  d1 d0                rcl ax, 1
05345  d1 e1                shl cx, 1
05347  d1 d0                rcl ax, 1
05349  d1 e3                shl bx, 1
0534b  d1 d0                rcl ax, 1
0534d  d1 e5                shl bp, 1
0534f  d1 d0                rcl ax, 1
05351  d1 e2                shl dx, 1
05353  d1 d0                rcl ax, 1
05355  d1 e1                shl cx, 1
05357  d1 d0                rcl ax, 1
05359  d1 e3                shl bx, 1
0535b  d1 d0                rcl ax, 1
0535d  d1 e5                shl bp, 1
0535f  d1 d0                rcl ax, 1
05361  86 e0                xchg al, ah
05363  26 89 45 04          mov word ptr es:[di + 4], ax
05367  d1 e2                shl dx, 1
05369  d1 d0                rcl ax, 1
0536b  d1 e1                shl cx, 1
0536d  d1 d0                rcl ax, 1
0536f  d1 e3                shl bx, 1
05371  d1 d0                rcl ax, 1
05373  d1 e5                shl bp, 1
05375  d1 d0                rcl ax, 1
05377  d1 e2                shl dx, 1
05379  d1 d0                rcl ax, 1
0537b  d1 e1                shl cx, 1
0537d  d1 d0                rcl ax, 1
0537f  d1 e3                shl bx, 1
05381  d1 d0                rcl ax, 1
05383  d1 e5                shl bp, 1
05385  d1 d0                rcl ax, 1
05387  d1 e2                shl dx, 1
05389  d1 d0                rcl ax, 1
0538b  d1 e1                shl cx, 1
0538d  d1 d0                rcl ax, 1
0538f  d1 e3                shl bx, 1
05391  d1 d0                rcl ax, 1
05393  d1 e5                shl bp, 1
05395  d1 d0                rcl ax, 1
05397  d1 e2                shl dx, 1
05399  d1 d0                rcl ax, 1
0539b  d1 e1                shl cx, 1
0539d  d1 d0                rcl ax, 1
0539f  d1 e3                shl bx, 1
053a1  d1 d0                rcl ax, 1
053a3  d1 e5                shl bp, 1
053a5  d1 d0                rcl ax, 1
053a7  86 e0                xchg al, ah
053a9  26 89 45 06          mov word ptr es:[di + 6], ax
053ad  83 c6 02             add si, 2
053b0  83 c7 08             add di, 8
053b3  8a 64 78             mov ah, byte ptr [si + 0x78]
053b6  8a 44 79             mov al, byte ptr [si + 0x79]
053b9  8b e8                mov bp, ax
053bb  8a 7c 50             mov bh, byte ptr [si + 0x50]
053be  8a 5c 51             mov bl, byte ptr [si + 0x51]
053c1  8a 6c 28             mov ch, byte ptr [si + 0x28]
053c4  8a 4c 29             mov cl, byte ptr [si + 0x29]
053c7  8a 34                mov dh, byte ptr [si]
053c9  8a 54 01             mov dl, byte ptr [si + 1]
053cc  b8 00 00             mov ax, 0
053cf  d1 e2                shl dx, 1
053d1  d1 d0                rcl ax, 1
053d3  d1 e1                shl cx, 1
053d5  d1 d0                rcl ax, 1
053d7  d1 e3                shl bx, 1
053d9  d1 d0                rcl ax, 1
053db  d1 e5                shl bp, 1
053dd  d1 d0                rcl ax, 1
053df  d1 e2                shl dx, 1
053e1  d1 d0                rcl ax, 1
053e3  d1 e1                shl cx, 1
053e5  d1 d0                rcl ax, 1
053e7  d1 e3                shl bx, 1
053e9  d1 d0                rcl ax, 1
053eb  d1 e5                shl bp, 1
053ed  d1 d0                rcl ax, 1
053ef  d1 e2                shl dx, 1
053f1  d1 d0                rcl ax, 1
053f3  d1 e1                shl cx, 1
053f5  d1 d0                rcl ax, 1
053f7  d1 e3                shl bx, 1
053f9  d1 d0                rcl ax, 1
053fb  d1 e5                shl bp, 1
053fd  d1 d0                rcl ax, 1
053ff  d1 e2                shl dx, 1
05401  d1 d0                rcl ax, 1
05403  d1 e1                shl cx, 1
05405  d1 d0                rcl ax, 1
05407  d1 e3                shl bx, 1
05409  d1 d0                rcl ax, 1
0540b  d1 e5                shl bp, 1
0540d  d1 d0                rcl ax, 1
0540f  86 e0                xchg al, ah
05411  26 89 05             mov word ptr es:[di], ax
05414  d1 e2                shl dx, 1
05416  d1 d0                rcl ax, 1
05418  d1 e1                shl cx, 1
0541a  d1 d0                rcl ax, 1
0541c  d1 e3                shl bx, 1
0541e  d1 d0                rcl ax, 1
05420  d1 e5                shl bp, 1
05422  d1 d0                rcl ax, 1
05424  d1 e2                shl dx, 1
05426  d1 d0                rcl ax, 1
05428  d1 e1                shl cx, 1
0542a  d1 d0                rcl ax, 1
0542c  d1 e3                shl bx, 1
0542e  d1 d0                rcl ax, 1
05430  d1 e5                shl bp, 1
05432  d1 d0                rcl ax, 1
05434  d1 e2                shl dx, 1
05436  d1 d0                rcl ax, 1
05438  d1 e1                shl cx, 1
0543a  d1 d0                rcl ax, 1
0543c  d1 e3                shl bx, 1
0543e  d1 d0                rcl ax, 1
05440  d1 e5                shl bp, 1
05442  d1 d0                rcl ax, 1
05444  d1 e2                shl dx, 1
05446  d1 d0                rcl ax, 1
05448  d1 e1                shl cx, 1
0544a  d1 d0                rcl ax, 1
0544c  d1 e3                shl bx, 1
0544e  d1 d0                rcl ax, 1
05450  d1 e5                shl bp, 1
05452  d1 d0                rcl ax, 1
05454  86 e0                xchg al, ah
05456  26 89 45 02          mov word ptr es:[di + 2], ax
0545a  d1 e2                shl dx, 1
0545c  d1 d0                rcl ax, 1
0545e  d1 e1                shl cx, 1
05460  d1 d0                rcl ax, 1
05462  d1 e3                shl bx, 1
05464  d1 d0                rcl ax, 1
05466  d1 e5                shl bp, 1
05468  d1 d0                rcl ax, 1
0546a  d1 e2                shl dx, 1
0546c  d1 d0                rcl ax, 1
0546e  d1 e1                shl cx, 1
05470  d1 d0                rcl ax, 1
05472  d1 e3                shl bx, 1
05474  d1 d0                rcl ax, 1
05476  d1 e5                shl bp, 1
05478  d1 d0                rcl ax, 1
0547a  d1 e2                shl dx, 1
0547c  d1 d0                rcl ax, 1
0547e  d1 e1                shl cx, 1
05480  d1 d0                rcl ax, 1
05482  d1 e3                shl bx, 1
05484  d1 d0                rcl ax, 1
05486  d1 e5                shl bp, 1
05488  d1 d0                rcl ax, 1
0548a  d1 e2                shl dx, 1
0548c  d1 d0                rcl ax, 1
0548e  d1 e1                shl cx, 1
05490  d1 d0                rcl ax, 1
05492  d1 e3                shl bx, 1
05494  d1 d0                rcl ax, 1
05496  d1 e5                shl bp, 1
05498  d1 d0                rcl ax, 1
0549a  86 e0                xchg al, ah
0549c  26 89 45 04          mov word ptr es:[di + 4], ax
054a0  d1 e2                shl dx, 1
054a2  d1 d0                rcl ax, 1
054a4  d1 e1                shl cx, 1
054a6  d1 d0                rcl ax, 1
054a8  d1 e3                shl bx, 1
054aa  d1 d0                rcl ax, 1
054ac  d1 e5                shl bp, 1
054ae  d1 d0                rcl ax, 1
054b0  d1 e2                shl dx, 1
054b2  d1 d0                rcl ax, 1
054b4  d1 e1                shl cx, 1
054b6  d1 d0                rcl ax, 1
054b8  d1 e3                shl bx, 1
054ba  d1 d0                rcl ax, 1
054bc  d1 e5                shl bp, 1
054be  d1 d0                rcl ax, 1
054c0  d1 e2                shl dx, 1
054c2  d1 d0                rcl ax, 1
054c4  d1 e1                shl cx, 1
054c6  d1 d0                rcl ax, 1
054c8  d1 e3                shl bx, 1
054ca  d1 d0                rcl ax, 1
054cc  d1 e5                shl bp, 1
054ce  d1 d0                rcl ax, 1
054d0  d1 e2                shl dx, 1
054d2  d1 d0                rcl ax, 1
054d4  d1 e1                shl cx, 1
054d6  d1 d0                rcl ax, 1
054d8  d1 e3                shl bx, 1
054da  d1 d0                rcl ax, 1
054dc  d1 e5                shl bp, 1
054de  d1 d0                rcl ax, 1
054e0  86 e0                xchg al, ah
054e2  26 89 45 06          mov word ptr es:[di + 6], ax
054e6  83 c6 02             add si, 2
054e9  83 c7 08             add di, 8
054ec  8a 64 78             mov ah, byte ptr [si + 0x78]
054ef  8a 44 79             mov al, byte ptr [si + 0x79]
054f2  8b e8                mov bp, ax
054f4  8a 7c 50             mov bh, byte ptr [si + 0x50]
054f7  8a 5c 51             mov bl, byte ptr [si + 0x51]
054fa  8a 6c 28             mov ch, byte ptr [si + 0x28]
054fd  8a 4c 29             mov cl, byte ptr [si + 0x29]
05500  8a 34                mov dh, byte ptr [si]
05502  8a 54 01             mov dl, byte ptr [si + 1]
05505  b8 00 00             mov ax, 0
05508  d1 e2                shl dx, 1
0550a  d1 d0                rcl ax, 1
0550c  d1 e1                shl cx, 1
0550e  d1 d0                rcl ax, 1
05510  d1 e3                shl bx, 1
05512  d1 d0                rcl ax, 1
05514  d1 e5                shl bp, 1
05516  d1 d0                rcl ax, 1
05518  d1 e2                shl dx, 1
0551a  d1 d0                rcl ax, 1
0551c  d1 e1                shl cx, 1
0551e  d1 d0                rcl ax, 1
05520  d1 e3                shl bx, 1
05522  d1 d0                rcl ax, 1
05524  d1 e5                shl bp, 1
05526  d1 d0                rcl ax, 1
05528  d1 e2                shl dx, 1
0552a  d1 d0                rcl ax, 1
0552c  d1 e1                shl cx, 1
0552e  d1 d0                rcl ax, 1
05530  d1 e3                shl bx, 1
05532  d1 d0                rcl ax, 1
05534  d1 e5                shl bp, 1
05536  d1 d0                rcl ax, 1
05538  d1 e2                shl dx, 1
0553a  d1 d0                rcl ax, 1
0553c  d1 e1                shl cx, 1
0553e  d1 d0                rcl ax, 1
05540  d1 e3                shl bx, 1
05542  d1 d0                rcl ax, 1
05544  d1 e5                shl bp, 1
05546  d1 d0                rcl ax, 1
05548  86 e0                xchg al, ah
0554a  26 89 05             mov word ptr es:[di], ax
0554d  d1 e2                shl dx, 1
0554f  d1 d0                rcl ax, 1
05551  d1 e1                shl cx, 1
05553  d1 d0                rcl ax, 1
05555  d1 e3                shl bx, 1
05557  d1 d0                rcl ax, 1
05559  d1 e5                shl bp, 1
0555b  d1 d0                rcl ax, 1
0555d  d1 e2                shl dx, 1
0555f  d1 d0                rcl ax, 1
05561  d1 e1                shl cx, 1
05563  d1 d0                rcl ax, 1
05565  d1 e3                shl bx, 1
05567  d1 d0                rcl ax, 1
05569  d1 e5                shl bp, 1
0556b  d1 d0                rcl ax, 1
0556d  d1 e2                shl dx, 1
0556f  d1 d0                rcl ax, 1
05571  d1 e1                shl cx, 1
05573  d1 d0                rcl ax, 1
05575  d1 e3                shl bx, 1
05577  d1 d0                rcl ax, 1
05579  d1 e5                shl bp, 1
0557b  d1 d0                rcl ax, 1
0557d  d1 e2                shl dx, 1
0557f  d1 d0                rcl ax, 1
05581  d1 e1                shl cx, 1
05583  d1 d0                rcl ax, 1
05585  d1 e3                shl bx, 1
05587  d1 d0                rcl ax, 1
05589  d1 e5                shl bp, 1
0558b  d1 d0                rcl ax, 1
0558d  86 e0                xchg al, ah
0558f  26 89 45 02          mov word ptr es:[di + 2], ax
05593  d1 e2                shl dx, 1
05595  d1 d0                rcl ax, 1
05597  d1 e1                shl cx, 1
05599  d1 d0                rcl ax, 1
0559b  d1 e3                shl bx, 1
0559d  d1 d0                rcl ax, 1
0559f  d1 e5                shl bp, 1
055a1  d1 d0                rcl ax, 1
055a3  d1 e2                shl dx, 1
055a5  d1 d0                rcl ax, 1
055a7  d1 e1                shl cx, 1
055a9  d1 d0                rcl ax, 1
055ab  d1 e3                shl bx, 1
055ad  d1 d0                rcl ax, 1
055af  d1 e5                shl bp, 1
055b1  d1 d0                rcl ax, 1
055b3  d1 e2                shl dx, 1
055b5  d1 d0                rcl ax, 1
055b7  d1 e1                shl cx, 1
055b9  d1 d0                rcl ax, 1
055bb  d1 e3                shl bx, 1
055bd  d1 d0                rcl ax, 1
055bf  d1 e5                shl bp, 1
055c1  d1 d0                rcl ax, 1
055c3  d1 e2                shl dx, 1
055c5  d1 d0                rcl ax, 1
055c7  d1 e1                shl cx, 1
055c9  d1 d0                rcl ax, 1
055cb  d1 e3                shl bx, 1
055cd  d1 d0                rcl ax, 1
055cf  d1 e5                shl bp, 1
055d1  d1 d0                rcl ax, 1
055d3  86 e0                xchg al, ah
055d5  26 89 45 04          mov word ptr es:[di + 4], ax
055d9  d1 e2                shl dx, 1
055db  d1 d0                rcl ax, 1
055dd  d1 e1                shl cx, 1
055df  d1 d0                rcl ax, 1
055e1  d1 e3                shl bx, 1
055e3  d1 d0                rcl ax, 1
055e5  d1 e5                shl bp, 1
055e7  d1 d0                rcl ax, 1
055e9  d1 e2                shl dx, 1
055eb  d1 d0                rcl ax, 1
055ed  d1 e1                shl cx, 1
055ef  d1 d0                rcl ax, 1
055f1  d1 e3                shl bx, 1
055f3  d1 d0                rcl ax, 1
055f5  d1 e5                shl bp, 1
055f7  d1 d0                rcl ax, 1
055f9  d1 e2                shl dx, 1
055fb  d1 d0                rcl ax, 1
055fd  d1 e1                shl cx, 1
055ff  d1 d0                rcl ax, 1
05601  d1 e3                shl bx, 1
05603  d1 d0                rcl ax, 1
05605  d1 e5                shl bp, 1
05607  d1 d0                rcl ax, 1
05609  d1 e2                shl dx, 1
0560b  d1 d0                rcl ax, 1
0560d  d1 e1                shl cx, 1
0560f  d1 d0                rcl ax, 1
05611  d1 e3                shl bx, 1
05613  d1 d0                rcl ax, 1
05615  d1 e5                shl bp, 1
05617  d1 d0                rcl ax, 1
05619  86 e0                xchg al, ah
0561b  26 89 45 06          mov word ptr es:[di + 6], ax
0561f  83 c6 02             add si, 2
05622  83 c7 08             add di, 8
05625  8a 64 78             mov ah, byte ptr [si + 0x78]
05628  8a 44 79             mov al, byte ptr [si + 0x79]
0562b  8b e8                mov bp, ax
0562d  8a 7c 50             mov bh, byte ptr [si + 0x50]
05630  8a 5c 51             mov bl, byte ptr [si + 0x51]
05633  8a 6c 28             mov ch, byte ptr [si + 0x28]
05636  8a 4c 29             mov cl, byte ptr [si + 0x29]
05639  8a 34                mov dh, byte ptr [si]
0563b  8a 54 01             mov dl, byte ptr [si + 1]
0563e  b8 00 00             mov ax, 0
05641  d1 e2                shl dx, 1
05643  d1 d0                rcl ax, 1
05645  d1 e1                shl cx, 1
05647  d1 d0                rcl ax, 1
05649  d1 e3                shl bx, 1
0564b  d1 d0                rcl ax, 1
0564d  d1 e5                shl bp, 1
0564f  d1 d0                rcl ax, 1
05651  d1 e2                shl dx, 1
05653  d1 d0                rcl ax, 1
05655  d1 e1                shl cx, 1
05657  d1 d0                rcl ax, 1
05659  d1 e3                shl bx, 1
0565b  d1 d0                rcl ax, 1
0565d  d1 e5                shl bp, 1
0565f  d1 d0                rcl ax, 1
05661  d1 e2                shl dx, 1
05663  d1 d0                rcl ax, 1
05665  d1 e1                shl cx, 1
05667  d1 d0                rcl ax, 1
05669  d1 e3                shl bx, 1
0566b  d1 d0                rcl ax, 1
0566d  d1 e5                shl bp, 1
0566f  d1 d0                rcl ax, 1
05671  d1 e2                shl dx, 1
05673  d1 d0                rcl ax, 1
05675  d1 e1                shl cx, 1
05677  d1 d0                rcl ax, 1
05679  d1 e3                shl bx, 1
0567b  d1 d0                rcl ax, 1
0567d  d1 e5                shl bp, 1
0567f  d1 d0                rcl ax, 1
05681  86 e0                xchg al, ah
05683  26 89 05             mov word ptr es:[di], ax
05686  d1 e2                shl dx, 1
05688  d1 d0                rcl ax, 1
0568a  d1 e1                shl cx, 1
0568c  d1 d0                rcl ax, 1
0568e  d1 e3                shl bx, 1
05690  d1 d0                rcl ax, 1
05692  d1 e5                shl bp, 1
05694  d1 d0                rcl ax, 1
05696  d1 e2                shl dx, 1
05698  d1 d0                rcl ax, 1
0569a  d1 e1                shl cx, 1
0569c  d1 d0                rcl ax, 1
0569e  d1 e3                shl bx, 1
056a0  d1 d0                rcl ax, 1
056a2  d1 e5                shl bp, 1
056a4  d1 d0                rcl ax, 1
056a6  d1 e2                shl dx, 1
056a8  d1 d0                rcl ax, 1
056aa  d1 e1                shl cx, 1
056ac  d1 d0                rcl ax, 1
056ae  d1 e3                shl bx, 1
056b0  d1 d0                rcl ax, 1
056b2  d1 e5                shl bp, 1
056b4  d1 d0                rcl ax, 1
056b6  d1 e2                shl dx, 1
056b8  d1 d0                rcl ax, 1
056ba  d1 e1                shl cx, 1
056bc  d1 d0                rcl ax, 1
056be  d1 e3                shl bx, 1
056c0  d1 d0                rcl ax, 1
056c2  d1 e5                shl bp, 1
056c4  d1 d0                rcl ax, 1
056c6  86 e0                xchg al, ah
056c8  26 89 45 02          mov word ptr es:[di + 2], ax
056cc  d1 e2                shl dx, 1
056ce  d1 d0                rcl ax, 1
056d0  d1 e1                shl cx, 1
056d2  d1 d0                rcl ax, 1
056d4  d1 e3                shl bx, 1
056d6  d1 d0                rcl ax, 1
056d8  d1 e5                shl bp, 1
056da  d1 d0                rcl ax, 1
056dc  d1 e2                shl dx, 1
056de  d1 d0                rcl ax, 1
056e0  d1 e1                shl cx, 1
056e2  d1 d0                rcl ax, 1
056e4  d1 e3                shl bx, 1
056e6  d1 d0                rcl ax, 1
056e8  d1 e5                shl bp, 1
056ea  d1 d0                rcl ax, 1
056ec  d1 e2                shl dx, 1
056ee  d1 d0                rcl ax, 1
056f0  d1 e1                shl cx, 1
056f2  d1 d0                rcl ax, 1
056f4  d1 e3                shl bx, 1
056f6  d1 d0                rcl ax, 1
056f8  d1 e5                shl bp, 1
056fa  d1 d0                rcl ax, 1
056fc  d1 e2                shl dx, 1
056fe  d1 d0                rcl ax, 1
05700  d1 e1                shl cx, 1
05702  d1 d0                rcl ax, 1
05704  d1 e3                shl bx, 1
05706  d1 d0                rcl ax, 1
05708  d1 e5                shl bp, 1
0570a  d1 d0                rcl ax, 1
0570c  86 e0                xchg al, ah
0570e  26 89 45 04          mov word ptr es:[di + 4], ax
05712  d1 e2                shl dx, 1
05714  d1 d0                rcl ax, 1
05716  d1 e1                shl cx, 1
05718  d1 d0                rcl ax, 1
0571a  d1 e3                shl bx, 1
0571c  d1 d0                rcl ax, 1
0571e  d1 e5                shl bp, 1
05720  d1 d0                rcl ax, 1
05722  d1 e2                shl dx, 1
05724  d1 d0                rcl ax, 1
05726  d1 e1                shl cx, 1
05728  d1 d0                rcl ax, 1
0572a  d1 e3                shl bx, 1
0572c  d1 d0                rcl ax, 1
0572e  d1 e5                shl bp, 1
05730  d1 d0                rcl ax, 1
05732  d1 e2                shl dx, 1
05734  d1 d0                rcl ax, 1
05736  d1 e1                shl cx, 1
05738  d1 d0                rcl ax, 1
0573a  d1 e3                shl bx, 1
0573c  d1 d0                rcl ax, 1
0573e  d1 e5                shl bp, 1
05740  d1 d0                rcl ax, 1
05742  d1 e2                shl dx, 1
05744  d1 d0                rcl ax, 1
05746  d1 e1                shl cx, 1
05748  d1 d0                rcl ax, 1
0574a  d1 e3                shl bx, 1
0574c  d1 d0                rcl ax, 1
0574e  d1 e5                shl bp, 1
05750  d1 d0                rcl ax, 1
05752  86 e0                xchg al, ah
05754  26 89 45 06          mov word ptr es:[di + 6], ax
05758  83 c6 02             add si, 2
0575b  83 c7 08             add di, 8
0575e  8a 64 78             mov ah, byte ptr [si + 0x78]
05761  8a 44 79             mov al, byte ptr [si + 0x79]
05764  8b e8                mov bp, ax
05766  8a 7c 50             mov bh, byte ptr [si + 0x50]
05769  8a 5c 51             mov bl, byte ptr [si + 0x51]
0576c  8a 6c 28             mov ch, byte ptr [si + 0x28]
0576f  8a 4c 29             mov cl, byte ptr [si + 0x29]
05772  8a 34                mov dh, byte ptr [si]
05774  8a 54 01             mov dl, byte ptr [si + 1]
05777  b8 00 00             mov ax, 0
0577a  d1 e2                shl dx, 1
0577c  d1 d0                rcl ax, 1
0577e  d1 e1                shl cx, 1
05780  d1 d0                rcl ax, 1
05782  d1 e3                shl bx, 1
05784  d1 d0                rcl ax, 1
05786  d1 e5                shl bp, 1
05788  d1 d0                rcl ax, 1
0578a  d1 e2                shl dx, 1
0578c  d1 d0                rcl ax, 1
0578e  d1 e1                shl cx, 1
05790  d1 d0                rcl ax, 1
05792  d1 e3                shl bx, 1
05794  d1 d0                rcl ax, 1
05796  d1 e5                shl bp, 1
05798  d1 d0                rcl ax, 1
0579a  d1 e2                shl dx, 1
0579c  d1 d0                rcl ax, 1
0579e  d1 e1                shl cx, 1
057a0  d1 d0                rcl ax, 1
057a2  d1 e3                shl bx, 1
057a4  d1 d0                rcl ax, 1
057a6  d1 e5                shl bp, 1
057a8  d1 d0                rcl ax, 1
057aa  d1 e2                shl dx, 1
057ac  d1 d0                rcl ax, 1
057ae  d1 e1                shl cx, 1
057b0  d1 d0                rcl ax, 1
057b2  d1 e3                shl bx, 1
057b4  d1 d0                rcl ax, 1
057b6  d1 e5                shl bp, 1
057b8  d1 d0                rcl ax, 1
057ba  86 e0                xchg al, ah
057bc  26 89 05             mov word ptr es:[di], ax
057bf  d1 e2                shl dx, 1
057c1  d1 d0                rcl ax, 1
057c3  d1 e1                shl cx, 1
057c5  d1 d0                rcl ax, 1
057c7  d1 e3                shl bx, 1
057c9  d1 d0                rcl ax, 1
057cb  d1 e5                shl bp, 1
057cd  d1 d0                rcl ax, 1
057cf  d1 e2                shl dx, 1
057d1  d1 d0                rcl ax, 1
057d3  d1 e1                shl cx, 1
057d5  d1 d0                rcl ax, 1
057d7  d1 e3                shl bx, 1
057d9  d1 d0                rcl ax, 1
057db  d1 e5                shl bp, 1
057dd  d1 d0                rcl ax, 1
057df  d1 e2                shl dx, 1
057e1  d1 d0                rcl ax, 1
057e3  d1 e1                shl cx, 1
057e5  d1 d0                rcl ax, 1
057e7  d1 e3                shl bx, 1
057e9  d1 d0                rcl ax, 1
057eb  d1 e5                shl bp, 1
057ed  d1 d0                rcl ax, 1
057ef  d1 e2                shl dx, 1
057f1  d1 d0                rcl ax, 1
057f3  d1 e1                shl cx, 1
057f5  d1 d0                rcl ax, 1
057f7  d1 e3                shl bx, 1
057f9  d1 d0                rcl ax, 1
057fb  d1 e5                shl bp, 1
057fd  d1 d0                rcl ax, 1
057ff  86 e0                xchg al, ah
05801  26 89 45 02          mov word ptr es:[di + 2], ax
05805  d1 e2                shl dx, 1
05807  d1 d0                rcl ax, 1
05809  d1 e1                shl cx, 1
0580b  d1 d0                rcl ax, 1
0580d  d1 e3                shl bx, 1
0580f  d1 d0                rcl ax, 1
05811  d1 e5                shl bp, 1
05813  d1 d0                rcl ax, 1
05815  d1 e2                shl dx, 1
05817  d1 d0                rcl ax, 1
05819  d1 e1                shl cx, 1
0581b  d1 d0                rcl ax, 1
0581d  d1 e3                shl bx, 1
0581f  d1 d0                rcl ax, 1
05821  d1 e5                shl bp, 1
05823  d1 d0                rcl ax, 1
05825  d1 e2                shl dx, 1
05827  d1 d0                rcl ax, 1
05829  d1 e1                shl cx, 1
0582b  d1 d0                rcl ax, 1
0582d  d1 e3                shl bx, 1
0582f  d1 d0                rcl ax, 1
05831  d1 e5                shl bp, 1
05833  d1 d0                rcl ax, 1
05835  d1 e2                shl dx, 1
05837  d1 d0                rcl ax, 1
05839  d1 e1                shl cx, 1
0583b  d1 d0                rcl ax, 1
0583d  d1 e3                shl bx, 1
0583f  d1 d0                rcl ax, 1
05841  d1 e5                shl bp, 1
05843  d1 d0                rcl ax, 1
05845  86 e0                xchg al, ah
05847  26 89 45 04          mov word ptr es:[di + 4], ax
0584b  d1 e2                shl dx, 1
0584d  d1 d0                rcl ax, 1
0584f  d1 e1                shl cx, 1
05851  d1 d0                rcl ax, 1
05853  d1 e3                shl bx, 1
05855  d1 d0                rcl ax, 1
05857  d1 e5                shl bp, 1
05859  d1 d0                rcl ax, 1
0585b  d1 e2                shl dx, 1
0585d  d1 d0                rcl ax, 1
0585f  d1 e1                shl cx, 1
05861  d1 d0                rcl ax, 1
05863  d1 e3                shl bx, 1
05865  d1 d0                rcl ax, 1
05867  d1 e5                shl bp, 1
05869  d1 d0                rcl ax, 1
0586b  d1 e2                shl dx, 1
0586d  d1 d0                rcl ax, 1
0586f  d1 e1                shl cx, 1
05871  d1 d0                rcl ax, 1
05873  d1 e3                shl bx, 1
05875  d1 d0                rcl ax, 1
05877  d1 e5                shl bp, 1
05879  d1 d0                rcl ax, 1
0587b  d1 e2                shl dx, 1
0587d  d1 d0                rcl ax, 1
0587f  d1 e1                shl cx, 1
05881  d1 d0                rcl ax, 1
05883  d1 e3                shl bx, 1
05885  d1 d0                rcl ax, 1
05887  d1 e5                shl bp, 1
05889  d1 d0                rcl ax, 1
0588b  86 e0                xchg al, ah
0588d  26 89 45 06          mov word ptr es:[di + 6], ax
05891  83 c6 02             add si, 2
05894  83 c7 08             add di, 8
05897  8a 64 78             mov ah, byte ptr [si + 0x78]
0589a  8a 44 79             mov al, byte ptr [si + 0x79]
0589d  8b e8                mov bp, ax
0589f  8a 7c 50             mov bh, byte ptr [si + 0x50]
058a2  8a 5c 51             mov bl, byte ptr [si + 0x51]
058a5  8a 6c 28             mov ch, byte ptr [si + 0x28]
058a8  8a 4c 29             mov cl, byte ptr [si + 0x29]
058ab  8a 34                mov dh, byte ptr [si]
058ad  8a 54 01             mov dl, byte ptr [si + 1]
058b0  b8 00 00             mov ax, 0
058b3  d1 e2                shl dx, 1
058b5  d1 d0                rcl ax, 1
058b7  d1 e1                shl cx, 1
058b9  d1 d0                rcl ax, 1
058bb  d1 e3                shl bx, 1
058bd  d1 d0                rcl ax, 1
058bf  d1 e5                shl bp, 1
058c1  d1 d0                rcl ax, 1
058c3  d1 e2                shl dx, 1
058c5  d1 d0                rcl ax, 1
058c7  d1 e1                shl cx, 1
058c9  d1 d0                rcl ax, 1
058cb  d1 e3                shl bx, 1
058cd  d1 d0                rcl ax, 1
058cf  d1 e5                shl bp, 1
058d1  d1 d0                rcl ax, 1
058d3  d1 e2                shl dx, 1
058d5  d1 d0                rcl ax, 1
058d7  d1 e1                shl cx, 1
058d9  d1 d0                rcl ax, 1
058db  d1 e3                shl bx, 1
058dd  d1 d0                rcl ax, 1
058df  d1 e5                shl bp, 1
058e1  d1 d0                rcl ax, 1
058e3  d1 e2                shl dx, 1
058e5  d1 d0                rcl ax, 1
058e7  d1 e1                shl cx, 1
058e9  d1 d0                rcl ax, 1
058eb  d1 e3                shl bx, 1
058ed  d1 d0                rcl ax, 1
058ef  d1 e5                shl bp, 1
058f1  d1 d0                rcl ax, 1
058f3  86 e0                xchg al, ah
058f5  26 89 05             mov word ptr es:[di], ax
058f8  d1 e2                shl dx, 1
058fa  d1 d0                rcl ax, 1
058fc  d1 e1                shl cx, 1
058fe  d1 d0                rcl ax, 1
05900  d1 e3                shl bx, 1
05902  d1 d0                rcl ax, 1
05904  d1 e5                shl bp, 1
05906  d1 d0                rcl ax, 1
05908  d1 e2                shl dx, 1
0590a  d1 d0                rcl ax, 1
0590c  d1 e1                shl cx, 1
0590e  d1 d0                rcl ax, 1
05910  d1 e3                shl bx, 1
05912  d1 d0                rcl ax, 1
05914  d1 e5                shl bp, 1
05916  d1 d0                rcl ax, 1
05918  d1 e2                shl dx, 1
0591a  d1 d0                rcl ax, 1
0591c  d1 e1                shl cx, 1
0591e  d1 d0                rcl ax, 1
05920  d1 e3                shl bx, 1
05922  d1 d0                rcl ax, 1
05924  d1 e5                shl bp, 1
05926  d1 d0                rcl ax, 1
05928  d1 e2                shl dx, 1
0592a  d1 d0                rcl ax, 1
0592c  d1 e1                shl cx, 1
0592e  d1 d0                rcl ax, 1
05930  d1 e3                shl bx, 1
05932  d1 d0                rcl ax, 1
05934  d1 e5                shl bp, 1
05936  d1 d0                rcl ax, 1
05938  86 e0                xchg al, ah
0593a  26 89 45 02          mov word ptr es:[di + 2], ax
0593e  d1 e2                shl dx, 1
05940  d1 d0                rcl ax, 1
05942  d1 e1                shl cx, 1
05944  d1 d0                rcl ax, 1
05946  d1 e3                shl bx, 1
05948  d1 d0                rcl ax, 1
0594a  d1 e5                shl bp, 1
0594c  d1 d0                rcl ax, 1
0594e  d1 e2                shl dx, 1
05950  d1 d0                rcl ax, 1
05952  d1 e1                shl cx, 1
05954  d1 d0                rcl ax, 1
05956  d1 e3                shl bx, 1
05958  d1 d0                rcl ax, 1
0595a  d1 e5                shl bp, 1
0595c  d1 d0                rcl ax, 1
0595e  d1 e2                shl dx, 1
05960  d1 d0                rcl ax, 1
05962  d1 e1                shl cx, 1
05964  d1 d0                rcl ax, 1
05966  d1 e3                shl bx, 1
05968  d1 d0                rcl ax, 1
0596a  d1 e5                shl bp, 1
0596c  d1 d0                rcl ax, 1
0596e  d1 e2                shl dx, 1
05970  d1 d0                rcl ax, 1
05972  d1 e1                shl cx, 1
05974  d1 d0                rcl ax, 1
05976  d1 e3                shl bx, 1
05978  d1 d0                rcl ax, 1
0597a  d1 e5                shl bp, 1
0597c  d1 d0                rcl ax, 1
0597e  86 e0                xchg al, ah
05980  26 89 45 04          mov word ptr es:[di + 4], ax
05984  d1 e2                shl dx, 1
05986  d1 d0                rcl ax, 1
05988  d1 e1                shl cx, 1
0598a  d1 d0                rcl ax, 1
0598c  d1 e3                shl bx, 1
0598e  d1 d0                rcl ax, 1
05990  d1 e5                shl bp, 1
05992  d1 d0                rcl ax, 1
05994  d1 e2                shl dx, 1
05996  d1 d0                rcl ax, 1
05998  d1 e1                shl cx, 1
0599a  d1 d0                rcl ax, 1
0599c  d1 e3                shl bx, 1
0599e  d1 d0                rcl ax, 1
059a0  d1 e5                shl bp, 1
059a2  d1 d0                rcl ax, 1
059a4  d1 e2                shl dx, 1
059a6  d1 d0                rcl ax, 1
059a8  d1 e1                shl cx, 1
059aa  d1 d0                rcl ax, 1
059ac  d1 e3                shl bx, 1
059ae  d1 d0                rcl ax, 1
059b0  d1 e5                shl bp, 1
059b2  d1 d0                rcl ax, 1
059b4  d1 e2                shl dx, 1
059b6  d1 d0                rcl ax, 1
059b8  d1 e1                shl cx, 1
059ba  d1 d0                rcl ax, 1
059bc  d1 e3                shl bx, 1
059be  d1 d0                rcl ax, 1
059c0  d1 e5                shl bp, 1
059c2  d1 d0                rcl ax, 1
059c4  86 e0                xchg al, ah
059c6  26 89 45 06          mov word ptr es:[di + 6], ax
059ca  83 c6 02             add si, 2
059cd  83 c7 08             add di, 8
059d0  8a 64 78             mov ah, byte ptr [si + 0x78]
059d3  8a 44 79             mov al, byte ptr [si + 0x79]
059d6  8b e8                mov bp, ax
059d8  8a 7c 50             mov bh, byte ptr [si + 0x50]
059db  8a 5c 51             mov bl, byte ptr [si + 0x51]
059de  8a 6c 28             mov ch, byte ptr [si + 0x28]
059e1  8a 4c 29             mov cl, byte ptr [si + 0x29]
059e4  8a 34                mov dh, byte ptr [si]
059e6  8a 54 01             mov dl, byte ptr [si + 1]
059e9  b8 00 00             mov ax, 0
059ec  d1 e2                shl dx, 1
059ee  d1 d0                rcl ax, 1
059f0  d1 e1                shl cx, 1
059f2  d1 d0                rcl ax, 1
059f4  d1 e3                shl bx, 1
059f6  d1 d0                rcl ax, 1
059f8  d1 e5                shl bp, 1
059fa  d1 d0                rcl ax, 1
059fc  d1 e2                shl dx, 1
059fe  d1 d0                rcl ax, 1
05a00  d1 e1                shl cx, 1
05a02  d1 d0                rcl ax, 1
05a04  d1 e3                shl bx, 1
05a06  d1 d0                rcl ax, 1
05a08  d1 e5                shl bp, 1
05a0a  d1 d0                rcl ax, 1
05a0c  d1 e2                shl dx, 1
05a0e  d1 d0                rcl ax, 1
05a10  d1 e1                shl cx, 1
05a12  d1 d0                rcl ax, 1
05a14  d1 e3                shl bx, 1
05a16  d1 d0                rcl ax, 1
05a18  d1 e5                shl bp, 1
05a1a  d1 d0                rcl ax, 1
05a1c  d1 e2                shl dx, 1
05a1e  d1 d0                rcl ax, 1
05a20  d1 e1                shl cx, 1
05a22  d1 d0                rcl ax, 1
05a24  d1 e3                shl bx, 1
05a26  d1 d0                rcl ax, 1
05a28  d1 e5                shl bp, 1
05a2a  d1 d0                rcl ax, 1
05a2c  86 e0                xchg al, ah
05a2e  26 89 05             mov word ptr es:[di], ax
05a31  d1 e2                shl dx, 1
05a33  d1 d0                rcl ax, 1
05a35  d1 e1                shl cx, 1
05a37  d1 d0                rcl ax, 1
05a39  d1 e3                shl bx, 1
05a3b  d1 d0                rcl ax, 1
05a3d  d1 e5                shl bp, 1
05a3f  d1 d0                rcl ax, 1
05a41  d1 e2                shl dx, 1
05a43  d1 d0                rcl ax, 1
05a45  d1 e1                shl cx, 1
05a47  d1 d0                rcl ax, 1
05a49  d1 e3                shl bx, 1
05a4b  d1 d0                rcl ax, 1
05a4d  d1 e5                shl bp, 1
05a4f  d1 d0                rcl ax, 1
05a51  d1 e2                shl dx, 1
05a53  d1 d0                rcl ax, 1
05a55  d1 e1                shl cx, 1
05a57  d1 d0                rcl ax, 1
05a59  d1 e3                shl bx, 1
05a5b  d1 d0                rcl ax, 1
05a5d  d1 e5                shl bp, 1
05a5f  d1 d0                rcl ax, 1
05a61  d1 e2                shl dx, 1
05a63  d1 d0                rcl ax, 1
05a65  d1 e1                shl cx, 1
05a67  d1 d0                rcl ax, 1
05a69  d1 e3                shl bx, 1
05a6b  d1 d0                rcl ax, 1
05a6d  d1 e5                shl bp, 1
05a6f  d1 d0                rcl ax, 1
05a71  86 e0                xchg al, ah
05a73  26 89 45 02          mov word ptr es:[di + 2], ax
05a77  d1 e2                shl dx, 1
05a79  d1 d0                rcl ax, 1
05a7b  d1 e1                shl cx, 1
05a7d  d1 d0                rcl ax, 1
05a7f  d1 e3                shl bx, 1
05a81  d1 d0                rcl ax, 1
05a83  d1 e5                shl bp, 1
05a85  d1 d0                rcl ax, 1
05a87  d1 e2                shl dx, 1
05a89  d1 d0                rcl ax, 1
05a8b  d1 e1                shl cx, 1
05a8d  d1 d0                rcl ax, 1
05a8f  d1 e3                shl bx, 1
05a91  d1 d0                rcl ax, 1
05a93  d1 e5                shl bp, 1
05a95  d1 d0                rcl ax, 1
05a97  d1 e2                shl dx, 1
05a99  d1 d0                rcl ax, 1
05a9b  d1 e1                shl cx, 1
05a9d  d1 d0                rcl ax, 1
05a9f  d1 e3                shl bx, 1
05aa1  d1 d0                rcl ax, 1
05aa3  d1 e5                shl bp, 1
05aa5  d1 d0                rcl ax, 1
05aa7  d1 e2                shl dx, 1
05aa9  d1 d0                rcl ax, 1
05aab  d1 e1                shl cx, 1
05aad  d1 d0                rcl ax, 1
05aaf  d1 e3                shl bx, 1
05ab1  d1 d0                rcl ax, 1
05ab3  d1 e5                shl bp, 1
05ab5  d1 d0                rcl ax, 1
05ab7  86 e0                xchg al, ah
05ab9  26 89 45 04          mov word ptr es:[di + 4], ax
05abd  d1 e2                shl dx, 1
05abf  d1 d0                rcl ax, 1
05ac1  d1 e1                shl cx, 1
05ac3  d1 d0                rcl ax, 1
05ac5  d1 e3                shl bx, 1
05ac7  d1 d0                rcl ax, 1
05ac9  d1 e5                shl bp, 1
05acb  d1 d0                rcl ax, 1
05acd  d1 e2                shl dx, 1
05acf  d1 d0                rcl ax, 1
05ad1  d1 e1                shl cx, 1
05ad3  d1 d0                rcl ax, 1
05ad5  d1 e3                shl bx, 1
05ad7  d1 d0                rcl ax, 1
05ad9  d1 e5                shl bp, 1
05adb  d1 d0                rcl ax, 1
05add  d1 e2                shl dx, 1
05adf  d1 d0                rcl ax, 1
05ae1  d1 e1                shl cx, 1
05ae3  d1 d0                rcl ax, 1
05ae5  d1 e3                shl bx, 1
05ae7  d1 d0                rcl ax, 1
05ae9  d1 e5                shl bp, 1
05aeb  d1 d0                rcl ax, 1
05aed  d1 e2                shl dx, 1
05aef  d1 d0                rcl ax, 1
05af1  d1 e1                shl cx, 1
05af3  d1 d0                rcl ax, 1
05af5  d1 e3                shl bx, 1
05af7  d1 d0                rcl ax, 1
05af9  d1 e5                shl bp, 1
05afb  d1 d0                rcl ax, 1
05afd  86 e0                xchg al, ah
05aff  26 89 45 06          mov word ptr es:[di + 6], ax
05b03  83 c6 02             add si, 2
05b06  83 c7 08             add di, 8
05b09  8a 64 78             mov ah, byte ptr [si + 0x78]
05b0c  8a 44 79             mov al, byte ptr [si + 0x79]
05b0f  8b e8                mov bp, ax
05b11  8a 7c 50             mov bh, byte ptr [si + 0x50]
05b14  8a 5c 51             mov bl, byte ptr [si + 0x51]
05b17  8a 6c 28             mov ch, byte ptr [si + 0x28]
05b1a  8a 4c 29             mov cl, byte ptr [si + 0x29]
05b1d  8a 34                mov dh, byte ptr [si]
05b1f  8a 54 01             mov dl, byte ptr [si + 1]
05b22  b8 00 00             mov ax, 0
05b25  d1 e2                shl dx, 1
05b27  d1 d0                rcl ax, 1
05b29  d1 e1                shl cx, 1
05b2b  d1 d0                rcl ax, 1
05b2d  d1 e3                shl bx, 1
05b2f  d1 d0                rcl ax, 1
05b31  d1 e5                shl bp, 1
05b33  d1 d0                rcl ax, 1
05b35  d1 e2                shl dx, 1
05b37  d1 d0                rcl ax, 1
05b39  d1 e1                shl cx, 1
05b3b  d1 d0                rcl ax, 1
05b3d  d1 e3                shl bx, 1
05b3f  d1 d0                rcl ax, 1
05b41  d1 e5                shl bp, 1
05b43  d1 d0                rcl ax, 1
05b45  d1 e2                shl dx, 1
05b47  d1 d0                rcl ax, 1
05b49  d1 e1                shl cx, 1
05b4b  d1 d0                rcl ax, 1
05b4d  d1 e3                shl bx, 1
05b4f  d1 d0                rcl ax, 1
05b51  d1 e5                shl bp, 1
05b53  d1 d0                rcl ax, 1
05b55  d1 e2                shl dx, 1
05b57  d1 d0                rcl ax, 1
05b59  d1 e1                shl cx, 1
05b5b  d1 d0                rcl ax, 1
05b5d  d1 e3                shl bx, 1
05b5f  d1 d0                rcl ax, 1
05b61  d1 e5                shl bp, 1
05b63  d1 d0                rcl ax, 1
05b65  86 e0                xchg al, ah
05b67  26 89 05             mov word ptr es:[di], ax
05b6a  d1 e2                shl dx, 1
05b6c  d1 d0                rcl ax, 1
05b6e  d1 e1                shl cx, 1
05b70  d1 d0                rcl ax, 1
05b72  d1 e3                shl bx, 1
05b74  d1 d0                rcl ax, 1
05b76  d1 e5                shl bp, 1
05b78  d1 d0                rcl ax, 1
05b7a  d1 e2                shl dx, 1
05b7c  d1 d0                rcl ax, 1
05b7e  d1 e1                shl cx, 1
05b80  d1 d0                rcl ax, 1
05b82  d1 e3                shl bx, 1
05b84  d1 d0                rcl ax, 1
05b86  d1 e5                shl bp, 1
05b88  d1 d0                rcl ax, 1
05b8a  d1 e2                shl dx, 1
05b8c  d1 d0                rcl ax, 1
05b8e  d1 e1                shl cx, 1
05b90  d1 d0                rcl ax, 1
05b92  d1 e3                shl bx, 1
05b94  d1 d0                rcl ax, 1
05b96  d1 e5                shl bp, 1
05b98  d1 d0                rcl ax, 1
05b9a  d1 e2                shl dx, 1
05b9c  d1 d0                rcl ax, 1
05b9e  d1 e1                shl cx, 1
05ba0  d1 d0                rcl ax, 1
05ba2  d1 e3                shl bx, 1
05ba4  d1 d0                rcl ax, 1
05ba6  d1 e5                shl bp, 1
05ba8  d1 d0                rcl ax, 1
05baa  86 e0                xchg al, ah
05bac  26 89 45 02          mov word ptr es:[di + 2], ax
05bb0  d1 e2                shl dx, 1
05bb2  d1 d0                rcl ax, 1
05bb4  d1 e1                shl cx, 1
05bb6  d1 d0                rcl ax, 1
05bb8  d1 e3                shl bx, 1
05bba  d1 d0                rcl ax, 1
05bbc  d1 e5                shl bp, 1
05bbe  d1 d0                rcl ax, 1
05bc0  d1 e2                shl dx, 1
05bc2  d1 d0                rcl ax, 1
05bc4  d1 e1                shl cx, 1
05bc6  d1 d0                rcl ax, 1
05bc8  d1 e3                shl bx, 1
05bca  d1 d0                rcl ax, 1
05bcc  d1 e5                shl bp, 1
05bce  d1 d0                rcl ax, 1
05bd0  d1 e2                shl dx, 1
05bd2  d1 d0                rcl ax, 1
05bd4  d1 e1                shl cx, 1
05bd6  d1 d0                rcl ax, 1
05bd8  d1 e3                shl bx, 1
05bda  d1 d0                rcl ax, 1
05bdc  d1 e5                shl bp, 1
05bde  d1 d0                rcl ax, 1
05be0  d1 e2                shl dx, 1
05be2  d1 d0                rcl ax, 1
05be4  d1 e1                shl cx, 1
05be6  d1 d0                rcl ax, 1
05be8  d1 e3                shl bx, 1
05bea  d1 d0                rcl ax, 1
05bec  d1 e5                shl bp, 1
05bee  d1 d0                rcl ax, 1
05bf0  86 e0                xchg al, ah
05bf2  26 89 45 04          mov word ptr es:[di + 4], ax
05bf6  d1 e2                shl dx, 1
05bf8  d1 d0                rcl ax, 1
05bfa  d1 e1                shl cx, 1
05bfc  d1 d0                rcl ax, 1
05bfe  d1 e3                shl bx, 1
05c00  d1 d0                rcl ax, 1
05c02  d1 e5                shl bp, 1
05c04  d1 d0                rcl ax, 1
05c06  d1 e2                shl dx, 1
05c08  d1 d0                rcl ax, 1
05c0a  d1 e1                shl cx, 1
05c0c  d1 d0                rcl ax, 1
05c0e  d1 e3                shl bx, 1
05c10  d1 d0                rcl ax, 1
05c12  d1 e5                shl bp, 1
05c14  d1 d0                rcl ax, 1
05c16  d1 e2                shl dx, 1
05c18  d1 d0                rcl ax, 1
05c1a  d1 e1                shl cx, 1
05c1c  d1 d0                rcl ax, 1
05c1e  d1 e3                shl bx, 1
05c20  d1 d0                rcl ax, 1
05c22  d1 e5                shl bp, 1
05c24  d1 d0                rcl ax, 1
05c26  d1 e2                shl dx, 1
05c28  d1 d0                rcl ax, 1
05c2a  d1 e1                shl cx, 1
05c2c  d1 d0                rcl ax, 1
05c2e  d1 e3                shl bx, 1
05c30  d1 d0                rcl ax, 1
05c32  d1 e5                shl bp, 1
05c34  d1 d0                rcl ax, 1
05c36  86 e0                xchg al, ah
05c38  26 89 45 06          mov word ptr es:[di + 6], ax
05c3c  83 c6 02             add si, 2
05c3f  83 c7 08             add di, 8
05c42  8a 64 78             mov ah, byte ptr [si + 0x78]
05c45  8a 44 79             mov al, byte ptr [si + 0x79]
05c48  8b e8                mov bp, ax
05c4a  8a 7c 50             mov bh, byte ptr [si + 0x50]
05c4d  8a 5c 51             mov bl, byte ptr [si + 0x51]
05c50  8a 6c 28             mov ch, byte ptr [si + 0x28]
05c53  8a 4c 29             mov cl, byte ptr [si + 0x29]
05c56  8a 34                mov dh, byte ptr [si]
05c58  8a 54 01             mov dl, byte ptr [si + 1]
05c5b  b8 00 00             mov ax, 0
05c5e  d1 e2                shl dx, 1
05c60  d1 d0                rcl ax, 1
05c62  d1 e1                shl cx, 1
05c64  d1 d0                rcl ax, 1
05c66  d1 e3                shl bx, 1
05c68  d1 d0                rcl ax, 1
05c6a  d1 e5                shl bp, 1
05c6c  d1 d0                rcl ax, 1
05c6e  d1 e2                shl dx, 1
05c70  d1 d0                rcl ax, 1
05c72  d1 e1                shl cx, 1
05c74  d1 d0                rcl ax, 1
05c76  d1 e3                shl bx, 1
05c78  d1 d0                rcl ax, 1
05c7a  d1 e5                shl bp, 1
05c7c  d1 d0                rcl ax, 1
05c7e  d1 e2                shl dx, 1
05c80  d1 d0                rcl ax, 1
05c82  d1 e1                shl cx, 1
05c84  d1 d0                rcl ax, 1
05c86  d1 e3                shl bx, 1
05c88  d1 d0                rcl ax, 1
05c8a  d1 e5                shl bp, 1
05c8c  d1 d0                rcl ax, 1
05c8e  d1 e2                shl dx, 1
05c90  d1 d0                rcl ax, 1
05c92  d1 e1                shl cx, 1
05c94  d1 d0                rcl ax, 1
05c96  d1 e3                shl bx, 1
05c98  d1 d0                rcl ax, 1
05c9a  d1 e5                shl bp, 1
05c9c  d1 d0                rcl ax, 1
05c9e  86 e0                xchg al, ah
05ca0  26 89 05             mov word ptr es:[di], ax
05ca3  d1 e2                shl dx, 1
05ca5  d1 d0                rcl ax, 1
05ca7  d1 e1                shl cx, 1
05ca9  d1 d0                rcl ax, 1
05cab  d1 e3                shl bx, 1
05cad  d1 d0                rcl ax, 1
05caf  d1 e5                shl bp, 1
05cb1  d1 d0                rcl ax, 1
05cb3  d1 e2                shl dx, 1
05cb5  d1 d0                rcl ax, 1
05cb7  d1 e1                shl cx, 1
05cb9  d1 d0                rcl ax, 1
05cbb  d1 e3                shl bx, 1
05cbd  d1 d0                rcl ax, 1
05cbf  d1 e5                shl bp, 1
05cc1  d1 d0                rcl ax, 1
05cc3  d1 e2                shl dx, 1
05cc5  d1 d0                rcl ax, 1
05cc7  d1 e1                shl cx, 1
05cc9  d1 d0                rcl ax, 1
05ccb  d1 e3                shl bx, 1
05ccd  d1 d0                rcl ax, 1
05ccf  d1 e5                shl bp, 1
05cd1  d1 d0                rcl ax, 1
05cd3  d1 e2                shl dx, 1
05cd5  d1 d0                rcl ax, 1
05cd7  d1 e1                shl cx, 1
05cd9  d1 d0                rcl ax, 1
05cdb  d1 e3                shl bx, 1
05cdd  d1 d0                rcl ax, 1
05cdf  d1 e5                shl bp, 1
05ce1  d1 d0                rcl ax, 1
05ce3  86 e0                xchg al, ah
05ce5  26 89 45 02          mov word ptr es:[di + 2], ax
05ce9  d1 e2                shl dx, 1
05ceb  d1 d0                rcl ax, 1
05ced  d1 e1                shl cx, 1
05cef  d1 d0                rcl ax, 1
05cf1  d1 e3                shl bx, 1
05cf3  d1 d0                rcl ax, 1
05cf5  d1 e5                shl bp, 1
05cf7  d1 d0                rcl ax, 1
05cf9  d1 e2                shl dx, 1
05cfb  d1 d0                rcl ax, 1
05cfd  d1 e1                shl cx, 1
05cff  d1 d0                rcl ax, 1
05d01  d1 e3                shl bx, 1
05d03  d1 d0                rcl ax, 1
05d05  d1 e5                shl bp, 1
05d07  d1 d0                rcl ax, 1
05d09  d1 e2                shl dx, 1
05d0b  d1 d0                rcl ax, 1
05d0d  d1 e1                shl cx, 1
05d0f  d1 d0                rcl ax, 1
05d11  d1 e3                shl bx, 1
05d13  d1 d0                rcl ax, 1
05d15  d1 e5                shl bp, 1
05d17  d1 d0                rcl ax, 1
05d19  d1 e2                shl dx, 1
05d1b  d1 d0                rcl ax, 1
05d1d  d1 e1                shl cx, 1
05d1f  d1 d0                rcl ax, 1
05d21  d1 e3                shl bx, 1
05d23  d1 d0                rcl ax, 1
05d25  d1 e5                shl bp, 1
05d27  d1 d0                rcl ax, 1
05d29  86 e0                xchg al, ah
05d2b  26 89 45 04          mov word ptr es:[di + 4], ax
05d2f  d1 e2                shl dx, 1
05d31  d1 d0                rcl ax, 1
05d33  d1 e1                shl cx, 1
05d35  d1 d0                rcl ax, 1
05d37  d1 e3                shl bx, 1
05d39  d1 d0                rcl ax, 1
05d3b  d1 e5                shl bp, 1
05d3d  d1 d0                rcl ax, 1
05d3f  d1 e2                shl dx, 1
05d41  d1 d0                rcl ax, 1
05d43  d1 e1                shl cx, 1
05d45  d1 d0                rcl ax, 1
05d47  d1 e3                shl bx, 1
05d49  d1 d0                rcl ax, 1
05d4b  d1 e5                shl bp, 1
05d4d  d1 d0                rcl ax, 1
05d4f  d1 e2                shl dx, 1
05d51  d1 d0                rcl ax, 1
05d53  d1 e1                shl cx, 1
05d55  d1 d0                rcl ax, 1
05d57  d1 e3                shl bx, 1
05d59  d1 d0                rcl ax, 1
05d5b  d1 e5                shl bp, 1
05d5d  d1 d0                rcl ax, 1
05d5f  d1 e2                shl dx, 1
05d61  d1 d0                rcl ax, 1
05d63  d1 e1                shl cx, 1
05d65  d1 d0                rcl ax, 1
05d67  d1 e3                shl bx, 1
05d69  d1 d0                rcl ax, 1
05d6b  d1 e5                shl bp, 1
05d6d  d1 d0                rcl ax, 1
05d6f  86 e0                xchg al, ah
05d71  26 89 45 06          mov word ptr es:[di + 6], ax
05d75  83 c6 02             add si, 2
05d78  83 c7 08             add di, 8
05d7b  8a 64 78             mov ah, byte ptr [si + 0x78]
05d7e  8a 44 79             mov al, byte ptr [si + 0x79]
05d81  8b e8                mov bp, ax
05d83  8a 7c 50             mov bh, byte ptr [si + 0x50]
05d86  8a 5c 51             mov bl, byte ptr [si + 0x51]
05d89  8a 6c 28             mov ch, byte ptr [si + 0x28]
05d8c  8a 4c 29             mov cl, byte ptr [si + 0x29]
05d8f  8a 34                mov dh, byte ptr [si]
05d91  8a 54 01             mov dl, byte ptr [si + 1]
05d94  b8 00 00             mov ax, 0
05d97  d1 e2                shl dx, 1
05d99  d1 d0                rcl ax, 1
05d9b  d1 e1                shl cx, 1
05d9d  d1 d0                rcl ax, 1
05d9f  d1 e3                shl bx, 1
05da1  d1 d0                rcl ax, 1
05da3  d1 e5                shl bp, 1
05da5  d1 d0                rcl ax, 1
05da7  d1 e2                shl dx, 1
05da9  d1 d0                rcl ax, 1
05dab  d1 e1                shl cx, 1
05dad  d1 d0                rcl ax, 1
05daf  d1 e3                shl bx, 1
05db1  d1 d0                rcl ax, 1
05db3  d1 e5                shl bp, 1
05db5  d1 d0                rcl ax, 1
05db7  d1 e2                shl dx, 1
05db9  d1 d0                rcl ax, 1
05dbb  d1 e1                shl cx, 1
05dbd  d1 d0                rcl ax, 1
05dbf  d1 e3                shl bx, 1
05dc1  d1 d0                rcl ax, 1
05dc3  d1 e5                shl bp, 1
05dc5  d1 d0                rcl ax, 1
05dc7  d1 e2                shl dx, 1
05dc9  d1 d0                rcl ax, 1
05dcb  d1 e1                shl cx, 1
05dcd  d1 d0                rcl ax, 1
05dcf  d1 e3                shl bx, 1
05dd1  d1 d0                rcl ax, 1
05dd3  d1 e5                shl bp, 1
05dd5  d1 d0                rcl ax, 1
05dd7  86 e0                xchg al, ah
05dd9  26 89 05             mov word ptr es:[di], ax
05ddc  d1 e2                shl dx, 1
05dde  d1 d0                rcl ax, 1
05de0  d1 e1                shl cx, 1
05de2  d1 d0                rcl ax, 1
05de4  d1 e3                shl bx, 1
05de6  d1 d0                rcl ax, 1
05de8  d1 e5                shl bp, 1
05dea  d1 d0                rcl ax, 1
05dec  d1 e2                shl dx, 1
05dee  d1 d0                rcl ax, 1
05df0  d1 e1                shl cx, 1
05df2  d1 d0                rcl ax, 1
05df4  d1 e3                shl bx, 1
05df6  d1 d0                rcl ax, 1
05df8  d1 e5                shl bp, 1
05dfa  d1 d0                rcl ax, 1
05dfc  d1 e2                shl dx, 1
05dfe  d1 d0                rcl ax, 1
05e00  d1 e1                shl cx, 1
05e02  d1 d0                rcl ax, 1
05e04  d1 e3                shl bx, 1
05e06  d1 d0                rcl ax, 1
05e08  d1 e5                shl bp, 1
05e0a  d1 d0                rcl ax, 1
05e0c  d1 e2                shl dx, 1
05e0e  d1 d0                rcl ax, 1
05e10  d1 e1                shl cx, 1
05e12  d1 d0                rcl ax, 1
05e14  d1 e3                shl bx, 1
05e16  d1 d0                rcl ax, 1
05e18  d1 e5                shl bp, 1
05e1a  d1 d0                rcl ax, 1
05e1c  86 e0                xchg al, ah
05e1e  26 89 45 02          mov word ptr es:[di + 2], ax
05e22  d1 e2                shl dx, 1
05e24  d1 d0                rcl ax, 1
05e26  d1 e1                shl cx, 1
05e28  d1 d0                rcl ax, 1
05e2a  d1 e3                shl bx, 1
05e2c  d1 d0                rcl ax, 1
05e2e  d1 e5                shl bp, 1
05e30  d1 d0                rcl ax, 1
05e32  d1 e2                shl dx, 1
05e34  d1 d0                rcl ax, 1
05e36  d1 e1                shl cx, 1
05e38  d1 d0                rcl ax, 1
05e3a  d1 e3                shl bx, 1
05e3c  d1 d0                rcl ax, 1
05e3e  d1 e5                shl bp, 1
05e40  d1 d0                rcl ax, 1
05e42  d1 e2                shl dx, 1
05e44  d1 d0                rcl ax, 1
05e46  d1 e1                shl cx, 1
05e48  d1 d0                rcl ax, 1
05e4a  d1 e3                shl bx, 1
05e4c  d1 d0                rcl ax, 1
05e4e  d1 e5                shl bp, 1
05e50  d1 d0                rcl ax, 1
05e52  d1 e2                shl dx, 1
05e54  d1 d0                rcl ax, 1
05e56  d1 e1                shl cx, 1
05e58  d1 d0                rcl ax, 1
05e5a  d1 e3                shl bx, 1
05e5c  d1 d0                rcl ax, 1
05e5e  d1 e5                shl bp, 1
05e60  d1 d0                rcl ax, 1
05e62  86 e0                xchg al, ah
05e64  26 89 45 04          mov word ptr es:[di + 4], ax
05e68  d1 e2                shl dx, 1
05e6a  d1 d0                rcl ax, 1
05e6c  d1 e1                shl cx, 1
05e6e  d1 d0                rcl ax, 1
05e70  d1 e3                shl bx, 1
05e72  d1 d0                rcl ax, 1
05e74  d1 e5                shl bp, 1
05e76  d1 d0                rcl ax, 1
05e78  d1 e2                shl dx, 1
05e7a  d1 d0                rcl ax, 1
05e7c  d1 e1                shl cx, 1
05e7e  d1 d0                rcl ax, 1
05e80  d1 e3                shl bx, 1
05e82  d1 d0                rcl ax, 1
05e84  d1 e5                shl bp, 1
05e86  d1 d0                rcl ax, 1
05e88  d1 e2                shl dx, 1
05e8a  d1 d0                rcl ax, 1
05e8c  d1 e1                shl cx, 1
05e8e  d1 d0                rcl ax, 1
05e90  d1 e3                shl bx, 1
05e92  d1 d0                rcl ax, 1
05e94  d1 e5                shl bp, 1
05e96  d1 d0                rcl ax, 1
05e98  d1 e2                shl dx, 1
05e9a  d1 d0                rcl ax, 1
05e9c  d1 e1                shl cx, 1
05e9e  d1 d0                rcl ax, 1
05ea0  d1 e3                shl bx, 1
05ea2  d1 d0                rcl ax, 1
05ea4  d1 e5                shl bp, 1
05ea6  d1 d0                rcl ax, 1
05ea8  86 e0                xchg al, ah
05eaa  26 89 45 06          mov word ptr es:[di + 6], ax
05eae  83 c6 02             add si, 2
05eb1  83 c7 08             add di, 8
05eb4  8a 64 78             mov ah, byte ptr [si + 0x78]
05eb7  8a 44 79             mov al, byte ptr [si + 0x79]
05eba  8b e8                mov bp, ax
05ebc  8a 7c 50             mov bh, byte ptr [si + 0x50]
05ebf  8a 5c 51             mov bl, byte ptr [si + 0x51]
05ec2  8a 6c 28             mov ch, byte ptr [si + 0x28]
05ec5  8a 4c 29             mov cl, byte ptr [si + 0x29]
05ec8  8a 34                mov dh, byte ptr [si]
05eca  8a 54 01             mov dl, byte ptr [si + 1]
05ecd  b8 00 00             mov ax, 0
05ed0  d1 e2                shl dx, 1
05ed2  d1 d0                rcl ax, 1
05ed4  d1 e1                shl cx, 1
05ed6  d1 d0                rcl ax, 1
05ed8  d1 e3                shl bx, 1
05eda  d1 d0                rcl ax, 1
05edc  d1 e5                shl bp, 1
05ede  d1 d0                rcl ax, 1
05ee0  d1 e2                shl dx, 1
05ee2  d1 d0                rcl ax, 1
05ee4  d1 e1                shl cx, 1
05ee6  d1 d0                rcl ax, 1
05ee8  d1 e3                shl bx, 1
05eea  d1 d0                rcl ax, 1
05eec  d1 e5                shl bp, 1
05eee  d1 d0                rcl ax, 1
05ef0  d1 e2                shl dx, 1
05ef2  d1 d0                rcl ax, 1
05ef4  d1 e1                shl cx, 1
05ef6  d1 d0                rcl ax, 1
05ef8  d1 e3                shl bx, 1
05efa  d1 d0                rcl ax, 1
05efc  d1 e5                shl bp, 1
05efe  d1 d0                rcl ax, 1
05f00  d1 e2                shl dx, 1
05f02  d1 d0                rcl ax, 1
05f04  d1 e1                shl cx, 1
05f06  d1 d0                rcl ax, 1
05f08  d1 e3                shl bx, 1
05f0a  d1 d0                rcl ax, 1
05f0c  d1 e5                shl bp, 1
05f0e  d1 d0                rcl ax, 1
05f10  86 e0                xchg al, ah
05f12  26 89 05             mov word ptr es:[di], ax
05f15  d1 e2                shl dx, 1
05f17  d1 d0                rcl ax, 1
05f19  d1 e1                shl cx, 1
05f1b  d1 d0                rcl ax, 1
05f1d  d1 e3                shl bx, 1
05f1f  d1 d0                rcl ax, 1
05f21  d1 e5                shl bp, 1
05f23  d1 d0                rcl ax, 1
05f25  d1 e2                shl dx, 1
05f27  d1 d0                rcl ax, 1
05f29  d1 e1                shl cx, 1
05f2b  d1 d0                rcl ax, 1
05f2d  d1 e3                shl bx, 1
05f2f  d1 d0                rcl ax, 1
05f31  d1 e5                shl bp, 1
05f33  d1 d0                rcl ax, 1
05f35  d1 e2                shl dx, 1
05f37  d1 d0                rcl ax, 1
05f39  d1 e1                shl cx, 1
05f3b  d1 d0                rcl ax, 1
05f3d  d1 e3                shl bx, 1
05f3f  d1 d0                rcl ax, 1
05f41  d1 e5                shl bp, 1
05f43  d1 d0                rcl ax, 1
05f45  d1 e2                shl dx, 1
05f47  d1 d0                rcl ax, 1
05f49  d1 e1                shl cx, 1
05f4b  d1 d0                rcl ax, 1
05f4d  d1 e3                shl bx, 1
05f4f  d1 d0                rcl ax, 1
05f51  d1 e5                shl bp, 1
05f53  d1 d0                rcl ax, 1
05f55  86 e0                xchg al, ah
05f57  26 89 45 02          mov word ptr es:[di + 2], ax
05f5b  d1 e2                shl dx, 1
05f5d  d1 d0                rcl ax, 1
05f5f  d1 e1                shl cx, 1
05f61  d1 d0                rcl ax, 1
05f63  d1 e3                shl bx, 1
05f65  d1 d0                rcl ax, 1
05f67  d1 e5                shl bp, 1
05f69  d1 d0                rcl ax, 1
05f6b  d1 e2                shl dx, 1
05f6d  d1 d0                rcl ax, 1
05f6f  d1 e1                shl cx, 1
05f71  d1 d0                rcl ax, 1
05f73  d1 e3                shl bx, 1
05f75  d1 d0                rcl ax, 1
05f77  d1 e5                shl bp, 1
05f79  d1 d0                rcl ax, 1
05f7b  d1 e2                shl dx, 1
05f7d  d1 d0                rcl ax, 1
05f7f  d1 e1                shl cx, 1
05f81  d1 d0                rcl ax, 1
05f83  d1 e3                shl bx, 1
05f85  d1 d0                rcl ax, 1
05f87  d1 e5                shl bp, 1
05f89  d1 d0                rcl ax, 1
05f8b  d1 e2                shl dx, 1
05f8d  d1 d0                rcl ax, 1
05f8f  d1 e1                shl cx, 1
05f91  d1 d0                rcl ax, 1
05f93  d1 e3                shl bx, 1
05f95  d1 d0                rcl ax, 1
05f97  d1 e5                shl bp, 1
05f99  d1 d0                rcl ax, 1
05f9b  86 e0                xchg al, ah
05f9d  26 89 45 04          mov word ptr es:[di + 4], ax
05fa1  d1 e2                shl dx, 1
05fa3  d1 d0                rcl ax, 1
05fa5  d1 e1                shl cx, 1
05fa7  d1 d0                rcl ax, 1
05fa9  d1 e3                shl bx, 1
05fab  d1 d0                rcl ax, 1
05fad  d1 e5                shl bp, 1
05faf  d1 d0                rcl ax, 1
05fb1  d1 e2                shl dx, 1
05fb3  d1 d0                rcl ax, 1
05fb5  d1 e1                shl cx, 1
05fb7  d1 d0                rcl ax, 1
05fb9  d1 e3                shl bx, 1
05fbb  d1 d0                rcl ax, 1
05fbd  d1 e5                shl bp, 1
05fbf  d1 d0                rcl ax, 1
05fc1  d1 e2                shl dx, 1
05fc3  d1 d0                rcl ax, 1
05fc5  d1 e1                shl cx, 1
05fc7  d1 d0                rcl ax, 1
05fc9  d1 e3                shl bx, 1
05fcb  d1 d0                rcl ax, 1
05fcd  d1 e5                shl bp, 1
05fcf  d1 d0                rcl ax, 1
05fd1  d1 e2                shl dx, 1
05fd3  d1 d0                rcl ax, 1
05fd5  d1 e1                shl cx, 1
05fd7  d1 d0                rcl ax, 1
05fd9  d1 e3                shl bx, 1
05fdb  d1 d0                rcl ax, 1
05fdd  d1 e5                shl bp, 1
05fdf  d1 d0                rcl ax, 1
05fe1  86 e0                xchg al, ah
05fe3  26 89 45 06          mov word ptr es:[di + 6], ax
05fe7  83 c6 02             add si, 2
05fea  83 c7 08             add di, 8
05fed  8a 64 78             mov ah, byte ptr [si + 0x78]
05ff0  8a 44 79             mov al, byte ptr [si + 0x79]
05ff3  8b e8                mov bp, ax
05ff5  8a 7c 50             mov bh, byte ptr [si + 0x50]
05ff8  8a 5c 51             mov bl, byte ptr [si + 0x51]
05ffb  8a 6c 28             mov ch, byte ptr [si + 0x28]
05ffe  8a 4c 29             mov cl, byte ptr [si + 0x29]
06001  8a 34                mov dh, byte ptr [si]
06003  8a 54 01             mov dl, byte ptr [si + 1]
06006  b8 00 00             mov ax, 0
06009  d1 e2                shl dx, 1
0600b  d1 d0                rcl ax, 1
0600d  d1 e1                shl cx, 1
0600f  d1 d0                rcl ax, 1
06011  d1 e3                shl bx, 1
06013  d1 d0                rcl ax, 1
06015  d1 e5                shl bp, 1
06017  d1 d0                rcl ax, 1
06019  d1 e2                shl dx, 1
0601b  d1 d0                rcl ax, 1
0601d  d1 e1                shl cx, 1
0601f  d1 d0                rcl ax, 1
06021  d1 e3                shl bx, 1
06023  d1 d0                rcl ax, 1
06025  d1 e5                shl bp, 1
06027  d1 d0                rcl ax, 1
06029  d1 e2                shl dx, 1
0602b  d1 d0                rcl ax, 1
0602d  d1 e1                shl cx, 1
0602f  d1 d0                rcl ax, 1
06031  d1 e3                shl bx, 1
06033  d1 d0                rcl ax, 1
06035  d1 e5                shl bp, 1
06037  d1 d0                rcl ax, 1
06039  d1 e2                shl dx, 1
0603b  d1 d0                rcl ax, 1
0603d  d1 e1                shl cx, 1
0603f  d1 d0                rcl ax, 1
06041  d1 e3                shl bx, 1
06043  d1 d0                rcl ax, 1
06045  d1 e5                shl bp, 1
06047  d1 d0                rcl ax, 1
06049  86 e0                xchg al, ah
0604b  26 89 05             mov word ptr es:[di], ax
0604e  d1 e2                shl dx, 1
06050  d1 d0                rcl ax, 1
06052  d1 e1                shl cx, 1
06054  d1 d0                rcl ax, 1
06056  d1 e3                shl bx, 1
06058  d1 d0                rcl ax, 1
0605a  d1 e5                shl bp, 1
0605c  d1 d0                rcl ax, 1
0605e  d1 e2                shl dx, 1
06060  d1 d0                rcl ax, 1
06062  d1 e1                shl cx, 1
06064  d1 d0                rcl ax, 1
06066  d1 e3                shl bx, 1
06068  d1 d0                rcl ax, 1
0606a  d1 e5                shl bp, 1
0606c  d1 d0                rcl ax, 1
0606e  d1 e2                shl dx, 1
06070  d1 d0                rcl ax, 1
06072  d1 e1                shl cx, 1
06074  d1 d0                rcl ax, 1
06076  d1 e3                shl bx, 1
06078  d1 d0                rcl ax, 1
0607a  d1 e5                shl bp, 1
0607c  d1 d0                rcl ax, 1
0607e  d1 e2                shl dx, 1
06080  d1 d0                rcl ax, 1
06082  d1 e1                shl cx, 1
06084  d1 d0                rcl ax, 1
06086  d1 e3                shl bx, 1
06088  d1 d0                rcl ax, 1
0608a  d1 e5                shl bp, 1
0608c  d1 d0                rcl ax, 1
0608e  86 e0                xchg al, ah
06090  26 89 45 02          mov word ptr es:[di + 2], ax
06094  d1 e2                shl dx, 1
06096  d1 d0                rcl ax, 1
06098  d1 e1                shl cx, 1
0609a  d1 d0                rcl ax, 1
0609c  d1 e3                shl bx, 1
0609e  d1 d0                rcl ax, 1
060a0  d1 e5                shl bp, 1
060a2  d1 d0                rcl ax, 1
060a4  d1 e2                shl dx, 1
060a6  d1 d0                rcl ax, 1
060a8  d1 e1                shl cx, 1
060aa  d1 d0                rcl ax, 1
060ac  d1 e3                shl bx, 1
060ae  d1 d0                rcl ax, 1
060b0  d1 e5                shl bp, 1
060b2  d1 d0                rcl ax, 1
060b4  d1 e2                shl dx, 1
060b6  d1 d0                rcl ax, 1
060b8  d1 e1                shl cx, 1
060ba  d1 d0                rcl ax, 1
060bc  d1 e3                shl bx, 1
060be  d1 d0                rcl ax, 1
060c0  d1 e5                shl bp, 1
060c2  d1 d0                rcl ax, 1
060c4  d1 e2                shl dx, 1
060c6  d1 d0                rcl ax, 1
060c8  d1 e1                shl cx, 1
060ca  d1 d0                rcl ax, 1
060cc  d1 e3                shl bx, 1
060ce  d1 d0                rcl ax, 1
060d0  d1 e5                shl bp, 1
060d2  d1 d0                rcl ax, 1
060d4  86 e0                xchg al, ah
060d6  26 89 45 04          mov word ptr es:[di + 4], ax
060da  d1 e2                shl dx, 1
060dc  d1 d0                rcl ax, 1
060de  d1 e1                shl cx, 1
060e0  d1 d0                rcl ax, 1
060e2  d1 e3                shl bx, 1
060e4  d1 d0                rcl ax, 1
060e6  d1 e5                shl bp, 1
060e8  d1 d0                rcl ax, 1
060ea  d1 e2                shl dx, 1
060ec  d1 d0                rcl ax, 1
060ee  d1 e1                shl cx, 1
060f0  d1 d0                rcl ax, 1
060f2  d1 e3                shl bx, 1
060f4  d1 d0                rcl ax, 1
060f6  d1 e5                shl bp, 1
060f8  d1 d0                rcl ax, 1
060fa  d1 e2                shl dx, 1
060fc  d1 d0                rcl ax, 1
060fe  d1 e1                shl cx, 1
06100  d1 d0                rcl ax, 1
06102  d1 e3                shl bx, 1
06104  d1 d0                rcl ax, 1
06106  d1 e5                shl bp, 1
06108  d1 d0                rcl ax, 1
0610a  d1 e2                shl dx, 1
0610c  d1 d0                rcl ax, 1
0610e  d1 e1                shl cx, 1
06110  d1 d0                rcl ax, 1
06112  d1 e3                shl bx, 1
06114  d1 d0                rcl ax, 1
06116  d1 e5                shl bp, 1
06118  d1 d0                rcl ax, 1
0611a  86 e0                xchg al, ah
0611c  26 89 45 06          mov word ptr es:[di + 6], ax
06120  83 c6 02             add si, 2
06123  83 c7 08             add di, 8
06126  8a 64 78             mov ah, byte ptr [si + 0x78]
06129  8a 44 79             mov al, byte ptr [si + 0x79]
0612c  8b e8                mov bp, ax
0612e  8a 7c 50             mov bh, byte ptr [si + 0x50]
06131  8a 5c 51             mov bl, byte ptr [si + 0x51]
06134  8a 6c 28             mov ch, byte ptr [si + 0x28]
06137  8a 4c 29             mov cl, byte ptr [si + 0x29]
0613a  8a 34                mov dh, byte ptr [si]
0613c  8a 54 01             mov dl, byte ptr [si + 1]
0613f  b8 00 00             mov ax, 0
06142  d1 e2                shl dx, 1
06144  d1 d0                rcl ax, 1
06146  d1 e1                shl cx, 1
06148  d1 d0                rcl ax, 1
0614a  d1 e3                shl bx, 1
0614c  d1 d0                rcl ax, 1
0614e  d1 e5                shl bp, 1
06150  d1 d0                rcl ax, 1
06152  d1 e2                shl dx, 1
06154  d1 d0                rcl ax, 1
06156  d1 e1                shl cx, 1
06158  d1 d0                rcl ax, 1
0615a  d1 e3                shl bx, 1
0615c  d1 d0                rcl ax, 1
0615e  d1 e5                shl bp, 1
06160  d1 d0                rcl ax, 1
06162  d1 e2                shl dx, 1
06164  d1 d0                rcl ax, 1
06166  d1 e1                shl cx, 1
06168  d1 d0                rcl ax, 1
0616a  d1 e3                shl bx, 1
0616c  d1 d0                rcl ax, 1
0616e  d1 e5                shl bp, 1
06170  d1 d0                rcl ax, 1
06172  d1 e2                shl dx, 1
06174  d1 d0                rcl ax, 1
06176  d1 e1                shl cx, 1
06178  d1 d0                rcl ax, 1
0617a  d1 e3                shl bx, 1
0617c  d1 d0                rcl ax, 1
0617e  d1 e5                shl bp, 1
06180  d1 d0                rcl ax, 1
06182  86 e0                xchg al, ah
06184  26 89 05             mov word ptr es:[di], ax
06187  d1 e2                shl dx, 1
06189  d1 d0                rcl ax, 1
0618b  d1 e1                shl cx, 1
0618d  d1 d0                rcl ax, 1
0618f  d1 e3                shl bx, 1
06191  d1 d0                rcl ax, 1
06193  d1 e5                shl bp, 1
06195  d1 d0                rcl ax, 1
06197  d1 e2                shl dx, 1
06199  d1 d0                rcl ax, 1
0619b  d1 e1                shl cx, 1
0619d  d1 d0                rcl ax, 1
0619f  d1 e3                shl bx, 1
061a1  d1 d0                rcl ax, 1
061a3  d1 e5                shl bp, 1
061a5  d1 d0                rcl ax, 1
061a7  d1 e2                shl dx, 1
061a9  d1 d0                rcl ax, 1
061ab  d1 e1                shl cx, 1
061ad  d1 d0                rcl ax, 1
061af  d1 e3                shl bx, 1
061b1  d1 d0                rcl ax, 1
061b3  d1 e5                shl bp, 1
061b5  d1 d0                rcl ax, 1
061b7  d1 e2                shl dx, 1
061b9  d1 d0                rcl ax, 1
061bb  d1 e1                shl cx, 1
061bd  d1 d0                rcl ax, 1
061bf  d1 e3                shl bx, 1
061c1  d1 d0                rcl ax, 1
061c3  d1 e5                shl bp, 1
061c5  d1 d0                rcl ax, 1
061c7  86 e0                xchg al, ah
061c9  26 89 45 02          mov word ptr es:[di + 2], ax
061cd  d1 e2                shl dx, 1
061cf  d1 d0                rcl ax, 1
061d1  d1 e1                shl cx, 1
061d3  d1 d0                rcl ax, 1
061d5  d1 e3                shl bx, 1
061d7  d1 d0                rcl ax, 1
061d9  d1 e5                shl bp, 1
061db  d1 d0                rcl ax, 1
061dd  d1 e2                shl dx, 1
061df  d1 d0                rcl ax, 1
061e1  d1 e1                shl cx, 1
061e3  d1 d0                rcl ax, 1
061e5  d1 e3                shl bx, 1
061e7  d1 d0                rcl ax, 1
061e9  d1 e5                shl bp, 1
061eb  d1 d0                rcl ax, 1
061ed  d1 e2                shl dx, 1
061ef  d1 d0                rcl ax, 1
061f1  d1 e1                shl cx, 1
061f3  d1 d0                rcl ax, 1
061f5  d1 e3                shl bx, 1
061f7  d1 d0                rcl ax, 1
061f9  d1 e5                shl bp, 1
061fb  d1 d0                rcl ax, 1
061fd  d1 e2                shl dx, 1
061ff  d1 d0                rcl ax, 1
06201  d1 e1                shl cx, 1
06203  d1 d0                rcl ax, 1
06205  d1 e3                shl bx, 1
06207  d1 d0                rcl ax, 1
06209  d1 e5                shl bp, 1
0620b  d1 d0                rcl ax, 1
0620d  86 e0                xchg al, ah
0620f  26 89 45 04          mov word ptr es:[di + 4], ax
06213  d1 e2                shl dx, 1
06215  d1 d0                rcl ax, 1
06217  d1 e1                shl cx, 1
06219  d1 d0                rcl ax, 1
0621b  d1 e3                shl bx, 1
0621d  d1 d0                rcl ax, 1
0621f  d1 e5                shl bp, 1
06221  d1 d0                rcl ax, 1
06223  d1 e2                shl dx, 1
06225  d1 d0                rcl ax, 1
06227  d1 e1                shl cx, 1
06229  d1 d0                rcl ax, 1
0622b  d1 e3                shl bx, 1
0622d  d1 d0                rcl ax, 1
0622f  d1 e5                shl bp, 1
06231  d1 d0                rcl ax, 1
06233  d1 e2                shl dx, 1
06235  d1 d0                rcl ax, 1
06237  d1 e1                shl cx, 1
06239  d1 d0                rcl ax, 1
0623b  d1 e3                shl bx, 1
0623d  d1 d0                rcl ax, 1
0623f  d1 e5                shl bp, 1
06241  d1 d0                rcl ax, 1
06243  d1 e2                shl dx, 1
06245  d1 d0                rcl ax, 1
06247  d1 e1                shl cx, 1
06249  d1 d0                rcl ax, 1
0624b  d1 e3                shl bx, 1
0624d  d1 d0                rcl ax, 1
0624f  d1 e5                shl bp, 1
06251  d1 d0                rcl ax, 1
06253  86 e0                xchg al, ah
06255  26 89 45 06          mov word ptr es:[di + 6], ax
06259  83 c6 02             add si, 2
0625c  83 c7 08             add di, 8
0625f  8a 64 78             mov ah, byte ptr [si + 0x78]
06262  8a 44 79             mov al, byte ptr [si + 0x79]
06265  8b e8                mov bp, ax
06267  8a 7c 50             mov bh, byte ptr [si + 0x50]
0626a  8a 5c 51             mov bl, byte ptr [si + 0x51]
0626d  8a 6c 28             mov ch, byte ptr [si + 0x28]
06270  8a 4c 29             mov cl, byte ptr [si + 0x29]
06273  8a 34                mov dh, byte ptr [si]
06275  8a 54 01             mov dl, byte ptr [si + 1]
06278  b8 00 00             mov ax, 0
0627b  d1 e2                shl dx, 1
0627d  d1 d0                rcl ax, 1
0627f  d1 e1                shl cx, 1
06281  d1 d0                rcl ax, 1
06283  d1 e3                shl bx, 1
06285  d1 d0                rcl ax, 1
06287  d1 e5                shl bp, 1
06289  d1 d0                rcl ax, 1
0628b  d1 e2                shl dx, 1
0628d  d1 d0                rcl ax, 1
0628f  d1 e1                shl cx, 1
06291  d1 d0                rcl ax, 1
06293  d1 e3                shl bx, 1
06295  d1 d0                rcl ax, 1
06297  d1 e5                shl bp, 1
06299  d1 d0                rcl ax, 1
0629b  d1 e2                shl dx, 1
0629d  d1 d0                rcl ax, 1
0629f  d1 e1                shl cx, 1
062a1  d1 d0                rcl ax, 1
062a3  d1 e3                shl bx, 1
062a5  d1 d0                rcl ax, 1
062a7  d1 e5                shl bp, 1
062a9  d1 d0                rcl ax, 1
062ab  d1 e2                shl dx, 1
062ad  d1 d0                rcl ax, 1
062af  d1 e1                shl cx, 1
062b1  d1 d0                rcl ax, 1
062b3  d1 e3                shl bx, 1
062b5  d1 d0                rcl ax, 1
062b7  d1 e5                shl bp, 1
062b9  d1 d0                rcl ax, 1
062bb  86 e0                xchg al, ah
062bd  26 89 05             mov word ptr es:[di], ax
062c0  d1 e2                shl dx, 1
062c2  d1 d0                rcl ax, 1
062c4  d1 e1                shl cx, 1
062c6  d1 d0                rcl ax, 1
062c8  d1 e3                shl bx, 1
062ca  d1 d0                rcl ax, 1
062cc  d1 e5                shl bp, 1
062ce  d1 d0                rcl ax, 1
062d0  d1 e2                shl dx, 1
062d2  d1 d0                rcl ax, 1
062d4  d1 e1                shl cx, 1
062d6  d1 d0                rcl ax, 1
062d8  d1 e3                shl bx, 1
062da  d1 d0                rcl ax, 1
062dc  d1 e5                shl bp, 1
062de  d1 d0                rcl ax, 1
062e0  d1 e2                shl dx, 1
062e2  d1 d0                rcl ax, 1
062e4  d1 e1                shl cx, 1
062e6  d1 d0                rcl ax, 1
062e8  d1 e3                shl bx, 1
062ea  d1 d0                rcl ax, 1
062ec  d1 e5                shl bp, 1
062ee  d1 d0                rcl ax, 1
062f0  d1 e2                shl dx, 1
062f2  d1 d0                rcl ax, 1
062f4  d1 e1                shl cx, 1
062f6  d1 d0                rcl ax, 1
062f8  d1 e3                shl bx, 1
062fa  d1 d0                rcl ax, 1
062fc  d1 e5                shl bp, 1
062fe  d1 d0                rcl ax, 1
06300  86 e0                xchg al, ah
06302  26 89 45 02          mov word ptr es:[di + 2], ax
06306  d1 e2                shl dx, 1
06308  d1 d0                rcl ax, 1
0630a  d1 e1                shl cx, 1
0630c  d1 d0                rcl ax, 1
0630e  d1 e3                shl bx, 1
06310  d1 d0                rcl ax, 1
06312  d1 e5                shl bp, 1
06314  d1 d0                rcl ax, 1
06316  d1 e2                shl dx, 1
06318  d1 d0                rcl ax, 1
0631a  d1 e1                shl cx, 1
0631c  d1 d0                rcl ax, 1
0631e  d1 e3                shl bx, 1
06320  d1 d0                rcl ax, 1
06322  d1 e5                shl bp, 1
06324  d1 d0                rcl ax, 1
06326  d1 e2                shl dx, 1
06328  d1 d0                rcl ax, 1
0632a  d1 e1                shl cx, 1
0632c  d1 d0                rcl ax, 1
0632e  d1 e3                shl bx, 1
06330  d1 d0                rcl ax, 1
06332  d1 e5                shl bp, 1
06334  d1 d0                rcl ax, 1
06336  d1 e2                shl dx, 1
06338  d1 d0                rcl ax, 1
0633a  d1 e1                shl cx, 1
0633c  d1 d0                rcl ax, 1
0633e  d1 e3                shl bx, 1
06340  d1 d0                rcl ax, 1
06342  d1 e5                shl bp, 1
06344  d1 d0                rcl ax, 1
06346  86 e0                xchg al, ah
06348  26 89 45 04          mov word ptr es:[di + 4], ax
0634c  d1 e2                shl dx, 1
0634e  d1 d0                rcl ax, 1
06350  d1 e1                shl cx, 1
06352  d1 d0                rcl ax, 1
06354  d1 e3                shl bx, 1
06356  d1 d0                rcl ax, 1
06358  d1 e5                shl bp, 1
0635a  d1 d0                rcl ax, 1
0635c  d1 e2                shl dx, 1
0635e  d1 d0                rcl ax, 1
06360  d1 e1                shl cx, 1
06362  d1 d0                rcl ax, 1
06364  d1 e3                shl bx, 1
06366  d1 d0                rcl ax, 1
06368  d1 e5                shl bp, 1
0636a  d1 d0                rcl ax, 1
0636c  d1 e2                shl dx, 1
0636e  d1 d0                rcl ax, 1
06370  d1 e1                shl cx, 1
06372  d1 d0                rcl ax, 1
06374  d1 e3                shl bx, 1
06376  d1 d0                rcl ax, 1
06378  d1 e5                shl bp, 1
0637a  d1 d0                rcl ax, 1
0637c  d1 e2                shl dx, 1
0637e  d1 d0                rcl ax, 1
06380  d1 e1                shl cx, 1
06382  d1 d0                rcl ax, 1
06384  d1 e3                shl bx, 1
06386  d1 d0                rcl ax, 1
06388  d1 e5                shl bp, 1
0638a  d1 d0                rcl ax, 1
0638c  86 e0                xchg al, ah
0638e  26 89 45 06          mov word ptr es:[di + 6], ax
06392  83 c6 02             add si, 2
06395  83 c7 08             add di, 8
06398  8a 64 78             mov ah, byte ptr [si + 0x78]
0639b  8a 44 79             mov al, byte ptr [si + 0x79]
0639e  8b e8                mov bp, ax
063a0  8a 7c 50             mov bh, byte ptr [si + 0x50]
063a3  8a 5c 51             mov bl, byte ptr [si + 0x51]
063a6  8a 6c 28             mov ch, byte ptr [si + 0x28]
063a9  8a 4c 29             mov cl, byte ptr [si + 0x29]
063ac  8a 34                mov dh, byte ptr [si]
063ae  8a 54 01             mov dl, byte ptr [si + 1]
063b1  b8 00 00             mov ax, 0
063b4  d1 e2                shl dx, 1
063b6  d1 d0                rcl ax, 1
063b8  d1 e1                shl cx, 1
063ba  d1 d0                rcl ax, 1
063bc  d1 e3                shl bx, 1
063be  d1 d0                rcl ax, 1
063c0  d1 e5                shl bp, 1
063c2  d1 d0                rcl ax, 1
063c4  d1 e2                shl dx, 1
063c6  d1 d0                rcl ax, 1
063c8  d1 e1                shl cx, 1
063ca  d1 d0                rcl ax, 1
063cc  d1 e3                shl bx, 1
063ce  d1 d0                rcl ax, 1
063d0  d1 e5                shl bp, 1
063d2  d1 d0                rcl ax, 1
063d4  d1 e2                shl dx, 1
063d6  d1 d0                rcl ax, 1
063d8  d1 e1                shl cx, 1
063da  d1 d0                rcl ax, 1
063dc  d1 e3                shl bx, 1
063de  d1 d0                rcl ax, 1
063e0  d1 e5                shl bp, 1
063e2  d1 d0                rcl ax, 1
063e4  d1 e2                shl dx, 1
063e6  d1 d0                rcl ax, 1
063e8  d1 e1                shl cx, 1
063ea  d1 d0                rcl ax, 1
063ec  d1 e3                shl bx, 1
063ee  d1 d0                rcl ax, 1
063f0  d1 e5                shl bp, 1
063f2  d1 d0                rcl ax, 1
063f4  86 e0                xchg al, ah
063f6  26 89 05             mov word ptr es:[di], ax
063f9  d1 e2                shl dx, 1
063fb  d1 d0                rcl ax, 1
063fd  d1 e1                shl cx, 1
063ff  d1 d0                rcl ax, 1
06401  d1 e3                shl bx, 1
06403  d1 d0                rcl ax, 1
06405  d1 e5                shl bp, 1
06407  d1 d0                rcl ax, 1
06409  d1 e2                shl dx, 1
0640b  d1 d0                rcl ax, 1
0640d  d1 e1                shl cx, 1
0640f  d1 d0                rcl ax, 1
06411  d1 e3                shl bx, 1
06413  d1 d0                rcl ax, 1
06415  d1 e5                shl bp, 1
06417  d1 d0                rcl ax, 1
06419  d1 e2                shl dx, 1
0641b  d1 d0                rcl ax, 1
0641d  d1 e1                shl cx, 1
0641f  d1 d0                rcl ax, 1
06421  d1 e3                shl bx, 1
06423  d1 d0                rcl ax, 1
06425  d1 e5                shl bp, 1
06427  d1 d0                rcl ax, 1
06429  d1 e2                shl dx, 1
0642b  d1 d0                rcl ax, 1
0642d  d1 e1                shl cx, 1
0642f  d1 d0                rcl ax, 1
06431  d1 e3                shl bx, 1
06433  d1 d0                rcl ax, 1
06435  d1 e5                shl bp, 1
06437  d1 d0                rcl ax, 1
06439  86 e0                xchg al, ah
0643b  26 89 45 02          mov word ptr es:[di + 2], ax
0643f  d1 e2                shl dx, 1
06441  d1 d0                rcl ax, 1
06443  d1 e1                shl cx, 1
06445  d1 d0                rcl ax, 1
06447  d1 e3                shl bx, 1
06449  d1 d0                rcl ax, 1
0644b  d1 e5                shl bp, 1
0644d  d1 d0                rcl ax, 1
0644f  d1 e2                shl dx, 1
06451  d1 d0                rcl ax, 1
06453  d1 e1                shl cx, 1
06455  d1 d0                rcl ax, 1
06457  d1 e3                shl bx, 1
06459  d1 d0                rcl ax, 1
0645b  d1 e5                shl bp, 1
0645d  d1 d0                rcl ax, 1
0645f  d1 e2                shl dx, 1
06461  d1 d0                rcl ax, 1
06463  d1 e1                shl cx, 1
06465  d1 d0                rcl ax, 1
06467  d1 e3                shl bx, 1
06469  d1 d0                rcl ax, 1
0646b  d1 e5                shl bp, 1
0646d  d1 d0                rcl ax, 1
0646f  d1 e2                shl dx, 1
06471  d1 d0                rcl ax, 1
06473  d1 e1                shl cx, 1
06475  d1 d0                rcl ax, 1
06477  d1 e3                shl bx, 1
06479  d1 d0                rcl ax, 1
0647b  d1 e5                shl bp, 1
0647d  d1 d0                rcl ax, 1
0647f  86 e0                xchg al, ah
06481  26 89 45 04          mov word ptr es:[di + 4], ax
06485  d1 e2                shl dx, 1
06487  d1 d0                rcl ax, 1
06489  d1 e1                shl cx, 1
0648b  d1 d0                rcl ax, 1
0648d  d1 e3                shl bx, 1
0648f  d1 d0                rcl ax, 1
06491  d1 e5                shl bp, 1
06493  d1 d0                rcl ax, 1
06495  d1 e2                shl dx, 1
06497  d1 d0                rcl ax, 1
06499  d1 e1                shl cx, 1
0649b  d1 d0                rcl ax, 1
0649d  d1 e3                shl bx, 1
0649f  d1 d0                rcl ax, 1
064a1  d1 e5                shl bp, 1
064a3  d1 d0                rcl ax, 1
064a5  d1 e2                shl dx, 1
064a7  d1 d0                rcl ax, 1
064a9  d1 e1                shl cx, 1
064ab  d1 d0                rcl ax, 1
064ad  d1 e3                shl bx, 1
064af  d1 d0                rcl ax, 1
064b1  d1 e5                shl bp, 1
064b3  d1 d0                rcl ax, 1
064b5  d1 e2                shl dx, 1
064b7  d1 d0                rcl ax, 1
064b9  d1 e1                shl cx, 1
064bb  d1 d0                rcl ax, 1
064bd  d1 e3                shl bx, 1
064bf  d1 d0                rcl ax, 1
064c1  d1 e5                shl bp, 1
064c3  d1 d0                rcl ax, 1
064c5  86 e0                xchg al, ah
064c7  26 89 45 06          mov word ptr es:[di + 6], ax
064cb  83 c6 02             add si, 2
064ce  83 c7 08             add di, 8
064d1  8a 64 78             mov ah, byte ptr [si + 0x78]
064d4  8a 44 79             mov al, byte ptr [si + 0x79]
064d7  8b e8                mov bp, ax
064d9  8a 7c 50             mov bh, byte ptr [si + 0x50]
064dc  8a 5c 51             mov bl, byte ptr [si + 0x51]
064df  8a 6c 28             mov ch, byte ptr [si + 0x28]
064e2  8a 4c 29             mov cl, byte ptr [si + 0x29]
064e5  8a 34                mov dh, byte ptr [si]
064e7  8a 54 01             mov dl, byte ptr [si + 1]
064ea  b8 00 00             mov ax, 0
064ed  d1 e2                shl dx, 1
064ef  d1 d0                rcl ax, 1
064f1  d1 e1                shl cx, 1
064f3  d1 d0                rcl ax, 1
064f5  d1 e3                shl bx, 1
064f7  d1 d0                rcl ax, 1
064f9  d1 e5                shl bp, 1
064fb  d1 d0                rcl ax, 1
064fd  d1 e2                shl dx, 1
064ff  d1 d0                rcl ax, 1
06501  d1 e1                shl cx, 1
06503  d1 d0                rcl ax, 1
06505  d1 e3                shl bx, 1
06507  d1 d0                rcl ax, 1
06509  d1 e5                shl bp, 1
0650b  d1 d0                rcl ax, 1
0650d  d1 e2                shl dx, 1
0650f  d1 d0                rcl ax, 1
06511  d1 e1                shl cx, 1
06513  d1 d0                rcl ax, 1
06515  d1 e3                shl bx, 1
06517  d1 d0                rcl ax, 1
06519  d1 e5                shl bp, 1
0651b  d1 d0                rcl ax, 1
0651d  d1 e2                shl dx, 1
0651f  d1 d0                rcl ax, 1
06521  d1 e1                shl cx, 1
06523  d1 d0                rcl ax, 1
06525  d1 e3                shl bx, 1
06527  d1 d0                rcl ax, 1
06529  d1 e5                shl bp, 1
0652b  d1 d0                rcl ax, 1
0652d  86 e0                xchg al, ah
0652f  26 89 05             mov word ptr es:[di], ax
06532  d1 e2                shl dx, 1
06534  d1 d0                rcl ax, 1
06536  d1 e1                shl cx, 1
06538  d1 d0                rcl ax, 1
0653a  d1 e3                shl bx, 1
0653c  d1 d0                rcl ax, 1
0653e  d1 e5                shl bp, 1
06540  d1 d0                rcl ax, 1
06542  d1 e2                shl dx, 1
06544  d1 d0                rcl ax, 1
06546  d1 e1                shl cx, 1
06548  d1 d0                rcl ax, 1
0654a  d1 e3                shl bx, 1
0654c  d1 d0                rcl ax, 1
0654e  d1 e5                shl bp, 1
06550  d1 d0                rcl ax, 1
06552  d1 e2                shl dx, 1
06554  d1 d0                rcl ax, 1
06556  d1 e1                shl cx, 1
06558  d1 d0                rcl ax, 1
0655a  d1 e3                shl bx, 1
0655c  d1 d0                rcl ax, 1
0655e  d1 e5                shl bp, 1
06560  d1 d0                rcl ax, 1
06562  d1 e2                shl dx, 1
06564  d1 d0                rcl ax, 1
06566  d1 e1                shl cx, 1
06568  d1 d0                rcl ax, 1
0656a  d1 e3                shl bx, 1
0656c  d1 d0                rcl ax, 1
0656e  d1 e5                shl bp, 1
06570  d1 d0                rcl ax, 1
06572  86 e0                xchg al, ah
06574  26 89 45 02          mov word ptr es:[di + 2], ax
06578  d1 e2                shl dx, 1
0657a  d1 d0                rcl ax, 1
0657c  d1 e1                shl cx, 1
0657e  d1 d0                rcl ax, 1
06580  d1 e3                shl bx, 1
06582  d1 d0                rcl ax, 1
06584  d1 e5                shl bp, 1
06586  d1 d0                rcl ax, 1
06588  d1 e2                shl dx, 1
0658a  d1 d0                rcl ax, 1
0658c  d1 e1                shl cx, 1
0658e  d1 d0                rcl ax, 1
06590  d1 e3                shl bx, 1
06592  d1 d0                rcl ax, 1
06594  d1 e5                shl bp, 1
06596  d1 d0                rcl ax, 1
06598  d1 e2                shl dx, 1
0659a  d1 d0                rcl ax, 1
0659c  d1 e1                shl cx, 1
0659e  d1 d0                rcl ax, 1
065a0  d1 e3                shl bx, 1
065a2  d1 d0                rcl ax, 1
065a4  d1 e5                shl bp, 1
065a6  d1 d0                rcl ax, 1
065a8  d1 e2                shl dx, 1
065aa  d1 d0                rcl ax, 1
065ac  d1 e1                shl cx, 1
065ae  d1 d0                rcl ax, 1
065b0  d1 e3                shl bx, 1
065b2  d1 d0                rcl ax, 1
065b4  d1 e5                shl bp, 1
065b6  d1 d0                rcl ax, 1
065b8  86 e0                xchg al, ah
065ba  26 89 45 04          mov word ptr es:[di + 4], ax
065be  d1 e2                shl dx, 1
065c0  d1 d0                rcl ax, 1
065c2  d1 e1                shl cx, 1
065c4  d1 d0                rcl ax, 1
065c6  d1 e3                shl bx, 1
065c8  d1 d0                rcl ax, 1
065ca  d1 e5                shl bp, 1
065cc  d1 d0                rcl ax, 1
065ce  d1 e2                shl dx, 1
065d0  d1 d0                rcl ax, 1
065d2  d1 e1                shl cx, 1
065d4  d1 d0                rcl ax, 1
065d6  d1 e3                shl bx, 1
065d8  d1 d0                rcl ax, 1
065da  d1 e5                shl bp, 1
065dc  d1 d0                rcl ax, 1
065de  d1 e2                shl dx, 1
065e0  d1 d0                rcl ax, 1
065e2  d1 e1                shl cx, 1
065e4  d1 d0                rcl ax, 1
065e6  d1 e3                shl bx, 1
065e8  d1 d0                rcl ax, 1
065ea  d1 e5                shl bp, 1
065ec  d1 d0                rcl ax, 1
065ee  d1 e2                shl dx, 1
065f0  d1 d0                rcl ax, 1
065f2  d1 e1                shl cx, 1
065f4  d1 d0                rcl ax, 1
065f6  d1 e3                shl bx, 1
065f8  d1 d0                rcl ax, 1
065fa  d1 e5                shl bp, 1
065fc  d1 d0                rcl ax, 1
065fe  86 e0                xchg al, ah
06600  26 89 45 06          mov word ptr es:[di + 6], ax
06604  83 c6 02             add si, 2
06607  83 c7 08             add di, 8
0660a  8a 64 78             mov ah, byte ptr [si + 0x78]
0660d  8a 44 79             mov al, byte ptr [si + 0x79]
06610  8b e8                mov bp, ax
06612  8a 7c 50             mov bh, byte ptr [si + 0x50]
06615  8a 5c 51             mov bl, byte ptr [si + 0x51]
06618  8a 6c 28             mov ch, byte ptr [si + 0x28]
0661b  8a 4c 29             mov cl, byte ptr [si + 0x29]
0661e  8a 34                mov dh, byte ptr [si]
06620  8a 54 01             mov dl, byte ptr [si + 1]
06623  b8 00 00             mov ax, 0
06626  d1 e2                shl dx, 1
06628  d1 d0                rcl ax, 1
0662a  d1 e1                shl cx, 1
0662c  d1 d0                rcl ax, 1
0662e  d1 e3                shl bx, 1
06630  d1 d0                rcl ax, 1
06632  d1 e5                shl bp, 1
06634  d1 d0                rcl ax, 1
06636  d1 e2                shl dx, 1
06638  d1 d0                rcl ax, 1
0663a  d1 e1                shl cx, 1
0663c  d1 d0                rcl ax, 1
0663e  d1 e3                shl bx, 1
06640  d1 d0                rcl ax, 1
06642  d1 e5                shl bp, 1
06644  d1 d0                rcl ax, 1
06646  d1 e2                shl dx, 1
06648  d1 d0                rcl ax, 1
0664a  d1 e1                shl cx, 1
0664c  d1 d0                rcl ax, 1
0664e  d1 e3                shl bx, 1
06650  d1 d0                rcl ax, 1
06652  d1 e5                shl bp, 1
06654  d1 d0                rcl ax, 1
06656  d1 e2                shl dx, 1
06658  d1 d0                rcl ax, 1
0665a  d1 e1                shl cx, 1
0665c  d1 d0                rcl ax, 1
0665e  d1 e3                shl bx, 1
06660  d1 d0                rcl ax, 1
06662  d1 e5                shl bp, 1
06664  d1 d0                rcl ax, 1
06666  86 e0                xchg al, ah
06668  26 89 05             mov word ptr es:[di], ax
0666b  d1 e2                shl dx, 1
0666d  d1 d0                rcl ax, 1
0666f  d1 e1                shl cx, 1
06671  d1 d0                rcl ax, 1
06673  d1 e3                shl bx, 1
06675  d1 d0                rcl ax, 1
06677  d1 e5                shl bp, 1
06679  d1 d0                rcl ax, 1
0667b  d1 e2                shl dx, 1
0667d  d1 d0                rcl ax, 1
0667f  d1 e1                shl cx, 1
06681  d1 d0                rcl ax, 1
06683  d1 e3                shl bx, 1
06685  d1 d0                rcl ax, 1
06687  d1 e5                shl bp, 1
06689  d1 d0                rcl ax, 1
0668b  d1 e2                shl dx, 1
0668d  d1 d0                rcl ax, 1
0668f  d1 e1                shl cx, 1
06691  d1 d0                rcl ax, 1
06693  d1 e3                shl bx, 1
06695  d1 d0                rcl ax, 1
06697  d1 e5                shl bp, 1
06699  d1 d0                rcl ax, 1
0669b  d1 e2                shl dx, 1
0669d  d1 d0                rcl ax, 1
0669f  d1 e1                shl cx, 1
066a1  d1 d0                rcl ax, 1
066a3  d1 e3                shl bx, 1
066a5  d1 d0                rcl ax, 1
066a7  d1 e5                shl bp, 1
066a9  d1 d0                rcl ax, 1
066ab  86 e0                xchg al, ah
066ad  26 89 45 02          mov word ptr es:[di + 2], ax
066b1  d1 e2                shl dx, 1
066b3  d1 d0                rcl ax, 1
066b5  d1 e1                shl cx, 1
066b7  d1 d0                rcl ax, 1
066b9  d1 e3                shl bx, 1
066bb  d1 d0                rcl ax, 1
066bd  d1 e5                shl bp, 1
066bf  d1 d0                rcl ax, 1
066c1  d1 e2                shl dx, 1
066c3  d1 d0                rcl ax, 1
066c5  d1 e1                shl cx, 1
066c7  d1 d0                rcl ax, 1
066c9  d1 e3                shl bx, 1
066cb  d1 d0                rcl ax, 1
066cd  d1 e5                shl bp, 1
066cf  d1 d0                rcl ax, 1
066d1  d1 e2                shl dx, 1
066d3  d1 d0                rcl ax, 1
066d5  d1 e1                shl cx, 1
066d7  d1 d0                rcl ax, 1
066d9  d1 e3                shl bx, 1
066db  d1 d0                rcl ax, 1
066dd  d1 e5                shl bp, 1
066df  d1 d0                rcl ax, 1
066e1  d1 e2                shl dx, 1
066e3  d1 d0                rcl ax, 1
066e5  d1 e1                shl cx, 1
066e7  d1 d0                rcl ax, 1
066e9  d1 e3                shl bx, 1
066eb  d1 d0                rcl ax, 1
066ed  d1 e5                shl bp, 1
066ef  d1 d0                rcl ax, 1
066f1  86 e0                xchg al, ah
066f3  26 89 45 04          mov word ptr es:[di + 4], ax
066f7  d1 e2                shl dx, 1
066f9  d1 d0                rcl ax, 1
066fb  d1 e1                shl cx, 1
066fd  d1 d0                rcl ax, 1
066ff  d1 e3                shl bx, 1
06701  d1 d0                rcl ax, 1
06703  d1 e5                shl bp, 1
06705  d1 d0                rcl ax, 1
06707  d1 e2                shl dx, 1
06709  d1 d0                rcl ax, 1
0670b  d1 e1                shl cx, 1
0670d  d1 d0                rcl ax, 1
0670f  d1 e3                shl bx, 1
06711  d1 d0                rcl ax, 1
06713  d1 e5                shl bp, 1
06715  d1 d0                rcl ax, 1
06717  d1 e2                shl dx, 1
06719  d1 d0                rcl ax, 1
0671b  d1 e1                shl cx, 1
0671d  d1 d0                rcl ax, 1
0671f  d1 e3                shl bx, 1
06721  d1 d0                rcl ax, 1
06723  d1 e5                shl bp, 1
06725  d1 d0                rcl ax, 1
06727  d1 e2                shl dx, 1
06729  d1 d0                rcl ax, 1
0672b  d1 e1                shl cx, 1
0672d  d1 d0                rcl ax, 1
0672f  d1 e3                shl bx, 1
06731  d1 d0                rcl ax, 1
06733  d1 e5                shl bp, 1
06735  d1 d0                rcl ax, 1
06737  86 e0                xchg al, ah
06739  26 89 45 06          mov word ptr es:[di + 6], ax
0673d  83 c6 02             add si, 2
06740  83 c7 08             add di, 8
06743  8a 64 78             mov ah, byte ptr [si + 0x78]
06746  8a 44 79             mov al, byte ptr [si + 0x79]
06749  8b e8                mov bp, ax
0674b  8a 7c 50             mov bh, byte ptr [si + 0x50]
0674e  8a 5c 51             mov bl, byte ptr [si + 0x51]
06751  8a 6c 28             mov ch, byte ptr [si + 0x28]
06754  8a 4c 29             mov cl, byte ptr [si + 0x29]
06757  8a 34                mov dh, byte ptr [si]
06759  8a 54 01             mov dl, byte ptr [si + 1]
0675c  b8 00 00             mov ax, 0
0675f  d1 e2                shl dx, 1
06761  d1 d0                rcl ax, 1
06763  d1 e1                shl cx, 1
06765  d1 d0                rcl ax, 1
06767  d1 e3                shl bx, 1
06769  d1 d0                rcl ax, 1
0676b  d1 e5                shl bp, 1
0676d  d1 d0                rcl ax, 1
0676f  d1 e2                shl dx, 1
06771  d1 d0                rcl ax, 1
06773  d1 e1                shl cx, 1
06775  d1 d0                rcl ax, 1
06777  d1 e3                shl bx, 1
06779  d1 d0                rcl ax, 1
0677b  d1 e5                shl bp, 1
0677d  d1 d0                rcl ax, 1
0677f  d1 e2                shl dx, 1
06781  d1 d0                rcl ax, 1
06783  d1 e1                shl cx, 1
06785  d1 d0                rcl ax, 1
06787  d1 e3                shl bx, 1
06789  d1 d0                rcl ax, 1
0678b  d1 e5                shl bp, 1
0678d  d1 d0                rcl ax, 1
0678f  d1 e2                shl dx, 1
06791  d1 d0                rcl ax, 1
06793  d1 e1                shl cx, 1
06795  d1 d0                rcl ax, 1
06797  d1 e3                shl bx, 1
06799  d1 d0                rcl ax, 1
0679b  d1 e5                shl bp, 1
0679d  d1 d0                rcl ax, 1
0679f  86 e0                xchg al, ah
067a1  26 89 05             mov word ptr es:[di], ax
067a4  d1 e2                shl dx, 1
067a6  d1 d0                rcl ax, 1
067a8  d1 e1                shl cx, 1
067aa  d1 d0                rcl ax, 1
067ac  d1 e3                shl bx, 1
067ae  d1 d0                rcl ax, 1
067b0  d1 e5                shl bp, 1
067b2  d1 d0                rcl ax, 1
067b4  d1 e2                shl dx, 1
067b6  d1 d0                rcl ax, 1
067b8  d1 e1                shl cx, 1
067ba  d1 d0                rcl ax, 1
067bc  d1 e3                shl bx, 1
067be  d1 d0                rcl ax, 1
067c0  d1 e5                shl bp, 1
067c2  d1 d0                rcl ax, 1
067c4  d1 e2                shl dx, 1
067c6  d1 d0                rcl ax, 1
067c8  d1 e1                shl cx, 1
067ca  d1 d0                rcl ax, 1
067cc  d1 e3                shl bx, 1
067ce  d1 d0                rcl ax, 1
067d0  d1 e5                shl bp, 1
067d2  d1 d0                rcl ax, 1
067d4  d1 e2                shl dx, 1
067d6  d1 d0                rcl ax, 1
067d8  d1 e1                shl cx, 1
067da  d1 d0                rcl ax, 1
067dc  d1 e3                shl bx, 1
067de  d1 d0                rcl ax, 1
067e0  d1 e5                shl bp, 1
067e2  d1 d0                rcl ax, 1
067e4  86 e0                xchg al, ah
067e6  26 89 45 02          mov word ptr es:[di + 2], ax
067ea  d1 e2                shl dx, 1
067ec  d1 d0                rcl ax, 1
067ee  d1 e1                shl cx, 1
067f0  d1 d0                rcl ax, 1
067f2  d1 e3                shl bx, 1
067f4  d1 d0                rcl ax, 1
067f6  d1 e5                shl bp, 1
067f8  d1 d0                rcl ax, 1
067fa  d1 e2                shl dx, 1
067fc  d1 d0                rcl ax, 1
067fe  d1 e1                shl cx, 1
06800  d1 d0                rcl ax, 1
06802  d1 e3                shl bx, 1
06804  d1 d0                rcl ax, 1
06806  d1 e5                shl bp, 1
06808  d1 d0                rcl ax, 1
0680a  d1 e2                shl dx, 1
0680c  d1 d0                rcl ax, 1
0680e  d1 e1                shl cx, 1
06810  d1 d0                rcl ax, 1
06812  d1 e3                shl bx, 1
06814  d1 d0                rcl ax, 1
06816  d1 e5                shl bp, 1
06818  d1 d0                rcl ax, 1
0681a  d1 e2                shl dx, 1
0681c  d1 d0                rcl ax, 1
0681e  d1 e1                shl cx, 1
06820  d1 d0                rcl ax, 1
06822  d1 e3                shl bx, 1
06824  d1 d0                rcl ax, 1
06826  d1 e5                shl bp, 1
06828  d1 d0                rcl ax, 1
0682a  86 e0                xchg al, ah
0682c  26 89 45 04          mov word ptr es:[di + 4], ax
06830  d1 e2                shl dx, 1
06832  d1 d0                rcl ax, 1
06834  d1 e1                shl cx, 1
06836  d1 d0                rcl ax, 1
06838  d1 e3                shl bx, 1
0683a  d1 d0                rcl ax, 1
0683c  d1 e5                shl bp, 1
0683e  d1 d0                rcl ax, 1
06840  d1 e2                shl dx, 1
06842  d1 d0                rcl ax, 1
06844  d1 e1                shl cx, 1
06846  d1 d0                rcl ax, 1
06848  d1 e3                shl bx, 1
0684a  d1 d0                rcl ax, 1
0684c  d1 e5                shl bp, 1
0684e  d1 d0                rcl ax, 1
06850  d1 e2                shl dx, 1
06852  d1 d0                rcl ax, 1
06854  d1 e1                shl cx, 1
06856  d1 d0                rcl ax, 1
06858  d1 e3                shl bx, 1
0685a  d1 d0                rcl ax, 1
0685c  d1 e5                shl bp, 1
0685e  d1 d0                rcl ax, 1
06860  d1 e2                shl dx, 1
06862  d1 d0                rcl ax, 1
06864  d1 e1                shl cx, 1
06866  d1 d0                rcl ax, 1
06868  d1 e3                shl bx, 1
0686a  d1 d0                rcl ax, 1
0686c  d1 e5                shl bp, 1
0686e  d1 d0                rcl ax, 1
06870  86 e0                xchg al, ah
06872  26 89 45 06          mov word ptr es:[di + 6], ax
06876  83 c6 02             add si, 2
06879  83 c7 08             add di, 8
0687c  81 c7 60 1f          add di, 0x1f60
06880  f7 c7 00 80          test di, 0x8000
06884  74 04                je loc_688a
06886  81 ef 60 7f          sub di, 0x7f60
loc_688a:
0688a  83 c6 78             add si, 0x78
0688d  2e ff 0e ef 23       dec word ptr cs:[0x23ef]
06892  74 03                je loc_6897
06894  e9 71 e7             jmp loc_5008
loc_6897:
06897  50                   push ax
06898  b8 00 00             mov ax, 0
0689b  8e d8                mov ds, ax
0689d  58                   pop ax
0689e  c3                   ret
; ---- 413 octets non atteints (689f-6a3b)

; ======== sub_6a3c   (appelée depuis 4974, 4e9d, 7d07, 7d2b, 7d49, 7d97, 7da5, 7db3)
06a3c  3e 8a 46 00          mov al, byte ptr ds:[bp]
06a40  22 c0                and al, al
06a42  75 01                jne loc_6a45
06a44  c3                   ret
loc_6a45:
06a45  e8 03 00             call sub_6a4b
06a48  45                   inc bp
06a49  eb f1                jmp sub_6a3c

; ======== sub_6a4b   (appelée depuis 6a45, 7337, 7358, 7e64)
06a4b  3c 01                cmp al, 1
06a4d  74 09                je loc_6a58
06a4f  bb dc 19             mov bx, 0x19dc
06a52  03 1e 40 14          add bx, word ptr [0x1440]
06a56  ff 27                jmp word ptr [bx]
loc_6a58:
06a58  3e 8b 46 01          mov ax, word ptr ds:[bp + 1]
06a5c  a3 f8 19             mov word ptr [0x19f8], ax
06a5f  83 c5 02             add bp, 2
06a62  c3                   ret
loc_6a63:
06a63  3c 10                cmp al, 0x10
06a65  75 03                jne loc_6a6a
06a67  e9 1e 01             jmp loc_6b88
loc_6a6a:
06a6a  3c 11                cmp al, 0x11
06a6c  75 03                jne loc_6a71
06a6e  e9 b1 03             jmp loc_6e22
loc_6a71:
06a71  3c 12                cmp al, 0x12
06a73  75 03                jne loc_6a78
06a75  e9 be 03             jmp loc_6e36
loc_6a78:
06a78  50                   push ax
06a79  bb 21 1a             mov bx, 0x1a21
06a7c  a0 f2 19             mov al, byte ptr [0x19f2]
06a7f  d7                   xlatb
06a80  8a d0                mov dl, al
06a82  a0 f3 19             mov al, byte ptr [0x19f3]
06a85  d7                   xlatb
06a86  8a f0                mov dh, al
06a88  80 3e fb 19 01       cmp byte ptr [0x19fb], 1
06a8d  75 02                jne loc_6a91
06a8f  b6 00                mov dh, 0
loc_6a91:
06a91  58                   pop ax
06a92  55                   push bp
06a93  32 e4                xor ah, ah
06a95  d1 e0                shl ax, 1
06a97  d1 e0                shl ax, 1
06a99  d1 e0                shl ax, 1
06a9b  05 b5 13             add ax, 0x13b5
06a9e  8b f0                mov si, ax
06aa0  bf ff 19             mov di, 0x19ff
06aa3  b9 08 00             mov cx, 8
loc_6aa6:
06aa6  51                   push cx
06aa7  ac                   lodsb al, byte ptr [si]
06aa8  b9 04 00             mov cx, 4
loc_6aab:
06aab  8a e6                mov ah, dh
06aad  d0 e0                shl al, 1
06aaf  73 0a                jae loc_6abb
06ab1  80 e4 0f             and ah, 0xf
06ab4  8a da                mov bl, dl
06ab6  80 e3 f0             and bl, 0xf0
06ab9  0a e3                or ah, bl
loc_6abb:
06abb  d0 e0                shl al, 1
06abd  73 0a                jae loc_6ac9
06abf  80 e4 f0             and ah, 0xf0
06ac2  8a da                mov bl, dl
06ac4  80 e3 0f             and bl, 0xf
06ac7  0a e3                or ah, bl
loc_6ac9:
06ac9  88 25                mov byte ptr [di], ah
06acb  47                   inc di
06acc  e2 dd                loop loc_6aab
06ace  59                   pop cx
06acf  e2 d5                loop loc_6aa6
06ad1  a1 f6 19             mov ax, word ptr [0x19f6]
06ad4  32 e4                xor ah, ah
06ad6  ba 40 01             mov dx, 0x140
06ad9  f7 e2                mul dx
06adb  8b 3e f4 19          mov di, word ptr [0x19f4]
06adf  d1 e7                shl di, 1
06ae1  d1 e7                shl di, 1
06ae3  03 f8                add di, ax
06ae5  a1 f8 19             mov ax, word ptr [0x19f8]
06ae8  8e c0                mov es, ax
06aea  bb 00 24             mov bx, 0x2400
06aed  be ff 19             mov si, 0x19ff
06af0  b9 08 00             mov cx, 8
loc_6af3:
06af3  ac                   lodsb al, byte ptr [si]
06af4  80 3e fb 19 01       cmp byte ptr [0x19fb], 1
06af9  74 06                je loc_6b01
06afb  26 88 05             mov byte ptr es:[di], al
06afe  eb 0b                jmp loc_6b0b
; ---- 1 octets non atteints (6b00-6b00)
loc_6b01:
06b01  8a e0                mov ah, al
06b03  2e d7                xlatb
06b05  26 20 05             and byte ptr es:[di], al
06b08  26 08 25             or byte ptr es:[di], ah
loc_6b0b:
06b0b  47                   inc di
06b0c  ac                   lodsb al, byte ptr [si]
06b0d  80 3e fb 19 01       cmp byte ptr [0x19fb], 1
06b12  74 06                je loc_6b1a
06b14  26 88 05             mov byte ptr es:[di], al
06b17  eb 0b                jmp loc_6b24
; ---- 1 octets non atteints (6b19-6b19)
loc_6b1a:
06b1a  8a e0                mov ah, al
06b1c  2e d7                xlatb
06b1e  26 20 05             and byte ptr es:[di], al
06b21  26 08 25             or byte ptr es:[di], ah
loc_6b24:
06b24  47                   inc di
06b25  ac                   lodsb al, byte ptr [si]
06b26  80 3e fb 19 01       cmp byte ptr [0x19fb], 1
06b2b  74 06                je loc_6b33
06b2d  26 88 05             mov byte ptr es:[di], al
06b30  eb 0b                jmp loc_6b3d
; ---- 1 octets non atteints (6b32-6b32)
loc_6b33:
06b33  8a e0                mov ah, al
06b35  2e d7                xlatb
06b37  26 20 05             and byte ptr es:[di], al
06b3a  26 08 25             or byte ptr es:[di], ah
loc_6b3d:
06b3d  47                   inc di
06b3e  ac                   lodsb al, byte ptr [si]
06b3f  80 3e fb 19 01       cmp byte ptr [0x19fb], 1
06b44  74 06                je loc_6b4c
06b46  26 88 05             mov byte ptr es:[di], al
06b49  eb 0b                jmp loc_6b56
; ---- 1 octets non atteints (6b4b-6b4b)
loc_6b4c:
06b4c  8a e0                mov ah, al
06b4e  2e d7                xlatb
06b50  26 20 05             and byte ptr es:[di], al
06b53  26 08 25             or byte ptr es:[di], ah
loc_6b56:
06b56  47                   inc di
06b57  81 c7 00 20          add di, 0x2000
06b5b  f7 c7 00 80          test di, 0x8000
06b5f  74 04                je loc_6b65
06b61  81 ef 60 7f          sub di, 0x7f60
loc_6b65:
06b65  83 ef 04             sub di, 4
06b68  e2 89                loop loc_6af3
06b6a  50                   push ax
06b6b  b8 00 00             mov ax, 0
06b6e  8e d8                mov ds, ax
06b70  58                   pop ax
06b71  ff 06 f4 19          inc word ptr [0x19f4]
06b75  83 3e f4 19 28       cmp word ptr [0x19f4], 0x28
06b7a  72 0a                jb loc_6b86
06b7c  c7 06 f4 19 00 00    mov word ptr [0x19f4], 0
06b82  ff 06 f6 19          inc word ptr [0x19f6]
loc_6b86:
06b86  5d                   pop bp
06b87  c3                   ret
loc_6b88:
06b88  3e 8a 46 01          mov al, byte ptr ds:[bp + 1]
06b8c  3c 38                cmp al, 0x38
06b8e  75 02                jne loc_6b92
06b90  b0 05                mov al, 5
loc_6b92:
06b92  a2 f2 19             mov byte ptr [0x19f2], al
06b95  3e 8a 46 02          mov al, byte ptr ds:[bp + 2]
06b99  a2 f3 19             mov byte ptr [0x19f3], al
06b9c  83 c5 02             add bp, 2
06b9f  c3                   ret
loc_6ba0:
06ba0  3c 10                cmp al, 0x10
06ba2  75 03                jne loc_6ba7
06ba4  e9 c3 01             jmp loc_6d6a
loc_6ba7:
06ba7  3c 11                cmp al, 0x11
06ba9  75 03                jne loc_6bae
06bab  e9 92 01             jmp loc_6d40
loc_6bae:
06bae  3c 12                cmp al, 0x12
06bb0  75 03                jne loc_6bb5
06bb2  e9 9f 01             jmp loc_6d54
loc_6bb5:
06bb5  55                   push bp
06bb6  32 e4                xor ah, ah
06bb8  d1 e0                shl ax, 1
06bba  d1 e0                shl ax, 1
06bbc  d1 e0                shl ax, 1
06bbe  05 b5 13             add ax, 0x13b5
06bc1  8b f0                mov si, ax
06bc3  bf ff 19             mov di, 0x19ff
06bc6  8a 1e f2 19          mov bl, byte ptr [0x19f2]
06bca  8a 3e f3 19          mov bh, byte ptr [0x19f3]
06bce  b9 08 00             mov cx, 8
loc_6bd1:
06bd1  53                   push bx
06bd2  ac                   lodsb al, byte ptr [si]
06bd3  32 e4                xor ah, ah
06bd5  d0 eb                shr bl, 1
06bd7  72 02                jb loc_6bdb
06bd9  88 25                mov byte ptr [di], ah
loc_6bdb:
06bdb  73 02                jae loc_6bdf
06bdd  88 05                mov byte ptr [di], al
loc_6bdf:
06bdf  d0 eb                shr bl, 1
06be1  72 03                jb loc_6be6
06be3  88 65 08             mov byte ptr [di + 8], ah
loc_6be6:
06be6  73 03                jae loc_6beb
06be8  88 45 08             mov byte ptr [di + 8], al
loc_6beb:
06beb  d0 eb                shr bl, 1
06bed  72 03                jb loc_6bf2
06bef  88 65 10             mov byte ptr [di + 0x10], ah
loc_6bf2:
06bf2  73 03                jae loc_6bf7
06bf4  88 45 10             mov byte ptr [di + 0x10], al
loc_6bf7:
06bf7  d0 eb                shr bl, 1
06bf9  72 03                jb loc_6bfe
06bfb  88 65 18             mov byte ptr [di + 0x18], ah
loc_6bfe:
06bfe  73 03                jae loc_6c03
06c00  88 45 18             mov byte ptr [di + 0x18], al
loc_6c03:
06c03  f6 d0                not al
06c05  80 3e fb 19 00       cmp byte ptr [0x19fb], 0
06c0a  75 1b                jne loc_6c27
06c0c  d0 ef                shr bh, 1
06c0e  73 02                jae loc_6c12
06c10  08 05                or byte ptr [di], al
loc_6c12:
06c12  d0 ef                shr bh, 1
06c14  73 03                jae loc_6c19
06c16  08 45 08             or byte ptr [di + 8], al
loc_6c19:
06c19  d0 ef                shr bh, 1
06c1b  73 03                jae loc_6c20
06c1d  08 45 10             or byte ptr [di + 0x10], al
loc_6c20:
06c20  d0 ef                shr bh, 1
06c22  73 03                jae loc_6c27
06c24  08 45 18             or byte ptr [di + 0x18], al
loc_6c27:
06c27  5b                   pop bx
06c28  47                   inc di
06c29  e2 a6                loop loc_6bd1
06c2b  be ff 19             mov si, 0x19ff
06c2e  a1 f8 19             mov ax, word ptr [0x19f8]
06c31  8e c0                mov es, ax
06c33  3d 00 a0             cmp ax, 0xa000
06c36  75 7a                jne loc_6cb2
06c38  a1 f6 19             mov ax, word ptr [0x19f6]
06c3b  ba 40 01             mov dx, 0x140
06c3e  f7 e2                mul dx
06c40  03 06 f4 19          add ax, word ptr [0x19f4]
06c44  8b f8                mov di, ax
06c46  ba ce 03             mov dx, 0x3ce
06c49  b4 18                mov ah, 0x18
06c4b  b0 03                mov al, 3
06c4d  ef                   out dx, ax
06c4e  b8 05 08             mov ax, 0x805
06c51  ef                   out dx, ax
06c52  b8 07 00             mov ax, 7
06c55  ef                   out dx, ax
06c56  b8 08 ff             mov ax, 0xff08
06c59  ef                   out dx, ax
06c5a  b2 c4                mov dl, 0xc4
06c5c  b8 02 08             mov ax, 0x802
06c5f  b9 08 00             mov cx, 8
loc_6c62:
06c62  ef                   out dx, ax
06c63  50                   push ax
06c64  ac                   lodsb al, byte ptr [si]
06c65  26 88 05             mov byte ptr es:[di], al
06c68  ac                   lodsb al, byte ptr [si]
06c69  26 88 45 28          mov byte ptr es:[di + 0x28], al
06c6d  ac                   lodsb al, byte ptr [si]
06c6e  26 88 45 50          mov byte ptr es:[di + 0x50], al
06c72  ac                   lodsb al, byte ptr [si]
06c73  26 88 45 78          mov byte ptr es:[di + 0x78], al
06c77  ac                   lodsb al, byte ptr [si]
06c78  26 88 85 a0 00       mov byte ptr es:[di + 0xa0], al
06c7d  ac                   lodsb al, byte ptr [si]
06c7e  26 88 85 c8 00       mov byte ptr es:[di + 0xc8], al
06c83  ac                   lodsb al, byte ptr [si]
06c84  26 88 85 f0 00       mov byte ptr es:[di + 0xf0], al
06c89  ac                   lodsb al, byte ptr [si]
06c8a  26 88 85 18 01       mov byte ptr es:[di + 0x118], al
06c8f  58                   pop ax
06c90  d0 ec                shr ah, 1
06c92  e2 ce                loop loc_6c62
loc_6c94:
06c94  50                   push ax
06c95  b8 00 00             mov ax, 0
06c98  8e d8                mov ds, ax
06c9a  58                   pop ax
06c9b  ff 06 f4 19          inc word ptr [0x19f4]
06c9f  83 3e f4 19 28       cmp word ptr [0x19f4], 0x28
06ca4  72 0a                jb loc_6cb0
06ca6  c7 06 f4 19 00 00    mov word ptr [0x19f4], 0
06cac  ff 06 f6 19          inc word ptr [0x19f6]
loc_6cb0:
06cb0  5d                   pop bp
06cb1  c3                   ret
loc_6cb2:
06cb2  a1 f6 19             mov ax, word ptr [0x19f6]
06cb5  ba 40 01             mov dx, 0x140
06cb8  f7 e2                mul dx
06cba  d1 e0                shl ax, 1
06cbc  d1 e0                shl ax, 1
06cbe  03 06 f4 19          add ax, word ptr [0x19f4]
06cc2  8b f8                mov di, ax
06cc4  b9 08 00             mov cx, 8
06cc7  80 3e fb 19 00       cmp byte ptr [0x19fb], 0
06ccc  75 29                jne loc_6cf7
loc_6cce:
06cce  57                   push di
06ccf  56                   push si
06cd0  a4                   movsb byte ptr es:[di], byte ptr [si]
06cd1  83 c6 07             add si, 7
06cd4  83 c7 27             add di, 0x27
06cd7  a4                   movsb byte ptr es:[di], byte ptr [si]
06cd8  83 c6 07             add si, 7
06cdb  83 c7 27             add di, 0x27
06cde  a4                   movsb byte ptr es:[di], byte ptr [si]
06cdf  83 c6 07             add si, 7
06ce2  83 c7 27             add di, 0x27
06ce5  a4                   movsb byte ptr es:[di], byte ptr [si]
06ce6  83 c6 07             add si, 7
06ce9  83 c7 27             add di, 0x27
06cec  5e                   pop si
06ced  5f                   pop di
06cee  46                   inc si
06cef  81 c7 a0 00          add di, 0xa0
06cf3  e2 d9                loop loc_6cce
06cf5  eb 9d                jmp loc_6c94
loc_6cf7:
06cf7  8a 24                mov ah, byte ptr [si]
06cf9  0a 64 08             or ah, byte ptr [si + 8]
06cfc  0a 64 10             or ah, byte ptr [si + 0x10]
06cff  0a 64 18             or ah, byte ptr [si + 0x18]
06d02  f6 d4                not ah
06d04  ac                   lodsb al, byte ptr [si]
06d05  26 20 25             and byte ptr es:[di], ah
06d08  26 08 05             or byte ptr es:[di], al
06d0b  83 c6 07             add si, 7
06d0e  83 c7 28             add di, 0x28
06d11  ac                   lodsb al, byte ptr [si]
06d12  26 20 25             and byte ptr es:[di], ah
06d15  26 08 05             or byte ptr es:[di], al
06d18  83 c6 07             add si, 7
06d1b  83 c7 28             add di, 0x28
06d1e  ac                   lodsb al, byte ptr [si]
06d1f  26 20 25             and byte ptr es:[di], ah
06d22  26 08 05             or byte ptr es:[di], al
06d25  83 c6 07             add si, 7
06d28  83 c7 28             add di, 0x28
06d2b  ac                   lodsb al, byte ptr [si]
06d2c  26 20 25             and byte ptr es:[di], ah
06d2f  26 08 05             or byte ptr es:[di], al
06d32  83 c6 07             add si, 7
06d35  83 c7 28             add di, 0x28
06d38  83 ee 1f             sub si, 0x1f
06d3b  e2 ba                loop loc_6cf7
06d3d  e9 54 ff             jmp loc_6c94
loc_6d40:
06d40  3e 8a 46 01          mov al, byte ptr ds:[bp + 1]
06d44  32 e4                xor ah, ah
06d46  a3 f6 19             mov word ptr [0x19f6], ax
06d49  3e 8a 46 02          mov al, byte ptr ds:[bp + 2]
06d4d  a3 f4 19             mov word ptr [0x19f4], ax
06d50  83 c5 02             add bp, 2
06d53  c3                   ret
loc_6d54:
06d54  3e 8a 46 02          mov al, byte ptr ds:[bp + 2]
06d58  04 04                add al, 4
06d5a  32 e4                xor ah, ah
06d5c  a3 f6 19             mov word ptr [0x19f6], ax
06d5f  3e 8a 46 01          mov al, byte ptr ds:[bp + 1]
06d63  a3 f4 19             mov word ptr [0x19f4], ax
06d66  83 c5 02             add bp, 2
06d69  c3                   ret
loc_6d6a:
06d6a  3e 8a 46 01          mov al, byte ptr ds:[bp + 1]
06d6e  a2 f2 19             mov byte ptr [0x19f2], al
06d71  3e 8a 46 02          mov al, byte ptr ds:[bp + 2]
06d75  a2 f3 19             mov byte ptr [0x19f3], al
06d78  83 c5 02             add bp, 2
06d7b  c3                   ret
loc_6d7c:
06d7c  3c 10                cmp al, 0x10
06d7e  75 03                jne loc_6d83
06d80  e9 c9 00             jmp loc_6e4c
loc_6d83:
06d83  3c 11                cmp al, 0x11
06d85  75 03                jne loc_6d8a
06d87  e9 98 00             jmp loc_6e22
loc_6d8a:
06d8a  3c 12                cmp al, 0x12
06d8c  75 03                jne loc_6d91
06d8e  e9 a5 00             jmp loc_6e36
loc_6d91:
06d91  9c                   pushf
06d92  50                   push ax
06d93  53                   push bx
06d94  51                   push cx
06d95  52                   push dx
06d96  57                   push di
06d97  56                   push si
06d98  55                   push bp
06d99  06                   push es
06d9a  1e                   push ds
06d9b  32 e4                xor ah, ah
06d9d  d1 e0                shl ax, 1
06d9f  d1 e0                shl ax, 1
06da1  d1 e0                shl ax, 1
06da3  05 b5 13             add ax, 0x13b5
06da6  8b f0                mov si, ax
06da8  a1 f6 19             mov ax, word ptr [0x19f6]
06dab  ba 00 0a             mov dx, 0xa00
06dae  f7 e2                mul dx
06db0  8b 16 f4 19          mov dx, word ptr [0x19f4]
06db4  d1 e2                shl dx, 1
06db6  d1 e2                shl dx, 1
06db8  d1 e2                shl dx, 1
06dba  03 c2                add ax, dx
06dbc  8b f8                mov di, ax
06dbe  a1 f8 19             mov ax, word ptr [0x19f8]
06dc1  8e c0                mov es, ax
06dc3  8a 1e f2 19          mov bl, byte ptr [0x19f2]
06dc7  8a 3e f3 19          mov bh, byte ptr [0x19f3]
06dcb  b9 08 00             mov cx, 8
loc_6dce:
06dce  51                   push cx
06dcf  ac                   lodsb al, byte ptr [si]
06dd0  f6 06 fa 19 01       test byte ptr [0x19fa], 1
06dd5  74 02                je loc_6dd9
06dd7  f6 d0                not al
loc_6dd9:
06dd9  8a e0                mov ah, al
06ddb  b9 08 00             mov cx, 8
loc_6dde:
06dde  8a c3                mov al, bl
06de0  d0 e4                shl ah, 1
06de2  72 0d                jb loc_6df1
06de4  8a c7                mov al, bh
06de6  80 3e fb 19 00       cmp byte ptr [0x19fb], 0
06deb  74 04                je loc_6df1
06ded  47                   inc di
06dee  eb 02                jmp loc_6df2
; ---- 1 octets non atteints (6df0-6df0)
loc_6df1:
06df1  aa                   stosb byte ptr es:[di], al
loc_6df2:
06df2  e2 ea                loop loc_6dde
06df4  59                   pop cx
06df5  81 c7 38 01          add di, 0x138
06df9  e2 d3                loop loc_6dce
06dfb  50                   push ax
06dfc  b8 00 00             mov ax, 0
06dff  8e d8                mov ds, ax
06e01  58                   pop ax
06e02  ff 06 f4 19          inc word ptr [0x19f4]
06e06  83 3e f4 19 28       cmp word ptr [0x19f4], 0x28
06e0b  72 0a                jb loc_6e17
06e0d  c7 06 f4 19 00 00    mov word ptr [0x19f4], 0
06e13  ff 06 f6 19          inc word ptr [0x19f6]
loc_6e17:
06e17  1f                   pop ds
06e18  07                   pop es
06e19  5d                   pop bp
06e1a  5e                   pop si
06e1b  5f                   pop di
06e1c  5a                   pop dx
06e1d  59                   pop cx
06e1e  5b                   pop bx
06e1f  58                   pop ax
06e20  9d                   popf
06e21  c3                   ret
loc_6e22:
06e22  3e 8a 46 01          mov al, byte ptr ds:[bp + 1]
06e26  a3 f6 19             mov word ptr [0x19f6], ax
06e29  32 e4                xor ah, ah
06e2b  3e 8a 46 02          mov al, byte ptr ds:[bp + 2]
06e2f  a3 f4 19             mov word ptr [0x19f4], ax
06e32  83 c5 02             add bp, 2
06e35  c3                   ret
loc_6e36:
06e36  3e 8a 46 02          mov al, byte ptr ds:[bp + 2]
06e3a  32 e4                xor ah, ah
06e3c  04 04                add al, 4
06e3e  a3 f6 19             mov word ptr [0x19f6], ax
06e41  3e 8a 46 01          mov al, byte ptr ds:[bp + 1]
06e45  a3 f4 19             mov word ptr [0x19f4], ax
06e48  83 c5 02             add bp, 2
06e4b  c3                   ret
loc_6e4c:
06e4c  3e 8a 46 01          mov al, byte ptr ds:[bp + 1]
06e50  a2 f2 19             mov byte ptr [0x19f2], al
06e53  3e 8a 46 02          mov al, byte ptr ds:[bp + 2]
06e57  a2 f3 19             mov byte ptr [0x19f3], al
06e5a  83 c5 02             add bp, 2
06e5d  c3                   ret

; ======== sub_6e5e   (routine probable : non appelée directement)
06e5e  c7 06 40 14 04 00    mov word ptr [0x1440], 4
06e64  b4 00                mov ah, 0
06e66  b0 08                mov al, 8
06e68  cd 10                int 0x10
06e6a  c3                   ret

; ======== sub_6e6b   (appelée depuis 7f44)
06e6b  9c                   pushf
06e6c  50                   push ax
06e6d  53                   push bx
06e6e  51                   push cx
06e6f  52                   push dx
06e70  57                   push di
06e71  56                   push si
06e72  55                   push bp
06e73  06                   push es
06e74  1e                   push ds
06e75  b9 e8 03             mov cx, 0x3e8    ; " SPACEBAR"
loc_6e78:
06e78  90                   nop
06e79  e2 fd                loop loc_6e78
06e7b  1f                   pop ds
06e7c  07                   pop es
06e7d  5d                   pop bp
06e7e  5e                   pop si
06e7f  5f                   pop di
06e80  5a                   pop dx
06e81  59                   pop cx
06e82  5b                   pop bx
06e83  58                   pop ax
06e84  9d                   popf
06e85  c3                   ret

; ======== sub_6e86   (routine probable : non appelée directement)
06e86  9c                   pushf
06e87  50                   push ax
06e88  53                   push bx
06e89  51                   push cx
06e8a  52                   push dx
06e8b  57                   push di
06e8c  56                   push si
06e8d  55                   push bp
06e8e  06                   push es
06e8f  1e                   push ds
06e90  b9 ff ff             mov cx, 0xffff
06e93  eb e3                jmp loc_6e78

; ======== sub_6e95   (appelée depuis 72f9)
06e95  e8 0a 00             call sub_6ea2
06e98  0a c0                or al, al
06e9a  74 f9                je sub_6e95
06e9c  50                   push ax
06e9d  e8 2b 00             call sub_6ecb
06ea0  58                   pop ax
06ea1  c3                   ret

; ======== sub_6ea2   (appelée depuis 6e95, 6ecb)
06ea2  06                   push es
06ea3  50                   push ax
06ea4  b8 00 00             mov ax, 0
06ea7  8e c0                mov es, ax
06ea9  58                   pop ax
06eaa  fc                   cld
06eab  b9 80 00             mov cx, 0x80
06eae  b0 01                mov al, 1
06eb0  bf b4 1b             mov di, 0x1bb4
loc_6eb3:
06eb3  26 38 05             cmp byte ptr es:[di], al
06eb6  74 07                je loc_6ebf
06eb8  47                   inc di
06eb9  e2 f8                loop loc_6eb3
06ebb  33 c0                xor ax, ax
06ebd  07                   pop es
06ebe  c3                   ret
loc_6ebf:
06ebf  b0 80                mov al, 0x80
06ec1  2a c1                sub al, cl
06ec3  8a e0                mov ah, al
06ec5  bb 3f 1c             mov bx, 0x1c3f
06ec8  d7                   xlatb
06ec9  07                   pop es
06eca  c3                   ret

; ======== sub_6ecb   (appelée depuis 6e9d)
06ecb  e8 d4 ff             call sub_6ea2
06ece  0a c0                or al, al
06ed0  75 f9                jne sub_6ecb
06ed2  c3                   ret

; ======== sub_6ed3   (routine probable : non appelée directement)
06ed3  a1 9f 1b             mov ax, word ptr [0x1b9f]
06ed6  24 48                and al, 0x48
06ed8  04 38                add al, 0x38
06eda  d0 d0                rcl al, 1
06edc  d0 d0                rcl al, 1
06ede  d0 16 a2 1b          rcl byte ptr [0x1ba2]
06ee2  d0 16 a1 1b          rcl byte ptr [0x1ba1]
06ee6  d0 16 a0 1b          rcl byte ptr [0x1ba0]
06eea  d0 16 9f 1b          rcl byte ptr [0x1b9f]
06eee  a1 9f 1b             mov ax, word ptr [0x1b9f]
06ef1  32 e4                xor ah, ah
06ef3  f6 f3                div bl
06ef5  8a c4                mov al, ah
06ef7  fe c0                inc al
06ef9  0a c0                or al, al
06efb  75 02                jne loc_6eff
06efd  fe c0                inc al
loc_6eff:
06eff  c3                   ret

; ======== sub_6f00   (routine probable : non appelée directement)
06f00  c7 06 f4 19 00 00    mov word ptr [0x19f4], 0
06f06  c7 06 f6 19 00 00    mov word ptr [0x19f6], 0
06f0c  fc                   cld
06f0d  33 c0                xor ax, ax
06f0f  8b f8                mov di, ax
06f11  b9 00 00             mov cx, 0
06f14  a1 40 14             mov ax, word ptr [0x1440]
06f17  bb e6 19             mov bx, 0x19e6
06f1a  03 1e 40 14          add bx, word ptr [0x1440]
06f1e  ff 27                jmp word ptr [bx]
loc_6f20:
06f20  50                   push ax
06f21  b8 00 a0             mov ax, 0xa000
06f24  8e c0                mov es, ax
06f26  58                   pop ax
06f27  33 ff                xor di, di
06f29  b9 00 40             mov cx, 0x4000
06f2c  f3 ab                rep stosw word ptr es:[di], ax
06f2e  c3                   ret
loc_6f2f:
06f2f  50                   push ax
06f30  b8 00 a0             mov ax, 0xa000
06f33  8e c0                mov es, ax
06f35  58                   pop ax
06f36  ba ce 03             mov dx, 0x3ce
06f39  8a 26 f3 19          mov ah, byte ptr [0x19f3]
06f3d  b0 00                mov al, 0
06f3f  ef                   out dx, ax
06f40  b8 01 0f             mov ax, 0xf01
06f43  ef                   out dx, ax
06f44  b9 c8 00             mov cx, 0xc8
06f47  f3 ab                rep stosw word ptr es:[di], ax
06f49  b8 01 00             mov ax, 1
06f4c  ef                   out dx, ax
06f4d  c3                   ret
loc_6f4e:
06f4e  50                   push ax
06f4f  b8 00 a0             mov ax, 0xa000
06f52  8e c0                mov es, ax
06f54  58                   pop ax
06f55  a0 f3 19             mov al, byte ptr [0x19f3]
06f58  8a e0                mov ah, al
06f5a  b9 00 7d             mov cx, 0x7d00
06f5d  f3 ab                rep stosw word ptr es:[di], ax
06f5f  c3                   ret

; ======== sub_6f60   (appelée depuis 7d91)
06f60  52                   push dx
06f61  50                   push ax
06f62  ba da 03             mov dx, 0x3da
loc_6f65:
06f65  ec                   in al, dx
06f66  24 08                and al, 8
06f68  74 fb                je loc_6f65
06f6a  58                   pop ax
06f6b  5a                   pop dx
06f6c  c3                   ret
; ---- 13 octets non atteints (6f6d-6f79)

; ======== sub_6f7a   (appelée depuis 7272)
06f7a  bb 19 2b             mov bx, 0x2b19
06f7d  39 1e 3d 1c          cmp word ptr [0x1c3d], bx
06f81  75 01                jne loc_6f84
06f83  c3                   ret
loc_6f84:
06f84  06                   push es
06f85  b4 35                mov ah, 0x35
06f87  b0 09                mov al, 9
06f89  cd 21                int 0x21
06f8b  bf 3b 1c             mov di, 0x1c3b
06f8e  8c 05                mov word ptr [di], es
06f90  89 5d 02             mov word ptr [di + 2], bx
06f93  07                   pop es
06f94  1e                   push ds
06f95  0e                   push cs
06f96  1f                   pop ds
06f97  ba 19 2b             mov dx, 0x2b19
06f9a  b4 25                mov ah, 0x25
06f9c  b0 09                mov al, 9
06f9e  cd 21                int 0x21
06fa0  1f                   pop ds
06fa1  bf b4 1b             mov di, 0x1bb4
06fa4  b8 00 00             mov ax, 0
06fa7  8e c0                mov es, ax
06fa9  33 c0                xor ax, ax
06fab  b9 40 00             mov cx, 0x40
06fae  f3 ab                rep stosw word ptr es:[di], ax
06fb0  c3                   ret

; ======== sub_6fb1   (appelée depuis 44ea, 4784, 4825, 4873, 4876, 48d5, 4e74, 4ed5)
06fb1  1e                   push ds
06fb2  bf 3b 1c             mov di, 0x1c3b
06fb5  8b 55 02             mov dx, word ptr [di + 2]
06fb8  83 fa 00             cmp dx, 0
06fbb  74 0a                je loc_6fc7
06fbd  8b 05                mov ax, word ptr [di]
06fbf  8e d8                mov ds, ax
06fc1  b4 25                mov ah, 0x25
06fc3  b0 09                mov al, 9
06fc5  cd 21                int 0x21
loc_6fc7:
06fc7  1f                   pop ds
06fc8  c3                   ret
; ---- 73 octets non atteints (6fc9-7011)

; ======== sub_7012   (appelée depuis 71af, 71ba, 71d6, 71ff, 7225)
07012  c6 06 34 1c 00       mov byte ptr [0x1c34], 0
07017  b9 06 00             mov cx, 6
0701a  33 db                xor bx, bx
0701c  be ad 1b             mov si, 0x1bad
0701f  bf b4 1b             mov di, 0x1bb4
loc_7022:
07022  8a 1c                mov bl, byte ptr [si]
07024  8a 01                mov al, byte ptr [bx + di]
07026  d0 e8                shr al, 1
07028  d0 16 34 1c          rcl byte ptr [0x1c34]
0702c  46                   inc si
0702d  e2 f3                loop loc_7022
0702f  80 26 34 1c 7f       and byte ptr [0x1c34], 0x7f
07034  f6 06 b5 1b 01       test byte ptr [0x1bb5], 1
07039  74 13                je loc_704e
0703b  f6 06 d1 1b 01       test byte ptr [0x1bd1], 1
07040  74 05                je loc_7047
07042  80 0e 34 1c 40       or byte ptr [0x1c34], 0x40
loc_7047:
07047  a0 d1 1b             mov al, byte ptr [0x1bd1]
0704a  8a 26 b5 1b          mov ah, byte ptr [0x1bb5]
loc_704e:
0704e  e8 18 00             call sub_7069
07051  e8 a1 00             call sub_70f5
07054  e8 ef 00             call sub_7146
07057  81 3e 35 1c 2f 01    cmp word ptr [0x1c35], 0x12f
0705d  76 06                jbe loc_7065
0705f  c7 06 35 1c 2f 01    mov word ptr [0x1c35], 0x12f
loc_7065:
07065  e8 8d 10             call sub_80f5
07068  c3                   ret

; ======== sub_7069   (appelée depuis 704e)
07069  80 3e 43 14 02       cmp byte ptr [0x1443], 2
0706e  74 01                je loc_7071
07070  c3                   ret
loc_7071:
07071  e8 56 0f             call sub_7fca
07074  80 3e ac 14 03       cmp byte ptr [0x14ac], 3
07079  74 04                je loc_707f
0707b  8b df                mov bx, di
0707d  8b ce                mov cx, si
loc_707f:
0707f  3b 0e ad 14          cmp cx, word ptr [0x14ad]
07083  72 11                jb loc_7096
07085  2b 0e ad 14          sub cx, word ptr [0x14ad]
07089  83 f9 10             cmp cx, 0x10
0708c  72 16                jb loc_70a4
0708e  80 0e 34 1c 02       or byte ptr [0x1c34], 2
07093  eb 0f                jmp loc_70a4
; ---- 1 octets non atteints (7095-7095)
loc_7096:
07096  2b 0e ad 14          sub cx, word ptr [0x14ad]
0709a  83 f9 f0             cmp cx, -0x10
0709d  77 05                ja loc_70a4
0709f  80 0e 34 1c 01       or byte ptr [0x1c34], 1
loc_70a4:
070a4  3b 1e af 14          cmp bx, word ptr [0x14af]
070a8  72 11                jb loc_70bb
070aa  2b 1e af 14          sub bx, word ptr [0x14af]
070ae  83 fb 10             cmp bx, 0x10
070b1  72 16                jb loc_70c9
070b3  80 0e 34 1c 08       or byte ptr [0x1c34], 8
070b8  eb 0f                jmp loc_70c9
; ---- 1 octets non atteints (70ba-70ba)
loc_70bb:
070bb  2b 1e af 14          sub bx, word ptr [0x14af]
070bf  83 fb f0             cmp bx, -0x10
070c2  77 05                ja loc_70c9
070c4  80 0e 34 1c 04       or byte ptr [0x1c34], 4
loc_70c9:
070c9  e8 45 0f             call sub_8011
070cc  a9 01 00             test ax, 1
070cf  74 05                je loc_70d6
070d1  80 0e 34 1c 10       or byte ptr [0x1c34], 0x10
loc_70d6:
070d6  a9 02 00             test ax, 2
070d9  74 05                je loc_70e0
070db  80 0e 34 1c 20       or byte ptr [0x1c34], 0x20
loc_70e0:
070e0  a9 04 00             test ax, 4
070e3  74 05                je loc_70ea
070e5  80 0e 34 1c 10       or byte ptr [0x1c34], 0x10
loc_70ea:
070ea  a9 08 00             test ax, 8
070ed  74 05                je loc_70f4
070ef  80 0e 34 1c 20       or byte ptr [0x1c34], 0x20
loc_70f4:
070f4  c3                   ret

; ======== sub_70f5   (appelée depuis 7051)
070f5  f6 06 34 1c 01       test byte ptr [0x1c34], 1
070fa  74 0c                je loc_7108
070fc  83 3e 37 1c 04       cmp word ptr [0x1c37], 4
07101  72 05                jb loc_7108
07103  83 2e 37 1c 04       sub word ptr [0x1c37], 4
loc_7108:
07108  f6 06 34 1c 02       test byte ptr [0x1c34], 2
0710d  74 0d                je loc_711c
0710f  81 3e 37 1c c2 00    cmp word ptr [0x1c37], 0xc2
07115  77 05                ja loc_711c
07117  83 06 37 1c 04       add word ptr [0x1c37], 4
loc_711c:
0711c  f6 06 34 1c 04       test byte ptr [0x1c34], 4
07121  74 0c                je loc_712f
07123  83 3e 35 1c 04       cmp word ptr [0x1c35], 4
07128  72 05                jb loc_712f
0712a  83 2e 35 1c 04       sub word ptr [0x1c35], 4
loc_712f:
0712f  f6 06 34 1c 08       test byte ptr [0x1c34], 8
07134  75 01                jne loc_7137
07136  c3                   ret
loc_7137:
07137  81 3e 35 1c 3b 01    cmp word ptr [0x1c35], 0x13b
0713d  76 01                jbe loc_7140
0713f  c3                   ret
loc_7140:
07140  83 06 35 1c 04       add word ptr [0x1c35], 4
07145  c3                   ret

; ======== sub_7146   (appelée depuis 7054)
07146  80 3e 43 14 00       cmp byte ptr [0x1443], 0
0714b  74 01                je loc_714e
0714d  c3                   ret
loc_714e:
0714e  b8 03 00             mov ax, 3
07151  cd 33                int 0x33
07153  f7 c3 01 00          test bx, 1
07157  74 05                je loc_715e
07159  80 0e 34 1c 10       or byte ptr [0x1c34], 0x10
loc_715e:
0715e  f7 c3 02 00          test bx, 2
07162  74 05                je loc_7169
07164  80 0e 34 1c 20       or byte ptr [0x1c34], 0x20
loc_7169:
07169  d1 e9                shr cx, 1
0716b  3b 0e 35 1c          cmp cx, word ptr [0x1c35]
0716f  74 0e                je loc_717f
07171  72 07                jb loc_717a
07173  80 0e 34 1c 08       or byte ptr [0x1c34], 8
07178  eb 05                jmp loc_717f
loc_717a:
0717a  80 0e 34 1c 04       or byte ptr [0x1c34], 4
loc_717f:
0717f  3b 16 37 1c          cmp dx, word ptr [0x1c37]
07183  74 0f                je loc_7194
07185  72 08                jb loc_718f
07187  80 0e 34 1c 02       or byte ptr [0x1c34], 2
0718c  eb 06                jmp loc_7194
; ---- 1 octets non atteints (718e-718e)
loc_718f:
0718f  80 0e 34 1c 01       or byte ptr [0x1c34], 1
loc_7194:
07194  89 0e 35 1c          mov word ptr [0x1c35], cx
07198  89 16 37 1c          mov word ptr [0x1c37], dx
0719c  c3                   ret

; ======== sub_719d   (routine probable : non appelée directement)
0719d  80 3e 43 14 00       cmp byte ptr [0x1443], 0
071a2  74 01                je loc_71a5
071a4  c3                   ret
loc_71a5:
071a5  33 c9                xor cx, cx
071a7  8b d2                mov dx, dx
071a9  b8 04 00             mov ax, 4
071ac  cd 33                int 0x33
071ae  c3                   ret

; ======== sub_71af   (routine probable : non appelée directement)
071af  e8 60 fe             call sub_7012
071b2  80 3e 34 1c 00       cmp byte ptr [0x1c34], 0
071b7  74 f6                je sub_71af
071b9  c3                   ret

; ======== sub_71ba   (appelée depuis 71e0)
071ba  e8 55 fe             call sub_7012
071bd  80 3e 34 1c 00       cmp byte ptr [0x1c34], 0
071c2  75 f6                jne sub_71ba
071c4  c3                   ret
loc_71c5:
071c5  9c                   pushf
071c6  50                   push ax
071c7  53                   push bx
071c8  51                   push cx
071c9  52                   push dx
071ca  57                   push di
071cb  56                   push si
071cc  55                   push bp
071cd  06                   push es
071ce  1e                   push ds
071cf  50                   push ax
071d0  b8 00 00             mov ax, 0
071d3  8e d8                mov ds, ax
071d5  58                   pop ax
loc_71d6:
071d6  e8 39 fe             call sub_7012
071d9  80 3e 34 1c 20       cmp byte ptr [0x1c34], 0x20
071de  75 f6                jne loc_71d6
071e0  e8 d7 ff             call sub_71ba
071e3  1f                   pop ds
071e4  07                   pop es
071e5  5d                   pop bp
071e6  5e                   pop si
071e7  5f                   pop di
071e8  5a                   pop dx
071e9  59                   pop cx
071ea  5b                   pop bx
071eb  58                   pop ax
071ec  9d                   popf
071ed  c3                   ret

; ======== sub_71ee   (routine probable : non appelée directement)
071ee  9c                   pushf
071ef  50                   push ax
071f0  53                   push bx
071f1  51                   push cx
071f2  52                   push dx
071f3  57                   push di
071f4  56                   push si
071f5  55                   push bp
071f6  06                   push es
071f7  1e                   push ds
071f8  50                   push ax
071f9  b8 00 00             mov ax, 0
071fc  8e d8                mov ds, ax
071fe  58                   pop ax
loc_71ff:
071ff  e8 10 fe             call sub_7012
07202  f6 06 34 1c 10       test byte ptr [0x1c34], 0x10
07207  74 f6                je loc_71ff
07209  1f                   pop ds
0720a  07                   pop es
0720b  5d                   pop bp
0720c  5e                   pop si
0720d  5f                   pop di
0720e  5a                   pop dx
0720f  59                   pop cx
07210  5b                   pop bx
07211  58                   pop ax
07212  9d                   popf
07213  c3                   ret

; ======== sub_7214   (routine probable : non appelée directement)
07214  9c                   pushf
07215  50                   push ax
07216  53                   push bx
07217  51                   push cx
07218  52                   push dx
07219  57                   push di
0721a  56                   push si
0721b  55                   push bp
0721c  06                   push es
0721d  1e                   push ds
0721e  50                   push ax
0721f  b8 00 00             mov ax, 0
07222  8e d8                mov ds, ax
07224  58                   pop ax
loc_7225:
07225  e8 ea fd             call sub_7012
07228  f6 06 34 1c 10       test byte ptr [0x1c34], 0x10
0722d  75 f6                jne loc_7225
0722f  f6 06 34 1c 20       test byte ptr [0x1c34], 0x20
07234  75 ef                jne loc_7225
07236  1f                   pop ds
07237  07                   pop es
07238  5d                   pop bp
07239  5e                   pop si
0723a  5f                   pop di
0723b  5a                   pop dx
0723c  59                   pop cx
0723d  5b                   pop bx
0723e  58                   pop ax
0723f  9d                   popf
07240  c3                   ret

; ======== sub_7241   (appelée depuis 44e7, 4689, 469e, 46c5, 4707, 474b, 4781, 48a1)
07241  c7 06 8b 1a 00 00    mov word ptr [0x1a8b], 0
07247  e8 67 fd             call sub_6fb1
0724a  e8 3b 00             call sub_7288
0724d  83 3e 8b 1a 00       cmp word ptr [0x1a8b], 0
07252  74 03                je loc_7257
07254  eb 1c                jmp loc_7272
; ---- 1 octets non atteints (7256-7256)
loc_7257:
07257  e8 62 00             call sub_72bc
0725a  a3 a7 1b             mov word ptr [0x1ba7], ax
0725d  eb 10                jmp loc_726f
; ---- 1 octets non atteints (725f-725f)

; ======== sub_7260   (appelée depuis 4822, 4870)
07260  c7 06 8b 1a 00 00    mov word ptr [0x1a8b], 0
07266  e8 48 fd             call sub_6fb1
07269  e8 0a 00             call sub_7276
0726c  e8 33 00             call sub_72a2
loc_726f:
0726f  e8 62 00             call sub_72d4
loc_7272:
07272  e8 05 fd             call sub_6f7a
07275  c3                   ret

; ======== sub_7276   (appelée depuis 7269)
07276  8b 16 a9 1b          mov dx, word ptr [0x1ba9]
0727a  33 c9                xor cx, cx
0727c  b0 02                mov al, 2
0727e  b4 3c                mov ah, 0x3c
07280  cd 21                int 0x21
07282  72 1a                jb loc_729e
07284  a3 ab 1b             mov word ptr [0x1bab], ax
07287  c3                   ret

; ======== sub_7288   (appelée depuis 724a)
07288  8b 16 a9 1b          mov dx, word ptr [0x1ba9]
0728c  32 c0                xor al, al
0728e  b4 3d                mov ah, 0x3d
07290  cd 21                int 0x21
07292  72 0a                jb loc_729e
07294  c7 06 8b 1a 00 00    mov word ptr [0x1a8b], 0
0729a  a3 ab 1b             mov word ptr [0x1bab], ax
0729d  c3                   ret
loc_729e:
0729e  a3 8b 1a             mov word ptr [0x1a8b], ax
072a1  c3                   ret

; ======== sub_72a2   (appelée depuis 726c)
072a2  a1 a3 1b             mov ax, word ptr [0x1ba3]
072a5  8b 1e ab 1b          mov bx, word ptr [0x1bab]
072a9  8b 0e a7 1b          mov cx, word ptr [0x1ba7]
072ad  8b 16 a5 1b          mov dx, word ptr [0x1ba5]
072b1  1e                   push ds
072b2  8e d8                mov ds, ax
072b4  b4 40                mov ah, 0x40
072b6  cd 21                int 0x21
072b8  1f                   pop ds
072b9  72 e3                jb loc_729e
072bb  c3                   ret

; ======== sub_72bc   (appelée depuis 7257)
072bc  a1 a3 1b             mov ax, word ptr [0x1ba3]
072bf  8b 1e ab 1b          mov bx, word ptr [0x1bab]
072c3  b9 ff ff             mov cx, 0xffff
072c6  8b 16 a5 1b          mov dx, word ptr [0x1ba5]
072ca  1e                   push ds
072cb  8e d8                mov ds, ax
072cd  b4 3f                mov ah, 0x3f
072cf  cd 21                int 0x21
072d1  1f                   pop ds
072d2  72 ca                jb loc_729e

; ======== sub_72d4   (appelée depuis 726f)
072d4  8b 1e ab 1b          mov bx, word ptr [0x1bab]
072d8  b4 3e                mov ah, 0x3e
072da  cd 21                int 0x21
072dc  72 c0                jb loc_729e
072de  c3                   ret

; ======== sub_72df   (appelée depuis 7370)
072df  89 0e 26 1d          mov word ptr [0x1d26], cx
072e3  89 3e 28 1d          mov word ptr [0x1d28], di
072e7  50                   push ax
072e8  b8 00 00             mov ax, 0
072eb  8e c0                mov es, ax
072ed  58                   pop ax
072ee  b8 20 00             mov ax, 0x20
072f1  f3 aa                rep stosb byte ptr es:[di], al
072f3  c7 06 2a 1d 00 00    mov word ptr [0x1d2a], 0
loc_72f9:
072f9  e8 99 fb             call sub_6e95
072fc  3c 0d                cmp al, 0xd
072fe  75 01                jne loc_7301
07300  c3                   ret
loc_7301:
07301  80 fc 0e             cmp ah, 0xe
07304  74 3a                je loc_7340
07306  3c 20                cmp al, 0x20
07308  72 ef                jb loc_72f9
0730a  3c 7a                cmp al, 0x7a
0730c  77 eb                ja loc_72f9
0730e  80 3e 2c 1d 01       cmp byte ptr [0x1d2c], 1
07313  75 08                jne loc_731d
07315  3c 30                cmp al, 0x30
07317  72 e0                jb loc_72f9
07319  3c 39                cmp al, 0x39
0731b  77 dc                ja loc_72f9
loc_731d:
0731d  8b 1e 2a 1d          mov bx, word ptr [0x1d2a]
07321  3b 1e 26 1d          cmp bx, word ptr [0x1d26]
07325  73 d2                jae loc_72f9
07327  50                   push ax
07328  b8 00 00             mov ax, 0
0732b  8e c0                mov es, ax
0732d  58                   pop ax
0732e  8b 3e 28 1d          mov di, word ptr [0x1d28]
07332  aa                   stosb byte ptr es:[di], al
07333  89 3e 28 1d          mov word ptr [0x1d28], di
07337  e8 11 f7             call sub_6a4b
0733a  ff 06 2a 1d          inc word ptr [0x1d2a]
0733e  eb b9                jmp loc_72f9
loc_7340:
07340  83 3e 2a 1d 00       cmp word ptr [0x1d2a], 0
07345  74 b2                je loc_72f9
07347  ff 0e f4 19          dec word ptr [0x19f4]
0734b  b0 20                mov al, 0x20
0734d  8b 3e 28 1d          mov di, word ptr [0x1d28]
07351  4f                   dec di
07352  88 05                mov byte ptr [di], al
07354  89 3e 28 1d          mov word ptr [0x1d28], di
07358  e8 f0 f6             call sub_6a4b
0735b  ff 0e f4 19          dec word ptr [0x19f4]
0735f  ff 0e 2a 1d          dec word ptr [0x1d2a]
07363  eb 94                jmp loc_72f9

; ======== sub_7365   (routine probable : non appelée directement)
07365  c6 06 2c 1d 01       mov byte ptr [0x1d2c], 1
0736a  bf 95 1a             mov di, 0x1a95
0736d  b9 02 00             mov cx, 2
07370  e8 6c ff             call sub_72df
07373  83 3e 2a 1d 00       cmp word ptr [0x1d2a], 0
07378  74 eb                je sub_7365
0737a  c6 06 2c 1d 00       mov byte ptr [0x1d2c], 0
0737f  8b 0e 2a 1d          mov cx, word ptr [0x1d2a]
07383  bf 95 1a             mov di, 0x1a95
07386  33 c0                xor ax, ax
07388  b2 0a                mov dl, 0xa
loc_738a:
0738a  8a 1d                mov bl, byte ptr [di]
0738c  47                   inc di
0738d  80 eb 30             sub bl, 0x30
07390  f6 e2                mul dl
07392  02 c3                add al, bl
07394  e2 f4                loop loc_738a
07396  32 e4                xor ah, ah
07398  c3                   ret

; ======== sub_7399   (appelée depuis 7419)
07399  9c                   pushf
0739a  50                   push ax
0739b  53                   push bx
0739c  51                   push cx
0739d  52                   push dx
0739e  57                   push di
0739f  56                   push si
073a0  55                   push bp
073a1  06                   push es
073a2  1e                   push ds
073a3  8b c7                mov ax, di
073a5  33 d2                xor dx, dx
073a7  b9 40 01             mov cx, 0x140
073aa  f7 f1                div cx
073ac  52                   push dx
073ad  b9 a0 00             mov cx, 0xa0
073b0  f7 e1                mul cx
073b2  8b d0                mov dx, ax
073b4  58                   pop ax
073b5  8b c8                mov cx, ax
073b7  80 e1 07             and cl, 7
073ba  89 0e 9b 1a          mov word ptr [0x1a9b], cx
073be  d1 e8                shr ax, 1
073c0  d1 e8                shr ax, 1
073c2  d1 e8                shr ax, 1
073c4  03 c2                add ax, dx
073c6  a3 9d 1a             mov word ptr [0x1a9d], ax
073c9  1f                   pop ds
073ca  07                   pop es
073cb  5d                   pop bp
073cc  5e                   pop si
073cd  5f                   pop di
073ce  5a                   pop dx
073cf  59                   pop cx
073d0  5b                   pop bx
073d1  58                   pop ax
073d2  9d                   popf
073d3  c3                   ret

; ======== sub_73d4   (appelée depuis 75f7, 799e)
073d4  9c                   pushf
073d5  50                   push ax
073d6  53                   push bx
073d7  51                   push cx
073d8  52                   push dx
073d9  57                   push di
073da  56                   push si
073db  55                   push bp
073dc  06                   push es
073dd  1e                   push ds
073de  c7 06 9b 1a 00 00    mov word ptr [0x1a9b], 0
073e4  d1 ef                shr di, 1
073e6  73 06                jae loc_73ee
073e8  c7 06 9b 1a 01 00    mov word ptr [0x1a9b], 1
loc_73ee:
073ee  8b c7                mov ax, di
073f0  33 d2                xor dx, dx
073f2  b9 a0 00             mov cx, 0xa0
073f5  f7 f1                div cx
073f7  8b d8                mov bx, ax
073f9  d1 e3                shl bx, 1
073fb  8b bf 2d 1d          mov di, word ptr [bx + 0x1d2d]
073ff  03 fa                add di, dx
07401  89 3e 9d 1a          mov word ptr [0x1a9d], di
07405  1f                   pop ds
07406  07                   pop es
07407  5d                   pop bp
07408  5e                   pop si
07409  5f                   pop di
0740a  5a                   pop dx
0740b  59                   pop cx
0740c  5b                   pop bx
0740d  58                   pop ax
0740e  9d                   popf
0740f  c3                   ret

; ======== sub_7410   (appelée depuis 496f)
07410  bb c8 19             mov bx, 0x19c8
07413  03 1e 40 14          add bx, word ptr [0x1440]
07417  ff 27                jmp word ptr [bx]
loc_7419:
07419  e8 7d ff             call sub_7399
0741c  a1 9b 1a             mov ax, word ptr [0x1a9b]
0741f  8b 3e 9d 1a          mov di, word ptr [0x1a9d]
07423  50                   push ax
07424  a1 f0 19             mov ax, word ptr [0x19f0]
07427  8e d8                mov ds, ax
07429  d1 ed                shr bp, 1
0742b  d1 ed                shr bp, 1
0742d  d1 ed                shr bp, 1
0742f  d1 ee                shr si, 1
07431  bb 28 00             mov bx, 0x28
07434  2b dd                sub bx, bp
07436  58                   pop ax
07437  0b c0                or ax, ax
07439  75 69                jne loc_74a4
loc_743b:
0743b  8b d1                mov dx, cx
0743d  8b cd                mov cx, bp
loc_743f:
0743f  8a 24                mov ah, byte ptr [si]
07441  56                   push si
07442  03 f5                add si, bp
07444  0a 24                or ah, byte ptr [si]
07446  03 f5                add si, bp
07448  0a 24                or ah, byte ptr [si]
0744a  03 f5                add si, bp
0744c  0a 24                or ah, byte ptr [si]
0744e  5e                   pop si
0744f  f6 d4                not ah
07451  56                   push si
07452  57                   push di
07453  8a 04                mov al, byte ptr [si]
07455  26 20 25             and byte ptr es:[di], ah
07458  26 08 05             or byte ptr es:[di], al
0745b  03 f5                add si, bp
0745d  83 c7 28             add di, 0x28
07460  8a 04                mov al, byte ptr [si]
07462  26 20 25             and byte ptr es:[di], ah
07465  26 08 05             or byte ptr es:[di], al
07468  03 f5                add si, bp
0746a  83 c7 28             add di, 0x28
0746d  8a 04                mov al, byte ptr [si]
0746f  26 20 25             and byte ptr es:[di], ah
07472  26 08 05             or byte ptr es:[di], al
07475  03 f5                add si, bp
07477  83 c7 28             add di, 0x28
0747a  8a 04                mov al, byte ptr [si]
0747c  26 20 25             and byte ptr es:[di], ah
0747f  26 08 05             or byte ptr es:[di], al
07482  03 f5                add si, bp
07484  83 c7 28             add di, 0x28
07487  5f                   pop di
07488  5e                   pop si
07489  46                   inc si
0748a  47                   inc di
0748b  e2 b2                loop loc_743f
0748d  03 f5                add si, bp
0748f  03 f5                add si, bp
07491  03 f5                add si, bp
07493  03 fb                add di, bx
07495  83 c7 78             add di, 0x78
07498  8b ca                mov cx, dx
0749a  e2 9f                loop loc_743b
0749c  50                   push ax
0749d  b8 00 00             mov ax, 0
074a0  8e d8                mov ds, ax
074a2  58                   pop ax
074a3  c3                   ret
loc_74a4:
074a4  2e 89 0e 02 25       mov word ptr cs:[0x2502], cx
074a9  8b c8                mov cx, ax
loc_74ab:
074ab  57                   push di
074ac  56                   push si
074ad  8a 24                mov ah, byte ptr [si]
074af  56                   push si
074b0  03 f5                add si, bp
074b2  0a 24                or ah, byte ptr [si]
074b4  03 f5                add si, bp
074b6  0a 24                or ah, byte ptr [si]
074b8  03 f5                add si, bp
074ba  0a 24                or ah, byte ptr [si]
074bc  5e                   pop si
074bd  f6 d4                not ah
074bf  8a c4                mov al, ah
074c1  b4 ff                mov ah, 0xff
074c3  d3 e8                shr ax, cl
074c5  56                   push si
074c6  57                   push di
074c7  8a 1c                mov bl, byte ptr [si]
074c9  32 ff                xor bh, bh
074cb  d3 eb                shr bx, cl
074cd  26 20 05             and byte ptr es:[di], al
074d0  26 08 1d             or byte ptr es:[di], bl
074d3  03 f5                add si, bp
074d5  83 c7 28             add di, 0x28
074d8  8a 1c                mov bl, byte ptr [si]
074da  32 ff                xor bh, bh
074dc  d3 eb                shr bx, cl
074de  26 20 05             and byte ptr es:[di], al
074e1  26 08 1d             or byte ptr es:[di], bl
074e4  03 f5                add si, bp
074e6  83 c7 28             add di, 0x28
074e9  8a 1c                mov bl, byte ptr [si]
074eb  32 ff                xor bh, bh
074ed  d3 eb                shr bx, cl
074ef  26 20 05             and byte ptr es:[di], al
074f2  26 08 1d             or byte ptr es:[di], bl
074f5  03 f5                add si, bp
074f7  83 c7 28             add di, 0x28
074fa  8a 1c                mov bl, byte ptr [si]
074fc  32 ff                xor bh, bh
074fe  d3 eb                shr bx, cl
07500  26 20 05             and byte ptr es:[di], al
07503  26 08 1d             or byte ptr es:[di], bl
07506  03 f5                add si, bp
07508  83 c7 28             add di, 0x28
0750b  5f                   pop di
0750c  5e                   pop si
0750d  47                   inc di
0750e  83 fd 01             cmp bp, 1
07511  74 71                je loc_7584
07513  2e 89 2e 00 25       mov word ptr cs:[0x2500], bp
07518  2e ff 0e 00 25       dec word ptr cs:[0x2500]
loc_751d:
0751d  8b 04                mov ax, word ptr [si]
0751f  56                   push si
07520  03 f5                add si, bp
07522  0b 04                or ax, word ptr [si]
07524  03 f5                add si, bp
07526  0b 04                or ax, word ptr [si]
07528  03 f5                add si, bp
0752a  0b 04                or ax, word ptr [si]
0752c  5e                   pop si
0752d  f7 d0                not ax
0752f  86 e0                xchg al, ah
07531  d3 e8                shr ax, cl
07533  56                   push si
07534  57                   push di
07535  8b 1c                mov bx, word ptr [si]
07537  86 fb                xchg bl, bh
07539  d3 eb                shr bx, cl
0753b  26 20 05             and byte ptr es:[di], al
0753e  26 08 1d             or byte ptr es:[di], bl
07541  03 f5                add si, bp
07543  83 c7 28             add di, 0x28
07546  8b 1c                mov bx, word ptr [si]
07548  86 fb                xchg bl, bh
0754a  d3 eb                shr bx, cl
0754c  26 20 05             and byte ptr es:[di], al
0754f  26 08 1d             or byte ptr es:[di], bl
07552  03 f5                add si, bp
07554  83 c7 28             add di, 0x28
07557  8b 1c                mov bx, word ptr [si]
07559  86 fb                xchg bl, bh
0755b  d3 eb                shr bx, cl
0755d  26 20 05             and byte ptr es:[di], al
07560  26 08 1d             or byte ptr es:[di], bl
07563  03 f5                add si, bp
07565  83 c7 28             add di, 0x28
07568  8b 1c                mov bx, word ptr [si]
0756a  86 fb                xchg bl, bh
0756c  d3 eb                shr bx, cl
0756e  26 20 05             and byte ptr es:[di], al
07571  26 08 1d             or byte ptr es:[di], bl
07574  03 f5                add si, bp
07576  83 c7 28             add di, 0x28
07579  5f                   pop di
0757a  5e                   pop si
0757b  47                   inc di
0757c  46                   inc si
0757d  2e ff 0e 00 25       dec word ptr cs:[0x2500]
07582  75 99                jne loc_751d
loc_7584:
07584  8a 24                mov ah, byte ptr [si]
07586  56                   push si
07587  03 f5                add si, bp
07589  0a 24                or ah, byte ptr [si]
0758b  03 f5                add si, bp
0758d  0a 24                or ah, byte ptr [si]
0758f  03 f5                add si, bp
07591  0a 24                or ah, byte ptr [si]
07593  5e                   pop si
07594  f6 d4                not ah
07596  b0 ff                mov al, 0xff
07598  d3 e8                shr ax, cl
0759a  8a 3c                mov bh, byte ptr [si]
0759c  32 db                xor bl, bl
0759e  d3 eb                shr bx, cl
075a0  26 20 05             and byte ptr es:[di], al
075a3  26 08 1d             or byte ptr es:[di], bl
075a6  03 f5                add si, bp
075a8  83 c7 28             add di, 0x28
075ab  8a 3c                mov bh, byte ptr [si]
075ad  32 db                xor bl, bl
075af  d3 eb                shr bx, cl
075b1  26 20 05             and byte ptr es:[di], al
075b4  26 08 1d             or byte ptr es:[di], bl
075b7  03 f5                add si, bp
075b9  83 c7 28             add di, 0x28
075bc  8a 3c                mov bh, byte ptr [si]
075be  32 db                xor bl, bl
075c0  d3 eb                shr bx, cl
075c2  26 20 05             and byte ptr es:[di], al
075c5  26 08 1d             or byte ptr es:[di], bl
075c8  03 f5                add si, bp
075ca  83 c7 28             add di, 0x28
075cd  8a 3c                mov bh, byte ptr [si]
075cf  32 db                xor bl, bl
075d1  d3 eb                shr bx, cl
075d3  26 20 05             and byte ptr es:[di], al
075d6  26 08 1d             or byte ptr es:[di], bl
075d9  03 f5                add si, bp
075db  83 c7 28             add di, 0x28
075de  5e                   pop si
075df  03 f5                add si, bp
075e1  03 f5                add si, bp
075e3  03 f5                add si, bp
075e5  03 f5                add si, bp
075e7  5f                   pop di
075e8  81 c7 a0 00          add di, 0xa0
075ec  2e ff 0e 02 25       dec word ptr cs:[0x2502]
075f1  74 03                je loc_75f6
075f3  e9 b5 fe             jmp loc_74ab
loc_75f6:
075f6  c3                   ret
loc_75f7:
075f7  e8 da fd             call sub_73d4
075fa  8b 3e 9d 1a          mov di, word ptr [0x1a9d]
075fe  8b 1e 9b 1a          mov bx, word ptr [0x1a9b]
07602  d1 ee                shr si, 1
07604  a1 f0 19             mov ax, word ptr [0x19f0]
07607  8e d8                mov ds, ax
07609  2e 89 0e 02 25       mov word ptr cs:[0x2502], cx
0760e  d1 ed                shr bp, 1
07610  2e 89 2e 04 25       mov word ptr cs:[0x2504], bp
07615  d1 ed                shr bp, 1
07617  d1 ed                shr bp, 1
07619  2e 89 2e 00 25       mov word ptr cs:[0x2500], bp
0761e  83 fb 01             cmp bx, 1
07621  75 03                jne loc_7626
07623  e9 19 01             jmp loc_773f
loc_7626:
07626  2e 8b 0e 00 25       mov cx, word ptr cs:[0x2500]
0762b  57                   push di
0762c  56                   push si
loc_762d:
0762d  2e 8b 1e 04 25       mov bx, word ptr cs:[0x2504]
07632  2e 2b 1e 00 25       sub bx, word ptr cs:[0x2500]
07637  8a 00                mov al, byte ptr [bx + si]
07639  2e 2b 1e 00 25       sub bx, word ptr cs:[0x2500]
0763e  8a 30                mov dh, byte ptr [bx + si]
07640  2e 2b 1e 00 25       sub bx, word ptr cs:[0x2500]
07645  8a 10                mov dl, byte ptr [bx + si]
07647  8a 1c                mov bl, byte ptr [si]
07649  d0 e3                shl bl, 1
0764b  d0 d4                rcl ah, 1
0764d  d0 e2                shl dl, 1
0764f  d0 d4                rcl ah, 1
07651  d0 e6                shl dh, 1
07653  d0 d4                rcl ah, 1
07655  d0 e0                shl al, 1
07657  d0 d4                rcl ah, 1
07659  d0 e3                shl bl, 1
0765b  d0 d4                rcl ah, 1
0765d  d0 e2                shl dl, 1
0765f  d0 d4                rcl ah, 1
07661  d0 e6                shl dh, 1
07663  d0 d4                rcl ah, 1
07665  d0 e0                shl al, 1
07667  d0 d4                rcl ah, 1
07669  50                   push ax
0766a  53                   push bx
0766b  8a c4                mov al, ah
0766d  bb 00 24             mov bx, 0x2400
07670  2e d7                xlatb
07672  5b                   pop bx
07673  26 20 05             and byte ptr es:[di], al
07676  26 08 25             or byte ptr es:[di], ah
07679  58                   pop ax
0767a  47                   inc di
0767b  d0 e3                shl bl, 1
0767d  d0 d4                rcl ah, 1
0767f  d0 e2                shl dl, 1
07681  d0 d4                rcl ah, 1
07683  d0 e6                shl dh, 1
07685  d0 d4                rcl ah, 1
07687  d0 e0                shl al, 1
07689  d0 d4                rcl ah, 1
0768b  d0 e3                shl bl, 1
0768d  d0 d4                rcl ah, 1
0768f  d0 e2                shl dl, 1
07691  d0 d4                rcl ah, 1
07693  d0 e6                shl dh, 1
07695  d0 d4                rcl ah, 1
07697  d0 e0                shl al, 1
07699  d0 d4                rcl ah, 1
0769b  50                   push ax
0769c  53                   push bx
0769d  8a c4                mov al, ah
0769f  bb 00 24             mov bx, 0x2400
076a2  2e d7                xlatb
076a4  5b                   pop bx
076a5  26 20 05             and byte ptr es:[di], al
076a8  26 08 25             or byte ptr es:[di], ah
076ab  58                   pop ax
076ac  47                   inc di
076ad  d0 e3                shl bl, 1
076af  d0 d4                rcl ah, 1
076b1  d0 e2                shl dl, 1
076b3  d0 d4                rcl ah, 1
076b5  d0 e6                shl dh, 1
076b7  d0 d4                rcl ah, 1
076b9  d0 e0                shl al, 1
076bb  d0 d4                rcl ah, 1
076bd  d0 e3                shl bl, 1
076bf  d0 d4                rcl ah, 1
076c1  d0 e2                shl dl, 1
076c3  d0 d4                rcl ah, 1
076c5  d0 e6                shl dh, 1
076c7  d0 d4                rcl ah, 1
076c9  d0 e0                shl al, 1
076cb  d0 d4                rcl ah, 1
076cd  50                   push ax
076ce  53                   push bx
076cf  8a c4                mov al, ah
076d1  bb 00 24             mov bx, 0x2400
076d4  2e d7                xlatb
076d6  5b                   pop bx
076d7  26 20 05             and byte ptr es:[di], al
076da  26 08 25             or byte ptr es:[di], ah
076dd  58                   pop ax
076de  47                   inc di
076df  d0 e3                shl bl, 1
076e1  d0 d4                rcl ah, 1
076e3  d0 e2                shl dl, 1
076e5  d0 d4                rcl ah, 1
076e7  d0 e6                shl dh, 1
076e9  d0 d4                rcl ah, 1
076eb  d0 e0                shl al, 1
076ed  d0 d4                rcl ah, 1
076ef  d0 e3                shl bl, 1
076f1  d0 d4                rcl ah, 1
076f3  d0 e2                shl dl, 1
076f5  d0 d4                rcl ah, 1
076f7  d0 e6                shl dh, 1
076f9  d0 d4                rcl ah, 1
076fb  d0 e0                shl al, 1
076fd  d0 d4                rcl ah, 1
076ff  50                   push ax
07700  53                   push bx
07701  8a c4                mov al, ah
07703  bb 00 24             mov bx, 0x2400
07706  2e d7                xlatb
07708  5b                   pop bx
07709  26 20 05             and byte ptr es:[di], al
0770c  26 08 25             or byte ptr es:[di], ah
0770f  58                   pop ax
07710  47                   inc di
07711  46                   inc si
07712  49                   dec cx
07713  74 03                je loc_7718
07715  e9 15 ff             jmp loc_762d
loc_7718:
07718  5e                   pop si
07719  5f                   pop di
0771a  2e 03 36 04 25       add si, word ptr cs:[0x2504]
0771f  81 c7 00 20          add di, 0x2000
07723  f7 c7 00 80          test di, 0x8000
07727  74 04                je loc_772d
07729  81 ef 60 7f          sub di, 0x7f60
loc_772d:
0772d  2e ff 0e 02 25       dec word ptr cs:[0x2502]
07732  74 03                je loc_7737
07734  e9 ef fe             jmp loc_7626
loc_7737:
07737  50                   push ax
07738  b8 00 00             mov ax, 0
0773b  8e d8                mov ds, ax
0773d  58                   pop ax
0773e  c3                   ret
loc_773f:
0773f  2e 89 0e 02 25       mov word ptr cs:[0x2502], cx
loc_7744:
07744  2e 8b 0e 00 25       mov cx, word ptr cs:[0x2500]
07749  57                   push di
0774a  56                   push si
0774b  32 e4                xor ah, ah
0774d  2e 8b 1e 04 25       mov bx, word ptr cs:[0x2504]
07752  2e 2b 1e 00 25       sub bx, word ptr cs:[0x2500]
07757  8a 00                mov al, byte ptr [bx + si]
07759  2e 2b 1e 00 25       sub bx, word ptr cs:[0x2500]
0775e  8a 30                mov dh, byte ptr [bx + si]
07760  2e 2b 1e 00 25       sub bx, word ptr cs:[0x2500]
07765  8a 10                mov dl, byte ptr [bx + si]
07767  8a 1c                mov bl, byte ptr [si]
07769  d0 e3                shl bl, 1
0776b  d0 d4                rcl ah, 1
0776d  d0 e2                shl dl, 1
0776f  d0 d4                rcl ah, 1
07771  d0 e6                shl dh, 1
07773  d0 d4                rcl ah, 1
07775  d0 e0                shl al, 1
07777  d0 d4                rcl ah, 1
07779  50                   push ax
0777a  53                   push bx
0777b  8a c4                mov al, ah
0777d  bb 00 24             mov bx, 0x2400
07780  2e d7                xlatb
07782  5b                   pop bx
07783  26 20 05             and byte ptr es:[di], al
07786  26 08 25             or byte ptr es:[di], ah
07789  58                   pop ax
0778a  47                   inc di
0778b  83 f9 01             cmp cx, 1
0778e  75 03                jne loc_7793
07790  e9 ec 00             jmp loc_787f
loc_7793:
07793  49                   dec cx
loc_7794:
07794  d0 e3                shl bl, 1
07796  d0 d4                rcl ah, 1
07798  d0 e2                shl dl, 1
0779a  d0 d4                rcl ah, 1
0779c  d0 e6                shl dh, 1
0779e  d0 d4                rcl ah, 1
077a0  d0 e0                shl al, 1
077a2  d0 d4                rcl ah, 1
077a4  d0 e3                shl bl, 1
077a6  d0 d4                rcl ah, 1
077a8  d0 e2                shl dl, 1
077aa  d0 d4                rcl ah, 1
077ac  d0 e6                shl dh, 1
077ae  d0 d4                rcl ah, 1
077b0  d0 e0                shl al, 1
077b2  d0 d4                rcl ah, 1
077b4  50                   push ax
077b5  53                   push bx
077b6  8a c4                mov al, ah
077b8  bb 00 24             mov bx, 0x2400
077bb  2e d7                xlatb
077bd  5b                   pop bx
077be  26 20 05             and byte ptr es:[di], al
077c1  26 08 25             or byte ptr es:[di], ah
077c4  58                   pop ax
077c5  47                   inc di
077c6  d0 e3                shl bl, 1
077c8  d0 d4                rcl ah, 1
077ca  d0 e2                shl dl, 1
077cc  d0 d4                rcl ah, 1
077ce  d0 e6                shl dh, 1
077d0  d0 d4                rcl ah, 1
077d2  d0 e0                shl al, 1
077d4  d0 d4                rcl ah, 1
077d6  d0 e3                shl bl, 1
077d8  d0 d4                rcl ah, 1
077da  d0 e2                shl dl, 1
077dc  d0 d4                rcl ah, 1
077de  d0 e6                shl dh, 1
077e0  d0 d4                rcl ah, 1
077e2  d0 e0                shl al, 1
077e4  d0 d4                rcl ah, 1
077e6  50                   push ax
077e7  53                   push bx
077e8  8a c4                mov al, ah
077ea  bb 00 24             mov bx, 0x2400
077ed  2e d7                xlatb
077ef  5b                   pop bx
077f0  26 20 05             and byte ptr es:[di], al
077f3  26 08 25             or byte ptr es:[di], ah
077f6  58                   pop ax
077f7  47                   inc di
077f8  d0 e3                shl bl, 1
077fa  d0 d4                rcl ah, 1
077fc  d0 e2                shl dl, 1
077fe  d0 d4                rcl ah, 1
07800  d0 e6                shl dh, 1
07802  d0 d4                rcl ah, 1
07804  d0 e0                shl al, 1
07806  d0 d4                rcl ah, 1
07808  d0 e3                shl bl, 1
0780a  d0 d4                rcl ah, 1
0780c  d0 e2                shl dl, 1
0780e  d0 d4                rcl ah, 1
07810  d0 e6                shl dh, 1
07812  d0 d4                rcl ah, 1
07814  d0 e0                shl al, 1
07816  d0 d4                rcl ah, 1
07818  50                   push ax
07819  53                   push bx
0781a  8a c4                mov al, ah
0781c  bb 00 24             mov bx, 0x2400
0781f  2e d7                xlatb
07821  5b                   pop bx
07822  26 20 05             and byte ptr es:[di], al
07825  26 08 25             or byte ptr es:[di], ah
07828  58                   pop ax
07829  47                   inc di
0782a  d0 e3                shl bl, 1
0782c  d0 d4                rcl ah, 1
0782e  d0 e2                shl dl, 1
07830  d0 d4                rcl ah, 1
07832  d0 e6                shl dh, 1
07834  d0 d4                rcl ah, 1
07836  d0 e0                shl al, 1
07838  d0 d4                rcl ah, 1
0783a  46                   inc si
0783b  2e 8b 1e 04 25       mov bx, word ptr cs:[0x2504]
07840  2e 2b 1e 00 25       sub bx, word ptr cs:[0x2500]
07845  8a 00                mov al, byte ptr [bx + si]
07847  2e 2b 1e 00 25       sub bx, word ptr cs:[0x2500]
0784c  8a 30                mov dh, byte ptr [bx + si]
0784e  2e 2b 1e 00 25       sub bx, word ptr cs:[0x2500]
07853  8a 10                mov dl, byte ptr [bx + si]
07855  8a 1c                mov bl, byte ptr [si]
07857  d0 e3                shl bl, 1
07859  d0 d4                rcl ah, 1
0785b  d0 e2                shl dl, 1
0785d  d0 d4                rcl ah, 1
0785f  d0 e6                shl dh, 1
07861  d0 d4                rcl ah, 1
07863  d0 e0                shl al, 1
07865  d0 d4                rcl ah, 1
07867  50                   push ax
07868  53                   push bx
07869  8a c4                mov al, ah
0786b  bb 00 24             mov bx, 0x2400
0786e  2e d7                xlatb
07870  5b                   pop bx
07871  26 20 05             and byte ptr es:[di], al
07874  26 08 25             or byte ptr es:[di], ah
07877  58                   pop ax
07878  47                   inc di
07879  49                   dec cx
0787a  74 03                je loc_787f
0787c  e9 15 ff             jmp loc_7794
loc_787f:
0787f  d0 e3                shl bl, 1
07881  d0 d4                rcl ah, 1
07883  d0 e2                shl dl, 1
07885  d0 d4                rcl ah, 1
07887  d0 e6                shl dh, 1
07889  d0 d4                rcl ah, 1
0788b  d0 e0                shl al, 1
0788d  d0 d4                rcl ah, 1
0788f  d0 e3                shl bl, 1
07891  d0 d4                rcl ah, 1
07893  d0 e2                shl dl, 1
07895  d0 d4                rcl ah, 1
07897  d0 e6                shl dh, 1
07899  d0 d4                rcl ah, 1
0789b  d0 e0                shl al, 1
0789d  d0 d4                rcl ah, 1
0789f  50                   push ax
078a0  53                   push bx
078a1  8a c4                mov al, ah
078a3  bb 00 24             mov bx, 0x2400
078a6  2e d7                xlatb
078a8  5b                   pop bx
078a9  26 20 05             and byte ptr es:[di], al
078ac  26 08 25             or byte ptr es:[di], ah
078af  58                   pop ax
078b0  47                   inc di
078b1  d0 e3                shl bl, 1
078b3  d0 d4                rcl ah, 1
078b5  d0 e2                shl dl, 1
078b7  d0 d4                rcl ah, 1
078b9  d0 e6                shl dh, 1
078bb  d0 d4                rcl ah, 1
078bd  d0 e0                shl al, 1
078bf  d0 d4                rcl ah, 1
078c1  d0 e3                shl bl, 1
078c3  d0 d4                rcl ah, 1
078c5  d0 e2                shl dl, 1
078c7  d0 d4                rcl ah, 1
078c9  d0 e6                shl dh, 1
078cb  d0 d4                rcl ah, 1
078cd  d0 e0                shl al, 1
078cf  d0 d4                rcl ah, 1
078d1  50                   push ax
078d2  53                   push bx
078d3  8a c4                mov al, ah
078d5  bb 00 24             mov bx, 0x2400
078d8  2e d7                xlatb
078da  5b                   pop bx
078db  26 20 05             and byte ptr es:[di], al
078de  26 08 25             or byte ptr es:[di], ah
078e1  58                   pop ax
078e2  47                   inc di
078e3  d0 e3                shl bl, 1
078e5  d0 d4                rcl ah, 1
078e7  d0 e2                shl dl, 1
078e9  d0 d4                rcl ah, 1
078eb  d0 e6                shl dh, 1
078ed  d0 d4                rcl ah, 1
078ef  d0 e0                shl al, 1
078f1  d0 d4                rcl ah, 1
078f3  d0 e3                shl bl, 1
078f5  d0 d4                rcl ah, 1
078f7  d0 e2                shl dl, 1
078f9  d0 d4                rcl ah, 1
078fb  d0 e6                shl dh, 1
078fd  d0 d4                rcl ah, 1
078ff  d0 e0                shl al, 1
07901  d0 d4                rcl ah, 1
07903  50                   push ax
07904  53                   push bx
07905  8a c4                mov al, ah
07907  bb 00 24             mov bx, 0x2400
0790a  2e d7                xlatb
0790c  5b                   pop bx
0790d  26 20 05             and byte ptr es:[di], al
07910  26 08 25             or byte ptr es:[di], ah
07913  58                   pop ax
07914  47                   inc di
07915  d0 e3                shl bl, 1
07917  d0 d4                rcl ah, 1
07919  d0 e2                shl dl, 1
0791b  d0 d4                rcl ah, 1
0791d  d0 e6                shl dh, 1
0791f  d0 d4                rcl ah, 1
07921  d0 e0                shl al, 1
07923  d0 d4                rcl ah, 1
07925  d0 e4                shl ah, 1
07927  d0 e4                shl ah, 1
07929  d0 e4                shl ah, 1
0792b  d0 e4                shl ah, 1
0792d  80 e4 f0             and ah, 0xf0
07930  50                   push ax
07931  53                   push bx
07932  8a c4                mov al, ah
07934  bb 00 24             mov bx, 0x2400
07937  2e d7                xlatb
07939  5b                   pop bx
0793a  26 20 05             and byte ptr es:[di], al
0793d  26 08 25             or byte ptr es:[di], ah
07940  58                   pop ax
07941  47                   inc di
07942  5e                   pop si
07943  5f                   pop di
07944  2e 03 36 04 25       add si, word ptr cs:[0x2504]
07949  81 c7 00 20          add di, 0x2000
0794d  f7 c7 00 80          test di, 0x8000
07951  74 04                je loc_7957
07953  81 ef 60 7f          sub di, 0x7f60
loc_7957:
07957  2e ff 0e 02 25       dec word ptr cs:[0x2502]
0795c  74 03                je loc_7961
0795e  e9 e3 fd             jmp loc_7744
loc_7961:
07961  50                   push ax
07962  b8 00 00             mov ax, 0
07965  8e d8                mov ds, ax
07967  58                   pop ax
07968  c3                   ret
loc_7969:
07969  a1 f0 19             mov ax, word ptr [0x19f0]
0796c  8e d8                mov ds, ax
loc_796e:
0796e  8b d1                mov dx, cx
07970  8b cd                mov cx, bp
07972  57                   push di
loc_7973:
07973  ac                   lodsb al, byte ptr [si]
07974  0a c0                or al, al
07976  74 03                je loc_797b
07978  26 88 05             mov byte ptr es:[di], al
loc_797b:
0797b  47                   inc di
0797c  e2 f5                loop loc_7973
0797e  5f                   pop di
0797f  81 c7 40 01          add di, 0x140
07983  81 ff 00 fa          cmp di, 0xfa00
07987  74 04                je loc_798d
07989  8b ca                mov cx, dx
0798b  e2 e1                loop loc_796e
loc_798d:
0798d  50                   push ax
0798e  b8 00 00             mov ax, 0
07991  8e d8                mov ds, ax
07993  58                   pop ax
07994  c3                   ret

; ======== sub_7995   (routine probable : non appelée directement)
07995  bb d2 19             mov bx, 0x19d2
07998  03 1e 40 14          add bx, word ptr [0x1440]
0799c  ff 27                jmp word ptr [bx]
loc_799e:
0799e  e8 33 fa             call sub_73d4
079a1  8b 3e 9d 1a          mov di, word ptr [0x1a9d]
079a5  8b 1e 9b 1a          mov bx, word ptr [0x1a9b]
079a9  d1 ee                shr si, 1
079ab  a1 f0 19             mov ax, word ptr [0x19f0]
079ae  8e d8                mov ds, ax
079b0  2e 89 0e 02 25       mov word ptr cs:[0x2502], cx
079b5  d1 ed                shr bp, 1
079b7  2e 89 2e 04 25       mov word ptr cs:[0x2504], bp
079bc  d1 ed                shr bp, 1
079be  d1 ed                shr bp, 1
079c0  2e 89 2e 00 25       mov word ptr cs:[0x2500], bp
079c5  83 fb 01             cmp bx, 1
079c8  75 03                jne loc_79cd
079ca  e9 e1 00             jmp loc_7aae
loc_79cd:
079cd  2e 8b 0e 00 25       mov cx, word ptr cs:[0x2500]
079d2  57                   push di
079d3  56                   push si
loc_79d4:
079d4  2e 8b 1e 04 25       mov bx, word ptr cs:[0x2504]
079d9  2e 2b 1e 00 25       sub bx, word ptr cs:[0x2500]
079de  8a 00                mov al, byte ptr [bx + si]
079e0  2e 2b 1e 00 25       sub bx, word ptr cs:[0x2500]
079e5  8a 30                mov dh, byte ptr [bx + si]
079e7  2e 2b 1e 00 25       sub bx, word ptr cs:[0x2500]
079ec  8a 10                mov dl, byte ptr [bx + si]
079ee  8a 1c                mov bl, byte ptr [si]
079f0  d0 e3                shl bl, 1
079f2  d0 d4                rcl ah, 1
079f4  d0 e2                shl dl, 1
079f6  d0 d4                rcl ah, 1
079f8  d0 e6                shl dh, 1
079fa  d0 d4                rcl ah, 1
079fc  d0 e0                shl al, 1
079fe  d0 d4                rcl ah, 1
07a00  d0 e3                shl bl, 1
07a02  d0 d4                rcl ah, 1
07a04  d0 e2                shl dl, 1
07a06  d0 d4                rcl ah, 1
07a08  d0 e6                shl dh, 1
07a0a  d0 d4                rcl ah, 1
07a0c  d0 e0                shl al, 1
07a0e  d0 d4                rcl ah, 1
07a10  26 88 25             mov byte ptr es:[di], ah
07a13  47                   inc di
07a14  d0 e3                shl bl, 1
07a16  d0 d4                rcl ah, 1
07a18  d0 e2                shl dl, 1
07a1a  d0 d4                rcl ah, 1
07a1c  d0 e6                shl dh, 1
07a1e  d0 d4                rcl ah, 1
07a20  d0 e0                shl al, 1
07a22  d0 d4                rcl ah, 1
07a24  d0 e3                shl bl, 1
07a26  d0 d4                rcl ah, 1
07a28  d0 e2                shl dl, 1
07a2a  d0 d4                rcl ah, 1
07a2c  d0 e6                shl dh, 1
07a2e  d0 d4                rcl ah, 1
07a30  d0 e0                shl al, 1
07a32  d0 d4                rcl ah, 1
07a34  26 88 25             mov byte ptr es:[di], ah
07a37  47                   inc di
07a38  d0 e3                shl bl, 1
07a3a  d0 d4                rcl ah, 1
07a3c  d0 e2                shl dl, 1
07a3e  d0 d4                rcl ah, 1
07a40  d0 e6                shl dh, 1
07a42  d0 d4                rcl ah, 1
07a44  d0 e0                shl al, 1
07a46  d0 d4                rcl ah, 1
07a48  d0 e3                shl bl, 1
07a4a  d0 d4                rcl ah, 1
07a4c  d0 e2                shl dl, 1
07a4e  d0 d4                rcl ah, 1
07a50  d0 e6                shl dh, 1
07a52  d0 d4                rcl ah, 1
07a54  d0 e0                shl al, 1
07a56  d0 d4                rcl ah, 1
07a58  26 88 25             mov byte ptr es:[di], ah
07a5b  47                   inc di
07a5c  d0 e3                shl bl, 1
07a5e  d0 d4                rcl ah, 1
07a60  d0 e2                shl dl, 1
07a62  d0 d4                rcl ah, 1
07a64  d0 e6                shl dh, 1
07a66  d0 d4                rcl ah, 1
07a68  d0 e0                shl al, 1
07a6a  d0 d4                rcl ah, 1
07a6c  d0 e3                shl bl, 1
07a6e  d0 d4                rcl ah, 1
07a70  d0 e2                shl dl, 1
07a72  d0 d4                rcl ah, 1
07a74  d0 e6                shl dh, 1
07a76  d0 d4                rcl ah, 1
07a78  d0 e0                shl al, 1
07a7a  d0 d4                rcl ah, 1
07a7c  26 88 25             mov byte ptr es:[di], ah
07a7f  47                   inc di
07a80  46                   inc si
07a81  49                   dec cx
07a82  74 03                je loc_7a87
07a84  e9 4d ff             jmp loc_79d4
loc_7a87:
07a87  5e                   pop si
07a88  5f                   pop di
07a89  2e 03 36 04 25       add si, word ptr cs:[0x2504]
07a8e  81 c7 00 20          add di, 0x2000
07a92  f7 c7 00 80          test di, 0x8000
07a96  74 04                je loc_7a9c
07a98  81 ef 60 7f          sub di, 0x7f60
loc_7a9c:
07a9c  2e ff 0e 02 25       dec word ptr cs:[0x2502]
07aa1  74 03                je loc_7aa6
07aa3  e9 27 ff             jmp loc_79cd
loc_7aa6:
07aa6  50                   push ax
07aa7  b8 00 00             mov ax, 0
07aaa  8e d8                mov ds, ax
07aac  58                   pop ax
07aad  c3                   ret
loc_7aae:
07aae  2e 89 0e 02 25       mov word ptr cs:[0x2502], cx
loc_7ab3:
07ab3  2e 8b 0e 00 25       mov cx, word ptr cs:[0x2500]
07ab8  57                   push di
07ab9  56                   push si
07aba  32 e4                xor ah, ah
07abc  2e 8b 1e 04 25       mov bx, word ptr cs:[0x2504]
07ac1  2e 2b 1e 00 25       sub bx, word ptr cs:[0x2500]
07ac6  8a 00                mov al, byte ptr [bx + si]
07ac8  2e 2b 1e 00 25       sub bx, word ptr cs:[0x2500]
07acd  8a 30                mov dh, byte ptr [bx + si]
07acf  2e 2b 1e 00 25       sub bx, word ptr cs:[0x2500]
07ad4  8a 10                mov dl, byte ptr [bx + si]
07ad6  8a 1c                mov bl, byte ptr [si]
07ad8  d0 e3                shl bl, 1
07ada  d0 d4                rcl ah, 1
07adc  d0 e2                shl dl, 1
07ade  d0 d4                rcl ah, 1
07ae0  d0 e6                shl dh, 1
07ae2  d0 d4                rcl ah, 1
07ae4  d0 e0                shl al, 1
07ae6  d0 d4                rcl ah, 1
07ae8  50                   push ax
07ae9  53                   push bx
07aea  8a c4                mov al, ah
07aec  bb 00 24             mov bx, 0x2400
07aef  2e d7                xlatb
07af1  5b                   pop bx
07af2  26 20 05             and byte ptr es:[di], al
07af5  26 08 25             or byte ptr es:[di], ah
07af8  58                   pop ax
07af9  47                   inc di
07afa  83 f9 01             cmp cx, 1
07afd  75 03                jne loc_7b02
07aff  e9 b0 00             jmp loc_7bb2
loc_7b02:
07b02  49                   dec cx
loc_7b03:
07b03  d0 e3                shl bl, 1
07b05  d0 d4                rcl ah, 1
07b07  d0 e2                shl dl, 1
07b09  d0 d4                rcl ah, 1
07b0b  d0 e6                shl dh, 1
07b0d  d0 d4                rcl ah, 1
07b0f  d0 e0                shl al, 1
07b11  d0 d4                rcl ah, 1
07b13  d0 e3                shl bl, 1
07b15  d0 d4                rcl ah, 1
07b17  d0 e2                shl dl, 1
07b19  d0 d4                rcl ah, 1
07b1b  d0 e6                shl dh, 1
07b1d  d0 d4                rcl ah, 1
07b1f  d0 e0                shl al, 1
07b21  d0 d4                rcl ah, 1
07b23  26 88 25             mov byte ptr es:[di], ah
07b26  d0 e3                shl bl, 1
07b28  d0 d4                rcl ah, 1
07b2a  d0 e2                shl dl, 1
07b2c  d0 d4                rcl ah, 1
07b2e  d0 e6                shl dh, 1
07b30  d0 d4                rcl ah, 1
07b32  d0 e0                shl al, 1
07b34  d0 d4                rcl ah, 1
07b36  d0 e3                shl bl, 1
07b38  d0 d4                rcl ah, 1
07b3a  d0 e2                shl dl, 1
07b3c  d0 d4                rcl ah, 1
07b3e  d0 e6                shl dh, 1
07b40  d0 d4                rcl ah, 1
07b42  d0 e0                shl al, 1
07b44  d0 d4                rcl ah, 1
07b46  26 88 25             mov byte ptr es:[di], ah
07b49  d0 e3                shl bl, 1
07b4b  d0 d4                rcl ah, 1
07b4d  d0 e2                shl dl, 1
07b4f  d0 d4                rcl ah, 1
07b51  d0 e6                shl dh, 1
07b53  d0 d4                rcl ah, 1
07b55  d0 e0                shl al, 1
07b57  d0 d4                rcl ah, 1
07b59  d0 e3                shl bl, 1
07b5b  d0 d4                rcl ah, 1
07b5d  d0 e2                shl dl, 1
07b5f  d0 d4                rcl ah, 1
07b61  d0 e6                shl dh, 1
07b63  d0 d4                rcl ah, 1
07b65  d0 e0                shl al, 1
07b67  d0 d4                rcl ah, 1
07b69  26 88 25             mov byte ptr es:[di], ah
07b6c  d0 e3                shl bl, 1
07b6e  d0 d4                rcl ah, 1
07b70  d0 e2                shl dl, 1
07b72  d0 d4                rcl ah, 1
07b74  d0 e6                shl dh, 1
07b76  d0 d4                rcl ah, 1
07b78  d0 e0                shl al, 1
07b7a  d0 d4                rcl ah, 1
07b7c  46                   inc si
07b7d  2e 8b 1e 04 25       mov bx, word ptr cs:[0x2504]
07b82  2e 2b 1e 00 25       sub bx, word ptr cs:[0x2500]
07b87  8a 00                mov al, byte ptr [bx + si]
07b89  2e 2b 1e 00 25       sub bx, word ptr cs:[0x2500]
07b8e  8a 30                mov dh, byte ptr [bx + si]
07b90  2e 2b 1e 00 25       sub bx, word ptr cs:[0x2500]
07b95  8a 10                mov dl, byte ptr [bx + si]
07b97  8a 1c                mov bl, byte ptr [si]
07b99  d0 e3                shl bl, 1
07b9b  d0 d4                rcl ah, 1
07b9d  d0 e2                shl dl, 1
07b9f  d0 d4                rcl ah, 1
07ba1  d0 e6                shl dh, 1
07ba3  d0 d4                rcl ah, 1
07ba5  d0 e0                shl al, 1
07ba7  d0 d4                rcl ah, 1
07ba9  26 88 25             mov byte ptr es:[di], ah
07bac  49                   dec cx
07bad  74 03                je loc_7bb2
07baf  e9 51 ff             jmp loc_7b03
loc_7bb2:
07bb2  d0 e3                shl bl, 1
07bb4  d0 d4                rcl ah, 1
07bb6  d0 e2                shl dl, 1
07bb8  d0 d4                rcl ah, 1
07bba  d0 e6                shl dh, 1
07bbc  d0 d4                rcl ah, 1
07bbe  d0 e0                shl al, 1
07bc0  d0 d4                rcl ah, 1
07bc2  d0 e3                shl bl, 1
07bc4  d0 d4                rcl ah, 1
07bc6  d0 e2                shl dl, 1
07bc8  d0 d4                rcl ah, 1
07bca  d0 e6                shl dh, 1
07bcc  d0 d4                rcl ah, 1
07bce  d0 e0                shl al, 1
07bd0  d0 d4                rcl ah, 1
07bd2  26 88 25             mov byte ptr es:[di], ah
07bd5  d0 e3                shl bl, 1
07bd7  d0 d4                rcl ah, 1
07bd9  d0 e2                shl dl, 1
07bdb  d0 d4                rcl ah, 1
07bdd  d0 e6                shl dh, 1
07bdf  d0 d4                rcl ah, 1
07be1  d0 e0                shl al, 1
07be3  d0 d4                rcl ah, 1
07be5  d0 e3                shl bl, 1
07be7  d0 d4                rcl ah, 1
07be9  d0 e2                shl dl, 1
07beb  d0 d4                rcl ah, 1
07bed  d0 e6                shl dh, 1
07bef  d0 d4                rcl ah, 1
07bf1  d0 e0                shl al, 1
07bf3  d0 d4                rcl ah, 1
07bf5  26 88 25             mov byte ptr es:[di], ah
07bf8  d0 e3                shl bl, 1
07bfa  d0 d4                rcl ah, 1
07bfc  d0 e2                shl dl, 1
07bfe  d0 d4                rcl ah, 1
07c00  d0 e6                shl dh, 1
07c02  d0 d4                rcl ah, 1
07c04  d0 e0                shl al, 1
07c06  d0 d4                rcl ah, 1
07c08  d0 e3                shl bl, 1
07c0a  d0 d4                rcl ah, 1
07c0c  d0 e2                shl dl, 1
07c0e  d0 d4                rcl ah, 1
07c10  d0 e6                shl dh, 1
07c12  d0 d4                rcl ah, 1
07c14  d0 e0                shl al, 1
07c16  d0 d4                rcl ah, 1
07c18  26 88 25             mov byte ptr es:[di], ah
07c1b  d0 e3                shl bl, 1
07c1d  d0 d4                rcl ah, 1
07c1f  d0 e2                shl dl, 1
07c21  d0 d4                rcl ah, 1
07c23  d0 e6                shl dh, 1
07c25  d0 d4                rcl ah, 1
07c27  d0 e0                shl al, 1
07c29  d0 d4                rcl ah, 1
07c2b  d0 e4                shl ah, 1
07c2d  d0 e4                shl ah, 1
07c2f  d0 e4                shl ah, 1
07c31  d0 e4                shl ah, 1
07c33  80 e4 f0             and ah, 0xf0
07c36  50                   push ax
07c37  53                   push bx
07c38  8a c4                mov al, ah
07c3a  bb 00 24             mov bx, 0x2400
07c3d  2e d7                xlatb
07c3f  5b                   pop bx
07c40  26 20 05             and byte ptr es:[di], al
07c43  26 08 25             or byte ptr es:[di], ah
07c46  58                   pop ax
07c47  47                   inc di
07c48  5e                   pop si
07c49  5f                   pop di
07c4a  2e 03 36 04 25       add si, word ptr cs:[0x2504]
07c4f  81 c7 00 20          add di, 0x2000
07c53  f7 c7 00 80          test di, 0x8000
07c57  74 04                je loc_7c5d
07c59  81 ef 60 7f          sub di, 0x7f60
loc_7c5d:
07c5d  2e ff 0e 02 25       dec word ptr cs:[0x2502]
07c62  74 03                je loc_7c67
07c64  e9 4c fe             jmp loc_7ab3
loc_7c67:
07c67  50                   push ax
07c68  b8 00 00             mov ax, 0
07c6b  8e d8                mov ds, ax
07c6d  58                   pop ax
07c6e  c3                   ret
loc_7c6f:
07c6f  a1 f0 19             mov ax, word ptr [0x19f0]
07c72  8e d8                mov ds, ax
07c74  d1 ed                shr bp, 1
07c76  d1 ed                shr bp, 1
07c78  d1 ed                shr bp, 1
07c7a  d1 ee                shr si, 1
07c7c  bb 28 00             mov bx, 0x28
07c7f  2b dd                sub bx, bp
loc_7c81:
07c81  8b d1                mov dx, cx
07c83  8b cd                mov cx, bp
07c85  f3 a4                rep movsb byte ptr es:[di], byte ptr [si]
07c87  03 fb                add di, bx
07c89  8b cd                mov cx, bp
07c8b  f3 a4                rep movsb byte ptr es:[di], byte ptr [si]
07c8d  03 fb                add di, bx
07c8f  8b cd                mov cx, bp
07c91  f3 a4                rep movsb byte ptr es:[di], byte ptr [si]
07c93  03 fb                add di, bx
07c95  8b cd                mov cx, bp
07c97  f3 a4                rep movsb byte ptr es:[di], byte ptr [si]
07c99  03 fb                add di, bx
07c9b  8b ca                mov cx, dx
07c9d  e2 e2                loop loc_7c81
07c9f  50                   push ax
07ca0  b8 00 00             mov ax, 0
07ca3  8e d8                mov ds, ax
07ca5  58                   pop ax
07ca6  c3                   ret
loc_7ca7:
07ca7  a1 f0 19             mov ax, word ptr [0x19f0]
07caa  8e d8                mov ds, ax
loc_7cac:
07cac  8b d1                mov dx, cx
07cae  8b cd                mov cx, bp
07cb0  57                   push di
07cb1  f3 a4                rep movsb byte ptr es:[di], byte ptr [si]
07cb3  5f                   pop di
07cb4  81 c7 40 01          add di, 0x140
07cb8  8b ca                mov cx, dx
07cba  e2 f0                loop loc_7cac
07cbc  50                   push ax
07cbd  b8 00 00             mov ax, 0
07cc0  8e d8                mov ds, ax
07cc2  58                   pop ax
07cc3  c3                   ret

; ======== sub_7cc4   (routine probable : non appelée directement)
07cc4  9c                   pushf
07cc5  50                   push ax
07cc6  53                   push bx
07cc7  51                   push cx
07cc8  52                   push dx
07cc9  57                   push di
07cca  56                   push si
07ccb  55                   push bp
07ccc  06                   push es
07ccd  1e                   push ds
07cce  50                   push ax
07ccf  b8 00 00             mov ax, 0
07cd2  8e c0                mov es, ax
07cd4  58                   pop ax
07cd5  8b 04                mov ax, word ptr [si]
07cd7  bf 33 1a             mov di, 0x1a33
07cda  89 45 01             mov word ptr [di + 1], ax
07cdd  8b 44 02             mov ax, word ptr [si + 2]
07ce0  a3 87 1a             mov word ptr [0x1a87], ax
07ce3  8b 44 04             mov ax, word ptr [si + 4]
07ce6  a3 89 1a             mov word ptr [0x1a89], ax
07ce9  8b c8                mov cx, ax
07ceb  8b 44 06             mov ax, word ptr [si + 6]
07cee  a3 f2 19             mov word ptr [0x19f2], ax
07cf1  b0 20                mov al, 0x20
07cf3  88 45 03             mov byte ptr [di + 3], al
07cf6  b0 20                mov al, 0x20
07cf8  83 c7 04             add di, 4
07cfb  f3 aa                rep stosb byte ptr es:[di], al
07cfd  b0 20                mov al, 0x20
07cff  aa                   stosb byte ptr es:[di], al
07d00  32 c0                xor al, al
07d02  aa                   stosb byte ptr es:[di], al
07d03  bd 33 1a             mov bp, 0x1a33
07d06  06                   push es
07d07  e8 32 ed             call sub_6a3c
07d0a  07                   pop es
07d0b  bf 36 1a             mov di, 0x1a36
07d0e  b0 20                mov al, 0x20
07d10  aa                   stosb byte ptr es:[di], al
07d11  b0 20                mov al, 0x20
07d13  8b 0e 89 1a          mov cx, word ptr [0x1a89]
07d17  f3 aa                rep stosb byte ptr es:[di], al
07d19  b0 20                mov al, 0x20
07d1b  aa                   stosb byte ptr es:[di], al
07d1c  8b 0e 87 1a          mov cx, word ptr [0x1a87]
07d20  bd 33 1a             mov bp, 0x1a33
07d23  55                   push bp
07d24  06                   push es
loc_7d25:
07d25  55                   push bp
07d26  51                   push cx
07d27  3e fe 46 01          inc byte ptr ds:[bp + 1]
07d2b  e8 0e ed             call sub_6a3c
07d2e  59                   pop cx
07d2f  5d                   pop bp
07d30  e2 f3                loop loc_7d25
07d32  07                   pop es
07d33  5d                   pop bp
07d34  bf 36 1a             mov di, 0x1a36
07d37  b0 20                mov al, 0x20
07d39  aa                   stosb byte ptr es:[di], al
07d3a  8b 0e 89 1a          mov cx, word ptr [0x1a89]
07d3e  b0 20                mov al, 0x20
07d40  f3 aa                rep stosb byte ptr es:[di], al
07d42  b0 20                mov al, 0x20
07d44  aa                   stosb byte ptr es:[di], al
07d45  3e fe 46 01          inc byte ptr ds:[bp + 1]
07d49  e8 f0 ec             call sub_6a3c
07d4c  1f                   pop ds
07d4d  07                   pop es
07d4e  5d                   pop bp
07d4f  5e                   pop si
07d50  5f                   pop di
07d51  5a                   pop dx
07d52  59                   pop cx
07d53  5b                   pop bx
07d54  58                   pop ax
07d55  9d                   popf
07d56  c3                   ret

; ======== sub_7d57   (routine probable : non appelée directement)
07d57  be 01 00             mov si, 1
loc_7d5a:
07d5a  3e 80 3a 00          cmp byte ptr ds:[bp + si], 0
07d5e  75 01                jne loc_7d61
07d60  c3                   ret
loc_7d61:
07d61  46                   inc si
07d62  eb f6                jmp loc_7d5a

; ======== sub_7d64   (routine probable : non appelée directement)
07d64  e8 03 00             call sub_7d6a
07d67  e9 5b f4             jmp loc_71c5

; ======== sub_7d6a   (appelée depuis 7d64)
07d6a  ff 36 f2 19          push word ptr [0x19f2]
07d6e  ff 36 f4 19          push word ptr [0x19f4]
07d72  ff 36 f6 19          push word ptr [0x19f6]
07d76  ff 36 fb 19          push word ptr [0x19fb]
07d7a  9c                   pushf
07d7b  9c                   pushf
07d7c  50                   push ax
07d7d  53                   push bx
07d7e  51                   push cx
07d7f  52                   push dx
07d80  57                   push di
07d81  56                   push si
07d82  55                   push bp
07d83  06                   push es
07d84  1e                   push ds
07d85  50                   push ax
07d86  b8 00 00             mov ax, 0
07d89  8e d8                mov ds, ax
07d8b  58                   pop ax
07d8c  c6 06 fb 19 00       mov byte ptr [0x19fb], 0
07d91  e8 cc f1             call sub_6f60
07d94  bd b5 17             mov bp, 0x17b5
07d97  e8 a2 ec             call sub_6a3c
07d9a  8b ec                mov bp, sp
07d9c  8b 56 10             mov dx, word ptr [bp + 0x10]
07d9f  e8 8c 00             call sub_7e2e
07da2  bd bf 17             mov bp, 0x17bf
07da5  e8 94 ec             call sub_6a3c
07da8  8b ec                mov bp, sp
07daa  8b 56 0e             mov dx, word ptr [bp + 0xe]
07dad  e8 7e 00             call sub_7e2e
07db0  bd c9 17             mov bp, 0x17c9
07db3  e8 86 ec             call sub_6a3c
07db6  8b ec                mov bp, sp
07db8  8b 56 0c             mov dx, word ptr [bp + 0xc]
07dbb  e8 70 00             call sub_7e2e
07dbe  bd d3 17             mov bp, 0x17d3
07dc1  e8 78 ec             call sub_6a3c
07dc4  8b ec                mov bp, sp
07dc6  8b 56 0a             mov dx, word ptr [bp + 0xa]
07dc9  e8 62 00             call sub_7e2e
07dcc  bd 05 18             mov bp, 0x1805
07dcf  e8 6a ec             call sub_6a3c
07dd2  8b ec                mov bp, sp
07dd4  8b 56 04             mov dx, word ptr [bp + 4]
07dd7  e8 54 00             call sub_7e2e
07dda  bd dd 17             mov bp, 0x17dd
07ddd  e8 5c ec             call sub_6a3c
07de0  8b ec                mov bp, sp
07de2  8b 56 08             mov dx, word ptr [bp + 8]
07de5  e8 46 00             call sub_7e2e
07de8  bd e7 17             mov bp, 0x17e7
07deb  e8 4e ec             call sub_6a3c
07dee  8b ec                mov bp, sp
07df0  8b 56 06             mov dx, word ptr [bp + 6]
07df3  e8 38 00             call sub_7e2e
07df6  bd f1 17             mov bp, 0x17f1
07df9  e8 40 ec             call sub_6a3c
07dfc  8b ec                mov bp, sp
07dfe  8b 56 02             mov dx, word ptr [bp + 2]
07e01  e8 2a 00             call sub_7e2e
07e04  bd fb 17             mov bp, 0x17fb
07e07  e8 32 ec             call sub_6a3c
07e0a  8b ec                mov bp, sp
07e0c  8b 56 00             mov dx, word ptr [bp]
07e0f  e8 1c 00             call sub_7e2e
07e12  1f                   pop ds
07e13  07                   pop es
07e14  5d                   pop bp
07e15  5e                   pop si
07e16  5f                   pop di
07e17  5a                   pop dx
07e18  59                   pop cx
07e19  5b                   pop bx
07e1a  58                   pop ax
07e1b  9d                   popf
07e1c  9d                   popf
07e1d  8f 06 fb 19          pop word ptr [0x19fb]
07e21  8f 06 f6 19          pop word ptr [0x19f6]
07e25  8f 06 f4 19          pop word ptr [0x19f4]
07e29  8f 06 f2 19          pop word ptr [0x19f2]
07e2d  c3                   ret

; ======== sub_7e2e   (appelée depuis 7d9f, 7dad, 7dbb, 7dc9, 7dd7, 7de5, 7df3, 7e01)
07e2e  89 16 95 1a          mov word ptr [0x1a95], dx
07e32  8a c6                mov al, dh
07e34  e8 1b 00             call sub_7e52
07e37  a1 95 1a             mov ax, word ptr [0x1a95]
07e3a  8a c4                mov al, ah
07e3c  e8 0d 00             call sub_7e4c
07e3f  a1 95 1a             mov ax, word ptr [0x1a95]
07e42  e8 0d 00             call sub_7e52
07e45  a1 95 1a             mov ax, word ptr [0x1a95]
07e48  e8 01 00             call sub_7e4c
07e4b  c3                   ret

; ======== sub_7e4c   (appelée depuis 7e3c, 7e48)
07e4c  24 0f                and al, 0xf
07e4e  e8 0f 00             call sub_7e60
07e51  c3                   ret

; ======== sub_7e52   (appelée depuis 7e34, 7e42)
07e52  24 f0                and al, 0xf0
07e54  d0 e8                shr al, 1
07e56  d0 e8                shr al, 1
07e58  d0 e8                shr al, 1
07e5a  d0 e8                shr al, 1
07e5c  e8 01 00             call sub_7e60
07e5f  c3                   ret

; ======== sub_7e60   (appelée depuis 7e4e, 7e5c)
07e60  bb 12 1d             mov bx, 0x1d12    ; "0123456789ABCDEF"
07e63  d7                   xlatb
07e64  e8 e4 eb             call sub_6a4b
07e67  c3                   ret

; ======== sub_7e68   (routine probable : non appelée directement)
07e68  51                   push cx
07e69  b4 00                mov ah, 0
07e6b  b9 08 00             mov cx, 8
loc_7e6e:
07e6e  d0 e8                shr al, 1
07e70  72 06                jb loc_7e78
07e72  fe c4                inc ah
07e74  e2 f8                loop loc_7e6e
07e76  32 e4                xor ah, ah
loc_7e78:
07e78  8a c4                mov al, ah
07e7a  59                   pop cx
07e7b  c3                   ret

; ======== sub_7e7c   (routine probable : non appelée directement)
07e7c  b4 25                mov ah, 0x25
07e7e  b0 24                mov al, 0x24
07e80  ba da 39             mov dx, 0x39da
07e83  1e                   push ds
07e84  0e                   push cs
07e85  1f                   pop ds
07e86  cd 21                int 0x21
07e88  1f                   pop ds
07e89  c3                   ret
; ---- 3 octets non atteints (7e8a-7e8c)

; ======== sub_7e8d   (appelée depuis 479c, 48b6, 492f, 4bf4, 4c70, 4ced, 4e92, 4eed)
07e8d  fc                   cld
07e8e  ba 00 00             mov dx, 0
loc_7e91:
07e91  b8 00 00             mov ax, 0
07e94  ac                   lodsb al, byte ptr [si]
07e95  3c 00                cmp al, 0
07e97  75 03                jne loc_7e9c
07e99  e9 a6 00             jmp loc_7f42
loc_7e9c:
07e9c  a8 80                test al, 0x80
07e9e  75 45                jne loc_7ee5
07ea0  a8 40                test al, 0x40
07ea2  75 1d                jne loc_7ec1
07ea4  a8 20                test al, 0x20
07ea6  74 08                je loc_7eb0
07ea8  24 df                and al, 0xdf
07eaa  86 e0                xchg al, ah
07eac  ac                   lodsb al, byte ptr [si]
07ead  05 20 00             add ax, 0x20
loc_7eb0:
07eb0  48                   dec ax
loc_7eb1:
07eb1  a4                   movsb byte ptr es:[di], byte ptr [si]
07eb2  42                   inc dx
07eb3  49                   dec cx
07eb4  75 03                jne loc_7eb9
07eb6  e9 89 00             jmp loc_7f42
loc_7eb9:
07eb9  48                   dec ax
07eba  f6 c4 80             test ah, 0x80
07ebd  74 f2                je loc_7eb1
07ebf  eb d0                jmp loc_7e91
loc_7ec1:
07ec1  24 bf                and al, 0xbf
07ec3  a8 20                test al, 0x20
07ec5  74 08                je loc_7ecf
07ec7  24 df                and al, 0xdf
07ec9  86 e0                xchg al, ah
07ecb  ac                   lodsb al, byte ptr [si]
07ecc  05 21 00             add ax, 0x21
loc_7ecf:
07ecf  05 02 00             add ax, 2
07ed2  8a 1c                mov bl, byte ptr [si]
07ed4  46                   inc si
loc_7ed5:
07ed5  26 88 1d             mov byte ptr es:[di], bl
07ed8  47                   inc di
07ed9  42                   inc dx
07eda  49                   dec cx
07edb  74 65                je loc_7f42
07edd  48                   dec ax
07ede  f6 c4 80             test ah, 0x80
07ee1  74 f2                je loc_7ed5
07ee3  eb ac                jmp loc_7e91
loc_7ee5:
07ee5  24 7f                and al, 0x7f
07ee7  a8 40                test al, 0x40
07ee9  75 29                jne loc_7f14
07eeb  bd 02 00             mov bp, 2
07eee  a8 20                test al, 0x20
07ef0  75 03                jne loc_7ef5
07ef2  bd 01 00             mov bp, 1
loc_7ef5:
07ef5  24 df                and al, 0xdf
07ef7  8b df                mov bx, di
07ef9  4b                   dec bx
07efa  2b d8                sub bx, ax
07efc  2b dd                sub bx, bp
loc_7efe:
07efe  26 8a 07             mov al, byte ptr es:[bx]
07f01  26 88 05             mov byte ptr es:[di], al
07f04  43                   inc bx
07f05  47                   inc di
07f06  42                   inc dx
07f07  49                   dec cx
07f08  74 38                je loc_7f42
07f0a  4d                   dec bp
07f0b  f7 c5 00 80          test bp, 0x8000
07f0f  74 ed                je loc_7efe
07f11  e9 7d ff             jmp loc_7e91
loc_7f14:
07f14  24 bf                and al, 0xbf
07f16  8b e8                mov bp, ax
07f18  86 c4                xchg ah, al
07f1a  ac                   lodsb al, byte ptr [si]
07f1b  25 ff 03             and ax, 0x3ff
07f1e  d1 ed                shr bp, 1
07f20  d1 ed                shr bp, 1
07f22  83 c5 03             add bp, 3
07f25  8b df                mov bx, di
07f27  4b                   dec bx
07f28  2b d8                sub bx, ax
07f2a  2b dd                sub bx, bp
loc_7f2c:
07f2c  26 8a 07             mov al, byte ptr es:[bx]
07f2f  26 88 05             mov byte ptr es:[di], al
07f32  43                   inc bx
07f33  47                   inc di
07f34  42                   inc dx
07f35  49                   dec cx
07f36  74 0a                je loc_7f42
07f38  4d                   dec bp
07f39  f7 c5 00 80          test bp, 0x8000
07f3d  74 ed                je loc_7f2c
07f3f  e9 4f ff             jmp loc_7e91
loc_7f42:
07f42  c3                   ret

; ======== sub_7f43   (appelée depuis 46b0)
07f43  51                   push cx
07f44  e8 24 ef             call sub_6e6b
07f47  59                   pop cx
07f48  e2 f9                loop sub_7f43
07f4a  c3                   ret

; ======== sub_7f4b   (appelée depuis 4a76, 4a8b, 4bda, 4c7d, 4cfa, 4e43, 4fb2, 4fe0)
07f4b  50                   push ax
07f4c  52                   push dx
07f4d  1e                   push ds
07f4e  50                   push ax
07f4f  b8 00 00             mov ax, 0
07f52  8e d8                mov ds, ax
07f54  58                   pop ax
07f55  8b 16 24 1d          mov dx, word ptr [0x1d24]
loc_7f59:
07f59  ec                   in al, dx
07f5a  a8 08                test al, 8
07f5c  74 fb                je loc_7f59
loc_7f5e:
07f5e  ec                   in al, dx
07f5f  a8 08                test al, 8
07f61  75 fb                jne loc_7f5e
07f63  1f                   pop ds
07f64  5a                   pop dx
07f65  58                   pop ax
07f66  c3                   ret

; ======== sub_7f67   (appelée depuis 4664)
07f67  b8 40 00             mov ax, 0x40
07f6a  8e c0                mov es, ax
07f6c  26 a1 63 00          mov ax, word ptr es:[0x63]
07f70  a3 22 1d             mov word ptr [0x1d22], ax
07f73  05 06 00             add ax, 6
07f76  a3 24 1d             mov word ptr [0x1d24], ax
07f79  c3                   ret
; ---- 80 octets non atteints (7f7a-7fc9)

; ======== sub_7fca   (appelée depuis 7071)
07fca  fa                   cli
07fcb  33 db                xor bx, bx
07fcd  33 c9                xor cx, cx
07fcf  33 ff                xor di, di
07fd1  33 f6                xor si, si
07fd3  ba 01 02             mov dx, 0x201
07fd6  ee                   out dx, al
07fd7  eb 01                jmp loc_7fda
; ---- 1 octets non atteints (7fd9-7fd9)
loc_7fda:
07fda  eb 01                jmp loc_7fdd
; ---- 1 octets non atteints (7fdc-7fdc)
loc_7fdd:
07fdd  eb 01                jmp loc_7fe0
; ---- 1 octets non atteints (7fdf-7fdf)
loc_7fe0:
07fe0  ec                   in al, dx
07fe1  22 06 ac 14          and al, byte ptr [0x14ac]
07fe5  32 e4                xor ah, ah
07fe7  8b e8                mov bp, ax
07fe9  25 01 00             and ax, 1
07fec  03 d8                add bx, ax
07fee  8b c5                mov ax, bp
07ff0  25 02 00             and ax, 2
07ff3  03 c8                add cx, ax
07ff5  8b c5                mov ax, bp
07ff7  25 04 00             and ax, 4
07ffa  d1 e8                shr ax, 1
07ffc  d1 e8                shr ax, 1
07ffe  03 f8                add di, ax
08000  8b c5                mov ax, bp
08002  25 08 00             and ax, 8
08005  d1 e8                shr ax, 1
08007  d1 e8                shr ax, 1
08009  03 f0                add si, ax
0800b  0b ed                or bp, bp
0800d  75 d1                jne loc_7fe0
0800f  fb                   sti
08010  c3                   ret

; ======== sub_8011   (appelée depuis 70c9)
08011  fa                   cli
08012  ba 01 02             mov dx, 0x201
08015  ec                   in al, dx
08016  f6 d0                not al
08018  8a e0                mov ah, al
0801a  d0 e8                shr al, 1
0801c  d0 e8                shr al, 1
0801e  0a c4                or al, ah
08020  d0 e8                shr al, 1
08022  d0 e8                shr al, 1
08024  d0 e8                shr al, 1
08026  d0 e8                shr al, 1
08028  fb                   sti
08029  c3                   ret

; ======== sub_802a   (appelée depuis 4879)
0802a  80 3e 42 14 00       cmp byte ptr [0x1442], 0
0802f  75 0b                jne loc_803c
08031  b8 0b 00             mov ax, 0xb
08034  cd 60                int 0x60
08036  e4 61                in al, 0x61
08038  24 fc                and al, 0xfc
0803a  e6 61                out 0x61, al
loc_803c:
0803c  80 3e 42 14 00       cmp byte ptr [0x1442], 0
08041  74 14                je loc_8057
08043  8b 3e 4e 14          mov di, word ptr [0x144e]
08047  80 3e 49 14 01       cmp byte ptr [0x1449], 1
0804c  74 04                je loc_8052
0804e  8b 3e 4c 14          mov di, word ptr [0x144c]
loc_8052:
08052  b8 04 00             mov ax, 4
08055  cd 60                int 0x60
loc_8057:
08057  b8 0b 00             mov ax, 0xb
0805a  cd 60                int 0x60
0805c  b8 00 00             mov ax, 0
0805f  cd 60                int 0x60
08061  c3                   ret

; ======== sub_8062   (appelée depuis 4667)
08062  c6 06 49 14 00       mov byte ptr [0x1449], 0
08067  8a 1e 42 14          mov bl, byte ptr [0x1442]
0806b  d0 e3                shl bl, 1
0806d  32 ff                xor bh, bh
0806f  8b 9f 80 14          mov bx, word ptr [bx + 0x1480]
08073  83 fb 00             cmp bx, 0
08076  74 28                je loc_80a0
08078  89 1e 8b 1a          mov word ptr [0x1a8b], bx
0807c  bb 97 06             mov bx, 0x697
0807f  b4 48                mov ah, 0x48
08081  cd 21                int 0x21
08083  73 01                jae loc_8086
08085  c3                   ret
loc_8086:
08086  a3 4a 14             mov word ptr [0x144a], ax
08089  8b 1e 8b 1a          mov bx, word ptr [0x1a8b]
0808d  89 1e a9 1b          mov word ptr [0x1ba9], bx
08091  c7 06 a5 1b 00 00    mov word ptr [0x1ba5], 0
08097  a1 4a 14             mov ax, word ptr [0x144a]
0809a  a3 a3 1b             mov word ptr [0x1ba3], ax
0809d  e8 a1 f1             call sub_7241
loc_80a0:
080a0  8a 1e 42 14          mov bl, byte ptr [0x1442]
080a4  d0 e3                shl bl, 1
080a6  32 ff                xor bh, bh
080a8  8b 9f 50 14          mov bx, word ptr [bx + 0x1450]
080ac  89 1e a9 1b          mov word ptr [0x1ba9], bx
080b0  c7 06 a5 1b 00 00    mov word ptr [0x1ba5], 0
080b6  b8 ec 01             mov ax, 0x1ec
080b9  a3 a3 1b             mov word ptr [0x1ba3], ax
080bc  e8 82 f1             call sub_7241
080bf  ff 1e a8 14          lcall [0x14a8]
080c3  b8 0a 00             mov ax, 0xa
080c6  cd 60                int 0x60
080c8  f8                   clc
080c9  c3                   ret

; ======== sub_80ca   (appelée depuis 466a)
080ca  80 3e 42 14 00       cmp byte ptr [0x1442], 0
080cf  74 0c                je loc_80dd
080d1  8b 16 4a 14          mov dx, word ptr [0x144a]
080d5  be 00 00             mov si, 0
080d8  b8 02 00             mov ax, 2
080db  cd 60                int 0x60
loc_80dd:
080dd  8a 1e 42 14          mov bl, byte ptr [0x1442]
080e1  32 ff                xor bh, bh
080e3  d1 e3                shl bx, 1
080e5  8b 97 a0 14          mov dx, word ptr [bx + 0x14a0]
080e9  8b ca                mov cx, dx
080eb  b8 03 00             mov ax, 3
080ee  cd 60                int 0x60
080f0  89 3e 4c 14          mov word ptr [0x144c], di
080f4  c3                   ret

; ======== sub_80f5   (appelée depuis 7065)
080f5  80 3e 49 14 01       cmp byte ptr [0x1449], 1
080fa  75 01                jne loc_80fd
080fc  c3                   ret
loc_80fd:
080fd  80 3e f8 1b 01       cmp byte ptr [0x1bf8], 1
08102  74 01                je loc_8105
08104  c3                   ret
loc_8105:
08105  c6 06 49 14 01       mov byte ptr [0x1449], 1
0810a  80 3e 42 14 03       cmp byte ptr [0x1442], 3
0810f  75 09                jne loc_811a
08111  ba 00 00             mov dx, 0
08114  b8 03 00             mov ax, 3
08117  cd 60                int 0x60
08119  c3                   ret
loc_811a:
0811a  8b 3e 4c 14          mov di, word ptr [0x144c]
0811e  b8 04 00             mov ax, 4
08121  cd 60                int 0x60
08123  80 3e 42 14 00       cmp byte ptr [0x1442], 0
08128  75 0b                jne loc_8135
0812a  b8 0b 00             mov ax, 0xb
0812d  cd 60                int 0x60
0812f  e4 61                in al, 0x61
08131  24 fc                and al, 0xfc
08133  e6 61                out 0x61, al
loc_8135:
08135  c3                   ret
