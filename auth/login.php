<?php
session_start();
require_once '../includes/db.php';

$email = $password = $error = '';
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $email = trim($_POST['email']);
    $password = $_POST['password'];
    if (!$email || !$password) {
        $error = 'All fields are required!';
    } else {
        $stmt = $conn->prepare('SELECT id, name, password FROM students WHERE email = ?');
        $stmt->bind_param('s', $email);
        $stmt->execute();
        $stmt->store_result();
        if ($stmt->num_rows === 1) {
            $stmt->bind_result($id, $name, $hash);
            $stmt->fetch();
            if (password_verify($password, $hash)) {
                $_SESSION['student_id'] = $id;
                $_SESSION['student_name'] = $name;
                header('Location: ../dashboard.php');
                exit();
            } else {
                $error = 'Incorrect password!';
            }
        } else {
            $error = 'No account found with that email!';
        }
        $stmt->close();
    }
}
?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Student Login</title>
    <link rel="stylesheet" href="../assets/style.css">
</head>
<body>
<div class="container">
    <h1>Student Login</h1>
    <?php if ($error): ?><p style="color:red; text-align:center;"> <?= $error ?> </p><?php endif; ?>
    <form method="post">
        <input type="email" name="email" placeholder="Email" value="<?= htmlspecialchars($email) ?>" required>
        <input type="password" name="password" placeholder="Password" required>
        <input type="submit" value="Login" class="button">
    </form>
    <p style="text-align:center;">Don't have an account? <a href="register.php">Register</a></p>
</div>
</body>
</html> 