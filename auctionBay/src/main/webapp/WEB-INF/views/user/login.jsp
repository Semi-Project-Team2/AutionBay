<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>AuctionBay - 로그인</title>
<link rel="stylesheet" href="/css/common.css">
<link rel="stylesheet" href="/css/login_join.css">
</head>
<body>

  <jsp:include page="/WEB-INF/views/common/header.jsp"/>

  <!-- 로그인 전용 카드 영역 -->
  <main class="auth-card">
    <h1>로그인</h1>

    <c:if test="${not empty error}">
      <p class="error-msg">${error}</p>
    </c:if>

    <c:if test="${not empty joinSuccess}">
      <p class="success-msg">회원가입이 완료되었습니다. 로그인해주세요.</p>
    </c:if>

    <form action="${pageContext.request.contextPath}/user/login" method="post">
      <div class="field-row">
        <label for="userId">아이디</label>
        <input type="text" id="userId" name="userId" required>
      </div>

      <div class="field-row">
        <label for="password">비밀번호</label>
        <input type="password" id="password" name="password" required>
      </div>

      <div class="submit-row">
        <button type="submit" class="btn-primary">로그인</button>
      </div>
    </form>

    <div class="links">
      <a href="${pageContext.request.contextPath}/user/join">회원가입</a>
    </div>
  </main>

  <jsp:include page="/WEB-INF/views/common/footer.jsp"/>

</body>
</html>