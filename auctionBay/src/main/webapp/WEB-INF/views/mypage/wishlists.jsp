<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>AuctionBay - 찜목록</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/common.css">
    <style>
        * { box-sizing: border-box; margin: 0; padding: 0; }
        body { font-family: 'Malgun Gothic', sans-serif; background-color: #ffffff !important; color: #333; }
        
        .main-container {
            width: 1200px;
            min-width: 1200px;
            margin: 30px auto;
            background-color: #ffffff;
        }

        /* 상품 그리드 영역과 퀵메뉴를 나란히 배치하기 위한 Flex 컨테이너 */
        .content-wrapper {
            display: flex;
            align-items: flex-start;
            gap: 30px;
            position: relative;
        }

        .wishlist-section {
            flex: 1;
            min-width: 0;
        }

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
            gap: 20px;
            margin-bottom: 40px;
        }

        .product-card {
            background-color: #fff;
            border: 1px solid #eaeaea;
            border-radius: 8px;
            overflow: hidden;
            display: flex;
            flex-direction: column;
            cursor: pointer;
            transition: transform 0.2s, box-shadow 0.2s;
        }

        .product-card:hover {
            transform: translateY(-4px);
            box-shadow: 0 6px 12px rgba(0,0,0,0.08);
        }
        
        .product-img {
            width: 100%;
            height: 150px;
            background-color: #f1f3f5;
            display: flex;
            align-items: center;
            justify-content: center;
            color: #777;
            font-size: 12px;
        }

        .product-info {
            padding: 12px;
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
            color: #111;
            margin-top: 2px;
        }

        .empty-wishlist {
            grid-column: span 5;
            text-align: center;
            padding: 60px;
            background-color: #f8f9fa;
            border: 1px solid #eaeaea;
            border-radius: 8px;
            color: #666;
            font-size: 15px;
        }

        /* 우측 스크롤 고정 퀵 메뉴 (메인 페이지와 동일한 방식) */
        .right-quick-menu {
            position: fixed;
            top: 50%;
            transform: translateY(-50%);
            left: calc(50% + 645px);
            width: 75px;
            background-color: #ffffff;
            border: 1px solid #eaeaea;
            border-radius: 8px;
            display: flex;
            flex-direction: column;
            align-items: center;
            padding: 15px 0;
            gap: 20px;
            box-shadow: 0 4px 10px rgba(0,0,0,0.05);
            z-index: 1000;
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
        .quick-icon { font-size: 20px; }
        .badge {
            position: absolute;
            top: -2px;
            right: 4px;
            background-color: #ff3b30;
            color: #fff;
            font-size: 9px;
            padding: 1px 5px;
            border-radius: 10px;
            font-weight: bold;
        }

        .pagination {
            display: flex;
            justify-content: center;
            align-items: center;
            gap: 5px;
            margin-top: 30px;
        }
        .page-btn {
            padding: 6px 12px;
            border: 1px solid #ddd;
            background-color: #fff;
            color: #333;
            text-decoration: none;
            border-radius: 4px;
            font-size: 13px;
            cursor: pointer;
        }
        .page-btn.active {
            background-color: #111;
            color: #fff;
            border-color: #111;
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

<jsp:include page="/WEB-INF/views/common/header.jsp" />

<div class="main-container">
    <div class="content-wrapper">
        
        <div class="wishlist-section">
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
                                                <span class="auction-price-loading" data-pno="${item.productNo}">조회중...</span>
                                            </c:when>
                                            <c:otherwise>
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

            <!-- 자바스크립트가 실제 카드 개수 기준으로 채워줄 페이징 바 영역 -->
            <div class="pagination" id="paginationContainer"></div>
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

    </div>
</div>

<div style="margin-top: 50px;">
    <jsp:include page="/WEB-INF/views/common/footer.jsp" />
</div>

<script>
const contextPath = "${pageContext.request.contextPath}";

document.addEventListener("DOMContentLoaded", function() {
    const auctionElements = document.querySelectorAll('.auction-price-loading');

    auctionElements.forEach(el => {
        const productNo = el.getAttribute('data-pno');
        
        fetch(contextPath + '/auction/' + productNo + '/detail')
            .then(response => response.text())
            .then(htmlStr => {
                const parser = new DOMParser();
                const doc = parser.parseFromString(htmlStr, 'text/html');
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

        if (totalItems === minTotalItemsCheck = 0) return; 

        const totalPages = Math.ceil(totalItems / itemsPerPage);
        if (totalPages <= 1) return;

        const prevBtn = document.createElement('a');
        prevBtn.className = 'page-btn' + (currentPage === 1 ? ' disabled' : '');
        prevBtn.innerHTML = '&lt; 이전';
        if (currentPage > 1) {
            prevBtn.onclick = () => showPage(currentPage - 1);
        }
        paginationContainer.appendChild(prevBtn);

        for (let i = 1; i <= totalPages; i++) {
            const pageBtn = document.createElement('a');
            pageBtn.className = 'page-btn' + (i === currentPage ? ' active' : '');
            pageBtn.innerText = i;
            pageBtn.onclick = () => showPage(i);
            paginationContainer.appendChild(pageBtn);
        }

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