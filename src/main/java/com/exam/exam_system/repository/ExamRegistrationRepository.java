package com.exam.exam_system.repository;

import com.exam.exam_system.model.ExamRegistration;
import com.exam.exam_system.model.ExamRegistration.ApprovalStatus;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface ExamRegistrationRepository extends JpaRepository<ExamRegistration, Integer> {

    // All registrations for a student
    List<ExamRegistration> findByStudent_StudentId(Integer studentId);

    // All registrations for an exam
    List<ExamRegistration> findByExam_ExamId(Integer examId);

    // Filter by status (admin views pending/approved/rejected)
    List<ExamRegistration> findByApprovalStatus(ApprovalStatus status);

    // Check if student already registered for this exam
    boolean existsByStudent_StudentIdAndExam_ExamId(Integer studentId, Integer examId);

    // Get specific registration for student + exam
    Optional<ExamRegistration> findByStudent_StudentIdAndExam_ExamId(
            Integer studentId, Integer examId);

    // Get approved registrations for an exam (used by examiner later)
    List<ExamRegistration> findByExam_ExamIdAndApprovalStatus(
            Integer examId, ApprovalStatus status);

    // Get approved registrations for exam where result doesn't exist yet
    @Query("SELECT er FROM ExamRegistration er WHERE er.exam.examId = :examId " +
            "AND er.approvalStatus = 'APPROVED' " +
            "AND NOT EXISTS (SELECT r FROM Result r WHERE r.student = er.student " +
            "AND r.exam = er.exam)")
    List<ExamRegistration> findApprovedStudentsWithoutResults(
            @Param("examId") Integer examId);
}
