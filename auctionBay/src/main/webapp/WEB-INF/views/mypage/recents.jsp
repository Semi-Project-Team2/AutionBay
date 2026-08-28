<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>마이페이지 - 최근 본 글</title>
    <link rel="stylesheet" href="/css/common.css">
    <style>

        /* 전체 컨테이너: 세로 플렉스로 잡아 프로필이 위, 사이드바+메인이 아래로 오게 고정 */
        .container { 
            width: 1200px; 
            margin: 30px auto; 
            display: flex; 
            flex-direction: column; 
            gap: 30px; 
        }

        /* 팀원 원본 프로필 영역이 가로 전체를 채우도록 설정 */
        .container > *:nth-child(2) {
            width: 100%;
        }

        /* 상단 프로필 영역 */
        .profile-area {
            background-color: #e2e2e2;
            padding: 30px;
            border-radius: 6px;
            display: flex;
            align-items: center;
            justify-content: space-between;
        }
        .profile-info { display: flex; align-items: center; gap: 20px; }
        .profile-img { width: 70px; height: 70px; background-color: #333; color: #fff; border-radius: 50%; display: flex; align-items: center; justify-content: center; font-weight: bold; }
        .profile-text h2 { font-size: 20px; font-weight: bold; margin-bottom: 5px; }
        .profile-text p { font-size: 14px; color: #555; }
        .profile-right { display: flex; gap: 10px; }
        .btn-edit { background-color: #d4edda; border: 1px solid #c3e6cb; padding: 8px 15px; border-radius: 4px; font-weight: bold; color: #155724; cursor: pointer; text-decoration: none; font-size: 13px; }
        .btn-withdraw { background-color: #f8d7da; border: 1px solid #f5c6cb; padding: 8px 15px; border-radius: 4px; font-weight: bold; color: #721c24; cursor: pointer; text-decoration: none; font-size: 13px; }


    
		/* 전체 컨테이너: 세로 플렉스로 잡아 프로필이 위, 사이드바+메인이 아래로 오게 고정 */
				    .container { 
				        width: 1200px; 
				        margin: 30px auto; 
				        display: flex; 
				        flex-direction: column; 
				        gap: 30px; 
				    }

				    /* 팀원 원본 프로필 영역이 가로 전체를 채우도록 설정 */
				    .container > *:nth-child(2) {
				        width: 100%;
				    }

				    /* 상단 프로필 영역 */
				    .profile-area {
				        background-color: #e2e2e2;
				        padding: 30px;
				        border-radius: 6px;
				        display: flex;
				        align-items: center;
				        justify-content: space-between;
				    }
				    .profile-info { display: flex; align-items: center; gap: 20px; }
				    .profile-img { width: 70px; height: 70px; background-color: #333; color: #fff; border-radius: 50%; display: flex; align-items: center; justify-content: center; font-weight: bold; }
				    .profile-text h2 { font-size: 20px; font-weight: bold; margin-bottom: 5px; }
				    .profile-text p { font-size: 14px; color: #555; }
				    .profile-right { display: flex; gap: 10px; }
				    .btn-edit { background-color: #d4edda; border: 1px solid #c3e6cb; padding: 8px 15px; border-radius: 4px; font-weight: bold; color: #155724; cursor: pointer; text-decoration: none; font-size: 13px; }
				    .btn-withdraw { background-color: #f8d7da; border: 1px solid #f5c6cb; padding: 8px 15px; border-radius: 4px; font-weight: bold; color: #721c24; cursor: pointer; text-decoration: none; font-size: 13px; }

        /* [핵심] 사이드바와 메인 컨텐츠를 좌우로 나란히 정렬 */
        .mypage-content { 
            display: flex !important; 
            flex-direction: row !important;
            gap: 30px !important; 
            align-items: flex-start !important; 
            width: 100% !important; 
        }

        /* 사이드바 고정 */
        .mypage-sidebar {
            width: 200px !important; 
            background-color: #e2e2e2; 
            border-radius: 6px;
            padding: 15px 0; 
            display: flex; 
            flex-direction: column; 
            gap: 5px;
            flex-shrink: 0 !important; 
        }
        .sidebar-item {
            padding: 12px 20px; text-decoration: none; color: #555; font-size: 15px; font-weight: 500; display: block;
        }
        .sidebar-item:hover { background-color: #d1d1d1; color: #000; }
        .sidebar-item.active { background-color: #d1d1d1; color: #000; font-weight: bold; }

        /* 우측 메인 영역 확장 */
        .mypage-main { 
            flex: 1 !important; 
            min-width: 0 !important; 
        }
        
        .content-header { display: flex; justify-content: space-between; align-items: center; margin-bottom: 20px; }
        .content-title { font-size: 18px; font-weight: bold; }

        .btn-clear-all {
            background-color: #ff8b94;
            color: #fff;
            border: none;
            padding: 6px 12px;
            border-radius: 4px;
            font-size: 12px;
            font-weight: bold;
            cursor: pointer;
        }
        .btn-clear-all:hover { background-color: #ff6b7b; }

        .board-list { display: flex; flex-direction: column; gap: 15px; margin-bottom: 30px; }
        .board-card {
            background-color: #e2e2e2; padding: 15px 20px; border-radius: 6px;
            display: flex; align-items: center; justify-content: space-between;
        }
        .board-info { display: flex; align-items: center; gap: 20px; }
        .board-thumb { width: 80px; height: 80px; background-color: #b5b5b5; border-radius: 4px; object-fit: cover; display: flex; align-items: center; justify-content: center; color: #555; font-weight: bold; }
        .board-title { font-size: 16px; font-weight: 500; color: #333; text-decoration: none; }
        .board-title:hover { text-decoration: underline; }
        
        .btn-delete-item {
            background: none;
            border: none;
            font-size: 18px;
            color: #888;
            cursor: pointer;
            padding: 5px;
            line-height: 1;
        }
        .btn-delete-item:hover { color: #ff0000; }

        .no-data { text-align: center; padding: 40px; color: #777; background-color: #e2e2e2; border-radius: 6px; }

        .pagination { display: flex; justify-content: center; align-items: center; gap: 5px; margin-top: 20px; }
        .page-btn { padding: 6px 12px; border: 1px solid #ddd; background-color: #fff; color: #333; text-decoration: none; border-radius: 3px; font-size: 13px; cursor: pointer; }
        .page-btn.active { background-color: #222; color: #fff; border-color: #222; font-weight: bold; }
        .page-btn:hover:not(.active) { background-color: #f1f1f1; }
    </style>
</head>
<body>

    <div class="container">
        <jsp:include page="/WEB-INF/views/common/header.jsp" />
        
        <!-- 프로필 영역 포함 -->
        <jsp:include page="/WEB-INF/views/mypage/profile/profile.jsp" />

        <div class="mypage-content">
            
        <!-- 사이드바 -->
        <div class="mypage-sidebar">
            <a href="${pageContext.request.contextPath}/mypage/products" class="sidebar-item">게시글 관리</a>
            <a href="${pageContext.request.contextPath}/mypage/comments" class="sidebar-item">댓글 관리</a>
            <a href="${pageContext.request.contextPath}/mypage/txHistories" class="sidebar-item">거래내역</a>
            <a href="${pageContext.request.contextPath}/mypage/reviews" class="sidebar-item">후기</a>
            <a href="${pageContext.request.contextPath}/mypage/recents" class="sidebar-item active">최근 본 글</a>
            <a href="${pageContext.request.contextPath}/mypage/wishlists" class="sidebar-item">찜 목록</a>
            <a href="${pageContext.request.contextPath}/message/received" class="sidebar-item">쪽지함</a>
        </div>

            <div class="mypage-main">
                <div class="content-header">
                    <div class="content-title">마이페이지(최근 본 글)</div>
                    <c:if test="${not empty recentList}">
                        <button type="button" class="btn-clear-all" onclick="clearAllRecents()">전체 삭제</button>
                    </c:if>
                </div>

                <div class="board-list">
                    <c:choose>
                        <c:when test="${empty recentList}">
                            <div class="no-data">최근 본 글이 없습니다.</div>
                        </c:when>
                        <c:otherwise>
                            <c:forEach var="recent" items="${recentList}">
                                <div class="board-card" data-product-no="${recent.productNo}">
                                    <div class="board-info">
                                        <c:choose>
                                            <c:when test="${not empty recent.mainImage and recent.mainImage != '/images/no-image.png'}">
                                                <img src="${pageContext.request.contextPath}/resources/upload/${recent.mainImage}" class="board-thumb" alt="상품 이미지">
                                            </c:when>
                                            <c:otherwise>
                                                <img src="${pageContext.request.contextPath}${empty recent.mainImage ? '/images/no-image.png' : recent.mainImage}" class="board-thumb" alt="기본 이미지">
                                            </c:otherwise>
                                        </c:choose>
                                        
                                        <c:choose>
                                            <c:when test="${recent.tradeType == 'AUCTION'}">
                                                <span class="type-badge auction">경매</span>
                                                <a href="${pageContext.request.contextPath}/auction/${recent.productNo}/detail" class="board-title">${recent.title}</a>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="type-badge general">일반</span>
                                                <a href="${pageContext.request.contextPath}/board/${recent.productNo}/detail" class="board-title">${recent.title}</a>
                                            </c:otherwise>
                                        </c:choose>
                                    </div>
                                    <button type="button" class="btn-delete-item" onclick="deleteRecent(${recent.productNo}, this)" title="삭제">✕</button>
                                </div>
                            </c:forEach>
                        </c:otherwise>
                    </c:choose>
                </div>

                <!-- 자바스크립트가 10개씩 끊어서 생성해 줄 페이징 바 영역 -->
                <div class="pagination" id="paginationContainer"></div>

            </div>
        </div>
    </div>

    <jsp:include page="/WEB-INF/views/common/footer.jsp" />

    <script>
        // 클라이언트 사이드 페이징 (1페이지당 10개씩)
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

        // 개별 삭제
        function deleteRecent(productNo, btnElement) {
            if (!confirm("해당 기록을 삭제하시겠습니까?")) return;

            fetch('/mypage/recents/delete?productNo=' + productNo, { method: 'DELETE' })
            .then(res => {
                if (!res.ok) throw new Error("HTTP error " + res.status);
                return res.text();
            })
            .then(data => {
                if (data === 'SUCCESS') {
                    location.reload(); // 삭제 후 깔끔하게 새로고침하여 목록 및 페이징 재정렬
                } else {
                    alert("삭제 실패: " + data);
                }
            })
            .catch(err => alert("오류 발생: " + err.message));
        }

        // 전체 삭제
        function clearAllRecents() {
            if (!confirm("최근 본 글을 모두 삭제하시겠습니까?")) return;

            fetch('/mypage/recents/clear', { method: 'DELETE' })
            .then(res => {
                if (!res.ok) throw new Error("HTTP error " + res.status);
                return res.text();
            })
            .then(data => {
                if (data === 'SUCCESS') {
                    location.reload();
                } else {
                    alert("삭제 실패: " + data);
                }
            })
            .catch(err => alert("오류 발생: " + err.message));
        }
    </script>
</body>
</html>