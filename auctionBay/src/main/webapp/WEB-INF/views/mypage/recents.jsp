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
        .page-btn { padding: 6px 12px; border: 1px solid #ddd; background-color: #fff; color: #333; text-decoration: none; border-radius: 3px; font-size: 13px; }
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
            
            <div class="mypage-sidebar">
                <a href="${pageContext.request.contextPath}/mypage/products" class="sidebar-item">게시글 관리</a>
                <a href="${pageContext.request.contextPath}/mypage/comments" class="sidebar-item">댓글 관리</a>
                <a href="${pageContext.request.contextPath}/mypage/txHistories" class="sidebar-item">거래 내역</a>
                <a href="${pageContext.request.contextPath}/mypage/reviews" class="sidebar-item">후기</a>
                <a href="${pageContext.request.contextPath}/mypage/recents" class="sidebar-item active">최근 본 글</a>
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
                                            <c:when test="${not empty recent.mainImage}">
                                                <img src="${pageContext.request.contextPath}/resources/upload/${recent.mainImage}" class="board-thumb" alt="상품 이미지">
                                            </c:when>
                                            <c:otherwise>
                                                <div class="board-thumb">img</div>
                                            </c:otherwise>
                                        </c:choose>
                                        
                                        <a href="${pageContext.request.contextPath}/auction/${recent.productNo}/detail" class="board-title">${recent.title}</a>
                                    </div>
                                    <button type="button" class="btn-delete-item" onclick="deleteRecent(${recent.productNo}, this)" title="삭제">✕</button>
                                </div>
                            </c:forEach>
                        </c:otherwise>
                    </c:choose>
                </div>

                <c:if test="${not empty recentList}">
                    <div class="pagination">
                        <a href="#" class="page-btn">&lt; 이전</a>
                        <a href="#" class="page-btn active">1</a>
                        <a href="#" class="page-btn">다음 &gt;</a>
                    </div>
                </c:if>

            </div>
        </div>
    </div>

    <jsp:include page="/WEB-INF/views/common/footer.jsp" />

	<script>
		// 개별 삭제
		function deleteRecent(productNo, btnElement) {
		    if (!confirm("해당 기록을 삭제하시겠습니까?")) return;

		    const params = new URLSearchParams();
		    params.append('productNo', productNo);

		    fetch('/mypage/recents/delete', {
		        method: 'POST',
		        headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
		        body: params
		    })
		    .then(res => {
		        if (!res.ok) throw new Error("HTTP error " + res.status);
		        return res.text();
		    })
		    .then(data => {
		        if (data === 'SUCCESS') {
		            const card = btnElement.closest('.board-card');
		            card.remove();

		            const list = document.querySelector('.board-list');
		            if (list.children.length === 0) {
		                list.innerHTML = '<div class="no-data">최근 본 글이 없습니다.</div>';
		                const pagination = document.querySelector('.pagination');
		                const clearBtn = document.querySelector('.btn-clear-all');
		                if (pagination) pagination.remove();
		                if (clearBtn) clearBtn.remove();
		            }
		        } else {
		            alert("삭제 실패: " + data);
		        }
		    })
		    .catch(err => alert("오류 발생: " + err.message));
		}

		// 전체 삭제
		function clearAllRecents() {
		    if (!confirm("최근 본 글을 모두 삭제하시겠습니까?")) return;

		    fetch('/mypage/recents/clear', {
		        method: 'POST'
		    })
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