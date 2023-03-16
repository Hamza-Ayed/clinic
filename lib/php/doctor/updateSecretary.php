
<?php
include 'conn.php';

$id = $_POST['id'];
$updated = $_POST['updated'];

    $dbdata = array();
    $sql = "UPDATE `secretary` SET `roles_id` = '$updated' WHERE `secretary`.`secretary_id_tabi` = '$id';  ";
    // echo $sql;
    $result = $conn->query($sql);
    if ($result) { 
        echo json_encode('Updated');    
    } else {
        echo json_encode('Not Updated');    
    }
    $conn->close();
return;