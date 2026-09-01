document.addEventListener("DOMContentLoaded", function () {
    
    // ==========================================
    // 1. 게시글 삭제 처리
    // ==========================================
    const deleteBtn = document.getElementById("btn-delete");
    if (deleteBtn) {
        deleteBtn.addEventListener("click", function () {
            const boardId = this.dataset.boardId;

            if (!confirm("정말 이 게시글을 삭제하시겠습니까?")) {
                return;
            }

            fetch(`/board/delete/${boardId}`, {
                method: "POST"
            })
            .then(response => {
                if (response.ok) {
                    alert("게시글이 삭제되었습니다.");
                    window.location.href = "/board/list";
                } else {
                    alert("삭제 권한이 없거나 처리 중 오류가 발생했습니다.");
                }
            })
            .catch(error => {
                console.error("Error:", error);
                alert("네트워크 오류가 발생했습니다.");
            });
        });
    }

    // ==========================================
    // 2. 찜하기 (좋아요) 처리
    // ==========================================
    const likeBtn = document.getElementById("btn-like");
    if (likeBtn) {
        likeBtn.addEventListener("click", function () {
            const productId = this.dataset.productId;

            fetch(`/board/${productId}/like`, {
                method: "POST",
                headers: {
                    "Content-Type": "application/json"
                }
            })
            .then(response => {
                if (response.status === 401) {
                    alert("로그인이 필요한 기능입니다.");
                    window.location.href = "/user/login";
                    return null;
                }
                return response.json();
            })
            .then(data => {
                if (!data) return;

                // 서버에서 { liked: true/false, likeCount: 10 } 형태로 응답 가정
                if (data.liked) {
                    likeBtn.classList.add("active");
                    alert("찜 목록에 추가되었습니다.");
                } else {
                    likeBtn.classList.remove("active");
                    alert("찜 목록에서 삭제되었습니다.");
                }

                const likeCountEl = document.getElementById("like-count");
                if (likeCountEl && data.likeCount !== undefined) {
                    likeCountEl.textContent = data.likeCount;
                }
            })
            .catch(error => {
                console.error("Error:", error);
                alert("찜 처리 중 오류가 발생했습니다.");
            });
        });
    }

	function appendComment(comment) {
	    const commentTemplate = document.querySelector("#comment-template");
	    const cloneComment = commentTemplate.content.cloneNode(true);
	    
	    const li = cloneComment.querySelector("li");
	    li.id = `comment-${comment.commentId}`;
	    
	    cloneComment.querySelector(".comment-list_writer").textContent = comment.writerNickname;
	    cloneComment.querySelector(".comment-list_content").textContent = comment.content;
	    // DTO 필드명(createdAtStr)과 일치하도록 수정
	    cloneComment.querySelector(".comment-list_date").textContent = comment.createdAtStr;
	    
	    cloneComment.querySelector(".comment-delete-btn").dataset.commentId = comment.commentId;
	    
	    // global scope 또는 상단에 정의된 commentList 요소에 추가
	    const commentList = document.querySelector("#comment-list");
	    commentList.appendChild(cloneComment);
	}

	// ==========================================
	// 3. 댓글 등록 처리 (비동기)
	// ==========================================
	const commentForm = document.getElementById("comment-form");
	const commentInput = document.getElementById("comment-input"); // 댓글 입력창 ID 확인 필요
	

	if (commentForm) {
	    commentForm.addEventListener("submit", async function (e) {
	        e.preventDefault();

	        const content = commentInput.value.trim();
	        if (!content) {
	            alert("댓글 내용을 입력해주세요.");
	            return;
	        }

	        const productId = window.location.pathname.split("/").pop();

	        try {
	            const response = await fetch(`/api/board/${productId}/comment`, {
	                method: "POST",
	                headers: {
	                    "Content-Type": "application/json",
	                    "X-Requested-With": "XMLHttpRequest"
	                },
	                body: JSON.stringify({ content: content })
	            });

	            const result = await response.json();

	            // ApiResponse 구조에 맞게 검증 (result.status === "SUCCESS" 또는 result.data 존재 여부)
	            if (response.ok && (result.success || result.data)) {
	                // ApiResponse.success(comment)로 전달된 DTO 데이터
	                const newComment = result.data || result; 
	                appendComment(newComment); // 화면에 동적 추가
	                commentInput.value = "";   // 입력창 초기화
	            } else {
	                alert(result.message || "댓글 등록에 실패했습니다.");
	            }
	        } catch (error) {
	            console.error(error);
	            alert("댓글 등록 중 오류가 발생했습니다.");
	        }
	    });
		
		// 댓글 추가 후 댓글 개수 변경
		updateCommentCount();

		
	}

	// ==========================================
	// 4. 댓글 삭제 처리
	// ==========================================
	const commentList = document.querySelector("#comment-list");

	if (commentList) {
		
	    commentList.addEventListener("click", async function (e) {
	        const delBtn = e.target.closest(".comment-delete-btn");
	        if (!delBtn) return;
	        
	        if (!confirm("댓글을 삭제하시겠습니까?")) return;
	        
	        const commentId = delBtn.dataset.commentId;
	        try {
	            const response = await fetch(`/api/comments/${commentId}`, {
	                method: "DELETE",
	                headers: { "X-Requested-With": "XMLHttpRequest" }
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

		

    // ==========================================
    // 5. 이미지 업로드 미리보기 (글쓰기 / 수정 폼)
    // ==========================================
    const imageInput = document.getElementById("imageFiles");
    const previewContainer = document.getElementById("image-preview");

    if (imageInput && previewContainer) {
        imageInput.addEventListener("change", function (e) {
            previewContainer.innerHTML = ""; // 기존 미리보기 초기화

            const files = Array.from(e.target.files);
            files.forEach(file => {
                if (!file.type.startsWith("image/")) return;

                const reader = new FileReader();
                reader.onload = function (event) {
                    const img = document.createElement("img");
                    img.src = event.target.result;
                    img.classList.add("img-thumbnail", "me-2", "mb-2");
                    img.style.width = "100px";
                    img.style.height = "100px";
                    img.style.objectFit = "cover";
                    previewContainer.appendChild(img);
                };
                reader.readAsDataURL(file);
            });
        });
    }
});