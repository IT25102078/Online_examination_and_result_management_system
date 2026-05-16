package com.exam.exam_system.service;

import com.exam.exam_system.model.*;
import com.exam.exam_system.repository.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.util.List;

// ── OOP: Abstraction — hides allocation logic from controller
@Service
public class ExaminerAllocationService {

    @Autowired
    private ExaminerAllocationRepository allocationRepository;

    @Autowired
    private ExaminerRepository examinerRepository;

    @Autowired
    private ExamRepository examRepository;

    @Autowired
    private AdminRepository adminRepository;

    // ── CREATE: Allocate examiner to exam ──────────────────
    public ExaminerAllocation allocateExaminer(Integer examinerId,
                                               Integer examId,
                                               Integer adminId) {

        Examiner examiner = examinerRepository.findById(examinerId)
                .orElseThrow(() -> new RuntimeException(
                        "Examiner not found."));

        Exam exam = examRepository.findById(examId)
                .orElseThrow(() -> new RuntimeException(
                        "Exam not found."));

        Admin admin = adminRepository.findById(adminId)
                .orElseThrow(() -> new RuntimeException(
                        "Admin not found."));

        // Check duplicate allocation
        if (allocationRepository
                .existsByExaminer_ExaminerIdAndExam_ExamId(
                        examinerId, examId)) {
            throw new RuntimeException(
                    "This examiner is already allocated to this exam.");
        }

        // Check exam is not cancelled
        if (exam.getStatus() == Exam.ExamStatus.CANCELLED) {
            throw new RuntimeException(
                    "Cannot allocate examiner to a cancelled exam.");
        }

        ExaminerAllocation allocation = new ExaminerAllocation();
        allocation.setExaminer(examiner);
        allocation.setExam(exam);
        allocation.setAllocatedBy(admin);
        allocation.setAllocatedDate(LocalDateTime.now());

        return allocationRepository.save(allocation);
    }

    // ── READ ALL ───────────────────────────────────────────
    public List<ExaminerAllocation> getAllAllocations() {
        return allocationRepository.findAll();
    }

    // ── READ by exam ───────────────────────────────────────
    public List<ExaminerAllocation> getAllocationsByExam(Integer examId) {
        return allocationRepository.findByExam_ExamId(examId);
    }

    // ── READ by examiner ───────────────────────────────────
    public List<ExaminerAllocation> getAllocationsByExaminer(
            Integer examinerId) {
        return allocationRepository
                .findByExaminer_ExaminerId(examinerId);
    }

    // ── READ ONE ───────────────────────────────────────────
    public ExaminerAllocation getAllocationById(Integer id) {
        return allocationRepository.findById(id)
                .orElseThrow(() -> new RuntimeException(
                        "Allocation not found with ID: " + id));
    }

    // ── READ: Get examiners NOT yet allocated to an exam ──
    public List<Examiner> getAvailableExaminersForExam(Integer examId) {
        List<ExaminerAllocation> existing =
                allocationRepository.findByExam_ExamId(examId);

        List<Integer> allocatedIds = existing.stream()
                .map(a -> a.getExaminer().getExaminerId())
                .toList();

        return examinerRepository.findAll().stream()
                .filter(e -> !allocatedIds.contains(e.getExaminerId()))
                .filter(e -> e.getStatus()
                        == Examiner.ExaminerStatus.ACTIVE)
                .toList();
    }

    // ── DELETE: Remove allocation ──────────────────────────
    public void deleteAllocation(Integer id) {
        if (!allocationRepository.existsById(id)) {
            throw new RuntimeException(
                    "Allocation not found with ID: " + id);
        }
        allocationRepository.deleteById(id);
    }
}
