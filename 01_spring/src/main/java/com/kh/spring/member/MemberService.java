package com.kh.spring.member;

import java.util.List;

import org.springframework.stereotype.Service;

@Service	// @Component + 이 클래스가 비즈니스 로직 계층임을 나타냄
public class MemberService {

	// 회원 목록 조회
	// -> DB에서 조회된 결과(List)를 반환
	public List<MemberDTO> getMemberList() {
		
		return null;		// TODO:
	}
	
	// 회원 정보 추가
	// -> 회원 정보(DTO)를 전달받아서 DB에 추가
	public void insertMember(MemberDTO member) {
		
	}
	
	// 회원 정보 삭제
	// -> 회원 번호(id)을 전달받아서 DB에서 삭제
	public void deleteMember(int id) {
		
	}
}


