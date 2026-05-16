<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Student Dashboard — ExamSystem</title>
    <link rel="stylesheet" href="/css/style.css" />
</head>
<body>
<%@ include file="/WEB-INF/views/common/navbar.jsp" %>

<div class="page-wrapper">
    <div class="page-header">
        <div>
            <h2 class="page-title">Student Dashboard</h2>
            <p class="page-subtitle">
                Welcome, ${studentName}. Manage your exams and results.
            </p>
        </div>
    </div>

    <div class="quick-links">
        <a href="/student/exams/register" class="quick-link-card">
            <div class="quick-link-icon">📝</div>
            <div class="quick-link-text">
                <div class="link-title">Register for Exam</div>
                <div class="link-desc">Browse and register for exams</div>
            </div>
        </a>
        <a href="/student/exams/my-registrations" class="quick-link-card">
            <div class="quick-link-icon">📄</div>
            <div class="quick-link-text">
                <div class="link-title">My Registrations</div>
                <div class="link-desc">View registration request statuses</div>
            </div>
        </a>
        <a href="/student/results" class="quick-link-card">
            <div class="quick-link-icon">📊</div>
            <div class="quick-link-text">
                <div class="link-title">My Results</div>
                <div class="link-desc">View marks, grades and status</div>
            </div>
        </a>
        <a href="/student/recheck" class="quick-link-card">
            <div class="quick-link-icon">📋</div>
            <div class="quick-link-text">
                <div class="link-title">Recheck Requests</div>
                <div class="link-desc">
                    Submit and track recheck requests
                </div>
            </div>
        </a>
    </div>
</div>
</body>
</html>