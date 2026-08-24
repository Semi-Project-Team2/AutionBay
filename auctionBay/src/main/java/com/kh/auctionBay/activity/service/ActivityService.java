package com.kh.auctionBay.activity.service;

import java.util.List;

import com.kh.auctionBay.activity.dto.MyBoardDTO;
import com.kh.auctionBay.activity.dto.MyCommentDTO;
import com.kh.auctionBay.activity.dto.RecentViewDTO;
import com.kh.auctionBay.activity.dto.WishlistDTO;

public interface ActivityService {

	// 1. 내가 작성한 게시글 목록 조회
	List<MyBoardDTO> selectMyBoardList(Long userNo);

	// 2. 내가 작성한 댓글 목록 조회
	List<MyCommentDTO> selectMyCommentList(Long userNo);

	// 3. 찜 목록 조회
	List<WishlistDTO> selectMyWishlist(Long userNo);

	// 4. 최근 본 글 목록 조회
	List<RecentViewDTO> selectRecentViews(Long userNo);
	// 5. 내가 작성한 게시글 삭제
		boolean deleteMyBoard(Long productNo, Long writerNo);

		// 6. 내가 작성한 댓글 삭제
		boolean deleteMyComment(Long commentNo, Long writerNo);
}