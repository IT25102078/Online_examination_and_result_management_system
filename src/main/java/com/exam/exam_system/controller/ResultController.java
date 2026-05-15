package com.exam.exam_system.controller;

import jakarta.servlet.http.HttpSession;
import com.exam.exam_system.model.*;
import com.exam.exam_system.repository.ExamRegistrationRepository;
import com.exam.exam_system.service.*;
import jakarta.validation.Valid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.List;

@Controller
@RequestMapping("/examiner")
public class ResultController {

    @Autowired
    private ResultService resultService;

    @Autowired
    private HoldService holdService;

    @Autowired
    private ExaminerPermissionService examinerPermissionService;

    @Autowired
    private ExamRegistrationRepository examRegistrationRepository;

    @Autowired
    private com.exam.exam_system.repository.ExaminerRepository examinerRepository;

    @Autowired
    private com.exam.exam_system.repository.ExamRepository examRepository;

    @Autowired
    private com.exam.exam_system.repository.ExaminerAllocationRepository
            examinerAllocationRepository;

    // ── Examiner dashboard — shows allocated exams ─────────
    @GetMapping("/dashboard")
    public String examinerDashboard(HttpSession session, Model model) {
        Integer examinerId = (Integer) session.getAttribute("examinerId");
        if (examinerId == null) return "redirect:/login";

        Examiner examiner = examinerRepository.findById(examinerId)
                .orElseThrow(() -> new RuntimeException("Examiner not found."));

        // ── Get allocated exams for this examiner ──────────────
        List<com.exam.exam_system.model.ExaminerAllocation> allocatedExams =
                examinerAllocationRepository
                        .findByExaminer_ExaminerId(examinerId);

        model.addAttribute("examiner", examiner);
        model.addAttribute("canHold",
                examinerPermissionService.canHoldStudents(examiner));
        model.addAttribute("privileges",
                examinerPermissionService.getPrivileges(examiner));
        model.addAttribute("allocatedExams", allocatedExams);
        model.addAttribute("results",
                resultService.getResultsByExaminer(examinerId));
        model.addAttribute("holds",
                holdService.getHoldsByExaminer(examinerId));

        return "result/examiner-dashboard";
    }

    // ── Show approved students for an exam (add marks) ─────
    @GetMapping("/results/add")
    public String showAddMarksPage(@RequestParam Integer examId,
                                   HttpSession session, Model model) {
        Integer examinerId = (Integer) session.getAttribute("examinerId");
        if (examinerId == null) return "redirect:/login";

        Examiner examiner = examinerRepository.findById(examinerId)
                .orElseThrow(() -> new RuntimeException("Examiner not found."));

        // ── Check examiner is allocated to this exam ───────────
        boolean isAllocated = examinerAllocationRepository
                .findByExaminer_ExaminerId(examinerId)
                .stream()
                .anyMatch(a -> a.getExam().getExamId().equals(examId));

        if (!isAllocated) {
            model.addAttribute("error",
                    "You are not allocated to this exam.");
            // Redirect back to dashboard
            return "redirect:/examiner/dashboard";
        }

        List<ExamRegistration> approvedStudents =
                examRegistrationRepository
                        .findApprovedStudentsWithoutResults(examId);

        Exam exam = examRepository.findById(examId)
                .orElseThrow(() -> new RuntimeException("Exam not found."));

        model.addAttribute("exam", exam);
        model.addAttribute("approvedStudents", approvedStudents);
        model.addAttribute("examiner", examiner);
        model.addAttribute("canHold",
                examinerPermissionService.canHoldStudents(examiner));
        return "result/add-marks";
    }
    // ── Process adding marks ───────────────────────────────
    @PostMapping("/results/add")
    public String addMarks(@RequestParam Integer studentId,
                           @RequestParam Integer examId,
                           @Valid @ModelAttribute("result") Result result,
                           BindingResult bindingResult,
                           HttpSession session,
                           RedirectAttributes redirectAttributes) {
        Integer examinerId = (Integer) session.getAttribute("examinerId");
        if (examinerId == null) return "redirect:/login";
        if (bindingResult.hasErrors()) {
            redirectAttributes.addFlashAttribute("error", "Invalid marks entered.");
            return "redirect:/examiner/results/add?examId=" + examId;
        }
        try {
            resultService.addResult(studentId, examId, examinerId, result);
            redirectAttributes.addFlashAttribute("success", "Marks added successfully!");
        } catch (RuntimeException e) {
            redirectAttributes.addFlashAttribute("error", e.getMessage());
        }
        return "redirect:/examiner/results/add?examId=" + examId;
    }

    // SHOW edit marks form
    @GetMapping("/results/edit/{id}")
    public String showEditMarks(@PathVariable Integer id,
                                HttpSession session,
                                Model model) {
        Integer examinerId = (Integer) session.getAttribute("examinerId");
        if (examinerId == null) return "redirect:/login";

        model.addAttribute("result", resultService.getResultById(id));
        return "result/edit-marks";
    }

    // PROCESS edit marks
    @PostMapping("/results/edit/{id}")
    public String updateMarks(@PathVariable Integer id,
                              @RequestParam("marksObtained") java.math.BigDecimal marksObtained,
                              HttpSession session,
                              RedirectAttributes redirectAttributes) {
        Integer examinerId = (Integer) session.getAttribute("examinerId");
        if (examinerId == null) return "redirect:/login";

        try {
            // Build a simple Result object with just the new marks
            Result updated = new Result();
            updated.setMarksObtained(marksObtained);

            resultService.updateResult(id, examinerId, updated);
            redirectAttributes.addFlashAttribute("success",
                    "Marks updated successfully!");
        } catch (RuntimeException e) {
            redirectAttributes.addFlashAttribute("error", e.getMessage());
        }
        return "redirect:/examiner/dashboard";
    }

    // ── Delete result ──────────────────────────────────────
    @PostMapping("/results/delete/{id}")
    public String deleteResult(@PathVariable Integer id,
                               RedirectAttributes redirectAttributes) {
        try {
            resultService.deleteResult(id);
            redirectAttributes.addFlashAttribute("success",
                    "Result deleted successfully!");
        } catch (RuntimeException e) {
            redirectAttributes.addFlashAttribute("error", e.getMessage());
        }
        return "redirect:/examiner/dashboard";
    }

    // ── Place hold (SENIOR only) ───────────────────────────
    @PostMapping("/holds/place")
    public String placeHold(@RequestParam Integer studentId,
                            @RequestParam Integer examId,
                            @RequestParam String reason,
                            HttpSession session,
                            RedirectAttributes redirectAttributes) {
        Integer examinerId = (Integer) session.getAttribute("examinerId");
        if (examinerId == null) return "redirect:/login";
        try {
            holdService.placeHold(studentId, examId, examinerId, reason);
            redirectAttributes.addFlashAttribute("success",
                    "Student placed on hold successfully!");
        } catch (RuntimeException e) {
            redirectAttributes.addFlashAttribute("error", e.getMessage());
        }
        return "redirect:/examiner/results/add?examId=" + examId;
    }

    // ── Release hold ───────────────────────────────────────
    @PostMapping("/holds/release/{holdId}")
    public String releaseHold(@PathVariable Integer holdId,
                              RedirectAttributes redirectAttributes) {
        try {
            holdService.releaseHold(holdId);
            redirectAttributes.addFlashAttribute("success",
                    "Hold released successfully!");
        } catch (RuntimeException e) {
            redirectAttributes.addFlashAttribute("error", e.getMessage());
        }
        return "redirect:/examiner/dashboard";
    }

    // ── Delete hold ────────────────────────────────────────
    @PostMapping("/holds/delete/{holdId}")
    public String deleteHold(@PathVariable Integer holdId,
                             RedirectAttributes redirectAttributes) {
        try {
            holdService.deleteHold(holdId);
            redirectAttributes.addFlashAttribute("success",
                    "Hold deleted successfully!");
        } catch (RuntimeException e) {
            redirectAttributes.addFlashAttribute("error", e.getMessage());
        }
        return "redirect:/examiner/dashboard";
    }
}
