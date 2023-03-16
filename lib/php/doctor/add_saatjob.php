<?php
include 'conn.php';


$startjob = $_POST['startjob'];
$endjob = $_POST['endjob'];
$doctor_id = $_POST['doctor_id'];
$secretary_id  = $_POST['secretary_id'];
$date  = $_POST['date'];


$sql = "INSERT INTO `saatjob`(`saat_id`, `date`, `secretary_id`, `doctor_id`, `startjob`, `endjob`) VALUES  (NULL,'$date','$secretary_id','$doctor_id','$startjob','$endjob')";
$result = $conn->query($sql);
// echo json_encode($sql);
if ($result) {
    echo json_encode('Added');
} else {
    echo json_encode('Not Added');
}
$conn->close();
return;
