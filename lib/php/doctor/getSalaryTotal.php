<?php
include 'conn.php';

 $doctor_id = $_POST['doctor_id'];
 $date = $_POST['date'];

    $dbdata = array();
    $sql = "SELECT ( SELECT SUM(Electric.total_bill) FROM `Electric` WHERE Electric.doctor_id = '$doctor_id' AND Electric.date='$date') AS total_bill, ( SELECT SUM(Gas.gasCount) FROM Gas WHERE Gas.doctor_id = '$doctor_id' ) AS gasCount, ( SELECT SUM(paper.paperCount) FROM paper WHERE paper.doctor_id = '$doctor_id' ) AS paperCount, ( SELECT SUM(Rental.rent_count) FROM Rental WHERE Rental.doctor_id = '$doctor_id' ) AS rent_count, ( SELECT SUM(salary.salary) FROM salary WHERE salary.doctor_id = '$doctor_id' ) AS salary, ( SELECT SUM(TibiIhtiac.count) FROM TibiIhtiac WHERE TibiIhtiac.doctor_id = '$doctor_id' ) AS tibi, ( SELECT SUM(Visiting.visitCount) FROM Visiting WHERE Visiting.doctor_id = '$doctor_id' ) AS visitCount,( SELECT SUM(Water.waterCount) FROM Water WHERE Water.doctor_id = '$doctor_id' ) AS waterCount;
;
";
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