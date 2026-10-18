
	function GetIdPieceAffiche(Piece){						// DEVOILE LES CASES DE LA PIECE PASSEE EN PARAM
		for (var i=0;i<MesPieces.length;i++){
			if(Piece == MesPieces[i] )
			{
				CacheCase(i);
			}
		}
		if(Piece=="$"){ GetIdPieceAffiche('*'); }
	}

	/* Mur entre deux cases voisines ou meuble sur la case d'arrivee. MesMurs n'existe que dans les cartes
	   importees de HeroQuest (quest101 a quest124) : 1 haut, 2 droite, 4 bas, 8 gauche, 16 case occupee. */
	function PassageBloque(De, Vers){
		if (typeof MesMurs == 'undefined') { return false; }
		if (MesMurs[Vers] & 16) { return true; }
		var Ecart = Vers - De;
		var Cote = Ecart == -26 ? 1 : Ecart == 1 ? 2 : Ecart == 26 ? 4 : Ecart == -1 ? 8 : 0;
		return (MesMurs[De] & Cote) != 0;
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
