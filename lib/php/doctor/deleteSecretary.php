<?php
include 'conn.php';

$secretary_id_tabi = $_POST['secretary_id_tabi'];

    $dbdata = array();
    $sql = "DELETE FROM `secretary` WHERE `secretary`.`secretary_id_tabi` = '$secretary_id_tabi'";
    $result = $conn->query($sql);
    if ($result->num_rows > 0) {
        while ($row = $result->fetch_assoc()) {
            $dbdata[] = $row;
        }
        echo json_encode($dbdata);
        echo $sql;
    } else {

        echo json_encode($dbdata);
        // echo $sql;
    }
    $conn->close();
    return;