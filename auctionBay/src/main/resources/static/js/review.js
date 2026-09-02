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

