package com.kh.auctionBay.user.service;

import java.io.IOException;

import org.springframework.web.multipart.MultipartFile;

import com.kh.auctionBay.user.model.dto.UserDTO;

public interface UserService {
	// 회원가입
	void join(UserDTO user, MultipartFile profileImg) throws IOException;
	
	// 아이디 중복 체크
	boolean isUserIdCheck(String userId);
	
	// 닉네임 중복 체크
	boolean isNicknameCheck(String nickname);
	boolean checkNickname(String nickname, Long userNo);		// 회원 정보 수정용
	
	// 이메일 중복 체크
	boolean isEmailCheck(String email);
	boolean checkEmail(String email, Long userNo);	// 회원 정보 수정용
	
	// 전화번호 중복 체크
	boolean isPhoneNumberCheck(String phoneNumber);
	boolean checkPhoneNumber(String phoneNumber, Long userNo);	// 회원 정보 수정용
	
	// 로그인
	UserDTO login(String userId, String password);
	
	// 회원 정보 수정
	int editProfile(UserDTO loginUser, MultipartFile profileImg, 
			boolean deleteProfileImg) throws IOException;
	
	// userNo로 user 정보 조회
	UserDTO getUserByUserNo(Long userNo);
	
	// 회원 탈퇴
	int withdraw(Long userNo);
	
}
