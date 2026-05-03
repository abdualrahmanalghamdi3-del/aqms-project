<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login | Al Yamamah University</title>

    <link rel="stylesheet" href="../public/css/style.css">
</head>
<body>

    <main class="login-page">
        <section class="login-card">

            <div class="login-logo">
                <img src="../public/images/public/images/Al_Yamamah_University_logo.png" alt="Al Yamamah University Logo">
            </div>

            <div class="login-header">
                <h2>Welcome Back</h2>
                <p>Login to access your account</p>
            </div>

            <?php if (isset($_GET['error'])) : ?>
                <p class="error-message">Invalid username or password.</p>
            <?php endif; ?>

            <form method="POST" action="../index.php?action=login_process" class="login-form">

                <div class="form-group">
                    <label for="username">Username</label>
                    <input
                        type="text"
                        id="username"
                        name="username"
                        placeholder="Enter your username"
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

                <button type="submit" class="login-btn">Login</button>

            </form>

        </section>
    </main>

</body>
</html>
