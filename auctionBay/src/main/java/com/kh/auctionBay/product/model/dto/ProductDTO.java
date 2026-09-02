package com.kh.auctionBay.product.model.dto;

import java.time.LocalDateTime;
import java.util.List;

import org.springframework.format.annotation.DateTimeFormat;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
public class ProductDTO {
//    product_id NUMBER(19) GENERATED ALWAYS AS IDENTITY,
//    writer_no NUMBER(19) NOT NULL,
//    category_id NUMBER(10) NOT NULL,
//    trade_type VARCHAR2(10) NOT NULL,
//    title VARCHAR2(100) NOT NULL,
//    description VARCHAR2(4000) NOT NULL,
//    price NUMBER(10),
//    product_condition VARCHAR2(20) DEFAULT 'USED' NOT NULL,
//    auction_start_price NUMBER(10),
//    auction_end_time DATE,
//    is_direct NUMBER(1) DEFAULT 1 NOT NULL,
//    trade_location VARCHAR2(100),
//    status VARCHAR2(20) DEFAULT 'ONGOING' NOT NULL,
//    view_count NUMBER(10) DEFAULT 0 NOT NULL,
//    created_at DATE DEFAULT SYSDATE,
//    updated_at DATE,
//    is_deleted NUMBER(1) DEFAULT 0 NOT NULL,
	private Long productId;
	private Long writerNo;
	private Long categoryId;
	private Long ReservedUserNo; // 구매자 컬럼 추가
	private String tradeType;
	private String title;
	private String description;
	private Long price;
	private String productCondition;
	private Long auctionStartPrice;
	@DateTimeFormat(pattern = "yyyy-MM-dd'T'HH:mm")
	private LocalDateTime auctionEndTime;

	private String tradeLocation;
	private int isDirect;
	private String status;
	private Long viewCount;
	private LocalDateTime createdAt;
	private LocalDateTime updatedAt;
	private int isDeleted;
	
	private String auctionEndTimeStr;
	private String createdAtStr;
	private String updatedAtStr;
	
	// 작성자의 닉네임(join할때)
	private String writerNickname;
	
	//카테고리 이름(join할때)
	private String categoryName;
	
	// 상세보기 화면에서 보여줄 이미지 목록

	private String mainImage;

	// 경매 종료 시간 확인용 임시 필드(시간 마감시 "Y", 아닐시 "N" 저장용)
	private String isClosed;
	
	//status에 따른 trade_type
	private String typeStatus;
	
	private List<ProductMediaDTO> mediaList;
	
	// 찜 여부
	public int isWished;
	
	// 해당 게시글에 달린 댓글 개수
		private int commentCount;
}
