package com.kh.auctionBay.auction.model.dto;

import java.time.LocalDateTime;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class HoldsDTO {
	private Long holdId;
	private Long bidId;
	private Long productId;
	private Long userNo;
	private Long holdAmount;
	private String holdStatus;
	private LocalDateTime createdAt;
	private LocalDateTime releasedAt;
}
