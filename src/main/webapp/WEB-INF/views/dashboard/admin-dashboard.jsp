<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Admin Dashboard — ExamSystem</title>
    <link rel="stylesheet" href="/css/style.css" />
</head>
<body>
<%@ include file="/WEB-INF/views/common/navbar.jsp" %>

<div class="page-wrapper">
    <div class="page-header">
        <div>
            <h2 class="page-title">Admin Dashboard</h2>
            <p class="page-subtitle">
                Welcome back, ${adminName}. Here's what's happening.
            </p>
        </div>
    </div>

    <%-- Stats --%>
    <div class="stats-grid">
        <div class="stat-card">
            <div class="stat-icon">👥</div>
            <div class="stat-info">
                <div class="stat-value">${totalStudents}</div>
                <div class="stat-label">Total Students</div>
            </div>
        </div>
        <div class="stat-card">
            <div class="stat-icon">🧑‍🏫</div>
            <div class="stat-info">
                <div class="stat-value">${totalExaminers}</div>
                <div class="stat-label">Examiners</div>
            </div>
        </div>
        <div class="stat-card">
            <div class="stat-icon">📋</div>
            <div class="stat-info">
                <div class="stat-value">${totalExams}</div>
                <div class="stat-label">Total Exams</div>
            </div>
        </div>
        <div class="stat-card warning">
            <div class="stat-icon">⏳</div>
            <div class="stat-info">
                <div class="stat-value">${pendingRegistrations}</div>
                <div class="stat-label">Pending Approvals</div>
            </div>
        </div>
    </div>

    <%-- Quick Links --%>
    <h3 style="margin-bottom:1rem; color:var(--blue-darkest);">
        Quick Actions
    </h3>
    <div class="quick-links">
        <a href="/students" class="quick-link-card">
            <div class="quick-link-icon">👥</div>
            <div class="quick-link-text">
                <div class="link-title">Manage Students</div>
                <div class="link-desc">View, add, edit students</div>
            </div>
        </a>
        <a href="/admin/examiners" class="quick-link-card">
            <div class="quick-link-icon">🧑‍🏫</div>
            <div class="quick-link-text">
                <div class="link-title">Manage Examiners</div>
                <div class="link-desc">View, add, edit examiners</div>
            </div>
        </a>
        <a href="/admin/exams" class="quick-link-card">
            <div class="quick-link-icon">📋</div>
            <div class="quick-link-text">
                <div class="link-title">Manage Exams</div>
                <div class="link-desc">View, add, edit exams</div>
            </div>
        </a>
        <a href="/admin/allocations" class="quick-link-card">
            <div class="quick-link-icon">📌</div>
            <div class="quick-link-text">
                <div class="link-title">Examiner Allocations</div>
                <div class="link-desc">Assign examiners to exams</div>
            </div>
        </a>
        <a href="/admin/registrations" class="quick-link-card">
            <div class="quick-link-icon">✅</div>
            <div class="quick-link-text">
                <div class="link-title">Registration Approvals</div>
                <div class="link-desc">
                    <c:if test="${pendingRegistrations > 0}">
                        <span style="color:var(--warning);font-weight:700;">
                            ${pendingRegistrations} pending
                        </span>
                    </c:if>
                    <c:if test="${pendingRegistrations == 0}">
                        All up to date
                    </c:if>
                </div>
            </div>
        </a>
        <a href="/admin/recheck" class="quick-link-card">
            <div class="quick-link-icon">📋</div>
            <div class="quick-link-text">
                <div class="link-title">Recheck Requests</div>
                <div class="link-desc">
                    Review student recheck requests
                </div>
            </div>
        </a>
    </div>
</div>
</body>
</html>