<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>AuctionBay - 쪽지 보내기</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/common.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/message.css">
</head>
<body>

<jsp:include page="/WEB-INF/views/common/header.jsp" />

<div class="main-container">
    <div class="content-wrapper">

        <main class="message-container">

            <c:choose>
                <c:when test="${not empty redirectURL}">
                    <a class="back-link" href="${redirectURL}">&laquo; 상품으로 돌아가기</a>
                </c:when>
                <c:otherwise>
                    <a class="back-link" href="${pageContext.request.contextPath}/message/received">&laquo; 쪽지함으로</a>
                </c:otherwise>
            </c:choose>
			
            <h2 class="message-title">쪽지 보내기</h2>

			<!-- 간단한 상품 정보 -->
			<c:if test="${not empty product}">
			    <div class="product-summary">
			        <div class="product-summary-title">${product.title}</div>
			        <div class="product-summary-price">
			            <fmt:formatNumber value="${product.price}" pattern="#,###"/>원
			            <span class="product-summary-type">
			                ${product.tradeType eq 'SELL' ? '판매글' : '구매글'}
			            </span>
			        </div>
			    </div>
			</c:if>


            <form class="reply-form" action="${pageContext.request.contextPath}/message/send" method="post">
                <input type="hidden" name="receiverNo" value="${receiverNo}">
                <input type="hidden" name="productId" value="${productId}">
                <input type="hidden" name="redirectURL" value="${redirectURL}">
                <textarea name="content" class="reply-textarea" placeholder="쪽지 내용을 입력하세요" required></textarea>
                <button type="submit" class="reply-submit">보내기</button>
            </form>

        </main>

        <aside class="right-quick-menu">
            <a href="${pageContext.request.contextPath}/mypage/wishlists" class="quick-item">
                <span class="quick-icon">❤️</span>
                <span>찜목록</span>
            </a>
            <a href="${pageContext.request.contextPath}/message/received" class="quick-item">
                <span class="quick-icon">✉️</span>
                <span>쪽지함</span>
                <c:choose>
                    <c:when test="${sessionScope.loginUser.unreadCount > 0 && sessionScope.loginUser.unreadCount <= 99}">
                        <span class="badge">${sessionScope.loginUser.unreadCount}</span>
                    </c:when>
                    <c:when test="${sessionScope.loginUser.unreadCount == 0}">
                    </c:when>
                    <c:otherwise>
                        <span class="badge">99+</span>
                    </c:otherwise>
                </c:choose>
            </a>
            <a href="${pageContext.request.contextPath}/mypage/recents" class="quick-item">
                <span class="quick-icon">⏱️</span>
                <span>최근 본 글</span>
            </a>
        </aside>

    </div>
</div>

<div style="margin-top: 50px;">
    <jsp:include page="/WEB-INF/views/common/footer.jsp" />
</div>

</body>
</html>