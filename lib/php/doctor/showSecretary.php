
<?php
include 'conn.php';

// $doctorId = $_POST['doctorId'];

    $dbdata = array();
    $sql = "SELECT secretary.secretary_id_tabi, secretary.doctor_id, secretary.secretary_name, secretary.password, secretary.roles_id, secretary.phone, secretary.date_register, secretary.reg, TIMESTAMPDIFF( MONTH, secretary.date_register, CURDATE()) AS month, TIMESTAMPDIFF( DAY, secretary.date_register, CURDATE()) AS days, doctors.doctor_name FROM `secretary` LEFT JOIN doctors ON doctors.doctor_id = secretary.doctor_id ORDER BY `secretary`.`doctor_id` DESC  ";
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