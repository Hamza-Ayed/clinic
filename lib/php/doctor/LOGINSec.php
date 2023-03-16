<?php
include 'conn.php';

    // $device_id      = $_POST['device_id'];
    $password       = $_POST['password'];
    $secretary_name    = $_POST['secretary_name'];

    $dbdata = array();
    $sql = "SELECT secretary.secretary_id_tabi, secretary.doctor_id, secretary.secretary_name, secretary.password, secretary.roles_id, secretary.phone, secretary.date_register, secretary.reg, doctors.doctor_name, doctors.clientName, doctors.phone FROM `secretary` LEFT JOIN doctors ON doctors.doctor_id = secretary.doctor_id WHERE secretary.`password` = '$password' AND secretary.`secretary_name` = '$secretary_name' ";
    $result = $conn->query($sql);
    if ($result->num_rows ==1) {
        while ($row = $result->fetch_assoc()) {
            $dbdata[] = $row;
        }
        echo json_encode($dbdata);
    } else {
        // echo
        // json_encode($dbdata);
        echo json_encode('not match');
    }
    $conn->close();
    return;