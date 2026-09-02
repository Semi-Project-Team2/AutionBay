<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<c:set var="boxType" value="sent" scope="request" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>AuctionBay - 보낸 쪽지함</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/common.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/message.css">
</head>
<body>

<jsp:include page="/WEB-INF/views/common/header.jsp" />

<div class="main-container">
    <div class="content-wrapper">
        
        <div class="message-container">
            <h2 class="message-title">쪽지함</h2>

            <!-- 받은함 / 보낸함 탭 -->
            <div class="message-tabs">
                <a class="tab-item" href="${pageContext.request.contextPath}/message/received">받은 쪽지함</a>
                <a class="tab-item active" href="${pageContext.request.contextPath}/message/sent">보낸 쪽지함</a>
            </div>

            <jsp:include page="/WEB-INF/views/message/list.jsp" />
        </div>

        <!-- 우측 스크롤 고정 퀵 메뉴 추가 -->
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