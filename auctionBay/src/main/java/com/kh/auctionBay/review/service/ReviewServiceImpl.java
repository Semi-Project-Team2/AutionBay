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
	public ReviewResultList getReceivedReviews(SearchCondition condition) {
		// 받은 후기 개수 조회
		int totalCount = reviewMapper.selectReceivedReviewsCount(condition);
		
		// 페이징 정보 저장
		int page = condition.getPage();
		int size = condition.getSize();
		PageInfo pageInfo = new PageInfo(page, size, totalCount);
		
		// offset을 pageInfo에서 가져오기
		condition.setOffset(pageInfo.getOffset());
		
		// 받은 후기 리스트 조회 및 저장
		ReviewResultList receivedReviews = new ReviewResultList(
				 reviewMapper.selectReceivedReviews(condition),
				 pageInfo);
		
		return receivedReviews;
	}

	/**
	 * 보낸 후기 목록 조회
	 */
	@Override
	public ReviewResultList getSentReviews(SearchCondition condition) {
		// 보낸 후기 개수 조회
		int totalCount = reviewMapper.selectSentReviewsCount(condition);
		
		// 페이징 정보 저장
		int page = condition.getPage();
		int size = condition.getSize();
		PageInfo pageInfo = new PageInfo(page, size, totalCount);
		
		// offset을 pageInfo에서 가져오기
		condition.setOffset(pageInfo.getOffset());

		// 보낸 후기 리스트 조회 및 저장
		ReviewResultList sentReviews = new ReviewResultList(
				reviewMapper.selectSentReviews(condition),
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
