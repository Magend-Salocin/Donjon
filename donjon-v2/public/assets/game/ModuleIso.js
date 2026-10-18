	/*
	 * Vue isometrique du plateau, avec les graphismes du HeroQuest PC de Gremlin (1991) : iso/atlas.png et iso/atlas.js.
	 * Disponible pour les cartes importees (quest101 a quest124), qui decrivent murs (MesMurs), sols (MesZones)
	 * et meubles (MesObjets). Le moteur continue de jouer sur le tableau #board ; cette vue le redessine en continu.
	 *
	 * Case (x, y) : sommet haut du losange en ((x - y) * 24, (x + y) * 12). Seuls les murs du fond (cotes haut et gauche)
	 * sont dessines, comme dans le jeu d'origine, pour voir l'interieur des pieces.
	 */

	var Iso = {
		Actif: false,
		Planche: null,
		Canvas: null,
		Contexte: null,
		Visibles: CasesDevoilees,	// cases deja vues par le heros (ModuleActionJeu.js)
		ObjetsParCase: {},			// code HeroQuest de l'objet pose sur chaque case
		MeublesParCase: {},			// meuble dessine avec la case la plus en avant de son emprise
		Directions: [],				// derniere direction de chaque personnage : 'bas' ou 'haut', miroir ou non
		Camera: null,
		Combat: null				// dernier combat, affiche en gros plan pendant ISO_DUREE_COMBAT ms
	};

	var ISO_DUREE_COMBAT = 2200, ISO_ZOOM_COMBAT = 3;

	/* Chaque attaque (ModuleCombat.js) est memorisee pour le gros plan : combattants, vie avant et apres. */
	var UneAttaqueMoteur = UneAttaque;
	UneAttaque = function(IdMonstre, IdJoueurs, Mode){
		var Monstre = LesMonstres[IdMonstre], Heros = LesJoueurs[IdJoueurs];
		var VieAvant = Mode == 'JOUEUR' ? Monstre[4] : Heros[3];
		UneAttaqueMoteur(IdMonstre, IdJoueurs, Mode);
		Iso.Combat = {
			Monstre: Monstre, Heros: Heros, HerosAttaque: Mode == 'JOUEUR',
			Perte: VieAvant - (Mode == 'JOUEUR' ? Monstre[4] : Heros[3]), Debut: Date.now()
		};
	};

	var ISO_LARGEUR = 26, ISO_DEMI_X = 24, ISO_DEMI_Y = 12;
	var ISO_HAUT = 1, ISO_DROITE = 2, ISO_BAS = 4, ISO_GAUCHE = 8;
	var ISO_HEROS = { 'humain': 'guerrier', 'elfe': 'elfe', 'nain': 'nain', 'ogre': 'barbare' };
	var ISO_MONSTRES = {
		'Lutin': 'gobelin', 'Orc': 'orc', 'Femir': 'fimir', 'Gargouille': 'gargouille', 'GuerrierChaos': 'chaos',
		'ChamanOrc': 'orc', 'Squellette': 'squelette', 'Zombie': 'zombie', 'Momie': 'momie',
		'MageSquellette': 'squelette', 'Sorcier': 'chaos'
	};

	function IsoDisponible(){
		return typeof MesMurs != 'undefined' && typeof MesZones != 'undefined' && typeof IsoAtlas != 'undefined';
	}

	function IsoInitialiser(){
		if (!IsoDisponible()) { return; }
		Iso.Canvas = document.getElementById('board-iso');
		Iso.Contexte = Iso.Canvas.getContext('2d');
		Iso.Contexte.imageSmoothingEnabled = false;
		Iso.Planche = new Image();
		Iso.Planche.src = Chemin.replace('/images', '/iso/atlas.png');
		IsoPreparerObjets();
		document.getElementById('board-vue').style.display = '';
		var Preference = null;
		try { Preference = localStorage.getItem('donjon-vue'); } catch (e) {}
		IsoChoisirVue(Preference != 'dessus');
		window.requestAnimationFrame(IsoBoucle);
	}

	function IsoChoisirVue(Iso3D){
		Iso.Actif = Iso3D;
		Iso.Canvas.style.display = Iso3D ? '' : 'none';
		document.getElementById('board').style.display = Iso3D ? 'none' : '';
		document.getElementById('board-vue').textContent = Iso3D ? 'Vue de dessus' : 'Vue 3D';
		try { localStorage.setItem('donjon-vue', Iso3D ? '3d' : 'dessus'); } catch (e) {}
	}

	function IsoBasculerVue(){
		IsoChoisirVue(!Iso.Actif);
	}

	function IsoPreparerObjets(){
		for (var i = 0; i < MesObjets.length; i++){
			var Objet = MesObjets[i], Code = Objet[0], Cases = Objet.slice(1);
			var Avant = Cases[0];
			for (var j = 0; j < Cases.length; j++){
				Iso.ObjetsParCase[Cases[j]] = Code;
				if (IsoProfondeur(Cases[j]) > IsoProfondeur(Avant)) { Avant = Cases[j]; }
			}
			if (IsoAtlas['meuble' + Code.toString(16)]) { Iso.MeublesParCase[Avant] = Objet; }
		}
	}

	function IsoProfondeur(Case){
		return (Case % ISO_LARGEUR) + Math.floor(Case / ISO_LARGEUR) + (Case % ISO_LARGEUR) / 100;
	}

	/* Sommet haut du losange d'une case, en pixels du plateau. */
	function IsoPoint(Case){
		var x = Case % ISO_LARGEUR, y = Math.floor(Case / ISO_LARGEUR);
		return { x: (x - y) * ISO_DEMI_X, y: (x + y) * ISO_DEMI_Y };
	}

	function IsoDessiner(Nom, x, y, Miroir){
		var Zone = IsoAtlas[Nom];
		if (!Zone) { return; }
		var Ctx = Iso.Contexte;
		if (Miroir){
			Ctx.save();
			Ctx.translate(Math.round(x) + Zone[2], Math.round(y));
			Ctx.scale(-1, 1);
			Ctx.drawImage(Iso.Planche, Zone[0], Zone[1], Zone[2], Zone[3], 0, 0, Zone[2], Zone[3]);
			Ctx.restore();
			return;
		}
		Ctx.drawImage(Iso.Planche, Zone[0], Zone[1], Zone[2], Zone[3], Math.round(x), Math.round(y), Zone[2], Zone[3]);
	}

	function IsoBoucle(){
		if (Iso.Actif && Iso.Planche.complete) { IsoRendu(); }
		window.requestAnimationFrame(IsoBoucle);
	}

	function IsoRendu(){
		var Ctx = Iso.Contexte, Largeur = Iso.Canvas.width, Hauteur = Iso.Canvas.height;
		var Cible = IsoCibleCamera(Largeur, Hauteur);
		if (!Iso.Camera) { Iso.Camera = { x: Cible.x, y: Cible.y }; }
		Iso.Camera.x += (Cible.x - Iso.Camera.x) * 0.15;
		Iso.Camera.y += (Cible.y - Iso.Camera.y) * 0.15;

		Ctx.setTransform(1, 0, 0, 1, 0, 0);
		Ctx.fillStyle = '#0b0a14';
		Ctx.fillRect(0, 0, Largeur, Hauteur);
		Ctx.translate(Math.round(Largeur / 2 - Iso.Camera.x), Math.round(Hauteur / 2 + 20 - Iso.Camera.y));

		var Ordre = IsoOrdreDessin();
		for (var i = 0; i < Ordre.length; i++){ IsoSol(Ordre[i]); }
		var Personnages = IsoPersonnagesParCase();
		for (var j = 0; j < Ordre.length; j++){
			var Case = Ordre[j];
			IsoCotesDuFond(Case);
			if (Iso.MeublesParCase[Case] && Iso.Visibles[Case]) { IsoMeuble(Iso.MeublesParCase[Case]); }
			if (Personnages[Case]) { IsoPersonnage(Case, Personnages[Case]); }
		}
		if (Iso.Combat && Date.now() - Iso.Combat.Debut < ISO_DUREE_COMBAT) { IsoGrosPlanCombat(Largeur, Hauteur); }
	}

	/* Gros plan du combat : les deux combattants agrandis sur leurs dalles, les des et le resultat. */
	function IsoGrosPlanCombat(Largeur, Hauteur){
		var Ctx = Iso.Contexte, C = Iso.Combat, Z = ISO_ZOOM_COMBAT;
		var Ecoule = Date.now() - C.Debut;
		Ctx.setTransform(1, 0, 0, 1, 0, 0);
		Ctx.fillStyle = 'rgba(0, 0, 0, 0.78)';
		Ctx.fillRect(0, 0, Largeur, Hauteur);

		var Cx = Largeur / 2, Cy = Hauteur / 2 + 40;
		var CaseHeros = Number(C.Heros[5]), CaseMonstre = Number(C.Monstre[7]);
		var SolHeros = IsoSols[MesZones[CaseHeros]], SolMonstre = IsoSols[MesZones[CaseMonstre]];
		// Heros a gauche, monstre a droite, sur deux dalles voisines en diagonale.
		IsoDessinerZoom(SolHeros, Cx - 2 * ISO_DEMI_X * Z, Cy - ISO_DEMI_Y * Z, Z, false);
		IsoDessinerZoom(SolMonstre, Cx, Cy, Z, false);

		var Frappe = Math.floor(Ecoule / 150) % 4;			// animation de l'attaquant pendant la premiere seconde
		var Anime = Ecoule < 1200;
		var Race = String(C.Heros[12][20] || '').toLowerCase();
		var NomHeros = (ISO_HEROS[Race] || 'barbare') + (C.HerosAttaque && Anime ? [0, 1, 2, 1][Frappe] : 0);
		var NomMonstre = (ISO_MONSTRES[C.Monstre[0]] || 'orc') + (!C.HerosAttaque && Anime ? Frappe : 0);
		IsoPersonnageZoom(NomHeros, Cx - ISO_DEMI_X * Z, Cy, Z, true);
		IsoPersonnageZoom(NomMonstre, Cx + ISO_DEMI_X * Z, Cy + ISO_DEMI_Y * Z, Z, false);

		Ctx.font = 'bold 15px sans-serif';
		Ctx.textAlign = 'center';
		IsoTexte(C.Heros[0] + '  ' + C.Heros[3] + ' PV', Cx - 2 * ISO_DEMI_X * Z + 24, 34, '#f0d890');
		IsoTexte(C.Monstre[0] + '  ' + Math.max(0, C.Monstre[4]) + ' PV', Cx + 2 * ISO_DEMI_X * Z - 24, 34, '#e08070');
		IsoDes(C.HerosAttaque ? 'DA' : 'DD', Cx - 2 * ISO_DEMI_X * Z + 24, 50);
		IsoDes(C.HerosAttaque ? 'DD' : 'DA', Cx + 2 * ISO_DEMI_X * Z - 24, 50);

		if (Ecoule > 700){
			var Cible = C.HerosAttaque ? C.Monstre[0] : C.Heros[0];
			var Message = C.Perte > 0 ? Cible + ' perd ' + C.Perte + ' point' + (C.Perte > 1 ? 's' : '') + ' de vie' : 'Coup paré !';
			if (C.HerosAttaque && C.Monstre[8] == -1) { Message = C.Monstre[0] + ' est vaincu !'; }
			Ctx.font = 'bold 20px sans-serif';
			IsoTexte(Message, Cx, Hauteur - 24, C.Perte > 0 ? '#ff5040' : '#d0d0d0');
		}
	}

	/* Des du dernier lancer, lus dans les images DA0-7 (attaque) ou DD0-7 (defense) du moteur. */
	function IsoDes(Prefixe, Centre, y){
		var Des = [];
		for (var i = 0; i < 8; i++){
			var Image = document.getElementById(Prefixe + i);
			if (Image && Image.className != 'Cache' && Image.complete && Image.naturalWidth) { Des.push(Image); }
		}
		var Taille = 30, x = Centre - (Des.length * (Taille + 4)) / 2;
		for (var j = 0; j < Des.length; j++){ Iso.Contexte.drawImage(Des[j], x + j * (Taille + 4), y, Taille, Taille); }
	}

	function IsoTexte(Texte, x, y, Couleur){
		var Ctx = Iso.Contexte;
		Ctx.fillStyle = '#000';
		Ctx.fillText(Texte, x + 2, y + 2);
		Ctx.fillStyle = Couleur;
		Ctx.fillText(Texte, x, y);
	}

	/* Image agrandie, (x, y) = coin haut gauche. */
	function IsoDessinerZoom(Nom, x, y, Z, Miroir){
		var Zone = IsoAtlas[Nom];
		if (!Zone) { return; }
		var Ctx = Iso.Contexte;
		Ctx.save();
		Ctx.translate(Math.round(x) + (Miroir ? Zone[2] * Z : 0), Math.round(y));
		Ctx.scale(Miroir ? -Z : Z, Z);
		Ctx.drawImage(Iso.Planche, Zone[0], Zone[1], Zone[2], Zone[3], 0, 0, Zone[2], Zone[3]);
		Ctx.restore();
	}

	/* Personnage agrandi, pieds au centre de la dalle dont le centre est (x, y). */
	function IsoPersonnageZoom(Nom, x, y, Z, Miroir){
		var Zone = IsoAtlas[Nom];
		if (!Zone) { return; }
		IsoDessinerZoom(Nom, x - Zone[2] * Z / 2, y + 4 * Z - Zone[3] * Z, Z, Miroir);
	}

	/* La camera suit le heros sans sortir des cases devoilees (marge d'une case). */
	function IsoCibleCamera(Largeur, Hauteur){
		var Cible = IsoPoint(Number(LesJoueurs[ConstIdJoueur][5]));
		var Gauche = Infinity, Droite = -Infinity, Haut = Infinity, Bas = -Infinity;
		for (var Case in Iso.Visibles){
			var P = IsoPoint(Number(Case));
			Gauche = Math.min(Gauche, P.x); Droite = Math.max(Droite, P.x);
			Haut = Math.min(Haut, P.y); Bas = Math.max(Bas, P.y);
		}
		if (Gauche == Infinity) { return Cible; }
		var MargeX = Largeur / 2 - 2 * ISO_DEMI_X, MargeY = Hauteur / 2 - 4 * ISO_DEMI_Y;
		return {
			x: Droite - Gauche < 2 * MargeX ? (Gauche + Droite) / 2 : Math.max(Gauche + MargeX, Math.min(Droite - MargeX, Cible.x)),
			y: Bas - Haut < 2 * MargeY ? (Haut + Bas) / 2 : Math.max(Haut + MargeY, Math.min(Bas - MargeY, Cible.y))
		};
	}

	/* Cases de la carte, du fond vers l'avant. */
	function IsoOrdreDessin(){
		if (!Iso.Ordre){
			Iso.Ordre = [];
			for (var Case = 0; Case < MesPieces.length; Case++){ if (MesZones[Case]) { Iso.Ordre.push(Case); } }
			Iso.Ordre.sort(function(a, b){ return IsoProfondeur(a) - IsoProfondeur(b); });
		}
		return Iso.Ordre;
	}

	function IsoSol(Case){
		if (!Iso.Visibles[Case]) { return; }
		var Code = Iso.ObjetsParCase[Case];
		var Nom = (Code && IsoSolsSpeciaux[Code]) || IsoSols[MesZones[Case]];
		var P = IsoPoint(Case);
		IsoDessiner(Nom, P.x - ISO_DEMI_X, P.y);
	}

	/* Porte entre deux cases voisines : pieces differentes reliees sans mur. */
	function IsoPorte(Case, Voisin, Cote){
		return Voisin >= 0 && Voisin < MesPieces.length && MesPieces[Voisin] != '0'
			&& MesPieces[Voisin] != MesPieces[Case] && !(MesMurs[Case] & Cote);
	}

	/* Murs et portes des cotes haut (\) et gauche (/) de la case. Une porte s'ouvre quand ses deux cotes sont devoiles. */
	function IsoCotesDuFond(Case){
		var P = IsoPoint(Case), Variante = (Case % 2);
		var Cotes = [
			{ Bit: ISO_HAUT, Voisin: Case - ISO_LARGEUR, Mur: 'mur' + (2 + Variante), Porte: 1, x: P.x, y: P.y },
			{ Bit: ISO_GAUCHE, Voisin: (Case % ISO_LARGEUR) ? Case - 1 : -1, Mur: 'mur' + Variante, Porte: 0, x: P.x - ISO_DEMI_X, y: P.y + ISO_DEMI_Y }
		];
		for (var i = 0; i < Cotes.length; i++){
			var C = Cotes[i];
			if (IsoPorte(Case, C.Voisin, C.Bit)){
				if (!Iso.Visibles[Case] && !Iso.Visibles[C.Voisin]) { continue; }
				var Ouverte = Iso.Visibles[Case] && Iso.Visibles[C.Voisin];
				var Bas = C.Porte ? 34 : 43;
				IsoDessiner('porte' + (C.Porte + (Ouverte ? 6 : 0)), C.x, (C.Porte ? P.y : P.y + ISO_DEMI_Y) - Bas);
			}
			else if ((MesMurs[Case] & C.Bit) && Iso.Visibles[Case]){
				IsoDessiner(C.Mur, C.x, (C.Porte ? P.y : P.y + ISO_DEMI_Y) - (C.Porte ? 39 : 51));
			}
		}
	}

	/* Meuble centre sur son emprise, pose sur la pointe avant de celle-ci. */
	function IsoMeuble(Objet){
		var Nom = 'meuble' + Objet[0].toString(16), Zone = IsoAtlas[Nom];
		var Gauche = Infinity, Droite = -Infinity, Bas = -Infinity, Haut = Infinity;
		for (var i = 1; i < Objet.length; i++){
			var P = IsoPoint(Objet[i]);
			Gauche = Math.min(Gauche, P.x - ISO_DEMI_X); Droite = Math.max(Droite, P.x + ISO_DEMI_X);
			Haut = Math.min(Haut, P.y); Bas = Math.max(Bas, P.y + 2 * ISO_DEMI_Y);
		}
		var Centre = (Gauche + Droite) / 2;
		IsoDessiner(Nom, Centre - Zone[2] / 2, Math.min(Bas - 4, (Haut + Bas) / 2 + Zone[3] / 2) - Zone[3]);
	}

	function IsoPersonnagesParCase(){
		var Liste = {};
		for (var i = 0; i < LesMonstres.length; i++){
			if (LesMonstres[i][8] == 1 && Iso.Visibles[LesMonstres[i][7]]) { Liste[Number(LesMonstres[i][7])] = { Monstre: LesMonstres[i], Cle: 'm' + i }; }
		}
		for (var j = 0; j < LesJoueurs.length; j++){
			Liste[Number(LesJoueurs[j][5])] = { Heros: LesJoueurs[j], Cle: 'h' + j };
		}
		return Liste;
	}

	/* Direction memorisee a partir du dernier deplacement : de face (bas) ou de dos (haut), en miroir pour l'autre diagonale. */
	function IsoDirection(Cle, Case){
		var D = Iso.Directions[Cle] || { Case: Case, Haut: false, Miroir: false };
		var Ecart = Case - D.Case;
		if (Ecart == ISO_LARGEUR) { D.Haut = false; D.Miroir = false; }
		if (Ecart == 1) { D.Haut = false; D.Miroir = true; }
		if (Ecart == -ISO_LARGEUR) { D.Haut = true; D.Miroir = true; }
		if (Ecart == -1) { D.Haut = true; D.Miroir = false; }
		D.Case = Case;
		Iso.Directions[Cle] = D;
		return D;
	}

	function IsoPersonnage(Case, Qui){
		var P = IsoPoint(Case), D = IsoDirection(Qui.Cle, Case), Nom;
		if (Qui.Heros){
			var Race = String(Qui.Heros[12][20] || '').toLowerCase();
			Nom = (ISO_HEROS[Race] || 'barbare') + (D.Haut ? 6 : 0);
		}
		else {
			Nom = (ISO_MONSTRES[Qui.Monstre[0]] || 'orc') + '0';
		}
		var Zone = IsoAtlas[Nom];
		IsoDessiner(Nom, P.x - Zone[2] / 2, P.y + ISO_DEMI_Y + 4 - Zone[3], D.Miroir);
	}

	window.addEventListener('load', IsoInitialiser);
