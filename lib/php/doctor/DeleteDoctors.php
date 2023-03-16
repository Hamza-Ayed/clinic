<?php
include 'conn.php';

$doctor_id = $_POST['doctor_id'];

    $dbdata = array();
    $sql = "DELETE FROM `doctors` WHERE `doctor_id`='$doctor_id'";
    $result = $conn->query($sql);
    if ($result->num_rows > 0) {
        while ($row = $result->fetch_assoc()) {
            $dbdata[] = $row;
        }
        echo json_encode($dbdata);
        // echo $sql;
    } else {

        echo json_encode($dbdata);
        // echo $sql;
    }
    $conn->close();
    return;