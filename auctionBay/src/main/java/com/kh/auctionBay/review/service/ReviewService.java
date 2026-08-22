package com.kh.auctionBay.review.service;

import java.util.List;

import com.kh.auctionBay.review.model.dto.ReviewDTO;

public interface ReviewService {

	// 받은 후기 목록 조회
	List<ReviewDTO> getRecievedReviews(Long userNo);
	
	// 보낸 후기 목록 조회
	List<ReviewDTO> getSentReviews(Long userNo);
	
	// 후기 상세 조회
	ReviewDTO getReviewDetail(Long reviewId);
	
	// 후기 작성(추가)
	int writeReview(ReviewDTO review);
}
