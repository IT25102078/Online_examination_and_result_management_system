<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Examiner Dashboard — ExamSystem</title>
    <link rel="stylesheet" href="/css/style.css" />
</head>
<body>
<%@ include file="/WEB-INF/views/common/navbar.jsp" %>
<div class="page-wrapper">

    <div class="page-header">
        <div>
            <h2 class="page-title">Examiner Dashboard</h2>
            <p class="page-subtitle">
                ${examiner.fullName} —
                <span style="color:var(--blue-bright);">
                    ${privileges}
                </span>
            </p>
        </div>
    </div>

    <c:if test="${not empty success}">
        <div class="alert alert-success">✅ ${success}</div>
    </c:if>
    <c:if test="${not empty error}">
        <div class="alert alert-danger">⚠️ ${error}</div>
    </c:if>

    <%-- ── Allocated Exams Section ─────────────────────── --%>
    <h3 style="margin-bottom:1rem;color:var(--blue-darkest);">
        📌 My Allocated Exams
    </h3>

    <c:choose>
        <c:when test="${empty allocatedExams}">
            <div class="card" style="margin-bottom:2rem;">
                <div class="empty-state">
                    <div class="empty-icon">📋</div>
                    <p>No exams allocated to you yet.</p>
                </div>
            </div>
        </c:when>
        <c:otherwise>
            <div class="quick-links" style="margin-bottom:2rem;">
                <c:forEach var="alloc" items="${allocatedExams}">
                    <a href="/examiner/results/add?examId=${alloc.exam.examId}"
                       class="quick-link-card">
                        <div class="quick-link-icon">📝</div>
                        <div class="quick-link-text">
                            <div class="link-title">
                                ${alloc.exam.examName}
                            </div>
                            <div class="link-desc">
                                ${alloc.exam.subjectName}
                                — ${alloc.exam.examDate}
                            </div>
                            <div style="margin-top:6px;">
                                <c:choose>
                                    <c:when test="${alloc.exam.status == 'ACTIVE'}">
                                        <span class="badge badge-success">
                                            ACTIVE
                                        </span>
                                    </c:when>
                                    <c:when test="${alloc.exam.status == 'COMPLETED'}">
                                        <span class="badge badge-dark">
                                            COMPLETED
                                        </span>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="badge badge-danger">
                                            CANCELLED
                                        </span>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </div>
                    </a>

                    <a href="/examiner/recheck" class="quick-link-card">
                        <div class="quick-link-icon">📋</div>
                        <div class="quick-link-text">
                            <div class="link-title">Recheck Requests</div>
                            <div class="link-desc">
                                Review student recheck requests
                            </div>
                        </div>
                    </a>
                </c:forEach>
            </div>
        </c:otherwise>
    </c:choose>

    <%-- ── Results Section ─────────────────────────────── --%>
    <div class="table-wrapper" style="margin-bottom:2rem;">
        <div class="table-toolbar">
            <h3>Results Entered</h3>
            <span style="font-size:0.8rem;color:var(--grey-400);">
                Click an exam above to add marks
            </span>
        </div>
        <c:choose>
            <c:when test="${empty results}">
                <div class="empty-state">
                    <div class="empty-icon">📊</div>
                    <p>No results entered yet.</p>
                </div>
            </c:when>
            <c:otherwise>
                <table>
                    <thead>
                        <tr>
                            <th>Student</th>
                            <th>Exam</th>
                            <th>Marks</th>
                            <th>Grade</th>
                            <th>Status</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="r" items="${results}">
                            <tr>
                                <td>
                                    <strong>${r.student.fullName}</strong>
                                </td>
                                <td>${r.exam.examName}</td>
                                <td>
                                    <strong>${r.marksObtained}</strong>
                                </td>
                                <td>
                                    <span class="badge badge-info">
                                        ${r.grade}
                                    </span>
                                </td>
                                <td>
                                    <c:choose>
                                        <c:when test="${r.resultStatus == 'PASS'}">
                                            <span class="badge badge-success">
                                                ✅ PASS
                                            </span>
                                        </c:when>
                                        <c:when test="${r.resultStatus == 'FAIL'}">
                                            <span class="badge badge-danger">
                                                ❌ FAIL
                                            </span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="badge badge-warning">
                                                ⏳ PENDING
                                            </span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td>
                                    <div class="td-actions">
                                        <a href="/examiner/results/edit/${r.resultId}"
                                           class="btn btn-sm btn-secondary">
                                            ✏️ Edit
                                        </a>
                                        <form method="post"
                                              action="/examiner/results/delete/${r.resultId}">
                                            <button type="submit"
                                                    class="btn btn-sm btn-danger"
                                                    onclick="return confirm(
                                                        'Delete this result?')">
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

    <%-- ── Holds Section — SENIOR only ────────────────── --%>
    <c:if test="${canHold}">
        <div class="table-wrapper">
            <div class="table-toolbar">
                <h3>🔒 Student Holds</h3>
            </div>
            <c:choose>
                <c:when test="${empty holds}">
                    <div class="empty-state">
                        <div class="empty-icon">🔓</div>
                        <p>No holds placed yet.</p>
                    </div>
                </c:when>
                <c:otherwise>
                    <table>
                        <thead>
                            <tr>
                                <th>Student</th>
                                <th>Exam</th>
                                <th>Reason</th>
                                <th>Status</th>
                                <th>Hold Date</th>
                                <th>Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="h" items="${holds}">
                                <tr>
                                    <td>
                                        <strong>
                                            ${h.student.fullName}
                                        </strong>
                                    </td>
                                    <td>${h.exam.examName}</td>
                                    <td>${h.reason}</td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${h.holdStatus == 'ACTIVE'}">
                                                <span class="badge badge-danger">
                                                    ACTIVE
                                                </span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="badge badge-success">
                                                    RELEASED
                                                </span>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td>${h.holdDate}</td>
                                    <td>
                                        <div class="td-actions">
                                            <c:if test="${h.holdStatus == 'ACTIVE'}">
                                                <form method="post"
                                                      action="/examiner/holds/release/${h.holdId}">
                                                    <button type="submit"
                                                            class="btn btn-sm btn-success">
                                                        🔓 Release
                                                    </button>
                                                </form>
                                            </c:if>
                                            <form method="post"
                                                  action="/examiner/holds/delete/${h.holdId}">
                                                <button type="submit"
                                                        class="btn btn-sm btn-danger"
                                                        onclick="return confirm(
                                                            'Delete hold?')">
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
    </c:if>

</div>
</body>
</html>