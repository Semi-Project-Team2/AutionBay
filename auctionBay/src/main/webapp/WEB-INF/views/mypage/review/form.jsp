<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>거래 후기 작성</title>
</head>
<body>

    <div class="popup-container">
        <!-- 상단 타이틀 및 거래 정보 영역 -->
        <div class="popup-header">
            <h2>거래 후기 작성</h2>
            <div class="trade-info-box">
                <div class="popup-title">TITLE</div>
                <div class="popup-nickname">NICKNAME</div>
            </div>
        </div>

        <!-- 후기 입력 폼 -->
        <form action="reviewWriteProcess.jsp" method="post" class="popup-form">
            
            <!-- Hidden 데이터 전달 영역 (productId, reviewerNo, revieweeNo) -->
            <input type="hidden" name="productId" value="123">
            <input type="hidden" name="reviewerNo" value="1">
            <input type="hidden" name="revieweeNo" value="2">

            <!-- 평점 입력 영역 (드롭박스, 1~10, required) -->
            <div class="form-group">
                <label for="rating">평점</label>
                <select id="rating" name="rating" required>
                    <option value="" disabled selected>평점을 선택하세요</option>
                    <option value="1">1</option>
                    <option value="2">2</option>
                    <option value="3">3</option>
                    <option value="4">4</option>
                    <option value="5">5</option>
                    <option value="6">6</option>
                    <option value="7">7</option>
                    <option value="8">8</option>
                    <option value="9">9</option>
                    <option value="10">10</option>
                </select>
            </div>

            <!-- 내용 입력 영역 (placeholder 지정, required 아님) -->
            <div class="form-group">
                <label for="content">내용</label>
                <textarea id="content" name="content" rows="6" placeholder="내용을 입력하세요. (공백 포함 최대 100자)" maxlength="100"></textarea>
            </div>

            <!-- 작성 완료 버튼 -->
            <div class="form-actions">
                <button type="submit" class="btn-submit">작성 완료</button>
            </div>

        </form>

    </div>

</body>
</html>