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
        * {
            box-sizing: border-box;
            margin: 0;
            padding: 0;
            font-family: 'Noto Sans KR', sans-serif;
        }

        /* 전체 페이지 배경 및 기본 흐름 설정 수정 완료 */
        body {
            background-color: #f9f9f9;
            margin: 0;
            padding: 0;
            color: #333;
        }

        /* 경매 카드만 중앙에 예쁘게 오도록 감싸는 컨테이너 */
        .page-container {
            width: 1200px;
            margin: 30px auto;
            display: flex;
            justify-content: center;
        }

        .auction-card {
            width: 400px;
            background-color: #ffffff;
            border-radius: 8px;
            padding: 20px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.05);
        }

        /* 현재가 영역 */
        .price-header {
            display: flex;
            justify-content: space-between;
            align-items: baseline;
            margin-bottom: 4px;
        }

        .price-label {
            font-size: 16px;
            font-weight: bold;
            color: #333;
        }

        .price-value {
            font-size: 26px;
            font-weight: bold;
            color: #222;
        }

        /* 경매 정보 박스 */
        .auction-info-box {
            background-color: #f8f8f8;
            border-radius: 8px;
            padding: 16px;
            margin-bottom: 16px;
        }

        .info-row {
            display: flex;
            align-items: center;
            margin-bottom: 12px;
            font-size: 13px;
        }

        .info-label {
            width: 80px;
            color: #888;
            flex-shrink: 0;
        }

        .info-content {
            flex-grow: 1;
            color: #333;
        }

        /* 시작가 강조 스타일 */
        .start-price-text {
            font-weight: bold;
            font-size: 14px;
        }

        .time-highlight {
            font-weight: bold;
            color: #222;
        }

        .time-sub {
            color: #888;
            font-size: 12px;
            margin-top: 2px;
        }

        .history-link {
            color: #999;
            text-decoration: none;
            margin-left: 4px;
        }

        .divider {
            height: 1px;
            background-color: #eaeaea;
            margin: 12px 0;
        }

        /* 희망 입찰가 입력창 */
        .bid-input-group {
            display: flex;
            align-items: center;
            border: 1px solid #ddd;
            border-radius: 4px;
            overflow: hidden;
            background-color: #fff;
            width: 180px;
        }

        .btn-circle {
            width: 28px;
            height: 28px;
            border-radius: 50%;
            border: 1px solid #e0e0e0;
            background: #f5f5f5;
            cursor: pointer;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 14px;
            color: #666;
        }

        .bid-input-container {
            display: flex;
            align-items: center;
            gap: 6px;
        }

        .bid-input {
            width: 100px;
            border: none;
            text-align: right;
            padding: 4px 6px;
            font-size: 13px;
            outline: none;
        }

        .input-unit {
            font-size: 12px;
            color: #333;
            padding-right: 8px;
        }

        /* Description 본문 영역 */
        .description-box {
            background-color: #fff;
            border-radius: 6px;
            height: 120px;
            display: flex;
            align-items: center;
            justify-content: center;
            color: #333;
            font-size: 18px;
            margin-top: 16px;
        }

        /* 버튼 영역 */
        .action-group {
            display: flex;
            gap: 8px;
            margin-top: 16px;
        }

        .btn-submit {
            flex-grow: 1;
            height: 42px;
            background-color: #222;
            color: #fff;
            border: none;
            border-radius: 4px;
            font-size: 14px;
            font-weight: bold;
            cursor: pointer;
        }

        .btn-wish {
            width: 42px;
            height: 42px;
            background-color: #fff;
            border: 1px solid #ddd;
            border-radius: 4px;
            display: flex;
            align-items: center;
            justify-content: center;
            cursor: pointer;
            font-size: 16px;
            color: #555;
        }

        /* 판매자 프로필 영역 */
        .seller-card {
            margin-top: 20px;
            padding-top: 16px;
            border-top: 1px solid #eee;
        }

        .seller-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 12px;
        }

        .seller-info {
            display: flex;
            align-items: center;
            gap: 6px;
        }

        .seller-name {
            font-weight: bold;
            font-size: 15px;
            color: #222;
        }

        .btn-message {
            background-color: #e0e0e0;
            border: none;
            padding: 8px 12px;
            border-radius: 4px;
            font-size: 13px;
            font-weight: 500;
            cursor: pointer;
            color: #333;
        }

        .seller-stats {
            display: flex;
            background-color: #f9f9f9;
            border-radius: 6px;
            padding: 10px;
            text-align: center;
        }

        .stat-item {
            flex: 1;
        }

        .stat-value {
            font-weight: bold;
            font-size: 14px;
            color: #222;
        }

        .review-count-text {
            font-size: 11px;
            color: #999;
            font-weight: normal;
        }
		/* --- 입찰 기록 모달 내부 상세 스타일 --- */
        .modal-overlay {
            display: none; /* 평소에는 숨김 */
            position: fixed;
            top: 0;
            left: 0;
            width: 100vw;   /* 뷰포트 전체 너비 */
            height: 100vh;  /* 뷰포트 전체 높이 */
            background-color: rgba(0, 0, 0, 0.5); /* 반투명 배경 */
            z-index: 9999;
            justify-content: center; /* 가로 중앙 정렬 */
            align-items: center;     /* 세로 중앙 정렬 */
        }

        .modal-container {
            background-color: #fff;
            width: 420px;
            border-radius: 8px;
            padding: 20px;
            box-shadow: 0 4px 12px rgba(0,0,0,0.15);
            max-height: 80vh;
            display: flex;
            flex-direction: column;
        }

        .modal-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            border-bottom: 1px solid #eee;
            padding-bottom: 12px;
            margin-bottom: 15px;
        }

        .modal-title {
            font-size: 16px;
            font-weight: bold;
            color: #222;
        }

        .modal-close {
            background: none;
            border: none;
            font-size: 20px;
            cursor: pointer;
            color: #888;
        }
        .modal-close:hover {
            color: #000;
        }

        .bid-history-list {
            overflow-y: auto;
            max-height: 320px;
            display: flex;
            flex-direction: column;
            gap: 8px;
            padding-right: 4px;
        }

        .bid-history-item {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 10px 12px;
            background-color: #f8f9fa;
            border-radius: 6px;
            font-size: 13px;
        }

        .bid-history-empty {
            text-align: center;
            padding: 40px 0;
            color: #888;
            font-size: 13px;
        }

        .bid-history-user-info {
            display: flex;
            align-items: center;
        }

        .bid-history-username {
            font-weight: bold;
            margin-right: 10px;
        }

        .bid-history-date {
            color: #888;
            font-size: 11px;
        }

        .bid-history-price {
            font-weight: bold;
            color: #111;
        }
		
		/* 찜 버튼 전체 스타일 (테두리, 배경 제거 및 정렬) */
		#wishBtn {
		    background: transparent;
		    border: none;
		    cursor: pointer;
		    font-size: 24px; /* 아이콘 크기 조절 */
		    padding: 8px;
		    display: flex;
		    align-items: center;
		    justify-content: center;
		    transition: transform 0.2s ease; /* 부드러운 효과 */
		}

		/* 마우스 올렸을 때 살짝 커지는 효과 */
		#wishBtn:hover {
		    transform: scale(1.1);
		}

		/* 1. 빈 하트 (기본 상태) */
		#wishBtn .fa-regular.fa-heart {
		    color: #999; /* 평소에는 회색빛 */
		    transition: color 0.2s ease;
		}

		#wishBtn .fa-regular.fa-heart:hover {
		    color: #ff4757; /* 마우스 올렸을 때 빨간색으로 미리보기 */
		}

		/* 2. 채워진 하트 (isLiked가 true일 때: fa-solid 클래스) */
		#wishBtn .fa-solid.fa-heart {
		    color: #ff4757; /* 선명한 빨간색 */
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
                    <button type="button" class="btn-message" id="btnSendMessage">판매자에게 쪽지</button>
                </div>
                <div class="seller-stats">
                    <div class="stat-item">
                        <div class="stat-value">
                            <span id="reviewAverage">리뷰 평균 : ${reviewSummary.reviewAvg}</span> 
                            <span id="reviewCount" class="review-count-text">리뷰개수 : ${reviewSummary.reviewCount}</span>
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