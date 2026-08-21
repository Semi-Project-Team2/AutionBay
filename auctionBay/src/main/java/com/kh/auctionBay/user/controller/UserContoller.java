package com.kh.auctionBay.user.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.kh.auctionBay.user.model.dto.UserDTO;
import com.kh.auctionBay.user.service.UserService;

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
	public String join(@ModelAttribute UserDTO user){
		System.out.println(user);
		
		service.join(user);
		
		return "redirect:/user/login";
	}
	
	@PostMapping("/login")
	public String login(String userId, String password) {
		return null;
	}
	
}
