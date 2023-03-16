<?php
include 'conn.php';


    $date       = $_POST['date'];
    $status     = $_POST['status'];
    $sick_id    = $_POST['sick_id'];
    $ilac_id    = $_POST['ilac_id'];
    $tempreture = $_POST['tempreture'];
    $ilac_id2   = $_POST['ilac_id2'];
    $ilac_id3   = $_POST['ilac_id3'];
    $ilac_id4   = $_POST['ilac_id4'];
    $ilac_id5   = $_POST['ilac_id5'];
    $doctor_id  = $_POST['doctor_id'];
    $image      = $_POST['image'];

    $dbdata = array();
    $sql = "INSERT INTO `client`(`id`, `date`, `status`, `sick_id`, `ilac_id`, `tempreture`, `ilac_id2`, `ilac_id3`, `ilac_id4`, `ilac_id5`, `doctor_id`, `image`) VALUES (NULL,'$date','$status','$sick_id','$ilac_id','$tempreture','$ilac_id2','$ilac_id3','$ilac_id4','$ilac_id5','$doctor_id','$image')";
    
    $result = $conn->query($sql);
    if ($result) { 
        echo json_encode('Added');    
    } else {
        echo json_encode('Not Added');    
    }
    $conn->close();
return;