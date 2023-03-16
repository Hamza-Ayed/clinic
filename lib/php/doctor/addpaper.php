<?php
include 'conn.php';

    
    $paperCount = $_POST['paperCount'];
    $doctor_id = $_POST['doctor_id'];
    $date  = $_POST['date'];
    
    
    $sql = "INSERT INTO `paper`(`id`, `doctor_id`, `paperCount`, `date`) VALUES(NULL,'$doctor_id','$paperCount','$date')";
   $result = $conn->query($sql);
   // echo json_encode($sql);
    if ($result) { 
        echo json_encode('Added');    
    } else {
        echo json_encode('Not Added');    
    }
    $conn->close();
return;