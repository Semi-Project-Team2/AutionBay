package com.kh.auctionBay.user.controller;

import java.io.IOException;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.kh.auctionBay.user.model.dto.UserDTO;
import com.kh.auctionBay.user.service.UserService;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

import com.kh.auctionBay.common.SessionConst;
import com.kh.auctionBay.common.dto.ApiResponse;

import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
@RequestMapping("/user")
public class UserContoller {

	private final UserService service;

	@GetMapping("/join")
	public String joinForm() {
		return "user/join";
	}

	@GetMapping("/login")
	public String loginForm() {
		return "user/login";
	}

	@PostMapping("/join")
	public String join(@ModelAttribute UserDTO user, @RequestParam(required = false) MultipartFile profileImage,
			RedirectAttributes redirectAttr) {

		try {
			service.join(user, profileImage);
		} catch (IOException e) {
			e.printStackTrace();
			redirectAttr.addFlashAttribute("error", "회원가입 실패");
			return "redirect:user/join";
		}
		redirectAttr.addFlashAttribute("joinSuccess", true);
		return "redirect:/user/login";
	}

	@GetMapping("/checkId")
	@ResponseBody
	public ApiResponse<Boolean> checkId(String userId) {

		boolean isDuplicate = service.isUserIdCheck(userId);

		String message = isDuplicate ? "이미 사용중인 아이디입니다." : "사용 가능한 아이디입니다.";

		return ApiResponse.success(message, isDuplicate);
	}

	@PostMapping("/login")
	public String login(String userId, String password, @RequestParam(required = false) String redirectURL,
			HttpSession session, RedirectAttributes redirectAttr) {
		try {
			UserDTO user = service.login(userId, password);
			session.setAttribute(SessionConst.LOGIN_USER, user);
		} catch (IllegalStateException e) {
			redirectAttr.addFlashAttribute("error", e.getMessage());
			return "redirect:/user/login";
		}

		if (redirectURL != null && !redirectURL.isBlank()) {
			return "redirect:" + redirectURL;
		}

		return "redirect:/";
	}
	
	@GetMapping("/logout")
	public String logout(HttpServletRequest request) {
		HttpSession session = request.getSession(false);
		if(session != null) {
			session.invalidate();
		}
		
		return "redirect:/";
	}
	
	@GetMapping("/withdraw")
	public String withdraw(HttpSession session, RedirectAttributes redirectAttr) {
		// 세션에 저장된 사용자 정보 추출
		UserDTO loginUser = (UserDTO)session.getAttribute(SessionConst.LOGIN_USER);
		
		// 서비스에 비즈니스 로직 요청
		service.withdraw(loginUser.getUserNo());
		
		// 세션 영역에서 모든 데이터 삭제 (세션 만료시키기)
		session.invalidate();
		
		return "redirect:/";
	}

}
