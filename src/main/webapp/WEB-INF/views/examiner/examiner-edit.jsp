<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<!DOCTYPE html>
<html>
<head>
    <title>Edit Examiner — ExamSystem</title>
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
        <span class="current">Edit Examiner</span>
    </div>

    <div class="page-header">
        <div>
            <h2 class="page-title">Edit Examiner</h2>
            <p class="page-subtitle">Update examiner details</p>
        </div>
    </div>

    <div class="form-card" style="max-width:760px;">
        <form:form method="post"
                   action="/admin/examiners/edit/${examiner.examinerId}"
                   modelAttribute="examiner">

            <form:hidden path="password" />
            <form:hidden path="createdAt" />

            <div class="form-grid">

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
                    <label class="form-label">Phone</label>
                    <form:input path="phone" cssClass="form-control" />
                </div>

                <div class="form-group">
                    <label class="form-label">Department</label>
                    <form:input path="department" cssClass="form-control" />
                </div>

                <div class="form-group">
                    <label class="form-label">Specialization</label>
                    <form:input path="specialization" cssClass="form-control" />
                </div>

                <div class="form-group">
                    <label class="form-label">Examiner Type</label>
                    <form:select path="examinerType" cssClass="form-control">
                        <form:option value="ASSISTANT">Assistant</form:option>
                        <form:option value="SENIOR">Senior</form:option>
                    </form:select>
                </div>

                <div class="form-group">
                    <label class="form-label">Username</label>
                    <form:input path="username" cssClass="form-control"
                                readonly="true" />
                </div>

                <div class="form-group">
                    <label class="form-label">Status</label>
                    <form:select path="status" cssClass="form-control">
                        <form:option value="ACTIVE">Active</form:option>
                        <form:option value="INACTIVE">Inactive</form:option>
                    </form:select>
                </div>

            </div>

            <div class="form-actions">
                <button type="submit" class="btn btn-primary">
                    💾 Save Changes
                </button>
                <a href="/admin/examiners" class="btn btn-secondary">Cancel</a>
            </div>
        </form:form>
    </div>
</div>
</body>
</html>