<?php
include 'conn.php';

$id = $_POST['id'];

    $dbdata = array();
    $sql = "DELETE FROM `appointment` WHERE `id`='$id'";
    $result = $conn->query($sql);
    if ($result->num_rows > 0) {
        while ($row = $result->fetch_assoc()) {
            $dbdata[] = $row;
        }
        echo json_encode('delete');
        // echo $sql;
    } else {

        echo json_encode('not delete');
        // echo $sql;
    }
    $conn->close();
    return;