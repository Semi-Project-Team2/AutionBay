package com.kh.auctionBay.user.service;


import java.io.IOException;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
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
		
		// 프로필 이미지 처리
	    if(profileImg == null || profileImg.isEmpty()) {

	        // 기본 프로필 이미지
	        user.setProfileImg("/uploads/profile/default-profile.png");

	    } else {

	        // 사용자가 선택한 이미지 저장
	        SavedFile saved = uploadUtil.save(profileImg, profileUploadDir, "/uploads/profile");

	        if(saved != null) {
	            user.setProfileImg(saved.getPath());
	        }
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
	public boolean isEmailCheck(String email) {

		return mapper.countByEmail(email) > 0;
		
	}
	
	@Override
	public boolean isPhoneNumberCheck(String phoneNumber) {
		
		return mapper.countByPhoneNumber(phoneNumber) > 0;
	
	}
	


	@Override
	public UserDTO login(String userId, String password) throws IllegalStateException {
		
		UserDTO user = mapper.selectByUserId(userId);
		
		if (user == null || !passwordEncoder.matches(password, user.getPassword()) ) {
			throw new IllegalStateException("아이디 또는 비밀번호가 일치하지 않습니다.");
		}
		
		
		return user;
		
		
	}

	@Transactional
	@Override
	public int editProfile(UserDTO loginUser, MultipartFile profileImg,
			boolean deleteProfileImg) throws IOException {
		
		// 닉네임, 이메일, 전화번호 중복 검증
		if (loginUser.getNickname() != null) {
			boolean isDuplicateNickname 
				= checkNickname(loginUser.getNickname(), loginUser.getUserNo());
			if (isDuplicateNickname) {
				throw new RuntimeException("이미 사용 중인 닉네임입니다.");
			}
		}
		
		if (loginUser.getEmail() != null) {
	        boolean isDuplicateEmail = checkEmail(loginUser.getEmail(), loginUser.getUserNo());
	        if (isDuplicateEmail) {
	            throw new RuntimeException("이미 사용 중인 이메일입니다.");
	        }
	    }
	    
	    if (loginUser.getPhoneNumber() != null) {
	        boolean isDuplicatePhone = checkPhoneNumber(loginUser.getPhoneNumber(), loginUser.getUserNo());
	        if (isDuplicatePhone) {
	            throw new RuntimeException("이미 사용 중인 전화번호입니다.");
	        }
	    }
	    
		// ---------------------------------------------------------------------
		// 프로필 이미지 변경
	    // DB에서 현재 회원의 기존 프로필 사진 정보 조회
		UserDTO oldUser = mapper.selectByUserNo(loginUser.getUserNo());
		String oldProfileImg = oldUser.getProfileImg(); // DB에 저장된 기존 프사 경로
		
		String uploadPath = "C:/workspace/auctionBay/auctionBay/uploads/profile";	// 파일 저장 경로
		String webPath = "/uploads/profile";
		
		if (deleteProfileImg) {
			// 1) 프로필 이미지 삭제 버튼 클릭
			if (oldProfileImg != null && !oldProfileImg.contains("default-profile.png")) {
				// 기존 프로필 이미지가 기본 이미지인 경우 포함
				uploadUtil.delete(oldProfileImg, uploadPath);
			}
			// 기본 이미지 경로로 세팅
			loginUser.setProfileImg("/uploads/profile/default-profile.png");
		} else if (profileImg != null && !profileImg.isEmpty()) {
			// 2) 새로운 프로필 사진으로 변경
			if (oldProfileImg != null && !oldProfileImg.contains("default-profile.png")) {
				// 기존 파일이 기본 프로필 사진이 아닌 경우에만 삭제
				// 기본 프로필 이미지 삭제 방지
				uploadUtil.delete(uploadPath, oldProfileImg);
			}
			
			// 새로운 프로필 사진으로 저장 후 반환된 SavedFile 객체 이용
			SavedFile saved = uploadUtil.save(profileImg, uploadPath, webPath);
			if (saved != null) {
				// SavedFile에 들어 있는 경로와 파일명을 유저 객체에 세팅
				loginUser.setProfileImg(saved.getPath());
			}
		} else {
			// 3) 기존 프로필 사진 유지
			loginUser.setProfileImg(oldProfileImg);
		}
		
		return mapper.updateUser(loginUser);
		
	}

	@Override
	public UserDTO getUserByUserNo(Long userNo) {
		return mapper.selectByUserNo(userNo);
	}

	@Override
	public int withdraw(Long userNo) {
		UserDTO loginUser = mapper.selectByUserNo(userNo);
		
		int result = mapper.updateUserWithdrawal(userNo);
		
		String profile = loginUser.getProfileImg();
		if (profile != null) {
			uploadUtil.delete(profile, profileUploadDir);
		}
		
		return result;
	}


	// 회원 정보 수정용
	@Override
	public boolean checkNickname(String nicknameInput, Long userNo) {
		String currentNickname = mapper.nicknameCheck(userNo);
		if (nicknameInput.equals(currentNickname)) {
			return false;	// 중복이 아니므로 isDuplicate = false
		}
		
		int count = mapper.countByNickname(nicknameInput);
		return count > 0;
	}


	@Override
	public boolean checkEmail(String emailInput, Long userNo) {
		String currentEmail = mapper.emailCheck(userNo);
		if (emailInput.equals(currentEmail)) {
			return false;	// 중복이 아니므로 isDuplicate = false
		}
		
		int count = mapper.countByEmail(emailInput);
		return count > 0;
	}


	@Override
	public boolean checkPhoneNumber(String phoneNumberInput, Long userNo) {
		String currentPhoneNumber = mapper.phoneNumberCheck(userNo);
		if (phoneNumberInput.equals(currentPhoneNumber)) {
			return false;	// 중복이 아니므로 isDuplicate = false
		}
		
		int count = mapper.countByPhoneNumber(phoneNumberInput);
		return count > 0;
	}
	
	





	
	
}
