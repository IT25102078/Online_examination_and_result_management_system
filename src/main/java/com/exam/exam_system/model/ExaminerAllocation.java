package com.exam.exam_system.model;

import jakarta.persistence.*;
import lombok.*;
import java.time.LocalDateTime;

@Entity
@Table(name = "examiner_allocations")
@Getter @Setter @NoArgsConstructor @AllArgsConstructor
public class ExaminerAllocation {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "allocation_id")
    private Integer allocationId;

    // ── OOP: Association — ManyToOne relationships ─────────
    @ManyToOne
    @JoinColumn(name = "examiner_id", nullable = false)
    private Examiner examiner;

    @ManyToOne
    @JoinColumn(name = "exam_id", nullable = false)
    private Exam exam;

    @ManyToOne
    @JoinColumn(name = "allocated_by")
    private Admin allocatedBy;

    @Column(name = "allocated_date", nullable = false, updatable = false)
    private LocalDateTime allocatedDate = LocalDateTime.now();

    // ── OOP: Polymorphism — toString ───────────────────────
    @Override
    public String toString() {
        return "ExaminerAllocation["
                + examiner.getFullName()
                + " -> "
                + exam.getExamName()
                + "]";
    }
}
