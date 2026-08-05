package com.kh.spring.member;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller	// @Component + 컨트롤러 계층의 기능이 추가된 어노테이션
			// -> 이 클래스의 메소드가 반환하는 문자열은 "View"의 이름으로 해석됨 (포워드)
@RequestMapping("/member")	// 클래스 레벨의 공통 URL 지정
							// -> 내부 메소드들은 매핑 URL 앞에 "/member"가 붙음
public class MemberController {
	
	// MemberService 클래스를 주입 (생성자 주입 방식)
	private final MemberService service;
	// @Autowired
	public MemberController(MemberService service) {
		this.service = service;
	}

	/**
	 * 회원 목록 조회
	 * URL : [GET] /member/list
	 */
	@GetMapping("/list")
	public String memberList() {
		
		return ""; // TODO:
	}
	
	/**
	 * 회원 등록 
	 * URL : [POST] /member/insert
	 * Parameter : age (나이), email (이메일), name (이름) => MemberDTO로 한번에 받을 수 있음
	 */
	@PostMapping("/insert")
	public String insert(@ModelAttribute MemberDTO member) {
		
		return ""; // TODO:
	}
	
	/**
	 * 회원 삭제
	 * URL : [GET] /member/delete/{id}
	 */
	@GetMapping("/delete/{id}")
	public String delete(@PathVariable int id) {
		
		return "";	// TODO:
	}
}









