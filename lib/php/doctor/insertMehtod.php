<?php
include 'conn.php';


    $name       = $_POST['name'];
    $birth_date = $_POST['birth_date'];
    $telphone   = $_POST['telphone'];

    $dbdata = array();
    $sql = "INSERT INTO `sick`(`id`, `name`, `birth_date`, `telphone`) VALUES (null,'$name','$birth_date','$telphone')";
   $result = $conn->query($sql);
    if ($result) { 
        echo json_encode('Added');    
    } else {
        echo json_encode('Not Added');    
    }
    $conn->close();
return;