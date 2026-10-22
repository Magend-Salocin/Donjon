	/*
	 * Vue isometrique du plateau, avec des graphismes redessines d'apres le HeroQuest PC de Gremlin (1991) : iso/atlas.png
	 * et iso/atlas.js (bin/construire-atlas-iso.py). Les personnages marchent d'une case a l'autre ; en combat, l'attaquant
	 * frappe et le defenseur recule ou tombe, quand leur planche d'animations a ces images (sinon : image de repos).
	 * Disponible pour les cartes importees (quest101 a quest124), qui decrivent murs (MesMurs), sols (MesZones)
	 * et meubles (MesObjets). Le moteur continue de jouer sur le tableau #board ; cette vue le redessine en continu.
	 *
	 * Case (x, y) : sommet haut du losange en ((x - y) * 24, (x + y) * 12). Seuls les murs du fond (cotes haut et gauche)
	 * sont dessines, comme dans le jeu d'origine, pour voir l'interieur des pieces.
	 *
	 * Trois vues : '3d' (tout ce qui est devoile, camera qui suit le heros), 'classique' (comme le jeu d'origine :
	 * seulement la piece ou le bout de couloir du heros, pose sur le livre, avec le portrait et les icones d'action),
	 * 'dessus' (le tableau #board de 2009).
	 */

	var Iso = {
		Actif: false,
		Vue: '3d',
		Montrees: null,				// cases a dessiner : les cases devoilees, ou la zone du heros en vue classique
		Planche: null,
		Livre: null,
		Canvas: null,
		Contexte: null,
		Visibles: CasesDevoilees,	// cases deja vues par le heros (ModuleActionJeu.js)
		ObjetsParCase: {},			// code HeroQuest de l'objet pose sur chaque case
		MeublesParCase: {},			// meuble dessine avec la case la plus en avant de son emprise
		Directions: [],				// derniere direction de chaque personnage : 'bas' ou 'haut', miroir ou non
		Camera: null,
		Combat: null,				// dernier combat, affiche en gros plan pendant ISO_DUREE_COMBAT ms
		VueAvantTourMonstre: null
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

	var ISO_DUREE_PAS = 240;					// glissement d'une case a la voisine, avec les 3 images de marche
	var ISO_FIN_FRAPPE = [150, 300, 600];		// gros plan : fin des images attaque0, attaque1, attaque2 (ms)
	var ISO_IMPACT = 450, ISO_FIN_TOUCHE = 1100;	// gros plan : reaction du defenseur (ms)
	var ISO_FIN_CHUTE = [750, 1000];				// gros plan : fin des images mort0, mort1 ; puis mort2

	/* Prefixe des images du heros dans l'atlas : type et sexe (barbare-h, elfe-f...). */
	function IsoNomHeros(Heros){
		var Nom = Heros[12][23] + '-' + String(Heros[12][31] || 'H').toLowerCase();
		return IsoAtlas[Nom + '-repos'] ? Nom : 'barbare-h';
	}

	/* Image d'une animation (repos, marche0, attaque2, touche, mort2, dos-marche1...) d'un personnage.
	   Une image absente est remplacee par la precedente de l'animation (mort2 par mort1), sinon par le repos
	   (de dos si possible) : un personnage sans planche d'animations n'a que quelques images. */
	function IsoImage(Base, Animation){
		var Noms = [Base + '-' + Animation], Numero = Animation.match(/^(.*\D)(\d)$/);
		for (var n = Numero ? Number(Numero[2]) - 1 : -1; n >= 0; n--){ Noms.push(Base + '-' + Numero[1] + n); }
		Noms.push(Base + (Animation.indexOf('dos-') == 0 ? '-dos-repos' : '-repos'), Base + '-repos');
		for (var i = 0; i < Noms.length; i++){ if (IsoAtlas[Noms[i]]) { return Noms[i]; } }
		return Base + '-repos';
	}

	function IsoDisponible(){
		return typeof MesMurs != 'undefined' && typeof MesZones != 'undefined' && typeof IsoAtlas != 'undefined';
	}

	function IsoInitialiser(){
		if (!IsoDisponible()) { return; }
		Iso.Canvas = document.getElementById('board-iso');
		Iso.Contexte = Iso.Canvas.getContext('2d');
		Iso.Planche = new Image();
		Iso.Planche.src = Chemin.replace('/images', '/iso/atlas.png');
		Iso.Livre = new Image();
		Iso.Livre.src = Chemin.replace('/images', '/iso/livre.jpg');
		IsoPreparerObjets();
		Iso.Canvas.addEventListener('click', IsoClic);
		Iso.Canvas.addEventListener('mousemove', IsoSurvol);
		document.getElementById('board-vue').style.display = '';
		var Preference = null;
		try { Preference = localStorage.getItem('donjon-vue'); } catch (e) {}
		IsoChoisirVue(ISO_VUES[Preference] ? Preference : '3d');
		window.requestAnimationFrame(IsoBoucle);
	}

	/* Largeur et Hauteur : taille logique du canvas. Finesse : pixels du canvas par pixel logique (la vue classique est
	   deux fois plus fine pour afficher iso/livre.jpg, 1280 x 800, sans le reduire). */
	var ISO_VUES = {
		'3d': { Suivante: 'classique', Nom: 'Vue 3D', Largeur: 728, Hauteur: 460, Finesse: 1 },
		'classique': { Suivante: 'dessus', Nom: 'Vue classique', Largeur: 640, Hauteur: 400, Finesse: 2 },
		'dessus': { Suivante: '3d', Nom: 'Vue de dessus' }
	};

	function IsoChoisirVue(Vue){
		var Choix = ISO_VUES[Vue];
		Iso.Vue = Vue;
		Iso.Actif = Vue != 'dessus';
		Iso.Camera = null;
		if (Iso.Actif){
			Iso.Finesse = Choix.Finesse;
			Iso.Canvas.width = Choix.Largeur * Choix.Finesse;
			Iso.Canvas.height = Choix.Hauteur * Choix.Finesse;
			Iso.Contexte.imageSmoothingQuality = 'high';	// l'atlas est a IsoEchelle fois la taille du plateau
		}
		Iso.Canvas.style.display = Iso.Actif ? '' : 'none';
		document.querySelector('.quest-grille').classList.toggle('vue-classique', Vue == 'classique');
		document.getElementById('fiche-heros').style.display = Vue == 'classique' ? '' : 'none';
		IsoOuvrirFiche(false);
		document.getElementById('board').style.display = Iso.Actif ? 'none' : '';
		document.getElementById('board-vue').textContent = Choix.Nom + ' (changer : ' + ISO_VUES[Choix.Suivante].Nom.toLowerCase() + ')';
		try { localStorage.setItem('donjon-vue', Vue); } catch (e) {}
		AjusterPlateau();							// ModulePleinEcran.js : taille d'affichage de la nouvelle vue
	}

	/* Vue classique : la fiche du heros, cachee, s'ouvre par-dessus le plateau (game.css). */
	function IsoOuvrirFiche(Ouverte){
		document.querySelector('.quest-grille').classList.toggle('fiche-ouverte', Ouverte);
		var Bouton = document.getElementById('fiche-heros');
		Bouton.setAttribute('aria-expanded', Ouverte);
		Bouton.textContent = Ouverte ? 'Cacher la fiche du héros' : 'Fiche du héros';
	}

	function IsoBasculerFiche(){
		IsoOuvrirFiche(!document.querySelector('.quest-grille').classList.contains('fiche-ouverte'));
	}

	function IsoBasculerVue(){
		IsoChoisirVue(ISO_VUES[Iso.Vue].Suivante);
	}

	function IsoDebuterTourMonstre(){
		//if (!IsoDisponible() || !Iso.Canvas) { return; }
		Iso.VueAvantTourMonstre = Iso.Vue;
		IsoChoisirVue('dessus');
	}

	function IsoTerminerTourMonstre(){
		if (Iso.VueAvantTourMonstre === null) { return; }
		var Vue = Iso.VueAvantTourMonstre;
		Iso.VueAvantTourMonstre = null;
		IsoChoisirVue(Vue);
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
			Ctx.drawImage(Iso.Planche, Zone[0], Zone[1], Zone[2] * IsoEchelle, Zone[3] * IsoEchelle, 0, 0, Zone[2], Zone[3]);
			Ctx.restore();
			return;
		}
		Ctx.drawImage(Iso.Planche, Zone[0], Zone[1], Zone[2] * IsoEchelle, Zone[3] * IsoEchelle, Math.round(x), Math.round(y), Zone[2], Zone[3]);
	}

	function IsoBoucle(){
		if (Iso.Actif && Iso.Planche.complete && Iso.Livre.complete){
			if (Iso.Vue == 'classique') { IsoRenduClassique(); } else { IsoRendu(); }
		}
		window.requestAnimationFrame(IsoBoucle);
	}

	function IsoRendu(){
		var Ctx = Iso.Contexte, Largeur = Iso.Canvas.width, Hauteur = Iso.Canvas.height;
		Iso.Montrees = Iso.Visibles;
		var Cible = IsoCibleCamera(Largeur, Hauteur);
		if (!Iso.Camera) { Iso.Camera = { x: Cible.x, y: Cible.y }; }
		Iso.Camera.x += (Cible.x - Iso.Camera.x) * 0.15;
		Iso.Camera.y += (Cible.y - Iso.Camera.y) * 0.15;

		Ctx.setTransform(1, 0, 0, 1, 0, 0);
		Ctx.fillStyle = '#0b0a14';
		Ctx.fillRect(0, 0, Largeur, Hauteur);
		Ctx.translate(Math.round(Largeur / 2 - Iso.Camera.x), Math.round(Hauteur / 2 + 20 - Iso.Camera.y));

		IsoDessinerCases();
		if (Iso.Combat && Date.now() - Iso.Combat.Debut < ISO_DUREE_COMBAT) { IsoGrosPlanCombat(Largeur, Hauteur); }
	}

	/* Sols, puis du fond vers l'avant : murs, meubles et personnages des cases de Iso.Montrees. */
	function IsoDessinerCases(){
		var Ordre = IsoOrdreDessin();
		for (var i = 0; i < Ordre.length; i++){ IsoSol(Ordre[i]); }
		var Personnages = IsoPersonnagesParCase();
		for (var j = 0; j < Ordre.length; j++){
			var Case = Ordre[j];
			IsoCotesDuFond(Case);
			if (Iso.MeublesParCase[Case] && Iso.Montrees[Case]) { IsoMeuble(Iso.MeublesParCase[Case]); }
			if (Personnages[Case]) { IsoPersonnage(Case, Personnages[Case]); }
		}
	}

	/* ---- Vue classique : ecran 320 x 200 du jeu d'origine, agrandi deux fois ---- */

	var ISO_CENTRE_LIVRE = { x: 160, y: 118 };		// milieu du dessus du livre (BOOK.VGA)
	var ISO_RAYON_COULOIR = 4;						// cases de couloir montrees autour du heros

	/* Icones d'action sur la tranche du livre : image, lien du moteur (Mn_*), action. */
	var ISO_ACTIONS = [
		{ Icone: 'deplacement', Lien: 'Mn_Deplacement', Action: function(){ Lancerdee(); }, Titre: 'Lancer les dés' },
		{ Icone: 'attaque', Lien: 'Mn_Attaquer', Action: function(){ LancerdeeAttaque(); }, Titre: 'Attaquer' },
		{ Icone: 'tresor', Lien: 'Mn_Tresor', Action: function(){ TirerUneCarteTresor(); }, Titre: 'Chercher un trésor' },
		{ Icone: 'piege', Lien: 'Mn_Piege', Action: function(){ DeactiverLesPieges(); }, Titre: 'Chercher les pièges' },
		{ Icone: 'objet', Lien: 'Mn_Objet', Action: function(){ AfficherElement('myHeroItem'); }, Titre: 'Utiliser un objet' },
		{ Icone: 'fin', Lien: 'Mn_FinTour', Action: function(){ FinTour(); }, Titre: 'Fin de tour' }
	];

	function IsoPositionAction(Index){
		return { x: 6 + Index * 20, y: 178 };
	}

	function IsoRenduClassique(){
		var Ctx = Iso.Contexte;
		var Heros = LesJoueurs[ConstIdJoueur];
		Iso.Montrees = IsoZoneDuHeros(Number(Heros[5]));

		var Echelle = 2 * Iso.Finesse;					// ecran de 320 x 200
		Ctx.setTransform(Echelle, 0, 0, Echelle, 0, 0);
		Ctx.drawImage(Iso.Livre, 0, 0, 320, 200);

		var Gauche = Infinity, Droite = -Infinity, Haut = Infinity, Bas = -Infinity;
		for (var Case in Iso.Montrees){
			var P = IsoPoint(Number(Case));
			Gauche = Math.min(Gauche, P.x - ISO_DEMI_X); Droite = Math.max(Droite, P.x + ISO_DEMI_X);
			Haut = Math.min(Haut, P.y); Bas = Math.max(Bas, P.y + 2 * ISO_DEMI_Y);
		}
		Ctx.translate(Math.round(ISO_CENTRE_LIVRE.x - (Gauche + Droite) / 2), Math.round(ISO_CENTRE_LIVRE.y - (Haut + Bas) / 2));
		IsoDessinerCases();

		Ctx.setTransform(Echelle, 0, 0, Echelle, 0, 0);
		IsoPanneau(Heros);
		if (Iso.Combat && Date.now() - Iso.Combat.Debut < ISO_DUREE_COMBAT){
			IsoGrosPlanCombat(Iso.Canvas.width / Iso.Finesse, Iso.Canvas.height / Iso.Finesse);
		}
	}

	/* Piece du heros, ou cases de son couloir a moins de ISO_RAYON_COULOIR cases (les couloirs forment une seule zone). */
	function IsoZoneDuHeros(CaseHeros){
		var Zone = {}, Piece = MesPieces[CaseHeros], Hx = CaseHeros % ISO_LARGEUR, Hy = Math.floor(CaseHeros / ISO_LARGEUR);
		var Couloir = MesZones[CaseHeros] <= 20;
		for (var Case = 0; Case < MesPieces.length; Case++){
			if (MesPieces[Case] != Piece) { continue; }
			var Dx = Math.abs(Case % ISO_LARGEUR - Hx), Dy = Math.abs(Math.floor(Case / ISO_LARGEUR) - Hy);
			if (!Couloir || (Dx <= ISO_RAYON_COULOIR && Dy <= ISO_RAYON_COULOIR)) { Zone[Case] = true; }
		}
		return Zone;
	}

	/* Portrait, caracteristiques et icones d'action, aux positions de l'ecran d'origine (portrait en 0,12). */
	function IsoPanneau(Heros){
		var Ctx = Iso.Contexte;
		IsoDessiner('portrait-' + IsoNomHeros(Heros), 2, 12);
		Ctx.strokeStyle = '#c8a040';
		Ctx.lineWidth = 1;
		Ctx.strokeRect(1.5, 11.5, 34, 47);
		Ctx.font = 'bold 8px monospace';
		Ctx.textAlign = 'left';
		IsoTexte(String(Heros[0]).toUpperCase(), 2, 8, '#e8c060');
		IsoTexte('PV ' + Heros[3], 2, 68, '#e8c060');

		var Caracteristiques = [
			['or', 40, 11, Heros[10]], ['bras', 96, 11, Heros[1]],
			['bottes', 40, 30, MovementJoueur], ['bouclier', 96, 30, Heros[2]]
		];
		Ctx.font = 'bold 10px monospace';
		for (var i = 0; i < Caracteristiques.length; i++){
			var C = Caracteristiques[i];
			IsoDessiner('icone-' + C[0], C[1], C[2]);
			IsoTexte(String(C[3]), C[1] + 19, C[2] + 12, '#e8c060');
		}

		for (var j = 0; j < ISO_ACTIONS.length; j++){
			var A = ISO_ACTIONS[j], P = IsoPositionAction(j);
			var Lien = document.getElementById(A.Lien);
			var Jouee = Lien && Lien.classList.contains('action-jouee');
			Ctx.fillStyle = 'rgba(0, 0, 0, 0.55)';
			Ctx.fillRect(P.x - 1, P.y - 1, 18, 18);
			IsoDessiner('icone-' + A.Icone + (Jouee && IsoAtlas['icone-' + A.Icone + '-grise'] ? '-grise' : ''), P.x, P.y);
			if (Iso.Survol === j){
				Ctx.strokeStyle = '#ffe080';
				Ctx.strokeRect(P.x - 1.5, P.y - 1.5, 19, 19);
			}
		}
		if (Iso.Survol !== null && Iso.Survol !== undefined){
			Ctx.font = 'bold 8px sans-serif';
			IsoTexte(ISO_ACTIONS[Iso.Survol].Titre, 6, 172, '#ffe080');
		}
	}

	function IsoActionSous(Evenement){
		var Rect = Iso.Canvas.getBoundingClientRect();
		var x = (Evenement.clientX - Rect.left) * 320 / Rect.width, y = (Evenement.clientY - Rect.top) * 200 / Rect.height;
		for (var i = 0; i < ISO_ACTIONS.length; i++){
			var P = IsoPositionAction(i);
			if (x >= P.x && x < P.x + 16 && y >= P.y && y < P.y + 16) { return i; }
		}
		return null;
	}

	function IsoClic(Evenement){
		if (Iso.Vue != 'classique') { return; }
		var Index = IsoActionSous(Evenement);
		if (Index !== null) { ISO_ACTIONS[Index].Action(); }
	}

	function IsoSurvol(Evenement){
		Iso.Survol = Iso.Vue == 'classique' ? IsoActionSous(Evenement) : null;
		Iso.Canvas.style.cursor = Iso.Survol !== null ? 'pointer' : '';
	}

	/* Gros plan : l'attaquant frappe une fois (3 images), puis revient au repos. */
	function IsoAnimationAttaquant(Ecoule){
		for (var i = 0; i < ISO_FIN_FRAPPE.length; i++){ if (Ecoule < ISO_FIN_FRAPPE[i]) { return 'attaque' + i; } }
		return 'repos';
	}

	/* Gros plan : au moment du coup, le defenseur tombe s'il meurt, recule s'il perd des points de vie. */
	function IsoAnimationDefenseur(Ecoule, Perte, Mort){
		if (Ecoule < ISO_IMPACT) { return 'repos'; }
		if (Mort){
			for (var i = 0; i < ISO_FIN_CHUTE.length; i++){ if (Ecoule < ISO_FIN_CHUTE[i]) { return 'mort' + i; } }
			return 'mort' + ISO_FIN_CHUTE.length;
		}
		return Perte > 0 && Ecoule < ISO_FIN_TOUCHE ? 'touche' : 'repos';
	}

	/* Gros plan du combat : les deux combattants agrandis sur leurs dalles, les des et le resultat. */
	function IsoGrosPlanCombat(Largeur, Hauteur){
		var Ctx = Iso.Contexte, C = Iso.Combat, Z = ISO_ZOOM_COMBAT;
		var Ecoule = Date.now() - C.Debut;
		Ctx.setTransform(Iso.Finesse, 0, 0, Iso.Finesse, 0, 0);		// Largeur, Hauteur : taille logique du canvas
		Ctx.fillStyle = 'rgba(0, 0, 0, 0.78)';
		Ctx.fillRect(0, 0, Largeur, Hauteur);

		var Cx = Largeur / 2, Cy = Hauteur / 2 + 40;
		var CaseHeros = Number(C.Heros[5]), CaseMonstre = Number(C.Monstre[7]);
		var SolHeros = IsoSols[MesZones[CaseHeros]], SolMonstre = IsoSols[MesZones[CaseMonstre]];
		// Heros a gauche, monstre a droite, sur deux dalles voisines en diagonale.
		IsoDessinerZoom(SolHeros, Cx - 2 * ISO_DEMI_X * Z, Cy - ISO_DEMI_Y * Z, Z, false);
		IsoDessinerZoom(SolMonstre, Cx, Cy, Z, false);

		var Mort = C.HerosAttaque ? C.Monstre[8] == -1 : C.Heros[3] < 1;
		var Attaquant = IsoAnimationAttaquant(Ecoule), Defenseur = IsoAnimationDefenseur(Ecoule, C.Perte, Mort);
		var NomHeros = IsoImage(IsoNomHeros(C.Heros), C.HerosAttaque ? Attaquant : Defenseur);
		var NomMonstre = IsoImage(SpriteMonstre(C.Monstre), C.HerosAttaque ? Defenseur : Attaquant);
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
			if (Image && !Image.classList.contains('Cache') && Image.complete && Image.naturalWidth) { Des.push(Image); }
		}
		var Taille = 30, x = Centre - (Des.length * (Taille + 4)) / 2;
		for (var j = 0; j < Des.length; j++){
			// Comme dans la fenetre de combat : les des qui ne comptent pas sont estompes une fois arretes.
			var Estompe = Des[j].classList.contains('de-ignore') && !Des[j].classList.contains('de-roule');
			Iso.Contexte.globalAlpha = Estompe ? 0.4 : 1;
			Iso.Contexte.drawImage(Des[j], x + j * (Taille + 4), y, Taille, Taille);
		}
		Iso.Contexte.globalAlpha = 1;
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
		Ctx.drawImage(Iso.Planche, Zone[0], Zone[1], Zone[2] * IsoEchelle, Zone[3] * IsoEchelle, 0, 0, Zone[2], Zone[3]);
		Ctx.restore();
	}

	/* Personnage agrandi, pieds au centre de la dalle dont le centre est (x, y). */
	function IsoPersonnageZoom(Nom, x, y, Z, Miroir){
		var Zone = IsoAtlas[Nom];
		if (!Zone) { return; }
		IsoDessinerZoom(Nom, x - Zone[2] * Z / 2, y + 4 * Z - Zone[3] * Z, Z, Miroir);
	}

	/* La camera suit le heros sans sortir des cases devoilees (marge d'une case). Elle vise sa position pendant un pas,
	   pas sa case d'arrivee : sinon elle le depasse et il semble reculer a l'ecran. */
	function IsoCibleCamera(Largeur, Hauteur){
		var D = Iso.Directions['h' + ConstIdJoueur];
		var Cible = D ? IsoPosition(D) : IsoPoint(Number(LesJoueurs[ConstIdJoueur][5]));
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
		if (!Iso.Montrees[Case]) { return; }
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
				if (!Iso.Montrees[Case] && !Iso.Montrees[C.Voisin]) { continue; }
				var Ouverte = Iso.Visibles[Case] && Iso.Visibles[C.Voisin];
				var Bas = C.Porte ? 34 : 43;
				IsoDessiner('porte' + (C.Porte + (Ouverte ? 6 : 0)), C.x, (C.Porte ? P.y : P.y + ISO_DEMI_Y) - Bas);
			}
			else if ((MesMurs[Case] & C.Bit) && Iso.Montrees[Case]){
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

	/* Personnages a dessiner, par case. Pendant un pas, le personnage est dessine avec la plus en avant des deux cases :
	   il passe ainsi devant les murs et les meubles de l'autre. */
	function IsoPersonnagesParCase(){
		var Liste = {};
		function Placer(Case, Qui){
			Qui.Direction = IsoDirection(Qui.Cle, Case);
			var Depart = Qui.Direction.Depart;
			Liste[IsoEnMarche(Qui.Direction) && IsoProfondeur(Depart) > IsoProfondeur(Case) ? Depart : Case] = Qui;
		}
		for (var i = 0; i < LesMonstres.length; i++){
			if (LesMonstres[i][8] == 1 && Iso.Montrees[LesMonstres[i][7]]) { Placer(Number(LesMonstres[i][7]), { Monstre: LesMonstres[i], Cle: 'm' + i }); }
		}
		for (var j = 0; j < LesJoueurs.length; j++){
			Placer(Number(LesJoueurs[j][5]), { Heros: LesJoueurs[j], Cle: 'h' + j });
		}
		return Liste;
	}

	/* Direction et pas en cours, a partir du dernier deplacement : de face (bas) ou de dos (haut), en miroir pour l'autre
	   diagonale. Un pas vers une case voisine glisse pendant ISO_DUREE_PAS ms ; un saut plus long est immediat. */
	function IsoDirection(Cle, Case){
		var D = Iso.Directions[Cle] || { Case: Case, Depart: Case, Debut: 0, Pas: 0, Haut: false, Miroir: false };
		var Ecart = Case - D.Case;
		if (Ecart){
			if (Ecart == ISO_LARGEUR) { D.Haut = false; D.Miroir = false; }
			if (Ecart == 1) { D.Haut = false; D.Miroir = true; }
			if (Ecart == -ISO_LARGEUR) { D.Haut = true; D.Miroir = true; }
			if (Ecart == -1) { D.Haut = true; D.Miroir = false; }
			var Voisine = Ecart == 1 || Ecart == -1 || Ecart == ISO_LARGEUR || Ecart == -ISO_LARGEUR;
			D.Depart = Voisine ? D.Case : Case;
			D.Debut = Date.now();
			D.Pas++;
			D.Case = Case;
		}
		Iso.Directions[Cle] = D;
		return D;
	}

	function IsoEnMarche(D){
		return D.Depart != D.Case && Date.now() - D.Debut < ISO_DUREE_PAS;
	}

	/* Part du pas deja faite (0 a 1), 1 au repos. */
	function IsoAvance(D){
		return IsoEnMarche(D) ? (Date.now() - D.Debut) / ISO_DUREE_PAS : 1;
	}

	/* Position du personnage : sa case, ou entre l'ancienne et la nouvelle pendant un pas. */
	function IsoPosition(D){
		var Avance = IsoAvance(D), A = IsoPoint(D.Depart), P = IsoPoint(D.Case);
		return { x: A.x + (P.x - A.x) * Avance, y: A.y + (P.y - A.y) * Avance };
	}

	/* Au repos sur sa case, ou en train de glisser vers elle avec les images de marche (jambes alternees d'un pas a l'autre). */
	function IsoPersonnage(Case, Qui){
		var D = Qui.Direction, P = IsoPosition(D), Animation = 'repos';
		if (IsoEnMarche(D)){
			var Image = Math.min(2, Math.floor(IsoAvance(D) * 3));
			Animation = 'marche' + (D.Pas % 2 ? 2 - Image : Image);
		}
		var Base = Qui.Heros ? IsoNomHeros(Qui.Heros) : SpriteMonstre(Qui.Monstre);
		var Nom = IsoImage(Base, (D.Haut ? 'dos-' : '') + Animation), Zone = IsoAtlas[Nom];
		IsoDessiner(Nom, P.x - Zone[2] / 2, P.y + ISO_DEMI_Y + 4 - Zone[3], D.Miroir);
	}

	window.addEventListener('load', IsoInitialiser);
