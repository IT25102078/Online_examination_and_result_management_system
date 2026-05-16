<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<!DOCTYPE html>
<html>
<head>
    <title>Edit Exam — ExamSystem</title>
    <link rel="stylesheet" href="/css/style.css" />
</head>
<body>
<%@ include file="/WEB-INF/views/common/navbar.jsp" %>
<div class="page-wrapper">

    <div class="breadcrumb">
        <a href="/admin/dashboard">Dashboard</a>
        <span class="separator">›</span>
        <a href="/admin/exams">Exams</a>
        <span class="separator">›</span>
        <span class="current">Edit Exam</span>
    </div>

    <div class="page-header">
        <div>
            <h2 class="page-title">Edit Exam</h2>
            <p class="page-subtitle">Update examination details</p>
        </div>
    </div>

    <div class="form-card" style="max-width:760px;">
        <form:form method="post"
                   action="/admin/exams/edit/${exam.examId}"
                   modelAttribute="exam">

            <form:hidden path="createdAt" />

            <div class="form-grid">

                <div class="form-group">
                    <label class="form-label">Exam Code</label>
                    <form:input path="examCode" cssClass="form-control"
                                readonly="true" />
                </div>

                <div class="form-group">
                    <label class="form-label">Exam Name</label>
                    <form:input path="examName" cssClass="form-control" />
                    <form:errors path="examName" cssClass="form-error" />
                </div>

                <div class="form-group span-2">
                    <label class="form-label">Subject Name</label>
                    <form:input path="subjectName" cssClass="form-control" />
                    <form:errors path="subjectName" cssClass="form-error" />
                </div>

                <div class="form-group">
                    <label class="form-label">Exam Date</label>
                    <input type="date" name="examDate"
                           class="form-control"
                           value="${exam.examDate}" />
                </div>

                <div class="form-group">
                    <label class="form-label">Exam Time</label>
                    <input type="time" name="examTime"
                           class="form-control"
                           value="${exam.examTime}" />
                </div>

                <div class="form-group">
                    <label class="form-label">Duration (minutes)</label>
                    <form:input path="durationMinutes"
                                cssClass="form-control" type="number" />
                </div>

                <div class="form-group">
                    <label class="form-label">Total Marks</label>
                    <form:input path="totalMarks" cssClass="form-control"
                                type="number" step="0.01" />
                </div>

                <div class="form-group">
                    <label class="form-label">Pass Marks</label>
                    <form:input path="passMarks" cssClass="form-control"
                                type="number" step="0.01" />
                </div>

                <div class="form-group">
                    <label class="form-label">Status</label>
                    <form:select path="status" cssClass="form-control">
                        <form:option value="ACTIVE">Active</form:option>
                        <form:option value="CANCELLED">Cancelled</form:option>
                        <form:option value="COMPLETED">Completed</form:option>
                    </form:select>
                </div>

            </div>

            <div class="form-actions">
                <button type="submit" class="btn btn-primary">
                    💾 Save Changes
                </button>
                <a href="/admin/exams" class="btn btn-secondary">Cancel</a>
            </div>
        </form:form>
    </div>
</div>
</body>
</html>
