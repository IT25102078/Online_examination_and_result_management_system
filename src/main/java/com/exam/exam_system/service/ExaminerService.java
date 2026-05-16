package com.exam.exam_system.service;

import com.exam.exam_system.model.Examiner;
import com.exam.exam_system.repository.ExaminerRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

// ── OOP: Abstraction — hides DB logic from controller ────
@Service
public class ExaminerService {

    @Autowired
    private ExaminerRepository examinerRepository;

    // CREATE
    public Examiner addExaminer(Examiner examiner) {
        if (examinerRepository.existsByEmail(examiner.getEmail())) {
            throw new RuntimeException("Email already registered.");
        }
        if (examinerRepository.existsByUsername(examiner.getUsername())) {
            throw new RuntimeException("Username already taken.");
        }
        return examinerRepository.save(examiner);
    }

    // READ ALL
    public List<Examiner> getAllExaminers() {
        return examinerRepository.findAll();
    }

    // READ ONE
    public Examiner getExaminerById(Integer id) {
        return examinerRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Examiner not found with ID: " + id));
    }

    // SEARCH
    public List<Examiner> searchExaminers(String name) {
        return examinerRepository.findByFullNameContainingIgnoreCase(name);
    }

    // UPDATE
    public Examiner updateExaminer(Integer id, Examiner updatedData) {
        Examiner existing = getExaminerById(id);
        existing.setFullName(updatedData.getFullName());
        existing.setEmail(updatedData.getEmail());
        existing.setPhone(updatedData.getPhone());
        existing.setDepartment(updatedData.getDepartment());
        existing.setSpecialization(updatedData.getSpecialization());
        existing.setExaminerType(updatedData.getExaminerType());
        existing.setStatus(updatedData.getStatus());
        // ── password and createdAt are NOT updated here ────────
        return examinerRepository.save(existing);
    }

    // DELETE
    public void deleteExaminer(Integer id) {
        if (!examinerRepository.existsById(id)) {
            throw new RuntimeException("Examiner not found with ID: " + id);
        }
        examinerRepository.deleteById(id);
    }
}