package com.kh.auctionBay.review.service;

import java.io.IOException;
import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.ModelAttribute;

import com.kh.auctionBay.review.model.dto.TxHistoryDTO;
import com.kh.auctionBay.review.model.mapper.TxHistoryMapper;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class TxHistoryServiceImpl implements TxHistoryService {
	/* Mapper DI 생성자 주입 */
	private final TxHistoryMapper txHistoryMapper;

	@Override
	public List<TxHistoryDTO> getTxHistories(Long userNo) {
		// 전체 거래내역 조회
		List<TxHistoryDTO> txHistories 
				= txHistoryMapper.selectTxHistoryList(userNo);
		
		return txHistories;
	}

	@Override
	public TxHistoryDTO getTxHistoryDetail(Long historyId) {
		// 거래내역 상세 조회 후 리턴		
		return txHistoryMapper.selectTxHistoryById(historyId);
	}

	@Override
	public int addTxHistory(TxHistoryDTO tx) throws IllegalStateException, IOException {
		// 거래내역 추가 후 추가된 개수 리턴
		int result = txHistoryMapper.insertTxHistory(tx);
		return result;
	}
	
	
}
