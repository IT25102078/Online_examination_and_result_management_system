-- Online Examination and Result Management System
-- Updated database design according to workload distribution
-- Tables: students, examiners, admins, exams, exam_allocations, student_approvals, results, held_students

DROP DATABASE IF EXISTS exam_system_db;
CREATE DATABASE exam_system_db;
USE exam_system_db;

-- =========================
-- 1. admins
-- Admin login and admin dashboard
-- =========================
CREATE TABLE admins (
    admin_id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(100) NOT NULL UNIQUE,
    full_name VARCHAR(150) NOT NULL,
    email VARCHAR(150) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    role VARCHAR(50) NOT NULL,
    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- =========================
-- 2. students
-- Component 01: Student Registration & Student Details
-- =========================
CREATE TABLE students (
    student_id INT AUTO_INCREMENT PRIMARY KEY,
    registration_no VARCHAR(50) NOT NULL UNIQUE,
    full_name VARCHAR(200) NOT NULL,
    email VARCHAR(150) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    contact_no VARCHAR(20),
    department VARCHAR(100) NOT NULL,
    course VARCHAR(100) NOT NULL,
    year_of_study INT NOT NULL,
    student_type ENUM('REGULAR', 'REPEAT') NOT NULL DEFAULT 'REGULAR',
    status ENUM('PENDING', 'APPROVED', 'REJECTED') NOT NULL DEFAULT 'PENDING',
    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- =========================
-- 3. examiners
-- Component 02: Examiner Registration
-- =========================
CREATE TABLE examiners (
    examiner_id INT AUTO_INCREMENT PRIMARY KEY,
    full_name VARCHAR(150) NOT NULL,
    email VARCHAR(150) NOT NULL UNIQUE,
    specialization VARCHAR(150) NOT NULL,
    username VARCHAR(100) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    contact_no VARCHAR(20),
    department VARCHAR(100) NOT NULL,
    examiner_type ENUM('SENIOR', 'ASSISTANT') NOT NULL DEFAULT 'ASSISTANT',
    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- =========================
-- 4. exams
-- Component 03: Exam Adding
-- =========================
CREATE TABLE exams (
    exam_id INT AUTO_INCREMENT PRIMARY KEY,
	exam_code VARCHAR(50) NOT NULL UNIQUE,
    exam_name VARCHAR(150) NOT NULL,
    subject_name VARCHAR(150) NOT NULL,
    exam_date DATE NOT NULL,
    exam_time TIME NOT NULL,
	duration_minutes INT NOT NULL,
    total_marks DECIMAL(5,2) NOT NULL,
    pass_marks DECIMAL(5,2) NOT NULL,
    status ENUM('ACTIVE', 'CANCELLED', 'COMPLETED') NOT NULL DEFAULT 'ACTIVE',
    created_by INT NULL,
    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_exams_created_by
        FOREIGN KEY (created_by) REFERENCES admins(admin_id)
        ON UPDATE CASCADE
        ON DELETE SET NULL
);

-- =========================
-- 5. exam_allocations
-- Admin allocates examiners to exams
-- =========================
CREATE TABLE exam_allocations (
    allocation_id INT AUTO_INCREMENT PRIMARY KEY,
    exam_id INT NOT NULL,
    examiner_id INT NOT NULL,
    allocated_by INT NULL,
    allocated_date DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT uq_exam_allocations_exam_examiner UNIQUE (exam_id, examiner_id),
    CONSTRAINT fk_exam_allocations_exam
        FOREIGN KEY (exam_id) REFERENCES exams(exam_id)
        ON UPDATE CASCADE
        ON DELETE CASCADE,
    CONSTRAINT fk_exam_allocations_examiner
        FOREIGN KEY (examiner_id) REFERENCES examiners(examiner_id)
        ON UPDATE CASCADE
        ON DELETE CASCADE,
    CONSTRAINT fk_exam_allocations_admin
        FOREIGN KEY (allocated_by) REFERENCES admins(admin_id)
        ON UPDATE CASCADE
        ON DELETE SET NULL
);

-- =========================
-- 6. student_approvals
-- Component 04: Student Approval
-- =========================
CREATE TABLE student_approvals (
    approval_id INT AUTO_INCREMENT PRIMARY KEY,
    student_id INT NOT NULL UNIQUE,
    approval_status ENUM('PENDING', 'APPROVED', 'REJECTED') NOT NULL DEFAULT 'PENDING',
    approved_by INT NULL,
    approval_date DATETIME NULL,
    remarks VARCHAR(255),
    CONSTRAINT fk_student_approvals_student
        FOREIGN KEY (student_id) REFERENCES students(student_id)
        ON UPDATE CASCADE
        ON DELETE CASCADE,
    CONSTRAINT fk_student_approvals_admin
        FOREIGN KEY (approved_by) REFERENCES admins(admin_id)
        ON UPDATE CASCADE
        ON DELETE SET NULL
);

-- =========================
-- 7. results
-- Component 05: Examiner Adding Results
-- Component 06: Displaying Results
-- =========================
CREATE TABLE results (
    result_id INT AUTO_INCREMENT PRIMARY KEY,
    student_id INT NOT NULL,
    exam_id INT NOT NULL,
    examiner_id INT NULL,
    marks DECIMAL(5,2) NOT NULL,
    grade VARCHAR(10) NOT NULL,
    result_status ENUM('PASS', 'FAIL', 'PENDING') NOT NULL DEFAULT 'PENDING',
    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    CONSTRAINT uq_results_student_exam UNIQUE (student_id, exam_id),
    CONSTRAINT fk_results_student
        FOREIGN KEY (student_id) REFERENCES students(student_id)
        ON UPDATE CASCADE
        ON DELETE CASCADE,
    CONSTRAINT fk_results_exam
        FOREIGN KEY (exam_id) REFERENCES exams(exam_id)
        ON UPDATE CASCADE
        ON DELETE CASCADE,
    CONSTRAINT fk_results_examiner
        FOREIGN KEY (examiner_id) REFERENCES examiners(examiner_id)
        ON UPDATE CASCADE
        ON DELETE SET NULL
);

-- =========================
-- 8. held_students
-- Component 05: Holding Students
-- =========================
CREATE TABLE held_students (
    hold_id INT AUTO_INCREMENT PRIMARY KEY,
    student_id INT NOT NULL,
    exam_id INT NOT NULL,
    examiner_id INT NULL,
    reason VARCHAR(255) NOT NULL,
    hold_status ENUM('HELD', 'RELEASED') NOT NULL DEFAULT 'HELD',
    held_date DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    released_date DATETIME NULL,
    CONSTRAINT fk_held_students_student
        FOREIGN KEY (student_id) REFERENCES students(student_id)
        ON UPDATE CASCADE
        ON DELETE CASCADE,
    CONSTRAINT fk_held_students_exam
        FOREIGN KEY (exam_id) REFERENCES exams(exam_id)
        ON UPDATE CASCADE
        ON DELETE CASCADE,
    CONSTRAINT fk_held_students_examiner
        FOREIGN KEY (examiner_id) REFERENCES examiners(examiner_id)
        ON UPDATE CASCADE
        ON DELETE SET NULL
);

-- =========================
-- Helpful indexes
-- =========================
CREATE INDEX idx_students_email ON students(email);
CREATE INDEX idx_students_status ON students(status);
CREATE INDEX idx_examiners_email ON examiners(email);
CREATE INDEX idx_examiners_department ON examiners(department);
CREATE INDEX idx_exams_exam_date ON exams(exam_date);
CREATE INDEX idx_exams_status ON exams(status);
CREATE INDEX idx_student_approvals_status ON student_approvals(approval_status);
CREATE INDEX idx_results_status ON results(result_status);
CREATE INDEX idx_held_students_status ON held_students(hold_status);

-- =========================
-- Sample data
-- =========================

-- Admins
INSERT INTO admins (username, full_name, email, password, created_at) VALUES
('admin', 'System Admin', 'admin@example.com', 'admin123', '2026-04-20 08:00:00'),
('nimal_admin', 'Nimal Perera', 'nimal.admin@example.com', 'admin123', '2026-04-20 08:15:00');

-- Students
INSERT INTO students (registration_no, name, email, password, contact_no, student_type, status, created_at) VALUES
('IT2026001', 'Kasun Jayawardena', 'kasun.student@example.com', 'student123', '0711111111', 'REGULAR', 'APPROVED', '2026-04-20 09:00:00'),
('IT2026002', 'Sahan Fernando', 'sahan.student@example.com', 'student123', '0722222222', 'REGULAR', 'APPROVED', '2026-04-20 09:10:00'),
('IT2026003', 'Tharushi Peris', 'tharushi.student@example.com', 'student123', '0733333333', 'REPEAT', 'PENDING', '2026-04-20 09:20:00'),
('IT2026004', 'Amaya Silva', 'amaya.student@example.com', 'student123', '0744444444', 'REGULAR', 'REJECTED', '2026-04-20 09:30:00');

-- Examiners
INSERT INTO examiners (name, email, password, contact_no, department, examiner_type, created_at) VALUES
('Dr. Anura Senanayake', 'anura.examiner@example.com', 'examiner123', '0755555555', 'Computing', 'SENIOR', '2026-04-20 10:00:00'),
('Prof. Malini De Silva', 'malini.examiner@example.com', 'examiner123', '0766666666', 'Software Engineering', 'SENIOR', '2026-04-20 10:15:00'),
('Mr. Ravi Gunasekara', 'ravi.examiner@example.com', 'examiner123', '0777777777', 'Cyber Security', 'ASSISTANT', '2026-04-20 10:30:00');

-- Exams
INSERT INTO exams (exam_name, subject, exam_date, exam_time, status, created_by, created_at) VALUES
('Mid Examination', 'Database Systems', '2026-05-10', '09:00:00', 'ACTIVE', 1, '2026-04-21 08:00:00'),
('Final Examination', 'Object Oriented Programming', '2026-05-15', '13:30:00', 'ACTIVE', 1, '2026-04-21 08:10:00'),
('Practical Examination', 'Cyber Security', '2026-05-20', '10:00:00', 'ACTIVE', 2, '2026-04-21 08:20:00');

-- Exam allocations
INSERT INTO exam_allocations (exam_id, examiner_id, allocated_by, allocated_date) VALUES
(1, 1, 1, '2026-04-22 08:00:00'),
(2, 2, 1, '2026-04-22 08:10:00'),
(3, 3, 2, '2026-04-22 08:20:00');

-- Student approvals
INSERT INTO student_approvals (student_id, approval_status, approved_by, approval_date, remarks) VALUES
(1, 'APPROVED', 1, '2026-04-21 11:00:00', 'Registration approved'),
(2, 'APPROVED', 1, '2026-04-21 11:05:00', 'Registration approved'),
(3, 'PENDING', NULL, NULL, 'Waiting for admin review'),
(4, 'REJECTED', 2, '2026-04-21 11:15:00', 'Invalid registration details');

-- Results
INSERT INTO results (student_id, exam_id, examiner_id, marks, grade, result_status, created_at) VALUES
(1, 1, 1, 78.50, 'A-', 'PASS', '2026-05-12 14:00:00'),
(1, 2, 2, 64.00, 'B', 'PASS', '2026-05-17 15:00:00'),
(2, 2, 2, 42.00, 'C-', 'FAIL', '2026-05-17 15:10:00');

-- Held students
INSERT INTO held_students (student_id, exam_id, examiner_id, reason, hold_status, held_date, released_date) VALUES
(3, 3, 3, 'Suspected cheating during practical examination', 'HELD', '2026-05-20 11:15:00', NULL),
(2, 1, 1, 'ID verification issue resolved', 'RELEASED', '2026-05-10 09:30:00', '2026-05-10 11:00:00');

-- =========================
-- Verify data quickly
-- =========================
-- SELECT * FROM admins;
-- SELECT * FROM students;
-- SELECT * FROM examiners;
-- SELECT * FROM exams;
-- SELECT * FROM exam_allocations;
-- SELECT * FROM student_approvals;
-- SELECT * FROM results;
-- SELECT * FROM held_students;
