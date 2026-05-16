<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Examiner Allocations — ExamSystem</title>
    <link rel="stylesheet" href="/css/style.css" />
</head>
<body>
<%@ include file="/WEB-INF/views/common/navbar.jsp" %>
<div class="page-wrapper">

    <div class="breadcrumb">
        <a href="/admin/dashboard">Dashboard</a>
        <span class="separator">›</span>
        <span class="current">Examiner Allocations</span>
    </div>

    <div class="page-header">
        <div>
            <h2 class="page-title">Examiner Allocations</h2>
            <p class="page-subtitle">
                Assign examiners to exams
            </p>
        </div>
    </div>

    <c:if test="${not empty success}">
        <div class="alert alert-success">✅ ${success}</div>
    </c:if>
    <c:if test="${not empty error}">
        <div class="alert alert-danger">⚠️ ${error}</div>
    </c:if>

    <%-- Exam list with manage links --%>
    <div class="table-wrapper" style="margin-bottom:2rem;">
        <div class="table-toolbar">
            <h3>Manage by Exam</h3>
        </div>
        <table>
            <thead>
                <tr>
                    <th>Exam Code</th>
                    <th>Exam Name</th>
                    <th>Subject</th>
                    <th>Date</th>
                    <th>Status</th>
                    <th>Action</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="ex" items="${exams}">
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
                        <td>
                            <c:choose>
                                <c:when test="${ex.status == 'ACTIVE'}">
                                    <span class="badge badge-success">
                                        ACTIVE
                                    </span>
                                </c:when>
                                <c:when test="${ex.status == 'CANCELLED'}">
                                    <span class="badge badge-danger">
                                        CANCELLED
                                    </span>
                                </c:when>
                                <c:otherwise>
                                    <span class="badge badge-dark">
                                        COMPLETED
                                    </span>
                                </c:otherwise>
                            </c:choose>
                        </td>
                        <td>
                            <c:if test="${ex.status != 'CANCELLED'}">
                                <a href="/admin/allocations/add?examId=${ex.examId}"
                                   class="btn btn-sm btn-primary">
                                    📌 Manage
                                </a>
                            </c:if>
                            <c:if test="${ex.status == 'CANCELLED'}">
                                <span style="color:var(--grey-400);
                                      font-size:0.8rem;">
                                    N/A
                                </span>
                            </c:if>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>

    <%-- All allocations overview --%>
    <div class="table-wrapper">
        <div class="table-toolbar">
            <h3>All Current Allocations</h3>
        </div>
        <c:choose>
            <c:when test="${empty allocations}">
                <div class="empty-state">
                    <div class="empty-icon">📌</div>
                    <p>No allocations found yet.</p>
                </div>
            </c:when>
            <c:otherwise>
                <table>
                    <thead>
                        <tr>
                            <th>Examiner Name</th>
                            <th>Type</th>
                            <th>Exam Name</th>
                            <th>Subject</th>
                            <th>Allocated By</th>
                            <th>Date</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="a" items="${allocations}">
                            <tr>
                                <td>
                                    <strong>${a.examiner.fullName}</strong>
                                </td>
                                <td>
                                    <c:choose>
                                        <c:when test="${a.examiner.examinerType == 'SENIOR'}">
                                            <span class="badge badge-info">
                                                SENIOR
                                            </span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="badge badge-dark">
                                                ASSISTANT
                                            </span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td>${a.exam.examName}</td>
                                <td>${a.exam.subjectName}</td>
                                <td>${a.allocatedBy.fullName}</td>
                                <td>${a.allocatedDate}</td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </c:otherwise>
        </c:choose>
    </div>

    <br/>
    <a href="/admin/dashboard" class="btn btn-secondary">
        ← Back to Dashboard
    </a>
</div>
</body>
</html>