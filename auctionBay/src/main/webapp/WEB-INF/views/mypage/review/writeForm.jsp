<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>거래 후기 작성</title>
    <!-- 외부 CSS 연결 -->
    <link rel="stylesheet" href="/css/mypage/review.css">
</head>
<body>

    <div class="popup-container">
        <!-- 상단 타이틀 및 거래 정보 영역 -->
        <div class="popup-header">
            <h2>거래 후기 작성</h2>
            <div class="trade-info-box">
                <div class="popup-title">${txHistory.title}</div>
                <div class="popup-nickname">${txHistory.partnerNickname}</div>
            </div>
        </div>

        <!-- 후기 입력 폼 -->
        <form id="review-form" 
            action="${pageContext.request.contextPath}/mypage/review/writeForm" 
            method="post" class="popup-form">
            
            <!-- Hidden 데이터 전달 영역 -->
            <input type="hidden" name="historyId" value="${txHistory.historyId}">
            <input type="hidden" name="productId" value="${txHistory.productId}">

            <!-- 평점 입력 영역 (0~10점 / 0.5개 단위 지원) -->
            <div class="form-group">
                <label>평점</label>
                <div class="star-rating-box">
                    <div class="stars" id="star-container">
                        <!-- 각 별은 left(0.5점), right(1.0점) 영역을 가집니다 -->
                        <span class="star" data-value="1"><span class="half left" data-val="1"></span><span class="half right" data-val="2"></span>★</span>
                        <span class="star" data-value="2"><span class="half left" data-val="3"></span><span class="half right" data-val="4"></span>★</span>
                        <span class="star" data-value="3"><span class="half left" data-val="5"></span><span class="half right" data-val="6"></span>★</span>
                        <span class="star" data-value="4"><span class="half left" data-val="7"></span><span class="half right" data-val="8"></span>★</span>
                        <span class="star" data-value="5"><span class="half left" data-val="9"></span><span class="half right" data-val="10"></span>★</span>
                    </div>
                    <!-- 서버로 넘어갈 실제 평점 값 (1~10) -->
                    <input type="hidden" id="rating" name="rating" value="" required>
                    <span class="rating-text"><b id="rating-count">0</b> / 10점</span>
                </div>
            </div>

            <!-- 내용 입력 영역 -->
            <div class="form-group">
                <label for="content">내용</label>
                <textarea id="content" name="content" rows="6" placeholder="상세 설명을 입력해주세요.
- 거래 흐름
- 상품 상태
- 만족도 " maxlength="100"></textarea>
            </div>

            <!-- 작성 완료 버튼 -->
            <div class="form-actions">
                <button type="submit" class="btn-submit">작성 완료</button>
            </div>

        </form>
    </div>

    <!-- js 파일 연결 -->
    <script src="/js/txHistory.js"></script>
</body>
</html>