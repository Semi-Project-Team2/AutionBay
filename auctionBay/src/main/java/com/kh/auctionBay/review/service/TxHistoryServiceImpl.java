package com.kh.auctionBay.review.service;

import java.io.IOException;
import java.util.List;

import org.springframework.stereotype.Service;

import com.kh.auctionBay.common.dto.PageInfo;
import com.kh.auctionBay.review.model.dto.TxHistoryDTO;
import com.kh.auctionBay.review.model.dto.TxHistoryResultList;
import com.kh.auctionBay.review.model.dto.SearchCondition;
import com.kh.auctionBay.review.model.mapper.TxHistoryMapper;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class TxHistoryServiceImpl implements TxHistoryService {
	/* Mapper DI 생성자 주입 */
	private final TxHistoryMapper txHistoryMapper;
	

	@Override
	public TxHistoryResultList getTxHistories(SearchCondition condition) {
		// 거래내역 개수 조회
		int totalCount = txHistoryMapper.selectTxHistoriesCount(condition);
		
		// 페이징 정보 저장
		int page = condition.getPage();
		int size = condition.getSize();
		PageInfo pageInfo = new PageInfo(page, size, totalCount);
		// 검색 조건(condition)의 offset을 pageInfo에서 가져오기
		condition.setOffset(pageInfo.getOffset());
		
		// 전체 거래내역 조회
		TxHistoryResultList txHistories = new TxHistoryResultList(
				txHistoryMapper.selectTxHistories(condition), pageInfo);
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
