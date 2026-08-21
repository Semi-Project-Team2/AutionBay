package com.kh.auctionBay.user.service;

import com.kh.auctionBay.user.model.dto.UserDTO;

public interface UserService {
	// 회원가입
	void join(UserDTO user);
	
	// 아이디 중복 체크
	boolean isUserIdCheck(String userId);
	
	
	// 로그인
	UserDTO login(String userId, String password);
	
}
