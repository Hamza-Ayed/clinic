<?php
include 'conn.php';

 $doctor_id = $_POST['doctor_id'];

    $dbdata = array();
    $sql = "SELECT *,TIMESTAMPDIFF(YEAR, sick.birth_date, CURDATE()) AS age FROM `sick`  WHERE `doctor_id`='$doctor_id' ORDER BY `sick`.`id` DESC";
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