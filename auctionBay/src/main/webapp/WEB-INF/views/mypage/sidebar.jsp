<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<nav class="mypage-sidebar">
    <ul>
        <li><a href="${pageContext.request.contextPath}/mypage/products" class="${param.activeMenu == 'products' ? 'active' : ''}">게시글 관리</a></li>
        <li><a href="${pageContext.request.contextPath}/mypage/comments" class="${param.activeMenu == 'comments' ? 'active' : ''}">댓글 관리</a></li>
        <li><a href="${pageContext.request.contextPath}/mypage/txHistories" class="${param.activeMenu == 'txHistories' ? 'active' : ''}">거래 내역</a></li>
        <li><a href="${pageContext.request.contextPath}/mypage/reviews" class="${param.activeMenu == 'reviews' ? 'active' : ''}">후기</a></li>
        <li><a href="${pageContext.request.contextPath}/mypage/recents" class="${param.activeMenu == 'recents' ? 'active' : ''}">최근 본 글</a></li>
        <li><a href="${pageContext.request.contextPath}/mypage/wishlists" class="${param.activeMenu == 'wishlists' ? 'active' : ''}">찜목록</a></li>
    </ul>
</nav>