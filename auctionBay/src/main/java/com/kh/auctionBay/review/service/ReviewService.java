package com.kh.auctionBay.review.service;

import java.io.IOException;
import java.util.List;

import com.kh.auctionBay.review.model.dto.ReviewDTO;
import com.kh.auctionBay.review.model.dto.ReviewResultList;
import com.kh.auctionBay.review.model.dto.SearchCondition;
import com.kh.auctionBay.review.model.dto.ReviewSummaryDTO;

public interface ReviewService {

	// 받은 후기 목록 조회
	ReviewResultList getReceivedReviews(SearchCondition condition);
	
	// 보낸 후기 목록 조회
	ReviewResultList getSentReviews(SearchCondition condition);
	
	// 후기 작성(추가)
	int writeReview(ReviewDTO review) throws IllegalStateException, IOException;
	
	// 게시물 등록자의 리뷰받은 총 개수와 평균 리뷰 계산
	ReviewSummaryDTO getAvgAndCountReview(Long revieweeNo);
}
