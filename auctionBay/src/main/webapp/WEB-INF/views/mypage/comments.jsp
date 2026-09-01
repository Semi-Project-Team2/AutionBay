<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>AuctionBay - 마이페이지(댓글 관리)</title>
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

		/* 프로필 영역 */
		.profile-area {
		    background-color: #e2e2e2;
		    padding: 30px;
		    border-radius: 6px;
		    display: flex !important;
		    align-items: center !important;
		    justify-content: space-between !important;
		    width: 100% !important;
		}

		.profile-info { display: flex; align-items: center; gap: 20px; }
		.profile-img { width: 70px; height: 70px; background-color: #333; color: #fff; border-radius: 50%; display: flex; align-items: center; justify-content: center; font-weight: bold; }
		.profile-text h2 { font-size: 20px; font-weight: bold; margin-bottom: 5px; }
		.profile-text p { font-size: 14px; color: #555; }
		.profile-right { display: flex; gap: 10px; }
		.btn-edit { background-color: #d4edda; border: 1px solid #c3e6cb; padding: 8px 15px; border-radius: 4px; font-weight: bold; color: #155724; cursor: pointer; text-decoration: none; font-size: 13px; }
		.btn-withdraw { background-color: #f8d7da; border: 1px solid #f5c6cb; padding: 8px 15px; border-radius: 4px; font-weight: bold; color: #721c24; cursor: pointer; text-decoration: none; font-size: 13px; }

		/* 사이드바 + 메인 가로 배치 강제 고정 */
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

		/* 댓글 메인 콘텐츠 확장 */
		.main-content { 
		    flex: 1 !important; 
		    min-width: 0 !important; 
		}

		/* 콘텐츠 헤더 */
		.content-header { display: flex; justify-content: space-between; align-items: center; margin-bottom: 20px; }
		.content-title { font-size: 18px; font-weight: bold; }

		/* 댓글 리스트 카드 */
		.comment-list { display: flex; flex-direction: column; gap: 15px; margin-bottom: 20px; }
		.comment-card {
		    background-color: #e2e2e2; padding: 18px 20px; border-radius: 6px;
		    display: flex; align-items: center; justify-content: space-between;
		}
		.comment-info { display: flex; align-items: center; gap: 15px; font-size: 14px; color: #333; }
		.comment-title { font-weight: bold; color: #111; text-decoration: none; }
		.comment-title:hover { text-decoration: underline; }
		
		/* 삭제된 게시글 스타일 */
		.comment-title.deleted { color: #888; font-weight: normal; cursor: default; }
		.comment-title.deleted:hover { text-decoration: none; }

		.divider { color: #999; }
		.comment-content.deleted { color: #888; font-style: italic; }

		/* 댓글 삭제 버튼 */
		.btn-delete {
		    background-color: #fff;
		    border: 1px solid #ccc;
		    padding: 6px 12px;
		    border-radius: 4px;
		    text-decoration: none;
		    color: #d9534f;
		    font-size: 13px;
		    font-weight: bold;
		    cursor: pointer;
		    white-space: nowrap;
		}
		.btn-delete:hover {
		    background-color: #f8d7da;
		    border-color: #f5c6cb;
		    color: #721c24;
		}

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
		.page-btn:hover:not(.active) { background-color: #f1f1f1; }
    </style>
</head>
<body>

    <!-- 공통 헤더 -->
    <jsp:include page="/WEB-INF/views/common/header.jsp" />

    <div class="container">
        <!-- 프로필 영역 include -->
        <jsp:include page="/WEB-INF/views/mypage/profile/profile.jsp" />

        <!-- 메인 콘텐츠 영역 -->
        <div class="content-area">
            <!-- 사이드바 -->
            <nav class="sidebar">
                <ul>
                    <li><a href="${pageContext.request.contextPath}/mypage/products">게시글 관리</a></li>
                    <li><a href="${pageContext.request.contextPath}/mypage/comments" class="active">댓글 관리</a></li>
                    <li><a href="${pageContext.request.contextPath}/mypage/txHistories">거래 내역</a></li>
                    <li><a href="${pageContext.request.contextPath}/mypage/reviews">후기</a></li>
                    <li><a href="${pageContext.request.contextPath}/mypage/recents">최근 본 글</a></li>
                    <li><a href="${pageContext.request.contextPath}/mypage/wishlists">찜목록</a></li>
                    <li><a href="${pageContext.request.contextPath}/message/received">쪽지함</a></li>
                </ul>
            </nav>

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