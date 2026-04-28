<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>AQMS Login</title>
    <link rel="stylesheet" href="/css/index.css"> 
</head>
<body>
    <h2>AQMS System Login</h2>
    
    <?php if(!empty($error_message)): ?>
        <p style="color:red;"><?php echo htmlspecialchars($error_message); ?></p>
    <?php endif; ?>

    <form action="" method="POST">
        <div>
            <label for="username">Username:</label>
            <input type="text" id="username" name="username" required>
        </div>
        <br>
        <div>
            <label for="password">Password:</label>
            <input type="password" id="password" name="password" required>
        </div>
        <br>
        <button type="submit">Login</button>
    </form>
</body>
</html>
