package com.kh.auctionBay.myPage.model.dto;

import java.util.Date;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class RecentViewDTO {
    private Long viewId;       // 최근 본 글 기록 ID
    private Long productId;    // 상품 ID
    private String title;      // 게시글 제목
    private Integer price;     // 가격
    private String status;     // 게시글 상태
    private String mainImage;  // 대표 썸네일 이미지 URL
    private Date viewedAt;     // 최근 조회 일시
}