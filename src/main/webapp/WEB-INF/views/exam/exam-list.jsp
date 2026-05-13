<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Exams — ExamSystem</title>
    <link rel="stylesheet" href="/css/style.css" />
</head>
<body>
<%@ include file="/WEB-INF/views/common/navbar.jsp" %>
<div class="page-wrapper">

    <div class="breadcrumb">
        <a href="/admin/dashboard">Dashboard</a>
        <span class="separator">›</span>
        <span class="current">Exams</span>
    </div>

    <c:if test="${not empty success}">
        <div class="alert alert-success">✅ ${success}</div>
    </c:if>
    <c:if test="${not empty error}">
        <div class="alert alert-danger">⚠️ ${error}</div>
    </c:if>

    <div class="table-wrapper">
        <div class="table-toolbar">
            <form method="get" action="/admin/exams" class="search-box">
                <span>🔍</span>
                <input type="text" name="search"
                       value="${search}"
                       placeholder="Search by name or subject..." />
            </form>
            <div style="display:flex;gap:8px;">
                <c:if test="${not empty search}">
                    <a href="/admin/exams" class="btn btn-secondary btn-sm">
                        Clear
                    </a>
                </c:if>
                <a href="/admin/exams/add" class="btn btn-primary btn-sm">
                    + Add Exam
                </a>
            </div>
        </div>

        <c:choose>
            <c:when test="${empty exams}">
                <div class="empty-state">
                    <div class="empty-icon">📋</div>
                    <p>No exams found.</p>
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
                            <th>Pass Marks</th>
                            <th>Status</th>
                            <th>Actions</th>
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
                                <td>${ex.examTime}</td>
                                <td>${ex.durationMinutes} mins</td>
                                <td>${ex.passMarks}</td>
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
                                    <div class="td-actions">
                                        <a href="/admin/exams/view/${ex.examId}"
                                           class="btn btn-sm btn-outline">
                                            👁️ View
                                        </a>
                                        <a href="/admin/exams/edit/${ex.examId}"
                                           class="btn btn-sm btn-secondary">
                                            ✏️ Edit
                                        </a>
                                        <form method="post"
                                              action="/admin/exams/delete/${ex.examId}">
                                            <button type="submit"
                                                    class="btn btn-sm btn-danger"
                                                    onclick="return confirm('Delete this exam?')">
                                                🗑️
                                            </button>
                                        </form>
                                    </div>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </c:otherwise>
        </c:choose>
    </div>
</div>
</body>
</html>
