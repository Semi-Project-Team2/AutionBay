/********* 회원가입 페이지 *********/

// 프로필 이미지 미리보기(프리뷰)
const profileImage = document.querySelector("#profile-image");

profileImage.addEventListener('change', function(e) {
	// 업로드한 파일 정보를 가지고 옴 (첫번째 요소)
	const file = e.target.files[0];
	if (!file) {
		return;
	}
	
	// FileReader : 아직 서버에 업로드하지 않은 파일을 브라우저 메모리에 올리기위해
	//				base64 라는 문자열로 만들어주는 객체
	const reader = new FileReader();
	reader.onload = function(e) {
		
		// 프로필 미리보기 영역에 변환된 이미지 파일을 표시
		const profilePreview = document.querySelector("#profile-preview");
		profilePreview.src = e.target.result;
		profilePreview.style.display = "block";
		
		// 이미지가 없을 경우 표시되는 영역은 display:none 변경
		document.querySelector("#profile-preview-placeholder").style.display = "none";
	}
	
	reader.readAsDataURL(file);		// 업로드한 파일을 base64방식으로 변경
	
});



