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
