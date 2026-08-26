package com.kh.auctionBay.product.service;



import java.util.List;

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
}
