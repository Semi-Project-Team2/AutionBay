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

/* 후기 작성 버튼 제출 (팝업창 닫기 포함) */
const reviewForm = document.querySelector("#review-form");

if (reviewForm) {
    reviewForm.addEventListener("submit", async function(e) {
        e.preventDefault();

        const formData = new FormData(reviewForm);

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
                if (window.opener) {
                    window.opener.location.href='/mypage/txHistories';
                }

                window.close();
            } else {
                if (result.message && result.message.includes("로그인")) {
                    window.opener.location.href = '/user/login';
                    window.close();
                }
            }
        } catch (error) {
            console.error("후기 등록 오류: ", error);
            alert("후기 등록 중 오류가 발생했습니다.");
        }
    });
}

/* 후기 목록 페이지 받은/보낸 후기 탭 전환 */
function switchTab(type, event) {
    // 자바스크립트로 숨기기/보내기 처리하는 대신, 
    // 아예 해당 탭의 1페이지로 페이지를 이동(새로고침)시킵니다!
    if (type === 'received') {
        location.href = '/mypage/reviews?tab=received&page=1';
    } else if (type === 'sent') {
        location.href = '/mypage/reviews?tab=sent&page=1';
    }
}

// DOM이 완전히 로드된 후 실행
document.addEventListener('DOMContentLoaded', function() {
    const tabBtns = document.querySelectorAll(".tab-btn");

    tabBtns.forEach(btn => {
        btn.addEventListener('click', function() {
            // 각 버튼에 표시되는 텍스트로 구분
            if (this.textContent.includes('받은 후기')) {
                switchTab('received');
            } else if (this.textContent.includes('보낸 후기')) {
                switchTab('sent');
            }
        });
    });
});
