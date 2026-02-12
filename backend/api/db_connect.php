<?php
// db.php : Ce fichier sert à se connecter à la base
$host = "localhost";
$user = "root";      // Par défaut sur XAMPP
$pass = "";          // Par défaut vide sur XAMPP
$db   = "fouladh_db";

$conn = new mysqli($host, $user, $pass, $db);

if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}
// Si pas d'erreur, la connexion est prête !
?>