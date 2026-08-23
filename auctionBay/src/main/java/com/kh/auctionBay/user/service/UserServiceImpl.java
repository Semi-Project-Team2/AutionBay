package com.kh.auctionBay.user.service;


import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import com.kh.auctionBay.user.model.dto.UserDTO;
import com.kh.auctionBay.user.model.mapper.UserMapper;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class UserServiceImpl implements UserService{

	private final UserMapper mapper;
	
	private final PasswordEncoder passwordEncoder; // 비밀번호 암호화 인터페이스
	
	
	

	@Override
	public void join(UserDTO user) {
		
		// 아이디 중복 검사
		if(isUserIdCheck(user.getUserId())) {
			throw new IllegalStateException("이미 사용중인 아이디입니다.");
		}
		
		String encodePWd = passwordEncoder.encode(user.getPassword());
		user.setPassword(encodePWd); // 비밀번호 암호화
		
		
		mapper.insertUser(user);
		
		
		
	}
	
	
	@Override
	public boolean isUserIdCheck(String userId) {
		
		return mapper.countByUserId(userId) > 0;
		
	}




	@Override
	public UserDTO login(String userId, String password) {
		
		UserDTO user = mapper.selectByUserId(userId);
		
		if (user == null || !passwordEncoder.matches(password, user.getPassword()) ) {
			throw new IllegalStateException("아이디 또는 비밀번호가 일치하지 않습니다.");
		}
		
		
		return user;
		
		
	}






	
	
	
	
	
	
}
