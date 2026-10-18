
	var Inventaire   = new Array();
	var movespeed 	= 150;				var bStatusA 	= false;	document.onkeydown 	= onKeyDown;	
	
	function onKeyDown(ev){
		var deplacement = true;
		var PieceJoueur = LesJoueurs[0][7];
		var id = LesJoueurs[0][5];	
		var Move = MovementJoueur;		
		//var Move = document.test.Move.value;
		var code = document.all?event.keyCode:ev.which;
		if (Move > 0) {		
		
			switch (code){
		
				case 37:	
					if (deplacement==true){
						IdPrecedant = id;	id =  id -1; 
						deplacement = RepartiteurPiece(id,IdPrecedant,PieceJoueur);	
					}
				break
					
				case 38:	
					if (deplacement==true){
						IdPrecedant = id;	id =  id -26; 
						deplacement = RepartiteurPiece(id,IdPrecedant,PieceJoueur);				
					}
				break
					
				case 39:
					if (deplacement==true){
						IdPrecedant = id;	id =  parseInt(id) +1;
						deplacement = RepartiteurPiece(id,IdPrecedant,PieceJoueur);
					}		
				break
					
				case 40:		
					if (deplacement==true){
						IdPrecedant = id;	id =  parseInt(id) +26; 
						deplacement = RepartiteurPiece(id,IdPrecedant,PieceJoueur);					
					}
				break		
			default:
			}
			ReAfficheMonstre();
			if(Victoire()==true){ alert("Ici"); FinPartieVictoire(); }
		}
		
	}
	
	
	function RepartiteurPiece(IdSuivant,IdPrecedant,PieceJoueur){//  VOID CONTROLE LES DEPLACEMENTS
		var MyTest = false;	
		
	
		if(MesPieces[IdSuivant]==PieceJoueur)
		{
			CacheCase(IdPrecedant); AfficheHeros(IdSuivant); 	MoveDee();	
			MyTest= true;
		}
		else{
			if(MesPortes[IdSuivant]!="0"){
				PieceJoueur = MesPortesPieceActive[IdSuivant];
				LesJoueurs[0][7]=PieceJoueur;
				
				ChargementPiece(PieceJoueur);
				CacheCase(IdPrecedant); AfficheHeros(IdSuivant);	MoveDee();	
				MyTest= true;
			}
		}
		return MyTest;
		
	}
	
	
	function GestionInventaire(){

	}	
	