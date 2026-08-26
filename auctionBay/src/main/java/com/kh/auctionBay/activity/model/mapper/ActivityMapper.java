package com.kh.auctionBay.activity.model.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.kh.auctionBay.activity.model.dto.MyCommentDTO;
import com.kh.auctionBay.activity.model.dto.RecentViewDTO;
import com.kh.auctionBay.activity.model.dto.WishlistDTO;
import com.kh.auctionBay.product.model.dto.ProductDTO;

@Mapper
public interface ActivityMapper {
	
	// 1. 회원 번호(userNo)를 받아 해당 회원이 작성한 게시글 목록을 조회하는 메서드
	List<ProductDTO> selectMyBoardList(Long userNo);
	
	// 2. 회원 번호(userNo)를 받아 해당 회원이 작성한 댓글 목록을 조회하는 메서드
	List<MyCommentDTO> selectMyCommentList(Long userNo);

	// 3. 회원 번호(userNo)를 받아 해당 회원의 찜 목록을 조회하는 메서드
	List<WishlistDTO> selectMyWishlist(Long userNo);

	// 4. 회원 번호(userNo)를 받아 해당 회원이 최근 본 글 목록을 조회하는 메서드
	List<RecentViewDTO> selectRecentViews(Long userNo);
	
	// 5. 내가 작성한 게시글 삭제 (성공 시 변경된 행 수 반환)
	int deleteMyBoard(@Param("productNo") Long productNo, @Param("writerNo") Long writerNo);

	// 6. 내가 작성한 댓글 삭제
	int deleteMyComment(@Param("commentNo") Long commentNo, @Param("writerNo") Long writerNo);
}