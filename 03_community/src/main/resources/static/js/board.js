// 이미지 미리보기
const imagesInput = document.querySelector("#images");
const imagePreviewList = document.querySelector("#image-preview-list");

imagesInput.addEventListener("change", function(e) {
	// preview 영역 초기화
	imagePreviewList.textContent = "";
	
	// 파일 객체 -> 이벤트 객체
	let images = e.target.files; // 배열이 아니라 FileList 객체임.
	
	images = Array.from(images); // forEach 사용을 위해 배열로 변환.
	images.forEach(function(file, index) {
		
		const reader = new FileReader();
		reader.onload = function(event) {
			
			const li = document.createElement("li");
			const img = document.createElement("img");
			
			img.src = event.target.result;
			img.alt = file.name;
			
			li.appendChild(img);
			imagePreviewList.appendChild(li);
			
		}
		
		reader.readAsDataURL(file);
		
	});
});

// 댓글 기능
const commentForm = document.querySelector("#comment-form");
const boardKey = document.querySelector("#board-key");

commentForm.addEventListener("submit", async function(ev) {
	ev.preventDefault();	// 기본 이벤트를 막고 직접 처리
	
	const contentInput = commentForm.querySelector("textarea");
	const content = contentInput.value.trim();
	
	if (!content) {
		alert("댓글 내용을 입력해주세요.");
		return;
	}
	
	const boardId = boardKey.value;
	
	try {
		const response = await fetch(`/api/board/${boardId}/comment`, {
			method: "POST", 
			headers: {
				"X-Requested-With": "XMLHttpRequest",   // 서버로 비동기 요청임을 전달
				"Content-Type": "application/json"		// 서버로 전달되는 데이터가 json 임을 알림
			}, 
			body: JSON.stringify({content}) // {content: content}
		});
		
		const result = await response.json();
		
		if (!response.ok || !result.success) {
			alert(result.message || "댓글 등록에 실패했습니다.");
			return;
		}
		
		// TODO: 응답 결과를 화면에 표시
	} catch (error) {
		alert("댓글 등록 중 오류가 발생했습니다.");
	}
});














