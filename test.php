<?php
session_start();
require_once 'includes/db.php';
if (!isset($_SESSION['student_id'])) {
    header('Location: auth/login.php');
    exit();
}
if (!isset($_GET['standard']) || !is_numeric($_GET['standard'])) {
    header('Location: dashboard.php');
    exit();
}
$standard = (int)$_GET['standard'];

// Fetch questions for this standard
$stmt = $conn->prepare('SELECT id, question, option_a, option_b, option_c, option_d FROM questions WHERE standard = ? ORDER BY RAND() LIMIT 15');
$stmt->bind_param('i', $standard);
$stmt->execute();
$result = $stmt->get_result();
$questions = $result->fetch_all(MYSQLI_ASSOC);
$stmt->close();

// Store questions in session for navigation
if (!isset($_SESSION['test']) || $_SESSION['test']['standard'] != $standard) {
    $_SESSION['test'] = [
        'standard' => $standard,
        'questions' => $questions,
        'answers' => [],
        'current' => 0
    ];
}
$test = &$_SESSION['test'];
$total = count($test['questions']);
$current = isset($_GET['q']) ? (int)$_GET['q'] : $test['current'];
if ($current < 0) $current = 0;
if ($current >= $total) $current = $total - 1;
$test['current'] = $current;

// Handle answer submission
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $answer = $_POST['answer'] ?? '';
    $test['answers'][$current] = $answer;
    if (isset($_POST['next'])) {
        $current++;
        if ($current < $total) {
            header('Location: test.php?standard=' . $standard . '&q=' . $current);
            exit();
        }
    } elseif (isset($_POST['submit'])) {
        header('Location: result.php');
        exit();
    }
}
$question = $test['questions'][$current];
$selected = $test['answers'][$current] ?? '';
?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Test - Standard <?= $standard ?></title>
    <link rel="stylesheet" href="assets/style.css">
</head>
<body>
<div class="container">
    <h2>Standard <?= $standard ?> Test</h2>
    <h3>Question <?= $current + 1 ?> of <?= $total ?></h3>
    <form method="post">
        <p style="font-size:1.2em; color:#333;"> <?= htmlspecialchars($question['question']) ?> </p>
        <label><input type="radio" name="answer" value="A" <?= $selected=='A'?'checked':'' ?>> <?= htmlspecialchars($question['option_a']) ?></label><br>
        <label><input type="radio" name="answer" value="B" <?= $selected=='B'?'checked':'' ?>> <?= htmlspecialchars($question['option_b']) ?></label><br>
        <label><input type="radio" name="answer" value="C" <?= $selected=='C'?'checked':'' ?>> <?= htmlspecialchars($question['option_c']) ?></label><br>
        <label><input type="radio" name="answer" value="D" <?= $selected=='D'?'checked':'' ?>> <?= htmlspecialchars($question['option_d']) ?></label><br><br>
        <?php if ($current < $total - 1): ?>
            <input type="submit" name="next" value="Next" class="button">
        <?php else: ?>
            <input type="submit" name="submit" value="Submit" class="button">
        <?php endif; ?>
    </form>
    <p style="text-align:center;"><a href="dashboard.php">Back to Dashboard</a></p>
</div>
</body>
</html> 