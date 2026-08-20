package com.kh.auctionBay.myPage.model.dto;

import java.util.Date;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class MyBoardDTO {
    private Long productId;      // 게시글 ID
    private String title;        // 게시글 제목
    private Integer price;       // 가격
    private String status;       // 게시글 상태 (ONGOING, COMPLETED 등)
    private Date createdAt;      // 작성일
    private String mainImage;    // 대표 썸네일 이미지 URL
}