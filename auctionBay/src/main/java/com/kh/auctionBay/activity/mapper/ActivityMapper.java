package com.kh.auctionBay.activity.mapper;

import java.util.List;

import com.kh.auctionBay.activity.dto.MyBoardDTO;
import com.kh.auctionBay.activity.dto.MyCommentDTO;
import com.kh.auctionBay.activity.dto.RecentViewDTO;
import com.kh.auctionBay.activity.dto.WishlistDTO;

public interface ActivityMapper {
	List<MyBoardDTO> selectMyBoardList(Long userNo);
	//2. 회원 번호(userNo)를 받아 해당 회원이 작성한 댓글 목록을 조회하는 메서드
	List<MyCommentDTO> selectMyCommentList(Long userNo);

	// 3. 회원 번호(userNo)를 받아 해당 회원의 찜 목록을 조회하는 메서드
	List<WishlistDTO> selectMyWishlist(Long userNo);

	// 4. 회원 번호(userNo)를 받아 해당 회원이 최근 본 글 목록을 조회하는 메서드
	List<RecentViewDTO> selectRecentViews(Long userNo);

}
