

<html>
<head>
	<script src="MesParametre.js"></script>
		<script src="MesFonction.js"></script>
	
		
</head>

<body  >
	
		<a id="GestionMagazin" href="GestionMagazin.php" >GestionMagazin</a>
 
	<form name="test">
	
		<table border="0" align="center" style='width:731px;height:534px'  background="_quest_.bmp" > 
		<?php			$case=-1; 
		for($j=0; $j <19 ; $j++) { 
			echo "<tr>"; 
				for($i=0; $i <26 ; $i++) { 
					$case=   $case + 1;					
					echo "<td onclick='RepartiteurAction($case)'><img src='00.png' title='$case' id='$case'></td>";
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
	<div align=center>
	<input type="text" 	id="nomPartie"	name="nomPartie" 	size="20">
	<br />
	<a id="MyPartieSave" href="javascript:void(0)" onclick="SetActiverCase('4')">Activer-desactiver Depart</a>
	<a id="MyPartieSave" href="javascript:void(0)" onclick="SetActiverCase('1')">Activer-desactiver case</a>
	<a id="MyPartieSave" href="javascript:void(0)" onclick="SetActiverCase('2')">Activer-desactiver Piece</a>
	<a id="MyPartieSave" href="javascript:void(0)" onclick="SetActiverCase('5')">Activer-desactiver Piege</a>
	
	<a id="MyPartieSave" href="javascript:void(0)" onclick="MyPartieSave()">MyPartieSave</a>
	<a id="MyPartieSave" href="javascript:void(0)" onclick="MyPartieSave()">MyPartieSave</a>
	<br />
	<img src='images/monstre/00.bmp' title='test' id='M1' onclick="ChooseMonstre('1')" />
	<img src='images/monstre/01.bmp' title='test' id='M2' onclick="ChooseMonstre('2')" />
	<img src='images/monstre/02.bmp' title='test' id='M3' onclick="ChooseMonstre('3')" />
	<img src='images/monstre/03.bmp' title='test' id='M4' onclick="ChooseMonstre('4')" />
	<img src='images/monstre/04.bmp' title='test' id='M5' onclick="ChooseMonstre('5')" />
	<img src='images/monstre/05.bmp' title='test' id='M6' onclick="ChooseMonstre('6')" />
	<img src='images/monstre/06.bmp' title='test' id='M7' onclick="ChooseMonstre('7')" />
	<img src='images/monstre/07.bmp' title='test' id='M8' onclick="ChooseMonstre('8')" />
	<img src='images/monstre/08.bmp' title='test' id='M9' onclick="ChooseMonstre('9')" />
	<img src='images/monstre/09.bmp' title='test' id='M10' onclick="ChooseMonstre('10')" />
	<img src='images/monstre/10.bmp' title='test' id='M11' onclick="ChooseMonstre('11')" />
	<img src='images/monstre/11.bmp' title='test' id='M12' onclick="ChooseMonstre('12')" />
	<img src='images/monstre/12.bmp' title='test' id='M13' onclick="ChooseMonstre('13')" />
	<img src='images/monstre/13.bmp' title='test' id='M14' onclick="ChooseMonstre('14')" />
	<img src='images/monstre/16.bmp' title='test' id='M17' onclick="ChooseMonstre('17')" />
	<img src='images/monstre/17.bmp' title='test' id='M18' onclick="ChooseMonstre('18')" />
	<img src='images/monstre/18.bmp' title='test' id='M19' onclick="ChooseMonstre('19')" />
	<img src='images/monstre/19.bmp' title='test' id='M20' onclick="ChooseMonstre('20')" />

	<form action="sampleposteddata.php" name="other" method="post" target="_blank">
	<?php 
		include_once("fckeditor/fckeditor.php");

			
					$oFCKeditor = new FCKeditor('FCKeditor1') ;
					$oFCKeditor->BasePath = 'fckeditor/' ;
					$oFCKeditor->Value = 'Nouvelle config' ;
					$oFCKeditor->Width = 580 ;
					$oFCKeditor->Height = 400 ;
					if ( isset($_POST['modifier'])) { $oFCKeditor->Value =stripslashes($row['2']);}
					$oFCKeditor->Create() ;
	?>
				</form> 
</div>

	
</body></html>