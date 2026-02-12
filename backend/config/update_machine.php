<?php
header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json; charset=UTF-8");
include 'db.php';

$id = $_POST['id_machine'];
$etat = $_POST['etat']; // 1 pour Marche, 0 pour Arrêt

$sql = "UPDATE machine SET etat = ? WHERE id_machine = ?";
$stmt = $conn->prepare($sql);
$stmt->bind_param("ii", $etat, $id); // "ii" pour Integer, Integer

if($stmt->execute()){
    echo json_encode(array("status" => "success"));
} else {
    echo json_encode(array("status" => "error"));
}
$conn->close();
?>