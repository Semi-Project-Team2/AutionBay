<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>AuctionBay - 마이페이지(게시글 관리)</title>
    <link rel="stylesheet" href="/css/common.css">
    <style>
        * { box-sizing: border-box; margin: 0; padding: 0; }
        body { font-family: 'Malgun Gothic', sans-serif; background-color: #f8f9fa; color: #333; }
        
        /* 전체 컨테이너를 세로 플렉스로 잡아 프로필이 위, content-area가 아래로 오게 고정 */
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

        /* [핵심] 사이드바와 메인 컨텐츠를 무조건 좌우로 나란히 강제 정렬 */
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

    <jsp:include page="/WEB-INF/views/common/header.jsp" />

    <div class="container">
        <!-- 팀원 원본 프로필 include -->
        <jsp:include page="/WEB-INF/views/mypage/profile/profile.jsp" />

        <div class="content-area">
            <!-- 사이드바 (게시글 관리에 active 클래스) -->
            <nav class="sidebar">
                <ul>
                    <li><a href="${pageContext.request.contextPath}/mypage/products" class="active">게시글 관리</a></li>
                    <li><a href="${pageContext.request.contextPath}/mypage/comments">댓글 관리</a></li>
                    <li><a href="${pageContext.request.contextPath}/mypage/txHistories">거래 내역</a></li>
                    <li><a href="${pageContext.request.contextPath}/mypage/reviews">후기</a></li>
                    <li><a href="${pageContext.request.contextPath}/mypage/recents">최근 본 글</a></li>
                </ul>
            </nav>

            <!-- 우측 게시글 메인 콘텐츠 -->
            <main class="main-content">
                <div class="content-header">
                    <span class="content-title">게시글 관리</span>
                    <form action="${pageContext.request.contextPath}/mypage/products" method="get" class="search-bar">
                        <input type="text" name="keyword" value="${param.keyword}" placeholder="검색어를 입력하세요">
                        <button type="submit">검색</button>
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
                                        <a href="${pageContext.request.contextPath}/board/update?no=${pNo}" class="btn-action">수정</a>
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
                
                <c:if test="${not empty productList}">
                    <div class="pagination">
                        <a href="#" class="page-btn">&lt; 이전</a>
                        <a href="#" class="page-btn active">1</a>
                        <a href="#" class="page-btn">다음 &gt;</a>
                    </div>
                </c:if>
            </main>
        </div>
    </div>

    <jsp:include page="/WEB-INF/views/common/footer.jsp" />

	<script>
	    function deleteProduct(button) {
	        const productNo = button.getAttribute("data-product-no");
	        
	        if (!productNo || productNo === 'undefined' || productNo === '') {
	            alert("게시글 번호를 찾을 수 없습니다.");
	            return;
	        }
	        
	        if (!confirm("정말 이 게시글을 삭제하시겠습니까?")) {
	            return;
	        }

	        // fetch 요청 시 method: 'DELETE' 지정
	        fetch('${pageContext.request.contextPath}/mypage/deleteProduct?productNo=' + productNo, {
	            method: 'DELETE'
	        })
	        .then(response => response.text())
	        .then(result => {
	            if (result.trim() === "SUCCESS") {
	                const card = document.getElementById('board-card-' + productNo);
	                if (card) card.remove();
	                alert("게시글이 성공적으로 삭제되었습니다.");
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
</html>s