package com.kh.auctionBay.user.model.dto;

import java.time.LocalDateTime;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
@ToString
public class UserDTO {
	
	private Long userNo;
	private String userId;
	private String password;
	private String email;
	private String nickname;
	private String phoneNumber;
	private String profileImg;
	private String regionAddress;
	private LocalDateTime createdAt;
	private int isDeleted;
	private LocalDateTime deletedAt;
	
	private String createdAtStr;
	private String deletedAtStr;
	
	// 안 읽은 받은 메시지 개수
	private int unreadCount;
	
	
	
}
