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
        flex-wrap: wrap; /* 댓글 영역을 아래로 내리기 위해 wrap 설정 */
        gap: 24px; /* 좌측 이미지 영역과 우측 카드 사이의 간격 */
        justify-content: center;
        align-items: flex-start;
    }

    .auction-card {
        width: 440px;
        background-color: #ffffff;
        border-radius: 12px;
        padding: 24px;
        box-shadow: 0 4px 16px rgba(0, 0, 0, 0.06);
    }

    /* ==========================================================
    2-1. 좌측 상품 이미지 영역 스타일
    ========================================================== */
    .product-image-section {
        width: 500px; /* 이미지 영역 너비 설정 */
        background-color: #ffffff;
        border-radius: 12px;
        padding: 20px;
        box-shadow: 0 4px 16px rgba(0, 0, 0, 0.06);
        display: flex;
        flex-direction: column;
        gap: 14px;
    }
	/* 제목과 경매 뱃지를 한 줄에 배치하기 위한 래퍼 */
	.product-title-header-wrapper {
	    display: flex;
	    align-items: center;
	    gap: 8px;
	    margin-bottom: 4px;
	}

	/* '경매' 뱃지 스타일 (분홍색 계열로 변경) */
	.auction-badge {
	    background-color: #fff0f5; /* 연한 핑크빛 배경 */
	    color: #ff2d55;            /* 진한 핑크/핫핑크 텍스트 */
	    font-size: 13px;
	    font-weight: 700;
	    padding: 3px 8px;
	    border-radius: 6px;
	    border: 1px solid #ffb6c1; /* 연한 핑크 테두리 */
	    flex-shrink: 0;
	}

	/* 기존 product-title-header 마진 조정 */
	.product-title-header {
	    font-size: 22px; 
	    font-weight: 700;
	    color: #0f172a;  
	    word-break: break-all;
	    line-height: 1.4;
	    margin-bottom: 0; /* 래퍼로 마진을 이동했으므로 0으로 설정 */
	}
	.product-title-header {
        font-size: 22px; /* 글씨 크기 확대 (기존 18px -> 22px) */
        font-weight: 700;
        color: #0f172a;  /* 색상을 조금 더 진하게 조정 */
        word-break: break-all;
        line-height: 1.4;
    }

    .main-image-container {
        width: 100%;
        height: 450px; /* 대표 이미지 박스 높이 */
        border-radius: 8px;
        overflow: hidden;
        border: 1px solid #e2e8f0;
        display: flex;
        align-items: center;
        justify-content: center;
        background-color: #f8fafc;
    }

    .main-image-container img,
    .main-image-container video {
        width: 100%;
        height: 100%;
        object-fit: cover; /* 이미지가 비율을 유지하며 가득 차도록 설정 */
        transition: transform 0.3s ease;
    }

    /* 이미지 없을 때 대체 이미지 전용 스타일 */
    .no-image {
        width: 100%;
        height: 100%;
        object-fit: contain;
        opacity: 0.5;
    }

    /* 비디오 전용 스타일 */
    .main-video-element {
        width: 100%;
        height: 100%;
        object-fit: cover;
    }

    /* 썸네일 리스트 스타일 */
    .thumbnail-list {
        display: flex;
        gap: 10px;
        margin-top: 14px;
        overflow-x: auto;
        padding-bottom: 4px;
    }

    .thumbnail-item {
        width: 75px;
        height: 75px;
        border-radius: 6px;
        overflow: hidden;
        border: 2px solid transparent;
        cursor: pointer;
        flex-shrink: 0;
        background-color: #f8fafc;
        transition: all 0.2s;
        position: relative;
    }

    .thumbnail-item img {
        width: 100%;
        height: 100%;
        object-fit: cover;
    }

    .thumbnail-item:hover {
        border-color: #94a3b8;
    }

    .thumbnail-item.active {
        border-color: #0f172a; /* 선택된 썸네일 강조 테두리 */
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
    10. 게시글 수정/삭제 버튼 영역 (우측 하단 배치용)
    ========================================================== */
    .post-owner-actions {
        width: 1000px;
        display: flex;
        justify-content: flex-end;
        gap: 8px;
        margin-top: -10px;
    }

    .btn-owner {
        padding: 8px 16px;
        font-size: 13px;
        font-weight: 600;
        border-radius: 6px;
        cursor: pointer;
        border: 1px solid #cbd5e1;
        background-color: #ffffff;
        color: #334155;
        transition: all 0.2s;
    }

    .btn-owner:hover {
        background-color: #f1f5f9;
    }

    .btn-owner.delete {
        color: #ef4444;
        border-color: #fca5a5;
    }

    .btn-owner.delete:hover {
        background-color: #fef2f2;
    }

    /* ==========================================================
    11. 댓글 영역 (페이지 하단 단독 배치)
    ========================================================== */
    .comment-section-full {
        width: 964px;
        background-color: #ffffff;
        border-radius: 12px;
        padding: 24px;
        box-shadow: 0 4px 16px rgba(0, 0, 0, 0.06);
        margin-top: 10px;
    }

    .comment-section_title {
        font-size: 16px;
        font-weight: 700;
        margin-bottom: 16px;
        color: #1e293b;
    }

    .comment-list {
        list-style: none;
        display: flex;
        flex-direction: column;
        gap: 12px;
        margin-bottom: 20px;
    }

    .comment-item {
        display: flex;
        justify-content: space-between;
        align-items: center;
        background: #f8fafc;
        padding: 14px;
        border-radius: 8px;
        border: 1px solid #f1f5f9;
        font-size: 13px;
    }

    .comment-list_body {
        display: flex;
        align-items: center;
        gap: 10px;
        flex-wrap: wrap;
    }

    .comment-list_writer {
        font-weight: 600;
        color: #334155;
    }

    .comment-list_content {
        color: #475569;
    }

    .comment-list_date {
        color: #94a3b8;
        font-size: 11px;
    }

    .comment-delete-btn {
        font-size: 11px;
        padding: 4px 8px;
        cursor: pointer;
        background: #ffffff;
        border: 1px solid #cbd5e1;
        border-radius: 4px;
        color: #64748b;
        transition: all 0.2s;
    }

    .comment-delete-btn:hover {
        background-color: #fef2f2;
        color: #ef4444;
        border-color: #fca5a5;
    }

    .comment-form {
        display: flex;
        gap: 8px;
    }

    .comment-textarea {
        flex-grow: 1;
        resize: none;
        padding: 10px;
        border: 1px solid #cbd5e1;
        border-radius: 6px;
        font-size: 13px;
        outline: none;
        height: 60px;
    }

    .comment-submit-btn {
        padding: 0 20px;
        background: #0f172a;
        color: white;
        border: none;
        border-radius: 6px;
        cursor: pointer;
        font-size: 13px;
        font-weight: 600;
        transition: background-color 0.2s;
    }

    .comment-submit-btn:hover {
        background: #1e293b;
    }

    .form-tip {
        font-size: 13px;
        color: #64748b;
    }

    .form-tip a {
        color: #3182ce;
        text-decoration: none;
        font-weight: 500;
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
        color: #ddd;
        font-size: 14px;
        font-family: Arial, sans-serif;
        letter-spacing: 2px;
    }

    .star-rating-fill {
        position: absolute;
        top: 0;
        left: 0;
        white-space: nowrap;
        overflow: hidden;
        color: #f59e0b;
    }

    .bid-history-list,
    .review-list {
        overflow-y: auto;
        max-height: 350px;
        display: flex;
        flex-direction: column;
        gap: 8px;
        padding-right: 4px;
    }

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
        flex-direction: column;
        align-items: flex-start;
        padding: 14px;
        background-color: #f8fafc;
        border: 1px solid #f1f5f9;
        border-radius: 8px;
        font-size: 13px;
        gap: 8px;
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

    .bid-history-date,
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

	<div id="server-data" data-message="${message}"></div>
    <!-- 상품 ID, 작성자 여부를 숨겨서 자바스크립트에서 접근 가능하게 함 -->
    <input type="hidden" id="product-id-value" value="${product.productId}">
    <input type="hidden" id="is-Owner-value" value="${isOwner}">

    <!-- 전체를 감싸는 중앙 정렬 컨테이너 -->
    <div class="page-container">
        
        <!-- 왼쪽: 상품 미디어 영역 -->
		<div class="product-image-section">
		    <div class="product-title-header-wrapper">
		        <span class="auction-badge">경매</span>
		        <h2 class="product-title-header">${product.title}</h2>
		    </div>

		    <div class="main-image-container" id="mainImageContainer">
                <c:choose>
                    <c:when test="${not empty product.mediaList}">
                        <c:set var="firstMedia" value="${product.mediaList[0]}" />
                        <c:choose>
                            <c:when test="${firstMedia.mediaType == 'VIDEO'}">
                                <video id="mainVideo" src="${firstMedia.mediaUrl}" controls class="main-video-element"></video>
                            </c:when>
                            <c:otherwise>
                                <img id="mainImage" src="${firstMedia.mediaUrl}" alt="${product.title}">
                            </c:otherwise>
                        </c:choose>
                    </c:when>
					<c:otherwise>
					    <img src="${pageContext.request.contextPath}/uploads/product/common/default_thumb.png" alt="이미지 없음" class="no-image">
					</c:otherwise>
                </c:choose>
            </div>
            
            <!-- 썸네일 리스트 (미디어가 여러 개일 경우) -->
            <c:if test="${not empty product.mediaList && product.mediaList.size() > 1}">
                <div class="thumbnail-list">
                    <c:forEach var="media" items="${product.mediaList}" varStatus="status">
                        <div class="thumbnail-item ${status.first ? 'active' : ''}" 
                             onclick="changeMainMedia(this, '${media.mediaUrl}', '${media.mediaType}')">
                            <c:choose>
                                <c:when test="${not empty media.thumbnailUrl}">
                                    <img src="${media.thumbnailUrl}" alt="썸네일">
                                </c:when>
                                <c:otherwise>
                                    <img src="${media.mediaUrl}" alt="썸네일">
                                </c:otherwise>
                            </c:choose>
                            <c:if test="${media.mediaType == 'VIDEO'}">
                                <div class="video-badge"><i class="fa-solid fa-play"></i></div>
                            </c:if>
                        </div>
                    </c:forEach>
                </div>
            </c:if>
        </div>

        <!-- 우측 기존 경매 상세 카드 영역 -->
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
				<!-- 상품 상태 -->
                <div class="info-row">
                    <span class="info-label">상품상태</span>
                    <div class="info-content" id="productCondition">
						<c:choose >
							<c:when test="${product.productCondition == 'NEW'}">
								미개봉
							</c:when>
							<c:when test="${product.productCondition == 'LIKE_NEW'}">
								거의새것
							</c:when>
							<c:when test="${product.productCondition == 'USED'}">
								사용감있음
							</c:when>	
						</c:choose>
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

        <!-- 글 작성자일 경우에만 노출되는 수정/삭제 버튼 영역 (우측 하단 배치) -->
        <c:if test="${isOwner}">
            <div class="post-owner-actions">
                <button type="button" class="btn-owner" onclick="location.href='${pageContext.request.contextPath}/auction/${product.productId}/update'">수정</button>
                <button type="button" class="btn-owner delete" onclick="if(confirm('정말 삭제하시겠습니까?')) { location.href='${pageContext.request.contextPath}/product/${product.productId}/delete'; }">삭제</button>
            </div>
        </c:if>

        <%-- 댓글 영역 (아래로 단독 배치) --%>
        <section class="comment-section-full">
            <h3 id="comment-section-title" class="comment-section_title">댓글 <span id="comment-count">${empty comments ? 0 : comments.size()}</span></h3>
            <ul class="comment-list" id="comment-list">
                <c:forEach var="comment" items="${comments}">
                    <li class="comment-item" id="comment-${comment.commentId}">
                        <div class="comment-list_body">
                            <span class="comment-list_writer">${comment.writerNickname}</span>
                            <span class="comment-list_content">${comment.content}</span>
                            <span class="comment-list_date">${comment.createdAtStr}</span>
                        </div>
                        <c:if test="${not empty loginUser and loginUser.userNo == comment.writerNo}">
                            <button type="button" class="comment-delete-btn" data-comment-id="${comment.commentId}">삭제</button>
                        </c:if>
                    </li>
                </c:forEach>
            </ul>

            <c:choose>
                <c:when test="${not empty loginUser}">
                    <form class="comment-form" id="comment-form">
                        <textarea class="comment-textarea" placeholder="댓글을 입력해주세요..." name="content" rows="2" required></textarea>
                        <button type="submit" class="comment-submit-btn">등록</button>
                    </form>
                </c:when>
                <c:otherwise>
                    <p class="form-tip"><a href="/user/login">로그인</a> 후 댓글을 작성하세요.</p>
                </c:otherwise>
            </c:choose>
        </section>
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
                                    <span class="bid-history-username">${bid.bidderNickname}</span>
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

    <template id="comment-template">
        <li class="comment-item">
            <div class="comment-list_body">
                <span class="comment-list_writer"></span>
                <span class="comment-list_content"></span>
                <span class="comment-list_date"></span>
            </div>
            <button type="button" class="comment-delete-btn">삭제</button>
        </li>
    </template>

    <!-- 공통 푸터 -->
    <jsp:include page="/WEB-INF/views/common/footer.jsp" />

    <!-- 자바스크립트 파일 연결 -->
    <script src="/js/auctionDetail.js"></script>
</body>
</html>