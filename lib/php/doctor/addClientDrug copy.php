<?php
include 'conn.php';

 $ilacName = $_POST['ilacName'];
    $count = $_POST['count'];
    $price = $_POST['price'];
    $doctor_id = $_POST['doctor_id'];

    $dbdata = array();
    $sql = "INSERT INTO `clientDrugs`(`id`, `ilacName`, `count`, `price`, `doctor_id`) VALUES(NULL,'$ilacName','$count','$price','$doctor_id')";
   
    $result = $conn->query($sql);
    if ($result) { 
        echo json_encode('Added');    
    } else {
        echo json_encode('Not Added');    
    }
    $conn->close();
return;