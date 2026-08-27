package com.kh.auctionBay.board.service;

import java.util.List;
import com.kh.auctionBay.board.model.dto.CommentDTO;

public interface CommentService {
    
	// 댓글 작성
	CommentDTO addComment(Long ProductId, String content, Long writerNo);
	
	// 댓글 목록 조회
	List<CommentDTO> getComments(Long boardId);
	
	// 댓글 삭제
	void deleteComment(Long commentId, Long writerNo);
}