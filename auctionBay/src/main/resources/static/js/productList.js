		const serverMessage = document.querySelector("#server-data").dataset.message;
	    if (serverMessage) {
	        alert(serverMessage);
	    }
		function toggleFinishedProducts() {
	        const checkbox = document.getElementById('includeFinished');
	        document.getElementById('page').value = 1;
	        document.getElementById('searchForm').submit();
	    }

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

	    function formatNumberOnly(input) {
	        input.value = input.value.replace(/[^0-9]/g, '');
	    }

	    /* 상품 카드 찜 버튼 클릭 이벤트 (상세 페이지 이동 방지 및 비동기 처리) */
	    function toggleWish(event, button) {
	        event.stopPropagation(); // 카드 전체에 걸린 상세페이지 이동 링크 이벤트 전파 차단
	        event.preventDefault();

	        const productId = button.getAttribute('data-product-id');

	        fetch('${pageContext.request.contextPath}/mypage/wishlist/toggle', {
	            method: 'POST',
	            headers: {
	                'Content-Type': 'application/x-www-form-urlencoded',
	            },
	            body: 'productId=' + encodeURIComponent(productId)
	        })
	        .then(response => {
	            if (response.ok) return response.json();
	            throw new Error('찜 요청 실패');
	        })
	        .then(data => {
	            if (data.status === 'added') {
	                button.classList.add('active');
	            } else if (data.status === 'removed') {
	                button.classList.remove('active');
	            } else if (data.status === 'login_required' || data === false) {
	                alert('로그인이 필요한 서비스입니다.');
	            }
	        })
	        .catch(error => {
	            console.error('Error:', error);
	            alert('찜 처리 중 오류가 발생했습니다.');
	        });
	    }

		/* 쪽지함 아이콘 위 '안읽음' 뱃지 */
    function updateUnreadBadge() {
        fetch('${pageContext.request.contextPath}/message/unread-count')
            .then(response => {
                if (response.ok) return response.json();
                throw new Error('안읽음 뱃지 갱신 실패');
            })
            .then(unreadCount => {
                const badgeContainers = document.querySelectorAll('a[href="/message/received"]');
                badgeContainers.forEach(badgeContainer => {
                    let badge = badgeContainer.querySelector(".badge, .header-badge");
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
                });
            })
            .catch(error => console.error('Error updating unread badge:', error));
    }

	    document.addEventListener('DOMContentLoaded', updateUnreadBadge);
	    window.addEventListener('pageshow', function(event) {
	        if (event.persisted || (performance.getEntriesByType("navigation")[0]?.type === "back_forward")) {
	            updateUnreadBadge();
	        }
	    });
		/* 상품 카드 찜 버튼 클릭 이벤트 (참고용 코드 스타일 적용) */
	    async function toggleWish(event, button) {
	        event.stopPropagation(); // 카드 전체에 걸린 상세페이지 이동 링크 이벤트 전파 차단
	        event.preventDefault();

	        const productId = button.getAttribute('data-product-id');
	        const icon = button.querySelector('.heart-icon'); // SVG 또는 i 태그 모두 대응 가능하도록 수정

	        try {
	            const response = await fetch('/api/board/wish', {
	                method: 'POST',
	                headers: {
	                    'Content-Type': 'application/json',
	                },
	                body: JSON.stringify({ productId: productId })
	            });

	            const result = await response.json();

	            if (!response.ok || !result.success) {
	                // 로그인 필요 등의 메시지가 result.message로 넘어올 경우 처리
	                alert(result.message || "찜목록 처리 중 오류가 발생했습니다.");
	                return;
	            }

	            // 서버에서 보내주는 찜 상태(true: 찜 추가됨, false: 찜 취소됨)에 따른 UI 변경
	            if (result.data) {
	                button.classList.add('active');
	            } else {
	                button.classList.remove('active');
	            }

	        } catch (error) {
	            console.error('Error:', error);
	            alert("네트워크 오류 발생");
	        }
	    }