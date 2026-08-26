<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>AuctionBay - 쪽지 보내기</title>
<link rel="stylesheet" href="/css/common.css">
<link rel="stylesheet" href="/css/message.css">
</head>
<body>

<div class="container">

<jsp:include page="/WEB-INF/views/common/header.jsp" />

<main class="container message-container">

    <c:choose>
        <c:when test="${not empty redirectURL}">
            <a class="back-link" href="${redirectURL}">&laquo; 상품으로 돌아가기</a>
        </c:when>
        <c:otherwise>
            <a class="back-link" href="${pageContext.request.contextPath}/message/received">&laquo; 쪽지함으로</a>
        </c:otherwise>
    </c:choose>

    <h2 class="message-title">쪽지 보내기</h2>

    <!-- 첫 메시지 작성 폼 -->
    <form class="reply-form" action="${pageContext.request.contextPath}/message/send" method="post">
        <input type="hidden" name="receiverNo" value="${receiverNo}">
        <input type="hidden" name="productId" value="${productId}">
        <input type="hidden" name="redirectURL" value="${redirectURL}">
        <textarea name="content" class="reply-textarea" placeholder="쪽지 내용을 입력하세요" required></textarea>
        <button type="submit" class="reply-submit">보내기</button>
    </form>

</main>

<jsp:include page="/WEB-INF/views/common/footer.jsp" />

</div>
</body>
</html>
