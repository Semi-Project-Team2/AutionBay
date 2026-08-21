package com.kh.auctionBay.product.service;

import com.kh.auctionBay.product.model.dto.ProductDTO;
import com.kh.auctionBay.product.model.mapper.ProductMapper;

import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
public class ProductServiceImpl implements ProductService{

	private final ProductMapper mapper;
	
	@Override
	public ProductDTO getProductByProductId(Long productId) {
		
		return mapper.selectProductById(productId);
	}
	
}
