package com.exam.exam_system.model;

import jakarta.persistence.*;
import jakarta.validation.constraints.*;
import lombok.*;
import java.math.BigDecimal;
import java.time.LocalDateTime;

@Entity
@Table(name = "results")
@Getter @Setter @NoArgsConstructor @AllArgsConstructor
public class Result {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "result_id")
    private Integer resultId;

    @ManyToOne
    @JoinColumn(name = "student_id", nullable = false)
    private Student student;

    @ManyToOne
    @JoinColumn(name = "exam_id", nullable = false)
    private Exam exam;

    @ManyToOne
    @JoinColumn(name = "examiner_id")
    private Examiner examiner;

    @NotNull(message = "Marks obtained is required")
    @DecimalMin(value = "0.0", message = "Marks cannot be negative")
    @DecimalMax(value = "100.0", message = "Marks cannot exceed 100")
    @Column(name = "marks_obtained", nullable = false, precision = 5, scale = 2)
    private BigDecimal marksObtained;

    @Column(name = "grade", nullable = false, length = 10)
    private String grade;

    @Enumerated(EnumType.STRING)
    @Column(name = "result_status", nullable = false)
    private ResultStatus resultStatus = ResultStatus.PENDING;

    @Column(name = "published_date", nullable = false)
    private LocalDateTime publishedDate = LocalDateTime.now();

    @Column(name = "updated_at")
    private LocalDateTime updatedAt = LocalDateTime.now();

    // ── OOP: Enum ──────────────────────────────────────────
    public enum ResultStatus { PASS, FAIL, PENDING }

    // ── OOP: Business method — auto calculate grade ────────
    public void calculateGradeAndStatus(BigDecimal passMarks) {
        double marks = marksObtained.doubleValue();

        if (marks >= 75) this.grade = "A";
        else if (marks >= 65) this.grade = "B";
        else if (marks >= 55) this.grade = "C";
        else if (marks >= 45) this.grade = "S";
        else this.grade = "F";

        this.resultStatus = marks >= passMarks.doubleValue()
                ? ResultStatus.PASS
                : ResultStatus.FAIL;

        this.updatedAt = LocalDateTime.now();
    }

    // ── OOP: Polymorphism — toString ───────────────────────
    @Override
    public String toString() {
        return "Result[" + student.getFullName()
                + " | " + exam.getExamName()
                + " | " + marksObtained + " | " + grade + "]";
    }
}
