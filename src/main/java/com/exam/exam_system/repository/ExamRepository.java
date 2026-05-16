package com.exam.exam_system.repository;

import com.exam.exam_system.model.Exam;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface ExamRepository extends JpaRepository<Exam, Integer> {

    // Search by exam name
    // Search by exam name OR subject name
    List<Exam> findByExamNameContainingIgnoreCaseOrSubjectNameContainingIgnoreCase(
            String examName, String subjectName);
    // Filter by status
    List<Exam> findByStatus(Exam.ExamStatus status);

    // Check duplicate exam code
    boolean existsByExamCode(String examCode);
}
