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

    // 2. [핵심] 사이드바 메뉴 클릭 시 페이지 전체 새로고침(깜빡임) 방지
    sidebarItems.forEach(item => {
        item.addEventListener("click", function(e) {
            const url = this.getAttribute("href");

            // 외부 링크나 빈 값은 제외
            if (!url || url === "#" || url.startsWith("javascript:")) return;

            // 1) 브라우저의 기본 페이지 새로고침(하얀 화면 깜빡임) 강제 차단
            e.preventDefault();

            // 2) 사이드바 active 메뉴 표시 전환
            sidebarItems.forEach(el => el.classList.remove("active"));
            this.classList.add("active");

            // 3) 비동기(fetch)로 우측 컨텐츠 영역만 가져와서 교체
            loadMypageContent(url);
        });
    });

    // 3. 카드 클릭 시 상세 페이지 이동
    const clickableCards = document.querySelectorAll(".board-card, .product-card");

    clickableCards.forEach(card => {
        card.addEventListener("click", function(e) {
            if (e.target.tagName.toLowerCase() !== 'a') {
                const url = this.getAttribute("data-url");
                if (url) {
                    location.href = url;
                }
            }
        });
    });

});

// 사이드바 비동기 컨텐츠 로더 함수
function loadMypageContent(url) {
    fetch(url, {
        headers: { 'X-Requested-With': 'XMLHttpRequest' }
    })
    .then(response => {
        if (!response.ok) throw new Error("페이지 로드 실패");
        return response.text();
    })
    .then(html => {
        const parser = new DOMParser();
        const doc = parser.parseFromString(html, 'text/html');

        // 우측 메인 컨텐츠 박스 영역만 찾아 쏙 교체 (클래스명이 다르면 수정 필요)
        const targetContainer = document.querySelector('.mypage-content-area') || document.querySelector('.mypage-content');
        const newContainer = doc.querySelector('.mypage-content-area') || doc.querySelector('.mypage-content');

        if (targetContainer && newContainer) {
            targetContainer.innerHTML = newContainer.innerHTML;
            // 브라우저 주소창 URL만 자연스럽게 변경
            window.history.pushState({}, '', url);
        } else {
            // 영역을 못 찾으면 어쩔 수 없이 일반 이동
            location.href = url;
        }
    })
    .catch(err => {
        console.error("마이페이지 로딩 오류:", err);
        location.href = url; // 실패 시 안전하게 일반 이동
    });
}