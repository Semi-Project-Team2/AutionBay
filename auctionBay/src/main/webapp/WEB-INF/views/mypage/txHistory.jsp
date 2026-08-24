<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
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
                <li><a href="#" class="active">거래 내역</a></li>
                <li><a href="#">후기</a></li>
                <li><a href="#">최근 본 글</a></li>
            </ul>
        </nav>

        <!-- 거래 내역 목록 -->
        <main class="main-content">
            <div class="content-header">
                <h3>거래 내역</h3>
                <div class="sub-search">검색창</div>
            </div>

            <div class="trade-list">
                <div class="trade-item">
                    <div class="trade-title">제목</div>
                    <div class="trade-info">
                        <span class="price">가격</span>
                        <span class="divider">|</span>
                        <span class="nickname">닉네임</span>
                        <span class="badge">판매</span>
                    </div>
                </div>

                <div class="trade-item">
                    <div class="trade-title">제목</div>
                    <div class="trade-info">
                        <span class="price">가격</span>
                        <span class="divider">|</span>
                        <span class="nickname">닉네임</span>
                    </div>
                </div>

                <div class="trade-item">
                    <div class="trade-title">제목</div>
                    <div class="trade-info">
                        <span class="price">가격</span>
                        <span class="divider">|</span>
                        <span class="nickname">닉네임</span>
                    </div>
                </div>
            </div>

            <!-- 페이지네이션 -->
            <div class="pagination">
                <a href="#">&lt; 이전</a>
                <a href="#" class="active">1</a>
                <a href="#">2</a>
                <a href="#">3</a>
                <a href="#">4</a>
                <a href="#">5</a>
                <a href="#">다음 &gt;</a>
            </div>
        </main>
    </div>
</div>

<jsp:include page="/WEB-INF/views/common/footer.jsp" />