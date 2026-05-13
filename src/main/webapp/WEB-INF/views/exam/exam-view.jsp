<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Exam Details — ExamSystem</title>
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
        <span class="current">View Details</span>
    </div>

    <div class="page-header">
        <div>
            <h2 class="page-title">Exam Details</h2>
            <p class="page-subtitle">${exam.examCode}</p>
        </div>
        <div style="display:flex;gap:8px;">
            <a href="/admin/exams/edit/${exam.examId}"
               class="btn btn-primary">✏️ Edit</a>
            <a href="/admin/exams" class="btn btn-secondary">← Back</a>
        </div>
    </div>

    <div class="card" style="max-width:700px;">
        <div class="card-header">
            <h3>${exam.examName}</h3>
            <c:choose>
                <c:when test="${exam.status == 'ACTIVE'}">
                    <span class="badge badge-success">ACTIVE</span>
                </c:when>
                <c:when test="${exam.status == 'CANCELLED'}">
                    <span class="badge badge-danger">CANCELLED</span>
                </c:when>
                <c:otherwise>
                    <span class="badge badge-dark">COMPLETED</span>
                </c:otherwise>
            </c:choose>
        </div>
        <div class="card-body" style="padding:0;">
            <table class="profile-table">
                <tr><th>Exam Code</th>
                    <td>
                        <span style="font-family:var(--font-mono);
                              color:var(--blue-primary);font-weight:600;">
                            ${exam.examCode}
                        </span>
                    </td>
                </tr>
                <tr><th>Exam Name</th><td>${exam.examName}</td></tr>
                <tr><th>Subject</th><td>${exam.subjectName}</td></tr>
                <tr><th>Date</th><td>${exam.examDate}</td></tr>
                <tr><th>Time</th><td>${exam.examTime}</td></tr>
                <tr><th>Duration</th><td>${exam.durationMinutes} minutes</td></tr>
                <tr><th>Total Marks</th><td>${exam.totalMarks}</td></tr>
                <tr><th>Pass Marks</th><td>${exam.passMarks}</td></tr>
                <tr><th>Created At</th><td>${exam.createdAt}</td></tr>
            </table>
        </div>
    </div>
</div>
</body>
</html>
