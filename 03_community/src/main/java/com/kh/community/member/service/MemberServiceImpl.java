package com.kh.community.member.service;

import java.io.IOException;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.kh.community.common.util.FileUploadUtil;
import com.kh.community.common.util.SavedFile;
import com.kh.community.member.model.dto.MemberDTO;
import com.kh.community.member.model.mapper.MemberMapper;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class MemberServiceImpl implements MemberService {
	// FileUploadUtil 을 DI처리 (생성자 주입 방식, 롬복 사용)
	private final FileUploadUtil uploadUtil;
	// MemberMapper DI
	private final MemberMapper mapper;
	
	
	@Value("${file.upload-dir.profile}")
	private String profileUploadDir;

	@Override
	public void join(MemberDTO member, MultipartFile profileImage) throws IOException {

		// 프로필 이미지 파일을 "서버"에 저장 --> 공통 클래스로 분리
		SavedFile saved = uploadUtil.save(profileImage, profileUploadDir, "/uploads/profile");
		if (saved != null) {
			// 저장된 경로를 dto에 설정
			member.setProfile( saved.getPath() );
		}
		
		// TB_MEMBER 테이블("DB")에 데이터 저장 --> Mapper
		mapper.insertMember(member);
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
