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
public class WishlistDTO {
	private Long wishlistNo;            // 찜 ID
	private Long userNo;                // 찜한 회원 ID
	private Long productNo;             // 찜한 상품 ID
	private LocalDateTime createdAt;    // 찜 등록 일시
	
	// 화면 표시용 가공 필드 (PRODUCTS, PRODUCT_MEDIA JOIN)
	private String title;               // 상품 제목
	private Long price;                 // 상품 가격
	private String tradeType;           // 거래 유형 (SELL/BUY/AUCTION)
	private String status;              // 상품 거래 상태
	private String mainImage;           // 대표 썸네일 이미지 URL
	private String wishedAtStr;         // 찜 등록일시 포맷팅

}
