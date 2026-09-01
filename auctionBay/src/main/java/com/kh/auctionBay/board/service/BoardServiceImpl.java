package com.kh.auctionBay.board.service;


import org.springframework.stereotype.Service;

import com.kh.auctionBay.board.model.mapper.BoardMapper;

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