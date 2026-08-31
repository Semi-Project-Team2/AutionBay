package com.kh.auctionBay.product.service;



import java.io.IOException;
import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import com.kh.auctionBay.product.model.dto.CategoryDTO;
import com.kh.auctionBay.product.model.dto.ProductDTO;
import com.kh.auctionBay.product.model.dto.ProductListResult;
import com.kh.auctionBay.product.model.dto.ProductSearchCondition;

public interface ProductService {
	//productId로 일치하는 productDTO 1개 조회
	ProductDTO getProductByProductId(Long productId);
	
	//condition 에 맞는 productDTO List와 pageinfo가 담긴 객체를 반환
	ProductListResult getProductList(ProductSearchCondition condition);
	
	// 카테고리 전부 조회하기
	List<CategoryDTO> findAllCategories();
	
	// 조회수 증가
	void increaseViewCount(Long productId);
	
	//게시글 작성
	int createProduct(ProductDTO product, List<MultipartFile> images) throws IOException;
	
	//전체 게시물 조회
	List<ProductDTO> getProductList();
	
	//가격 필터
	List<ProductDTO> getProductByPrice(Long minPrice, Long maxPrice);
	
	// 게시글 수정
	void updateProduct(ProductDTO product, List<MultipartFile> images, String deletedMediaIds);
	
	// 게시글 삭제
	String deleteProduct(Long productId);
	
}
