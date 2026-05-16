<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Students — ExamSystem</title>
    <link rel="stylesheet" href="/css/style.css" />
</head>
<body>
<%@ include file="/WEB-INF/views/common/navbar.jsp" %>
<div class="page-wrapper">

    <div class="breadcrumb">
        <a href="/admin/dashboard">Dashboard</a>
        <span class="separator">›</span>
        <span class="current">Students</span>
    </div>

    <c:if test="${not empty success}">
        <div class="alert alert-success">✅ ${success}</div>
    </c:if>
    <c:if test="${not empty error}">
        <div class="alert alert-danger">⚠️ ${error}</div>
    </c:if>

    <div class="table-wrapper">
        <div class="table-toolbar">
            <form method="get" action="/students" class="search-box">
                <span>🔍</span>
                <input type="text" name="search"
                       value="${search}"
                       placeholder="Search students..." />
            </form>
            <div style="display:flex;gap:8px;">
                <c:if test="${not empty search}">
                    <a href="/students" class="btn btn-secondary btn-sm">
                        Clear
                    </a>
                </c:if>
                <a href="/students/register" class="btn btn-primary btn-sm">
                    + Add Student
                </a>
            </div>
        </div>

        <c:choose>
            <c:when test="${empty students}">
                <div class="empty-state">
                    <div class="empty-icon">👥</div>
                    <p>No students found.</p>
                </div>
            </c:when>
            <c:otherwise>
                <table>
                    <thead>
                        <tr>
                            <th>Reg No</th>
                            <th>Full Name</th>
                            <th>Email</th>
                            <th>Course</th>
                            <th>Year</th>
                            <th>Type</th>
                            <th>Status</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="s" items="${students}">
                            <tr>
                                <td>
                                    <span style="font-family:var(--font-mono);
                                          font-size:0.8rem;
                                          color:var(--blue-primary);
                                          font-weight:600;">
                                        ${s.registrationNo}
                                    </span>
                                </td>
                                <td><strong>${s.fullName}</strong></td>
                                <td>${s.email}</td>
                                <td>${s.course}</td>
                                <td>${s.yearOfStudy}</td>
                                <td>
                                    <span class="badge badge-info">
                                        ${s.studentType}
                                    </span>
                                </td>
                                <td>
                                    <c:choose>
                                        <c:when test="${s.accountStatus == 'ACTIVE'}">
                                            <span class="badge badge-success">
                                                ACTIVE
                                            </span>
                                        </c:when>
                                        <c:when test="${s.accountStatus == 'HELD'}">
                                            <span class="badge badge-danger">
                                                HELD
                                            </span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="badge badge-dark">
                                                INACTIVE
                                            </span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td>
                                    <div class="td-actions">
                                        <a href="/students/view/${s.studentId}"
                                           class="btn btn-sm btn-outline">
                                            👁️ View
                                        </a>
                                        <a href="/students/edit/${s.studentId}"
                                           class="btn btn-sm btn-secondary">
                                            ✏️ Edit
                                        </a>
                                        <form method="post"
                                              action="/students/delete/${s.studentId}">
                                            <button type="submit"
                                                    class="btn btn-sm btn-danger"
                                                    onclick="return confirm('Delete this student?')">
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