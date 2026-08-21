package com.kh.auctionBay.user.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import com.kh.auctionBay.review.service.ReviewService;
import com.kh.auctionBay.review.service.TxHistoryService;
import com.kh.auctionBay.user.service.UserService;

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
	
	
	/* --------- 화면 이동 요청 ----------- */
	@GetMapping("/txHistory/{userId}")
	public String mypage(@PathVariable String userId, Model model) {
		
		
		return "mypage/txHistory";
	}
	
	
	/* --------------------------------------- */
	

}
