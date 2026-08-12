package com.kh.community.member.controller;

import java.io.IOException;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.kh.community.member.model.dto.MemberDTO;
import com.kh.community.member.service.MemberService;

/*
 * "회원" 관련 화면 이동, 폼 처리 등을 담당할 컨트롤러
 */
@Controller
@RequestMapping("/member")
public class MemberController {
	// MemberService 를 DI 처리 (생성자 주입방식)
	private final MemberService service;
	public MemberController(MemberService service) {
		this.service = service;
	}
	
	
	
	// --- 화면 이동 요청 ----
	@GetMapping("/join")
	public String joinForm() {
		return "member/join";
	}
	
	@GetMapping("/login")
	public String loginForm() {
		return "member/login";
	}
	
	// --------------------
	
	@PostMapping("/join")
	public String join(@ModelAttribute MemberDTO member,
					   @RequestParam(required=false) MultipartFile profileImage) {
		System.out.println(member);
		System.out.println(profileImage);
		
		try {
			
			service.join(member, profileImage);
			
		} catch (IOException e) {
			e.printStackTrace();
			// "회원 가입 실패" 메시지를 저장 ---> 클라이언트에서 사용
			
			// 예외 발생 시 회원 가입 페이지로 리다이렉트
			return "redirect:/member/join";
		}
		
		// 회원 가입 성공 시 로그인 페이지로 리다이렉트
		return "redirect:/member/login";
	}

}





