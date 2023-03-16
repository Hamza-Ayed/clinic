<?php
include 'conn.php';
 $doctor_id = $_POST['doctor_id'];

 $dbdata = array();
    $sql = "SELECT salary.`salary_id`, salary.`Secretary_id`, salary.`doctor_id`, salary.`salary`, salary.`salary_pluse`, salary.`salary_minus`, doctors.doctor_name, doctors.date_register, doctors.phone, sum(salary.salary)as totalSalary FROM `salary` LEFT JOIN doctors ON doctors.doctor_id = salary.Secretary_id WHERE doctors.roles_id = '2' AND salary.doctor_id = '$doctor_id' GROUP by salary.Secretary_id;";
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