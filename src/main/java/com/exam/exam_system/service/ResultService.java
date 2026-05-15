package com.exam.exam_system.service;

import com.exam.exam_system.model.*;
import com.exam.exam_system.repository.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.exam.exam_system.repository.RecheckRequestRepository;

import java.time.LocalDateTime;
import java.util.List;

@Service
public class ResultService {

    @Autowired
    private ResultRepository resultRepository;

    @Autowired
    private StudentRepository studentRepository;

    @Autowired
    private ExamRepository examRepository;

    @Autowired
    private ExaminerRepository examinerRepository;

    @Autowired
    private ExamRegistrationService examRegistrationService;

    @Autowired
    private ExaminerPermissionService examinerPermissionService;

    @Autowired
    private RecheckRequestRepository recheckRequestRepository;

    // ── CREATE: Add marks ──────────────────────────────────
    public Result addResult(Integer studentId, Integer examId,
                            Integer examinerId, Result result) {

        Examiner examiner = examinerRepository.findById(examinerId)
                .orElseThrow(() -> new RuntimeException("Examiner not found."));

        // ── OOP: Permission check ──────────────────────────
        if (!examinerPermissionService.canAddMarks(examiner)) {
            throw new RuntimeException("You do not have permission to add marks.");
        }

        // ── Business Rule: must be approved registration ───
        if (!examRegistrationService.canAddMarks(studentId, examId)) {
            throw new RuntimeException(
                    "Cannot add marks. Student does not have an " +
                            "APPROVED registration for this exam.");
        }

        if (resultRepository.existsByStudent_StudentIdAndExam_ExamId(
                studentId, examId)) {
            throw new RuntimeException(
                    "Result already exists for this student and exam.");
        }

        Student student = studentRepository.findById(studentId)
                .orElseThrow(() -> new RuntimeException("Student not found."));
        Exam exam = examRepository.findById(examId)
                .orElseThrow(() -> new RuntimeException("Exam not found."));

        result.setStudent(student);
        result.setExam(exam);
        result.setExaminer(examiner);
        result.setPublishedDate(LocalDateTime.now());

        // ── OOP: Business method calculates grade/status ───
        result.calculateGradeAndStatus(exam.getPassMarks());

        return resultRepository.save(result);
    }

    // ── READ ALL for an exam ───────────────────────────────
    public List<Result> getResultsByExam(Integer examId) {
        return resultRepository.findByExam_ExamId(examId);
    }

    // ── READ by examiner ───────────────────────────────────
    public List<Result> getResultsByExaminer(Integer examinerId) {
        return resultRepository.findByExaminer_ExaminerId(examinerId);
    }

    // ── READ ONE ───────────────────────────────────────────
    public Result getResultById(Integer id) {
        return resultRepository.findById(id)
                .orElseThrow(() -> new RuntimeException(
                        "Result not found with ID: " + id));
    }

    // ── UPDATE ─────────────────────────────────────────────
    public Result updateResult(Integer resultId, Integer examinerId,
                               Result updatedData) {

        Examiner examiner = examinerRepository.findById(examinerId)
                .orElseThrow(() -> new RuntimeException("Examiner not found."));

        if (!examinerPermissionService.canAddMarks(examiner)) {
            throw new RuntimeException(
                    "You do not have permission to update marks.");
        }

        Result existing = getResultById(resultId);
        existing.setMarksObtained(updatedData.getMarksObtained());
        existing.calculateGradeAndStatus(existing.getExam().getPassMarks());

        return resultRepository.save(existing);
    }

    // ── DELETE ─────────────────────────────────────────────
    public void deleteResult(Integer resultId) {
        if (!resultRepository.existsById(resultId)) {
            throw new RuntimeException(
                    "Result not found with ID: " + resultId);
        }

        List<com.exam.exam_system.model.RecheckRequest> recheckRequests =
                recheckRequestRepository
                        .findByResult_ResultId(resultId);

        if (!recheckRequests.isEmpty()) {
            recheckRequestRepository.deleteAll(recheckRequests);
        }

        resultRepository.deleteById(resultId);
    }
}
