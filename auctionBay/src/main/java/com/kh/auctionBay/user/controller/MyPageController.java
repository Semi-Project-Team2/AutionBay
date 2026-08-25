package com.kh.auctionBay.user.controller;

import java.io.IOException;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.kh.auctionBay.common.SessionConst;
import com.kh.auctionBay.review.model.dto.ReviewDTO;
import com.kh.auctionBay.review.model.dto.ReviewResultList;
import com.kh.auctionBay.review.model.dto.TxHistoryDTO;
import com.kh.auctionBay.review.model.dto.TxHistoryResultList;
import com.kh.auctionBay.review.model.dto.SearchCondition;
import com.kh.auctionBay.review.service.ReviewService;
import com.kh.auctionBay.review.service.TxHistoryService;
import com.kh.auctionBay.user.model.dto.UserDTO;
import com.kh.auctionBay.user.service.UserService;

import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
@RequestMapping("/mypage")
public class MyPageController {
	// service DI (생성자 주입)
	private final TxHistoryService txService;
	private final ReviewService reviewService;
	private final UserService userService;
//	private final ProductService productService;
	
	
	/* ------------- 화면 이동 요청 --------------- */
	
	/**
 	 * 거래 목록 화면
	 * @param session
	 * @param model
	 * @return
	 */
	@GetMapping("/txHistories")
	public String txHistories(HttpSession session, Model model,
				@ModelAttribute SearchCondition condition) {
		
		// 로그인한 사용자 정보를 loginUser로 백엔드에 저장
		UserDTO loginUser = (UserDTO)session.getAttribute(SessionConst.LOGIN_USER);
		
		// 로그인 진행 X(또는 로그인 세션 만료) 시 로그인 페이지로 리다이렉트
		if (loginUser == null) {
			return "redirect:/user/login";
		}
		
		// 검색 조건 중 userNo 필드에 로그인한 사용자 넘버 저장
		Long userNo = loginUser.getUserNo();
		condition.setUserNo(userNo);
		
		// DB에서 데이터 조회 후 변수에 저장
		TxHistoryResultList list = txService.getTxHistories(condition);
		
		// 브라우저에서 "list"로 요청 시 컨트롤러 클래스에 list라고 저장된 데이터 전달
		model.addAttribute("list", list);
		// 브라우저에서 "txHistories"로 요청 시 컨트롤러 클래스에 txHistories라고 저장된 데이터를 전달
		model.addAttribute("txHistories", list.getTxHistories());
		// 검색 상태 유지를 위해 condition 저장
		model.addAttribute("condition", condition);
		// 페이지 정보 저장
		model.addAttribute("pageInfo", list.getPageInfo());
		
		return "mypage/txHistories";
	}
	
	/**
	 * 거래내역 상세 화면
	 */
	@GetMapping("/txHistory/{historyId}")
	public String txHistoryDetail(@PathVariable Long historyId,	Model model) {
		
		// DB에서 거래내역 조회 후 변수에 저장
		TxHistoryDTO txHistory = txService.getTxHistoryDetail(historyId);
		
		// 브라우저에서 "txHistory"로 요청 시 txHistory 전달
		model.addAttribute("txHistory", txHistory);
		
		return "mypage/txHistory/detail";
	}
	
	/**
	 * 후기 목록 화면
	 * @param session
	 * @param model
	 * @return
	 */
	@GetMapping("/reviews")
	public String reviews(HttpSession session, Model model) {
		
		// 로그인한 사용자 정보를 loginUser로 백엔드에 저장
		UserDTO loginUser = (UserDTO)session.getAttribute(SessionConst.LOGIN_USER);
		
		// 로그인 진행 X(또는 로그인 세션 만료) 시 로그인 페이지로 리다이렉트
		if (loginUser == null) {
			return "redirect:/user/login";
		}
		
		// userNo에 로그인한 사용자의 userNo값 저장
		Long userNo = loginUser.getUserNo();
		
		// DB에서 데이터 조회 후 변수에 저장
		ReviewResultList receivedReviews = reviewService.getReceivedReviews(userNo);
		ReviewResultList sentReviews = reviewService.getSentReviews(userNo);
		
		// 브라우저에서 "receivedReviews"로 요청 시 컨트롤러 클래스의 receivedReviews 전달
		model.addAttribute("receivedReviews", receivedReviews);
		// 브라우저에서 "sentReviews"로 요청 시 컨트롤러 클래스의 sentReviews 전달
		model.addAttribute("sentReviews", sentReviews);
		// 페이징 정보 저장 (받은 후기: receivedPageInfo, 보낸 후기: sentPageInfo)
		model.addAttribute("receivedPageInfo", receivedReviews.getPageInfo());
		model.addAttribute("sentPageInfo", sentReviews.getPageInfo());
		
		
		return "mypage/reviews";
	}
	
	
	/**
	 * 거래내역 중 후기 작성 버튼
	 * @return
	 */
	@GetMapping("/review/writeForm")
	public String reviewForm() {	
		return "mypage/review/writeForm";
	}
	
	/**
	 * 마이페이지 회원 정보 수정 버튼
	 * @return
	 */
	@GetMapping("/profile/editForm")
	public String editProfile() {
		return "mypage/profile/editForm";
	}
	
	/* ----------------------------------------- */

	/**
	 * 후기 작성 폼
	 */
	@PostMapping("/writeReview")
	public String writeReview(@RequestParam("historyId") Long historyId,
			@ModelAttribute ReviewDTO review, 
			Model model, HttpSession session) 
				throws IllegalStateException, IOException {
		// MessageController에서 불러오게 될 것 같긴 함
		UserDTO loginUser = (UserDTO)session.getAttribute(SessionConst.LOGIN_USER);
		
		// DB에서 거래내역 조회 후 변수에 저장
		TxHistoryDTO txHistory = txService.getTxHistoryDetail(historyId);
				
		// 브라우저에서 "txHistory"로 요청 시 txHistory 전달
		model.addAttribute("txHistory", txHistory);
		
		int result = reviewService.writeReview(review);
		
		return "redirect:/mypage/reviews";
	}
	
	@PostMapping("/user/edit")
	public String editProfile(@ModelAttribute UserDTO user, HttpSession session)
				throws IllegalStateException, IOException {
		
		
		return "redirect:/mypage/txHistories";
	}
	
	
}
