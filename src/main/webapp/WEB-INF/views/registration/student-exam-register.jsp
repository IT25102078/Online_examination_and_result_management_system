<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Register for Exam — ExamSystem</title>
    <link rel="stylesheet" href="/css/style.css" />
</head>
<body>
<%@ include file="/WEB-INF/views/common/navbar.jsp" %>
<div class="page-wrapper">

    <div class="breadcrumb">
        <a href="/student/dashboard">Dashboard</a>
        <span class="separator">›</span>
        <span class="current">Register for Exam</span>
    </div>

    <div class="page-header">
        <div>
            <h2 class="page-title">Available Exams</h2>
            <p class="page-subtitle">
                Select an exam to submit a registration request
            </p>
        </div>
        <a href="/student/exams/my-registrations" class="btn btn-secondary">
            📄 My Registrations
        </a>
    </div>

    <c:if test="${not empty success}">
        <div class="alert alert-success">✅ ${success}</div>
    </c:if>
    <c:if test="${not empty error}">
        <div class="alert alert-danger">⚠️ ${error}</div>
    </c:if>

    <div class="table-wrapper">
        <c:choose>
            <c:when test="${empty availableExams}">
                <div class="empty-state">
                    <div class="empty-icon">📋</div>
                    <p>No available exams to register for at the moment.</p>
                </div>
            </c:when>
            <c:otherwise>
                <table>
                    <thead>
                        <tr>
                            <th>Code</th>
                            <th>Exam Name</th>
                            <th>Subject</th>
                            <th>Date</th>
                            <th>Time</th>
                            <th>Duration</th>
                            <th>Action</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="ex" items="${availableExams}">
                            <tr>
                                <td>
                                    <span style="font-family:var(--font-mono);
                                          font-size:0.8rem;
                                          color:var(--blue-primary);
                                          font-weight:600;">
                                        ${ex.examCode}
                                    </span>
                                </td>
                                <td><strong>${ex.examName}</strong></td>
                                <td>${ex.subjectName}</td>
                                <td>${ex.examDate}</td>
                                <td>${ex.examTime}</td>
                                <td>${ex.durationMinutes} mins</td>
                                <td>
                                    <form method="post"
                                          action="/student/exams/register">
                                        <input type="hidden"
                                               name="examId"
                                               value="${ex.examId}" />
                                        <button type="submit"
                                                class="btn btn-sm btn-primary"
                                                onclick="return confirm(
                                                    'Register for ${ex.examName}?')">
                                            📝 Register
                                        </button>
                                    </form>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </c:otherwise>
        </c:choose>
    </div>

    <br/>
    <a href="/student/dashboard" class="btn btn-secondary">
        ← Back to Dashboard
    </a>
</div>
</body>
</html>