package com.kh.auctionBay.review.service;

import java.io.IOException;
import java.util.List;

import com.kh.auctionBay.review.model.dto.TxHistoryDTO;

public interface TxHistoryService {
	// 거래 내역 목록 조회
	List<TxHistoryDTO> getTransactionHistoryList(Long userNo, Long productId);
	
	// 거래 내역 상세 조회
	TxHistoryDTO getTransactionHistoryDetail(Long historyId);
	
	// 거래 내역 추가
	int addTxHistory(TxHistoryDTO tx) throws IllegalStateException, IOException ;
}
