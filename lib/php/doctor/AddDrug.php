<?php
include 'conn.php';

$subject_name = $_POST['subject_name'];
    $barcode = $_POST['barcode'];

   
    $sql = "INSERT INTO `subject`(`id`, `subject_name`, `barcode`) VALUES (null,'$subject_name','$barcode')";
    $result = $conn->query($sql);
    if ($result) { 
        echo json_encode('Added');    
    } else {
        echo json_encode('Not Added');    
    }
    $conn->close();
return;