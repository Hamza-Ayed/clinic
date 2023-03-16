<?php
include 'conn.php';

    $secretary_name       = $_POST['secretary_name'];
    $password = $_POST['password'];
   
    $doctor_id  = $_POST['doctor_id'];
    $roles_id     = $_POST['roles_id'];
    $phone      = $_POST['phone'];
    $date_register=$_POST['date_register'];
    $reg=$_POST['reg'];

    $dbdata = array();
    $sql = "INSERT INTO `secretary`(`secretary_id_tabi`, `doctor_id`, `secretary_name`, `password`, `roles_id`, `phone`, `date_register`, `reg`) VALUES(NULL,'$doctor_id','$secretary_name','$password','$roles_id','$phone','$date_register','$reg')";
    $result = $conn->query($sql);
    // echo json_encode($sql);
    if ($result) { 
        echo json_encode('Added');    
    } else {
        echo json_encode('Not Added');    
    }
    $conn->close();
return;