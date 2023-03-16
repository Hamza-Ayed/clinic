<?php
include 'conn.php';


$date = $_POST['date'];

$dbdata = array();
$sql = "SELECT * FROM `appointment` WHERE `startDate`='$date' ORDER BY `id`  DESC ";

$result = $conn->query($sql);
echo json_encode($sql);
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
