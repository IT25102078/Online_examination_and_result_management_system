<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Registration Approvals — ExamSystem</title>
    <link rel="stylesheet" href="/css/style.css" />
</head>
<body>
<%@ include file="/WEB-INF/views/common/navbar.jsp" %>
<div class="page-wrapper">

    <div class="breadcrumb">
        <a href="/admin/dashboard">Dashboard</a>
        <span class="separator">›</span>
        <span class="current">Registration Approvals</span>
    </div>

    <div class="page-header">
        <div>
            <h2 class="page-title">Exam Registration Requests</h2>
            <p class="page-subtitle">
                Approve or reject student exam registration requests
            </p>
        </div>
    </div>

    <c:if test="${not empty success}">
        <div class="alert alert-success">✅ ${success}</div>
    </c:if>
    <c:if test="${not empty error}">
        <div class="alert alert-danger">⚠️ ${error}</div>
    </c:if>

    <div class="table-wrapper">
        <div class="table-toolbar">
            <form method="get" action="/admin/registrations"
                  class="filter-bar">
                <label class="form-label" style="margin:0;">Filter:</label>
                <select name="status" class="filter-select"
                        onchange="this.form.submit()">
                    <option value="">All Requests</option>
                    <option value="PENDING"
                        ${selectedStatus == 'PENDING' ? 'selected' : ''}>
                        ⏳ Pending
                    </option>
                    <option value="APPROVED"
                        ${selectedStatus == 'APPROVED' ? 'selected' : ''}>
                        ✅ Approved
                    </option>
                    <option value="REJECTED"
                        ${selectedStatus == 'REJECTED' ? 'selected' : ''}>
                        ❌ Rejected
                    </option>
                </select>
            </form>
        </div>

        <c:choose>
            <c:when test="${empty registrations}">
                <div class="empty-state">
                    <div class="empty-icon">✅</div>
                    <p>No registration requests found.</p>
                </div>
            </c:when>
            <c:otherwise>
                <table>
                    <thead>
                        <tr>
                            <th>Student</th>
                            <th>Reg No</th>
                            <th>Exam</th>
                            <th>Subject</th>
                            <th>Registered</th>
                            <th>Status</th>
                            <th>Remarks</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="r" items="${registrations}">
                            <tr>
                                <td>
                                    <strong>${r.student.fullName}</strong>
                                </td>
                                <td>
                                    <span style="font-family:var(--font-mono);
                                          font-size:0.78rem;
                                          color:var(--blue-primary);
                                          font-weight:600;">
                                        ${r.student.registrationNo}
                                    </span>
                                </td>
                                <td>${r.exam.examName}</td>
                                <td>${r.exam.subjectName}</td>
                                <td>${r.registeredDate}</td>
                                <td>
                                    <c:choose>
                                        <c:when test="${r.approvalStatus == 'APPROVED'}">
                                            <span class="badge badge-success">
                                                APPROVED
                                            </span>
                                        </c:when>
                                        <c:when test="${r.approvalStatus == 'REJECTED'}">
                                            <span class="badge badge-danger">
                                                REJECTED
                                            </span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="badge badge-warning">
                                                PENDING
                                            </span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td>${r.remarks}</td>
                                <td>
                                    <div class="td-actions">
                                        <c:if test="${r.approvalStatus == 'PENDING'}">
                                            <form method="post"
                                                  action="/admin/registrations/approve/${r.registrationId}">
                                                <input type="hidden"
                                                       name="remarks"
                                                       value="Approved by admin" />
                                                <button type="submit"
                                                        class="btn btn-sm btn-success">
                                                    ✅ Approve
                                                </button>
                                            </form>
                                            <form method="post"
                                                  action="/admin/registrations/reject/${r.registrationId}">
                                                <input type="hidden"
                                                       name="remarks"
                                                       value="Rejected by admin" />
                                                <button type="submit"
                                                        class="btn btn-sm btn-warning"
                                                        onclick="return confirm(
                                                            'Reject this registration?')">
                                                    ❌ Reject
                                                </button>
                                            </form>
                                        </c:if>
                                        <form method="post"
                                              action="/admin/registrations/delete/${r.registrationId}">
                                            <button type="submit"
                                                    class="btn btn-sm btn-danger"
                                                    onclick="return confirm(
                                                        'Delete this registration?')">
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

    <br/>
    <a href="/admin/dashboard" class="btn btn-secondary">
        ← Back to Dashboard
    </a>
</div>
</body>
</html>