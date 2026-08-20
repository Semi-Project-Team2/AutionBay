package com.kh.community.board.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.kh.community.board.model.dto.CommentDTO;
import com.kh.community.board.model.mapper.CommentMapper;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class CommentServiceImpl implements CommentService {
	
	private final CommentMapper mapper;

	@Override
	public CommentDTO addComment(Long boardId, String content, String writerId) {
		// 댓글 내용 검토
		if (content == null || content.isBlank()) {
			throw new IllegalArgumentException("댓글 내용을 입력해주세요.");
		}
		
		CommentDTO comment = new CommentDTO();
		comment.setBoardId(boardId);
		comment.setContent(content);
		comment.setMemberId(writerId);
		
		mapper.insertComment(comment);	// 실행 후 commentId 가 채워짐
		
		// commentId 로 다시 조회한 후 결과를 반환
		return mapper.selectCommentById( comment.getCommentId() );
	}

	@Override
	public List<CommentDTO> getComments(Long boardId) {
		// TODO Auto-generated method stub
		return null;
	}

	
	
}
