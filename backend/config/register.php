<?php
// register.php
header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json; charset=UTF-8");

include 'db.php';

$matricule = $_POST['matricule'];
$password  = $_POST['password'];

// 1. Vérification des champs vides
if(empty($matricule) || empty($password)){
    echo json_encode(array("status" => "error", "message" => "Champs vides"));
    exit();
}

// 2. Vérifier si le matricule existe DÉJÀ
$checkSQL = "SELECT id_user FROM utilisateur WHERE matricule = ?";
$stmt = $conn->prepare($checkSQL);
$stmt->bind_param("s", $matricule);
$stmt->execute();
$stmt->store_result();

if ($stmt->num_rows > 0) {
    // Le matricule existe déjà
    echo json_encode(array("status" => "error", "message" => "Ce matricule est déjà inscrit"));
} else {
    // 3. Insérer le nouvel utilisateur
    // Par défaut, on lui donne le rôle 'Superviseur'
    $insertSQL = "INSERT INTO utilisateur (matricule, password, role) VALUES (?, ?, 'Superviseur')";
    $stmt2 = $conn->prepare($insertSQL);
    $stmt2->bind_param("ss", $matricule, $password);
    
    if($stmt2->execute()){
        echo json_encode(array("status" => "success", "message" => "Compte créé avec succès"));
    } else {
        echo json_encode(array("status" => "error", "message" => "Erreur lors de l'inscription"));
    }
}

$conn->close();
?>