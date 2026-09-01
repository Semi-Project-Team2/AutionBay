<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>AuctionBay - 찜목록</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/common.css">
	<link rel="stylesheet" href="/css/common.css">
	<style>
        * { box-sizing: border-box; margin: 0; padding: 0; }
        body { font-family: 'Malgun Gothic', sans-serif; background-color: #f8f9fa; color: #333; }
        
        .container { width: 1200px; margin: 30px auto; position: relative; }

        .wishlist-header-title {
            font-size: 28px;
            font-weight: bold;
            font-style: italic;
            text-transform: uppercase;
            letter-spacing: 1px;
            margin-bottom: 25px;
            color: #000;
        }

        .wishlist-grid {
            display: grid;
            grid-template-columns: repeat(5, 1fr);
            gap: 15px;
            margin-bottom: 40px;
            padding-right: 90px;
        }

        .product-card {
            background-color: #fff;
            border-radius: 4px;
            overflow: hidden;
            display: flex;
            flex-direction: column;
            cursor: pointer;
        }
        
        .product-img {
            width: 100%;
            height: 150px;
            background-color: #d1d1d1;
            display: flex;
            align-items: center;
            justify-content: center;
            color: #777;
            font-size: 12px;
        }

        .product-info {
            padding: 10px;
            display: flex;
            flex-direction: column;
            gap: 4px;
        }
        .product-title-row {
            display: flex;
            justify-content: space-between;
            align-items: center;
            font-size: 13px;
        }
        .product-title {
            font-weight: normal;
            color: #333;
            overflow: hidden;
            text-overflow: ellipsis;
            white-space: nowrap;
            max-width: 100px;
        }
        .trade-type {
            font-size: 11px;
            color: #666;
        }
        .product-price {
            font-size: 14px;
            font-weight: bold;
            color: #000;
            margin-top: 2px;
        }

        .empty-wishlist {
            grid-column: span 5;
            text-align: center;
            padding: 60px;
            background-color: #e2e2e2;
            border-radius: 6px;
            color: #666;
            font-size: 15px;
        }

		.right-quick-menu {
		    position: absolute;
		    top: 120px;
		    right: 0;
		    width: 75px;
		    background-color: #ffeef4;
		    border: 1px solid #ffccd5;
		    border-radius: 6px;
		    display: flex;
		    flex-direction: column;
		    align-items: center;
		    padding: 15px 0;
		    gap: 20px;
		    box-shadow: 0 2px 5px rgba(0,0,0,0.05);
		}
        .quick-item {
            display: flex;
            flex-direction: column;
            align-items: center;
            text-decoration: none;
            color: #333;
            font-size: 11px;
            font-weight: bold;
            gap: 5px;
            position: relative;
        }
        .quick-icon { font-size: 22px; }
        .badge {
            position: absolute;
            top: 0px;
            right: -2px;
            background-color: #000;
            color: #fff;
            font-size: 9px;
            padding: 1px 4px;
            border-radius: 50%;
        }

        .pagination {
            display: flex;
            justify-content: center;
            align-items: center;
            gap: 5px;
            margin-top: 30px;
            padding-right: 90px;
        }
        .page-btn {
            padding: 5px 10px;
            border: 1px solid #ddd;
            background-color: #fff;
            color: #333;
            text-decoration: none;
            border-radius: 3px;
            font-size: 12px;
            cursor: pointer;
        }
        .page-btn.active {
            background-color: #000;
            color: #fff;
            border-color: #000;
            font-weight: bold;
        }
        .page-btn:hover:not(.active) { background-color: #f1f1f1; }
        .page-btn.disabled {
            opacity: 0.4;
            cursor: default;
            pointer-events: none;
        }
    </style>
</head>
<body>

<div class="container">
	<jsp:include page="/WEB-INF/views/common/header.jsp" />
    
    <main style="margin-top: 30px;">
        <div class="wishlist-header-title">WISHLISTS</div>

        <div class="wishlist-grid" id="wishlistGrid">
            <c:choose>
                <c:when test="${not empty wishlist}">
                    <c:forEach var="item" items="${wishlist}">
                        
                        <div class="product-card" onclick="location.href='${pageContext.request.contextPath}/${item.tradeType == 'AUCTION' ? 'auction' : 'board'}/${item.productNo}/detail'">
							<div class="product-img">
							    <c:choose>
							        <c:when test="${not empty item.mainImage}">
							            <img src="${pageContext.request.contextPath}${item.mainImage}" alt="상품 이미지" style="width:100%; height:100%; object-fit:cover;">
							        </c:when>
							        <c:otherwise>
							            <img src="/uploads/product/common/default_thumb.png" alt="이미지 없음" style="width:100%; height:100%; object-fit:cover;">
							        </c:otherwise>
							    </c:choose>
							</div>
                            <div class="product-info">
                                <div class="product-title-row">
                                    <span class="product-title">${item.title}</span>
                                    <span class="trade-type">
                                        <c:choose>
                                            <c:when test="${item.tradeType == 'BUY'}">구매</c:when>
                                            <c:when test="${item.tradeType == 'SELL'}">판매</c:when>
                                            <c:otherwise>경매</c:otherwise>
                                        </c:choose>
                                    </span>
                                </div>
                                <div class="product-price" id="price-${item.productNo}">
                                    <c:choose>
                                        <c:when test="${item.tradeType == 'AUCTION'}">
                                            <!-- 경매 상품: JS로 가격 동적 조회 -->
                                            <span class="auction-price-loading" data-pno="${item.productNo}">조회중...</span>
                                        </c:when>
                                        <c:otherwise>
                                            <!-- 일반 상품: DTO price 출력 -->
                                            ${item.price}원
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </c:when>
                <c:otherwise>
                    <div class="empty-wishlist">
                        찜한 상품이 없습니다.
                    </div>
                </c:otherwise>
            </c:choose>
        </div>

        <aside class="right-quick-menu">
            <a href="${pageContext.request.contextPath}/mypage/wishlists" class="quick-item">
                <span class="quick-icon">❤️</span>
                <span>찜목록</span>
            </a>
            <a href="${pageContext.request.contextPath}/message/received" class="quick-item">
                <span class="quick-icon">✉️</span>
                <span>쪽지함</span>

                 <c:choose>
                    <c:when test="${sessionScope.loginUser.unreadCount > 0 && sessionScope.loginUser.unreadCount <= 99}">
                        <span class="badge">${sessionScope.loginUser.unreadCount}</span>
                    </c:when>
                    <c:when test="${sessionScope.loginUser.unreadCount == 0}">
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

        <!-- 자바스크립트가 실제 카드 개수 기준으로 채워줄 페이징 바 영역 -->
        <div class="pagination" id="paginationContainer"></div>
    </main>

    <div style="margin-top: 50px;">
        <jsp:include page="/WEB-INF/views/common/footer.jsp" />
    </div>
</div>

<script>
const contextPath = "${pageContext.request.contextPath}";

document.addEventListener("DOMContentLoaded", function() {
    const contextPath = "${pageContext.request.contextPath}";
    const auctionElements = document.querySelectorAll('.auction-price-loading');

    auctionElements.forEach(el => {
        const productNo = el.getAttribute('data-pno');
        
        // 경매 상세 페이지 HTML/JSON에서 가격 파싱
        fetch(contextPath + '/auction/' + productNo + '/detail')
            .then(response => response.text())
            .then(htmlStr => {
                const parser = new DOMParser();
                const doc = parser.parseFromString(htmlStr, 'text/html');
                
                // 상세페이지 내 가격 엘리먼트 추출 (클래스/ID에 맞게 선택자 자동 매칭)
                const priceTarget = doc.querySelector('.price, .current-price, .start-price, #price, [class*="price"]');
                
                if (priceTarget && priceTarget.textContent.trim() !== '') {
                    const priceText = priceTarget.textContent.replace(/[^0-9]/g, '');
                    if (priceText) {
                        document.getElementById('price-' + productNo).innerText = Number(priceText).toLocaleString() + '원';
                        return;
                    }
                }
                document.getElementById('price-' + productNo).innerText = '경매 진행중';
            })
            .catch(err => {
                document.getElementById('price-' + productNo).innerText = '경매 진행중';
            });
    });

    // ------------------------------------------------------
    // 찜목록 클라이언트 사이드 페이지네이션
    // (한 페이지당 10개 = 그리드 2줄. 필요하면 itemsPerPage만 조정)
    // ------------------------------------------------------
    const itemsPerPage = 10;
    let currentPage = 1;
    const cards = document.querySelectorAll('#wishlistGrid .product-card');
    const totalItems = cards.length;

    function showPage(page) {
        currentPage = page;
        const start = (page - 1) * itemsPerPage;
        const end = start + itemsPerPage;

        cards.forEach((card, index) => {
            card.style.display = (index >= start && index < end) ? 'flex' : 'none';
        });

        renderPagination();
    }

    function renderPagination() {
        const paginationContainer = document.getElementById('paginationContainer');
        paginationContainer.innerHTML = '';

        if (totalItems === 0) return; // 찜한 상품이 없으면 페이징 바 자체를 노출하지 않음

        const totalPages = Math.ceil(totalItems / itemsPerPage);
        if (totalPages <= 1) return; // 1페이지 이하면 페이징 바 숨김

        // 이전 버튼
        const prevBtn = document.createElement('a');
        prevBtn.className = 'page-btn' + (currentPage === 1 ? ' disabled' : '');
        prevBtn.innerHTML = '&lt; 이전';
        if (currentPage > 1) {
            prevBtn.onclick = () => showPage(currentPage - 1);
        }
        paginationContainer.appendChild(prevBtn);

        // 페이지 번호 버튼 (실제 totalPages 만큼만 생성)
        for (let i = 1; i <= totalPages; i++) {
            const pageBtn = document.createElement('a');
            pageBtn.className = 'page-btn' + (i === currentPage ? ' active' : '');
            pageBtn.innerText = i;
            pageBtn.onclick = () => showPage(i);
            paginationContainer.appendChild(pageBtn);
        }

        // 다음 버튼
        const nextBtn = document.createElement('a');
        nextBtn.className = 'page-btn' + (currentPage === totalPages ? ' disabled' : '');
        nextBtn.innerHTML = '다음 &gt;';
        if (currentPage < totalPages) {
            nextBtn.onclick = () => showPage(currentPage + 1);
        }
        paginationContainer.appendChild(nextBtn);
    }

    if (totalItems > 0) {
        showPage(1);
    }
});
</script>

</body>
</html>
