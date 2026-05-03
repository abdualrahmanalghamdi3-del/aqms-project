<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login</title>

    <!-- Correct path from views/login_view.php to public/css/style.css -->
    <link rel="stylesheet" href="../public/css/style.css">
</head>
<body>

    <main class="login-page">
        <section class="login-card">

            <div class="login-header">
                <h1>Welcome Back</h1>
                <p>Please login to continue to your account</p>
            </div>

            <?php if (!empty($error)) : ?>
                <div class="error-message">
                    <?= htmlspecialchars($error) ?>
                </div>
            <?php endif; ?>

            <form action="" method="POST" class="login-form">

                <div class="form-group">
                    <label for="email">Email Address</label>
                    <input
                        type="email"
                        id="email"
                        name="email"
                        placeholder="Enter your email"
                        required
                    >
                </div>

                <div class="form-group">
                    <label for="password">Password</label>
                    <input
                        type="password"
                        id="password"
                        name="password"
                        placeholder="Enter your password"
                        required
                    >
                </div>

                <div class="form-options">
                    <label class="remember-me">
                        <input type="checkbox" name="remember">
                        <span>Remember me</span>
                    </label>

                    <a href="#" class="forgot-link">Forgot password?</a>
                </div>

                <button type="submit" class="login-btn">
                    Login
                </button>

            </form>

            <p class="signup-text">
                Don't have an account?
                <a href="register.php">Create one</a>
            </p>

        </section>
    </main>

</body>
</html>