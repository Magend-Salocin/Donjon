# Dialogues de la campagne

Notation : voir [mecaniques.md](mecaniques.md). Sources : les fiches de quête de [Campagne01/02-quetes](../../../Campagne01/02-quetes) et leurs conséquences ([consequences.md](../../../Campagne01/02-quetes/consequences.md)).

## Principes

- La quête N de la campagne correspond à l'aventure 100 + N. Les aventures 105 (Melar) et 110 (Château des mystères) n'existent pas en jeu : la chaîne passe de 104 à 106, puis de 109 à 111.
- Chaque débriefing se joue dans la taverne du village de l'aventure ([pnj.md](pnj.md)).
- Une victoire débloque l'aventure suivante de la campagne. Un échec ne bloque rien : le héros peut recommencer.
- Les conséquences d'un échec ne s'appliquent qu'au premier échec (condition `sans echec_<code>`, effet `drapeau echec_<code>`), pour ne pas punir deux fois. Dans les nœuds ci-dessous, ce drapeau est sous-entendu.
- Le dernier nœud de chaque débriefing efface son drapeau `debrief_<code>_*` : `effacer debrief_<code>_victoire` ou `_echec`. Lui aussi est sous-entendu.

| Aventure | Village | Débriefing | Débloque | Choix principal |
| ---: | --- | --- | ---: | --- |
| 101 | Valtordu | Mentor | 102 | Lettre impériale ou or |
| 102 | Waldorg | Sir Ragnar | 103 | Accepter sa dette, le recruter, ou demander de l'or |
| 103 | Gzor | Éclaireur impérial | 104 | Épargner, achever ou livrer Ulag |
| 104 | Valtordu | Émissaire du Prince | 106 | Rendre l'or, le garder, ou en garder une part |
| 106 | Waldorg | Prisonnier évadé | 107 | Alliance avec Grak ou refus |
| 107 | Gzor | Esprit de Wardoz | 108 | Purifier Wardoz ou prendre son or |
| 108 | Valtordu | Balur | 109 | Grimoire, pitié ou mort |
| 109 | Waldorg | Voix du labyrinthe | 111 | Porte de la richesse, de la connaissance ou de la vérité |
| 111 | Gzor | Éclaireur impérial | 112 | Prévenir Altdorf ou vendre l'information |
| 112 | Valtordu | Mentor | 113 | Étoile de l'Ouest, amulette selon la confiance |
| 113 | Waldorg | Prêtre fantôme | 114 | Fureur de Gromril, Larme de Leben, ou les deux |
| 114 | Gzor | Mentor | 115 | Fin héroïque ou ère sombre |

## Mentor : premier contact

### pnj : mentor

Présence : `sans mentor_rencontre`, au Rat fumant.

#### accueil

> Le feu brûle dans l'âtre, mais diffuse une faible clarté… Votre apprentissage est terminé. Votre épreuve commence. Zargon rôde, et ses ombres s'étendent bien au-delà de ces murs.

1. Quelle épreuve ? → epreuve
2. Qui êtes-vous ? → qui

#### qui

> Celui qui a formé les héros avant vous. La plupart sont morts. Les autres ont fait les bons choix.

1. Quelle épreuve ? → epreuve

#### epreuve

> Mon labyrinthe. Trouvez l'escalier en son cœur. Souvenez-vous : la vraie force n'est pas dans l'épée, mais dans les choix que vous ferez.

1. J'y vais. [effets : drapeau mentor_rencontre] → fin

## 101 : L'Épreuve (Mentor, Valtordu)

#### victoire

> Vous avez passé l'épreuve avec honneur. Voici une lettre de recommandation impériale. Elle pourrait vous ouvrir des portes… ou vous en fermer d'autres.

1. Merci, Mentor. Je la porterai avec fierté. [effets : objet 40, reputation +1, drapeau confiance_mentor, debloquer 102] → victoire-suite
2. Une lettre ne nourrit pas son homme. De l'or, plutôt. [effets : or +25, drapeau mentor_doute, debloquer 102] → victoire-or

#### victoire-suite

> Méfiez-vous : les ombres de Barak Tor s'allongent. Sir Ragnar est prisonnier d'Ulag. Ceux de Waldorg en savent plus.

1. Je pars pour Waldorg. → fin

#### victoire-or

> (Il pose une bourse sur la table, sans un mot de plus.) Sir Ragnar est prisonnier d'Ulag. Allez à Waldorg. L'or ne vous suffira pas, là-bas.

1. Nous verrons. → fin

#### echec

> Je craignais cela. Vous n'êtes pas encore prêts. L'Empire ne peut se permettre des faiblesses… Prouvez-moi que je me trompe.

1. Je recommencerai. [effets : reputation −1, drapeau mentor_doute] → fin

## 102 : Le sauvetage de Sir Ragnar (Sir Ragnar, Waldorg)

#### victoire

> Par Sigmar… Vous m'avez tiré de cet enfer. Un chevalier n'oublie jamais une dette. Prenez cette bague : elle vous protégera, comme elle m'a protégé.

1. J'accepte, Sir Ragnar. [effets : objet 41, drapeau ragnar_libre, effacer ragnar_maudit, debloquer 103] → offre
2. Gardez votre bague. Une récompense en or suffira. [effets : or +30, drapeau ragnar_libre, effacer ragnar_maudit, debloquer 103] → or

#### offre

> Et si un jour vous avez besoin d'une épée, venez me trouver ici. Mais souvenez-vous : la loyauté se mérite.

1. Pourquoi pas maintenant ? Rejoignez-moi. [si : reputation ≥ 3, sans or_magnus_garde] [effets : recruter ragnar] → recrute
2. Je m'en souviendrai. → fin

#### or

> (Il serre la mâchoire.) Soit. L'Empire paie ses dettes. Mais l'honneur ne se compte pas en pièces.

1. Chacun ses valeurs. [effets : fidelite ragnar −2] → fin

#### recrute

> Alors en route. Ulag a des alliés, et je connais leurs repaires. Ceux de Gzor vous diront le reste.

1. En route. → fin

#### echec

> (C'est Brunhilde qui vous accueille.) La famille de Sir Ragnar a appris que vous l'aviez laissé derrière vous. Elle a mis votre tête à prix.

1. Je retournerai le chercher. [effets : reputation −1, drapeau ragnar_maudit] → fin

## 103 : Le repaire du seigneur orc (Éclaireur impérial, Gzor)

#### victoire

> Beau travail. Ulag respire encore : mes hommes le tiennent dans la cour. Il supplie. Il parle d'un trésor sous les montagnes. Qu'est-ce qu'on en fait ?

1. Épargnez-le. Les orcs se souviendront de notre clémence. [effets : objet 42, drapeau ulag_epargne, debloquer 104] → epargne
2. Achevez-le. [effets : objet 42, drapeau ulag_mort, debloquer 104] → mort
3. Livrez-le au Prince Magnus. [effets : objet 42, or +20, reputation +1, drapeau ulag_mort, debloquer 104] → livre

#### epargne

> (Ulag jette une carte au sol.) « Tunnels… sous les montagnes. Mais si vous me trahissez… mes frères… »

1. On verra. → suite

#### mort

> Comme vous voudrez. On a trouvé une carte des tunnels sur son corps. Elle vous servira plus qu'à lui.

1. Merci. → suite

#### livre

> Le Prince sera ravi. Il paie toujours ses chasseurs de têtes. On a aussi trouvé cette carte sur lui.

1. Parfait. → suite

#### suite

> Autre chose : trois coffres de l'Empereur ont été volés dans les Montagnes Noires. On en parle à Valtordu.

1. J'y vais. → fin

#### echec

> Ulag a fui. Ses orcs ont pillé un hameau la nuit dernière. Il ne reste rien.

1. C'est ma faute. [effets : corruption +2] → fin

## 104 : L'or du Prince Magnus (Émissaire du Prince, Valtordu)

#### victoire

> Vous avez retrouvé les coffres. Le Prince vous en sera reconnaissant… à condition qu'ils arrivent pleins.
> (Les coffres brillent faiblement. Gulthor disait que cet or était maudit.)

1. Les voici, intacts. [effets : objet 43, or +20, reputation +2, drapeau or_magnus_rendu, debloquer 106] → rendu
2. Les orcs avaient déjà tout dépensé. [effets : or +100, corruption +2, fidelite ragnar −3, drapeau or_magnus_garde, debloquer 106] → garde
3. Deux coffres. Le troisième, c'est notre salaire. [effets : or +40, reputation +1, corruption +1, drapeau or_magnus_partiel, debloquer 106] → partiel

#### rendu

> L'Empire n'oublie pas. Recevez la médaille impériale. On murmure que Grak, le fils d'Ulag, vous cherche. Soyez prudents à Waldorg.

1. Merci. → fin

#### garde

> (L'émissaire vous regarde longuement.) Je transmettrai. (En sortant, vous remarquez que vos mains sont froides là où elles ont touché les pièces.)

1. … → fin

#### partiel

> Le Prince comptera. Il compte toujours. Mais il appréciera le geste.

1. Il sera bien gardé, ce troisième coffre. → fin

#### echec

> Les coffres sont perdus, et l'on dit à la cour que vous les avez pris vous-mêmes. Vous êtes accusés de trahison.

1. C'est faux ! [effets : reputation −2] → fin

## 106 : L'héritage du seigneur orc (Prisonnier évadé, Waldorg)

#### victoire

> Vous m'avez sorti de là aussi. Avant que vous ne cassiez la serrure, Grak est venu me parler. Il veut vous proposer une alliance. « Ensemble, écraser les humains », qu'il a dit.

1. Qu'il vienne me parler. J'écoute. → grak
2. Jamais d'alliance avec un orc. [effets : drapeau grak_vengeance, bonus att+1@107, debloquer 107] → refus

#### grak

> (Un orc entre, crache par terre, et pose une cape de peau sur la table.) « Grak dire : vous pas stupides. Ensemble, nous forts. Prends cape. »

1. J'accepte l'alliance. [effets : objet 44, reputation −1, fidelite ragnar −2, drapeau grak_allie, debloquer 107] → allie
2. Dis à Grak que c'est non. [effets : drapeau grak_vengeance, bonus att+1@107, debloquer 107] → refus

#### allie

> « Bien ! Quand toi besoin, guerriers de Grak venir. Une fois. » (Les guerriers de Grak deviennent un mercenaire gratuit, pour une seule aventure : [compagnons.md](compagnons.md).)

1. Une fois suffira. → fin

#### refus

> (On entend un hurlement au loin.) Grak n'oubliera pas. Mais ses orcs sont dispersés : la route de Gzor sera plus sûre.

1. Qu'il vienne. → fin

#### echec

> Grak vous a laissés filer, mais il a rejoint Zargon. Les orcs de l'Est portent désormais sa marque.

1. … [effets : corruption +1, drapeau grak_vengeance] → fin

## 107 : Le chasseur de pierres (Esprit de Wardoz, Gzor)

Le résumé de l'aventure 107 en base parle de Karlen, le sorcier de l'Empereur (nom du HeroQuest PC). La campagne l'appelle Wardoz. À harmoniser (voir le concept).

#### victoire

> (Une voix froide, dans la fumée de l'âtre.) Vous… êtes venus… Trop tard. La magie m'a dévoré. Mon grimoire du Chaos est encore là-bas. Libérez-moi… ou prenez ce qui reste.

1. Je purifie ton âme, Wardoz. [effets : objet 45, reputation +2, drapeau wardoz_purifie, debloquer 108] → purifie
2. Je prends ton or et ton grimoire. [effets : or +144, corruption +1, drapeau wardoz_tue, debloquer 108] → tue

#### purifie

> Merci… Le grimoire… Balur l'a peut-être déjà trouvé. Dans les Pics Volcaniques. Méfiez-vous du feu.

1. Repose en paix. → fin

#### tue

> Vous… n'avez rien compris… Le Chaos… gagne toujours.

1. … → fin

#### echec

> (La voix de Wardoz ricane dans les flammes.) La pierre vous a touchés. Elle ne vous lâchera plus.

1. … [effets : pvmax −1, corruption +1] → fin

## 108 : Le mage du feu (Balur, Valtordu)

#### victoire

> (Balur, à genoux, couvert de cendres, sourit encore.) Bravo, insectes. Prenez ce grimoire : il contient des sorts que même les mages impériaux ignorent. Mais le feu a un prix.

1. Je prends le grimoire. [effets : objet 46, reputation +1, drapeau balur_epargne, debloquer 109] → grimoire
2. Garde ton grimoire. Va-t'en, et ne reviens pas. [effets : reputation +1, drapeau balur_epargne, debloquer 109] → pitie
3. Tu as trop brûlé de villages. [effets : objet 47, drapeau balur_mort, debloquer 109] → mort

Si `wardoz_purifie`, une réplique s'ajoute avant les réponses : « Wardoz vous a parlé de moi ? Ce vieux fou était trop faible pour son propre grimoire. »

#### grimoire

> Étrange… Vous auriez pu me tuer. Nous nous reverrons, héros. Peut-être même du même côté.

1. Peut-être. → fin

#### pitie

> La pitié ? Voilà qui est nouveau. Je m'en souviendrai… dans un sens ou dans l'autre.

1. … → fin

#### mort

> (Il s'effondre en riant.) Les cultistes… viendront pour vous… (Sur son corps, une pierre tiède, qui ne brûle pas.)

1. Qu'ils viennent. → fin

#### echec

> (Une odeur de soufre flotte dans la taverne.) Vous avez fui. Balur a laissé sa marque sur vous.

1. … [effets : pvmax −1, corruption +1] → fin

## 109 : Course contre la montre (Voix du labyrinthe, Waldorg)

Le Guide qui trahit le héros se recrute à Valtordu, avant l'aventure : voir [compagnons.md](compagnons.md).

#### victoire

> (Une lueur verdâtre danse dans votre chope.) Chaque porte mène à un destin différent. L'une offre la richesse, une autre la connaissance, la dernière… la vérité. Laquelle avez-vous franchie ?

1. La richesse. [effets : objet 48, or +30, drapeau porte_richesse, debloquer 111] → richesse
2. La connaissance. [effets : objet 49, drapeau porte_connaissance, debloquer 111] → connaissance
3. La vérité. [effets : objet 50, drapeau porte_verite, debloquer 111] → verite

#### richesse

> Les ombres vous suivent désormais. Elles chuchotent vos noms quand vous dormez.

1. … → suite

#### connaissance

> Les miroirs d'Ollar ne reflètent pas la réalité… mais ce qui pourrait l'être.

1. … → suite

#### verite

> Le Sorcier-Roi porte un anneau qui le protège. Seule une lame pure peut le briser.

1. … → suite

#### suite

> Les orcs et les gobelins pillent l'Est depuis un bastion souterrain. Ceux de Gzor le savent.

1. J'irai à Gzor. → fin

#### echec

> Vous m'avez abandonné ici… Maintenant, je ne vous quitterai plus. Jamais. (Une de vos possessions a disparu.)

1. … [effets : perdre-objet, drapeau spectre_guide] → fin

## 111 : Le bastion du Chaos (Éclaireur impérial, Gzor)

#### victoire

> Le bastion est tombé. Dans les quartiers du chef, on a trouvé ceci : Zargon prépare une attaque sur Altdorf.

1. Prévenez Altdorf, vite. [effets : reputation +2, debloquer 112] → previent
2. Cette information vaut de l'or. Je la vendrai. [effets : or +50, corruption +1, debloquer 112] → vend

Si `grak_vengeance`, réplique ajoutée : « Grak commandait le bastion. Il a fui par les tunnels. On ne le reverra pas de sitôt. » [effets : effacer grak_vengeance]

#### previent

> Les cavaliers partent ce soir. Et vous, partez pour Valtordu : Mentor veut vous voir. Il parle de Barak Tor.

1. J'y vais. → fin

#### vend

> (Il vous regarde avec dégoût.) L'Empire a des espions partout, vous savez. Mentor vous attend à Valtordu.

1. … → fin

#### echec

> Zargon a invoqué un démon dans le bastion. Les terres autour sont mortes.

1. … [effets : corruption +2, drapeau demon_mineur, bonus monstre+1@114] → fin

## 112 : Barak Tor (Mentor, Valtordu)

#### victoire

> L'Étoile de l'Ouest… Vous l'avez. Mais vous avez réveillé le Sorcier-Roi. Seule la lame de l'esprit, forgée par les nains, peut le blesser. Elle repose dans un temple en ruine.

1. Où est ce temple ? [effets : objet 51, debloquer 113] → temple
2. Avez-vous quelque chose pour nous protéger ? [si : drapeau confiance_mentor] [effets : objet 51, objet 52, debloquer 113] → amulette

#### temple

> Au-delà de Waldorg. Le prêtre qui le garde n'est plus tout à fait vivant. Écoutez-le.

1. Merci, Mentor. → fin

#### amulette

> Cette amulette appartenait au premier héros que j'ai formé. Il n'en a plus besoin. Le temple est au-delà de Waldorg.

1. Je la porterai. → fin

#### echec

> Le Sorcier-Roi a relevé un champion d'entre les morts. Il vous attendra.

1. … [effets : corruption +2, drapeau champion_sorcier, bonus monstre+1@114] → fin

## 113 : La lame de l'esprit (Prêtre fantôme, Waldorg)

#### victoire

> Deux lames. Deux destins. L'une vous donnera la force de vaincre, au prix de votre âme. L'autre vous offrira la sagesse, mais exige une pureté que peu possèdent.

1. La Fureur de Gromril, l'épée naine. [effets : objet 53, drapeau epee_fureur, debloquer 114] → fureur
2. La Larme de Leben, l'épée elfique. [si : corruption ≤ 3, sans or_magnus_garde] [effets : objet 54, drapeau epee_larme, debloquer 114] → larme
3. Les deux. [effets : objet 55, pvmax −1, drapeau epee_maudite, debloquer 114] → deux

La réponse 2 grisée affiche « Votre cœur n'est pas assez pur » plutôt que la condition chiffrée.

#### fureur

> Je suis la fureur des ancêtres ! Ma lame exige du sang… le tien aussi. (La poignée vous brûle la main.)

1. Qu'il en soit ainsi. → fin

#### larme

> Je suis la sagesse des anciens. Un mensonge, une trahison, et je me retournerai contre toi.

1. Je serai digne. → fin

#### deux

> Gourmands… et indignes. Vous ne méritez aucune des deux. (Il ne reste qu'une dague noire.)

1. … → fin

#### echec

> La lame est retournée dans la pierre. Vous affronterez le Sorcier-Roi sans elle.

1. … [effets : bonus att−1@114] → fin

## 114 : Retour à Barak Tor (Mentor, Gzor)

#### victoire

Le premier nœud dépend de l'épée portée.

> **Si `epee_larme`** : L'anneau s'est brisé. Le Sorcier-Roi n'est plus. Vous avez bien fait, mes amis… Mais le vrai combat ne fait que commencer. Zargon se lève.

1. Nous serons prêts. [effets : reputation +3, drapeau campagne_heroique, debloquer 115] → suite

> **Sinon** : Il s'est retiré, mais il n'est pas mort. Votre lame l'a blessé sans le vaincre. Il reviendra, plus fort.

1. Alors nous le poursuivrons. [effets : corruption +1, drapeau campagne_sombre, debloquer 115] → suite

#### suite

> Sa forteresse est ouverte. Ses portes, ses salles glacées, sa légion oubliée… Le Retour du Sorcier-Roi commence. Êtes-vous prêts ?

1. Toujours. → fin

#### echec

> Les morts marchent sur l'Empire. Une ère sombre commence. Mais tant que vous respirez, rien n'est perdu.

1. Je retourne à Barak Tor. [effets : corruption +3] → fin
