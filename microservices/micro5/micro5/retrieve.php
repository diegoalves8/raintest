<?php
include_once 'database.php';
$result = mysqli_query($conn,"SELECT * FROM rainus_db");
?>
<!DOCTYPE html>
<html>
 <head>
 <title> Retrive data</title>
 </head>
<body>
<?php
if (mysqli_num_rows($result) > 0) {
?>
  <table>
  
  <tr>
    <td>ID</td>
    <td>Name</td>
    <td>Birthday</td>
  </tr>
<?php
	$i=0;
	while($row = mysqli_fetch_array($result)) {
?>
<tr>
    <td><?php echo $row["id"]; ?></td>
    <td><?php echo $row["name"]; ?></td>
    <td><?php echo $row["birthday_year"]; ?></td>
</tr>
<?php
		$i++;
	}
?>
</table>
 <?php
}
else{
	    echo "No result found";
}
?>
<form action="index.php">
<input type="Submit" value="Back">
</form>
 </body>
</html>
