
<?php
include 'conn.php';

// $doctorId = $_POST['doctorId'];

    $dbdata = array();
    $sql = "SELECT sick.id,sick.name,sick.birth_date,sick.telphone,sick.gender,sick.site,sick.dateRegister, doctors.doctor_name, doctors.doctor_id FROM `sick` LEFT JOIN doctors ON doctors.doctor_id = sick.doctor_id ORDER BY sick.name ASC  ";
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