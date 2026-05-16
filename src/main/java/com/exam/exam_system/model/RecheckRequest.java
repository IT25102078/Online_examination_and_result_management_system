package com.exam.exam_system.model;

import jakarta.persistence.*;
import jakarta.validation.constraints.*;
import lombok.*;
import java.time.LocalDateTime;

@Entity
@Table(name = "recheck_requests")
@Getter @Setter @NoArgsConstructor @AllArgsConstructor
public class RecheckRequest {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "request_id")
    private Integer requestId;

    // ── OOP: Association — links Student, Exam, Result ────
    @ManyToOne
    @JoinColumn(name = "student_id", nullable = false)
    private Student student;

    @ManyToOne
    @JoinColumn(name = "exam_id", nullable = false)
    private Exam exam;

    @ManyToOne
    @JoinColumn(name = "result_id", nullable = false)
    private Result result;

    @NotBlank(message = "Request reason is required")
    @Column(name = "request_reason", nullable = false, length = 255)
    private String requestReason;

    @Column(name = "request_description", columnDefinition = "TEXT")
    private String requestDescription;

    @Enumerated(EnumType.STRING)
    @Column(name = "request_status", nullable = false)
    private RequestStatus requestStatus = RequestStatus.PENDING;

    @Column(name = "submitted_date", nullable = false, updatable = false)
    private LocalDateTime submittedDate = LocalDateTime.now();

    // ── Reviewed by Examiner or Admin ─────────────────────
    @ManyToOne
    @JoinColumn(name = "reviewed_by_examiner")
    private Examiner reviewedByExaminer;

    @ManyToOne
    @JoinColumn(name = "reviewed_by_admin")
    private Admin reviewedByAdmin;

    @Column(name = "reviewed_date")
    private LocalDateTime reviewedDate;

    @Column(name = "review_comment", length = 255)
    private String reviewComment;

    @Column(name = "updated_at")
    private LocalDateTime updatedAt = LocalDateTime.now();

    // ── OOP: Enum ──────────────────────────────────────────
    public enum RequestStatus {
        PENDING, APPROVED, REJECTED, REVIEWED
    }

    // ── OOP: Business methods — Polymorphism ───────────────
    public boolean isPending() {
        return this.requestStatus == RequestStatus.PENDING;
    }

    public boolean isReviewed() {
        return this.requestStatus == RequestStatus.REVIEWED
                || this.requestStatus == RequestStatus.APPROVED
                || this.requestStatus == RequestStatus.REJECTED;
    }

    // ── OOP: Polymorphism — toString ───────────────────────
    @Override
    public String toString() {
        return "RecheckRequest["
                + student.getFullName()
                + " | " + exam.getExamName()
                + " | " + requestStatus + "]";
    }
}