package com.kh.auctionBay.review.model.dto;

import java.time.LocalDateTime;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@AllArgsConstructor
@Data
public class ReviewDTO {
//    review_id NUMBER(19) GENERATED ALWAYS AS IDENTITY,
//    product_id NUMBER(19) NOT NULL,
//    reviewer_no NUMBER(19) NOT NULL,
//    reviewee_no NUMBER(19) NOT NULL,
//    rating NUMBER(2) NOT NULL,
//    content VARCHAR2(500),
//    created_at DATE DEFAULT SYSDATE,
	
	private Long reviewId;
	private Long productId;
	private Long reviewerNo;
	private Long revieweeNo;
	private int rating;
	private String content;
	private LocalDateTime createdAt;
	
	private String createdAtStr;
	
	// 보낸/받은 후기 상대방 닉네임
	private String reviewerNickname;
	private String revieweeNickname;
	
}
