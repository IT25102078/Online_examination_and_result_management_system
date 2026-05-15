<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>My Registrations — ExamSystem</title>
    <link rel="stylesheet" href="/css/style.css" />
</head>
<body>
<%@ include file="/WEB-INF/views/common/navbar.jsp" %>
<div class="page-wrapper">

    <div class="breadcrumb">
        <a href="/student/dashboard">Dashboard</a>
        <span class="separator">›</span>
        <span class="current">My Registrations</span>
    </div>

    <div class="page-header">
        <div>
            <h2 class="page-title">My Exam Registrations</h2>
            <p class="page-subtitle">
                Track your exam registration request statuses
            </p>
        </div>
        <a href="/student/exams/register" class="btn btn-primary">
            + Register for Exam
        </a>
    </div>

    <div class="table-wrapper">
        <c:choose>
            <c:when test="${empty registrations}">
                <div class="empty-state">
                    <div class="empty-icon">📄</div>
                    <p>You have not registered for any exams yet.</p>
                </div>
            </c:when>
            <c:otherwise>
                <table>
                    <thead>
                        <tr>
                            <th>Exam Name</th>
                            <th>Subject</th>
                            <th>Exam Date</th>
                            <th>Registered On</th>
                            <th>Status</th>
                            <th>Remarks</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="r" items="${registrations}">
                            <tr>
                                <td><strong>${r.exam.examName}</strong></td>
                                <td>${r.exam.subjectName}</td>
                                <td>${r.exam.examDate}</td>
                                <td>${r.registeredDate}</td>
                                <td>
                                    <c:choose>
                                        <c:when test="${r.approvalStatus == 'APPROVED'}">
                                            <span class="badge badge-success">
                                                ✅ APPROVED
                                            </span>
                                        </c:when>
                                        <c:when test="${r.approvalStatus == 'REJECTED'}">
                                            <span class="badge badge-danger">
                                                ❌ REJECTED
                                            </span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="badge badge-warning">
                                                ⏳ PENDING
                                            </span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td>${r.remarks}</td>
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