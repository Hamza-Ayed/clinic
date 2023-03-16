<?php
include 'conn.php';

    $Secretary_id = $_POST['Secretary_id'];
    $salary = $_POST['salary'];
    $salary_pluse = $_POST['salary_pluse'];
    $salary_minus = $_POST['salary_minus'];
    $doctor_id = $_POST['doctor_id'];
    $date  = $_POST['date'];


    $dbdata = array();
    $sql = "INSERT INTO `salary`(`salary_id`, `Secretary_id`, `doctor_id`, `salary`, `salary_pluse`, `salary_minus`, `date`) VALUES (NULL, '$Secretary_id', '$doctor_id', '$salary', '$salary_pluse', '$salary_minus','$date');";
   
    $result = $conn->query($sql);
    // echo json_encode($sql)
    if ($result) { 
        echo json_encode('Added');    
    } else {
        
        echo json_encode('Not Added');    
    }
    $conn->close();
return;