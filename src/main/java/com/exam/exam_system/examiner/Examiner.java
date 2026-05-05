package com.exam.exam_system.examiner;

public class Examiner {

    private int examinerId;
    private String fullName;
    private String email;
    private String phone;
    private String specialization;
    private String username;
    private String password;
    private String status;

    // Default constructor
    public Examiner() {}

    // Getters
    public int getExaminerId()        { return examinerId; }
    public String getFullName()       { return fullName; }
    public String getEmail()          { return email; }
    public String getPhone()          { return phone; }
    public String getSpecialization() { return specialization; }
    public String getUsername()       { return username; }
    public String getPassword()       { return password; }
    public String getStatus()         { return status; }

    // Setters
    public void setExaminerId(int examinerId)           { this.examinerId = examinerId; }
    public void setFullName(String fullName)             { this.fullName = fullName; }
    public void setEmail(String email)                   { this.email = email; }
    public void setPhone(String phone)                   { this.phone = phone; }
    public void setSpecialization(String specialization) { this.specialization = specialization; }
    public void setUsername(String username)             { this.username = username; }
    public void setPassword(String password)             { this.password = password; }
    public void setStatus(String status)                 { this.status = status; }

    // OOP: Polymorphism — overridden in subclasses
    public String getExaminerType() {
        return "Examiner";
    }
}
