<?php
session_start();
if (!isset($_SESSION['student_id'])) {
    header('Location: auth/login.php');
    exit();
}
$name = $_SESSION['student_name'];
?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Dashboard</title>
    <link rel="stylesheet" href="assets/style.css">
</head>
<body>
<div class="container">
    <h1>Welcome, <?= htmlspecialchars($name) ?>!</h1>
    <h2>Select Your Standard</h2>
    <div class="standard-list">
        <?php for ($i = 1; $i <= 10; $i++): ?>
            <a href="test.php?standard=<?= $i ?>" class="standard-card">Standard <?= $i ?></a>
        <?php endfor; ?>
    </div>
    <p style="text-align:center;"><a href="auth/logout.php" class="button">Logout</a></p>
</div>
</body>
</html> 