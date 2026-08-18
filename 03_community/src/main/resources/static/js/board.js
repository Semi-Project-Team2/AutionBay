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




