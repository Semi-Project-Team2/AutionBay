package com.kh.auctionBay.activity.service;

import java.util.List;

import org.springframework.stereotype.Service;
// 만든 DTO 및 Mapper 임포트
import com.kh.auctionBay.activity.dto.MyBoardDTO;
import com.kh.auctionBay.activity.dto.MyCommentDTO;
import com.kh.auctionBay.activity.dto.RecentViewDTO;
import com.kh.auctionBay.activity.dto.WishlistDTO;
import com.kh.auctionBay.activity.mapper.ActivityMapper;

import lombok.RequiredArgsConstructor;
//이 클래스가 비즈니스 로직을 처리하는 Service 빈(Bean)임을 스프링에 등록
@Service 
//final로 선언된 필드(activityMapper)의 생성자를 자동으로 만들어 의존성을 주입(DI)받음
@RequiredArgsConstructor

public class ActivityServiceImpl implements ActivityService {
	// DB 조회를 수행할 Mapper 객체를 의존성 주입 받음
	private final ActivityMapper activityMapper;
	
	// 1. 내가 작성한 게시글 목록 조회 로직
	@Override
	public List<MyBoardDTO> selectMyBoardList(Long userNo) {
		// Mapper를 호출하여 해당 회원의 게시글 목록 데이터를 받아온 후 그대로 반환
		return activityMapper.selectMyBoardList(userNo);
	}
	
	// 2. 내가 작성한 댓글 목록 조회 로직
	@Override
	public List<MyCommentDTO> selectMyCommentList(Long userNo) {
		// Mapper를 호출하여 해당 회원의 댓글 목록 데이터를 받아온 후 그대로 반환
		return activityMapper.selectMyCommentList(userNo);
		
	}
	
	// 3. 찜 목록 조회 로직
	@Override
	public List<WishlistDTO> selectMyWishlist(Long userNo) {
		// Mapper를 호출하여 해당 회원이 조회했던 최근 글 목록 데이터를 받아온 후 그대로 반환
		return activityMapper.selectMyWishlist(userNo);
	}
	// 4. 최근 본 글 목록 조회 로직
	@Override
	public List<RecentViewDTO> selectRecentViews(Long userNo) {
		// Mapper를 호출하여 해당 회원이 조회했던 최근 글 목록 데이터를 받아온 후 그대로 반환
		return activityMapper.selectRecentViews(userNo);
	}
	// 5. 내가 작성한 게시글 삭제 로직
		@Override
		public boolean deleteMyBoard(Long productNo, Long writerNo) {
			int result = activityMapper.deleteMyBoard(productNo, writerNo);
			return result > 0;
		}

		// 6. 내가 작성한 댓글 삭제 로직
		@Override
		public boolean deleteMyComment(Long commentNo, Long writerNo) {
			int result = activityMapper.deleteMyComment(commentNo, writerNo);
			return result > 0;
		}
}