
<?php
include 'conn.php';

$id = $_POST['id'];
$count = $_POST['count'];

    $dbdata = array();
    $sql = "UPDATE `clientDrugs` SET `count` = '$count' WHERE `clientDrugs`.`id` = '$id';  ";
    // echo $sql;
    $result = $conn->query($sql);
    if ($result) { 
        echo json_encode('Updated');    
    } else {
        echo json_encode('Not Updated');    
    }
    $conn->close();
return;