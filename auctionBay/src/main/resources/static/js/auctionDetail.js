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
// 모달 제어용

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


// const btnSubmitBid = document.querySelector('#btnSubmitBid'); 위에서 입찰하기 버튼 변수선언했었음
const bidInput = document.getElementById('bidInput');
const btnPlusBid = document.getElementById('btnPlusBid');
const btnMinusBid = document.getElementById('btnMinusBid');
const bidUnitElem = document.getElementById('bidUnit');
const currentPriceElem = document.getElementById('currentPrice');
const startPriceElem = document.getElementById('startPrice');



// 1. 입찰 단위 및 기준 가격(현재가 혹은 시작가) 숫자로 추출
const unit = parseInt(bidUnitElem.textContent.replace(/[^0-9]/g, '')) || 2000;
//console.log(unit);

// 2. 현재가 엘리먼트에서 가격 읽어오기 
const currentPrice = parseInt(currentPriceElem.textContent.replace(/[^0-9]/g, '')) || 0;

console.log(currentPrice);

// 3. 최소 입찰 가능 금액 = 현재가(또는 시작가) + 입찰단위
const minValidBid = currentPrice + unit;
console.log(minValidBid);

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
