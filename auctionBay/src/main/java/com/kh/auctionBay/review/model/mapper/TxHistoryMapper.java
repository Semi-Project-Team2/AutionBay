package com.kh.auctionBay.review.model.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.kh.auctionBay.review.model.dto.TxHistoryDTO;

@Mapper
public interface TxHistoryMapper {
	// 거래내역 목록 조회
	List<TxHistoryDTO> selectTxHistories(Long userNo);
	
	// 거래내역 상세 조회
	TxHistoryDTO selectTxHistoryById(Long historyId);
	
	// 거래내역 추가
	int insertTxHistory(TxHistoryDTO tx);

}
