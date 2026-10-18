	function FinPartieVictoire(){
		MyHeroSave();
		var FinPartie = new Array(42,'Vous etez Victorieux','index.php?page=EtatPersonnage',0,0,'Bien jouée');
		GetAfficheCarte(FinPartie);
		MyPartieFin();
	
	}

	function initialiserJeux(){						//LANCE LA PARTIE
		for (jj=0;jj<PieceActiver.length;jj++){ 
			if(PieceActiver[jj].length >0){
			GetIdPieceAffiche(PieceActiver[jj]);
			}
		}
		AfficheHeros(LesJoueurs[ConstIdJoueur][5]);	
		ReAfficheMonstre();
		RemiseZero();
		
		
		LesJoueurs[ConstIdJoueur][3] = LeMagend[2];
	}
	
	function MoveDee(){
		//var Move = document.test.Move.value;
		//document.test.Move.value = Move - 1;
		//MovementJoueur = MovementJoueur  - 1;		
	}

	function Lancerdee(){		//POUR DEFINIR LE DEPLACEMENT DU JOUEUR
		
		if(LesJoueurs[ConstIdJoueur][11]==0){
			LesJoueurs[ConstIdJoueur][8]=0;
			LesJoueurs[ConstIdJoueur][9] = 0;
			Valeur1 = Math.floor(Math.random()*(6 -1+1))+1;
			Valeur2 = Math.floor(Math.random()*(6 -1+1))+1;
			$('Dee1').src = 'images/dee/'+Valeur1+'.bmp';
			$('Dee2').src = 'images/dee/'+Valeur2+'.bmp';
			document.images['Dee1'].src='images/dee/'+Valeur1+'.bmp';
			document.images['Dee2'].src='images/dee/'+Valeur2+'.bmp';
			MovementJoueur = Valeur1 + Valeur2;
			temp=1;
			ActiveAction("Mn_Deplacement");
			LesJoueurs[ConstIdJoueur][11] = 1;
		}
	
	}
	
	function FinTour(){
		MyPartieSave();
		document.images['Dee1'].src='images/dee/Dee.GIF';
		document.images['Dee2'].src='images/dee/Dee.GIF';
		MovementJoueur = 0;
		//document.test.Move.value ="Tour Monstre"
		TimerTourMonstre();
		DesactiveAction("Mn_Attaquer");
		DesactiveAction("Mn_Deplacement");
		DesactiveAction("Mn_Tresor");
		DesactiveAction("Mn_Objet");
		LesJoueurs[ConstIdJoueur][8] = 0;
		LesJoueurs[ConstIdJoueur][11] = 0;

	}
	
	function AfficheHeros(id){
		LesJoueurs[ConstIdJoueur][5] = id;
		MontreElement(id);
		id = parseInt(id)  + IdCorrectionParam; 
		document.images[id].src=LesJoueurs[0][6];	
	}
	
	function AfficheMonstre(id){
		LesMonstres[IdLeMienMonstre][7] = id;
		MontreElement(id);
		id = parseInt(id)  + IdCorrectionParam; 
		document.images[id].src=LesMonstres[IdLeMienMonstre][6]; 
	}
	
	function AfficheCarteTresor(){
		TirerUneCarteTresor();
	}
	
	function AjouterDebug(valeur){
		//document.getElementById("Debug").innerHTML = document.getElementById("Debug").innerHTML + "<br />" + valeur + "<br />";
	}
	
	function ClearDebug(){
		document.getElementById("Debug").innerHTML = '';
	}
	
	function ActiveAction(LienId){
		/*	Mn_Attaquer	Mn_Deplacement	Mn_Tresor	Mn_Objet	Mn_FinTour	*/
		$(LienId).style.textDecoration="line-through";
		$(LienId).style.color="DarkRed";
	}
	
	function DesactiveAction(LienId){
		/*	Mn_Attaquer	Mn_Deplacement	Mn_Tresor	Mn_Objet	Mn_FinTour	*/
		$(LienId).style.textDecoration="";
		$(LienId).style.color="";
	}
	
	function MontreElement(id){
		document.getElementById(id).className = "Montre";
	}
	
	function CacheCase(id){
		document.getElementById(id).className = "Cache";
	}
	