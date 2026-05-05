package com.exam.exam_system.examiner;

public class AssistantExaminer extends Examiner {

    @Override
    public String getExaminerType() {
        return "Assistant Examiner";
    }

    public boolean canApproveResults() {
        return false;
    }
}
