<?php
include 'conn.php';

    
    $count = $_POST['count'];
    $doctor_id = $_POST['doctor_id'];
    $date  = $_POST['date'];
    
    
    $sql = "INSERT INTO `TibiIhtiac`(`id`, `doctor_id`, `count`, `date`)VALUES(NULL,'$doctor_id','$count','$date')";
   $result = $conn->query($sql);
   // echo json_encode($sql);
    if ($result) { 
        echo json_encode('Added');    
    } else {
        echo json_encode('Not Added');    
    }
    $conn->close();
return;