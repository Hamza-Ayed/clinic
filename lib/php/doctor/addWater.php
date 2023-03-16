<?php
include 'conn.php';

    
    $waterCount = $_POST['waterCount'];
    $doctor_id = $_POST['doctor_id'];
    $date  = $_POST['date'];
    
    
    $sql = "INSERT INTO `Water`(`id`, `doctor_id`, `waterCount`, `date`)VALUES(NULL,'$doctor_id','$waterCount','$date')";
   $result = $conn->query($sql);
   // echo json_encode($sql);
    if ($result) { 
        echo json_encode('Added');    
    } else {
        echo json_encode('Not Added');    
    }
    $conn->close();
return;