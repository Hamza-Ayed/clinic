<?php
include 'conn.php';

    $name       = $_POST['name'];
    $birth_date = $_POST['birth_date'];
    $telphone   = $_POST['telphone'];
    $doctor_id  = $_POST['doctor_id'];
    $gender     = $_POST['gender'];
    $site       = $_POST['site'];
    $dateRegister=$_POST['dateRegister'];

    $dbdata = array();
    $sql = "INSERT INTO `sick`(`id`, `name`, `birth_date`, `telphone`, `doctor_id`, `gender`, `site`, `dateRegister`) VALUES (NULL,'$name','$birth_date','$telphone','$doctor_id','$gender','$site','$dateRegister')";
    $result = $conn->query($sql);
    // echo json_encode($sql);
    if ($result) { 
        echo json_encode('Added');    
    } else {
        echo json_encode('Not Added');    
    }
    $conn->close();
return;