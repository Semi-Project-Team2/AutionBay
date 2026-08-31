<%@ page language="java"
    contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>

<head> 

<meta charset="UTF-8">

<title>일반 게시글 수정</title>

<style>

/* 전체 페이지 기본 설정 */
* {
    box-sizing: border-box;
}

body {
    margin: 0;
    font-family: Arial, sans-serif;
    background-color: #fff;
}


/* =========================
   헤더
   ========================= */

header {
    height: 120px;

    display: flex;
    align-items: center;

    padding: 20px 50px;

    background-color: #f5f5f5;
}


/* 로고 */
.logo {
    width: 200px;

    font-size: 30px;
    font-weight: bold;
}


/* 검색창 */
.search {
    width: 600px;
    height: 50px;

    margin-left: 100px;

    background-color: #ddd;

    display: flex;
    align-items: center;

    padding-left: 20px;

    color: #777;
}


/* 오른쪽 메뉴 */
.header-menu {
    margin-left: auto;

    display: flex;

    gap: 10px;
}

.header-menu button {
    border: none;

    background-color: #ddd;

    padding: 10px 20px;

    cursor: pointer;
}


/* =========================
   본문
   ========================= */

.container {
    width: 1200px;

    margin: 50px auto;
}


/* 제목 영역 및 거래 타입 탭 버튼 */
.page-header-area {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 40px;
}

.page-title {
    font-size: 38px;
    margin: 0;
}

/* 구매/판매 전환 탭 버튼 스타일 */
.trade-type-tabs {
    display: flex;
    gap: 10px;
}

.trade-tab-btn {
    width: 120px;
    height: 50px;
    border: 1px solid #ccc;
    background-color: #fff;
    font-size: 18px;
    font-weight: bold;
    cursor: pointer;
    transition: all 0.2s;
}

.trade-tab-btn.active {
    background-color: #ddd;
    border-color: #aaa;
}


/* =========================
   작성 영역
   ========================= */

.write-area {

    display: flex;

    gap: 50px;
}


/* 이미지 영역 */
.image-area {

    width: 400px;
}


/* 이미지 등록 박스 */
.image-box {

    width: 400px;
    height: 400px;

    background-color: #eee;

    display: flex;

    align-items: center;
    justify-content: center;
	
	overflow: hidden;
	
    cursor: pointer;
	
	position: relative;
}

#imagePlaceholder {
    position: absolute;
    top: 50%;
    left: 50%;
    transform: translate(-50%, -50%);
}

#imagePreview {
    width: 100%;
    height: 100%;

    display: flex;
	flex-wrap: wrap;
    align-items: center;
    justify-content: center;

	gap: 10px;

	overflow: auto;
}

#imagePreview img,
#imagePreview video {
    width: 100%;
    height: 100%;
    object-fit: cover;
	
	border-radius: 8px;
}

/* 이전/다음 버튼 */
.media-navigation {
    width: 400px;

    display: flex;
    justify-content: space-between;
    align-items: center;
	
	margin-top: 10px;
}

.media-button {
    width: 40px;
    height: 40px;

    border: none;
    border-radius: 50%;

    background: #888;

    color: white;
    font-size: 30px;

    cursor: pointer;
}

/* 사진/동영상 추가 버튼 */
.media-add-btn {
    display: block;
    margin: 20px auto 0;

    padding: 8px 20px;

    border: 1px solid #ccc;
    background: #eee;

    font-size: 14px;
    cursor: pointer;
}

.media-add-btn:hover {
    background: #ddd;
}


/* 이미지 파일 input 숨김 */
#imageInput {
    display: none;
}


/* 이미지 개수 */
.image-count {

    text-align: center;

    margin-top: 15px;

    font-size: 18px;
}


/* =========================
   입력폼
   ========================= */

.form-area {

    width: 600px;
}


/* 입력 한 줄 */
.form-row {

    display: flex;

    align-items: center;

    margin-bottom: 25px;
}


/* 라벨 */
.form-row label {

    width: 150px;

    font-size: 18px;

    font-weight: bold;
}


/* input */
.form-row input,
.form-row select,
.form-row textarea {

    flex: 1;

    border: none;

    background-color: #eee;

    padding: 15px;

    font-size: 16px;
}


/* input 높이 */
.form-row input,
.form-row select {

    height: 50px;
}


/* textarea */
.form-row textarea {

    height: 180px;

    resize: none;
}


/* =========================
   버튼
   ========================= */

.button-area {

    margin-top: 50px;

    display: flex;

    justify-content: center;

    gap: 30px;
}


.button-area button {

    width: 250px;

    height: 60px;

    border: none;

    background-color: #ddd;

    font-size: 20px;

    cursor: pointer;
}

</style>

</head>


<body>


<!-- =========================
     HEADER
     ========================= -->

	<!-- 공통 헤더 포함 -->
	<jsp:include page="/WEB-INF/views/common/header.jsp" />





<!-- =========================
     MAIN
     ========================= -->

<div class="container">


    <!-- 페이지 제목 및 구매/판매 전환 탭 -->
    <div class="page-header-area">
        <div class="page-title">
            일반 게시글 수정
        </div>

        <!-- 구매 / 판매 선택 탭 버튼 -->
        <div class="trade-type-tabs">
            <button type="button" class="trade-tab-btn ${product.tradeType == 'BUY' ? 'active' : ''}" onclick="setTradeType('BUY')">구매</button>
            <button type="button" class="trade-tab-btn ${product.tradeType == 'SELL' || empty product.tradeType ? 'active' : ''}" onclick="setTradeType('SELL')">판매</button>
        </div>
    </div>



    <!-- =========================
         일반 게시글 수정 Form
         ========================= -->

    <form
        id="productForm"

        action="${pageContext.request.contextPath}/board/${product.productId}/update"

        method="post"

        enctype="multipart/form-data">


        <!-- 거래 방식 (BUY 또는 SELL) -->
        <input
            type="hidden"
            name="tradeType"
            id="tradeType"
            value="${not empty product.tradeType ? product.tradeType : 'SELL'}">
            
		<!-- 작성자 고유 번호 -->
        <input
            type="hidden"
            name="writerNo"
            id="writerNo"
            value="${product.writerNo}">

        <!-- 삭제된 기존 미디어의 ID를 담을 숨김 필드 -->
        <input 
            type="hidden" 
            name="deletedMediaIds" 
            id="deletedMediaIds" 
            value="">



        <div class="write-area">


            <!-- =========================
                 이미지
                 ========================= -->

            <div class="image-area">


                <!-- 파일 선택 -->
                <label for="imageInput">

					<div class="image-box" style="position: relative;">
					    <span id="imagePlaceholder">이미지 등록</span>
					    <div id="imagePreview"></div>
					    
					    <!-- 미디어 순서 표시 (예: 1 / 5) -->
					    <div id="mediaOrderBadge" style="display: none; position: absolute; top: 10px; left: 10px; z-index: 10; background: rgba(0,0,0,0.6); color: white; padding: 4px 8px; border-radius: 4px; font-size: 14px; font-weight: bold;">
					        1 / 5
					    </div>
					    
					    <!-- 개별 삭제 버튼 -->
					    <button 
					        type="button" 
					        id="currentMediaDeleteBtn" 
					        onclick="removeCurrentMedia(event)" 
					        style="display: none; position: absolute; top: 10px; right: 10px; z-index: 10; background: rgba(0,0,0,0.6); color: white; border: none; border-radius: 50%; width: 30px; height: 30px; cursor: pointer; font-weight: bold;">
					        ×
					    </button>
					</div>

                </label>
				
                <!-- 최대 5개 이미지 -->
                <input
                    type="file"
                    id="imageInput"
                    name="images"
                    multiple
                    accept="image/*, video/*">

				
				<div class="media-navigation">

				    <button
				        type="button"
				        id="prevMedia"
				        class="media-button"
				        onclick="showPreviousMedia(event)">
				        ‹
				    </button>
					
					<!-- 이미지 개수 -->
					<div
					    class="image-count"
					    id="imageCount">

					    (0/5)

					</div>

				    <button
				        type="button"
				        id="nextMedia"
				        class="media-button"
				        onclick="showNextMedia(event)">
				        ›
				    </button>

				</div>
				
				<button type="button" class="media-add-btn" onclick="document.getElementById('imageInput').click();">
				    사진/동영상 추가
				</button>

				
            </div>



            <!-- =========================
                 입력 영역
                 ========================= -->

            <div class="form-area">


                <!-- 상품명 -->
                <div class="form-row">

                    <label for="title">
                        상품명
                    </label>

                    <input
                        type="text"
                        id="title"
                        name="title"
                        value="${product.title}"
                        placeholder="상품명을 입력해주세요"
                        required>

                </div>



                <!-- 카테고리 -->
                <div class="form-row">

                    <label for="categoryId">
                        카테고리
                    </label>

					<select id="categoryId" name="categoryId" required>
					    <option value="">카테고리 선택</option>

					    <c:forEach var="category" items="${categoryList}">
					        <option value="${category.categoryId}" ${product.categoryId == category.categoryId ? 'selected' : ''}>
					            ${category.categoryName}
					        </option>
					    </c:forEach>
					</select>

                </div>



                <!-- =========================
                     상품 상태
                     ========================= -->

                <div class="form-row" id="conditionArea">

                    <label for="productCondition">
                        상품상태
                    </label>

                    <select
                        id="productCondition"
                        name="productCondition"
                        required>

                        <option value="">
                            선택해주세요
                        </option>

                        <option value="NEW" ${product.productCondition == 'NEW' ? 'selected' : ''}>
                            새상품
                        </option>

                        <option value="LIKE_NEW" ${product.productCondition == 'LIKE_NEW' ? 'selected' : ''}>
                            미개봉
                        </option>

                        <option value="USED" ${product.productCondition == 'USED' ? 'selected' : ''}>
                            개봉
                        </option>

                    </select>

                </div>



                <!-- =========================
                     가격 (price)
                     ========================= -->

                <div class="form-row" id="priceArea">

                    <label for="price">
                        가격
                    </label>

                    <input
                        type="number"
                        id="price"
                        name="price"
                        value="${product.price}"
                        min="0"
                        placeholder="가격을 입력해주세요"
                        required>

                </div>



                <!-- =========================
                     설명
                     ========================= -->

                <div class="form-row">

                    <label for="description">
                        상품설명
                    </label>

                    <textarea
                        id="description"
                        name="description"
                        placeholder="상품에 대한 설명을 입력해주세요"
                        required>${product.description}</textarea>

                </div>



                <!-- =========================
                     거래 방식 (택배/직거래)
                     ========================= -->

                <div class="form-row">

                    <label for="isDirect">
                        거래방식
                    </label>

                    <select
                        id="isDirect"
                        name="isDirect">

                        <option value="0" ${product.isDirect == 0 ? 'selected' : ''}>
                            택배
                        </option>

                        <option value="1" ${product.isDirect == 1 ? 'selected' : ''}>
                            직거래
                        </option>

                    </select>

                </div>



                <!-- 거래 장소 -->
                <div class="form-row" id="locationArea">

                    <label for="tradeLocation">
                        거래장소
                    </label>

                    <input
                        type="text"
                        id="tradeLocation"
                        name="tradeLocation"
                        value="${product.tradeLocation}"
                        placeholder="거래 장소를 입력해주세요">

                </div>


            </div>

        </div>



        <!-- =========================
             하단 버튼
             ========================= -->

        <div class="button-area">

            <!-- 취소 -->
            <button
                type="button"
                onclick="location.href='${pageContext.request.contextPath}/board/${product.productId}/detail'">

                취소

            </button>


            <!-- 수정 완료 -->
			<button type="submit">
			    수정하기
			</button>

        </div>


    </form>

</div>



<script>
    // 구매/판매 탭 전환 함수
    function setTradeType(type) {
        document.getElementById("tradeType").value = type;
        
        const buttons = document.querySelectorAll(".trade-tab-btn");
        buttons.forEach(btn => btn.classList.remove("active"));
        
        if (type === 'BUY') {
            buttons[0].classList.add("active");
        } else {
            buttons[1].classList.add("active");
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

    // 전체 미디어 목록 관리 배열 (기존 미디어 + 새로 추가할 파일 통합)
    let mediaItems = [];
    let currentMediaIndex = 0;
    
    // 삭제된 기존 미디어의 ID를 저장할 배열
    let deletedMediaIdList = [];

    // 페이지 로드 시 기존 미디어가 있으면 mediaItems에 세팅
    if (existingMediaList && existingMediaList.length > 0) {
        mediaItems = existingMediaList.map(item => ({
            mediaId: item.mediaId,
            url: item.mediaUrl,
            type: item.mediaType,
            file: null // 기존 파일은 새 File 객체가 없으므로 null
        }));
    }

    const imageInput = document.getElementById("imageInput");
    const imagePreview = document.getElementById("imagePreview");
    const imagePlaceholder = document.getElementById("imagePlaceholder");
    const imageCount = document.getElementById("imageCount");
    const currentMediaDeleteBtn = document.getElementById("currentMediaDeleteBtn");

    // 페이지가 처음 열릴 때 미리보기 실행
    window.addEventListener("DOMContentLoaded", function() {
        renderPreview();
    });

    // 파일 선택(새로 추가) 시 동작
    imageInput.addEventListener("change", function () {
        const files = Array.from(this.files);

        files.forEach(file => {
            // 최대 5개 제한 체크
            if (mediaItems.length >= 5) {
                alert("이미지와 동영상은 최대 5개까지 등록할 수 있습니다.");
                return;
            }

            // 동일한 파일 중복 추가 방지
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
                    mediaId: null, // 새로 추가된 파일은 기존 ID가 없음
                    url: url,
                    type: type,
                    file: file
                });
            }
        });

        // 실제 input[type="file"]에도 누적된 파일 동기화
        updateInputFiles();

        // input 값 초기화 (동일 파일 재선택 가능하도록)
        this.value = "";
        
        renderPreview();
    });

    // DataTransfer를 이용해 실제 input 파일 목록을 관리하는 함수
    function updateInputFiles() {
        const dataTransfer = new DataTransfer();
        mediaItems.forEach(item => {
            if (item.file) {
                dataTransfer.items.add(item.file);
            }
        });
        imageInput.files = dataTransfer.files;
    }

	const mediaOrderBadge = document.getElementById("mediaOrderBadge");

    // 미리보기 렌더링 함수
    function renderPreview() {
        imagePreview.innerHTML = "";

        if (mediaItems.length === 0) {
            imagePlaceholder.style.display = "block";
            currentMediaDeleteBtn.style.display = "none";
            mediaOrderBadge.style.display = "none"; // 순서 뱃지 숨김
            imageCount.innerText = "(0/5)";
            return;
        }

        imagePlaceholder.style.display = "none";
        currentMediaDeleteBtn.style.display = "block";
        mediaOrderBadge.style.display = "block"; // 순서 뱃지 표시

        // 인덱스 범위 초과 방지
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

        // 현재 몇 번째인지 뱃지와 하단 카운트 텍스트 갱신
        mediaOrderBadge.innerText = (currentMediaIndex + 1) + " / " + mediaItems.length;
        imageCount.innerText = "(" + mediaItems.length + "/5)";
    }
	
    // 현재 보고 있는 미디어 개별 삭제 함수 (X 버튼 클릭 시)
    function removeCurrentMedia(event) {
        event.preventDefault();
        event.stopPropagation();

        if (mediaItems.length === 0) return;

        const targetMedia = mediaItems[currentMediaIndex];

        // 기존에 DB에 있던 미디어라면 삭제 ID 목록에 추가
        if (targetMedia.mediaId) {
            deletedMediaIdList.push(targetMedia.mediaId);
            document.getElementById("deletedMediaIds").value = deletedMediaIdList.join(",");
        }

        // 배열에서 현재 인덱스 항목 제거
        mediaItems.splice(currentMediaIndex, 1);

        // 실제 input 파일 목록 동기화
        updateInputFiles();

        // 인덱스 조정
        if (currentMediaIndex >= mediaItems.length && currentMediaIndex > 0) {
            currentMediaIndex--;
        }

        renderPreview();
    }

    // 이전 미디어 보기
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

    // 다음 미디어 보기
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

    // 첫 번째 미디어가 동영상인지 검사
    function checkFirstMedia() {
        if (mediaItems.length === 0) {
            return true;
        }

        const firstMedia = mediaItems[0];

        if (firstMedia.type === "VIDEO" || firstMedia.type.startsWith("video/")) {
            const result = confirm(
                "첫 번째 등록 미디어가 동영상입니다.\n" +
                "목록 화면에서는 기본 이미지로 표시됩니다.\n\n" +
                "수정하시겠습니까?"
            );
            return result;
        }

        return true;
    }

    // 폼 제출 시 최종 유효성 검사 및 제출 직전 파일 동기화 보장
    document.getElementById("productForm").addEventListener("submit", function(e) {
        // 제출 직전 파일 객체들이 input[type="file"]에 확실히 담기도록 동기화 보장
        updateInputFiles();

        const price = document.getElementById("price");

        if (!price.value || price.value < 0) {
            alert("올바른 가격을 입력해주세요.");
            price.value = "";
            e.preventDefault();
            return;
        }
        
        // 첫 번째 미디어가 동영상일 때 사용자 확인 체크
        if (!checkFirstMedia()) {
            e.preventDefault();
            return;
        }
    });
</script>


</body>
</html>