package com.exam.exam_system.controller;

import com.exam.exam_system.model.Student;
import com.exam.exam_system.service.StudentService;
import jakarta.validation.Valid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
@RequestMapping("/students")
public class StudentController {

    @Autowired
    private StudentService studentService;

    // LIST all students (admin view)
    @GetMapping
    public String listStudents(@RequestParam(required = false) String search, Model model) {
        if (search != null && !search.isEmpty()) {
            model.addAttribute("students", studentService.searchStudents(search));
            model.addAttribute("search", search);
        } else {
            model.addAttribute("students", studentService.getAllStudents());
        }
        return "student/student-list";
    }

    // SHOW registration form
    @GetMapping("/register")
    public String showRegisterForm(Model model) {
        model.addAttribute("student", new Student());
        return "student/student-register";
    }

    // PROCESS registration
    @PostMapping("/register")
    public String registerStudent(@Valid @ModelAttribute("student") Student student,
                                  BindingResult result,
                                  RedirectAttributes redirectAttributes) {
        if (result.hasErrors()) {
            return "student/student-register";
        }
        try {
            studentService.registerStudent(student);
            redirectAttributes.addFlashAttribute("success", "Registration successful! Please login.");
            return "redirect:/login";   // ← changed from /students to /login
        } catch (RuntimeException e) {
            redirectAttributes.addFlashAttribute("error", e.getMessage());
            return "redirect:/students/register";
        }
    }

    // SHOW edit form
    @GetMapping("/edit/{id}")
    public String showEditForm(@PathVariable Integer id, Model model) {
        model.addAttribute("student", studentService.getStudentById(id));
        return "student/student-edit";
    }

    // PROCESS edit
    @PostMapping("/edit/{id}")
    public String updateStudent(@PathVariable Integer id,
                                @Valid @ModelAttribute("student") Student student,
                                BindingResult result,
                                RedirectAttributes redirectAttributes) {
        if (result.hasErrors()) {
            return "student/student-edit";
        }
        try {
            studentService.updateStudent(id, student);
            redirectAttributes.addFlashAttribute("success",
                    "Student updated successfully!");
        } catch (RuntimeException e) {
            redirectAttributes.addFlashAttribute("error", e.getMessage());
        }
        return "redirect:/students";
    }

    // DELETE
    @PostMapping("/delete/{id}")
    public String deleteStudent(@PathVariable Integer id, RedirectAttributes redirectAttributes) {
        try {
            studentService.deleteStudent(id);
            redirectAttributes.addFlashAttribute("success", "Student deleted successfully!");
        } catch (RuntimeException e) {
            redirectAttributes.addFlashAttribute("error", e.getMessage());
        }
        return "redirect:/students";
    }

    // VIEW single student profile
    @GetMapping("/view/{id}")
    public String viewStudent(@PathVariable Integer id, Model model) {
        model.addAttribute("student", studentService.getStudentById(id));
        return "student/student-view";
    }
}