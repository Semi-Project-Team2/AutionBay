package com.kh.community.member.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

/*
 * "회원" 관련 화면 이동, 폼 처리 등을 담당할 컨트롤러
 */
@Controller
@RequestMapping("/member")
public class MemberController {
	// --- 화면 이동 요청 ----
	@GetMapping("/join")
	public String joinForm() {
		return "member/join";
	}
	
	// --------------------
	
	@PostMapping("/join")
	public String join() {
		
	}

}





