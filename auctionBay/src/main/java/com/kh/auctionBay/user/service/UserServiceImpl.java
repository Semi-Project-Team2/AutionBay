package com.kh.auctionBay.user.service;


import java.io.IOException;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.kh.auctionBay.common.util.FileUploadUtil;
import com.kh.auctionBay.common.util.SavedFile;
import com.kh.auctionBay.user.model.dto.UserDTO;
import com.kh.auctionBay.user.model.mapper.UserMapper;

import lombok.RequiredArgsConstructor;


@Service
@RequiredArgsConstructor
public class UserServiceImpl implements UserService{

	private final UserMapper mapper;
	
	private final PasswordEncoder passwordEncoder; // 비밀번호 암호화 인터페이스
	
	private final FileUploadUtil uploadUtil;
	
	@Value("${file.upload-dir.profile}")
	private String profileUploadDir;
	
	

	@Override
	public void join(UserDTO user, MultipartFile profileImg) throws  IOException {
		
		// 아이디 중복 검사
		if(isUserIdCheck(user.getUserId())) {
			throw new IllegalStateException("이미 사용중인 아이디입니다.");
		}
		
		String encodePWd = passwordEncoder.encode(user.getPassword());
		user.setPassword(encodePWd); // 비밀번호 암호화
		
		SavedFile saved = uploadUtil.save(profileImg, profileUploadDir, "/uploads/profile");
		if(saved != null) {
			user.setProfileImg(saved.getPath());
		}
		
		mapper.insertUser(user);
		
		
		
	}
	
	
	@Override
	public boolean isUserIdCheck(String userId) {
		
		return mapper.countByUserId(userId) > 0;
		
	}
	
	

	@Override
	public boolean isNicknameCheck(String nickname) {
		
		return mapper.countByNickname(nickname) > 0;
		
	}



	@Override
	public UserDTO login(String userId, String password) throws IllegalStateException {
		
		UserDTO user = mapper.selectByUserId(userId);
		
		if (user == null || !passwordEncoder.matches(password, user.getPassword()) ) {
			throw new IllegalStateException("아이디 또는 비밀번호가 일치하지 않습니다.");
		}
		
		
		return user;
		
		
	}


	@Override
	public int editProfile(UserDTO loginUser, MultipartFile profileImg)
			throws IOException {
		
		SavedFile saved = uploadUtil.save(profileImg, profileUploadDir, "/uploads/profile");
		if(saved != null) {
			loginUser.setProfileImg(saved.getPath());
		}
		
		try {
			
			return mapper.updateUser(loginUser);
			
		} catch (DataIntegrityViolationException e) {
			
			throw new RuntimeException("이미 사용중인 전화번호/이메입니다.");
		}
		
	}

	@Override
	public UserDTO getUserByUserNo(Long userNo) {
		return mapper.selectByUserNo(userNo);
	}

	@Override
	public int withdraw(Long userNo) {
		
		return mapper.updateUserWithdrawal(userNo);
	}



	
	
}
