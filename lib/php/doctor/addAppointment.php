<?php
include 'conn.php';

    $description = $_POST['description'];
    $startDate = $_POST['startDate'];
    $endDate = $_POST['endDate'];
    $color = $_POST['color'];
    $doctor_id = $_POST['doctor_id'];
    $sick_id = $_POST['sick_id'];
    
    
    $sql = "INSERT INTO `appointment`(`id`, `description`, `startDate`, `endDate`, `color`,`doctor_id`,`sick_id`) VALUES (NULL,'$description','$startDate','$endDate','$color','$doctor_id','$sick_id')";
   $result = $conn->query($sql);
    if ($result) { 
        echo json_encode('Added');    
    } else {
        echo json_encode('Not Added');    
    }
    $conn->close();
return;