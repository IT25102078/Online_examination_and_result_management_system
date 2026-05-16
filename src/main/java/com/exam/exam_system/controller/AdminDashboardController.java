package com.exam.exam_system.controller;

import com.exam.exam_system.service.*;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class AdminDashboardController {

    @Autowired
    private StudentService studentService;

    @Autowired
    private ExaminerService examinerService;

    @Autowired
    private ExamService examService;

    @Autowired
    private ExamRegistrationService examRegistrationService;

    @GetMapping("/admin/dashboard")
    public String adminDashboard(HttpSession session, Model model) {
        if (session.getAttribute("adminId") == null)
            return "redirect:/login";

        model.addAttribute("adminName",
                session.getAttribute("adminName"));
        model.addAttribute("totalStudents",
                studentService.getAllStudents().size());
        model.addAttribute("totalExaminers",
                examinerService.getAllExaminers().size());
        model.addAttribute("totalExams",
                examService.getAllExams().size());
        model.addAttribute("pendingRegistrations",
                examRegistrationService.getRegistrationsByStatus(
                        com.exam.exam_system.model.ExamRegistration
                                .ApprovalStatus.PENDING).size());

        return "dashboard/admin-dashboard";
    }

    @GetMapping("/student/dashboard")
    public String studentDashboard(HttpSession session, Model model) {
        if (session.getAttribute("studentId") == null)
            return "redirect:/login";

        model.addAttribute("studentName",
                session.getAttribute("studentName"));
        return "dashboard/student-dashboard";
    }
}