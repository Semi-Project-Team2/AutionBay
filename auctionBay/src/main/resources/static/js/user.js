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