package com.exam.exam_system.service;

import com.exam.exam_system.model.Admin;
import com.exam.exam_system.model.Examiner;
import com.exam.exam_system.model.Student;
import com.exam.exam_system.repository.AdminRepository;
import com.exam.exam_system.repository.ExaminerRepository;
import com.exam.exam_system.repository.StudentRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

// ── OOP: Abstraction — hides login logic from controller ──
@Service
public class LoginService {

    @Autowired
    private AdminRepository adminRepository;

    @Autowired
    private StudentRepository studentRepository;

    @Autowired
    private ExaminerRepository examinerRepository;

    // ── Validate Admin ─────────────────────────────────────
    public Admin loginAdmin(String username, String password) {
        return adminRepository.findByUsername(username)
                .filter(a -> a.getPassword().equals(password))
                .orElse(null);
    }

    // ── Validate Student ───────────────────────────────────
    public Student loginStudent(String username, String password) {
        Student student = studentRepository.findByEmail(username)
                .orElse(null);

        if (student == null) return null;

        if (!student.getPassword().equals(password)) return null;

        if (student.getAccountStatus() == Student.AccountStatus.HELD) {
            throw new RuntimeException(
                    "Your account is on hold. Please contact admin.");
        }

        if (student.getAccountStatus() == Student.AccountStatus.INACTIVE) {
            throw new RuntimeException(
                    "Your account is inactive. Please contact admin.");
        }

        return student;
    }

    // ── Validate Examiner ──────────────────────────────────
    public Examiner loginExaminer(String username, String password) {
        return examinerRepository.findByUsername(username)
                .filter(e -> e.getPassword().equals(password))
                .filter(e -> e.getStatus()
                        == Examiner.ExaminerStatus.ACTIVE)
                .orElse(null);
    }
}