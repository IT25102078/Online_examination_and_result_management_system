package com.exam.exam_system.controller;

import com.exam.exam_system.model.Admin;
import com.exam.exam_system.model.Examiner;
import com.exam.exam_system.model.Student;
import com.exam.exam_system.service.LoginService;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
public class LoginController {

    @Autowired
    private LoginService loginService;

    @GetMapping("/")
    public String root() {
        return "redirect:/login";
    }

    @GetMapping("/online-examination-system")
    public String home() {
        return "redirect:/login";
    }

    // ── Show login page ────────────────────────────────────
    @GetMapping("/login")
    public String showLoginPage(HttpSession session) {
        // If already logged in redirect to correct dashboard
        if (session.getAttribute("adminId") != null)
            return "redirect:/admin/dashboard";
        if (session.getAttribute("studentId") != null)
            return "redirect:/student/dashboard";
        if (session.getAttribute("examinerId") != null)
            return "redirect:/examiner/dashboard";
        return "login";
    }

    // ── Process login ──────────────────────────────────────
    @PostMapping("/login")
    public String processLogin(@RequestParam String username,
                               @RequestParam String password,
                               @RequestParam String role,
                               HttpSession session,
                               RedirectAttributes redirectAttributes) {
        try {
            switch (role) {

                case "ADMIN": {
                    Admin admin = loginService.loginAdmin(username, password);
                    if (admin != null) {
                        session.setAttribute("adminId",   admin.getAdminId());
                        session.setAttribute("adminName", admin.getFullName());
                        session.setAttribute("role",      "ADMIN");
                        return "redirect:/admin/dashboard";
                    }
                    break;
                }

                case "STUDENT": {
                    Student student = loginService.loginStudent(username, password);
                    if (student != null) {
                        session.setAttribute("studentId",   student.getStudentId());
                        session.setAttribute("studentName", student.getFullName());
                        session.setAttribute("role",        "STUDENT");
                        return "redirect:/student/dashboard";
                    }
                    break;
                }

                case "EXAMINER": {
                    Examiner examiner = loginService.loginExaminer(username, password);
                    if (examiner != null) {
                        session.setAttribute("examinerId",   examiner.getExaminerId());
                        session.setAttribute("examinerName", examiner.getFullName());
                        session.setAttribute("examinerType", examiner.getExaminerType().name());
                        session.setAttribute("role",         "EXAMINER");
                        return "redirect:/examiner/dashboard";
                    }
                    break;
                }
            }
        } catch (RuntimeException e) {
            // Catches held/inactive account messages
            redirectAttributes.addFlashAttribute("error", e.getMessage());
            return "redirect:/login";
        }

        redirectAttributes.addFlashAttribute("error",
                "Invalid username, password, or role.");
        return "redirect:/login";
    }

    // ── Logout ─────────────────────────────────────────────
    @GetMapping("/logout")
    public String logout(HttpSession session,
                         RedirectAttributes redirectAttributes) {
        session.invalidate();
        redirectAttributes.addFlashAttribute("success",
                "Logged out successfully.");
        return "redirect:/login";
    }
}