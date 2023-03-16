<?php
include 'conn.php';

    $electric = $_POST['electric'];
    $salary = $_POST['salary'];
    $Visiting = $_POST['Visiting'];
    $ClinikRental = $_POST['ClinikRental'];
    $water = $_POST['water'];
    $gas = $_POST['gas'];
    $paper = $_POST['paper'];
    $doctorId = $_POST['doctorId'];
    $medicalsupplies = $_POST['medicalsupplies'];

    $dbdata = array();
    $sql = "INSERT INTO `Clinic expenses`(`id`, `salary`, `electric`, `Visiting`, `ClinikRental`, `water`, `gas`, `paper`, `medicalsupplies`,'doctorId') VALUES(NULL,'$salary','$electric','$Visiting','$ClinikRental','$water','$gas','$paper','$medicalsupplies','$doctorId')";
   
    $result = $conn->query($sql);
    if ($result) { 
        echo json_encode('Added');    
    } else {
        echo json_encode('Not Added');    
    }
    $conn->close();
return;