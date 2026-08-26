package com.kh.auctionBay.activity.controller;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

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

	private long getLoginUserNo(HttpSession session) {
	    UserDTO loginUser = (UserDTO) session.getAttribute(SessionConst.LOGIN_USER);
	    return (loginUser != null) ? loginUser.getUserNo() : 1L; 
	}
	
	/**
	 * [찜 목록 페이지 이동 및 데이터 조회]
	 * - 요청 URL: GET /member/wishlist (클래스 기본 매핑 무시하고 전역 경로 설정)
	 */
	@GetMapping("member/wishlist")
	public String myWishlist(HttpSession session, Model model) {
		UserDTO loginUser = (UserDTO)session.getAttribute(SessionConst.LOGIN_USER);
		if (loginUser == null) {
			return "redirect:/user/login";
		}

		List<WishlistDTO> wishlist = activityService.selectMyWishlist(loginUser.getUserNo());
		model.addAttribute("wishlist", wishlist);
		return "member/wishlist"; 
	}

}