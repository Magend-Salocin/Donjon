<html><body>
		<table border="1"  align="center" background="images/carte.bmp"> 
		<?php			$case=-1; 
		for($j=0; $j <19 ; $j++) { 
			echo "<tr>"; 
				for($i=0; $i <26 ; $i++) { 
					 $case=   $case + 1;
					 echo "<td width='25' height='25'>$case</td>";
				}
			echo "</tr>";
		}
		?>
		</table>
</body></html>