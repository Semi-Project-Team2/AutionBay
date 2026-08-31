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
		} catch(IllegalStateException e){
			redirectAttr.addFlashAttribute("error", "회원가입 실패");
			return "redirect:/user/join";
		} 
		catch (IOException e) {
			e.printStackTrace();
			redirectAttr.addFlashAttribute("error", "회원가입 실패");
			return "redirect:/user/join";
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
	
	@GetMapping("/checkNickname")
	@ResponseBody
	public ApiResponse<Boolean> checkNickname(String nickname){
		
		boolean isDuplicate = service.isNicknameCheck(nickname);
		
		String message = isDuplicate ? "이미 사용중인 닉네임입니다." : "사용 가능한 닉네임입니다.";
		
		return ApiResponse.success(message, isDuplicate);
		
	}
	
	@GetMapping("/checkEmail")
	@ResponseBody
	public ApiResponse<Boolean> checkEmail(String email){
		
		boolean isDuplicate = service.isEmailCheck(email);
		
		String message = isDuplicate ? "이미 사용중인 이메일입니다." : "사용 가능한 이메일입니다.";
		
		return ApiResponse.success(message, isDuplicate);
		
	}
	
	@GetMapping("/checkPhoneNumber")
	@ResponseBody
	public ApiResponse<Boolean> checkPhoneNumber(String phoneNumber){
		
		boolean isDuplicate = service.isPhoneNumberCheck(phoneNumber);
		
		String message = isDuplicate ? "이미 사용중인 전화번호입니다." : "사용 가능한 전화번호입니다.";
		
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
	public String withdraw() {
		
		return "user/withdraw";
	}
	
	@PostMapping("withdraw")
	public String withdraw(String pwInput, HttpSession session,
			RedirectAttributes redirectAttr) {
		UserDTO loginUser = (UserDTO)session.getAttribute(SessionConst.LOGIN_USER);
		
		if (loginUser == null) {
			return "redirect:/login";
		}
		
		int result = service.withdraw(loginUser.getUserNo(), pwInput);
		
		if (result > 0) {
			// 세션 영역에서 사용자 데이터 삭제
			// RedirectAttributes는 HttpSession을 이용하여 데이터를 전달하므로
			// session.invalidate()를 사용하면 withdrawMessage로 데이터 전달 불가
			redirectAttr.addFlashAttribute("withdrawMessage", "회원 탈퇴가 완료되었습니다.");
			session.removeAttribute(SessionConst.LOGIN_USER);
			return "redirect:/product/list";
			// 초기 화면으로 redirect 하므로 탈퇴 메시지는 초기화면에서 받아야 함
		} else {
			redirectAttr.addFlashAttribute("error", "비밀번호가 일치하지 않습니다.");
			return "redirect:/user/withdraw";
		}
	}

}
