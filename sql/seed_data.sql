-- ============================================================
-- AQMS Seed Data — Al Yamamah University
-- Run AFTER aqms_db.sql to populate tables with demo data
-- ============================================================

USE aqms_db;

-- --------------------------------------------------------
-- USERS (plain-text passwords for Week 1 demo)
-- --------------------------------------------------------
INSERT INTO `users` (`username`, `password`, `role`) VALUES
('faculty1',  'password1', 'Faculty'),
('hod1',      'password1', 'HoD'),
('dean1',     'password1', 'Dean'),
('qa1',       'password1', 'QA');

-- --------------------------------------------------------
-- PROGRAM
-- --------------------------------------------------------
INSERT INTO `programs`
  (`program_name`, `program_code`, `qualification_level`, `department`, `college`,
   `institution`, `specification_status`, `last_review_date`,
   `main_location`, `total_credit_hours`, `mission`, `goals`)
VALUES
  ('Bachelor of Computer Science', 'BCS', 'NQF Level 6',
   'Computer Science & Information Systems', 'College of Engineering & Architecture',
   'Al Yamamah University', 'Updated', '2025-09-01',
   'Riyadh', 120,
   'To prepare graduates with strong theoretical and practical foundations in computing that meet the needs of the Saudi digital economy.',
   'Develop graduates capable of designing, implementing, and maintaining modern software systems aligned with Vision 2030.');

-- --------------------------------------------------------
-- PROGRAM LEARNING OUTCOMES (PLOs)
-- --------------------------------------------------------
INSERT INTO `program_learning_outcomes` (`program_id`, `plo_code`, `description`, `category`) VALUES
(1, 'PLO1', 'Demonstrate comprehensive knowledge of fundamental computing concepts, algorithms, and data structures.', 'Knowledge'),
(1, 'PLO2', 'Apply theoretical frameworks and software engineering methodologies to real-world problems.', 'Knowledge'),
(1, 'PLO3', 'Design, implement, and evaluate software solutions to complex computing problems.', 'Skills'),
(1, 'PLO4', 'Use modern development tools, frameworks, and technologies effectively in professional contexts.', 'Skills'),
(1, 'PLO5', 'Demonstrate professional ethics, integrity, and social responsibility in computing practice.', 'Values'),
(1, 'PLO6', 'Collaborate effectively in multidisciplinary teams, communicating technical ideas clearly.', 'Values');

-- --------------------------------------------------------
-- COURSES
-- --------------------------------------------------------
INSERT INTO `courses`
  (`program_id`, `course_title`, `course_code`, `department`, `college`, `institution`,
   `version`, `last_revision_date`, `credit_hours`,
   `course_type_source`, `course_type_requirement`, `offered_level_year`,
   `general_description`, `pre_requirements`, `main_objectives`)
VALUES
(1, 'Advanced Web Programming', 'CS401',
   'Computer Science & Information Systems', 'College of Engineering & Architecture',
   'Al Yamamah University', '2.0', '2025-09-01', 3,
   'Department', 'Required', 'Year 4 / Semester 1',
   'Covers advanced server-side web development including PHP, MySQL, session management, RESTful APIs, and NCAAA-aligned quality systems.',
   'CS301 – Web Programming', 'Enable students to build secure, data-driven web applications following industry best practices.'),

(1, 'Database Systems', 'CS302',
   'Computer Science & Information Systems', 'College of Engineering & Architecture',
   'Al Yamamah University', '3.1', '2025-02-10', 3,
   'Department', 'Required', 'Year 3 / Semester 1',
   'Covers relational database design, SQL, normalization, transactions, and an introduction to NoSQL systems.',
   'CS201 – Data Structures', 'Equip students to design and query robust relational database schemas.'),

(1, 'Software Engineering', 'CS303',
   'Computer Science & Information Systems', 'College of Engineering & Architecture',
   'Al Yamamah University', '2.2', '2024-09-01', 3,
   'Department', 'Required', 'Year 3 / Semester 2',
   'Covers software development life cycles, requirements engineering, UML modeling, testing strategies, and Agile methodologies.',
   'CS201 – Data Structures', 'Develop students ability to manage full software projects from requirements to deployment.');

-- --------------------------------------------------------
-- COURSE LEARNING OUTCOMES — CS401 Advanced Web Programming
-- --------------------------------------------------------
INSERT INTO `course_learning_outcomes` (`course_id`, `clo_code`, `description`, `category`, `teaching_strategies`, `assessment_methods`) VALUES
(1, 'CLO1', 'Explain advanced web architectures, MVC design patterns, and server-side rendering techniques.', 'Knowledge',
   'Lectures, case studies, code walkthroughs', 'Midterm Exam, Quizzes'),
(1, 'CLO2', 'Develop dynamic, data-driven web applications using PHP and MySQL with proper security practices.', 'Skills',
   'Lab sessions, pair programming, project work', 'Lab Assignments, Final Project'),
(1, 'CLO3', 'Implement secure user authentication, session management, and role-based access control.', 'Skills',
   'Hands-on labs, code review sessions', 'Lab Assignments, Final Project'),
(1, 'CLO4', 'Apply professional coding standards, version control, and documentation practices.', 'Values',
   'Team projects, peer code review', 'Project Deliverables, Peer Review'),
(1, 'CLO5', 'Design and consume RESTful APIs and integrate third-party services into web applications.', 'Skills',
   'Project-based learning, industry guest talks', 'Final Project, Presentation');

-- --------------------------------------------------------
-- COURSE LEARNING OUTCOMES — CS302 Database Systems
-- --------------------------------------------------------
INSERT INTO `course_learning_outcomes` (`course_id`, `clo_code`, `description`, `category`, `teaching_strategies`, `assessment_methods`) VALUES
(2, 'CLO1', 'Explain relational database concepts, ER modelling, and normalization principles up to 3NF.', 'Knowledge',
   'Lectures, diagram exercises', 'Midterm, Quizzes'),
(2, 'CLO2', 'Write complex SQL queries including joins, subqueries, aggregations, and stored procedures.', 'Skills',
   'Lab sessions, SQL challenges', 'Lab Assignments, Final Exam'),
(2, 'CLO3', 'Design and implement a normalized relational schema for a real-world application.', 'Skills',
   'Project-based learning', 'Database Project'),
(2, 'CLO4', 'Demonstrate awareness of data integrity, security, and ethical data handling responsibilities.', 'Values',
   'Case studies, discussion', 'Report, Quizzes');

-- --------------------------------------------------------
-- COURSE LEARNING OUTCOMES — CS303 Software Engineering
-- --------------------------------------------------------
INSERT INTO `course_learning_outcomes` (`course_id`, `clo_code`, `description`, `category`, `teaching_strategies`, `assessment_methods`) VALUES
(3, 'CLO1', 'Describe the major software development lifecycle models and their appropriate use contexts.', 'Knowledge',
   'Lectures, comparative analysis', 'Midterm, Quizzes'),
(3, 'CLO2', 'Produce software requirements specifications (SRS) and UML diagrams for a given problem.', 'Skills',
   'Workshop sessions, group modelling', 'Assignments, Project'),
(3, 'CLO3', 'Apply Agile/Scrum methodologies to manage iterative software delivery.', 'Skills',
   'Simulated sprints, retrospectives', 'Sprint Deliverables'),
(3, 'CLO4', 'Work collaboratively in software teams, demonstrating responsibility and professional conduct.', 'Values',
   'Team project, peer evaluation', 'Peer Review, Project');

-- --------------------------------------------------------
-- CLO–PLO MAPPINGS
-- --------------------------------------------------------
-- CS401 CLOs
INSERT INTO `clo_plo_mapping` (`clo_id`, `plo_id`, `performance_level`) VALUES
(1, 1, 'Practiced'),   -- CS401 CLO1 → PLO1
(1, 2, 'Introduced'),  -- CS401 CLO1 → PLO2
(2, 3, 'Mastered'),    -- CS401 CLO2 → PLO3
(2, 4, 'Mastered'),    -- CS401 CLO2 → PLO4
(3, 3, 'Mastered'),    -- CS401 CLO3 → PLO3
(3, 4, 'Practiced'),   -- CS401 CLO3 → PLO4
(4, 5, 'Practiced'),   -- CS401 CLO4 → PLO5
(4, 6, 'Practiced'),   -- CS401 CLO4 → PLO6
(5, 3, 'Practiced'),   -- CS401 CLO5 → PLO3
(5, 4, 'Mastered');    -- CS401 CLO5 → PLO4

-- CS302 CLOs
INSERT INTO `clo_plo_mapping` (`clo_id`, `plo_id`, `performance_level`) VALUES
(6, 1, 'Mastered'),    -- CS302 CLO1 → PLO1
(7, 3, 'Mastered'),    -- CS302 CLO2 → PLO3
(7, 4, 'Practiced'),   -- CS302 CLO2 → PLO4
(8, 3, 'Mastered'),    -- CS302 CLO3 → PLO3
(9, 5, 'Practiced');   -- CS302 CLO4 → PLO5

-- CS303 CLOs
INSERT INTO `clo_plo_mapping` (`clo_id`, `plo_id`, `performance_level`) VALUES
(10, 1, 'Practiced'),  -- CS303 CLO1 → PLO1
(10, 2, 'Practiced'),  -- CS303 CLO1 → PLO2
(11, 3, 'Practiced'),  -- CS303 CLO2 → PLO3
(12, 3, 'Mastered'),   -- CS303 CLO3 → PLO3
(12, 4, 'Practiced'),  -- CS303 CLO3 → PLO4
(13, 5, 'Mastered'),   -- CS303 CLO4 → PLO5
(13, 6, 'Mastered');   -- CS303 CLO4 → PLO6

-- --------------------------------------------------------
-- APPROVAL LOG (initial states)
-- --------------------------------------------------------
INSERT INTO `approval_log` (`course_id`, `user_id`, `status`, `timestamp`) VALUES
(1, 1, 'Draft',       '2026-04-01 10:00:00'),
(2, 1, 'Pending HoD', '2026-04-15 09:30:00'),
(3, 1, 'Approved',    '2026-03-20 14:00:00');

-- --------------------------------------------------------
-- ASSESSMENTS — CS401
-- --------------------------------------------------------
INSERT INTO `assessments` (`course_id`, `assessment_activity`, `assessment_timing`, `percentage_of_total`) VALUES
(1, 'Midterm Exam',     'Week 8',  25.00),
(1, 'Lab Assignments',  'Weekly',  20.00),
(1, 'Final Project',    'Week 15', 35.00),
(1, 'Final Exam',       'Week 16', 20.00);
