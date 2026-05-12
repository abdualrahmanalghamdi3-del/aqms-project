<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login | AQMS — Al Yamamah University</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=DM+Sans:wght@400;500;600;700;800&family=DM+Mono:wght@400;500&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="public/css/style.css">
</head>
<body class="login-body">

    <main class="login-page">
        <section class="login-card">

            <div class="login-logo">
                <img src="public/images/Al_Yamamah_University_logo.png" alt="Al Yamamah University">
            </div>

            <div class="login-header">
                <h2>Welcome Back</h2>
                <p>Sign in to the Academic Quality Management System</p>
            </div>

            <?php if (isset($_GET['error'])): ?>
            <div class="error-message">
                Invalid username or password. Please try again.
            </div>
            <?php endif; ?>

            <form method="POST" action="index.php?action=login_process" class="login-form">
                <div class="form-group">
                    <label for="username">Username</label>
                    <input type="text" id="username" name="username"
                           placeholder="Enter your username" required autocomplete="username">
                </div>
                <div class="form-group">
                    <label for="password">Password</label>
                    <input type="password" id="password" name="password"
                           placeholder="Enter your password" required autocomplete="current-password">
                </div>
                <button type="submit" class="login-btn">Sign In</button>
            </form>

        </section>
    </main>

</body>
</html>
