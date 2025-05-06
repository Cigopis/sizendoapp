<?php
header('Access-Control-Allow-Origin: *');
header('Content-Type: application/json');

// Setting koneksi database
$servername = "localhost";
$username = "root"; // username default laragon
$password = "arrosyid028"; // password kosong di laragon
$dbname = "sizendo"; // nama database kamu

// Buat koneksi
$conn = new mysqli($servername, $username, $password, $dbname);

// Cek koneksi
if ($conn->connect_error) {
    die(json_encode(["success" => false, "message" => "Koneksi database gagal!"]));
}

// Ambil data dari Flutter (POST)
$email = $_POST['email'] ?? '';

// Cek apakah email ada di tabel members
$stmt = $conn->prepare("SELECT * FROM members WHERE email = ?");
$stmt->bind_param("s", $email);
$stmt->execute();
$result = $stmt->get_result();

// Jika ada data
if ($result->num_rows > 0) {
    $user = $result->fetch_assoc();
    echo json_encode([
        "success" => true,
        "message" => "Login berhasil",
        "data" => [
            "id" => $user['id'],
            "nama_member" => $user['nama_member'],
            "email" => $user['email'],
            "paket" => $user['paket'],
            "no_wa" => $user['no_wa'],
            "sosmed" => $user['sosmed'],
            "catatan" => $user['catatan']
        ]
    ]);
} else {
    echo json_encode(["success" => false, "message" => "Email tidak ditemukan"]);
}

// Tutup koneksi
$stmt->close();
$conn->close();
?>
