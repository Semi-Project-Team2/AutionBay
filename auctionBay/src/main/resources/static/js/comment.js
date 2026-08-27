// 댓글 작성
function submitComment() {
    const form = document.getElementById('commentForm');
    const formData = new FormData(form);

    fetch('/board/comment/write', {
        method: 'POST',
        body: formData
    })
    .then(response => {
        if (response.status === 401) {
            alert('로그인이 필요합니다.');
            return;
        }
        if (response.ok) {
            location.reload(); // 성공 시 페이지 새로고침
        } else {
            alert('댓글 작성 실패');
        }
    })
    .catch(error => console.error('Error:', error));
}

// 댓글 삭제
function deleteComment(commentId) {
    if (!confirm('댓글을 삭제하시겠습니까?')) return;

    fetch(`/board/comment/delete/${commentId}`, {
        method: 'POST'
    })
    .then(response => {
        if (response.ok) {
            // 화면에서 삭제된 댓글 엘리먼트 제거
            const targetDiv = document.getElementById(`comment-${commentId}`);
            if (targetDiv) targetDiv.remove();
            else location.reload();
        } else {
            alert('삭제에 실패했습니다.');
        }
    })
    .catch(error => console.error('Error:', error));
}