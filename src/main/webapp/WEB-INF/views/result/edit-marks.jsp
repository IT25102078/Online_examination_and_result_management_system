<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Edit Marks — ExamSystem</title>
    <link rel="stylesheet" href="/css/style.css" />
</head>
<body>
<%@ include file="/WEB-INF/views/common/navbar.jsp" %>
<div class="page-wrapper">

    <div class="breadcrumb">
        <a href="/examiner/dashboard">Dashboard</a>
        <span class="separator">›</span>
        <span class="current">Edit Marks</span>
    </div>

    <div class="page-header">
        <div>
            <h2 class="page-title">Edit Marks</h2>
            <p class="page-subtitle">
                ${result.student.fullName} — ${result.exam.examName}
            </p>
        </div>
    </div>

    <%-- Current result summary --%>
    <div class="stats-grid" style="max-width:600px;">
        <div class="stat-card">
            <div class="stat-icon">📊</div>
            <div class="stat-info">
                <div class="stat-value">${result.marksObtained}</div>
                <div class="stat-label">Current Marks</div>
            </div>
        </div>
        <div class="stat-card">
            <div class="stat-icon">🎓</div>
            <div class="stat-info">
                <div class="stat-value">${result.grade}</div>
                <div class="stat-label">Current Grade</div>
            </div>
        </div>
        <div class="stat-card
            ${result.resultStatus == 'PASS' ? 'success' : 'danger'}">
            <div class="stat-icon">
                ${result.resultStatus == 'PASS' ? '✅' : '❌'}
            </div>
            <div class="stat-info">
                <div class="stat-value">${result.resultStatus}</div>
                <div class="stat-label">Current Status</div>
            </div>
        </div>
    </div>

    <div class="form-card" style="max-width:400px;">
        <form method="post"
              action="/examiner/results/edit/${result.resultId}">
            <div class="form-group" style="margin-bottom:1.5rem;">
                <label class="form-label">New Marks (0 — 100)</label>
                <input type="number"
                       name="marksObtained"
                       class="form-control"
                       value="${result.marksObtained}"
                       min="0" max="100"
                       step="0.01"
                       required />
                <small style="color:var(--grey-400);font-size:0.78rem;
                               margin-top:4px;display:block;">
                    Grade and status will be recalculated automatically.
                </small>
            </div>

            <div class="form-actions">
                <button type="submit" class="btn btn-primary">
                    💾 Update Marks
                </button>
                <a href="/examiner/dashboard" class="btn btn-secondary">
                    Cancel
                </a>
            </div>
        </form>
    </div>
</div>
</body>
</html>