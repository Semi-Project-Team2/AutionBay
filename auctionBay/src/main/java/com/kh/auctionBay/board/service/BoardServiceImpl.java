package com.kh.auctionBay.board.service;

import java.io.IOException;
import java.util.List;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import com.kh.auctionBay.board.model.dto.BoardDTO;
import com.kh.auctionBay.board.model.dto.BoardImageDTO;
import com.kh.auctionBay.board.model.dto.BoardListResult;
import com.kh.auctionBay.board.model.dto.BoardSearchCondition;
import com.kh.auctionBay.board.model.dto.CommentDTO;
import com.kh.auctionBay.board.model.mapper.BoardMapper;
import com.kh.auctionBay.common.dto.PageInfo;
import com.kh.auctionBay.common.util.FileUploadUtil;
import com.kh.auctionBay.common.util.SavedFile;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class BoardServiceImpl implements BoardService {
	
	private final BoardMapper mapper;
	
	@Override
	public boolean checkIsLiked(Long userNo, Long productId) {
	    return mapper.checkIsLiked(userNo, productId) > 0;
	}

	@Override
	public boolean toggleWish(Long userNo, Long productId) {
		boolean isAlreadyLiked = mapper.checkIsLiked(userNo, productId) > 0;

		if (isAlreadyLiked) {
	        // 이미 찜 되어있다면 -> 삭제 (취소)
	        mapper.deleteWish(userNo, productId);
	        return false; // 최종 상태: 찜 해제됨
	    } else {
	        // 찜 안 되어있다면 -> 추가
	        mapper.insertWish(userNo, productId);
	        return true; // 최종 상태: 찜 등록됨
	    }
	}
	
}