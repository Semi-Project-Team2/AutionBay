package com.kh.auctionBay.review.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.kh.auctionBay.review.model.dto.ReviewDTO;

@Service
public class ReviewServiceImpl implements ReviewService {

	@Override
	public List<ReviewDTO> getRecievedReviews(Long userNo) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<ReviewDTO> getSentReviews(Long userNo) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public ReviewDTO getReviewDetail(Long reviewId) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public int writeReview(ReviewDTO review) {
		// TODO Auto-generated method stub
		return 0;
	}

}
