package com.exam.exam_system.examiner;

public class SeniorExaminer extends Examiner {

    @Override
    public String getExaminerType() {
        return "Senior Examiner";
    }

    public boolean canApproveResults() {
        return true;
    }
}
