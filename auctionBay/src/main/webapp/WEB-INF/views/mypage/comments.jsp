<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>AuctionBay - 마이페이지(댓글 관리)</title>
<link rel="stylesheet" href="/css/common.css">
<style>
    * { box-sizing: border-box; margin: 0; padding: 0; }
    body { font-family: 'Malgun Gothic', sans-serif; background-color: #f8f9fa; color: #333; }
    
    .container { width: 1200px; margin: 30px auto; }

    /* 상단 프로필 영역 */
    .profile-box {
        background-color: #e2e2e2; padding: 30px; border-radius: 6px;
        display: flex; align-items: center; justify-content: space-between; margin-bottom: 30px;
    }
    .profile-info-wrap { display: flex; align-items: center; gap: 25px; }
    .profile-img { width: 80px; height: 80px; background-color: #222; border-radius: 50%; }
    .profile-text h2 { font-size: 22px; font-weight: bold; margin-bottom: 5px; color: #000; }
    .profile-text p { font-size: 14px; color: #555; }
    .btn-edit {
        background-color: #d4edda; border: 1px solid #c3e6cb; padding: 10px 20px;
        border-radius: 4px; text-decoration: none; color: #155724; font-weight: bold; font-size: 14px; cursor: pointer;
    }
    .btn-edit:hover { background-color: #c3e6cb; }

    /* 메인 콘텐츠 영역 */
    .mypage-content { display: flex; gap: 30px; align-items: flex-start; }

    /* 사이드바 스타일 */
    .sidebar {
        width: 200px; background-color: #e2e2e2; border-radius: 6px;
        padding: 15px 0;
    }
    .sidebar ul {
        list-style: none; padding: 0; margin: 0;
        display: flex; flex-direction: column; gap: 5px;
    }
    .sidebar li a {
        padding: 12px 20px; text-decoration: none; color: #555; font-size: 15px; font-weight: 500; display: block;
    }
    .sidebar li a:hover { background-color: #d1d1d1; color: #000; }
    .sidebar li a.active { background-color: #c5c5c5; color: #000; font-weight: bold; }

    /* 우측 리스트 섹션 */
    .mypage-main { flex: 1; min-width: 0; }
    .content-header { display: flex; justify-content: space-between; align-items: center; margin-bottom: 20px; }
    .content-title { font-size: 18px; font-weight: bold; }
    .search-bar { background-color: #d1d1d1; padding: 8px 15px; border-radius: 4px; font-size: 13px; color: #666; width: 250px; text-align: center; }

    /* 댓글 리스트 카드 */
    .comment-list { display: flex; flex-direction: column; gap: 15px; margin-bottom: 30px; }
    .comment-card {
        background-color: #e2e2e2; padding: 18px 20px; border-radius: 6px;
        display: flex; align-items: center; justify-content: space-between;
    }
    .comment-info { display: flex; align-items: center; gap: 15px; font-size: 15px; color: #333; }
    .comment-title { font-weight: bold; color: #111; text-decoration: none; }
    .comment-title:hover { text-decoration: underline; }
    .divider { color: #999; }
    .comment-content { color: #555; }

    .btn-delete {
        background-color: #fff; border: 1px solid #ccc; padding: 6px 12px;
        border-radius: 4px; text-decoration: none; color: #c92a2a; font-size: 13px; font-weight: bold; cursor: pointer;
    }
    .btn-delete:hover { background-color: #f1f1f1; }

    /* 페이징 바 */
    .pagination { display: flex; justify-content: center; align-items: center; gap: 5px; margin-top: 20px; }
    .page-btn { padding: 6px 12px; border: 1px solid #ddd; background-color: #fff; color: #333; text-decoration: none; border-radius: 3px; font-size: 13px; }
    .page-btn.active { background-color: #222; color: #fff; border-color: #222; font-weight: bold; }
    .page-btn:hover:not(.active) { background-color: #f1f1f1; }
</style>
</head>
<body>

<div class="container">
	<!-- 공통 헤더 포함 -->
	<jsp:include page="/WEB-INF/views/common/header.jsp" />
    
    <!-- 상단 프로필 영역 -->
    <div class="profile-box">
        <div class="profile-info-wrap">
            <div class="profile-img"></div>
            <div class="profile-text">
                <h2>${sessionScope.loginUser.nickname}</h2>
                <p>${sessionScope.loginUser.email}</p>
            </div>
        </div>
        <a href="${pageContext.request.contextPath}/mypage/edit" class="btn-edit">회원 정보 수정</a>
    </div>

    <!-- 메인 콘텐츠 -->
    <div class="mypage-content">
        
		<!-- 사이드바 -->
		<nav class="sidebar">
		    <ul>
		        <li><a href="${pageContext.request.contextPath}/mypage/boards">게시글 관리</a></li>
		        <li><a href="${pageContext.request.contextPath}/mypage/comments" class="active">댓글 관리</a></li>
		        <li><a href="${pageContext.request.contextPath}/mypage/txHistories">거래 내역</a></li>
		        <li><a href="${pageContext.request.contextPath}/mypage/review/list">후기</a></li>
		        <li><a href="${pageContext.request.contextPath}/mypage/recent">최근 본 글</a></li>
		    </ul>
		</nav>

        <!-- 우측 댓글 리스트 -->
        <div class="mypage-main">
            <div class="content-header">
                <span class="content-title">댓글 관리</span>
                <div class="search-bar">검색창</div>
            </div>

            <div class="comment-list">
                <c:choose>
                    <c:when test="${not empty commentList}">
                        <c:forEach var="comment" items="${commentList}">
                            <div class="comment-card" id="comment-card-${comment.commentNo}">
                                <div class="comment-info">
                                    <a href="${pageContext.request.contextPath}/board/detail?no=${comment.productNo}" class="comment-title">${comment.productTitle}</a>
                                    <span class="divider">|</span>
                                    <span class="comment-content">${comment.content}</span>
                                </div>
                                <a href="#" onclick="deleteComment(${comment.commentNo}); return false;" class="btn-delete">삭제</a>
                            </div>
                        </c:forEach>
                    </c:when>
                    <c:otherwise>
                        <div class="comment-card">
                            <div class="comment-info">
                                <span class="comment-title">등록된 댓글이 없습니다.</span>
                            </div>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>

            <!-- 페이징 바 -->
            <div class="pagination">
                <a class="page-btn" href="#">&lt; 이전</a>
                <a class="page-btn active" href="#">1</a>
                <a class="page-btn" href="#">2</a>
                <a class="page-btn" href="#">3</a>
                <a class="page-btn" href="#">4</a>
                <a class="page-btn" href="#">5</a>
                <a class="page-btn" href="#">다음 &gt;</a>
            </div>
        </div>

    </div>
</div>

<!-- 공통 푸터 포함 -->
<jsp:include page="/WEB-INF/views/common/footer.jsp" />

<!-- 삭제 처리를 위한 자바스크립트 함수 추가 -->
<script>
function deleteComment(commentNo) {
    if (!commentNo) {
        alert("댓글 번호를 찾을 수 없습니다.");
        return;
    }
    
    if (!confirm("정말 이 댓글을 삭제하시겠습니까?")) {
        return;
    }

    fetch('${pageContext.request.contextPath}/mypage/deleteComment?commentNo=' + commentNo)
    .then(response => response.text())
    .then(result => {
        if (result.trim() === "SUCCESS") {
            alert("댓글이 성공적으로 삭제되었습니다.");
            location.reload(); // 새로고침하여 목록 반영
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