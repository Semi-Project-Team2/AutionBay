package com.kh.auctionBay.product.model.dto;

import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class ProductSearchCondition {
	// 1. 키워드 검색 (상단 통합 검색창)
    private String searchType;       // 검색 대상 (TITLE OR WRITER_NICKNAME 통합검색)
    private String keyword;          // 검색어 (예: "아이폰", "판매자닉네임")

    // 2. 게시글 유형 필터 (UI: 구매, 판매, 경매)
    private String tradeType;        // PRODUCTS.trade_type (SELL, BUY, AUCTION)

    // 3. 카테고리 필터 (DB 기준 PK 연동)
    private Long categoryId;         // CATEGORIES.category_id 참조 (PK)

    // 4. 가격 범위 필터
    private Integer minPrice;        // 최소 금액 (0 ~ )
    private Integer maxPrice;        // 최대 금액 (~ N원)

    // 5. 상품 및 게시글 상태 필터 (선택적 확장)
    private String productCondition; // PRODUCTS.product_condition (NEW, LIKE_NEW, USED)
    private String status;           // PRODUCTS.status (ONGOING, COMPLETED 등)
    private Boolean isDirect;        // 직거래 여부 (1: 가능, 0: 택배)

    // 6. 정렬 및 페이징 (UI 하단 1, 2, 3... 페이지 연동)
    private String sortBy;           // 정렬 기준 (LATEST: 최신순, PRICE_ASC: 낮은가격순, PRICE_DESC: 높은가격순, VIEWS: 조회수순)
    private Integer page = 1;        // 현재 페이지 번호 (기본값: 1)
    private Integer size = 3;       // 한 페이지당 노출할 개수 (기본값: 12개)
	
    
    // 쿼리문 실행 시 사용할 값
 	private int offset;		// 건너뛸 행수
}
