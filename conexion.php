<?php
function connexionBD(){
    $host="localhost";
    $user="root";
    $pwd='';
    $bd="venta2022";

    return mysqli_connect($host, $user, $pwd, );
}

?>