<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<!DOCTYPE html>
<html>
<head>
    <title>Edit Student — ExamSystem</title>
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
        <span class="current">Edit Student</span>
    </div>

    <div class="page-header">
        <div>
            <h2 class="page-title">Edit Student</h2>
            <p class="page-subtitle">Update student details</p>
        </div>
    </div>

    <div class="form-card" style="max-width:760px;">
        <form:form method="post"
                   action="/students/edit/${student.studentId}"
                   modelAttribute="student">

            <form:hidden path="password" />
            <form:hidden path="createdAt" />

            <div class="form-grid">

                <div class="form-group">
                    <label class="form-label">Registration No</label>
                    <form:input path="registrationNo"
                                cssClass="form-control" readonly="true" />
                </div>

                <div class="form-group">
                    <label class="form-label">Full Name</label>
                    <form:input path="fullName" cssClass="form-control" />
                    <form:errors path="fullName" cssClass="form-error" />
                </div>

                <div class="form-group">
                    <label class="form-label">Email</label>
                    <form:input path="email" cssClass="form-control" />
                    <form:errors path="email" cssClass="form-error" />
                </div>

                <div class="form-group">
                    <label class="form-label">Contact No</label>
                    <form:input path="contactNo" cssClass="form-control" />
                </div>

                <div class="form-group">
                    <label class="form-label">Department</label>
                    <form:input path="department" cssClass="form-control" />
                </div>

                <div class="form-group">
                    <label class="form-label">Course</label>
                    <form:input path="course" cssClass="form-control" />
                </div>

                <div class="form-group">
                    <label class="form-label">Year of Study</label>
                    <form:input path="yearOfStudy"
                                cssClass="form-control" type="number" />
                </div>

                <div class="form-group">
                    <label class="form-label">Student Type</label>
                    <form:select path="studentType" cssClass="form-control">
                        <form:option value="REGULAR">Regular</form:option>
                        <form:option value="REPEAT">Repeat</form:option>
                    </form:select>
                </div>

                <div class="form-group">
                    <label class="form-label">Account Status</label>
                    <form:select path="accountStatus" cssClass="form-control">
                        <form:option value="ACTIVE">Active</form:option>
                        <form:option value="INACTIVE">Inactive</form:option>
                        <form:option value="HELD">Held</form:option>
                    </form:select>
                </div>

            </div>

            <div class="form-actions">
                <button type="submit" class="btn btn-primary">
                    💾 Save Changes
                </button>
                <a href="/students" class="btn btn-secondary">Cancel</a>
            </div>
        </form:form>
    </div>
</div>
</body>
</html>