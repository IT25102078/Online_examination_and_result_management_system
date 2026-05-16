<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Examiner Profile — ExamSystem</title>
    <link rel="stylesheet" href="/css/style.css" />
</head>
<body>
<%@ include file="/WEB-INF/views/common/navbar.jsp" %>
<div class="page-wrapper">

    <div class="breadcrumb">
        <a href="/admin/dashboard">Dashboard</a>
        <span class="separator">›</span>
        <a href="/admin/examiners">Examiners</a>
        <span class="separator">›</span>
        <span class="current">View Profile</span>
    </div>

    <div class="page-header">
        <div>
            <h2 class="page-title">Examiner Profile</h2>
            <p class="page-subtitle">${examiner.fullName}</p>
        </div>
        <div style="display:flex;gap:8px;">
            <a href="/admin/examiners/edit/${examiner.examinerId}"
               class="btn btn-primary">✏️ Edit</a>
            <a href="/admin/examiners" class="btn btn-secondary">← Back</a>
        </div>
    </div>

    <div class="card" style="max-width:700px;">
        <div class="card-header">
            <h3>Examiner Details</h3>
            <c:choose>
                <c:when test="${examiner.status == 'ACTIVE'}">
                    <span class="badge badge-success">ACTIVE</span>
                </c:when>
                <c:otherwise>
                    <span class="badge badge-dark">INACTIVE</span>
                </c:otherwise>
            </c:choose>
        </div>
        <div class="card-body" style="padding:0;">
            <table class="profile-table">
                <tr><th>Full Name</th><td>${examiner.fullName}</td></tr>
                <tr><th>Email</th><td>${examiner.email}</td></tr>
                <tr><th>Phone</th><td>${examiner.phone}</td></tr>
                <tr><th>Department</th><td>${examiner.department}</td></tr>
                <tr><th>Specialization</th><td>${examiner.specialization}</td></tr>
                <tr>
                    <th>Type</th>
                    <td>
                        <c:choose>
                            <c:when test="${examiner.examinerType == 'SENIOR'}">
                                <span class="badge badge-info">SENIOR</span>
                            </c:when>
                            <c:otherwise>
                                <span class="badge badge-dark">ASSISTANT</span>
                            </c:otherwise>
                        </c:choose>
                    </td>
                </tr>
                <tr><th>Username</th>
                    <td>
                        <span style="font-family:var(--font-mono);
                              color:var(--blue-primary);font-weight:600;">
                            ${examiner.username}
                        </span>
                    </td>
                </tr>
                <tr><th>Created At</th><td>${examiner.createdAt}</td></tr>
            </table>
        </div>
    </div>
</div>
</body>
</html>