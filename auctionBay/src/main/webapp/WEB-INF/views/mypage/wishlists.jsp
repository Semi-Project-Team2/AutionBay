<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
            <div class="mypage-main">
                <div class="wishlist-header-title">WISHLISTS</div>

                <div class="wishlist-grid" id="wishlistGrid">
                    <c:choose>
                        <c:when test="${not empty wishlist}">
                            <c:forEach var="item" items="${wishlist}">
                                
                                <div class="product-card" onclick="location.href='${pageContext.request.contextPath}/${item.tradeType == 'AUCTION' ? 'auction' : 'board'}/${item.productNo}/detail'">
                                    <div class="product-img">
                                        <c:choose>
                                            <c:when test="${not empty item.mainImage}">
                                                <img src="${pageContext.request.contextPath}${item.mainImage}" alt="상품 이미지">
                                            </c:when>
                                            <c:otherwise>
                                                <img src="${pageContext.request.contextPath}/uploads/product/common/default_thumb.png" alt="이미지 없음">
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

                <!-- 자바스크립트가 실제 카드 개수 기준으로 채워줄 페이징 바 영역 -->
                <div class="pagination" id="paginationContainer"></div>
            </div>
        </div>
    </div>

    <jsp:include page="/WEB-INF/views/common/footer.jsp" />

<script>
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
                
                // 상세페이지 내 가격 엘리먼트 추출
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
    const itemsPerPage = 8; // 4열 배치 기준 2줄(8개)씩 노출
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

        if (totalItems === 0) return;

        const totalPages = Math.ceil(totalItems / itemsPerPage);
        if (totalPages <= 1) return;

        // 이전 버튼
        const prevBtn = document.createElement('a');
        prevBtn.className = 'page-btn' + (currentPage === 1 ? ' disabled' : '');
        prevBtn.innerHTML = '&lt; 이전';
        if (currentPage > 1) {
            prevBtn.onclick = () => showPage(currentPage - 1);
        }
        paginationContainer.appendChild(prevBtn);

        // 페이지 번호 버튼
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