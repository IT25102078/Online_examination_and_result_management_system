package com.exam.exam_system.model;

import jakarta.persistence.*;
import jakarta.validation.constraints.*;
import lombok.*;
import java.time.LocalDateTime;

@Entity
@Table(name = "examiners")
@Getter @Setter @NoArgsConstructor @AllArgsConstructor
public class Examiner {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "examiner_id")
    private Integer examinerId;

    @NotBlank(message = "Full name is required")
    @Column(name = "full_name", nullable = false, length = 150)
    private String fullName;

    @NotBlank(message = "Email is required")
    @Email(message = "Enter a valid email")
    @Column(name = "email", unique = true, nullable = false, length = 150)
    private String email;

    @Column(name = "phone", length = 20)
    private String phone;

    @Column(name = "department", length = 100)
    private String department;

    @Column(name = "specialization", length = 150)
    private String specialization;

    @Enumerated(EnumType.STRING)
    @Column(name = "examiner_type", nullable = false)
    private ExaminerType examinerType = ExaminerType.ASSISTANT;

    @NotBlank(message = "Username is required")
    @Column(name = "username", unique = true, nullable = false, length = 100)
    private String username;

    @NotBlank(message = "Password is required")
    @Column(name = "password", nullable = false, length = 255)
    private String password;

    @Enumerated(EnumType.STRING)
    @Column(name = "status", nullable = false)
    private ExaminerStatus status = ExaminerStatus.ACTIVE;

    @Column(name = "created_at", nullable = false, updatable = false)
    private LocalDateTime createdAt = LocalDateTime.now();

    // ── OOP: Enums ─────────────────────────────────────────
    public enum ExaminerType { SENIOR, ASSISTANT }
    public enum ExaminerStatus { ACTIVE, INACTIVE }

    // ── OOP: Polymorphism — business method ────────────────
    public boolean isActive() {
        return this.status == ExaminerStatus.ACTIVE;
    }

    // ── OOP: Polymorphism — overriding toString ─────────────
    @Override
    public String toString() {
        return "Examiner[" + username + " - " + fullName + "]";
    }
}