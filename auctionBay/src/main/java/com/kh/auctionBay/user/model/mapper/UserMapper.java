package com.kh.auctionBay.user.model.mapper;

import org.apache.ibatis.annotations.Mapper;

import com.kh.auctionBay.user.model.dto.UserDTO;

@Mapper
public interface UserMapper {
	// 회원가입
	int insertUser(UserDTO user);
	
	
	// 아이디 중복 확인
	int countByUserId(String userId);
	
	// 로그인
	UserDTO selectByUserId(String userId);
	
}
