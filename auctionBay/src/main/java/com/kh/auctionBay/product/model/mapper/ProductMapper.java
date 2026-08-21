package com.kh.auctionBay.product.model.mapper;

import org.apache.ibatis.annotations.Mapper;

import com.kh.auctionBay.product.model.dto.ProductDTO;

@Mapper
public interface ProductMapper {
	// productId로 ProductDTO 1개 조회하기
	ProductDTO selectProductById(Long productId);
}
