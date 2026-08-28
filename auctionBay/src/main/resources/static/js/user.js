// 아이디 중복 체크
let checkId = null;		// 아이디 중복체크 값
const checkIdResult = document.querySelector("#check-id-result");
const userIdInput = document.querySelector("#user-id");
userIdInput.addEventListener("input", function() {
    checkIdResult.textContent = "";
    checkId = null;
});



const checkIdBtn = document.querySelector("#check-id-btn");
checkIdBtn.addEventListener("click", async function() {
    const userId = userIdInput.value.trim();
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

// 닉네임 중복 체크
let checkNickname = null;
const checkNicknameResult = document.querySelector("#check-nickname-result");
const nicknameInput = document.querySelector("#nickname");
nicknameInput.addEventListener("input", function(){
	checkNicknameResult.textContent = "";
	checkNickname = null;
});

const checkNicknameBtn = document.querySelector("#check-nickname-btn");
checkNicknameBtn.addEventListener("click", async function() {
    const nickname = nicknameInput.value.trim();
    
	if (nickname.length === 0) {
        checkNicknameResult.textContent = "닉네임을 입력해주세요.";
        checkNicknameResult.className = "form-tip form-tip-error";
        checkNickname = null;
        return;
    }
    try {
        const response = await fetch("/user/checkNickname?nickname=" + encodeURIComponent(nickname), {
            method: "GET",
            headers: { "X-Requested-With": "XMLHttpRequest" }
        });

        // response.json() : json 응답을 자바스크립트 객체로 변경
        const result = await response.json();

        // console.log(result);
        checkNicknameResult.textContent = result.message;
        checkNicknameResult.className = result.data ? "form-tip form-tip-error" : "form-tip form-tip-ok";

        checkNickname = result.data ? null : nickname;
    } catch (error) {
        console.log(error);

        checkNicknameResult.textContent = "중복 확인 중 오류가 발생했습니다.";
        checkNicknameResult.className = "form-tip form-tip-error";

        checkNickname = null;
    }
});

// 이메일 중복 체크
let checkEmail = null;
const checkEmailResult = document.querySelector("#check-email-result");
const emailInput = document.querySelector("#email");
emailInput.addEventListener("input", function(){
	checkEmailResult.textContent = "";
	checkEmail = null;
});

const checkEmailBtn = document.querySelector("#check-email-btn");
checkEmailBtn.addEventListener("click", async function() {
    const email = emailInput.value.trim();
    
	if (email.length === 0) {
        checkEmailResult.textContent = "닉네임을 입력해주세요.";
        checkEmailResult.className = "form-tip form-tip-error";
        checkEmail = null;
        return;
    }
    try {
        const response = await fetch("/user/checkEmail?email=" + encodeURIComponent(email), {
            method: "GET",
            headers: { "X-Requested-With": "XMLHttpRequest" }
        });

        const result = await response.json();

        checkEmailResult.textContent = result.message;
        checkEmailResult.className = result.data ? "form-tip form-tip-error" : "form-tip form-tip-ok";

        checkEmail = result.data ? null : email;
    } catch (error) {
        console.log(error);

        checkEmailResult.textContent = "중복 확인 중 오류가 발생했습니다.";
        checkEmailResult.className = "form-tip form-tip-error";

        checkEmail = null;
    }
});

// 연락처 중복 체크
let checkPhoneNumber = null;
const checkPhoneNumberResult = document.querySelector("#check-phoneNumber-result");
const phoneNumberInput = document.querySelector("#phoneNumber");
phoneNumberInput.addEventListener("input", function(){
	checkPhoneNumberResult.textContent = "";
	checkPhoneNumber = null;
});

const checkPhoneNumberBtn = document.querySelector("#check-phoneNumber-btn");
checkPhoneNumberBtn.addEventListener("click", async function() {
    const phoneNumber = phoneNumberInput.value.trim();
    
	if (phoneNumber.length === 0) {
        checkPhoneNumberResult.textContent = "번호를 입력해주세요.";
        checkPhoneNumberResult.className = "form-tip form-tip-error";
        checkPhoneNumber = null;
        return;
    }
    try {
        const response = await fetch("/user/checkPhoneNumber?phoneNumber=" + encodeURIComponent(phoneNumber), {
            method: "GET",
            headers: { "X-Requested-With": "XMLHttpRequest" }
        });

        const result = await response.json();

        checkPhoneNumberResult.textContent = result.message;
        checkPhoneNumberResult.className = result.data ? "form-tip form-tip-error" : "form-tip form-tip-ok";

        checkPhoneNumber = result.data ? null : phoneNumber;
    } catch (error) {
        console.log(error);

        checkPhoneNumberResult.textContent = "중복 확인 중 오류가 발생했습니다.";
        checkPhoneNumberResult.className = "form-tip form-tip-error";

        checkPhoneNumber = null;
    }
});


// 프로필 이미지 미리보기

const profileImg = document.querySelector("#profile-image");
const profilePreview = document.querySelector("#profile-preview");

profileImg.addEventListener("change", function(e) {

    const file = e.target.files[0];

    // 파일을 선택하지 않은 경우 기본 이미지
    if (!file) {
        profilePreview.src =  "/uploads/profile/default-profile.png";
        return;
    }

    const reader = new FileReader();

    reader.onload = function(e) {
        profilePreview.src = e.target.result;
    };

    reader.readAsDataURL(file);

});

// 프로필 이미지 초기화

const resetProfileBtn = document.querySelector("#reset-profile-btn");

resetProfileBtn.addEventListener("click", function() {

    // 선택한 파일 초기화
    profileImg.value = "";

    // 기본 프로필 이미지로 변경
    profilePreview.src = "/uploads/profile/default-profile.png";

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

const joinForm = document.querySelector("#join-form");
joinForm.addEventListener("submit", function(e) {
	
	if (!checkId) {
		e.preventDefault();
		alert("아이디 중복확인을 진행해주세요.");
		return;
	}
	
	if (!checkNickname) {
		e.preventDefault();
		alert("닉네임 중복확인을 진행해주세요.");
		return;
	}
	
	if (!checkEmail) {
		e.preventDefault();
		alert("이메일 중복확인을 진행해주세요.");
		return;
	}
	
	if (!checkPwd) {
		e.preventDefault();		// 기존 폼 제출 동작을 막기!
		alert("비밀번호가 일치하지 않습니다.");
		return;
	}
	
});
