<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>AQMS — Al Yamamah University</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=DM+Sans:wght@400;500;600;700&family=DM+Mono:wght@400;500&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="public/css/style.css">
</head>
<body>

<div class="app-shell">

    <!-- ======== SIDEBAR ======== -->
    <aside class="sidebar">
        <div class="sidebar-brand">
            <img src="public/images/yamamah_logo.png" alt="Al Yamamah University" class="sidebar-logo">
            <div class="sidebar-brand-text">
                <span class="brand-title">AQMS</span>
                <span class="brand-sub">Quality Management</span>
            </div>
        </div>

        <div class="sidebar-user">
            <div class="user-avatar">
                <?php echo strtoupper(substr($_SESSION['username'] ?? 'U', 0, 1)); ?>
            </div>
            <div class="user-info">
                <span class="user-name"><?php echo htmlspecialchars($_SESSION['username'] ?? 'User'); ?></span>
                <span class="user-role role-badge role-<?php echo strtolower($_SESSION['role'] ?? 'faculty'); ?>">
                    <?php echo htmlspecialchars($_SESSION['role'] ?? 'Faculty'); ?>
                </span>
            </div>
        </div>

        <!-- 7-Step Progress Guide -->
        <nav class="step-nav">
            <p class="step-nav-label">7-Step Workflow</p>
            <ul class="step-list">
                <li class="step-item active" data-step="1">
                    <span class="step-num">1</span>
                    <span class="step-text">Review Specifications</span>
                    <span class="step-dot"></span>
                </li>
                <li class="step-item locked" data-step="2">
                    <span class="step-num">2</span>
                    <span class="step-text">Revise CLOs</span>
                </li>
                <li class="step-item locked" data-step="3">
                    <span class="step-num">3</span>
                    <span class="step-text">Map CLOs → PLOs</span>
                </li>
                <li class="step-item locked" data-step="4">
                    <span class="step-num">4</span>
                    <span class="step-text">Align Assessments</span>
                </li>
                <li class="step-item locked" data-step="5">
                    <span class="step-num">5</span>
                    <span class="step-text">Jahiziah Skills</span>
                </li>
                <li class="step-item locked" data-step="6">
                    <span class="step-num">6</span>
                    <span class="step-text">PDCA Tracking</span>
                </li>
                <li class="step-item locked" data-step="7">
                    <span class="step-num">7</span>
                    <span class="step-text">Approval Workflow</span>
                </li>
            </ul>
        </nav>

        <div class="sidebar-footer">
            <a href="index.php?action=profile" class="sidebar-link">
                <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><circle cx="12" cy="8" r="4"/><path d="M4 20c0-4 3.6-7 8-7s8 3 8 7"/></svg>
                Profile
            </a>
            <a href="index.php?action=logout" class="sidebar-link logout-link">
                <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M9 21H5a2 2 0 0 1-2-2V5a2 2 0 0 1 2-2h4"/><polyline points="16 17 21 12 16 7"/><line x1="21" y1="12" x2="9" y2="12"/></svg>
                Logout
            </a>
        </div>
    </aside>

    <!-- ======== MAIN CONTENT WRAPPER ======== -->
    <main class="main-content">
