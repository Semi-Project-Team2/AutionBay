<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>

<head>
    <meta charset="UTF-8">
    <title>AuctionBay - 마이페이지</title>
    <link rel="stylesheet" href="/css/common.css">
    <link rel="stylesheet" href="/css/mypage/common.css">
    <link rel="stylesheet" href="/css/mypage/tx.css">

</head>

<body>
    <!-- 공통 헤더 포함 -->
    <jsp:include page="/WEB-INF/views/common/header.jsp" />

    <div class="mypage-container">

        <!-- 프로필 영역 포함 -->
        <jsp:include page="/WEB-INF/views/mypage/profile/profile.jsp" />

        <!-- 메인 콘텐츠 (사이드바 + 내용) -->
        <div class="mypage-content-area">

            <!-- 사이드바 -->
            <jsp:include page="/WEB-INF/views/mypage/sidebar.jsp">
                <jsp:param name="activeMenu" value="txHistories"></jsp:param>
            </jsp:include>

            <!-- 우측 거래 내역 리스트 -->
            <div class="mypage-main">
                <div class="content-header">
                    <span class="content-title">거래 내역</span>
                        <form action="${pageContext.request.contextPath}/mypage/txHistories"
                            method="get" class="search-bar">
                            <input type="text" name="keyword" value="${param.keyword}"
                                id="mypageKeywordInput" 
                                placeholder="검색어를 입력하세요">
                            <button type="submit">검색</button>
                        </form>
                </div>

                <!-- 리스트 반복 영역 -->
                <div class="history-list mypage-list">
                    <c:choose>
                        <c:when test="${not empty list.txHistories}">
                            <c:forEach var="txHistory" items="${list.txHistories}">
                                <div class="history-card">
                                    <div class="history-info">
                                        <c:choose>
                                            <c:when test="${txHistory.tradeType == '경매'}">
                                                <a href="${pageContext.request.contextPath}/auction/${txHistory.productId}/detail"
                                                    class="tx-title">${txHistory.title}</a>
                                            </c:when>
                                            <c:otherwise>
                                                <a href="${pageContext.request.contextPath}/board/${txHistory.productId}/detail"
                                                    class="tx-title">${txHistory.title}</a>
                                            </c:otherwise>
                                        </c:choose>
                                        <span class="tx-type">${txHistory.tradeType}</span>
                                        <span class="tx-price">${txHistory.finalPrice}원</span>
                                        <span class="tx-partner">${txHistory.partnerNickname}</span>
                                        <span class="tx-date">${txHistory.completedAtStr}</span>
                                    </div>
                                    <%-- 후기 작성 버튼 --%>
                                    <div class="history-action">
                                        <c:choose>
                                            <c:when test="${txHistory.reviewWrited == true}">
                                                <button class="review-completed">후기 작성 완료</button>
                                            </c:when>
                                            <c:when test="${txHistory.reviewWrited == false}">
                                                <a href="${pageContext.request.contextPath}/mypage/review/writeForm?historyId=${txHistory.historyId}"
                                                class="btn-review">
                                                    후기 작성하기 
                                                </a>
                                            </c:when>
                                        </c:choose>
                                    </div>
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
                        <c:if test="${pageInfo.hasPrevGroup}">
                            <a class="page-btn"
                                href="/mypage/txHistories?page=${pageInfo.startPage - 1}&keyword=${condition.keyword}">
                                &lt;&lt;
                            </a>
                        </c:if>
                        <c:forEach var="i" begin="${pageInfo.startPage}" end="${pageInfo.endPage}">
                            <a class="page-btn ${currentPage eq i  ? 'active' : ''}"
                                href="/mypage/txHistories?page=${i}&keyword=${condition.keyword}">
                                ${i}
                            </a>
                        </c:forEach>
                        <c:if test="${pageInfo.hasNextGroup}">
                            <a class="page-btn"
                                href="/mypage/txHistories?page=${pageInfo.endPage + 1}&keyword=${condition.keyword}">
                                &gt;&gt;
                            </a>
                        </c:if>
                    </div>
                </c:if>

            </div>

        </div>
    </div>

    <!-- 공통 푸터 포함 -->
    <jsp:include page="/WEB-INF/views/common/footer.jsp" />
    <script src="/js/txHistory.js"></script>
</body>

</html>