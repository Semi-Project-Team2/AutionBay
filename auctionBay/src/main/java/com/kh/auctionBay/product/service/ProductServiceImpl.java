package com.kh.auctionBay.product.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.kh.auctionBay.common.dto.PageInfo;
import com.kh.auctionBay.product.model.dto.CategoryDTO;
import com.kh.auctionBay.product.model.dto.ProductDTO;
import com.kh.auctionBay.product.model.dto.ProductListResult;
import com.kh.auctionBay.product.model.dto.ProductSearchCondition;
import com.kh.auctionBay.product.model.mapper.ProductMapper;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class ProductServiceImpl implements ProductService{

	private final ProductMapper mapper;
	
	// productId로 ProductDTO 1개 조회
	@Override
	public ProductDTO getProductByProductId(Long productId) {
		
		return mapper.selectProductById(productId);
	}

	@Override
	public ProductListResult getProductList(ProductSearchCondition condition) {
		// 검색 조건에 일치하는 전체 상품 개수 조회 (count 쿼리)
        int totalCount = mapper.selectProductCount(condition);
        
        // PageInfo 객체 생성 (검색 조건과 전체 개수를 전달하여 페이징 계산)
        PageInfo pageInfo = new PageInfo(condition.getPage(),condition.getSize(), totalCount);
        
        
        condition.setOffset(pageInfo.getOffset());
        
        // 조건에 맞는 상품 목록 조회
        List<ProductDTO> productList = mapper.selectProductList(condition);
        
        // 조회된 목록과 페이징 정보를 ProductListResult에 담아서 반환
        return new ProductListResult(productList, pageInfo);
	}

	// 전체 카테고리 조회
	@Override
	public List<CategoryDTO> findAllCategories() {
		return mapper.selectCategories();
	}

	@Override
	public void increaseViewCount(Long productId) {
		mapper.updateViewCount(productId);
	}
	
	
	@Override
	public int createProduct(ProductDTO product, List<MultipartFile> images) {
		
		String tradeType = product.getTradeType();
		
		if("BUY".equals(tradeType)) {
			product.setAuctionStartPrice(null);
			product.setAuctionEndTime(null);
		}
		
		else if("SELL".equals(tradeType)) {
			product.setAuctionStartPrice(null);
			product.setAuctionEndTime(null);
		}
		
		else if("AUCTION".equals(tradeType)) {
			product.setPrice(product.getAuctionStartPrice());
		}
		
		else {
			throw new IllegalArgumentException("잘못된 거래 방식입니다.");
		}
		
		product.setStatus("ONGOING");
		product.setViewCount(0L);
		
		int result = mapper.insertProduct(product);
		
		return result;
	} 
	
	@Override
	public List<ProductDTO> getProductList(){
		return mapper.selectProuctList();
	}
	
	@Override
	public List<ProductDTO> getProductByPrice(Long minPrice, Long maxPrice){
		return mapper.selectProductByPrice(minPrice, maxPrice);
	}
}
