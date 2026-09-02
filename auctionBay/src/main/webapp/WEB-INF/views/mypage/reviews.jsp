<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>마이페이지 - 후기</title>
    <link rel="stylesheet" href="/css/common.css">
    <link rel="stylesheet" href="/css/mypage/common.css">
    <link rel="stylesheet" href="/css/mypage/review.css">
</head>
<body>

    <!-- 공통 헤더 포함 -->
    <jsp:include page="/WEB-INF/views/common/header.jsp" />

    <div class="mypage-container">
        <!-- 프로필 영역 포함 -->
        <jsp:include page="/WEB-INF/views/mypage/profile/profile.jsp" />

        <!-- 메인 콘텐츠 영역 (공통 레이아웃 클래스 적용) -->
        <div class="mypage-content-area">
            
            <!-- 사이드바 -->
            <jsp:include page="/WEB-INF/views/mypage/sidebar.jsp">
                <jsp:param name="activeMenu" value="reviews"></jsp:param>
            </jsp:include>

            <!-- 후기 콘텐츠 영역 -->
            <main class="mypage-main">
                <!-- 탭 메뉴 -->
                <div class="review-tabs">
                    <button class="tab-btn ${activeTab eq 'received' ? 'active' : ''}">받은 후기</button>
                    <button class="tab-btn ${activeTab eq 'sent' ? 'active' : ''}">보낸 후기</button>
                </div>

                <!-- 1. 받은 후기 섹션 -->
                <div id="receivedSection" class="review-section ${activeTab eq 'received' ? 'active' : ''}">
                    <c:choose>
                        <c:when test="${not empty receivedReviews}">
                            <div class="mypage-list">
                                <c:forEach var="review" items="${receivedReviews}">
                                    <div class="review-item mypage-card">
                                        <div class="review-header">
                                            <span class="rating">⭐ ${review.rating}</span>
                                            <c:choose>
                                                <c:when test="${review.tradeType == '경매'}">
                                                    <a href="${pageContext.request.contextPath}/auction/${review.productId}/detail"
                                                        class="title">${review.title}</a>
                                                </c:when>
                                                <c:otherwise>
                                                    <a href="${pageContext.request.contextPath}/board/${review.productId}/detail"
                                                        class="title">${review.title}</a>
                                                </c:otherwise>
                                            </c:choose>
                                            <span class="nickname">${review.reviewerNickname}</span>
                                            <span class="time">${review.createdAtStr}</span>
                                        </div>
                                        <div class="review-body">
                                            <p>${review.content}</p>
                                        </div>
                                    </div>
                                </c:forEach>
                            </div>

                            <div class="pagination">
                                <c:if test="${receivedPageInfo.hasPrevGroup}">
                                    <a class="page-btn"
                                        href="/mypage/reviews?tab=received&page=${receivedPageInfo.startPage - 1}">&lt;&lt;</a>
                                </c:if>
                        
                                <c:forEach var="i" begin="${receivedPageInfo.startPage}" end="${receivedPageInfo.endPage}">
                                    <a class="page-btn ${currentPage eq i ? 'active' : ''}"
                                        href="/mypage/reviews?tab=received&page=${i}">${i}</a>
                                </c:forEach>

                                <c:if test="${receivedPageInfo.hasNextGroup}">
                                    <a class="page-btn"
                                        href="/mypage/reviews?tab=received&page=${receivedPageInfo.endPage + 1}">&gt;&gt;</a>
                                </c:if>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <div class="no-data">받은 후기가 없습니다.</div>
                        </c:otherwise>
                    </c:choose>
                </div>

                <!-- 2. 보낸 후기 섹션 -->
                <div id="sentSection" class="review-section ${activeTab eq 'sent' ? 'active' : ''}">
                    <c:choose>
                        <c:when test="${not empty sentReviews}">
                            <div class="mypage-list">
                                <c:forEach var="review" items="${sentReviews}">
                                    <div class="review-item mypage-card">
                                        <div class="review-header">
                                            <span class="rating">⭐ ${review.rating}</span>
                                            <span class="title">${review.title}</span>
                                            <span class="nickname">${review.revieweeNickname}</span>
                                            <span class="time">${review.createdAtStr}</span>
                                        </div>
                                        <div class="review-body">
                                            <p>${review.content}</p>
                                        </div>
                                    </div>
                                </c:forEach>
                            </div>

                            <div class="pagination">
                                <c:if test="${sentPageInfo.hasPrevGroup}">
                                    <a class="page-btn"
                                        href="/mypage/reviews?tab=sent&page=${sentPageInfo.startPage - 1}">&lt;&lt;</a>
                                </c:if>
                        
                                <c:forEach var="i" begin="${sentPageInfo.startPage}" end="${sentPageInfo.endPage}">
                                    <a class="page-btn ${currentPage eq i ? 'active' : ''}"
                                        href="/mypage/reviews?tab=sent&page=${i}">${i}</a>
                                </c:forEach>

                                <c:if test="${sentPageInfo.hasNextGroup}">
                                    <a class="page-btn"
                                        href="/mypage/reviews?tab=sent&page=${sentPageInfo.endPage + 1}">&gt;&gt;</a>
                                </c:if>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <div class="no-data">보낸 후기가 없습니다.</div>
                        </c:otherwise>
                    </c:choose>
                </div>
            </main>
        </div>
    </div>

    <!-- 공통 푸터 포함 -->
    <jsp:include page="/WEB-INF/views/common/footer.jsp" />

    <script src="/js/review.js"></script>
</body>
</html>