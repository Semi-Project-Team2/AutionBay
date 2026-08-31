package com.kh.auctionBay.message.model.dto;

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
public class MessageDTO {

	private Long messageId; 
	private Long senderNo;
	private Long receiverNo; 
	private Long productId; 
	private String content; 
	private int isRead; 
	private int senderDeleted; 
	private int receiverDeleted; 
	private LocalDateTime createdAt; 
	
	private String createAtStr;
	
	// users랑 products에서 join 해서 가져오는 값
	private String opponentNickname;
	private String productTitle;
	private String productStatus;
	
}
