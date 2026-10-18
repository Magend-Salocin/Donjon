/* Des du jeu : images, texte alternatif et animation de lancer. */

	var DES_DUREE_LANCER = 400, DES_INTERVALLE = 60;
	var DES_FACES_DEPLACEMENT = [1, 2, 3, 4, 5, 6];
	var DES_FACES_COMBAT = ['crane', 'bouclier-blanc', 'bouclier-noir'];
	var DES_TEXTES = { 'neutre': 'Dé non lancé', 'crane': 'Crâne', 'bouclier-blanc': 'Bouclier blanc', 'bouclier-noir': 'Bouclier noir' };

	function ImageDe(Face){							// Face : 1 a 6, 'neutre', 'crane', 'bouclier-blanc' ou 'bouclier-noir'
		return Chemin + '/dee/' + Face + '.svg';
	}

	function FaceCombat(Valeur){					// de de combat : 3 cranes, 2 boucliers blancs, 1 bouclier noir
		if (Valeur == 1 || Valeur == 3) { return 'bouclier-blanc'; }
		if (Valeur == 5) { return 'bouclier-noir'; }
		return 'crane';
	}

	function DesAnimes(){
		return !(window.matchMedia && window.matchMedia('(prefers-reduced-motion: reduce)').matches);
	}

	function ApresLancer(Action){					// execute Action une fois l'animation des des terminee
		window.setTimeout(Action, DesAnimes() ? DES_DUREE_LANCER : 0);
	}

	function ArreteDe(Img){
		window.clearInterval(Img.Lancer);
		Img.Lancer = null;
		Img.classList.remove('de-roule');
	}

	function AfficheDe(Img, Face){
		ArreteDe(Img);
		Img.src = ImageDe(Face);
		Img.alt = DES_TEXTES[Face] || ('Dé : ' + Face);
		Img.title = Img.alt;
	}

	function AnimerDe(Img, Faces, FaceFinale){		// fait defiler des faces au hasard puis montre FaceFinale
		if (!DesAnimes()) { AfficheDe(Img, FaceFinale); return; }
		ArreteDe(Img);
		Img.classList.add('de-roule');
		var Fin = Date.now() + DES_DUREE_LANCER;
		Img.Lancer = window.setInterval(function(){
			if (Date.now() >= Fin) { AfficheDe(Img, FaceFinale); return; }
			Img.src = ImageDe(Faces[Math.floor(Math.random() * Faces.length)]);
		}, DES_INTERVALLE);
	}

	function Pluriel(Nombre, Mot){
		return Nombre + ' ' + Mot + (Nombre > 1 ? 's' : '');
	}

	(function PrechargeDes(){						// evite un clignotement pendant la premiere animation
		var Faces = DES_FACES_DEPLACEMENT.concat(DES_FACES_COMBAT, ['neutre']);
		for (var i = 0; i < Faces.length; i++) { new Image().src = ImageDe(Faces[i]); }
	})();
