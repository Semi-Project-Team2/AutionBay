package com.kh.auctionBay.activity.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.kh.auctionBay.activity.model.dto.MyCommentDTO;
import com.kh.auctionBay.activity.model.dto.RecentViewDTO;
import com.kh.auctionBay.activity.model.dto.WishlistDTO;
import com.kh.auctionBay.activity.model.mapper.ActivityMapper;
import com.kh.auctionBay.product.model.dto.ProductDTO;

import lombok.RequiredArgsConstructor;

/**
 * [ActivityServiceImpl]
 * - 활동 내역(마이페이지: 작성글, 댓글, 찜, 최근 본 글)과 관련된 
 *   비즈니스 로직을 처리하는 서비스 구현체 클래스입니다.
 */
@Service 
@RequiredArgsConstructor // final 필드(activityMapper)의 생성자를 자동으로 생성하여 의존성 주입(DI) 수행
public class ActivityServiceImpl implements ActivityService {

	// DB 조회를 수행할 Mapper 객체
	private final ActivityMapper activityMapper;
	
	/**
	 * [1. 내가 작성한 게시글 목록 조회 로직]
	 * - 요청 데이터: 로그인한 회원의 번호 (userNo)
	 * - 처리 과정: Mapper를 호출하여 해당 회원이 작성한 게시글 리스트를 가져옵니다.
	 * - 반환 데이터: List<ProductDTO> 형태의 게시글 목록
	 */
	@Override
	public List<ProductDTO> selectMyProductList(Long userNo, String keyword) {
	    return activityMapper.selectMyProductList(userNo, keyword);
	}
	
	/**
	 * [2. 내가 작성한 댓글 목록 조회 로직]
	 * - 요청 데이터: 로그인한 회원의 번호 (userNo)
	 * - 처리 과정: Mapper를 호출하여 해당 회원이 작성한 댓글 리스트를 가져옵니다.
	 * - 반환 데이터: List<MyCommentDTO> 형태의 댓글 목록
	 */
	@Override
	public List<MyCommentDTO> selectMyCommentList(Long userNo) {
		return activityMapper.selectMyCommentList(userNo);
	}
	
	/**
	 * [3. 찜 목록 조회 로직]
	 * - 요청 데이터: 로그인한 회원의 번호 (userNo)
	 * - 처리 과정: Mapper를 호출하여 해당 회원이 찜한 상품 리스트를 가져옵니다.
	 * - 반환 데이터: List<WishlistDTO> 형태의 찜 목록
	 */
	@Override
	public List<WishlistDTO> selectMyWishlist(Long userNo) {
		return activityMapper.selectMyWishlist(userNo);
	}
	
	/**
	 * [4. 최근 본 글 목록 조회 로직]
	 * - 요청 데이터: 로그인한 회원의 번호 (userNo)
	 * - 처리 과정: Mapper를 호출하여 사용자가 최근에 조회한 상품 히스토리 리스트를 가져옵니다.
	 * - 반환 데이터: List<RecentViewDTO> 형태의 최근 본 글 목록
	 */
	@Override
	public List<RecentViewDTO> selectRecentViews(Long userNo) {
		return activityMapper.selectRecentViews(userNo);
	}
	
	/**
	 * [5. 내가 작성한 게시글 삭제 로직 (소프트 딜리트)]
	 * - 요청 데이터: 상품 번호(productNo), 작성자 번호(writerNo)
	 * - 처리 과정: Mapper를 통해 게시글의 삭제 상태 값을 변경하고, 업데이트된 행의 수가 0보다 큰지(성공 여부) 확인합니다.
	 * - 반환 데이터: 성공 시 true, 실패 시 false (boolean)
	 */
	@Override
	public boolean deleteMyProduct(Long productNo, Long writerNo) {
		int result = activityMapper.deleteMyProduct(productNo, writerNo);
		return result > 0;
	}

	/**
	 * [6. 내가 작성한 댓글 삭제 로직]
	 * - 요청 데이터: 댓글 번호(commentNo), 작성자 번호(writerNo)
	 * - 처리 과정: Mapper를 통해 댓글 내용을 마스킹 처리('삭제된 댓글입니다.')하고, 업데이트된 행의 수가 0보다 큰지 확인합니다.
	 * - 반환 데이터: 성공 시 true, 실패 시 false (boolean)
	 */
	@Override
	public boolean deleteMyComment(Long commentNo, Long writerNo) {
		int result = activityMapper.deleteMyComment(commentNo, writerNo);
		return result > 0;
	}
	// ActivityServiceImpl.java
	@Override
	public boolean removeRecentView(long userNo, long productNo) {
	    return activityMapper.deleteRecentView(userNo, productNo) > 0;
	}

	@Override
	public boolean removeAllRecentViews(long userNo) {
	    return activityMapper.deleteAllRecentViews(userNo) > 0;
	}
}