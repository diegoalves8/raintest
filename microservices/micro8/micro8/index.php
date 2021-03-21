<html>
<head>
<script>
 function Send_Data() {
  var name=document.getElementById("name").value;
  var birthday=document.getElementById("birthday").value;

  var httpr=new XMLHttpRequest();
  httpr.open("POST", "./get_data.php", true);
  httpr.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
  httpr.onreadystatechange=function(){
    if(httpr.readyState==4 && httpr.status==200){
      document.getElementById("response").innerHTML=httpr.responseText;
    }
  }
  httpr.send("name="+name+"&birthday="+birthday);
 }
</script>

</head>
<body>
<div class="form">
  <center><h3>Microservice 8</h3></center>
<hr />
<center>
<input type="text" id="name" placeholder="Enter name" />
<br />
<input type="text" id="birthday" placeholder="Enter your birth year" />
<br />
<input type="button" value="Submit" onclick="Send_Data()" />

<form action="retrieve.php">
<input type="Submit" value="Fetch">
</form>
<form method="post" action="#">
  Enter IP you want to ping:<br>
  <input type="text" name="ip">
  <input type="submit" name="submit" value="Submit" />
  <br>
</form>
<?php
$IPECS = isset($_SERVER['SERVER_ADDR'])?$_SERVER['SERVER_ADDR']:gethostbyname(gethostname());
echo "Server IP Address is: $IPECS";
echo "</br>";

if (isset($_POST['submit'])) {
$ip=$_POST['ip'];
exec("ping -c 1 " . $ip . " | head -n 2 | tail -n 1 ", $ping_time);
echo "</br>";
  print $ping_time[0]; // First item in array, since exec returns an array.
  unset($ping_time);
  unset($ip);
echo "</br>";
}
?>

<span id="response">
</center>
</span>
</div>
</body>
</html>
