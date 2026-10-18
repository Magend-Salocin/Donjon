	function Victoire(){
		var Victoire = true;
		for (i=0;i<LesMonstres.length;i++){ 
				if (LesMonstres[i][10]==false){
					Victoire = false;
				}
		}
		return Victoire
	}