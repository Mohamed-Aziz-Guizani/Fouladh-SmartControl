<?php
header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json; charset=UTF-8");
include 'db.php';

// On récupère le département envoyé par Flutter (ex: "DEA")
$dept = $_POST['dept'];

if(empty($dept)){
    echo json_encode([]);
    exit();
}

// Requête SQL filtrée
$sql = "SELECT * FROM machine WHERE dept = ?";
$stmt = $conn->prepare($sql);
$stmt->bind_param("s", $dept);
$stmt->execute();
$result = $stmt->get_result();

$machines = array();
while($row = $result->fetch_assoc()) {
    $machines[] = $row;
}

echo json_encode($machines);
$conn->close();
?>