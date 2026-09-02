<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>마이페이지 - 게시글 관리</title>
    <link rel="stylesheet" href="/css/common.css">
    <link rel="stylesheet" href="/css/mypage/common.css">
    <link rel="stylesheet" href="/css/mypage/product.css">

</head>
<body>

    <!-- 헤더 -->
    <jsp:include page="/WEB-INF/views/common/header.jsp" />

    <div class="mypage-container">
        <!-- 프로필 영역 -->
        <jsp:include page="/WEB-INF/views/mypage/profile/profile.jsp" />

        <div class="mypage-content-area">

            <!-- 사이드바 -->
            <jsp:include page="/WEB-INF/views/mypage/sidebar.jsp">
                <jsp:param name="activeMenu" value="products"></jsp:param>
            </jsp:include>

            <!-- 우측 메인 영역 -->
            <div class="mypage-main">
                <div class="content-header">
                    <div class="content-title">게시글 관리</div>
                    <form action="${pageContext.request.contextPath}/mypage/products" method="get" class="search-bar" onsubmit="return false;">
                        <input type="text" id="mypageKeywordInput" name="keyword" placeholder="검색어를 입력하세요">
                        <button type="button" onclick="searchMypageProducts()">검색</button>
                    </form>
                </div>

                <div class="board-list" id="boardListContainer">
                    <c:choose>
                        <c:when test="${not empty productList}">
                            <c:forEach var="board" items="${productList}">
                                <c:set var="pNo" value="${board.productId}" />
                                <div class="board-card" id="board-card-${pNo}">
                                    <div class="board-info">
                                        <c:choose>
                                            <c:when test="${not empty board.mainImage}">
                                                <img src="${board.mainImage}" alt="썸네일" class="board-thumb">
                                            </c:when>
                                            <c:otherwise>
                                                <div class="board-thumb" style="display:flex; align-items:center; justify-content:center; font-size:10px; color:#555;">이미지없음</div>
                                            </c:otherwise>
                                        </c:choose>

                                        <div>
											<c:choose>
											    <c:when test="${board.tradeType == 'AUCTION'}">
											        <span class="auction-badge">경매</span>
											        <a href="${pageContext.request.contextPath}/auction/${pNo}/detail" class="board-title">
											            ${board.title}
											            <c:if test="${board.commentCount > 0}">
											                <span class="comment-count">댓글: ${board.commentCount}</span>
											            </c:if>
											        </a>
											    </c:when>
											    <c:when test="${board.tradeType == 'BUY'}">
											        <span class="buy-badge">구매</span>
											        <a href="${pageContext.request.contextPath}/board/${pNo}/detail" class="board-title">
											            ${board.title}
											            <c:if test="${board.commentCount > 0}">
											                <span class="comment-count">댓글: ${board.commentCount}</span>
											            </c:if>
											        </a>
											    </c:when>
											    <c:otherwise>
											        <span class="sell-badge">판매</span>
											        <a href="${pageContext.request.contextPath}/board/${pNo}/detail" class="board-title">
											            ${board.title}
											            <c:if test="${board.commentCount > 0}">
											                <span class="comment-count">댓글: ${board.commentCount}</span>
											            </c:if>
											        </a>
											    </c:otherwise>
											</c:choose>
                                        </div>
                                    </div>
									<div class="board-actions">
									    <c:choose>
									        <%-- 1. 경매글일 때 --%>
									        <c:when test="${board.tradeType == 'AUCTION'}">
									            <button type="button" class="btn-action" onclick="location.href='${pageContext.request.contextPath}/auction/${pNo}/update'">수정</button>
									            <button type="button" class="btn-action" style="color: #c92a2a;" onclick="if(confirm('정말 삭제하시겠습니까?')) { location.href='${pageContext.request.contextPath}/product/${pNo}/delete'; }">삭제</button>
									        </c:when>
									        
									        <%-- 2. 일반글일 때 (경매와 경로 형식을 board로 통일) --%>
									        <c:otherwise>
									            <button type="button" class="btn-action" onclick="location.href='${pageContext.request.contextPath}/board/${pNo}/update'">수정</button>
									            <button type="button" class="btn-action" style="color: #c92a2a;" onclick="if(confirm('정말 삭제하시겠습니까?')) { location.href='${pageContext.request.contextPath}/product/${pNo}/delete'; }">삭제</button>
									        </c:otherwise>
									    </c:choose>
									</div>
                                </div>
                            </c:forEach>
                        </c:when>
                        <c:otherwise>
                            <div class="no-data">등록된 게시글이 없습니다.</div>
                        </c:otherwise>
                    </c:choose>
                </div>

                <div class="pagination" id="paginationContainer"></div>
            </div>

        </div>
    </div>

    <jsp:include page="/WEB-INF/views/common/footer.jsp" />

    <script>
        const itemsPerPage = 5;
        let currentPage = 1;
        const cards = document.querySelectorAll('.board-card');
        const totalItems = cards.length;

        function showPage(page) {
            currentPage = page;
            const start = (page - 1) * itemsPerPage;
            const end = start + itemsPerPage;

            cards.forEach((card, index) => {
                if (index >= start && index < end) {
                    card.style.display = 'flex';
                } else {
                    card.style.display = 'none';
                }
            });

            renderPagination();
        }

        function renderPagination() {
            const paginationContainer = document.getElementById('paginationContainer');
            paginationContainer.innerHTML = '';

            if (totalItems === 0) return;

            const totalPages = Math.ceil(totalItems / itemsPerPage);
            if (totalPages <= 1) return;

            const prevBtn = document.createElement('a');
            prevBtn.className = 'page-btn';
            prevBtn.innerHTML = '&lt; 이전';
            if (currentPage > 1) {
                prevBtn.onclick = () => showPage(currentPage - 1);
            } else {
                prevBtn.style.opacity = '0.4';
                prevBtn.style.cursor = 'default';
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
            nextBtn.className = 'page-btn';
            nextBtn.innerHTML = '다음 &gt;';
            if (currentPage < totalPages) {
                nextBtn.onclick = () => showPage(currentPage + 1);
            } else {
                nextBtn.style.opacity = '0.4';
                nextBtn.style.cursor = 'default';
            }
            paginationContainer.appendChild(nextBtn);
        }

        if (totalItems > 0) {
            showPage(1);
        }

        document.addEventListener("DOMContentLoaded", function() {
            const urlParams = new URLSearchParams(window.location.search);
            const keywordParam = urlParams.get('keyword');
            const mypageInput = document.getElementById('mypageKeywordInput');
            
            if (keywordParam && mypageInput) {
                mypageInput.value = keywordParam;
            }

            const headerInput = document.querySelector('header input[name="keyword"], .header input[name="keyword"]');
            if (headerInput) {
                headerInput.value = '';
            }

            if (mypageInput) {
                mypageInput.addEventListener('keydown', function(event) {
                    if (event.key === 'Enter') {
                        event.preventDefault();
                        searchMypageProducts();
                    }
                });
            }
        });

        function searchMypageProducts() {
            const input = document.getElementById('mypageKeywordInput');
            const keyword = input ? input.value.trim() : '';
            location.href = '${pageContext.request.contextPath}/mypage/products?keyword=' + encodeURIComponent(keyword);
        }

        function deleteProduct(button) {
            const productNo = button.getAttribute("data-product-no");
            
            if (!productNo || productNo === 'undefined' || productNo === '') {
                alert("게시글 번호를 찾을 수 없습니다.");
                return;
            }
            
            if (!confirm("정말 이 게시글을 삭제하시겠습니까?")) {
                return;
            }

            fetch('${pageContext.request.contextPath}/mypage/deleteProduct?productNo=' + productNo, {
                method: 'DELETE'
            })
            .then(response => response.text())
            .then(result => {
                if (result.trim() === "SUCCESS") {
                    location.reload();
                } else {
                    alert("게시글 삭제에 실패했습니다.");
                }
            })
            .catch(error => {
                console.error('Error:', error);
                alert("서버 통신 중 오류가 발생했습니다.");
            });
        }
    </script>
</body>
</html>