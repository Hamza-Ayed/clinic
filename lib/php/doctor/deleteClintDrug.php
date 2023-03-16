<?php
include 'conn.php';

$id = $_POST['id'];

    $dbdata = array();
    $sql = "DELETE FROM `clientDrugs` WHERE `clientDrugs`.`id` = '$id'";
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