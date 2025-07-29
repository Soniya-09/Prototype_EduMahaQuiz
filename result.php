<?php
session_start();
require_once 'includes/db.php';
if (!isset($_SESSION['student_id']) || !isset($_SESSION['test'])) {
    header('Location: dashboard.php');
    exit();
}
$student_id = $_SESSION['student_id'];
$test = $_SESSION['test'];
$standard = $test['standard'];
$questions = $test['questions'];
$answers = $test['answers'];
$total = count($questions);
$score = 0;

// Fetch correct answers for these questions
$ids = array_column($questions, 'id');
$id_list = implode(',', array_map('intval', $ids));
$sql = "SELECT id, correct_option FROM questions WHERE id IN ($id_list)";
$res = $conn->query($sql);
$correct = [];
while ($row = $res->fetch_assoc()) {
    $correct[$row['id']] = $row['correct_option'];
}

// Calculate score
for ($i = 0; $i < $total; $i++) {
    $qid = $questions[$i]['id'];
    if (isset($answers[$i]) && strtoupper($answers[$i]) === strtoupper($correct[$qid])) {
        $score++;
    }
}
$percentage = $total ? round(($score / $total) * 100, 2) : 0;
if ($percentage >= 80) {
    $remark = 'Excellent';
} elseif ($percentage >= 50) {
    $remark = 'Good';
} else {
    $remark = 'Try Again';
}

// Store result in DB
$stmt = $conn->prepare('INSERT INTO results (student_id, standard, score, percentage, remark) VALUES (?, ?, ?, ?, ?)');
$stmt->bind_param('iiids', $student_id, $standard, $score, $percentage, $remark);
if (!$stmt->execute()) {
    // If foreign key constraint fails, redirect to login
    if ($stmt->errno === 1452) {
        session_destroy();
        header('Location: auth/login.php');
        exit();
    }
}
$stmt->close();

// Clear test session
unset($_SESSION['test']);
?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Test Result</title>
    <link rel="stylesheet" href="assets/style.css">
</head>
<body>
<div class="container">
    <h2>Test Result - Standard <?= $standard ?></h2>
    <p style="font-size:1.3em; text-align:center;">Score: <b><?= $score ?> / <?= $total ?></b></p>
    <p style="font-size:1.2em; text-align:center;">Percentage: <b><?= $percentage ?>%</b></p>
    <p style="font-size:1.2em; text-align:center; color:#ff4e50;">Remark: <b><?= $remark ?></b></p>
    <p style="text-align:center;"><a href="dashboard.php" class="button">Back to Dashboard</a></p>
</div>
</body>
</html> 