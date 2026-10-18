	function getXhr(){
		var xhr = null;
		if (window.XMLHttpRequest)	{ xhr = new XMLHttpRequest();}
		else {
			if(window.ActiveXObject){
				try			{xhr = new ActiveXObject("Msxml2.XMLHTTP");}
				catch (e) 	{xhr = new ActiveXObject("Microsoft.XMLHTTP");}
			}
		
			else {
				alert("votre navigateur ne supporte pas xhr..");
				xhr = fasle ;
			}
		}
		return xhr
	}	
		
		

		
	function MyHeroSave(){
	
		var xhr = getXhr()
		
		xhr.onreadystatechange = function() {
			if(xhr.readyState == 4 && xhr.status == 200) {
				
			} 
		}

	
		//LesJoueurs[0][3] 	 = new Array(LeMagend[1],3,2,LeMagend[2],2,2,'images/avatars/00.bmp','0',0,0,LeMagend[15]);
		
		LeMagend[2]   = LesJoueurs[0][3]; 
		LeMagend[15]  = LesJoueurs[0][10]; 
		
		var url = 'Vues/Ajax-SaveJoueur.php';
		var parametres = 'MyHero=' 			+ MyHeroId ;
		parametres +=  '&MyHero_pv=' 		+ LeMagend[2] ;
		parametres +=  '&MyHero_pv2='  		+ LeMagend[3];
		parametres +=  '&MyHero_pm=' 		+ LeMagend[4] ;
		parametres +=  '&MyHero_pm2='  		+ LeMagend[5];
		parametres +=  '&MyHero_forc=' 		+ LeMagend[6] ;
		parametres +=  '&MyHero_end='  		+ LeMagend[7];
		parametres +=  '&MyHero_inti=' 		+ LeMagend[8] ;
		parametres +=  '&MyHero_dext='  	+ LeMagend[9];
		parametres +=  '&MyHero_vit=' 		+ LeMagend[10] ;
		parametres +=  '&MyHero_cha='  		+ LeMagend[11];
		parametres +=  '&MyHero_man=' 		+ LeMagend[12] ;
		parametres +=  '&MyHero_ppm='  		+ LeMagend[13];
		parametres +=  '&MyHero_exp=' 		+ LeMagend[14] ;
		parametres +=  '&MyHero_ors=' 		+ LeMagend[15] ;
		parametres +=  '&MyHero_codeexp='  	+ LeMagend[16];
		parametres +=  '&MyHero_nivsuv=' 	+ LeMagend[17] ;
		parametres +=  '&MyHero_cexp='  	+ LeMagend[18];
		parametres +=  '&MyHero_nbexp=' 	+ LeMagend[19] ;	
		parametres +=  '&MyHero_Arme='  	+ LeMagend[24];
		parametres +=  '&MyHero_Bouclier=' 	+ LeMagend[25] ;
		parametres +=  '&MyHero_Casque='  	+ LeMagend[26];
		parametres +=  '&MyHero_Plastron=' 	+ LeMagend[27] ;
		parametres +=  '&MyHero_AvantBras=' + LeMagend[28];
		parametres +=  '&MyHero_Botte=' 	+ LeMagend[29] ;
		parametres +=  '&MyHero_Jambiere='  + LeMagend[30];
		


		xhr.open("POST",url,true);
		xhr.setRequestHeader('Content-Type','application/x-www-form-urlencoded');
		xhr.send(parametres);
		
	}
	
	function MyPartieSave(){
	
		var xhr = getXhr()
		
		xhr.onreadystatechange = function() {
			if(xhr.readyState == 4 && xhr.status == 200) {
				
			} 
		}

	
		var url = 'Vues/Ajax-SavePartie.php';
		var LesMonstreSave = null;
		for (i=0;i<LesMonstres.length;i++){ 
			
			LesMonstreSave += LesMonstres[i] +'@';
			
		}
		
		var parametres = 'MyHero=' 			+ MyHeroId ;
		parametres +=  '&LesJoueurs=' 					+ LesJoueurs ;
		parametres +=  '&MesPieces=' 					+ MesPieces ;
		parametres +=  '&MesPortes='  					+ MesPortes;
		parametres +=  '&MesPortesPieceActive=' 		+ MesPortesPieceActive ;
		parametres +=  '&MesMonstres='  				+ MesMonstres;
		parametres +=  '&LesMonstres=' 					+ LesMonstreSave ;
		parametres +=  '&NbMonstre='  					+ NbMonstre;
		parametres +=  '&PieceFouiller=' 				+ PieceFouiller ;
		parametres +=  '&PieceActiver=' 				+ PieceActiver ;
		
		
		

		xhr.open("POST",url,true);
		xhr.setRequestHeader('Content-Type','application/x-www-form-urlencoded');
		xhr.send(parametres);
		
	}
	
	function MyPartieFin(){
	
		var xhr = getXhr()
		xhr.onreadystatechange = function() {
			if(xhr.readyState == 4 && xhr.status == 200) {
			} 
		}

		var url = 'Vues/Ajax-PartieFin.php';
		var parametres = 'MyHero=' 			+ MyHeroId ;

		xhr.open("POST",url,true);
		xhr.setRequestHeader('Content-Type','application/x-www-form-urlencoded');
		xhr.send(parametres);
		
	}