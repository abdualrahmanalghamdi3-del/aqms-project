<?php
// index.php
require_once 'config/db_connect.php';
// 1. SESSION START: Must appear BEFORE any HTML or text.
// This function checks if a session ID exists; if not, it creates one.
session_start(); 

$action = $_GET['action'] ?? 'login';

// --- ADDED: REDIRECT LOGGED-IN USERS ---
// If the user is already logged in and tries to go to the login page, 
// redirect them straight to the dashboard.
if ($action === 'login' && isset($_SESSION['user_id'])) {
    header("Location: index.php?action=dashboard");
    exit();
}

switch ($action) {
    case 'login_process':
        $username = $_POST['username'] ?? '';
        $password = $_POST['password'] ?? '';
        
        $user = find_user($conn, $username);
        
        if ($user && $password === $user['password']) {
            // Store sensitive data on the server side[cite: 25, 180].
            $_SESSION['user_id'] = $user['user_id'];
            $_SESSION['username'] = $user['username'];
            $_SESSION['role'] = $user['role'];
            // Store non-sensitive name in a client-side cookie.
            // This provides persistence even after the browser closes.
            setcookie("visitor_name", $user['username'], time() + (3600 * 24 * 30), "/"); 

            header("Location: index.php?action=dashboard");
            exit();
        } else {
            header("Location: index.php?action=login&error=1");
            exit();
        }
        break;

    case 'dashboard':
    case 'profile':
        // SECURITY CHECK: If session is not set, redirect to login.
        if (!isset($_SESSION['user_id'])) { 
            header("Location: index.php?action=login"); 
            exit; 
        }
        include ($action === 'dashboard') ? 'views/dashboard.php' : 'views/profile.php';
        break;

    case 'logout':
        // Destroy all data registered to the session.
        session_unset();
        session_destroy();
        
        // To fully delete, set the cookie expiration to the past.
        setcookie("visitor_name", "", time() - 3600, "/");
        
        header("Location: index.php");
        exit();
        break;

    default:
        include 'views/login.php';
        break;
}