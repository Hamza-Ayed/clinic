<?php
include 'conn.php';

$id = $_POST['id'];

    $dbdata = array();
    $sql = "UPDATE `clientDrugs` SET `count`=`count`-1 WHERE `id`='$id' ";
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