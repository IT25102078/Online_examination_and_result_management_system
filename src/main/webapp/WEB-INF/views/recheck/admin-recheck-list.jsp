<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Recheck Requests — ExamSystem</title>
    <link rel="stylesheet" href="/css/style.css" />
</head>
<body>
<%@ include file="/WEB-INF/views/common/navbar.jsp" %>
<div class="page-wrapper">

    <div class="breadcrumb">
        <a href="/admin/dashboard">Dashboard</a>
        <span class="separator">›</span>
        <span class="current">Recheck Requests</span>
    </div>

    <div class="page-header">
        <div>
            <h2 class="page-title">Recheck Request Management</h2>
            <p class="page-subtitle">
                Review and process student result recheck requests
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
            <form method="get" action="/admin/recheck"
                  class="filter-bar">
                <label class="form-label" style="margin:0;">
                    Filter:
                </label>
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
                    <option value="REVIEWED"
                        ${selectedStatus == 'REVIEWED' ? 'selected' : ''}>
                        🔍 Reviewed
                    </option>
                </select>
            </form>
        </div>

        <c:choose>
            <c:when test="${empty requests}">
                <div class="empty-state">
                    <div class="empty-icon">📋</div>
                    <p>No recheck requests found.</p>
                </div>
            </c:when>
            <c:otherwise>
                <table>
                    <thead>
                        <tr>
                            <th>Student</th>
                            <th>Reg No</th>
                            <th>Exam</th>
                            <th>Current Marks</th>
                            <th>Reason</th>
                            <th>Submitted</th>
                            <th>Status</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="r" items="${requests}">
                            <tr>
                                <td>
                                    <strong>
                                        ${r.student.fullName}
                                    </strong>
                                </td>
                                <td>
                                    <span style="font-family:
                                          var(--font-mono);
                                          font-size:0.78rem;
                                          color:var(--blue-primary);
                                          font-weight:600;">
                                        ${r.student.registrationNo}
                                    </span>
                                </td>
                                <td>${r.exam.examName}</td>
                                <td>
                                    <strong>
                                        ${r.result.marksObtained}
                                    </strong>
                                    <span class="badge badge-${r.result.resultStatus == 'PASS' ? 'success' : 'danger'}"
                                          style="margin-left:4px;">
                                        ${r.result.resultStatus}
                                    </span>
                                </td>
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
                                    <div class="td-actions">
                                        <c:if test="${r.requestStatus == 'PENDING' or r.requestStatus == 'REVIEWED'}">
                                            <%-- Review form --%>
                                            <button type="button"
                                                    class="btn btn-sm btn-primary"
                                                    onclick="openReviewModal(
                                                        ${r.requestId},
                                                        '${r.student.fullName}',
                                                        '${r.exam.examName}')">
                                                🔍 Review
                                            </button>
                                        </c:if>
                                        <form method="post"
                                              action="/admin/recheck/delete/${r.requestId}">
                                            <button type="submit"
                                                    class="btn btn-sm btn-danger"
                                                    onclick="return confirm(
                                                        'Delete this request?')">
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

<%-- Review Modal --%>
<div id="reviewModal" style="display:none; position:fixed;
     top:0; left:0; width:100%; height:100%;
     background:rgba(0,0,0,0.5); z-index:9999;
     align-items:center; justify-content:center;">
    <div style="background:white; border-radius:16px;
                padding:2rem; width:480px; max-width:90%;
                box-shadow:0 20px 40px rgba(0,0,0,0.2);">
        <h3 style="color:#0d2247; margin-bottom:0.5rem;">
            🔍 Review Request
        </h3>
        <p id="reviewInfo"
           style="color:#64748b; font-size:0.875rem;
                  margin-bottom:1.5rem;"></p>

        <form id="reviewForm" method="post" action="">

            <div class="form-group"
                 style="margin-bottom:1rem;">
                <label class="form-label">Decision</label>
                <select name="requestStatus"
                        class="form-control" required>
                    <option value="REVIEWED">
                        🔍 Reviewed (No Change)
                    </option>
                    <option value="APPROVED">
                        ✅ Approved (Recheck Granted)
                    </option>
                    <option value="REJECTED">
                        ❌ Rejected (Recheck Denied)
                    </option>
                </select>
            </div>

            <div class="form-group"
                 style="margin-bottom:1.5rem;">
                <label class="form-label">Review Comment</label>
                <textarea name="reviewComment"
                          class="form-control"
                          rows="3"
                          placeholder="Add review comments..."
                          style="resize:vertical;"></textarea>
            </div>

            <div style="display:flex; gap:10px;">
                <button type="submit" class="btn btn-primary">
                    Submit Review
                </button>
                <button type="button"
                        class="btn btn-secondary"
                        onclick="closeReviewModal()">
                    Cancel
                </button>
            </div>
        </form>
    </div>
</div>

<script>
function openReviewModal(requestId, studentName, examName) {
    document.getElementById('reviewForm').action =
        '/admin/recheck/review/' + requestId;
    document.getElementById('reviewInfo').textContent =
        studentName + ' — ' + examName;
    const modal = document.getElementById('reviewModal');
    modal.style.display = 'flex';
}
function closeReviewModal() {
    document.getElementById('reviewModal').style.display = 'none';
}
</script>
</body>
</html>