/**
 * 마이페이지 조회 전용 공통 자바스크립트 (mypage.js)
 */
document.addEventListener("DOMContentLoaded", function() {
    
    // 1. 현재 URL을 인식해서 사이드바 메뉴에 자동으로 active 클래스 붙여주기
    const currentPath = window.location.pathname;
    const sidebarItems = document.querySelectorAll(".mypage-sidebar .sidebar-item, .sidebar li a");

    sidebarItems.forEach(item => {
        const href = item.getAttribute("href");
        if (href && currentPath.includes(href)) {
            sidebarItems.forEach(el => el.classList.remove("active"));
            item.classList.add("active");
        }
    });

    // 2. 최근 본 글, 찜목록, 게시글/댓글 카드를 누르면 상세 페이지로 부드럽게 이동하기
    // (JSP에서 onclick 속성을 일일이 안 넣어도 data-url 속성만 읽어서 이동하게 만들어 줍니다)
    const clickableCards = document.querySelectorAll(".board-card, .product-card");

    clickableCards.forEach(card => {
        card.addEventListener("click", function(e) {
            // 안쪽에 따로 링크(a태그)가 걸려있지 않은 경우에만 카드 전체 클릭 작동
            if (e.target.tagName.toLowerCase() !== 'a') {
                const url = this.getAttribute("data-url");
                if (url) {
                    location.href = url;
                }
            }
        });
    });

});