package com.exam.exam_system.controller;

import com.exam.exam_system.service.ResultDisplayService;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

@Controller
@RequestMapping("/student/results")
public class ResultDisplayController {

    @Autowired
    private ResultDisplayService resultDisplayService;

    // ── Student views all own results ──────────────────────
    @GetMapping
    public String viewMyResults(HttpSession session, Model model) {
        Integer studentId = (Integer) session.getAttribute("studentId");
        if (studentId == null) return "redirect:/login";

        model.addAttribute("results",
                resultDisplayService.getResultViewsForStudent(studentId));
        model.addAttribute("summary",
                resultDisplayService.getSummaryForStudent(studentId));
        return "result/student-results";
    }
}
