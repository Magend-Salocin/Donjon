
	document.addEventListener('keydown', onKeyDown);

	function onKeyDown(ev){
		var code = ev.keyCode;
		if (code < 37 || code > 40 || PartieTerminee) { return; }
		ev.preventDefault();

		var deplacement = true;
		var PieceJoueur = LesJoueurs[ConstIdJoueur][7];
		var id = parseInt(LesJoueurs[ConstIdJoueur][5]);
		var IdPrecedant;
		if (MovementJoueur > 0) {
			switch (code){
				case 37:	IdPrecedant = id;	id = id - 1;	break;	// gauche
				case 38:	IdPrecedant = id;	id = id - 26;	break;	// haut
				case 39:	IdPrecedant = id;	id = id + 1;	break;	// droite
				case 40:	IdPrecedant = id;	id = id + 26;	break;	// bas
			}
			deplacement = RepartiteurPiece(id,IdPrecedant,PieceJoueur);
			if (deplacement) {
				ActiverPiege(id);
			}
			ReAfficheMonstre();
			ControleVictoire();
		}
	}

	function RepartiteurPiece(IdSuivant,IdPrecedant,PieceJoueur){	// CONTROLE LES DEPLACEMENTS
		if (IdSuivant < 0 || IdSuivant >= MesPieces.length || IsCaseOccupee(IdSuivant)) {
			return false;
		}
		if(MesPieces[IdSuivant]==PieceJoueur){
			CacheCase(IdPrecedant); AfficheHeros(IdSuivant); 	MoveDee();
			return true;
		}
		if(MesPortes[IdSuivant]!="0"){
			PieceJoueur = MesPortesPieceActive[IdSuivant];
			LesJoueurs[ConstIdJoueur][7]=PieceJoueur;
			ChargementPiece(PieceJoueur);
			CacheCase(IdPrecedant); AfficheHeros(IdSuivant);	MoveDee();
			return true;
		}
		return false;
	}

	function IsCaseOccupee(IdCase){						// Un heros ne traverse pas un monstre vivant
		for (var i=0;i<LesMonstres.length;i++){
			if (LesMonstres[i][8]==1 && LesMonstres[i][7]==IdCase){ return true; }
		}
		return false;
	}
