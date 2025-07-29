<?php
// Database connection for XAMPP (default credentials)
$host = 'localhost';
$user = 'root';
$pass = '';
$db = 'e_learning';

$conn = new mysqli($host, $user, $pass, $db);

if ($conn->connect_error) {
    die('Database connection failed: ' . $conn->connect_error);
}
?> 