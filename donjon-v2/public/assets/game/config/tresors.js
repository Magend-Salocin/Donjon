/*
	Cartes tresor tirees au hasard quand un heros fouille une piece.

	type        : 'or' (ajoute la valeur a l'or du heros), 'potion' (ajoute l'objet au sac),
	              'piege' (retire la valeur en points de Corps), 'rien'
	titre       : titre de la carte
	cible       : caracteristique visee, a titre informatif
	valeur      : pieces d'or, bonus de la potion ou points de Corps perdus
	objet       : numero de l'objet ajoute au sac (table objet, 995 a 999), potions uniquement
	exemplaires : nombre de cartes identiques dans la pioche (1 par defaut)
	texte       : description affichee sur la carte (HTML accepte)
*/
var CONFIG_TRESORS = [
	{ type: 'or', titre: 'Or !', cible: 'or', valeur: 10,
	  texte: "Un maigre butin de 10 pièces d'or est découvert dans la poche d'un vieux pourpoint malodorant." },
	{ type: 'or', titre: 'Or !', cible: 'or', valeur: 25,
	  texte: "Dans un fouillis de vieux chiffons, manteaux de fourrure élimés et couvertures tachées, vous découvrez 25 pièces d'or." },
	{ type: 'or', titre: 'Or !', cible: 'or', valeur: 20,
	  texte: "La fouille de vieux vêtements vous permet de découvrir 20 pièces d'or." },
	{ type: 'or', titre: 'Or !', cible: 'or', valeur: 25,
	  texte: "Cette boîte contenant 25 pièces d'or a été abandonnée par un inconscient qui n'a même pas songé à la dissimuler." },
	{ type: 'or', titre: 'Or !', cible: 'or', valeur: 50,
	  texte: "Vous avez repéré une pierre descellée derrière laquelle se trouve dissimulée une petite bourse en cuir enveloppée d'un vieux chiffon. Celle-ci contient 50 pièces d'or." },
	{ type: 'or', titre: 'Bijoux !', cible: 'or', valeur: 50,
	  texte: "Vous trouvez un petit coffre de bois, d'apparence ordinaire et plutôt vieux, mais à l'intérieur, sur une doublure de velours, reposent des bijoux d'une valeur de 50 pièces d'or." },
	{ type: 'or', titre: 'Pierre précieuse !', cible: 'or', valeur: 50,
	  texte: "Nichée au fond d'une vieille botte, vous découvrez une pierre précieuse d'une valeur de 50 pièces d'or." },
	{ type: 'or', titre: 'Fabuleux trésor !', cible: 'or', valeur: 100,
	  texte: "La chance est avec vous. Un petit coffre que vous trouvez dissimulé sous une vieille fourrure contient 100 pièces d'or." },

	{ type: 'potion', titre: 'Potion de résistance', cible: 'def', valeur: 2, objet: 998,
	  texte: "Parmi toute une collection de vieux flacons et pots en terre, vous découvrez une petite fiole claire contenant une potion de résistance. Celle-ci peut être prise à tout moment. Votre défense augmentera de deux." },
	{ type: 'potion', titre: 'Potion de vitesse', cible: 'dee', valeur: 2, objet: 996,
	  texte: "Vous repérez un flacon poussiéreux sur une étagère. En le nettoyant, vous vous rendez compte qu'il s'agit d'une potion de vitesse. Celle-ci peut être bue à tout moment. Elle vous permettra de relancer les dés de déplacement." },
	{ type: 'potion', titre: 'Potion de force', cible: 'for', valeur: 2, objet: 997,
	  texte: "Vous trouvez un petit flacon rempli de liquide pourpre. Il s'agit d'une potion de force. Vous pouvez la boire à tout moment. Elle vous permettra de lancer deux dés de combat en plus pour attaquer." },
	{ type: 'potion', titre: 'Potion de guérison', cible: 'or', valeur: 10, objet: 999, exemplaires: 2,
	  texte: "Vous découvrez un petit flacon enveloppé de vieux chiffons et en reconnaissez tout de suite le contenu : il s'agit d'une potion de guérison. Celle-ci peut être bue à tout moment. Elle vous restituera quatre points de vie perdus." },
	{ type: 'potion', titre: 'Breuvage héroïque', cible: 'or', valeur: 2, objet: 995,
	  texte: "Un sac de cuir accroché au mur contient une potion. Il s'agit d'un breuvage héroïque. Celui-ci peut être pris juste avant de lancer un combat. Le joueur qui absorbe cette potion pourra, le temps d'un tour seulement, attaquer deux fois au lieu d'une." },

	{ type: 'rien', titre: 'Rien', cible: '', valeur: '',
	  texte: "En dépit d'une fouille méticuleuse, vous ne trouvez rien." },

	{ type: 'piege', titre: 'Piège !', cible: 'Vie', valeur: -1,
	  texte: "Une dalle cède sous votre pied et vous vous rendez compte trop tard qu'il s'agit d'un piège. Vous tombez dans une fosse et perdez un point de Corps." },
	{ type: 'piege', titre: 'Piège !', cible: 'Vie', valeur: -1,
	  texte: "La pression d'un fil contre votre jambe vous avertit du danger et vous faites volte-face... Mais il est trop tard ! Le carreau d'une arbalète vous coûte un point de Corps." },
	{ type: 'piege', titre: 'Piège !', cible: 'Vie', valeur: -1,
	  texte: "Au cours de vos recherches, vous déclenchez accidentellement un piège. Une flèche jaillit du mur et vous atteint. Vous perdez un point de Corps." }
];

var CODES_TYPE_TRESOR = { potion: 0, or: 1, piege: 2, rien: 9 };
var LesTresors = GetAllTabTresor();

function TabObjet(Config){
	//  Type =  Nom-image-cible-valeur-text-IDBase
	//   0   -    1    -    2   -     3   -   4  -  5 - 6
	//  Type : 0 potion (objet 995 a 999), 1 or, 2 piege, 9 rien
	var Objet = (Config.type == 'potion') ? Config.objet : -1;
	return new Array(CODES_TYPE_TRESOR[Config.type],Config.titre,Chemin+'/',Config.cible,Config.valeur,Config.texte,Objet);
}

/* Pioche des cartes tresor, construite depuis CONFIG_TRESORS. */
function GetAllTabTresor(){
	var LesTresors  = new Array();
	for (var i=0;i<CONFIG_TRESORS.length;i++){
		var Exemplaires = CONFIG_TRESORS[i].exemplaires || 1;
		for (var n=0;n<Exemplaires;n++){ LesTresors[LesTresors.length] = TabObjet(CONFIG_TRESORS[i]); }
	}
	return LesTresors;
}
