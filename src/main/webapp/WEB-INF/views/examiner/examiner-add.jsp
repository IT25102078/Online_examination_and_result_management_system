<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<!DOCTYPE html>
<html>
<head>
    <title>Add Examiner — ExamSystem</title>
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
        <span class="current">Add Examiner</span>
    </div>

    <div class="page-header">
        <div>
            <h2 class="page-title">Add New Examiner</h2>
            <p class="page-subtitle">Create a new examiner account</p>
        </div>
    </div>

    <c:if test="${not empty error}">
        <div class="alert alert-danger">⚠️ ${error}</div>
    </c:if>

    <div class="form-card" style="max-width:760px;">
        <form:form method="post" action="/admin/examiners/add"
                   modelAttribute="examiner">
            <div class="form-grid">

                <div class="form-group">
                    <label class="form-label">Full Name</label>
                    <form:input path="fullName" cssClass="form-control"
                                placeholder="Dr. / Prof. / Mr. / Ms." />
                    <form:errors path="fullName" cssClass="form-error" />
                </div>

                <div class="form-group">
                    <label class="form-label">Email</label>
                    <form:input path="email" cssClass="form-control"
                                placeholder="examiner@example.com" />
                    <form:errors path="email" cssClass="form-error" />
                </div>

                <div class="form-group">
                    <label class="form-label">Phone</label>
                    <form:input path="phone" cssClass="form-control"
                                placeholder="07XXXXXXXX" />
                </div>

                <div class="form-group">
                    <label class="form-label">Department</label>
                    <form:input path="department" cssClass="form-control"
                                placeholder="e.g. Computing" />
                </div>

                <div class="form-group">
                    <label class="form-label">Specialization</label>
                    <form:input path="specialization" cssClass="form-control"
                                placeholder="e.g. Database Systems" />
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
                                placeholder="unique_username" />
                    <form:errors path="username" cssClass="form-error" />
                </div>

                <div class="form-group">
                    <label class="form-label">Password</label>
                    <form:input path="password" cssClass="form-control"
                                type="password" placeholder="Create a password" />
                    <form:errors path="password" cssClass="form-error" />
                </div>

            </div>

            <div class="form-actions">
                <button type="submit" class="btn btn-primary">
                    ✅ Add Examiner
                </button>
                <a href="/admin/examiners" class="btn btn-secondary">Cancel</a>
            </div>
        </form:form>
    </div>
</div>
</body>
</html>