<?php
include 'conn.php';

 $doctor_name = $_POST['doctor_name'];
 $password = $_POST['password'];
 $device_id = $_POST['device_id'];

    $dbdata = array();

    $sql = "SELECT `doctor_id`, `doctor_name`, `password`, `device_id`, `roles_id`, `phone`, `clientName`, TIMESTAMPDIFF(DAY, `date_register`, CURDATE()) AS session_period, `reg` FROM `doctors` WHERE `device_id` = '$device_id' AND `password` = '$password' AND `doctor_name` = '$doctor_name' ";
    $result = $conn->query($sql);
    if ($result->num_rows ==1) {
        while ($row = $result->fetch_assoc()) {
            $dbdata[] = $row;
        }
        echo json_encode($dbdata);
    } else {
        echo
        json_encode('not match words');
    }
    $conn->close();
    return;