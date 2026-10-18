<?php 
	$SERVEUR="localhost";
	$LOGIN="root";
	$MDP="";
	$MABASE="donjon";
	//$MABASE="ProjetCFSA";
	
	$CONNEXION=mysql_connect($SERVEUR,$LOGIN,$MDP);
	mysql_select_db($MABASE);

	function GetLigne($Curseur) {
	// fournit une ligne du curseur pass?n param?e
	   $Ligne=mysql_fetch_array($Curseur);
	   return $Ligne;
	}

	function ExecuteRequete($Requete){
	// execute la requete passer en parametre
		$RequeteExecuter = mysql_query($Requete) or die (mysql_error());
		return $RequeteExecuter;
	}

?>
