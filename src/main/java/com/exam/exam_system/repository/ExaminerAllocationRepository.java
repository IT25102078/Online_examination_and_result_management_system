package com.exam.exam_system.repository;

import com.exam.exam_system.model.ExaminerAllocation;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface ExaminerAllocationRepository
        extends JpaRepository<ExaminerAllocation, Integer> {

    // All allocations for an exam
    List<ExaminerAllocation> findByExam_ExamId(Integer examId);

    // All allocations for an examiner
    List<ExaminerAllocation> findByExaminer_ExaminerId(Integer examinerId);

    // Check if examiner already allocated to this exam
    boolean existsByExaminer_ExaminerIdAndExam_ExamId(
            Integer examinerId, Integer examId);
}
