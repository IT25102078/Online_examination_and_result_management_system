package com.exam.exam_system.controller;


import jakarta.servlet.http.HttpSession; // added when connecting all
import com.exam.exam_system.model.ExamRegistration.ApprovalStatus;
import com.exam.exam_system.service.ExamRegistrationService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
public class ExamRegistrationController {

    @Autowired
    private ExamRegistrationService examRegistrationService;

    // ── STUDENT SIDE ───────────────────────────────────────

    // Student views available exams to register
    @GetMapping("/student/exams/register")
    public String showAvailableExams(HttpSession session, Model model) {
        Integer studentId = (Integer) session.getAttribute("studentId");
        if (studentId == null) return "redirect:/login";
        model.addAttribute("availableExams",
                examRegistrationService.getAvailableExamsForStudent(studentId));
        return "registration/student-exam-register";
    }

    // Student submits registration request
    @PostMapping("/student/exams/register")
    public String submitRegistration(@RequestParam Integer examId,
                                     HttpSession session,
                                     RedirectAttributes redirectAttributes) {
        Integer studentId = (Integer) session.getAttribute("studentId");
        if (studentId == null) return "redirect:/login";
        try {
            examRegistrationService.requestRegistration(studentId, examId);
            redirectAttributes.addFlashAttribute("success",
                    "Registration request submitted! Waiting for admin approval.");
        } catch (RuntimeException e) {
            redirectAttributes.addFlashAttribute("error", e.getMessage());
        }
        return "redirect:/student/exams/my-registrations";
    }

    // Student views own registration statuses
    @GetMapping("/student/exams/my-registrations")
    public String myRegistrations(HttpSession session, Model model) {
        Integer studentId = (Integer) session.getAttribute("studentId");
        if (studentId == null) return "redirect:/login";
        model.addAttribute("registrations",
                examRegistrationService.getRegistrationsByStudent(studentId));
        return "registration/student-my-registrations";
    }

    // ── ADMIN SIDE ─────────────────────────────────────────

    // Admin views all registrations with optional status filter
    @GetMapping("/admin/registrations")
    public String adminViewRegistrations(
            @RequestParam(required = false) String status,
            HttpSession session, Model model) {
        if (session.getAttribute("adminId") == null) return "redirect:/login";
        if (status != null && !status.isEmpty()) {
            model.addAttribute("registrations",
                    examRegistrationService.getRegistrationsByStatus(
                            ApprovalStatus.valueOf(status)));
            model.addAttribute("selectedStatus", status);
        } else {
            model.addAttribute("registrations",
                    examRegistrationService.getAllRegistrations());
        }
        return "registration/admin-registration-list";
    }

    // Admin approves a registration
    @PostMapping("/admin/registrations/approve/{id}")
    public String approveRegistration(@PathVariable Integer id,
                                      @RequestParam(required = false) String remarks,
                                      HttpSession session,
                                      RedirectAttributes redirectAttributes) {
        Integer adminId = (Integer) session.getAttribute("adminId");
        if (adminId == null) return "redirect:/login";
        try {
            examRegistrationService.approveRegistration(id, adminId, remarks);
            redirectAttributes.addFlashAttribute("success",
                    "Registration approved successfully!");
        } catch (RuntimeException e) {
            redirectAttributes.addFlashAttribute("error", e.getMessage());
        }
        return "redirect:/admin/registrations";
    }

    // Admin rejects a registration
    @PostMapping("/admin/registrations/reject/{id}")
    public String rejectRegistration(@PathVariable Integer id,
                                     @RequestParam(required = false) String remarks,
                                     HttpSession session,
                                     RedirectAttributes redirectAttributes) {
        Integer adminId = (Integer) session.getAttribute("adminId");
        if (adminId == null) return "redirect:/login";
        try {
            examRegistrationService.rejectRegistration(id, adminId, remarks);
            redirectAttributes.addFlashAttribute("success",
                    "Registration rejected.");
        } catch (RuntimeException e) {
            redirectAttributes.addFlashAttribute("error", e.getMessage());
        }
        return "redirect:/admin/registrations";
    }

    // Admin deletes a registration
    @PostMapping("/admin/registrations/delete/{id}")
    public String deleteRegistration(@PathVariable Integer id,
                                     RedirectAttributes redirectAttributes) {
        try {
            examRegistrationService.deleteRegistration(id);
            redirectAttributes.addFlashAttribute("success",
                    "Registration deleted successfully!");
        } catch (RuntimeException e) {
            redirectAttributes.addFlashAttribute("error", e.getMessage());
        }
        return "redirect:/admin/registrations";
    }
}
