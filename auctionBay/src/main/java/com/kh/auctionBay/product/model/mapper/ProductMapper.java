package com.kh.auctionBay.product.model.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.kh.auctionBay.product.model.dto.CategoryDTO;
import com.kh.auctionBay.product.model.dto.ProductDTO;
import com.kh.auctionBay.product.model.dto.ProductSearchCondition;

@Mapper
public interface ProductMapper {
	// productId로 ProductDTO 1개 조회하기
	ProductDTO selectProductById(Long productId);
	
	// 검색 조건에 맞는 전체 상품 개수 조회 (카운트 쿼리용)
    int selectProductCount(ProductSearchCondition condition);

    // 검색 조건 및 페이징이 적용된 상품 목록 조회
    List<ProductDTO> selectProductList(ProductSearchCondition condition);
    
    // 카테고리 전부 조회하기
    List<CategoryDTO> selectCategories();
    
    // 조회수 증가
    void updateViewCount(Long productId);
}
