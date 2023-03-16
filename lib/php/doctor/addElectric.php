<?php
include 'conn.php';
 $token= $_SESSION['token']=md5(uniqid(mt_rand(),more_entropy:true));
    $total_bill = $_POST['total_bill'];
    $kilo_month = $_POST['kilo_month'];
    $date = $_POST['date'];
    $doctor_id = $_POST['doctor_id'];

    $dbdata = array();
    $sql = "INSERT INTO `Electric`(`id`, `Electric_id`, `total_bill`, `kilo_month`, `date`,`doctor_id`)VALUES (null,'$token','$total_bill','$kilo_month','$date','$doctor_id')";
   $result = $conn->query($sql);
    if ($result) { 
        echo json_encode('Added');    
    } else {echo json_encode($dbdata);
        echo json_encode('Not Added');    
    }
    $conn->close();
return;