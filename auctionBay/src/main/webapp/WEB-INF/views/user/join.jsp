<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>회원가입 (테스트)</title>
</head>
<body>

<h1>회원가입 테스트</h1>

<c:if test="${not empty error}">
  <p style="color:red;">${error}</p>
</c:if>

<form action="${pageContext.request.contextPath}/user/join" method="post" enctype="multipart/form-data">

  <div>
    <label>아이디</label>
    <input type="text" name="userId">
  </div>

  <div>
    <label>비밀번호</label>
    <input type="password" name="password">
  </div>

  <div>
    <label>닉네임</label>
    <input type="text" name="nickname">
  </div>

  <div>
    <label>이메일</label>
    <input type="email" name="email">
  </div>

  <div>
    <label>연락처</label>
    <input type="text" name="phoneNumber">
  </div>

  <div>
    <label>주소</label>
    <input type="text" name="regionAddress">
  </div>

  <div>
    <label>프로필 이미지</label>
    <input type="file" name="profileImage">
  </div>

  <div>
    <button type="submit">가입</button>
  </div>

</form>

</body>
</html>
