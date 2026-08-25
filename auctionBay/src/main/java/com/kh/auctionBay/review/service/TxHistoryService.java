package com.kh.auctionBay.review.service;

import java.io.IOException;

import com.kh.auctionBay.review.model.dto.TxHistoryDTO;
import com.kh.auctionBay.review.model.dto.TxHistoryResultList;
import com.kh.auctionBay.review.model.dto.TxHistorySearchCondition;

public interface TxHistoryService {
	// 거래 내역 목록 조회
	TxHistoryResultList getTxHistories(TxHistorySearchCondition condition);
	
	// 거래 내역 상세 조회
	TxHistoryDTO getTxHistoryDetail(Long historyId);
	
	// 거래 내역 추가
	int addTxHistory(TxHistoryDTO tx) throws IllegalStateException, IOException;
}
