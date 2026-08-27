package com.kh.auctionBay.review.model.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.kh.auctionBay.review.model.dto.TxHistoryDTO;
import com.kh.auctionBay.review.model.dto.SearchCondition;

@Mapper
public interface TxHistoryMapper {
	// 거래 내역 목록 조회
	List<TxHistoryDTO> selectTxHistories(SearchCondition condition);
	
	// 거래 내역 개수 (페이징 계산용)
	int selectTxHistoriesCount(SearchCondition condition);
	
	// 거래 내역 상세 조회
	TxHistoryDTO selectTxHistoryById(Long historyId);
	
	// 거래 내역 추가
	int insertTxHistory(TxHistoryDTO txHistory);
	
	// 거래 후기 작성 여부 조회
	boolean selectReviewWrited(Long historyId);

}
