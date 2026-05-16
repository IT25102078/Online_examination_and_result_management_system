<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Examiners — ExamSystem</title>
    <link rel="stylesheet" href="/css/style.css" />
</head>
<body>
<%@ include file="/WEB-INF/views/common/navbar.jsp" %>
<div class="page-wrapper">

    <div class="breadcrumb">
        <a href="/admin/dashboard">Dashboard</a>
        <span class="separator">›</span>
        <span class="current">Examiners</span>
    </div>

    <c:if test="${not empty success}">
        <div class="alert alert-success">✅ ${success}</div>
    </c:if>
    <c:if test="${not empty error}">
        <div class="alert alert-danger">⚠️ ${error}</div>
    </c:if>

    <div class="table-wrapper">
        <div class="table-toolbar">
            <form method="get" action="/admin/examiners" class="search-box">
                <span>🔍</span>
                <input type="text" name="search"
                       value="${search}" placeholder="Search examiners..." />
            </form>
            <div style="display:flex;gap:8px;">
                <c:if test="${not empty search}">
                    <a href="/admin/examiners" class="btn btn-secondary btn-sm">
                        Clear
                    </a>
                </c:if>
                <a href="/admin/examiners/add" class="btn btn-primary btn-sm">
                    + Add Examiner
                </a>
            </div>
        </div>

        <c:choose>
            <c:when test="${empty examiners}">
                <div class="empty-state">
                    <div class="empty-icon">🧑‍🏫</div>
                    <p>No examiners found.</p>
                </div>
            </c:when>
            <c:otherwise>
                <table>
                    <thead>
                        <tr>
                            <th>Full Name</th>
                            <th>Email</th>
                            <th>Department</th>
                            <th>Specialization</th>
                            <th>Type</th>
                            <th>Status</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="e" items="${examiners}">
                            <tr>
                                <td><strong>${e.fullName}</strong></td>
                                <td>${e.email}</td>
                                <td>${e.department}</td>
                                <td>${e.specialization}</td>
                                <td>
                                    <c:choose>
                                        <c:when test="${e.examinerType == 'SENIOR'}">
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
                                <td>
                                    <c:choose>
                                        <c:when test="${e.status == 'ACTIVE'}">
                                            <span class="badge badge-success">
                                                ACTIVE
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
                                        <a href="/admin/examiners/view/${e.examinerId}"
                                           class="btn btn-sm btn-outline">
                                            👁️ View
                                        </a>
                                        <a href="/admin/examiners/edit/${e.examinerId}"
                                           class="btn btn-sm btn-secondary">
                                            ✏️ Edit
                                        </a>
                                        <form method="post"
                                              action="/admin/examiners/delete/${e.examinerId}">
                                            <button type="submit"
                                                    class="btn btn-sm btn-danger"
                                                    onclick="return confirm('Delete this examiner?')">
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