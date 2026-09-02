<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>AuctionBay - 찜목록</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/common.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/mypage/common.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/mypage/wishlist.css">
</head>
<body>
    <jsp:include page="/WEB-INF/views/common/header.jsp" />

    <div class="mypage-container">
        <!-- 프로필 상단 영역 -->
        <jsp:include page="/WEB-INF/views/mypage/profile/profile.jsp" />

        <div class="mypage-content-area">
            <!-- 사이드바 -->
            <jsp:include page="/WEB-INF/views/mypage/sidebar.jsp">
                <jsp:param name="activeMenu" value="wishlists"></jsp:param>
            </jsp:include>
            
            <!-- 사이드바 우측 메인 영역 -->
            <div class="mypage-main main-content">
                <div class="content-header">
                    <h2 class="content-title">찜목록</h2>
                </div>

                <div class="content-main">
                    <div class="wishlist-grid" id="wishlistGrid">
                        <c:choose>
                            <c:when test="${not empty wishlist}">
                                <c:forEach var="item" items="${wishlist}">
                                    <div class="product-card" onclick="location.href='${pageContext.request.contextPath}/${item.tradeType == 'AUCTION' ? 'auction' : 'board'}/${item.productNo}/detail'">
                                        <!-- 정사각형 이미지 카드 영역 -->
                                        <div class="product-img">
                                            <c:choose>
                                                <c:when test="${not empty item.mainImage}">
                                                    <img src="${pageContext.request.contextPath}${item.mainImage}" alt="상품 이미지">
                                                </c:when>
												<c:when test="${item.status == 'EXPIRED'}">
													<span class="expired-badge">경매 기간 만료</span>
												</c:when>
												<c:when test="${item.status == 'COMPLETED'}">
													<span class="finished-badge">거래완료</span>
												</c:when>
                                                <c:when test="${item.tradeType == 'BUY'}">
                                                    <span class="buy-badge">구매</span>
                                                </c:when>
                                                <c:when test="${item.tradeType == 'SELL'}">
                                                    <span class="sell-badge">판매</span>
                                                </c:when>
                                                <c:otherwise>
                                                    <img src="${pageContext.request.contextPath}/uploads/product/common/default_thumb.png" alt="이미지 없음">
                                                </c:otherwise>
                                            </c:choose>
                                    
                                            <!-- 찜(하트) 버튼 -->
                                            <button type="button" class="wish-btn active" data-product-id="${item.productNo}" onclick="toggleWish(event, this)">
                                                <svg class="heart-icon" viewBox="0 0 24 24">
                                                    <path d="M12 21.35l-1.45-1.32C5.4 15.36 2 12.28 2 8.5 2 5.42 4.42 3 7.5 3c1.74 0 3.41.81 4.5 2.09C13.09 3.81 14.76 3 16.5 3 19.58 3 22 5.42 22 8.5c0 3.78-3.4 6.86-8.55 11.54L12 21.35z"/>
                                                </svg>
                                            </button>
                                        </div>

                                        <!-- 상품 정보 영역 -->
                                        <div class="product-info">
                                            <div class="product-title-row">
                                                <span class="product-title">${item.title}</span>
                                                <c:choose>
													<c:when test="${item.status == 'EXPIRED'}">
														<span class="expired-badge">유찰</span>
													</c:when>
                                                    <c:when test="${item.tradeType == 'BUY'}">
                                                        <span class="buy-badge">구매</span>
                                                    </c:when>
                                                    <c:when test="${item.tradeType == 'SELL'}">
                                                        <span class="sell-badge">판매</span>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span class="auction-badge">경매</span>
                                                    </c:otherwise>
                                                </c:choose>
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
                </div>

                <!-- 자바스크립트가 실제 카드 개수 기준으로 채워줄 페이징 바 영역 -->
                <div class="pagination" id="paginationContainer"></div>
            </div>
        </div>
    </div>
	
	<!-- 공통 푸터 포함 -->
	<jsp:include page="/WEB-INF/views/common/footer.jsp" />

<script>
document.addEventListener("DOMContentLoaded", function() {
    const auctionElements = document.querySelectorAll('.auction-price-loading');

    auctionElements.forEach(el => {
        const productNo = el.getAttribute('data-pno');
        const path = (typeof contextPath !== 'undefined' ? contextPath : '') + '/auction/' + productNo + '/detail';
        
        fetch(path)
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

    // ------------------------------------------------------
    // 찜목록 클라이언트 사이드 페이지네이션
    // ------------------------------------------------------
    const itemsPerPage = 8; 
    let currentPage = 1;

    function getCards() {
        return document.querySelectorAll('#wishlistGrid .product-card');
    }

    function showPage(page) {
        currentPage = page;
        const cards = getCards();
        const totalItems = cards.length;
        
        const totalPages = Math.ceil(totalItems / itemsPerPage) || 1;
        if (currentPage > totalPages) currentPage = totalPages;

        const start = (currentPage - 1) * itemsPerPage;
        const end = start + itemsPerPage;

        cards.forEach((card, index) => {
            card.style.display = (index >= start && index < end) ? '' : 'none';
        });

        renderPagination(totalItems, totalPages);
    }

    function renderPagination(totalItems, totalPages) {
        const paginationContainer = document.getElementById('paginationContainer');
        paginationContainer.innerHTML = '';

        if (totalItems === 0) return;

        // 1페이지 초과일 때만 이전 버튼 생성
        if (totalPages > 1) {
            const prevBtn = document.createElement('a');
            prevBtn.className = 'page-btn' + (currentPage === 1 ? ' disabled' : '');
            prevBtn.innerHTML = '&lt; 이전';
            if (currentPage > 1) {
                prevBtn.onclick = () => showPage(currentPage - 1);
            } else {
                prevBtn.style.opacity = '0.4';
                prevBtn.style.cursor = 'default';
            }
            paginationContainer.appendChild(prevBtn);
        }

        // 페이지 번호 버튼 (아이템이 있으면 1페이지뿐이여도 '1'번 버튼이 무조건 생성됩니다)
        for (let i = 1; i <= totalPages; i++) {
            const pageBtn = document.createElement('a');
            pageBtn.className = 'page-btn' + (i === currentPage ? ' active' : '');
            pageBtn.innerText = i;
            pageBtn.onclick = () => showPage(i);
            paginationContainer.appendChild(pageBtn);
        }

        // 1페이지 초과일 때만 다음 버튼 생성
        if (totalPages > 1) {
            const nextBtn = document.createElement('a');
            nextBtn.className = 'page-btn' + (currentPage === totalPages ? ' disabled' : '');
            nextBtn.innerHTML = '다음 &gt;';
            if (currentPage < totalPages) {
                nextBtn.onclick = () => showPage(currentPage + 1);
            } else {
                nextBtn.style.opacity = '0.4';
                nextBtn.style.cursor = 'default';
            }
            paginationContainer.appendChild(nextBtn);
        }
    }

    if (getCards().length > 0) {
        showPage(1);
    }
});

/* 상품 카드 찜 버튼 클릭 이벤트 (비동기 처리) */
async function toggleWish(event, button) {
    event.stopPropagation(); 
    event.preventDefault();

    const productId = button.getAttribute('data-product-id');

    try {
        const response = await fetch('/api/board/wish', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json',
            },
            body: JSON.stringify({ productId: Number(productId) })
        });

        const result = await response.json();

        if (!response.ok || !result.success) {
            alert(result.message || "찜목록 처리 중 오류가 발생했습니다.");
            return;
        }

        if (result.data) {
            button.classList.add('active');
        } else {
            const card = button.closest('.product-card');
            if (card) {
                card.remove();
                
                const remainingCards = document.querySelectorAll('#wishlistGrid .product-card');
                if (remainingCards.length === 0) {
                    document.getElementById('wishlistGrid').innerHTML = `
                        <div class="empty-wishlist">
                            찜한 상품이 없습니다.
                        </div>
                    `;
                    document.getElementById('paginationContainer').innerHTML = '';
                } else {
                    location.reload(); 
                }
            }
        }

    } catch (error) {
        console.error('Error:', error);
        alert("네트워크 오류 발생");
    }
}
</script>

</body>
</html>