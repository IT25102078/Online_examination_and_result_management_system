package com.exam.exam_system.repository;

import com.exam.exam_system.model.Hold;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface HoldRepository extends JpaRepository<Hold, Integer> {

    // All holds placed by an examiner
    List<Hold> findByExaminer_ExaminerId(Integer examinerId);

    // All holds for an exam
    List<Hold> findByExam_ExamId(Integer examId);

    // Filter by status
    List<Hold> findByHoldStatus(Hold.HoldStatus holdStatus);

    // Check if student is already on hold for this exam
    boolean existsByStudent_StudentIdAndExam_ExamIdAndHoldStatus(
            Integer studentId, Integer examId, Hold.HoldStatus holdStatus);
}
