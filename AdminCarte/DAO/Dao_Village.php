<?php
	/******AUTEUR*********************************
	***	BERGER NICOLAS 				           ****
	***	EMAIL: Berger.n@hotmail.fr     		   ****
	***	Code Auto-Généré					   ****
	***	Modifié par  :			  		       ****	
	***	Le:				  			           ****	
	***	Motif:			  			           ****											
	***********************************************/
		
		
		
		
	function GetVillage($num){
		$MaRequete="SELECT * FROM village WHERE code= '".$num."'";
		$MonRs = ExecuteRequete($MaRequete);
		return GetLigne($MonRs);
	}
	
	function GetVoyage($dep,$arv){
		$MaRequete="SELECT temps FROM villagealler WHERE   villagedep  = '".$dep."' and villagearv  = '".$arv."' ";
		$MonRs = ExecuteRequete($MaRequete);
		return GetLigne($MonRs);
	}
	
	function GetAutreVillage($num){
	 	$MaRequete="SELECT * FROM village, villagealler WHERE villagedep = '".$num."' AND villagearv = code";
		return ExecuteRequete($MaRequete);
	}

	function GetAfficheVillage($village){
		$village = GetAutreVillage($village);

	}	
		
		
	/*function Getvillage(){
	     $MonSQL  = 'SELECT * FROM village ';
	    return ExecuteRequete($MonSQL); 
	}*/


	function GetvillageId($Idvillage){
	     $MonSQL   = 'SELECT * FROM village where code='.$Idvillage.' ';
	     $Curseur = ExecuteRequete($MonSQL);  return GetLigne($Curseur); 
	}

	function Insertvillage($code,$libelle,$coord01,$coord02,$coord03){
	     $MonSQL  = '  INSERT INTO village ( code,libelle,coord01,coord02,coord03) VALUES ( "'.$code.'","'.$libelle.'","'.$coord01.'","'.$coord02.'","'.$coord03.'") ';
	     ExecuteRequete($MonSQL); 
	}

	function Updatevillage($code,$libelle,$coord01,$coord02,$coord03){
		 $MonSQL  = ' UPDATE village SET libelle="'.$libelle.'",coord01="'.$coord01.'",coord02="'.$coord02.'",coord03="'.$coord03.'" Where code='.$code.' ';
		 ExecuteRequete($MonSQL); 
	 }

	function Deletevillage($code,$libelle,$coord01,$coord02,$coord03){
		 $MonSQL = ' DELETE From village Where code='.$code.' '; 
		 ExecuteRequete($MonSQL); 
	}

	function GetvillageListe($Idvillage){
		$Lesvillage=Getvillage($Idvillage);
		$Unevillage=GetLigne($Lesvillage);
		while ($Unevillage){ 
			if($Unevillage==$Idvillage){
				echo '<OPTION SELECTED value="$Unevillage[0]">$Unevillage[1]</OPTION>';
			}
			else{
				echo '<OPTION  value="$Unevillage[0]">$Unevillage[1]</OPTION>';
			}
			$Unevillage=GetLigne($Lesvillage);
		}
	}
	
	
	/*********************************/
	/*		Table Village Aller	*/
	/*********************************/
	
	
	
	function Getvillagealler(){
	     $MonSQL  = 'SELECT * FROM villagealler ';
	    return ExecuteRequete($MonSQL); 
	}


	function GetvillageallerId($Idvillagealler){
	     $MonSQL   = 'SELECT * FROM villagealler where villagedep='.$Idvillagealler.' ';
	     $Curseur = ExecuteRequete($MonSQL);  return GetLigne($Curseur); 
	}

	function Insertvillagealler($villagedep,$villagearv,$temps){
	     $MonSQL  = '  INSERT INTO villagealler ( villagedep,villagearv,temps) VALUES ( "'.$villagedep.'","'.$villagearv.'","'.$temps.'") ';
	     ExecuteRequete($MonSQL); 
	}

	function Updatevillagealler($villagedep,$villagearv,$temps){
		 $MonSQL  = ' UPDATE villagealler SET villagearv="'.$villagearv.'",temps="'.$temps.'" Where villagedep='.$villagedep.' ';
		 ExecuteRequete($MonSQL); 
	 }

	function Deletevillagealler($villagedep,$villagearv,$temps){
		 $MonSQL = ' DELETE From villagealler Where villagedep='.$villagedep.' '; 
		 ExecuteRequete($MonSQL); 
	}

	function GetvillageallerListe($Idvillagealler){
		$Lesvillagealler=Getvillagealler($Idvillagealler);
		$Unevillagealler=GetLigne($Lesvillagealler);
		while ($Unevillagealler){ 
			if($Unevillagealler==$Idvillagealler){
				echo '<OPTION SELECTED value="$Unevillagealler[0]">$Unevillagealler[1]</OPTION>';
			}
			else{
				echo '<OPTION  value="$Unevillagealler[0]">$Unevillagealler[1]</OPTION>';
			}
			$Unevillagealler=GetLigne($Lesvillagealler);
		}
	}
	

	?>