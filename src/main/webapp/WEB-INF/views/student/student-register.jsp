<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<!DOCTYPE html>
<html>
<head>
    <title>Register Student — ExamSystem</title>
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
        <span class="current">Register</span>
    </div>

    <div class="page-header">
        <div>
            <h2 class="page-title">Register New Student</h2>
            <p class="page-subtitle">Fill in the details to create a student account</p>
        </div>
    </div>

    <c:if test="${not empty error}">
        <div class="alert alert-danger">⚠️ ${error}</div>
    </c:if>

    <div class="form-card" style="max-width:760px;">
        <form:form method="post" action="/students/register" modelAttribute="student">
            <div class="form-grid">

                <div class="form-group">
                    <label class="form-label">Registration No</label>
                    <form:input path="registrationNo" cssClass="form-control"
                                placeholder="e.g. IT2026001" />
                    <form:errors path="registrationNo" cssClass="form-error" />
                </div>

                <div class="form-group">
                    <label class="form-label">Full Name</label>
                    <form:input path="fullName" cssClass="form-control"
                                placeholder="Enter full name" />
                    <form:errors path="fullName" cssClass="form-error" />
                </div>

                <div class="form-group">
                    <label class="form-label">Email</label>
                    <form:input path="email" cssClass="form-control"
                                placeholder="student@example.com" />
                    <form:errors path="email" cssClass="form-error" />
                </div>

                <div class="form-group">
                    <label class="form-label">Contact No</label>
                    <form:input path="contactNo" cssClass="form-control"
                                placeholder="07XXXXXXXX" />
                </div>

                <div class="form-group">
                    <label class="form-label">Department</label>
                    <form:input path="department" cssClass="form-control"
                                placeholder="e.g. Computing" />
                </div>

                <div class="form-group">
                    <label class="form-label">Course</label>
                    <form:input path="course" cssClass="form-control"
                                placeholder="e.g. Information Technology" />
                </div>

                <div class="form-group">
                    <label class="form-label">Year of Study</label>
                    <form:input path="yearOfStudy" cssClass="form-control"
                                type="number" placeholder="1" />
                </div>

                <div class="form-group">
                    <label class="form-label">Student Type</label>
                    <form:select path="studentType" cssClass="form-control">
                        <form:option value="REGULAR">Regular</form:option>
                        <form:option value="REPEAT">Repeat</form:option>
                    </form:select>
                </div>

                <div class="form-group span-2">
                    <label class="form-label">Password</label>
                    <form:input path="password" cssClass="form-control"
                                type="password" placeholder="Create a password" />
                    <form:errors path="password" cssClass="form-error" />
                </div>

            </div>

            <div class="form-actions">
                <button type="submit" class="btn btn-primary">
                    ✅ Register Student
                </button>
<%--                <a href="/students" class="btn btn-secondary">Cancel</a>--%>
                <c:choose>
                    <c:when test="${sessionScope.role == 'ADMIN'}">
                        <a href="/students" class="btn btn-secondary">Cancel</a>
                    </c:when>
                    <c:otherwise>
                        <a href="/login" class="btn btn-secondary">Cancel</a>
                    </c:otherwise>
                </c:choose>
            </div>
        </form:form>
    </div>
</div>
</body>
</html>