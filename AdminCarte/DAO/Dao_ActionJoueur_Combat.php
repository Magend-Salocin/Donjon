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
	
	function GetConnecter($village){
		$tempsMax=time();  $tempsMin=$tempsMax-300;  
		$Requete="SELECT * FROM joueur WHERE village ='".$village."' AND Enligne  between '".$tempsMin."' and '".$tempsMax."'";
		return ExecuteRequete ($Requete);
	}
	
	function GetDefis($idheros,$village){
		$Requete="SELECT avantCombat.num, MoiHeros, nom, exp, nbCombat, NbVictoire FROM avantCombat, joueur WHERE Heros='".$idheros."' AND joueur.village ='".$village."'AND avantCombat.MoiHeros = joueur.num";
		return ExecuteRequete ($Requete);
	}
	
	function GetDefis1($idheros,$village){
		$Requete="SELECT  nom, exp, nbCombat, NbVictoire FROM avantCombat, joueur WHERE MoiHeros='".$idheros."' AND joueur.village ='".$village."'AND avantCombat.heros = joueur.num";
		return ExecuteRequete ($Requete);
	}
	
	function SetDefis($num,$heros,$Moiheros,$village){
		$Requete="INSERT INTO avantCombat  ( num, heros , MoiHeros , village ) VALUES ('$num', '$heros' , '$Moiheros' , '$village')";
		return ExecuteRequete ($Requete);
	}
	
	function DelDefis($num){
		$Requete = "DELETE FROM avantCombat  WHERE  num= '".$num."'"; 
		ExecuteRequete($Requete);
	}
	
	function GetForceDext($jet,$att){
		$degat=0;	$att=$att/10;	$degat=$jet*rand(0,12);
		//for($j=0; $j <$jet ; $j++) { $degat=$degat + rand(0,6);}
		return $degat+$att;
	}
	
	function GetDefence($jet,$def){
		$degat=0;	$def=$def/10;	$degat=$jet*rand(0,12);
		//for($j=0; $j <$jet ; $j++) {  $degat=$degat + rand(0,6); } 
		return $degat+$def;
	}
	
	function GetDext($jet){
		$parfait=0;	  $controle=$jet/4;
		//for($j=0; $j <$jet ; $j++) { $degat= rand(0,6); if($degat==6){$parfait=$parfait+1;}} 
		return  ($parfait>$controle);
	}
	
	function GetVit($jet){
		$degat=0; $degat=$jet*rand(0,6);
		//for($j=0; $j <$jet ; $j++) { $degat=$degat + rand(0,6);} 
		return  $degat;
	}
	
	function Affichage($code,$name,$degat,$pv,$color,$nb){
	echo"<div id='$nb' style='visibility: hidden'><li><font color='$color'>";
	
		if($code==0)
			{echo "Fin du combat!.";}
		if($code==1)
			{echo "$name donne un  coup normal ($degat) descend la vie de son adversaire ?pv.";}
		if($code==2)	
			{echo "$name esquive l'attaque.";}
		if($code==3)	
			{echo "$name donne <b> un  coup critique ($degat) </b> descend la vie de son adversaire ?pv.";}
		if($code==4)	
			{echo "$name remporte le combat! (11 pi? d'or + 18 point Experience).";}	
	echo "<br><br></font></li></div>";		
	}
	
	function FinCombatVictory($Win,$nb,$bool){
	
		$or=rand(1,20);		$exp=rand(1,20);	
		
		echo"<div id='$nb' style='visibility: hidden'><li><font color='green'>";
		echo "$Win[4] remporte le combat! ($or pi? d'or + $exp point Experience).";
		echo "<br><br></font></li></div>";
		
		$nbvictoire=$Win[29]+1;	$NbCombatDay=$Win[30]+1;	$NbCombat=$Win[28]+1;
		$or=$or+$Win[18];	$exp=$exp+$Win[17];
		
		$Requete="UPDATE joueur SET exp = ".$exp.", ors = ".$or." ,nbCombat = ".$NbCombat." ,nbVictoire = ".$nbvictoire." ,NbCombatDay = ".$NbCombatDay." WHERE num = ".$Win[0]." ";
		ExecuteRequete($Requete);
		if($bool==true){	SetJoueur($Win);	}
	 
	}
	
	function FinCombatDeite($Def,$bool){
	$exp=rand(1,5);	$exp=$exp+$Def[17];
	$NbCombatDay=$Def[30]+1;	$NbCombat=$Def[28]+1;
	
	$Requete="UPDATE joueur SET exp = '".$exp."',nbCombat = '".$NbCombat."'  ,NbCombatDay = '".$NbCombatDay."' WHERE num = '".$Def[0]."'";
	ExecuteRequete ($Requete);
	if($bool==true){	SetJoueur($Def);	}
	}
	
	/*********************************/
	/*		Table Avant Combat 	*/
	/*********************************/
	
	function Getavantcombat(){
	     $MonSQL  = 'SELECT * FROM avantcombat ';
	    return ExecuteRequete($MonSQL); 
	}


	function GetavantcombatId($Idavantcombat){
	     $MonSQL   = 'SELECT * FROM avantcombat where num='.$Idavantcombat.' ';
	     $Curseur = ExecuteRequete($MonSQL);  return GetLigne($Curseur); 
	}

	function Insertavantcombat($num,$heros,$MoiHeros){
	     $MonSQL  = '  INSERT INTO avantcombat ( num,heros,MoiHeros) VALUES ( "'.$num.'","'.$heros.'","'.$MoiHeros.'") ';
	     ExecuteRequete($MonSQL); 
	}

	function Updateavantcombat($num,$heros,$MoiHeros){
		 $MonSQL  = ' UPDATE avantcombat SET heros="'.$heros.'",MoiHeros="'.$MoiHeros.'" Where num='.$num.' ';
		 ExecuteRequete($MonSQL); 
	 }

	function Deleteavantcombat($num,$heros,$MoiHeros){
		 $MonSQL = ' DELETE From avantcombat Where num='.$num.' '; 
		 ExecuteRequete($MonSQL); 
	}

	function GetavantcombatListe($Idavantcombat){
		$Lesavantcombat=Getavantcombat($Idavantcombat);
		$Uneavantcombat=GetLigne($Lesavantcombat);
		while ($Uneavantcombat){ 
			if($Uneavantcombat==$Idavantcombat){
				echo '<OPTION SELECTED value="$Uneavantcombat[0]">$Uneavantcombat[1]</OPTION>';
			}
			else{
				echo '<OPTION  value="$Uneavantcombat[0]">$Uneavantcombat[1]</OPTION>';
			}
			$Uneavantcombat=GetLigne($Lesavantcombat);
		}
	}
	
	

	?>