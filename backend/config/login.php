<?php
// login.php
header("Access-Control-Allow-Origin: *"); // Autoriser l'accès depuis l'appli
header("Content-Type: application/json; charset=UTF-8");

include 'db.php'; // On inclut la connexion créée à l'étape précédente

// 1. Récupérer les données envoyées par Flutter
$matricule = $_POST['matricule'];
$password  = $_POST['password'];

// 2. Vérifier si les champs sont remplis
if(empty($matricule) || empty($password)){
    echo json_encode(array("status" => "error", "message" => "Champs vides"));
    exit();
}

// 3. La requête SQL sécurisée (Préparée pour éviter les piratages SQL Injection)
$sql = "SELECT * FROM utilisateur WHERE matricule = ? AND password = ?";
$stmt = $conn->prepare($sql);
$stmt->bind_param("ss", $matricule, $password); // "ss" veut dire String, String
$stmt->execute();
$result = $stmt->get_result();

// 4. Vérifier le résultat
if ($result->num_rows > 0) {
    // Trouvé ! On récupère les infos de l'utilisateur
    $row = $result->fetch_assoc();
    echo json_encode(array(
        "status" => "success",
        "user_id" => $row['id_user'],
        "role" => $row['role']
    ));
} else {
    // Pas trouvé
    echo json_encode(array("status" => "error", "message" => "Matricule ou mot de passe incorrect"));
}

$conn->close();
?>