<?php
include 'conn.php';

$name = $_POST['name'];
    $birth_date = $_POST['birth_date'];
    $telphone = $_POST['telphone'];
    $doctor_id = $_POST['doctor_id'];

    $dbdata = array();
    $sql = "INSERT INTO `sick`(`id`, `name`, `birth_date`, `telphone`, `doctor_id`) VALUES (null,'$name','$birth_date','$telphone','$doctor_id')";
   $result = $conn->query($sql);
    if ($result) { 
        echo json_encode('Added');    
    } else {
        echo json_encode('Not Added');    
    }
    $conn->close();
return;