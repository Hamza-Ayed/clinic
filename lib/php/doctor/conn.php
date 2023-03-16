<?php

// error_reporting(E_ALL ^ E_NOTICE);

$db_name = 'id18298913_doctordb';
$db_user = 'id18298913_doctor';
$db_pass = 'ECuc!Ks?Ls#NSKW4';
$db_host = 'localhost';
$conn = mysqli_connect($db_host, $db_user, $db_pass, $db_name);


if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}
// else{
//     echo 'true';
// }
// $doctor_id = !empty($_POST['doctor_id']) ? $_POST['doctor_id'] : '';


?>