<?php

session_start();

require_once '../config/db_connect.php';

$error_message = '';

if ($_SERVER["REQUEST_METHOD"] == "POST") {
    $username = trim($_POST['username']);
    $password = trim($_POST['password']);

    if (empty($username) || empty($password)) {
        $error_message = "Please enter both username and password.";
    } else {
        $stmt = $pdo->prepare("SELECT user_id, username, password, role FROM Users WHERE username = :username");
        $stmt->bindParam(':username', $username);
        $stmt->execute();
        
        $user_record = $stmt->fetch(PDO::FETCH_ASSOC);

        if ($user_record && password_verify($password, $user_record['password'])) {
            session_regenerate_id(true);
            
            $_SESSION['logged_in'] = true;
            $_SESSION['user_id']   = $user_record['user_id'];
            $_SESSION['username']  = $user_record['username'];
            $_SESSION['role']      = $user_record['role'];

            switch ($user_record['role']) {
                case 'Faculty':
                    header("Location: /dashboard_faculty.php");
                    break;
                case 'HoD':
                    header("Location: /dashboard_hod.php");
                    break;
                case 'QA':
                    header("Location: /dashboard_qa.php");
                    break;
            }
            exit();
        } else {
            $error_message = "Invalid credentials. Please try again.";
        }
    }
}

require_once '../views/login_view.php';
?>
