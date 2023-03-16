
<?php
include 'conn.php';

// $doctorId = $_POST['doctorId'];

    $dbdata = array();
    $sql = "SELECT doctors.doctor_id_tabi, doctors.`doctor_id`, doctors.`doctor_name`, doctors.`password`, doctors.`device_id`, doctors.`roles_id`, doctors.`phone`, doctors.`clientName`, doctors.`date_register`, doctors.`reg`, COUNT(sick.name) AS countSick FROM `doctors` LEFT JOIN sick ON sick.doctor_id = doctors.doctor_id WHERE `roles_id` = '1' GROUP BY doctors.doctor_id ORDER BY `countSick` DESC ";
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