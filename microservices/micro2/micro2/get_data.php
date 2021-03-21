<?php
if(isset($_POST['name'])){
$name=$_POST['name'];
$birthday_year=$_POST['birthday'];

include_once 'database.php';

$sql="INSERT INTO $tabledb(name,birthday_year) VALUES ('$name','$birthday_year');";
	
$result=mysqli_query($conn,$sql);

if($result==true){
		echo "<h3> The name $name and birthday $birthday_year were Inserted!</h3>";
}
}

?>
