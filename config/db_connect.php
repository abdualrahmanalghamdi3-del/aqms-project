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

    // TODO: Displaying a clean error message using a theme
    /*
    die('
    ');
    */
}
?>
