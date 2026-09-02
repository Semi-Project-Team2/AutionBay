<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>AuctionBay - 회원 탈퇴</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/common.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/mypage/common.css">
</head>
<body>
    <jsp:include page="/WEB-INF/views/common/header.jsp" />

    <div class="mypage-container">
        <div class="withdraw-container">
            <h3 class="withdraw-title">회원 탈퇴</h3> 
            <p class="withdraw-desc">
                안전한 회원 탈퇴를 위해<br>
                현재 사용 중인 비밀번호를 입력해 주세요.
            </p>

            <form action="${pageContext.request.contextPath}/user/withdraw" method="post" class="withdraw-form">
                <c:if test="${not empty error}">
                    <script>alert('${error}');</script>
                </c:if>
                
                <input type="password" 
                       name="pwInput" 
                       class="withdraw-input" 
                       placeholder="비밀번호 입력" 
                       required 
                       autofocus>

                <div class="withdraw-btn-group">
                    <a href="javascript:history.back()" class="withdraw-btn withdraw-btn-cancel">취소</a>
                    <button type="submit" class="withdraw-btn withdraw-btn-submit">탈퇴하기</button>
                </div>
            </form>
        </div>
    </div>

    <jsp:include page="/WEB-INF/views/common/footer.jsp" />
</body>
</html>