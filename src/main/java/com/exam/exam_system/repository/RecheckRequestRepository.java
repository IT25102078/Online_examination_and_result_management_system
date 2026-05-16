package com.exam.exam_system.repository;

import com.exam.exam_system.model.RecheckRequest;
import com.exam.exam_system.model.RecheckRequest.RequestStatus;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface RecheckRequestRepository
        extends JpaRepository<RecheckRequest, Integer> {

    // Student views own requests
    List<RecheckRequest> findByStudent_StudentId(Integer studentId);

    // Admin/Examiner views all by status
    List<RecheckRequest> findByRequestStatus(RequestStatus status);

    // All requests for an exam
    List<RecheckRequest> findByExam_ExamId(Integer examId);

    // Find all recheck requests for a specific result
    // Used before deleting a result to remove dependent records
    List<RecheckRequest> findByResult_ResultId(Integer resultId);

    // Check duplicate — student can only submit one
    // recheck per result
    boolean existsByStudent_StudentIdAndResult_ResultId(
            Integer studentId, Integer resultId);

    // Get specific request for student + result
    Optional<RecheckRequest> findByStudent_StudentIdAndResult_ResultId(
            Integer studentId, Integer resultId);
}