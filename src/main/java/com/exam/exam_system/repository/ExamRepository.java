package com.example.exammanagementsystem.repository;

import com.example.exammanagementsystem.model.Exam;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface ExamRepository extends JpaRepository<Exam, Long> {
    // This interface helps to perform Database operations like Save, Delete, Find
}
