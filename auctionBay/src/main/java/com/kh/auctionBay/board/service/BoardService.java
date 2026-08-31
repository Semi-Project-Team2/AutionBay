package com.kh.auctionBay.board.service;

import java.io.IOException;
import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import com.kh.auctionBay.board.model.dto.BoardDTO;
import com.kh.auctionBay.board.model.dto.BoardListResult;
import com.kh.auctionBay.board.model.dto.BoardSearchCondition;
import com.kh.auctionBay.board.model.dto.CommentDTO; // CommentDTO import 추가


public interface BoardService {

	// 게시글 상세 조회
	BoardDTO getBoardDetail(Long boardId);
	
	//찜 여부 조회 메서드
	boolean checkIsLiked(Long userNo, Long productId);
	
	// 찜 토글 기능 메서드
	boolean toggleWish(Long userNo, Long productId);

	// 댓글 목록 조회 추가
	List<CommentDTO> getCommentList(Long boardId);
}