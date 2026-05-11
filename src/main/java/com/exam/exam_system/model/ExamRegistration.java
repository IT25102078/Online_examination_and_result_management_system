package com.exam.exam_system.model;

import jakarta.persistence.*;
import lombok.*;
import java.time.LocalDateTime;

@Entity
@Table(name = "exam_registrations")
@Getter @Setter @NoArgsConstructor @AllArgsConstructor
public class ExamRegistration {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "registration_id")
    private Integer registrationId;

    // ── OOP: Association — ManyToOne relationships ─────────
    @ManyToOne
    @JoinColumn(name = "student_id", nullable = false)
    private Student student;

    @ManyToOne
    @JoinColumn(name = "exam_id", nullable = false)
    private Exam exam;

    @Column(name = "registered_date", nullable = false, updatable = false)
    private LocalDateTime registeredDate = LocalDateTime.now();

    @Enumerated(EnumType.STRING)
    @Column(name = "approval_status", nullable = false)
    private ApprovalStatus approvalStatus = ApprovalStatus.PENDING;

    @ManyToOne
    @JoinColumn(name = "approved_by")
    private Admin approvedBy;

    @Column(name = "approved_date")
    private LocalDateTime approvedDate;

    @Column(name = "remarks", length = 255)
    private String remarks;

    // ── OOP: Enum ──────────────────────────────────────────
    public enum ApprovalStatus { PENDING, APPROVED, REJECTED }

    // ── OOP: Business methods — Polymorphism ───────────────
    public boolean isPending() {
        return this.approvalStatus == ApprovalStatus.PENDING;
    }

    public boolean isApproved() {
        return this.approvalStatus == ApprovalStatus.APPROVED;
    }

    @Override
    public String toString() {
        return "ExamRegistration[" + student.getFullName()
                + " -> " + exam.getExamName()
                + " | " + approvalStatus + "]";
    }
}
