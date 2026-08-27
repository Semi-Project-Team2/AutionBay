<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>마이페이지 - 최근 본 글</title>
	<link rel="stylesheet" href="/css/common.css">
    <style>
        * { box-sizing: border-box; margin: 0; padding: 0; }
        body { font-family: 'Malgun Gothic', sans-serif; background-color: #f8f9fa; color: #333; }
        
        .container { width: 1200px; margin: 30px auto; }

        .profile-box {
            background-color: #e2e2e2;
            padding: 30px;
            border-radius: 6px;
            display: flex;
            align-items: center;
            justify-content: space-between;
            margin-bottom: 30px;
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

        .mypage-content { display: flex; gap: 30px; align-items: flex-start; }

        .mypage-sidebar {
            width: 200px; background-color: #e2e2e2; border-radius: 6px;
            padding: 15px 0; display: flex; flex-direction: column; gap: 5px;
        }
        .sidebar-item {
            padding: 12px 20px; text-decoration: none; color: #555; font-size: 15px; font-weight: 500; display: block;
        }
        .sidebar-item:hover { background-color: #d1d1d1; color: #000; }
        .sidebar-item.active { background-color: #c5c5c5; color: #000; font-weight: bold; }

        .mypage-main { flex: 1; min-width: 0; }
        .content-header { display: flex; justify-content: space-between; align-items: center; margin-bottom: 20px; }
        .content-title { font-size: 18px; font-weight: bold; }

        .board-list { display: flex; flex-direction: column; gap: 15px; margin-bottom: 30px; }
        .board-card {
            background-color: #e2e2e2; padding: 15px 20px; border-radius: 6px;
            display: flex; align-items: center; justify-content: space-between;
        }
        .board-info { display: flex; align-items: center; gap: 20px; }
        .board-thumb { width: 80px; height: 80px; background-color: #b5b5b5; border-radius: 4px; object-fit: cover; display: flex; align-items: center; justify-content: center; color: #555; font-weight: bold; }
        .board-title { font-size: 16px; font-weight: 500; color: #333; text-decoration: none; }
        .board-title:hover { text-decoration: underline; }
        
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
                </div>

                <div class="board-list">
                    <c:choose>
                        <c:when test="${empty recentList}">
                            <div class="no-data">최근 본 글이 없습니다.</div>
                        </c:when>
                        <c:otherwise>
							<c:forEach var="recent" items="${recentList}">
							    <div class="board-card">
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
	<script src="${pageContext.request.contextPath}/js/mypage.js"></script>
</body>
</html>