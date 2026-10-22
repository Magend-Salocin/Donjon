# Récompenses : objets, bonus et drapeaux

Tout ce que les dialogues peuvent donner. Les codes de bonus et les règles d'application sont dans [mecaniques.md](mecaniques.md).

## Reliques (nouvelle catégorie `relique`, numéros 40 à 59)

Ce sont des objets de lore, jamais vendus. Leur effet dure tant qu'ils sont dans l'inventaire, sauf ceux qui ont un emplacement `Bijou`.

| N° | Relique | Obtenue | Effet dans le jeu |
| ---: | --- | --- | --- |
| 40 | Lettre de recommandation impériale | 101, victoire | Le Garde impérial signe à moitié prix. Réplique spéciale des PNJ impériaux. |
| 41 | Bague de la famille Ragnar (Bijou) | 102, accepter la dette de Ragnar | `def+1` |
| 42 | Carte des tunnels orques | 103, victoire | Voyages 25 % plus courts ([Travel](../../../donjon-v2/src/Game/Travel.php)) |
| 43 | Médaille impériale | 104, rendre l'or | Réputation +2 au moment de la remise. Le Garde impérial signe gratuitement. |
| 44 | Cape en peau d'orc | 106, alliance avec Grak | `def+1`. Ragnar refuse de la voir (fidélité −2 à la remise). |
| 45 | Pierre de protection | 107, purifier Wardoz | `corps+2` |
| 46 | Grimoire de feu | 108, accepter le grimoire de Balur | `att+1`. Après chaque aventure, 1 chance sur 3 de corruption +1. |
| 47 | Pierre de résistance au feu | 108, tuer Balur | `def+1` |
| 48 | Dague de l'ombre | 109, porte de la richesse | `att+1` |
| 49 | Parchemins d'Ollar | 109, porte de la connaissance | `pieges` (pièges de la pièce de départ désamorcés) |
| 50 | Vision du Sorcier-Roi | 109, porte de la vérité | `att+2` dans les aventures 112, 114 et 124 seulement |
| 51 | Étoile de l'Ouest | 112, victoire | Clé : nécessaire pour débloquer 113 et 114 |
| 52 | Amulette de protection (Bijou) | 112, victoire, si Mentor a confiance | `def+1`, `corps+2` |
| 53 | Fureur de Gromril | 113, prendre l'épée naine | `att+3`, `def−1` |
| 54 | Larme de Leben | 113, prendre l'épée elfique | `att+1`, `def+1`. Seule voie vers la fin héroïque de 114 |
| 55 | Dague maudite | 113, vouloir les deux épées | `att+2`. Après chaque aventure, 1 point de vie maximum perdu. |
| 56 | Talisman de connaissance | Réservé à l'aventure 105 (Melar), absente aujourd'hui | `pieges`, `depl+2` |

Les emplacements de bijou sont limités à un : la bague (41) et l'amulette (52) s'excluent.

## Objets ordinaires donnés par les dialogues

Ce sont des objets qui existent déjà en base.

| N° | Objet | Donné par |
| ---: | --- | --- |
| 995 | Breuvage héroïque | Snorri, contre un défi à boire |
| 996 | Potion de vitesse | Brunhilde, rumeur payante |
| 997 | Potion de force | Dorn, une fois son contrat honoré |
| 998 | Potion de résistance | Sœur Ilsa, aumône |
| 999 | Potion de guérison | Sœur Ilsa, Hergard (repos de luxe) |
| 19, 20 | Poulet, gâteau de miel | Jos, puis Hergard après l'aventure 1 |

## Bonus temporaires

Ils sont donnés par les rumeurs et les taverniers. Un bonus suivi de `@code` ne vaut que pour cette aventure : `bonus def+1@102`.

| Bonus | Source |
| --- | --- |
| `pieges@101` | Hergard : les pièges du labyrinthe de Mentor |
| `def+1@102` | Brunhilde : les gardes d'Ulag frappent toujours de face |
| `att+1@103` | Snorri : Ulag et ses gardes dorment à l'aube |
| `def+1@104` | Hergard : la façon de combattre Gulthor |
| `depl+2@106` | Brunhilde : toujours repérer une sortie |
| `def+1@107` | Snorri : ne pas regarder la bête dans les yeux |
| `att+1@107` | Débriefing 106 : refuser Grak disperse ses orcs |
| `corps+2@108` | Hergard : mouiller sa cape avant les Pics Volcaniques |
| `att+1@111` | Snorri : frapper le premier au bastion |
| `def+1@113` | Brunhilde : le temple des deux épées |
| `att−1@114` | Débriefing 113, échec : la lame est perdue |
| `corps+2` | Chambre du haut chez Hergard (prochaine aventure) |
| `att+1` | Défi à boire gagné chez Snorri (prochaine aventure) |

## Registre des drapeaux

Chaque drapeau est écrit en un seul endroit. Il faut tenir ce registre à jour pour éviter les doublons.

| Drapeau | Posé par | Lu par |
| --- | --- | --- |
| `reputation`, `corruption` | tous (valeurs numériques) | conditions, boutiques, aventures |
| `aventure_<code>` | débriefings, habitués | liste des aventures |
| `debrief_<code>_victoire` / `_echec` | fin d'aventure | présence des PNJ, verrou des aventures |
| `mentor_rencontre` | Mentor, accueil | Mentor |
| `confiance_mentor` / `mentor_doute` | débriefing 101 | Mentor (112, 114), amulette 52 |
| `ragnar_libre` | débriefing 102, victoire | présence de Ragnar |
| `ragnar_maudit` | débriefing 102, échec | réplique de Brunhilde, réputation |
| `ulag_epargne` / `ulag_mort` | débriefing 103 | Grak (106) |
| `or_magnus_rendu` / `or_magnus_garde` | débriefing 104 | Ragnar (refus), Mentor, prix |
| `grak_allie` / `grak_vengeance` | débriefing 106 | Grak à Gzor, aventure 111 |
| `wardoz_purifie` / `wardoz_tue` | débriefing 107 | Balur (108) |
| `balur_epargne` / `balur_mort` | débriefing 108 | compagnon Balur |
| `guide_traitre` | le Guide, avant 109 | Spectre du Guide |
| `porte_richesse` / `porte_connaissance` / `porte_verite` | débriefing 109 | reliques 48 à 50 |
| `epee_fureur` / `epee_larme` / `epee_maudite` | débriefing 113 | fin de campagne (114) |
| `campagne_heroique` / `campagne_sombre` | débriefing 114 | Mentor, aventures 115 à 124 |
| `or_magnus_partiel` | débriefing 104 (garder un coffre) | Mentor, Ragnar |
| `guide_refuse` | le Guide, refusé | débriefing 109 |
| `spectre_guide` | débriefing 109, échec | réplique d'ambiance du Spectre du Guide |
| `demon_mineur` | débriefing 111, échec | aventure 114 : +1 monstre |
| `champion_sorcier` | débriefing 112, échec | aventure 114 : +1 monstre |
| `balur_traitre` | Balur, trahison | Balur ennemi, répliques des PNJ |
| `tournee_valtordu` | Hergard, tournée générale | une seule tournée par héros |
| `defi_snorri` | Snorri, défi à boire | un seul défi par héros |
| `echec_<code>` | premier échec d'une aventure de campagne | évite d'appliquer deux fois la pénalité |
| `rumeur_<sujet>` | taverniers | évite de revendre deux fois la même rumeur |
| `fini_<pnj>` | dernier nœud d'un PNJ | présence du PNJ |
