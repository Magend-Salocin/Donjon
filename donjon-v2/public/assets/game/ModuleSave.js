
	/*
	 * Sauvegarde de la partie vers public/api.php.
	 * ApiUrl et CsrfToken sont definis par la page du donjon (templates/pages/jeu.php).
	 */

	function AppelApi(Action, Parametres){
		return fetch(ApiUrl + '?action=' + Action, {
			method: 'POST',
			headers: { 'X-CSRF-Token': CsrfToken },
			body: new URLSearchParams(Parametres || {})
		}).then(function (Reponse) {
			return Reponse.json().then(function (Donnees) {
				if (!Reponse.ok) { throw new Error(Donnees.error || 'Erreur ' + Reponse.status); }
				return Donnees;
			});
		}).catch(function (Erreur) {
			AfficheMessage('Sauvegarde impossible : ' + Erreur.message);
			throw Erreur;
		});
	}

	function MyHeroSave(){
		var Heros = LesJoueurs[ConstIdJoueur];
		Heros[12][3]  = Heros[3];
		Heros[12][15] = Heros[10];
		return AppelApi('save-hero', { pv2: Heros[3], ors: Heros[10] });
	}

	function MyItemRetrait(IdItem){
		return AppelApi('item-remove', { objet: IdItem });
	}

	function MyItemAjout(IdItem){
		return AppelApi('item-add', { objet: IdItem }).then(MyHeroReloadItem);
	}

	function MyHeroReloadItem(){
		return AppelApi('inventory').then(function (Donnees) {
			SetMesObjet(Donnees.items);
			$('myHeroItemListe').innerHTML = Donnees.html;
		});
	}

	/* MesObjet[i] : 0 heros, 1 num, 2 quantite, 3 num, 4 libelle, 5 effet, 6 valeur, 7 image, 8 categorie, 9 emplacement */
	function SetMesObjet(Objets){
		MesObjet = Objets.map(function (Objet) {
			return [MyHeroNum, String(Objet.num), Number(Objet.nb), Objet.num, Objet.libelle, Objet.effet, Number(Objet.valeur), Objet.image, Objet.catheg, Objet.autre];
		});
	}

	function MyPartieFin(Resultat){
		var Heros = LesJoueurs[ConstIdJoueur];
		return AppelApi('finish', { resultat: Resultat, pv2: Heros[3], ors: Heros[10] });
	}
