<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>상품 상세 페이지</title>
    
    <link rel="stylesheet" href="/css/common.css">
    <link rel="stylesheet" href="/css/productDetail.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    
</head>
<body>
    <!-- 공통 헤더 -->
    <jsp:include page="/WEB-INF/views/common/header.jsp" />

    <div id="server-data" data-message="${message}"></div>
    <input type="hidden" id="product-id-value" value="${product.productId}">
    <input type="hidden" id="is-Owner-value" value="${isOwner}">

    <!-- 전체를 감싸는 중앙 정렬 컨테이너 -->
    <div class="page-container">
        
        <!-- 왼쪽: 상품 미디어 영역 -->
        <div class="product-image-section">
            <div class="product-title-header-wrapper">
                <c:choose>
                    <c:when test="${product.tradeType == 'SELL'}">
                        <span class="sell-badge">판매</span>
                    </c:when>
                    <c:when test="${product.tradeType == 'BUY'}">
                        <span class="buy-badge">구매</span>
                    </c:when>
                </c:choose>
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
            
            <!-- 썸네일 리스트 -->
			<c:if test="${not empty product.mediaList && product.mediaList.size() > 1}">
	            <div class="thumbnail-list">
	                <c:forEach var="media" items="${product.mediaList}" varStatus="status">
	                    <div class="thumbnail-item ${status.first ? 'active' : ''}" 
	                         onclick="changeMainMedia(this, '${media.mediaUrl}', '${media.mediaType}')">
	                        <c:choose>
	                            
	                            <c:when test="${media.mediaType == 'VIDEO'}">
	                                <img src="${pageContext.request.contextPath}/uploads/product/common/video_thumb.png" alt="동영상 썸네일">
	                            </c:when>
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

        <!-- 우측 일반 상품 상세 카드 영역 -->
        <div class="auction-card">
            <!-- 가격 헤더 -->
            <div class="price-header">
                <span class="price-label">희망가격</span>
                <span class="price-value" id="currentPrice"><fmt:formatNumber value="${product.price}" pattern="#,###" />원</span>
            </div>

            <!-- 상품 상세 정보 박스 -->
            <div class="auction-info-box">
                <!-- 상품 상태 -->
                <div class="info-row">
                    <span class="info-label">상품상태</span>
                    <div class="info-content" id="productCondition">
                        <c:choose>
                            <c:when test="${product.productCondition == 'NEW'}">미개봉</c:when>
                            <c:when test="${product.productCondition == 'LIKE_NEW'}">거의새것</c:when>
                            <c:when test="${product.productCondition == 'USED'}">사용감있음</c:when>	
                        </c:choose>
                    </div>
                </div>

                <!-- description 영역 -->
                <div class="description-box" id="productDescription">
                    ${product.description}
                </div>
				<!-- 상품거래 방식(택배, 직거래) - CSS 수정에 맞춰 구조 변경 -->
				<div class="direct-or-post">
					<span class="info-label">거래방식</span>
					<div class="direct-or-post-text">
						<c:choose>
							<c:when test="${product.isDirect == 0}">
								<!-- 택배 -->
								<span class="trade-method-item delivery">
									<i class="fas fa-shipping-fast"></i>
									택배 배송
								</span>
							</c:when>
							<c:otherwise>
								<!-- 직거래 -->
								<span class="trade-method-item direct">
									<i class="fas fa-handshake"></i>
									직거래
								</span>
								<!-- 거래장소 박스 -->
								<div class="trade-location-box">
									<i class="fas fa-map-marker-alt"></i>
									<span>거래장소: ${product.tradeLocation}</span>
								</div>
							</c:otherwise>
						</c:choose>
					</div>
				</div>
            </div>

            <!-- 버튼 영역 -->
            <div class="action-group">
                <button type="button" class="btn-submit" id="btnSendMessage"
                        data-product-id="${product.productId}"
                        data-receiver-no="${product.writerNo}"
                        data-redirect-url="${pageContext.request.contextPath}/board/${product.productId}/detail">
                    ${product.tradeType == 'SELL' ? '쪽지하여 구매하기' : '쪽지하여 판매하기'}
                </button>
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
        </div>

        <!-- 글 작성자일 경우에만 노출되는 수정/삭제 버튼 영역 -->
        <c:if test="${isOwner or (not empty sessionScope.loginUser and sessionScope.loginUser.userNo == product.writerNo)}">
            <div class="post-owner-actions">
                <button type="button" class="btn-owner" onclick="location.href='${pageContext.request.contextPath}/board/${product.productId}/update'">수정</button>
                <button type="button" class="btn-owner delete" onclick="if(confirm('정말 삭제하시겠습니까?')) { location.href='${pageContext.request.contextPath}/product/${product.productId}/delete'; }">삭제</button>
            </div>
        </c:if>

        <%-- 댓글 영역 --%>
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
    <script src="/js/boardDetail.js"></script>
</body>
</html>