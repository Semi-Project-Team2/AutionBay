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
	public String join(@ModelAttribute UserDTO user, @RequestParam(required=false) MultipartFile profileImg, RedirectAttributes redirectAttr){
		
		try {
		service.join(user, profileImg);
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
	public String login(String userId, String password) {
		return null;
	}
	
}
