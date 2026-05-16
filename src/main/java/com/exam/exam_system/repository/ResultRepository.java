package com.exam.exam_system.repository;

import com.exam.exam_system.model.Result;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface ResultRepository extends JpaRepository<Result, Integer> {

    // All results for a student (used in Component 06)
    List<Result> findByStudent_StudentId(Integer studentId);

    // All results for an exam
    List<Result> findByExam_ExamId(Integer examId);

    // All results entered by an examiner
    List<Result> findByExaminer_ExaminerId(Integer examinerId);

    // Check if result already exists for student + exam
    boolean existsByStudent_StudentIdAndExam_ExamId(
            Integer studentId, Integer examId);

    // Get specific result
    Optional<Result> findByStudent_StudentIdAndExam_ExamId(
            Integer studentId, Integer examId);
}
