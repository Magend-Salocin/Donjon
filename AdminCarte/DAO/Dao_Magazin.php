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
	/*		Old Method	 		*/
	/*********************************/	
	
	function GetMagazin($village){
		$LesMagazins="SELECT * FROM magazin WHERE  village = '".$village."' ";
		return ExecuteRequete($LesMagazins);
	}
	
	function GetLeMagazin($village,$magazin){
		$LeMagazin="SELECT code FROM magazin WHERE  village = '".$village."' and code = '".$magazin."'";
		$LeMagazin=GetLigne(ExecuteRequete($LeMagazin));
		return $LeMagazin[0]==$magazin;
	}

	function GetAfficheMagazin($village){
	$LesMagazin=GetMagazin($village);
		while($row=GetLigne($LesMagazin)){
		echo " <area shape='rect' coords='$row[2],$row[3],$row[4],$row[5]'  href='$row[7]' alt='$row[1]' title='$row[1]' >";
		}
	}	
		
	/*********************************/
	/*		Old Method	 		*/
	/*********************************/	
/*	function Getmagazin(){
	     $MonSQL  = 'SELECT * FROM magazin ';
	    return ExecuteRequete($MonSQL); 
	}
*/

	function GetmagazinId($Idmagazin){
	     $MonSQL   = 'SELECT * FROM magazin where code='.$Idmagazin.' ';
	     $Curseur = ExecuteRequete($MonSQL);  return GetLigne($Curseur); 
	}

	function Insertmagazin($code,$libelle,$coord01,$coord02,$coord03,$coord04,$village){
	     $MonSQL  = '  INSERT INTO magazin ( code,libelle,coord01,coord02,coord03,coord04,village) VALUES ( "'.$code.'","'.$libelle.'","'.$coord01.'","'.$coord02.'","'.$coord03.'","'.$coord04.'","'.$village.'") ';
	     ExecuteRequete($MonSQL); 
	}

	function Updatemagazin($code,$libelle,$coord01,$coord02,$coord03,$coord04,$village){
		 $MonSQL  = ' UPDATE magazin SET libelle="'.$libelle.'",coord01="'.$coord01.'",coord02="'.$coord02.'",coord03="'.$coord03.'",coord04="'.$coord04.'",village="'.$village.'" Where code='.$code.' ';
		 ExecuteRequete($MonSQL); 
	 }

	function Deletemagazin($code,$libelle,$coord01,$coord02,$coord03,$coord04,$village){
		 $MonSQL = ' DELETE From magazin Where code='.$code.' '; 
		 ExecuteRequete($MonSQL); 
	}

	function GetmagazinListe($Idmagazin){
		//$Lesmagazin=Getmagazin($Idmagazin);
		$LesMagazins="SELECT * FROM magazin  ";
		$Lesmagazin= ExecuteRequete($LesMagazins);
		$Unemagazin=GetLigne($Lesmagazin);
		while ($Unemagazin){ 
			if($Unemagazin[0]==$Idmagazin){
				echo '<OPTION SELECTED value="'.$Unemagazin[0].'">'.$Unemagazin[1].'__'.$Unemagazin[6].'</OPTION>';
			}
			else{
				echo '<OPTION  value="'.$Unemagazin[0].'">'.$Unemagazin[1].'__'.$Unemagazin[6].'</OPTION>';
			}
			$Unemagazin=GetLigne($Lesmagazin);
		}
	}

	?>