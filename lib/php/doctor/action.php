<?php

$db_name = 'doctors';
$db_user = 'root';
$db_pass = '';//S+iAPznEwh_?E#P2
$db_host = 'localhost';
$conn = mysqli_connect($db_host, $db_user, $db_pass, $db_name);


if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}

?>