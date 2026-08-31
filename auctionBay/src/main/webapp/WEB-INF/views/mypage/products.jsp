<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>AuctionBay - 마이페이지(게시글 관리)</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/common.css">
    <style>
        * { box-sizing: border-box; margin: 0; padding: 0; }
        body { font-family: 'Malgun Gothic', sans-serif; background-color: #f8f9fa; color: #333; }
        
        /* 전체 컨테이너 */
        .container { 
            width: 1200px; 
            margin: 30px auto; 
            display: flex; 
            flex-direction: column; 
            gap: 30px; 
        }

        /* 상단 프로필 영역 */
        .profile-area {
            background-color: #e2e2e2;
            padding: 30px;
            border-radius: 6px;
            display: flex !important;
            align-items: center !important;
            justify-content: space-between !important;
            width: 100% !important;
        }

        /* [핵심] 사이드바와 메인 콘텐츠를 무조건 좌우로 나란히 강제 정렬 */
        .content-area { 
            display: flex !important; 
            flex-direction: row !important;
            gap: 30px !important; 
            align-items: flex-start !important; 
            width: 100% !important; 
        }
        
        /* 사이드바 고정 */
        .sidebar { 
            width: 200px !important; 
            background-color: #e2e2e2; 
            border-radius: 6px; 
            padding: 15px 0; 
            flex-shrink: 0 !important; 
        }
        .sidebar ul { list-style: none; padding: 0; margin: 0; display: flex; flex-direction: column; gap: 5px; }
        .sidebar li a { display: block; padding: 12px 20px; text-decoration: none; color: #555; font-size: 15px; font-weight: 500; }
        .sidebar li a:hover, .sidebar li a.active { background-color: #d1d1d1; color: #000; font-weight: bold; }

        /* 우측 메인 영역 확장 */
        .main-content { 
            flex: 1 !important; 
            min-width: 0 !important; 
        }
        
        /* 콘텐츠 헤더 */
        .content-header { display: flex; justify-content: space-between; align-items: center; margin-bottom: 20px; }
        .content-title { font-size: 18px; font-weight: bold; }
        
        /* 검색바 스타일 */
        .search-bar { background-color: #e2e2e2; padding: 0 10px; border-radius: 4px; font-size: 13px; color: #666; width: 250px; display: flex; align-items: center; }
        .search-bar input { width: 100%; border: none; background: transparent; outline: none; font-size: 13px; text-align: left; padding: 8px 5px; }
        .search-bar button { border: none; background: transparent; cursor: pointer; font-size: 13px; color: #333; font-weight: bold; white-space: nowrap; }

        /* 게시글 리스트 카드 스타일 */
        .board-list { display: flex; flex-direction: column; gap: 15px; margin-bottom: 30px; }
        .board-card { background-color: #e2e2e2; padding: 15px 20px; border-radius: 6px; display: flex; align-items: center; justify-content: space-between; }
        .board-info { display: flex; align-items: center; gap: 20px; }
        .board-thumb { width: 80px; height: 80px; background-color: #b5b5b5; border-radius: 4px; object-fit: cover; }
        .board-title { font-size: 16px; font-weight: 500; color: #333; text-decoration: none; }
        .board-title:hover { text-decoration: underline; }
        
        .board-actions { display: flex; gap: 10px; }
        .btn-action { background-color: #fff; border: 1px solid #ccc; padding: 6px 12px; border-radius: 4px; text-decoration: none; color: #333; font-size: 13px; font-weight: bold; cursor: pointer; }
        .btn-action:hover { background-color: #f1f1f1; }

        /* 경매/일반 구분 뱃지 */
        .type-badge {
            display: inline-block;
            padding: 3px 8px;
            border-radius: 10px;
            font-size: 11px;
            font-weight: bold;
            margin-right: 8px;
            vertical-align: middle;
        }
        .type-badge.auction { background-color: #ffe3e3; color: #c92a2a; }
        .type-badge.general { background-color: #e7f5ff; color: #1971c2; }
        
        .no-data { background-color: #e2e2e2; padding: 40px; text-align: center; border-radius: 6px; color: #777; font-size: 14px; }

        /* 페이징 바 */
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
            cursor: pointer;
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

    <!-- 공통 헤더 포함 -->
    <jsp:include page="/WEB-INF/views/common/header.jsp" />

    <div class="container">
        <!-- 팀원 원본 프로필 include -->
        <jsp:include page="/WEB-INF/views/mypage/profile/profile.jsp" />

        <div class="content-area">
            <!-- 사이드바 (게시글 관리에 active 적용 및 중복 항목 제거) -->
            <nav class="sidebar">
                <ul>
                    <li><a href="${pageContext.request.contextPath}/mypage/products" class="active">게시글 관리</a></li>
                    <li><a href="${pageContext.request.contextPath}/mypage/comments">댓글 관리</a></li>
                    <li><a href="${pageContext.request.contextPath}/mypage/txHistories">거래 내역</a></li>
                    <li><a href="${pageContext.request.contextPath}/mypage/reviews">후기</a></li>
                    <li><a href="${pageContext.request.contextPath}/mypage/recents">최근 본 글</a></li>
                    <li><a href="${pageContext.request.contextPath}/mypage/wishlists">찜 목록</a></li>
                    <li><a href="${pageContext.request.contextPath}/message/received">쪽지 함</a></li>
                </ul>
            </nav>

            <!-- 우측 게시글 메인 콘텐츠 -->
            <main class="main-content">
                <div class="content-header">
                    <span class="content-title">게시글 관리</span>
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
                                                    <span class="type-badge auction">경매</span>
                                                    <a href="${pageContext.request.contextPath}/auction/${pNo}/detail" class="board-title">${board.title}</a>
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="type-badge general">일반</span>
                                                    <a href="${pageContext.request.contextPath}/board/${pNo}/detail" class="board-title">${board.title}</a>
                                                </c:otherwise>
                                            </c:choose>
                                        </div>
                                    </div>
                                    <div class="board-actions">
                                        <a href="${pageContext.request.contextPath}/product/updateForm?no=${pNo}" class="btn-action">수정</a>
                                        <button type="button" class="btn-action" style="color: #c92a2a;" data-product-no="${pNo}" onclick="deleteProduct(this);">삭제</button>
                                    </div>
                                </div>
                            </c:forEach>
                        </c:when>
                        <c:otherwise>
                            <div class="no-data">등록된 게시글이 없습니다.</div>
                        </c:otherwise>
                    </c:choose>
                </div>
                
                <!-- 자바스크립트 동적 페이징 바 -->
                <div class="pagination" id="paginationContainer"></div>
            </main>
        </div>
    </div>

    <!-- 공통 푸터 포함 -->
    <jsp:include page="/WEB-INF/views/common/footer.jsp" />

    <script>
        // 한 페이지당 5개씩 설정
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
            if (totalPages <= 1) return; // 1페이지 이하면 페이징 바 숨김

            // 이전 버튼
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

        // 페이지 최초 로드 시 1페이지 실행
        if (totalItems > 0) {
            showPage(1);
        }

        // 페이지 로드 시 처리
        document.addEventListener("DOMContentLoaded", function() {
            // 1. 주소창의 keyword 파라미터 값 가져오기
            const urlParams = new URLSearchParams(window.location.search);
            const keywordParam = urlParams.get('keyword');
            const mypageInput = document.getElementById('mypageKeywordInput');
            
            // 2. 마이페이지 검색창에 검색어 바인딩
            if (keywordParam && mypageInput) {
                mypageInput.value = keywordParam;
            }

            // 3. 공통 헤더 검색창의 value 초기화
            const headerInput = document.querySelector('header input[name="keyword"], .header input[name="keyword"]');
            if (headerInput) {
                headerInput.value = '';
            }

            // 4. 엔터키 감지 이벤트
            if (mypageInput) {
                mypageInput.addEventListener('keydown', function(event) {
                    if (event.key === 'Enter') {
                        event.preventDefault();
                        searchMypageProducts();
                    }
                });
            }
        });

        // 마이페이지 검색 실행 함수
        function searchMypageProducts() {
            const input = document.getElementById('mypageKeywordInput');
            const keyword = input ? input.value.trim() : '';
            location.href = '${pageContext.request.contextPath}/mypage/products?keyword=' + encodeURIComponent(keyword);
        }

        // 게시글 삭제 함수
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