/* 거래 내역 목록 페이지의 후기 작성 버튼 클릭 시 팝업 창 열기 */
const reviewBtns = document.querySelectorAll(".btn-review");

reviewBtns.forEach(btn => {
    btn.addEventListener("click", function (e) {
        e.preventDefault();    // 기본 링크 이동 막기

        // html의 href 속성(주소 + parameter)을 그대로 가져와서 팝업창 표시
        const url = this.getAttribute("href");

        // 팝업 창 옵션
        const reviewPopup = "width=500, height=500, scrollbars=yes";

        // 어떤 버튼에서 팝업을 열었는지 알 수 있도록 현재 버튼을 window 객체 등에 임시 저장 가능
        // 혹은 historyId를 추출해둘 수 있습니다.
        const urlParams = new URLSearchParams(url.split('?')[1]);
        const historyId = urlParams.get('historyId');
        if (historyId) {
            window.name = "parentWindow_" + historyId; // 예비용
        }

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

/* 후기 작성 버튼 제출 (팝업창 닫기 및 부모 창 버튼 상태 변경 포함) */
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
                // 부모 창(거래내역 페이지)이 열려있다면 해당 historyId를 가진 버튼을 찾아 변경
                if (window.opener && !window.opener.closed) {
                    // 부모 창 문서에서 해당 historyId와 연결된 후기 작성 버튼 탐색
                    // (※ 거래내역 JSP 구조에 맞춰 셀렉터를 확인해주세요. 예: a태그의 href에 historyId가 포함된 경우)
                    const parentDoc = window.opener.document;
                    const targetBtn = parentDoc.querySelector(`a.btn-review[href*="historyId=${historyId}"], button.btn-review[data-history-id="${historyId}"]`);
                    
                    if (targetBtn) {
                        targetBtn.textContent = "후기 작성 완료";
                        targetBtn.classList.add("completed"); // 필요시 클래스 추가
                        targetBtn.style.pointerEvents = "none"; // 클릭 방지
                        targetBtn.style.backgroundColor = "#ddd"; // 비활성화 느낌 색상
                        targetBtn.style.color = "#777";
                    } else {
                        // 만약 정확한 셀렉터를 찾기 힘들다면 안전하게 부모 창을 해당 페이지만 살짝 새로고침
                        window.opener.location.reload();
                    }
                }

                window.close();
            } else {
                if (result.message && result.message.includes("로그인")) {
                    if (window.opener) {
                        window.opener.location.href = '/user/login';
                    }
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
    if (type === 'received') {
        location.href = '/mypage/reviews?tab=received&page=1';
    } else if (type === 'sent') {
        location.href = '/mypage/reviews?tab=sent&page=1';
    }
}

document.addEventListener('DOMContentLoaded', function() {
    const tabBtns = document.querySelectorAll(".tab-btn");

    tabBtns.forEach(btn => {
        btn.addEventListener('click', function() {
            if (this.textContent.includes('받은 후기')) {
                switchTab('received');
            } else if (this.textContent.includes('보낸 후기')) {
                switchTab('sent');
            }
        });
    });
});

/* 별점 인터랙티브 기능 (0~10점 / 0.5 단위) */
document.addEventListener("DOMContentLoaded", function () {
    const halves = document.querySelectorAll("#star-container .half");
    const stars = document.querySelectorAll("#star-container .star");
    const starContainer = document.getElementById("star-container");
    const ratingInput = document.getElementById("rating");
    const ratingCount = document.getElementById("rating-count");

    let selectedValue = 0; // 최종 선택된 점수 (1 ~ 10)

    if (halves.length > 0) {
        halves.forEach(half => {
            const val = parseInt(half.getAttribute("data-val"));

            half.addEventListener("mouseenter", function () {
                highlightStars(val);
            });

            half.addEventListener("click", function () {
                selectedValue = val;
                ratingInput.value = selectedValue;
                ratingCount.textContent = selectedValue;
                highlightStars(selectedValue);
            });
        });

        starContainer.addEventListener("mouseleave", function () {
            highlightStars(selectedValue);
        });
    }

    function highlightStars(score) {
        stars.forEach((star, index) => {
            const starMaxVal = (index + 1) * 2; 
            
            star.classList.remove("full", "half-filled", "empty");

            if (score >= starMaxVal) {
                star.classList.add("full");
            } else if (score === starMaxVal - 1) {
                star.classList.add("half-filled");
            } else {
                star.classList.add("empty");
            }
        });
    }
});