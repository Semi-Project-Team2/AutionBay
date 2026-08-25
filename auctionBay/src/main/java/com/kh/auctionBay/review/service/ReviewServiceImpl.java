package com.kh.auctionBay.review.service;

import org.springframework.stereotype.Service;

import com.kh.auctionBay.common.dto.PageInfo;
import com.kh.auctionBay.review.model.dto.ReviewDTO;
import com.kh.auctionBay.review.model.dto.ReviewResultList;
import com.kh.auctionBay.review.model.dto.SearchCondition;
import com.kh.auctionBay.review.model.mapper.ReviewMapper;

import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Service
public class ReviewServiceImpl implements ReviewService {
	/* Mapper DI (생성자 주입) */
	private final ReviewMapper reviewMapper;

	/**
	 * 받은 후기 목록 조회
	 */
	@Override
	public ReviewResultList getReceivedReviews(Long userNo) {
		// 받은 후기 개수 조회
		int totalCount = reviewMapper.selectReceivedReviewsCount(userNo);
		
		// 페이징 정보 저장
		int page = 1;	// 페이지 번호 1로 초기화
		int size = 5;	// 한 페이지 당 5개씩 보이도록 초기화
		PageInfo pageInfo = new PageInfo(page, size, totalCount);
		
		// 받은 후기 리스트 조회 및 저장
		ReviewResultList receivedReviews = new ReviewResultList(
				 reviewMapper.selectReceivedReviews(userNo),
				 pageInfo);
		
		return receivedReviews;
	}

	/**
	 * 보낸 후기 목록 조회
	 */
	@Override
	public ReviewResultList getSentReviews(Long userNo) {
		// 보낸 후기 개수 조회
		int totalCount = reviewMapper.selectSentReviewsCount(userNo);
		
		// 페이징 정보 저장
		int page = 1;
		int size = 5;
		PageInfo pageInfo = new PageInfo(page, size, totalCount);
		
		// 보낸 후기 리스트 조회 및 저장
		ReviewResultList sentReviews = new ReviewResultList(
				reviewMapper.selectSentReviews(userNo),
				pageInfo);

		return sentReviews;
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
