<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>AuctionBay - 마이페이지(댓글 관리)</title>
    <link rel="stylesheet" href="/css/common.css">
    <link rel="stylesheet" href="/css/mypage/common.css">
    <link rel="stylesheet" href="/css/mypage/comment.css">
    
</head>
<body>

    <!-- 공통 헤더 -->
    <jsp:include page="/WEB-INF/views/common/header.jsp" />

    <div class="mypage-container">
        <!-- 프로필 영역 include -->
        <jsp:include page="/WEB-INF/views/mypage/profile/profile.jsp" />

        <!-- 메인 콘텐츠 영역 -->
        <div class="mypage-content-area">
            <!-- 사이드바 -->
            <jsp:include page="/WEB-INF/views/mypage/sidebar.jsp">
                <jsp:param name="activeMenu" value="comments"></jsp:param>
            </jsp:include>

            <!-- 우측 댓글 리스트 메인 콘텐츠 -->
            <main class="main-content">
                <div class="content-header">
                    <span class="content-title">댓글 관리</span>
                </div>

                <div class="comment-list" id="commentListContainer">
                    <c:choose>
                        <c:when test="${not empty commentList}">
                            <c:forEach var="comment" items="${commentList}">
                                <div class="comment-card" id="comment-card-${comment.commentNo}">
                                    <div class="comment-info">
                                        <%-- 게시글이 삭제되었거나(productDeleted == 1) 제목이 없는 경우 체크 --%>
                                        <c:choose>
                                            <c:when test="${comment.productDeleted == 1 || empty comment.productTitle}">
                                                <span class="comment-title deleted">[삭제된 게시글]</span>
                                            </c:when>
                                            <c:otherwise>
                                                <c:choose>
                                                    <c:when test="${comment.tradeType == 'AUCTION'}">
                                                        <a href="${pageContext.request.contextPath}/auction/${comment.productNo}/detail" class="comment-title">${comment.productTitle}</a>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <a href="${pageContext.request.contextPath}/board/${comment.productNo}/detail" class="comment-title">${comment.productTitle}</a>
                                                    </c:otherwise>
                                                </c:choose>
                                            </c:otherwise>
                                        </c:choose>
                                        
                                        <span class="divider">|</span>
                                        <c:choose>
                                            <c:when test="${comment.isDeleted == 1}">
                                                <span class="comment-content deleted">삭제된 댓글입니다.</span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="comment-content">${comment.content}</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </div>
                                    
                                    <%-- 댓글도 안 지워졌고, 게시글도 정상 존재할 때만 삭제 버튼 노출 --%>
                                    <c:if test="${comment.isDeleted != 1 && comment.productDeleted != 1 && not empty comment.productTitle}">
                                        <a href="#" class="btn-delete" data-comment-no="${comment.commentNo}" onclick="deleteComment(this); return false;">삭제</a>
                                    </c:if>
                                </div>
                            </c:forEach>
                        </c:when>
                        <c:otherwise>
                            <div class="no-data">등록된 댓글이 없습니다.</div>
                        </c:otherwise>
                    </c:choose>
                </div>

                <!-- 자바스크립트가 동적으로 생성할 페이징 바 영역 -->
                <div class="pagination" id="paginationContainer"></div>
            </main>
        </div>
    </div>

    <!-- 공통 푸터 -->
    <jsp:include page="/WEB-INF/views/common/footer.jsp" />

    <script>
        // 한 페이지당 5개씩 설정
        const itemsPerPage = 5;
        let currentPage = 1;
        const cards = document.querySelectorAll('.comment-card');
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

        function deleteComment(button) {
            const commentNo = button.getAttribute("data-comment-no");
            
            if (!confirm("정말 이 댓글을 삭제하시겠습니까?")) {
                return;
            }

            fetch('${pageContext.request.contextPath}/mypage/deleteComment?commentNo=' + commentNo, {
                method: 'DELETE'
            })
            .then(response => response.text())
            .then(result => {
                if (result.trim() === "SUCCESS") {
                    location.reload();
                } else {
                    alert("댓글 삭제에 실패했습니다.");
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