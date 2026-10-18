<?php
include ("Secret/connect.php");	
include ("DAO/Dao_Magazin.php");
include ("DAO/Dao_Objet.php");		

$Magazin=-1;
if(isset($_POST['Magazin'])){$Magazin= $_POST['Magazin'];}
if(isset($_POST['AddStock'])){ ECHO "tt"; UpdateStockMagazin($magazin,$_POST['id'],$_POST['prix'],$_POST['stock']); }
?>
<html>
<head>

	
		
</head>

<body>
	<form  name="m" id="m" method="post"  action="#">
		<select size="1" name="Magazin"  onchange="m.submit();">
			<option value="choix">Selectionner votre Magazin:</option>
			<?php GetmagazinListe($Magazin)?>
		</select><br>
		</form>	
		
	<form  name="i" id="i" method="post"  action="#">
	<table style='width:800px;'  >	

		<tr>
		<td>
		id
		</td>
		<td>
		nom
		</td>
		<td>
		Prix
		</td>
		<td>
		Quantite
		</td>
		</tr>	
	<?php
$LesObjets = 	GetLesObjet($Magazin);
	while($row=GetLigne($LesObjets))	{
					if($row[8]==""){$row[8]="01.jpg";}					
					echo " 
		<form  name='_$row[6]' id='_$row[6]' method='post'  action='#'>
		<tr>
		<td>
		<input type='hidden' id='id'  name='id' 	size='20' value='$row[6]'>
		$row[6]
			</td>
		<td>
		$row[0]
			</td>
		<td>
			<input type='text' 	id='prix'	name='prix' 	size='20' value='$row[5]'>
			</td>
		<td>
			<input type='text' 	id='stock'	name='stock' 	size='20' value='$row[4]'> 
			</td>
			<td>
			<input type='hidden' 	name='Magazin' 	value='$Magazin' >
		<input type='hidden' 	name='AddStock' 	value='AddStock' >
		<input type='submit' 	name='AddStock' 	value='Valider' >
		</td>
		</tr>
		</form>				
				
						";	
					}?>
 
	
		</table><br>
	</form>
</body>

</html>