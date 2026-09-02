<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>마이페이지 - 최근 본 글</title>
    <link rel="stylesheet" href="/css/common.css">
    <link rel="stylesheet" href="/css/mypage/common.css">
    <link rel="stylesheet" href="/css/mypage/recent.css">

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
                <jsp:param name="activeMenu" value="recents"></jsp:param>
            </jsp:include>

            <!-- 우측 메인 영역 -->
            <div class="mypage-main">
                <div class="content-header">
                    <div class="content-title">최근 본 글</div>
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
									        <c:when test="${not empty recent.mainImage}">
									            <img src="${pageContext.request.contextPath}${recent.mainImage}" alt="썸네일" class="board-thumb" style="object-fit:cover;">
									        </c:when>
									        <c:otherwise>
									            <img src="${pageContext.request.contextPath}/uploads/product/common/default_thumb.png" alt="이미지 없음" class="board-thumb" style="object-fit:cover;">
									        </c:otherwise>
									    </c:choose>
                                        
                                        <div>
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
                                    </div>
                                    <button type="button" class="btn-delete-item" onclick="deleteRecent(${recent.productNo}, this)" title="삭제">✕</button>
                                </div>
                            </c:forEach>
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

        function deleteRecent(productNo, btnElement) {
            if (!confirm("해당 기록을 삭제하시겠습니까?")) return;

            fetch('${pageContext.request.contextPath}/mypage/recents/delete?productNo=' + productNo, { method: 'DELETE' })
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

        function clearAllRecents() {
            if (!confirm("최근 본 글을 모두 삭제하시겠습니까?")) return;

            fetch('${pageContext.request.contextPath}/mypage/recents/clear', { method: 'DELETE' })
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
</html>c