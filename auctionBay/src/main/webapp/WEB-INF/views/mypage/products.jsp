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
    .container { width: 1200px; margin: 30px auto; }
    .profile-box { background-color: #e2e2e2; padding: 30px; border-radius: 6px; display: flex; align-items: center; justify-content: space-between; margin-bottom: 30px; }
    .profile-info-wrap { display: flex; align-items: center; gap: 25px; }
    .profile-img { width: 80px; height: 80px; background-color: #222; border-radius: 50%; }
    .profile-text h2 { font-size: 22px; font-weight: bold; margin-bottom: 5px; color: #000; }
    .profile-text p { font-size: 14px; color: #555; }
    .btn-edit { background-color: #d4edda; border: 1px solid #c3e6cb; padding: 10px 20px; border-radius: 4px; text-decoration: none; color: #155724; font-weight: bold; font-size: 14px; cursor: pointer; }
    .mypage-content { display: flex; gap: 30px; align-items: flex-start; }
    .sidebar { width: 200px; background-color: #e2e2e2; border-radius: 6px; padding: 15px 0; }
    .sidebar ul { list-style: none; padding: 0; margin: 0; display: flex; flex-direction: column; gap: 5px; }
    .sidebar li a { padding: 12px 20px; text-decoration: none; color: #555; font-size: 15px; font-weight: 500; display: block; }
    .sidebar li a:hover { background-color: #d1d1d1; color: #000; }
    .sidebar li a.active { background-color: #c5c5c5; color: #000; font-weight: bold; }
    .mypage-main { flex: 1; min-width: 0; }
    .content-header { display: flex; justify-content: space-between; align-items: center; margin-bottom: 20px; }
    .content-title { font-size: 18px; font-weight: bold; }
    .search-bar { background-color: #d1d1d1; padding: 8px 15px; border-radius: 4px; font-size: 13px; color: #666; width: 250px; text-align: center; }
    .board-list { display: flex; flex-direction: column; gap: 15px; margin-bottom: 30px; }
    .board-card { background-color: #e2e2e2; padding: 15px 20px; border-radius: 6px; display: flex; align-items: center; justify-content: space-between; }
    .board-info { display: flex; align-items: center; gap: 20px; }
    .board-thumb { width: 80px; height: 80px; background-color: #b5b5b5; border-radius: 4px; object-fit: cover; }
    .board-title { font-size: 16px; font-weight: 500; color: #333; text-decoration: none; }
    .board-actions { display: flex; gap: 10px; }
    .btn-action { background-color: #fff; border: 1px solid #ccc; padding: 6px 12px; border-radius: 4px; text-decoration: none; color: #333; font-size: 13px; font-weight: bold; cursor: pointer; }

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
</style>
</head>
<body>

<div class="container">
   <jsp:include page="/WEB-INF/views/common/header.jsp" />
   
    <div class="profile-box">
        <div class="profile-info-wrap">
            <div class="profile-img"></div>
            <div class="profile-text">
                <h2>${sessionScope.loginUser.nickname}</h2>
                <p>${sessionScope.loginUser.email}</p>
            </div>
        </div>
        <a href="${pageContext.request.contextPath}/mypage/profile/editForm" class="btn-edit">회원 정보 수정</a>
    </div>

    <div class="mypage-content">
        <nav class="sidebar">
            <ul>
                <!-- 수정: /mypage/boards -> /mypage/products (실제 매핑과 일치) -->
                <li><a href="${pageContext.request.contextPath}/mypage/products" class="active">게시글 관리</a></li>
                <li><a href="${pageContext.request.contextPath}/mypage/comments">댓글 관리</a></li>
                <li><a href="${pageContext.request.contextPath}/mypage/txHistories">거래 내역</a></li>
                <li><a href="${pageContext.request.contextPath}/mypage/reviews/list">후기</a></li>
                <li><a href="${pageContext.request.contextPath}/mypage/recents">최근 본 글</a></li>
            </ul>
        </nav>

        <div class="mypage-main">
            <div class="content-header">
                <span class="content-title">게시글 관리</span>
                <!-- 검색 기능 추가 (기존 search-bar 클래스 및 스타일 그대로 유지) -->
                <form action="${pageContext.request.contextPath}/mypage/products" method="get" class="search-bar" style="display: flex; align-items: center; padding: 0 5px;">
                    <input type="text" name="keyword" value="${param.keyword}" placeholder="검색어를 입력하세요" style="width: 100%; border: none; background: transparent; outline: none; font-size: 13px; text-align: left; padding: 8px 5px;">
                    <button type="submit" style="border: none; background: transparent; cursor: pointer; font-size: 13px; color: #333; font-weight: bold; white-space: nowrap;">검색</button>
                </form>
            </div>

            <!-- productList: 경매/일반 게시글이 tradeType 값으로 함께 조회됨 -->
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
						                <!-- 경매/일반 구분 뱃지: tradeType 값에 따라 표시 -->
						                <c:choose>
						                    <c:when test="${board.tradeType == 'AUCTION'}">
						                        <span class="type-badge auction">경매</span>
						                    </c:when>
						                    <c:otherwise>
						                        <span class="type-badge general">일반</span>
						                    </c:otherwise>
						                </c:choose>
						                <a href="${pageContext.request.contextPath}/auction/${pNo}/detail" class="board-title">${board.title}</a>
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
                        <div class="board-card">
                            <div class="board-info">
                                <span class="board-title">등록된 게시글이 없습니다.</span>
                            </div>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
			
            <!-- 게시글이 있을 때만 노출되는 페이징 바 영역 -->
            <c:if test="${not empty productList}">
                <div class="pagination" style="display: flex; justify-content: center; gap: 5px; margin-top: 20px;">
                    <a href="#" class="btn-action">&lt; 이전</a>
                    <a href="#" class="btn-action" style="background-color: #ddd; font-weight: bold;">1</a>
                    <a href="#" class="btn-action">다음 &gt;</a>
                </div>
            </c:if>

        </div>
    </div>
</div>

<jsp:include page="/WEB-INF/views/common/footer.jsp" />

<script>
/* 수정: functio -> function 오타로 인해 삭제 기능이 동작하지 않던 버그 수정 */
function deleteProduct(button) {
    const productNo = button.getAttribute("data-product-no");
    
    if (!productNo || productNo === 'undefined' || productNo === '') {
        alert("게시글 번호를 찾을 수 없습니다.");
        return;
    }
    
    if (!confirm("정말 이 게시글을 삭제하시겠습니까?")) {
        return;
    }

    fetch('${pageContext.request.contextPath}/mypage/deleteProduct?productNo=' + productNo)
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
</html>