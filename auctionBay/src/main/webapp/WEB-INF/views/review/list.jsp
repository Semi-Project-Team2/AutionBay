<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>마이페이지 - 후기</title>
</head>
<body>

    <!-- 공통 헤더 포함 -->
<jsp:include page="/WEB-INF/views/common/header.jsp" />

    <div class="container">
        <!-- 상단 프로필 영역 -->
        <div class="profile-area">
            <div class="profile-info">
                <div class="profile-img">img</div>
                <div class="profile-text">
                    <h2>닉네임</h2>
                    <p>example@email.com</p>
                </div>
            </div>
            <div class="profile-right">
                <button class="btn-edit">회원 정보 수정</button>
                <a href="#" class="btn-withdraw">회원 탈퇴</a>
            </div>
        </div>

        <!-- 메인 콘텐츠 영역 -->
        <div class="content-area">
            <!-- 사이드바 -->
            <nav class="sidebar">
                <ul>
                    <li><a href="#">게시글 관리</a></li>
                    <li><a href="#">댓글 관리</a></li>
                    <li><a href="#">거래 내역</a></li>
                    <li><a href="#" class="active">후기</a></li>
                    <li><a href="#">최근 본 글</a></li>
                </ul>
            </nav>

            <!-- 후기 콘텐츠 영역 -->
            <main class="main-content">
                <!-- 탭 메뉴 -->
                <div class="review-tabs">
                    <button class="tab-btn active">받은 후기</button>
                    <button class="tab-btn">보낸 후기</button>
                </div>

                <!-- 후기 리스트 -->
                <div class="review-list">
                    <div class="review-item">
                        <div class="review-header">
                            <span class="rating">평점</span>
                            <span class="nickname">닉네임</span>
                            <span class="time">시간</span>
                        </div>
                        <div class="review-body">
                            <p>내용</p>
                        </div>
                    </div>

                    <div class="review-item">
                        <div class="review-header">
                            <span class="rating">평점</span>
                            <span class="nickname">닉네임</span>
                            <span class="time">시간</span>
                        </div>
                        <div class="review-body">
                            <p>내용</p>
                        </div>
                    </div>

                    <div class="review-item">
                        <div class="review-header">
                            <span class="rating">평점</span>
                            <span class="nickname">닉네임</span>
                            <span class="time">시간</span>
                        </div>
                        <div class="review-body">
                            <p>내용</p>
                        </div>
                    </div>
                </div>
            </main>
        </div>
    </div>

    <!-- 공통 푸터 포함 -->
    <jsp:include page="common/footer.jsp" />

</body>
</html>