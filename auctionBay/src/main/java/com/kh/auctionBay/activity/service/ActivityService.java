package com.kh.auctionBay.activity.service;

import java.util.List;

import com.kh.auctionBay.activity.model.dto.MyCommentDTO;
import com.kh.auctionBay.activity.model.dto.RecentViewDTO;
import com.kh.auctionBay.activity.model.dto.WishlistDTO;
import com.kh.auctionBay.product.model.dto.ProductDTO;

public interface ActivityService {

	// 1. 내가 작성한 게시글 목록 조회 (검색어 파라미터 추가)
	List<ProductDTO> selectMyProductList(Long userNo, String keyword);	

	// 2. 내가 작성한 댓글 목록 조회
	List<MyCommentDTO> selectMyCommentList(Long userNo);

	// 3. 찜 목록 조회
	List<WishlistDTO> selectMyWishlist(Long userNo);

	// 4. 최근 본 글 목록 조회
	List<RecentViewDTO> selectRecentViews(Long userNo);
	
	// 5. 내가 작성한 게시글 삭제
	boolean deleteMyProduct(Long productNo, Long writerNo);

	// 6. 내가 작성한 댓글 삭제
	boolean deleteMyComment(Long commentNo, Long writerNo);
	
	// 7. 최근 본 글 삭제
	boolean removeRecentView(long userNo, long productNo);
	// 8. 최근 본 글 전체 삭제
	boolean removeAllRecentViews(long userNo);
}