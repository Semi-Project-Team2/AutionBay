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
