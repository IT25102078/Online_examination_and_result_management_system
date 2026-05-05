package com.exam.exam_system.examiner;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.util.List;

@Service
public class ExaminerService {

    @Autowired
    private ExaminerRepository examinerRepository;

    public void registerExaminer(Examiner e) {
        e.setStatus("ACTIVE");
        examinerRepository.save(e);
    }

    public List<Examiner> getAllExaminers() {
        return examinerRepository.findAll();
    }

    public Examiner getExaminerById(int id) {
        return examinerRepository.findById(id);
    }

    public List<Examiner> searchExaminers(String keyword) {
        return examinerRepository.search(keyword);
    }

    public void updateExaminer(Examiner e) {
        examinerRepository.update(e);
    }

    public void deleteExaminer(int id) {
        examinerRepository.delete(id);
    }
}
