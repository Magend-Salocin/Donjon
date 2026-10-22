/*
	Types de monstres, indexes par le numero utilise dans les quetes : TabMonstre(type, case, piece).
	Le numero est aussi reference par bin/import-heroquest.py.

	deplacement, attaque, defense, corps, esprit : caracteristiques de depart
	image        : pion sur le plateau, dans images/monstre/
	imageCombat  : gros plan pendant un combat, dans images/monstre/
	sprite       : prefixe des images de la vue iso (iso/atlas.js), 'orc' si absent
*/
var CONFIG_MONSTRES = {
	1:  { nom: 'Lutin',          deplacement: 10, attaque: 2, defense: 1, corps: 1, esprit: 1, image: '00.bmp', imageCombat: 'WLutin.png', sprite: 'gobelin' },
	2:  { nom: 'Orc',            deplacement: 8,  attaque: 3, defense: 2, corps: 1, esprit: 2, image: '01.bmp', imageCombat: 'WOrc.png', sprite: 'orc' },
	3:  { nom: 'Femir',          deplacement: 6,  attaque: 3, defense: 3, corps: 1, esprit: 3, image: '02.bmp', imageCombat: 'WFemir.jpg', sprite: 'fimir' },
	4:  { nom: 'Gargouille',     deplacement: 6,  attaque: 4, defense: 4, corps: 1, esprit: 4, image: '03.bmp', imageCombat: 'WGargouille.png', sprite: 'gargouille' },
	5:  { nom: 'GuerrierChaos',  deplacement: 6,  attaque: 3, defense: 4, corps: 1, esprit: 3, image: '04.bmp', imageCombat: 'WGuerrierChaos.jpg', sprite: 'chaos' },
	6:  { nom: 'ChamanOrc',      deplacement: 8,  attaque: 3, defense: 2, corps: 6, esprit: 4, image: '05.bmp', imageCombat: 'WChamanOrc.png', sprite: 'orc' },
	7:  { nom: 'Ogre',           deplacement: 8,  attaque: 3, defense: 2, corps: 6, esprit: 4, image: '06.bmp', imageCombat: 'WOgre.png' },
	8:  { nom: 'OgreAncien',     deplacement: 8,  attaque: 3, defense: 2, corps: 6, esprit: 4, image: '07.bmp', imageCombat: 'WOgreAncien.png' },
	9:  { nom: 'OgreGuerrier',   deplacement: 8,  attaque: 3, defense: 2, corps: 6, esprit: 4, image: '08.bmp', imageCombat: 'WOgreGuerrier.png' },
	10: { nom: 'OgreChef',       deplacement: 8,  attaque: 3, defense: 2, corps: 6, esprit: 4, image: '09.bmp', imageCombat: 'WOgreChef.png' },
	11: { nom: 'OgreNeige',      deplacement: 8,  attaque: 3, defense: 2, corps: 6, esprit: 4, image: '10.bmp', imageCombat: 'WOgreNeige.png' },
	12: { nom: 'Yeti',           deplacement: 8,  attaque: 3, defense: 2, corps: 6, esprit: 4, image: '11.bmp', imageCombat: 'WYeti.png' },
	13: { nom: 'Loup',           deplacement: 8,  attaque: 3, defense: 2, corps: 6, esprit: 4, image: '12.bmp', imageCombat: 'WLoup.png' },
	14: { nom: 'DemonNeige',     deplacement: 8,  attaque: 3, defense: 2, corps: 6, esprit: 4, image: '13.bmp', imageCombat: 'WDemonNeige.png' },
	15: { nom: 'Squellette',     deplacement: 6,  attaque: 2, defense: 2, corps: 1, esprit: 0, image: '16.bmp', imageCombat: 'WSquellette.png', sprite: 'squelette' },
	16: { nom: 'Zombie',         deplacement: 4,  attaque: 2, defense: 3, corps: 1, esprit: 0, image: '17.bmp', imageCombat: 'WZombie.png', sprite: 'zombie' },
	17: { nom: 'Momie',          deplacement: 4,  attaque: 3, defense: 4, corps: 1, esprit: 0, image: '18.bmp', imageCombat: 'WMomie.png', sprite: 'momie' },
	18: { nom: 'MageSquellette', deplacement: 8,  attaque: 3, defense: 2, corps: 6, esprit: 4, image: '19.bmp', imageCombat: 'WMageSquellette.png', sprite: 'mage' },
	19: { nom: 'Sorcier',        deplacement: 8,  attaque: 3, defense: 2, corps: 6, esprit: 4, image: '99.bmp', imageCombat: 'WSorcier.png', sprite: 'mage' }
};

var DernierMonstreId = 1;

function TabMonstre(id,emplacement,Piece){
	// Nom-Deplacement-Attaque-Defence-Corp-Esprit-Image-Emplacement-Actif-Piece-Combatre
	//   0   -         1    -             2       -     3    -   4  -    5    -    6     -       7            -    8  -     9 -         10
	// Un numero inconnu reprend le type du monstre precedent (comportement de la v1, sans partager le meme tableau).
	var Config = CONFIG_MONSTRES[id];
	if (Config == null) { return TabMonstre(DernierMonstreId,emplacement,Piece); }
	DernierMonstreId = id;
	return new Array(Config.nom,Config.deplacement,Config.attaque,Config.defense,Config.corps,Config.esprit,Chemin+'/monstre/'+Config.image,emplacement,0,Piece,false);
}

/* Configuration d'un monstre en jeu, retrouvee par son nom (Monstre[0]). */
function ConfigMonstre(Monstre){
	for (var id in CONFIG_MONSTRES){
		if (CONFIG_MONSTRES[id].nom == Monstre[0]) { return CONFIG_MONSTRES[id]; }
	}
	return null;
}

/* Image du monstre affichee pendant un combat (imageCombat). */
function ImageCombatMonstre(Monstre){
	var Config = ConfigMonstre(Monstre);
	return Chemin + '/monstre/' + (Config ? Config.imageCombat : 'W' + Monstre[0] + '.png');
}

/* Prefixe des images du monstre dans l'atlas iso (sprite). */
function SpriteMonstre(Monstre){
	var Config = ConfigMonstre(Monstre);
	return (Config && Config.sprite) || 'orc';
}
