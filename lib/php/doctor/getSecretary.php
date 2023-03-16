
<?php
include 'conn.php';

$doctor_id = $_POST['doctor_id'];

    $dbdata = array();
    $sql = "SELECT * FROM `secretary` WHERE `doctor_id` ='$doctor_id '";
    // echo $sql;
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