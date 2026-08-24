package com.kh.auctionBay.common.dto;

import lombok.Getter;

@Getter
public class PageInfo {
	private int page;       // 현재 페이지 번호
    private int size;       // 한 페이지에 보여줄 게시글/상품 개수
    private int totalCount; // 전체 목록 개수

    private int totalPages; // 전체 페이지 수
    private int startPage;  // 화면에서 보여줄 페이지 시작 번호
    private int endPage;    // 화면에서 보여줄 페이지 끝 번호
    private boolean hasPrevGroup;   // 이전 페이지 그룹 존재 여부
    private boolean hasNextGroup;   // 다음 페이지 그룹 존재 여부
    
    private static final int PAGE_GROUP_SIZE = 5;
    // 하단에 한번에 보여줄 페이지 번호 개수 (고정)
    
    public PageInfo(int page, int size, int totalCount) {
        this.page = page < 1 ? 1 : page;
        this.size = size < 1 ? 12 : size; // size가 비정상적일 경우 기본 12개 적용
        this.totalCount = totalCount;
        
        // 전체 페이지 수 : 데이터가 0개일 때 최소 1페이지 보장
        this.totalPages = totalCount == 0 ? 1 : (int) Math.ceil((double) totalCount / this.size);
        
        // 요청 페이지가 전체 페이지 수보다 클 경우 마지막 페이지로 보정
        if (this.page > this.totalPages) {
            this.page = this.totalPages;
        }
        
        // 표시되는 페이지 번호 범위 계산 (예: page = 7, PAGE_GROUP_SIZE = 5 --> 6 ~ 10)
        this.startPage = ((this.page - 1) / PAGE_GROUP_SIZE) * PAGE_GROUP_SIZE + 1;
        this.endPage = Math.min(this.startPage + PAGE_GROUP_SIZE - 1, this.totalPages);
        
        // 이전/다음 그룹 존재 여부
        this.hasPrevGroup = this.startPage > 1;
        this.hasNextGroup = this.endPage < this.totalPages;
    }
    
    public int getOffset() {
        return (this.page - 1) * this.size;
    }
}
