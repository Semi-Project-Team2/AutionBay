// 아이디 중복 체크
let checkId = null;		// 아이디 중복체크 값
const checkIdResult = document.querySelector("#check-id-result");
const memberIdInput = document.querySelector("#user-id");
memberIdInput.addEventListener("input", function() {
    checkIdResult.textContent = "";
    checkId = null;
});
const checkIdBtn = document.querySelector("#check-id-btn");
checkIdBtn.addEventListener("click", async function() {
    const userId = memberIdInput.value.trim();
    // 아이디 값이 입력되지 않았을 경우, 요청 x
    if (userId.length === 0) {
        checkIdResult.textContent = "아이디를 입력해주세요.";
        checkIdResult.className = "form-tip form-tip-error";
        checkId = null;
        return;
    }
    try {
        const response = await fetch("/user/checkId?userId=" + encodeURIComponent(userId), {
            method: "GET",
            headers: { "X-Requested-With": "XMLHttpRequest" }
        });

        // response.json() : json 응답을 자바스크립트 객체로 변경
        const result = await response.json();

        // console.log(result);
        checkIdResult.textContent = result.message;
        checkIdResult.className = result.data ? "form-tip form-tip-error" : "form-tip form-tip-ok";

        checkId = result.data ? null : userId;
    } catch (error) {
        console.log(error);

        checkIdResult.textContent = "중복 확인 중 오류가 발생했습니다.";
        checkIdResult.className = "form-tip form-tip-error";

        checkId = null;
    }
});

// 프로필 이미지 미리보기
const profileImg = document.querySelector("#profile-image");
profileImg.addEventListener('change', function(e) {
	const file = e.target.files[0];
	if(!file){
		return;
	}
	
	const reader = new FileReader();
	reader.onload = function(e){
		const profilePreview = document.querySelector("#profile-preview");
		profilePreview.src = e.target.result;
		profilePreview.style.display = "block";
		
		document.querySelector("#profile-preview-placeholder").style.display = "none";
	}
	
	reader.readAsDataURL(file);
	

});

// 비밀번호 체크
const password = document.querySelector("#user-pwd");
const passwordConfirm = document.querySelector("#password-confirm");

let checkPwd = false;

function validatePwdConfirm(){
	const confirmResult = document.querySelector("#check-pwd-result");
	
	if (!passwordConfirm.value.trim()){
		confirmResult.textContent= "";
		checkPwd = false;
		return;
	}
	
	checkPwd = password.value === passwordConfirm.value;
	
	confirmResult.textContent = checkPwd ? "비밀번호가 일치합니다." : "비밀번호가 일치하지 않습니다";
	confirmResult.className = checkPwd ? "form-tip form-tip-ok" : "form-tip form-tip-error";
	
}

password.addEventListener('input', validatePwdConfirm);
passwordConfirm.addEventListener('input', validatePwdConfirm);


