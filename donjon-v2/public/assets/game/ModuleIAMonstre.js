var LeMienMonstre = "";
var temp = 1;
var TabAction ;
var NbAction ; 
var IdThisMonstre;
var MoveThisMonstre;
var IdLeMienMonstre ;
var IsTourMonstreTimer = false;
	
	function TimerTourMonstre(){
		if(PartieTerminee){ return; }
		$('TourMonstre').innerHTML ='Tour des monstres';
		AfficheMessage('Tour des monstres...');
		for (var m=0;m<LesMonstres.length;m++){ LesMonstres[m][10]=false; }
		RemiseZero();
		IdThisMonstre = 0; 
		MoveThisMonstre = 0; 
		temp = 600; 
		IdLeMienMonstre = 0;
		IsTourMonstreTimer = false;
		TourMonstreTimer();

	}
	
	function TourMonstreTimer(){	
		if(PartieTerminee){ return; }
		if(IsTourMonstreTimer == false){
			if(IdThisMonstre>=LesMonstres.length){ FinTourMonstre(); return; }
			if(IdThisMonstre<LesMonstres.length){
				if(LesMonstres[IdThisMonstre][8]==1){
					if(MoveThisMonstre<LesMonstres[IdThisMonstre][1] && LesMonstres[IdThisMonstre][10]==false) {
						MoveThisMonstre++; TourMonstreAction(); 
						$('TourMonstre').innerHTML ='Tour des monstre  Action '+ LesMonstres[IdThisMonstre][0];
						 window.setTimeout("TourMonstreTimer()",temp);	
					}
					else{ 
						IdThisMonstre++; 
						if(IdThisMonstre < LesMonstres.length){
							IdLeMienMonstre = IdThisMonstre;	LesMonstres[IdThisMonstre][10]=false; MoveThisMonstre = 0;RemiseZero();
							window.setTimeout("TourMonstreTimer()",1);	
						}
						else{
							FinTourMonstre();
						}
					}

					
				}
				else{
					IdThisMonstre++;
					if(IdThisMonstre < LesMonstres.length){
						IdLeMienMonstre = IdThisMonstre;	LesMonstres[IdThisMonstre][10]=false; MoveThisMonstre = 0;
						window.setTimeout("TourMonstreTimer()",1);	
					}
					else{
						FinTourMonstre();
					}
				}
			}
		}
	}

	function TourMonstreAction(){
		/*Soit le monstre se trouve ds la piece du joueur et attaque (cartes avec MesMurs : il le poursuit partout)*/
		if(LesMonstres[IdLeMienMonstre][9]==LesJoueurs[0][7] || typeof MesMurs != 'undefined'){
			LesMonstres[IdLeMienMonstre][10] = IATourMonstrePiece(LesMonstres[IdLeMienMonstre],LesJoueurs[0]);
			if(LesMonstres[IdLeMienMonstre][10]==true){ /*temp=temp+200;*/ UneAttaque(IdLeMienMonstre,0,"MONSTRE");  	}	
	
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
		if(PassageBloque(LesMonstres[IdLeMienMonstre][7], IdSuivant)){ return false; }
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
		if( (Id==26 || Id==-26 || Id==1 || Id==-1) && !PassageBloque(IdMonstre,Joueur[5]) ){ Combatre=true; }
		else if (typeof MesMurs != 'undefined'){
			var Pas = PasVersHeros(IdMonstre, Number(Joueur[5]));
			if (Pas != -1){ DeplacementMonstre(IdMonstre, Pas); Monstre[9] = MesPieces[Pas]; }
		}
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

	/* Premiere case du plus court chemin d'un monstre vers le heros, en contournant murs, meubles et autres
	   monstres, avec les regles de passage des portes du heros (cartes avec MesMurs). -1 si bloque. */
	function PasVersHeros(Depart, Cible){
		var Precedent = {}; Precedent[Depart] = Depart;
		var File = [Depart];
		while (File.length > 0){
			var Case = File.shift();
			var Voisins = [Case - 26, Case + 1, Case + 26, Case - 1];
			for (var i = 0; i < Voisins.length; i++){
				var Voisin = Voisins[i];
				if (Voisin in Precedent || Voisin < 0 || Voisin >= MesPieces.length || PassageBloque(Case, Voisin)){ continue; }
				if (Voisin == Cible){
					if (Case == Depart){ return -1; }
					while (Precedent[Case] != Depart){ Case = Precedent[Case]; }
					return Case;
				}
				var Passage = MesPieces[Voisin] == MesPieces[Case] || MesPortes[Voisin] != "0";
				if (MesPieces[Voisin] == "0" || !Passage || IsCaseOccupee(Voisin)){ continue; }
				Precedent[Voisin] = Case;
				File.push(Voisin);
			}
		}
		return -1;
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
		LibereCase(IdMonstre);
		AfficheMonstre(Id)
	}
	
	function ActiveMontrePiece(piece){							//VOID	ACTIVE LES MONTRES DANS LEQUELLE UN JOUEUR ENTRE
		for (i=0;i<LesMonstres.length;i++){ 
			if (LesMonstres[i][9]==GetMyIdPiece(piece) && LesMonstres[i][8]==0){
				LesMonstres[i][8]=1; 
			}
		}
	}
	
	function ReAfficheMonstre(){								//VOID	REAFFICHE LES MONSTRE DANS LEURS PIECES RESPECTIVE
		for (i=0;i<LesMonstres.length;i++){ 
			if (LesMonstres[i][8]==1 && CasesDevoilees[LesMonstres[i][7]]){
				MontreElement(LesMonstres[i][7]);
				ImageCase(LesMonstres[i][7]).src=LesMonstres[i][6];
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
	
	function NbMonsreRestant(){
		MonstreTuer = 0;
		for (var i=0;i<LesMonstres.length;i++){ if(LesMonstres[i][8]==-1){ MonstreTuer++; } }
		$('NbMonstre').innerHTML=LesMonstres.length - MonstreTuer;
	}
	