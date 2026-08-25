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

    <c:if test="${not empty thread}">
        <c:set var="first" value="${thread[0]}" />
        <%-- 상대방 번호/이름/상품명은 스레드 첫 메시지 기준으로 뽑아서 상단에 표시 --%>
        <c:set var="opponentNo" value="${first.senderNo == myNo ? first.receiverNo : first.senderNo}" />

        <h2 class="message-title">
            ${first.opponentNickname} 님과의 대화
            <span class="message-product">· ${first.productTitle}</span>
        </h2>
    </c:if>

    <!-- 대화 스레드 -->
    <div class="thread-box">
        <c:choose>
            <c:when test="${not empty thread}">
                <c:forEach var="m" items="${thread}">
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
    <c:if test="${not empty thread}">
        <form class="reply-form" action="${pageContext.request.contextPath}/message/send" method="post">
            <input type="hidden" name="receiverNo" value="${opponentNo}">
            <input type="hidden" name="productId" value="${first.productId}">
            <textarea name="content" class="reply-textarea" placeholder="답장을 입력하세요" required></textarea>
            <button type="submit" class="reply-submit">보내기</button>
        </form>
    </c:if>

</main>

<jsp:include page="/WEB-INF/views/common/footer.jsp" />

</div>
</body>
</html>
