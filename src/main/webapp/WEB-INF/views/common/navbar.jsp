<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<nav class="navbar">
  <a class="navbar-brand" href="
        <c:choose>
            <c:when test='${sessionScope.role == "ADMIN"}'>/admin/dashboard</c:when>
            <c:when test='${sessionScope.role == "STUDENT"}'>/student/dashboard</c:when>
            <c:when test='${sessionScope.role == "EXAMINER"}'>/examiner/dashboard</c:when>
            <c:otherwise>/login</c:otherwise>
        </c:choose>">
    <div class="brand-icon">🎓</div>
    ExamSystem
  </a>

  <div class="navbar-user">
    <div class="user-info">
      <div class="user-name">
        <c:choose>
          <c:when test="${not empty sessionScope.adminName}">
            ${sessionScope.adminName}
          </c:when>
          <c:when test="${not empty sessionScope.studentName}">
            ${sessionScope.studentName}
          </c:when>
          <c:when test="${not empty sessionScope.examinerName}">
            ${sessionScope.examinerName}
          </c:when>
        </c:choose>
      </div>
      <div class="user-role">${sessionScope.role}</div>
    </div>
    <div class="avatar">
      <c:choose>
        <c:when test="${sessionScope.role == 'ADMIN'}">A</c:when>
        <c:when test="${sessionScope.role == 'STUDENT'}">S</c:when>
        <c:when test="${sessionScope.role == 'EXAMINER'}">E</c:when>
      </c:choose>
    </div>
    <a href="/logout" class="btn-logout">Logout</a>
  </div>
</nav>