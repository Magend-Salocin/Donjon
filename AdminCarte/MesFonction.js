
	

var MyActiverCase = 1;
var MyCaseAvant = -1; 
var MyMonstre = -1;
var depart= -1;
var departPiece= -1;

	
	function SetActiverCase(id)
	{
		MyActiverCase = id;
	}
	function ChooseMonstre(id){
		MyMonstre = id;
		MyActiverCase = 3;
	}
	
	function RepartiteurAction(id){

		if(MyActiverCase == 1){ActiverCase(id);}
		if(MyActiverCase == 2){ActiverPiece(id);}
		if(MyActiverCase == 3){ActiverMonstre(id);}
		if(MyActiverCase == 4){ActiverDepart(id);}
				if(MyActiverCase == 5){ActiverPiege(id);}
	}	

	function IsCouloir(Valeur){
		
		if(Valeur=="0"){
			Valeur="$";
		}
		return Valeur;
	}
	
	function ActiverPiece(id){
		if(document.images[id].src=="http://localhost/AdminCarte/00.png"){
			if(MyCaseAvant==-1){
				MesPortesPieceActive[id] 	= IsCouloir(MesPieces[id]);
				MyCaseAvant					= id;
			}
			else{
				MesPortes[MyCaseAvant] 		= IsCouloir(MesPieces[id]);
				MesPortes[id] 				= IsCouloir(MesPieces[MyCaseAvant]);
				MesPortesPieceActive[id] 	= IsCouloir(MesPieces[id]);
				MyCaseAvant					= -1;
			}
			document.images[id].src			= "http://localhost/AdminCarte/02.jpg";
		}
		else{
			document.images[id].src			= "http://localhost/AdminCarte/00.png";
			MesPortes[id] 					= "0";
			MesPortesPieceActive[id] 		= "0";
			MyCaseAvant						= -1;
		}
	}	
	
	
	function ActiverMonstre(id){
	
		if(document.images[id].src=="http://localhost/AdminCarte/00.png"){
			
			LesMonstres[LesMonstres.length] = MyMonstre + "-"+id + "-" + MesPieces[id];
			
			document.images[id].src=document.images["M"+MyMonstre].src;
		}
		else{
			document.images[id].src="http://localhost/AdminCarte/00.png";
		}
	}
	
	function ActiverCase(id){


		if(document.images[id].src=="http://localhost/AdminCarte/00.png"){
			MesPiecesSave[id] = "*";
			document.images[id].src="http://localhost/AdminCarte/01.jpg";
		}
		else{
			document.images[id].src="http://localhost/AdminCarte/00.png";
			MesPiecesSave[id] = MesPieces[id];
		}

	}	
	
	function ActiverDepart(id){


		if(depart=='-1'){
			document.images[id].src="http://localhost/AdminCarte/01.jpg";
			depart=id;
			departPiece = MesPieces[id];
		}
		else{
			document.images[depart].src="http://localhost/AdminCarte/00.png";
			depart='-1';
			departPiece='-1';
		}

	}	
	
	
	function ActiverPiege(id){
		if(document.images[id].src=="http://localhost/AdminCarte/00.png"){
			MesPieges[id] = "X";
			document.images[id].src="http://localhost/AdminCarte/03.jpg";
		}
		else{
			document.images[id].src="http://localhost/AdminCarte/00.png";
			MesPieges[id] = "0";
		}
	}	

