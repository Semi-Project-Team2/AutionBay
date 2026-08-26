<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>경매 상세 페이지</title>
    <style>
   /* ==========================================================
   1. 공통 및 초기화 스타일
   ========================================================== */
    * {
        box-sizing: border-box;
        margin: 0;
        padding: 0;
        font-family: 'Noto Sans KR', sans-serif;
    }

    body {
        background-color: #f4f6f8;
        color: #333;
    }

    /* ==========================================================
    2. 레이아웃 컨테이너
    ========================================================== */
    .page-container {
        width: 1200px;
        margin: 40px auto;
        display: flex;
        justify-content: center;
    }

    .auction-card {
        width: 440px;
        background-color: #ffffff;
        border-radius: 12px;
        padding: 24px;
        box-shadow: 0 4px 16px rgba(0, 0, 0, 0.06);
    }

    /* ==========================================================
    3. 경매 가격 헤더 영역
    ========================================================== */
    .price-header {
        display: flex;
        justify-content: space-between;
        align-items: baseline;
        margin-bottom: 16px;
        padding-bottom: 12px;
        border-bottom: 2px solid #f0f0f0;
    }

    .price-label {
        font-size: 15px;
        font-weight: 600;
        color: #666;
    }

    .price-value {
        font-size: 28px;
        font-weight: 700;
        color: #111;
    }

    /* ==========================================================
    4. 경매 정보 박스
    ========================================================== */
    .auction-info-box {
        background-color: #f9fafb;
        border-radius: 8px;
        padding: 16px;
        margin-bottom: 20px;
        border: 1px solid #eee;
    }

    .info-row {
        display: flex;
        align-items: center;
        margin-bottom: 12px;
        font-size: 13px;
    }

    .info-row:last-child {
        margin-bottom: 0;
    }

    .info-label {
        width: 85px;
        color: #777;
        font-weight: 500;
        flex-shrink: 0;
    }

    .info-content {
        flex-grow: 1;
        color: #333;
    }

    .start-price-text {
        font-weight: 600;
        font-size: 14px;
        color: #444;
    }

    .time-highlight {
        font-weight: 600;
        color: #d9534f; /* 남은 시간 강조 색상 */
    }

    .time-sub {
        color: #888;
        font-size: 11px;
        margin-top: 2px;
    }

    .history-link {
        color: #3182ce;
        text-decoration: none;
        font-weight: 500;
        margin-left: 6px;
    }

    .history-link:hover {
        text-decoration: underline;
    }

    .divider {
        height: 1px;
        background-color: #e5e7eb;
        margin: 14px 0;
    }

    /* ==========================================================
    5. 입찰 입력 및 조절 영역
    ========================================================== */
    .bid-input-container {
        display: flex;
        align-items: center;
        gap: 8px;
    }

    .btn-circle {
        width: 32px;
        height: 32px;
        border-radius: 50%;
        border: 1px solid #cbd5e1;
        background: #ffffff;
        cursor: pointer;
        display: flex;
        align-items: center;
        justify-content: center;
        font-size: 15px;
        font-weight: bold;
        color: #475569;
        transition: all 0.2s;
    }

    .btn-circle:hover {
        background-color: #f1f5f9;
        border-color: #94a3b8;
    }

    .bid-input-group {
        display: flex;
        align-items: center;
        border: 1px solid #cbd5e1;
        border-radius: 6px;
        overflow: hidden;
        background-color: #fff;
        width: 150px;
    }

    .bid-input {
        width: 110px;
        border: none;
        text-align: right;
        padding: 6px 8px;
        font-size: 14px;
        outline: none;
        color: #1e293b;
    }

    .input-unit {
        font-size: 13px;
        color: #64748b;
        padding-right: 8px;
    }

    /* ==========================================================
    6. 상품 설명 본문 영역
    ========================================================== */
    .description-box {
        background-color: #fff;
        border: 1px solid #e2e8f0;
        border-radius: 6px;
        padding: 16px;
        min-height: 100px;
        max-height: 150px;
        overflow-y: auto;
        color: #334155;
        font-size: 14px;
        line-height: 1.5;
        margin-top: 16px;
    }

    /* ==========================================================
    7. 하단 액션 버튼 그룹 (입찰하기 + 찜하기)
    ========================================================== */
    .action-group {
        display: flex;
        gap: 8px;
        margin-top: 16px;
    }

    .btn-submit {
        flex-grow: 1;
        height: 46px;
        background-color: #0f172a;
        color: #fff;
        border: none;
        border-radius: 6px;
        font-size: 15px;
        font-weight: 600;
        cursor: pointer;
        transition: background-color 0.2s;
    }

    .btn-submit:hover {
        background-color: #1e293b;
    }

    /* 찜 버튼 디자인 개선 */
    #wishBtn {
        width: 46px;
        height: 46px;
        background: #ffffff;
        border: 1px solid #cbd5e1;
        border-radius: 6px;
        cursor: pointer;
        font-size: 20px;
        display: flex;
        align-items: center;
        justify-content: center;
        transition: all 0.2s ease;
    }

    #wishBtn:hover {
        transform: scale(1.05);
        background-color: #f8fafc;
    }

    #wishBtn .fa-regular.fa-heart {
        color: #94a3b8;
        transition: color 0.2s ease;
    }

    #wishBtn .fa-regular.fa-heart:hover {
        color: #ef4444;
    }

    #wishBtn .fa-solid.fa-heart {
        color: #ef4444;
    }

    /* ==========================================================
    8. 판매자 프로필 영역
    ========================================================== */
    .seller-card {
        margin-top: 20px;
        padding-top: 16px;
        border-top: 1px solid #e5e7eb;
    }

    .seller-header {
        display: flex;
        justify-content: space-between;
        align-items: center;
        margin-bottom: 10px;
    }

    .seller-name {
        font-weight: 600;
        font-size: 14px;
        color: #1e293b;
    }

    .btn-message {
        background-color: #f1f5f9;
        border: 1px solid #cbd5e1;
        padding: 6px 12px;
        border-radius: 4px;
        font-size: 12px;
        font-weight: 500;
        cursor: pointer;
        color: #334155;
        transition: background-color 0.2s;
    }

    .btn-message:hover {
        background-color: #e2e8f0;
    }

    .seller-stats {
        display: flex;
        background-color: #f9fafb;
        border: 1px solid #f0f0f0;
        border-radius: 6px;
        padding: 10px 12px;
        align-items: center;
    }

    .stat-item {
        width: 100%;
    }

    .stat-value {
        font-size: 13px;
        color: #475569;
        display: flex;
        align-items: center;
        justify-content: space-between;
        width: 100%;
    }

    .review-count-text {
        font-size: 12px;
        color: #64748b;
        margin-left: 6px;
    }

    /* ==========================================================
    9. 공통 모달창 스타일 (입찰 기록 & 리뷰 기록)
    ========================================================== */
    .modal-overlay {
        display: none;
        position: fixed;
        top: 0;
        left: 0;
        width: 100vw;
        height: 100vh;
        background-color: rgba(0, 0, 0, 0.4);
        z-index: 9999;
        justify-content: center;
        align-items: center;
    }

    .modal-container {
        background-color: #fff;
        width: 440px;
        border-radius: 12px;
        padding: 20px;
        box-shadow: 0 10px 25px rgba(0, 0, 0, 0.1);
        max-height: 80vh;
        display: flex;
        flex-direction: column;
    }

    .modal-header {
        display: flex;
        justify-content: space-between;
        align-items: center;
        border-bottom: 1px solid #e5e7eb;
        padding-bottom: 12px;
        margin-bottom: 12px;
    }

    .modal-title {
        font-size: 16px;
        font-weight: 700;
        color: #1e293b;
    }

    .modal-close {
        background: none;
        border: none;
        font-size: 22px;
        cursor: pointer;
        color: #94a3b8;
        line-height: 1;
    }

    .modal-close:hover {
        color: #0f172a;
    }
    /* --- 별점 UI 스타일 --- */
    .star-rating {
        position: relative;
        unicode-bidi: bidi-override;
        color: #ddd; /* 빈 별 색상 */
        font-size: 14px; /* 별 크기 조절 */
        font-family: Arial, sans-serif;
        letter-spacing: 2px;
    }

    .star-rating-fill {
        position: absolute;
        top: 0;
        left: 0;
        white-space: nowrap;
        overflow: hidden;
        color: #f59e0b; /* 채워진 별 색상 (노란색) */
    }

    /* 모달 내부 리스트 스크롤 영역 공통 */
    .bid-history-list,
    .review-list {
        overflow-y: auto;
        max-height: 350px;
        display: flex;
        flex-direction: column;
        gap: 8px;
        padding-right: 4px;
    }

    /* 입찰/리뷰 아이템 카드 공통 스타일 */
    .bid-history-item{
        display: flex;
        justify-content: space-between;
        align-items: center;
        padding: 12px;
        background-color: #f8fafc;
        border: 1px solid #f1f5f9;
        border-radius: 8px;
        font-size: 13px;
    }

    .review-list-item {
        display: flex;
        flex-direction: column; /* 위아래로 배치 */
        align-items: flex-start;
        padding: 14px;
        background-color: #f8fafc;
        border: 1px solid #f1f5f9;
        border-radius: 8px;
        font-size: 13px;
        gap: 8px; /* 위쪽(정보)과 아래쪽(내용) 간격 */
    }

    .bid-history-user-info{
        display: flex;
        align-items: center;
        gap: 8px;
    }

    .review-list-user-info {
        display: flex;
        align-items: center;
        justify-content: space-between;
        width: 100%;
    }
    .bid-history-username {
        font-weight: 600;
        color: #334155;
    }

    .review-list-userNickname {
        font-weight: 600;
        color: #334155;
        white-space: nowrap; 
    }

    .bid-history-date {
        color: #94a3b8;
        font-size: 11px;
    }

    .review-list-date {
        color: #94a3b8;
        font-size: 11px;
    }

    .bid-history-price{
        font-weight: 600;
        color: #0f172a;
    }

    .review-list-content {
        font-weight: normal;
        color: #475569;
        width: 100%;
        word-break: break-all;
        line-height: 1.4;
    }

    /* 데이터가 없을 때 엠티 박스 */
    .bid-history-empty,
    .review-list-empty {
        text-align: center;
        padding: 40px 0;
        color: #94a3b8;
        font-size: 13px;
    }
        
    </style>
    <link rel="stylesheet" href="/css/common.css">
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>
<body>
    <!-- 공통 헤더 -->
    <jsp:include page="/WEB-INF/views/common/header.jsp" />

    <!-- 전체를 감싸는 중앙 정렬 컨테이너 -->
    <div class="page-container">
        <div class="auction-card">
            <!-- 현재가 헤더 -->
            <div class="price-header">
                <span class="price-label">현재가</span>
                <span class="price-value" id="currentPrice"><fmt:formatNumber value="${empty bids ? product.auctionStartPrice : bids[0].bidPrice}" pattern="#,###" />원</span>
            </div>

            <!-- 경매 및 상품 상세 정보 박스 -->
            <div class="auction-info-box">
                <!-- 남은시간 -->
                <div class="info-row">
                    <span class="info-label">남은시간</span>
                    <div class="info-content">
                        <div class="time-highlight" id="remainingTime"></div>
                        <div class="time-sub" id="auctionEndTime">${product.auctionEndTime}</div>
                    </div>
                </div>

                <!-- 경매 시작가 -->
                <div class="info-row">
                    <span class="info-label">시작가격</span>
                    <div class="info-content start-price-text" id="startPrice">
						<fmt:formatNumber value="${product.auctionStartPrice}" pattern="#,###" />원
					</div>
                </div>

                <!-- 입찰기록 -->
                <div class="info-row">
                    <span class="info-label">입찰기록</span>
                    <div class="info-content">
                        <strong id="bidCount">${bidCount}</strong> 
                        <a href="#" id="btnBidHistory" class="history-link">[기록보기]</a>
                    </div>
                </div>

                <div class="divider"></div>

                <!-- 입찰단위 -->
                <div class="info-row">
                    <span class="info-label">입찰단위</span>
                    <div class="info-content" id="bidUnit">3,000원</div>
                </div>

                <!-- 희망 입찰가 -->
                <div class="info-row">
                    <span class="info-label">희망 입찰가</span>
                    <div class="info-content">
                        <div class="bid-input-container">
                            <button type="button" class="btn-circle" id="btnMinusBid">-</button>
                            <div class="bid-input-group">
                                <input type="text" class="bid-input" id="bidInput" >
                                <span class="input-unit">원</span>
                            </div>
                            <button type="button" class="btn-circle" id="btnPlusBid">+</button>
                        </div>
                    </div>
                </div>

                <!-- description 영역 -->
                <div class="description-box" id="productDescription">
                    ${product.description}
                </div>
            </div>

            <!-- 버튼 영역 -->
            <div class="action-group">
                <button type="button" class="btn-submit" id="btnSubmitBid" data-product-id="${product.productId}">입찰하기</button>
				<button type="button" id="wishBtn" data-product-id="${product.productId}">
				    <i class="${isLiked ? 'fa-solid fa-heart' : 'fa-regular fa-heart'}"></i>
				</button>
            </div>

            <!-- 판매자 정보 영역 -->
            <div class="seller-card">
                <div class="seller-header">
                    <div class="seller-info">
                        <span class="seller-name" id="sellerNickname">유저 닉네임 : ${product.writerNickname}</span>
                    </div>
                    <button type="button" class="btn-message" id="btnSendMessage" 
							data-product-id="${product.productId}"
							data-receiver-no="${product.writerNo}"
							data-redirect-url="${pageContext.request.contextPath}/auction/${product.productId}/detail">판매자에게 쪽지</button>
                </div>
                <div class="seller-stats">
                    <div class="stat-item">
                        <div class="stat-value">
                            <span id="reviewAverage">리뷰 평균 : ${reviewSummary.reviewAvg}</span> 
                            <span id="reviewCount" class="review-count-text">리뷰개수 : ${reviewSummary.reviewCount}</span>
                            <a href="#" id="btnReviewHistory" class="history-link">[기록보기]</a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
	<!-- 입찰 기록 모달 창 -->
    <div class="modal-overlay" id="bidModalOverlay">
        <div class="modal-container">
            <div class="modal-header">
                <span class="modal-title">실시간 입찰 기록</span>
                <button type="button" class="modal-close" id="btnCloseModal">&times;</button>
            </div>
            <div class="bid-history-list">
                <c:choose>
                    <c:when test="${not empty bids}">
                        <c:forEach var="bid" items="${bids}">
                            <div class="bid-history-item">
                                <div class="bid-history-user-info">
                                    <span class="bid-history-username">${bid.bidderId}</span>
                                    <span class="bid-history-date">${bid.createdAtStr}</span>
                                </div>
                                <div class="bid-history-price">
                                    <fmt:formatNumber value="${bid.bidPrice}" pattern="#,###" />원
                                </div>
                            </div>
                        </c:forEach>
                    </c:when>
                    <c:otherwise>
                        <div class="bid-history-empty">
                            아직 입찰 기록이 없습니다.
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </div>
    <!-- 리뷰 기록 모달 창 -->
    <div class="modal-overlay" id="reviewModalOverlay">
        <div class="modal-container">
            <div class="modal-header">
                <span class="modal-title">리뷰 기록</span>
                <button type="button" class="modal-close" id="btnCloseReviewModal">&times;</button>
            </div>
            <div class="review-list">
                <c:choose>
                    <c:when test="${not empty reviewList}">
                        <c:forEach var="review" items="${reviewList}">
                            <div class="review-list-item">
                                <div class="review-list-user-info">
                                    <span class="review-list-userNickname">${review.reviewerNickname}</span>
                                    <!-- 숫자 평점을 별점으로 변환하는 UI -->
                                    <div class="star-rating" title="평점: ${review.rating}점">
                                        ★★★★★
                                        <div class="star-rating-fill" style="width: calc(${review.rating} * 10%);">
                                            ★★★★★
                                        </div>
                                    </div>
                                    <span class="review-list-date">${review.createdAtStr}</span>
                                </div>
                                <div class="review-list-content">
                                    ${review.content}
                                </div>
                            </div>
                        </c:forEach>
                    </c:when>
                    <c:otherwise>
                        <div class="review-list-empty">
                            아직 리뷰 기록이 없습니다.
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </div>

    <script>
    <c:if test="${not empty message}">
        alert("${message}");
    </c:if>
    </script>

    <!-- 공통 푸터 -->
    <jsp:include page="/WEB-INF/views/common/footer.jsp" />

    <!-- 자바스크립트 파일 연결 -->
    <script src="/js/auctionDetail.js"></script>
</body>
</html>