package com.kh.auctionBay.review.service;

import java.io.IOException;
import java.util.List;

import org.springframework.stereotype.Service;

import com.kh.auctionBay.review.model.dto.TxHistoryDTO;

public interface TxHistoryService {
	// 거래 내역 목록 조회
	List<TxHistoryDTO> getTxHistories(Long userNo);
	
	// 거래 내역 상세 조회
	TxHistoryDTO getTxHistoryDetail(Long historyId);
	
	// 거래 내역 추가
	int addTxHistory(TxHistoryDTO tx) throws IllegalStateException, IOException;
}
