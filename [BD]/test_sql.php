<?php
$cnx=new mysqli("localhost","root","","venta2022b");
$stmt="SELECT insert_pasajero(0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0);";
// $stmt="select estadoAsientos(99999999999, 8, 10, 1, 'a');";
// $stmt="SHOW TABLES;";
$rs=$cnx->query($stmt);

// if (mysqli_connect_errno()) {
//     echo "Failed to connect to MySQL: " . mysqli_connect_error();
// }
// echo "<br><br><br><br>";
if($cnx->error){
    var_dump($cnx->error);
}else{
    var_dump($rs);
    echo "<br>";
    while($row=$rs->fetch_object()){
        var_dump($row);
    }
}
?>