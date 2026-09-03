<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>

<head> 
    <meta charset="UTF-8">
    <title>일반 게시글 수정</title>
    <link rel="stylesheet" href="/css/productWrite.css">
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

        <!-- 거래 방식 선택 탭 버튼 -->
        <div class="trade-type-area">
            <button type="button" 
                    class="trade-button ${product.tradeType == 'BUY' ? 'active' : ''}" 
                    id="buyButton" 
                    onclick="setTradeType('BUY')">구매</button>
            <button type="button" 
                    class="trade-button ${product.tradeType == 'SELL' || empty product.tradeType ? 'active' : ''}" 
                    id="sellButton" 
                    onclick="setTradeType('SELL')">판매</button>
        </div>

        <!-- 일반 게시글 수정 Form -->
        <form id="productForm" action="${pageContext.request.contextPath}/board/${product.productId}/update" method="post" enctype="multipart/form-data">

            <!-- 거래 방식 (BUY 또는 SELL) -->
            <input type="hidden" name="tradeType" id="tradeType" value="${not empty product.tradeType ? product.tradeType : 'SELL'}">
            
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
                            
                            <!-- 미디어 순서 표시 (예: 1 / 5) -->
                            <div id="mediaOrderBadge" class="media-badge" style="display: none;">1 / 5</div>
                            
                            <!-- 개별 삭제 버튼 -->
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
                        <input type="text" id="title" name="title" value="${product.title}" placeholder="상품명을 입력해주세요" required>
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

                    <!-- 상품 상태 -->
                    <div class="form-row" id="conditionArea">
                        <label for="productCondition">상품상태</label>
                        <select id="productCondition" name="productCondition" required>
                            <option value="">선택해주세요</option>
                            <option value="NEW" ${product.productCondition == 'NEW' ? 'selected' : ''}>새상품</option>
                            <option value="LIKE_NEW" ${product.productCondition == 'LIKE_NEW' ? 'selected' : ''}>미개봉</option>
                            <option value="USED" ${product.productCondition == 'USED' ? 'selected' : ''}>개봉</option>
                        </select>
                    </div>

                    <!-- 가격 -->
                    <div class="form-row" id="priceArea">
                        <label for="price">가격</label>
                        <input type="number" id="price" name="price" value="${product.price}" min="0" placeholder="가격을 입력해주세요" required>
                    </div>

                    <!-- 설명 -->
                    <div class="form-row">
                        <label for="description">상품설명</label>
                        <textarea id="description" name="description" placeholder="상품에 대한 설명을 입력해주세요" required>${product.description}</textarea>
                    </div>

                    <!-- 거래 방식 (택배/직거래) -->
                    <div class="form-row">
                        <label for="isDirect">거래방식</label>
                        <select id="isDirect" name="isDirect">
                            <option value="0" ${product.isDirect == 0 ? 'selected' : ''}>택배</option>
                            <option value="1" ${product.isDirect == 1 ? 'selected' : ''}>직거래</option>
                        </select>
                    </div>

                    <!-- 거래 장소 -->
                    <div class="form-row" id="locationArea">
                        <label for="tradeLocation">거래장소</label>
                        <input type="text" id="tradeLocation" name="tradeLocation" value="${product.tradeLocation}" placeholder="거래 장소를 입력해주세요">
                    </div>

                </div>

            </div>

            <!-- 하단 버튼 영역 -->
            <div class="button-area">
                <!-- 취소 버튼 (btn-temp-save 스타일 적용) -->
                <button type="button" class="btn-temp-save" onclick="location.href='${pageContext.request.contextPath}/board/${product.productId}/detail'">
                    취소
                </button>

                <!-- 수정 완료 버튼 (btn-submit 스타일 적용) -->
                <button type="submit" class="btn-submit">
                    수정하기
                </button>
            </div>

        </form>

    </div>

    <script>
        // 구매/판매 탭 전환 함수
        function setTradeType(type) {
            document.getElementById("tradeType").value = type;
            
            const buttons = document.querySelectorAll(".trade-button");
            buttons.forEach(btn => btn.classList.remove("active"));
            
            if (type === 'BUY') {
                document.getElementById("buyButton").classList.add("active");
            } else {
                document.getElementById("sellButton").classList.add("active");
            }
        }

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

        // 전체 미디어 목록 관리 배열
        let mediaItems = [];
        let currentMediaIndex = 0;
        let deletedMediaIdList = [];

        // 페이지 로드 시 기존 미디어가 있으면 mediaItems에 세팅
        if (existingMediaList && existingMediaList.length > 0) {
            mediaItems = existingMediaList.map(item => ({
                mediaId: item.mediaId,
                url: item.mediaUrl,
                type: item.mediaType,
                file: null
            }));
        }

        const imageInput = document.getElementById("imageInput");
        const imagePreview = document.getElementById("imagePreview");
        const imagePlaceholder = document.getElementById("imagePlaceholder");
        const imageCount = document.getElementById("imageCount");
        const currentMediaDeleteBtn = document.getElementById("currentMediaDeleteBtn");
        const mediaOrderBadge = document.getElementById("mediaOrderBadge");

        window.addEventListener("DOMContentLoaded", function() {
            renderPreview();
        });

        imageInput.addEventListener("change", function () {
            const files = Array.from(this.files);

            files.forEach(file => {
                if (mediaItems.length >= 5) {
                    alert("이미지와 동영상은 최대 5개까지 등록할 수 있습니다.");
                    return;
                }

                const alreadyExists = mediaItems.some(item => 
                    item.file && 
                    item.file.name === file.name && 
                    item.file.size === file.size && 
                    item.file.lastModified === file.lastModified
                );

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

            updateInputFiles();
            this.value = "";
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

        function removeCurrentMedia(event) {
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

        function showPreviousMedia(event) {
            event.preventDefault();
            event.stopPropagation();

            if (mediaItems.length === 0) return;

            currentMediaIndex--;
            if (currentMediaIndex < 0) {
                currentMediaIndex = mediaItems.length - 1;
            }
            renderPreview();
        }

        function showNextMedia(event) {
            event.preventDefault();
            event.stopPropagation();

            if (mediaItems.length === 0) return;

            currentMediaIndex++;
            if (currentMediaIndex >= mediaItems.length) {
                currentMediaIndex = 0;
            }
            renderPreview();
        }

        function checkFirstMedia() {
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

        document.getElementById("productForm").addEventListener("submit", function(e) {
            updateInputFiles();

            const price = document.getElementById("price");

            if (!price.value || price.value < 0) {
                alert("올바른 가격을 입력해주세요.");
                price.value = "";
                e.preventDefault();
                return;
            }
            
            if (!checkFirstMedia()) {
                e.preventDefault();
                return;
            }
        });
    </script>
</body>
</html>