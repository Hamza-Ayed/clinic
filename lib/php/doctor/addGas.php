<?php
include 'conn.php';

    
    $gasCount = $_POST['gasCount'];
    $doctor_id = $_POST['doctor_id'];
    $date  = $_POST['date'];
    
    
    $sql = "INSERT INTO `Gas`(`id`, `doctor_id`, `gasCount`, `date`) VALUES(NULL,'$doctor_id','$gasCount','$date')";
   $result = $conn->query($sql);
   // echo json_encode($sql);
    if ($result) { 
        echo json_encode('Added');    
    } else {
        echo json_encode('Not Added');    
    }
    $conn->close();
return;