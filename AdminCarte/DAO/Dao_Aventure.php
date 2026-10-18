<?php
	/******AUTEUR*********************************
	***	BERGER NICOLAS 				           ****
	***	EMAIL: Berger.n@hotmail.fr     		   ****
	***	Code Auto-Généré					   ****
	***	Modifié par  :			  		       ****	
	***	Le:				  			           ****	
	***	Motif:			  			           ****											
	***********************************************/
		
	/**************/	
	


	function GetMissionAventure($id){
		$UneAventure="SELECT * FROM aventure WHERE code = '".$id."' ";
		$UneAventure = ExecuteRequete($UneAventure);
		return GetLigne($UneAventure);
	}
	
	function GetDanger($grade){
		if ($grade=="Novice") 		{$nb=rand(0,6);}
		if ($grade=="Ecuyer") 		{$nb=rand(1,9);}
		if ($grade=="Aventurier")	{$nb=rand(10,20);}
		if ($grade=="Legende")		{$nb=rand(15,30);}
		return $nb;
	}
	
	function GetCapable($codeheros){
		$Vie=$_SESSION["pv2"];	$fatiguer="4";
		if( $Vie < 7  ) 			 { $fatiguer="0"; }
		if( $Vie > 6  && $Vie < 9 )  { $fatiguer="1"; }
		if( $Vie > 8  && $Vie < 20 ) { $fatiguer="2"; }
		if( $Vie > 19 && $Vie < 30 ) { $fatiguer="3"; }
		return $fatiguer;
	}
	

	function SetFinMission($IdMission,$IdHeros){
		//CALCUL DES VARIABLE DE FIN DE MISSION
		$mission=GetMissionAventure($IdMission);	
		$exp=$_SESSION["exp"]+$mission['nbexp'];		$ors=$_SESSION["ors"]+$mission['nbor'];
		$NbPerdu=GetDanger($_SESSION["libellerang"]);	$vie=$_SESSION["pv2"]-$NbPerdu;
		
		//MISE A JOUR DES DONNEE DU JOUEUR
		$MaRequete="UPDATE joueur SET exp='".$exp."',ors='".$ors."',pv2='".$vie."' WHERE num='".$IdHeros."'";
		ExecuteRequete($MaRequete);
		$_SESSION["exp"]=$exp;	$_SESSION["ors"]=$ors;	$_SESSION["pv2"]=$vie;
		
		//MISE A JOUR DU NOMBRE DE MISSION ACCOMPLIE
		SetNbMission($IdMission,$IdHeros);
		$sql = "DELETE FROM aventureencour  WHERE  jou_num= '".$IdHeros."'"; 
		ExecuteRequete($sql);
	}
	
	/**************/
	
	
	function GetAventure($rang,$village){
		$LesAventures="SELECT * FROM aventure WHERE rang < '".$rang."' AND village = '".$village."' ";
		return ExecuteRequete($LesAventures);
	}


	function GetaventureId($Idaventure){
	     $MonSQL   = 'SELECT * FROM aventure where code='.$Idaventure.' ';
	     $Curseur = ExecuteRequete($MonSQL);  return GetLigne($Curseur); 
	}

	function Insertaventure($code,$libelle,$resumer,$nbor,$nbexp,$temps,$rang,$image){
	     $MonSQL  = '  INSERT INTO aventure ( code,libelle,resumer,nbor,nbexp,temps,rang,image) VALUES ( "'.$code.'","'.$libelle.'","'.$resumer.'","'.$nbor.'","'.$nbexp.'","'.$temps.'","'.$rang.'","'.$image.'") ';
	     ExecuteRequete($MonSQL); 
	}

	function Updateaventure($code,$libelle,$resumer,$nbor,$nbexp,$temps,$rang,$image){
		 $MonSQL  = ' UPDATE aventure SET libelle="'.$libelle.'",resumer="'.$resumer.'",nbor="'.$nbor.'",nbexp="'.$nbexp.'",temps="'.$temps.'",rang="'.$rang.'",image="'.$image.'" Where code='.$code.' ';
		 ExecuteRequete($MonSQL); 
	 }

	function Deleteaventure($code,$libelle,$resumer,$nbor,$nbexp,$temps,$rang,$image){
		 $MonSQL = ' DELETE From aventure Where code='.$code.' '; 
		 ExecuteRequete($MonSQL); 
	}

	function GetaventureListe($Idaventure){
		$Lesaventure=Getaventure($Idaventure);
		$Uneaventure=GetLigne($Lesaventure);
		while ($Uneaventure){ 
			if($Uneaventure==$Idaventure){
				echo '<OPTION SELECTED value="$Uneaventure[0]">$Uneaventure[1]</OPTION>';
			}
			else{
				echo '<OPTION  value="$Uneaventure[0]">$Uneaventure[1]</OPTION>';
			}
			$Uneaventure=GetLigne($Lesaventure);
		}
	}
	
	/*********************************/
	/*	Table Aventure En Cour		*/
	/*********************************/
	
	/*
	function Getaventureencour(){
	     $MonSQL  = 'SELECT * FROM aventureencour ';
	    return ExecuteRequete($MonSQL); 
	}
	*/


	function GetaventureencourId($Idaventureencour){
	     $MonSQL   = 'SELECT * FROM aventureencour where aven_num='.$Idaventureencour.' ';
	     $Curseur = ExecuteRequete($MonSQL);  return GetLigne($Curseur); 
	}

	function Insertaventureencour($aven_num,$jou_num,$sec){
	     $MonSQL  = '  INSERT INTO aventureencour ( aven_num,jou_num,sec) VALUES ( "'.$aven_num.'","'.$jou_num.'","'.$sec.'") ';
	     ExecuteRequete($MonSQL); 
	}

	function Updateaventureencour($aven_num,$jou_num,$sec){
		 $MonSQL  = ' UPDATE aventureencour SET jou_num="'.$jou_num.'",sec="'.$sec.'" Where aven_num='.$aven_num.' ';
		 ExecuteRequete($MonSQL); 
	 }

	function Deleteaventureencour($aven_num,$jou_num,$sec){
		 $MonSQL = ' DELETE From aventureencour Where aven_num='.$aven_num.' '; 
		 ExecuteRequete($MonSQL); 
	}

	function GetaventureencourListe($Idaventureencour){
		$Lesaventureencour=Getaventureencour($Idaventureencour);
		$Uneaventureencour=GetLigne($Lesaventureencour);
		while ($Uneaventureencour){ 
			if($Uneaventureencour==$Idaventureencour){
				echo '<OPTION SELECTED value="$Uneaventureencour[0]">$Uneaventureencour[1]</OPTION>';
			}
			else{
				echo '<OPTION  value="$Uneaventureencour[0]">$Uneaventureencour[1]</OPTION>';
			}
			$Uneaventureencour=GetLigne($Lesaventureencour);
		}
	}
	
	/*********************************/
	/*		Table Accomplir		*/
	/*********************************/
	
	function Getaccomplir(){
	     $MonSQL  = 'SELECT * FROM accomplir ';
	    return ExecuteRequete($MonSQL); 
	}


	function GetaccomplirId($Idaccomplir){
	     $MonSQL   = 'SELECT * FROM accomplir where aven_num='.$Idaccomplir.' ';
	     $Curseur = ExecuteRequete($MonSQL);  return GetLigne($Curseur); 
	}

	function Insertaccomplir($aven_num,$jou_num){
	     $MonSQL  = '  INSERT INTO accomplir ( aven_num,jou_num) VALUES ( "'.$aven_num.'","'.$jou_num.'") ';
	     ExecuteRequete($MonSQL); 
	}

	function Updateaccomplir($aven_num,$jou_num){
		 $MonSQL  = ' UPDATE accomplir SET jou_num="'.$jou_num.'" Where aven_num='.$aven_num.' ';
		 ExecuteRequete($MonSQL); 
	 }

	function Deleteaccomplir($aven_num,$jou_num){
		 $MonSQL = ' DELETE From accomplir Where aven_num='.$aven_num.' '; 
		 ExecuteRequete($MonSQL); 
	}

	function GetaccomplirListe($Idaccomplir){
		$Lesaccomplir=Getaccomplir($Idaccomplir);
		$Uneaccomplir=GetLigne($Lesaccomplir);
		while ($Uneaccomplir){ 
			if($Uneaccomplir==$Idaccomplir){
				echo '<OPTION SELECTED value="$Uneaccomplir[0]">$Uneaccomplir[1]</OPTION>';
			}
			else{
				echo '<OPTION  value="$Uneaccomplir[0]">$Uneaccomplir[1]</OPTION>';
			}
			$Uneaccomplir=GetLigne($Lesaccomplir);
		}
	}

	?>