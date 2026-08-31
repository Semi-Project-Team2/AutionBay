package com.kh.auctionBay.board.service;

import java.io.IOException;
import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import com.kh.auctionBay.board.model.dto.BoardDTO;
import com.kh.auctionBay.board.model.dto.BoardListResult;
import com.kh.auctionBay.board.model.dto.BoardSearchCondition;
import com.kh.auctionBay.board.model.dto.CommentDTO; // CommentDTO import 추가


public interface BoardService {
	
	//찜 여부 조회 메서드
	boolean checkIsLiked(Long userNo, Long productId);
	
	// 찜 토글 기능 메서드
	boolean toggleWish(Long userNo, Long productId);

}