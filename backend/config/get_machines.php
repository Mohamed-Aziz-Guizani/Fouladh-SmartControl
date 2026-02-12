<?php
header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json; charset=UTF-8");
include 'db.php';

$sql = "SELECT * FROM machine"; 
$result = $conn->query($sql);

$machines = array();
while($row = $result->fetch_assoc()) {
    $machines[] = $row;
}

echo json_encode($machines);
$conn->close();
?>