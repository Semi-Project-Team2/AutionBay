package com.kh.community.member.service;

import java.io.IOException;

import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.kh.community.member.model.dto.MemberDTO;

@Service
public class MemberServiceImpl implements MemberService {

	@Override
	public void join(MemberDTO member, MultipartFile profileImage) throws IOException {

		// 프로필 이미지 파일을 "서버"에 저장 --> 공통 클래스로 분리
		
		// TB_MEMBER 테이블("DB")에 데이터 저장 --> Mapper
		
	}

	@Override
	public boolean isMemberIdCheck(String memberId) {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public MemberDTO login(String memberId, String memberPwd) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public void withdraw(String memberId) {
		// TODO Auto-generated method stub
		
	}

}
