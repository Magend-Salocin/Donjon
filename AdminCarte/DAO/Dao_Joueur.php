<?php
	/******AUTEUR*********************************
	***	BERGER NICOLAS 				           ****
	***	EMAIL: Berger.n@hotmail.fr     		   ****
	***	Code Auto-Généré					   ****
	***	Modifié par  :			  		       ****	
	***	Le:				  			           ****	
	***	Motif:			  			           ****											
	***********************************************/
		
	function Getjoueur(){
	     $MonSQL  = 'SELECT * FROM joueur ';
	    return ExecuteRequete($MonSQL); 
	}


	function GetjoueurId($Idjoueur){
	     $MonSQL   = 'SELECT * FROM joueur where num='.$Idjoueur.' ';
	     $Curseur = ExecuteRequete($MonSQL);  return GetLigne($Curseur); 
	}

	function Insertjoueur($num,$email,$login,$mdp,$nom,$pv,$pv2,$pm,$pm2,$forc,$end,$inti,$dext,$vit,$cha,$man,$ppm,$exp,$ors,$codeexp,$nivsuv,$cexp,$nbexp,$libellerace,$libellerang,$village,$image,$Enligne,$nbCombat,$nbVictoire,$NbCombatDay,$Arme,$Bouclier,$Casque,$Plastron,$AvantBras,$Botte,$Jambiere){
	     $MonSQL  = '  INSERT INTO joueur ( num,email,login,mdp,nom,pv,pv2,pm,pm2,forc,end,inti,dext,vit,cha,man,ppm,exp,ors,codeexp,nivsuv,cexp,nbexp,libellerace,libellerang,village,image,Enligne,nbCombat,nbVictoire,NbCombatDay,Arme,Bouclier,Casque,Plastron,AvantBras,Botte,Jambiere) VALUES ( "'.$num.'","'.$email.'","'.$login.'","'.$mdp.'","'.$nom.'","'.$pv.'","'.$pv2.'","'.$pm.'","'.$pm2.'","'.$forc.'","'.$end.'","'.$inti.'","'.$dext.'","'.$vit.'","'.$cha.'","'.$man.'","'.$ppm.'","'.$exp.'","'.$ors.'","'.$codeexp.'","'.$nivsuv.'","'.$cexp.'","'.$nbexp.'","'.$libellerace.'","'.$libellerang.'","'.$village.'","'.$image.'","'.$Enligne.'","'.$nbCombat.'","'.$nbVictoire.'","'.$NbCombatDay.'","'.$Arme.'","'.$Bouclier.'","'.$Casque.'","'.$Plastron.'","'.$AvantBras.'","'.$Botte.'","'.$Jambiere.'") ';
	     ExecuteRequete($MonSQL); 
	}

	function Updatejoueur($num,$email,$login,$mdp,$nom,$pv,$pv2,$pm,$pm2,$forc,$end,$inti,$dext,$vit,$cha,$man,$ppm,$exp,$ors,$codeexp,$nivsuv,$cexp,$nbexp,$libellerace,$libellerang,$village,$image,$Enligne,$nbCombat,$nbVictoire,$NbCombatDay,$Arme,$Bouclier,$Casque,$Plastron,$AvantBras,$Botte,$Jambiere){
		 $MonSQL  = ' UPDATE joueur SET email="'.$email.'",login="'.$login.'",mdp="'.$mdp.'",nom="'.$nom.'",pv="'.$pv.'",pv2="'.$pv2.'",pm="'.$pm.'",pm2="'.$pm2.'",forc="'.$forc.'",end="'.$end.'",inti="'.$inti.'",dext="'.$dext.'",vit="'.$vit.'",cha="'.$cha.'",man="'.$man.'",ppm="'.$ppm.'",exp="'.$exp.'",ors="'.$ors.'",codeexp="'.$codeexp.'",nivsuv="'.$nivsuv.'",cexp="'.$cexp.'",nbexp="'.$nbexp.'",libellerace="'.$libellerace.'",libellerang="'.$libellerang.'",village="'.$village.'",image="'.$image.'",Enligne="'.$Enligne.'",nbCombat="'.$nbCombat.'",nbVictoire="'.$nbVictoire.'",NbCombatDay="'.$NbCombatDay.'",Arme="'.$Arme.'",Bouclier="'.$Bouclier.'",Casque="'.$Casque.'",Plastron="'.$Plastron.'",AvantBras="'.$AvantBras.'",Botte="'.$Botte.'",Jambiere="'.$Jambiere.'" Where num='.$num.' ';
		 ExecuteRequete($MonSQL); 
	 }

	function Deletejoueur($num,$email,$login,$mdp,$nom,$pv,$pv2,$pm,$pm2,$forc,$end,$inti,$dext,$vit,$cha,$man,$ppm,$exp,$ors,$codeexp,$nivsuv,$cexp,$nbexp,$libellerace,$libellerang,$village,$image,$Enligne,$nbCombat,$nbVictoire,$NbCombatDay,$Arme,$Bouclier,$Casque,$Plastron,$AvantBras,$Botte,$Jambiere){
		 $MonSQL = ' DELETE From joueur Where num='.$num.' '; 
		 ExecuteRequete($MonSQL); 
	}

	function GetjoueurListe($Idjoueur){
		$Lesjoueur=Getjoueur($Idjoueur);
		$Unejoueur=GetLigne($Lesjoueur);
		while ($Unejoueur){ 
			if($Unejoueur==$Idjoueur){
				echo '<OPTION SELECTED value="$Unejoueur[0]">$Unejoueur[1]</OPTION>';
			}
			else{
				echo '<OPTION  value="$Unejoueur[0]">$Unejoueur[1]</OPTION>';
			}
			$Unejoueur=GetLigne($Lesjoueur);
		}
	}

	?>