# Dialogues des taverniers et des habitués

Notation : voir [mecaniques.md](mecaniques.md). Les PNJ et leur présence sont dans [pnj.md](pnj.md).

Les taverniers ont quatre fonctions, toujours dans le même ordre de réponses, pour que le joueur s'y retrouve :

1. les nouvelles : rumeurs qui donnent un bonus pour la prochaine aventure de la campagne ;
2. le repos : rendre ses points de vie ;
3. le recrutement : liste des mercenaires ;
4. l'action propre à chaque taverne (tournée générale, défi à boire…).

Les rumeurs suivent la campagne. Le tavernier propose celle de la prochaine aventure qui se joue dans son village. Sinon, il répond par une réplique d'ambiance.

## Valtordu : Hergard, tavernier du Rat fumant

### pnj : hergard

Présence : toujours. Si `corruption ≥ 7`, il est remplacé par le cultiste (voir plus bas).

#### accueil

> Encore un aventurier… Essuie tes bottes, j'ai lavé le sol au printemps. Qu'est-ce que je te sers ?

1. Des nouvelles du pays ? → nouvelles
2. Une chambre pour la nuit. → repos
3. Je cherche des bras pour une expédition. [effets : ecran recrutement] → fin
4. Une tournée pour toute la salle ! [si : or ≥ 10, sans tournee_valtordu] [effets : or −10, reputation +1, drapeau tournee_valtordu] → tournee
5. Rien, merci. → fin

#### nouvelles

Le nœud propose la première rumeur disponible, dans l'ordre ci-dessous. Une fois achetée, elle n'est plus proposée (drapeau `rumeur_<sujet>`).

> **Avant l'aventure 101** (`sans aventure 101`) : Le vieux Mentor cherche des têtes brûlées pour son épreuve. Paraît qu'il a semé son labyrinthe de pièges, le vieux sadique.

1. Où sont les pièges ? [si : or ≥ 2] [effets : or −2, bonus pieges@101, drapeau rumeur_labyrinthe] → nouvelles-merci
2. Je trouverai bien. → accueil

> **Avant l'aventure 104** (`aventure 103`, `sans aventure 104`) : Trois coffres de l'Empereur ont disparu dans les Montagnes Noires. Les orcs qui les gardent obéissent à un guerrier en armure noire. Gulthor, qu'on l'appelle.

1. Comment le battre ? [si : or ≥ 3] [effets : or −3, bonus def+1@104, drapeau rumeur_gulthor] → nouvelles-gulthor
2. Merci du renseignement. → accueil

> **Avant l'aventure 108** (`aventure 107`, `sans aventure 108`) : Les orcs reviennent des Pics Volcaniques avec des torches qui ne s'éteignent jamais. On parle d'un mage, Balur.

1. Que sais-tu de lui ? [si : or ≥ 3] [effets : or −3, bonus corps+2@108, drapeau rumeur_balur] → nouvelles-balur
2. Je verrai sur place. → accueil

> **Sinon** : Rien de neuf. Les vaches donnent moins de lait depuis que les orcs passent. C'est tout.

1. Dommage. → accueil

#### nouvelles-merci

> Les dalles les plus propres. Personne ne marche dessus, alors personne ne les salit. Logique, non ?

1. Logique. → accueil

#### nouvelles-gulthor

> Il frappe fort, mais toujours de la même façon. Garde ton bouclier haut et laisse-le se fatiguer.

1. Compris. → accueil

#### nouvelles-balur

> Mouille ta cape avant d'y aller. Ça sent le roussi, mais ça sauve la peau.

1. Merci, Hergard. → accueil

#### repos

> La paillasse, c'est 5 pièces. Pour 12, t'as la chambre du haut, un vrai lit et un bain chaud.

1. La paillasse. [si : or ≥ 5, corruption ≤ 6] [effets : or −5, pv plein] → repos-ok
2. La chambre du haut. [si : or ≥ 12, corruption ≤ 6] [effets : or −12, pv plein, bonus corps+2] → repos-ok
3. Trop cher. → accueil

#### repos-ok

> Dors bien. Et si t'entends gratter sous le plancher, c'est les rats du père Magotte. Pas les miens.

1. Bonne nuit. → fin

#### tournee

> Holà, tout le monde ! C'est l'aventurier qui régale !
> (La salle lève ses chopes. On se souviendra de ton nom à Valtordu.)

1. À la vôtre ! → fin

### pnj : magotte (père Magotte, fermier)

Présence : `sans aventure 1`.

#### accueil

> Vous êtes aventurier, vous ? Alors aidez un pauvre vieux. Les rats ont pris ma grange. Des gros, gros comme des chiens.

1. Je m'en occupe. [effets : debloquer 1] → accepte
2. Combien vous payez ? → paie
3. Pas le temps. → fin

#### paie

> Dix pièces, et toute la reconnaissance du village. Et un poulet, si vous revenez vivant.

1. Marché conclu. [effets : debloquer 1] → accepte
2. Trop peu. → fin

#### accepte

> Merci ! La grange est derrière le moulin. Prenez une torche, ils n'aiment pas le feu.

1. J'y vais. → fin

Après l'aventure 1, le père Magotte revient une fois : « Mon poulet, comme promis ! » [effets : objet 19, reputation +1, drapeau fini_magotte].

### pnj : hergard, aventures 4 et 5

Ces deux réponses s'ajoutent au nœud `accueil` d'Hergard quand leur condition est vraie.

6. Il paraît que tu connais une histoire de statuette ? [si : grade Aventurier, sans aventure 4] [effets : debloquer 4] → statuette
7. Qui vole les tomates de la région ? [si : grade Legende, sans aventure 5] [effets : debloquer 5] → vampire

#### statuette

> Une statuette, une prophétie de Galdeulfera, et un sorcier de niveau 1 pour l'aller chercher. Ça finit toujours mal, ces histoires-là. Monte une compagnie, et bonne chance.

1. On verra bien. → fin

#### vampire

> Un ancien seigneur, revenu d'entre les morts pour dévorer les tomates. Le cours de la tomate s'effondre. Si tu le chasses, les maraîchers te bénissent.

1. Les tomates seront vengées. → fin

### Le cultiste de Zargon (remplace Hergard si `corruption ≥ 7`)

#### accueil

> Hergard ? Parti. Il ne supportait plus… l'odeur. Toi, en revanche, tu sens déjà comme nous. Assieds-toi. Le Maître est généreux avec ceux qui l'écoutent.

1. Quel genre de générosité ? → pacte
2. Je vais te tuer. → menace
3. Je m'en vais. → fin

#### pacte

> De l'or. Beaucoup d'or. En échange, un peu de toi.

1. J'accepte. [effets : or +50, corruption +1] → fin
2. Jamais. [effets : reputation +1] → fin

#### menace

> Me tuer ? Je suis déjà mort à l'intérieur. Comme toute cette ville, bientôt.

1. … → fin

## Waldorg : Brunhilde, aubergiste du Cheval bondissant

### pnj : brunhilde

Présence : toujours.

#### accueil

> Bienvenue au Cheval bondissant ! Lit, repas, écurie, et pas de bagarre avant minuit. Qu'est-ce que ce sera ?

1. Des nouvelles de la route ? → nouvelles
2. Un lit. → repos
3. Des gens à embaucher ? [effets : ecran recrutement] → fin
4. Un remède pour la route. [si : or ≥ 15] [effets : or −15, objet 996] → remede
5. Au revoir. → fin

#### nouvelles

> **Avant l'aventure 102** (`aventure 101`, `sans aventure 102`) : Sir Ragnar, le chevalier de l'Empereur, est aux mains d'Ulag. Ses gardes frappent toujours de face, les brutes. Ils n'ont jamais appris à feinter.

1. Bon à savoir. [effets : bonus def+1@102, drapeau rumeur_ragnar] → accueil

> **Avant l'aventure 106** (`aventure 104`, `sans aventure 106`) : Grak, le fils d'Ulag, cherche les meurtriers de son père. Fais attention où tu dors, et repère toujours une sortie.

1. Merci du conseil. [si : or ≥ 3] [effets : or −3, bonus depl+2@106, drapeau rumeur_grak] → accueil
2. Je n'ai peur de personne. → accueil

> **Avant l'aventure 113** (`aventure 112`, `sans aventure 113`) : Les morts ne dorment plus à Barak Tor. Un pèlerin parle d'un temple en ruine, mi-nain, mi-elfe, où reposent deux épées.

1. Où est ce temple ? [si : or ≥ 5] [effets : or −5, bonus def+1@113, drapeau rumeur_temple] → accueil
2. J'en ai assez entendu. → accueil

> **Si `ragnar_maudit`** : On dit que la famille de Sir Ragnar a mis ta tête à prix. Je ne veux pas d'ennuis chez moi.

1. Je comprends. → fin

> **Sinon** : La route de l'Est est calme. Trop calme, si tu veux mon avis.

1. On verra. → accueil

#### repos

> Huit pièces, repas compris. La soupe est bonne aujourd'hui, pour une fois.

1. Va pour un lit. [si : or ≥ 8, corruption ≤ 6] [effets : or −8, pv plein] → fin
2. Une autre fois. → accueil

#### remede

> Une potion de vitesse, prise à un marchand d'Altdorf. Il jurait qu'elle fait courir plus vite qu'un orc affamé.

1. Merci. → fin

### pnj : jos (Jos, éleveur de poulets)

Présence : `sans aventure 2`.

#### accueil

> Mes poulets… Un par nuit. Et ce matin, j'ai vu un de mes poulets… marcher sur deux jambes d'homme. Un changeforme ! Personne ne me croit.

1. Moi, je te crois. [effets : debloquer 2] → accepte
2. Tu as trop bu. → fin

#### accepte

> Merci ! Quinze pièces si vous le trouvez. Et pas un mot à ma femme, elle croit que c'est le renard.

1. Promis. → fin

Après l'aventure 2, Jos revient une fois : « Plus un poulet de perdu ! Tenez, le gâteau de ma femme. » [effets : objet 20, drapeau fini_jos].

## Gzor : Snorri, tavernier nain du Gai souriseau

### pnj : snorri

Présence : toujours.

#### accueil

> Hah ! Un client qui tient debout. Rare, à cette heure. Bière, bagarre, ou ragots ?

1. Ragots. → nouvelles
2. Un coin pour dormir. → repos
3. Des épées à louer ? [effets : ecran recrutement] → fin
4. Un défi à boire ! [si : sans defi_snorri] → defi
5. Où est passée ta réserve de bière ? [si : sans aventure 3] → biere
6. Bière, et je m'en vais. [effets : or −1] → fin

#### nouvelles

> **Avant l'aventure 103** (`aventure 102`, `sans aventure 103`) : Ulag ronfle comme un dragon. Ses gardes aussi, à l'aube. Entre à ce moment-là.

1. Merci, Snorri. [si : or ≥ 2] [effets : or −2, bonus att+1@103, drapeau rumeur_ulag] → accueil
2. Je n'ai rien à payer. → accueil

> **Avant l'aventure 107** (`aventure 106`, `sans aventure 107`) : Une bête change les gens en pierre dans les Montagnes Frontalières. Ne la regarde pas dans les yeux. Jamais.

1. Que sais-tu d'autre ? [si : or ≥ 3] [effets : or −3, bonus def+1@107, drapeau rumeur_pierre] → accueil
2. Merci. → accueil

> **Avant l'aventure 111** (`aventure 109`, `sans aventure 111`) : Le bastion du Chaos est plein d'orcs et de gobelins. Ils se battent entre eux pour les restes. Frappe le premier, frappe fort.

1. Compris. [si : or ≥ 3] [effets : or −3, bonus att+1@111, drapeau rumeur_bastion] → accueil
2. Merci. → accueil

> **Sinon** : Les mines de Gzor ont trouvé un filon d'argent. Tout le monde boit à crédit. C'est la fin du monde.

1. Courage. → accueil

#### repos

> Une paillasse dans la cave, entre deux tonneaux. Trois pièces. Ne touche pas aux tonneaux.

1. Ça ira. [si : or ≥ 3, corruption ≤ 6] [effets : or −3, pv plein] → fin
2. Non merci. → accueil

#### defi

> Un défi ! Trois chopes de Bière de Gromril, et le premier qui tombe paie la tournée. Mise : 10 pièces.

1. Je tiens le pari. [si : or ≥ 10, type Nain] [effets : or +10, bonus att+1, drapeau defi_snorri] → defi-gagne
2. Je tiens le pari. [si : or ≥ 10] [effets : or −10, drapeau defi_snorri] → defi-perdu
3. Je ne suis pas fou. → accueil

Le Nain gagne toujours. Les autres types perdent. C'est un clin d'œil, pas un jeu de hasard.

#### defi-gagne

> Par ma barbe ! Un vrai buveur ! Prends ça, ça te donnera du cœur au combat. (Il te tend un breuvage.)

1. À la tienne. [effets : objet 995] → fin

#### defi-perdu

> (Tu te réveilles sous la table. Snorri compte tes pièces en sifflant.)

1. … → fin

#### biere

> Un lutin. Bleu. Il est entré, il a tout pris, il est reparti dans la forêt. Toute ma réserve ! C'est une mission capitale !

1. Je retrouve ta bière. [si : grade Ecuyer] [effets : debloquer 3] → biere-ok
2. Je suis trop novice pour ça. → accueil

#### biere-ok

> Si tu la ramènes, tu bois gratuit chez moi pour toujours. Enfin… pour une semaine.

1. Marché conclu. → fin

### pnj : gnorg (Gnorg, gobelin unijambiste repenti)

Présence : `sans aventure 6`.

#### accueil

> Pas taper ! Gnorg gentil maintenant ! Mais copains à Gnorg, pas gentils. Eux boire, eux piller champ du fermier, eux casser tout.

1. Où sont-ils ? [effets : debloquer 6] → accepte
2. Pourquoi tu les trahis ? → pourquoi
3. Dégage. → fin

#### pourquoi

> Eux prendre jambe de Gnorg. Pour rire. Gnorg pas rire.

1. Je comprends. Où sont-ils ? [effets : debloquer 6] → accepte

#### accepte

> Champ derrière colline. Eux dormir le jour, boire la nuit. Toi venir le jour !

1. Merci, Gnorg. → fin
