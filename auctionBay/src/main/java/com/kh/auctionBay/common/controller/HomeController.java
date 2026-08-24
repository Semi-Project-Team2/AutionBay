package com.kh.auctionBay.common.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;

import com.kh.auctionBay.product.controller.ProductController;
import com.kh.auctionBay.product.model.dto.ProductSearchCondition;
import com.kh.auctionBay.user.model.dto.UserDTO;

import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;

@Controller
public class HomeController {
	
	@GetMapping("/")
    public String home(@ModelAttribute ProductSearchCondition condition, Model model) {
        return "redirect:/product/list";
    }
	
	/* 테스트 유저(userNo = 1L)로 로그인(시작): 필요 시 주석 처리 해제하여 사용하시고 지우지 말아주세요 */
	
	@GetMapping("/user/logintest")
	public String login() {
		return "user/logintest";
	}
	
	@GetMapping("/loginProcess")
	public String loginProcess(HttpSession session) {
		
	    // 1. 테스트 유저 번호 (기본값 1번)
	    Long userNo = 1L;

	    // 2. 테스트용 회원 객체 생성
	    UserDTO testUser = new UserDTO();
	    testUser.setUserNo(userNo);
	    testUser.setNickname("테스트닉네임");
	    testUser.setEmail("example@email.com");

	    // 3. JSTL에서 사용하는 이름인 'loginUser'로 세션에 저장
	    session.setAttribute("loginUser", testUser);

	    // 4. 메인 페이지로 리다이렉트 (새로고침 효과와 함께 세션이 확실히 반영됨)
	    return "redirect:/";
	}
	
	/* 테스트 유저(userNo = 1L)로 로그인(종료): 필요 시 주석 처리 해제하여 사용하시고 지우지 말아주세요 */
	
}
