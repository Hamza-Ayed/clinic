<?php
include 'conn.php';

$id = $_POST['id'];

$dbdata = array();
$sql = "SELECT client.id,client.date,client.status,client.ilac_id,client.ilac_id2,client.ilac_id3,client.ilac_id4,client.ilac_id5,client.tempreture,sick.id,sick.name,TIMESTAMPDIFF(YEAR, sick.birth_date, CURDATE()) AS age,sick.telphone,subject.id,subject.subject_name FROM `client` LEFT join sick on sick.id=client.sick_id left join subject on subject.id=client.ilac_id WHERE sick.id=$id ";

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
