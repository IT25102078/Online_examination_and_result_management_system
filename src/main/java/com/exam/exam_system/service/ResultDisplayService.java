package com.exam.exam_system.service;

import com.exam.exam_system.model.Result;
import com.exam.exam_system.model.ResultView;
import com.exam.exam_system.repository.ResultRepository;
import com.exam.exam_system.repository.StudentRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import lombok.*;

import java.util.List;
import java.util.stream.Collectors;

// ── OOP: Abstraction — hides result formatting from controller
@Service
public class ResultDisplayService {

    @Autowired
    private ResultRepository resultRepository;

    @Autowired
    private StudentRepository studentRepository;

    // ── READ: Get all results for a student as ResultView ──
    public List<ResultView> getResultViewsForStudent(Integer studentId) {

        List<Result> results =
                resultRepository.findByStudent_StudentId(studentId);

        // ── OOP: Converts Result entity → ResultView ───────
        return results.stream()
                .map(this::convertToView)
                .collect(Collectors.toList());
    }

    // ── READ: Summary stats for student dashboard ──────────
    public StudentResultSummary getSummaryForStudent(Integer studentId) {

        List<Result> results =
                resultRepository.findByStudent_StudentId(studentId);

        long total   = results.size();
        long passed  = results.stream()
                .filter(r -> r.getResultStatus() == Result.ResultStatus.PASS)
                .count();
        long failed  = results.stream()
                .filter(r -> r.getResultStatus() == Result.ResultStatus.FAIL)
                .count();
        long pending = results.stream()
                .filter(r -> r.getResultStatus() == Result.ResultStatus.PENDING)
                .count();

        return new StudentResultSummary(total, passed, failed, pending);
    }

    // ── OOP: Private helper — converts entity to view model ─
    private ResultView convertToView(Result result) {
        ResultView view = new ResultView();
        view.setExamId(result.getExam().getExamId());
        view.setResultId(result.getResultId());
        view.setExamCode(result.getExam().getExamCode());
        view.setExamName(result.getExam().getExamName());
        view.setSubjectName(result.getExam().getSubjectName());
        view.setExamDate(result.getExam().getExamDate().toString());
        view.setMarksObtained(result.getMarksObtained());
        view.setTotalMarks(result.getExam().getTotalMarks());
        view.setPassMarks(result.getExam().getPassMarks());
        view.setGrade(result.getGrade());
        view.setResultStatus(result.getResultStatus().name());
        view.setPublishedDate(result.getPublishedDate().toString());
        view.setExaminerName(
                result.getExaminer() != null
                        ? result.getExaminer().getFullName()
                        : "N/A");
        return view;
    }

    // ── OOP: Inner summary class — Encapsulation ───────────
    @Getter @Setter @AllArgsConstructor @NoArgsConstructor
    public static class StudentResultSummary {
        private long totalExams;
        private long passed;
        private long failed;
        private long pending;
    }
}
