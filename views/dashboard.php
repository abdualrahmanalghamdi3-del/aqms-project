<?php
// views/dashboard.php
// Included by index.php — $conn and $_SESSION are already available.

// ── Query: Summary Stats ──────────────────────────────────────────
$stat_courses = $conn->query("SELECT COUNT(*) AS n FROM courses")->fetch_assoc()['n'];
$stat_clos    = $conn->query("SELECT COUNT(*) AS n FROM course_learning_outcomes")->fetch_assoc()['n'];
$stat_plos    = $conn->query("SELECT COUNT(*) AS n FROM program_learning_outcomes")->fetch_assoc()['n'];
$stat_pending = $conn->query(
    "SELECT COUNT(DISTINCT course_id) AS n FROM approval_log
     WHERE status IN ('Pending HoD','Pending QA')"
)->fetch_assoc()['n'];
$stat_mapped  = $conn->query("SELECT COUNT(DISTINCT clo_id) AS n FROM clo_plo_mapping")->fetch_assoc()['n'];
$stat_approved = $conn->query(
    "SELECT COUNT(DISTINCT course_id) AS n FROM approval_log WHERE status = 'Approved'"
)->fetch_assoc()['n'];

// ── Query: Courses with aggregated data ──────────────────────────
$courses_sql = "
    SELECT
        c.course_id,
        c.course_code,
        c.course_title,
        c.credit_hours,
        c.offered_level_year,
        p.program_name,
        p.qualification_level,
        COUNT(DISTINCT clo.clo_id)                                              AS clo_count,
        SUM(clo.category = 'Knowledge')                                         AS clo_knowledge,
        SUM(clo.category = 'Skills')                                            AS clo_skills,
        SUM(clo.category = 'Values')                                            AS clo_values,
        COUNT(DISTINCT plo.plo_id)                                              AS plo_count,
        COUNT(DISTINCT map.mapping_id)                                          AS mapping_count,
        (SELECT status FROM approval_log
         WHERE course_id = c.course_id
         ORDER BY timestamp DESC LIMIT 1)                                       AS approval_status,
        (SELECT timestamp FROM approval_log
         WHERE course_id = c.course_id
         ORDER BY timestamp DESC LIMIT 1)                                       AS approval_date
    FROM courses c
    LEFT JOIN programs p               ON c.program_id   = p.program_id
    LEFT JOIN course_learning_outcomes clo ON c.course_id = clo.course_id
    LEFT JOIN program_learning_outcomes plo ON p.program_id = plo.program_id
    LEFT JOIN clo_plo_mapping map      ON clo.clo_id     = map.clo_id
    GROUP BY c.course_id
    ORDER BY c.course_id ASC
";
$courses_result = $conn->query($courses_sql);
$courses = [];
while ($row = $courses_result->fetch_assoc()) {
    $courses[] = $row;
}

// ── Query: PLO category breakdown ────────────────────────────────
$plo_breakdown = [];
$plo_res = $conn->query(
    "SELECT category, COUNT(*) AS n FROM program_learning_outcomes GROUP BY category"
);
while ($r = $plo_res->fetch_assoc()) {
    $plo_breakdown[$r['category']] = (int)$r['n'];
}

// ── Helper: status badge ──────────────────────────────────────────
function status_badge($status) {
    if (!$status) $status = 'Draft';
    $map = [
        'Draft'       => ['label' => 'Draft',       'class' => 'badge-draft'],
        'Pending HoD' => ['label' => 'Pending HoD', 'class' => 'badge-pending'],
        'Pending QA'  => ['label' => 'Pending QA',  'class' => 'badge-pending'],
        'Approved'    => ['label' => 'Approved',     'class' => 'badge-approved'],
    ];
    $b = $map[$status] ?? ['label' => $status, 'class' => 'badge-draft'];
    return "<span class=\"badge {$b['class']}\">{$b['label']}</span>";
}

// ── Helper: mapping health ────────────────────────────────────────
function mapping_health($clo_count, $mapping_count) {
    if ($clo_count == 0) return ['pct' => 0, 'class' => 'health-none', 'label' => 'No CLOs'];
    $pct = ($mapping_count > 0) ? min(100, round(($mapping_count / $clo_count) * 100)) : 0;
    if ($pct == 0)  return ['pct' => 0,   'class' => 'health-none',    'label' => 'Unmapped'];
    if ($pct < 60)  return ['pct' => $pct, 'class' => 'health-low',    'label' => "{$pct}% mapped"];
    if ($pct < 100) return ['pct' => $pct, 'class' => 'health-partial','label' => "{$pct}% mapped"];
    return ['pct' => 100, 'class' => 'health-full', 'label' => 'Fully mapped'];
}

include 'views/header.php';
?>

<!-- ====== TOP BAR ====== -->
<div class="topbar">
    <div class="topbar-left">
        <h1 class="page-title">Step 1 — Review Specifications</h1>
        <p class="page-sub">View current CLOs, PLOs, and NQF compliance status</p>
    </div>
    <div class="topbar-right">
        <span class="nqf-chip">NQF Level 6</span>
        <span class="nqf-chip nqf-chip-alt">Jahiziah 2026</span>
    </div>
</div>

<!-- ====== STATS GRID ====== -->
<section class="stats-grid">
    <div class="stat-card">
        <div class="stat-icon stat-icon-courses">
            <svg width="22" height="22" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><rect x="2" y="3" width="20" height="14" rx="2"/><path d="M8 21h8M12 17v4"/></svg>
        </div>
        <div class="stat-body">
            <span class="stat-num"><?php echo $stat_courses; ?></span>
            <span class="stat-label">Courses</span>
        </div>
    </div>
    <div class="stat-card">
        <div class="stat-icon stat-icon-clo">
            <svg width="22" height="22" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M9 11l3 3L22 4"/><path d="M21 12v7a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2V5a2 2 0 0 1 2-2h11"/></svg>
        </div>
        <div class="stat-body">
            <span class="stat-num"><?php echo $stat_clos; ?></span>
            <span class="stat-label">CLOs</span>
        </div>
    </div>
    <div class="stat-card">
        <div class="stat-icon stat-icon-plo">
            <svg width="22" height="22" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><circle cx="12" cy="12" r="10"/><path d="M12 8v4l3 3"/></svg>
        </div>
        <div class="stat-body">
            <span class="stat-num"><?php echo $stat_plos; ?></span>
            <span class="stat-label">PLOs</span>
        </div>
    </div>
    <div class="stat-card">
        <div class="stat-icon stat-icon-mapped">
            <svg width="22" height="22" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><line x1="6" y1="3" x2="6" y2="15"/><circle cx="18" cy="6" r="3"/><circle cx="6" cy="18" r="3"/><path d="M18 9a9 9 0 0 1-9 9"/></svg>
        </div>
        <div class="stat-body">
            <span class="stat-num"><?php echo $stat_mapped; ?></span>
            <span class="stat-label">CLOs Mapped</span>
        </div>
    </div>
    <div class="stat-card">
        <div class="stat-icon stat-icon-pending">
            <svg width="22" height="22" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><circle cx="12" cy="12" r="10"/><polyline points="12 6 12 12 16 14"/></svg>
        </div>
        <div class="stat-body">
            <span class="stat-num"><?php echo $stat_pending; ?></span>
            <span class="stat-label">Pending Review</span>
        </div>
    </div>
    <div class="stat-card">
        <div class="stat-icon stat-icon-approved">
            <svg width="22" height="22" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M22 11.08V12a10 10 0 1 1-5.93-9.14"/><polyline points="22 4 12 14.01 9 11.01"/></svg>
        </div>
        <div class="stat-body">
            <span class="stat-num"><?php echo $stat_approved; ?></span>
            <span class="stat-label">Approved</span>
        </div>
    </div>
</section>

<!-- ====== PLO BREAKDOWN BAR ====== -->
<?php if (!empty($plo_breakdown)): ?>
<section class="plo-bar-section">
    <h2 class="section-title">Program Learning Outcomes — Category Breakdown</h2>
    <div class="plo-breakdown-bar">
        <?php
        $total_plos = array_sum($plo_breakdown);
        $categories = ['Knowledge' => '#f97316', 'Skills' => '#3b82f6', 'Values' => '#22c55e'];
        foreach ($categories as $cat => $color):
            $count = $plo_breakdown[$cat] ?? 0;
            $pct   = $total_plos > 0 ? round(($count / $total_plos) * 100) : 0;
        ?>
        <div class="plo-bar-segment" style="width:<?php echo $pct; ?>%; background:<?php echo $color; ?>;"
             title="<?php echo $cat; ?>: <?php echo $count; ?> PLOs (<?php echo $pct; ?>%)">
        </div>
        <?php endforeach; ?>
    </div>
    <div class="plo-legend">
        <?php foreach ($categories as $cat => $color): ?>
        <span class="legend-item">
            <span class="legend-dot" style="background:<?php echo $color; ?>;"></span>
            <?php echo $cat; ?> (<?php echo $plo_breakdown[$cat] ?? 0; ?>)
        </span>
        <?php endforeach; ?>
    </div>
</section>
<?php endif; ?>

<!-- ====== COURSES TABLE ====== -->
<section class="courses-section">
    <div class="section-header">
        <h2 class="section-title">Course Specifications</h2>
        <span class="course-count"><?php echo count($courses); ?> course<?php echo count($courses) !== 1 ? 's' : ''; ?></span>
    </div>

    <?php if (empty($courses)): ?>
    <div class="empty-state">
        <svg width="48" height="48" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.5"><rect x="2" y="3" width="20" height="14" rx="2"/><path d="M8 21h8M12 17v4"/></svg>
        <p>No courses found.</p>
        <small>Import the seed_data.sql file to populate demo data.</small>
    </div>
    <?php else: ?>

    <div class="table-wrap">
        <table class="courses-table">
            <thead>
                <tr>
                    <th>Course</th>
                    <th>NQF / Program</th>
                    <th>CLOs</th>
                    <th>PLOs</th>
                    <th>Mapping</th>
                    <th>Status</th>
                    <th>Last Updated</th>
                    <th></th>
                </tr>
            </thead>
            <tbody>
            <?php foreach ($courses as $c):
                $health = mapping_health((int)$c['clo_count'], (int)$c['mapping_count']);
                $date_fmt = $c['approval_date']
                    ? date('d M Y', strtotime($c['approval_date']))
                    : '—';
            ?>
                <tr class="course-row">
                    <td>
                        <div class="course-title-cell">
                            <span class="course-code-tag"><?php echo htmlspecialchars($c['course_code']); ?></span>
                            <span class="course-title-text"><?php echo htmlspecialchars($c['course_title']); ?></span>
                            <?php if ($c['credit_hours']): ?>
                            <span class="credit-chip"><?php echo $c['credit_hours']; ?> cr</span>
                            <?php endif; ?>
                        </div>
                    </td>
                    <td>
                        <div class="nqf-cell">
                            <span class="nqf-level-tag"><?php echo htmlspecialchars($c['qualification_level'] ?? 'NQF 6'); ?></span>
                            <span class="program-name-small"><?php echo htmlspecialchars($c['program_name'] ?? '—'); ?></span>
                        </div>
                    </td>
                    <td>
                        <div class="clo-breakdown-cell">
                            <span class="clo-total"><?php echo $c['clo_count']; ?></span>
                            <div class="clo-mini-bars">
                                <?php if ($c['clo_knowledge']): ?><span class="mini-bar mini-k" title="Knowledge: <?php echo $c['clo_knowledge']; ?>">K<?php echo $c['clo_knowledge']; ?></span><?php endif; ?>
                                <?php if ($c['clo_skills']):   ?><span class="mini-bar mini-s" title="Skills: <?php echo $c['clo_skills']; ?>">S<?php echo $c['clo_skills']; ?></span><?php endif; ?>
                                <?php if ($c['clo_values']):   ?><span class="mini-bar mini-v" title="Values: <?php echo $c['clo_values']; ?>">V<?php echo $c['clo_values']; ?></span><?php endif; ?>
                            </div>
                        </div>
                    </td>
                    <td class="center"><?php echo $c['plo_count']; ?></td>
                    <td>
                        <div class="health-cell">
                            <div class="health-bar-bg">
                                <div class="health-bar-fill <?php echo $health['class']; ?>"
                                     style="width:<?php echo $health['pct']; ?>%"></div>
                            </div>
                            <span class="health-label"><?php echo $health['label']; ?></span>
                        </div>
                    </td>
                    <td><?php echo status_badge($c['approval_status']); ?></td>
                    <td class="center date-cell"><?php echo $date_fmt; ?></td>
                    <td>
                        <div class="action-btns">
                            <a href="index.php?action=view_course&id=<?php echo $c['course_id']; ?>"
                               class="btn-action btn-view" title="View details">
                                <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M1 12s4-8 11-8 11 8 11 8-4 8-11 8-11-8-11-8z"/><circle cx="12" cy="12" r="3"/></svg>
                            </a>
                            <?php if (in_array($_SESSION['role'], ['Faculty', 'HoD'])): ?>
                            <a href="index.php?action=edit_course&id=<?php echo $c['course_id']; ?>"
                               class="btn-action btn-edit" title="Edit">
                                <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M11 4H4a2 2 0 0 0-2 2v14a2 2 0 0 0 2 2h14a2 2 0 0 0 2-2v-7"/><path d="M18.5 2.5a2.121 2.121 0 0 1 3 3L12 15l-4 1 1-4 9.5-9.5z"/></svg>
                            </a>
                            <?php endif; ?>
                        </div>
                    </td>
                </tr>
            <?php endforeach; ?>
            </tbody>
        </table>
    </div>
    <?php endif; ?>
</section>

<!-- ====== NOTICE ====== -->
<div class="week2-notice">
    <div class="notice-icon">
        <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><circle cx="12" cy="12" r="10"/><line x1="12" y1="8" x2="12" y2="12"/><line x1="12" y1="16" x2="12.01" y2="16"/></svg>
    </div>
    <p><strong>Week 2 — Step 2 & 3</strong> coming next: CLO revision forms and the CLO → PLO mapping grid will be added to the workflow.</p>
</div>

    </main><!-- .main-content -->
</div><!-- .app-shell -->

</body>
</html>
