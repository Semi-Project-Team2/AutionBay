<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<jsp:include page="/WEB-INF/views/common/header.jsp" />

<div class="write-container">
    <h2 class="page-title">판매 게시글 작성</h2>

    <form action="/product/write" method="post" enctype="multipart/form-data" class="form form-flex">

        <h3>상품 이미지/동영상</h3>
        
        <!-- 이미지 등록 영역 -->
        <div class="form-row">
            <label for="images">이미지는 최대 5장 첨부 가능합니다.</label>
            <input type="file" id="images" name="imageFiles" accept="image/*" multiple>
            <div id="image-preview-list" class="board-image-list"></div>
        </div>
        
        <div class="form-row">
            <label for="title">상품명</label>
            <input type="text" id="title" name="title" required>
        </div>
        
        <div class="form-row">
            <label for="price">상품가격</label>
            <input type="number" id="price" name="price" required>
        </div>
            
        <div class="form-row">
            <label for="productStatus">상품상태</label>
            <select id="productStatus" name="productStatus">
                <option value="NEW">새상품 (미사용)</option>
                <option value="UPPER">상</option>
                <option value="MIDDLE">중</option>
                <option value="LOWER">하</option>
            </select>
        </div>
        
        <div class="form-row">
            <label for="productDescription">상품설명</label>
            <textarea id="productDescription" name="productDescription" rows="10" required></textarea>
        </div>

        <div class="form-row">
            <label for="tradeLocation">직거래 여부</label>
            <select id="tradeLocation" name="tradeLocation" onchange="toggleTradeLocation()">
                <option value="N">불가능</option>
                <option value="Y">가능</option>
            </select>
        </div>

        <!-- 직거래 장소 입력 (초기 숨김) -->
        <div class="form-row" id="tradeLocationGroup" style="display: none;">
            <label for="tradeAddress">직거래 장소</label>
            <input type="text" id="tradeAddress" name="tradeAddress" placeholder="예: 강남역 1번 출구 앞, 00동 주민센터 근처">
        </div>

        <!-- 하단 버튼 영역 -->
        <div class="form-row form-actions" style="margin-top: 20px;">
            <button type="button" class="btn btn-secondary">임시저장</button>
            <button type="submit" class="btn btn-primary">등록하기</button>
        </div>

    </form>
</div>

<!-- 자바스크립트 연동 -->
<script>
    function toggleTradeLocation() {
        const tradeLocationSelect = document.getElementById("tradeLocation").value;
        const tradeLocationGroup = document.getElementById("tradeLocationGroup");
        const tradeAddressInput = document.getElementById("tradeAddress");

        if (tradeLocationSelect === "Y") {
            tradeLocationGroup.style.display = "flex"; // 가능 선택 시 장소 입력창 표시
        } else {
            tradeLocationGroup.style.display = "none"; // 불가능 선택 시 장소 입력창 숨김
            tradeAddressInput.value = "";              // 값 초기화
        }
    }
</script>

<script src="/js/board.js"></script>

<jsp:include page="/WEB-INF/views/common/footer.jsp" />