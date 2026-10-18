
	function ValeurdeeAtt(valeur){							// ATTRIBUT UNE IMAGE AU LANCER DE DEE
		if(valeur==1 || valeur==3){ return Chemin + '/dee/D01.png'; }	// bouclier blanc
		if(valeur==5){ return Chemin + '/dee/E01.png'; }				// bouclier noir
		return Chemin + '/dee/A01.png';									// crane
	}

	function RemiseZero(){									// REMISE A ZERO DES IMAGE DE DEE DE COMBAT
		for (var i=0;i<8;i++){
			CacheCase('DA'+i);
			CacheCase('DD'+i);
		}
		$('Defenceur').style.display="none";
		$('Attaquant').style.display="none";
	}

	function LancerdeeAtt(NbLancer,Mode){ 					// MODULE DE LANCER DE DEE DE COMBAT RETOUR UN NOMBRE
		var dee =0;
		var NbDes = Math.max(1, Math.min(8, parseInt(NbLancer)));
		for (var i=0;i<NbDes;i++){
			var Valeur = Math.floor(Math.random()*6)+1;
			if(Mode==0){ //MODE ATTAQUE : un crane touche
				$('DA'+i).src=ValeurdeeAtt(Valeur);
				MontreElement('DA'+i);
				if (Valeur==2 || Valeur==4 || Valeur==6){dee=dee+1}
			}
			if(Mode==1){ //MODE DEFENCE : un bouclier blanc pare
				$('DD'+i).src=ValeurdeeAtt(Valeur);
				MontreElement('DD'+i);
				if (Valeur==1 || Valeur==3){dee=dee+1}
			}
		}
		return dee
	}

	function LancerdeeAttaque(){ 							// ATTAQUE DU JOUEUR SUR UN MONSTRE VOISIN
		if(PartieTerminee || LesJoueurs[ConstIdJoueur][8]!=0){ return; }
		var CaseDuMonstre = IsCombatre(LesMonstres,LesJoueurs[ConstIdJoueur][5]);
		if (CaseDuMonstre == -1) {
			AfficheMessage("Aucun monstre &agrave; port&eacute;e d'attaque.");
			return;
		}
		AfficheAttaquantDefenceur(LesJoueurs[ConstIdJoueur][13],ImageCombatMonstre(LesMonstres[CaseDuMonstre]));
		UneAttaque(CaseDuMonstre,ConstIdJoueur,"JOUEUR");
		ActiveAction("Mn_Attaquer");
		LesJoueurs[ConstIdJoueur][8] = 1;
		window.setTimeout(CacheAttaque,2500);
		ControleVictoire();
	}

	function UneAttaque(IdMonstre,IdJoueurs,mode){ 			// COMBAT ENTRE UN JOUEUR ET UN MONSTRE
		var Perte;
		if(mode=="MONSTRE"){
			AfficheAttaquantDefenceur(ImageCombatMonstre(LesMonstres[IdMonstre]),LesJoueurs[IdJoueurs][13]);
			Perte = LancerdeeAtt(LesMonstres[IdMonstre][2],0) - LancerdeeAtt(LesJoueurs[IdJoueurs][2],1);
			if (Perte > 0 ) { PerteVieJoueur(LesJoueurs,IdJoueurs,Perte) }
		}
		if(mode=="JOUEUR"){
			Perte = LancerdeeAtt(LesJoueurs[IdJoueurs][1],0)-LancerdeeAtt(LesMonstres[IdMonstre][3],1);
			if (Perte > 0 ) { PerteVieMonstre(LesMonstres,IdMonstre,Perte) }
			LesJoueurs[IdJoueurs][8]=1;
		}
	}

	function IsCombatre(LesMonstres,Joueur){				// MONSTRE ACTIF SUR UNE CASE VOISINE, OU -1
		var Controle = -1;
		for (var i=0;i<LesMonstres.length;i++){
			if (LesMonstres[i][8]==1) {
				var Combatre=Joueur-LesMonstres[i][7];
				if( Combatre==1 || Combatre==-1 || Combatre==26 || Combatre==-26 ){
					Controle=i;
				}
			}
		}
		return	 Controle
	}

	function PerteVieMonstre(LesMonstres,IdMonstre,Perte){	// PERTE DE POINT DE VIE D UN MONSTRE ET SA MORT
		LesMonstres[IdMonstre][4]=LesMonstres[IdMonstre][4]-Perte;
		if (LesMonstres[IdMonstre][4] < 1 )
		{
			LesMonstres[IdMonstre][8]=-1;
			CacheCase(LesMonstres[IdMonstre][7]);
			ReAfficheMonstre();
			NbMonsreRestant();
		}
	}

	function PerteVieJoueur(LesJoueurs,IdJoueurs,Perte){	// PERTE DE POINT DE VIE DU HEROS ET SA MORT
		LesJoueurs[IdJoueurs][3]= Math.max(0, LesJoueurs[IdJoueurs][3] - Perte);
		CaracHero();
		if (LesJoueurs[IdJoueurs][3] < 1 && !PartieTerminee)
		{
			FinPartieDefaite();
		}
	}

	function AfficheAttaquantDefenceur(ImgAttaquant,ImgDefenceur){
		MontreAttaque();
		$('Attaquant').src =  ImgAttaquant;
		$('Defenceur').src =  ImgDefenceur;
		$('Defenceur').style.display="block";
		$('Attaquant').style.display="block";
	}

	function MontreAttaque(){
		$('MenuCombat').style.display="block";
		$('MenuJoueur').style.display="none";
	}

	function CacheAttaque(){
		$('MenuCombat').style.display="none";
		$('MenuJoueur').style.display="block";
	}
