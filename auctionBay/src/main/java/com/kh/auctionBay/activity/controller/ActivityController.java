package com.kh.auctionBay.activity.controller;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.kh.auctionBay.activity.model.dto.MyBoardDTO;
import com.kh.auctionBay.activity.model.dto.MyCommentDTO;
import com.kh.auctionBay.activity.model.dto.RecentViewDTO;
import com.kh.auctionBay.activity.model.dto.WishlistDTO;
import com.kh.auctionBay.activity.service.ActivityService;
import com.kh.auctionBay.common.SessionConst;
import com.kh.auctionBay.user.model.dto.UserDTO;

import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor 
public class ActivityController {

	private final ActivityService activityService;

	/**
	 * [공통 메서드: 로그인 회원 번호 추출]
	 * - 처리 과정: HttpSession에서 팀원들과 공통으로 사용하는 SessionConst.LOGIN_USER 키를 통해 
	 *             현재 로그인된 UserDTO 객체를 꺼내옵니다.
	 * - 예외 처리: 로그인이 되어 있지 않거나 세션이 만료된 경우 테스트 및 에러 방지를 위해 1L(기본 회원 번호)을 반환합니다.
	 */
	private long getLoginUserNo(HttpSession session) {
	    UserDTO loginUser = (UserDTO) session.getAttribute(SessionConst.LOGIN_USER);
	    return (loginUser != null) ? loginUser.getUserNo() : 1L; 
	}

	/**
	 * [1-1. 내가 작성한 게시글 목록 페이지 요청 및 응답]
	 * - 요청 URL: GET /mypage/boards
	 * - 요청 방식: 클라이언트(브라우저)가 마이페이지 메뉴에서 '내가 쓴 글'을 클릭하여 GET 방식으로 요청
	 * - 처리 과정: 
	 *    1. 세션을 통해 현재 로그인한 사용자의 고유 번호(userNo)를 가져옵니다.
	 *    2. ActivityService를 호출하여 해당 유저가 작성한 게시글 목록(List<MyBoardDTO>)을 DB에서 조회합니다.
	 *    3. 조회한 데이터를 Model 객체에 "boardList"라는 이름으로 담아 뷰(JSP)로 전달합니다.
	 * - 응답 뷰: "mypage/boards" (JSP 페이지 포워딩)
	 */
	@GetMapping("/mypage/boards")
	public String myBoardList(HttpSession session, Model model) {
		long userNo = getLoginUserNo(session);

		List<MyBoardDTO> boardList = activityService.selectMyBoardList(userNo);
		model.addAttribute("boardList", boardList);
		return "mypage/boards";
	}

	/**
	 * [1-2. 내가 작성한 댓글 목록 페이지 요청 및 응답]
	 * - 요청 URL: GET /mypage/comments
	 * - 요청 방식: 클라이언트가 마이페이지에서 '내가 쓴 댓글' 탭을 클릭하여 GET 요청
	 * - 처리 과정: 로그인한 유저 번호로 서비스에 댓글 목록 조회를 요청하고, 결과를 Model에 담아 뷰로 넘깁니다.
	 * - 응답 뷰: "mypage/comments"
	 */
	@GetMapping("/mypage/comments")
	public String myCommentList(HttpSession session, Model model) {
		long userNo = getLoginUserNo(session);

		List<MyCommentDTO> commentList = activityService.selectMyCommentList(userNo);
		model.addAttribute("commentList", commentList);
		return "mypage/comments";
	}

	/**
	 * [1-3. 찜 목록 페이지 요청 및 응답]
	 * - 요청 URL: GET /member/wishlist
	 * - 요청 방식: 클라이언트가 찜 목록 메뉴를 클릭하여 GET 요청
	 * - 처리 과정: 로그인한 유저 번호를 바탕으로 찜한 상품 목록 데이터를 조회해 Model에 담습니다.
	 * - 응답 뷰: "member/wishlist"
	 */
	@GetMapping("/member/wishlist")
	public String myWishlist(HttpSession session, Model model) {
		long userNo = getLoginUserNo(session);

		List<WishlistDTO> wishlist = activityService.selectMyWishlist(userNo);
		model.addAttribute("wishlist", wishlist);
		return "member/wishlist"; 
	}

	/**
	 * [1-4. 최근 본 글 목록 페이지 요청 및 응답]
	 * - 요청 URL: GET /mypage/recent
	 * - 요청 방식: 클라이언트가 최근 본 상품 목록 메뉴를 클릭하여 GET 요청
	 * - 처리 과정: 사용자의 히스토리 데이터 중 최근 조회한 상품 목록을 서비스로부터 받아와 Model에 담습니다.
	 * - 응답 뷰: "mypage/recent"
	 */
	@GetMapping("/mypage/recent")
	public String recentViews(HttpSession session, Model model) {
		long userNo = getLoginUserNo(session);

		List<RecentViewDTO> recentList = activityService.selectRecentViews(userNo);
		model.addAttribute("recentList", recentList);
		return "mypage/recent";
	}

	/**
	 * [1-5. 후기 목록 페이지 이동]
	 * - 요청 URL: GET /mypage/review/list
	 * - 처리 과정: 후기 관리 페이지 화면을 단순 반환합니다.
	 * - 응답 뷰: "mypage/reviews"
	 */
	@GetMapping("/mypage/review/list")
	public String reviewList(HttpSession session, Model model) {
		return "mypage/reviews";
	}

	/**
	 * [2-1. 내가 작성한 게시글 삭제 처리 (AJAX 비동기 통신)]
	 * - 요청 URL: GET /mypage/deleteBoard?productNo=상품번호
	 * - 요청 방식: 화면을 새로고침하지 않고, JavaScript(AJAX)를 통해 비동기로 삭제 요청 전송
	 * - 처리 과정: 
	 *    1. 파라미터로 넘어온 상품 번호(productNo)와 로그인 유저 번호(userNo)를 받습니다.
	 *    2. 서비스에서 소프트 딜리트(상태값 변경 방식)를 수행하고 성공 여부(boolean)를 리턴 받습니다.
	 * - 응답 데이터: 화면 리프레시 없이 결과만 판별할 수 있도록 `@ResponseBody`를 붙여 
	 *               성공 시 `"SUCCESS"`, 실패 시 `"FAIL"` 문자열 데이터를 직접 반환합니다.
	 */
	@GetMapping("/mypage/deleteBoard")
	@ResponseBody 
	public String deleteMyBoard(@RequestParam("productNo") Long productNo, HttpSession session) {
		long userNo = getLoginUserNo(session);

		boolean isDeleted = activityService.deleteMyBoard(productNo, userNo);
		return isDeleted ? "SUCCESS" : "FAIL";
	}

	/**
	 * [2-2. 내가 작성한 댓글 삭제 처리 (AJAX 비동기 통신)]
	 * - 요청 URL: GET /mypage/deleteComment?commentNo=댓글번호
	 * - 요청 방식: AJAX를 이용한 비동기 요청
	 * - 처리 과정: 댓글 번호와 유저 번호를 이용해 댓글 내용 마스킹 처리('삭제된 댓글입니다.')를 수행합니다.
	 * - 응답 데이터: 성공 시 `"SUCCESS"`, 실패 시 `"FAIL"` 문자열을 비동기로 반환 (@ResponseBody)
	 */
	@GetMapping("/mypage/deleteComment")
	@ResponseBody 
	public String deleteMyComment(@RequestParam("commentNo") Long commentNo, HttpSession session) {
		long userNo = getLoginUserNo(session);

		boolean isDeleted = activityService.deleteMyComment(commentNo, userNo);
		return isDeleted ? "SUCCESS" : "FAIL";
	}

	/**
	 * [3-1. 상품 상세 페이지 이동 처리]
	 * - 요청 URL: GET /board/detail?no=상품번호
	 * - 처리 과정: 마이페이지 등에서 특정 게시글이나 상품을 클릭했을 때 상세 조회 화면으로 연결합니다.
	 * - 응답 뷰: "auction/detail"
	 */
	@GetMapping("/board/detail")
	public String boardDetail(@RequestParam("no") Long no, Model model) {
		return "auction/detail"; 
	}

}