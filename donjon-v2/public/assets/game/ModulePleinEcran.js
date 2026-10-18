/*
 * Taille d'affichage du plateau (canvas des vues iso ou tableau #board de la vue de dessus).
 * Dans la page, le plateau occupe la largeur de la colonne. En plein ecran (toute la zone de jeu, cartes
 * tresor et inventaire compris), il est agrandi au maximum en laissant la fiche du heros visible.
 * La resolution interne du canvas ne change pas : seul l'affichage est mis a l'echelle.
 */

	var PLATEAU_LARGEUR_PAGE = 728;

	function ZoneDeJeu(){
		return document.getElementById('body-fullside');
	}

	function EstPleinEcran(){
		return document.fullscreenElement == ZoneDeJeu();
	}

	function PlateauVisible(){
		var Canvas = document.getElementById('board-iso');
		return Canvas && Canvas.style.display != 'none' ? Canvas : document.getElementById('board');
	}

	function HauteurContenu(Zone){					// du haut du titre au bas du dernier bouton
		return Zone.lastElementChild.getBoundingClientRect().bottom - Zone.firstElementChild.getBoundingClientRect().top;
	}

	function AjusterPlateau(){
		var Plateau = PlateauVisible(), Canvas = Plateau.tagName == 'CANVAS';
		Plateau.style.width = Plateau.style.height = Plateau.style.zoom = '';	// mesures a la taille d'origine
		var Largeur = Canvas ? Plateau.width : Plateau.offsetWidth;
		var Hauteur = Canvas ? Plateau.height : Plateau.offsetHeight;
		var Echelle = Canvas ? PLATEAU_LARGEUR_PAGE / Largeur : 1;
		if (EstPleinEcran()){
			var Zone = ZoneDeJeu();
			var Autres = HauteurContenu(Zone) - Plateau.getBoundingClientRect().height;	// titre, fiche du heros, boutons
			Echelle = Math.min((Zone.clientWidth - 20) / Largeur, (window.innerHeight - Autres - 30) / Hauteur);
		}
		if (Canvas){
			Plateau.style.width = Math.floor(Largeur * Echelle) + 'px';
			Plateau.style.height = Math.floor(Hauteur * Echelle) + 'px';
		} else {
			Plateau.style.zoom = Echelle == 1 ? '' : Echelle;
		}
	}

	function BasculerPleinEcran(){
		if (EstPleinEcran()) { document.exitFullscreen(); }
		else { ZoneDeJeu().requestFullscreen(); }
	}

	function AfficherBoutonPleinEcran(){
		var Bouton = document.getElementById('plein-ecran');
		Bouton.style.display = document.fullscreenEnabled ? '' : 'none';
		Bouton.textContent = EstPleinEcran() ? 'Quitter le plein écran (Échap)' : 'Plein écran';
	}

	document.addEventListener('fullscreenchange', function(){
		AfficherBoutonPleinEcran();
		AjusterPlateau();
	});
	window.addEventListener('resize', AjusterPlateau);
	window.addEventListener('load', function(){
		AfficherBoutonPleinEcran();
		AjusterPlateau();
		// La fiche du heros change de hauteur (menu de combat, messages) : le plateau suit en plein ecran.
		if (window.ResizeObserver) { new ResizeObserver(function(){ if (EstPleinEcran()) { AjusterPlateau(); } }).observe(document.getElementById('CarteJoueurAventure')); }
	});
