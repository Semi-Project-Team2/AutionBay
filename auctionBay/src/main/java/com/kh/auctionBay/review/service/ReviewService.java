package com.kh.auctionBay.review.service;

import java.io.IOException;
import java.util.List;

import com.kh.auctionBay.review.model.dto.ReviewDTO;
import com.kh.auctionBay.review.model.dto.ReviewResultList;

public interface ReviewService {

	// 받은 후기 목록 조회
	ReviewResultList getReceivedReviews(Long userNo);
	
	// 보낸 후기 목록 조회
	ReviewResultList getSentReviews(Long userNo);
	
	// 후기 작성(추가)
	int writeReview(ReviewDTO review) throws IllegalStateException, IOException;
}
