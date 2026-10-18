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
	
	function GetInfoRace($idrace){
		$UneRaceInfo="SELECT * FROM race WHERE code ='".$idrace."'";
		return GetLigne(ExecuteRequete ($UneRaceInfo));
	}
	
	function GetGrade($lib){
		$CodeGrade="SELECT code FROM grade WHERE libelle = '".$lib."' ";
		$CodeGrade = ExecuteRequete ($CodeGrade);
		$CodeGrade = GetLigne($CodeGrade);
		return $CodeGrade[0];
	}
	
	function GetNbMission($num){
		$MaRequete="SELECT grade.libelle, sum( accomplir.nb ) FROM accomplir , aventure, grade WHERE jou_num = ".$num." and accomplir.aven_num = aventure.code AND grade.code = aventure.rang GROUP BY grade.libelle";
		return  ExecuteRequete($MaRequete);
	}
	
	function SetGradeSup($heros){
	$Ngrade=GetNbMission($heros);	$rang=$_SESSION["libellerang"];
	while($grade=GetLigne($Ngrade)){
	if($grade[0]=="Novice" && $rang==$grade[0]) { if($grade[1]>30){   Modif("libellerang","Ecuyer",$heros);}}
	if($grade[0]=="Ecuyer" && $rang==$grade[0]) { if($grade[1]>40){    Modif("libellerang","Aventurier",$heros);}}
	if($grade[0]=="Aventurier" && $rang==$grade[0]) { if($grade[1]>50){Modif("libellerang","Legende",$heros);}}
			
		}
	}

	function GetAfficheGrade($librang,$codeheros){
		$nbmission = GetNbMission($codeheros);
		while($row=GetLigne($nbmission))	{ 
			echo "<TR><TD width='50%'align=center>$row[0]: $row[1]</TD>";
			$row=GetLigne($nbmission);
			echo "<TD width='50%' align=center>$row[0]: $row[1]</TD></TR>"; 
		}	    
	}

	
	
	function SetNbMission($mission,$heros){
		$NbMission="SELECT nb FROM accomplir WHERE aven_num = '".$mission."' and jou_num = '".$heros."'";
		$NbMission=ExecuteRequete($NbMission);	$total=GetLigne($NbMission);
		if (isset($total['nb'])){
		   $nb=$total['nb']+1;
		   $MaRequete="UPDATE accomplir SET nb='".$nb."' WHERE aven_num='".$mission."' and jou_num='".$heros."'";
		   ExecuteRequete($MaRequete);
		}
		else{
			$MaRequete="insert into accomplir  values ('".$mission."','".$heros."','1')";
			ExecuteRequete($MaRequete);
		}
		SetGradeSup($heros);
	}
	
	function SetJoueurInscription($mail,$nom,$mdp,$idrace){

		$race=GetInfoRace($idrace);
		$Num= date("his");
		$UnJoueur="insert into joueur  values ('".$Num."','".$mail."','".$nom."','".$mdp."','".$nom."','".$race['r_pv']."','".$race['r_pv']."','".$race['r_pm']."','".$race['r_pm']."','".$race['r_for']."','".$race['r_end']."','".$race['r_int']."','".$race['r_dext']."','".$race['r_vit']."','".$race['r_cha']."','".$race['r_man']."','".$race['r_ppm']."','0','0','1','150','0','0','".$race['libelle']."','novice','".$race['r_village']."','".$race['r_image']."','0','0','0','0','rien','rien','rien','rien','rien','rien','rien')";
		ExecuteRequete ($UnJoueur);
	
		$LesAventure="SELECT code FROM aventure ";
		$LesAventure = ExecuteRequete($LesAventure);
		
		while($row=GetLigne($LesAventure))	{	
		$Un="insert into accomplir  values ('".$row[0]."','".$Num."','0') ";
		ExecuteRequete ($Un);
		}
	
	}

	function GetNom($nom){
		$MaRequete="SELECT nom FROM joueur WHERE nom= '".$nom."' ";
		$MonRs = GetLigne(ExecuteRequete($MaRequete));
		return $nom==$MonRs['nom'];
	}
	
	function GetMail($email){
		$MaRequete="SELECT email  FROM joueur WHERE email = '".$email."' ";
		$MonRs = GetLigne( ExecuteRequete($MaRequete));
		return $email==$MonRs['email'];
	}
		
	/*********************************/
	/*		Table Race   		*/
	/*********************************/
	function Getrace(){
	     $MonSQL  = 'SELECT * FROM race ';
	    return ExecuteRequete($MonSQL); 
	}

	function GetraceId($Idrace){
	     $MonSQL   = 'SELECT * FROM race where code='.$Idrace.' ';
	     $Curseur = ExecuteRequete($MonSQL);  return GetLigne($Curseur); 
	}

	function Insertrace($code,$libelle,$r_pv,$r_pm,$r_for,$r_end,$r_vit,$r_int,$r_dext,$r_cha,$r_man,$r_ppm,$r_village){
	     $MonSQL  = '  INSERT INTO race ( code,libelle,r_pv,r_pm,r_for,r_end,r_vit,r_int,r_dext,r_cha,r_man,r_ppm,r_village) VALUES ( "'.$code.'","'.$libelle.'","'.$r_pv.'","'.$r_pm.'","'.$r_for.'","'.$r_end.'","'.$r_vit.'","'.$r_int.'","'.$r_dext.'","'.$r_cha.'","'.$r_man.'","'.$r_ppm.'","'.$r_village.'") ';
	     ExecuteRequete($MonSQL); 
	}

	function Updaterace($code,$libelle,$r_pv,$r_pm,$r_for,$r_end,$r_vit,$r_int,$r_dext,$r_cha,$r_man,$r_ppm,$r_village){
		 $MonSQL  = ' UPDATE race SET libelle="'.$libelle.'",r_pv="'.$r_pv.'",r_pm="'.$r_pm.'",r_for="'.$r_for.'",r_end="'.$r_end.'",r_vit="'.$r_vit.'",r_int="'.$r_int.'",r_dext="'.$r_dext.'",r_cha="'.$r_cha.'",r_man="'.$r_man.'",r_ppm="'.$r_ppm.'",r_village="'.$r_village.'" Where code='.$code.' ';
		 ExecuteRequete($MonSQL); 
	 }

	function Deleterace($code,$libelle,$r_pv,$r_pm,$r_for,$r_end,$r_vit,$r_int,$r_dext,$r_cha,$r_man,$r_ppm,$r_village){
		 $MonSQL = ' DELETE From race Where code='.$code.' '; 
		 ExecuteRequete($MonSQL); 
	}

	function GetraceListe($Idrace){
		$Lesrace=Getrace($Idrace);
		$Unerace=GetLigne($Lesrace);
		while ($Unerace){ 
			if($Unerace==$Idrace){
				echo '<OPTION SELECTED value="$Unerace[0]">$Unerace[1]</OPTION>';
			}
			else{
				echo '<OPTION  value="$Unerace[0]">$Unerace[1]</OPTION>';
			}
			$Unerace=GetLigne($Lesrace);
		}
	}
	
	
	/*********************************/
	/*		Table Grade   		*/
	/*********************************/
	
	/*function Getgrade(){
	     $MonSQL  = 'SELECT * FROM grade ';
	    return ExecuteRequete($MonSQL); 
	}
*/

	function GetgradeId($Idgrade){
	     $MonSQL   = 'SELECT * FROM grade where code='.$Idgrade.' ';
	     $Curseur = ExecuteRequete($MonSQL);  return GetLigne($Curseur); 
	}

	function Insertgrade($code){
	     $MonSQL  = '  INSERT INTO grade ( code) VALUES ( "'.$code.'") ';
	     ExecuteRequete($MonSQL); 
	}

	function Updategrade($code){
		 $MonSQL  = ' UPDATE grade SET  Where code='.$code.' ';
		 ExecuteRequete($MonSQL); 
	 }

	function Deletegrade($code){
		 $MonSQL = ' DELETE From grade Where code='.$code.' '; 
		 ExecuteRequete($MonSQL); 
	}

	function GetgradeListe($Idgrade){
		$Lesgrade=Getgrade($Idgrade);
		$Unegrade=GetLigne($Lesgrade);
		while ($Unegrade){ 
			if($Unegrade==$Idgrade){
				echo '<OPTION SELECTED value="$Unegrade[0]">$Unegrade[1]</OPTION>';
			}
			else{
				echo '<OPTION  value="$Unegrade[0]">$Unegrade[1]</OPTION>';
			}
			$Unegrade=GetLigne($Lesgrade);
		}
	}

	?>