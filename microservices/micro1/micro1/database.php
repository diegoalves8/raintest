<?php
$url='rainusdb.ceoxbnwk2oae.us-east-1.rds.amazonaws.com:3306';
$username='root';
$password='vander123';
$database='microapi';
$tabledb='rainus_db';
$conn=mysqli_connect($url,$username,$password,$database);
if(!$conn){
	 die('Could not Connect My Sql:' .mysql_error());
}
?>
