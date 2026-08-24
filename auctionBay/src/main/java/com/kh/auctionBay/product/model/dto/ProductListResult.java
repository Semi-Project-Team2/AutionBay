package com.kh.auctionBay.product.model.dto;

import java.util.List;

import com.kh.auctionBay.common.dto.PageInfo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class ProductListResult {
	private List<ProductDTO> productList;
	private PageInfo pageInfo;
}
