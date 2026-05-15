<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Add Marks — ExamSystem</title>
    <link rel="stylesheet" href="/css/style.css" />
</head>
<body>
<%@ include file="/WEB-INF/views/common/navbar.jsp" %>
<div class="page-wrapper">

    <div class="breadcrumb">
        <a href="/examiner/dashboard">Dashboard</a>
        <span class="separator">›</span>
        <span class="current">Add Marks</span>
    </div>

    <div class="page-header">
        <div>
            <h2 class="page-title">${exam.examName}</h2>
            <p class="page-subtitle">
                ${exam.subjectName} — Pass: ${exam.passMarks} /
                Total: ${exam.totalMarks}
            </p>
        </div>
        <a href="/examiner/dashboard" class="btn btn-secondary">
            ← Dashboard
        </a>
    </div>

    <c:if test="${not empty success}">
        <div class="alert alert-success">✅ ${success}</div>
    </c:if>
    <c:if test="${not empty error}">
        <div class="alert alert-danger">⚠️ ${error}</div>
    </c:if>

    <div class="table-wrapper">
        <div class="table-toolbar">
            <h3>Approved Students</h3>
            <c:if test="${canHold}">
                <span class="badge badge-info">
                    🔒 Hold feature enabled (Senior Examiner)
                </span>
            </c:if>
        </div>

        <c:choose>
            <c:when test="${empty approvedStudents}">
                <div class="empty-state">
                    <div class="empty-icon">🎓</div>
                    <p>
                        All approved students already have marks entered,
                        or no approved students found.
                    </p>
                </div>
            </c:when>
            <c:otherwise>
                <table>
                    <thead>
                        <tr>
                            <th>Reg No</th>
                            <th>Student Name</th>
                            <th>Add Marks</th>
                            <c:if test="${canHold}">
                                <th>Hold Student</th>
                            </c:if>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="reg" items="${approvedStudents}">
                            <tr>
                                <td>
                                    <span style="font-family:var(--font-mono);
                                          font-size:0.8rem;
                                          color:var(--blue-primary);
                                          font-weight:600;">
                                        ${reg.student.registrationNo}
                                    </span>
                                </td>
                                <td>
                                    <strong>${reg.student.fullName}</strong>
                                </td>
                                <td>
                                    <form method="post"
                                          action="/examiner/results/add"
                                          style="display:flex;gap:8px;
                                                 align-items:center;">
                                        <input type="hidden" name="studentId"
                                               value="${reg.student.studentId}" />
                                        <input type="hidden" name="examId"
                                               value="${exam.examId}" />
                                        <input type="number"
                                               name="marksObtained"
                                               class="form-control"
                                               style="width:100px;"
                                               min="0" max="100"
                                               step="0.01"
                                               placeholder="0-100"
                                               required />
                                        <button type="submit"
                                                class="btn btn-sm btn-primary">
                                            ✅ Submit
                                        </button>
                                    </form>
                                </td>
                                <c:if test="${canHold}">
                                    <td>
                                        <form method="post"
                                              action="/examiner/holds/place"
                                              style="display:flex;gap:8px;
                                                     align-items:center;">
                                            <input type="hidden"
                                                   name="studentId"
                                                   value="${reg.student.studentId}" />
                                            <input type="hidden"
                                                   name="examId"
                                                   value="${exam.examId}" />
                                            <input type="text"
                                                   name="reason"
                                                   class="form-control"
                                                   style="width:180px;"
                                                   placeholder="Hold reason"
                                                   required />
                                            <button type="submit"
                                                    class="btn btn-sm btn-danger"
                                                    onclick="return confirm(
                                                        'Place hold on this student?')">
                                                🔒 Hold
                                            </button>
                                        </form>
                                    </td>
                                </c:if>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </c:otherwise>
        </c:choose>
    </div>
</div>
</body>
</html>