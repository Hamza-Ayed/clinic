<?php
include 'conn.php';

    $device_id = $_POST['device_id'];
    $password = $_POST['password'];
    $doctor_name = $_POST['doctor_name'];

    
    $dbdata = array();
    $sql = "SELECT `doctor_id`, `doctor_name`, `password`, `device_id`, `roles_id`, `phone`, `clientName`, TIMESTAMPDIFF(DAY, `date_register`, CURDATE()) AS session_period, `reg` FROM `doctors` ";
    $result = $conn->query($sql);
    if ($result->num_rows > 0) {
        while ($row = $result->fetch_assoc()) {
            $dbdata[] = $row;
        }
        echo json_encode($dbdata);
    } else {
        echo
        json_encode($dbdata);
    }
    $conn->close();
    return;