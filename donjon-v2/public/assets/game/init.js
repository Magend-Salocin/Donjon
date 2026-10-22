/* Etat global de la partie et fonctions DOM communes. Charge en premier, avant config/ et la quete. */
	var Chemin ="assets/game/images";
	var MovementJoueur 	= 0;
	var ConstIdJoueur 	= 0;
	var MonstreTuer 	= 0;
	var LesJoueurs   	= new Array();
	var LesEffets   	= new Array();
	var MesObjet   		= new Array();
	var PartieTerminee 	= false;

	/* Remplace le $ de mootools 1.2, utilise par le jeu en 2009. */
	function $(id){
		return typeof id === 'string' ? document.getElementById(id) : id;
	}

	/* Image d'une case du plateau (id = numéro de case). */
	function ImageCase(id){
		return document.getElementById(String(parseInt(id, 10)));
	}
