package com.exam.exam_system.repository;

import com.exam.exam_system.model.Student;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface StudentRepository extends JpaRepository<Student, Integer> {

    // Find by registration number
    Optional<Student> findByRegistrationNo(String registrationNo);

    // Find by email (used for login later)
    Optional<Student> findByEmail(String email);

    // Search by name (partial match)
    List<Student> findByFullNameContainingIgnoreCase(String name);

    // Check duplicates
    boolean existsByRegistrationNo(String registrationNo);
    boolean existsByEmail(String email);
}