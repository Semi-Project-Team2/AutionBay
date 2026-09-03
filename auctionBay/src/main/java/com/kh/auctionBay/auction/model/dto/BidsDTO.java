package com.kh.auctionBay.auction.model.dto;

import java.time.LocalDateTime;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class BidsDTO {
	private Long bidId;
	private Long productId;
	private Long bidderNo;
	private Long bidPrice;
	private LocalDateTime createdAt;
	
	private String createdAtStr;
	
	// join용
	private String bidderId;
	private String bidderNickname;
	
	// 입찰 단위
	private Long bidUnit;
}
