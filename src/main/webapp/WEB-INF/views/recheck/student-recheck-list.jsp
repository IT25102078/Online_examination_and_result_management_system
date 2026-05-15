<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>My Recheck Requests — ExamSystem</title>
    <link rel="stylesheet" href="/css/style.css" />
</head>
<body>
<%@ include file="/WEB-INF/views/common/navbar.jsp" %>
<div class="page-wrapper">

    <div class="breadcrumb">
        <a href="/student/dashboard">Dashboard</a>
        <span class="separator">›</span>
        <a href="/student/results">My Results</a>
        <span class="separator">›</span>
        <span class="current">Recheck Requests</span>
    </div>

    <div class="page-header">
        <div>
            <h2 class="page-title">My Recheck Requests</h2>
            <p class="page-subtitle">
                Track your result recheck request statuses
            </p>
        </div>
        <a href="/student/results" class="btn btn-secondary">
            ← My Results
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
            <c:when test="${empty requests}">
                <div class="empty-state">
                    <div class="empty-icon">📋</div>
                    <p>No recheck requests submitted yet.</p>
                </div>
            </c:when>
            <c:otherwise>
                <table>
                    <thead>
                        <tr>
                            <th>Exam Name</th>
                            <th>Subject</th>
                            <th>Reason</th>
                            <th>Submitted</th>
                            <th>Status</th>
                            <th>Review Comment</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="r" items="${requests}">
                            <tr>
                                <td>
                                    <strong>${r.exam.examName}</strong>
                                </td>
                                <td>${r.exam.subjectName}</td>
                                <td>${r.requestReason}</td>
                                <td>${r.submittedDate}</td>
                                <td>
                                    <c:choose>
                                        <c:when test="${r.requestStatus == 'PENDING'}">
                                            <span class="badge badge-warning">
                                                ⏳ PENDING
                                            </span>
                                        </c:when>
                                        <c:when test="${r.requestStatus == 'APPROVED'}">
                                            <span class="badge badge-success">
                                                ✅ APPROVED
                                            </span>
                                        </c:when>
                                        <c:when test="${r.requestStatus == 'REJECTED'}">
                                            <span class="badge badge-danger">
                                                ❌ REJECTED
                                            </span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="badge badge-info">
                                                🔍 REVIEWED
                                            </span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td>
                                    <c:choose>
                                        <c:when test="${not empty r.reviewComment}">
                                            ${r.reviewComment}
                                        </c:when>
                                        <c:otherwise>
                                            <span style="color:var(--grey-400);">
                                                Not reviewed yet
                                            </span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td>
                                    <div class="td-actions">
                                        <c:if test="${r.requestStatus == 'PENDING'}">
                                            <a href="/student/recheck/edit/${r.requestId}"
                                               class="btn btn-sm btn-secondary">
                                                ✏️ Edit
                                            </a>
                                            <form method="post"
                                                  action="/student/recheck/delete/${r.requestId}">
                                                <button type="submit"
                                                        class="btn btn-sm btn-danger"
                                                        onclick="return confirm(
                                                            'Delete this request?')">
                                                    🗑️
                                                </button>
                                            </form>
                                        </c:if>
                                        <c:if test="${r.requestStatus != 'PENDING'}">
                                            <span style="color:var(--grey-400);
                                                  font-size:0.8rem;">
                                                Under Review
                                            </span>
                                        </c:if>
                                    </div>
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