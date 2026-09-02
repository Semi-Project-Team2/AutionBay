<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<link rel="stylesheet" href="/css/common.css">
<!-- 헤더 영역 -->
<header class="header">
    <div class="header-container">
        
        <!-- 1. 로고 이미지 영역 -->
        <a href="${pageContext.request.contextPath}/" class="header-logo">
            <img src="${pageContext.request.contextPath}/css/logo/logo.png" alt="AuctionBay" class="logo-img">
        </a>

        <!-- 2. 검색창 영역 -->
        <div class="header-search">
            <form action="${pageContext.request.contextPath}/product/list" method="get" style="width: 100%;">
                <input type="text" name="keyword" value="${param.keyword}" placeholder="제목 또는 작성자 검색">
            </form>
        </div>

        <!-- 3. 로그인 / 회원가입 영역 -->
        <div class="header-auth">
            <c:choose>
                <%-- 로그인 상태가 아닐 때 --%>
                <c:when test="${empty sessionScope.loginUser}">
                    <a href="${pageContext.request.contextPath}/user/login" class="auth-btn">로그인</a>
                    <a href="${pageContext.request.contextPath}/user/join" class="auth-btn">회원가입</a>
                </c:when>
<%-- 로그인 상태일 때 --%>
<c:otherwise>
    <span class="header-welcome-text">
        ${sessionScope.loginUser.nickname}님 환영합니다!
    </span>
    
    <%-- 헤더 쪽지함 버튼 (안읽은 쪽지 뱃지 포함) --%>
    <a href="${pageContext.request.contextPath}/message/received" class="auth-btn header-msg-btn">
        쪽지함
        <c:choose>
            <c:when test="${sessionScope.loginUser.unreadCount > 0 && sessionScope.loginUser.unreadCount <= 99}">
                <span class="header-badge">${sessionScope.loginUser.unreadCount}</span>
            </c:when>
            <c:when test="${sessionScope.loginUser.unreadCount > 99}">
                <span class="header-badge">99+</span>
            </c:when>
            <c:otherwise>
                <%-- 뱃지 없음 --%>
            </c:otherwise>
        </c:choose>
    </a>

    <a href="${pageContext.request.contextPath}/mypage/products" class="auth-btn">마이페이지</a>
    <a href="${pageContext.request.contextPath}/user/logout" class="auth-btn">로그아웃</a>
</c:otherwise>
            </c:choose>
        </div>

    </div>
</header>