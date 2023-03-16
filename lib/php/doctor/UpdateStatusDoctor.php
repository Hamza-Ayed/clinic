
<?php
include 'conn.php';

$doctorId = $_POST['doctorId'];
$status = $_POST['status'];

    $dbdata = array();
    $sql = "UPDATE `doctors` SET `reg` = '$status' WHERE `doctors`.`doctor_id` = '$doctorId' ";
    // echo $sql;
    $result = $conn->query($sql);
    if ($result) { 
        echo json_encode('Updated');    
    } else {
        echo json_encode('Not Updated');    
    }
    $conn->close();
return;