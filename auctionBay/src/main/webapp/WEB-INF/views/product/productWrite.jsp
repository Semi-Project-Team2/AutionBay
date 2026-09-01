<%@ page language="java"
    contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>

<head> 

<meta charset="UTF-8">

<title>게시글 작성</title>

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


/* 제목 */
.page-title {
    font-size: 38px;

    margin-bottom: 30px;
}


/* =========================
   거래 방식 선택
   ========================= */

.trade-type-area {

    display: flex;

    gap: 15px;

    margin-bottom: 40px;
}


/* 거래 방식 버튼 */
.trade-button {

    width: 180px;
    height: 60px;

    border: 1px solid #ccc;

    background-color: white;

    font-size: 20px;

    cursor: pointer;
}


/* 선택된 버튼 */
.trade-button.active {

    background-color: #ddd;

    font-weight: bold;
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


/* 경매 전용 영역 */
.auction-only {

    display: none;
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


    <!-- 페이지 제목 -->
    <div class="page-title">

        게시글 작성

    </div>


    <!-- =========================
         거래 방식 선택
         ========================= -->

    <div class="trade-type-area">


        <!-- 구매 버튼 -->
        <button
            type="button"
            class="trade-button active"
            id="buyButton"
            onclick="changeTradeType('BUY')">

            구매

        </button>


        <!-- 판매 버튼 -->
        <button
            type="button"
            class="trade-button"
            id="sellButton"
            onclick="changeTradeType('SELL')">

            판매

        </button>


        <!-- 경매 버튼 -->
        <button
            type="button"
            class="trade-button"
            id="auctionButton"
            onclick="changeTradeType('AUCTION')">

            경매

        </button>

    </div>



    <!-- =========================
         게시글 작성 Form
         ========================= -->

    <form
        id="productForm"

        action="${pageContext.request.contextPath}/product/write"

        method="post"

        enctype="multipart/form-data">


        <!-- 거래 방식 -->
        <input
            type="hidden"
            name="tradeType"
            id="tradeType"
            value="BUY">



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
					        <option value="${category.categoryId}">
					            ${category.categoryName}
					        </option>
					    </c:forEach>
					</select>

                </div>



                <!-- =========================
                     판매 / 경매 상품 상태
                     ========================= -->

                <div
                    class="form-row"
                    id="conditionArea">

                    <label for="productCondition">
                        상품상태
                    </label>

                    <select
                        id="productCondition"
                        name="productCondition">

                        <option value="">
                            선택해주세요
                        </option>

                        <option value="NEW">
                            새상품
                        </option>

                        <option value="LIKE_NEW">
                            미개봉
                        </option>

                        <option value="USED">
                            개봉
                        </option>


                    </select>

                </div>



                <!-- =========================
                     가격
                     ========================= -->

                <div
                    class="form-row"
                    id="priceArea">

                    <label for="price">
                        희망가격
                    </label>

                    <input
                        type="number"
                        id="price"
                        name="price"
                        min="0"
                        placeholder="가격을 입력해주세요">

                </div>



                <!-- =========================
                     경매 시작 가격
                     ========================= -->

                <div
                    class="form-row auction-only"
                    id="auctionPriceArea">

                    <label for="auctionStartPrice">
                        시작가격
                    </label>

                    <input
                        type="number"
                        id="auctionStartPrice"
                        name="auctionStartPrice"
                        min="0"
                        placeholder="경매 시작 가격">

                </div>



                <!-- =========================
                     경매 마감시간
                     ========================= -->

                <div
                    class="form-row auction-only"
                    id="auctionEndArea">

                    <label for="auctionEndTime">
                        마감시간
                    </label>

                    <input
                        type="datetime-local"
                        id="auctionEndTime"
                        name="auctionEndTime">

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
                        required></textarea>

                </div>



                <!-- =========================
                     거래 방식
                     ========================= -->

                <div class="form-row">

                    <label for="isDirect">
                        거래방식
                    </label>

                    <select
                        id="isDirect"
                        name="isDirect">

                        <option value="0">
                            택배
                        </option>

                        <option value="1">
                            직거래
                        </option>

                    </select>

                </div>



                <!-- 거래 장소 -->
                <div
                    class="form-row"
                    id="locationArea">

                    <label for="tradeLocation">
                        거래장소
                    </label>

                    <input
                        type="text"
                        id="tradeLocation"
                        name="tradeLocation"
                        placeholder="거래 장소를 입력해주세요">

                </div>


            </div>

        </div>



        <!-- =========================
             하단 버튼
             ========================= -->

        <div class="button-area">

            <!-- 임시저장 -->
            <button
                type="button"
                onclick="temporarySave()">

                임시저장

            </button>


            <!-- 등록 -->
			<button type="submit" onclick="return checkFirstMedia();">
			    등록하기
			</button>

        </div>


    </form>

</div>



<script>

/*
 * 현재 선택된 거래 방식
 *
 * BUY      : 구매
 * SELL     : 판매
 * AUCTION  : 경매
 */
let currentTradeType = "BUY";



/*
 * 거래 방식 변경 함수
 *
 * 버튼을 누르면
 * 화면에 필요한 입력창을 변경한다.
 */
function changeTradeType(type) {
	
	// =========================
	// 작성 내용 초기화
	// =========================
	document.getElementById("title").value = "";
	document.getElementById("categoryId").value = "";
	document.getElementById("productCondition").value = "";
	document.getElementById("price").value = "";
	document.getElementById("auctionStartPrice").value = "";
	document.getElementById("auctionEndTime").value = "";
	document.getElementById("description").value = "";
	document.getElementById("isDirect").value = "0";
	document.getElementById("tradeLocation").value = "";

	// 이미지 초기화
	selectedFiles = new DataTransfer();
	currentMediaIndex = 0;
	imageInput.value = "";
	imagePreview.innerHTML = "";
	imagePlaceholder.style.display = "block";
	document.getElementById("currentMediaDeleteBtn").style.display = "none";
	document.getElementById("mediaOrderBadge").style.display = "none";
	document.getElementById("imageCount").innerText = "(0/5)";

    // 현재 거래 방식 저장
    currentTradeType = type;


    // hidden input에 거래 방식 저장
    document.getElementById("tradeType").value = type;


    // 버튼 가져오기
    const buyButton =
        document.getElementById("buyButton");

    const sellButton =
        document.getElementById("sellButton");

    const auctionButton =
        document.getElementById("auctionButton");


    // 모든 버튼의 active 제거
    buyButton.classList.remove("active");
    sellButton.classList.remove("active");
    auctionButton.classList.remove("active");


    // 선택한 버튼에 active 추가
    if (type === "BUY") {

        buyButton.classList.add("active");

    } else if (type === "SELL") {

        sellButton.classList.add("active");

    } else if (type === "AUCTION") {

        auctionButton.classList.add("active");

    }



    // 가격 영역
    const priceArea =
        document.getElementById("priceArea");


    // 상품 상태 영역
    const conditionArea =
        document.getElementById("conditionArea");


    // 경매 시작 가격
    const auctionPriceArea =
        document.getElementById("auctionPriceArea");


    // 경매 마감 시간
    const auctionEndArea =
        document.getElementById("auctionEndArea");


    // 일반 가격 input
    const price =
        document.getElementById("price");


    // 상품 상태
    const productCondition =
        document.getElementById("productCondition");


    // 경매 시작가격
    const auctionStartPrice =
        document.getElementById("auctionStartPrice");


    // 경매 마감시간
    const auctionEndTime =
        document.getElementById("auctionEndTime");



    /*
     * 구매 게시글
     */
    if (type === "BUY") {

        // 구매자는 원하는 가격을 입력
        priceArea.style.display = "flex";

        // 구매 게시글에서는 상품 상태를 선택하지 않아도 됨
        conditionArea.style.display = "none";

        // 경매 관련 항목 숨김
        auctionPriceArea.style.display = "none";
        auctionEndArea.style.display = "none";


        // 필수 조건 변경
        price.required = true;
		
		productCondition.value = "USED";
        productCondition.required = false;

        auctionStartPrice.required = false;

        auctionEndTime.required = false;
		
		

    }



    /*
     * 판매 게시글
     */
    else if (type === "SELL") {

        // 판매 가격
        priceArea.style.display = "flex";

        // 상품 상태 표시
        conditionArea.style.display = "flex";

        // 경매 관련 항목 숨김
        auctionPriceArea.style.display = "none";
        auctionEndArea.style.display = "none";


        // 필수 입력
        price.required = true;

        productCondition.required = true;

        auctionStartPrice.required = false;

        auctionEndTime.required = false;

    }



    /*
     * 경매 게시글
     */
    else if (type === "AUCTION") {

        // 일반 가격은 사용하지 않음
        priceArea.style.display = "none";

        // 상품 상태 표시
        conditionArea.style.display = "flex";

        // 경매 시작가격 표시
        auctionPriceArea.style.display = "flex";

        // 경매 마감시간 표시
        auctionEndArea.style.display = "flex";


        // 필수 입력
        price.required = false;

        productCondition.required = true;

        auctionStartPrice.required = true;

        auctionEndTime.required = true;
		
    }

}

const imageInput = document.getElementById("imageInput");
const imagePreview = document.getElementById("imagePreview");
const imagePlaceholder = document.getElementById("imagePlaceholder");
const imageCount = document.getElementById("imageCount");
const currentMediaDeleteBtn = document.getElementById("currentMediaDeleteBtn");
const mediaOrderBadge = document.getElementById("mediaOrderBadge");

// 선택한 파일을 계속 저장할 곳
let selectedFiles = new DataTransfer();
let currentMediaIndex = 0;


imageInput.addEventListener("change", function () {

    // 새로 선택한 파일 추가
    Array.from(this.files).forEach(function(file) {

        // 같은 파일 중복 방지
        const alreadyExists =
            Array.from(selectedFiles.files).some(function(existingFile) {

                return existingFile.name === file.name
                    && existingFile.size === file.size
                    && existingFile.lastModified === file.lastModified;

            });


        if (!alreadyExists) {
            selectedFiles.items.add(file);
        }

    });


    // 최대 5개
    if (selectedFiles.files.length > 5) {

        alert("이미지와 동영상은 최대 5개까지 등록할 수 있습니다.");

        // 5개까지만 유지
        const newDataTransfer = new DataTransfer();

        Array.from(selectedFiles.files)
            .slice(0, 5)
            .forEach(function(file) {

                newDataTransfer.items.add(file);

            });

        selectedFiles = newDataTransfer;

    }


    // 실제 input에도 누적된 파일 넣기
    imageInput.files = selectedFiles.files;


    // 미리보기 다시 그리기
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
    currentMediaDeleteBtn.style.display = "block";
    mediaOrderBadge.style.display = "block";

    // 인덱스 범위 초과 방지
    if (currentMediaIndex >= selectedFiles.files.length) {
        currentMediaIndex = selectedFiles.files.length - 1;
    }

	const file = selectedFiles.files[currentMediaIndex];
	const url = URL.createObjectURL(file);


	// 이미지
	if (file.type.startsWith("image/")) {

	    const img = document.createElement("img");

	    img.src = url;

	    imagePreview.appendChild(img);

	}


	// 동영상
	else if (file.type.startsWith("video/")) {

	    const video = document.createElement("video");

	    video.src = url;

	    video.controls = true;

	    imagePreview.appendChild(video);
	}


    mediaOrderBadge.innerText = (currentMediaIndex + 1) + " / " + selectedFiles.files.length;
    imageCount.innerText = "(" + selectedFiles.files.length + "/5)";
}

// 현재 보고 있는 미디어 개별 삭제 함수 (X 버튼 클릭 시)
function removeCurrentMedia(event) {
    event.preventDefault();
    event.stopPropagation();

    if (selectedFiles.files.length === 0) return;

    const newDataTransfer = new DataTransfer();
    const files = selectedFiles.files;

    // 현재 인덱스에 해당하는 파일을 제외하고 새로운 DataTransfer에 담기
    for (let i = 0; i < files.length; i++) {
        if (i !== currentMediaIndex) {
            newDataTransfer.items.add(files[i]);
        }
    }

    selectedFiles = newDataTransfer;
    imageInput.files = selectedFiles.files;

    // 인덱스 조정
    if (currentMediaIndex >= selectedFiles.files.length && currentMediaIndex > 0) {
        currentMediaIndex--;
    }

    renderPreview();
}

function showPreviousMedia(event) {

    /*
     * label 클릭 방지
     */
    event.preventDefault();

    event.stopPropagation();


    if (selectedFiles.files.length === 0) {
        return;
    }


    currentMediaIndex--;


    if (currentMediaIndex < 0) {

        currentMediaIndex =
            selectedFiles.files.length - 1;
    }


    renderPreview();
}


function showNextMedia(event) {

    /*
     * label 클릭 방지
     */
    event.preventDefault();

    event.stopPropagation();


    if (selectedFiles.files.length === 0) {
        return;
    }


    currentMediaIndex++;


    if (
        currentMediaIndex >=
        selectedFiles.files.length
    ) {

        currentMediaIndex = 0;
    }


    renderPreview();
}

function checkFirstMedia() {

	// 등록한 미디어가 없으면 그대로 등록
	if (selectedFiles.files.length === 0) {
	    return true;
	}

	// 첫 번째 미디어
	const firstFile = selectedFiles.files[0];

	// 첫 번째가 동영상이면
	if (firstFile.type.startsWith("video/")) {

	    const result = confirm(
	        "첫 번째 등록 미디어가 동영상입니다.\n" +
	        "목록 화면에서는 기본 이미지로 표시됩니다.\n\n" +
	        "등록하시겠습니까?"
	    );

	    // 예
	    if (result) {
	        return true;
	    }

	    // 아니요
	    return false;
	}

	return true;
}


/*
 * 임시저장
 *
 * 현재는 기능만 만들어놓고
 * 나중에 별도의 API를 연결하면 된다.
 */
function temporarySave() {

    alert("임시저장 기능은 준비 중입니다.");

}


// ==========================================
// 경매 마감시간 검사
// ==========================================
document.getElementById("auctionEndTime").addEventListener("change", function() {

    if (!this.value) {
        return;
    }

    const selectedTime = new Date(this.value);
    const now = new Date();

    // 현재 시간보다 이전이면 초기화
    if (selectedTime <= now) {
        alert("경매 마감시간은 현재 시간 이후로 선택해주세요.");

        this.value = "";
    }
});


// ==========================================
// 등록할 때도 한 번 더 검사
// ==========================================
document.getElementById("productForm").addEventListener("submit", function(e) {

    // 경매일 때만 검사
    if (currentTradeType === "AUCTION") {

        const auctionEndTime =
            document.getElementById("auctionEndTime");

        if (!auctionEndTime.value) {
            alert("경매 마감시간을 선택해주세요.");
            e.preventDefault();
            return;
        }

        const selectedTime = new Date(auctionEndTime.value);
        const now = new Date();

        // 현재 시간 이전이면 등록 막기
        if (selectedTime <= now) {
            alert("경매 마감시간은 현재 시간 이후로 설정해주세요.");
            auctionEndTime.value = "";
            e.preventDefault();
            return;
        }
    }
});


/*
 * 페이지가 처음 열렸을 때
 *
 * 기본값은 구매 게시글
 */
changeTradeType("BUY");

</script>


</body>

</html>