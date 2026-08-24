package com.kh.auctionBay.activity.controller;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.kh.auctionBay.activity.dto.MyBoardDTO;
import com.kh.auctionBay.activity.dto.MyCommentDTO;
import com.kh.auctionBay.activity.dto.RecentViewDTO;
import com.kh.auctionBay.activity.dto.WishlistDTO;
import com.kh.auctionBay.activity.service.ActivityService;

import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor 
public class ActivityController {

	private final ActivityService activityService;

	// 1-1. 내가 작성한 게시글 목록 페이지 이동
	@GetMapping("/mypage/boards")
	public String myBoardList(HttpSession session, Model model) {
		List<MyBoardDTO> boardList = activityService.selectMyBoardList(1L);
		model.addAttribute("boardList", boardList);
		return "mypage/boards";
	}

	// 1-2. 내가 작성한 댓글 목록 페이지 이동
	@GetMapping("/mypage/comments")
	public String myCommentList(HttpSession session, Model model) {
		List<MyCommentDTO> commentList = activityService.selectMyCommentList(1L);
		model.addAttribute("commentList", commentList);
		return "mypage/comments";
	}

	// 1-3. 찜 목록 페이지 이동
	@GetMapping("/member/wishlist")
	public String myWishlist(HttpSession session, Model model) {
		List<WishlistDTO> wishlist = activityService.selectMyWishlist(1L);
		model.addAttribute("wishlist", wishlist);
		return "member/wishlist"; 
	}

	// 1-4. 최근 본 글 목록 페이지 이동
	@GetMapping("/mypage/recent")
	public String recentViews(HttpSession session, Model model) {
		List<RecentViewDTO> recentList = activityService.selectRecentViews(1L);
		model.addAttribute("recentList", recentList);
		return "mypage/recent";
	}

	// 1-5. 후기 목록 페이지 이동
	@GetMapping("/mypage/review/list")
	public String reviewList(HttpSession session, Model model) {
		return "mypage/reviews";
	}

	// 2-1. 내가 작성한 게시글 삭제 처리
	@GetMapping("/mypage/deleteBoard")
	@ResponseBody 
	public String deleteMyBoard(@RequestParam("productNo") Long productNo, HttpSession session) {
		boolean isDeleted = activityService.deleteMyBoard(productNo, 1L);
		return isDeleted ? "SUCCESS" : "FAIL";
	}

	// 2-2. 내가 작성한 댓글 삭제 처리
	@GetMapping("/mypage/deleteComment")
	@ResponseBody 
	public String deleteMyComment(@RequestParam("commentNo") Long commentNo, HttpSession session) {
		boolean isDeleted = activityService.deleteMyComment(commentNo, 1L);
		return isDeleted ? "SUCCESS" : "FAIL";
	}

	// 3-1. 상품 상세 페이지 이동 처리
		@GetMapping("/board/detail")
		public String boardDetail(@RequestParam("no") Long no, Model model) {
			// 필요시 나중에 상세 조회 서비스 연결
			return "auction/detail"; // "board/detail" 이 아니라 "auction/detail"로 수정!
		}

}