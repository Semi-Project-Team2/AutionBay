package com.kh.auctionBay.user.controller;

import java.io.IOException;
import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.kh.auctionBay.common.SessionConst;
import com.kh.auctionBay.review.model.dto.ReviewDTO;
import com.kh.auctionBay.review.model.dto.TxHistoryDTO;
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
 	 * 거래 목록 화면 (마이페이지 기본화면)
	 * @param session
	 * @param model
	 * @return
	 */
	@GetMapping("/txHistories")
	public String mypageTxHistory(HttpSession session, Model model) {
		
		// 로그인한 사용자 정보를 loginUser로 백엔드에 저장
		UserDTO loginUser = (UserDTO)session.getAttribute(SessionConst.LOGIN_USER);
		// userNo(PK)에 로그인한 사용자의 userNo값 저장
		Long userNo = loginUser.getUserNo();
		
		// DB에서 데이터 조회 후 변수에 저장
		List<TxHistoryDTO> txHistories = txService.getTxHistories(userNo);
		
		// 브라우저에서 "txHistories"로 요청 시 컨트롤러 클래스에 txHistories라고 저장된 데이터를 전달
		model.addAttribute("txHistories", txHistories);
		
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
	 * 거래내역 중 후기 작성 버튼
	 * @return
	 */
	@GetMapping("/reviewForm")
	public String reviewForm() {	
		return "review/form";
	}
	
	/**
	 * 후기 목록 화면
	 * @param session
	 * @param model
	 * @return
	 */
	@GetMapping("/reviews")
	public String mypageReview(HttpSession session, Model model) {
		
		// 로그인한 사용자 정보를 loginUser로 백엔드에 저장
		UserDTO loginUser = (UserDTO)session.getAttribute(SessionConst.LOGIN_USER);
		// userNo(PK)에 로그인한 사용자의 userNo값 저장
		Long userNo = loginUser.getUserNo();
		
		// DB에서 데이터 조회 후 변수에 저장
		List<ReviewDTO> receivedReviews = reviewService.getReceivedReviews(userNo);
		List<ReviewDTO> sentReviews = reviewService.getSentReviews(userNo);
		
		// 브라우저에서 "receivedReviews"로 요청 시 컨트롤러 클래스의 receivedReviews 전달
		// 브라우저에서 "sentReviews"로 요청 시 컨트롤러 클래스의 sentReviews 전달
		model.addAttribute("receivedReviews", receivedReviews);
		model.addAttribute("sentReviews", sentReviews);
		
		return "mypage/reviews";
	}	
		
	/* ----------------------------------------- */

	/**
	 * 후기 작성 폼
	 */
	@PostMapping("/form")
	public String writeReview(@ModelAttribute ReviewDTO review, HttpSession session) 
				throws IllegalStateException, IOException {
		// MessageController에서 불러오게 될 것 같긴 함
		UserDTO loginUser = (UserDTO)session.getAttribute(SessionConst.LOGIN_USER);
		Long userNo = loginUser.getUserNo();
		
		int result = reviewService.writeReview(review);
		review.setReviewerNo(userNo);
		
		return "redirect:/mypage/review";
	}
}
