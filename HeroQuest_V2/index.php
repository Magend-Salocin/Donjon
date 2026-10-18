<?php

if(isset($_POST['chooseMap'])){
echo $IdCarte=$_POST['chooseMap'];

}
else{
echo $IdCarte=1;
}

 ?>


<html>
<head>
	<link rel="stylesheet" href="default.css" type="text/css" />
	<script type="text/javascript" src="mootools.js"></script>
	<script Language="JavaScript" src="MesItem.js"></script> 

	<script Language="JavaScript"  src="quest/quest<?php echo $IdCarte; ?>.js"></script> 
</head>

<body  onload="initialiserJeux()">
	<form name="Chosse" action="index.php" method="post">
		<select name="chooseMap" id="chooseMap" size="1" onchange="Chosse.submit();">
			<option value="1">-----quest1----</option>
			<option value="2">-----quest2----</option>
			<option value="3">-----quest3----</option>
			<option value="4">-----quest4----</option>
		</select>
		</form>
		<form name="test">
	<div id="Centre"  class="Centre">
		<div id="myOtherElement"  class="demoElement">
			<div id="body-leftside">
				<div id="scroll_top"><span id="scroll_header">
					<span id="CarteTitre"></span>
				</span></div>
				<div id="scroll_middle">
					<div id="CarteDescription" style="padding-left:30px;width:70%;"></div>
				</div>
				<div id="scroll_bottom">
					<a href="#" title="RetireStyle" onclick="RetireStyle('myOtherElement')" id="FermerTresor">Fermer</a>
				</div>
			</div>
					
		</div>
		

		
		<div id="myHeroItem" style="left:50%;margin-left:-450px;" class="demoElement">
			<?php //include("./Vues/Carte-PageHero-Inventaire.php");?>

		</div>
					
		</div>
	
 

	
		<table id="CarteJeu" border="0" align="center" style='width:731px;height:534px'  background="quest/quest<?php echo $IdCarte;?>.jpg" > 
		<?php			$case=-1; 
		for($j=0; $j <19 ; $j++) { 
			echo "<tr>"; 
				for($i=0; $i <26 ; $i++) { 
					$case=   $case + 1;					
					echo "<td class='FondNoir'><img src='images/08.jpg' title='$case' name='$case' id='$case'></td>";
				}
			echo "</tr>";
		}
		?>
		</table>

	
	

		<A style="CURSOR: n-resize" href="javascript:void(0)" id="atop" 	name="atop"></A>
		<A style="CURSOR: w-resize" href="javascript:void(0)" id="aleft" 	name="aleft"></A>
		<A style="CURSOR: e-resize" href="javascript:void(0)" id="aright"   name="aright"></A>
		<A style="CURSOR: s-resize" href="javascript:void(0)" id="abottom"  name="abottom" ></A>


	</form>

	
	<div align="center" >
		<img src='images/dee/Dee.GIF' name='Dee1' id='Dee1'>
		<img src='images/dee/Dee.GIF' name='Dee2' id='Dee2'>
		Nombre de case de déplacement restant: <input type='text' name='Move' value='99' />
		<input type='button' name='dee' value="Attaquer"  onclick='LancerdeeAttaque()'/>
		<input type='button' name='dee' value="Lancer les dée"  onclick='Lancerdee()'/>
		<input type='button' name='dee' value="Tirer Une Carte Tresor"  onclick='TirerUneCarteTresor()'/>
		<input type='button' name='End' value="Fin de tour"  onclick='FinTour()'/>
		<input type='button' name='End' value="Clear Debug"  onclick='ClearDebug()'/>
	<br />
		<table border="0" align="center"  width="50%">
			<tr>
			<td>Attaque</td>
			<td><img src='images/dee/Dee.GIF'  class="test" name='DA0'></td>
			<td><img src='images/dee/Dee.GIF' class="test" name='DA1'></td>
			<td><img src='images/dee/Dee.GIF' class="test" name='DA2'></td>
			<td><img src='images/dee/Dee.GIF' class="test" name='DA3'></td>
			<td><img src='images/dee/Dee.GIF' class="test" name='DA4'></td>
			<td><img src='images/dee/Dee.GIF' class="test" name='DA5'></td>
			<td><img src='images/dee/Dee.GIF' class="test" name='DA6'></td>
			<td><img src='images/dee/Dee.GIF' class="test" name='DA7'></td>
			</tr>
			
			<tr>
			<td>Defence</td>
			<td><img src='images/dee/Dee.GIF' class="test" name='DD0'></td>
			<td><img src='images/dee/Dee.GIF' class="test" name='DD1'></td>
			<td><img src='images/dee/Dee.GIF' class="test" name='DD2'></td>
			<td><img src='images/dee/Dee.GIF' class="test" name='DD3'></td>
			<td><img src='images/dee/Dee.GIF' class="test" name='DD4'></td>
			<td><img src='images/dee/Dee.GIF' class="test" name='DD5'></td>
			<td><img src='images/dee/Dee.GIF' class="test" name='DD6'></td>
			<td><img src='images/dee/Dee.GIF' class="test" name='DD7'></td>
			</tr>
		</table>
	</div>
	
		
	<div id="Debug">

	</div>
	
	</div>





<script Language="JavaScript" src="ModuleActionJeu.js"></script>
<script Language="JavaScript" src="ModulePiece.js"></script>
<script Language="JavaScript" src="ModulePersonnage.js"></script>
<script Language="JavaScript" src="ModuleIAMonstre.js"></script>
<script Language="JavaScript" src="ModuleCombat.js"></script>
<script Language="JavaScript" src="ModuleCarteTresor.js"></script>
<script Language="JavaScript" src="ModuleCarteHero.js"></script>
<script Language="JavaScript" src="ModuleSave.js"></script>
<script Language="JavaScript" src="ModuleVictoire.js"></script>




</body></html>