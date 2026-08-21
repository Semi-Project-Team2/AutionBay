package com.kh.auctionBay.review.service;

import java.io.IOException;
import java.util.List;

import org.springframework.stereotype.Service;

import com.kh.auctionBay.review.model.dto.TxHistoryDTO;
import com.kh.auctionBay.review.model.mapper.TxHistoryMapper;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class TxHistoryServiceImpl implements TxHistoryService {
	/* Mapper DI 생성자 주입 */
	private final TxHistoryMapper txHistoryMapper;

	@Override
	public List<TxHistoryDTO> getTransactionHistoryList(Long userNo, Long productId) {
		// 전체 거래내역 조회
		List<TxHistoryDTO> txHistories 
				= txHistoryMapper.selectTxHistoryList(userNo, productId);
		
		return txHistories;
	}

	@Override
	public TxHistoryDTO getTransactionHistoryDetail(Long historyId) {
		// 거래내역 상세 조회 후 리턴		
		return txHistoryMapper.selectTxHistoryById(historyId);
	}

	@Override
	public int addTxHistory(TxHistoryDTO tx) throws IllegalStateException, IOException {
		// TODO Auto-generated method stub
		return 0;
	}
	
	
}
