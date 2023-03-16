<?php
include 'conn.php';


$doctor_id = $_POST['doctor_id'];

$dbdata = array();
$sql = "SELECT appointment.id AS Appointment, appointment.description, appointment.startDate, appointment.endDate, appointment.doctor_id, appointment.sick_id, sick.name, sick.telphone, sick.doctor_id, doctors.clientName as doctorName, doctors.phone as doctorphone FROM `appointment` LEFT JOIN `sick` ON sick.id = appointment.sick_id LEFT JOIN doctors ON doctors.doctor_id = appointment.doctor_id WHERE `appointment`.`doctor_id` = '$doctor_id' AND `startDate` >= CURRENT_DATE() ORDER BY `appointment`.`startDate` ASC";

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
