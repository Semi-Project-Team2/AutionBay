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
	private int bidPrice;
	private LocalDateTime createdAt;
	
	private String createdAtStr;
}
