package com.exam.exam_system.service;

import com.exam.exam_system.model.Examiner;
import com.exam.exam_system.model.Examiner.ExaminerType;
import org.springframework.stereotype.Service;

// ── OOP: Polymorphism — different behaviour by examiner type
@Service
public class ExaminerPermissionService {

    // Both SENIOR and ASSISTANT can add marks
    public boolean canAddMarks(Examiner examiner) {
        return examiner.getExaminerType() == ExaminerType.SENIOR
                || examiner.getExaminerType() == ExaminerType.ASSISTANT;
    }

    // ONLY SENIOR can hold students
    public boolean canHoldStudents(Examiner examiner) {
        return examiner.getExaminerType() == ExaminerType.SENIOR;
    }

    // Get role description for UI display
    public String getPrivileges(Examiner examiner) {
        if (examiner.getExaminerType() == ExaminerType.SENIOR) {
            return "Add Marks + Hold Students";
        } else {
            return "Add Marks Only";
        }
    }
}