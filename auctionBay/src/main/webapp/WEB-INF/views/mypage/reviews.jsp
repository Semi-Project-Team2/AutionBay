<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>마이페이지 - 후기</title>
    <link rel="stylesheet" href="/css/common.css">
    <style>
        * { box-sizing: border-box; margin: 0; padding: 0; }
        body { font-family: 'Malgun Gothic', sans-serif; background-color: #f8f9fa; color: #333; }
        
        .container { width: 1200px; margin: 30px auto; }

        /* 상단 프로필 영역 */
        .profile-area {
            background-color: #e2e2e2;
            padding: 30px;
            border-radius: 6px;
            display: flex;
            align-items: center;
            justify-content: space-between;
            margin-bottom: 30px;
        }
        .profile-info { display: flex; align-items: center; gap: 20px; }
        .profile-img { width: 70px; height: 70px; background-color: #333; color: #fff; border-radius: 50%; display: flex; align-items: center; justify-content: center; font-weight: bold; }
        .profile-text h2 { font-size: 20px; font-weight: bold; margin-bottom: 5px; }
        .profile-text p { font-size: 14px; color: #555; }
        .profile-right { display: flex; gap: 10px; }
        .btn-edit { background-color: #d4edda; border: 1px solid #c3e6cb; padding: 8px 15px; border-radius: 4px; font-weight: bold; color: #155724; cursor: pointer; text-decoration: none; font-size: 13px; }
        .btn-withdraw { background-color: #f8d7da; border: 1px solid #f5c6cb; padding: 8px 15px; border-radius: 4px; font-weight: bold; color: #721c24; cursor: pointer; text-decoration: none; font-size: 13px; }

        /* 메인 콘텐츠 영역 */
        .content-area { display: flex; gap: 30px; align-items: flex-start; }
        
        /* 사이드바 */
        .sidebar { width: 200px; background-color: #e2e2e2; border-radius: 6px; padding: 15px 0; }
        .sidebar ul { list-style: none; }
        .sidebar li a { display: block; padding: 12px 20px; text-decoration: none; color: #555; font-size: 15px; font-weight: 500; }
        .sidebar li a:hover, .sidebar li a.active { background-color: #d1d1d1; color: #000; font-weight: bold; }

        /* 후기 메인 콘텐츠 */
        .main-content { flex: 1; min-width: 0; }
        
        /* 탭 메뉴 스타일 */
        .review-tabs { display: flex; gap: 10px; margin-bottom: 20px; }
        .tab-btn { background-color: #e2e2e2; border: 1px solid #ccc; padding: 10px 20px; border-radius: 4px; font-size: 14px; font-weight: bold; cursor: pointer; color: #555; }
        .tab-btn.active { background-color: #333; color: #fff; border-color: #333; }

        /* 후기 리스트 */
        .review-list { display: flex; flex-direction: column; gap: 15px; }
        .review-section { display: none; }
        .review-section.active { display: flex; flex-direction: column; gap: 15px; }

        .review-item { background-color: #e2e2e2; padding: 20px; border-radius: 6px; }
        .review-header { display: flex; align-items: center; gap: 15px; margin-bottom: 10px; font-size: 14px; font-weight: bold; }
        .rating { color: #f39c12; }
        .nickname { color: #333; }
        .time { margin-left: auto; color: #777; font-size: 12px; font-weight: normal; }
        .review-body p { font-size: 14px; color: #444; line-height: 1.4; }
        
        .no-data { background-color: #e2e2e2; padding: 40px; text-align: center; border-radius: 6px; color: #777; font-size: 14px; }
    </style>
</head>
<body>

    <!-- 공통 헤더 포함 -->
    <jsp:include page="/WEB-INF/views/common/header.jsp" />

    <div class="container">
        <!-- 상단 프로필 영역 -->
        <div class="profile-area">
            <div class="profile-info">
                <div class="profile-img">IMG</div>
                <div class="profile-text">
                    <h2>${sessionScope.loginUser.nickname}님</h2>
                    <p>${sessionScope.loginUser.email}</p>
                </div>
            </div>
            <div class="profile-right">
                <a href="${pageContext.request.contextPath}/mypage/edit" class="btn-edit">회원 정보 수정</a>
                <a href="${pageContext.request.contextPath}/member/withdraw" class="btn-withdraw">회원 탈퇴</a>
            </div>
        </div>

        <!-- 메인 콘텐츠 영역 -->
        <div class="content-area">
            <!-- 사이드바 -->
            <nav class="sidebar">
                <ul>
                    <li><a href="${pageContext.request.contextPath}/mypage/boards">게시글 관리</a></li>
                    <li><a href="${pageContext.request.contextPath}/mypage/comments">댓글 관리</a></li>
                    <li><a href="${pageContext.request.contextPath}/mypage/txHistories">거래 내역</a></li>
                    <li><a href="${pageContext.request.contextPath}/mypage/review/list" class="active">후기</a></li>
                    <li><a href="${pageContext.request.contextPath}/mypage/recent">최근 본 글</a></li>
                </ul>
            </nav>

            <!-- 후기 콘텐츠 영역 -->
            <main class="main-content">
                <!-- 탭 메뉴 -->
                <div class="review-tabs">
                    <button class="tab-btn active" onclick="switchTab('received', event)">받은 후기</button>
                    <button class="tab-btn" onclick="switchTab('sent', event)">보낸 후기</button>
                </div>

                <!-- 1. 받은 후기 섹션 -->
                <div id="receivedSection" class="review-section active">
                    <c:choose>
                        <c:when test="${not empty receivedReviews}">
                            <c:forEach var="r" items="${receivedReviews}">
                                <div class="review-item">
                                    <div class="review-header">
                                        <span class="rating">⭐ ${r.rating}</span>
                                        <span class="nickname">${r.reviewerNickname}</span>
                                        <span class="time">${r.createdAtStr}</span>
                                    </div>
                                    <div class="review-body">
                                        <p>${r.content}</p>
                                    </div>
                                </div>
                            </c:forEach>
                        </c:when>
                        <c:otherwise>
                            <div class="no-data">받은 후기가 없습니다.</div>
                        </c:otherwise>
                    </c:choose>
                </div>

                <!-- 2. 보낸 후기 섹션 -->
                <div id="sentSection" class="review-section">
                    <c:choose>
                        <c:when test="${not empty sentReviews}">
                            <c:forEach var="r" items="${sentReviews}">
                                <div class="review-item">
                                    <div class="review-header">
                                        <span class="rating">⭐ ${r.rating}</span>
                                        <span class="nickname">${r.revieweeNickname}</span>
                                        <span class="time">${r.createdAtStr}</span>
                                    </div>
                                    <div class="review-body">
                                        <p>${r.content}</p>
                                    </div>
                                </div>
                            </c:forEach>
                        </c:when>
                        <c:otherwise>
                            <div class="no-data">보낸 후기가 없습니다.</div>
                        </c:otherwise>
                    </c:choose>
                </div>
            </main>
        </div>
    </div>

    <!-- 공통 푸터 포함 -->
    <jsp:include page="/WEB-INF/views/common/footer.jsp" />

    <script>
        // 받은 후기 / 보낸 후기 탭 전환 함수
        function switchTab(type, event) {
            // 버튼 활성화 클래스 변경
            document.querySelectorAll('.tab-btn').forEach(btn => btn.classList.remove('active'));
            event.target.classList.add('active');

            // 섹션 보이기/숨기기
            document.querySelectorAll('.review-section').forEach(section => section.classList.remove('active'));
            if (type === 'received') {
                document.getElementById('receivedSection').classList.add('active');
            } else if (type === 'sent') {
                document.getElementById('sentSection').classList.add('active');
            }
        }
    </script>
</body>
</html>