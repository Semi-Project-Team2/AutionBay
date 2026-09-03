<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>

<head> 
    <meta charset="UTF-8">
    <title>일반 게시글 수정</title>
    <link rel="stylesheet" href="/css/productWrite.css">
    <style>

    </style>
</head>

<body>

    <!-- 공통 헤더 포함 -->
    <jsp:include page="/WEB-INF/views/common/header.jsp" />

    <div class="container">

        <c:if test="${not empty uploadError}">
            <script>alert("${uploadError}")</script>
        </c:if>
        
        <!-- 페이지 제목 -->
        <div class="page-title">일반 게시글 수정</div>

        <!-- 거래 방식 선택 -->
        <div class="trade-type-area">
            <button type="button" class="trade-button ${product.tradeType == 'BUY' ? 'active' : ''}" id="buyButton" onclick="changeTradeType('BUY')">구매</button>
            <button type="button" class="trade-button ${product.tradeType == 'SELL' ? 'active' : ''}" id="sellButton" onclick="changeTradeType('SELL')">판매</button>
        </div>

        <!-- 일반 게시글 수정 Form -->
        <form id="productForm" action="${pageContext.request.contextPath}/board/${product.productId}/update" method="post" enctype="multipart/form-data">

            <input type="hidden" name="tradeType" id="tradeType" value="${not empty product.tradeType ? product.tradeType : 'BUY'}">
            
            <!-- 작성자 고유 번호 -->
            <input type="hidden" name="writerNo" id="writerNo" value="${product.writerNo}">

            <!-- 삭제된 기존 미디어의 ID를 담을 숨김 필드 -->
            <input type="hidden" name="deletedMediaIds" id="deletedMediaIds" value="">

            <div class="write-area">

                <!-- 이미지 영역 -->
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

                    <!-- 상품명 (20자 제한) -->
                    <div class="form-row">
                        <label for="title">상품명</label>
                        <div class="char-count-wrapper">
                            <input type="text" id="title" name="title" class="with-count" value="${product.title}" placeholder="상품명을 입력해주세요 (최대 20자)" required maxlength="20">
                            <span class="char-count" id="titleCount">(0/20)</span>
                        </div>
                    </div>

                    <!-- 카테고리 -->
                    <div class="form-row">
                        <label for="categoryId">카테고리</label>
                        <select id="categoryId" name="categoryId" required>
                            <option value="">카테고리 선택</option>
                            <c:forEach var="category" items="${categoryList}">
                                <option value="${category.categoryId}" ${product.categoryId == category.categoryId ? 'selected' : ''}>
                                    ${category.categoryName}
                                </option>
                            </c:forEach>
                        </select>
                    </div>

                    <!-- 상품 상태 (판매/경매 전용) -->
                    <div class="form-row" id="conditionArea">
                        <label for="productCondition">상품상태</label>
                        <select id="productCondition" name="productCondition">
                            <option value="">선택해주세요</option>
                            <option value="NEW" ${product.productCondition == 'NEW' ? 'selected' : ''}>미개봉</option>
                            <option value="LIKE_NEW" ${product.productCondition == 'LIKE_NEW' ? 'selected' : ''}>거의 새것</option>
                            <option value="USED" ${product.productCondition == 'USED' ? 'selected' : ''}>사용감 있음</option>
                        </select>
                    </div>

                    <!-- 가격 (구매/판매 전용) -->
                    <div class="form-row" id="priceArea">
                        <label for="price">희망가격</label>
                        <input type="number" id="price" name="price" value="${product.price}" min="0" placeholder="가격을 입력해주세요">
                    </div>

                    <!-- 설명 (500자 제한) -->
                    <div class="form-row">
                        <label for="description">상품설명</label>
                        <div class="char-count-wrapper">
                            <textarea id="description" name="description" class="with-count" placeholder="상품에 대한 설명을 입력해주세요 (최대 500자)" required maxlength="500">${product.description}</textarea>
                            <span class="char-count" id="descriptionCount">(0/500)</span>
                        </div>
                    </div>

                    <!-- 거래 방식 -->
                    <div class="form-row">
                        <label for="isDirect">거래방식</label>
                        <select id="isDirect" name="isDirect">
                            <option value="0" ${product.isDirect == 0 ? 'selected' : ''}>택배</option>
                            <option value="1" ${product.isDirect == 1 ? 'selected' : ''}>직거래</option>
                        </select>
                    </div>

                    <!-- 거래 장소 (20자 제한) -->
                    <div class="form-row" id="locationArea">
                        <label for="tradeLocation">거래장소</label>
                        <div class="char-count-wrapper">
                            <input type="text" id="tradeLocation" name="tradeLocation" class="with-count" value="${product.tradeLocation}" placeholder="거래 장소를 입력해주세요 (최대 20자)" maxlength="20">
                            <span class="char-count" id="tradeLocationCount">(0/20)</span>
                        </div>
                    </div>

                </div>

            </div>

            <!-- 하단 버튼 -->
            <div class="button-area">
                <button type="button" class="btn-temp-save" onclick="location.href='${pageContext.request.contextPath}/board/${product.productId}/detail'">취소</button>
                <button type="submit" class="btn-submit" onclick="return checkFirstMedia();">수정하기</button>
            </div>

        </form>

    </div>

    <script>
        document.addEventListener('DOMContentLoaded', function() {
            // 서버에서 가져온 기존 미디어 목록을 JS 배열로 변환
            const existingMediaList = [
                <c:forEach var="media" items="${product.mediaList}" varStatus="status">
                    {
                        mediaId: "${media.mediaId}",
                        mediaUrl: "${pageContext.request.contextPath}${media.mediaUrl}",
                        mediaType: "${media.mediaType}"
                    }${!status.last ? ',' : ''}
                </c:forEach>
            ];

            let mediaItems = [];
            let currentMediaIndex = 0;
            let deletedMediaIdList = [];

            if (existingMediaList && existingMediaList.length > 0) {
                mediaItems = existingMediaList.map(item => ({
                    mediaId: item.mediaId,
                    url: item.mediaUrl,
                    type: item.mediaType,
                    file: null
                }));
            }

            let currentTradeType = document.getElementById("tradeType").value || "BUY";

            const imageInput = document.getElementById("imageInput");
            const imagePreview = document.getElementById("imagePreview");
            const imagePlaceholder = document.getElementById("imagePlaceholder");
            const imageCount = document.getElementById("imageCount");
            const currentMediaDeleteBtn = document.getElementById("currentMediaDeleteBtn");
            const mediaOrderBadge = document.getElementById("mediaOrderBadge");

            // 거래 방식 관련 요소 가져오기
            const isDirectSelect = document.getElementById("isDirect");
            const locationArea = document.getElementById("locationArea");
            const tradeLocationInput = document.getElementById("tradeLocation");

            function toggleLocationInput() {
                if (currentTradeType !== "AUCTION") {
                    if (isDirectSelect.value === "1") {
                        locationArea.style.display = "flex";
                        tradeLocationInput.required = true;
                    } else {
                        locationArea.style.display = "none";
                        tradeLocationInput.required = false;
                        tradeLocationInput.value = "";
                    }
                }
            }

            isDirectSelect.addEventListener("change", toggleLocationInput);

            window.changeTradeType = function(type) {
                currentTradeType = type;
                document.getElementById("tradeType").value = type;

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

                    productCondition.value = "USED";
                    
                    price.required = true;
                    productCondition.required = false;
                    auctionStartPrice.required = false;
                    auctionEndTime.required = false;

                    isDirectSelect.disabled = false;
                    toggleLocationInput(); 

                } else if (type === "SELL") {
                    priceArea.style.display = "flex";
                    conditionArea.style.display = "flex";
                    auctionPriceArea.style.display = "none";
                    auctionEndArea.style.display = "none";

                    price.required = true;
                    productCondition.required = true;
                    auctionStartPrice.required = false;
                    auctionEndTime.required = false;

                    isDirectSelect.disabled = false;
                    toggleLocationInput(); 

                } else if (type === "AUCTION") {
                    priceArea.style.display = "none";
                    conditionArea.style.display = "flex";
                    auctionPriceArea.style.display = "flex";
                    auctionEndArea.style.display = "flex";

                    price.required = false;
                    productCondition.required = true;
                    auctionStartPrice.required = true;
                    auctionEndTime.required = true;

                    isDirectSelect.value = "0";
                    isDirectSelect.disabled = true;
                    
                    locationArea.style.display = "none";
                    tradeLocationInput.value = "";
                    tradeLocationInput.required = false;
                }
            }

            imageInput.addEventListener("change", function () {
                Array.from(this.files).forEach(function(file) {
                    const alreadyExists = mediaItems.some(function(item) {
                        return item.file && 
                            item.file.name === file.name && 
                            item.file.size === file.size && 
                            item.file.lastModified === file.lastModified;
                    });

                    if (!alreadyExists) {
                        const url = URL.createObjectURL(file);
                        const type = file.type.startsWith("video/") ? "VIDEO" : "IMAGE";

                        mediaItems.push({
                            mediaId: null,
                            url: url,
                            type: type,
                            file: file
                        });
                    }
                });

                if (mediaItems.length > 5) {
                    alert("이미지와 동영상은 최대 5개까지 등록할 수 있습니다.");
                    mediaItems = mediaItems.slice(0, 5);
                }

                updateInputFiles();
                renderPreview();
            });

            function updateInputFiles() {
                const dataTransfer = new DataTransfer();
                mediaItems.forEach(item => {
                    if (item.file) {
                        dataTransfer.items.add(item.file);
                    }
                });
                imageInput.files = dataTransfer.files;
            }

            function renderPreview() {
                imagePreview.innerHTML = "";

                if (mediaItems.length === 0) {
                    imagePlaceholder.style.display = "block";
                    currentMediaDeleteBtn.style.display = "none";
                    mediaOrderBadge.style.display = "none";
                    imageCount.innerText = "(0/5)";
                    return;
                }

                imagePlaceholder.style.display = "none";
                currentMediaDeleteBtn.style.display = "flex";
                mediaOrderBadge.style.display = "block";

                if (currentMediaIndex >= mediaItems.length) {
                    currentMediaIndex = mediaItems.length - 1;
                }

                const currentMedia = mediaItems[currentMediaIndex];

                if (currentMedia.type === "VIDEO" || currentMedia.type.startsWith("video/")) {
                    const video = document.createElement("video");
                    video.src = currentMedia.url;
                    video.controls = true;
                    imagePreview.appendChild(video);
                } else {
                    const img = document.createElement("img");
                    img.src = currentMedia.url;
                    imagePreview.appendChild(img);
                }

                mediaOrderBadge.innerText = (currentMediaIndex + 1) + " / " + mediaItems.length;
                imageCount.innerText = "(" + mediaItems.length + "/5)";
            }
            
            window.removeCurrentMedia = function(event) {
                event.preventDefault();
                event.stopPropagation();

                if (mediaItems.length === 0) return;

                const targetMedia = mediaItems[currentMediaIndex];

                if (targetMedia.mediaId) {
                    deletedMediaIdList.push(targetMedia.mediaId);
                    document.getElementById("deletedMediaIds").value = deletedMediaIdList.join(",");
                }

                mediaItems.splice(currentMediaIndex, 1);
                updateInputFiles();

                if (currentMediaIndex >= mediaItems.length && currentMediaIndex > 0) {
                    currentMediaIndex--;
                }

                renderPreview();
            }

            window.showPreviousMedia = function(event) {
                event.preventDefault();
                event.stopPropagation();
                if (mediaItems.length === 0) return;

                currentMediaIndex--;
                if (currentMediaIndex < 0) {
                    currentMediaIndex = mediaItems.length - 1;
                }
                renderPreview();
            }

            window.showNextMedia = function(event) {
                event.preventDefault();
                event.stopPropagation();
                if (mediaItems.length === 0) return;

                currentMediaIndex++;
                if (currentMediaIndex >= mediaItems.length) {
                    currentMediaIndex = 0;
                }
                renderPreview();
            }

            window.checkFirstMedia = function() {
                if (mediaItems.length === 0) return true;
                const firstMedia = mediaItems[0];

                if (firstMedia.type === "VIDEO" || firstMedia.type.startsWith("video/")) {
                    return confirm(
                        "첫 번째 등록 미디어가 동영상입니다.\n" +
                        "목록 화면에서는 기본 이미지로 표시됩니다.\n\n" +
                        "수정하시겠습니까?"
                    );
                }
                return true;
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
                updateInputFiles();

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

            // 글자 수 제한 실시간 표시 기능
            const limitConfigs = [
                ['title', 'titleCount', 20],
                ['description', 'descriptionCount', 500],
                ['tradeLocation', 'tradeLocationCount', 20]
            ];

            limitConfigs.forEach(function(config) {
                const inputElement = document.getElementById(config[0]);
                const counterElement = document.getElementById(config[1]);
                const maxLength = config[2];

                if (inputElement && counterElement) {
                    updateCounterDisplay(inputElement, counterElement, maxLength);

                    inputElement.addEventListener('input', function() {
                        if (this.value.length > maxLength) {
                            this.value = this.value.substring(0, maxLength);
                        }
                        updateCounterDisplay(this, counterElement, maxLength);
                    });
                }
            });

            function updateCounterDisplay(inputObj, counterObj, limit) {
                const currentLength = inputObj.value.length;
                counterObj.textContent = '(' + currentLength + '/' + limit + ')';
                
                if (currentLength >= limit) {
                    counterObj.style.color = '#ef4444';
                    counterObj.style.fontWeight = 'bold';
                } else if (currentLength >= limit * 0.9) {
                    counterObj.style.color = '#f59e0b';
                } else {
                    counterObj.style.color = '#a0aec0';
                    counterObj.style.fontWeight = 'normal';
                }
            }

            // 초기 실행
            changeTradeType(currentTradeType);
            renderPreview();
        });
    </script>
</body>
</html>