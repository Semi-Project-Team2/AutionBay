package com.kh.auctionBay.product.service;

import java.io.IOException;
import java.util.List;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import com.kh.auctionBay.common.dto.PageInfo;
import com.kh.auctionBay.common.util.FileUploadUtil;
import com.kh.auctionBay.common.util.SavedFile;
import com.kh.auctionBay.product.model.dto.CategoryDTO;
import com.kh.auctionBay.product.model.dto.ProductDTO;
import com.kh.auctionBay.product.model.dto.ProductListResult;
import com.kh.auctionBay.product.model.dto.ProductMediaDTO;
import com.kh.auctionBay.product.model.dto.ProductSearchCondition;
import com.kh.auctionBay.product.model.mapper.ProductMapper;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class ProductServiceImpl implements ProductService{

	private final ProductMapper mapper;
	
	private final FileUploadUtil fileUploadUtil;

	@Value("${file.upload-dir.product}")
	private String productUploadDir;
	
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
	@Transactional
	public int createProduct(ProductDTO product, List<MultipartFile> images)
	        throws IOException {

	    String tradeType = product.getTradeType();


	    // =========================
	    // 거래 방식 처리
	    // =========================

	    if ("BUY".equals(tradeType)) {

	        product.setAuctionStartPrice(null);
	        product.setAuctionEndTime(null);

	    }

	    else if ("SELL".equals(tradeType)) {

	        product.setAuctionStartPrice(null);
	        product.setAuctionEndTime(null);

	    }

	    else if ("AUCTION".equals(tradeType)) {

	        product.setPrice(product.getAuctionStartPrice());

	    }

	    else {

	        throw new IllegalArgumentException(
	            "잘못된 거래 방식입니다."
	        );
	    }


	    // =========================
	    // 기본값
	    // =========================

	    product.setStatus("ONGOING");
	    product.setViewCount(0L);


	    // =========================
	    // 상품 등록
	    // =========================

	    int result = mapper.insertProduct(product);


	    if (result == 0) {
	        throw new IllegalStateException(
	            "상품 등록에 실패했습니다."
	        );
	    }


	    // =========================
	    // 생성된 상품 번호
	    // =========================

	    Long productId = product.getProductId();


	    if (productId == null) {

	        throw new IllegalStateException(
	            "상품 번호를 가져오지 못했습니다."
	        );
	    }


	    // =========================
	    // 이미지 / 동영상 저장
	    // =========================

	    if (images == null || images.isEmpty()) {
	        return result;
	    }


	    int order = 1;


	    for (MultipartFile file : images) {

	        if (file == null || file.isEmpty()) {
	            continue;
	        }


	        // 최대 5개
	        if (order > 5) {
	            break;
	        }


	        // =========================
	        // 이미지 / 동영상 구분
	        // =========================

	        String contentType = file.getContentType();

	        String mediaType;


	        if (contentType != null
	                && contentType.startsWith("image/")) {

	            mediaType = "IMAGE";

	        }

	        else if (contentType != null
	                && contentType.startsWith("video/")) {

	            mediaType = "VIDEO";

	        }

	        else {

	            throw new IllegalArgumentException(
	                "이미지 또는 동영상 파일만 등록할 수 있습니다."
	            );
	        }


	        // =========================
	        // 실제 파일 저장
	        // =========================

	        SavedFile saved =
	            fileUploadUtil.save(
	                file,
	                productUploadDir,
	                "/uploads/product"
	            );


	        if (saved == null) {
	            continue;
	        }


	        // =========================
	        // PRODUCT_MEDIA DTO 생성
	        // =========================

	        ProductMediaDTO media =
	            new ProductMediaDTO();

	        media.setProductId(productId);

	        media.setMediaType(mediaType);

	        media.setMediaUrl(saved.getPath());

	        // 동영상은 썸네일 없음
	        media.setThumbnailUrl(null);

	        media.setMediaOrder((long) order);


	        // =========================
	        // PRODUCT_MEDIA 저장
	        // =========================

	        mapper.insertProductMedia(media);


	        order++;
	    }


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
