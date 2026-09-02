document.addEventListener("DOMContentLoaded", function () {

    /* 1. 거래내역 목록에서 검색 시 헤더 검색창 키워드 초기화 */
    const headerInput = document.querySelector('header.header input[name="keyword"]');
    const mypageInput = document.querySelector("#mypageKeywordInput");

    if (headerInput && mypageInput) {
        headerInput.value = '';
    }

    /* 2. 후기 작성 버튼 클릭 시 팝업 창 열기 */
    const reviewBtns = document.querySelectorAll(".btn-review");

    reviewBtns.forEach(btn => {
        btn.addEventListener("click", function (e) {
            e.preventDefault(); // 기본 링크 이동 막기

            const url = this.getAttribute("href");
            const reviewPopup = "width=500, height=500, scrollbars=yes";

            window.open(url, "리뷰 작성", reviewPopup);
        });
    });
});

/* 3. 후기 작성 폼 제출 (팝업창 전용) */
const reviewForm = document.querySelector("#review-form");

if (reviewForm) {
    reviewForm.addEventListener("submit", async function (e) {
        e.preventDefault();

        const formData = new FormData(reviewForm);

        try {
            const response = await fetch(reviewForm.action, {
                method: "POST",
                body: formData,
                headers: { "X-Requested-With": "XMLHttpRequest" }
            });

            const result = await response.json();

            if (result.message) {
                alert(result.message);
            }

            if (result.success) {
                // 부모 창(거래내역 목록)이 있다면 강력 새로고침으로 JSP를 다시 로드
                if (window.opener && !window.opener.closed) {
                    window.opener.location.href = window.opener.location.href; 
                }
                // 팝업창 닫기
                window.close();
            } else {
                if (result.message && result.message.includes("로그인")) {
                    if (window.opener && !window.opener.closed) {
                        window.opener.location.href = '/user/login';
                    }
                }
                window.close();
            }
        } catch (error) {
            console.error("후기 등록 오류: ", error);
            console.error(error.message);
            alert("후기 등록 중 오류가 발생했습니다.");
        }
    });
}

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