package com.exam.exam_system.controller;

import com.exam.exam_system.model.Exam;
import com.exam.exam_system.service.ExamService;
import jakarta.servlet.http.HttpSession;
import jakarta.validation.Valid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
@RequestMapping("/admin/exams")
public class ExamController {

    @Autowired
    private ExamService examService;

    // LIST all exams
    @GetMapping
    public String listExams(@RequestParam(required = false) String search, Model model) {
        if (search != null && !search.isEmpty()) {
            model.addAttribute("exams", examService.searchExams(search));
            model.addAttribute("search", search);
        } else {
            model.addAttribute("exams", examService.getAllExams());
        }
        model.addAttribute("statuses", Exam.ExamStatus.values());
        return "exam/exam-list";
    }

    // SHOW add form
    @GetMapping("/add")
    public String showAddForm(Model model) {
        model.addAttribute("exam", new Exam());
        model.addAttribute("statuses", Exam.ExamStatus.values());
        return "exam/exam-add";
    }

    // PROCESS add
    @PostMapping("/add")
    public String addExam(@Valid @ModelAttribute("exam") Exam exam,
                          BindingResult result,
                          Model model,
                          RedirectAttributes redirectAttributes) {
        if (result.hasErrors()) {
            model.addAttribute("statuses", Exam.ExamStatus.values());
            return "exam/exam-add";
        }
        try {
            examService.addExam(exam);
            redirectAttributes.addFlashAttribute("success", "Exam added successfully!");
        } catch (RuntimeException e) {
            redirectAttributes.addFlashAttribute("error", e.getMessage());
        }
        return "redirect:/admin/exams";
    }

    // SHOW edit form
    @GetMapping("/edit/{id}")
    public String showEditForm(@PathVariable Integer id, Model model) {
        model.addAttribute("exam", examService.getExamById(id));
        model.addAttribute("statuses", Exam.ExamStatus.values());
        return "exam/exam-edit";
    }

    // PROCESS edit
    @PostMapping("/edit/{id}")
    public String updateExam(@PathVariable Integer id,
                             @ModelAttribute("exam") Exam exam,
                             @RequestParam("examDate") String examDate,
                             @RequestParam("examTime") String examTime,
                             HttpSession session,
                             RedirectAttributes redirectAttributes) {
        if (session.getAttribute("adminId") == null)
            return "redirect:/login";
        try {
            exam.setExamDate(java.time.LocalDate.parse(examDate));
            exam.setExamTime(java.time.LocalTime.parse(examTime));
            examService.updateExam(id, exam);
            redirectAttributes.addFlashAttribute("success",
                    "Exam updated successfully!");
        } catch (RuntimeException e) {
            redirectAttributes.addFlashAttribute("error", e.getMessage());
        }
        return "redirect:/admin/exams";
    }

    // DELETE
    @PostMapping("/delete/{id}")
    public String deleteExam(@PathVariable Integer id,
                             RedirectAttributes redirectAttributes) {
        try {
            examService.deleteExam(id);
            redirectAttributes.addFlashAttribute("success", "Exam deleted successfully!");
        } catch (RuntimeException e) {
            redirectAttributes.addFlashAttribute("error", e.getMessage());
        }
        return "redirect:/admin/exams";
    }

    // VIEW single exam
    @GetMapping("/view/{id}")
    public String viewExam(@PathVariable Integer id, Model model) {
        model.addAttribute("exam", examService.getExamById(id));
        return "exam/exam-view";
    }
}
