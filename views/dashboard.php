<?php 
// views/dashboard.php
include 'views/header.php'; 
?>

<div class="container">
    <h1>Dashboard</h1>
    <p>Welcome back, <strong><?php echo $_SESSION['username']; ?></strong>!</p>
    <p><em>(Status: Verified via Server-Side Session)</em></p>
    
    <hr>

    <div class="cookie-demo">
        <h3>Cookie Information</h3>
        <p>Persistent name stored in your browser: 
           <strong><?php echo $_COOKIE['visitor_name'] ?? 'Not found'; ?></strong>
        </p>
        <p><small>This cookie will last for 30 days.</small></p>
    </div>

    <nav style="margin-top: 20px;">
        <a href="index.php?action=profile" class="btn">View Profile Page</a> | 
        <a href="index.php?action=logout" style="color: red;">Logout</a>
    </nav>
</div>

</body>
</html>