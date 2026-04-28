-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Apr 28, 2026 at 06:31 PM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.0.30

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
  `status` enum('Draft','Pending HoD','Pending QA','Approved') NOT NULL,
  `timestamp` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `assessments`
--

CREATE TABLE `assessments` (
  `assessment_id` int(11) NOT NULL,
  `course_id` int(11) DEFAULT NULL,
  `assessment_activity` varchar(255) DEFAULT NULL,
  `assessment_timing` varchar(100) DEFAULT NULL,
  `percentage_of_total` decimal(5,2) DEFAULT NULL
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
  `plo_id` int(11) DEFAULT NULL,
  `performance_level` enum('Introduced','Practiced','Mastered') DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `courses`
--

CREATE TABLE `courses` (
  `course_id` int(11) NOT NULL,
  `program_id` int(11) DEFAULT NULL,
  `course_title` varchar(255) NOT NULL,
  `course_code` varchar(50) NOT NULL,
  `department` varchar(255) DEFAULT NULL,
  `college` varchar(255) DEFAULT NULL,
  `institution` varchar(255) DEFAULT NULL,
  `version` varchar(50) DEFAULT NULL,
  `last_revision_date` date DEFAULT NULL,
  `credit_hours` int(11) DEFAULT NULL,
  `course_type_source` enum('University','College','Department','Track','Others') DEFAULT NULL,
  `course_type_requirement` enum('Required','Elective') DEFAULT NULL,
  `offered_level_year` varchar(100) DEFAULT NULL,
  `general_description` text DEFAULT NULL,
  `pre_requirements` varchar(255) DEFAULT NULL,
  `co_requisites` varchar(255) DEFAULT NULL,
  `main_objectives` text DEFAULT NULL,
  `curriculum_requirement_type` enum('Institution','College','Program') DEFAULT NULL,
  `approval_council_committee` varchar(255) DEFAULT NULL,
  `approval_reference_no` varchar(100) DEFAULT NULL,
  `approval_date` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `course_contact_hours`
--

CREATE TABLE `course_contact_hours` (
  `hours_id` int(11) NOT NULL,
  `course_id` int(11) DEFAULT NULL,
  `activity` enum('Lectures','Laboratory/Studio','Field','Tutorial','Others') DEFAULT NULL,
  `contact_hours` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `course_learning_outcomes`
--

CREATE TABLE `course_learning_outcomes` (
  `clo_id` int(11) NOT NULL,
  `course_id` int(11) DEFAULT NULL,
  `clo_code` varchar(20) NOT NULL,
  `description` text DEFAULT NULL,
  `category` enum('Knowledge','Skills','Values') NOT NULL,
  `teaching_strategies` text DEFAULT NULL,
  `assessment_methods` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `course_quality_assessment`
--

CREATE TABLE `course_quality_assessment` (
  `quality_id` int(11) NOT NULL,
  `course_id` int(11) DEFAULT NULL,
  `assessment_area` varchar(255) DEFAULT NULL,
  `assessor` enum('Students','Faculty','Program Leaders','Peer Reviewers','Others') DEFAULT NULL,
  `assessment_method` enum('Direct','Indirect') DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `course_resources_facilities`
--

CREATE TABLE `course_resources_facilities` (
  `resource_id` int(11) NOT NULL,
  `course_id` int(11) DEFAULT NULL,
  `essential_references` text DEFAULT NULL,
  `supportive_references` text DEFAULT NULL,
  `electronic_materials` text DEFAULT NULL,
  `other_materials` text DEFAULT NULL,
  `classrooms_labs_facilities` text DEFAULT NULL,
  `technology_equipment` text DEFAULT NULL,
  `other_equipment` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `course_teaching_modes`
--

CREATE TABLE `course_teaching_modes` (
  `mode_id` int(11) NOT NULL,
  `course_id` int(11) DEFAULT NULL,
  `mode` enum('Traditional classroom','E-learning','Hybrid','Distance learning') DEFAULT NULL,
  `contact_hours` int(11) DEFAULT NULL,
  `percentage` decimal(5,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `course_topics`
--

CREATE TABLE `course_topics` (
  `topic_id` int(11) NOT NULL,
  `course_id` int(11) DEFAULT NULL,
  `topic_title` varchar(255) DEFAULT NULL,
  `contact_hours` int(11) DEFAULT NULL
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
  `program_code` varchar(100) DEFAULT NULL,
  `qualification_level` varchar(100) DEFAULT NULL,
  `department` varchar(255) DEFAULT NULL,
  `college` varchar(255) DEFAULT NULL,
  `institution` varchar(255) DEFAULT NULL,
  `specification_status` enum('New','Updated') DEFAULT NULL,
  `last_review_date` date DEFAULT NULL,
  `main_location` varchar(255) DEFAULT NULL,
  `branches` text DEFAULT NULL,
  `partnerships` text DEFAULT NULL,
  `professions_jobs` text DEFAULT NULL,
  `occupational_sectors` text DEFAULT NULL,
  `total_credit_hours` int(11) DEFAULT NULL,
  `mission` text DEFAULT NULL,
  `goals` text DEFAULT NULL,
  `teaching_learning_strategies` text DEFAULT NULL,
  `assessment_methods` text DEFAULT NULL,
  `admission_requirements` text DEFAULT NULL,
  `guidance_orientation` text DEFAULT NULL,
  `student_counseling` text DEFAULT NULL,
  `special_support` text DEFAULT NULL,
  `program_learning_resources` text DEFAULT NULL,
  `program_facilities_equipment` text DEFAULT NULL,
  `health_safety_procedures` text DEFAULT NULL,
  `qa_system_link` varchar(255) DEFAULT NULL,
  `monitor_other_departments_procedures` text DEFAULT NULL,
  `branches_consistency_procedures` text DEFAULT NULL,
  `plo_assessment_plan` text DEFAULT NULL,
  `approval_council_committee` varchar(255) DEFAULT NULL,
  `approval_reference_no` varchar(100) DEFAULT NULL,
  `approval_date` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `program_curriculum_structure`
--

CREATE TABLE `program_curriculum_structure` (
  `structure_id` int(11) NOT NULL,
  `program_id` int(11) DEFAULT NULL,
  `requirement_type` enum('Institution Requirements','College Requirements','Program Requirements','Capstone Course/Project','Field Training/ Internship','Residency year','Others') DEFAULT NULL,
  `is_required` enum('Required','Elective') DEFAULT NULL,
  `num_courses` int(11) DEFAULT NULL,
  `credit_hours` int(11) DEFAULT NULL,
  `percentage` decimal(5,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `program_evaluation_matrix`
--

CREATE TABLE `program_evaluation_matrix` (
  `eval_id` int(11) NOT NULL,
  `program_id` int(11) DEFAULT NULL,
  `evaluation_areas` varchar(255) DEFAULT NULL,
  `evaluation_sources` varchar(255) DEFAULT NULL,
  `evaluation_methods` varchar(255) DEFAULT NULL,
  `evaluation_time` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `program_exit_points`
--

CREATE TABLE `program_exit_points` (
  `exit_point_id` int(11) NOT NULL,
  `program_id` int(11) DEFAULT NULL,
  `awarded_degree` varchar(255) DEFAULT NULL,
  `credit_hours` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `program_faculty_staff`
--

CREATE TABLE `program_faculty_staff` (
  `staff_id` int(11) NOT NULL,
  `program_id` int(11) DEFAULT NULL,
  `academic_rank` enum('Professor','Associate Professor','Assistant Professor','Lecturer','Teaching Assistant','Technicians and Laboratory Assistants','Administrative and Supportive Staff','Others') DEFAULT NULL,
  `specialty_general` varchar(255) DEFAULT NULL,
  `specialty_specific` varchar(255) DEFAULT NULL,
  `special_requirements` text DEFAULT NULL,
  `required_male` int(11) DEFAULT NULL,
  `required_female` int(11) DEFAULT NULL,
  `required_total` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `program_kpis`
--

CREATE TABLE `program_kpis` (
  `kpi_id` int(11) NOT NULL,
  `program_id` int(11) DEFAULT NULL,
  `kpi_code` varchar(50) DEFAULT NULL,
  `kpi_description` text DEFAULT NULL,
  `targeted_level` varchar(100) DEFAULT NULL,
  `measurement_methods` varchar(255) DEFAULT NULL,
  `measurement_time` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `program_learning_outcomes`
--

CREATE TABLE `program_learning_outcomes` (
  `plo_id` int(11) NOT NULL,
  `program_id` int(11) DEFAULT NULL,
  `plo_code` varchar(20) NOT NULL,
  `description` text DEFAULT NULL,
  `category` enum('Knowledge','Skills','Values') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `program_tracks`
--

CREATE TABLE `program_tracks` (
  `track_id` int(11) NOT NULL,
  `program_id` int(11) DEFAULT NULL,
  `track_name` varchar(255) DEFAULT NULL,
  `credit_hours` int(11) DEFAULT NULL,
  `professions` text DEFAULT NULL
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
  `role` enum('Faculty','HoD','Dean','QA') NOT NULL
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
-- Indexes for table `course_contact_hours`
--
ALTER TABLE `course_contact_hours`
  ADD PRIMARY KEY (`hours_id`),
  ADD KEY `course_id` (`course_id`);

--
-- Indexes for table `course_learning_outcomes`
--
ALTER TABLE `course_learning_outcomes`
  ADD PRIMARY KEY (`clo_id`),
  ADD KEY `course_id` (`course_id`);

--
-- Indexes for table `course_quality_assessment`
--
ALTER TABLE `course_quality_assessment`
  ADD PRIMARY KEY (`quality_id`),
  ADD KEY `course_id` (`course_id`);

--
-- Indexes for table `course_resources_facilities`
--
ALTER TABLE `course_resources_facilities`
  ADD PRIMARY KEY (`resource_id`),
  ADD KEY `course_id` (`course_id`);

--
-- Indexes for table `course_teaching_modes`
--
ALTER TABLE `course_teaching_modes`
  ADD PRIMARY KEY (`mode_id`),
  ADD KEY `course_id` (`course_id`);

--
-- Indexes for table `course_topics`
--
ALTER TABLE `course_topics`
  ADD PRIMARY KEY (`topic_id`),
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
-- Indexes for table `program_curriculum_structure`
--
ALTER TABLE `program_curriculum_structure`
  ADD PRIMARY KEY (`structure_id`),
  ADD KEY `program_id` (`program_id`);

--
-- Indexes for table `program_evaluation_matrix`
--
ALTER TABLE `program_evaluation_matrix`
  ADD PRIMARY KEY (`eval_id`),
  ADD KEY `program_id` (`program_id`);

--
-- Indexes for table `program_exit_points`
--
ALTER TABLE `program_exit_points`
  ADD PRIMARY KEY (`exit_point_id`),
  ADD KEY `program_id` (`program_id`);

--
-- Indexes for table `program_faculty_staff`
--
ALTER TABLE `program_faculty_staff`
  ADD PRIMARY KEY (`staff_id`),
  ADD KEY `program_id` (`program_id`);

--
-- Indexes for table `program_kpis`
--
ALTER TABLE `program_kpis`
  ADD PRIMARY KEY (`kpi_id`),
  ADD KEY `program_id` (`program_id`);

--
-- Indexes for table `program_learning_outcomes`
--
ALTER TABLE `program_learning_outcomes`
  ADD PRIMARY KEY (`plo_id`),
  ADD KEY `program_id` (`program_id`);

--
-- Indexes for table `program_tracks`
--
ALTER TABLE `program_tracks`
  ADD PRIMARY KEY (`track_id`),
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
-- AUTO_INCREMENT for table `course_contact_hours`
--
ALTER TABLE `course_contact_hours`
  MODIFY `hours_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `course_learning_outcomes`
--
ALTER TABLE `course_learning_outcomes`
  MODIFY `clo_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `course_quality_assessment`
--
ALTER TABLE `course_quality_assessment`
  MODIFY `quality_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `course_resources_facilities`
--
ALTER TABLE `course_resources_facilities`
  MODIFY `resource_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `course_teaching_modes`
--
ALTER TABLE `course_teaching_modes`
  MODIFY `mode_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `course_topics`
--
ALTER TABLE `course_topics`
  MODIFY `topic_id` int(11) NOT NULL AUTO_INCREMENT;

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
-- AUTO_INCREMENT for table `program_curriculum_structure`
--
ALTER TABLE `program_curriculum_structure`
  MODIFY `structure_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `program_evaluation_matrix`
--
ALTER TABLE `program_evaluation_matrix`
  MODIFY `eval_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `program_exit_points`
--
ALTER TABLE `program_exit_points`
  MODIFY `exit_point_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `program_faculty_staff`
--
ALTER TABLE `program_faculty_staff`
  MODIFY `staff_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `program_kpis`
--
ALTER TABLE `program_kpis`
  MODIFY `kpi_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `program_learning_outcomes`
--
ALTER TABLE `program_learning_outcomes`
  MODIFY `plo_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `program_tracks`
--
ALTER TABLE `program_tracks`
  MODIFY `track_id` int(11) NOT NULL AUTO_INCREMENT;

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
  ADD CONSTRAINT `approval_log_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE;

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
  ADD CONSTRAINT `courses_ibfk_1` FOREIGN KEY (`program_id`) REFERENCES `programs` (`program_id`) ON DELETE CASCADE;

--
-- Constraints for table `course_contact_hours`
--
ALTER TABLE `course_contact_hours`
  ADD CONSTRAINT `course_contact_hours_ibfk_1` FOREIGN KEY (`course_id`) REFERENCES `courses` (`course_id`) ON DELETE CASCADE;

--
-- Constraints for table `course_learning_outcomes`
--
ALTER TABLE `course_learning_outcomes`
  ADD CONSTRAINT `course_learning_outcomes_ibfk_1` FOREIGN KEY (`course_id`) REFERENCES `courses` (`course_id`) ON DELETE CASCADE;

--
-- Constraints for table `course_quality_assessment`
--
ALTER TABLE `course_quality_assessment`
  ADD CONSTRAINT `course_quality_assessment_ibfk_1` FOREIGN KEY (`course_id`) REFERENCES `courses` (`course_id`) ON DELETE CASCADE;

--
-- Constraints for table `course_resources_facilities`
--
ALTER TABLE `course_resources_facilities`
  ADD CONSTRAINT `course_resources_facilities_ibfk_1` FOREIGN KEY (`course_id`) REFERENCES `courses` (`course_id`) ON DELETE CASCADE;

--
-- Constraints for table `course_teaching_modes`
--
ALTER TABLE `course_teaching_modes`
  ADD CONSTRAINT `course_teaching_modes_ibfk_1` FOREIGN KEY (`course_id`) REFERENCES `courses` (`course_id`) ON DELETE CASCADE;

--
-- Constraints for table `course_topics`
--
ALTER TABLE `course_topics`
  ADD CONSTRAINT `course_topics_ibfk_1` FOREIGN KEY (`course_id`) REFERENCES `courses` (`course_id`) ON DELETE CASCADE;

--
-- Constraints for table `jahiziah_skills`
--
ALTER TABLE `jahiziah_skills`
  ADD CONSTRAINT `jahiziah_skills_ibfk_1` FOREIGN KEY (`course_id`) REFERENCES `courses` (`course_id`) ON DELETE CASCADE;

--
-- Constraints for table `program_curriculum_structure`
--
ALTER TABLE `program_curriculum_structure`
  ADD CONSTRAINT `program_curriculum_structure_ibfk_1` FOREIGN KEY (`program_id`) REFERENCES `programs` (`program_id`) ON DELETE CASCADE;

--
-- Constraints for table `program_evaluation_matrix`
--
ALTER TABLE `program_evaluation_matrix`
  ADD CONSTRAINT `program_evaluation_matrix_ibfk_1` FOREIGN KEY (`program_id`) REFERENCES `programs` (`program_id`) ON DELETE CASCADE;

--
-- Constraints for table `program_exit_points`
--
ALTER TABLE `program_exit_points`
  ADD CONSTRAINT `program_exit_points_ibfk_1` FOREIGN KEY (`program_id`) REFERENCES `programs` (`program_id`) ON DELETE CASCADE;

--
-- Constraints for table `program_faculty_staff`
--
ALTER TABLE `program_faculty_staff`
  ADD CONSTRAINT `program_faculty_staff_ibfk_1` FOREIGN KEY (`program_id`) REFERENCES `programs` (`program_id`) ON DELETE CASCADE;

--
-- Constraints for table `program_kpis`
--
ALTER TABLE `program_kpis`
  ADD CONSTRAINT `program_kpis_ibfk_1` FOREIGN KEY (`program_id`) REFERENCES `programs` (`program_id`) ON DELETE CASCADE;

--
-- Constraints for table `program_learning_outcomes`
--
ALTER TABLE `program_learning_outcomes`
  ADD CONSTRAINT `program_learning_outcomes_ibfk_1` FOREIGN KEY (`program_id`) REFERENCES `programs` (`program_id`) ON DELETE CASCADE;

--
-- Constraints for table `program_tracks`
--
ALTER TABLE `program_tracks`
  ADD CONSTRAINT `program_tracks_ibfk_1` FOREIGN KEY (`program_id`) REFERENCES `programs` (`program_id`) ON DELETE CASCADE;

--
-- Constraints for table `quality_improvements`
--
ALTER TABLE `quality_improvements`
  ADD CONSTRAINT `quality_improvements_ibfk_1` FOREIGN KEY (`course_id`) REFERENCES `courses` (`course_id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
