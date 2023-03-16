<?php
include 'conn.php';



$dbdata = array();
$sql = "SELECT saatjob.saat_id, saatjob.date, saatjob.secretary_id, saatjob.doctor_id, saatjob.startjob, saatjob.endjob, TIME_FORMAT( TIMEDIFF( saatjob.endjob, saatjob.startjob ), '%H ' ) AS period, doctors.doctor_name FROM `saatjob` LEFT JOIN doctors ON doctors.doctor_id = saatjob.secretary_id ";

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
