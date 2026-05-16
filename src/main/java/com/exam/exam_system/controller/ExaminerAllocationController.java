package com.exam.exam_system.controller;

import com.exam.exam_system.service.ExaminerAllocationService;
import com.exam.exam_system.service.ExamService;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
@RequestMapping("/admin/allocations")
public class ExaminerAllocationController {

    @Autowired
    private ExaminerAllocationService allocationService;

    @Autowired
    private ExamService examService;

    // ── LIST all allocations ───────────────────────────────
    @GetMapping
    public String listAllocations(HttpSession session, Model model) {
        if (session.getAttribute("adminId") == null)
            return "redirect:/login";

        model.addAttribute("allocations",
                allocationService.getAllAllocations());
        model.addAttribute("exams",
                examService.getAllExams());
        return "allocation/allocation-list";
    }

    // ── SHOW allocate form for a specific exam ─────────────
    @GetMapping("/add")
    public String showAllocateForm(
            @RequestParam Integer examId,
            HttpSession session,
            Model model) {
        if (session.getAttribute("adminId") == null)
            return "redirect:/login";

        model.addAttribute("exam",
                examService.getExamById(examId));
        model.addAttribute("availableExaminers",
                allocationService.getAvailableExaminersForExam(examId));
        model.addAttribute("currentAllocations",
                allocationService.getAllocationsByExam(examId));
        return "allocation/allocation-add";
    }

    // ── PROCESS allocation ─────────────────────────────────
    @PostMapping("/add")
    public String allocateExaminer(
            @RequestParam Integer examinerId,
            @RequestParam Integer examId,
            HttpSession session,
            RedirectAttributes redirectAttributes) {

        Integer adminId = (Integer) session.getAttribute("adminId");
        if (adminId == null) return "redirect:/login";

        try {
            allocationService.allocateExaminer(
                    examinerId, examId, adminId);
            redirectAttributes.addFlashAttribute("success",
                    "Examiner allocated successfully!");
        } catch (RuntimeException e) {
            redirectAttributes.addFlashAttribute("error",
                    e.getMessage());
        }
        return "redirect:/admin/allocations/add?examId=" + examId;
    }

    // ── DELETE allocation ──────────────────────────────────
    @PostMapping("/delete/{id}")
    public String deleteAllocation(
            @PathVariable Integer id,
            @RequestParam Integer examId,
            HttpSession session,
            RedirectAttributes redirectAttributes) {

        if (session.getAttribute("adminId") == null)
            return "redirect:/login";

        try {
            allocationService.deleteAllocation(id);
            redirectAttributes.addFlashAttribute("success",
                    "Allocation removed successfully!");
        } catch (RuntimeException e) {
            redirectAttributes.addFlashAttribute("error",
                    e.getMessage());
        }
        return "redirect:/admin/allocations/add?examId=" + examId;
    }
}
