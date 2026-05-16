package com.exam.exam_system.controller;

import com.exam.exam_system.model.RecheckRequest.RequestStatus;
import com.exam.exam_system.service.RecheckRequestService;
import com.exam.exam_system.service.ResultDisplayService;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
public class RecheckRequestController {

    @Autowired
    private RecheckRequestService recheckRequestService;

    @Autowired
    private ResultDisplayService resultDisplayService;

    // ── STUDENT SIDE ───────────────────────────────────────

    // Student views own recheck requests
    @GetMapping("/student/recheck")
    public String myRecheckRequests(HttpSession session,
                                    Model model) {
        Integer studentId = (Integer) session
                .getAttribute("studentId");
        if (studentId == null) return "redirect:/login";

        model.addAttribute("requests",
                recheckRequestService
                        .getRequestsByStudent(studentId));
        return "recheck/student-recheck-list";
    }

    // Student submits new recheck request
    @PostMapping("/student/recheck/submit")
    public String submitRecheckRequest(
            @RequestParam Integer examId,
            @RequestParam Integer resultId,
            @RequestParam String requestReason,
            @RequestParam(required = false)
            String requestDescription,
            HttpSession session,
            RedirectAttributes redirectAttributes) {

        Integer studentId = (Integer) session
                .getAttribute("studentId");
        if (studentId == null) return "redirect:/login";

        try {
            recheckRequestService.submitRequest(
                    studentId, examId, resultId,
                    requestReason, requestDescription);
            redirectAttributes.addFlashAttribute("success",
                    "Recheck request submitted successfully!");
        } catch (RuntimeException e) {
            redirectAttributes.addFlashAttribute("error",
                    e.getMessage());
        }
        return "redirect:/student/recheck";
    }

    // Student edits PENDING request
    @GetMapping("/student/recheck/edit/{id}")
    public String showEditRequest(@PathVariable Integer id,
                                  HttpSession session,
                                  Model model) {
        Integer studentId = (Integer) session
                .getAttribute("studentId");
        if (studentId == null) return "redirect:/login";

        model.addAttribute("request",
                recheckRequestService.getRequestById(id));
        return "recheck/student-recheck-edit";
    }

    // Student saves edited request
    @PostMapping("/student/recheck/edit/{id}")
    public String updateRecheckRequest(
            @PathVariable Integer id,
            @RequestParam String requestReason,
            @RequestParam(required = false)
            String requestDescription,
            HttpSession session,
            RedirectAttributes redirectAttributes) {

        Integer studentId = (Integer) session
                .getAttribute("studentId");
        if (studentId == null) return "redirect:/login";

        try {
            recheckRequestService.updateRequest(
                    id, requestReason, requestDescription);
            redirectAttributes.addFlashAttribute("success",
                    "Request updated successfully!");
        } catch (RuntimeException e) {
            redirectAttributes.addFlashAttribute("error",
                    e.getMessage());
        }
        return "redirect:/student/recheck";
    }

    // Student deletes PENDING request
    @PostMapping("/student/recheck/delete/{id}")
    public String deleteRecheckRequest(
            @PathVariable Integer id,
            HttpSession session,
            RedirectAttributes redirectAttributes) {

        Integer studentId = (Integer) session
                .getAttribute("studentId");
        if (studentId == null) return "redirect:/login";

        try {
            recheckRequestService.deleteRequest(id);
            redirectAttributes.addFlashAttribute("success",
                    "Request deleted successfully!");
        } catch (RuntimeException e) {
            redirectAttributes.addFlashAttribute("error",
                    e.getMessage());
        }
        return "redirect:/student/recheck";
    }

    // ── ADMIN SIDE ─────────────────────────────────────────

    // Admin views all recheck requests
    @GetMapping("/admin/recheck")
    public String adminViewRequests(
            @RequestParam(required = false) String status,
            HttpSession session,
            Model model) {

        if (session.getAttribute("adminId") == null)
            return "redirect:/login";

        if (status != null && !status.isEmpty()) {
            model.addAttribute("requests",
                    recheckRequestService.getRequestsByStatus(
                            RequestStatus.valueOf(status)));
            model.addAttribute("selectedStatus", status);
        } else {
            model.addAttribute("requests",
                    recheckRequestService.getAllRequests());
        }
        return "recheck/admin-recheck-list";
    }

    // Admin reviews a request
    @PostMapping("/admin/recheck/review/{id}")
    public String adminReviewRequest(
            @PathVariable Integer id,
            @RequestParam String requestStatus,
            @RequestParam(required = false) String reviewComment,
            HttpSession session,
            RedirectAttributes redirectAttributes) {

        Integer adminId = (Integer) session
                .getAttribute("adminId");
        if (adminId == null) return "redirect:/login";

        try {
            recheckRequestService.reviewByAdmin(
                    id, adminId, requestStatus, reviewComment);
            redirectAttributes.addFlashAttribute("success",
                    "Request reviewed successfully!");
        } catch (RuntimeException e) {
            redirectAttributes.addFlashAttribute("error",
                    e.getMessage());
        }
        return "redirect:/admin/recheck";
    }

    // Admin force deletes any request
    @PostMapping("/admin/recheck/delete/{id}")
    public String adminDeleteRequest(
            @PathVariable Integer id,
            HttpSession session,
            RedirectAttributes redirectAttributes) {

        if (session.getAttribute("adminId") == null)
            return "redirect:/login";

        try {
            recheckRequestService.forceDeleteRequest(id);
            redirectAttributes.addFlashAttribute("success",
                    "Request deleted successfully!");
        } catch (RuntimeException e) {
            redirectAttributes.addFlashAttribute("error",
                    e.getMessage());
        }
        return "redirect:/admin/recheck";
    }

    // ── EXAMINER SIDE ──────────────────────────────────────

    // Examiner views all recheck requests
    @GetMapping("/examiner/recheck")
    public String examinerViewRequests(
            @RequestParam(required = false) String status,
            HttpSession session,
            Model model) {

        if (session.getAttribute("examinerId") == null)
            return "redirect:/login";

        if (status != null && !status.isEmpty()) {
            model.addAttribute("requests",
                    recheckRequestService.getRequestsByStatus(
                            RequestStatus.valueOf(status)));
            model.addAttribute("selectedStatus", status);
        } else {
            model.addAttribute("requests",
                    recheckRequestService.getAllRequests());
        }
        return "recheck/examiner-recheck-list";
    }

    // Examiner reviews a request
    @PostMapping("/examiner/recheck/review/{id}")
    public String examinerReviewRequest(
            @PathVariable Integer id,
            @RequestParam String requestStatus,
            @RequestParam(required = false) String reviewComment,
            HttpSession session,
            RedirectAttributes redirectAttributes) {

        Integer examinerId = (Integer) session
                .getAttribute("examinerId");
        if (examinerId == null) return "redirect:/login";

        try {
            recheckRequestService.reviewByExaminer(
                    id, examinerId, requestStatus, reviewComment);
            redirectAttributes.addFlashAttribute("success",
                    "Request reviewed successfully!");
        } catch (RuntimeException e) {
            redirectAttributes.addFlashAttribute("error",
                    e.getMessage());
        }
        return "redirect:/examiner/recheck";
    }
}