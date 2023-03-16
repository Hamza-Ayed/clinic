<?php
include 'conn.php';


$sick_id = $_POST['sick_id'];

$dbdata = array();
$sql = "SELECT appointment.id as Appointment,appointment.description,appointment.startDate,appointment.endDate,appointment.doctor_id,appointment.sick_id, sick.name, sick.telphone, sick.doctor_id FROM `appointment` LEFT JOIN `sick` ON sick.id = appointment.sick_id WHERE `appointment`.`sick_id` = '$sick_id' ORDER BY `appointment`. `id` DESC    ";

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
