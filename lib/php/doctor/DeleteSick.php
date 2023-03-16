<?php
include 'conn.php';

$sick_id = $_POST['sick_id'];

    $dbdata = array();
    $sql = "DELETE FROM `sick` WHERE `id`='$sick_id'";
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