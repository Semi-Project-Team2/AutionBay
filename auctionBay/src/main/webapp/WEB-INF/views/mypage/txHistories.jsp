<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <!DOCTYPE html>
        <html>

        <head>
            <meta charset="UTF-8">
            <title>AuctionBay - 마이페이지</title>
            <link rel="stylesheet" href="/css/common.css">
            <style>
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
            <!-- 공통 헤더 포함 -->
            <jsp:include page="/WEB-INF/views/common/header.jsp" />

            <div class="container">

               <!-- 프로필 영역 포함 -->
               <jsp:include page="/WEB-INF/views/mypage/profile/profile.jsp" />

                <!-- 2. 메인 콘텐츠 (사이드바 + 내용) -->
                <div class="mypage-content">

                    <!-- 사이드바 -->
                    <div class="mypage-sidebar">
                        <a href="${pageContext.request.contextPath}/mypage/products" class="sidebar-item">게시글 관리</a>
                        <a href="${pageContext.request.contextPath}/mypage/comments" class="sidebar-item">댓글 관리</a>
                        <a href="${pageContext.request.contextPath}/mypage/txHistories" class="sidebar-item active">거래
                            내역</a>
                        <a href="${pageContext.request.contextPath}/mypage/reviews" class="sidebar-item">후기</a>
                        <a href="${pageContext.request.contextPath}/mypage/recents" class="sidebar-item">최근 본 글</a>
                    </div>

                    <!-- 우측 거래 내역 리스트 -->
                    <div class="mypage-main">
                        <div class="content-header">
                            <span class="content-title">거래 내역</span>
                            <div class="search-bar">
                                <form action="${pageContext.request.contextPath}/mypage/txHistories" method="get"
                                    style="width: 100%;">
                                    <input type="text" name="keyword" value="${param.keyword}"
                                        placeholder="제목 또는 닉네임 검색">
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
                                                <span>${txHistory.title}</span>
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
                                                    <span class="review-completed">후기 작성 완료</span>
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
                                    <span>거래 내역이 없습니다.</span>
                                </c:otherwise>
                            </c:choose>

                        </div>

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

                    </div>

                </div>

            </div>
            <!-- 공통 푸터 포함 -->
            <jsp:include page="/WEB-INF/views/common/footer.jsp" />
            <script src="/js/review.js"></script>
        </body>

        </html>