/*
 * Taille d'affichage du plateau (canvas des vues iso ou tableau #board de la vue de dessus).
 * Le plateau occupe toute la largeur de sa colonne. Quand la fiche du heros est a cote (grand ecran) ou par-dessus
 * (vue classique), il tient en entier dans la hauteur de la fenetre ; quand elle est dessous, il en prend au plus 70 %.
 * En plein ecran (toute la zone de jeu, cartes tresor et inventaire compris), il est agrandi au maximum
 * en laissant la fiche du heros visible.
 * La resolution interne du canvas ne change pas : seul l'affichage est mis a l'echelle.
 */

	var PLATEAU_HAUTEUR_PAGE = 0.7, PLATEAU_MARGE = 16;

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

	function FicheACote(Colonne){					// fiche du heros a droite du plateau (grand ecran)
		return document.getElementById('CarteJoueurAventure').getBoundingClientRect().left >= Colonne.getBoundingClientRect().right;
	}

	function FicheParDessus(){						// vue classique : fiche cachee ou ouverte par-dessus le plateau
		return document.querySelector('.quest-grille').classList.contains('vue-classique');
	}

	function AjusterPlateau(){
		var Plateau = PlateauVisible(), Canvas = Plateau.tagName == 'CANVAS';
		Plateau.style.width = Plateau.style.height = Plateau.style.zoom = '';	// mesures a la taille d'origine
		var Largeur = Canvas ? Plateau.width : Plateau.offsetWidth;
		var Hauteur = Canvas ? Plateau.height : Plateau.offsetHeight;
		var Zone = ZoneDeJeu(), Colonne = Plateau.parentElement, Bordure = Plateau.offsetWidth - Plateau.clientWidth;
		var HauteurDispo;
		if (FicheACote(Colonne) || FicheParDessus()){
			// en plein ecran, sous le titre ; dans la page, le plateau doit tenir dans la fenetre
			HauteurDispo = EstPleinEcran() ? window.innerHeight - Colonne.getBoundingClientRect().top : window.innerHeight;
			HauteurDispo -= PLATEAU_MARGE;
		} else if (EstPleinEcran()){
			var Autres = HauteurContenu(Zone) - Plateau.getBoundingClientRect().height;	// titre, fiche du heros, boutons
			HauteurDispo = window.innerHeight - Autres - 30;
		} else {
			HauteurDispo = window.innerHeight * PLATEAU_HAUTEUR_PAGE;
		}
		var Echelle = Math.min((Colonne.clientWidth - Bordure) / Largeur, (HauteurDispo - Bordure) / Hauteur);
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
