package com.kh.auctionBay.product.service;


import com.kh.auctionBay.product.model.dto.ProductDTO;

public interface ProductService {
	ProductDTO getProductByProductId(Long productId);
}
