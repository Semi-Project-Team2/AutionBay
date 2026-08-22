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
	private String regionAdress;
	private LocalDateTime createdAt;
	private int isDeleted;
	private LocalDateTime deletedAt;
	
	
	
}
