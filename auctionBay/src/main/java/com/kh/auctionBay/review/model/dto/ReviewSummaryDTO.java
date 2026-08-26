package com.kh.auctionBay.review.model.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class ReviewSummaryDTO {
	
	// 상세페이지 리뷰 평균 점수, 총 개수 띄우기용 DTO
	private double reviewAvg;
	private int reviewCount;
}
