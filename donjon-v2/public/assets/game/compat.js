/*
 * Remplace les quelques fonctions de mootools 1.2 utilisées par le jeu en 2009.
 */

	function $(id){
		return typeof id === 'string' ? document.getElementById(id) : id;
	}

	/* Image d'une case du plateau (id = numéro de case). */
	function ImageCase(id){
		return document.getElementById(String(parseInt(id, 10)));
	}
