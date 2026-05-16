package com.exam.exam_system.model;

import jakarta.persistence.*;
import jakarta.validation.constraints.*;
import lombok.*;
import java.time.LocalDateTime;

@Entity
@Table(name = "holds")
@Getter @Setter @NoArgsConstructor @AllArgsConstructor
public class Hold {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "hold_id")
    private Integer holdId;

    @ManyToOne
    @JoinColumn(name = "student_id", nullable = false)
    private Student student;

    @ManyToOne
    @JoinColumn(name = "exam_id", nullable = false)
    private Exam exam;

    @ManyToOne
    @JoinColumn(name = "examiner_id")
    private Examiner examiner;

    @NotBlank(message = "Reason is required")
    @Column(name = "reason", nullable = false, length = 255)
    private String reason;

    @Enumerated(EnumType.STRING)
    @Column(name = "hold_status", nullable = false)
    private HoldStatus holdStatus = HoldStatus.ACTIVE;

    @Column(name = "hold_date", nullable = false, updatable = false)
    private LocalDateTime holdDate = LocalDateTime.now();

    @Column(name = "released_date")
    private LocalDateTime releasedDate;

    // ── OOP: Enum ──────────────────────────────────────────
    public enum HoldStatus { ACTIVE, RELEASED }

    // ── OOP: Business method ───────────────────────────────
    public boolean isActive() {
        return this.holdStatus == HoldStatus.ACTIVE;
    }

    @Override
    public String toString() {
        return "Hold[" + student.getFullName()
                + " | " + exam.getExamName()
                + " | " + holdStatus + "]";
    }
}
