<?php 
// views/profile.php
include 'views/header.php'; 
?>

<div class="container">
    <h2>User Profile</h2>
    <p>This is a separate page to demonstrate <strong>Persistence</strong></p>
    
    <div class="persistence-check" style="text-align: left; background: #eee; padding: 10px; border-radius: 5px;">
        <p><strong>Session Check:</strong> Still logged in as <?php echo $_SESSION['username']; ?></p>
        
        <p><strong>Cookie Check:</strong> Browser still holds "<?php echo $_COOKIE['visitor_name']; ?>"</p>
    </div>

    <p style="margin-top: 20px;">
        <a href="index.php?action=dashboard">← Return to Dashboard</a>
    </p>
</div>

</body>
</html>