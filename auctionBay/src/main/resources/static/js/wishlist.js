// ----------------------------------------------------
// 찜하기 버튼 토글 제어용
const wishBtn = document.getElementById('wishBtn');

if (wishBtn) {
    wishBtn.addEventListener('click', async function() {
        // data-product-id 속성에서 상품 번호 가져오기
        const productId = this.dataset.productId; 

        if (!productId) {
            console.error("상품 번호(productId)를 찾을 수 없습니다.");
            return;
        }

        try {
            const response = await fetch('/auction/wish', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json',
                },
                body: JSON.stringify({ productId: Number(productId) }) // 숫자로 변환해서 전달
            });

            const result = await response.json();

            if (!response.ok || !result.success) {
                alert(result.message || "찜목록 처리 중 오류가 발생했습니다.");
                return;
            }
            
            // 하트 아이콘 토글 처리 (폰트어썸 클래스 변경)
            const icon = wishBtn.querySelector('i');
            if (icon) {
                // 서버에서 돌려준 boolean 값(result.data): true면 찜 완료, false면 찜 취소
                if (result.data) { 
                    icon.classList.remove('fa-regular');
                    icon.classList.add('fa-solid'); // 채워진 하트
                } else {            
                    icon.classList.remove('fa-solid');
                    icon.classList.add('fa-regular'); // 빈 하트
                }
            }
        } catch (error) {
            console.error('Error:', error);
            alert("네트워크 오류가 발생했습니다.");
        }
    });
}

/* 쪽지함 아이콘 위 '안읽음' 뱃지 */
function updateUnreadBadge() {
    fetch(contextPath + '/message/unread-count')
        .then(response => {
            if (response.ok) {
                return response.json();
            }
            throw new Error('안읽음 뱃지 갱신 실패');
        })
        .then(unreadCount => {
            // 쪽지함 a 태그 내의 뱃지 요소
            const badgeContainer = document.querySelector('a[href*="/message/received"]');
            if (!badgeContainer) return;

            let badge = badgeContainer.querySelector(".badge");

            if (unreadCount > 0) {
                const badgeText = unreadCount <= 99 ? unreadCount : '99+';
                if (badge) {
                    badge.innerText = badgeText;
                } else {
                    // 뱃지가 없는데 개수가 생겼다면 새로 생성해서 추가
                        badge = document.createElement('span');
                        badge.className = 'badge';
                        badge.innerText = badgeText;
                        badgeContainer.appendChild(badge);
                }
            } else {
                if (badge) {
                    // unreadCount = 0이면 뱃지 삭제
                    badge.remove();
                }
            }
        })
            .catch(error => console.error('Error updating unread badge:', error));
    }

    // 1. 페이지가 처음 로드될 때 실행
    document.addEventListener('DOMContentLoaded', updateUnreadBadge);

    // 2. 뒤로 가기(bfcache)로 페이지가 복원될 때도 비동기로 실행
    window.addEventListener('pageshow', function(event) {
        if (event.persisted || (performance.getEntriesByType("navigation")[0]?.type === "back_forward")) {
            updateUnreadBadge();
        }
    });