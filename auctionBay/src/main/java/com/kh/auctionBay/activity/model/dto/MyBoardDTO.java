package com.kh.auctionBay.activity.model.dto;

import java.time.LocalDateTime;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@NoArgsConstructor
@AllArgsConstructor
@Getter
@Setter
@ToString
public class MyBoardDTO {
	private Long productNo;				// 게시글 ID
	private Long writerNo;              // 작성자 번호
	private Long categoryNo;            // 카테고리 ID
	private String tradeType;           // 거래 유형 (SELL/BUY/AUCTION)
	private String title;               // 게시글 제목
	private String description;         // 게시글 상세 설명
	private Long price;                 // 판매/구매 희망 가격
	private String productCondition;    // 상품 품질 상태
	private String status;              // 게시글 상태 (ONGOING/COMPLETED 등)
	private Integer viewCount;          // 조회수
	private LocalDateTime createdAt;    // 게시글 등록 일시
	
	// 화면 표시용 가공 필드
	private String createdAtStr;        // 작성일시 포맷팅 (YYYY-MM-DD HH:mm)
	private String mainImage;           // 대표 썸네일 이미지 URL (PRODUCT_MEDIA JOIN)
}
