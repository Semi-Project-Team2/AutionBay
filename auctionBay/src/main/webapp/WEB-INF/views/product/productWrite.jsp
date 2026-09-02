<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>

<head> 
    <meta charset="UTF-8">
    <title>게시글 작성</title>
</head>

<body>

    <!-- 공통 헤더 포함 -->
    <jsp:include page="/WEB-INF/views/common/header.jsp" />

    <div class="container">

        <c:if test="${not empty uploadError}">
            <script>alert("${uploadError}")</script>
        </c:if>
        
        <!-- 페이지 제목 -->
        <div class="page-title">게시글 작성</div>

        <!-- 거래 방식 선택 -->
        <div class="trade-type-area">
            <button type="button" class="trade-button active" id="buyButton" onclick="changeTradeType('BUY')">구매</button>
            <button type="button" class="trade-button" id="sellButton" onclick="changeTradeType('SELL')">판매</button>
            <button type="button" class="trade-button" id="auctionButton" onclick="changeTradeType('AUCTION')">경매</button>
        </div>

        <!-- 게시글 작성 Form -->
        <form id="productForm" action="${pageContext.request.contextPath}/product/write" method="post" enctype="multipart/form-data">

            <input type="hidden" name="tradeType" id="tradeType" value="BUY">

            <div class="write-area">

                <!-- 이미지 영역 (정사각형 fixed) -->
                <div class="image-area">
                    <label for="imageInput" style="width: 100%;">
                        <div class="image-box">
                            <span id="imagePlaceholder">사진/동영상 등록</span>
                            <div id="imagePreview"></div>
                            
                            <div id="mediaOrderBadge" class="media-badge" style="display: none;">1 / 5</div>
                            <button type="button" id="currentMediaDeleteBtn" class="media-delete-btn" onclick="removeCurrentMedia(event)" style="display: none;">×</button>
                        </div>
                    </label>
                    
                    <input type="file" id="imageInput" name="images" multiple accept="image/*, video/*">

                    <div class="media-navigation">
                        <button type="button" id="prevMedia" class="media-button" onclick="showPreviousMedia(event)">‹</button>
                        <div class="image-count" id="imageCount">(0/5)</div>
                        <button type="button" id="nextMedia" class="media-button" onclick="showNextMedia(event)">›</button>
                    </div>
                    
                    <button type="button" class="media-add-btn" onclick="document.getElementById('imageInput').click();">
                        사진/동영상 추가
                    </button>
                </div>

                <!-- 입력 영역 -->
                <div class="form-area">

                    <!-- 상품명 -->
                    <div class="form-row">
                        <label for="title">상품명</label>
                        <input type="text" id="title" name="title" placeholder="상품명을 입력해주세요" required>
                    </div>

                    <!-- 카테고리 -->
                    <div class="form-row">
                        <label for="categoryId">카테고리</label>
                        <select id="categoryId" name="categoryId" required>
                            <option value="">카테고리 선택</option>
                            <c:forEach var="category" items="${categoryList}">
                                <option value="${category.categoryId}">${category.categoryName}</option>
                            </c:forEach>
                        </select>
                    </div>

                    <!-- 상품 상태 (판매/경매 전용) -->
                    <div class="form-row" id="conditionArea">
                        <label for="productCondition">상품상태</label>
                        <select id="productCondition" name="productCondition">
                            <option value="">선택해주세요</option>
                            <option value="NEW">새상품</option>
                            <option value="LIKE_NEW">미개봉</option>
                            <option value="USED">개봉</option>
                        </select>
                    </div>

                    <!-- 가격 (구매/판매 전용) -->
                    <div class="form-row" id="priceArea">
                        <label for="price">희망가격</label>
                        <input type="number" id="price" name="price" min="0" placeholder="가격을 입력해주세요">
                    </div>

                    <!-- 경매 시작 가격 (경매 전용) -->
                    <div class="form-row" id="auctionPriceArea">
                        <label for="auctionStartPrice">시작가격</label>
                        <input type="number" id="auctionStartPrice" name="auctionStartPrice" min="0" placeholder="경매 시작 가격">
                    </div>

                    <!-- 경매 마감시간 (경매 전용) -->
                    <div class="form-row" id="auctionEndArea">
                        <label for="auctionEndTime">마감시간</label>
                        <input type="datetime-local" id="auctionEndTime" name="auctionEndTime">
                    </div>

                    <!-- 설명 -->
                    <div class="form-row">
                        <label for="description">상품설명</label>
                        <textarea id="description" name="description" placeholder="상품에 대한 설명을 입력해주세요" required></textarea>
                    </div>

                    <!-- 거래 방식 -->
                    <div class="form-row">
                        <label for="isDirect">거래방식</label>
                        <select id="isDirect" name="isDirect">
                            <option value="0">택배</option>
                            <option value="1">직거래</option>
                        </select>
                    </div>

                    <!-- 거래 장소 -->
                    <div class="form-row" id="locationArea">
                        <label for="tradeLocation">거래장소</label>
                        <input type="text" id="tradeLocation" name="tradeLocation" placeholder="거래 장소를 입력해주세요">
                    </div>

                </div>

            </div>

            <!-- 하단 버튼 -->
            <div class="button-area">
                <button type="button" class="btn-temp-save" onclick="temporarySave()">임시저장</button>
                <button type="submit" class="btn-submit" onclick="return checkFirstMedia();">등록하기</button>
            </div>

        </form>

    </div>

    <script>
    let currentTradeType = "BUY";
    let selectedFiles = new DataTransfer();
    let currentMediaIndex = 0;

    const imageInput = document.getElementById("imageInput");
    const imagePreview = document.getElementById("imagePreview");
    const imagePlaceholder = document.getElementById("imagePlaceholder");
    const imageCount = document.getElementById("imageCount");
    const currentMediaDeleteBtn = document.getElementById("currentMediaDeleteBtn");
    const mediaOrderBadge = document.getElementById("mediaOrderBadge");

    function changeTradeType(type) {
        currentTradeType = type;
        document.getElementById("tradeType").value = type;

        // 버튼 Active 토글
        document.getElementById("buyButton").classList.toggle("active", type === "BUY");
        document.getElementById("sellButton").classList.toggle("active", type === "SELL");
        document.getElementById("auctionButton").classList.toggle("active", type === "AUCTION");

        const priceArea = document.getElementById("priceArea");
        const conditionArea = document.getElementById("conditionArea");
        const auctionPriceArea = document.getElementById("auctionPriceArea");
        const auctionEndArea = document.getElementById("auctionEndArea");

        const price = document.getElementById("price");
        const productCondition = document.getElementById("productCondition");
        const auctionStartPrice = document.getElementById("auctionStartPrice");
        const auctionEndTime = document.getElementById("auctionEndTime");

        if (type === "BUY") {
            priceArea.style.display = "flex";
            conditionArea.style.display = "none";
            auctionPriceArea.style.display = "none";
            auctionEndArea.style.display = "none";

            price.required = true;
            productCondition.required = false;
            auctionStartPrice.required = false;
            auctionEndTime.required = false;

        } else if (type === "SELL") {
            priceArea.style.display = "flex";
            conditionArea.style.display = "flex";
            auctionPriceArea.style.display = "none";
            auctionEndArea.style.display = "none";

            price.required = true;
            productCondition.required = true;
            auctionStartPrice.required = false;
            auctionEndTime.required = false;

        } else if (type === "AUCTION") {
            priceArea.style.display = "none";
            conditionArea.style.display = "flex";
            auctionPriceArea.style.display = "flex";
            auctionEndArea.style.display = "flex";

            price.required = false;
            productCondition.required = true;
            auctionStartPrice.required = true;
            auctionEndTime.required = true;
        }
    }

    imageInput.addEventListener("change", function () {
        Array.from(this.files).forEach(function(file) {
            const alreadyExists = Array.from(selectedFiles.files).some(function(existingFile) {
                return existingFile.name === file.name
                    && existingFile.size === file.size
                    && existingFile.lastModified === file.lastModified;
            });

            if (!alreadyExists) {
                selectedFiles.items.add(file);
            }
        });

        if (selectedFiles.files.length > 5) {
            alert("이미지와 동영상은 최대 5개까지 등록할 수 있습니다.");
            const newDataTransfer = new DataTransfer();
            Array.from(selectedFiles.files).slice(0, 5).forEach(function(file) {
                newDataTransfer.items.add(file);
            });
            selectedFiles = newDataTransfer;
        }

        imageInput.files = selectedFiles.files;
        renderPreview();
    });

    function renderPreview() {
        imagePreview.innerHTML = "";

        if (selectedFiles.files.length === 0) {
            imagePlaceholder.style.display = "block";
            currentMediaDeleteBtn.style.display = "none";
            mediaOrderBadge.style.display = "none";
            imageCount.innerText = "(0/5)";
            return;
        }

        imagePlaceholder.style.display = "none";
        currentMediaDeleteBtn.style.display = "flex";
        mediaOrderBadge.style.display = "block";

        if (currentMediaIndex >= selectedFiles.files.length) {
            currentMediaIndex = selectedFiles.files.length - 1;
        }

        const file = selectedFiles.files[currentMediaIndex];
        const url = URL.createObjectURL(file);

        if (file.type.startsWith("image/")) {
            const img = document.createElement("img");
            img.src = url;
            imagePreview.appendChild(img);
        } else if (file.type.startsWith("video/")) {
            const video = document.createElement("video");
            video.src = url;
            video.controls = true;
            imagePreview.appendChild(video);
        }

        mediaOrderBadge.innerText = (currentMediaIndex + 1) + " / " + selectedFiles.files.length;
        imageCount.innerText = "(" + selectedFiles.files.length + "/5)";
    }

    function removeCurrentMedia(event) {
        event.preventDefault();
        event.stopPropagation();

        if (selectedFiles.files.length === 0) return;

        const newDataTransfer = new DataTransfer();
        const files = selectedFiles.files;

        for (let i = 0; i < files.length; i++) {
            if (i !== currentMediaIndex) {
                newDataTransfer.items.add(files[i]);
            }
        }

        selectedFiles = newDataTransfer;
        imageInput.files = selectedFiles.files;

        if (currentMediaIndex >= selectedFiles.files.length && currentMediaIndex > 0) {
            currentMediaIndex--;
        }

        renderPreview();
    }

    function showPreviousMedia(event) {
        event.preventDefault();
        event.stopPropagation();
        if (selectedFiles.files.length === 0) return;

        currentMediaIndex--;
        if (currentMediaIndex < 0) {
            currentMediaIndex = selectedFiles.files.length - 1;
        }
        renderPreview();
    }

    function showNextMedia(event) {
        event.preventDefault();
        event.stopPropagation();
        if (selectedFiles.files.length === 0) return;

        currentMediaIndex++;
        if (currentMediaIndex >= selectedFiles.files.length) {
            currentMediaIndex = 0;
        }
        renderPreview();
    }

    function checkFirstMedia() {
        if (selectedFiles.files.length === 0) return true;
        const firstFile = selectedFiles.files[0];

        if (firstFile.type.startsWith("video/")) {
            return confirm(
                "첫 번째 등록 미디어가 동영상입니다.\n" +
                "목록 화면에서는 기본 이미지로 표시됩니다.\n\n" +
                "등록하시겠습니까?"
            );
        }
        return true;
    }

    function temporarySave() {
        alert("임시저장 기능은 준비 중입니다.");
    }

    document.getElementById("auctionEndTime").addEventListener("change", function() {
        if (!this.value) return;
        const selectedTime = new Date(this.value);
        if (selectedTime <= new Date()) {
            alert("경매 마감시간은 현재 시간 이후로 선택해주세요.");
            this.value = "";
        }
    });

    document.getElementById("productForm").addEventListener("submit", function(e) {
        if (currentTradeType === "AUCTION") {
            const auctionEndTime = document.getElementById("auctionEndTime");
            if (!auctionEndTime.value) {
                alert("경매 마감시간을 선택해주세요.");
                e.preventDefault();
                return;
            }

            if (new Date(auctionEndTime.value) <= new Date()) {
                alert("경매 마감시간은 현재 시간 이후로 설정해주세요.");
                auctionEndTime.value = "";
                e.preventDefault();
                return;
            }
        }
    });

    // 초깃값 실행
    changeTradeType("BUY");
    </script>
</body>
</html>