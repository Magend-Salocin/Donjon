
	function GetIdPieceAffiche(Piece){						// DEVOILE LES CASES DE LA PIECE PASSEE EN PARAM
		if (PieceEstCouloir(Piece)) { return; }			// couloir : seulement ce que le heros voit (DevoilerVueCouloir)
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

	/* Cartes HeroQuest (MesZones : 1 a 20 couloirs, 21 et plus pieces) : tous les couloirs forment une seule piece.
	   Ils ne sont pas devoiles d'un coup : le heros voit en ligne droite depuis sa case. */
	function EstCouloir(Case){
		return typeof MesZones != 'undefined' && MesZones[Case] >= 1 && MesZones[Case] <= 20;
	}

	function PieceEstCouloir(Piece){
		if (typeof MesZones == 'undefined') { return false; }
		for (var i = 0; i < MesPieces.length; i++){
			if (MesPieces[i] == Piece) { return EstCouloir(i); }
		}
		return false;
	}

	/* Depuis une case de couloir, devoile les 4 lignes droites jusqu'a un mur, une porte (la piece derriere reste
	   cachee) ou un eboulis (devoile, mais il arrete la vue). Les monstres vus s'activent. */
	function DevoilerVueCouloir(CaseHeros){
		if (typeof MesMurs == 'undefined' || !EstCouloir(CaseHeros)) { return; }
		CasesDevoilees[CaseHeros] = true;
		var Directions = [[-26, 1], [1, 2], [26, 4], [-1, 8]];			// ecart, mur a franchir (MesMurs)
		for (var d = 0; d < Directions.length; d++){
			var Case = CaseHeros, Ecart = Directions[d][0], Mur = Directions[d][1];
			while (!(MesMurs[Case] & Mur)){
				var Suivante = Case + Ecart;
				if (Suivante < 0 || Suivante >= MesPieces.length || !EstCouloir(Suivante)) { break; }
				CacheCase(Suivante);
				if (MesMurs[Suivante] & 16) { break; }
				Case = Suivante;
			}
		}
		ActiverMonstresVus();
	}

	function ActiverMonstresVus(){
		for (var i = 0; i < LesMonstres.length; i++){
			if (LesMonstres[i][8] == 0 && CasesDevoilees[LesMonstres[i][7]]) { LesMonstres[i][8] = 1; }
		}
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
