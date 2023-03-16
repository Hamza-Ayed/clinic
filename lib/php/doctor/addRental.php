<?php
include 'conn.php';

    
    $rent_count = $_POST['rent_count'];
    $doctor_id = $_POST['doctor_id'];
    $date  = $_POST['date'];
    
    
    $sql = "INSERT INTO `Rental`(`id`, `rent_count`, `doctor_id`, `date`)  VALUES(NULL,'$rent_count','$doctor_id','$date')";
   $result = $conn->query($sql);
   // echo json_encode($sql);
    if ($result) { 
        echo json_encode('Added');    
    } else {
        echo json_encode('Not Added');    
    }
    $conn->close();
return;