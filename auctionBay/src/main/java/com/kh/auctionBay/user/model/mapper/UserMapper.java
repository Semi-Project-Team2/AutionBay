package com.kh.auctionBay.user.model.mapper;

import org.apache.ibatis.annotations.Mapper;

import com.kh.auctionBay.user.model.dto.UserDTO;

@Mapper
public interface UserMapper {
	
	// 회원가입
	int insertUser(UserDTO user);	
	
	// 아이디 중복 확인
	int countByUserId(String userId);
	
	// 닉네임 중복 확인
	int countByNickname(String nickname);
	
	// 이메일 중복 확인 
	int countByEmail(String email);
	
	// 전화번호 중복 확인
	int countByPhoneNumber(String phoneNumber);
	
	// 로그인
	UserDTO selectByUserId(String userId);
	
	// 회원 정보 수정
	int updateUser(UserDTO user);
	
	// 회원 탈퇴 (DB에는 남겨 두고 숨김 처리)
	int updateUserWithdrawal(Long userNo);
	
}
