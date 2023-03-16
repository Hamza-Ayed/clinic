<?php
include 'conn.php';
    // $token= $_SESSION['token']=md5(uniqid(mt_rand(),more_entropy:true));
 $token  =   md5(uniqid(mt_rand(), true));
        $_SESSION['token'][$form]   =   $token; 
    $doctor_name = $_POST['doctor_name'];
    $password = $_POST['password'];
    $device_id = $_POST['device_id'];
    $roles_id = $_POST['roles_id'];
    $phone = $_POST['phone'];
    $date_register = $_POST['date_register'];
    $clientName = $_POST['clientName'];
    $reg = $_POST['reg'];

    
    $sql = "INSERT INTO `doctors`(`doctor_id_tabi`, `doctor_id`, `doctor_name`, `password`, `device_id`, `roles_id`, `phone`, `clientName`, `date_register`, `reg`)VALUES   (NULL,'$token','$doctor_name','$password','$device_id','$roles_id','$phone','$clientName', '$date_register','$reg')";
  $result = $conn->query($sql);
   // echo json_encode($sql);
    // if ($result) { 
    //     echo json_encode('Added');    
    // } else {
    //     echo json_encode('Not Added');    
    // }
    $conn->close();
return;