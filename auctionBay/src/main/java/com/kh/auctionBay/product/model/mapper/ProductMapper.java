package com.kh.auctionBay.product.model.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.kh.auctionBay.product.model.dto.CategoryDTO;
import com.kh.auctionBay.product.model.dto.ProductDTO;
import com.kh.auctionBay.product.model.dto.ProductMediaDTO;
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
    
    int insertProduct(ProductDTO product);
    
    List<ProductDTO> selectProuctList();
    
    List<ProductDTO> selectProductByPrice(@Param("minPrice") Long minPrice, @Param("maxPrice") Long maxPrice);
    
    int insertProductMedia(ProductMediaDTO media);
    
    // 상세페이지 미디어 보여주기
    List<ProductMediaDTO> getMediaListByProductId(Long productId);
    
    // 경매 게시글 수정
    int updateAuctionProduct(ProductDTO product);
    
    // 일반 게시글 수정
    int updateNormalProduct(ProductDTO product);
    
    // 미디어 테이블 단건 조회
    ProductMediaDTO getMediaByMediaId(Long mediaId);
    
    // 미디어 테이블 단건 삭제
    int deleteProductMedia(Long mediaId);
    
    // 게시물 삭제
    int deleteProduct(Long productId);
    
   
}
