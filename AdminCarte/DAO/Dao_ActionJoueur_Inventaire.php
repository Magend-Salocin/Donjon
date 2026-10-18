<?php
	/******AUTEUR*********************************
	***	BERGER NICOLAS 				           ****
	***	EMAIL: Berger.n@hotmail.fr     		   ****
	***	Code Auto-Généré					   ****
	***	Modifié par  :			  		       ****	
	***	Le:				  			           ****	
	***	Motif:			  			           ****											
	***********************************************/
		
	/*********************************/
	/*		Old Methode		*/
	/*********************************/
	
	function GetInventaire($hero){
	$Inventaire=" SELECT *  FROM objethero, objet WHERE hero ='".$hero."' AND catheg='item' AND  objet = num ";
		return ExecuteRequete($Inventaire);
	}
	
	function GetEquipement($hero){
	$Inventaire=" SELECT *  FROM objethero, objet WHERE hero ='".$hero."' AND catheg='equip' AND  objet = num ";
		return ExecuteRequete($Inventaire);
	}
	
	function GetObjetInventaire($item,$hero){
		$Inventaire="SELECT * FROM objethero, objet WHERE hero='".$hero."' AND objet='".$item."' AND objet=num";
		return GetLigne(ExecuteRequete($Inventaire));
	}
	
	function GetUtiliseObjet($item,$hero){
		//RECHERCHE DES ERREURS LIEE A UTILISATION DES OBJET
		$erreur="";	$test=0; $O=GetObjet($item);	$H=$_SESSION["tab"];	
		if ($O['effet']=="pv2"){  if ($H["pv2"]==$H["pv"]){$erreur="pv";} }
		if ($O['effet']=="pm2"){  if ($H["pm2"]==$H["pm"]){$erreur="pm";} }
		if ($erreur==""){
		
			//DININUE LE STOCKE DE 1 OU LE SUPPRIMME
			$objet=GetObjetInventaire($item,$hero);
			if ($objet[2]>1)	{EnleverObjet($hero,$item,$objet[2]);}
			else 				{SuppObjet($hero,$item);}
				
			//UTILISE OBJET SANS DEPASSER LES LIMITES
				if ($objet[6]=="pv2"){ $C=$H["pv2"]+$O["valeur"]; if ($C>$H["pv"]){$valeur=$H["pv"]; $test=1;} }
				if ($objet[6]=="pm2"){ $C=$H["pm2"]+$O["valeur"]; if ($C>$H["pm"]){$valeur=$H["pm"]; $test=1;} }
				if ($test==0){	$valeur = $H["$objet[6]"] + $objet[7];	}
				Modif($objet[6],$valeur,$hero);
				$H["$objet[6]"]=$valeur;	SetJoueur($H);
				afficheText($_GET['text'],"item");
				
		}
		else {affichErreur($erreur);}
	}
	
	function GetEquipeObjet($item,$hero){// 	NomObjet==$O[1];	champs==$O[3]:	ValeurObjet==$O[4];  ChampsObjetJoueur==$O[7];
		$row=$_SESSION["tab"];			$O=GetObjet($item);		
		$Text = "On ne peut pas s\?ipe de => $O[1] ! vous lavez deja";
		if($row["$O[7]"]!=$O[1]){
		$valeur = $row["$O[3]"] + $O[4];	$row["$O[3]"]=$valeur;		$row["$O[7]"]=$O[1];
		$Requete="UPDATE joueur SET ".$O[3]." = '".$valeur."' ,".$O[7]." = '".$O[1]."' WHERE num = '".$hero."' ";
		ExecuteRequete($Requete);	SetJoueur($row);
		$Text = afficheText($_GET['text'],"equip");
		
		}
		
		return $Text;
	}
	
	function GetDeequipeObjet($champ){
		$row=$_SESSION["tab"];				$libelle=$row["$champ"];
		$O=GetObjetName($libelle);			$valeur = $row["$O[3]"] - $O[4];
		$row["$champ"]="rien";				$row["$O[3]"]=$valeur;	
			
		$Requete="UPDATE joueur SET ".$O[3]." = '".$valeur."' ,".$champ." = 'rien' WHERE num = '".$row[0]."' ";
		ExecuteRequete($Requete);			SetJoueur($row);
		afficheText($O[1],"dequip");
		
	}

	function GetPossedeObjet($item,$heros){
		$Objet="SELECT * FROM objethero WHERE objet= '".$item."' and hero= '".$heros."'  ";
		$row=GetLigne(ExecuteRequete($Objet));
		return $row['nb'];
	}
	
	function CreeObjet($heros,$item,$nb){
		$sql = "INSERT INTO objethero ( hero, objet ,  nb ) VALUES ('$heros', '$item' , '1')";
		ExecuteRequete($sql);
	}
	
	function SuppObjet($heros,$item){
		$sql = "DELETE FROM objethero  WHERE hero='".$heros."' AND objet='".$item."'"; 
		ExecuteRequete($sql);
	}
	
	function AjoutObjet($heros,$item,$nb){
		$nb = $nb + 1;
		$sql = "UPDATE objethero SET nb = '".$nb."' WHERE hero='".$heros."' AND objet='".$item."'"; 
		ExecuteRequete($sql);
	}
	
	function EnleverObjet($heros,$item,$nb){
		$nb = $nb - 1;
		echo $sql = "UPDATE objethero SET nb = '".$nb."' WHERE hero='".$heros."' AND objet='".$item."'"; 
		ExecuteRequete($sql);
	}
	

	?>