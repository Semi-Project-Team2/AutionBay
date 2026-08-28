<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>AuctionBay - 쪽지</title>
<link rel="stylesheet" href="/css/common.css">
<link rel="stylesheet" href="/css/message.css">
</head>
<body>

<div class="container">

<jsp:include page="/WEB-INF/views/common/header.jsp" />

<main class="container message-container">

	<a class="back-link" href="${pageContext.request.contextPath}/message/received">&laquo; 쪽지함으로</a>

	<c:if test="${not empty completeMessage}">
	    <div class="alert alert-success">${completeMessage}</div>
	</c:if>
	<c:if test="${not empty completeError}">
	    <div class="alert alert-error">${completeError}</div>
	</c:if>

	<c:if test="${not empty message}">
	    <c:set var="firstMessage" value="${message[0]}" />

	    <h2 class="message-title">
	        ${firstMessage.opponentNickname} 님과의 대화
	        <span class="message-product">· ${product.title}</span>
	        <c:if test="${product.status == 'COMPLETED'}">
	            <span class="trade-status-badge done">거래완료</span>
	        </c:if>
	    </h2>

	    <c:if test="${canComplete}">
	        <form class="complete-trade-form" action="${pageContext.request.contextPath}/message/completeTrade" method="post"
	              onsubmit="return confirm('거래를 완료 처리하시겠습니까?\n완료 후에는 되돌릴 수 없습니다.');">
	            <input type="hidden" name="productId" value="${product.productId}">
	            <input type="hidden" name="opponentNo" value="${opponentNo}">
	            <input type="hidden" name="messageId" value="${firstMessage.messageId}">
	            <button type="submit" class="complete-trade-btn">거래완료</button>
	        </form>
	    </c:if>
	</c:if>

    <!-- 대화 스레드 -->
    <div class="thread-box">
        <c:choose>
            <c:when test="${not empty message}">
                <c:forEach var="m" items="${message}">
                    <div class="chat-bubble-row ${m.senderNo == myNo ? 'mine' : 'theirs'}">
                        <div class="chat-bubble">
                            <div class="chat-content">${m.content}</div>
                            <div class="chat-date">${m.createdAt}</div>
                        </div>
                    </div>
                </c:forEach>
            </c:when>
            <c:otherwise>
                <div class="message-empty">대화 내용이 없습니다.</div>
            </c:otherwise>
        </c:choose>
    </div>

    <!-- 답장 입력 폼 -->
    <c:if test="${not empty message}">
        <form class="reply-form" action="${pageContext.request.contextPath}/message/send" method="post">
            <input type="hidden" name="receiverNo" value="${opponentNo}">
            <input type="hidden" name="productId" value="${firstMessage.productId}">
            <textarea name="content" class="reply-textarea" placeholder="답장을 입력하세요" required></textarea>
            <button type="submit" class="reply-submit">보내기</button>
        </form>
    </c:if>

</main>

<jsp:include page="/WEB-INF/views/common/footer.jsp" />

</div>
</body>
</html>
