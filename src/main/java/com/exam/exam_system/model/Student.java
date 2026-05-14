package com.exam.exam_system.model;

import jakarta.persistence.*;
import jakarta.validation.constraints.*;
import lombok.*;
import java.time.LocalDateTime;

@Entity
@Table(name = "students")
@Getter @Setter @NoArgsConstructor @AllArgsConstructor
public class Student {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "student_id")
    private Integer studentId;

    @NotBlank(message = "Registration number is required")
    @Column(name = "registration_no", unique = true, nullable = false, length = 50)
    private String registrationNo;

    @NotBlank(message = "Full name is required")
    @Column(name = "full_name", nullable = false, length = 200)
    private String fullName;

    @NotBlank(message = "Email is required")
    @Email(message = "Enter a valid email")
    @Column(name = "email", unique = true, nullable = false, length = 150)
    private String email;

    @Column(name = "contact_no", length = 20)
    private String contactNo;

    @Column(name = "department", length = 100)
    private String department;

    @Column(name = "course", length = 100)
    private String course;

    @Column(name = "year_of_study")
    private Integer yearOfStudy;

    @Enumerated(EnumType.STRING)
    @Column(name = "student_type", nullable = false)
    private StudentType studentType = StudentType.REGULAR;

    @NotBlank(message = "Password is required")
    @Column(name = "password", nullable = false, length = 255)
    private String password;

    @Enumerated(EnumType.STRING)
    @Column(name = "account_status", nullable = false)
    private AccountStatus accountStatus = AccountStatus.ACTIVE;

    @Column(name = "created_at", nullable = false, updatable = false)
    private LocalDateTime createdAt = LocalDateTime.now();

    // ── OOP: Enums as inner types ──────────────────────────
    public enum StudentType { REGULAR, REPEAT }
    public enum AccountStatus { ACTIVE, INACTIVE, HELD }

    // ── OOP: Polymorphism — overriding toString ────────────
    @Override
    public String toString() {
        return "Student[" + registrationNo + " - " + fullName + "]";
    }

    // ── OOP: Business method on model ─────────────────────
    public boolean isActive() {
        return this.accountStatus == AccountStatus.ACTIVE;
    }
}