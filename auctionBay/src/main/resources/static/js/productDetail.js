const isOwner = document.querySelector("#is-Owner-value").value === "true"; // 문자열을 boolean으로 변환

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
		} catch (error) {
			alert("댓글 삭제 중 오류가 발생했습니다.");
		}
	});	
	
}




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
