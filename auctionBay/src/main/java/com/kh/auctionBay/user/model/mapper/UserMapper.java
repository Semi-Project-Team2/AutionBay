package com.kh.auctionBay.user.model.mapper;

import org.apache.ibatis.annotations.Mapper;

import com.kh.auctionBay.user.model.dto.UserDTO;

@Mapper
public interface UserMapper {
	
	int insertUser(UserDTO user);
	
}
