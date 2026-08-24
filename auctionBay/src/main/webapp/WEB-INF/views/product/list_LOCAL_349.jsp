<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>AuctionBay - 상품 목록</title>
<style>
    * { box-sizing: border-box; margin: 0; padding: 0; }
    body { font-family: 'Malgun Gothic', sans-serif; background-color: #f8f9fa; color: #333; }
    
    .container { width: 1200px; margin: 30px auto; position: relative; }

    .header {
        background-color: #f1f3f5;
        border-bottom: 1px solid #ddd;
        padding: 15px 0;
        margin-bottom: 30px;
    }
    .header-container {
        width: 1200px;
        margin: 0 auto;
        display: flex;
        align-items: center;
        justify-content: space-between;
    }
    
    /* 로고 (필기체 느낌 연출) */
    .header-logo {
        text-decoration: none;
        color: #000;
        font-family: 'Brush Script MT', cursive, sans-serif;
        font-size: 24px;
        line-height: 1.1;
        font-weight: bold;
        display: inline-block;
    }
    .header-logo .bay {
        display: block;
        padding-left: 15px;
    }

    /* 검색창 영역 */
    .header-search {
        flex: 1;
        max-width: 500px;
        margin: 0 40px;
        display: flex;
    }
    .header-search input {
        width: 100%;
        padding: 10px 15px;
        border: 1px solid #ccc;
        border-radius: 4px;
        background-color: #e2e2e2;
        font-size: 14px;
        outline: none;
    }
    .header-search input:focus {
        background-color: #fff;
        border-color: #999;
    }

    /* 우측 회원 메뉴 (로그인/회원가입) */
    .header-auth {
        display: flex;
        gap: 10px;
    }
    .auth-btn {
        background-color: #e2e2e2;
        border: 1px solid #ccc;
        padding: 8px 14px;
        border-radius: 4px;
        text-decoration: none;
        color: #333;
        font-size: 13px;
        font-weight: bold;
        cursor: pointer;
    }
    .auth-btn:hover {
        background-color: #d1d1d1;
    }
	
    /* 1. 상단 필터 바 영역 */
    .filter-bar {
        background-color: #e2e2e2;
        padding: 20px;
        border-radius: 6px;
        margin-bottom: 30px;
    }
    .filter-row {
        display: flex;
        align-items: center;
        margin-bottom: 12px;
    }
    .filter-row:last-child { margin-bottom: 0; }
    .filter-label {
        width: 120px;
        font-weight: bold;
        font-size: 15px;
    }
    .filter-options {
        display: flex;
        gap: 20px;
    }
    .filter-options.category-wrap {
        flex-wrap: wrap;
        gap: 10px 20px;
    }
    .filter-item {
        cursor: pointer;
        color: #555;
        text-decoration: none;
        padding: 4px 8px;
        border-radius: 4px;
    }
    .filter-item:hover, .filter-item.active {
        background-color: #ccc;
        color: #000;
        font-weight: bold;
    }

    /* 2. 메인 콘텐츠 및 상품 그리드 */
    .main-content {
        display: flex;
        gap: 30px;
        align-items: flex-start;
    }
    .product-grid-section {
        flex: 1;
        min-width: 0;
    }
    .product-grid {
        display: grid;
        grid-template-columns: repeat(5, 1fr);
        gap: 20px;
        margin-bottom: 40px;
    }
    .product-card {
        background: #fff;
        border: 1px solid #ddd;
        border-radius: 4px;
        overflow: hidden;
        cursor: pointer;
        transition: transform 0.2s;
    }
    .product-card:hover {
        transform: translateY(-3px);
        box-shadow: 0 4px 8px rgba(0,0,0,0.1);
    }
    .product-img {
        width: 100%;
        height: 160px;
        background-color: #d8d8d8;
        display: flex;
        align-items: center;
        justify-content: center;
        color: #888;
        font-size: 13px;
    }
    .product-info {
        padding: 10px;
    }
    .product-title-row {
        display: flex;
        justify-content: space-between;
        font-size: 13px;
        margin-bottom: 6px;
        color: #666;
    }
    .product-price {
        font-size: 15px;
        font-weight: bold;
        color: #000;
    }

    /* 3. 우측 퀵 메뉴 영역 */
    .quick-menu-section {
        width: 100px;
        flex-shrink: 0;
        display: flex;
        flex-direction: column;
        gap: 15px;
    }
    .btn-write {
        background-color: #d1d1d1;
        border: none;
        padding: 12px;
        font-weight: bold;
        text-align: center;
        text-decoration: none;
        color: #333;
        border-radius: 4px;
        cursor: pointer;
    }
    .btn-write:hover { background-color: #bcbcbc; }
    
    .quick-box {
        background-color: #ffe6f2;
        border: 1px solid #ffcce6;
        border-radius: 6px;
        display: flex;
        flex-direction: column;
        align-items: center;
        padding: 15px 0;
        gap: 20px;
    }
    .quick-item {
        text-align: center;
        cursor: pointer;
        font-size: 12px;
        color: #333;
        text-decoration: none;
    }
    .quick-item span { display: block; font-size: 18px; margin-bottom: 3px; }

    /* 4. 페이징 바 영역 */
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

<div class="container">
	<!-- 헤더 영역 -->
	<header class="header">
	    <div class="header-container">
	        
	        <!-- 1. 로고 (Auction Bay) -->
	        <a href="${pageContext.request.contextPath}/" class="header-logo">
	            Auction
	            <span class="bay">Bay</span>
	        </a>

			<!-- 2. 검색창 영역 (헤더 내부에 배치) -->
			<div class="header-search">
			    <input type="text" name="keyword" value="${condition.keyword}" placeholder="제목 또는 작성자 검색" form="searchForm">
			</div>

	        <!-- 3. 로그인 / 회원가입 영역 -->
	        <div class="header-auth">
	            <c:choose>
	                <%-- 로그인 상태가 아닐 때 --%>
	                <c:when test="${empty sessionScope.loginUser}">
	                    <a href="${pageContext.request.contextPath}/user/login" class="auth-btn">로그인</a>
	                    <a href="${pageContext.request.contextPath}/member/signup" class="auth-btn">회원가입</a>
	                </c:when>
	                <%-- 로그인 상태일 때 --%>
	                <c:otherwise>
	                    <span style="font-size: 13px; font-weight: bold; align-self: center; margin-right: 5px;">
	                        ${sessionScope.loginUser.nickname}님 환영합니다!
	                    </span>
                        <a href="${pageContext.request.contextPath}/mypage/txHistories" class="auth-btn">마이페이지</a>
	                    <a href="${pageContext.request.contextPath}/member/logout" class="auth-btn">로그아웃</a>
	                </c:otherwise>
	            </c:choose>
	        </div>

	    </div>
	</header>

    <!-- 검색/필터 유지를 위한 공통 Form -->
    <form id="searchForm" action="${pageContext.request.contextPath}/product/list" method="get">
        <input type="hidden" name="tradeType" id="tradeType" value="${condition.tradeType}">
        <input type="hidden" name="categoryId" id="categoryId" value="${condition.categoryId}">
        <input type="hidden" name="page" id="page" value="${result.pageInfo.page}">
        
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

			<!-- 4. 페이징 바 영역 -->
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

        <!-- 3. 우측 퀵 메뉴 섹션 -->
        <div class="quick-menu-section">
            <a href="${pageContext.request.contextPath}/product/write" class="btn-write">게시글 작성</a>
            
            <div class="quick-box">
                <a href="${pageContext.request.contextPath}/member/wishlist" class="quick-item">
                    <span>❤️</span>찜목록
                </a>
                <a href="${pageContext.request.contextPath}/message/list" class="quick-item">
                    <span>✉️</span>쪽지함
                </a>
                <a href="javascript:void(0);" class="quick-item" onclick="alert('최근 본 글 기능 준비중');">
                    <span>👁️</span>최근 본 글
                </a>
            </div>
        </div>

    </div>

</div>

<script>
    function filterChange(type, value) {
        if (type === 'tradeType') {
            document.getElementById('tradeType').value = value;
        } else if (type === 'categoryId') {
            document.getElementById('categoryId').value = value;
        }
        
        document.querySelector('input[name="keyword"]').value = '';
        document.getElementById('page').value = 1;
        document.getElementById('searchForm').submit();
    }

    function movePage(page) {
        document.getElementById('page').value = page;
        document.getElementById('searchForm').submit();
    }

    window.addEventListener('pageshow', function(event) {
        if (event.persisted || (performance && performance.getEntriesByType("navigation")[0].type === "back_forward")) {
            const keywordInput = document.querySelector('input[name="keyword"]');
            if (keywordInput) {
                keywordInput.value = '';
            }
        }
    });
</script>

</body>
</html>