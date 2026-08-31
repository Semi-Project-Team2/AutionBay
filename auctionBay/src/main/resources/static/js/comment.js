const isOwner = document.querySelector("#is-Owner-value").value === "true";

const commentForm = document.querySelector("#comment-form");
const productId = document.querySelector("#product-id-value").value;
const commentList = document.querySelector("#comment-list");

// ==========================================
// 댓글 등록 처리 (요청하신 코드 그대로 사용)
// ==========================================
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

// ==========================================
// appendComment 함수만 살짝 안전하게 보완
// ==========================================
function appendComment(commentData) {
	if (!commentData) return;

	// 만약 서버에서 배열([CommentDTO, ...])로 들어오면 가장 최근 작성된 마지막 1개만 가져옴
	const comment = Array.isArray(commentData) ? commentData[commentData.length - 1] : commentData;

	// 템플릿 영역 접근
	const commentTemplate = document.querySelector("#comment-template");
	const cloneComment = commentTemplate.content.cloneNode(true);
	
	const li = cloneComment.querySelector("li");
	li.id = `comment-${comment.commentId}`;
	
	// writerNo 대신 닉네임이 있으면 닉네임 표시, 없으면 writerNo 표시
	cloneComment.querySelector(".comment-list_writer").textContent = comment.writerNickname || comment.writerNo;
	cloneComment.querySelector(".comment-list_content").textContent = comment.content;
	cloneComment.querySelector(".comment-list_date").textContent = comment.createdAtStr;
	
	const delBtn = cloneComment.querySelector(".comment-delete-btn");
	if (delBtn) {
		delBtn.dataset.commentId = comment.commentId;
	}
	
	commentList.appendChild(cloneComment);
}

// ==========================================
// 댓글 삭제 기능
// ==========================================
if (commentList) {
	commentList.addEventListener("click", async function(e) {
		const delBtn = e.target.closest(".comment-delete-btn");
		if (!delBtn) return;
		
		if (!confirm("댓글을 삭제하시겠습니까?")) return;
		
		const commentId = delBtn.dataset.commentId;
		try {
			const response = await fetch(`/api/comments/${commentId}`, {
				method: "DELETE",
				headers: {"X-Requested-With": "XMLHttpRequest"}
			});
			
			const result = await response.json();
			
			if (!response.ok || !result.success) {
				alert(result.message || "댓글 삭제에 실패했습니다.");
				return;
			} 
			
			document.querySelector(`#comment-${commentId}`).remove();
		} catch (error) {
			alert("댓글 삭제 중 오류가 발생했습니다.");
		}
	});	
}