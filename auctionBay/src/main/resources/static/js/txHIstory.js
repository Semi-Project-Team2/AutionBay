/* 거래 내역 목록 페이지의 후기 작성 버튼 클릭 시 팝업 창 열기 */
const reviewBtns = document.querySelectorAll(".btn-review");

reviewBtns.forEach(btn => {
    btn.addEventListener("click", function (e) {
        e.preventDefault();     // 기본 링크 이동 막기

        // html의 href 속성(주소 + parameter)을 그대로 가져와서 팝업창 표시
        const url = this.getAttribute("href");

        // 팝업 창 옵션
        const reviewPopup = "width=500, height=500, scrollbars=yes";

        window.open(url, "리뷰 작성", reviewPopup);

    });
});

/* 거래내역 목록에서 검색 시 헤더의 검색창에 같은 키워드가 입력되는 것을 방지 */
document.addEventListener("DOMContentLoaded", function() {
    const headerInput = document.querySelector('header.header input[name="keyword"]');
    const mypageInput = document.querySelector("#mypageKeywordInput");

    if (headerInput && mypageInput) {
        headerInput.value = '';
    }
});

/* 후기 작성 버튼 제출 (팝업창 닫기, 부모 창(거래내역 목록 창) 새로고침 포함) */
const reviewForm = document.querySelector("#review-form");

if (reviewForm) {
    reviewForm.addEventListener("submit", async function(e) {
        e.preventDefault();

        const formData = new FormData(reviewForm);
        const historyId = reviewForm.querySelector('input[name="historyId"]').value;

        try {
            const response = await fetch(reviewForm.action, {
                method: "POST",
                body: formData,
                headers: {"X-Requested-With" : "XMLHttpRequest"}
            });

            const result = await response.json();

            if (result.message) {
                alert(result.message);
            }

            if (result.success) {
                // 부모 창이 열려 있다면 리로드 하여 후기 작성 완료됨을 반영
                if (window.opener && !window.opener.closed) {
                    // 부모 창 문서에서 해당 historyId와 연결된 후기 작성 버튼 탐색
                    // (※ 거래내역 JSP 구조에 맞춰 셀렉터를 확인해주세요. 예: a태그의 href에 historyId가 포함된 경우)
                    const parentDoc = window.opener.document;
                    const targetBtn = parentDoc.querySelector(`a.btn-review[href*="historyId=${historyId}"]`);
                    
                    if (targetBtn) {
                        // 1. 기존 btn-review 클래스를 삭제하고 review-completed 추가
                        targetBtn.classList.remove("btn-review");
                        targetBtn.classList.add("review-completed");

                        // 2. 텍스트 변경
                        targetBtn.textContent = "후기 작성 완료";

                        // 3. 더 이상 클릭 및 이동 못하게 처리
                        targetBtn.removeAttribute("href");
                        targetBtn.style.pointerEvents = "none";

                        // 4. 기존에 JS로 직접 넣었던 인라인 스타일이 있다면 전부 제거
                        targetBtn.style.backgroundColor = "";
                        targetBtn.style.color = "";
                        targetBtn.style.border = "";
                    } else {
                        // 만약 정확한 셀렉터를 찾기 힘들다면 안전하게 부모 창을 해당 페이지만 살짝 새로고침
                        window.opener.location.reload();
                    }
                }

                window.close();
            } else {
                if (result.message && result.message.includes("로그인")) {
                    window.opener.location.href = '/user/login';
                }
                window.close();
            }
        } catch (error) {
            console.error("후기 등록 오류: ", error);
            alert("후기 등록 중 오류가 발생했습니다.");
        }
    });
}