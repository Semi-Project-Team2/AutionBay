<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>AuctionBay - 상품 목록</title>
<link rel="stylesheet" href="/css/common.css">
<link rel="stylesheet" href="/css/productlist.css">
</head>
<body>

	<!-- 1. 헤더 (브라우저 전체 너비로 확장) -->
	<jsp:include page="/WEB-INF/views/common/header.jsp" />

	<div id="server-data" data-message="${message}"></div>

	<!-- 2. 중앙 콘텐츠를 감싸는 메인 래퍼 (1200px 중앙 정렬) -->
	<main class="main-container">
	    <%-- 회원 탈퇴 후 초기화면에서 표시할 탈퇴 완료 메시지 --%>
	    <c:if test="${not empty withdrawMessage}">
	        <script>alert('${withdrawMessage}')</script>
	    </c:if>

	    <!-- 검색/필터 유지를 위한 공통 Form -->
	    <form id="searchForm" action="${pageContext.request.contextPath}/product/list" method="get">
	        <input type="hidden" name="tradeType" id="tradeType" value="${condition.tradeType}">
	        <input type="hidden" name="categoryId" id="categoryId" value="${condition.categoryId}">
	        <input type="hidden" name="sortBy" id="sortBy" value="${condition.sortBy}">
	        <input type="hidden" name="page" id="page" value="${result.pageInfo.page}">
	        <input type="hidden" name="keyword" value="${condition.keyword}">
	        
	        <!-- 상단 필터 바 -->
	        <div class="filter-bar">
	            <div class="filter-row">
	                <div class="filter-label">게시글 유형</div>
	                <div class="filter-options">
	                    <a class="filter-item ${empty condition.tradeType ? 'active' : ''}" onclick="filterChange('tradeType', '')">전체</a>
	                    <a class="filter-item ${condition.tradeType == 'BUY' ? 'active' : ''}" onclick="filterChange('tradeType', 'BUY')">구매</a>
	                    <a class="filter-item ${condition.tradeType == 'SELL' ? 'active' : ''}" onclick="filterChange('tradeType', 'SELL')">판매</a>
	                    <a class="filter-item ${condition.tradeType == 'AUCTION' ? 'active' : ''}" onclick="filterChange('tradeType', 'AUCTION')">경매</a>
	                </div>
	            </div>
	            <div class="filter-row">
	                <div class="filter-label">상품 카테고리</div>
	                <div class="filter-options category-wrap">
	                    <a class="filter-item ${empty condition.categoryId ? 'active' : ''}" onclick="filterChange('categoryId', '')">전체</a>
	                    <c:forEach var="c" items="${categoryList}">
	                        <a class="filter-item ${condition.categoryId == c.categoryId ? 'active' : ''}" onclick="filterChange('categoryId', '${c.categoryId}')">${c.categoryName}</a>
	                    </c:forEach>
	                </div>    
	            </div>
				<div class="filter-row">
		            <div class="filter-label">가격</div>
		            <div class="filter-options price-filter">
		                <input type="text" name="minPrice" id="minPrice" value="${condition.minPrice}" placeholder="최소 가격" onblur="formatNumberOnly(this)">
		                <span>~</span>
		                <input type="text" name="maxPrice" id="maxPrice" value="${condition.maxPrice}" placeholder="최대 가격" onblur="formatNumberOnly(this)">
		                <button type="submit" class="price-search-btn">검색</button>
		            </div>
		        </div>
	            
	            <!-- 정렬 필터 영역 -->
	            <div class="filter-row" style="border-top: 1px solid #eee; padding-top: 10px; margin-top: 10px;">
	                <div class="filter-label">정렬 기준</div>
	                <div class="filter-options">
	                    <a class="filter-item ${empty condition.sortBy || condition.sortBy == 'LATEST' ? 'active' : ''}" onclick="filterChange('sortBy', 'LATEST')">최신순</a>
	                    <a class="filter-item ${condition.sortBy == 'PRICE_ASC' ? 'active' : ''}" onclick="filterChange('sortBy', 'PRICE_ASC')">낮은가격순</a>
	                    <a class="filter-item ${condition.sortBy == 'PRICE_DESC' ? 'active' : ''}" onclick="filterChange('sortBy', 'PRICE_DESC')">높은가격순</a>
	                    <a class="filter-item ${condition.sortBy == 'VIEWS' ? 'active' : ''}" onclick="filterChange('sortBy', 'VIEWS')">조회수순</a>
	                    <a class="filter-item ${condition.sortBy == 'WISHS' ? 'active' : ''}" onclick="filterChange('sortBy', 'WISHS')">찜 많은 순</a>
	                </div>
	            </div>
				<!-- 완료된 상품 포함 보기 필터 -->
				<div class="filter-row">
				    <div class="filter-label">상태 보기</div>
				    <div class="filter-options">
				        <input type="hidden" name="includeFinished" id="includeFinished" value="${empty condition.includeFinished ? 'false' : condition.includeFinished}">
				        <span class="filter-item ${empty condition.includeFinished || !condition.includeFinished ? 'active' : ''}" onclick="filterChange('includeFinished', 'false')">진행중 상품</span>
				        <span class="filter-item ${condition.includeFinished ? 'active' : ''}" onclick="filterChange('includeFinished', 'true')">완료 상품 포함</span>
				    </div>
				</div>
	        </div>
	    </form>

	    <!-- 카테고리 타이틀/상품수와 게시글 작성 버튼을 한 줄에 배치 -->
	    <div class="section-title-area">
	        <div class="section-left-info">
	            <h2 class="current-category-title">
	                <c:choose>
	                    <c:when test="${empty condition.categoryId}">
	                        전체 상품
	                    </c:when>
	                    <c:otherwise>
	                        <c:forEach var="c" items="${categoryList}">
	                            <c:if test="${condition.categoryId == c.categoryId}">
	                                ${c.categoryName}
	                            </c:if>
	                        </c:forEach>
	                    </c:otherwise>
	                </c:choose>
	            </h2>
	            <div class="section-sub-info">
	                상품 <span>${result.pageInfo.totalCount}</span>
	            </div>
	        </div>
	        
	        <div class="product-write-container">
	            <a href="${pageContext.request.contextPath}/product/write" class="btn-product-write">
	                <span>✏️ 게시글 작성</span>
	            </a>
	        </div>
	    </div>

	    <!-- 메인 콘텐츠 (상품 그리드 + 우측 퀵메뉴 포함 구조) -->
	    <div class="content-wrapper">
	        <div class="product-grid-section">
	            <div class="product-grid">
	                <c:choose>
	                    <c:when test="${not empty result.productList}">
	                        <c:forEach var="p" items="${result.productList}">
	                            <div class="product-card" onclick="location.href='${pageContext.request.contextPath}/${p.tradeType == 'AUCTION' ? 'auction' : 'board'}/${p.productId}/detail'">
	                                <div class="product-img">
	                                    <c:choose>
	                                        <c:when test="${not empty p.mediaList}">
	                                            <c:set var="firstMedia" value="${p.mediaList[0]}" />
	                                            <c:set var="imgSrc" value="${not empty firstMedia.thumbnailUrl ? firstMedia.thumbnailUrl : firstMedia.mediaUrl}" />
	                                            <img src="${pageContext.request.contextPath}${imgSrc}" alt="${p.title}" style="width: 100%; height: 100%; object-fit: cover;">
	                                        </c:when>
	                                        <c:otherwise>
	                                            <img src="/uploads/product/common/default_thumb.png" alt="이미지 없음" style="width: 100%; height: 100%; object-fit: cover;">
	                                        </c:otherwise>
	                                    </c:choose>

										<!-- 찜(하트) 버튼 (p.isWished > 0 일 때 active 클래스 추가) -->
										<button type="button" class="wish-btn ${p.isWished > 0 ? 'active' : ''}" data-product-id="${p.productId}" onclick="toggleWish(event, this)">
										    <svg class="heart-icon" viewBox="0 0 24 24">
										        <path d="M12 21.35l-1.45-1.32C5.4 15.36 2 12.28 2 8.5 2 5.42 4.42 3 7.5 3c1.74 0 3.41.81 4.5 2.09C13.09 3.81 14.76 3 16.5 3 19.58 3 22 5.42 22 8.5c0 3.78-3.4 6.86-8.55 11.54L12 21.35z"/>
										    </svg>
										</button>
	                                </div>
	                                <div class="product-info">
										<div class="product-title-row">
										    <span class="product-title">${p.title}</span>
										    <c:choose>
												<c:when test="${p.status == 'EXPIRED'}">
													<span class="expired-badge">유찰</span>
												</c:when>
												<c:when test="${p.status == 'COMPLETED'}">
												    <span class="finished-badge">거래완료</span>
												</c:when>
										        <c:when test="${p.tradeType == 'AUCTION'}">
										            <span class="auction-badge">경매</span>
										        </c:when>
										        <c:when test="${p.tradeType == 'BUY'}">
										            <span class="buy-badge">구매</span>
										        </c:when>
										        <c:otherwise>
										            <span class="sell-badge">판매</span>
										        </c:otherwise>
										    </c:choose>
										</div>
	                                    <div class="product-price">
	                                        <c:choose>
	                                            <c:when test="${p.tradeType == 'AUCTION'}">
	                                                ${p.auctionStartPrice}원 <span>(시작가)</span>
	                                            </c:when>
	                                            <c:otherwise>
	                                                ${p.price}원
	                                            </c:otherwise>
	                                        </c:choose>
	                                    </div>
	                                </div>
	                            </div>
	                        </c:forEach>
	                    </c:when>
	                    <c:otherwise>
	                        <div style="grid-column: span 5; text-align: center; padding: 50px; color: #888;">
	                            등록된 상품이 없습니다.
	                        </div>
	                    </c:otherwise>
	                </c:choose>
	            </div>

	            <!-- 페이징 바 영역 -->
	            <div class="pagination">
	                <c:if test="${result.pageInfo.hasPrevGroup}">
	                    <a class="page-btn" href="javascript:movePage(${result.pageInfo.startPage - 1})">&laquo; 이전</a>
	                </c:if>
	                <c:forEach var="i" begin="${result.pageInfo.startPage}" end="${result.pageInfo.endPage}">
	                    <a class="page-btn ${result.pageInfo.page == i ? 'active' : ''}" href="javascript:movePage(${i})">${i}</a>
	                </c:forEach>
	                <c:if test="${result.pageInfo.hasNextGroup}">
	                    <a class="page-btn" href="javascript:movePage(${result.pageInfo.endPage + 1})">다음 &raquo;</a>
	                </c:if>
	            </div>
	        </div>

	        <!-- 우측 퀵 메뉴 섹션 -->
	        <aside class="right-quick-menu">
	            <a href="${pageContext.request.contextPath}/mypage/wishlists" class="quick-item">
	                <span class="quick-icon">❤️</span>
	                <span>찜목록</span>
	            </a>
	            <a href="${pageContext.request.contextPath}/message/received" class="quick-item">
	                <span class="quick-icon">✉️</span>
	                <span>쪽지함</span>
	                <c:choose>
	                    <c:when test="${sessionScope.loginUser.unreadCount <= 99 && sessionScope.loginUser.unreadCount > 0}">
	                        <span class="badge">${sessionScope.loginUser.unreadCount}</span>
	                    </c:when>
	                    <c:when test="${empty sessionScope.loginUser || sessionScope.loginUser.unreadCount == 0}">
	                    </c:when>
	                    <c:otherwise>
	                        <span class="badge">99+</span>
	                    </c:otherwise>
	                </c:choose>
	            </a>
	            <a href="${pageContext.request.contextPath}/mypage/recents" class="quick-item">
	                <span class="quick-icon">⏱️</span>
	                <span>최근 본 글</span>
	            </a>
	        </aside>
	    </div>
	</main>

	<!-- 3. 푸터 -->
	<jsp:include page="/WEB-INF/views/common/footer.jsp" />

	<script src="/js/productList.js"></script>
</body>
</html>