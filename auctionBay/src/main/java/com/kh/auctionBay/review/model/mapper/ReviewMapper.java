package com.kh.auctionBay.review.model.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.kh.auctionBay.review.model.dto.ReviewDTO;
import com.kh.auctionBay.review.model.dto.ReviewResultList;

@Mapper
public interface ReviewMapper {
	
	// 받은 후기 목록 조회
	List<ReviewDTO> selectReceivedReviews(Long userNo);
	
	// 보낸 후기 목록 조회
	List<ReviewDTO> selectSentReviews(Long userNo);
	
	// 후기 작성
	int insertReview(ReviewDTO review);
}
