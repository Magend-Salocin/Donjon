# Bogues relevés pendant la réécriture lisible

Comportements du code de 1991 trouvés en réécrivant les routines dans `web/jeu/lisible/`. Le code lisible les reproduit tels quels : rien n'est corrigé. Certains contredisent les autres notes, qui ne sont pas encore mises à jour : la colonne « Note à revoir » le signale.

## Combat

| Routine | Constat | Note à revoir |
| --- | --- | --- |
| `attaque_heros` (0x0936) | Les boucliers du monstre sont lancés avec `loop` sur un compteur de 16 bits, sans test préalable : un monstre à 0 dé de défense en lance 65 536. | |
| `compte_cranes` (0x5D8C) | Le compteur de dés est un octet décrémenté avant le test : 0 dé en lance 256. `attaque_contre_heros` l'appelle sans test, avec les dés d'attaque du monstre. | |

## Déplacement

| Routine | Constat | Note à revoir |
| --- | --- | --- |
| `porte_reveille` (0x0790) | Quêtes 5 et 16 : x et y sont comparés d'un coup au mot 5 (donc y = 0), puis le code exige y = 3 ou 4. La condition n'est jamais vraie : la porte ne réveille jamais le monstre 1. | 03-regles.md, « Déplacement » : décrit le réveil comme effectif |
| `fin_deplacement` (0x6049) | Si le héros n'a pas bougé, la potion héroïque est lue dans la fiche pointée par le DI de l'appelant, pas dans celle du héros courant. | |
| `pas_automatique` (0x6784) | Il entre au milieu des routines de pas et saute le test des autres personnages ; `pas_permis` ne les regarde pas non plus. Le chemin automatique peut traverser un autre héros. | 03-regles.md : « les héros ne se traversent pas » vaut seulement pour les flèches |
| pas (0x48A0 à 0x4BBF) | Devant une porte secrète cachée, `porte_franchie` est posé avant le refus et reste posé : le pas réussi suivant compte comme un passage de porte. | |
| pas | Pas refusé à cause de l'occupant d'arrivée : le son de porte a déjà été joué et la dernière porte notée, alors que la porte n'est pas ouverte. | |
| `entre_piege` (0x4DC7) | `case_piege` reçoit la case que le héros quitte, pas celle du piège. | |
| pièce tournante (quête 16) | Le test porte sur l'ancienne zone de la fiche, pas encore mise à jour : le saut arrive en quittant la zone 31, pas en y entrant. | 03-regles.md : « entrer dans la zone 31 » |
| `des_deplacement_tour` (0x68AE) | Le plafond de 6 dés n'est appliqué qu'après le vent rapide : la potion de rapidité seule peut donner 4 dés sans plafond. | 03-regles.md : « 6 au plus » sans condition |
| `pas_bas` (0x4AF7) | Le bord teste d'abord la rangée 19, puis la rangée 18. | |
| `pas_permis` (0x2EB7) | Accepte l'occupant 0x40 (premier meuble), que les pas refusent. | 03-regles.md : « code 0x32 à 0x40 » est exact, mais diffère des flèches |
| `clic_plateau` (0x67B6) | Accepte de cibler une case occupée par un monstre ; `pas_permis` la refuse ensuite. | |
| révélation de zone (téléport du château, héros déplacé) | La dernière case touche aussi le premier octet de la grille des murs. Après un `retire_monstre`, la zone est relue dans la fiche pointée par DI. | |
| `tirage_deplacement` (0x66F9) | Chaque image de l'animation tire de nouveaux dés : la graine avance selon le moment du clic. 0 dé de déplacement en lance 65 536. | |
| téléport du château (quête 10) | Le bit 0x10 de +0x0F est effacé ; la note l'appelle « or de la mine », nom qu'elle donne ailleurs au bit 0x20. Nommé `retireParTeleport` dans `donnees.js` en attendant d'en connaître le sens. | 03-regles.md : bit 0x10 ou 0x20 |

## Tour d'un personnage

| Routine | Constat | Note à revoir |
| --- | --- | --- |
| `tour_personnage` (0x0349) | La boucle du tour compare l'octet `commandes` entier à 0x40 (`cmp`), alors que `partie` teste le seul bit (`test`). Échap + Ctrl n'interrompt la quête depuis la boucle du tour que si aucun autre bit de commande n'est posé au même moment ; sinon il faut attendre la fin du tour de Morcar. | |
| `tour_personnage` | Un héros endormi et pris dans la tempête : la tempête est consommée, mais elle ne lui fait pas passer son tour ; il tente son réveil au dé comme un héros seulement endormi. | 03-regles.md, « Tour d'un personnage » : ne parle pas de la tempête |
| `tour_personnage` | Le réveil passe par `tirage_deplacement` avec 1 dé : le joueur doit cliquer pour arrêter le dé, et c'est `deplacement_restant` = 6 qui réveille. Le nombre de dés du tour est gardé par un `push` du mot DS:3FC4, qui sauve et remet aussi l'octet DS:3FC5. | |
| `tour_personnage` | `fin_du_tour` n'est pas remis à 0 par `tour_personnage` mais par `des_deplacement_tour`, appelée au début du tour : une fiche vide (+0 = 0) sort avant, sans toucher à la fin du tour. | |
| `action_sort` (0x2C74) | Hors du tour, relevé en passant : `test byte ptr [0x3f9b], 0` en 0x2C93 teste un masque nul : le `je` qui suit est toujours pris, et le test suivant (`attaque_repetee` bit 2, puis sa mise à 1) n'est jamais atteint. | |
