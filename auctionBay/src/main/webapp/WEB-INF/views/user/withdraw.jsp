<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>회원 탈퇴</title>
</head>
<body>
   <h3>회원 탈퇴</h3> 
   <p>비밀번호를 입력해주세요.</p>

   <form 
    action="${pageContext.request.contextPath}/user/withdraw"
    method="post">
       <c:if test="${not empty error}">
           <script>alert('${error}')</script>
       </c:if>
       <input type="password" name="pwInput" placeholder="비밀번호 입력" required>
       <button type="submit">탈퇴하기</button>
   </form>
</body>
</html>