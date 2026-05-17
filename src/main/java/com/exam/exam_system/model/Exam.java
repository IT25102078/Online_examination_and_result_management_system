package com.exam.exam_system.model;

import jakarta.persistence.*;
import jakarta.validation.constraints.*;
import lombok.*;
import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.LocalTime;
//test commit
@Entity
@Table(name = "exams")
@Getter @Setter @NoArgsConstructor @AllArgsConstructor
public class Exam {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "exam_id")
    private Integer examId;

    @NotBlank(message = "Exam code is required")
    @Column(name = "exam_code", unique = true, nullable = false, length = 50)
    private String examCode;

    @NotBlank(message = "Exam name is required")
    @Column(name = "exam_name", nullable = false, length = 150)
    private String examName;

    @NotBlank(message = "Subject name is required")
    @Column(name = "subject_name", nullable = false, length = 150)
    private String subjectName;

    @NotNull(message = "Exam date is required")
    @Column(name = "exam_date", nullable = false)
    private LocalDate examDate;

    @NotNull(message = "Exam time is required")
    @Column(name = "exam_time", nullable = false)
    private LocalTime examTime;

    @NotNull(message = "Duration is required")
    @Min(value = 1, message = "Duration must be at least 1 minute")
    @Column(name = "duration_minutes", nullable = false)
    private Integer durationMinutes;

    @NotNull(message = "Total marks is required")
    @Column(name = "total_marks", nullable = false, precision = 5, scale = 2)
    private BigDecimal totalMarks = BigDecimal.valueOf(100.00);

    @NotNull(message = "Pass marks is required")
    @Column(name = "pass_marks", nullable = false, precision = 5, scale = 2)
    private BigDecimal passMarks = BigDecimal.valueOf(50.00);

    @Enumerated(EnumType.STRING)
    @Column(name = "status", nullable = false)
    private ExamStatus status = ExamStatus.ACTIVE;

    @ManyToOne
    @JoinColumn(name = "created_by", referencedColumnName = "admin_id")
    private Admin createdBy;

    @Column(name = "created_at", nullable = false, updatable = false)
    private LocalDateTime createdAt = LocalDateTime.now();

    // ── OOP: Enum ──────────────────────────────────────────
    public enum ExamStatus { ACTIVE, CANCELLED, COMPLETED }

    // ── OOP: Business method ───────────────────────────────
    public boolean isActive() {
        return this.status == ExamStatus.ACTIVE;
    }

    // ── OOP: Polymorphism — toString ───────────────────────
    @Override
    public String toString() {
        return "Exam[" + examCode + " - " + examName + "]";
    }
}
