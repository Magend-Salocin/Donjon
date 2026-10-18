<?php
	/******AUTEUR*********************************
	***	BERGER NICOLAS 				   ****
	***	EMAIL: Berger.n@hotmail.fr     		   ****
	***	Code Auto-Généré					   ****
	***	Modifié par  :			  		   ****	
	***	Le:				  			    ****	
	***	Motif:			  			    ****											
	***********************************************/
	
	
	
	
	function UpdateStockMagazin($magazin,$item,$nb,$prix){
		//$nb = $nb - 1;
		$sql = "UPDATE objetproposer  SET prix= '".$prix."' , nb = '".$nb."' WHERE magazin ='".$magazin."' AND objet='".$item."'"; 
		ExecuteRequete($sql);
	}
	
	/*********************************/
	/*		Old Method	 		*/
	/*********************************/
	
	function GetLesObjet($village){
		$LesMagazins="SELECT libelle , resumer , effet , valeur , nb , prix , num , magazin , image
		FROM objetproposer , objet WHERE magazin = '".$village."' and num=objet  ";
		return ExecuteRequete($LesMagazins);
	}
	
	function GetObjet($num){
		$Objet="SELECT * FROM  objet WHERE num = '".$num."'";
		return GetLigne(ExecuteRequete($Objet));
	}
	
	function GetObjetName($libelle){
		$Objet="SELECT * FROM  objet WHERE libelle = '".$libelle."'";
		return GetLigne(ExecuteRequete($Objet));
	}
	
	
	function GetObjetMagazin($item,$magazin){
		$Objet="SELECT * FROM objetproposer,objet WHERE num='".$item."' and magazin='".$magazin."' and num=objet ";
		return GetLigne(ExecuteRequete($Objet));
	}
		
	function GetAcheter($item,$ors,$heros,$magazin){
	
		$row=GetObjetMagazin($item,$magazin);
		if($ors < $row['prix'])	{ print "Vous n'avez pas assez d'or"; }
		else					{ print "Vous venez d'acquerir l'objet selectionner";
			
			$nb=GetPossedeObjet($item,$heros); 
			if($nb!=0)		{ AjoutObjet($heros,$item,$nb); }
			else 			{ CreeObjet($heros,$item,$nb);  }
			$ors= $ors - $row['prix'];
			Modif("ors",$ors,$heros);	$_SESSION["ors"] = $ors;
			if($row['nb']!=1) {UpStock($magazin,$item,$row['nb']);}
			else {DelStock($magazin,$item);}
		}	
	}
	
	function UpStock($magazin,$item,$nb){
		//$nb = $nb - 1;
		$sql = "UPDATE objetproposer  SET nb = '".$nb."' WHERE magazin ='".$magazin."' AND objet='".$item."'"; 
		ExecuteRequete($sql);
	}
	

	
	function DelStock($magazin,$item){
		$sql = "DELETE FROM objetproposer  WHERE magazin ='".$magazin."' AND objet='".$item."'"; 
		ExecuteRequete($sql);
	}
	
	/*********************************/
	/*		Table Objet 		*/
	/*********************************/
	


	function GetobjetId($Idobjet){
	     $MonSQL   = 'SELECT * FROM objet where num='.$Idobjet.' ';
	     $Curseur = ExecuteRequete($MonSQL);  return GetLigne($Curseur); 
	}

	function Insertobjet($num,$libelle,$resumer,$effet,$valeur,$image,$catheg,$autre){
	     $MonSQL  = '  INSERT INTO objet ( num,libelle,resumer,effet,valeur,image,catheg,autre) VALUES ( "'.$num.'","'.$libelle.'","'.$resumer.'","'.$effet.'","'.$valeur.'","'.$image.'","'.$catheg.'","'.$autre.'") ';
	     ExecuteRequete($MonSQL); 
	}

	function Updateobjet($num,$libelle,$resumer,$effet,$valeur,$image,$catheg,$autre){
		 $MonSQL  = ' UPDATE objet SET libelle="'.$libelle.'",resumer="'.$resumer.'",effet="'.$effet.'",valeur="'.$valeur.'",image="'.$image.'",catheg="'.$catheg.'",autre="'.$autre.'" Where num='.$num.' ';
		 ExecuteRequete($MonSQL); 
	 }

	function Deleteobjet($num,$libelle,$resumer,$effet,$valeur,$image,$catheg,$autre){
		 $MonSQL = ' DELETE From objet Where num='.$num.' '; 
		 ExecuteRequete($MonSQL); 
	}

	function GetobjetListe($Idobjet){
		$Lesobjet=Getobjet($Idobjet);
		$Uneobjet=GetLigne($Lesobjet);
		while ($Uneobjet){ 
			if($Uneobjet==$Idobjet){
				echo '<OPTION SELECTED value="$Uneobjet[0]">$Uneobjet[1]</OPTION>';
			}
			else{
				echo '<OPTION  value="$Uneobjet[0]">$Uneobjet[1]</OPTION>';
			}
			$Uneobjet=GetLigne($Lesobjet);
		}
	}
	
	/*********************************/
	/*		Table Objet Hero		*/
	/*********************************/
	
	function Getobjethero(){
	     $MonSQL  = 'SELECT * FROM objethero ';
	    return ExecuteRequete($MonSQL); 
	}

	function GetobjetheroId($Idobjethero){
	     $MonSQL   = 'SELECT * FROM objethero where hero='.$Idobjethero.' ';
	     $Curseur = ExecuteRequete($MonSQL);  return GetLigne($Curseur); 
	}

	function Insertobjethero($hero,$objet){
	     $MonSQL  = '  INSERT INTO objethero ( hero,objet) VALUES ( "'.$hero.'","'.$objet.'") ';
	     ExecuteRequete($MonSQL); 
	}

	function Updateobjethero($hero,$objet){
		 $MonSQL  = ' UPDATE objethero SET objet="'.$objet.'" Where hero='.$hero.' ';
		 ExecuteRequete($MonSQL); 
	 }

	function Deleteobjethero($hero,$objet){
		 $MonSQL = ' DELETE From objethero Where hero='.$hero.' '; 
		 ExecuteRequete($MonSQL); 
	}

	function GetobjetheroListe($Idobjethero){
		$Lesobjethero=Getobjethero($Idobjethero);
		$Uneobjethero=GetLigne($Lesobjethero);
		while ($Uneobjethero){ 
			if($Uneobjethero==$Idobjethero){
				echo '<OPTION SELECTED value="$Uneobjethero[0]">$Uneobjethero[1]</OPTION>';
			}
			else{
				echo '<OPTION  value="$Uneobjethero[0]">$Uneobjethero[1]</OPTION>';
			}
			$Uneobjethero=GetLigne($Lesobjethero);
		}
	}

	/*********************************/
	/*	Table Objet Proposer 		*/
	/*********************************/
	
	
	
	
	function Getobjetproposer(){
	     $MonSQL  = 'SELECT * FROM objetproposer ';
	    return ExecuteRequete($MonSQL); 
	}


	function GetobjetproposerId($Idobjetproposer){
	     $MonSQL   = 'SELECT * FROM objetproposer where magazin='.$Idobjetproposer.' ';
	     $Curseur = ExecuteRequete($MonSQL);  return GetLigne($Curseur); 
	}

	function Insertobjetproposer($magazin,$objet,$nb){
	     $MonSQL  = '  INSERT INTO objetproposer ( magazin,objet,nb) VALUES ( "'.$magazin.'","'.$objet.'","'.$nb.'") ';
	     ExecuteRequete($MonSQL); 
	}

	function Updateobjetproposer($magazin,$objet,$nb){
		 $MonSQL  = ' UPDATE objetproposer SET objet="'.$objet.'",nb="'.$nb.'" Where magazin='.$magazin.' ';
		 ExecuteRequete($MonSQL); 
	 }

	function Deleteobjetproposer($magazin,$objet,$nb){
		 $MonSQL = ' DELETE From objetproposer Where magazin='.$magazin.' '; 
		 ExecuteRequete($MonSQL); 
	}

	function GetobjetproposerListe($Idobjetproposer){
		$Lesobjetproposer=Getobjetproposer($Idobjetproposer);
		$Uneobjetproposer=GetLigne($Lesobjetproposer);
		while ($Uneobjetproposer){ 
			if($Uneobjetproposer==$Idobjetproposer){
				echo '<OPTION SELECTED value="$Uneobjetproposer[0]">$Uneobjetproposer[1]</OPTION>';
			}
			else{
				echo '<OPTION  value="$Uneobjetproposer[0]">$Uneobjetproposer[1]</OPTION>';
			}
			$Uneobjetproposer=GetLigne($Lesobjetproposer);
		}
	}
	
	
	?>