const serverMessage = document.querySelector("#server-data").dataset.message;
if (serverMessage) {
    alert(serverMessage);
}
function toggleFinishedProducts() {
    const checkbox = document.getElementById('includeFinished');
    // hidden이나 다른 상태를 유지하며 폼 제출
    document.getElementById('page').value = 1;
    document.getElementById('searchForm').submit();
}
// 폼 제출(검색 버튼 클릭 등) 시 가격 입력창에 숫자만 들어가도록 최종 검증
document.getElementById('searchForm').addEventListener('submit', function(event) {
    const minPriceInput = document.getElementById('minPrice');
    const maxPriceInput = document.getElementById('maxPrice');
    
    if (minPriceInput) minPriceInput.value = minPriceInput.value.replace(/[^0-9]/g, '');
    if (maxPriceInput) maxPriceInput.value = maxPriceInput.value.replace(/[^0-9]/g, '');
});

function filterChange(type, value) {
    if (type === 'tradeType') {
        document.getElementById('tradeType').value = value;
    } else if (type === 'categoryId') {
        document.getElementById('categoryId').value = value;
    } else if (type === 'sortBy') {
        document.getElementById('sortBy').value = value;
    } else if (type === 'includeFinished') {
        document.getElementById('includeFinished').value = value;
    }
    document.getElementById('page').value = 1;
    document.getElementById('searchForm').submit();
}

function movePage(page) {
    document.getElementById('page').value = page;
    document.getElementById('searchForm').submit();
}

/* 가격 입력창에 숫자만 남기도록 정제하는 함수 (blur용) */
function formatNumberOnly(input) {
    input.value = input.value.replace(/[^0-9]/g, '');
}

/* 쪽지함 아이콘 위 '안읽음' 뱃지 */
function updateUnreadBadge() {
    fetch('${pageContext.request.contextPath}/message/unread-count')
        .then(response => {
            if (response.ok) return response.json();
            throw new Error('안읽음 뱃지 갱신 실패');
        })
        .then(unreadCount => {
            const badgeContainer = document.querySelector('a[href*="/message/received"]');
            if (!badgeContainer) return;
            let badge = badgeContainer.querySelector(".badge");
            if (unreadCount > 0) {
                const badgeText = unreadCount <= 99 ? unreadCount : '99+';
                if (badge) {
                    badge.innerText = badgeText;
                } else {
                    badge = document.createElement('span');
                    badge.className = 'badge';
                    badge.innerText = badgeText;
                    badgeContainer.appendChild(badge);
                }
            } else {
                if (badge) badge.remove();
            }
        })
        .catch(error => console.error('Error updating unread badge:', error));
}

document.addEventListener('DOMContentLoaded', updateUnreadBadge);
window.addEventListener('pageshow', function(event) {
    if (event.persisted || (performance.getEntriesByType("navigation")[0]?.type === "back_forward")) {
        updateUnreadBadge();
    }
});