<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>

<head> 
    <meta charset="UTF-8">
    <title>게시글 작성</title>
    <link rel="stylesheet" href="/css/productWrite.css">
    <style>
        /* 글자 수 표시 영역 스타일 */
        .char-count-wrapper {
            position: relative;
            width: 100%;
        }
        .char-count {
            position: absolute;
            right: 10px;
            bottom: 5px;
            font-size: 12px;
            color: #999;
            pointer-events: none; /* 클릭 방지 */
        }
        textarea.with-count {
            padding-bottom: 25px; /* 카운트 영역 확보 */
        }
        input.with-count {
            padding-right: 60px; /* 카운트 영역 확보 */
        }
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
                            <input type="text" id="title" name="title" class="with-count" placeholder="상품명을 입력해주세요 (최대 20자)" required maxlength="20">
                            <span class="char-count" id="titleCount">(0/20)</span>
                        </div>
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
                            <option value="NEW">미개봉</option>
                            <option value="LIKE_NEW">거의 새것</option>
                            <option value="USED">사용감 있음</option>
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

                    <!-- 설명 (500자 제한) -->
                    <div class="form-row">
                        <label for="description">상품설명</label>
                        <div class="char-count-wrapper">
                            <textarea id="description" name="description" class="with-count" placeholder="상품에 대한 설명을 입력해주세요 (최대 500자)" required maxlength="500"></textarea>
                            <span class="char-count" id="descriptionCount">(0/500)</span>
                        </div>
                    </div>

                    <!-- 거래 방식 -->
                    <div class="form-row">
                        <label for="isDirect">거래방식</label>
                        <select id="isDirect" name="isDirect">
                            <option value="0">택배</option>
                            <option value="1">직거래</option>
                        </select>
                    </div>

                    <!-- 거래 장소 (20자 제한) -->
                    <div class="form-row" id="locationArea">
                        <label for="tradeLocation">거래장소</label>
                        <div class="char-count-wrapper">
                            <input type="text" id="tradeLocation" name="tradeLocation" class="with-count" placeholder="거래 장소를 입력해주세요 (최대 20자)" maxlength="20">
                            <span class="char-count" id="tradeLocationCount">(0/20)</span>
                        </div>
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
		// 페이지 로드 완료 후 모든 스크립트 실행
		document.addEventListener('DOMContentLoaded', function() {
		        
        // --- 기존 기능 구현부 ---
        let currentTradeType = "BUY";
        let selectedFiles = new DataTransfer();
        let currentMediaIndex = 0;

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

        // --- [수정] 거래 방식 변경 시 UI를 제어하는 함수 (판매/구매 탭용) ---
        function toggleLocationInput() {
            // 경매 탭이 아닐 때만 현재 선택 값에 따라 주소 입력란 제어
            if (currentTradeType !== "AUCTION") {
                if (isDirectSelect.value === "1") { // 직거래 선택 시
                    locationArea.style.display = "flex";
                    tradeLocationInput.required = true;
                } else { // 택배 선택 시
                    locationArea.style.display = "none";
                    tradeLocationInput.required = false;
                    tradeLocationInput.value = ""; // 값 초기화
                }
            }
        }

        // 거래 방식 셀렉트 박스에 이벤트 리스너 등록
        isDirectSelect.addEventListener("change", toggleLocationInput);

        window.changeTradeType = function(type) {
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

            // --- [수정] 각 탭별 거래 방식 제어 로직 ---
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

                // [구매] 거래 방식: 변경 가능, 현재 선택 상태 반영
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

                // [판매] 거래 방식: 변경 가능, 현재 선택 상태 반영
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

                // --- [핵심 수정] 경매 탭: 택배로 고정 ---
                isDirectSelect.value = "0";       // 1. 값 강제 설정 (택배)
                isDirectSelect.disabled = true;   // 2. 비활성화 (사용자 변경 불가)
                
                // 3. 거래 장소 입력란 숨기기 및 초기화
                locationArea.style.display = "none";
                tradeLocationInput.value = "";
                tradeLocationInput.required = false;
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

        window.removeCurrentMedia = function(event) {
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

        window.showPreviousMedia = function(event) {
            event.preventDefault();
            event.stopPropagation();
            if (selectedFiles.files.length === 0) return;

            currentMediaIndex--;
            if (currentMediaIndex < 0) {
                currentMediaIndex = selectedFiles.files.length - 1;
            }
            renderPreview();
        }

        window.showNextMedia = function(event) {
            event.preventDefault();
            event.stopPropagation();
            if (selectedFiles.files.length === 0) return;

            currentMediaIndex++;
            if (currentMediaIndex >= selectedFiles.files.length) {
                currentMediaIndex = 0;
            }
            renderPreview();
        }

        window.checkFirstMedia = function() {
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

        window.temporarySave = function() {
            alert("임시저장 기능은 준비 중입니다.");
        }

        // 경매 마감시간 유효성 검사
        document.getElementById("auctionEndTime").addEventListener("change", function() {
            if (!this.value) return;
            const selectedTime = new Date(this.value);
            if (selectedTime <= new Date()) {
                alert("경매 마감시간은 현재 시간 이후로 선택해주세요.");
                this.value = "";
            }
        });

        // 폼 제출 시 최종 검사
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

        // --- [신규] 글자 수 제한 실시간 표시 기능 ---
        // 대상 필드 설정: [입력요소ID, 카운터표시ID, 최대길이]
        const limitConfigs = [
            ['title', 'titleCount', 20],            // 상품명: 20자
            ['description', 'descriptionCount', 500], // 상세설명: 500자
            ['tradeLocation', 'tradeLocationCount', 20] // 거래장소: 20자
        ];

        limitConfigs.forEach(function(config) {
            const inputElement = document.getElementById(config[0]);
            const counterElement = document.getElementById(config[1]);
            const maxLength = config[2];

            if (inputElement && counterElement) {
                // 1. 초기 로드 시 카운터 업데이트
                updateCounterDisplay(inputElement, counterElement, maxLength);

                // 2. 입력(input) 이벤트 리스너 등록 (실시간 반영)
                inputElement.addEventListener('input', function() {
                    // maxlength를 초과하여 입력되는 경우 방지 (HTML maxlength 속성이 작동하지만 안전장치)
                    if (this.value.length > maxLength) {
                        this.value = this.value.substring(0, maxLength);
                    }
                    updateCounterDisplay(this, counterElement, maxLength);
                });
            }
        });

        // 카운터 텍스트를 업데이트하는 헬퍼 함수
        function updateCounterDisplay(inputObj, counterObj, limit) {
            const currentLength = inputObj.value.length;
            counterObj.textContent = '(' + currentLength + '/' + limit + ')';
            
            // 제한 근접 시 색상 변경 (옵션: CSS로도 제어 가능)
            if (currentLength >= limit) {
                counterObj.style.color = '#ef4444'; // 경고 색상 (빨강)
                counterObj.style.fontWeight = 'bold';
            } else if (currentLength >= limit * 0.9) {
                counterObj.style.color = '#f59e0b'; // 주의 색상 (주황)
            } else {
                counterObj.style.color = '#999'; // 기본 색상
                counterObj.style.fontWeight = 'normal';
            }
        }
        // -------------------------------------------

        // 초깃값 실행 (페이지 로드 시 '구매' 탭 설정)
        changeTradeType("BUY");
    });
	</script>
</body>
</html>