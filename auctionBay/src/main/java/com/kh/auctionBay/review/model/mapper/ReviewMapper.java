package com.kh.auctionBay.review.model.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.kh.auctionBay.review.model.dto.ReviewDTO;

import com.kh.auctionBay.review.model.dto.SearchCondition;

import com.kh.auctionBay.review.model.dto.ReviewSummaryDTO;


@Mapper
public interface ReviewMapper {
	
	// 받은 후기 목록 조회
	List<ReviewDTO> selectReceivedReviews(SearchCondition condition);
	
	// 받은 후기 개수 조회 (페이징 계산용)
	int selectReceivedReviewsCount(SearchCondition condition);
	
	// 보낸 후기 목록 조회
	List<ReviewDTO> selectSentReviews(SearchCondition condition);
	
	// 보낸 후기 개수 조회 (페이징 계산용)
	int selectSentReviewsCount(SearchCondition condition);
	
	// 후기 작성
	int insertReview(ReviewDTO review);
	
	// 게시물 등록자의 받은 리뷰 총 개수와 평균 별점 반환
	ReviewSummaryDTO selectAvgAndCountReview(Long revieweeNo);
}
