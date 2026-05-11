package com.example.exammanagementsystem.controller;

import com.example.exammanagementsystem.model.Exam;
import com.example.exammanagementsystem.repository.ExamRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;

import java.util.List;

@Controller
public class ExamController {

    @Autowired
    private ExamRepository examRepository;

    // Display the form to add a new exam
    @GetMapping("/add")
    public String showAddExamForm() {
        return "add_exam";
    }

    // Save the exam details to the database and redirect to the list page
    @PostMapping("/save")
    public String saveExam(@ModelAttribute("exam") Exam exam) {
        examRepository.save(exam);
        return "redirect:/exams"; // Redirect to the list view after saving
    }

    // Fetch all exams from the database and display them in a table
    @GetMapping("/exams")
    public String viewExams(Model model) {
        List<Exam> exams = examRepository.findAll();
        model.addAttribute("allExams", exams); // Sending the list to JSP
        return "exam-list"; // This will look for exam-list.jsp
    }

    // Delete an exam record based on its ID
    @GetMapping("/delete/{id}")
    public String deleteExam(@PathVariable Long id) {
        examRepository.deleteById(id);
        return "redirect:/exams"; // Redirect back to the list after deletion
    }
    // Method to show the Edit form with existing data
    @GetMapping("/edit/{id}")
    public String showEditForm(@PathVariable Long id, Model model) {
        Exam exam = examRepository.findById(id).orElse(null);
        model.addAttribute("exam", exam);
        return "edit_exam"; // This will look for edit_exam.jsp
    }

    // Method to handle the update request
    @PostMapping("/update/{id}")
    public String updateExam(@PathVariable Long id, @ModelAttribute("exam") Exam exam) {
        exam.setId(id); // Ensure the ID stays the same so it updates instead of creating new
        examRepository.save(exam);
        return "redirect:/exams";
    }
}