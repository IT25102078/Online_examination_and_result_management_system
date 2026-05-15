<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Login — ExamSystem</title>
    <link rel="stylesheet" href="/css/style.css" />
</head>
<body>
<div class="login-page">
    <div class="login-card">

        <div class="login-logo">
            <div class="logo-icon">🎓</div>
            <h1>ExamSystem</h1>
            <p>Online Examination & Result Management</p>
        </div>

        <c:if test="${not empty success}">
            <div class="alert alert-success">✅ ${success}</div>
        </c:if>
        <c:if test="${not empty error}">
            <div class="alert alert-danger">⚠️ ${error}</div>
        </c:if>

        <div class="login-divider"><span>Select Role</span></div>

        <form method="post" action="/login">
            <div class="role-selector">
                <div class="role-option">
                    <input type="radio" name="role"
                           id="role-admin" value="ADMIN" checked />
                    <label for="role-admin">
                        <span class="role-icon">🛡️</span>
                        Admin
                    </label>
                </div>
                <div class="role-option">
                    <input type="radio" name="role"
                           id="role-student" value="STUDENT" />
                    <label for="role-student">
                        <span class="role-icon">🎒</span>
                        Student
                    </label>
                </div>
                <div class="role-option">
                    <input type="radio" name="role"
                           id="role-examiner" value="EXAMINER" />
                    <label for="role-examiner">
                        <span class="role-icon">📝</span>
                        Examiner
                    </label>
                </div>
            </div>

            <div class="form-group" style="margin-bottom:1rem;">
                <label class="form-label">Username / Email</label>
                <input type="text" name="username"
                       class="form-control"
                       placeholder="Enter your username or email"
                       required />
            </div>

            <div class="form-group" style="margin-bottom:1.5rem;">
                <label class="form-label">Password</label>
                <input type="password" name="password"
                       class="form-control"
                       placeholder="Enter your password"
                       required />
            </div>

            <button type="submit" class="btn btn-primary"
                    style="width:100%;justify-content:center;">
                Sign In →
            </button>
        </form>

        <p style="text-align:center; margin-top:1.5rem; font-size:0.8rem;">
            New student?
            <a href="/students/register">Register here</a>
        </p>
    </div>
</div>
</body>
</html>