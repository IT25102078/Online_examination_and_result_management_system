-- Online Examination and Result Management System
-- Full database dump-style SQL file
-- Includes: database creation, table structure, constraints, indexes, and sample data

DROP DATABASE IF EXISTS exam_system_db;
CREATE DATABASE exam_system_db;
USE exam_system_db;

-- =========================
-- 1. students
-- =========================
CREATE TABLE students (
    student_id INT AUTO_INCREMENT PRIMARY KEY,
    registration_no VARCHAR(50) NOT NULL UNIQUE,
    full_name VARCHAR(200) NOT NULL,
    email VARCHAR(150) NOT NULL UNIQUE,
    phone VARCHAR(20),
    department VARCHAR(100) NOT NULL,
    course VARCHAR(100) NOT NULL,
    year_of_study INT NOT NULL,
    password VARCHAR(255) NOT NULL,
    account_status ENUM('ACTIVE', 'HELD') NOT NULL DEFAULT 'ACTIVE',
    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- =========================
-- 2. admins
-- =========================
CREATE TABLE admins (
    admin_id INT AUTO_INCREMENT PRIMARY KEY,
    full_name VARCHAR(150) NOT NULL,
    email VARCHAR(150) NOT NULL UNIQUE,
    username VARCHAR(100) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    role VARCHAR(50) NOT NULL,
    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- =========================
-- 3. examiners
-- =========================
CREATE TABLE examiners (
    examiner_id INT AUTO_INCREMENT PRIMARY KEY,
    full_name VARCHAR(150) NOT NULL,
    email VARCHAR(150) NOT NULL UNIQUE,
    phone VARCHAR(20),
    specialization VARCHAR(150) NOT NULL,
    username VARCHAR(100) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    status ENUM('ACTIVE', 'INACTIVE') NOT NULL DEFAULT 'ACTIVE'
);

-- =========================
-- 4. exams
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
    created_by INT NOT NULL,
    CONSTRAINT fk_exams_created_by
        FOREIGN KEY (created_by) REFERENCES admins(admin_id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
);

-- =========================
-- 5. registrations
-- =========================
CREATE TABLE registrations (
    registration_id INT AUTO_INCREMENT PRIMARY KEY,
    student_id INT NOT NULL,
    exam_id INT NOT NULL,
    registered_date DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    approval_status ENUM('PENDING', 'APPROVED') NOT NULL DEFAULT 'PENDING',
    approved_by INT NULL,
    approved_date DATETIME NULL,
    CONSTRAINT uq_registrations_student_exam UNIQUE (student_id, exam_id),
    CONSTRAINT fk_registrations_student
        FOREIGN KEY (student_id) REFERENCES students(student_id)
        ON UPDATE CASCADE
        ON DELETE CASCADE,
    CONSTRAINT fk_registrations_exam
        FOREIGN KEY (exam_id) REFERENCES exams(exam_id)
        ON UPDATE CASCADE
        ON DELETE CASCADE,
    CONSTRAINT fk_registrations_approved_by
        FOREIGN KEY (approved_by) REFERENCES admins(admin_id)
        ON UPDATE CASCADE
        ON DELETE SET NULL
);

-- =========================
-- 6. examiner_allocations
-- =========================
CREATE TABLE examiner_allocations (
    allocation_id INT AUTO_INCREMENT PRIMARY KEY,
    examiner_id INT NOT NULL,
    exam_id INT NOT NULL,
    allocated_by INT NOT NULL,
    allocated_date DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT uq_examiner_allocations UNIQUE (examiner_id, exam_id),
    CONSTRAINT fk_allocations_examiner
        FOREIGN KEY (examiner_id) REFERENCES examiners(examiner_id)
        ON UPDATE CASCADE
        ON DELETE CASCADE,
    CONSTRAINT fk_allocations_exam
        FOREIGN KEY (exam_id) REFERENCES exams(exam_id)
        ON UPDATE CASCADE
        ON DELETE CASCADE,
    CONSTRAINT fk_allocations_admin
        FOREIGN KEY (allocated_by) REFERENCES admins(admin_id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
);

-- =========================
-- 7. results
-- =========================
CREATE TABLE results (
    result_id INT AUTO_INCREMENT PRIMARY KEY,
    student_id INT NOT NULL,
    exam_id INT NOT NULL,
    examiner_id INT NOT NULL,
    marks_obtained DECIMAL(5,2) NOT NULL,
    grade VARCHAR(10) NOT NULL,
    result_status ENUM('PASS', 'FAIL') NOT NULL,
    published_date DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
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
        ON DELETE RESTRICT
);

-- =========================
-- 8. holds
-- =========================
CREATE TABLE holds (
    hold_id INT AUTO_INCREMENT PRIMARY KEY,
    student_id INT NOT NULL,
    exam_id INT NOT NULL,
    examiner_id INT NOT NULL,
    reason VARCHAR(255) NOT NULL,
    hold_status ENUM('ACTIVE', 'RELEASED') NOT NULL DEFAULT 'ACTIVE',
    hold_date DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_holds_student
        FOREIGN KEY (student_id) REFERENCES students(student_id)
        ON UPDATE CASCADE
        ON DELETE CASCADE,
    CONSTRAINT fk_holds_exam
        FOREIGN KEY (exam_id) REFERENCES exams(exam_id)
        ON UPDATE CASCADE
        ON DELETE CASCADE,
    CONSTRAINT fk_holds_examiner
        FOREIGN KEY (examiner_id) REFERENCES examiners(examiner_id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
);

-- =========================
-- Helpful indexes
-- =========================
CREATE INDEX idx_students_email ON students(email);
CREATE INDEX idx_students_registration_no ON students(registration_no);
CREATE INDEX idx_exams_exam_date ON exams(exam_date);
CREATE INDEX idx_registrations_status ON registrations(approval_status);
CREATE INDEX idx_results_status ON results(result_status);
CREATE INDEX idx_holds_status ON holds(hold_status);

-- =========================
-- Sample data
-- =========================

-- Admins
INSERT INTO admins (full_name, email, username, password, role, created_at) VALUES
('Nimal Perera', 'nimal.admin@example.com', 'nimal_admin', 'admin123', 'SUPER_ADMIN', '2026-04-20 08:00:00'),
('Kamal Silva', 'kamal.admin@example.com', 'kamal_admin', 'admin123', 'ADMIN', '2026-04-20 08:15:00');

-- Students
INSERT INTO students (registration_no, full_name, email, phone, department, course, year_of_study, password, account_status, created_at) VALUES
('IT2026001', 'Kasun Jayawardena', 'kasun.student@example.com', '0711111111', 'Computing', 'Information Technology', 1, 'student123', 'ACTIVE', '2026-04-20 09:00:00'),
('IT2026002', 'Sahan Fernando', 'sahan.student@example.com', '0722222222', 'Computing', 'Software Engineering', 2, 'student123', 'ACTIVE', '2026-04-20 09:10:00'),
('IT2026003', 'Tharushi Peris', 'tharushi.student@example.com', '0733333333', 'Engineering', 'Computer Systems', 3, 'student123', 'HELD', '2026-04-20 09:20:00');

-- Examiners
INSERT INTO examiners (full_name, email, phone, specialization, username, password, status) VALUES
('Dr. Anura Senanayake', 'anura.examiner@example.com', '0744444444', 'Database Systems', 'anura_examiner', 'examiner123', 'ACTIVE'),
('Prof. Malini De Silva', 'malini.examiner@example.com', '0755555555', 'Object Oriented Programming', 'malini_examiner', 'examiner123', 'ACTIVE'),
('Mr. Ravi Gunasekara', 'ravi.examiner@example.com', '0766666666', 'Cyber Security', 'ravi_examiner', 'examiner123', 'INACTIVE');

-- Exams
INSERT INTO exams (exam_code, exam_name, subject_name, exam_date, exam_time, duration_minutes, total_marks, pass_marks, created_by) VALUES
('EXAM-DB-001', 'Mid Examination', 'Database Systems', '2026-05-10', '09:00:00', 120, 100.00, 50.00, 1),
('EXAM-OOP-001', 'Final Examination', 'Object Oriented Programming', '2026-05-15', '13:30:00', 180, 100.00, 50.00, 1),
('EXAM-CS-001', 'Practical Examination', 'Cyber Security', '2026-05-20', '10:00:00', 90, 100.00, 50.00, 2);

-- Registrations
INSERT INTO registrations (student_id, exam_id, registered_date, approval_status, approved_by, approved_date) VALUES
(1, 1, '2026-04-21 10:00:00', 'APPROVED', 1, '2026-04-21 11:00:00'),
(1, 2, '2026-04-21 10:05:00', 'APPROVED', 1, '2026-04-21 11:05:00'),
(2, 2, '2026-04-21 10:10:00', 'APPROVED', 2, '2026-04-21 11:10:00'),
(3, 3, '2026-04-21 10:20:00', 'PENDING', NULL, NULL);

-- Examiner allocations
INSERT INTO examiner_allocations (examiner_id, exam_id, allocated_by, allocated_date) VALUES
(1, 1, 1, '2026-04-22 08:00:00'),
(2, 2, 1, '2026-04-22 08:10:00'),
(3, 3, 2, '2026-04-22 08:20:00');

-- Results
INSERT INTO results (student_id, exam_id, examiner_id, marks_obtained, grade, result_status, published_date) VALUES
(1, 1, 1, 78.50, 'A-', 'PASS', '2026-05-12 14:00:00'),
(1, 2, 2, 64.00, 'B', 'PASS', '2026-05-17 15:00:00'),
(2, 2, 2, 42.00, 'C-', 'FAIL', '2026-05-17 15:10:00');

-- Holds
INSERT INTO holds (student_id, exam_id, examiner_id, reason, hold_status, hold_date) VALUES
(3, 3, 3, 'Suspected cheating during practical examination', 'ACTIVE', '2026-05-20 11:15:00');

-- =========================
-- Verify data quickly
-- =========================
-- SELECT * FROM students;
-- SELECT * FROM admins;
-- SELECT * FROM examiners;
-- SELECT * FROM exams;
-- SELECT * FROM registrations;
-- SELECT * FROM examiner_allocations;
-- SELECT * FROM results;
-- SELECT * FROM holds;
