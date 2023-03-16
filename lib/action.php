<?php

$db_name = 'epiz_30052143_doctor_m_eid';
$db_user = 'epiz_30052143';
$db_pass = 'wCHa60CgNUhe';
$db_host = 'sql300.epizy.com';
$conn = mysqli_connect($db_host, $db_user, $db_pass, $db_name);


if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}

$action = $_POST['action'];


if ('getClient' == $action) {
    $id = $_POST['id'];

    $dbdata = array();
    $sql = "SELECT client.id,DATE_FORMAT(client.date, '%d-%m-%Y'),client.status,client.tempreture,sick.id,sick.name,TIMESTAMPDIFF(YEAR, sick.birth_date, CURDATE()) AS age,sick.telphone,subject.id,subject.subject_name FROM `client` LEFT join sick on sick.id=client.sick_id left join subject on subject.id=client.ilac_id WHERE sick.id=$id  ";
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
}


if ('getHelthChecks' == $action) {
    $id = $_POST['id'];

    $dbdata = array();
    $sql = "SELECT * FROM `testTabel` ";
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
}

if ('getSecretary' == $action) {
    $doctorId = $_POST['doctorId'];

    $dbdata = array();
    $sql = "SELECT * FROM `doctors` WHERE `device_id` =$doctorId ";
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
}


if ('LOGIN' == $action) {
    $device_id = $_POST['device_id'];
    $password = $_POST['password'];
    $doctor_name = $_POST['doctor_name'];

    $dbdata = array();
    $sql = "SELECT `doctor_name`,`password`,`device_id` FROM `doctors` WHERE `device_id`= '$device_id' AND `password`='$password' AND `doctor_name`='$doctor_name'";
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
}

if ('getMethod' == $action) {
    // $sql = $_POST['SQL'];

    $dbdata = array();
    $sql = "SELECT * FROM `sick`";
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
}

if ('getDrugs' == $action) {
    // $sql = $_POST['SQL'];

    $dbdata = array();
    $sql = "SELECT * FROM `subject`";
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
}

if ('getSick' == $action) {
    $doctor_id = $_POST['doctor_id'];

    $dbdata = array();
    $sql = "SELECT * FROM `sick` WHERE `doctor_id`='$doctor_id'";
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
}


if ('getClientDrugs' == $action) {
    $doctor_id = $_POST['doctor_id'];

    $dbdata = array();
    $sql = "SELECT * FROM `clientDrugs` WHERE `doctor_id`='$doctor_id'";
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
}

if ('insertMehtod' == $action) {
    // $sql = $_POST['SQLs'];
    $name = $_POST['name'];
    $birth_date = $_POST['birth_date'];
    $telphone = $_POST['telphone'];

    $dbdata = array();
    $sql = "INSERT INTO `sick`(`id`, `name`, `birth_date`, `telphone`) VALUES (null,'$name','$birth_date','$telphone')";
    $result = $conn->query($sql);
    if ($result->num_rows > 0) {
        while ($row = $result->fetch_assoc()) {
            $dbdata[] = $row;
        }
        echo json_encode($dbdata);
        // echo $sql;
    } else {

        echo json_encode($dbdata);
        // echo $sql;
    }
    $conn->close();
    return;
}

if ('addClientSickreview' == $action) {
    $date = $_POST['date'];
    $status = $_POST['status'];
    $sick_id = $_POST['sick_id'];
    $ilac_id = $_POST['ilac_id'];
    $tempreture = $_POST['tempreture'];
    $ilac_id2 = $_POST['ilac_id2'];
    $ilac_id3 = $_POST['ilac_id3'];
    $ilac_id4 = $_POST['ilac_id4'];
    $ilac_id5 = $_POST['ilac_id5'];
    $doctor_id = $_POST['doctor_id'];
    $image = $_POST['image'];

    // $img = base64_decode($image);
    // file_put_contents($date, $img);

    $dbdata = array();
    $sql = "INSERT INTO `client`(`id`, `date`, `status`, `sick_id`, `ilac_id`, `tempreture`, `ilac_id2`, `ilac_id3`, `ilac_id4`, `ilac_id5`,doctor_id,image) VALUES (null,'$date','$status','$sick_id','$ilac_id','$tempreture','$ilac_id2','$ilac_id3','$ilac_id4','$ilac_id5','$doctor_id','$image')";
    $result = $conn->query($sql);
    if ($result->num_rows > 0) {
        while ($row = $result->fetch_assoc()) {
            $dbdata[] = $row;
        }
        echo json_encode($dbdata);
        // echo $sql;
    } else {

        echo json_encode($dbdata);
        // echo $sql;
    }
    $conn->close();
    return;
}

if ('AddDrug' == $action) {

    $subject_name = $_POST['subject_name'];
    $barcode = $_POST['barcode'];

    $dbdata = array();
    $sql = "INSERT INTO `subject`(`id`, `subject_name`, `barcode`) VALUES (null,'$subject_name','$barcode')";
    $result = $conn->query($sql);
    if ($result->num_rows > 0) {
        while ($row = $result->fetch_assoc()) {
            $dbdata[] = $row;
        }
        echo json_encode($dbdata);
        // echo $sql;
    } else {

        echo json_encode($dbdata);
        // echo $sql;
    }
    $conn->close();
    return;
}


if ('addClientDrug' == $action) {

    $ilacName = $_POST['ilacName'];
    $count = $_POST['count'];
    $price = $_POST['price'];
    $doctor_id = $_POST['doctor_id'];

    $dbdata = array();
    $sql = "INSERT INTO `clientDrugs`(`id`, `ilacName`, `count`,price,doctor_id) VALUES (null,'$ilacName','$count','$price','$doctor_id')";
    $result = $conn->query($sql);
    if ($result->num_rows > 0) {
        while ($row = $result->fetch_assoc()) {
            $dbdata[] = $row;
        }
        echo json_encode($dbdata);
        // echo $sql;
    } else {

        echo json_encode($dbdata);
        // echo $sql;
    }
    $conn->close();
    return;
}

if ('AddSick' == $action) {

    $name = $_POST['name'];
    $birth_date = $_POST['birth_date'];
    $telphone = $_POST['telphone'];
    $doctor_id = $_POST['doctor_id'];

    $dbdata = array();
    $sql = "INSERT INTO `sick`(`id`, `name`, `birth_date`, `telphone`, `doctor_id`) VALUES (null,'$name','$birth_date','$telphone','$doctor_id')";
    $result = $conn->query($sql);
    if ($result->num_rows > 0) {
        while ($row = $result->fetch_assoc()) {
            $dbdata[] = $row;
        }
        echo json_encode($dbdata);
        // echo $sql;
    } else {

        echo json_encode($dbdata);
        // echo $sql;
    }
    $conn->close();
    return;
}


if ('AddImages' == $action) {

    $name = $_POST['name'];
    $image = $_FILES['image']['name'];

    $imagePath = 'upload/' . $image;
    $tmp_name = $_FILES['image']['tmp_name'];

    move_uploaded_file($tmp_name, $imagePath);

    $dbdata = array();
    // $sql = "INSERT INTO `img`(`id`, `name`, `image`) VALUES  (null,'$name','$image')";
    $sql = "INSERT INTO `img`(`id`, `name`, `image`) VALUES (NULL,'" . $name . "'.'" . $image . "')";
    $result = $conn->query($sql);
    if ($result->num_rows > 0) {
        while ($row = $result->fetch_assoc()) {
            $dbdata[] = $row;
        }
        echo json_encode($dbdata);
        // echo $sql;
    } else {

        echo json_encode($dbdata);
        // echo $sql;
    }
    $conn->close();
    return;
}


if ('AddIMAGESSS' == $action) {

    $name = $_POST['name'];
    $birth_date = $_POST['birth_date'];
    $telphone = $_POST['telphone'];
    $doctor_id = $_POST['doctor_id'];

    $dbdata = array();
    $sql = "INSERT INTO `sick`(`id`, `name`, `birth_date`, `telphone`, `doctor_id`) VALUES (null,'$name','$birth_date','$telphone','$doctor_id')";
    $result = $conn->query($sql);
    if ($result->num_rows > 0) {
        while ($row = $result->fetch_assoc()) {
            $dbdata[] = $row;
        }
        echo json_encode($dbdata);
        // echo $sql;
    } else {

        echo json_encode($dbdata);
        // echo $sql;
    }
    $conn->close();
    return;
}


if ('DeleteDoctors' == $action) {
    $doctor_id = $_POST['doctor_id'];

    $dbdata = array();
    $sql = "DELETE FROM `doctors` WHERE `doctor_id`='$doctor_id'";
    $result = $conn->query($sql);
    if ($result->num_rows > 0) {
        while ($row = $result->fetch_assoc()) {
            $dbdata[] = $row;
        }
        echo json_encode($dbdata);
        // echo $sql;
    } else {

        echo json_encode($dbdata);
        // echo $sql;
    }
    $conn->close();
    return;
}





if ('AddDoctors' == $action) {

    $doctor_name = $_POST['doctor_name'];
    $password = $_POST['password'];
    $device_id = $_POST['device_id'];
    $roles_id = $_POST['roles_id'];
    $phone = $_POST['phone'];

    $dbdata = array();
    $sql = "INSERT INTO `doctors`(`doctor_id`, `doctor_name`, `password`, `device_id`, `roles_id`,phone) VALUES (null,'$doctor_name','$password','$device_id','$roles_id',$phone)";
    $result = $conn->query($sql);
    if ($result->num_rows > 0) {
        while ($row = $result->fetch_assoc()) {
            $dbdata[] = $row;
        }
        echo json_encode($dbdata);
        // echo $sql;
    } else {

        echo json_encode($dbdata);
        // echo $sql;
    }
    $conn->close();
    return;
}
