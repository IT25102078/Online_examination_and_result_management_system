package com.exam.exam_system.model;

import lombok.*;
import java.math.BigDecimal;
import java.time.LocalDateTime;

@Getter @Setter @NoArgsConstructor @AllArgsConstructor
public class ResultView {

    private String examCode;
    private String examName;
    private String subjectName;
    private String examDate;
    private BigDecimal marksObtained;
    private BigDecimal totalMarks;
    private BigDecimal passMarks;
    private String grade;
    private String resultStatus;
    private String publishedDate;
    private String examinerName;
    private Integer examId;
    private Integer resultId;

    // ── OOP: Polymorphism — format result for display ──────
    public String getFormattedResult() {
        return examName + " | " + marksObtained + "/" + totalMarks
                + " | Grade: " + grade + " | " + resultStatus;
    }

    // ── OOP: Business method ───────────────────────────────
    public boolean isPassed() {
        return "PASS".equals(resultStatus);
    }

    // ── OOP: Polymorphism — toString ───────────────────────
    @Override
    public String toString() {
        return "ResultView[" + examName + " | " + grade
                + " | " + resultStatus + "]";
    }
}
