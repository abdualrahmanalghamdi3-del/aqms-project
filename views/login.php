<!DOCTYPE html>
<html>
<head>
    <title>Login</title>
    <link rel="stylesheet" href="public/css/style.css">
</head>
<body>
    <div class="auth-box">
        <h2>Welcome Back</h2>
        <?php if(isset($_GET['error'])) echo "<p class='error'>Invalid credentials!</p>"; ?>
        <form method="POST" action="index.php?action=login_process">
            <input type="text" name="username" placeholder="Username" required>
            <input type="password" name="password" placeholder="Password" required>
            <button type="submit">Login</button>
        </form>
    </div>
</body>
</html>