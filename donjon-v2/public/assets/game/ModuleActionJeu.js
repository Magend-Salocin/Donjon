
	//  Nom - Attaque -  Defence - Corp - Esprit - Position - Image - Piece - Attaquer	-ChercherTresor	 - Or	- deplacement	JOUEUR - ImageCombat
	//   0  -      1     -               2     -       3  -    4   -            5     -   6   -          7    -  8 -                        9-                    10 -           11  - 12 - 13

	var PartieTerminee = false;

	function initialiserJeux(){						//LANCE LA PARTIE
		for (var jj=0;jj<PieceActiver.length;jj++){
			if(PieceActiver[jj] && PieceActiver[jj].length >0){
				GetIdPieceAffiche(PieceActiver[jj]);
			}
		}
		ActiveMontrePiece(LesJoueurs[ConstIdJoueur][7]);	// les monstres de la piece de depart jouent des le premier tour
		AfficheHeros(LesJoueurs[ConstIdJoueur][5]);
		AfficheAllJoueur();
		ReAfficheMonstre();
		RemiseZero();
		ClearAction();
		NbMonsreRestant();
		if(MyHeroNum != LesJoueurs[ConstIdJoueur][12][0]){ DesactiveAllAction(); }
	}

	function DebutTour(){							// Debut de tour d'un joueur
		if(PartieTerminee){ return; }
		ClearAction();
		RemiseZero();
		CacheAttaque();
		if(MyHeroNum != LesJoueurs[ConstIdJoueur][12][0]){ DesactiveAllAction(); }
	}

	function FinTour(){								//Fin de tour d'un joueur
		if(PartieTerminee){ return; }
		CacheAttaque();
		TimerTourMonstre();
	}

	function FinTourMonstre(){
		IsTourMonstreTimer = true;
		ReloadTimer();
		window.setTimeout(DebutTour,1399);
	}

	function FinCombat(){
		CacheAttaque();
	}

	function ControleVictoire(){
		if(!PartieTerminee && Victoire()==true){ FinPartieVictoire(); }
	}

	function FinPartieVictoire(){					//La quete est accomplie
		PartieTerminee = true;
		var FinPartie = new Array(42,'Vous &ecirc;tes victorieux !','index.php?page=personnage',0,0,'Bien jou&eacute;. Votre r&eacute;compense vous attend au village.');
		GetAfficheCarte(FinPartie);
		MyPartieFin('victoire');
	}

	function FinPartieDefaite(){					//Le heros n'a plus de point de vie
		PartieTerminee = true;
		var FinPartie = new Array(42,'Vous &ecirc;tes mort...','index.php?page=personnage',0,0,'Vos compagnons vous ram&egrave;nent au village avec un point de vie.');
		GetAfficheCarte(FinPartie);
		MyPartieFin('defaite');
	}

	function ClearAction(){
		MovementJoueur = 0;
		RemiseZeroDesDeplacement();
		DesactiveAction("Mn_Attaquer");
		DesactiveAction("Mn_Deplacement");
		DesactiveAction("Mn_Tresor");
		DesactiveAction("Mn_Objet");
		DesactiveAction("Mn_Piege");
		LesJoueurs[ConstIdJoueur][8]=0;
		LesJoueurs[ConstIdJoueur][9] = 0;
		LesJoueurs[ConstIdJoueur][11] = 0;
		RetirerEffet();
	}

	function DesactiveAllAction(){
		RemiseZeroDesDeplacement();
		ActiveAction("Mn_Attaquer");
		ActiveAction("Mn_Deplacement");
		ActiveAction("Mn_Tresor");
		ActiveAction("Mn_Objet");
		ActiveAction("Mn_Piege");
	}

	function AfficheHeros(id){
		LesJoueurs[ConstIdJoueur][5] = id;
		MontreElement(id);
		ImageCase(id).src=LesJoueurs[ConstIdJoueur][6];
	}

	function AfficheOtherHeros(id,IdJoueur){
		if(ConstIdJoueur!=IdJoueur){
			LesJoueurs[IdJoueur][5] = id;
			MontreElement(id);
			ImageCase(id).src=LesJoueurs[IdJoueur][6];
		}
	}

	function AfficheMonstre(id){							// un monstre sur une case jamais vue par le heros reste cache
		LesMonstres[IdLeMienMonstre][7] = id;
		if (!CasesDevoilees[id]) { MasqueCase(id); return; }
		MontreElement(id);
		ImageCase(id).src=LesMonstres[IdLeMienMonstre][6];
	}

	function AfficheCarteTresor(){
		TirerUneCarteTresor();
	}

	function ActiveAction(LienId){
		/* Action deja utilisee pendant ce tour : Mn_Attaquer Mn_Deplacement Mn_Tresor Mn_Objet Mn_Piege */
		$(LienId).style.textDecoration="line-through";
		$(LienId).style.color="DarkRed";
	}

	function DesactiveAction(LienId){
		/* Action de nouveau disponible */
		$(LienId).style.textDecoration="";
		$(LienId).style.color="";
	}

	function MontreElement(id){
		document.getElementById(String(id)).className = "Montre";
	}

	/* Cases du plateau deja vues par le heros (pieces devoilees et cases parcourues). */
	var CasesDevoilees = {};

	function CacheCase(id){								// devoile la case : son image noire disparait
		if (/^\d+$/.test(String(id))) { CasesDevoilees[parseInt(id, 10)] = true; }
		document.getElementById(String(id)).className = "Cache";
	}

	function MasqueCase(id){							// remet l'image noire d'une case jamais vue
		ImageCase(id).src = Chemin + '/08.jpg';
		MontreElement(id);
	}

	function LibereCase(id){							// case quittee par un monstre
		if (CasesDevoilees[parseInt(id, 10)]) { CacheCase(id); } else { MasqueCase(id); }
	}

	function UtiliserObjet(id){
		// MesObjet : 1 num, 2 quantite, 5 effet, 6 valeur
		if(PartieTerminee || !(MesObjet[id][2] > 0)){ return; }
		var Heros = LesJoueurs[ConstIdJoueur];

		if(MesObjet[id][5] =="pv2"){
			var VieMax = parseInt(Heros[12][2]);
			Heros[3] = Math.min(VieMax, parseInt(Heros[3]) + parseInt(MesObjet[id][6]));
			UtiliserObjetHeroDel(id);
			CaracHero();
			return;
		}
		if(MesObjet[id][1] == "998"){
			LesEffets[LesEffets.length]   = new Array(ConstIdJoueur,2,Heros[2]);
			UtiliserObjetHero(2,id);
		}
		if(MesObjet[id][1] == "997"){
			LesEffets[LesEffets.length]   = new Array(ConstIdJoueur,1,Heros[1]);
			UtiliserObjetHero(1,id);
		}
		if(MesObjet[id][1] == "996"){
			Heros[11] = 0;	DesactiveAction("Mn_Deplacement");
			UtiliserObjetHeroDel(id);
		}
		if(MesObjet[id][1] == "995"){
			Heros[8] = 0; 	DesactiveAction("Mn_Attaquer");
			UtiliserObjetHeroDel(id);
		}
	}

	/* Bonus temporaire (retire au debut du tour suivant) sur l'attaque (1) ou la defense (2), 8 des au maximum. */
	function UtiliserObjetHero(IdAttribu,id){
		var Valeur = parseInt(MesObjet[id][6]) + parseInt(LesJoueurs[ConstIdJoueur][IdAttribu]);
		LesJoueurs[ConstIdJoueur][IdAttribu] = Math.min(8, Valeur);
		UtiliserObjetHeroDel(id);
	}

	function UtiliserObjetHeroDel(id){
		MesObjet[id][2] = parseInt(MesObjet[id][2]) - 1;
		MyItemRetrait(MesObjet[id][1]);
		$('_item'+MesObjet[id][1]).innerHTML= MesObjet[id][2];
	}

	function RetirerEffet(){
		for (var i=0;i<LesEffets.length;i++){
			LesJoueurs[LesEffets[i][0]][LesEffets[i][1]] = LesEffets[i][2];
		}
		LesEffets = new Array();
	}

	function ActiverPiege(id){
		if(MesPieges[id]=="X"){
			MesPieges[id]="0";
			PerteVieJoueur(LesJoueurs,ConstIdJoueur,1);
			AfficheMessage("Vous &ecirc;tes victime d'un pi&egrave;ge !");
		}
	}

	function DeactiverLesPieges(){
		var LaPiece = GetIdPiece(LesJoueurs[ConstIdJoueur][7]);
		for (var i=0;i<LaPiece.length;i++){
			MesPieges[LaPiece[i]]="0";
		}
		ActiveAction("Mn_Attaquer");
		ActiveAction("Mn_Deplacement");
		ActiveAction("Mn_Tresor");
		ActiveAction("Mn_Objet");
		ActiveAction("Mn_Piege");
		LesJoueurs[ConstIdJoueur][11] = 1;
	}

	function AfficheAllJoueur(){					// Affiche tout les joueurs sur la carte
		for (var jj=0;jj<LesJoueurs.length;jj++){
			AfficheOtherHeros(LesJoueurs[jj][5],jj);
		}
	}

	function MoveDee(){								//Controle du deplacement des joueurs
		MovementJoueur = MovementJoueur  - 1;
		AfficheDeplacement();
	}

	var DeplacementTotal = 0;						// somme des deux des du dernier lancer

	function AfficheDeplacement(){					// "= 7 cases" apres le lancer, puis "reste 5 / 7"
		var Texte = '';
		if (DeplacementTotal > 0) {
			Texte = MovementJoueur == DeplacementTotal
				? '= ' + Pluriel(DeplacementTotal, 'case')
				: 'reste ' + Math.max(0, MovementJoueur) + ' / ' + DeplacementTotal;
		}
		$('DeplacementRestant').innerHTML = Texte;
	}

	function RemiseZeroDesDeplacement(){
		AfficheDe($('Dee1'), 'neutre');
		AfficheDe($('Dee2'), 'neutre');
		DeplacementTotal = 0;
		AfficheDeplacement();
	}

	function Lancerdee(){							//Lancer les dees pour le deplacement du joueur en cours
		if(!PartieTerminee && LesJoueurs[ConstIdJoueur][11]==0){
			var Valeur1 = Math.floor(Math.random()*6)+1;
			var Valeur2 = Math.floor(Math.random()*6)+1;
			AnimerDe($('Dee1'), DES_FACES_DEPLACEMENT, Valeur1);
			AnimerDe($('Dee2'), DES_FACES_DEPLACEMENT, Valeur2);
			MovementJoueur = Valeur1 + Valeur2;
			DeplacementTotal = MovementJoueur;
			ApresLancer(AfficheDeplacement);
			ActiveAction("Mn_Deplacement");
			LesJoueurs[ConstIdJoueur][11] = 1;
		}
	}

	function AfficheMessage(Texte){
		$('TourJoueur').innerHTML = Texte;
	}
