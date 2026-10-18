
	function RemiseZero(){									// REMISE A ZERO DES IMAGE DE DEE DE COMBAT
		for (var i=0;i<8;i++){
			ArreteDe($('DA'+i));
			ArreteDe($('DD'+i));
			CacheCase('DA'+i);
			CacheCase('DD'+i);
		}
		NumeroCombat++;
		$('BilanCombat').innerHTML = '';
		$('Defenceur').style.display="none";
		$('Attaquant').style.display="none";
	}

	function LancerdeeAtt(NbLancer,Mode){ 					// MODULE DE LANCER DE DEE DE COMBAT RETOUR UN NOMBRE
		var Prefixe = Mode==0 ? 'DA' : 'DD';
		var FaceUtile = Mode==0 ? 'crane' : 'bouclier-blanc';	// attaque : un crane touche ; defense : un bouclier blanc pare
		var dee =0;
		var NbDes = Math.max(1, Math.min(8, parseInt(NbLancer)));
		for (var i=0;i<8;i++){
			var De = $(Prefixe+i);
			if (i >= NbDes) { ArreteDe(De); CacheCase(Prefixe+i); continue; }	// des restes d'un lancer precedent plus grand
			var Face = FaceCombat(Math.floor(Math.random()*6)+1);
			MontreElement(Prefixe+i);
			De.classList.add(Face==FaceUtile ? 'de-compte' : 'de-ignore');
			AnimerDe(De, DES_FACES_COMBAT, Face);
			if (Face==FaceUtile){dee=dee+1}
		}
		return dee
	}

	var NumeroCombat = 0;									// evite d'afficher le bilan d'un combat deja efface

	function AfficheBilanCombat(Touches,Parades){			// "3 cranes - 1 bouclier = 2 blessures" apres l'animation
		var Perte = Touches - Parades;
		var Texte = Pluriel(Touches, 'cr&acirc;ne') + ' - ' + Pluriel(Parades, 'bouclier') + ' : '
			+ (Perte > 0 ? Pluriel(Perte, 'blessure') : 'coup par&eacute;');
		var Numero = ++NumeroCombat;
		ApresLancer(function(){
			if (Numero == NumeroCombat) { $('BilanCombat').innerHTML = Texte; }
		});
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
		var Touches, Parades;
		if(mode=="MONSTRE"){
			AfficheAttaquantDefenceur(ImageCombatMonstre(LesMonstres[IdMonstre]),LesJoueurs[IdJoueurs][13]);
			Touches = LancerdeeAtt(LesMonstres[IdMonstre][2],0);
			Parades = LancerdeeAtt(LesJoueurs[IdJoueurs][2],1);
			if (Touches > Parades) { PerteVieJoueur(LesJoueurs,IdJoueurs,Touches - Parades) }
		}
		if(mode=="JOUEUR"){
			Touches = LancerdeeAtt(LesJoueurs[IdJoueurs][1],0);
			Parades = LancerdeeAtt(LesMonstres[IdMonstre][3],1);
			if (Touches > Parades) { PerteVieMonstre(LesMonstres,IdMonstre,Touches - Parades) }
			LesJoueurs[IdJoueurs][8]=1;
		}
		AfficheBilanCombat(Touches, Parades);
	}

	function IsCombatre(LesMonstres,Joueur){				// MONSTRE ACTIF SUR UNE CASE VOISINE, OU -1
		var Controle = -1;
		for (var i=0;i<LesMonstres.length;i++){
			if (LesMonstres[i][8]==1) {
				var Combatre=Joueur-LesMonstres[i][7];
				if( (Combatre==1 || Combatre==-1 || Combatre==26 || Combatre==-26) && !PassageBloque(Joueur,LesMonstres[i][7]) ){
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
			LibereCase(LesMonstres[IdMonstre][7]);
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
