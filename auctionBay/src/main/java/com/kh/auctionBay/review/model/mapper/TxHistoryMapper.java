package com.kh.auctionBay.review.model.mapper;

import java.util.List;

import com.kh.auctionBay.review.model.dto.TxHistoryDTO;

public interface TxHistoryMapper {
	// 거래내역 목록 조회
	List<TxHistoryDTO> selectTxHistoryList(Long userNo, Long productId);
	
	// 거래내역 상세 조회
	TxHistoryDTO selectTxHistoryById(Long historyId);

}
