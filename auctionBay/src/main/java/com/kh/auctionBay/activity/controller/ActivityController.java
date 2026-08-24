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

/**
 * [마이페이지 - 내 활동 내역 컨트롤러]
 * 로그인한 사용자의 작성 게시글, 작성 댓글, 찜 목록, 최근 본 상품/글 조회 및 삭제 요청을 처리합니다.
 */
@Controller
@RequestMapping("/activity")
@RequiredArgsConstructor
public class ActivityController {

	// 마이페이지 활동 내역 관련 비즈니스 로직을 수행하는 서비스 주입
	private final ActivityService activityService;

	
	/* =========================================================================
	 * 1. 화면 조회 요청 (GET)
	 * ========================================================================= */

	/**
	 * [내가 작성한 게시글 목록 페이지 이동]
	 * @param session 현재 사용자 세션 (로그인 정보 확인용)
	 * @param model   뷰(JSP)로 게시글 목록 데이터를 전달하기 위한 객체
	 * @return        activity/myBoardList.jsp 이동
	 */
	@GetMapping("/myBoard")
	public String myBoardList(HttpSession session, Model model) {
		// TODO: 실제 서비스 구현 시 세션에서 로그인한 회원 번호(userNo)를 가져와야 합니다. (현재는 테스트용 1L 사용)
		Long loginUserNo = 1L; 

		// 로그인한 회원의 게시글 목록 조회
		List<MyBoardDTO> boardList = activityService.selectMyBoardList(loginUserNo);
		
		// 조회한 목록 데이터를 Model에 담아 JSP로 전달
		model.addAttribute("boardList", boardList);

		return "activity/myBoardList";
	}

	/**
	 * [내가 작성한 댓글 목록 페이지 이동]
	 * @param session 현재 사용자 세션
	 * @param model   뷰(JSP)로 댓글 목록 데이터를 전달하기 위한 객체
	 * @return        activity/myCommentList.jsp 이동
	 */
	@GetMapping("/myComment")
	public String myCommentList(HttpSession session, Model model) {
		Long loginUserNo = 1L; 

		// 로그인한 회원의 댓글 목록 조회
		List<MyCommentDTO> commentList = activityService.selectMyCommentList(loginUserNo);
		model.addAttribute("commentList", commentList);

		return "activity/myCommentList";
	}

	/**
	 * [찜한 상품 목록 페이지 이동]
	 * @param session 현재 사용자 세션
	 * @param model   뷰(JSP)로 찜 목록 데이터를 전달하기 위한 객체
	 * @return        activity/wishlist.jsp 이동
	 */
	@GetMapping("/wishlist")
	public String myWishlist(HttpSession session, Model model) {
		Long loginUserNo = 1L; 

		// 로그인한 회원의 찜 목록 조회
		List<WishlistDTO> wishlist = activityService.selectMyWishlist(loginUserNo);
		model.addAttribute("wishlist", wishlist);

		return "activity/wishlist";
	}

	/**
	 * [최근 본 글/상품 목록 페이지 이동]
	 * @param session 현재 사용자 세션
	 * @param model   뷰(JSP)로 최근 본 목록 데이터를 전달하기 위한 객체
	 * @return        activity/recentList.jsp 이동
	 */
	@GetMapping("/recent")
	public String recentViews(HttpSession session, Model model) {
		Long loginUserNo = 1L; 

		// 로그인한 회원의 최근 본 목록 조회
		List<RecentViewDTO> recentList = activityService.selectRecentViews(loginUserNo);
		model.addAttribute("recentList", recentList);

		return "activity/recentList";
	}


	/* =========================================================================
	 * 2. 삭제 처리 요청 (POST / AJAX 비동기 통신)
	 * ========================================================================= */

	/**
	 * [내가 작성한 게시글 삭제 처리 (AJAX)]
	 * @param productNo 삭제할 게시글(상품) 번호
	 * @param session   현재 사용자 세션 (본인 검증용)
	 * @return          성공 시 "SUCCESS", 실패 시 "FAIL" 문자열 반환
	 */
	@PostMapping("/deleteBoard")
	@ResponseBody
	public String deleteMyBoard(@RequestParam("productNo") Long productNo, 
	                             HttpSession session) {
		Long loginUserNo = 1L; 

		// 타인의 글을 함부로 삭제하지 못하도록 '글 번호'와 '로그인 회원 번호'를 함께 넘겨 본인 확인 후 삭제
		boolean isDeleted = activityService.deleteMyBoard(productNo, loginUserNo);

		// AJAX 성공/실패 여부를 단순 문자열로 반환
		return isDeleted ? "SUCCESS" : "FAIL";
	}

	/**
	 * [내가 작성한 댓글 삭제 처리 (AJAX)]
	 * @param commentNo 삭제할 댓글 번호
	 * @param session   현재 사용자 세션 (본인 검증용)
	 * @return          성공 시 "SUCCESS", 실패 시 "FAIL" 문자열 반환
	 */
	@PostMapping("/deleteComment")
	@ResponseBody
	public String deleteMyComment(@RequestParam("commentNo") Long commentNo, 
	                               HttpSession session) {
		Long loginUserNo = 1L; 

		// 본인 댓글 검증 후 삭제 진행
		boolean isDeleted = activityService.deleteMyComment(commentNo, loginUserNo);

		return isDeleted ? "SUCCESS" : "FAIL";
	}

}