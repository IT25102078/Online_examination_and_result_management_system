package com.exam.exam_system.repository;

import com.exam.exam_system.model.Examiner;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface ExaminerRepository extends JpaRepository<Examiner, Integer> {

    Optional<Examiner> findByEmail(String email);
    Optional<Examiner> findByUsername(String username);

    List<Examiner> findByFullNameContainingIgnoreCase(String name);

    boolean existsByEmail(String email);
    boolean existsByUsername(String username);
}