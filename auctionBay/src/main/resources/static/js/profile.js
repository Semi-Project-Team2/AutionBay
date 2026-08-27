/* 프로필 수정 페이지 전용 js */

/* 닉네임 중복 체크 */
const checkNicknameResult = document.querySelector("#check-nickname-result");
const nicknameInput = document.querySelector("#nickname");
const checkNicknameBtn = document.querySelector("#check-nickname-btn");

// 페이지 로드 시점에 사용자의 원래 닉네임을 백업 (공백 제거)
const originalNickname = nicknameInput ? nicknameInput.value.trim() : "";

// 닉네임 중복체크 값은 처음 시작 시 '원래 닉네임'으로 세팅 (수정 안 한 상태에서는 통과 가능)
let checkNickname = originalNickname;

nicknameInput.addEventListener("input", function() {
    const currentNickname = nicknameInput.value.trim();
    
    // 입력한 닉네임이 원래 닉네임과 같을 경우, 수정을 안 한 것과 동일하게 통과 처리
    if (currentNickname === originalNickname) {
        checkNicknameResult.textContent = "변경 사항이 없습니다.";
        checkNicknameResult.className = "form-tip form-tip-ok";
        checkNickname = currentNickname;
    } else {
        // 글자가 바뀌었는데 아직 중복 체크가 안 되었다면 초기화
        checkNicknameResult.textContent = "중복확인을 해주세요";
        checkNicknameResult.className = "form-tip form-tip-error";
        checkNickname = null;
    }
});

// 중복확인 버튼 클릭 시
checkNicknameBtn.addEventListener("click", async function() {
    const nickname = nicknameInput.value.trim();

    // 닉네임 입력값이 빈 문자열(또는 공백만 입력된 문자열)일 경우 요청하지 않음
    if (nickname.length === 0) {
        checkNicknameResult.textContent = "닉네임을 입력해주세요.";
        checkNicknameResult.className = "form-tip form-tip-error";
        checkNickname = null;
        return;
    }

    if (nickname === originalNickname) {
        checkNicknameResult.textContent = "변경 사항이 없습니다.";
        checkNicknameResult.className = "form-tip form-tip-ok";
        checkNickname = nickname;
        return;
    }

    try {   // encodeURIComponent: 특수문자(&,= 등) 깨짐 방지
        const response 
            = await fetch("/mypage/checkNickname?nickname=" + encodeURIComponent(nickname), {
                method: "GET",
                headers: {"X-Requested-With" : "XMLHttpRequest"}
                // 비동기 요청임을 서버에 알려주는 헤더
        });

        // 서버가 보낸 JSON 응답 데이터를 자바스크립트 객체(result)로 반환
        // 이 result가 ApiResponse 객체 (여기서는 ApiResponse<Boolean>)
        const result = await response.json();

        // 컨트롤러에서 받아온 message를 중복확인 결과 영역에 삽입
        checkNicknameResult.textContent = result.message;

        // result.data: ApiResponse 객체 안에 들어 있는 데이터(isDuplicate: true/false)
        checkNicknameResult.className 
                = result.data ? "form-tip form-tip-error" : "form-tip form-tip-ok";
        
        // 중복 여부 검증용 데이터에 result.data 값에 따른 값 대입              
        checkNickname = result.data ? null : nickname;
    } catch (error) {
        checkNicknameResult.textContent = "중복 확인 불가";
        checkNicknameResult.className = "form-tip form-tip-error";

        checkNickname = null;
    }

});


// ---------------------------------------------------------------------------------------
/* 연락처 중복 체크 */
const checkPhoneNumberResult = document.querySelector("#check-phoneNumber-result");
const phoneNumberInput = document.querySelector("#phoneNumber");
const checkPhoneNumberBtn = document.querySelector("#check-phoneNumber-btn");

// 페이지 로드 시점에 사용자의 원래 연락처를 백업 (공백 제거)
const originalPhoneNumber = phoneNumberInput ? phoneNumberInput.value.trim() : "";

// 연락처 중복체크 값은 처음 시작 시 '원래 연락처'로 세팅 (수정 안 한 상태에서는 통과 가능)
let checkPhoneNumber = originalPhoneNumber;

phoneNumberInput.addEventListener("input", function() {
    const currentPhoneNumber = phoneNumberInput.value.trim();
    
    // 입력한 연락처가 원래 연락처와 같을 경우, 수정을 안 한 것과 동일하게 통과 처리
    if (currentPhoneNumber === originalPhoneNumber) {
        checkPhoneNumberResult.textContent = "변경 사항이 없습니다.";
        checkPhoneNumberResult.className = "form-tip form-tip-ok";
        checkPhoneNumber = currentPhoneNumber;
    } else {
        // 글자가 바뀌었는데 아직 중복 체크가 안 되었다면 초기화
        checkPhoneNumberResult.textContent = "중복확인을 해주세요";
        checkPhoneNumberResult.className = "form-tip form-tip-error";
        checkPhoneNumber = null;
    }
});

// 중복확인 버튼 클릭 시
checkPhoneNumberBtn.addEventListener("click", async function() {
    const phoneNumber = phoneNumberInput.value.trim();

    // 연락처 입력값이 빈 문자열일 경우 요청하지 않음
    if (phoneNumber.length === 0) {
        checkPhoneNumberResult.textContent = "연락처를 입력해주세요.";
        checkPhoneNumberResult.className = "form-tip form-tip-error";
        checkPhoneNumber = null;
        return;
    }

    if (phoneNumber === originalPhoneNumber) {
        checkPhoneNumberResult.textContent = "변경 사항이 없습니다.";
        checkPhoneNumberResult.className = "form-tip form-tip-ok";
        checkPhoneNumber = phoneNumber;
        return;
    }

    try {    
        const response 
            = await fetch("/mypage/checkPhoneNumber?phoneNumber=" + encodeURIComponent(phoneNumber), {
                method: "GET",
                headers: {"X-Requested-With" : "XMLHttpRequest"}
        });

        const result = await response.json();

        checkPhoneNumberResult.textContent = result.message;

        checkPhoneNumberResult.className 
                = result.data ? "form-tip form-tip-error" : "form-tip form-tip-ok";
              
        checkPhoneNumber = result.data ? null : phoneNumber;
    } catch (error) {
        checkPhoneNumberResult.textContent = "중복 확인 불가";
        checkPhoneNumberResult.className = "form-tip form-tip-error";

        checkPhoneNumber = null;
    }
});

// ------------------------------------------------------------------------------------------
/* 이메일 중복 체크 */
const checkEmailResult = document.querySelector("#check-email-result");
const emailInput = document.querySelector("#email");
const checkEmailBtn = document.querySelector("#check-email-btn");

// 페이지 로드 시점에 사용자의 원래 이메일을 백업 (공백 제거)
const originalEmail = emailInput ? emailInput.value.trim() : "";

// 이메일 중복체크 값은 처음 시작 시 '원래 이메일'로 세팅 (수정 안 한 상태에서는 통과 가능)
let checkEmail = originalEmail;

emailInput.addEventListener("input", function() {
    const currentEmail = emailInput.value.trim();
    
    // 입력한 이메일이 원래 이메일과 같을 경우, 수정을 안 한 것과 동일하게 통과 처리
    if (currentEmail === originalEmail) {
        checkEmailResult.textContent = "변경 사항이 없습니다.";
        checkEmailResult.className = "form-tip form-tip-ok";
        checkEmail = currentEmail;
    } else {
        // 글자가 바뀌었는데 아직 중복 체크가 안 되었다면 초기화
        checkEmailResult.textContent = "중복확인을 해주세요";
        checkEmailResult.className = "form-tip form-tip-error";
        checkEmail = null;
    }
});

// 중복확인 버튼 클릭 시
checkEmailBtn.addEventListener("click", async function() {
    const email = emailInput.value.trim();

    // 이메일 입력값이 빈 문자열일 경우 요청하지 않음
    if (email.length === 0) {
        checkEmailResult.textContent = "이메일을 입력해주세요.";
        checkEmailResult.className = "form-tip form-tip-error";
        checkEmail = null;
        return;
    }

    if (email === originalEmail) {
        checkEmailResult.textContent = "변경 사항이 없습니다.";
        checkEmailResult.className = "form-tip form-tip-ok";
        checkEmail = email;
        return;
    }

    try {    
        const response 
            = await fetch("/mypage/checkEmail?email=" + encodeURIComponent(email), {
                method: "GET",
                headers: {"X-Requested-With" : "XMLHttpRequest"}
        });

        const result = await response.json();

        checkEmailResult.textContent = result.message;

        checkEmailResult.className 
                = result.data ? "form-tip form-tip-error" : "form-tip form-tip-ok";
              
        checkEmail = result.data ? null : email;
    } catch (error) {
        checkEmailResult.textContent = "중복 확인 불가";
        checkEmailResult.className = "form-tip form-tip-error";

        checkEmail = null;
    }
});
// ----------------------------------------------------------------------------------------------
/* 프로필 이미지 미리보기 수정/삭제 시 반영 */
// jsp 문서가 완전히 로딩된 후에 이 스크립트 실행
document.addEventListener('DOMContentLoaded', function() {
    const profileImgInput = document.querySelector("#profile-image");
    const profilePreview = document.querySelector("#profile-preview");
    const resetProfileBtn = document.querySelector("#reset-profile-btn");
    const deleteProfileImgInput = document.querySelector("#deleteProfileImg");

    // 기본 이미지 경로 설정
    const defaultProfileImg = "/uploads/profile/default-profile.png";
    
    // 1. 프로필 이미지 파일 선택 시 실시간 미리보기
    if (profileImgInput) { 
        profileImgInput.addEventListener('change', function(e) {
            // 사용자가 선택한 첫 번째 파일을 가져옴
            const file = e.target.files[0];
            // file이 존재하지 않으면 메서드 종료, 선택 취소 시 중단
            if (!file) return;
            
            if (deleteProfileImgInput) {
                // 새 파일을 선택한 경우이므로 '삭제 안 함(false)' 처리
                deleteProfileImgInput.value = "false";
            }
            
            const reader = new FileReader();
            reader.onload = function(event) {
                if (profilePreview) {
                    profilePreview.src = event.target.result;
                }
            }
            reader.readAsDataURL(file);
        });
    }

    // 2. 프로필 이미지 삭제 시 기본 이미지로 프로필 미리보기 사진 변경
    if (resetProfileBtn) {
        resetProfileBtn.addEventListener('click', function() {
            if(deleteProfileImgInput) {
                // 프로필 삭제 신호 주기
                deleteProfileImgInput.value = "true";
            }

            if (profilePreview) {
                profilePreview.src = defaultProfileImg;
            }

            // 파일 input 값 초기화 (선택했던 파일 취소)
            if (profileImgInput) {
                profileImgInput.value = "";
            }
        });
    }
});
// ---------------------------------------------------------------------------------------------
/* 프로필 수정 폼 제출 시 비동기(fetch) 처리 */
const editForm = document.querySelector("#edit-form");

if (editForm) {
    editForm.addEventListener("submit", async function(e) {
        // 닉네임, 이메일, 연락처 중 하나라도 중복확인을 거치지 않으면(null이면) 제출 차단
        if (checkNickname === null || checkEmail === null || checkPhoneNumber === null) {
            e.preventDefault();
            alert("중복 확인이 완료되지 않았습니다.");

            if (checkNickname === null) {
                document.querySelector("#nickname").focus();
            } else if (checkEmail === null) {
                document.querySelector("#email").focus();
            } else if (checkPhoneNumber === null) {
                document.querySelector("#phoneNumber").focus();
            }
            
            return;
        }

        e.preventDefault();

        // 폼 태그 내부의 모든 입력값과 파일 데이터를 담을 객체 생성
        const formData = new FormData(editForm);

        try {
            // 컨트롤러로 비동기 POST 요청 전송
            // 파일이 포함되므로 body에 formData 통째로 전달
            const response = await fetch(editForm.action, {
                method: "POST",
                body: formData,
                headers: {"X-Requested-With" : "XMLHttpRequest"}
            });

            const result = await response.json();

            if (result.message) {   // 서버에서 보낸 메시지가 존재할 경우 alert 표시
                alert(result.message);
            }

            if (result.success) {
                location.href="/mypage/txHistories";
            } else {
                // 메시지가 "로그인"을 포함하면 로그인 페이지로 유도
                if (result.message && result.message.includes("로그인")) {
                    location.href="/user/login";
                }
            }
        } catch (error) {
            console.error("프로필 수정 오류: ", error);
            alert("프로필 수정 중 오류가 발생했습니다.");
        }
    });
}

