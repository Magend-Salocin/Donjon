
	function TirerUneCarteTresor(){
		PieceJoueur = LesJoueurs[ConstIdJoueur][7];
		if(IsFouiller(PieceJoueur)==false &&  IsFouillerPieceVide(PieceJoueur)==false && LesJoueurs[ConstIdJoueur][9]==0){
			var LeTresor = GetAleaCarte();
			AffecterPiece(PieceJoueur);
			SetEffet(LeTresor);
			GetAfficheCarte(LeTresor,ConstIdJoueur);
			LesJoueurs[ConstIdJoueur][9] = 1;
		}
	}

	function AffecterPiece(Piece){
		PieceFouiller[PieceFouiller.length+1] =Piece;
	}
	
	function IsFouiller(Piece){
		var Controle = false;
		for (i=0;i<PieceFouiller.length;i++){
			if(Piece==PieceFouiller[i]){
				Controle = true;
			}
		}
		return Controle;
	}
	
	function IsFouillerPieceVide(Piece){
		var Controle = false;
		for (i=0;i<LesMonstres.length;i++){ 
			if (LesMonstres[i][9]==Piece && LesMonstres[i][8]==1){
				Controle = true;
			}
		}
		return Controle;
	}
	
	function GetAleaCarte(){
		Valeur = Math.floor(Math.random()*(LesTresors.length -1+1))+1;
		//return LesTresors[Valeur];
		return LesTresors[8];
	}
	
	function SetEffet(LeTresor,Id){
		
		if(LeTresor[0]==0){
			Inventaire[Inventaire.length+1] = LeTresor;
		}
		if(LeTresor[0]==1){
			LesJoueurs[id][10] = LesJoueurs[id][10] + LeTresor[4];
		}
		if(LeTresor[0]==2){
			LesJoueurs[id][3] = LesJoueurs[id][3] + LeTresor[4];
		}
		if(LeTresor[0]==3){
			//Inventaire[Inventaire.length+1] = LeTresor;
		}
		
		$('CarteTitre').innerHTML = "====="  + LesJoueurs[id][10]  ;
		$('CarteDescription').innerHTML = "=========" + LesJoueurs[id][3] ;
		AffecteStyle('myOtherElement');
	
	}
	
	function GetAfficheCarte(LeTresor){
		$('CarteTitre').innerHTML = LeTresor[1] ;
		$('CarteDescription').innerHTML = LeTresor[5];
		if(LeTresor[0]==42){  $('FermerTresor').href=LeTresor[2]; }
		AffecteStyle('myOtherElement');
	}
	
	function AffecteStyle(id){
		var otherEl = $(id);
		var morph = new Fx.Morph(id);
		otherEl.style.display='block';
		otherEl.morph('.myClass');
	}
	
	function RetireStyle(id){
		var otherEl = $(id);
		var morph = new Fx.Morph(id);
		$('CarteTitre').innerHTML = '' ;
		$('CarteDescription').innerHTML = '';
		otherEl.erase('style');
		otherEl.style.display='none';
		otherEl.morph('.demoElement');
	}

	function CaracHero(){
		$('MyHeroOrs').innerHTML = LesJoueurs[ConstIdJoueur][10]; 
		$('MyHeroPv').innerHTML = LesJoueurs[ConstIdJoueur][3]; 
		$('MyHeroBarrePv').width=  LesJoueurs[ConstIdJoueur][3] * 300 / LeMagend[2];
		MyHeroSave();
	}
	
	function CacherElement(id){
		$(id).style.display='none';
	}
	
	function AfficherElement(id){
		$(id).style.display='block';
	}
	