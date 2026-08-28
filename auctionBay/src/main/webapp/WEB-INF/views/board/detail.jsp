<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>상품 상세 페이지</title>
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

    .product-card {
        width: 480px;
        background-color: #ffffff;
        border-radius: 12px;
        padding: 24px;
        box-shadow: 0 4px 16px rgba(0, 0, 0, 0.06);
    }

    /* ==========================================================
    3. 상단 상품 정보 영역
    ========================================================== */
    .product-title {
        font-size: 22px;
        font-weight: 700;
        color: #111;
        margin-bottom: 8px;
        word-break: break-all;
    }

    .product-price {
        font-size: 20px;
        font-weight: 800;
        color: #111;
        margin-bottom: 12px;
    }

    .product-meta {
        font-size: 13px;
        color: #888;
        display: flex;
        align-items: center;
        gap: 12px;
        margin-bottom: 16px;
    }

    .product-meta span {
        display: flex;
        align-items: center;
        gap: 4px;
    }

    .product-condition {
        font-size: 13px;
        margin-bottom: 24px;
        display: flex;
        gap: 16px;
    }

    .condition-label {
        color: #888;
    }

    .condition-value {
        color: #333;
        font-weight: 500;
    }

    /* ==========================================================
    4. 상품 설명 본문 영역
    ========================================================== */
    .description-box {
        min-height: 180px;
        color: #333;
        font-size: 15px;
        line-height: 1.6;
        margin-bottom: 30px;
        white-space: pre-line;
        word-break: break-all;
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
    7. 댓글 영역
    ========================================================== */
    .comment-section {
        margin-top: 24px;
        padding-top: 20px;
        border-top: 1px solid #e5e7eb;
    }

    .comment-title {
        font-size: 15px;
        font-weight: 700;
        color: #1e293b;
        margin-bottom: 12px;
    }

    .comment-list {
        display: flex;
        flex-direction: column;
        gap: 10px;
        margin-bottom: 16px; /* 댓글 작성 폼과의 간격 추가 */
    }

    .comment-item {
        background-color: #f8fafc;
        padding: 10px 12px;
        border-radius: 6px;
        font-size: 13px;
    }

    .comment-header {
        display: flex;
        justify-content: space-between;
        margin-bottom: 4px;
    }

    .comment-writer {
        font-weight: 600;
        color: #334155;
    }

    .btn-comment-delete {
        background: none;
        border: none;
        color: #ef4444;
        font-size: 11px;
        cursor: pointer;
    }

    .comment-body {
        color: #475569;
        line-height: 1.4;
    }

    .comment-empty {
        text-align: center;
        padding: 20px 0;
        color: #94a3b8;
        font-size: 13px;
        margin-bottom: 16px;
    }

    .comment-form {
        display: flex;
        flex-direction: column;
        gap: 8px;
    }

    .comment-textarea {
        width: 100%;
        height: 70px;
        padding: 10px;
        border: 1px solid #cbd5e1;
        border-radius: 6px;
        font-size: 13px;
        resize: none;
        outline: none;
    }

    .comment-textarea:focus {
        border-color: #0f172a;
    }

    .btn-comment-submit {
        align-self: flex-end;
        padding: 6px 16px;
        background-color: #0f172a;
        color: #fff;
        border: none;
        border-radius: 4px;
        font-size: 13px;
        cursor: pointer;
    }

    /* ==========================================================
    8. 공통 모달창 스타일 (리뷰 기록)
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

    .star-rating {
        position: relative;
        unicode-bidi: bidi-override;
        color: #ddd;
        font-size: 14px;
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

    .review-list {
        overflow-y: auto;
        max-height: 350px;
        display: flex;
        flex-direction: column;
        gap: 8px;
        padding-right: 4px;
    }

    .review-list-item {
        display: flex;
        flex-direction: column;
        padding: 12px;
        background-color: #f8fafc;
        border: 1px solid #f1f5f9;
        border-radius: 8px;
        font-size: 13px;
        gap: 6px;
    }

    .review-list-user-info {
        display: flex;
        align-items: center;
        justify-content: space-between;
        width: 100%;
    }

    .review-list-userNickname {
        font-weight: 600;
        color: #334155;
    }

    .review-list-content {
        color: #475569;
        word-break: break-all;
        line-height: 1.4;
    }

    .review-list-empty {
        text-align: center;
        padding: 30px 0;
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
	<input type="hidden" id="product-id-value" value="${product.productId}">
	<input type="hidden" id="is-Owner-value" value="${isOwner}">
	<div class="page-container">
        <div class="product-card">
         
            <!-- 1. 상품 제목 -->
            <h1 class="product-title">${product.title}</h1>

            <!-- 2. 상품 가격 -->
            <div class="product-price">
                <fmt:formatNumber value="${product.price}" type="number" />원
            </div>

            <!-- 4. 상품 상태 -->
            <div class="product-condition">
                <span class="condition-label">상품상태</span>
                <span class="condition-value">${product.productCondition}</span>
            </div>

            <!-- 5. 본문 설명 -->
            <div class="description-box" id="productDescription">
                ${product.description}
            </div>

			<!-- 버튼 영역 -->
            <div class="action-group">
				<button type="button" class="btn-message" id="btnSendMessage" 
											data-product-id="${product.productId}"
											data-receiver-no="${product.writerNo}"
											data-redirect-url="${pageContext.request.contextPath}/board/${product.productId}/detail">판매자에게 쪽지</button>
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

			<%-- 댓글 영역 --%>
			    <section class="comment-section">
			        <h3 class="comment-section_title">댓글 ${empty comments ? 0 : comments.size()}</h3>
			        <ul class="comment-list" id="comment-list">
			            <c:forEach var="comment" items="${comments}">
			                <li id="comment-${comment.commentId}">
			                    <div class="comment-list_body">
			                        <span class="comment-list_writer">${comment.writerNickname}</span>
			                        <span class="comment-list_content">${comment.content}</span>
			                        <span class="comment-list_date">${comment.createAtStr}</span>
			                    </div>
			                    <c:if test="${not empty loginUser and loginUser.UserNo == comment.writerNo}">
			                        <button type="button" class="btn btn-outline comment-delete-btn" data-comment-id="${comment.commentId}">삭제</button>
			                    </c:if>
			                </li>
			            </c:forEach>
			        </ul>

			        <c:choose>
			            <c:when test="${not empty loginUser}">
			                <form class="comment-form" id="comment-form">
			                    <textarea placeholder="댓글입력..." name="content" rows="2" required></textarea>
			                    <button type="submit" class="btn btn-primary">등록</button>
			                </form>
			            </c:when>
			            <c:otherwise>
			                <p class="form-tip"><a href="/user/login">로그인</a> 후 댓글을 작성하세요.</p>
			            </c:otherwise>
			        </c:choose>
			    </section>

			    <!--
					댓글 목록을 표시하는 영역에서 사용할 템플릿으로 임시 저장한 UI (브라우저에서 해석되지 않음, 마크업 구조 보관용)
			    -->
			    <template id="comment-template">
			        <li>
			            <div class="comment-list_body">
			                <span class="comment-list_writer"></span>
			                <span class="comment-list_content"></span>
			                <span class="comment-list_date"></span>
			            </div>
			            <button type="button" class="btn btn-outline comment-delete-btn">삭제</button>
			        </li>
			    </template>

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
                                        <div class="star-rating-fill" style="width: calc(${review.rating} * 20%);">
                                            ★★★★★
                                        </div>
                                    </div>
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
    <script src="/js/productDetail.js"></script>
</body>
</html>