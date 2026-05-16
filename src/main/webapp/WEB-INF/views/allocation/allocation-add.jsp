<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Manage Allocations — ExamSystem</title>
    <link rel="stylesheet" href="/css/style.css" />
</head>
<body>
<%@ include file="/WEB-INF/views/common/navbar.jsp" %>
<div class="page-wrapper">

    <div class="breadcrumb">
        <a href="/admin/dashboard">Dashboard</a>
        <span class="separator">›</span>
        <a href="/admin/allocations">Allocations</a>
        <span class="separator">›</span>
        <span class="current">Manage</span>
    </div>

    <div class="page-header">
        <div>
            <h2 class="page-title">${exam.examName}</h2>
            <p class="page-subtitle">
                ${exam.subjectName} — ${exam.examDate}
            </p>
        </div>
        <a href="/admin/allocations" class="btn btn-secondary">
            ← Back
        </a>
    </div>

    <c:if test="${not empty success}">
        <div class="alert alert-success">✅ ${success}</div>
    </c:if>
    <c:if test="${not empty error}">
        <div class="alert alert-danger">⚠️ ${error}</div>
    </c:if>

    <%-- Currently allocated --%>
    <div class="table-wrapper" style="margin-bottom:2rem;">
        <div class="table-toolbar">
            <h3>Currently Allocated Examiners</h3>
        </div>
        <c:choose>
            <c:when test="${empty currentAllocations}">
                <div class="empty-state">
                    <div class="empty-icon">📌</div>
                    <p>No examiners allocated yet.</p>
                </div>
            </c:when>
            <c:otherwise>
                <table>
                    <thead>
                        <tr>
                            <th>Examiner Name</th>
                            <th>Type</th>
                            <th>Department</th>
                            <th>Specialization</th>
                            <th>Allocated By</th>
                            <th>Action</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="a" items="${currentAllocations}">
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
                                <td>${a.examiner.department}</td>
                                <td>${a.examiner.specialization}</td>
                                <td>${a.allocatedBy.fullName}</td>
                                <td>
                                    <form method="post"
                                          action="/admin/allocations/delete/${a.allocationId}">
                                        <input type="hidden"
                                               name="examId"
                                               value="${exam.examId}" />
                                        <button type="submit"
                                                class="btn btn-sm btn-danger"
                                                onclick="return confirm(
                                                    'Remove this allocation?')">
                                            🗑️ Remove
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

    <%-- Add new allocation --%>
    <div class="card" style="max-width:500px;">
        <div class="card-header">
            <h3>Add Examiner to This Exam</h3>
        </div>
        <div class="card-body">
            <c:choose>
                <c:when test="${empty availableExaminers}">
                    <p style="color:var(--grey-400);font-size:0.875rem;">
                        All active examiners are already allocated
                        to this exam.
                    </p>
                </c:when>
                <c:otherwise>
                    <form method="post" action="/admin/allocations/add">
                        <input type="hidden"
                               name="examId"
                               value="${exam.examId}" />
                        <div class="form-group"
                             style="margin-bottom:1rem;">
                            <label class="form-label">
                                Select Examiner
                            </label>
                            <select name="examinerId"
                                    class="form-control" required>
                                <option value="">
                                    -- Select Examiner --
                                </option>
                                <c:forEach var="e"
                                           items="${availableExaminers}">
                                    <option value="${e.examinerId}">
                                        ${e.fullName}
                                        (${e.examinerType})
                                        — ${e.department}
                                    </option>
                                </c:forEach>
                            </select>
                        </div>
                        <button type="submit" class="btn btn-primary">
                            📌 Allocate Examiner
                        </button>
                    </form>
                </c:otherwise>
            </c:choose>
        </div>
    </div>
</div>
</body>
</html>