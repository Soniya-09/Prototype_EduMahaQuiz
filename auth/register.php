<?php
session_start();
require_once '../includes/db.php';

$name = $email = $password = $error = '';
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $name = trim($_POST['name']);
    $email = trim($_POST['email']);
    $password = $_POST['password'];
    if (!$name || !$email || !$password) {
        $error = 'All fields are required!';
    } elseif (!filter_var($email, FILTER_VALIDATE_EMAIL)) {
        $error = 'Invalid email address!';
    } else {
        $stmt = $conn->prepare('SELECT id FROM students WHERE email = ?');
        $stmt->bind_param('s', $email);
        $stmt->execute();
        $stmt->store_result();
        if ($stmt->num_rows > 0) {
            $error = 'Email already registered!';
        } else {
            $hash = password_hash($password, PASSWORD_DEFAULT);
            $stmt = $conn->prepare('INSERT INTO students (name, email, password) VALUES (?, ?, ?)');
            $stmt->bind_param('sss', $name, $email, $hash);
            if ($stmt->execute()) {
                $_SESSION['student_id'] = $stmt->insert_id;
                $_SESSION['student_name'] = $name;
                header('Location: ../dashboard.php');
                exit();
            } else {
                $error = 'Registration failed!';
            }
        }
        $stmt->close();
    }
}
?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Student Registration</title>
    <link rel="stylesheet" href="../assets/style.css">
</head>
<body>
<div class="container">
    <h1>Student Registration</h1>
    <?php if ($error): ?><p style="color:red; text-align:center;"> <?= $error ?> </p><?php endif; ?>
    <form method="post">
        <input type="text" name="name" placeholder="Full Name" value="<?= htmlspecialchars($name) ?>" required>
        <input type="email" name="email" placeholder="Email" value="<?= htmlspecialchars($email) ?>" required>
        <input type="password" name="password" placeholder="Password" required>
        <input type="submit" value="Register" class="button">
    </form>
    <p style="text-align:center;">Already have an account? <a href="login.php">Login</a></p>
</div>
</body>
</html> 