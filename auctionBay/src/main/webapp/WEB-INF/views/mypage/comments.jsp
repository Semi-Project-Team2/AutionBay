<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>AuctionBay - 마이페이지(댓글 관리)</title>
    <link rel="stylesheet" href="/css/common.css">
    <style>
		* { box-sizing: border-box; margin: 0; padding: 0; }
        body { font-family: 'Malgun Gothic', sans-serif; background-color: #f8f9fa; color: #333; }
        
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

        /* 메인 콘텐츠 영역 (사이드바와 우측 본문을 가로로 정렬) */
        .content-area { display: flex; gap: 30px; align-items: flex-start; width: 100%; }
        
        /* 사이드바 */
        .sidebar { width: 200px; background-color: #e2e2e2; border-radius: 6px; padding: 15px 0; flex-shrink: 0; }
        .sidebar ul { list-style: none; padding: 0; margin: 0; }
        .sidebar li a { display: block; padding: 12px 20px; text-decoration: none; color: #555; font-size: 15px; font-weight: 500; }
        .sidebar li a:hover, .sidebar li a.active { background-color: #d1d1d1; color: #000; font-weight: bold; }

        /* 댓글 메인 콘텐츠 */
        .main-content { flex: 1; min-width: 0; }
        
        /* 콘텐츠 헤더 */
        .content-header { display: flex; justify-content: space-between; align-items: center; margin-bottom: 20px; }
        .content-title { font-size: 18px; font-weight: bold; }
        
        /* 검색 바 스타일 */
        .search-bar { background-color: #e2e2e2; border-radius: 4px; padding: 8px 15px; }
        .search-bar input { border: none; background: transparent; font-size: 13px; color: #666; width: 200px; outline: none; text-align: center; }

        /* 댓글 리스트 카드 */
        .comment-list { display: flex; flex-direction: column; gap: 15px; margin-bottom: 20px; }
        .comment-card {
            background-color: #e2e2e2; padding: 18px 20px; border-radius: 6px;
            display: flex; align-items: center; justify-content: space-between;
        }
        .comment-info { display: flex; align-items: center; gap: 15px; font-size: 14px; color: #333; }
        .comment-title { font-weight: bold; color: #111; text-decoration: none; }
        .comment-title:hover { text-decoration: underline; }
        .divider { color: #999; }
        .comment-date { color: #666; font-size: 13px; }

        /* 댓글 삭제 버튼 스타일 추가 */
        .btn-delete {
            background-color: #fff;
            border: 1px solid #ccc;
            padding: 6px 12px;
            border-radius: 4px;
            text-decoration: none;
            color: #d9534f; /* 삭제 버튼이라 은은한 붉은빛 텍스트 컬러 (원하시면 #333으로 변경 가능) */
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
        
        /* 프로필 영역 안의 이미지와 텍스트가 찌그러지거나 밀리지 않도록 고정 */
        .profile-area {
            display: flex !important;
            align-items: center !important;
            justify-content: space-between !important;
            width: 100% !important;
        }
        .profile-info {
            display: flex !important;
            align-items: center !important;
            gap: 20px !important;
        }
    </style>
</head>
<body>

    <!-- 공통 헤더 포함 -->
    <jsp:include page="/WEB-INF/views/common/header.jsp" />

    <div class="container">
        <!-- 팀원 원본 프로필 include -->
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
                </ul>
            </nav>

            <!-- 우측 댓글 리스트 메인 콘텐츠 -->
            <main class="main-content">
                <div class="content-header">
                    <span class="content-title">댓글 관리</span>
                </div>

                <div class="comment-list">
                    <c:choose>
                        <c:when test="${not empty commentList}">
                            <c:forEach var="comment" items="${commentList}">
                                <div class="comment-card" id="comment-card-${comment.commentNo}">
                                    <div class="comment-info">
                                        <a href="${pageContext.request.contextPath}/auction/${comment.productNo}/detail" class="comment-title">${comment.productTitle}</a>
                                        <span class="divider">|</span>
                                        <span class="comment-content ${comment.content eq '삭제된 댓글입니다.' ? 'deleted' : ''}">${comment.content}</span>
                                    </div>
                                    
                                    <c:if test="${comment.content ne '삭제된 댓글입니다.'}">
                                        <a href="#" class="btn-delete" data-comment-no="${comment.commentNo}" onclick="deleteComment(this); return false;">삭제</a>
                                    </c:if>
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
                <c:if test="${not empty commentList}">
                    <div class="pagination">
                        <a href="#" class="page-btn">&lt; 이전</a>
                        <a href="#" class="page-btn active">1</a>
                        <a href="#" class="page-btn">다음 &gt;</a>
                    </div>
                </c:if>
            </main>
        </div>
    </div>

    <!-- 공통 푸터 포함 -->
    <jsp:include page="/WEB-INF/views/common/footer.jsp" />

    <!-- 삭제 처리 JS -->
    <script>
    function deleteComment(button) {
        const commentNo = button.getAttribute("data-comment-no");
        
        if (!confirm("정말 이 댓글을 삭제하시겠습니까?")) {
            return;
        }

        fetch('${pageContext.request.contextPath}/mypage/deleteComment?commentNo=' + commentNo)
        .then(response => response.text())
        .then(result => {
            if (result.trim() === "SUCCESS") {
                const card = document.getElementById('comment-card-' + commentNo);
                if (card) {
                    const contentSpan = card.querySelector('.comment-content');
                    if (contentSpan) {
                        contentSpan.innerText = '삭제된 댓글입니다.';
                        contentSpan.classList.add('deleted');
                    }
                    button.remove();
                }
                alert("댓글이 성공적으로 삭제되었습니다.");
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