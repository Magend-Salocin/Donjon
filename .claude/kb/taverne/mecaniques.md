# Mécaniques de la taverne

Spécification technique des dialogues : comment les écrire, ce qu'ils peuvent tester et modifier, et ce qu'il faut ajouter au jeu pour que leurs effets existent. Vue d'ensemble : [concept-taverne.md](../concept-taverne.md).

## 1. Écrire un dialogue

Les dialogues s'écrivent d'abord en Markdown, dans les fichiers de ce dossier, puis se convertissent en fichiers PHP (`data/dialogues/<pnj>.php`, format décrit dans le concept). La notation :

```text
### pnj : identifiant du PNJ
Présence : condition pour que le PNJ soit à la taverne.

#### nom-du-noeud
> Réplique du PNJ.
1. Réponse du héros → noeud-suivant
2. Réponse [si : or ≥ 5] [effets : or −5, drapeau x] → fin
```

- `→ fin` termine le dialogue.
- `[si : …]` : la réponse est grisée si la condition n'est pas remplie. Plusieurs conditions séparées par une virgule doivent toutes être vraies.
- `[effets : …]` : appliqués dans l'ordre, au moment du choix.
- Une réplique fait 4 lignes au plus. Une réponse tient sur une ligne.
- Le premier nœud s'appelle toujours `accueil`.

## 2. Conditions

| Notation | Vrai si |
| --- | --- |
| `aventure 102` | l'aventure 102 a été réussie au moins une fois (table `accomplir`) |
| `drapeau x` / `sans x` | le drapeau `x` est posé / absent |
| `or ≥ n`, `niveau ≥ n` | or ou niveau (`codeexp`) suffisant |
| `grade Ecuyer` | grade égal ou supérieur |
| `reputation ≥ n`, `reputation ≤ n` | réputation dans la plage |
| `corruption ≥ n`, `corruption ≤ n` | corruption dans la plage |
| `type Nain`, `sexe F` | type ou sexe du héros |
| `compagnon ragnar` / `sans-compagnon` | compagnon présent / équipe vide |
| `objet 41` | le héros possède l'objet 41 |
| `fidelite ragnar ≥ n` | fidélité d'un compagnon |

## 3. Effets

| Notation | Effet |
| --- | --- |
| `or ±n`, `exp +n` | or, expérience |
| `pv plein` | rend tous les points de vie (repos) |
| `pvmax ±n` | modifie les points de vie maximum (`pv`), sans descendre sous 10 |
| `objet n` / `retirer n` | donne ou retire un objet |
| `perdre-objet` | retire un objet de l'inventaire au hasard (hors reliques) |
| `drapeau x` / `effacer x` | pose ou retire un drapeau |
| `reputation ±n`, `corruption ±n` | modifie les jauges (bornées à 0) |
| `debloquer 102` | rend l'aventure 102 visible dans la liste des aventures |
| `bonus code`, `bonus code@102` | bonus pour la prochaine aventure, ou pour l'aventure 102 seulement (voir 6) |
| `recruter code` / `renvoyer code` | ajoute ou retire un membre de l'équipe |
| `fidelite code ±n` | modifie la fidélité d'un compagnon |
| `ecran recrutement` | ouvre la liste des mercenaires de la taverne |

## 4. Débloquer des aventures

Aujourd'hui, toutes les aventures du grade et du village s'affichent ([World::adventures](../../src/Repository/World.php)).

À ajouter : une colonne `aventure.cle TEXT NULL`. Une aventure dont la clé est renseignée n'apparaît que si le héros a le drapeau du même nom. L'effet `debloquer 102` pose donc le drapeau `aventure_102`.

| Aventures | Clé | Débloquée par |
| --- | --- | --- |
| 101 | aucune | ouverte dès le départ (l'épreuve de Mentor) |
| 102 à 114 | `aventure_<code>` | le débriefing de l'aventure précédente de la campagne ([dialogues-campagne.md](dialogues-campagne.md)) |
| 115 à 124 | `aventure_115` (puis la suite) | Mentor, après la victoire finale de 114 |
| 1, 2, 3, 6 (quêtes de 2009) | `aventure_<code>` | les habitués des tavernes ([dialogues-taverniers.md](dialogues-taverniers.md)) |
| 4, 5 | `aventure_<code>` | un habitué, à partir du grade Aventurier |

Les conditions de grade et de village continuent de s'appliquer. Une clé dit seulement que le héros connaît l'aventure.

## 5. Débriefing après une aventure

`Progression::finishAdventure` enregistre le résultat, puis pose le drapeau `debrief_<code>_victoire` ou `debrief_<code>_echec`.

Tant qu'un de ces drapeaux existe :

- la page du village affiche un bandeau « Quelqu'un vous attend à la taverne » ;
- la liste des aventures est verrouillée.

Le dernier nœud du débriefing efface ce drapeau. Seules les aventures 101 à 114 ont un débriefing. Les autres se terminent comme aujourd'hui.

## 6. Bonus pour une aventure

Table `bonus (jou_num, code, aventures, aventure NULL)` : bonus actif pendant `aventures` aventures, puis supprimé (1 par défaut). Si `aventure` est renseigné (notation `bonus def+1@102`), le bonus ne vaut que pour cette aventure et attend qu'elle soit jouée.

Les bonus s'appliquent dans [jeu.php](../../templates/pages/jeu.php) au moment de construire le héros du plateau, après le plafond :

```js
Math.min(8, forc) + bonusAttaque
```

Attention : l'équipement ajoute sa valeur (5 à 50) à `forc` et `end`, si bien qu'un héros équipé atteint vite le plafond de 8 dés. Un bonus appliqué avant le plafond ne servirait à rien. Les reliques et les compagnons appliquent donc leurs bonus après, avec un maximum de 10 dés.

| Code | Effet dans le donjon |
| --- | --- |
| `att+1`, `att+2` | dés d'attaque |
| `def+1`, `def+2` | dés de défense |
| `att−1`, `def−1` | malus (Fureur de Gromril) |
| `corps+2` | points de vie de départ (sans dépasser le maximum + 2) |
| `depl+2` | cases de déplacement à chaque tour |
| `pieges` | pièges de la pièce de départ désamorcés |
| `potion` | une potion de guérison (999) dans l'inventaire de quête |
| `bouclier` | la première blessure reçue dans l'aventure est annulée (Sir Ragnar) |
| `ennemi-balur` | ajoute un Sorcier (type 19) dans la plus grande pièce de la prochaine aventure |
| `monstre+1` | ajoute une copie du monstre le plus fort de la carte dans sa pièce (échecs 111 et 112, corruption 4-6) |

Les mercenaires et les compagnons utilisent les mêmes codes ([compagnons.md](compagnons.md)).

## 7. Réputation et corruption dans le jeu

Ce sont deux drapeaux numériques, `reputation` (départ 3) et `corruption` (départ 0). Les seuils viennent de [regles-campagne.md](../../../Campagne01/01-regles/regles-campagne.md).

| Réputation | Effet dans le jeu |
| --- | --- |
| 0-2 Honteux | Prix des boutiques +50 %. Les mercenaires refusent de signer. Les taverniers ne donnent pas de rumeurs. |
| 3-5 Neutre | Normal |
| 6-8 Respecté | Prix −10 %. Les rumeurs sont gratuites. |
| 9+ Légendaire | Prix −20 %. Le Garde impérial signe gratuitement. Réplique spéciale de chaque PNJ. |

| Corruption | Effet dans le jeu |
| --- | --- |
| 0-3 | Normal |
| 4-6 | `monstre+1` dans chaque aventure. Les PNJ le remarquent. |
| 7+ | La taverne ne permet plus le repos. Balur trahit. Un cultiste remplace l'un des taverniers. |

Les deux jauges s'affichent sur la fiche du héros ([personnage.php](../../templates/pages/personnage.php)), sous les jauges de vie et de magie.

## 8. Nouveaux objets

- **Catégorie `relique`** : un objet de lore, jamais vendu. Son effet est un code de bonus permanent, actif tant que l'objet est dans l'inventaire (même table de codes qu'en 6).
- **Emplacement `Bijou`** : pour la bague et l'amulette. Il s'ajoute à `Players::EQUIPMENT_SLOTS` et en colonne de `joueur`.

Le catalogue est dans [recompenses.md](recompenses.md).

## 9. Stockage

| Table | Colonnes | Rôle |
| --- | --- | --- |
| `drapeau` | `jou_num, cle, valeur INTEGER` | drapeaux, clés d'aventure, réputation, corruption |
| `bonus` | `jou_num, code, aventures, aventure NULL` | bonus temporaires |
| `equipe` | `jou_num, code, fidelite, aventures NULL` | mercenaires (`aventures` restantes) et compagnons (`NULL`) |
| `aventure.cle` | `TEXT NULL` | clé requise pour voir l'aventure |
| `objet.catheg` | ajout de `relique` | objets de lore |

Le serveur vérifie chaque choix : la réponse doit appartenir au nœud courant (gardé en session) et sa condition doit être vraie au moment du POST.
