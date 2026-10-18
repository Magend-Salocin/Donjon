
	function TirerUneCarteTresor(){
		if(PartieTerminee){ return; }
		var PieceJoueur = LesJoueurs[ConstIdJoueur][7];
		if(IsFouiller(PieceJoueur)==false &&  IsFouillerPieceVide(PieceJoueur)==false && LesJoueurs[ConstIdJoueur][9]==0){
			var LeTresor = GetAleaCarte();
			AffecterPiece(PieceJoueur);
			LesJoueurs[ConstIdJoueur][9] = 1;
			ActiveAction("Mn_Tresor");
			GetAfficheCarte(LeTresor);
			SetEffet(LeTresor);
		}
	}

	function AffecterPiece(Piece){
		PieceFouiller[PieceFouiller.length] =Piece;
	}

	function IsFouiller(Piece){
		for (var i=0;i<PieceFouiller.length;i++){
			if(Piece==PieceFouiller[i]){
				return true;
			}
		}
		return false;
	}

	function IsFouillerPieceVide(Piece){				// Une piece ne se fouille pas tant qu'un monstre y est actif
		for (var i=0;i<LesMonstres.length;i++){
			if (LesMonstres[i][9]==Piece && LesMonstres[i][8]==1){
				return true;
			}
		}
		return false;
	}

	function GetAleaCarte(){
		return LesTresors[Math.floor(Math.random()*LesTresors.length)];
	}

	function SetEffet(LeTresor){
		if(LeTresor[0]==0){
			MyItemAjout(LeTresor[6]);
		}
		if(LeTresor[0]==1){
			LesJoueurs[ConstIdJoueur][10] = parseInt(LesJoueurs[ConstIdJoueur][10]) + parseInt(LeTresor[4]);
			CaracHero();
		}
		if(LeTresor[0]==2){
			PerteVieJoueur(LesJoueurs,ConstIdJoueur,-parseInt(LeTresor[4]));
		}
	}

	function GetAfficheCarte(LeTresor){
		$('CarteTitre').innerHTML = LeTresor[1] ;
		$('CarteDescription').innerHTML = LeTresor[5];
		if(LeTresor[0]==42){  $('FermerTresor').href=LeTresor[2]; $('FermerTresor').innerHTML='Retour au village'; }
		AffecteStyle('myOtherElement');
	}

	function AffecteStyle(id){
		$(id).className = 'demoElement myClass';
	}

	function RetireStyle(id){
		$('CarteTitre').innerHTML = '' ;
		$('CarteDescription').innerHTML = '';
		$(id).className = 'demoElement';
	}

	function CacherElement(id){
		$(id).style.display='none';
	}

	function AfficherElement(id){
		if(!PartieTerminee){ $(id).style.display='block'; }
	}
