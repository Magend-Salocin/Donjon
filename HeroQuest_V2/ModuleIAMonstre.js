var LeMienMonstre = "";
var temp = 1;
var TabAction ;
var NbAction ; 
var i2;
var j2;
var test;
var Oldtest
	
	function TimerTourMonstre(){
		RemiseZero();
		i2 = 0; j2 = 0; temp = 250; IdLeMienMonstre = 0;
		TourMonstreTimer();
	}
	
	function TourMonstreTimer(){	
		if(i2<LesMonstres.length){
			if(LesMonstres[i2][8]==1){
				if(j2<LesMonstres[i2][1] && LesMonstres[i2][10]==false) {
					j2++; TourMonstreAction(); 
				}
				else{ 
					test = j2; Oldtest = i2; i2++; IdLeMienMonstre = i2;	LesMonstres[i2][10]=false; j2 = 0;
				}
				temp = temp + 100;
				window.setTimeout("TourMonstreTimer()",temp);	
			}
			else{
				i2++; IdLeMienMonstre = i2;	LesMonstres[i2][10]=false; j2 = 0;
				temp = temp + 100;
				window.setTimeout("TourMonstreTimer()",temp);
			}
		}
	}

	function TourMonstreAction(){
		/*Soit le monstre se trouve ds la piece du joueur et attaque*/
		if(LesMonstres[IdLeMienMonstre][9]==LesJoueurs[0][7]){
			LesMonstres[IdLeMienMonstre][10] = IATourMonstrePiece(LesMonstres[IdLeMienMonstre],LesJoueurs[0]);
			if(LesMonstres[IdLeMienMonstre][10]==true){	 UneAttaque(IdLeMienMonstre,0,"MONSTRE");  	}	
	
		}
		/*Soit le monstre se trouve dans une autre piece et cherche le joueur*/
		else{
			PieceMonstre = IATourMonstreChangePiece(LesMonstres[IdLeMienMonstre],LesJoueurs[0]);	
			if (PieceMonstre != -1){
				LesMonstres[IdLeMienMonstre][9] = PieceMonstre;
			}	
		}
	}
	
	function RepartiteurPieceMonstre(IdSuivant,IdPrecedant,PieceJoueur){
		var MyTest = false;	
		if(MesPieces[IdSuivant]==PieceJoueur)
		{
			MyTest= true;
		}
		else{
			if(MesPortes[IdSuivant]!="0"){
				//PieceJoueur = MesPortesPieceActive[IdSuivant];
				//LesJoueurs[0][7]=PieceJoueur;		
				//ChargementPiece(PieceJoueur);
				//CacheCase(IdPrecedant); AfficheHeros(IdSuivant);	MoveDee();	
				//MyTest= true;
			}
		}
		return MyTest;
	}
	
	function IATourMonstrePiece(Monstre,Joueur){
		var controle 	= false; var Combatre 	= false; IdMonstre=Monstre[7]; Id=Joueur[5]-IdMonstre;					
		//Le joueur se trouve dans la piece	40 haut 39 bas 38 gauche
		if( Id==26 || Id==-26 || Id==1 || Id==-1  ){ Combatre=true; }
		else{
			if(Id>=24  && Id>0 &&  Id!=26){
				IdPrecedant = Id;	Id =  parseInt(IdMonstre) +26; 
				controle = RepartiteurPieceMonstre(Id,IdPrecedant,Monstre[9]);		
			}
				
			if(Id<=-24 && Id<0 && Id!=-26 && controle == false){	
				IdPrecedant = Id;	Id =  IdMonstre -26; 
				controle = RepartiteurPieceMonstre(Id,IdPrecedant,Monstre[9]);	
			}				
				
			if(Id>=-25 && Id<0 && Id!=-1 && controle == false){
				
				IdPrecedant = Id;	Id =  IdMonstre -1; 
				controle = RepartiteurPieceMonstre(Id,IdPrecedant,Monstre[9]);	
			}
			
			if(Id<=25  && Id>0 && Id!=1  && controle == false){
				IdPrecedant = Id;	Id =  parseInt(IdMonstre) +1;
				controle = RepartiteurPieceMonstre(Id,IdPrecedant,Monstre[9]);
				
			}
			if (controle == true){   DeplacementMonstre(IdMonstre,Id);  }		
		}	
		return Combatre
	}
		
	function IATourMonstreChangePiece(Monstre,Joueur){			// TOUVER LA SORTIE DE LA PIECE AFIN DE REJOINDRE LE HEROS
					
		var PieceMonstre 	= false;
		var controle=false;		
		var ChangeDePiece 	= false;	
			IdMonstre	 = Monstre[7];
			if(IdMonstre < 0){ IdMonstre = IdMonstre * -1;	}
			PieceJoueur  = Joueur[7];	
			PieceMonstre = Monstre[9];	
		LesIdentifiantsSortieMonstre = GetSortiePossible(PieceMonstre);
		LesIdentifiantsSortieJoueur  = GetSortiePossible(PieceJoueur);
		PorteSortie =RetrouverJoueur(LesIdentifiantsSortieMonstre,LesIdentifiantsSortieJoueur);
		coef = 1;	

		Id=PorteSortie-IdMonstre; IdPrecedant = Id;
		if(Id>=22  && Id>0 ){
			Id=parseInt(IdMonstre)+26;  	ChangeDePiece = RepartiteurPieceMonstre(IdMonstre,Id,PieceMonstre); 
			controle = RepartiteurPieceMonstre(Id,IdPrecedant,Monstre[9]);	
		}
		if(Id<-22 && Id<0  && ChangeDePiece == false){
			Id=IdMonstre-26;  				ChangeDePiece = RepartiteurPieceMonstre(IdMonstre,Id,PieceMonstre); 
			controle = RepartiteurPieceMonstre(Id,IdPrecedant,Monstre[9]);	
		}
			
		Id = Id * coef;
		if(Joueur[7] > IdMonstre) { Id = Id * 1;   }
		else { Id = (parseInt(Id) * parseInt(-1)); coef=-1;  }
		
		if(coef==1){
			if(Id>=-25 && Id<0 || Id==1 && ChangeDePiece == false){
				Id=parseInt(IdMonstre)+1;    				ChangeDePiece = RepartiteurPieceMonstre(IdMonstre,Id,PieceMonstre); 
				controle = RepartiteurPieceMonstre(Id,IdPrecedant,Monstre[9]);					
			}
			if(Id<=25  && Id>0 || Id==-1  &&   ChangeDePiece == false){
				Id=IdMonstre-1;   	ChangeDePiece = RepartiteurPieceMonstre(IdMonstre,Id,PieceMonstre); 
				controle = RepartiteurPieceMonstre(Id,IdPrecedant,Monstre[9]);	
			}
		}
		else {
			if(Id>=-25 && Id<0 || Id==-1 &&  ChangeDePiece == false){
				Id=parseInt(IdMonstre)+1;    				ChangeDePiece = true;
				controle = RepartiteurPieceMonstre(Id,IdPrecedant,Monstre[9]);	
			}
			if(Id<=25  && Id>0 || Id==1  && ChangeDePiece == false){
				Id=IdMonstre-1;   	ChangeDePiece = RepartiteurPieceMonstre(IdMonstre,Id,PieceMonstre); 
				controle = RepartiteurPieceMonstre(Id,IdPrecedant,Monstre[9]);
			}
		}
		
		if (ChangeDePiece == true && controle ==true){ 
			if(Id<0){ Id = Id * -1;}	
			DeplacementMonstre(IdMonstre,Id); 
		}
		
		if( Id==PorteSortie && controle ==true){  
			PieceSuivante = MesPortesPieceActive[PorteSortie];
			if(PieceSuivante!=PieceJoueur){
				DeplacementMonstre(IdMonstre,Id);
				var IdMonstreHaut   = parseInt(Id) +26; var IdMonstreBas    = Id - 26; var IdMonstreGauche = Id  - 1; var IdMonstreDroite = parseInt(Id) +1; var PieceMyMonstre = MesPortes[PorteSortie];
				
				if(MesPortesPieceActive[IdMonstreHaut]==PieceMyMonstre)	{ DeplacementMonstre(Id,IdMonstreHaut); } 
				if(MesPortesPieceActive[IdMonstreBas]==PieceMyMonstre)		{ DeplacementMonstre(Id,IdMonstreBas); } 
				if(MesPortesPieceActive[IdMonstreGauche]==PieceMyMonstre)	{ DeplacementMonstre(Id,IdMonstreGauche); } 
				if(MesPortesPieceActive[IdMonstreDroite]==PieceMyMonstre)	{ DeplacementMonstre(Id,IdMonstreDroite); } 

				LesIdentifiantsSortieMonstre = GetSortiePossible(PieceSuivante);
				LesIdentifiantsSortieJoueur  = GetSortiePossible(PieceJoueur);
				
				PorteSortie =RetrouverJoueur(LesIdentifiantsSortieMonstre,LesIdentifiantsSortieJoueur);  PieceSuivante = MesPortes[PorteSortie];	
			}
			else{ DeplacementMonstre(IdMonstre,Id); }
		}	
		else { PieceSuivante=-1; }
		return PieceSuivante
	}

	function DeplacementMonstre(IdMonstre,Id){
		CacheCase(IdMonstre);  
		AfficheMonstre(Id)
	}
	
	function ActiveMontrePiece(piece){							//VOID	ACTIVE LES MONTRES DANS LEQUELLE UN JOUEUR ENTRE
		for (i=0;i<LesMonstres.length;i++){ 
			if (LesMonstres[i][9]==piece && LesMonstres[i][8]==0){
				LesMonstres[i][8]=1; 
			}
		}
	}
	
	function ReAfficheMonstre(){								//VOID	REAFFICHE LES MONSTRE DANS LEURS PIECES RESPECTIVE
		for (i=0;i<LesMonstres.length;i++){ 
			if (LesMonstres[i][8]==1){
				MontreElement(LesMonstres[i][7]);
				id = parseInt(LesMonstres[i][7])  + IdCorrectionParam; 
				document.images[id].src=LesMonstres[i][6]; 
			}
		}
	}
	
	function GetIdPiece(Piece){									//LesIdentifiantsPiece	RENVOIE LES IDS DE LA PIECE PASSE EN PARAM
		j=0; var LesIdentifiantsPiece   = new Array();
		for (i=0;i<MesPieces.length;i++){ 	
			if(Piece == MesPieces[i]){
				LesIdentifiantsPiece[j]=i;
				j++;
			}
		}
		return LesIdentifiantsPiece;	
	}
	
	function GetSortiePossible(Piece){							//LesIdentifiantsSortie	RENVOIE LES IDS DE SORTI DE LA PIECE PASSE EN PARAM
		
		var LesIdentifiantsSortie   = new Array(); var LesIdentifiantsPiece  = GetIdPiece(Piece); j=0;
		for (i=0;i<LesIdentifiantsPiece.length;i++){ 	
			if(MesPortes[LesIdentifiantsPiece[i]]!="0"){
				LesIdentifiantsSortie[j]=LesIdentifiantsPiece[i];
				j++;
			}
		}
		return LesIdentifiantsSortie;	
	}
	
	function RetrouverJoueur(LesIdentifiantsSortieMonstre,LesIdentifiantsSortieJoueur){ //PORTE DE SORTIE DES JOUEURS  les Id
		var find = false;var Porte = 0;
		
		for (i=0;i<LesIdentifiantsSortieMonstre.length;i++){ 	
			for (j=0;j<LesIdentifiantsSortieJoueur.length;j++){ 	 
				if(MesPortes[LesIdentifiantsSortieMonstre[i]] == MesPortesPieceActive[LesIdentifiantsSortieJoueur[j]] && find == false){
					var IdMonstre = LesIdentifiantsSortieMonstre[i]; var IdJoueur  = LesIdentifiantsSortieJoueur[j]; var IdMonstreHaut   = parseInt(IdMonstre) +26; var IdMonstreBas    = IdMonstre - 26; var IdMonstreGauche = IdMonstre - 1; var IdMonstreDroite = parseInt(IdMonstre) +1;
					
					if(IdMonstreHaut == IdJoueur || IdMonstreBas == IdJoueur  || IdMonstreGauche == IdJoueur  || IdMonstreDroite == IdJoueur){
						Porte =  LesIdentifiantsSortieMonstre[i];
						find=true;
					}					
				}
			}
		}
		if(find==false){
			for (i=0;i<LesIdentifiantsSortieMonstre.length;i++){ 	
				for (j=0;j<LesIdentifiantsSortieJoueur.length;j++){ 	
						AjouterDebug("RetrouverJoueur |  |Piece Monstre : " + MesPortes[LesIdentifiantsSortieMonstre[i]] +" _ _ Piece Joueur"+ MesPortes[LesIdentifiantsSortieJoueur[j]]);
					if(MesPortes[LesIdentifiantsSortieMonstre[i]] == MesPortes[LesIdentifiantsSortieJoueur[j]] && find == false){
						var IdMonstre = LesIdentifiantsSortieMonstre[i]; var IdJoueur  = LesIdentifiantsSortieMonstre[i]; var IdMonstreHaut   = parseInt(IdMonstre) +26; var IdMonstreBas    = IdMonstre - 26; var IdMonstreDroite = parseInt(IdMonstre) +1; var IdMonstreGauche = IdMonstre -1;
							
							Porte =  LesIdentifiantsSortieMonstre[i];
							find=true;
					}
				}
			}
		}
		return Porte;
	}
	