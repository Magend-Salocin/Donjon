
	var Chemin ="assets/game/images";
	var MovementJoueur 	= 0;
	var ConstIdJoueur 	= 0;
	var LesTresors  	= GetAllTabTresor();
	var MonstreTuer 	= 0;
	var LesJoueurs   	= new Array();
	var LesEffets   	= new Array();
	var MesObjet   		= new Array();
	var DernierMonstreId = 1;

	function TabObjet(id){
		//  Type =  Nom-image-cible-valuer-text-IDBase
		//   0   -    1    -    2   -     3   -   4  -  5 - 6
		//  Type : 0 potion (objet 995 a 999), 1 or, 2 piege, 9 rien
		var Item = null;
		if (id == 1)  { Item = new Array(1,'Or!',Chemin+'/','or',10,"Un maigre butin de 10 pi&egrave;ce d'or est d&eacute;couvert dans la poche d'un vieux pourpoint malodorant.",-1); }
		if (id == 3)  { Item = new Array(1,'Or!',Chemin+'/','or',25,"Dans un fouillis de vieux chiffons, manteaux de fourrure &eacute;lim&eacute;s et couvertures tach&eacute;es, vous d&eacute;couvrez 25 pi&egrave;ce d'or.",-1); }
		if (id == 4)  { Item = new Array(1,'Or!',Chemin+'/','or',20,"La fouille de vieux vêtements vous permet de d&eacute;couvrir 20 pi&egrave;ce d'or.",-1); }
		if (id == 5)  { Item = new Array(1,'Or!',Chemin+'/','or',25,"Cette boîte contenant 25 pi&egrave;ces d'or a &eacute;t&eacute; abandonn&eacute; par un inconscient qui n'a même pas song&eacute; à la dissimuler",-1); }
		if (id == 6)  { Item = new Array(1,'Or!',Chemin+'/','or',50,"Vous avez rep&eacute;r&eacute; une pierre descell&eacute;e derri&egrave;re laquelle se trouve dissimul&eacute;e une petite bourse en cuir envelop&eacute;e d'un vieux chiffon. Celle-ci contient 50 pi&egrave;ce d'or.",-1); }
		if (id == 7)  { Item = new Array(1,'Bijoux!',Chemin+'/','or',50,"Vous trouvez un petit coffre de bois, d'apparence ordinaire et plutôt vieux, mais à l'int&eacute;rieur sur une doublure de velours , reposent des bijoux d'une valeur de 50 pi&egrave;ces d'or",-1); }
		if (id == 8)  { Item = new Array(1,'Pierre pr&eacute;cieuse!',Chemin+'/','or',50,"Nich&eacute;e au fond d'une vieille botte , vous d&eacute;couvrez une pierre pr&eacute;cieuse d'une valeur de 50 pi&egrave;ces d'or",-1); }
		if (id == 9)  { Item = new Array(1,'Fabuleux tr&eacute;sor!',Chemin+'/','or',100,"La chance est avec vous. Un petit coffre que vous trouvez dissimul&eacute; sous une vielle fourrure contient 100 pi&egrave;ce d'or",-1); }
		if (id == 10)  { Item = new Array(0,'Potion de r&eacute;sistance',Chemin+'/','def',2,"Parmi toute une collection de vieux flacons et pots en terre , vous d&eacute;couvrez une petite fiole claire contenant une potion de r&eacute;sistance. Celle-ci peut être prise à tout moment. Votre d&eacute;fense augmentera de deux.",998); }
		if (id == 11)  { Item = new Array(0,'Potion de vitesse',Chemin+'/','dee',2,"Vous rep&eacute;rez un flacon poussi&eacute;reux sur une &eacute;tag&egrave;re. En le nettoyant , vous vous rendez compte qu'il s'agit d'une potion de vitesse. Celle-ci peut être bue à tout moment. Elle vous permettra de relancer les d&eacute;s de d&eacute;placement.",996); }
		if (id == 12)  { Item = new Array(0,'Potion de force',Chemin+'/','for',2,"Vous trouvez un petit flacon rempli de liquide pourpre. Il s'agit d'une potion de force. Vous pouvez la boire à tout moment. Elle vous permettra de lancer deux d&eacute;s de combat en plus pour attaquer.",997); }
		if (id == 14)  { Item = new Array(0,'Potion de gu&eacute;rison',Chemin+'/','or',10,"Vous d&eacute;couvrez un petit flacon envelopp&eacute; de vieux chiffons et en reconnaissez tout de suite le contenu : il s'agit d'une potion de gu&eacute;rison. Celle-ci peut être bue à tout moment. Elle vous restituera quatre points de vie perdus.",999); }
		if (id == 15)  { Item = new Array(0,'Potion de gu&eacute;rison',Chemin+'/','or',10,"Vous d&eacute;couvrez un petit flacon envelopp&eacute; de vieux chiffons et en reconnaissez tout de suite le contenu : il s'agit d'une potion de gu&eacute;rison. Celle-ci peut être bue à tout moment. Elle vous restituera quatre points de vie perdus.",999); }
		if (id == 16)  { Item = new Array(0,'Breuvage h&eacute;roïque',Chemin+'/','or',2,"Un sac de cuir accroch&eacute; au mur contient une potion. Il s'agit d'un breuvage h&eacute;roïque. Celui-ci peut être pris juste avant de lancer un combat. Le joueur qui absorbe cette potion pourra , le temps d'un tour seulement , attaquer deux fois au lieu d'une.",995); }
		if (id == 17)  { Item = new Array(9,'Rien',Chemin+'/','','',"En d&eacute;pit d'un fouille m&eacute;ticuleuse , vous ne trouvez rien.",-1); }
		if (id == 18)  { Item = new Array(2,'Pi&egrave;ge!',Chemin+'/','Vie',-1,"Une dalle c&egrave;de sous votre pied et vous vous rendez compte trop tard qu'il s'agit d'un pi&egrave;ge. Vous tombez dans une fosse et perdez un point de Corps.",-1); }
		if (id == 19)  { Item = new Array(2,'Pi&egrave;ge!',Chemin+'/','Vie',-1,"La pression d'un fil contre votre jambe vous avertit du danger et vous faites volte-face ... Mais il est trop tard! Le carreau d'une arbal&egrave;te vous coûte un point de Corps",-1); }
		if (id == 20)  { Item = new Array(2,'Pi&egrave;ge!',Chemin+'/','Vie',-1,"Au cours de vos recherches , vous d&eacute;clenchez accidentellement un pi&egrave;ge. Une fl&egrave;che jaillit du mur et vous atteint. Vous perdez un point de Corps",-1); }
		return Item;
	}

	function GetAllTabTresor(){
		var LesTresors  = new Array();
		for (var i=1;i<25;i++){
			var LeTresor = TabObjet(i);
			if(LeTresor != null){ LesTresors[LesTresors.length] = LeTresor; }
		}
		return LesTresors;
	}

	function TabMonstre(id,emplacement,Piece){
		// Nom-Deplacement-Attaque-Defence-Corp-Esprit-Image-Emplacement-Actif-Piece-Combatre
		//   0   -         1    -             2       -     3    -   4  -    5    -    6     -       7            -    8  -     9 -         10
		// Un numero inconnu reprend le type du monstre precedent (comportement de la v1, sans partager le meme tableau).
		var Monstre = null;
		if (id == 1)  { Monstre = new Array('Lutin',10,2,1,1,1,Chemin+'/monstre/00.bmp',emplacement,0,Piece,false); }
		if (id == 2)  { Monstre = new Array('Orc',8,3,2,1,2,Chemin+'/monstre/01.bmp',emplacement,0,Piece,false); }
		if (id == 3)  { Monstre = new Array('Femir',6,3,3,1,3,Chemin+'/monstre/02.bmp',emplacement,0,Piece,false); }
		if (id == 4)  { Monstre = new Array('Gargouille',6,4,4,1,4,Chemin+'/monstre/03.bmp',emplacement,0,Piece,false); }
		if (id == 5)  { Monstre = new Array('GuerrierChaos',6,3,4,1,3,Chemin+'/monstre/04.bmp',emplacement,0,Piece,false);  }
		if (id == 6)  { Monstre = new Array('ChamanOrc',8,3,2,6,4,Chemin+'/monstre/05.bmp',emplacement,0,Piece,false); }
		if (id == 7)  { Monstre = new Array('Ogre',8,3,2,6,4,Chemin+'/monstre/06.bmp',emplacement,0,Piece,false); }
		if (id == 8)  { Monstre = new Array('OgreAncien',8,3,2,6,4,Chemin+'/monstre/07.bmp',emplacement,0,Piece,false); }
		if (id == 9)  { Monstre = new Array('OgreGuerrier',8,3,2,6,4,Chemin+'/monstre/08.bmp',emplacement,0,Piece,false); }
		if (id == 10) { Monstre = new Array('OgreChef',8,3,2,6,4,Chemin+'/monstre/09.bmp',emplacement,0,Piece,false); }
		if (id == 11) { Monstre = new Array('OgreNeige',8,3,2,6,4,Chemin+'/monstre/10.bmp',emplacement,0,Piece,false); }
		if (id == 12) { Monstre = new Array('Yeti',8,3,2,6,4,Chemin+'/monstre/11.bmp',emplacement,0,Piece,false); }
		if (id == 13) { Monstre = new Array('Loup',8,3,2,6,4,Chemin+'/monstre/12.bmp',emplacement,0,Piece,false); }
		if (id == 14) { Monstre = new Array('DemonNeige',8,3,2,6,4,Chemin+'/monstre/13.bmp',emplacement,0,Piece,false); }
		if (id == 15) { Monstre = new Array('Squellette',6,2,2,1,0,Chemin+'/monstre/16.bmp',emplacement,0,Piece,false); }
		if (id == 16) { Monstre = new Array('Zombie',4,2,3,1,0,Chemin+'/monstre/17.bmp',emplacement,0,Piece,false); }
		if (id == 17) { Monstre = new Array('Momie',4,3,4,1,0,Chemin+'/monstre/18.bmp',emplacement,0,Piece,false); }
		if (id == 18) { Monstre = new Array('MageSquellette',8,3,2,6,4,Chemin+'/monstre/19.bmp',emplacement,0,Piece,false); }
		if (id == 19) { Monstre = new Array('Sorcier',8,3,2,6,4,Chemin+'/monstre/99.bmp',emplacement,0,Piece,false); }

		if (Monstre == null) { return TabMonstre(DernierMonstreId,emplacement,Piece); }
		DernierMonstreId = id;
		return Monstre;
	}

	/* Image du monstre affichee pendant un combat (W<Nom>.png ou .jpg). */
	function ImageCombatMonstre(Monstre){
		var EnJpg = (Monstre[0] == 'Femir' || Monstre[0] == 'GuerrierChaos');
		return Chemin + '/monstre/W' + Monstre[0] + (EnJpg ? '.jpg' : '.png');
	}
