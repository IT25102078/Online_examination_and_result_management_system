package com.exam.exam_system.service;

import com.exam.exam_system.model.*;
import com.exam.exam_system.repository.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.util.List;

@Service
public class HoldService {

    @Autowired
    private HoldRepository holdRepository;

    @Autowired
    private StudentRepository studentRepository;

    @Autowired
    private ExamRepository examRepository;

    @Autowired
    private ExaminerRepository examinerRepository;

    @Autowired
    private ExaminerPermissionService examinerPermissionService;

    // ── CREATE: Place a hold ───────────────────────────────
    public Hold placeHold(Integer studentId, Integer examId,
                          Integer examinerId, String reason) {

        Examiner examiner = examinerRepository.findById(examinerId)
                .orElseThrow(() -> new RuntimeException("Examiner not found."));

        // ── OOP: Polymorphism — Senior only ────────────────
        if (!examinerPermissionService.canHoldStudents(examiner)) {
            throw new RuntimeException(
                    "Permission denied. Only SENIOR examiners can hold students.");
        }

        if (holdRepository.existsByStudent_StudentIdAndExam_ExamIdAndHoldStatus(
                studentId, examId, Hold.HoldStatus.ACTIVE)) {
            throw new RuntimeException(
                    "Student already has an active hold for this exam.");
        }

        Student student = studentRepository.findById(studentId)
                .orElseThrow(() -> new RuntimeException("Student not found."));
        Exam exam = examRepository.findById(examId)
                .orElseThrow(() -> new RuntimeException("Exam not found."));

        Hold hold = new Hold();
        hold.setStudent(student);
        hold.setExam(exam);
        hold.setExaminer(examiner);
        hold.setReason(reason);
        hold.setHoldStatus(Hold.HoldStatus.ACTIVE);
        hold.setHoldDate(LocalDateTime.now());

        // Update student account status to HELD
        student.setAccountStatus(Student.AccountStatus.HELD);
        studentRepository.save(student);

        return holdRepository.save(hold);
    }

    // ── READ ALL ───────────────────────────────────────────
    public List<Hold> getAllHolds() {
        return holdRepository.findAll();
    }

    // ── READ by examiner ───────────────────────────────────
    public List<Hold> getHoldsByExaminer(Integer examinerId) {
        return holdRepository.findByExaminer_ExaminerId(examinerId);
    }

    // ── READ ONE ───────────────────────────────────────────
    public Hold getHoldById(Integer id) {
        return holdRepository.findById(id)
                .orElseThrow(() -> new RuntimeException(
                        "Hold not found with ID: " + id));
    }

    // ── UPDATE: Release a hold ─────────────────────────────
    public Hold releaseHold(Integer holdId) {
        Hold hold = getHoldById(holdId);
        hold.setHoldStatus(Hold.HoldStatus.RELEASED);
        hold.setReleasedDate(LocalDateTime.now());

        // Restore student account status to ACTIVE
        Student student = hold.getStudent();
        student.setAccountStatus(Student.AccountStatus.ACTIVE);
        studentRepository.save(student);

        return holdRepository.save(hold);
    }

    // ── DELETE ─────────────────────────────────────────────
    public void deleteHold(Integer holdId) {
        if (!holdRepository.existsById(holdId)) {
            throw new RuntimeException("Hold not found with ID: " + holdId);
        }
        holdRepository.deleteById(holdId);
    }
}
