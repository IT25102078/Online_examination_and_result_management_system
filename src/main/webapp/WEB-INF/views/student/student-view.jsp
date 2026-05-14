<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Student Profile — ExamSystem</title>
    <link rel="stylesheet" href="/css/style.css" />
</head>
<body>
<%@ include file="/WEB-INF/views/common/navbar.jsp" %>
<div class="page-wrapper">

    <div class="breadcrumb">
        <a href="/admin/dashboard">Dashboard</a>
        <span class="separator">›</span>
        <a href="/students">Students</a>
        <span class="separator">›</span>
        <span class="current">View Profile</span>
    </div>

    <div class="page-header">
        <div>
            <h2 class="page-title">Student Profile</h2>
            <p class="page-subtitle">${student.fullName}</p>
        </div>
        <div style="display:flex;gap:8px;">
            <a href="/students/edit/${student.studentId}"
               class="btn btn-primary">✏️ Edit</a>
            <a href="/students" class="btn btn-secondary">← Back</a>
        </div>
    </div>

    <div class="card" style="max-width:700px;">
        <div class="card-header">
            <h3>Personal Details</h3>
            <c:choose>
                <c:when test="${student.accountStatus == 'ACTIVE'}">
                    <span class="badge badge-success">ACTIVE</span>
                </c:when>
                <c:when test="${student.accountStatus == 'HELD'}">
                    <span class="badge badge-danger">HELD</span>
                </c:when>
                <c:otherwise>
                    <span class="badge badge-dark">INACTIVE</span>
                </c:otherwise>
            </c:choose>
        </div>
        <div class="card-body" style="padding:0;">
            <table class="profile-table">
                <tr>
                    <th>Registration No</th>
                    <td>
                        <span style="font-family:var(--font-mono);
                              color:var(--blue-primary);font-weight:600;">
                            ${student.registrationNo}
                        </span>
                    </td>
                </tr>
                <tr><th>Full Name</th><td>${student.fullName}</td></tr>
                <tr><th>Email</th><td>${student.email}</td></tr>
                <tr><th>Contact No</th><td>${student.contactNo}</td></tr>
                <tr><th>Department</th><td>${student.department}</td></tr>
                <tr><th>Course</th><td>${student.course}</td></tr>
                <tr><th>Year of Study</th><td>Year ${student.yearOfStudy}</td></tr>
                <tr>
                    <th>Student Type</th>
                    <td>
                        <span class="badge badge-info">
                            ${student.studentType}
                        </span>
                    </td>
                </tr>
                <tr><th>Registered At</th><td>${student.createdAt}</td></tr>
            </table>
        </div>
    </div>
</div>
</body>
</html>