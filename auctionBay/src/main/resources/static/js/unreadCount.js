document.addEventListener("DOMContentLoaded", function () {
    updateUnreadMessageCount();
});

function updateUnreadMessageCount() {
    // 맨 앞에 /를 붙인 루트 상대 경로 사용 (Spring 컨트롤러 URL과 100% 일치)
    fetch('/message/unread-count')
        .then(response => {
            // 1. 비로그인 상태(401)일 경우 에러 처리 없이 종료
            if (response.status === 401) {
                return null;
            }
            // 2. 그 외 200 OK가 아니면 에러 처리
            if (!response.ok) {
                throw new Error(`HTTP 에러: ${response.status}`);
            }
            return response.json();
        })
        .then(count => {
            if (count === null) return; // 비로그인은 스킵

            const headerMsgBtn = document.querySelector('.header-msg-btn');
            const quickMsgBtn = document.querySelector('.right-quick-menu a[href*="/message/"]');
            const displayCount = count > 99 ? '99+' : count;

            // 1. 헤더 뱃지 업데이트
            if (headerMsgBtn) {
                let headerBadge = headerMsgBtn.querySelector('.header-badge');
                if (count > 0) {
                    if (!headerBadge) {
                        headerBadge = document.createElement('span');
                        headerBadge.className = 'header-badge';
                        headerMsgBtn.appendChild(headerBadge);
                    }
                    headerBadge.textContent = displayCount;
                } else if (headerBadge) {
                    headerBadge.remove();
                }
            }

            // 2. 우측 퀵메뉴 뱃지 업데이트
            if (quickMsgBtn) {
                let quickBadge = quickMsgBtn.querySelector('.badge');
                if (count > 0) {
                    if (!quickBadge) {
                        quickBadge = document.createElement('span');
                        quickBadge.className = 'badge';
                        quickMsgBtn.appendChild(quickBadge);
                    }
                    quickBadge.textContent = displayCount;
                } else if (quickBadge) {
                    quickBadge.remove();
                }
            }
        })
        .catch(error => {
            console.error('뱃지 갱신 처리 실패:', error);
        });
}