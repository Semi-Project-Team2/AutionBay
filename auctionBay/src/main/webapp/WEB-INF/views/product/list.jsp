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

<div class="container">

<jsp:include page="/WEB-INF/views/common/header.jsp" />
	
<main class="container">
    <!-- 검색/필터 유지를 위한 공통 Form -->
    <form id="searchForm" action="${pageContext.request.contextPath}/product/list" method="get">
        <input type="hidden" name="tradeType" id="tradeType" value="${condition.tradeType}">
        <input type="hidden" name="categoryId" id="categoryId" value="${condition.categoryId}">
        <input type="hidden" name="page" id="page" value="${result.pageInfo.page}">
		<input type="hidden" name="keyword" value="${param.keyword}">
        
		<!-- 1. 상단 필터 바 -->
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

			        <input
			            type="number"
			            name="minPrice"
			            id="minPrice"
			            value="${condition.minPrice}"
			            placeholder="최소 가격"
			            min="0">

			        <span>~</span>

			        <input
			            type="number"
			            name="maxPrice"
			            id="maxPrice"
			            value="${condition.maxPrice}"
			            placeholder="최대 가격"
			            min="0">

			        <button type="submit" class="price-search-btn">
			            검색
			        </button>

			    </div>
			</div>
        </div>
    </form>

    <!-- 2. 메인 콘텐츠 (상품 그리드 + 우측 퀵메뉴) -->
    <div class="main-content">
        
        <!-- 상품 목록 그리드 섹션 -->
		<div class="product-grid-section">
		    <div class="product-grid">
		        <c:choose>
		            <c:when test="${not empty result.productList}">
		                <c:forEach var="p" items="${result.productList}">
		                    <div class="product-card" onclick="location.href='${pageContext.request.contextPath}/${p.tradeType == 'AUCTION' ? 'auction' : 'board'}/${p.productId}/detail'">
		                        <div class="product-img">
		                            [이미지 영역]
		                        </div>
		                        <div class="product-info">
		                            <div class="product-title-row">
		                                <span style="overflow: hidden; text-overflow: ellipsis; white-space: nowrap; max-width: 100px;">${p.title}</span>
		                                <span>
		                                    <c:choose>
		                                        <c:when test="${p.tradeType == 'BUY'}">구매</c:when>
		                                        <c:when test="${p.tradeType == 'SELL'}">판매</c:when>
		                                        <c:when test="${p.tradeType == 'AUCTION'}">경매</c:when>
		                                    </c:choose>
		                                </span>
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

			<!-- 3. 페이징 바 영역 -->
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

        <!-- 4. 우측 퀵 메뉴 섹션 -->
        <div class="quick-menu-section">
            <a href="${pageContext.request.contextPath}/product/write" class="btn-write">게시글 작성</a>
            
            <div class="quick-box">
                <a href="${pageContext.request.contextPath}/mypage/wishlists" class="quick-item">
                    <span>❤️</span>찜목록
                </a>
                <a href="${pageContext.request.contextPath}/message/received" class="quick-item">
                    <span>✉️</span>쪽지함
                </a>
                <a href="${pageContext.request.contextPath}/mypage/recents"class="quick-item">
                    <span>👁️</span>최근 본 글
                </a>
            </div>
        </div>

    </div>
	</main>
<jsp:include page="/WEB-INF/views/common/footer.jsp" />

<script>
    function filterChange(type, value) {
        if (type === 'tradeType') {
            document.getElementById('tradeType').value = value;
        } else if (type === 'categoryId') {
            document.getElementById('categoryId').value = value;
        }
        
		/*
		const keywordInput = document.querySelector('input[name="keyword"]');
		if (keywordInput) {
		    keywordInput.value = '';
		}
		*/
        document.getElementById('page').value = 1;
        document.getElementById('searchForm').submit();
    }

    function movePage(page) {
        document.getElementById('page').value = page;
        document.getElementById('searchForm').submit();
    }
	/*
    window.addEventListener('pageshow', function(event) {
        if (event.persisted || (performance && performance.getEntriesByType("navigation")[0].type === "back_forward")) {
            const keywordInput = document.querySelector('input[name="keyword"]');
            if (keywordInput) {
                keywordInput.value = '';
            }
        }
    });
	*/
</script>
</body>
</html>
