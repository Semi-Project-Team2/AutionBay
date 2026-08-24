package com.kh.auctionBay.review.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.kh.auctionBay.review.model.dto.ReviewDTO;
import com.kh.auctionBay.review.model.mapper.ReviewMapper;

import lombok.RequiredArgsConstructor;


import org.springframework.stereotype.Service;

@RequiredArgsConstructor
@Service
public class ReviewServiceImpl implements ReviewService {
	/* Mapper DI (생성자 주입) */
	private final ReviewMapper reviewMapper;

	/**
	 * 받은 후기 목록 조회
	 */
	@Override
	public List<ReviewDTO> getReceivedReviews(Long userNo) {
		List<ReviewDTO> receivedReviews = reviewMapper.selectReceivedReviews(userNo);
		
		return receivedReviews;
	}

	/**
	 * 보낸 후기 목록 조회
	 */
	@Override
	public List<ReviewDTO> getSentReviews(Long userNo) {
		List<ReviewDTO> sentReviews = reviewMapper.selectSentReviews(userNo);

		return null;
	}

	/**
	 * 리뷰 작성
	 */
	@Override
	public int writeReview(ReviewDTO review) {
		int result = reviewMapper.insertReview(review);
		return result;
	}

}
