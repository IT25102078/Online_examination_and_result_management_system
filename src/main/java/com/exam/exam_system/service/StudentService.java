package com.exam.exam_system.service;

import com.exam.exam_system.model.Student;
import com.exam.exam_system.repository.StudentRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

// ── OOP: Abstraction — hides DB logic from controller ────
@Service
public class StudentService {

    @Autowired
    private StudentRepository studentRepository;

    // CREATE
    public Student registerStudent(Student student) {
        if (studentRepository.existsByRegistrationNo(student.getRegistrationNo())) {
            throw new RuntimeException("Registration number already exists.");
        }
        if (studentRepository.existsByEmail(student.getEmail())) {
            throw new RuntimeException("Email already registered.");
        }
        return studentRepository.save(student);
    }

    // READ ALL
    public List<Student> getAllStudents() {
        return studentRepository.findAll();
    }

    // READ ONE
    public Student getStudentById(Integer id) {
        return studentRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Student not found with ID: " + id));
    }

    // SEARCH
    public List<Student> searchStudents(String name) {
        return studentRepository.findByFullNameContainingIgnoreCase(name);
    }

    // UPDATE
    public Student updateStudent(Integer id, Student updatedData) {
        Student existing = getStudentById(id);
        existing.setFullName(updatedData.getFullName());
        existing.setEmail(updatedData.getEmail());
        existing.setContactNo(updatedData.getContactNo());
        existing.setDepartment(updatedData.getDepartment());
        existing.setCourse(updatedData.getCourse());
        existing.setYearOfStudy(updatedData.getYearOfStudy());
        existing.setStudentType(updatedData.getStudentType());
        existing.setAccountStatus(updatedData.getAccountStatus());
        // ── password and createdAt are NOT updated here ────────
        return studentRepository.save(existing);
    }

    // DELETE
    public void deleteStudent(Integer id) {
        if (!studentRepository.existsById(id)) {
            throw new RuntimeException("Student not found with ID: " + id);
        }
        studentRepository.deleteById(id);
    }
}