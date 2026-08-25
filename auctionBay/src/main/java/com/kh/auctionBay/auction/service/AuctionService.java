package com.kh.auctionBay.auction.service;

import java.util.List;

import com.kh.auctionBay.auction.model.dto.BidsDTO;

public interface AuctionService {
	
	// productId로 해당 게시물 모든 경매이력 조회
	List<BidsDTO> getBidsByProductId(Long productId);
	
	// 입찰 처리하는 메서드
	String processBid(BidsDTO bidDTO);
	
	// 스케쥴링 메서드
	void checkAndCloseAuctions();
	
	//찜 여부 조회 메서드
	boolean checkIsLiked(Long userNo, Long productId);
	
	// 찜 토글 기능 메서드
	boolean toggleWish(Long userNo, Long productId);
}
