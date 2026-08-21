<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>로그인</title>
<style>
  * { box-sizing: border-box; }
  body {
    margin: 0;
    font-family: "Malgun Gothic", "Apple SD Gothic Neo", sans-serif;
    color: #222;
  }
  .container {
    max-width: 400px;
    margin: 80px auto;
    padding: 0 20px;
  }
  h1 {
    font-size: 22px;
    margin-bottom: 30px;
    text-align: center;
  }
  .field-row {
    margin-bottom: 14px;
  }
  .field-row label {
    display: block;
    font-size: 14px;
    margin-bottom: 6px;
  }
  .field-row input[type="text"],
  .field-row input[type="password"] {
    width: 100%;
    padding: 10px;
    border: 1px solid #ccc;
    background: #e0e0e0;
    border-radius: 3px;
  }
  .submit-row {
    margin-top: 24px;
  }
  .submit-row button {
    width: 100%;
    padding: 12px;
    background: #e0e0e0;
    border: 1px solid #ccc;
    border-radius: 3px;
    cursor: pointer;
    font-size: 15px;
  }
  .error-msg {
    color: #d9534f;
    font-size: 13px;
    margin-bottom: 14px;
  }
  .links {
    margin-top: 16px;
    text-align: center;
    font-size: 13px;
  }
  .links a {
    color: #555;
    text-decoration: none;
    margin: 0 8px;
  }
</style>
</head>
<body>

<div class="container">
  <h1>로그인</h1>

  <c:if test="${not empty error}">
    <p class="error-msg">${error}</p>
  </c:if>

  <c:if test="${not empty joinSuccess}">
    <p style="color:#2a7a2a; font-size:13px; margin-bottom:14px;">회원가입이 완료되었습니다. 로그인해주세요.</p>
  </c:if>

  <form action="${pageContext.request.contextPath}/member/login" method="post">

    <div class="field-row">
      <label for="userId">아이디</label>
      <input type="text" id="userId" name="userId">
    </div>

    <div class="field-row">
      <label for="password">비밀번호</label>
      <input type="password" id="password" name="password">
    </div>

    <div class="submit-row">
      <button type="submit">로그인</button>
    </div>

  </form>

  <div class="links">
    <a href="${pageContext.request.contextPath}/member/join">회원가입</a>
  </div>
</div>

</body>
</html>
