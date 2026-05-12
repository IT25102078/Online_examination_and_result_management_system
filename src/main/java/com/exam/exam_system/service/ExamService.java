package com.exam.exam_system.service;

import com.exam.exam_system.model.Exam;
import com.exam.exam_system.repository.ExamRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

// ── OOP: Abstraction — hides all DB logic from controller ─
@Service
public class ExamService {

    @Autowired
    private ExamRepository examRepository;

    // CREATE
    public Exam addExam(Exam exam) {
        if (examRepository.existsByExamCode(exam.getExamCode())) {
            throw new RuntimeException("Exam code already exists.");
        }
        return examRepository.save(exam);
    }

    // READ ALL
    public List<Exam> getAllExams() {
        return examRepository.findAll();
    }

    // READ ONE
    public Exam getExamById(Integer id) {
        return examRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Exam not found with ID: " + id));
    }

    // SEARCH by name
    public List<Exam> searchExams(String keyword) {
        return examRepository
                .findByExamNameContainingIgnoreCaseOrSubjectNameContainingIgnoreCase(
                        keyword, keyword);
    }

    // FILTER by status
    public List<Exam> getExamsByStatus(Exam.ExamStatus status) {
        return examRepository.findByStatus(status);
    }

    // UPDATE
    public Exam updateExam(Integer id, Exam updatedData) {
        Exam existing = getExamById(id);
        existing.setExamName(updatedData.getExamName());
        existing.setSubjectName(updatedData.getSubjectName());
        existing.setExamDate(updatedData.getExamDate());
        existing.setExamTime(updatedData.getExamTime());
        existing.setDurationMinutes(updatedData.getDurationMinutes());
        existing.setTotalMarks(updatedData.getTotalMarks());
        existing.setPassMarks(updatedData.getPassMarks());
        existing.setStatus(updatedData.getStatus());
        // ── createdBy and createdAt are NOT updated ────────────
        return examRepository.save(existing);
    }

    // DELETE
    public void deleteExam(Integer id) {
        if (!examRepository.existsById(id)) {
            throw new RuntimeException("Exam not found with ID: " + id);
        }
        examRepository.deleteById(id);
    }
}
