<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>My Results — ExamSystem</title>
    <link rel="stylesheet" href="/css/style.css" />
</head>
<body>
<%@ include file="/WEB-INF/views/common/navbar.jsp" %>
<div class="page-wrapper">

    <div class="breadcrumb">
        <a href="/student/dashboard">Dashboard</a>
        <span class="separator">›</span>
        <span class="current">My Results</span>
    </div>

    <div class="page-header">
        <div>
            <h2 class="page-title">My Exam Results</h2>
            <p class="page-subtitle">Your examination performance summary</p>
        </div>
    </div>

    <%-- Summary Stats --%>
    <div class="stats-grid" style="margin-bottom:2rem;">
        <div class="stat-card">
            <div class="stat-icon">📋</div>
            <div class="stat-info">
                <div class="stat-value">${summary.totalExams}</div>
                <div class="stat-label">Total Exams</div>
            </div>
        </div>
        <div class="stat-card success">
            <div class="stat-icon">✅</div>
            <div class="stat-info">
                <div class="stat-value">${summary.passed}</div>
                <div class="stat-label">Passed</div>
            </div>
        </div>
        <div class="stat-card danger">
            <div class="stat-icon">❌</div>
            <div class="stat-info">
                <div class="stat-value">${summary.failed}</div>
                <div class="stat-label">Failed</div>
            </div>
        </div>
        <div class="stat-card warning">
            <div class="stat-icon">⏳</div>
            <div class="stat-info">
                <div class="stat-value">${summary.pending}</div>
                <div class="stat-label">Pending</div>
            </div>
        </div>
    </div>

    <%-- Results Table --%>
    <div class="table-wrapper">
        <div class="table-toolbar">
            <h3>Result Details</h3>
        </div>
        <c:choose>
            <c:when test="${empty results}">
                <div class="empty-state">
                    <div class="empty-icon">📊</div>
                    <p>No results available yet.</p>
                </div>
            </c:when>
            <c:otherwise>
                <table>
                    <thead>
                        <tr>
                            <th>Code</th>
                            <th>Exam Name</th>
                            <th>Subject</th>
                            <th>Date</th>
                            <th>Marks</th>
                            <th>Total</th>
                            <th>Pass</th>
                            <th>Grade</th>
                            <th>Result</th>
                            <th>Examiner</th>
                            <th>Recheck</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="r" items="${results}">
                            <tr>
                                <td>
                                    <span style="font-family:var(--font-mono);
                                          font-size:0.78rem;
                                          color:var(--blue-primary);
                                          font-weight:600;">
                                        ${r.examCode}
                                    </span>
                                </td>
                                <td><strong>${r.examName}</strong></td>
                                <td>${r.subjectName}</td>
                                <td>${r.examDate}</td>
                                <td>
                                    <strong style="font-size:1rem;
                                            color:var(--blue-darkest);">
                                        ${r.marksObtained}
                                    </strong>
                                </td>
                                <td>${r.totalMarks}</td>
                                <td>${r.passMarks}</td>
                                <td>
                                    <span class="badge badge-info">
                                        ${r.grade}
                                    </span>
                                </td>
                                <td>
                                    <c:choose>
                                        <c:when test="${r.resultStatus == 'PASS'}">
                                            <span class="badge badge-success">
                                                ✅ PASS
                                            </span>
                                        </c:when>
                                        <c:when test="${r.resultStatus == 'FAIL'}">
                                            <span class="badge badge-danger">
                                                ❌ FAIL
                                            </span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="badge badge-warning">
                                                ⏳ PENDING
                                            </span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td>${r.examinerName}</td>
                                <td>
                                    <c:if test="${r.resultStatus == 'PASS' or r.resultStatus == 'FAIL'}">
                                        <button type="button"
                                                class="btn btn-sm btn-outline"
                                                onclick="openRecheckModal(
                                                    '${r.examId}',
                                                    '${r.resultId}',
                                                    '${r.examName}')"
                                                style="font-size:0.75rem;">
                                            📋 Request Recheck
                                        </button>
                                    </c:if>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </c:otherwise>
        </c:choose>
    </div>

    <br/>
    <a href="/student/dashboard" class="btn btn-secondary">
        ← Back to Dashboard
    </a>
</div>
<%-- Recheck Request Modal --%>
<div id="recheckModal" style="display:none; position:fixed;
     top:0; left:0; width:100%; height:100%;
     background:rgba(0,0,0,0.5); z-index:9999;
     align-items:center; justify-content:center;">
    <div style="background:white; border-radius:16px;
                padding:2rem; width:500px; max-width:90%;
                box-shadow:0 20px 40px rgba(0,0,0,0.2);">
        <h3 style="color:#0d2247; margin-bottom:1rem;">
            📋 Submit Recheck Request
        </h3>
        <p id="recheckExamName"
           style="color:#64748b; margin-bottom:1rem;
                  font-size:0.875rem;"></p>

        <form method="post" action="/student/recheck/submit">
            <input type="hidden" id="recheckExamId"
                   name="examId" />
            <input type="hidden" id="recheckResultId"
                   name="resultId" />

            <div class="form-group"
                 style="margin-bottom:1rem;">
                <label class="form-label">Reason</label>
                <input type="text" name="requestReason"
                       class="form-control"
                       placeholder="Brief reason for recheck"
                       required />
            </div>

            <div class="form-group"
                 style="margin-bottom:1.5rem;">
                <label class="form-label">
                    Description (Optional)
                </label>
                <textarea name="requestDescription"
                          class="form-control"
                          rows="3"
                          placeholder="Provide more details..."
                          style="resize:vertical;"></textarea>
            </div>

            <div style="display:flex; gap:10px;">
                <button type="submit"
                        class="btn btn-primary">
                    Submit Request
                </button>
                <button type="button"
                        class="btn btn-secondary"
                        onclick="closeRecheckModal()">
                    Cancel
                </button>
            </div>
        </form>
    </div>
</div>

<div id="recheckModal" style="display:none; position:fixed;
     top:0; left:0; width:100%; height:100%;
     background:rgba(0,0,0,0.5); z-index:9999;
     align-items:center; justify-content:center;">
    <div style="background:white; border-radius:16px;
                padding:2rem; width:500px; max-width:90%;
                box-shadow:0 20px 40px rgba(0,0,0,0.2);">
        <h3 style="color:#0d2247; margin-bottom:1rem;">
            📋 Submit Recheck Request
        </h3>
        <p id="recheckExamName"
           style="color:#64748b; margin-bottom:1rem;
                  font-size:0.875rem;"></p>

        <form method="post" action="/student/recheck/submit">
            <input type="hidden" id="recheckExamId"
                   name="examId" />
            <input type="hidden" id="recheckResultId"
                   name="resultId" />

            <div class="form-group"
                 style="margin-bottom:1rem;">
                <label class="form-label">Reason</label>
                <input type="text" name="requestReason"
                       class="form-control"
                       placeholder="Brief reason for recheck"
                       required />
            </div>

            <div class="form-group"
                 style="margin-bottom:1.5rem;">
                <label class="form-label">
                    Description (Optional)
                </label>
                <textarea name="requestDescription"
                          class="form-control"
                          rows="3"
                          placeholder="Provide more details..."
                          style="resize:vertical;"></textarea>
            </div>

            <div style="display:flex; gap:10px;">
                <button type="submit"
                        class="btn btn-primary">
                    Submit Request
                </button>
                <button type="button"
                        class="btn btn-secondary"
                        onclick="closeRecheckModal()">
                    Cancel
                </button>
            </div>
        </form>
    </div>
</div>

<script>
    function openRecheckModal(examId, resultId, examName) {
        document.getElementById('recheckExamId').value = examId;
        document.getElementById('recheckResultId').value = resultId;
        document.getElementById('recheckExamName').textContent =
            'Exam: ' + examName;
        const modal = document.getElementById('recheckModal');
        modal.style.display = 'flex';
    }
    function closeRecheckModal() {
        document.getElementById('recheckModal').style.display = 'none';
    }
</script>
</body>
</html>