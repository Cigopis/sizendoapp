<?php
header("Content-Type: application/json");
$conn = new mysqli("localhost", "root", "arrosyid028", "sizendo");

$email = $_GET['email'];

$sql = "SELECT nama_member, paket, email FROM members WHERE email = ?";
$stmt = $conn->prepare($sql);
$stmt->bind_param("s", $email);
$stmt->execute();

$result = $stmt->get_result();
$data = $result->fetch_assoc();

echo json_encode($data);
?>
