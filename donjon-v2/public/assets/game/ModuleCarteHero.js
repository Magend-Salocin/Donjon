
	function CaracHero(){
		ReloadCaracHero();
		MyHeroSave();
	}

	function ReloadCaracHero(){
		var Heros = LesJoueurs[ConstIdJoueur];
		var VieMax = parseInt(Heros[12][2]);
		$('MyHeroOrs').innerHTML = Heros[10];
		$('MyHeroPv').innerHTML = Heros[3];
		$('MyHeroBarrePv').style.width = Math.max(0, Math.min(100, Math.floor(Heros[3] * 100 / VieMax))) + '%';
	}
