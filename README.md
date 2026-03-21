# 📘 Online Examination and Result Management System

A web-based Java (Spring Boot / JSP Servlet) application developed for managing the full lifecycle of examinations using Object-Oriented Programming (OOP) principles.

---

## 🚀 Project Overview

This system automates the examination process by allowing:
- Students to register and view results  
- Admins to manage exams, students, and examiners  
- Examiners to evaluate students and submit results  

---

## 🧩 System Features

### 👨‍🎓 Student Dashboard
- Register for exams  
- Check registration status  
- View results  
- Manage student profile  

### 🛠️ Admin Dashboard
- Approve student registrations  
- Create and manage exams  
- Register examiners  
- Allocate examiners to exams  

### 🧑‍🏫 Examiner Dashboard
- Add marks for students  
- Calculate grades  
- Hold students (cheating/misconduct)  

---

## 🔗 System Relationships

- Student → registers → Exam  
- Admin → approves → Registration  
- Admin → creates → Exam  
- Admin → allocates → Examiner  
- Examiner → enters → Result  
- Exam → contains → Results  

---

## 🗄️ Database Tables

- students
- admins
- examiners
- exams
- registrations
- examiner_allocations
- results
- holds

---

## 🧠 OOP Concepts Used

- Encapsulation  
- Inheritance  
- Polymorphism  
- Abstraction  

---

## 🖥️ Tech Stack

- Java (Spring Boot / JSP Servlet)  
- HTML, CSS, Bootstrap  
- MySQL  
- IntelliJ IDEA  
- Git & GitHub  

---

## 🔄 Workflow

1. Student registers for exam  
2. Admin approves registration  
3. Admin creates exams  
4. Examiner adds marks  
5. Results are published  
6. Student views results   

