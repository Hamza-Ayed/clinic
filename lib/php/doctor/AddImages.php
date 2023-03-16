<?php
include 'conn.php';


$name = $_POST['name'];
$image = $_POST['image'];
// $image = $_FILES['image']['name'];

// $imagePath = 'upload/' . $image;
// $tmp_name = $_FILES['image']['tmp_name'];

// move_uploaded_file($tmp_name, $imagePath);


$sql = "INSERT INTO `img`(`id`, `name`, `image`) VALUES(NULL,'$name','$image');";
$result = $conn->query($sql);

if ($result) {
    echo json_encode('Added');
} else {
    echo json_encode('Not Added');
}
$conn->close();
return;
