<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<!DOCTYPE html>
<html>
<head>
    <title>Add Exam — ExamSystem</title>
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
        <span class="current">Add Exam</span>
    </div>

    <div class="page-header">
        <div>
            <h2 class="page-title">Add New Exam</h2>
            <p class="page-subtitle">Create a new examination</p>
        </div>
    </div>

    <c:if test="${not empty error}">
        <div class="alert alert-danger">⚠️ ${error}</div>
    </c:if>

    <div class="form-card" style="max-width:760px;">
        <form:form method="post" action="/admin/exams/add" modelAttribute="exam">
            <div class="form-grid">

                <div class="form-group">
                    <label class="form-label">Exam Code</label>
                    <form:input path="examCode" cssClass="form-control"
                                placeholder="e.g. EXAM-DB-001" />
                    <form:errors path="examCode" cssClass="form-error" />
                </div>

                <div class="form-group">
                    <label class="form-label">Exam Name</label>
                    <form:input path="examName" cssClass="form-control"
                                placeholder="e.g. Mid Examination" />
                    <form:errors path="examName" cssClass="form-error" />
                </div>

                <div class="form-group span-2">
                    <label class="form-label">Subject Name</label>
                    <form:input path="subjectName" cssClass="form-control"
                                placeholder="e.g. Database Systems" />
                    <form:errors path="subjectName" cssClass="form-error" />
                </div>

                <div class="form-group">
                    <label class="form-label">Exam Date</label>
                    <form:input path="examDate" cssClass="form-control"
                                type="date" />
                    <form:errors path="examDate" cssClass="form-error" />
                </div>

                <div class="form-group">
                    <label class="form-label">Exam Time</label>
                    <form:input path="examTime" cssClass="form-control"
                                type="time" />
                    <form:errors path="examTime" cssClass="form-error" />
                </div>

                <div class="form-group">
                    <label class="form-label">Duration (minutes)</label>
                    <form:input path="durationMinutes" cssClass="form-control"
                                type="number" placeholder="120" />
                    <form:errors path="durationMinutes" cssClass="form-error" />
                </div>

                <div class="form-group">
                    <label class="form-label">Total Marks</label>
                    <form:input path="totalMarks" cssClass="form-control"
                                type="number" step="0.01" placeholder="100" />
                    <form:errors path="totalMarks" cssClass="form-error" />
                </div>

                <div class="form-group">
                    <label class="form-label">Pass Marks</label>
                    <form:input path="passMarks" cssClass="form-control"
                                type="number" step="0.01" placeholder="50" />
                    <form:errors path="passMarks" cssClass="form-error" />
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
                    ✅ Add Exam
                </button>
                <a href="/admin/exams" class="btn btn-secondary">Cancel</a>
            </div>
        </form:form>
    </div>
</div>
</body>
</html>
