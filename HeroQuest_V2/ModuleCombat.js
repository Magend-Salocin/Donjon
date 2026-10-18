
	function ValeurdeeAtt(valeur){							// ATTRIBUT UNE IMAGE AU LANCER DE DEE
		if(valeur==1){image='images/dee/D01.jpg'};
		if(valeur==2){image='images/dee/A01.jpg'};
		if(valeur==3){image='images/dee/D01.jpg'};
		if(valeur==4){image='images/dee/A01.jpg'};
		if(valeur==5){image='images/dee/E01.jpg'};
		if(valeur==6){image='images/dee/A01.jpg'};
		return image;
	}
	
	function RemiseZero(){									// REMISE A ZERO DES IMAGE DE DEE DE COMBAT
		for (i=0;i<8;i++){ 
			CacheCase('DA'+i);
			CacheCase('DD'+i);
		}
	}
	
	function LancerdeeAtt(NbLancer,Mode){ 					// MODULE DE LANCER DE DEE DE COMBAT RETOUR UN NOMBRE 
		var dee =0;
		for (i=0;i<NbLancer;i++){ 

			if(Mode==0){ //MODE ATTAQUE
				Valeur = Math.floor(Math.random()*(6 -1+1))+1;
				document.images['DA'+i+''].src=ValeurdeeAtt(Valeur);
				MontreElement('DA'+i+'');
				if (Valeur==2 || Valeur==4 || Valeur==6){dee=dee+1}
			}
				
			if(Mode==1){ //MODE DEFENCE
				Valeur = Math.floor(Math.random()*(6 -1+1))+1;
				document.images['DD'+i].src=ValeurdeeAtt(Valeur);
				MontreElement('DD'+i+'');
				if (Valeur==1 || Valeur==3){dee=dee+1}
			}
		}
		return dee
	}
	
	function LancerdeeAttaque(){ 							// MODULE DE COMBAT ENTRE N JOUEUR ET N MONSTRE
		if(LesJoueurs[ConstIdJoueur][8]==0){
			CaseDuMonstre = IsCombatre(LesMonstres,NbMonstre,LesJoueurs[ConstIdJoueur][5])
			if (CaseDuMonstre != -1 && LesJoueurs[ConstIdJoueur][8]==0 ) {  
				UneAttaque(CaseDuMonstre,0,"JOUEUR");
			}
			var imgMonstre = LesMonstres[CaseDuMonstre][0];
			$('Defenceur').src = Chemin + "/monstre/W" + imgMonstre + ".png";
			$('Attaquant').src = "image/personnage/NLB_aventurier.png";
				
			ActiveAction("Mn_Attaquer");
			//else { alert("Pas d'attaque possible"); }*
			LesJoueurs[ConstIdJoueur][8] = 1;
		}
	}
	
	function UneAttaque(IdMonstre,IdJoueurs,mode){ 			// MODULE DE COMBAT ENTRE N JOUEUR ET N MONSTRE
		//MODE SOIT JOUEUR
		//MODE MONSTRE
		if(mode=="MONSTRE"){
			$('Attaquant').src =  Chemin + '/monstre/W'+LesMonstres[IdMonstre][0]+'.png';
			$('Defenceur').src =  Chemin + 'image/personnage/NLB_aventurier.png';
		
			Perte = LancerdeeAtt(LesMonstres[IdMonstre][3],0) - LancerdeeAtt(LesJoueurs[IdJoueurs][1],1);
		
			if (Perte > 0 ) { PerteVieJoueur(LesJoueurs,IdJoueurs,Perte) }
			
		}
		if(mode=="JOUEUR"){
			Perte = LancerdeeAtt(LesJoueurs[IdJoueurs][1],0)-LancerdeeAtt(LesMonstres[IdMonstre][3],1);
			if (Perte > 0 ) { PerteVieMonstre(LesMonstres,IdMonstre,Perte) }
			LesJoueurs[0][8]=1;
		}
	}
	
	function IsCombatre(LesMonstres,NbMonstre,Joueur){		// DEFINIE SI UN JOUEUR PEUT COMBATRE UN MONSTRE 
		Controle = -1;	
		for (i=0;i<NbMonstre;i++){ 
			if (LesMonstres[i][8]==1) {
				Combatre=Joueur-LesMonstres[i][7];
					if( Combatre==1 || Combatre==-1 || Combatre==26 || Combatre==-26 ){ 
						Controle=i;	
					} 	 
			}
		}
		return	 Controle
	}
	
	function PerteVieMonstre(LesMonstres,IdMonstre,Perte){	// DEFINIE LA PERTE DE POINT DE VIE D UN MONSTRE ET SA MORT
		LesMonstres[IdMonstre][4]=LesMonstres[IdMonstre][4]-Perte;
		if (LesMonstres[IdMonstre][4] < 1 )
		{
			LesMonstres[IdMonstre][8]=-1;
			CacheCase(LesMonstres[IdMonstre][7]);
		}
	}
	
	function PerteVieJoueur(LesJoueurs,IdJoueurs,Perte){	// DEFINIE LA PERTE DE POINT DE VIE D UN MONSTRE ET SA MORT  
		LesJoueurs[IdJoueurs][3]= LesJoueurs[IdJoueurs][3] - Perte;
		CaracHero();
		if (LesJoueurs[IdJoueurs][3] < 1 )
		{
			CacheCase(LesJoueurs[IdJoueurs][6]);
		}
	}
	