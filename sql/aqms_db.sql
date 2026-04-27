-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Apr 27, 2026 at 04:17 PM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `aqms_db`
--

-- --------------------------------------------------------

--
-- Table structure for table `approval_log`
--

CREATE TABLE `approval_log` (
  `log_id` int(11) NOT NULL,
  `course_id` int(11) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `status` enum('Draft','Pending HoD','Pending QA','Approved') DEFAULT 'Draft',
  `timestamp` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `assessments`
--

CREATE TABLE `assessments` (
  `assessment_id` int(11) NOT NULL,
  `course_id` int(11) DEFAULT NULL,
  `type` varchar(100) DEFAULT NULL COMMENT 'e.g., Final Exam, Midterm, Project',
  `weight` decimal(5,2) DEFAULT NULL,
  `timing` varchar(50) DEFAULT NULL COMMENT 'e.g., Week 10',
  `proportion_of_total` decimal(5,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `assessment_clo_alignment`
--

CREATE TABLE `assessment_clo_alignment` (
  `alignment_id` int(11) NOT NULL,
  `assessment_id` int(11) DEFAULT NULL,
  `clo_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `clo_plo_mapping`
--

CREATE TABLE `clo_plo_mapping` (
  `mapping_id` int(11) NOT NULL,
  `clo_id` int(11) DEFAULT NULL,
  `plo_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `courses`
--

CREATE TABLE `courses` (
  `course_id` int(11) NOT NULL,
  `program_id` int(11) DEFAULT NULL,
  `course_code` varchar(20) NOT NULL,
  `title` varchar(255) NOT NULL,
  `level` int(11) DEFAULT NULL COMMENT 'e.g., NQF Level 6',
  `prerequisites` varchar(255) DEFAULT NULL,
  `delivery_mode` varchar(50) DEFAULT NULL COMMENT 'e.g., Traditional, Blended',
  `learning_resources` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `course_learning_outcomes`
--

CREATE TABLE `course_learning_outcomes` (
  `clo_id` int(11) NOT NULL,
  `course_id` int(11) DEFAULT NULL,
  `clo_code` varchar(20) NOT NULL,
  `description` text NOT NULL,
  `category` enum('Knowledge','Skills','Values') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `jahiziah_skills`
--

CREATE TABLE `jahiziah_skills` (
  `skill_id` int(11) NOT NULL,
  `course_id` int(11) DEFAULT NULL,
  `skill_type` enum('Digital','Communication','Teamwork','Ethics') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `programs`
--

CREATE TABLE `programs` (
  `program_id` int(11) NOT NULL,
  `program_name` varchar(255) NOT NULL,
  `program_aims` text DEFAULT NULL,
  `program_structure` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `program_learning_outcomes`
--

CREATE TABLE `program_learning_outcomes` (
  `plo_id` int(11) NOT NULL,
  `program_id` int(11) DEFAULT NULL,
  `plo_code` varchar(20) NOT NULL,
  `description` text NOT NULL,
  `category` enum('Knowledge','Skills','Values') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `quality_improvements`
--

CREATE TABLE `quality_improvements` (
  `improvement_id` int(11) NOT NULL,
  `course_id` int(11) DEFAULT NULL,
  `cycle_stage` enum('Plan','Do','Check','Act') NOT NULL,
  `description` text DEFAULT NULL,
  `date` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `user_id` int(11) NOT NULL,
  `username` varchar(100) NOT NULL,
  `password` varchar(255) NOT NULL,
  `role` enum('Faculty','HoD','QA') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `approval_log`
--
ALTER TABLE `approval_log`
  ADD PRIMARY KEY (`log_id`),
  ADD KEY `course_id` (`course_id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `assessments`
--
ALTER TABLE `assessments`
  ADD PRIMARY KEY (`assessment_id`),
  ADD KEY `course_id` (`course_id`);

--
-- Indexes for table `assessment_clo_alignment`
--
ALTER TABLE `assessment_clo_alignment`
  ADD PRIMARY KEY (`alignment_id`),
  ADD KEY `assessment_id` (`assessment_id`),
  ADD KEY `clo_id` (`clo_id`);

--
-- Indexes for table `clo_plo_mapping`
--
ALTER TABLE `clo_plo_mapping`
  ADD PRIMARY KEY (`mapping_id`),
  ADD KEY `clo_id` (`clo_id`),
  ADD KEY `plo_id` (`plo_id`);

--
-- Indexes for table `courses`
--
ALTER TABLE `courses`
  ADD PRIMARY KEY (`course_id`),
  ADD KEY `program_id` (`program_id`);

--
-- Indexes for table `course_learning_outcomes`
--
ALTER TABLE `course_learning_outcomes`
  ADD PRIMARY KEY (`clo_id`),
  ADD KEY `course_id` (`course_id`);

--
-- Indexes for table `jahiziah_skills`
--
ALTER TABLE `jahiziah_skills`
  ADD PRIMARY KEY (`skill_id`),
  ADD KEY `course_id` (`course_id`);

--
-- Indexes for table `programs`
--
ALTER TABLE `programs`
  ADD PRIMARY KEY (`program_id`);

--
-- Indexes for table `program_learning_outcomes`
--
ALTER TABLE `program_learning_outcomes`
  ADD PRIMARY KEY (`plo_id`),
  ADD KEY `program_id` (`program_id`);

--
-- Indexes for table `quality_improvements`
--
ALTER TABLE `quality_improvements`
  ADD PRIMARY KEY (`improvement_id`),
  ADD KEY `course_id` (`course_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`user_id`),
  ADD UNIQUE KEY `username` (`username`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `approval_log`
--
ALTER TABLE `approval_log`
  MODIFY `log_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `assessments`
--
ALTER TABLE `assessments`
  MODIFY `assessment_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `assessment_clo_alignment`
--
ALTER TABLE `assessment_clo_alignment`
  MODIFY `alignment_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `clo_plo_mapping`
--
ALTER TABLE `clo_plo_mapping`
  MODIFY `mapping_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `courses`
--
ALTER TABLE `courses`
  MODIFY `course_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `course_learning_outcomes`
--
ALTER TABLE `course_learning_outcomes`
  MODIFY `clo_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `jahiziah_skills`
--
ALTER TABLE `jahiziah_skills`
  MODIFY `skill_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `programs`
--
ALTER TABLE `programs`
  MODIFY `program_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `program_learning_outcomes`
--
ALTER TABLE `program_learning_outcomes`
  MODIFY `plo_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `quality_improvements`
--
ALTER TABLE `quality_improvements`
  MODIFY `improvement_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `user_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `approval_log`
--
ALTER TABLE `approval_log`
  ADD CONSTRAINT `approval_log_ibfk_1` FOREIGN KEY (`course_id`) REFERENCES `courses` (`course_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `approval_log_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE SET NULL;

--
-- Constraints for table `assessments`
--
ALTER TABLE `assessments`
  ADD CONSTRAINT `assessments_ibfk_1` FOREIGN KEY (`course_id`) REFERENCES `courses` (`course_id`) ON DELETE CASCADE;

--
-- Constraints for table `assessment_clo_alignment`
--
ALTER TABLE `assessment_clo_alignment`
  ADD CONSTRAINT `assessment_clo_alignment_ibfk_1` FOREIGN KEY (`assessment_id`) REFERENCES `assessments` (`assessment_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `assessment_clo_alignment_ibfk_2` FOREIGN KEY (`clo_id`) REFERENCES `course_learning_outcomes` (`clo_id`) ON DELETE CASCADE;

--
-- Constraints for table `clo_plo_mapping`
--
ALTER TABLE `clo_plo_mapping`
  ADD CONSTRAINT `clo_plo_mapping_ibfk_1` FOREIGN KEY (`clo_id`) REFERENCES `course_learning_outcomes` (`clo_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `clo_plo_mapping_ibfk_2` FOREIGN KEY (`plo_id`) REFERENCES `program_learning_outcomes` (`plo_id`) ON DELETE CASCADE;

--
-- Constraints for table `courses`
--
ALTER TABLE `courses`
  ADD CONSTRAINT `courses_ibfk_1` FOREIGN KEY (`program_id`) REFERENCES `programs` (`program_id`) ON DELETE SET NULL;

--
-- Constraints for table `course_learning_outcomes`
--
ALTER TABLE `course_learning_outcomes`
  ADD CONSTRAINT `course_learning_outcomes_ibfk_1` FOREIGN KEY (`course_id`) REFERENCES `courses` (`course_id`) ON DELETE CASCADE;

--
-- Constraints for table `jahiziah_skills`
--
ALTER TABLE `jahiziah_skills`
  ADD CONSTRAINT `jahiziah_skills_ibfk_1` FOREIGN KEY (`course_id`) REFERENCES `courses` (`course_id`) ON DELETE CASCADE;

--
-- Constraints for table `program_learning_outcomes`
--
ALTER TABLE `program_learning_outcomes`
  ADD CONSTRAINT `program_learning_outcomes_ibfk_1` FOREIGN KEY (`program_id`) REFERENCES `programs` (`program_id`) ON DELETE CASCADE;

--
-- Constraints for table `quality_improvements`
--
ALTER TABLE `quality_improvements`
  ADD CONSTRAINT `quality_improvements_ibfk_1` FOREIGN KEY (`course_id`) REFERENCES `courses` (`course_id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
