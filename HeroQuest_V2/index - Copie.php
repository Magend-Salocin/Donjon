
<?php 

$IdAventure = $_SESSION["AventureEnCour"];

?>

<html>
<head>
	<link rel="stylesheet" href="Javascript/HeroQuest_V2/default.css" type="text/css" />
	<script type="text/javascript" src="Javascript/HeroQuest_V2/mootools.js"></script>
	<!-- <script type="text/javascript" src="Javascript/HeroQuest_V2/EngineMagend.js"></script> -->
	<script Language="JavaScript" src="Javascript/HeroQuest_V2/MesItem.js"></script> 
	<script type="text/javascript">
		<?php 
			SetJoueurJavascript($heros);	
		?>
		
		
	var MyHeroId = '<?php echo session_id(); ?>'
	
	<?php 
	if(isset($_SESSION['ReloadPartie'])==true){
		ReloadPartieMyHero();
	}
	?>
	
	</script>
	
</head>

<body  onload="initialiserJeux()">
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
		
		<div id="myHero"  class="demoElement">
			<?php include("./Vues/Carte-PageHero-EtatHero.php");?>
		</div>
		
		<div id="myHeroItem" style="left:50%;margin-left:-450px;" class="demoElement">
			<?php include("./Vues/Carte-PageHero-Inventaire.php");?>

		</div>
					
		</div>
	
 
	<form name="test">
	
		<table border="0" align="center" style='width:731px;height:534px'  background="Javascript/HeroQuest_V2/quest/quest<?php echo $IdAventure;  ?>.jpg" > 
		<?php			$case=-1; 
		for($j=0; $j <19 ; $j++) { 
			echo "<tr>"; 
				for($i=0; $i <26 ; $i++) { 
					$case=   $case + 1;					
					echo "<td class='FondNoir'><img src='Javascript/HeroQuest_V2/images/08.jpg' title='$case' id='$case'></td>";
				}
			echo "</tr>";
		}
		?>
		</table>

	
	<div align="center" >
		
		<input type='button' name='dee' value="Attaquer"  onclick='LancerdeeAttaque()'>
		<input type='button' name='dee' value="Lancer les d&eacute;e"  onclick='Lancerdee()'>
		<input type='button' name='dee' value="Tirer Une Carte Tresor"  onclick='TirerUneCarteTresor()'>
		<input type='button' name='dee' value="CaracHero"  onclick="AfficherElement('myHero')">
		<input type='button' name='dee' value="Item"  onclick="AfficherElement('myHeroItem')">
		<input type='button' name='End' value="Fin de tour"  onclick='FinTour()'>
		<input type='button' name='End' value="Clear Debug"  onclick='ClearDebug()'>
			<br />
	
		Nombre de case de d&eacute;placement restant: <input type='text' name='Move' value='99' />
		&nbsp;&nbsp;<img src='Javascript/HeroQuest_V2/images/dee/Dee.GIF' name='Dee1'>
		&nbsp;&nbsp;<img src='Javascript/HeroQuest_V2/images/dee/Dee.GIF' name='Dee2'>
	<br />
		<table border="0" align="center"  width="50%">
			<tr>
			<td>Attaque</td>
			<td><img src='Javascript/HeroQuest_V2/images/dee/E01.jpg' class="test" id='DA0' name='DA0'></td>
			<td><img src='Javascript/HeroQuest_V2/images/dee/E01.jpg' class="test" id='DA1' name='DA1'></td>
			<td><img src='Javascript/HeroQuest_V2/images/dee/E01.jpg' class="test" id='DA2' name='DA2'></td>
			<td><img src='Javascript/HeroQuest_V2/images/dee/E01.jpg' class="test" id='DA3' name='DA3'></td>
			<td><img src='Javascript/HeroQuest_V2/images/dee/E01.jpg' class="test" id='DA4' name='DA4'></td>
			<td><img src='Javascript/HeroQuest_V2/images/dee/E01.jpg' class="test" id='DA5' name='DA5'></td>
			<td><img src='Javascript/HeroQuest_V2/images/dee/E01.jpg' class="test" id='DA6' name='DA6'></td>
			<td><img src='Javascript/HeroQuest_V2/images/dee/E01.jpg' class="test" id='DA7' name='DA7'></td>
			</tr>
			
			<tr>
			<td>Defence</td>
			<td><img src='Javascript/HeroQuest_V2/images/dee/E01.jpg' class="test" id='DD0' name='DD0'></td>
			<td><img src='Javascript/HeroQuest_V2/images/dee/E01.jpg' class="test" id='DD1' name='DD1'></td>
			<td><img src='Javascript/HeroQuest_V2/images/dee/E01.jpg' class="test" id='DD2' name='DD2'></td>
			<td><img src='Javascript/HeroQuest_V2/images/dee/E01.jpg' class="test" id='DD3' name='DD3'></td>
			<td><img src='Javascript/HeroQuest_V2/images/dee/E01.jpg' class="test" id='DD4' name='DD4'></td>
			<td><img src='Javascript/HeroQuest_V2/images/dee/E01.jpg' class="test" id='DD5' name='DD5'></td>
			<td><img src='Javascript/HeroQuest_V2/images/dee/E01.jpg' class="test" id='DD6' name='DD6'></td>
			<td><img src='Javascript/HeroQuest_V2/images/dee/E01.jpg' class="test" id='DD7' name='DD7'></td>
			</tr>
		</table>
	</div>
	
		
	<div id="Debug">

	</div>

		<A style="CURSOR: n-resize" href="javascript:void(0)" id="atop" 	name="atop"></A>
		<A style="CURSOR: w-resize" href="javascript:void(0)" id="aleft" 	name="aleft"></A>
		<A style="CURSOR: e-resize" href="javascript:void(0)" id="aright"   name="aright"></A>
		<A style="CURSOR: s-resize" href="javascript:void(0)" id="abottom"  name="abottom" ></A>


	</form>

	
	<div style="color:red;">
	<?php include("./Vues/Carte-PageHero-EtatHero.php");?>
	</div>
	
	</div>





<script Language="JavaScript" src="Javascript/HeroQuest_V2/ModuleActionJeu.js"></script>
<script Language="JavaScript" src="Javascript/HeroQuest_V2/ModulePiece.js"></script>
<script Language="JavaScript" src="Javascript/HeroQuest_V2/ModulePersonnage.js"></script>
<script Language="JavaScript" src="Javascript/HeroQuest_V2/ModuleIAMonstre.js"></script>
<script Language="JavaScript" src="Javascript/HeroQuest_V2/ModuleCombat.js"></script>
<script Language="JavaScript" src="Javascript/HeroQuest_V2/ModuleCarteTresor.js"></script>
<script Language="JavaScript" src="Javascript/HeroQuest_V2/ModuleCarteHero.js"></script>
<script Language="JavaScript" src="Javascript/HeroQuest_V2/ModuleSave.js"></script>


<?php	if(!isset($_SESSION['ReloadPartie'])){
	echo '<script Language="JavaScript" src="Javascript/HeroQuest_V2/quest/quest'.$IdAventure.'.js"></script>';
	}
	else{
	
	echo '<script type="text/javascript">initialiserJeux()</script>';
	}
?>

</body></html>