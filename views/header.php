<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>PHP Session and Cookie Demo</title>
    <link rel="stylesheet" href="public/css/style.css">
</head>
<body>
    <header>
        <div class="nav-container">
            <?php if (isset($_SESSION['user_id'])): ?>
                <span>Logged in as: <strong><?php echo htmlspecialchars($_SESSION['username']); ?></strong></span>
            <?php else: ?>
                <span>Please log in to continue.</span>
            <?php endif; ?>
        </div>
    </header>