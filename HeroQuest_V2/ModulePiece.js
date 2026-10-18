	
	function GetIdPieceAffiche(Piece){						//LesIdentifiantsPiece	RENVOIE LES IDS DE LA PIECE PASSE EN PARAM
		j=0;
		for (i=0;i<MesPieces.length;i++){ 	
			if(Piece == MesPieces[i] )
			{
				CacheCase(i);
			}
		}
		if(Piece=="$"){ GetIdPieceAffiche('*'); }
	}
	
	
	function ChargementPiece(id){					//STATIC	CHARGE LA PIECE PASSE EN PARAMETRE

		
		
		SavePiece(id);
		LesJoueurs[0][7]=id; 
		ActiveMontrePiece(id);
		GetIdPieceAffiche(id);
		ReAfficheMonstre();
		
	}
	
	function SavePiece(id){
	
		if(id!= null && id!=""){
			PieceActiver[PieceActiver.length+1] = id;
		}
	
	}