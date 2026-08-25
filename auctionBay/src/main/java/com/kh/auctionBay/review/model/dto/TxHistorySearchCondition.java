package com.kh.auctionBay.review.model.dto;

import lombok.Getter;
import lombok.Setter;

/* 검색 조건(설정) 및 페이징 정보를 담을 객체 */
@Getter
@Setter
public class TxHistorySearchCondition {
	private Long userNo;	// 로그인한 사용자 PK
	
	private String keyword;		// 검색 키워드
	
	// 페이징 정보
	private int size = 5;		// 한 페이지에 보여줄 거래내역, 리뷰 개수(고정)
	private int page = 1;		// 페이지 번호 (기본값 1)
	
	// 쿼리문 실행 시 사용할 값
	private int offset;			// 건너뛸 행 수
}
