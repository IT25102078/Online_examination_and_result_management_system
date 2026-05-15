package com.exam.exam_system.controller;

import com.exam.exam_system.model.Examiner;
import com.exam.exam_system.service.ExaminerService;
import jakarta.validation.Valid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
@RequestMapping("/admin/examiners")
public class ExaminerController {

    @Autowired
    private ExaminerService examinerService;

    // LIST all examiners (admin only)
    @GetMapping
    public String listExaminers(@RequestParam(required = false) String search, Model model) {
        if (search != null && !search.isEmpty()) {
            model.addAttribute("examiners", examinerService.searchExaminers(search));
            model.addAttribute("search", search);
        } else {
            model.addAttribute("examiners", examinerService.getAllExaminers());
        }
        return "examiner/examiner-list";
    }

    // SHOW add form
    @GetMapping("/add")
    public String showAddForm(Model model) {
        model.addAttribute("examiner", new Examiner());
        return "examiner/examiner-add";
    }

    // PROCESS add
    @PostMapping("/add")
    public String addExaminer(@Valid @ModelAttribute("examiner") Examiner examiner,
                              BindingResult result,
                              RedirectAttributes redirectAttributes) {
        if (result.hasErrors()) {
            return "examiner/examiner-add";
        }
        try {
            examinerService.addExaminer(examiner);
            redirectAttributes.addFlashAttribute("success", "Examiner added successfully!");
        } catch (RuntimeException e) {
            redirectAttributes.addFlashAttribute("error", e.getMessage());
        }
        return "redirect:/admin/examiners";
    }

    // SHOW edit form
    @GetMapping("/edit/{id}")
    public String showEditForm(@PathVariable Integer id, Model model) {
        model.addAttribute("examiner", examinerService.getExaminerById(id));
        return "examiner/examiner-edit";
    }

    // PROCESS edit
    @PostMapping("/edit/{id}")
    public String updateExaminer(@PathVariable Integer id,
                                 @Valid @ModelAttribute("examiner") Examiner examiner,
                                 BindingResult result,
                                 RedirectAttributes redirectAttributes) {
        if (result.hasErrors()) {
            return "examiner/examiner-edit";
        }
        try {
            examinerService.updateExaminer(id, examiner);
            redirectAttributes.addFlashAttribute("success", "Examiner updated successfully!");
        } catch (RuntimeException e) {
            redirectAttributes.addFlashAttribute("error", e.getMessage());
        }
        return "redirect:/admin/examiners";
    }

    // DELETE
    @PostMapping("/delete/{id}")
    public String deleteExaminer(@PathVariable Integer id,
                                 RedirectAttributes redirectAttributes) {
        try {
            examinerService.deleteExaminer(id);
            redirectAttributes.addFlashAttribute("success", "Examiner deleted successfully!");
        } catch (RuntimeException e) {
            redirectAttributes.addFlashAttribute("error", e.getMessage());
        }
        return "redirect:/admin/examiners";
    }

    // VIEW single examiner
    @GetMapping("/view/{id}")
    public String viewExaminer(@PathVariable Integer id, Model model) {
        model.addAttribute("examiner", examinerService.getExaminerById(id));
        return "examiner/examiner-view";
    }
}