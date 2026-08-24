package com.kh.auctionBay.activity.controller;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.kh.auctionBay.activity.dto.MyBoardDTO;
import com.kh.auctionBay.activity.dto.MyCommentDTO;
import com.kh.auctionBay.activity.dto.RecentViewDTO;
import com.kh.auctionBay.activity.dto.WishlistDTO;
import com.kh.auctionBay.activity.service.ActivityService;

import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;

// 마이페이지 활동 내역(게시글, 댓글, 찜, 최근본글) 관련 요청을 처리하는 컨트롤러
@Controller
@RequestMapping("/activity")
@RequiredArgsConstructor
public class ActivityController {

	// 비즈니스 로직을 처리하는 ActivityService 주입
	private final ActivityService activityService;

	
	/* =========================================================================
	 * 1. 화면 조회 (GET 요청)
	 * ========================================================================= */

	// 1-1. 내가 작성한 게시글 목록 페이지 이동
	@GetMapping("/myBoard")
	public String myBoardList(HttpSession session, Model model) {
		// 세션에서 로그인한 회원 정보 추출 (테스트용: 1L)
		Long loginUserNo = 1L; 

		List<MyBoardDTO> boardList = activityService.selectMyBoardList(loginUserNo);
		model.addAttribute("boardList", boardList);

		return "activity/myBoardList"; // WEB-INF/views/activity/myBoardList.jsp
	}

	// 1-2. 내가 작성한 댓글 목록 페이지 이동
	@GetMapping("/myComment")
	public String myCommentList(HttpSession session, Model model) {
		Long loginUserNo = 1L; 

		List<MyCommentDTO> commentList = activityService.selectMyCommentList(loginUserNo);
		model.addAttribute("commentList", commentList);

		return "activity/myCommentList";
	}

	// 1-3. 찜 목록 페이지 이동
	@GetMapping("/wishlist")
	public String myWishlist(HttpSession session, Model model) {
		Long loginUserNo = 1L; 

		List<WishlistDTO> wishlist = activityService.selectMyWishlist(loginUserNo);
		model.addAttribute("wishlist", wishlist);

		return "activity/wishlist";
	}

	// 1-4. 최근 본 글 목록 페이지 이동
	@GetMapping("/recent")
	public String recentViews(HttpSession session, Model model) {
		Long loginUserNo = 1L; 

		List<RecentViewDTO> recentList = activityService.selectRecentViews(loginUserNo);
		model.addAttribute("recentList", recentList);

		return "activity/recentList";
	}


	/* =========================================================================
	 * 2. 삭제 처리 (POST / AJAX 비동기 요청)
	 * ========================================================================= */

	// 2-1. 내가 작성한 게시글 삭제 처리 (AJAX)
	@PostMapping("/deleteBoard")
	@ResponseBody
	public String deleteMyBoard(@RequestParam("productNo") Long productNo, 
	                            HttpSession session) {
		// 로그인 회원의 본인 작성글만 삭제되도록 회원 번호 전달
		Long loginUserNo = 1L; 

		boolean isDeleted = activityService.deleteMyBoard(productNo, loginUserNo);

		// 자바스크립트(AJAX) 응답으로 성공/실패 문자열 반환
		return isDeleted ? "SUCCESS" : "FAIL";
	}

	// 2-2. 내가 작성한 댓글 삭제 처리 (AJAX)
	@PostMapping("/deleteComment")
	@ResponseBody
	public String deleteMyComment(@RequestParam("commentNo") Long commentNo, 
	                              HttpSession session) {
		Long loginUserNo = 1L; 

		boolean isDeleted = activityService.deleteMyComment(commentNo, loginUserNo);

		return isDeleted ? "SUCCESS" : "FAIL";
	}

}