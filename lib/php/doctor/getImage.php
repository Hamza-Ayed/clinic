<?php
include 'conn.php';

$dbdata = array();
    $sql = "SELECT * FROM `img` ORDER BY `img`.`id` DESC";
    if ($result->num_rows > 0) {
        while ($row = $result->fetch_assoc()) {
            $dbdata[] = $row;
        }
        echo json_encode($dbdata);
    } else {
        echo
        json_encode('Error not');
    }
    $conn->close();
    return;