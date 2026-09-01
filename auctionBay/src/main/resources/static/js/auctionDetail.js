const isOwner = document.querySelector("#is-Owner-value").value === "true"; // 문자열을 boolean으로 변환

const serverMessage = document.querySelector("#server-data").dataset.message;

if (serverMessage) {
    alert(serverMessage);
}

// 댓글 기능
const commentForm = document.querySelector("#comment-form");
const productId = document.querySelector("#product-id-value").value;

if (commentForm) {
	commentForm.addEventListener("submit", async function(ev) {
		ev.preventDefault();	// 기본 이벤트를 막고 직접 처리
	
		const contentInput = commentForm.querySelector("textarea");
		const content = contentInput.value.trim();
		
		if (!content) {
			alert("댓글 내용을 입력해주세요.");
			return;
		}
		
		
		try {
			const response = await fetch(`/api/board/${productId}/comment`, {
				method: "POST", 
				headers: {
					"X-Requested-With": "XMLHttpRequest",   // 서버로 비동기 요청임을 전달
					"Content-Type": "application/json"		// 서버로 전달되는 데이터가 json 임을 알림
				}, 
				body: JSON.stringify({content}) // {content: content}
			});
			
			const result = await response.json();
			
			if (!response.ok || !result.success) {
				alert(result.message || "댓글 등록에 실패했습니다.");
				return;
			}
			
			// TODO: 응답 결과를 화면에 표시
			// alert("댓글 작성 성공");
			appendComment(result.data);
			console.log(result.data);
			contentInput.value = "";
			
		} catch (error) {
			alert("댓글 등록 중 오류가 발생했습니다.");
		}
	});
}

// 댓글 추가 시 화면에 표시
const commentList = document.querySelector("#comment-list");

function appendComment(comment) {
	// isDeleted가 1이면 화면에 표시하지 않고 종료
    if (comment.isDeleted === 1) {
        return;
    }
	// 템플릿 영역 접근
	const commentTemplate = document.querySelector("#comment-template");
	const cloneComment = commentTemplate.content.cloneNode(true);
	
	const li = cloneComment.querySelector("li");
	li.id = `comment-${comment.commentId}`;
	
	cloneComment.querySelector(".comment-list_writer").textContent = comment.writerNickname;
	cloneComment.querySelector(".comment-list_content").textContent = comment.content;
	cloneComment.querySelector(".comment-list_date").textContent = comment.createdAtStr;
	
	cloneComment.querySelector(".comment-delete-btn").dataset.commentId = comment.commentId;
	// => dataset 을 사용하면 data-* 속성으로 추가될 것임.
	
	commentList.appendChild(cloneComment);

    // 댓글 등록 시 개수 1 증가시키기
    const commentCountElem = document.querySelector("#comment-count");
    if (commentCountElem) {
        let currentCount = parseInt(commentCountElem.textContent.replace(/[^0-9]/g, '')) || 0;
        commentCountElem.textContent = currentCount + 1;
    }
}


// 댓글 영역에 표시되는 댓글 삭제 기능
if (commentList) {
	
	commentList.addEventListener("click", async function(e) {
		/*
			if (!e.target.classList.contains("comment-delete-btn")) return;
			
			const delBtn = e.target;
		*/
		
		// closest(선택자) : 클릭한 요소로부터 부모 방향으로 선택자에 해당하는 요소를 찾아줌
		const delBtn = e.target.closest(".comment-delete-btn");
		if (!delBtn) return;	// 삭제 버튼이 아니면 메소드 종료
		
		if (!confirm("댓글을 삭제하시겠습니까?")) return;
		
		const commentId = delBtn.dataset.commentId;
		try {
			const response = await fetch(`/api/comments/${commentId}`, {
				method: "DELETE",   // Restful 설계 원칙에 따라 요청 방식은 get, post, put, patch, delete로 나뉘어짐
				headers: {"X-Requested-With": "XMLHttpRequest"}
			});
			
			const result = await response.json();
			
			if (!response.ok || !result.success) {
				alert(result.message || "댓글 삭제에 실패했습니다.");
				return;
			} 
			
			// 화면상에서 해당 댓글 제거
			document.querySelector(`#comment-${commentId}`).remove();
            // 댓글 개수 실시간으로 1 감소시키기
            const commentCountElem = document.querySelector("#comment-count"); // 만약 클래스라면 ".comment-count"로 변경
            if (commentCountElem) {
                let currentCount = parseInt(commentCountElem.textContent.replace(/[^0-9]/g, '')) || 0;
                if (currentCount > 0) {
                    commentCountElem.textContent = currentCount - 1;
                }
            }
		} catch (error) {
			alert("댓글 삭제 중 오류가 발생했습니다.");
		}
	});	
	
}




// ----------------------------------------------------
// 남은시간 타이머

const auctionEndTime = document.querySelector('#auctionEndTime');
const remainingTime = document.querySelector('#remainingTime');
const btnSubmitBid = document.querySelector('#btnSubmitBid');


// HTML에 적힌 원본 텍스트를 const 변수에 저장 (.trim()으로 공백 제거)
const rawAuctionEndTime = auctionEndTime.textContent.trim();

if (rawAuctionEndTime) {
    // Date 객체 생성 (공백을 'T'로 교체)
    const endDate = new Date(rawAuctionEndTime.replace(" ", "T"));
    
    // 사용자용 한국어 날짜 포맷으로 변환 후 화면(textContent) 업데이트
    auctionEndTime.textContent = formatToKoreanDateTime(endDate);

    // 남은시간 타이머 실행
    startTimer(endDate.getTime());
}

// 날짜 포맷팅 함수
function formatToKoreanDateTime(date) {
    const year = date.getFullYear();
    const month = String(date.getMonth() + 1).padStart(2, '0');
    const day = String(date.getDate()).padStart(2, '0');
    const hours = String(date.getHours()).padStart(2, '0');
    const minutes = String(date.getMinutes()).padStart(2, '0');
    const seconds = String(date.getSeconds()).padStart(2, '0');

    return `(${year}년 ${month}월 ${day}일 ${hours}:${minutes}:${seconds})`;
}

// 남은시간 카운트다운 함수
function startTimer(endTimeMs) {
    let timerInterval = null; // 인터벌 변수를 먼저 선언

    function updateTimer() {
        const now = new Date().getTime();
        const diff = endTimeMs - now;

        // 경매가 종료되었을 때 (과거 날짜 포함)
        if (diff <= 0) {
            if (timerInterval) {
                clearInterval(timerInterval);
            }
            remainingTime.textContent = "경매가 종료되었습니다.";

            // 입찰 버튼 비활성화
            if (btnSubmitBid) {
                btnSubmitBid.disabled = true;
                btnSubmitBid.textContent = "경매 종료";
                btnSubmitBid.style.backgroundColor = "#ccc";
                btnSubmitBid.style.cursor = "not-allowed";
            }
            return;
        }

        // 일, 시간, 분, 초 계산
        const days = Math.floor(diff / (1000 * 60 * 60 * 24));
        const hours = Math.floor((diff % (1000 * 60 * 60 * 24)) / (1000 * 60 * 60));
        const minutes = Math.floor((diff % (1000 * 60 * 60)) / (1000 * 60));
        const seconds = Math.floor((diff % (1000 * 60)) / 1000);

        // 출력 문구 조립
        let timeString = "";
        if (days > 0) {
            timeString += `${days}일 `;
        }
        timeString += `${hours}시간 ${minutes}분 ${seconds}초`;

        remainingTime.textContent = timeString;
    }

    // 로드 직후 1회 실행
    updateTimer();

    // 경매 시간이 아직 남아있는 경우에만 1초 간격 인터벌 생성
    if (endTimeMs - new Date().getTime() > 0) {
        timerInterval = setInterval(updateTimer, 1000);
    }
}


// ----------------------------------------------------
// 입찰 기록 모달 제어용

const btnBidHistory = document.getElementById('btnBidHistory');
const bidModalOverlay = document.getElementById('bidModalOverlay');
const btnCloseModal = document.getElementById('btnCloseModal');

// [기록보기] 클릭 시 모달 열기
btnBidHistory.addEventListener('click', function(e) {
    e.preventDefault();
    bidModalOverlay.style.display = 'flex';
});

// 닫기(X) 버튼 클릭 시 모달 닫기
btnCloseModal.addEventListener('click', function() {
    bidModalOverlay.style.display = 'none';
});

// 모달 배경 어두운 곳 클릭 시 닫기
bidModalOverlay.addEventListener('click', function(e) {
    if (e.target === bidModalOverlay) {
        bidModalOverlay.style.display = 'none';
    }
});

// 리뷰보기모달 제어용

const btnReviewHistory = document.getElementById('btnReviewHistory');
const reviewModalOverlay = document.getElementById('reviewModalOverlay');
const btnCloseReviewModal = document.getElementById('btnCloseReviewModal');

// [기록보기] 클릭 시 모달 열기
btnReviewHistory.addEventListener('click', function(e) {
    e.preventDefault();
    reviewModalOverlay.style.display = 'flex';
});

// 닫기(X) 버튼 클릭 시 모달 닫기
    btnCloseReviewModal.addEventListener('click', function() {
    reviewModalOverlay.style.display = 'none';
});

// 모달 배경 어두운 곳 클릭 시 닫기
reviewModalOverlay.addEventListener('click', function(e) {
    if (e.target === reviewModalOverlay) {
        reviewModalOverlay.style.display = 'none';
    }
});


// const btnSubmitBid = document.querySelector('#btnSubmitBid'); 위에서 입찰하기 버튼 변수선언했었음
const bidInput = document.getElementById('bidInput');
const btnPlusBid = document.getElementById('btnPlusBid');
const btnMinusBid = document.getElementById('btnMinusBid');
const bidUnitElem = document.getElementById('bidUnit');
const currentPriceElem = document.getElementById('currentPrice');
const startPriceElem = document.getElementById('startPrice');



// 1. 입찰 단위 및 기준 가격(현재가 혹은 시작가) 숫자로 추출
const unit = parseInt(bidUnitElem.textContent.replace(/[^0-9]/g, '')) || 2000;


// 2. 현재가 엘리먼트에서 가격 읽어오기 
const currentPrice = parseInt(currentPriceElem.textContent.replace(/[^0-9]/g, '')) || 0;


// 3. 최소 입찰 가능 금액 = 현재가(또는 시작가) + 입찰단위
const minValidBid = currentPrice + unit;


// 페이지가 처음 뜰 때 희망 입찰가 입력창에 최소 입찰 가능 금액 기본 세팅
if (bidInput && !bidInput.value) {
    bidInput.value = minValidBid.toLocaleString();
}

// '+' 버튼 클릭 시
if (btnPlusBid) {
    btnPlusBid.addEventListener('click', function() {
        let inputVal = parseInt(bidInput.value.replace(/[^0-9]/g, '')) || minValidBid;
        bidInput.value = (inputVal + unit).toLocaleString();
    });
}

// '-' 버튼 클릭 시
if (btnMinusBid) {
    btnMinusBid.addEventListener('click', function() {
        let inputVal = parseInt(bidInput.value.replace(/[^0-9]/g, '')) || minValidBid;
        if (inputVal - unit >= minValidBid) {
            bidInput.value = (inputVal - unit).toLocaleString();
        } else {
            alert('최소 입찰가 이상이어야 합니다.');
            bidInput.value = minValidBid.toLocaleString();
        }
    });
}

// 직접 입력 후 포커스 아웃될 때
if (bidInput) {
    bidInput.addEventListener('blur', function() {
        let inputVal = parseInt(bidInput.value.replace(/[^0-9]/g, '')) || minValidBid;

        // 최소 입찰가보다 낮으면 최소가로 맞춤
        if (inputVal < minValidBid) {
            alert('최소 입찰가(' + minValidBid.toLocaleString() + '원) 이상으로 입력해주세요.');
            bidInput.value = minValidBid.toLocaleString();
            return;
        }

        // (입찰가 - 현재가)가 입찰단위의 배수가 되는지 확인
        let remainder = (inputVal - currentPrice) % unit;
        
        if (remainder !== 0) {
            // 배수가 안 맞을 경우, 가장 가까운 올바른 배수 금액으로 자동 조정 
            // 여기서는 깔끔하게 가장 가까운 금액으로 반올림/맞춤 처리
            let adjustedVal = inputVal - remainder; 
            if (adjustedVal < minValidBid) adjustedVal = minValidBid;

            alert('입찰 단위(' + unit.toLocaleString() + '원)에 맞는 금액만 입력 가능합니다.\n(예시 금액으로 자동 조정됩니다.)');
            bidInput.value = adjustedVal.toLocaleString();
        } else {
            bidInput.value = inputVal.toLocaleString();
        }
    });
    
    bidInput.addEventListener('focus', function() {
        bidInput.value = bidInput.value.replace(/[^0-9]/g, '');
    });
}

// 입찰하기 버튼 클릭 시 최종 전송
if (btnSubmitBid) {
    btnSubmitBid.addEventListener('click', function() {
        const productId = this.getAttribute('data-product-id');
        const bidPrice = parseInt(bidInput.value.replace(/[^0-9]/g, '')) || 0;
		
		// 조건문 안으로 진입하는지 확인하기 위한 로그 추가
		if (isOwner) {
		    alert("본인이 등록한 상품에는 입찰할 수 없습니다.");
		    return;
		}

        if (bidPrice < minValidBid || (bidPrice - currentPrice) % unit !== 0) {
            alert('올바른 입찰 단위 금액이 아닙니다.');
            return;
        }

        if (!confirm(bidPrice.toLocaleString() + '원으로 입찰하시겠습니까?')) {
            return;
        }


        // 폼 태그 만들어서 요청 보내기
        const form = document.createElement('form');
        form.method = 'POST';
        form.action = '/auction/bid';

        // 상품 번호 추가
        const productInput = document.createElement('input');
        productInput.type = 'hidden';
        productInput.name = 'productId';
        productInput.value = productId;
        form.appendChild(productInput);

        // 입찰가 추가
        const priceInput = document.createElement('input');
        priceInput.type = 'hidden';
        priceInput.name = 'bidPrice';
        priceInput.value = bidPrice;
        form.appendChild(priceInput);

        // 입찰 단위추가
        const unitInput = document.createElement('input');
        unitInput.type = 'hidden';
        unitInput.name = 'bidUnit';
        unitInput.value = unit; 
        form.appendChild(unitInput);

        document.body.appendChild(form);
        form.submit();
    });
}

// 찜목록 버튼 클릭 시 토글효과
const wishBtn = document.getElementById('wishBtn');
wishBtn.addEventListener('click', async function() {
    const productId = wishBtn.dataset.productId; // data-product-id 값을 가져옴

    if(isOwner){
        alert("본인이 등록한 상품은 찜목록에 추가할 수 없습니다.");
        return;
    }

    try{
        const response = await fetch('/api/board/wish', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json',
            },
            body: JSON.stringify({ productId: productId })
        })

        const result = await response.json();

        if (!response.ok || !result.success) {
            alert(result.message || "찜목록 처리 중 오류가 발생했습니다.");
            return;
        }
        
        const icon = wishBtn.querySelector('i');
        
        // 서버에서 현재 찜 상태(isLiked)를 boolean타입으로 보내줌
        if (result.data) { // 찜이 안되어 있어서 찜한상태로 변경
            icon.classList.remove('fa-regular');
            icon.classList.add('fa-solid'); // 빨간 하트로 변경
        } else {            // 찜이 되어 있던 것이므로 찜 취소 상태로 변경
            icon.classList.remove('fa-solid');
            icon.classList.add('fa-regular'); // 빈 하트로 변경
        }
    }
    catch (error) {
        console.error('Error:', error);
        alert("네크워크 오류 발생");
    }

});

// 쪽지 보내기
const btnSendMessage = document.getElementById("btnSendMessage");

if(btnSendMessage){
	btnSendMessage.addEventListener('click', function (){

        if(isOwner){
            alert("본인에게는 쪽지를 보낼 수 없습니다.");
            return;
        }

		const productId = this.dataset.productId;
		const receiverNo = this.dataset.receiverNo;
		const redirectURL = this.dataset.redirectUrl;
		
		const url = '/message/write'
					+ '?productId=' + productId
					+ '&receiverNo=' + receiverNo
					+ '&redirectURL=' + encodeURIComponent(redirectURL);
					
					location.href = url;
	});
}


function changeMainMedia(element, mediaUrl, mediaType) {
    const container = document.getElementById('mainImageContainer');
    
    if (mediaType === 'VIDEO') {
        container.innerHTML = `<video id="mainVideo" src="${mediaUrl}" controls autoplay style="width:100%; height:100%; object-fit:cover;"></video>`;
    } else {
        container.innerHTML = `<img id="mainImage" src="${mediaUrl}" alt="상품 이미지">`;
    }
    
    // 썸네일 활성화 테두리 토글
    document.querySelectorAll('.thumbnail-item').forEach(item => {
        item.classList.remove('active');
    });
    element.classList.add('active');
}
