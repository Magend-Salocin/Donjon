
	function GetIdPieceAffiche(Piece){						// DEVOILE LES CASES DE LA PIECE PASSEE EN PARAM
		for (var i=0;i<MesPieces.length;i++){
			if(Piece == MesPieces[i] )
			{
				CacheCase(i);
			}
		}
		if(Piece=="$"){ GetIdPieceAffiche('*'); }
	}

	function GetMyIdPiece(id){
		if(id=="$"){ id="*"; }
		return id
	}

	function ChargementPiece(id){					//STATIC	CHARGE LA PIECE PASSE EN PARAMETRE
		SavePiece(id);
		LesJoueurs[ConstIdJoueur][7]=id;
		ActiveMontrePiece(id);
		GetIdPieceAffiche(id);
		ReAfficheMonstre();
	}

	function SavePiece(id){
		if(id!= null && id!=""){
			PieceActiver[PieceActiver.length] = id;
		}
	}
