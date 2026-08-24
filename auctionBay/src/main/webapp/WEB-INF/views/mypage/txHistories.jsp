<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>AuctionBay - 마이페이지</title>
<style>
    * { box-sizing: border-box; margin: 0; padding: 0; }
    body { font-family: 'Malgun Gothic', sans-serif; background-color: #f8f9fa; color: #333; }
    
    .container { width: 1200px; margin: 30px auto; }

    /* 1. 상단 프로필 영역 */
    .profile-box {
        background-color: #e2e2e2;
        padding: 30px;
        border-radius: 6px;
        display: flex;
        align-items: center;
        justify-content: space-between;
        margin-bottom: 30px;
    }
    .profile-info-wrap {
        display: flex;
        align-items: center;
        gap: 25px;
    }
    .profile-img {
        width: 80px;
        height: 80px;
        background-color: #222;
        border-radius: 50%;
    }
    .profile-text h2 {
        font-size: 22px;
        font-weight: bold;
        margin-bottom: 5px;
        color: #000;
    }
    .profile-text p {
        font-size: 14px;
        color: #555;
    }
    .btn-edit {
        background-color: #d4edda;
        border: 1px solid #c3e6cb;
        padding: 10px 20px;
        border-radius: 4px;
        text-decoration: none;
        color: #155724;
        font-weight: bold;
        font-size: 14px;
        cursor: pointer;
    }
    .btn-edit:hover {
        background-color: #c3e6cb;
    }

    /* 2. 메인 콘텐츠 영역 (사이드바 + 리스트) */
    .mypage-content {
        display: flex;
        gap: 30px;
        align-items: flex-start;
    }

    /* 사이드바 */
    .mypage-sidebar {
        width: 200px;
        background-color: #e2e2e2;
        border-radius: 6px;
        padding: 15px 0;
        display: flex;
        flex-direction: column;
        gap: 5px;
    }
    .sidebar-item {
        padding: 12px 20px;
        text-decoration: none;
        color: #555;
        font-size: 15px;
        font-weight: 500;
        display: block;
    }
    .sidebar-item:hover {
        background-color: #d1d1d1;
        color: #000;
    }
    .sidebar-item.active {
        background-color: #c5c5c5;
        color: #000;
        font-weight: bold;
    }

    /* 우측 리스트 섹션 */
    .mypage-main {
        flex: 1;
        min-width: 0;
    }
    .content-header {
        display: flex;
        justify-content: space-between;
        align-items: center;
        margin-bottom: 20px;
    }
    .content-title {
        font-size: 18px;
        font-weight: bold;
    }
    .search-bar {
        background-color: #d1d1d1;
        padding: 8px 15px;
        border-radius: 4px;
        font-size: 13px;
        color: #666;
        width: 250px;
        text-align: center;
    }

    /* 거래 내역 아이템 카드 */
    .history-list {
        display: flex;
        flex-direction: column;
        gap: 15px;
        margin-bottom: 30px;
    }
    .history-card {
        background-color: #e2e2e2;
        padding: 18px 20px;
        border-radius: 6px;
        display: flex;
        align-items: center;
        justify-content: space-between;
    }
    .history-info {
        display: flex;
        align-items: center;
        gap: 20px;
        font-size: 15px;
        font-weight: 500;
        color: #333;
    }
    .history-info .divider {
        color: #999;
    }
    .btn-review {
        background-color: #d4edda;
        border: 1px solid #c3e6cb;
        padding: 6px 14px;
        border-radius: 4px;
        text-decoration: none;
        color: #155724;
        font-size: 13px;
        font-weight: bold;
        cursor: pointer;
    }
    .btn-review:hover {
        background-color: #c3e6cb;
    }

    /* 페이징 바 */
    .pagination {
        display: flex;
        justify-content: center;
        align-items: center;
        gap: 5px;
        margin-top: 20px;
    }
    .page-btn {
        padding: 6px 12px;
        border: 1px solid #ddd;
        background-color: #fff;
        color: #333;
        text-decoration: none;
        border-radius: 3px;
        font-size: 13px;
    }
    .page-btn.active {
        background-color: #222;
        color: #fff;
        border-color: #222;
        font-weight: bold;
    }
    .page-btn:hover:not(.active) {
        background-color: #f1f1f1;
    }
</style>
</head>
<body>

<div class="container">
    
    <!-- 1. 상단 프로필 영역 -->
    <div class="profile-box">
        <div class="profile-info-wrap">
            <div class="profile-img"></div>
            <div class="profile-text">
                <h2>${sessionScope.loginUser.nickname}</h2>
                <p>${sessionScope.loginUser.email}</p>
            </div>
        </div>
        <a href="${pageContext.request.contextPath}/mypage/edit" class="btn-edit">회원 정보 수정</a>
    </div>

    <!-- 2. 메인 콘텐츠 (사이드바 + 내용) -->
    <div class="mypage-content">
        
        <!-- 사이드바 -->
        <div class="mypage-sidebar">
            <a href="${pageContext.request.contextPath}/mypage/boards" class="sidebar-item">게시글 관리</a>
            <a href="${pageContext.request.contextPath}/mypage/comments" class="sidebar-item">댓글 관리</a>
            <a href="${pageContext.request.contextPath}/mypage/txHistoies" class="sidebar-item active">거래 내역</a>
            <a href="${pageContext.request.contextPath}/mypage/reviews" class="sidebar-item">후기</a>
            <a href="${pageContext.request.contextPath}/mypage/recent" class="sidebar-item">최근 본 글</a>
        </div>

        <!-- 우측 거래 내역 리스트 -->
        <div class="mypage-main">
            <div class="content-header">
                <span class="content-title">거래 내역</span>
                <div class="search-bar">검색창</div>
            </div>

            <!-- 리스트 반복 영역 -->
            <div class="history-list">
                
                <c:choose>
                    <c:when test="${not empty txList}">
                        <c:forEach var="tx" items="${txList}">
                            <div class="history-card">
                                <div class="history-info">
                                    <span>${tx.title}</span>
                                    <span class="divider">|</span>
                                    <span>${tx.tradeType}</span>
                                    <span class="divider">|</span>
                                    <span>${tx.price}원</span>
                                    <span class="divider">|</span>
                                    <span>${tx.partnerNickname}</span>
                                </div>
                                <a href="${pageContext.request.contextPath}/review/write?txNo=${tx.txNo}" class="btn-review">후기 작성</a>
                            </div>
                        </c:forEach>
                    </c:when>
                    <c:otherwise>
                        <!-- 데이터가 없을 때 시안 느낌의 임시 카드 3개 노출 (원하시면 c:forEach로 교체하세요) -->
                        <div class="history-card">
                            <div class="history-info">
                                <span>제목</span>
                                <span class="divider">|</span>
                                <span>거래유형</span>
                                <span class="divider" style="margin-left: 40px;">|</span>
                                <span>가격</span>
                                <span class="divider">|</span>
                                <span>닉네임</span>
                            </div>
                            <a href="#" class="btn-review" onclick="alert('후기 작성 기능 준비 중');">후기 작성</a>
                        </div>
                        <div class="history-card">
                            <div class="history-info">
                                <span>제목</span>
                                <span class="divider">|</span>
                                <span>거래유형</span>
                                <span class="divider" style="margin-left: 40px;">|</span>
                                <span>가격</span>
                                <span class="divider">|</span>
                                <span>닉네임</span>
                            </div>
                            <a href="#" class="btn-review" onclick="alert('후기 작성 기능 준비 중');">후기 작성</a>
                        </div>
                        <div class="history-card">
                            <div class="history-info">
                                <span>제목</span>
                                <span class="divider">|</span>
                                <span>거래유형</span>
                                <span class="divider" style="margin-left: 40px;">|</span>
                                <span>가격</span>
                                <span class="divider">|</span>
                                <span>닉네임</span>
                            </div>
                            <a href="#" class="btn-review" onclick="alert('후기 작성 기능 준비 중');">후기 작성</a>
                        </div>
                    </c:otherwise>
                </c:choose>

            </div>

            <!-- 페이징 바 -->
            <div class="pagination">
                <a class="page-btn" href="#">&lt; 이전</a>
                <a class="page-btn active" href="#">1</a>
                <a class="page-btn" href="#">2</a>
                <a class="page-btn" href="#">3</a>
                <a class="page-btn" href="#">4</a>
                <a class="page-btn" href="#">5</a>
                <a class="page-btn" href="#">다음 &gt;</a>
            </div>

        </div>

    </div>

</div>

</body>
</html>