package com.kh.auctionBay.user.controller;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import com.kh.auctionBay.common.SessionConst;
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
	@GetMapping("/txHistory")
	public String mypageTxHistory(HttpSession session, Model model) {
		
		// 로그인한 사용자 정보를 loginUser로 백엔드에 저장
		UserDTO loginUser = (UserDTO)session.getAttribute(SessionConst.LOGIN_MEMBER);
		// userNo(PK)에 로그인한 사용자의 userNo값 저장
		Long userNo = loginUser.getUserNo();
		
		// DB에서 데이터 조회 후 변수에 저장
		List<TxHistoryDTO> txHistories = txService.getTxHistories(userNo);
		// 브라우저에서 txHistories를 요구하면 컨트롤러 클래스에 txHistories로 저장된 데이터를 전달
		model.addAttribute("txHistories", txHistories);
		
		return "mypage/txHistory";
	}
	
	@GetMapping("/review")
	public String mypageReview(HttpSession session, Model model) {
		
		// 로그인한 사용자 정보를 loginUser로 백엔드에 저장
		UserDTO loginUser = (UserDTO)session.getAttribute(SessionConst.LOGIN_MEMBER);
		// userNo(PK)에 로그인한 사용자의 userNo값 저장
		Long userNo = loginUser.getUserNo();
		
		// DB에서 데이터 조회 후 변수에 저장
		
		// 브라우저에서 reviews를 요구하면 컨트롤러 클래스의 reviews 전달
		
		return "mypage/review";
	}
	
	
	/* ----------------------------------------- */
	

}
