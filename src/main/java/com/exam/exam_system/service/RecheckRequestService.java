package com.exam.exam_system.service;

import com.exam.exam_system.model.*;
import com.exam.exam_system.model.RecheckRequest.RequestStatus;
import com.exam.exam_system.repository.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.util.List;

// ── OOP: Abstraction — all logic hidden from controller ───
@Service
public class RecheckRequestService {

    @Autowired
    private RecheckRequestRepository recheckRequestRepository;

    @Autowired
    private StudentRepository studentRepository;

    @Autowired
    private ExamRepository examRepository;

    @Autowired
    private ResultRepository resultRepository;

    @Autowired
    private ExaminerRepository examinerRepository;

    @Autowired
    private AdminRepository adminRepository;

    // ── CREATE: Student submits recheck request ────────────
    public RecheckRequest submitRequest(Integer studentId,
                                        Integer examId,
                                        Integer resultId,
                                        String reason,
                                        String description) {

        if (recheckRequestRepository
                .existsByStudent_StudentIdAndResult_ResultId(
                        studentId, resultId)) {
            throw new RuntimeException(
                    "You have already submitted a recheck request " +
                            "for this result.");
        }

        Student student = studentRepository.findById(studentId)
                .orElseThrow(() -> new RuntimeException(
                        "Student not found."));
        Exam exam = examRepository.findById(examId)
                .orElseThrow(() -> new RuntimeException(
                        "Exam not found."));
        Result result = resultRepository.findById(resultId)
                .orElseThrow(() -> new RuntimeException(
                        "Result not found."));

        RecheckRequest request = new RecheckRequest();
        request.setStudent(student);
        request.setExam(exam);
        request.setResult(result);
        request.setRequestReason(reason);
        request.setRequestDescription(description);
        request.setRequestStatus(RequestStatus.PENDING);
        request.setSubmittedDate(LocalDateTime.now());

        return recheckRequestRepository.save(request);
    }

    // ── READ ALL (admin/examiner) ──────────────────────────
    public List<RecheckRequest> getAllRequests() {
        return recheckRequestRepository.findAll();
    }

    // ── READ by status ─────────────────────────────────────
    public List<RecheckRequest> getRequestsByStatus(
            RequestStatus status) {
        return recheckRequestRepository
                .findByRequestStatus(status);
    }

    // ── READ: Student views own requests ───────────────────
    public List<RecheckRequest> getRequestsByStudent(
            Integer studentId) {
        return recheckRequestRepository
                .findByStudent_StudentId(studentId);
    }

    // ── READ ONE ───────────────────────────────────────────
    public RecheckRequest getRequestById(Integer id) {
        return recheckRequestRepository.findById(id)
                .orElseThrow(() -> new RuntimeException(
                        "Recheck request not found with ID: " + id));
    }

    // ── UPDATE: Student edits before review ───────────────
    public RecheckRequest updateRequest(Integer requestId,
                                        String reason,
                                        String description) {
        RecheckRequest existing = getRequestById(requestId);

        if (!existing.isPending()) {
            throw new RuntimeException(
                    "Cannot edit a request that has already " +
                            "been reviewed.");
        }

        existing.setRequestReason(reason);
        existing.setRequestDescription(description);
        existing.setUpdatedAt(LocalDateTime.now());
        return recheckRequestRepository.save(existing);
    }

    // ── UPDATE: Examiner reviews request ──────────────────
    public RecheckRequest reviewByExaminer(Integer requestId,
                                           Integer examinerId,
                                           String status,
                                           String comment) {
        RecheckRequest request = getRequestById(requestId);
        Examiner examiner = examinerRepository.findById(examinerId)
                .orElseThrow(() -> new RuntimeException(
                        "Examiner not found."));

        request.setRequestStatus(
                RequestStatus.valueOf(status));
        request.setReviewedByExaminer(examiner);
        request.setReviewedDate(LocalDateTime.now());
        request.setReviewComment(comment);
        request.setUpdatedAt(LocalDateTime.now());
        return recheckRequestRepository.save(request);
    }

    // ── UPDATE: Admin reviews request ─────────────────────
    public RecheckRequest reviewByAdmin(Integer requestId,
                                        Integer adminId,
                                        String status,
                                        String comment) {
        RecheckRequest request = getRequestById(requestId);
        Admin admin = adminRepository.findById(adminId)
                .orElseThrow(() -> new RuntimeException(
                        "Admin not found."));

        request.setRequestStatus(
                RequestStatus.valueOf(status));
        request.setReviewedByAdmin(admin);
        request.setReviewedDate(LocalDateTime.now());
        request.setReviewComment(comment);
        request.setUpdatedAt(LocalDateTime.now());
        return recheckRequestRepository.save(request);
    }

    // ── DELETE ────────────────────────────────────────────
    public void deleteRequest(Integer requestId) {
        RecheckRequest request = getRequestById(requestId);
        if (!request.isPending()) {
            throw new RuntimeException(
                    "Cannot delete a request that has already " +
                            "been reviewed.");
        }
        recheckRequestRepository.deleteById(requestId);
    }

    // ── DELETE (admin force delete) ────────────────────────
    public void forceDeleteRequest(Integer requestId) {
        if (!recheckRequestRepository.existsById(requestId)) {
            throw new RuntimeException(
                    "Recheck request not found.");
        }
        recheckRequestRepository.deleteById(requestId);
    }
}