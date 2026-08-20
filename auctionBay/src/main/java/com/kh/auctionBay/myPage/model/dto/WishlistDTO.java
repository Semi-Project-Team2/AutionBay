package com.kh.auctionBay.myPage.model.dto;

import java.util.Date;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class WishlistDTO {
    private Long wishlistId;   // 찜 ID
    private Long productId;    // 상품 ID
    private String title;      // 상품명
    private Integer price;     // 가격
    private String tradeType;  // 거래 유형 (SELL, BUY, AUCTION)
    private String mainImage;  // 대표 썸네일 이미지 URL
    private Date wishedAt;     // 찜 등록 일시
}