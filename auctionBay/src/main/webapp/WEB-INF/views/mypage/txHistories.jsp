<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>

<head>
    <meta charset="UTF-8">
    <title>AuctionBay - 마이페이지</title>
    <link rel="stylesheet" href="/css/common.css">
    <style>
<<<<<<< Updated upstream
        * {
            box-sizing: border-box;
            margin: 0;
            padding: 0;
        }

        body {
            font-family: 'Malgun Gothic', sans-serif;
            background-color: #f8f9fa;
            color: #333;
        }

        .container {
            width: 1200px;
            margin: 30px auto;
        }

/* 상단 프로필 영역 */
.profile-area {
    background-color: #e2e2e2;
    padding: 30px;
    border-radius: 6px;
    display: flex;
    align-items: center;
    justify-content: space-between;
    margin-bottom: 30px;
}
.profile-info { display: flex; align-items: center; gap: 20px; }
.profile-img { width: 70px; height: 70px; background-color: #333; color: #fff; border-radius: 50%; display: flex; align-items: center; justify-content: center; font-weight: bold; }
.profile-text h2 { font-size: 20px; font-weight: bold; margin-bottom: 5px; }
.profile-text p { font-size: 14px; color: #555; }
.profile-right { display: flex; gap: 10px; }
.btn-edit { background-color: #d4edda; border: 1px solid #c3e6cb; padding: 8px 15px; border-radius: 4px; font-weight: bold; color: #155724; cursor: pointer; text-decoration: none; font-size: 13px; }
.btn-withdraw { background-color: #f8d7da; border: 1px solid #f5c6cb; padding: 8px 15px; border-radius: 4px; font-weight: bold; color: #721c24; cursor: pointer; text-decoration: none; font-size: 13px; }

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

        /* 검색바 스타일 */
        .search-bar { background-color: #e2e2e2; padding: 0 10px; border-radius: 4px; font-size: 13px; color: #666; width: 250px; display: flex; align-items: center; }
        .search-bar input { width: 100%; border: none; background: transparent; outline: none; font-size: 13px; text-align: left; padding: 8px 5px; }
        .search-bar button { border: none; background: transparent; cursor: pointer; font-size: 13px; color: #333; font-weight: bold; white-space: nowrap; }

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
        .review-completed {
            background-color: #a1a1a1;
            border: 1px solid #aaa;
            padding: 6px 14px;
            border-radius: 4px;
            text-decoration: none;
            color: #555;
            font-size: 13px;
            font-weight: bold;
            cursor: pointer;
        }
        .no-data { background-color: #e2e2e2; padding: 40px; text-align: center; border-radius: 6px; color: #777; font-size: 14px; }

        .btn-review:hover {
            background-color: #c3e6cb;
        }

=======
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

>>>>>>> Stashed changes
        /* 페이징 바 */
        .pagination {
            display: flex;
            justify-content: center;
            align-items: center;
            gap: 5px;
            margin-top: 20px;
        }
<<<<<<< Updated upstream

=======
>>>>>>> Stashed changes
        .page-btn {
            padding: 6px 12px;
            border: 1px solid #ddd;
            background-color: #fff;
            color: #333;
            text-decoration: none;
            border-radius: 3px;
            font-size: 13px;
        }
<<<<<<< Updated upstream

=======
>>>>>>> Stashed changes
        .page-btn.active {
            background-color: #222;
            color: #fff;
            border-color: #222;
            font-weight: bold;
        }
<<<<<<< Updated upstream

=======
>>>>>>> Stashed changes
        .page-btn:hover:not(.active) {
            background-color: #f1f1f1;
        }
    </style>
</head>

<body>
    <!-- 공통 헤더 포함 -->
    <jsp:include page="/WEB-INF/views/common/header.jsp" />

    <div class="container">
<<<<<<< Updated upstream

        <!-- 프로필 영역 포함 -->
        <jsp:include page="/WEB-INF/views/mypage/profile/profile.jsp" />

        <!-- 2. 메인 콘텐츠 (사이드바 + 내용) -->
        <div class="mypage-content">

        <!-- 3. 사이드바 -->
        <div class="mypage-sidebar">
            <a href="${pageContext.request.contextPath}/mypage/products" class="sidebar-item">게시글 관리</a>
            <a href="${pageContext.request.contextPath}/mypage/comments" class="sidebar-item">댓글 관리</a>
            <a href="${pageContext.request.contextPath}/mypage/txHistories" class="sidebar-item active">거래내역</a>
            <a href="${pageContext.request.contextPath}/mypage/reviews" class="sidebar-item">후기</a>
            <a href="${pageContext.request.contextPath}/mypage/recents" class="sidebar-item">최근 본 글</a>
            <a href="${pageContext.request.contextPath}/mypage/wishlists" class="sidebar-item">찜 목록</a>
            <a href="${pageContext.request.contextPath}/message/received" class="sidebar-item">쪽지함</a>
        </div>

            <!-- 우측 거래 내역 리스트 -->
            <div class="mypage-main">
                <div class="content-header">
                    <span class="content-title">거래 내역</span>
                    <div class="search-bar">
                        <form action="${pageContext.request.contextPath}/mypage/txHistories" method="get" class="search-bar">
                            <input type="text" name="keyword" value="${param.keyword}"
                                id="mypageKeywordInput" 
                                placeholder="검색어를 입력하세요">
                            <button type="submit">검색</button>
                        </form>
                    </div>
                </div>

                <!-- 리스트 반복 영역 -->
                <div class="history-list">

                    <c:choose>
                        <c:when test="${not empty list.txHistories}">
                            <c:forEach var="txHistory" items="${list.txHistories}">
                                <!-- 
                                    list.txHistories: 
                                    TxHistoryResultList 클래스의 필드 List<TxHistoryDTO> list의 getter 호출
                                -->
                                <div class="history-card">
                                    <div class="history-info">
                                <c:choose>
                                    <c:when test="${txHistory.tradeType == '경매'}">
                                        <a href="${pageContext.request.contextPath}/auction/${txHistory.productId}/detail"
                                            class="title">${txHistory.title}</a>
                                    </c:when>
                                    <c:otherwise>
                                        <a href="${pageContext.request.contextPath}/board/${txHistory.productId}/detail"
                                            class="title">${txHistory.title}</a>
                                    </c:otherwise>
                                </c:choose>
                                        <span class="divider">|</span>
                                        <span>${txHistory.tradeType}</span>
                                        <span class="divider" style="margin-left: 40px;">|</span>
                                        <span>${txHistory.finalPrice}원</span>
                                        <span class="divider">|</span>
                                        <span>${txHistory.partnerNickname}</span>
                                        <span class="divider">|</span>
                                        <span>${txHistory.completedAtStr}</span>
                                    </div>
                                    <c:choose>
                                        <%-- 후기작성완료(reviewWrited값이 true)인 경우 작성 완료 --%>
                                        <c:when test="${txHistory.reviewWrited == true}">
                                            <button class="review-completed">후기 작성 완료</button>
                                        </c:when>
                                        <%-- 후기 미작성(reviewWrited값이 false)인 경우 --%>
                                        <c:when test="${txHistory.reviewWrited == false}">
                                            <a href="${pageContext.request.contextPath}/mypage/review/writeForm?historyId=${txHistory.historyId}"
                                            class="btn-review">
                                                후기작성
                                            </a>
                                        </c:when>
                                    </c:choose>
                                </div>
                            </c:forEach>
                        </c:when>
                        <c:otherwise>
                            <div class="no-data">거래 내역이 없습니다.</div>
                        </c:otherwise>
                    </c:choose>

                </div>

                <c:if test="${not empty list.txHistories}">
                    <!-- 페이징 바 -->
                    <div class="pagination">
                        <%-- 이전 페이지 그룹이 있을 경우 --%>
                        <c:if test="${pageInfo.hasPrevGroup}">
                            <a class="page-btn"
                                href="/mypage/txHistories?page=${pageInfo.startPage - 1}&keyword=${condition.keyword}">
                                &lt;&lt;
                            </a>
                        </c:if>
                        <%-- 현재 페이지 그룹 표시 --%>
                        <c:forEach var="i" begin="${pageInfo.startPage}" end="${pageInfo.endPage}">
                            <a class="page-btn ${currentPage eq i  ? 'active' : ''}"
                                href="/mypage/txHistories?page=${i}&keyword=${condition.keyword}">
                                ${i}
                            </a>
                        </c:forEach>
                        <%-- 다음 페이지 그룹이 있을 경우 --%>
                        <c:if test="${pageInfo.hasNextGroup}">
                            <a class="page-btn"
                                href="/mypage/txHistories?page=${pageInfo.endPage + 1}&keyword=${condition.keyword}">
                                &gt;&gt;
                            </a>
                        </c:if>
                    </div>
                </c:if>
=======
        
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
>>>>>>> Stashed changes

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

<<<<<<< Updated upstream
=======
            </div>

>>>>>>> Stashed changes
        </div>

    </div>
    <!-- 공통 푸터 포함 -->
    <jsp:include page="/WEB-INF/views/common/footer.jsp" />
<<<<<<< Updated upstream
    <script src="/js/review.js"></script>
=======

>>>>>>> Stashed changes
</body>

</html>