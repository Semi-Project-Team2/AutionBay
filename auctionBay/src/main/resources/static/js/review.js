document.addEventListener('DOMContentLoaded', function() {
    const tabBtns = document.querySelectorAll(".tab-btn");
    const receivedArea = document.querySelector("#received-reviews-area"); // 받은 후기 감싸는 div ID
    const sentArea = document.querySelector("#sent-reviews-area");         // 보낸 후기 감싸는 div ID

    tabBtns.forEach(btn => {
        btn.addEventListener('click', function(e) {
            e.preventDefault();

            // 1. 탭 버튼 활성화 스타일 교체
            tabBtns.forEach(b => b.classList.remove('active'));
            this.classList.add('active');

            // 2. 받은/보낸 후기 영역 display 제어 (새로고침/비동기 요청 X)
            if (this.textContent.includes('받은 후기')) {
                if (receivedArea) receivedArea.style.display = 'block';
                if (sentArea) sentArea.style.display = 'none';
            } else {
                if (receivedArea) receivedArea.style.display = 'none';
                if (sentArea) sentArea.style.display = 'block';
            }
        });
    });

    // 제목 링크 클릭 시 카드 버블링 방지
    const titleLinks = document.querySelectorAll('.review-header .title');
    titleLinks.forEach(link => {
        link.addEventListener('click', function(e) {
            e.stopPropagation();
        });
    });
});