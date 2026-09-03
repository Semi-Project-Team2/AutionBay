document.addEventListener('DOMContentLoaded', function() {
    const tabBtns = document.querySelectorAll(".tab-btn");
    const receivedSection = document.getElementById("receivedSection");
    const sentSection = document.getElementById("sentSection");

    tabBtns.forEach(btn => {
        btn.addEventListener('click', function(e) {
            e.preventDefault();

            // 1. 모든 탭 버튼 및 섹션의 active 클래스 제거
            tabBtns.forEach(b => b.classList.remove('active'));
            if (receivedSection) receivedSection.classList.remove('active');
            if (sentSection) sentSection.classList.remove('active');

            // 2. 클릭된 탭과 해당 섹션에 active 클래스 추가
            this.classList.add('active');
            
            if (this.textContent.includes('받은 후기')) {
                if (receivedSection) receivedSection.classList.add('active');
            } else {
                if (sentSection) sentSection.classList.add('active');
            }
        });
    });

    // 제목 링크 클릭 시 이벤트 버블링 방지
    const titleLinks = document.querySelectorAll('.review-header .title');
    titleLinks.forEach(link => {
        link.addEventListener('click', function(e) {
            e.stopPropagation();
        });
    });
});