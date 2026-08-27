package com.kh.auctionBay.review.model.dto;

import java.time.LocalDateTime;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class TxHistoryDTO {
//    history_id NUMBER(19) GENERATED ALWAYS AS IDENTITY,
//    product_id NUMBER(19) NOT NULL,
//    trade_type VARCHAR2(10) NOT NULL,
//    seller_no NUMBER(19) NOT NULL,
//    buyer_no NUMBER(19) NOT NULL,
//    final_price NUMBER(10) NOT NULL,
//    completed_at DATE DEFAULT SYSDATE,
	private Long historyId;
	private Long productId;
	private String tradeType;
	private Long sellerNo;
	private Long buyerNo;
	private Long finalPrice;
	private LocalDateTime completedAt;
	
	private String completedAtStr;
	
	// 거래내역 목록에서 보여줄 게시글 제목
	private String title;
	// 거래내역 목록에서 보여줄 거래상대 닉네임
	private String partnerNickname;
	
	// 거래 후기 작성 여부
	private boolean reviewWrited;
}
