package com.exam.exam_system.service;

import com.exam.exam_system.model.*;
import com.exam.exam_system.model.ExamRegistration.ApprovalStatus;
import com.exam.exam_system.repository.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.util.List;

// ── OOP: Abstraction — all business logic hidden here ─────
@Service
public class ExamRegistrationService {

    @Autowired
    private ExamRegistrationRepository examRegistrationRepository;

    @Autowired
    private StudentRepository studentRepository;

    @Autowired
    private ExamRepository examRepository;

    @Autowired
    private AdminRepository adminRepository;

    // ── CREATE: Student requests exam registration ─────────
    public ExamRegistration requestRegistration(Integer studentId, Integer examId) {

        Student student = studentRepository.findById(studentId)
                .orElseThrow(() -> new RuntimeException("Student not found."));

        Exam exam = examRepository.findById(examId)
                .orElseThrow(() -> new RuntimeException("Exam not found."));

        if (examRegistrationRepository
                .existsByStudent_StudentIdAndExam_ExamId(studentId, examId)) {
            throw new RuntimeException(
                    "You have already registered for this exam.");
        }

        ExamRegistration registration = new ExamRegistration();
        registration.setStudent(student);
        registration.setExam(exam);
        registration.setApprovalStatus(ApprovalStatus.PENDING);
        registration.setRegisteredDate(LocalDateTime.now());

        return examRegistrationRepository.save(registration);
    }

    // ── READ: All registrations (admin) ───────────────────
    public List<ExamRegistration> getAllRegistrations() {
        return examRegistrationRepository.findAll();
    }

    // ── READ: Filter by status ─────────────────────────────
    public List<ExamRegistration> getRegistrationsByStatus(ApprovalStatus status) {
        return examRegistrationRepository.findByApprovalStatus(status);
    }

    // ── READ: Student's own registrations ─────────────────
    public List<ExamRegistration> getRegistrationsByStudent(Integer studentId) {
        return examRegistrationRepository.findByStudent_StudentId(studentId);
    }

    // ── READ ONE ───────────────────────────────────────────
    public ExamRegistration getRegistrationById(Integer id) {
        return examRegistrationRepository.findById(id)
                .orElseThrow(() -> new RuntimeException(
                        "Registration not found with ID: " + id));
    }

    // ── UPDATE: Admin approves ─────────────────────────────
    public ExamRegistration approveRegistration(Integer registrationId,
                                                Integer adminId,
                                                String remarks) {
        ExamRegistration registration = getRegistrationById(registrationId);
        Admin admin = adminRepository.findById(adminId)
                .orElseThrow(() -> new RuntimeException("Admin not found."));

        registration.setApprovalStatus(ApprovalStatus.APPROVED);
        registration.setApprovedBy(admin);
        registration.setApprovedDate(LocalDateTime.now());
        registration.setRemarks(remarks);

        return examRegistrationRepository.save(registration);
    }

    // ── UPDATE: Admin rejects ──────────────────────────────
    public ExamRegistration rejectRegistration(Integer registrationId,
                                               Integer adminId,
                                               String remarks) {
        ExamRegistration registration = getRegistrationById(registrationId);
        Admin admin = adminRepository.findById(adminId)
                .orElseThrow(() -> new RuntimeException("Admin not found."));

        registration.setApprovalStatus(ApprovalStatus.REJECTED);
        registration.setApprovedBy(admin);
        registration.setApprovedDate(LocalDateTime.now());
        registration.setRemarks(remarks);

        return examRegistrationRepository.save(registration);
    }

    // ── DELETE: Remove invalid registration ───────────────
    public void deleteRegistration(Integer id) {
        if (!examRegistrationRepository.existsById(id)) {
            throw new RuntimeException("Registration not found with ID: " + id);
        }
        examRegistrationRepository.deleteById(id);
    }

    // ── BUSINESS RULE: Used by examiner in Component 05 ───
    // Returns true only if student has APPROVED registration for this exam
    public boolean canAddMarks(Integer studentId, Integer examId) {
        return examRegistrationRepository
                .findByStudent_StudentIdAndExam_ExamId(studentId, examId)
                .map(ExamRegistration::isApproved)
                .orElse(false);
    }

    // Get all available exams student has NOT yet registered for
    public List<Exam> getAvailableExamsForStudent(Integer studentId) {
        List<ExamRegistration> existing =
                examRegistrationRepository.findByStudent_StudentId(studentId);

        List<Integer> registeredExamIds = existing.stream()
                .map(r -> r.getExam().getExamId())
                .toList();

        return examRepository.findAll().stream()
                .filter(e -> !registeredExamIds.contains(e.getExamId()))
                .filter(e -> e.getStatus() == Exam.ExamStatus.ACTIVE)
                .toList();
    }
}
