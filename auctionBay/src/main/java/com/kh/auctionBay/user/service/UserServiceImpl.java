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
		
		
		String encodePWd = passwordEncoder.encode(user.getPassword());
		user.setPassword(encodePWd); // 비밀번호 암호화
		
		
		mapper.insertUser(user);
		
		
		
	}
	
	
	
	
}
