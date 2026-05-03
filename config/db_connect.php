<?php
/*
 * File: db_connect.php
 * Description: Creates a connection to the AQMS MySQL database
 */

// Enable mysqli exceptions
mysqli_report(MYSQLI_REPORT_ERROR | MYSQLI_REPORT_STRICT);

try {
    // Database Configuration Variables
    $db_host = "localhost";
    $db_user = "root";
    $db_pass = ""; 
    $db_name = "aqms_db";

    // Create the database connection
    $conn = new mysqli($db_host, $db_user, $db_pass, $db_name);

    // Set the character set during database creation
    $conn->set_charset("utf8mb4");

} catch (mysqli_sql_exception $e) {
    // Log the actual error internally for debugging
    error_log("AQMS Database Connection Error: " . $e->getMessage());

     die('
        <link rel="stylesheet" href="public/css/style.css">
        <div class="error-container">
            <div class="error-box" style="background: white; padding: 2rem; border-radius: 8px; box-shadow: 0 4px 6px rgba(0,0,0,0.1); text-align: center; margin-top: 50px;">
                <h2>System Connection Issue</h2>
                <p>We are currently experiencing technical difficulties. Please try again later.</p>
            </div>
        </div>
    ');
}

/**
 * Finds a user by username using the mysqli connection.
 * This helper function allows our controller to access persistent data.
 */
function find_user($conn, $username) {
    $stmt = $conn->prepare("SELECT * FROM users WHERE username = ?");
    $stmt->bind_param("s", $username);
    $stmt->execute();
    $result = $stmt->get_result();
    return $result->fetch_assoc();
}
?>
