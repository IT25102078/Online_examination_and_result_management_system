<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Edit Recheck Request — ExamSystem</title>
    <link rel="stylesheet" href="/css/style.css" />
</head>
<body>
<%@ include file="/WEB-INF/views/common/navbar.jsp" %>
<div class="page-wrapper">

    <div class="breadcrumb">
        <a href="/student/dashboard">Dashboard</a>
        <span class="separator">›</span>
        <a href="/student/recheck">Recheck Requests</a>
        <span class="separator">›</span>
        <span class="current">Edit Request</span>
    </div>

    <div class="page-header">
        <div>
            <h2 class="page-title">Edit Recheck Request</h2>
            <p class="page-subtitle">
                ${request.exam.examName} —
                ${request.exam.subjectName}
            </p>
        </div>
    </div>

    <div class="form-card" style="max-width:560px;">
        <form method="post"
              action="/student/recheck/edit/${request.requestId}">

            <div class="form-group"
                 style="margin-bottom:1.2rem;">
                <label class="form-label">Reason</label>
                <input type="text" name="requestReason"
                       class="form-control"
                       value="${request.requestReason}"
                       required />
            </div>

            <div class="form-group"
                 style="margin-bottom:1.5rem;">
                <label class="form-label">
                    Description (Optional)
                </label>
                <textarea name="requestDescription"
                          class="form-control"
                          rows="4"
                          style="resize:vertical;">${request.requestDescription}</textarea>
            </div>

            <div class="form-actions">
                <button type="submit" class="btn btn-primary">
                    💾 Save Changes
                </button>
                <a href="/student/recheck"
                   class="btn btn-secondary">Cancel</a>
            </div>
        </form>
    </div>
</div>
</body>
</html>