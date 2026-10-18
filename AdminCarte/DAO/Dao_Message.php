<?php
	/******AUTEUR*********************************
	***	BERGER NICOLAS 				           ****
	***	EMAIL: Berger.n@hotmail.fr     		   ****
	***	Code Auto-Généré					   ****
	***	Modifié par  :			  		       ****	
	***	Le:				  			           ****	
	***	Motif:			  			           ****											
	***********************************************/
		
	/*****/
	
	function SetMessage($A,$DE,$sujet,$contenu){
		$Num= date('his');
		$UnMessage="insert into message  values ('".$Num."','".$A."','".$DE."','".$Num."','".$sujet."','".$contenu."','0') ";
		ExecuteRequete ($UnMessage);
	}

	function GetMessage($code,$nom){
		$MaRequete="SELECT * FROM message WHERE code= '".$code."' AND A= '".$nom."' ";
		$MonRs = ExecuteRequete($MaRequete);
		return  GetLigne($MonRs);
	}
	
	function ModifMessage($num,$nom){	
		$MaRequete="UPDATE message SET lue=1 WHERE code='".$num."' AND A= '".$nom."'";
		ExecuteRequete($MaRequete);
	}
	
	function DelMessage($Id,$nom){
		$sql = "DELETE FROM message  WHERE  code= '".$Id."' AND A= '".$nom."'"; 
		ExecuteRequete($sql);
	}
	
	function GetAllMessage($nom){
		$MaRequete="SELECT * FROM message WHERE A= '".$nom."' ";
		$MaRequete=ExecuteRequete($MaRequete);
		while($row=GetLigne($MaRequete)){
		 echo"  <tr>
				<td width='35'  align='center' valign='top'><img src='image/msg_int/$row[6].jpg' alt='' /> </td>
				<td width='107' valign='top'>$row[2]</td>
				<td width='170' valign='top'>$row[4]</td>
				<td width='108' valign='top'>$row[3]</td>
				<td width='54'  valign='top'><a href='?page=Messagerie&msg=msglook&name=$row[0]'>lire</a></td>
			</tr>";
		}
	}
	
	
/***/	
	/*	
	function Getmessage(){
	     $MonSQL  = 'SELECT * FROM message ';
	    return ExecuteRequete($MonSQL); 
	}
*/

	function GetmessageId($Idmessage){
	     $MonSQL   = 'SELECT * FROM message where code='.$Idmessage.' ';
	     $Curseur = ExecuteRequete($MonSQL);  return GetLigne($Curseur); 
	}

	function Insertmessage($code,$a,$de,$date,$sujet,$contenu){
	     $MonSQL  = '  INSERT INTO message ( code,a,de,date,sujet,contenu) VALUES ( "'.$code.'","'.$a.'","'.$de.'","'.$date.'","'.$sujet.'","'.$contenu.'") ';
	     ExecuteRequete($MonSQL); 
	}

	function Updatemessage($code,$a,$de,$date,$sujet,$contenu){
		 $MonSQL  = ' UPDATE message SET a="'.$a.'",de="'.$de.'",date="'.$date.'",sujet="'.$sujet.'",contenu="'.$contenu.'" Where code='.$code.' ';
		 ExecuteRequete($MonSQL); 
	 }

	function Deletemessage($code,$a,$de,$date,$sujet,$contenu){
		 $MonSQL = ' DELETE From message Where code='.$code.' '; 
		 ExecuteRequete($MonSQL); 
	}

	function GetmessageListe($Idmessage){
		$Lesmessage=Getmessage($Idmessage);
		$Unemessage=GetLigne($Lesmessage);
		while ($Unemessage){ 
			if($Unemessage==$Idmessage){
				echo '<OPTION SELECTED value="$Unemessage[0]">$Unemessage[1]</OPTION>';
			}
			else{
				echo '<OPTION  value="$Unemessage[0]">$Unemessage[1]</OPTION>';
			}
			$Unemessage=GetLigne($Lesmessage);
		}
	}

	?>